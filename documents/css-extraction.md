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
| `[%css]`               | Class-scoped declaration lists, one class per block                     |
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
  ─ hash each block into one class
  ─ resolve same-module $(name) selector interpolations
  ─ buffer rendered rules; record cross-module refs as sentinels
  │
  ▼
PPX impl transformer (end of CU)
  ─ production, library-name  → emit [@@@css.config [...]]     (environment, library)
  ─ drain Css_file.Buffer     → emit [@@@css "..."]            (one per block)
                              → emit [@@@css.classes [...]]    (block classes)
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
  ─ order the library's .ml / .pp.ml files by the imports in their .cmt files
  ─ walk every .ml / .pp.ml in the library
  ─ collect [@@@css ...], [@@@css.classes ...], [@@@css.bindings ...], [@@@css.refs ...], [@@@css.config ...]
  ─ resolve NUL-delimited cross-module sentinels against the bindings index
  ─ check that no two blocks with different rules have the same class
  ─ deduplicate rules, emit final stylesheet (minified when the configs say production)
  │
  ▼
styles.css (one per library; the app loads library sheets in dependency order)
```

## Wire protocol: five attributes

Everything the aggregator needs to know is conveyed by five top-level
floating attributes that the PPX appends to the post-PPX file. They are
the entire interface between PPX expansion and the aggregator — the
aggregator never re-parses `CSS.make` calls or infers facts from filenames,
and it takes no mode flags: the build environment travels in-band.

### `[@@@css "..."]` — extracted CSS rule

A CSS string. One attribute per `[%css]` block (all the block's rules,
nested selectors and at-rules included), per global rule, or per
`@keyframes` block.

```ocaml
[@@@css ".css-61kr9t7{display:flex;align-items:center;}"]
[@@@css ".css-61krwwy{padding-right:8px;}.css-61krwwy:where(.css-61kr54l:last-child){padding-right:0;}"]
[@@@css "@keyframes keyframe-jw9oix{from{opacity:0;}to{opacity:1;}}"]
```

The string may contain NUL-delimited cross-module sentinels
(`\x00LONGIDENT\x00`) when the PPX could not resolve a `$(M.binding)`
selector reference at PPX time. The aggregator substitutes those at
resolve time (see "Resolve" below; the sentinel constants live in
`packages/css-extraction/css_extraction.ml`).

### `[@@@css.classes [(class, rule_index, binding, file, start_line, start_col, end_line, end_col); ...]]` — block classes

One attribute per CU that has blocks. One entry per block class: the
block's class, the index of its rule among the file's `[@@@css ...]` items
(from 0; `-1` for an empty marker block, which has a class and no rule),
the binding that holds the block (`""` when the block is anonymous, as in
`let _ = [%css ...]`), and the block's location in the source.

```ocaml
[@@@css.classes
  [("css-61kr9t7", 1, "Card.layout", "card.ml", 2, 2, 4, 0);
   ("css-61krp2a", -1, "Card.active", "card.ml", 9, 18, 9, 18);
   ("css-61kr0r8", 4, "Card.compactCell", "card.ml", 14, 25, 14, 43)]]
```

The aggregator uses it to find two different blocks with the same class
(for example two modules with the same name in one sheet). The same class
with the same rule text, for example a native and a Melange copy of one
module, is not a collision. A class with two rule texts (an empty marker
has the rule `""`) is an error that names both bindings and gives both
locations. An index below `-1` or out of range is a protocol error.

### `[@@@css.bindings [(longident, class_string); ...]]` — binding exports

One attribute per CU, listing every named `[%css]` binding and
`[%styled.<tag>]` component the CU minted.
The longident is the fully-qualified path users would write to reference
the binding from another module; the class string is the binding's
class. A binding that holds exactly one block (or empty marker) anywhere in
its body, and is not a function, exports that block's class. A function
or a binding with two or more blocks exports an empty class string, and
`generate` reports a reference to it at the reference. Aliases, string
literals and other values are not exported. No real block exports an empty
string: an empty marker has its own class.

```ocaml
[@@@css.bindings
  [("Card.layout", "css-61kr9t7");
   ("Card.edge", "css-61kr54l");
   ("Value.pick", "")]]
```

The aggregator folds every payload into a flat
`(longident, class_string) Hashtbl` — its global resolution index. No
AST walking, no `CSS.make` pattern matching, no filename-to-module
inference.

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

Carries PPX-side settings the aggregator must honor, as string
key/value pairs. Two keys:

- `env`: `("env", "production")` when the PPX runs with production
  settings (`--minify` or `--env production`) and the CU contributes
  extraction items. Absence means development.
- `library`: the dune library of the CU, from dune's `library-name`
  cookie, in every CU when the cookie is present. dune passes it to a
  library's ppx (not an executable's) since jbuilder 1.0+beta8, for every
  `(lang dune ...)` version. Run outside dune, the PPX writes none.

```ocaml
[@@@css.config [("env", "production"); ("library", "ui")]]
```

The attribute is omitted when it has no entry. Unknown keys are ignored
by the aggregator (forward compatibility).

The aggregator minifies its output (drops inter-rule newlines) only when
**every** contributing input file — every file with collected rules or an
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
| `Css_file.Buffer`                   | block rules during expansion   | `[@@@css "..."]` and `[@@@css.classes ...]` attributes |
| `Css_bindings`                      | each named `[%css]` / `[%styled.<tag>]` expansion | `[@@@css.bindings ...]` attribute |
| `Cross_module_refs`                 | each unresolved `$(M.x)` in selector position | `[@@@css.refs ...]` attribute + synthetic `let _ = M.x` |

`Local_selector_environment` is a fourth piece of state, distinct from the
three above: it serves same-file selector interpolation before cross-module
fallback. It is keyed by `(file, lexical_path)` and never escapes the CU.
It tracks named `[%css]` bindings and `[%styled.<tag>]` components, same-file
module aliases, same-file opens/includes, and earlier string literals.
Cross-module references only go through `Cross_module_refs` after this local
resolver fails.

### `Css_file.Buffer`

A list ref of `(className, cssText)` pairs, one entry per block, and the
block classes (class, rule text, binding, location) for
`[@@@css.classes ...]`. Cleared
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
custom properties (`var(--<path>-<hash>)` in the extracted rule, values
supplied by the generated module's runtime `:root` block — see
`documents/design.md`). Two positions reject interpolation outright:

- inside `url(...)` (browsers don't substitute `var()` there), so font
  URLs must be literal CSS
- in at-rule preludes, e.g. `@media (max-width: $(bp))`

### `Css_bindings`

Per-CU buffer of `(longident, class_string)` exports. The ordered
structure pass computes the longident from the compilation unit name + current
submodule path + the enclosing top-level value name (`[%css]`) or module name
(`[%styled.<tag>]`), then calls `Css_bindings.record`. Last-write-wins on
duplicates within a CU (matches `Local_selector_environment` shadowing
semantics).

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
`.pp.ml` paths, optionally mixed with `.cmt` paths, produces a stylesheet
on stdout or `-o <file>`. One run gives one sheet, usually one per
library.

```
parse args → order files → read each file → resolve_sentinels → check classes → dedup → write
```

### Order

The arguments are split by extension. Without `.cmt` files the inputs are
sorted by path. With `.cmt` files (`packages/generate/module_order.ml`):

- Each `.cmt` gives `cmt_modname`, `cmt_sourcefile` and `cmt_imports`, the
  three fields that mean the same on OCaml 4.14 and 5.x (`cmt_loadpath`
  changed type in 5.2 and is not read). A `.cmt` compiled from a generated
  `.ml-gen` file (the alias module of a wrapped library) is skipped.
- A `.cmt` matches an input when its `cmt_sourcefile`, a path from the
  directory the compiler ran in (for dune, the build context root), is a
  component suffix of the input's absolute path. dune runs the rule in its
  own directory, so `%{deps}` paths are relative to it, and this pairs them
  without knowing the context root. Each input takes the matching `.cmt`s
  with the longest source file (`packages/x/src/foo.ml` beats
  `src/foo.ml`). A `.cmt` that is the best match of two inputs is ignored
  with a warning that names both. A `.cmt` that matches no input is
  ignored: a glob over an object directory can pull in modules that the
  rule does not cover.
- Module A goes after module B when one of A's `.cmt` files imports a unit
  that B's `.cmt` defines; when two inputs define it, the one whose `.cmt`
  sits in the importer's object directory wins, else all of them do. A
  topological sort with ties broken by path gives the order; source order
  holds inside a file.
- A `.cmt` that cannot be read (written by another compiler version, or
  not a `.cmt`) gives a warning and the path order. An input without a
  `.cmt` has no edges and keeps its place by path. A cycle, which one
  compiler run cannot produce, is an error that names the modules.

Imports are the compiler's resolved dependencies, so a local `open` or a
module name shared by two libraries gives no false edge (an earlier design
read module names from the source and got both wrong). Type-only imports
add edges that change no order a cascade can see.

### Read

For each input file, walk its top-level structure once and dispatch on
the attribute shapes:

```ocaml
[@@@css "..."]            → push rule string
[@@@css.classes [...]]    → push block class entries
[@@@css.bindings [...]]   → fold (longident, class_string) into Index
[@@@css.refs [...]]       → push (longident, location) into per-file refs
[@@@css.config [...]]     → record the file's declared environment and library
_                         → ignore
```

The read pass is the **only** time the aggregator looks at the AST.
Everything downstream operates on plain strings.

### Resolve

For each rule string, scan for `\x00LONGIDENT\x00` sentinel pairs:

- on hit: replace with the binding's class from `Hashtbl.find idx longident`
- on a binding exported with an empty class string (a function or a
  binding with several blocks), or with several classes: report one error
  per reference, at the reference's location
- on miss: report an error using the location stored in the file's
  `[@@@css.refs ...]`, distinguishing **cross-library** (root module
  not found in any binding's longident) from **missing binding**

Errors are accumulated; if any fire, the aggregator prints them all to
stderr in `File "...", line N, characters X-Y:` format (the OCaml
compiler convention, so editors pick them up) and exits 1.

### Check classes

For each `[@@@css.classes ...]` entry, look up its rule text by index
(empty for a marker). When a class was already seen with a different rule
text, report a collision that names both blocks and gives both locations.

The check covers one sheet, the inputs of one `generate` run. Nothing
checks sheets generated separately (one per library) against each other;
see "Several library sheets" below.

### Dedup and write

Resolved rule strings are deduplicated with an order-preserving
`Hashtbl` filter: walk the rules in source-traversal order and keep the
first occurrence of each string. This removes the duplicates produced by
one module compiled twice (a native and a Melange copy): the same module,
scope, binding and content give the same class and the same rule text.
Blocks with the same content in different modules have different classes
and are both kept.

Order preservation is load-bearing: block rules have the same
specificity (one class) unless their selectors add more, so the cascade
tiebreaker is "later in stylesheet wins". The stylesheet is the input
files in the order above, and each file's blocks in source order, so a
module's blocks come after the blocks of the modules it uses, and a
caller's override wins over a utility block it merges with. An earlier
version deduped through
`Set.Make(String)`, which sorted by hash-prefixed rule text and silently
destroyed declaration order (regression test:
`packages/generate/test/source-order.t`).

The deduplicated list is then written to the output channel. Inter-rule
newlines are dropped when every contributing input file declared
`env=production` in its `[@@@css.config ...]` (see the wire protocol
section above); there is no CLI flag for this.

## Blocks

Each `[%css]` block becomes one class and one `[@@@css ...]` item:
`{ display: flex; color: red; }` produces one rule with both
declarations, in source order. A block with nested selectors or
at-rules produces one rule for each, all on the block's class. The
runtime `CSS.make` call carries the class.

Class names are `css-<hash>`, where the hash is seven base36 characters:
four from a murmur2 hash of the module name, then three from a murmur2
hash of the module name, the submodule path, the binding name and the
block's transformed rules (see below). Every class of a module shares the
four-character prefix, which keeps stylesheets and bundles small after
compression. An empty block has a class too, which selectors can
reference. Minting lives in `packages/ppx/src/Hash_class.ml`.

Three characters leave room for two different blocks of one module to get
the same class. Blocks are compared by their hash input, not by their CSS:
the same block pushed twice (a function called twice) keeps its class.
When a different block already holds the class, the later block widens its
own suffix to four, five, then six characters (`Css_file.claim`);
earlier blocks keep their names. Only a clash at six characters is a
compile error, which names both blocks.

"Earlier" must not depend on the build, so the ppx names blocks before any
ppx expands the module. A naming pass (a ppxlib instrumentation registered
`Before`, which runs ahead of every extension rule and every whole-file
pass) expands the module's native view and then its client view
(`Platform_view`: the `Server` or `Client` case of `switch%platform`,
`browser_only` bodies, `[@platform]` items, as server-reason-react's
browser_ppx keeps them), claims every key in that order and keeps only the
names (`Css_file.Naming`). Expansion then takes each block's and each
variable's name from that table, and fails on a key the naming pass did
not see (a `[%css]` written by another ppx). So a `copy_files` twin of a
module (same file name, same text) gets the same names in both builds,
even when a block exists in one build only.
`generate` still checks for collisions across modules, for example two
modules with the same name in one sheet.

Interpolations become custom properties named like classes:
`--<module prefix><suffix>`, the same four characters as the module's
classes, then three base36 characters of a hash of the module, the block's
interpolated declarations with their selectors and at-rules, the
interpolated path, its type, and its position when one declaration reads
the same path twice. So the same path in a block's base, `:hover` and
`@media` rules is one variable, and two blocks of one module with the same
interpolated text share it: `CSS.merge` of the two sets it twice and the
later operand wins. Blocks of different modules never share a variable. When a different
variable of the module already holds the name, the later one widens its
suffix, as a class does. Variables of `[%keyframe]` and `[%styled.global]` are not
named this way: they keep `--<readable path>-<hash>`, hashed from their
kind, module, scope and rendered rules (`Hash_class.scoped_namespace`).

The hash input is the block's rules after the transform, with a placeholder
for the block's own hash: selector references are already resolved (a
cross-module reference as its longident), and the interpolated paths and
types are appended. So two blocks with the same text whose `.$(x)` names
different blocks get different classes.

The environment is a PPX concern, set once per `(pps styled-ppx ...)`
stanza: `--env production` (alias for `--minify`) declares production, so
the aggregator minifies its output; `--env development` (alias for
`--dev`) adds `cx-<binding>` marker classes next to each class. The
classes are the same in both environments. The aggregator learns the
environment from `[@@@css.config ...]` and adjusts its whitespace
accordingly.

Two consequences worth knowing:

1. **`CSS.merge` concatenates classes.** When two merged blocks set the
   same property, the block later in the stylesheet wins; the argument
   order of `CSS.merge` has no effect, unless the two blocks share the
   variable (same module, same interpolated text), where the later
   operand's value wins.
2. **Cross-module `$(M.marker)` resolves to one class.** A function or a
   binding with several blocks has no single class, so a reference to it
   is an error.

## Several library sheets

`generate` writes one sheet per run, and a dune rule usually runs it once
per library, over the library's `.pp.ml` and `.cmt` files. Inside a sheet,
`.cmt` imports order the modules (see "Order"). Between sheets, the order
is the consumer's job: an app that loads several library sheets must load
them in library dependency order, so a library's blocks come after the
blocks of the libraries it uses. dune's library graph gives that order:
`dune describe workspace` lists each library's `requires`. A topological
sort of the libraries a page uses gives its sheet order.

To map a sheet to its libraries, read its first line. When the inputs
carry the `library` key of `[@@@css.config]`, `generate` lists their
distinct names, sorted ASCII, separated by one space:

```css
/* This file is generated by styled-ppx, do not edit manually; libraries: ui ui_native */
```

The names are dune's local library names (the `name` field of the
`library` stanza), not public names. `dune describe workspace
--split-public-names` (dune 3.25 and later) reports the local name in its
`name` field; older versions report the public name there when there is
one, and the local name shows only in `include_dirs` (`.<name>.objs`). A
rule over two libraries (a shared library and its native twin) lists
both. Inputs without a library add nothing; with none, the line has no
`; libraries:` part. A consumer reads this line to map each sheet to its
libraries, then orders the sheets by dune's graph.
Regression test: `packages/generate/test/library-header.t`.

Accepted risk: a block's class holds the module name and not the library,
so modules with the same basename in different libraries can give two
different blocks one class, and nothing checks it across sheets. Putting
the library into the module prefix (dune's `library-name` cookie) is
planned once `copy_files` twins are gone (single-context Melange).

## What this design intentionally avoids

- **Reading typed AST during PPX expansion.** ppxlib runs strictly per
  CU on the untyped Parsetree. Cross-module facts cannot be queried at
  PPX time — they have to flow through emitted attributes that a later
  tool reads.
- **Sidecar files from the PPX.** Everything about CSS lives in the
  post-PPX `.ml`. The only compiled artifact `generate` reads is the
  `.cmt`, for its imports, and only to order modules.
- **Filesystem I/O from the PPX.** PPX never reads peers' artifacts.
  All cross-module information flows through the aggregator.
- **AST traversal in the aggregator.** The aggregator does not pattern-
  match `CSS.make` calls or rebuild module paths from filenames. The
  PPX writes the index directly into `[@@@css.bindings ...]`.
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
- `packages/css-extraction/css_extraction.ml` — shared attribute names,
  sentinel encoding, and sentinel resolution
- `packages/ppx/src/{Css_bindings,Cross_module_refs}.{re,rei}` — the
  per-CU buffers feeding the aggregator
