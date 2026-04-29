# Static CSS Extraction in styled-ppx

## Status

- Implementation reference for the static-extraction pipeline (`[%cx2]`,
  `[%styled.global2]`, `[%keyframe2]`)
- Companion to `documents/design.md` (high-level CSS pipeline) and
  `documents/cross-module-selector-interpolation.md` (the cross-module
  resolution layer)

## What "extraction" means here

Three extension points produce CSS at compile time rather than emitting
runtime calls that mint CSS strings on first use:

| Extension              | What it extracts                                                       |
| ---------------------- | ---------------------------------------------------------------------- |
| `[%cx2]`               | Class-scoped declaration lists, one atomized rule per declaration       |
| `[%styled.global2]`    | Top-level global rules and at-rules (no class scoping)                 |
| `[%keyframe2]`         | `@keyframes` blocks, named by content hash                             |

For all three, the PPX renders the resulting CSS to a string at compile
time and parks it in a top-level floating attribute on the post-PPX `.ml`
file. A separate post-build tool (`styled-ppx.generate`, the aggregator)
walks every emitted `.ml` in a dune library, collects the attributes, and
writes a single deduplicated stylesheet.

The non-extracting siblings (`[%cx]`, `[%styled.global]`, `[%keyframe]`)
emit runtime `CSS.*` calls instead, and are not covered by this document.

## End-to-end pipeline

```
.re/.ml source
  │
  ▼
PPX expansion (per compilation unit)
  ─ parse [%cx2 "..."] / [%styled.global2 "..."] / [%keyframe2 "..."]
  ─ atomize, hash, mint class names
  ─ resolve same-module $(name) selector interpolations
  ─ buffer rendered rules; record cross-module refs as sentinels
  │
  ▼
PPX impl transformer (end of CU)
  ─ drain Css_file.Buffer    → emit [@@@css "..."]            (one per rule)
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
  ─ harvest [@@@css ...], [@@@css.bindings ...], [@@@css.refs ...]
  ─ resolve NUL-delimited cross-module sentinels against the bindings index
  ─ deduplicate rules, emit final stylesheet
  │
  ▼
styles.css
```

## Wire protocol: three attributes

Everything the aggregator needs to know is conveyed by three top-level
floating attributes that the PPX appends to the post-PPX file. They are
the entire interface between PPX expansion and the aggregator — the
aggregator never re-parses `CSS.make` calls or infers facts from filenames.

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
resolve time. See
`documents/cross-module-selector-interpolation.md` for details.

### `[@@@css.bindings [(longident, class_string); ...]]` — binding exports

One attribute per CU, listing every named `[%cx2]` binding the CU minted.
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

Anonymous bindings (`let _ = [%cx2 ...]`) are not exported because they
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

## PPX-side state

Three module-level mutable buffers, all per-CU, all drained by the impl
transformer at end-of-CU:

| Buffer                              | Source                         | Sink                              |
| ----------------------------------- | ------------------------------ | --------------------------------- |
| `Css_file.Buffer`                   | atomized rules during expansion | `[@@@css "..."]` attributes       |
| `Css_bindings` (new module)         | each named `[%cx2]` expansion  | `[@@@css.bindings ...]` attribute |
| `Cross_module_refs` (new module)    | each unresolved `$(M.x)` in selector position | `[@@@css.refs ...]` attribute + synthetic `let _ = M.x` |

`Css_file.Class_registry` is a fourth piece of state, distinct from the
three above: it serves only **same-module** `$(name)` selector
interpolation. It is keyed by `(file, name)` and never escapes the CU.
Cross-module references skip it entirely and go through
`Cross_module_refs` instead.

### `Css_file.Buffer`

A list ref of `(className, cssText)` pairs. Atomization produces one
entry per declaration (each declaration becomes its own class). Cleared
at end-of-CU when `Css_file.get()` returns the rules to the impl
transformer.

`[%styled.global2]` writes through `Buffer.add_global_rule`; the global
rules are kept separate so they always sort before per-class rules in
the final stylesheet (see `Buffer.get_rules`).

### `Css_bindings`

Per-CU buffer of `(longident, class_string)` exports. The `[%cx2]`
handler computes the longident from
`Code_path.main_module_name` + `Code_path.submodule_path` + the
enclosing value name, then calls `Css_bindings.record`. Last-write-wins
on duplicates within a CU (matches `Class_registry` shadowing
semantics).

### `Cross_module_refs`

Per-CU buffer populated by `Css_file.resolve_selector_class_ref` when
the requested `$(name)` contains a `.` (i.e. a longident, not a bare
name). Records `(longident, location)` and produces a NUL-delimited
sentinel string that gets baked into the rule the PPX is currently
rendering. The sentinel survives CSS rendering verbatim and is resolved
later by the aggregator.

## Aggregator responsibilities

Implemented in `packages/generate/generate.ml`. Takes a list of `.ml` /
`.pp.ml` paths, produces a stylesheet on stdout or `-o <file>`.

```
parse args → harvest_each_file → resolve_sentinels → dedup → write
```

### Harvest

For each input file, walk its top-level structure once and dispatch on
the four attributes:

```ocaml
[@@@css "..."]            → push rule string
[@@@css.bindings [...]]   → fold (longident, class_string) into Index
[@@@css.refs [...]]       → push (longident, location) into per-file refs
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
stderr in `File "..." line N, characters X-Y:` format and exits 1.

### Dedup and write

Resolved rule strings are inserted into a `Set.Make(String)`, which
removes duplicates produced by the same rule appearing in multiple files
(common for shared helpers). The set is then written to the output
channel with optional `--minify` (no inter-rule newlines).

## Atomization

Every declaration produced by `[%cx2]` becomes its own atom:
`{ display: flex; color: red; }` produces two rules, two class names,
two `[@@@css ...]` attributes. The runtime `CSS.make` call carries the
space-separated concatenation of those class names, so consumers apply
all atoms by setting one `className` attribute.

Class names follow `css-<murmur2 hash of CSS>-<binding label>` format
(or `css-<hash>` under `--minify`). The binding label is purely
cosmetic — atom hashes are deduplication-safe even when labels differ.

Two consequences worth knowing:

1. **One `[%cx2]` binding maps to N class names.** This is what the
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
  tool reads. See
  `documents/cross-module-selector-interpolation.md` §"Why this shape
  was chosen over a richer template format".
- **Sidecar files.** No `.cmt` / `.cmti` / per-binding metadata files.
  Everything the aggregator needs lives in the post-PPX `.ml`.
- **Filesystem I/O from the PPX.** PPX never reads peers' artifacts.
  All cross-module information flows through the aggregator.
- **AST traversal in the aggregator.** The aggregator does not pattern-
  match `CSS.make` calls or rebuild module paths from filenames. The
  PPX writes the index directly into `[@@@css.bindings ...]`.
- **Runtime resolution via `var(--xyz)` indirection.** Selector
  interpolation is resolved statically; this is a load-bearing choice
  that distinguishes `[%cx2]` from `[%cx]` and is what makes the
  aggregator necessary in the first place.

## See also

- `documents/design.md` — overall CSS pipeline (parsing, validation,
  generation)
- `documents/cross-module-selector-interpolation.md` — the
  cross-module resolution layer in depth (sentinels, error formatting,
  dune dep tracking, edge cases)
- `documents/current-design.md` — descriptive snapshot of the parser /
  css-grammar layers feeding extraction
- `packages/generate/generate.ml` — the aggregator implementation
- `packages/ppx/src/{Css_bindings,Cross_module_refs}.{re,rei}` — the
  per-CU buffers feeding the aggregator
