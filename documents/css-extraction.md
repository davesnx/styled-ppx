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
[@@@css ".a-tokvmb{color:red;}"]
[@@@css ".a-1ru12dh:hover{opacity:0.8;}"]
[@@@css "@media (min-width:768px){.a-fmb91l{padding:2rem;}}"]
[@@@css "@keyframes k-jw9oix{from{opacity:0;}to{opacity:1;}}"]
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
build-independent `id-...` class (see "Identity classes" below) — a
`$(binding)` selector reference resolves to this, verbatim; the class
string is the space-separated list of atomized class names the PPX
produced, kept only as a content fingerprint so the aggregator can tell
a legitimate duplicate build from a real identity collision (see
Resolve below).

```ocaml
[@@@css.bindings
  [("M.marker", "id-1a2b3c4", "");
   ("M.Css.active", "id-5d6e7f8", "a-tokvmb");
   ("M.layout", "id-9a0b1c2", "a-k008qs a-1tyndxa")]]
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
edge. `--layers` (see Cascade layers below) requires `--order dependency`,
since it wraps each library's rules by the same grouping.

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
(`a-` classes) that mint the same class name but render
different CSS - the same shape as an identity collision above, applied
to atom classes instead of `id-` identities, and reported the same way
(both rule bodies, the shared class, a `--namespace` remedy). `in-`
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
`@import`/`@namespace`: CSS allows it anywhere in a stylesheet, and layer
order is first-occurrence order, so relocating a `@layer` statement would
silently reorder a library's cascade layers instead of just moving text.
It carries no atom class of its own, so cascade tiers (below) treat it
exactly like a registration or a global rule: it stays outside every tier,
ahead of the tier statement, in whatever relative position dedup/ordering
placed it among the other rules that also stay outside the tiers — a
normal and supported way to declare sub-layers from user-written CSS.
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

Every deduplicated STYLE rule this generator emits - a real atom (`a-`/
`in-` class) or a `[%styled.global]` rule (no atom class, but a real,
cascading rule all the same - `html{...}`, `*{...}`, `*::before{...}`, an
author's own global selector) - is classified into one of exactly four
CSS cascade layers, lowest to highest priority: `styled-ppx.global`,
`styled-ppx.descendant`, `styled-ppx.base`, and `styled-ppx.conditional`.
Every output stylesheet opens with the same, unconditional `@layer
styled-ppx.global, styled-ppx.descendant, styled-ppx.base,
styled-ppx.conditional;` statement (right after the hoisted
`@import`/`@namespace` rules and the registrations below) whenever it
ships any rule that tiers at all. Layer order beats source order, so
this fixes four real bugs content-hash dedup and plain concatenation
could not:

- a block's own `@media`/`:hover` override landing BEFORE its
  unconditional declaration in the deduplicated list (so the
  unconditional one, being later, always won, even while the condition
  held);
- the SAME atom emitted by two different `styled-ppx.generate`
  invocations (two `<link>`s on one page) landing in a different
  relative order to some OTHER sheet's conditional rule, depending only
  on which `<link>` the browser happened to load last;
- an ancestor's blind reach for an unclassed descendant
  (`.wrapper * {color}`) beating the descendant element's OWN class on
  the same property, purely because the ancestor's rule happened to land
  later in the stylesheet;
- and a `[%styled.global]` default (`*{box-sizing:inherit}`, a global
  `a{color:blue}`) beating an atom on the same element - the regression
  the first three tiers were almost shipped with: an unlayered normal
  declaration beats ANY layered one in CSS, regardless of layer or
  specificity, so leaving globals unlayered while atoms became layered
  would have let a global default win over an atom that used to beat it
  by ordinary specificity or source order.

Two sheets that both use these four fixed names agree on `global <
descendant < base < conditional` regardless of load order, because CSS
fixes cascade-layer order by each name's first occurrence across every
stylesheet on the page, cumulatively - which is also why the statement
lists all four names unconditionally even when this particular sheet
only ever populates some of them: omitting an empty one would make this
sheet's contribution to the OTHER tiers' priority depend on whether some
other sheet already declared it first.

**A real, documented behavior change**: a `[%styled.global]` selector
with HIGHER specificity than an atom (`.theme-dark .card{color:green}` vs
an atom `.a-card{color:blue}`) used to beat the atom outright -
specificity is compared before source order, and unlayered vs. unlayered
never considers layers at all. Now that `styled-ppx.global` is its own,
lowest layer, layer order beats specificity entirely: the atom wins
regardless of how specific the global selector is. An author whose
global still needs to win uses `!important` (see below) - the same
escape hatch every other tier already relies on.

**Classification**: a rule with NO atom class at all (see `atom_class_name`
in `packages/generate/generate.ml`) is either a registration (stays
outside every layer, see below) or a `[%styled.global]` rule, which is
always `styled-ppx.global` - global rules never compete for the SAME
descendant/base/conditional distinction an atom's own selector does, they
are simply the floor every atom sits above. A rule WITH an atom class is
classified per rendered rule (not per class, so two declarations of the
same `in-` bundle can land in different tiers), `Descendant` checked
FIRST and independent of at-rule/pseudo wrapping (see the reasoning
below), then `Conditional`, then `Base`:

- `Descendant`: the rule's selector reaches, via a combinator, for a
  DIFFERENT element than the atom's own class (every atom's class is
  always that selector's leading token), and that different element's
  subject compound (the rightmost compound - the actual element the rule
  styles, in CSS Selectors terms) has no class of its own: a bare element
  type or `*` (`.x > div`, `.x span`, `.x > *`). A subject that DOES carry
  its own class (`.x .id-...` - what a `$(binding)` selector reference
  resolves to - or a literal author class like `.x .tiptap`) is NOT this
  shape: seeing a class there means the rule targets a specific,
  identified element, not "whatever happens to be under here", so it
  stays `Base`/`Conditional` as before this tier existed. Checked
  independent of at-rule/pseudo wrapping - `@media (...) { .x > span
  {...} }` is still `Descendant`, not `Conditional` - because
  descendant-ness is a question of WHAT ELEMENT the rule reaches for, not
  of WHEN it applies: an ancestor's blind reach must lose to the child's
  own rule regardless of whether that child's own rule is itself
  unconditional or conditional, so "reaches for a different, unspecified
  element" has to outrank both, not just `Base`.
- `Conditional`: the rule is wrapped in an at-rule (`@media`/`@supports`/
  `@container` are the only ones that ever wrap an atom class -
  `@property`/`@keyframes`/`@font-face` registrations and a literal
  `@layer` at-rule carry no atom class at all and never reach this
  classification, see "outside the tiers" below), or a pseudo-class/
  pseudo-element is attached DIRECTLY to the atom's own compound selector
  (`.x:hover`, `.x::before`, chained `.x:focus-visible:not(:disabled)`).
- `Base`: everything else, including a descendant/child selector whose
  subject carries its own class (see above) and any selector with no
  combinator at all.

A real, narrower gap remains even with four tiers: `.x *{color:red}`
where `.x` itself is styled by nothing that competes (no rule targets
`.x` on the same property at all) still depends on stylesheet position
relative to some OTHER, unrelated rule that also happens to match the
descendant element - cross-element ordering beyond "does this rule's own
subject carry the atom's own class" is a different, harder problem tiers
do not fully solve.

`!important` needs no special handling here, but is worth naming
explicitly: CSS compares declaration importance BEFORE layer order, and
among `!important` declarations the EARLIEST-declared layer wins (the
reverse of the normal-declaration rule, where the latest layer wins) - so
an `!important` declaration in `styled-ppx.global` or `styled-ppx.
descendant` still beats a plain, non-`!important` declaration in a higher
layer, despite `global`/`descendant` being the two lowest layers for
everything else. This is an intentional, spec-level escape hatch (an
author who needs a global default or a descendant override to truly win
uses `!important`, same as they always could to beat any unconditional
rule), not a gap in this design - `styled-ppx.generate` only decides
which layer a rule goes in, never how a browser weighs importance
against layer order.

**Sort, inside each tier**: a stable sort puts an atom covering MORE of a
property family's leaves (a shorthand, or a wider family atom) before one
covering fewer of the SAME family (a lone longhand from a different
binding or a different `in-` bundle) - rules that share no family compare
equal, so the sort never reorders anything else, and only ever reorders
rules that were already fighting over the same property. This is what
`CSS.merge` (below) cannot do for two atoms hidden inside different `in-`
bundles (`CSS.merge` only ever sees a bundle's class as one opaque,
never-dropped token): the sort fixes their relative STYLESHEET position
instead, restoring the override a `merge` call intended even though
`merge` itself still cannot see one property next to another inside a
bundle. Reads each rule's own property name(s) straight from its rendered
text (through `Slot_key.Family`'s css-grammar-sourced shorthand/leaf data,
the same table a real atom's own mask is built from) rather than from a
`Slot_key.t` - a bundle's declarations never had one to begin with (a real
bundle spans more than one property, sometimes more than one context, see
"Atomization" above). Two declarations already grouped into one atom
because their leaves overlap (see "Atomization") never need this: they are
one rule, in author order, before the sort ever runs.

**Outside every tier, always**: `@property`, `@keyframes`, `@font-face`
registrations, hoisted `@import`/`@namespace`, dropped `@charset`, and a
literal, user-authored `@layer` at-rule (statement or block form) - none
of these compete for an element in the cascade the way a `[%styled.
global]` rule or an atom does, and nesting a literal `@layer` inside one
of styled-ppx's own tiers would rescope whatever sub-layer name it
declares, silently changing what the user's own statement means (the same
hazard "Dedup and write" already explains for why it is never hoisted
with `@import`/`@namespace` either). They are emitted exactly where they
were before tiers existed: ahead of the tier statement, in whatever
relative order dedup/ordering already gave them. A `[%styled.global]`
rule is NOT in this list - it has no atom class either, but it IS a real,
cascading rule, so it goes into `styled-ppx.global` (above), not outside
every tier.

### Cascade layers (opt-in), nested inside tiers

`--layers` (default off, and rejected together with `--order source`)
wraps each tier's OWN rules into named per-library CSS cascade layers,
nested one level inside that tier's `@layer styled-ppx.global { ... }` /
`@layer styled-ppx.descendant { ... }` / `@layer styled-ppx.base { ... }`
/ `@layer styled-ppx.conditional { ... }` block - the outer tier
statement above already settles global-vs-descendant-vs-base-vs-
conditional order before any library ordering is even consulted, so a
library's conditional atom never has to out-rank a DIFFERENT library's
base, descendant, or global rule by accident. Inside each non-empty tier,
one `@layer <lib1>, <lib2>, ...;` statement lists every library that
still owns a rule IN THAT TIER, in the same dependency order as the
default output, and then each such library's rules for that tier follow
inside their own nested `@layer <lib> { ... }` block - the same
per-library bucketing the unlayered case skips, just computed once per
tier instead of once overall, so a library can get a block in one tier
and none in another. A group with nothing left to wrap in a given tier
gets no block and no name in that tier's statement, same rule as before
tiers existed. A tier with no rule in this sheet at all gets no `@layer
<lib1>, ...;` statement and no library blocks either - only the OUTER,
four-name tier statement is unconditional; a per-library statement inside
an empty tier would have nothing to say. `@property`/`@keyframes`/
`@font-face` registrations and a literal `@layer` at-rule stay outside
every tier and every library layer, exactly as before tiers existed: a
`@property` inside a layer would make the registration itself depend on
layer order, and a `@keyframes` name lookup would too.

Layering rules changes how they interact with hand-written CSS, which is
why the flag defaults to off. An unlayered declaration always beats a
layered one, however low that layer sits, because the cascade only
compares layers when both competing declarations are themselves inside a
layer; a normal, non-`!important` layered rule loses to any unlayered
rule regardless of specificity or source order. `!important` inverts
that: an `!important` declaration in a layer beats an unlayered
`!important` declaration, and among layers the earliest-declared layer
wins for `!important` (the opposite of the normal-declaration order,
where the latest layer wins) - this applies to the mandatory
`styled-ppx.global`/`.descendant`/`.base`/`.conditional` tiers too,
`--layers` or not; not addressed by this change, flagged here rather than
silently ignored (see "Cascade tiers" above for the specific
global/descendant `!important` interaction). A consumer that turns
`--layers` on has to put its own hand-written CSS — resets, palettes,
fonts, an inline global stylesheet not routed through `[%styled.global]`
at all — into a layer declared before the generated ones (before
`styled-ppx.global`, the first-declared of the four, now that they always
exist), or that CSS's plain declarations stop overriding anything the
generated, now-layered rules set.

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

Class names follow the `a-<context?><family><mask?><value>` format: a
fixed-width, base36-encoded context hash (present only under a real
selector/at-rule, or when the declaration carries `!important` - see
"CSS.merge" below), a 2-character property-family id from a fixed,
append-only table, an optional mask of which of the family's longhands
this atom covers, and a short value hash unique only within that
(context, family[, mask]) bucket - not globally, which is what lets it
be short. `styled-ppx.generate` checks that uniqueness (see the atom
class collision check under "Dedup and write" above). The binding's
`let` name never appears in the class name either way; two bindings
whose declarations render to the same CSS text in the same context mint
the same class, dev or production. Minting lives in
`packages/ppx/src/Hash_class.ml` (`Class_format.slot_class`); the
`(context, family, mask)` triple comes from `packages/ppx/slot_key`.

One exception: when a block has TWO OR MORE declarations that carry a
`$(...)` value interpolation, they mint one shared `in-<murmur2 hash>`
class instead - a plain, unbucketed hash of their concatenated content, no
context/family/mask fields at all (the "bundle" - see `Css_file.re`'s
`transform_rule_list`). A single interpolating declaration is NOT a
bundle: it mints its own real, slot-keyed `a-` class exactly like a static
atom, and merges normally (see `CSS.merge` below) - bundling only kicks
in when two or more of a block's interpolating declarations would
otherwise need separate custom-property namespaces for what is often the
same value reused across `base`/`:hover`/`@media` variants. A bundle's own
`var(--...)` target is unaffected by which prefix its class carries,
since only the CLASS half of `Hash_class.class_and_namespace` differs
between the two cases, never the namespace/variable-naming half. The
`in-` prefix lets `CSS.merge` (see below) recognize a bundle atom and
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

## CSS.merge

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
compile-time property registry). A bundle (`in-`), an identity (`id-`),
a `label:<binding>` marker, and any class this pipeline didn't mint are
never dropped and never drop anything else - `merge` only ever acts on
a well-formed `a-` atom on either side, and only ever drops a class of
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
(two atoms hidden behind the SAME opaque `in-` class), is exactly what the
aggregator's shorthand-before-longhand sort exists for - see "Cascade
tiers" above: the sort fixes stylesheet POSITION so the browser's own
cascade still resolves the override correctly, whether or not `merge`
itself could see the two properties involved.

## Identity classes

Every named `[%css]` binding and `[%styled.<tag>]` component mints a
second, build-independent class alongside its atoms: `id-<hash>`
(`Hash_class.identity_class`). `$(binding)` and `&.$(binding)` selector
references resolve to this identity, verbatim, regardless of how many
atoms the binding minted or whether it minted any at all. It is emitted
first among the atoms in the className string (after the `label:<binding>`
dev marker, when present): `label:<binding> id-<hash> a-<hash> ...`.

**Inputs**, joined with `\0` and murmur2-hashed: the `--namespace` flag
value (empty by default), the compilation-unit module name (the source
file's basename, capitalized — never a physical path or dune library
name, so a module compiled twice under different paths, e.g. a native
and a Melange build via `copy_files`, mints the same identity), the
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

**`--namespace <string>`** is a PPX flag, mixed into every identity hash
in the same library-wide way as `--dev`/`--minify`. Two libraries whose
modules happen to share a basename and binding name would otherwise mint
colliding identities; passing each library a distinct `--namespace`
(identically on its native and Melange `(pps styled-ppx ...)` stanzas)
tells them apart. See "Identity collision" under Resolve for what
happens when they aren't.

**Empty markers.** A named binding with no declarations (`let m = [%css
{||}]`) still mints an identity — its `class_string` is `""` and no
`[@@@css ...]` rule is emitted, since there is nothing to write. This is
independent of `--minify`: an empty binding's identity is never dropped,
which is what makes it possible to resolve `&.$(m)` in every mode (see
`packages/ppx/test/css-support/identity-empty-marker.t`).

**Specificity note.** `.a-x.id-y` is still a two-class compound
selector — `(0,2,0)` specificity, same as `.a-x.a-a.a-b` before
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
