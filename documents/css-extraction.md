# Static CSS Extraction in styled-ppx

## Status

- Implementation reference for the static-extraction pipeline (`[%css]`,
  `[%styled.<tag>]`, `[%styled.global]`, `[%keyframe]`)
- Companion to `documents/design.md` (high-level CSS pipeline), which also
  covers the cross-module selector resolution layer in its
  `[%styled.global]` section

## What "extraction" means here

Four extension points produce CSS at compile time rather than emitting
runtime calls that mint CSS strings on first use:

| Extension              | What it extracts                                                       |
| ---------------------- | ---------------------------------------------------------------------- |
| `[%css]`               | Class-scoped declaration lists, one atomized rule per declaration       |
| `[%styled.<tag>]`     | Same as `[%css]` (string and function payloads both extract), wrapped in a generated React component for the given HTML tag |
| `[%styled.global]`    | Top-level global rules and at-rules: `@font-face`, `@media`, `:root` custom properties, and any document-level selectors (no class scoping) |
| `[%keyframe]`         | `@keyframes` blocks, named by content hash                             |

For all four, the PPX renders the resulting CSS to a string at compile
time and parks it in a top-level floating attribute on the post-PPX `.ml`
file. A separate post-build tool (`styled-ppx.generate`, the aggregator)
walks every emitted `.ml` in a dune library, collects the attributes, and
writes a single deduplicated stylesheet.

There is no non-extracting sibling family anymore: every live extension
extracts. Dynamic values (`$(expr)` in declaration values) do not opt a
block out of extraction — they are lowered to CSS custom properties in
the extracted rule, and the runtime side only supplies the custom
property values (via `CSS.make` vars for `[%css]`/`[%styled.<tag>]`, or
a generated `:root` block for `[%styled.global]`).

## End-to-end pipeline

```
.re/.ml source
  │
  ▼
PPX expansion (per compilation unit)
  ─ parse [%css "..."] / [%styled.<tag> ...] / [%styled.global "..."] / [%keyframe "..."]
  ─ resolve same-module $(name) selector interpolations to the referenced
    binding's identity class (or a cross-module sentinel), BEFORE atomizing -
    an atom's hash must see the RESOLVED selector, never the literal
    $(name) text, which means the same thing in every file
  ─ atomize, hash, mint class names; mint each named binding's identity class
  ─ buffer rendered rules; record cross-module refs as sentinels
  │
  ▼
PPX impl transformer (end of CU)
  ─ production mode           → emit [@@@css.config [...]]     (environment marker)
  ─ drain Css_file.Buffer     → emit [@@@css "..."]            (one per rule)
  ─ drain Css_bindings        → emit [@@@css.bindings [...]]   (binding exports)
  ─ drain Cross_module_refs   → emit [@@@css.refs [...]]       (cross-module refs)
                              → emit `let _ = M.x` synthetic deps
  │
  ▼
post-PPX .ml file
  │
  ▼
dune builds the library normally (.cmi, .cmx, executables)
  │
  ▼
styled-ppx.generate (post-build aggregator)
  ─ walk every .ml / .pp.ml in the library
  ─ extract [@@@css ...], [@@@css.bindings ...], [@@@css.refs ...], [@@@css.config ...]
  ─ resolve NUL-delimited cross-module sentinels against the bindings index
  ─ deduplicate rules, emit final stylesheet (minified when the configs say production)
  │
  ▼
styles.css
```

## Wire protocol: four attributes

Everything the aggregator needs to know is conveyed by four top-level
floating attributes that the PPX appends to the post-PPX file. They are
the entire interface between PPX expansion and the aggregator — the
aggregator never re-parses `CSS.make` calls or infers facts from filenames,
and it takes no mode flags: the build environment travels in-band.

### `[@@@css "..."]` — extracted CSS rule

A single CSS rule string. One attribute per atomized rule, per global
rule, or per `@keyframes` block.

```ocaml
[@@@css "._a_tokvmb{color:red;}"]
[@@@css "._a_1ru12dh:hover{opacity:0.8;}"]
[@@@css "@media (min-width:768px){._a_fmb91l{padding:2rem;}}"]
[@@@css "@keyframes _k_jw9oix{from{opacity:0;}to{opacity:1;}}"]
```

The string may contain NUL-delimited cross-module sentinels
(`\x00LONGIDENT\x00`) when the PPX could not resolve a `$(M.binding)`
selector reference at PPX time. The aggregator substitutes those at
resolve time (see "Resolve" below; the sentinel constants live in
`packages/css-extraction/css_extraction.ml`).

### `[@@@css.bindings [(longident, identity, class_string); ...]]` — binding exports

One attribute per CU, listing every named `[%css]` binding and
`[%styled.<tag>]` component the CU minted.
The longident is the fully-qualified path users would write to reference
the binding from another module; the identity is the binding's
build-independent `_id_...` class (see "Identity classes" below) — a
`$(binding)` selector reference resolves to this, verbatim; the class
string is the space-separated list of atomized class names the PPX
produced, kept only as a content fingerprint so the aggregator can tell
a legitimate duplicate build from a real identity collision (see
Resolve below).

```ocaml
[@@@css.bindings
  [("M.marker", "_id_1a2b3c4", "");
   ("M.Css.active", "_id_5d6e7f8", "_a_tokvmb");
   ("M.layout", "_id_9a0b1c2", "_a_k008qs _a_1tyndxa")]]
```

The aggregator folds every payload into two flat hash tables — its
global resolution index: `longident -> identity` for resolving `$(M.x)`
references, and `identity -> (longident, class_string, filename)` for
collision detection. No AST walking, no `CSS.make` pattern matching, no
filename-to-module inference.

Anonymous bindings (`let _ = [%css ...]`) are not exported because they
cannot be referenced from another module.

### `[@@@css.refs [(longident, file, line, scol, ecol); ...]]` — cross-module references

Emitted only when a CU contains cross-module `$(M.binding)` selector
interpolations. Carries every distinct `(longident, source_location)`
pair the PPX could not resolve locally. The aggregator uses these
locations to format errors with the original `.re`/`.ml` source position
when a cross-module reference fails to resolve.

```ocaml
[@@@css.refs [("M.marker", "n.re", 4, 6, 14)]]
let _ = M.marker
```

The accompanying synthetic `let _ = M.marker` lines exist so that:

- `ocamldep` sees N depends on M (preserving build order)
- the OCaml type checker produces a clear "Unbound module" /
  "Unbound value" diagnostic with the original source location
  before the aggregator even runs

### `[@@@css.config [(key, value); ...]]` — extraction settings

Emitted when the CU contributes extraction items (rules or bindings) and
at least one config key applies. Carries PPX-side settings the aggregator
must honor, as string key/value pairs. Two keys today:

- `env`: set to `"production"` when the PPX runs with production settings
  (`--minify` or `--env production`), and the aggregator minifies its
  output accordingly.
- `library-name`: the value of the `library-name` cookie dune passes to every
  ppx run inside a `(library ...)` stanza, read via
  `Ppxlib.Driver.Cookies.add_simple_handler`. Absent when the module isn't
  compiled as part of a library (for example an `(executable ...)`
  stanza) or the cookie wasn't set. The aggregator reads this key to group
  and order rules by owning library; see Order below.

```ocaml
[@@@css.config [("env", "production"); ("library-name", "my_lib")]]
```

When both apply, `env` comes first, then `library-name`. Absence of every key
means the attribute is omitted entirely — dev output with no library
cookie stays exactly as before this key was added. Unknown keys are
ignored by the aggregator (forward compatibility).

The aggregator minifies its output (drops inter-rule newlines) only when
**every** contributing input file — every file with extracted rules or an
explicit config — declares `env=production`. Mixed inputs mean some
library stanzas ran the PPX with production settings and some did not;
the aggregator warns (visible by default) and falls back to readable
output. This is why `styled-ppx.generate` has no `--minify`/`--env` flag:
the environment is declared once, on the `(pps styled-ppx ...)` stanza,
and everything downstream follows.

## PPX-side state

Three module-level mutable buffers, all per-CU, all drained by the impl
transformer at end-of-CU:

| Buffer                              | Source                         | Sink                              |
| ----------------------------------- | ------------------------------ | --------------------------------- |
| `Css_file.Buffer`                   | atomized rules during expansion | `[@@@css "..."]` attributes       |
| `Css_bindings`                      | each named `[%css]` / `[%styled.<tag>]` expansion | `[@@@css.bindings ...]` attribute |
| `Cross_module_refs`                 | each unresolved `$(M.x)` in selector position | `[@@@css.refs ...]` attribute + synthetic `let _ = M.x` |

`Local_selector_environment` is a fourth piece of state, distinct from the
three above: it serves same-file selector interpolation before cross-module
fallback. It is keyed by `(file, lexical_path)` and never escapes the CU.
It tracks named `[%css]` bindings and `[%styled.<tag>]` components, same-file
module aliases, same-file opens/includes, and earlier string literals.
Cross-module references only go through `Cross_module_refs` after this local
resolver fails.

`Css_file.re` resolves every `$(name)`/`&.$(name)` selector reference in a
`[%css]`/`[%styled.<tag>]` block (via `resolve_rule_selectors`) before
atomizing it, precisely so two files that both use a local binding named
`row` in the same selector shape - but whose `row`s are different bindings
with different identity classes - mint different atom classes instead of
colliding: the atom's hash sees `row`'s resolved identity class (or, for a
cross-module `$(M.row)`, the sentinel `Cross_module_refs` would otherwise
have inserted later), never the bare, textually-ambiguous `$(row)` marker.
This only touches selector position; declaration VALUES are still resolved
later, in `lower_atom`, since a value interpolation's variable name depends
on the atom's own class/namespace - resolved only after atomizing.

### `Css_file.Buffer`

A list ref of `(className, cssText)` pairs. Atomization produces one
entry per declaration (each declaration becomes its own class). Cleared
at end-of-CU when `Css_file.get()` returns the rules to the impl
transformer.

`[%styled.global]` writes through `Buffer.add_global_rule`; the global
rules are kept separate so they always sort before per-class rules in
the final stylesheet (see `Buffer.get_rules`).

#### `@font-face`

`@font-face` is a global at-rule and belongs in `[%styled.global]`
(a `fontFace` helper only survives in the legacy emotion bindings,
not in the current runtimes). The canonical form is:

```reason
module Fonts = [%styled.global {|
  @font-face {
    font-family: "Inter";
    src: url("/fonts/inter.woff2") format("woff2");
    font-display: swap;
  }
|}];
```

Each `@font-face` block ships through `[@@@css ...]` like any other
global rule, so the font registers when the extracted `.css`
loads — no runtime side-effects required.

The `@font-face`-only descriptors (`src`, `unicode-range`, `font-display`,
`ascent-override`, `descent-override`, `line-gap-override`, `size-adjust`)
are rejected by `Css_validation` in every other declaration context: a
style rule, a `[%css]` block, or a different at-rule body. Inside an
`@font-face` body only descriptors are accepted (those above plus the
`font-*` properties css-fonts also defines as descriptors), so an ordinary
property such as `color` there is rejected as well.

Declaration-value interpolation in `[%styled.global]` is lowered to CSS
custom properties (`var(--<prefix>-<hash>)` in the extracted rule, values
supplied by the generated module's runtime `:root` block — see
`documents/design.md`). Two positions reject interpolation outright:

- inside `url(...)` (browsers don't substitute `var()` there), so font
  URLs must be literal CSS
- in at-rule preludes, e.g. `@media (max-width: $(bp))`

### `Css_bindings`

Per-CU buffer of `(longident, identity, class_string)` exports. The
ordered structure pass computes the longident from the compilation unit
name + current submodule path + the enclosing top-level value name
(`[%css]`) or module name (`[%styled.<tag>]`); the identity comes from
`Css_file.push` (see "Identity classes" below), computed from the
*local* binding label, which for a function-local rebinding differs from
the longident's top-level name. `Css_bindings.record` is then called
with all three. Last-write-wins on duplicates within a CU (matches
`Local_selector_environment` shadowing semantics).

### `Cross_module_refs`

Per-CU buffer populated by
`Local_selector_environment.resolve_selector_class_ref` when the requested
dotted `$(name)` cannot be resolved against a same-file `[%css]` binding,
same-file module alias, same-file open/include, or earlier string literal.
Records `(longident, location)` and produces a NUL-delimited sentinel string
that gets baked into the rule the PPX is currently rendering. The sentinel
survives CSS rendering verbatim and is resolved later by the aggregator.

## Aggregator responsibilities

Implemented in `packages/generate/generate.ml`. Takes a list of `.ml` /
`.pp.ml` paths, produces a stylesheet on stdout or `-o <file>`.

```
parse args → extract_each_file → order_inputs → resolve_sentinels → dedup → write
```

### Extract

For each input file, walk its top-level structure once and dispatch on
the five attribute shapes:

```ocaml
[@@@css "..."]            → push rule string
[@@@css.bindings [...]]   → fold (longident, identity, class_string) into Index
[@@@css.refs [...]]       → push (longident, location) into per-file refs
[@@@css.config [...]]     → record the file's declared environment
_                         → ignore
```

The extraction pass is the **only** time the aggregator looks at the AST.
Everything downstream operates on plain strings, except that the extraction
pass also records, per file, which other module names its structure
references (see Order below) — the last thing the AST is used for.

### Order

Implemented in `packages/generate/order.ml` (the pure `sort`/`references`
primitives) and `packages/generate/generate.ml` (`order_by_dependency`,
which applies them). Runs between extract and resolve, reordering the
inputs before dedup picks which occurrence of a repeated rule
survives.

By default (`--order dependency`) the order is two levels: libraries
first, then, inside each library, files.

**Library level.** Every input file belongs to a group: its declared
`library` key from `[@@@css.config]` (see above), or, when that key is
absent, the directory of its input path. A library's rules come after the
rules of every library it depends on. A raw module reference `X` from a
file in library `L1` becomes a library edge `L1 -> L2` when:

- `L1` itself has no module named `X` (otherwise it's a same-library
  reference, resolved at the module level below, and contributes no
  library edge), and
- exactly one other library has a module named `X` (the `(wrapped false)`
  case — dune exposes every module of an unwrapped library at top level);
  or, failing that, exactly one other library's name capitalizes
  (`String.capitalize_ascii`) to `X` (the default `(wrapped true)` case —
  a wrapped library is referenced through its alias module, e.g. `Zlib.Inner.x`
  for a library named `zlib`).

Anything else (zero or multiple candidates either way) means no edge.

**Module level.** Inside a library, a file's rules come after the rules of
every file in the *same* library it depends on — module resolution now
never crosses a library boundary. Candidates for a referenced name are the
files in that one library whose module name matches; the one sharing the
longest directory-path prefix with the referencing file wins a tie. No
same-library candidate at all means no module edge (the library edge above
already ordered the two libraries relative to each other).

Both levels call the same `Order.sort` (Kahn's algorithm, always advancing
the alphabetically smallest ready key), so both get the same guarantees:
files or libraries with no dependency relation keep their input order, and
a cycle — which can't come from a real dune graph, only from this
heuristic picking an edge a real build wouldn't have — never fails the
build. The aggregator warns once naming the cycle's members, drops the
blocking edge whose source sorts alphabetically last, and keeps going.

`--order source` skips all of this, ignoring references and `library`
keys, and keeps the file order dune passes on the command line. It exists
as an escape hatch for one release and to compare
against the old behavior. Under the default `--order dependency`, `--log
info` prints the library order and then each library's module order;
`--log debug` additionally prints every library edge and every module
edge.

### Resolve

For each rule string, scan for `\x00LONGIDENT\x00` sentinel pairs:

- on hit: replace with the longident's identity class from the index,
  verbatim — one class, regardless of how many atoms the referenced
  binding minted
- on miss: report an error using the location stored in the file's
  `[@@@css.refs ...]`, distinguishing **cross-library** (root module
  not found in any binding's longident) from **missing binding**

Errors are accumulated; if any fire, the aggregator prints them all to
stderr in `File "...", line N, characters X-Y:` format (the OCaml
compiler convention, so editors pick them up) and exits 1.

**Identity collision.** While building the index (during Extract, not
Resolve), two different bindings can hash to the same identity — e.g.
two libraries whose modules share a basename and binding name, with no
distinguishing `--namespace`. This is only an error when their
`class_string` fingerprints differ: the same identity with the same
atoms is the ordinary "same module compiled twice" case (native +
melange, `copy_files`, vendoring) and is accepted. A real collision
names both input files, both longidents, the shared identity, and the
`--namespace` remedy, and is reported through the same protocol-error
path as a
malformed attribute (see `packages/generate/test/identity-collision.t`).

### Dedup and write

Resolved rule strings are deduplicated with an order-preserving
`Hashtbl` filter: walk the rules in the order established by Order above
(library, then module, then source — or the plain file order under
`--order source`) and keep the first occurrence of each string. This
removes duplicates produced by the same rule appearing in multiple files
(common for shared helpers, and for a native/melange pair of the same
library compiled twice).

Order preservation is load-bearing: every atomized rule has the same
specificity (one class, no qualifiers), so the cascade tiebreaker is
"later in stylesheet wins". A longhand override written after a
shorthand (`margin: 10px; margin-top: 20px`) must stay after it in the
emitted stylesheet, and a module's rule now stays after a dependency's
equal-specificity rule regardless of file naming. An earlier version
deduped through `Set.Make(String)`, which sorted by hash-prefixed rule
text and silently destroyed declaration order (regression test:
`packages/generate/test/source-order.t`).

**Atom class collision.** Right after that dedup pass, the aggregator
scans the deduplicated rules for two different, non-bundle atoms
(`_a_` classes) that mint the same class name but render
different CSS - the same shape as an identity collision above, applied
to atom classes instead of `_id_` identities, and reported the same way
(both rule bodies, the shared class, a `--namespace` remedy). `_in_`
(interpolation-bundle) classes are exempt in both directions: several
different bundle bodies sharing one class is that mechanism working as
designed (see "Atomization" above), never a collision (see
`packages/generate/test/atom-class-collision.t`).

Before writing, `@import` rules are hoisted to the front of the
deduplicated list, then `@namespace` rules right after them, each block
keeping its own relative order, regardless of which library or module
emitted them: a browser only honors these rules when they precede every
other rule, Order above routinely places the module that emits one after
modules with plain style rules, and CSS Cascade 5 additionally requires
every `@import` to precede every `@namespace`. Classification is a string
test on the rendered rule — starts with `@import`/`@namespace` and ends
with `;` — rather than a search for `{`, since an `@import` URL can itself
contain `{` (`@import url("a{b.css");` is a valid statement, not a block
rule). Statement-form `@layer a, b;` is deliberately NOT hoisted with
`@import`/`@namespace`: CSS allows it anywhere in a stylesheet, but a
layer's priority is fixed by its name's FIRST occurrence across the whole
page, so relocating a user's own `@layer` statement could silently change
which layer it introduces first there - a hazard independent of whether
this aggregator wraps anything in a layer of its own. It carries no atom
class of its own, so cascade tiers (below) treat it exactly like a
registration: it takes no part in tiering, staying in whatever relative
position dedup/ordering already gave it among the other rules that also
sit outside the tiers — a normal and supported way to declare layers from
user-written CSS.
`@charset` is dropped instead of hoisted: the generated file always opens
with its own leading comment, so `@charset` can never be the literal
first bytes of the stylesheet, and the file is written as UTF-8 regardless
of what a module declares; dropping it is reported as a warning naming
the input file (`packages/generate/test/statement-at-rules.t`).

The deduplicated (and hoisted) list is then written to the output
channel. Inter-rule newlines are dropped when every contributing input
file declared `env=production` in its `[@@@css.config ...]` (see the wire
protocol section above); there is no CLI flag for this.

### Cascade tiers (always on)

Every deduplicated STYLE rule this generator emits - a real atom (`_a_`/
`_in_` class) or a `[%styled.global]` rule (no atom class, but a real,
cascading rule all the same - `html{...}`, `*{...}`, `*::before{...}`, an
author's own global selector) - is emitted into one of THREE fixed-order
groups: `global` (`[%styled.global]` rules), `base` (an atom's own,
unconditional context), `conditional` (an atom wrapped in an at-rule, or
carrying a pseudo-class/pseudo-element directly on its own selector - see
"Classification" below), each group further ordered by "Sort, inside
each tier" below. No CSS layer wraps any of the three: ordinary CSS
cascade rules apply, SPECIFICITY first, emission position only as the
tie-break - exactly like plain, unlayered CSS. Within `atoms`-shaped
rules, tier order (base before conditional) fixes a real bug
content-hash dedup and plain concatenation could not: a block's own
`@media`/`:hover` override landing BEFORE its unconditional declaration
in the deduplicated list (so the unconditional one, being later, always
won, even while the condition held). Ordering by tier fixes this
whenever the two competing rules are equally specific (the common case:
two single-class atoms); a genuine specificity difference between a
`base` and a `conditional` rule is decided by the browser's own cascade
regardless of tier order - see "Classification" for the accepted
consequence for a `[%styled.global]` rule.

A descendant-shaped rule (`.wrapper * {color}`, `.list li {...}` -
see "Sort, inside each tier" below for exactly what this means) stays
in the tier of its own context, exactly like any other rule: it is not
its own tier, and specificity decides between it and a child's own atom
the same way it would with no tiers at all.

**Accepted limit: two separate stylesheets have no guaranteed relative
order between their own tiered rules, when they share a class.**
`--namespace` (see "Atomization" above) salts each library's atom
classes, so two different libraries never mint the same one; sharing a
class only happens for a native/Melange twin pair passing the same
explicit `--namespace`, or for two runs with no namespace at all. When it
does happen: two different `styled-ppx.generate` invocations (two
`<link>`s on one page) simply concatenate on the page in load order,
exactly like any two plain CSS files always have - so which sheet's rule
ends up textually later, and therefore wins an equal-specificity tie
against the OTHER sheet's rule, depends on load order, a page-authoring
detail this aggregator has no visibility into. Each sheet's OWN tier
order still holds internally (its own conditional rules still come after
its own base rules, and its own atoms still come after its own globals);
only the relative position of two DIFFERENT sheets' rules is unguaranteed
- see `tiers-two-stylesheets.t`.

**Classification**: a rule with NO atom class at all (see `atom_class_name`
in `packages/generate/generate.ml`) is either a registration (takes no
part in tiering, see below) or a `[%styled.global]` rule, which is always
`global` - global rules never compete for the SAME base/conditional
distinction an atom's own selector does, they are simply always emitted
before either tier. A rule WITH an atom class is classified per rendered
rule (not per class, so two declarations of the same `_in_` bundle can
land in different tiers) into exactly one of:

- `Conditional`: the rule is wrapped in an at-rule (`@media`/`@supports`/
  `@container` are the only ones that ever wrap an atom class -
  `@property`/`@keyframes`/`@font-face` registrations and a literal
  `@layer` at-rule carry no atom class at all and never reach this
  classification, see "outside the tiers" below), or a pseudo-class/
  pseudo-element is attached DIRECTLY to the atom's own compound selector
  (`.x:hover`, `.x::before`, chained `.x:focus-visible:not(:disabled)`).
- `Base`: everything else, including a descendant/child selector (see
  `is_descendant_shape` below) and any selector with no combinator at
  all. Whether the rule is descendant-shaped or not plays no part in
  this classification - it only affects sort order WITHIN whichever of
  these two tiers the rule already landed in, see "Sort, inside each
  tier" below.

None of `global`, `base` or `conditional` is wrapped in a CSS layer, so
tier order between them is only ever a TIE-BREAK between equally specific
rules - it never overrides a real specificity difference: an ancestor's
own `base` rule with higher specificity than an unrelated `conditional`
atom still wins, exactly as it would with no tiers at all, and a
`[%styled.global]` rule with higher (or equal) specificity than an atom
it targets (`.theme-dark .card{color:green}` vs an atom
`._a_card{color:blue}`) wins too - an accepted consequence: an author
whose atom must still win either raises its own specificity or uses
`!important`, the same escape hatch plain CSS always offers.

`!important` needs no special handling anywhere in this ordering, `global`
included: importance is compared once, before specificity or position,
then two `!important` declarations on the same property compete exactly
like two plain ones do - specificity first, tier order (then the
shorthand-depth sort) as the tie-break - see `tiers-important.t` for the
responsive-override case (a component's `!important` base padding,
narrowed by an `!important` media-query override of the same
properties), and `global-tier.t` for the global-vs-atom cases: a more
specific atom beats an `!important` global the same way it beats a plain
one.

**Sort, inside each tier**: a TOTAL per-rule key, `(descendant-shaped,
shorthand depth)`, not a pairwise comparison between two rules. A
descendant-shaped rule - the rule's selector reaches, via a combinator,
for a DIFFERENT element than the atom's own class (every atom's class is
always that selector's leading token), and that different element's
subject compound (the rightmost compound - the actual element the rule
styles, in CSS Selectors terms) has no class of its own: a bare element
type or `*` (`.x > div`, `.x span`, `.x > *`). A subject that DOES carry
its own class (`.x ._id_...` - what a `$(binding)` selector reference
resolves to - or a literal author class like `.x .tiptap`) is NOT this
shape: seeing a class there means the rule targets a specific,
identified element, not "whatever happens to be under here" - is always
emitted BEFORE an own-element rule in the same tier, so a genuine
specificity TIE between an ancestor's blind reach and the child's own
atom resolves to the child, the later rule in the tier, winning: the
fix for the one case removing the `descendant` tier needed a
replacement for (`.wrapper * {color}` vs the child's own `color` atom,
both `(0,1,0)`). A real specificity difference is untouched either way
- the browser's own cascade already prefers the more specific rule
regardless of stylesheet position, tiers or no tiers; this ordering
only ever matters when specificity is equal, which is also why
descendant-shape is the PRIMARY sort key and not the depth compare
below: the two guarantees are almost never both live for the same pair
(a descendant rule and the child's own atom rarely share a property
too), and on the rare pair where they would disagree, protecting the
child from an unrelated ancestor's blind reach takes priority over
depth's narrower concern (restoring one binding's own
shorthand-then-longhand override intent).

Within rules that are equally descendant-shaped (both, or neither), a
rule's own shorthand DEPTH decides: the number of shorthand levels
above its property in the css-grammar shorthand graph (`Slot_key.
depth_of` - 0 for a top-level shorthand like `margin`, or a plain leaf
like `color`; 1 for a direct longhand, `margin-top`; 2 for a longhand
of a longhand). A shallower rule (a shorthand, or a wider family atom)
sorts before a deeper one covering less (a lone longhand from a
different binding or a different `_in_` bundle). A property reachable
through more than one shorthand takes the LONGEST such path, not the
shortest: `border-top-width` is a direct longhand of both `border-top`
(its own, parent-less shorthand, depth 0) and `border-width` (itself a
longhand of `border`, depth 1); the longest path puts it at depth 2,
strictly above BOTH parents, which is what keeps `border-width` sorting
before `border-top-width` - the shortest path would tie them both at
depth 1 and leave their relative order to whatever the pre-sort order
happened to be. An alias (`grid-column-gap` for `column-gap`) resolves
to its canonical name's depth first - it names the exact same computed
property, so it must sort exactly like its canonical name would. A
logical property (`margin-inline-start`) needs no such redirect: it is
registered as its own, separate shorthand entry with only its own
logical longhands, never a physical one, so the graph already keeps it
apart from its physical counterpart. Depth is a TOTAL order - a plain
integer comparison, always transitive - which is exactly what
`List.stable_sort` needs for its own correctness guarantee to hold: a
comparator that instead matched rules pairwise by shared property
family, treating any two rules that share no family as equal, is NOT a
transitive relation (two rules each "equal" to a common third rule need
not be equal to each other), so a stable sort built on one could leave
a genuine shorthand stranded after its own longhand whenever enough
family-unrelated rules separated them in the pre-sort list -
`shorthand-depth-stress.t`'s 30-rule fixture pins this: every one of
nine shorthand/longhand pairs, shuffled among sixteen unrelated
declarations, sorts correctly.

**Conditional group only**: once descendant-shape and depth tie two
`conditional` rules (the common case - two atoms wrapped in an at-rule, or
carrying a pseudo-class/pseudo-element directly, of equal specificity),
three more key components decide, in this order: **at-rule rank** (0 for
no wrapper, 1 for `@supports`, 2 for `@media`, 3 for `@container` - StyleX's
own relative order); **pseudo rank** (StyleX's `PSEUDO_CLASS_PRIORITIES`/
`PSEUDO_ELEMENT_PRIORITY`, ported verbatim - `:hover` 130, `:focus` 150,
`:focus-visible` 160, `:active` 170, every pseudo-element 5000, read only
from the pseudo chain directly suffixed to the atom's own class, the same
position the classification above checks - and stopping at the first
top-level combinator or `,`, so a rule that reaches further
(`.x:hover .id-y{...}`, `.x:hover > span{...}`) still reads only its own
`:hover`, not a mangled string spanning into the unrelated selector text
past it); and **media width bound** (only
read when the at-rule rank is `@media` - the single `min-width`/
`max-width` px value in the prelude, ascending for `min-width`, descending
for `max-width`, `None` when the prelude combines features and sorts
first). Fixed and global: the same pseudo, at-rule or width always sorts
the same way, in every block, in every file - not a per-block "last
declaration wins" rule. `global` and `base` never use this extended key
(see "Classification" above and `packages/generate/generate.ml`'s
`sort_conditional_rules`).

This is a total order, not an injective one: two different `@supports`
conditions, or two different pseudo-elements (`::before` vs `::after`),
still tie on every component above and fall through to stable/file order -
an accepted, documented gap, same as StyleX (see "Known limits" in
`how-merging-works.md`). The fixed order also applies to two conditions
written in the SAME block: a block that writes `:focus{color:blue}` then
`:hover{color:red}` gets `blue` (focus, the higher-ranked pseudo) when both
apply, reversing what "last declaration wins" would otherwise give for
that one block - decided on purpose, for cross-block consistency, not
inherited as a side effect (see `how-merging-works.md`).

The media width bound is read with a plain substring scan over the
prelude text, not the MQ4 grammar (`css-grammar/lib/Shared.ml:1104-1182`,
not wired into this package): it drops a leading `screen`/`all` media type
(`only` optional) and its own `and` first - `@media screen and
(max-width: 767px)` is the dominant real shape, and that `and` is not the
same thing as a compound feature query's `and` - then reads a single
`min-width`/`max-width: <n>px` feature (whitespace after the `:` optional,
since generated code always has one - `@media (min-width: 600px)` - while
a hand-written `[@@@css ...]` fixture may not) and returns `None` for
anything else: a compound prelude (`and`/`or`/`not`), a feature this scan
does not recognize, a unit other than `px` (an `em`/`vw` bound needs a
font-size/viewport to compare against a `px` one, out of scope here), a
`print` or other/unrecognized media type (left as `None` on purpose - not
stripped like `screen`/`all`), or a leading `not` (`not screen` negates
the type entirely, a different condition from `screen`, so it is never
stripped either). `None` sorts first - a fixed, total choice, not a claim
that an unreadable prelude deserves to lose on any semantic ground - so an
unreadable prelude never outranks one this scan can read.

A bundle, or a same-file family-atom group (see "Atomization" - several
declarations already merged into one atom because their leaves overlap,
needing no separate sort entry: they are one rule, in author order,
before the sort ever runs), has no single depth of its own the way a
plain, single-property atom does; it is keyed by the MINIMUM depth over
every declaration it carries. This protects the group's SHALLOWEST
declaration correctly (a `padding: 4px;` inside the group still sorts
before an unrelated `padding-top: 0;` atom that needs to override it,
the same guarantee a lone `padding` atom would get), but not every
declaration in the group at once: a bundle of `margin-top: 0;` (depth
1) and `padding: 4px;` (depth 0), keyed by the group's minimum (0), no
longer sorts its `margin-top: 0;` at its own true depth 1 - an
unrelated `margin: 10px;` atom (depth 0, genuinely wider than
`margin-top`) is not guaranteed to sort before this group's
`margin-top: 0;` the way it would if `margin-top` sorted honestly on
its own. Accepted, not fixed: a multi-declaration rule that mixes
properties at different depths cannot be ordered correctly against
every other rule at once, only against rules competing for its
shallowest declaration's own property.

This is what `CSS.merge` (below) cannot do for two atoms hidden inside
different `_in_` bundles (`CSS.merge` only ever sees a bundle's class
as one opaque, never-dropped token): the sort fixes their relative
STYLESHEET position instead, restoring the override a `merge` call
intended even though `merge` itself still cannot see one property next
to another inside a bundle. Reads each rule's own property name(s)
straight from its rendered text (through `Slot_key.depth_of`'s
css-grammar-sourced shorthand graph, the same table a real atom's own
mask is built from) rather than from a `Slot_key.t` - a bundle's
declarations never had one to begin with (a real bundle spans more than
one property, sometimes more than one context, see "Atomization"
above).

A real, narrower gap remains: `.x *{color:red}` where `.x` itself is
styled by nothing that competes (no rule targets `.x` on the same
property at all) still depends on stylesheet position relative to some
OTHER, unrelated rule that also happens to match the descendant element
- cross-element ordering beyond "does this rule's own subject carry the
atom's own class" is a different, harder problem this sort does not
fully solve.

**Takes no part in tiering, always**: `@property`, `@keyframes`,
`@font-face` registrations, hoisted `@import`/`@namespace`, dropped
`@charset`, and a literal, user-authored `@layer` at-rule (statement or
block form) - none of these compete for an element in the cascade the
way a `[%styled.global]` rule or an atom does. They are emitted exactly
where they were before tiers existed: ahead of every tiered rule, in
whatever relative order dedup/ordering already gave them. A
`[%styled.global]` rule is NOT in this list - it has no atom class
either, but it IS a real, cascading rule, so it is `global` (above).

`--layers` is not a recognized flag: passing it is rejected the same way
any other unrecognized flag is. Two different libraries' rules compete
the same way `base`/`conditional`/`global` do - ordinary specificity
first, emission position (dependency order) as the tie-break.

## Atomization

Every declaration produced by `[%css]` becomes its own atom:
`{ display: flex; color: red; }` produces two rules, two class names,
two `[@@@css ...]` attributes. The runtime `CSS.make` call carries the
space-separated concatenation of those class names, so consumers apply
all atoms by setting one `className` attribute.

**Two declarations in one block group into one atom when their covered
leaf properties overlap**, taken transitively, not one atom per
declaration: `{ margin: 0; margin-top: 5px; margin: 10px; }` is ONE atom
carrying all three declarations in author order, because `margin`'s full
leaf set includes `margin-top` (see `Slot_key.leaves_of`). This is what
makes the final `margin: 10px` reset `margin-top` reliably: source order
inside one rule decides the winner, not the relative position of two
independently-hashed atoms in the generated stylesheet (a repeat of the
same property overlaps itself trivially - `color: blue; color: red;` is
also one atom, the older, narrower rule this generalizes). Sharing a
property *family* is necessary but not sufficient: `padding-left` and
`padding-right` are both in the "padding" family but cover disjoint
leaves, so they stay TWO atoms - merging them would make a future
`CSS.merge` too coarse, unable to drop just the overlapping side without
also dropping the other. "Transitively" means a bridging declaration
pulls in everything it overlaps even when those things don't overlap
each other directly: `border: 1px solid; border-left-width: 2px;` group
together (border's full leaf set includes border-left-width), and adding
a third declaration `border-top: 1px solid;` (which shares no leaf with
`border-left-width` directly) still joins the same group, bridged through
`border`. A declaration that shares no leaf with anything else in the
block is its own one-member group, which is exactly "one atom per
property" for everything this doesn't otherwise merge. Grouping in
`Css_file.re`'s `group_declarations_by_family` reuses
`Slot_key.leaves_of` directly (not a reimplementation).

Class names follow the `_a_<context?><family><mask?><value>` format: a
fixed-width, base36-encoded context hash (present only under a real
selector/at-rule, or when the declaration carries `!important` - see
"CSS.merge" below), a 2-character property-family id from a fixed,
append-only table, an optional mask of which of the family's longhands
this atom covers, and a short value hash unique only within that
(context, family[, mask]) bucket - not globally, which is what lets it
be short. The value hash is computed over the rendered declaration
salted with `--namespace` (see "Identity classes" below - the same flag,
defaulting the same way, now salts atom and bundle classes too, not just
identities): two libraries with different namespaces never share an
atom class for the same declaration, even byte-identical, so one
library's stylesheet position can never decide a tie against another
library's own override of it. `styled-ppx.generate` checks the
per-bucket uniqueness this leaves (see the atom class collision check
under "Dedup and write" above). The binding's `let` name never appears
in the class name either way; two bindings whose declarations render to
the same CSS text in the same context AND namespace mint the same
class, dev or production. Minting lives in `packages/ppx/src/Hash_class.ml`
(`Class_format.slot_class`); the `(context, family, mask)` triple comes
from `packages/ppx/slot_key` and is never itself salted - only the value
field's hash input is.
An alias (`grid-row-gap` for `row-gap`, one of two legs of `gap`) resolves
to its canonical name before its mask is computed too, the same redirect
`Slot_key.depth_of` already does for sort order (see "Cascade tiers"
above): it
names the exact same computed property, so it must get the exact same
mask its canonical name would - never a mask computed against the
alias's own, unresolved name, which `Slot_key.Family`'s union-find (built
only from registered shorthands, never from aliases) would otherwise see
as an unrelated one-member family and mask as "full" regardless of how
many longhands the real, canonical property actually covers.

One exception: when a block has TWO OR MORE declarations that interpolate
the SAME `$(name)` source path, they mint one shared `_in_<murmur2 hash>`
class instead - a plain, unbucketed hash of their concatenated content, no
context/family/mask fields at all (the "bundle" - see `Css_file.re`'s
`transform_rule_list`). Grouped by shared path with the same union-find
technique the shorthand/longhand leaf-overlap grouping above uses,
transitively: a declaration interpolating two paths bridges both into one
group. Two declarations that merely both interpolate, but different,
unrelated paths - `color: $(a); background-color: $(b);` - do NOT bundle:
each mints its own real, slot-keyed `_a_` class exactly like a static
atom, and merges normally (see `CSS.merge` below), since neither value
ever needed to share a variable with the other. A single interpolating
declaration, or one whose path no sibling declaration in the block
shares, is likewise not a bundle - bundling only kicks in when two or
more of a block's interpolating declarations, sharing a path, would
otherwise need separate custom-property namespaces for what is often the
same value reused across `base`/`:hover`/`@media` variants. A bundle's own
`var(--...)` target is unaffected by which prefix its class carries,
since only the CLASS half of `Hash_class.class_and_namespace` differs
between the two cases, never the namespace/variable-naming half - and
that CLASS half is salted with `--namespace` exactly like a real atom's
value field (`Hash_class.bundle_class_and_namespace`), so two libraries
never share a bundle class either. The
`_in_` prefix lets `CSS.merge` (see below) recognize a bundle atom and
never drop it or let it drop another atom, and lets
`styled-ppx.generate`'s atom-class collision check ("Dedup and write"
above) skip it -
several different bundle bodies legitimately sharing one class is the
mechanism working as designed, not a hash collision.

The environment is a PPX concern, set once per `(pps styled-ppx ...)`
stanza: `--env production` (alias for `--minify`) only minifies rule
bodies — it has no effect on class names; `--env development` (alias for
`--dev`) adds `label:<binding>` marker classes. Dev markers are on by
default, so a bare `(pps styled-ppx)` stanza already gets them;
`--minify` and `--env production` turn them off, and an explicit `--dev`
forces them back on regardless. The aggregator learns the environment
from `[@@@css.config ...]` and adjusts its whitespace accordingly.

Two consequences worth knowing:

1. **One `[%css]` binding maps to N class names.** This is what the
   space-separated `class_string` in `[@@@css.bindings ...]` captures.
2. **A `$(binding)` selector reference resolves to ONE class: the
   referenced binding's identity** (see below), not a chain of its
   atoms. This holds same-module and cross-module alike. A reference
   means "carries that binding", not "reproduces its exact
   declarations" — a referenced multi-atom binding drops from
   `(0,N,0)` to `(0,1,0)` specificity inside the compound selector (see
   the specificity note below).

### Media condition ordering

When one block sets the same property (or overlapping shorthand family)
under two or more `@media` rules on the same selector, plain CSS gives
the tie at equal specificity to stylesheet *position*, and
`styled-ppx.generate` dedupes byte-identical rules by first sighting -
neither tracks the block's own source order once two blocks emit the
same `@media` text. `Css_file.re`'s `rewrite_media_conditions` fixes
this before atomization: for every group of 2+ sibling `@media`
at-rules that set the same `(selector, property family)`, each earlier
condition is rewritten to exclude every later one (StyleX's
`lastMediaQueryWinsTransform`), so the group becomes pairwise disjoint
and "last written wins" holds regardless of stylesheet position:

```css
/* source */
@media (min-width: 600px) { color: red; }
@media (min-width: 900px) { color: blue; }

/* extracted */
@media (min-width: 600px) and (not (min-width: 900px)) { color: red; }
@media (min-width: 900px) { color: blue; }
```

Every negation is wrapped in its own parentheses - `(not (...))`, never a
bare `and not (...)`. Media Queries 4 only lets `not` start a whole
condition (`<media-not> = not <media-in-parens>`); anywhere else (after
an `and`) it must be parenthesized into its own `<media-in-parens>`
first. The bare form is a parse error a browser resolves to `not all` -
a condition that can never match - which would make every rewritten
earlier rule dead code.

A comma-separated (`or`) condition is negated by De Morgan: every branch
gets the same `(not (...))` terms appended independently. A 3+-way group
chains each earlier member against every strictly later one, not just
its immediate neighbor.

This runs *before* `Hash_class` hashes the atom's class name, so the
rewritten condition - not the source one - is what ends up in the class
and the stylesheet; two blocks that write the same two `@media`
conditions in opposite order now mint different, correctly-ordered
atoms instead of colliding on one shared, first-sighted pair.

v1 always wraps: it does not check whether two ranges are already
disjoint (`(min-width: 768px) and (max-width: 1279px)` vs
`(min-width: 1280px)` never actually overlap), so an already-correct,
non-overlapping pair still gets a redundant `and (not (...))` clause.
`# ponytail: always-wrap is O(bytes) not O(correctness-risk); add
interval detection (StyleX's range/interval math) when a monorepo round
shows real size cost.` Only `@media` is rewritten - `@supports` and
`@container` are a known, deliberate gap (see "Known limits" in
`how-merging-works.md`). A `@media` block whose content doesn't reduce
to one clean (selector, family) unit (further nesting, or two unrelated
properties in one block) is left untouched rather than guessed at: this
pass is an ordering optimization, not a validity check.

**A later query is negated only when every feature it tests resolves to
a definite true/false in every browser** - `min-width`/`max-width`/
`min-height`/`max-height` with a literal px/em/rem length, or
`orientation` - never `calc()`, a percentage, or range-comparison
syntax. Three-valued media-feature logic means `not unknown` is itself
`unknown`, and `true and unknown` is `unknown`, not `false`: negating a
query with an invalid or unsupported feature can turn an EARLIER rule
that used to apply unconditionally into one that never applies again -
a real, user-visible regression, not just a missed optimization.
Concretely: `min-width: calc(1000px - 2%)` mixes an absolute length with
a percentage (not valid in a media feature), so the browser resolves it
- and its negation - to permanently `false`; naively wrapping an
earlier `calc(2px + 1px)` rule against it would make that earlier rule
permanently false too, losing a style that showed at every normal
viewport width. If any later member of a group is unsafe this way, the
WHOLE group is left untouched, not just that one pairing.

**A query carrying a media type CAN be rewritten, when every member of
the group shares the exact same bare-or-`only` type** (`screen`/`only
screen` is by far the most common case in practice): the shared type is
carried through unchanged, only each member's own feature chain is
negated - `@media screen and (max-width: 992px) {...}` then
`@media screen and (max-width: 480px) {...}` extracts the first as
`@media screen and (max-width: 992px) and (not (max-width: 480px)) {...}`.
A `not`-prefixed type (`not screen and (...)`) is a separate, remaining
known gap even with a matching type on every member: `not` inverts the
WHOLE query (type and condition together, not just the condition), so
folding a negation into just the condition produces a genuinely wrong
result. A comma list mixing a typed and an untyped branch, or two
different types, is also left untouched - "keep mixed or other types
untouched" (`media-type-query-same-type-rewrite.t`).

## CSS.merge

See `documents/how-merging-works.md` for the user-facing version of this
section (the promise, worked examples, and the known limits, without the
implementation detail below).

`CSS.merge(a, b)` drops a class of `a` when a class of `b` covers the
same slot - same context, same property family, and `a`'s longhands a
subset of `b`'s - so the winner is decided by the merge call's own
argument order, not by which atom happened to reach the generated
stylesheet first under content-hash dedup. Before this, `merge` was
plain string concatenation (`fst a ^ " " ^ fst b`): if `a` and `b` both
carry the same property atom (e.g. `content = height: auto` merged with
`collapsed = height: 0`, both winning by turns depending on the merge
site) and some unrelated module also happens to use `a`'s atom, that
other module's own position in the generated stylesheet can decide
which of `a`'s or `b`'s atom the CSS cascade actually applies -
independent of which one this particular `merge` call meant to win.
See `packages/ppx/slot_key/slot_key.mli`'s `removes` for the exact rule.

The rule runs entirely at runtime, parsing the fixed-width fields the
class name already carries (see "Atomization" above) - no shorthand
table, no CSS property knowledge, in either the native or the melange
runtime (`packages/runtime/native/shared/Merge_key.ml`, built once and
shared into both - see its own doc comment for why it duplicates
`Class_format`'s widths instead of depending on it: it ships in the
melange browser bundle, and that library exists only to build the ppx's
compile-time property registry). A bundle (`_in_`), an identity (`_id_`),
a `label:<binding>` marker, and any class this pipeline didn't mint are
never dropped and never drop anything else - `merge` only ever acts on
a well-formed `_a_` atom on either side, and only ever drops a class of
`a`, never of `b`.

`!important` needs no separate check: it is folded into the context (as
if it were one more wrapper, like an at-rule - see
`packages/ppx/slot_key/slot_key.mli`'s `context` type), so a plain
declaration and its `!important` twin are never in the same context and
never remove each other in either direction. The browser's own cascade
already decides between them.

**Accepted limit**, pinned by `packages/runtime/test/test_merge_key.ml`:
`merge(margin: 10px, margin-top: 0)` (a shorthand, then a lone longhand
it covers) keeps both classes - a lone longhand's mask is never a
superset of the shorthand's full mask, by the encoding's own
convention, so the shorthand is never dropped by a later longhand this
way. Which one the browser actually applies still depends on where each
atom's rule landed in the generated stylesheet. The reverse
(`merge(margin-top: 0, margin: 10px)`, a longhand then a later
shorthand that covers it) is not a limit - it drops normally, since a
full mask is always a superset of any lone longhand's mask.

`merge`'s remaining gap here, and the one it can never close for a bundle
(two atoms hidden behind the SAME opaque `_in_` class), is exactly what the
aggregator's shorthand-before-longhand sort exists for - see "Cascade
tiers" above: the sort fixes stylesheet POSITION so the browser's own
cascade still resolves the override correctly, whether or not `merge`
itself could see the two properties involved.

**Known limit, pinned by `packages/runtime/test/test_merge_key.ml`**:
`Merge_key.parse_atom` (and its ppx-side mirror, `Slot_key.of_atom`'s
consumers) recognizes an atom by PREFIX and LENGTH alone - it has no way
to ask the ppx "did you really mint this class?" - so a hand-written,
author-authored class that happens to start with `_a_` and happens to
land on one of the six lengths a real atom can have is indistinguishable
from a real one. `merge_class_names "label:x _a_header" "_a_he1234"` drops
the hand-written `_a_header`: both strings parse as ordinary, same-
family, same-context, full-mask atoms (`"_a_header"`'s body, `header`, is
exactly the family+value floor - 6 characters, no context/mask/extended
fields - and `"_a_he1234"`'s body is the same length), so `removes` sees
no reason to keep both. Accepted as current behavior, same shape as
before the `_a_`/`_in_`/`_id_`/`_k_` prefix rename - only the odds of an
accidental collision changed (a hand-written class now needs to start
with the less common `_a_` sequence rather than plain `a-`), not the
existence of the limit. A hand-written class that merely starts with the
OLD `a-` shape, like `"a-header"`, is no longer read as an atom at all
now that only `_a_` is a recognized prefix - `packages/runtime/test/
test_merge_key.ml` pins both: the old shape now surviving `CSS.merge`
untouched, and the same ambiguity persisting under the new prefix.

## Identity classes

Every named `[%css]` binding and `[%styled.<tag>]` component mints a
second, build-independent class alongside its atoms: `_id_<hash>`
(`Hash_class.identity_class`). `$(binding)` and `&.$(binding)` selector
references resolve to this identity, verbatim, regardless of how many
atoms the binding minted or whether it minted any at all. It is emitted
first among the atoms in the className string (after the `label:<binding>`
dev marker, when present): `label:<binding> _id_<hash> _a_<hash> ...`.

**Inputs**, joined with `\0` and murmur2-hashed: the `--namespace` flag
value (see below), the compilation-unit module name (the source
file's basename, capitalized — never a physical path or dune library
name, so a module compiled twice under different paths, e.g. a native
and a Melange build via `copy_files`, mints the same identity when both
share a namespace), the
enclosing submodule path, the binding name (or `[%styled.<tag>]` module
name), and an occurrence index — folded in only when a
`(scope, name)` pair repeats within one compilation unit (e.g. two
functions each with their own `let a = [%css ...]`), so a name seen
exactly once keeps a stable identity independent of whether a later
occurrence ever appears. A `let` whose name starts with `__` does not count
as a binding here: it is a temporary another ppx introduced (server-reason-react's
`styles=` expansion binds `__incoming` and `__existing` before the `[%css]`
inside them is lowered), so the css under it takes the enclosing user
binding's name for its label, dev marker and identity
(`packages/ppx/test/css-support/styles-optional-className.t`).

**`--namespace=<string>`** is a PPX flag, mixed into every identity
(`_id_`), atom (`_a_`) and bundle (`_in_`) class hash in the same
library-wide way as `--dev`/`--minify` (see "Atomization" above). In a
dune `(pps ...)` list write it as one token, `--namespace=<string>`:
dune reads a separate value token as a PPX library name. It defaults to the dune `library-name` cookie
(`Settings.Get.namespace`, `packages/ppx/src/settings.re`) - the same
cookie `[@@@css.config]`'s `library-name` entry already carries - so
each dune library salts its own classes with no flag needed, and never
collides with another library's byte-identical declaration on a page
that links both (see "Class names" above). With neither the cookie nor
the flag (e.g. the standalone driver run with no `-cookie`, as every
css-support cram test does), the namespace is empty and adds nothing to
the hash input. An explicit `--namespace` overrides the
cookie: pass one shared value to both a native library and its Melange
twin's `(pps styled-ppx ...)` stanzas (`copy_files` gives them different
dune library names by default) so they keep minting identical atom and
identity classes; pass two libraries with no dune cookie distinct
values to tell them apart the way this flag always has
(`packages/ppx/test/css-support/atom-namespace-twin.t`,
`identity-library-namespace.t`). See "Identity collision" under Resolve
for what happens when two libraries collide anyway.

**Empty markers.** A named binding with no declarations (`let m = [%css
{||}]`) still mints an identity — its `class_string` is `""` and no
`[@@@css ...]` rule is emitted, since there is nothing to write. This is
independent of `--minify`: an empty binding's identity is never dropped,
which is what makes it possible to resolve `&.$(m)` in every mode (see
`packages/ppx/test/css-support/identity-empty-marker.t`).

**Specificity note.** `._a_x._id_y` is still a two-class compound
selector — `(0,2,0)` specificity, same as `._a_x._a_a._a_b` before
this change, and both still beat plain unqualified atoms either way.
Only a tie between two compound selectors that used to carry 3+ class
tokens can shift, since those are the only ones whose token count
actually drops.

## What this design intentionally avoids

- **Reading typed AST during PPX expansion.** ppxlib runs strictly per
  CU on the untyped Parsetree. Cross-module facts cannot be queried at
  PPX time — they have to flow through emitted attributes that a later
  tool reads.
- **Sidecar files.** No `.cmt` / `.cmti` / per-binding metadata files.
  Everything the aggregator needs lives in the post-PPX `.ml`.
- **Filesystem I/O from the PPX.** PPX never reads peers' artifacts.
  All cross-module information flows through the aggregator.
- **AST traversal in the aggregator, for anything but ordering.** The
  aggregator does not pattern-match `CSS.make` calls, and rule resolution
  never inspects the AST: the PPX writes the index directly into
  `[@@@css.bindings ...]`. Order is the one exception — it reruns the
  compiler's own free-module-name analysis (`Order.references`) on the
  input's structure to decide dependency order, and derives a module
  name from each input filename to resolve those references to files
  (see Order above); it still never touches `CSS.make`.
- **Runtime resolution of selectors via `var(--xyz)` indirection.**
  Selector interpolation is resolved statically (value interpolation
  does use custom properties, but only for values); this is a
  load-bearing choice and is what makes the aggregator necessary in
  the first place.

## See also

- `documents/how-merging-works.md` — `CSS.merge`, sheet order, and
  `--namespace`, for library users
- `documents/design.md` — overall CSS pipeline (parsing, validation,
  generation) and the `[%styled.global]` / selector-interpolation
  design in depth
- `documents/keyframe-static-extraction.md` — `[%keyframe]` extraction
  in depth
- `packages/generate/generate.ml` — the aggregator implementation
- `packages/generate/order.ml` — the dependency graph and sort behind
  `--order dependency`
- `packages/css-extraction/css_extraction.ml` — shared attribute names,
  sentinel encoding, and sentinel resolution
- `packages/ppx/src/{Css_bindings,Cross_module_refs}.{re,rei}` — the
  per-CU buffers feeding the aggregator
- `packages/ppx/src/Hash_class.ml` — identity, class, and variable hash
  formats, including `identity_class`
- `packages/ppx/src/Local_selector_environment.re{,i}` — same-file
  `$(name)` resolution to a binding's identity class
