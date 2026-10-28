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
  ─ drain Css_file.Buffer     → emit [@@@css ...]              (one per rule; an atom rule carries its sort key)
  ─ drain Css_bindings        → emit [@@@css.bindings [...]]   (binding exports)
  ─ drain Css_file.Blocks     → emit [@@@css.blocks [...]]     (block rule lists)
                              → emit [@@@css.merges [...]]     (resolved CSS.merge / +++ calls)
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
  ─ extract [@@@css ...], [@@@css.bindings ...], [@@@css.blocks ...], [@@@css.merges ...], [@@@css.refs ...], [@@@css.config ...]
  ─ resolve NUL-delimited cross-module sentinels against the bindings index
  ─ deduplicate rules, order atom rules by their keys, blocks and merges
  ─ emit final stylesheet (minified when the configs say production)
  │
  ▼
styles.css
```

## Wire protocol: six attributes

Everything the aggregator needs to know is conveyed by six top-level
floating attributes that the PPX appends to the post-PPX file. They are
the entire interface between PPX expansion and the aggregator — the
aggregator never re-parses `CSS.make` calls, never reads facts out of a
rendered rule's text, and never infers facts from filenames; it takes no
mode flags either: the build environment travels in-band.

### `[@@@css ...]` — extracted CSS rule

One attribute per atomized rule, per global rule, per `@keyframes` block
and per `@property` registration. An atom rule is a tuple of the rule text
and its sort key; any other rule is the bare rule text.

```ocaml
[@@@css ("._a_tokvmb{color:red;}", "_a_tokvmb", "0,1,0 own", "158", 1, false)]
[@@@css ("._a_1ru12dh:hover{opacity:0.8;}", "_a_1ru12dh", "0,2,0 own", "310", 1, false)]
[@@@css ("._a_9k2 .tiptap{color:navy;}", "_a_9k2", "0,2,0 & .tiptap", "158", 1, false)]
[@@@css "@keyframes _k_jw9oix{from{opacity:0;}to{opacity:1;}}"]
```

The key (`Css_extraction.atom_key`, computed by `Sort_key.of_rule` from the
rule's AST before the autoprefixer runs) is:

- the atom's own `_a_`/`_in_` class;
- the scope: `!` when important, the specificity (Selectors 4:
  `:where()` counts 0, `:is()`/`:not()`/`:has()` count their most specific
  argument), then the element the rule styles: `own` plus its
  pseudo-elements, or the whole selector with the atom class written `&`
  when a combinator reaches another element;
- the family and mask of the longhands the declarations set, on the
  canonical property name (an alias such as `grid-gap` counts as `gap`; a
  `-webkit-` copy never counts). The family is `*` for `all`, and starts
  with `-` when `all` does not reset the property;
- whether the rule is descendant-shaped: a combinator to an element whose
  compound has no class (`.x *`, `.list li`).

The text may contain NUL-delimited cross-module sentinels
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

### `[@@@css.blocks [(line, identity, [rule; ...]); ...]]` — block rule lists

One attribute per CU, listing every block the CU rendered: every `[%css]`
and `[%styled.<tag>]` expansion, named or anonymous. The line is the source
line of the block's CSS string (the file is the one that carries the
attribute); the identity is the block's `_id_` class (`""` when anonymous);
the rules are indices into the file's `[@@@css ...]` list, one per rule, in
emotion order: the block's own declarations first, then its nested rules
(pseudo-classes, `@media`, selectors), each in source order, and the same
inside every nested rule. A rule that a bundle shares with other rules of
the block keeps its own position. Identical entries appear once.

```ocaml
[@@@css.blocks [(1, "_id_zu568x", [0]); (5, "", [1; 0])]]
```

The PPX records an entry in exactly one place, `Css_file.push` (buffer
`Css_file.Blocks`). The aggregator reads the order of competing rules from
it (see "Sheet order"); it names a block by the longident of its identity
(from the bindings index), else by `file:line` (the input file, `.pp.ml`
suffix removed). Like the other attributes, it is a floating attribute: the
compiler drops it, so it reaches neither the native nor the JS output.

### `[@@@css.merges [(line, [operand; ...]); ...]]` — merge calls

One attribute per CU, listing every `CSS.merge(a, b)` and `a +++ b` whose
arguments the PPX resolves, with its arguments in call order
(`merge(merge(a, b), c)` and `a +++ b +++ c` list `a`, `b`, `c`). An operand
is an integer, the index of a block of the same file (a `[%css]` binding
resolved through `Local_selector_environment`, or an inline `[%css]`), or a
string, the longident of another module's binding. An argument the PPX can
not resolve (a function call, a parameter) is left out; the attribute lists
only calls with two or more resolved arguments.

```ocaml
[@@@css.merges [(6, [1; 2]); (12, ["Theme.base"; 3])]]
```

The aggregator adds a merge edge from each competing rule of an argument to
each rule of a later argument (see "Sheet order").

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

Four module-level mutable buffers, all per-CU, all drained by the impl
transformer at end-of-CU:

| Buffer                              | Source                         | Sink                              |
| ----------------------------------- | ------------------------------ | --------------------------------- |
| `Css_file.Buffer`                   | atomized rules during expansion | `[@@@css "..."]` attributes       |
| `Css_bindings`                      | each named `[%css]` / `[%styled.<tag>]` expansion | `[@@@css.bindings ...]` attribute |
| `Css_file.Blocks`                   | each `[%css]` / `[%styled.<tag>]` expansion, each resolved `CSS.merge` / `+++` | `[@@@css.blocks ...]` and `[@@@css.merges ...]` attributes |
| `Cross_module_refs`                 | each unresolved `$(M.x)` in selector position | `[@@@css.refs ...]` attribute + synthetic `let _ = M.x` |

`Local_selector_environment` is a fifth piece of state, distinct from the
buffers above: it serves same-file selector interpolation before cross-module
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

A list of rules (`Css_extraction.rule`: the text, and the sort key for an
atom rule), deduplicated by class name (by text for a bundle rule), with
each rule's position, so a block can name its rules by index. Cleared at
end-of-CU when `Css_file.get()` returns the rules, blocks and merges to the
impl transformer.

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

The same scoping applies to the other descriptor-only at-rules:
`@font-palette-values` (`base-palette`, `override-colors`, plus `font-family`),
`@view-transition` (`navigation`, `types`) and `@counter-style` (`system`,
`symbols`, `negative`, `range`, `pad`, `fallback`, `prefix`, `suffix`,
`additive-symbols`). Each descriptor is validated against its spec grammar and
rejected outside its at-rule; the scopes live in `Css_validation.re`.
`@counter-style`'s `speak-as` is not registered yet.

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
the seven attribute shapes:

```ocaml
[@@@css ...]              → push rule (text, and key for an atom rule)
[@@@css.bindings [...]]   → fold (longident, identity, class_string) into Index
[@@@css.blocks [...]]     → push (line, identity, rule indices) into per-file blocks
[@@@css.merges [...]]     → push (line, operands) into per-file merges
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
files or libraries with no dependency relation come out in alphabetical
order of their key (the file path, or the library name), whatever order
dune passes them in, and a cycle — which can't come from a real dune
graph, only from this heuristic picking an edge a real build wouldn't
have — never fails the build. The aggregator warns once naming the cycle's
members, drops one edge that lies on the cycle (both ends in one strongly
connected component; the one whose source sorts alphabetically last), and
keeps going. A node that only depends on the cycle keeps its edge.

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
two libraries whose modules share a basename and binding name. This is
only an error when their
`class_string` fingerprints differ: the same identity with the same
atoms is the ordinary "same module compiled twice" case (native +
melange, `copy_files`, vendoring) and is accepted. A real collision
names both input files, both longidents, the shared identity, and the
rename remedy, and is reported through the same protocol-error
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
(both rule bodies, the shared class, the width of the value hash, and
what to do). The value field is 4 base-36 characters, 1,679,616 values
per (context, family, mask) bucket, so by the birthday bound a bucket
with about 1,500 distinct declarations has an even chance of one
collision. The repository's own tests and demo hold at most 101 (plain
`color` values) in one bucket, about a 0.3% chance, and have no
collision. One run per app checks every library at once. `_in_`
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
rule). A namespace-qualified selector (`svg|circle`, `[xlink|href]`) only
matches when the page declares its prefix with `@namespace svg url(...);`,
which the hoisting above then places ahead of the rule; `*|name` and `|name`
need no declaration (`packages/ppx/test/css-support/namespace-selectors.t`).
Statement-form `@layer a, b;` is deliberately NOT hoisted with
`@import`/`@namespace`: CSS allows it anywhere in a stylesheet, but a
layer's priority is fixed by its name's FIRST occurrence across the whole
page, so relocating a user's own `@layer` statement could silently change
which layer it introduces first there - a hazard independent of whether
this aggregator wraps anything in a layer of its own. It carries no atom
key, so the sheet order (below) treats it exactly like a registration: it
takes no part in ordering, staying in whatever relative position dedup
already gave it among the other registrations — a normal and supported way
to declare layers from user-written CSS.
`@charset` is dropped instead of hoisted: the generated file always opens
with its own leading comment, so `@charset` can never be the literal
first bytes of the stylesheet, and the file is written as UTF-8 regardless
of what a module declares; dropping it is reported as a warning naming
the input file (`packages/generate/test/statement-at-rules.t`).

The deduplicated (and hoisted) list is then written to the output
channel. Inter-rule newlines are dropped when every contributing input
file declared `env=production` in its `[@@@css.config ...]` (see the wire
protocol section above); there is no CLI flag for this.

### Sheet order: the ordered sheet (always on)

Every deduplicated STYLE rule this generator emits is either a
`[%styled.global]` rule (no atom key, but a real, cascading rule -
`html{...}`, `*{...}`, an author's own global selector) or an atom rule
(it carries an atom key). Globals come first, in source and dependency
order: hand-written CSS keeps its own order, so a later `h1{padding:0}`
still wins over an earlier `h1{padding-top:10px}`
(`packages/generate/test/global-source-order.t`). All atom rules follow in
ONE topological order (`order_atom_rules` in `packages/generate/generate.ml`,
"Ordered sheet"). No CSS layer wraps any of it: specificity decides first,
emission position is only the tie-break. The generator reads every fact it
orders by from the payload; it never parses a rule's text.

**Competing rules.** Sheet position matters only between two rules the
cascade can not separate otherwise: the same scope (equal `!important`,
equal specificity, the same subject element and pseudo-element - a rule
whose selector reaches another element through a combinator only competes
with a rule of the same selector) and at least one shared longhand (equal
family, masks that share a bit; `all` overlaps every property it resets).
A legacy alias that css-grammar registers (`grid-gap`, `grid-row-gap`,
`grid-column-gap`, `word-wrap`, `font-width`) counts as its canonical
property, so `grid-gap: 40px` and a later `gap: 16px` compete. A logical
property and the physical properties it can map to also compete
(`margin-inline-start` and `margin-left`, `inline-size` and `width`, ...),
whatever the writing mode, from one table, `Slot_key.logical_physical_pairs`
(`packages/ppx/test/css-support/ordered-sheet-logical-physical.t`).
`CSS.merge` still keeps them apart: it never drops a physical class for a
logical one or the reverse.

**Order keys**, in priority:

1. Descendant-shaped rules first (the key's `descendant`: a combinator to
   an unclassed subject, `.x *`, `.list li`), so a child's own atom wins a
   specificity tie against an ancestor's blind reach.
2. Edges.
   - Block edges: inside one block (`[@@@css.blocks ...]`, emotion order),
     an earlier competing rule comes before a later one. So
     `@media (max-width: 600px) { color: pink } color: black` gives pink
     under the media query, as emotion prints the block
     (`packages/ppx/test/css-support/ordered-sheet-emotion-order.t`).
   - Merge edges: in a resolved `CSS.merge(a, b)` or `a +++ b`
     (`[@@@css.merges ...]`), each competing rule of `a` comes before each
     rule of `b`, whichever block defined each atom first
     (`packages/ppx/test/css-support/ordered-sheet-merge-edges.t`). A rule
     whose class a later argument drops at run time (`Merge_key.removes`,
     the source `generate` copies from the runtime) takes no part, so
     `merge(a, b)` and `merge(b, a)` only conflict when both keep both
     classes (`ordered-sheet-merge-both-orders.t`).
3. Definition order (first occurrence in the deduplicated, dependency-ordered
   rule list) for every pair the edges leave open.

There is no "shorthand before a longhand it covers" edge across blocks.
Such an edge also reaches through an unrelated block: in the Ahrefs
monorepo, a `padding-right` rule under `@media (max-width: 1279px)` in one
file pulled `headerWithBanner`'s `padding` rule in that context, and through
its block edge its base rule, ahead of `header`'s rules, so
`merge(header, headerWithBanner)` gave `header` the tie
(`packages/ppx/test/css-support/ordered-sheet-monorepo-regressions.t`).
`CSS.merge` already drops a longhand that a later argument's shorthand
covers.

The sheet is built from its end: among the rules whose successors are all
placed, the latest by definition order is placed next. A rule therefore
stays at its definition position unless an edge pulls it ahead of a rule it
must precede.

**Conflicts and cycles.** Two blocks or merges that order the same two
rules in opposite directions: a warning names both (`block <longident>` or
`block <file:line>`, `merge at <file:line>`), both edges are dropped, and
the pair keeps definition order (`block-order-pseudo-class.t`). A
longer cycle is cut at the rule that waits on the fewest edges, with a
warning naming the blocks and merges whose order it drops
(`ordered-sheet-cycle.t`).

**Not used, by measurement (2026-10-20).** #616's base-before-conditional
tier, shorthand depth as a global key, and the fixed at-rule and
pseudo-class rank tables (StyleX's numbers). Block and merge edges plus
definition order decide those ties; a fixed rank overrode a block's own
source order.

**Accepted limit: two separate stylesheets have no guaranteed relative
order between their rules, when they share a class.** Class hashes take no
library name (see "Atomization"), so two libraries that declare the same
atom share its class. Run one `styled-ppx.generate` per app over all its
libraries; two `<link>`s concatenate on the page in load order - see
`two-stylesheets.t`.

**Takes no part in ordering, always**: `@property`, `@keyframes`,
`@font-face` registrations, hoisted `@import`/`@namespace`, dropped
`@charset`, and a literal, user-authored `@layer` at-rule (statement or
block form) - none of these compete for an element. They are emitted ahead
of every style rule, in the order dedup gave them.

`--layers` is not a recognized flag: passing it is rejected the same way
any other unrecognized flag is.

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
`Slot_key.leaves_of` directly (not a reimplementation). A group sits at its
last member's position among the block's declarations, and the block's
nested rules come after all of its declarations (emotion order), so
`padding: 8px; @media (min-width: 768px) { padding: 16px; } padding-top: 0;`
gives `padding: 16px` at 768px and wider.

Class names follow the `_a_<context?><family><mask?><value>` format: a
fixed-width, base36-encoded context hash (present only under a real
selector/at-rule, or when the declaration carries `!important` - see
"CSS.merge" below), a 2-character property-family id from a fixed,
append-only table, an optional mask of which of the family's longhands
this atom covers, and a short value hash unique only within that
(context, family[, mask]) bucket - not globally, which is what lets it
be short. The value hash is computed over the rendered declaration
alone, with no library name or flag, so a native library and its
Melange twin mint the same class, and so do two libraries that declare
the same atom. `styled-ppx.generate` checks the
per-bucket uniqueness this leaves (see the atom class collision check
under "Dedup and write" above). The binding's `let` name never appears
in the class name either way; two bindings whose declarations render to
the same CSS text in the same context mint the same class, dev or
production. Minting lives in `packages/ppx/src/Hash_class.ml`
(`Class_format.slot_class`); the `(context, family, mask)` triple comes
from `packages/ppx/slot_key`.
An alias (`grid-row-gap` for `row-gap`, one of two legs of `gap`) resolves
to its canonical name before its mask is computed, and before
declarations are grouped (so `row-gap: 2px; grid-row-gap: 1px;` is one
atom, `packages/ppx/test/css-support/ordered-sheet-alias-grouping.t`): it
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
between the two cases, never the namespace/variable-naming half
(`Hash_class.bundle_class_and_namespace`). The
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
(two atoms hidden behind the SAME opaque `_in_` class), is left to sheet
position - see "Sheet order" above: a merge the PPX resolves puts the
narrow argument's rules after the wide one's; otherwise one block's source
order, then definition order decide.

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

**Inputs**, joined with `\0` and murmur2-hashed: the compilation-unit
module name (the source file's basename, capitalized — never a physical
path or dune library name, so a module compiled twice under different
paths or library names, e.g. a native and a Melange build via
`copy_files`, mints the same identity), the
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

Two libraries that each have a module with the same basename and a
binding with the same name share an identity. Run one
`styled-ppx.generate` per app: it sees both and reports an identity
collision when their CSS differs (see "Identity collision" under
Resolve). Rename the module or the binding in one of them. The dune
`library-name` cookie never reaches a hash; the ppx writes it only into
`[@@@css.config]`, where `styled-ppx.generate` reads it to group modules
for dependency order (`packages/ppx/test/css-support/library-twin-same-classes.t`).

**Empty markers.** A named binding with no declarations (`let m = [%css
{||}]`) still mints an identity — its `class_string` is `""` and no
`[@@@css ...]` rule is emitted, since there is nothing to write. This is
independent of `--minify`: an empty binding's identity is never dropped,
which is what makes it possible to resolve `&.$(m)` in every mode (see
`packages/ppx/test/css-support/identity-empty-marker.t`).

**Specificity note.** `._a_x._id_y` is still a two-class compound
selector with `(0,2,0)` specificity. Before this change,
`._a_x._a_a._a_b` had `(0,3,0)`. Both still beat plain unqualified
atoms, but the reduction can change the winner against any competing
selector, not only a tie between compound selectors. For example, a
later two-class selector can now override a rule that previously had
three classes.

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
  several libraries in one sheet, for library users
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
