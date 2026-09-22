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
  ─ atomize, hash, mint class names; mint each named binding's identity class
  ─ resolve same-module $(name) selector interpolations to the referenced
    binding's identity class
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

### `[@@@css.bindings [(longident, identity, class_string); ...]]` — binding exports

One attribute per CU, listing every named `[%css]` binding and
`[%styled.<tag>]` component the CU minted.
The longident is the fully-qualified path users would write to reference
the binding from another module; the identity is the binding's
build-independent `cid-...` class (see "Identity classes" below) — a
`$(binding)` selector reference resolves to this, verbatim; the class
string is the space-separated list of atomized class names the PPX
produced, kept only as a content fingerprint so the aggregator can tell
a legitimate duplicate build from a real identity collision (see
Resolve below).

```ocaml
[@@@css.bindings
  [("M.marker", "cid-1a2b3c4", "");
   ("M.Css.active", "cid-5d6e7f8", "css-tokvmb-active");
   ("M.layout", "cid-9a0b1c2", "css-k008qs-layout css-1tyndxa-layout")]]
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
- `library`: the value of the `library-name` cookie dune passes to every
  ppx run inside a `(library ...)` stanza, read via
  `Ppxlib.Driver.Cookies.add_simple_handler`. Absent when the module isn't
  compiled as part of a library (for example an `(executable ...)`
  stanza) or the cookie wasn't set. The aggregator reads this key to group
  and order rules by owning library; see Order below.

```ocaml
[@@@css.config [("env", "production"); ("library", "my_lib")]]
```

When both apply, `env` comes first, then `library`. Absence of every key
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
two executables (no library name, so no default namespace) whose modules
share a basename and binding name, or a plain 32-bit hash collision.
This is only an error when their `class_string` fingerprints differ: the
same identity with the same atoms is the ordinary "same module compiled
twice" case (a native library and its melange twin sharing a
`--namespace`, vendoring) and is accepted. A real collision names both
input files, both longidents, the shared identity, and the `--namespace`
remedy, and is reported through the same protocol-error path as a
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

The deduplicated list is then written to the output channel. Inter-rule
newlines are dropped when every contributing input file declared
`env=production` in its `[@@@css.config ...]` (see the wire protocol
section above); there is no CLI flag for this.

### Cascade layers (opt-in)

`--layers` (default off, and rejected together with `--order source`)
wraps the deduplicated rule list from above into named CSS cascade
layers, one per library, instead of one flat list. `@property` and
`@keyframes` rules are pulled out ahead of every layer, since they are
global registrations: a `@property` inside a layer would make the
registration itself depend on layer order, and a `@keyframes` name is
looked up by layer order too, so leaving both unlayered avoids surprises.
After the registrations, one `@layer <lib1>, <lib2>, ...;` statement lists
every library in the same dependency order as the default output, and
then each library's remaining rules follow inside their own
`@layer <lib> { ... }` block, still in that order. A layer's name is its
library key with every character outside `[A-Za-z0-9_-]` replaced by `_`
(the directory-fallback case uses the key's last path segment first). Two
different keys can sanitize to the same name; the aggregator warns once
and lets the two `@layer` blocks share that name, which CSS itself
concatenates into a single layer.

Layering rules changes how they interact with hand-written CSS, which is
why the flag defaults to off. An unlayered declaration always beats a
layered one, however low that layer sits, because the cascade only
compares layers when both competing declarations are themselves inside a
layer; a normal, non-`!important` layered rule loses to any unlayered
rule regardless of specificity or source order. `!important` inverts
that: an `!important` declaration in a layer beats an unlayered
`!important` declaration, and among layers the earliest-declared layer
wins for `!important` (the opposite of the normal-declaration order,
where the latest layer wins). A consumer that turns `--layers` on has to
put its own hand-written CSS — resets, palettes, fonts, an inline global
stylesheet — into a layer declared before the generated ones, or that
CSS's plain declarations stop overriding anything the generated,
now-layered rules set.

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
2. **A `$(binding)` selector reference resolves to ONE class: the
   referenced binding's identity** (see below), not a chain of its
   atoms. This holds same-module and cross-module alike. A reference
   means "carries that binding", not "reproduces its exact
   declarations" — a referenced multi-atom binding drops from
   `(0,N,0)` to `(0,1,0)` specificity inside the compound selector (see
   the specificity note below).

## Identity classes

Every named `[%css]` binding and `[%styled.<tag>]` component mints a
second, build-independent class alongside its atoms: `cid-<hash>`
(`Hash_class.identity_class`). `$(binding)` and `&.$(binding)` selector
references resolve to this identity, verbatim, regardless of how many
atoms the binding minted or whether it minted any at all. It is emitted
first among the atoms in the className string (after the `cx-<label>`
dev marker, when present): `cx-<label> cid-<hash> css-<hash> ...`.

**Inputs**, joined with `\0` and murmur2-hashed: the namespace (the
`--namespace` flag when given, else the dune library name from the
`library-name` cookie, else empty — an executable has no library name),
the compilation-unit module name (the source file's basename,
capitalized — never a physical path, so a module compiled twice under
different paths mints the same identity as long as the namespace agrees),
the enclosing submodule path, the binding name (or `[%styled.<tag>]`
module name), and an occurrence index — folded in only when a
`(scope, name)` pair repeats within one compilation unit (e.g. two
functions each with their own `let a = [%css ...]`), so a name seen
exactly once keeps a stable identity independent of whether a later
occurrence ever appears.

**`--namespace <string>`** overrides the library-name default. Two dune
libraries never share a name, so same-named modules and bindings in
different libraries are told apart with no configuration. The flag is
for the one case the default gets wrong: a native library and its
Melange twin built from the same sources via `copy_files` have different
library names, so they pass the same `--namespace` on both
`(pps styled-ppx ...)` stanzas to keep minting the same identities. See
"Identity collision" under Resolve for what happens when identities
still coincide.

**Empty markers.** A named binding with no declarations (`let m = [%css
{||}]`) still mints an identity — its `class_string` is `""` and no
`[@@@css ...]` rule is emitted, since there is nothing to write. This is
independent of `--minify`: an empty binding's identity is never dropped,
which is what makes it possible to resolve `&.$(m)` in every mode (see
`packages/ppx/test/css-support/identity-empty-marker.t`).

**Specificity note.** `.css-x.cid-y` is still a two-class compound
selector — `(0,2,0)` specificity, same as `.css-x.css-a.css-b` before
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
