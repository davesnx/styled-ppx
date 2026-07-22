# Adding CSS properties

Contributor/agent guide for burning down the missing-property list tracked in
[issue #588](https://github.com/davesnx/styled-ppx/issues/588) (umbrella:
missing-property burn-down, 185 standard properties).

The work queue is the generated coverage report:
`packages/css-grammar/data/coverage.md`. Its "Missing properties (185)"
section lists every gap with its spec id and raw value-definition syntax.
The report is produced by `make css-oracle`
(`packages/css-grammar/bin/registry_dump.ml` +
`scripts/css-oracle/report.mjs` + vendored
`packages/css-grammar/data/webref-css.json`). CI fails when it is stale
(`make css-oracle-check`). Background: `documents/css-coverage-oracle.md`.

**Work by spec module, not by property.** The report tags each property with
its spec id (`css-borders-4`, `css-rhythm-1`, `css-overflow-4`, ...). Pick
one spec's worth of properties per PR so shared value types (e.g. a new
`<repetition>` or `<content-list>`) land once and get reused.

## Architecture in one paragraph

A property is a `[%spec_module "<dialect spec string>", (module
Css_types.Witness)]` in `packages/css-grammar/lib/Properties/*.ml`. The ppx
(`packages/css-grammar/ppx/Generate.re`) parses the spec string with
`packages/css-spec-parser` and generates a parser rule whose value type is a
structural polymorphic variant. `packages/css-grammar/lib/Types.ml`
(hand-maintained) declares the named `property_*` type the generated rule is
annotated with. The witness module argument is captured *by path only*
(`runtime_module_path`): it names the module in
`packages/runtime/native/shared/Css_types.ml` whose `t`/`toString` give
interpolated OCaml values (`$(foo)`) their type. The generated code calls
`CSS.Types.<Witness>.toString` (see `packages/ppx/src/Property_to_types.re`).
Registration happens via per-file `entries` lists aggregated in
`packages/css-grammar/lib/Registry.ml`.

## Recipe

1. **Pick a chunk** from the "Missing properties" section of
   `packages/css-grammar/data/coverage.md`: all properties from one spec id.
   Announce it on issue #588 (comment or sub-issue) so work doesn't collide.

2. **Translate the spec syntax to the styled-ppx dialect.** The report's
   syntax strings come straight from the specs and are NOT paste-ready.
   Divergences:

   | Raw CSS value definition | styled-ppx dialect |
   |---|---|
   | bare keywords: `auto \| none` | quoted: `'auto' \| 'none'` (house style; also disambiguates single-char delimiters, which quote as `'/'`, `','`) |
   | `<length>` | `<extended-length>`, which adds `calc()`/`min()`/`max()` and interpolation acceptance (see `extended_length` in `packages/css-grammar/lib/Types.ml`) |
   | `<percentage>` (as a value) | `<extended-percentage>`; `<length-percentage>` exists and expands to both extended forms |
   | `<angle>` | `<extended-angle>` |
   | no interpolation concept | add `\| <interpolation>` as a top-level alternative when whole-value `$(x)` should be typed by the witness |
   | range restrictions: `<integer [1,∞]>` | dropped: `<integer>` (no existing spec module keeps ranges) |
   | data types resolve per spec | `<foo>` resolves by name against the registry: shared values live in `packages/css-grammar/lib/Values.ml` / `Shared.ml` (`Value "foo"` entries); `<'prop-name'>` references another property's grammar |

   Real before/after examples (webref syntax → committed spec string):

   - `tab-size`: `<number [0,∞]> | <length [0,∞]>` →
     `"<number> | <extended-length>"`
     (`packages/css-grammar/lib/Properties/TabSize.ml`)
   - `font-kerning`: `auto | normal | none` →
     `"'auto' | 'normal' | 'none'"`
     (`packages/css-grammar/lib/Properties/Font.ml`)
   - `z-index`: `auto | <integer> | inherit` →
     `"'auto' | <integer> | <interpolation>"`. `inherit` is dropped
     (css-wide keywords are handled generically), interpolation added
     (`packages/css-grammar/lib/Properties/ZIndex.ml`)

3. **Add or extend parser types in `packages/css-grammar/lib/Types.ml`.**
   Declare `and property_<snake_name> = ...` matching the structure the ppx
   generates: keywords → capitalized variant tags (`avoid-page` →
   `` `Avoid_page ``), `A | B` → variant alternatives (mixed alternatives get
   payloads, e.g. `` `Extended_length of extended_length ``), `A || B` →
   `` `Or of _ option * _ option ``, `?` → `option`, `#`/`+`/`*` → `list`,
   juxtaposition → tuples. `<integer>` → `int`, `<number>` → `float`,
   `<string>`/`<custom-ident>` → `string`, `<interpolation>` →
   `string list`. Tip: write the spec module first with the annotation
   `let property_x : property_x Rule.rule = Property_x.rule`; the compile
   error shows the exact generated structural type. Copy it into `Types.ml`.
   New shared value types (`<foo>` used by several properties) go in
   `Types.ml` + a `[%spec_module]` in `Values.ml`/`Shared.ml` + a
   `Value "foo"` registry entry.

4. **Add the runtime witness in
   `packages/runtime/native/shared/Css_types.ml`.** A witness is a module
   with `type t` (user-facing polymorphic variant, usually including
   `Var.t`/`Cascading.t`) and `val toString : t -> string`. Alias when an
   existing witness fits (`module Widows = Order` is the committed pattern).
   Then append the module to the audit list in
   `packages/runtime/test/Css_types_witness_audit.ml` (the header claims a
   generator script; that script is gone, so edit the file by hand). No other
   runtime copies exist: `packages/runtime/melange/dune` pulls the shared
   files in via `(copy_files# ... ../native/shared/**)`, and there is no
   rescript runtime directory, so one edit serves every target.

5. **Add the `[%spec_module]` and registration.** Put the module in the
   matching `packages/css-grammar/lib/Properties/<Spec>.ml` (create a new
   file for a new spec area). Pattern, from
   `packages/css-grammar/lib/Properties/Widows.ml`:

   ```ocaml
   open Types
   open Support
   module Property_widows = [%spec_module "<integer>", (module Css_types.Widows)]

   let property_widows : property_widows Rule.rule = Property_widows.rule

   let entries : (kind * packed_rule) list =
     [ Property "widows", pack_module (module Property_widows) ]
   ```

   Every property in the file goes into the file's `entries` list. A new
   file must be added to the concat in
   `packages/css-grammar/lib/Registry.ml` (`Properties.<Spec>.entries`) or
   it silently never registers and the coverage report won't move.

6. **Add tests.** Property support tests are cram tests in
   `packages/ppx/test/css-support/<spec>-module.t/` (see
   `fragmentation-module.t/` for the shape): `input.re` holds one
   `[%css {|prop: value|}];` line per accepted form, `run.t` writes a local
   `dune-project`/`dune`, runs `dune build`, and snapshots
   `dune describe pp ./input.re`. Cover each alternative in the grammar and
   at least one interpolation case if the spec accepts one. Regenerate the
   snapshot with `make test-css-support-promote` (or
   `_opam/bin/dune build @test-css-support --auto-promote`). If you added a
   shared value type, also cover it in `packages/css-grammar/test`
   (`make test-css-grammar`).

7. **Regenerate the coverage report**: `make css-oracle`, then commit the
   `packages/css-grammar/data/coverage.md` diff with your change. The
   missing count in the summary table must decrease by exactly the number
   of properties you added. The same run regenerates the website support
   tables and the spec-conformance cram test
   (`packages/ppx/test/css-support/spec-conformance.t`, see
   `documents/css-coverage-oracle.md`): your new property moves from the
   expect-error file to the compiles file, so re-run `make test-css-support`
   after regenerating and commit those diffs too.

8. **Run the full suite**: `make test`. Don't stop at the first `[ERROR]`;
   read the whole output (`documents/testing.md`).

## Gotchas

- **Spec strings are not paste-ready.** Translate per the table above.
  Auto-generating specs/witnesses from webref was evaluated and rejected
  (issue #588); `Types.ml` and `Css_types.ml` are hand-maintained on
  purpose. Don't build a generator; don't commit generated blobs into them.
- **Witness modules are referenced by name, not checked structurally at the
  `[%spec_module]` site.** A typo in `(module Css_types.Foo)` only surfaces
  when interpolation code is generated (`CSS.Types.Foo.toString`). The
  witness-audit test and an interpolation test case catch this. Write both.
- **Snapshot/hash churn.** Class names in cram output (`css-h7q94c`) are
  murmur2 hashes of the rendered CSS. If you touch the renderer or value
  printing, hashes shift across *unrelated* snapshots. Audit promotions by
  change-class: new-property lines are expected; hash-only diffs on existing
  lines mean you changed rendering and need to justify it.
- **CI gates coverage staleness.** Any registry change without regenerated
  oracle artifacts (`coverage.md`, the website support tables, the
  spec-conformance cram test) fails `make css-oracle-check`.
- **Use the local switch's dune** (`_opam/bin/dune`, or `make` targets which
  wrap `opam exec -- dune`); another dune may hold the build lock.
- **`Registry.ml` registration is easy to forget** for new `Properties/*.ml`
  files; the property parses in unit tests but stays "missing" in the
  report and unusable from `[%css]`.
- **Legacy aliases** (the report's separate 47-item list) and functions have
  the same recipe but different registry kinds (`Property` with the alias
  name / `Function` entries in `packages/css-grammar/lib/Functions.ml`).

## Definition of done (per PR)

- [ ] One spec module's chunk of properties added, each with `[%spec_module]`,
      `Types.ml` type, `Css_types.ml` witness (or alias), witness-audit
      entry, and `entries`/`Registry.ml` registration
- [ ] css-support cram test covers every grammar alternative plus
      interpolation where applicable
- [ ] `make css-oracle` run; regenerated `coverage.md` committed; missing
      count decreased accordingly
- [ ] `make test` green; snapshot promotions audited (no unexplained hash
      churn)
- [ ] PR references umbrella issue #588
