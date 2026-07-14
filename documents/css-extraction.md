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
  ─ atomize, hash, mint class names
  ─ resolve same-module $(name) selector interpolations
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
  ─ harvest [@@@css ...], [@@@css.bindings ...], [@@@css.refs ...], [@@@css.config ...]
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
[@@@css ".css-tokvmb-marker{color:red;}"]
[@@@css ".css-1ru12dh-button:hover{opacity:0.8;}"]
[@@@css "@media (min-width:768px){.css-fmb91l-card{padding:2rem;}}"]
[@@@css "@keyframes keyframe-jw9oix{from{opacity:0;}to{opacity:1;}}"]
```

The string may contain NUL-delimited cross-module sentinels
(`\x00LONGIDENT\x00`) when the PPX could not resolve a `$(M.binding)`
selector reference at PPX time. The aggregator substitutes those at
resolve time (see "Resolve" below; the sentinel constants live in
`packages/css-extraction/css_extraction.ml`).

### `[@@@css.bindings [(longident, class_string); ...]]` — binding exports

One attribute per CU, listing every named `[%css]` binding and
`[%styled.<tag>]` component the CU minted.
The longident is the fully-qualified path users would write to reference
the binding from another module; the class string is the
space-separated list of atomized class names the PPX produced.

```ocaml
[@@@css.bindings
  [("M.marker", "css-0-marker");
   ("M.Css.active", "css-tokvmb-active");
   ("M.layout", "css-k008qs-layout css-1tyndxa-layout")]]
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

Emitted when the PPX runs with production settings (`--minify` or
`--env production`) and the CU contributes extraction items. Carries
PPX-side settings the aggregator must honor, as string key/value pairs.
The only key today is `env`:

```ocaml
[@@@css.config [("env", "production")]]
```

Absence means development — the attribute is not emitted in dev builds,
so dev output stays clean. Unknown keys are ignored by the aggregator
(forward compatibility).

The aggregator minifies its output (drops inter-rule newlines) only when
**every** contributing input file — every file with harvested rules or an
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

Declaration-value interpolation in `[%styled.global]` is lowered to CSS
custom properties (`var(--<prefix>-<hash>)` in the extracted rule, values
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
`.pp.ml` paths, produces a stylesheet on stdout or `-o <file>`.

```
parse args → harvest_each_file → resolve_sentinels → dedup → write
```

### Harvest

For each input file, walk its top-level structure once and dispatch on
the five attribute shapes:

```ocaml
[@@@css "..."]            → push rule string
[@@@css.bindings [...]]   → fold (longident, class_string) into Index
[@@@css.refs [...]]       → push (longident, location) into per-file refs
[@@@css.config [...]]     → record the file's declared environment
_                         → ignore
```

The harvest pass is the **only** time the aggregator looks at the AST.
Everything downstream operates on plain strings.

### Resolve

For each rule string, scan for `\x00LONGIDENT\x00` sentinel pairs:

- on hit: replace with `Hashtbl.find idx longident`, converting the
  space-separated class string to a dot-chain (`"a b c"` → `"a.b.c"`)
  so it slots into selector chains correctly
- on miss: report an error using the location stored in the file's
  `[@@@css.refs ...]`, distinguishing **cross-library** (root module
  not found in any binding's longident) from **missing binding**

Errors are accumulated; if any fire, the aggregator prints them all to
stderr in `File "...", line N, characters X-Y:` format (the OCaml
compiler convention, so editors pick them up) and exits 1.

### Dedup and write

Resolved rule strings are deduplicated with an order-preserving
`Hashtbl` filter: walk the rules in source-traversal order and keep the
first occurrence of each string. This removes duplicates produced by the
same rule appearing in multiple files (common for shared helpers).

Order preservation is load-bearing: every atomized rule has the same
specificity (one class, no qualifiers), so the cascade tiebreaker is
"later in stylesheet wins". A longhand override written after a
shorthand (`margin: 10px; margin-top: 20px`) must stay after it in the
emitted stylesheet. An earlier version deduped through
`Set.Make(String)`, which sorted by hash-prefixed rule text and silently
destroyed declaration order (regression test:
`packages/generate/test/source-order.t`).

The deduplicated list is then written to the output channel. Inter-rule
newlines are dropped when every contributing input file declared
`env=production` in its `[@@@css.config ...]` (see the wire protocol
section above); there is no CLI flag for this.

## Atomization

Every declaration produced by `[%css]` becomes its own atom:
`{ display: flex; color: red; }` produces two rules, two class names,
two `[@@@css ...]` attributes. The runtime `CSS.make` call carries the
space-separated concatenation of those class names, so consumers apply
all atoms by setting one `className` attribute.

Class names follow `css-<murmur2 hash of CSS>-<binding label>` format
(or bare `css-<hash>` when the PPX driver runs with production
settings). The binding label is purely cosmetic — atom hashes are
deduplication-safe even when labels differ. Minting lives in
`packages/ppx/src/Hash_class.ml`.

The environment is a PPX concern, set once per `(pps styled-ppx ...)`
stanza: `--env production` (alias for `--minify`) drops label suffixes
and minifies rule bodies; `--env development` (alias for `--dev`) keeps
readable labels and adds `cx-<binding>` marker classes. Labels are baked
into class names at PPX time — in both the compiled `className` and the
extracted `[@@@css ...]` payload — so no downstream tool could change
them without desyncing the two. The aggregator learns the environment
from `[@@@css.config ...]` and adjusts its whitespace accordingly.

Two consequences worth knowing:

1. **One `[%css]` binding maps to N class names.** This is what the
   space-separated `class_string` in `[@@@css.bindings ...]` captures.
2. **Cross-module `$(M.marker)` resolves to a chained compound** (e.g.
   `.cssA.cssB`) not a single class. The aggregator does the
   space-to-dot conversion so the resulting selector requires *all*
   atoms of `M.marker` to be present on the element, matching the
   semantics of using `M.marker` as a className locally.

## What this design intentionally avoids

- **Reading typed AST during PPX expansion.** ppxlib runs strictly per
  CU on the untyped Parsetree. Cross-module facts cannot be queried at
  PPX time — they have to flow through emitted attributes that a later
  tool reads.
- **Sidecar files.** No `.cmt` / `.cmti` / per-binding metadata files.
  Everything the aggregator needs lives in the post-PPX `.ml`.
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
