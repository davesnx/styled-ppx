# Todo

- [x] Inspect parser and css-grammar architecture around lexer, parser, and runtime boundaries.
- [x] Identify the main design problems in `packages/parser/lib/Lexer.re` and the current parser contract.
- [x] Draft the refactor plan toward shared parser/css-grammar infrastructure.
- [x] Create `documents/design.md` and `documents/primitives.md` and reference them from `AGENTS.md`.
- [x] Finish the interview pass and resolve the remaining design branches.
- [x] Implement phase 1 by wiring parser AST values directly into `packages/css-grammar` entrypoints.
- [x] Remove `Rule.parse_string` and move string-to-AST parsing out of `packages/css-grammar/lib/Rule.re`.
- [x] Simplify `packages/css-grammar/lib/Rule.re` by replacing `Data` / `Match` / `Let` layers with a smaller top-level API.

## Review

- Chosen direction so far: keep `packages/parser` as the thin stylesheet/selector parser layer.
- Chosen direction so far: remove the parser/css-grammar string handoff and share the existing parser AST as the boundary.
- Chosen direction so far: preserve the current parser-facing token contract in phase 1, but keep it internal to `packages/parser`.
- Chosen direction so far: target one semantic parse result per declaration/property in the long term.
- Chosen direction so far: keep selector AST ownership in `packages/parser` for the medium term.
- Chosen direction so far: keep declaration values and at-rule preludes as `component_value_list` on the parser AST.
- Chosen direction so far: `packages/css-grammar` should become the source of truth for typed property values, with PPX/runtime code translating typed values into runtime expressions.
- Added living architecture docs in `documents/design.md` and `documents/primitives.md`.
- Chosen direction so far: phase-1 typed at-rule prelude support should cover `@media` and `@container` first.
- Implemented phase 1 AST entrypoints in `Rule.re`/`Parser.ml` and rewired validation, interpolation extraction, and typed prelude parsing to use parser AST directly.
- Removed `Rule.parse_string`; string inputs are now converted to parser AST in `Parser.ml` / generated parse helpers before entering `Rule.re`.
- Simplified `Rule.re` around top-level `ok` / `bind` / `map` / `all` helpers and a smaller `Pattern` module; `Data`, `Match`, and `Let` are gone.
- Added `packages/parser/lib/Component_value_classifier.re` so parser-owned helpers classify delimiter kinds, function names, reserved keywords, and dimension units instead of open-coding string checks in `css-grammar`.

## Border Interpolation Fix

- [x] Reproduce the `border-top` cx2 interpolation regression.
- [x] Trace the generated extraction path through `[%spec_module]` alias properties.
- [x] Fix `packages/css-grammar/ppx/Generate.re` so property references are treated as interpolation-capable.
- [x] Run targeted `css-grammar` and cx2 regression tests.

### Review

- Root cause: `spec_may_contain_interpolation` returned `false` for `Property_type`, so alias properties like `<'border'>` generated empty `extract_interpolations` functions.
- Result: `border-top` partial interpolations fell back to the property runtime module (`Css_types.Border`) instead of delegating to the nested `color` position.
- Fix: treat `Property_type` nodes as interpolation-capable so generated extractors delegate through the registry and preserve nested type context.

## Duplicate cx2 interpolation vars

- [x] Inspect the `flex` cx2 fixture and confirm how duplicate interpolation names are collapsed.
- [x] Update cx2 variable naming so repeated interpolation names are preserved with numbered CSS vars.
- [x] Add regression coverage for duplicate interpolation names.
- [x] Run targeted `css-grammar` and `cx2-support` verification.

### Review

- Root cause: `Css_file.transform_declaration` matched interpolation metadata by variable name only, so repeated `$(X.value)` slots reused one CSS custom property and one inferred runtime module.
- Fix: consume interpolation metadata in occurrence order and suffix duplicate CSS custom property names as `_1`, `_2`, etc. so each slot keeps its own inferred type.
- Coverage: added a `Css_grammar.Parser.get_interpolation_types` regression for duplicate `flex` interpolation names and updated the cx2 cram expectation.
- Verification: `make test-css-grammar` and `make test-cx2-support` both pass.

## Step 1 - Handwritten parser front-end

- [x] Replace Menhir entrypoints in `packages/parser` with a handwritten parser stream.
- [x] Shrink the parser-facing lexer contract to raw tokenization/interpolation/location duties and move parse decisions into handwritten parser code.
- [x] Remove `packages/parser/lib/Lexer_context.re` from the parser front-end contract by moving whitespace/context/nesting decisions into parser code.
- [x] Keep `packages/parser/lib/Ast.re` and public parser entrypoints stable enough for downstream packages during the migration.
- [x] Preserve external behavior by keeping parser, css-grammar, PPX, and runtime suites green.

### Review

- Target design for step 1: hybrid recursive-descent parser with explicit cursor/lookahead helpers and specialized helpers for CSS-specific corners.
- Testing gate for step 1: treat `make test-css-support` as mandatory alongside parser-facing verification.
- Implemented `packages/parser/lib/Parser.ml` as the new handwritten front-end and removed Menhir from `packages/parser/lib/dune`.
- Reworked `packages/parser/lib/driver.re` to call handwritten parser entrypoints directly and keep parser errors on the existing public result type.
- Simplified `packages/parser/lib/Lexer.re` so `Lexer.from_string` now exposes raw lexer output directly and the parser owns the remaining disambiguation logic.
- Preserved selector nesting, descendant combinators, implicit nested-block termination, keyframes, and at-rules across `Render_test`, parser tests, and PPX native tests.
- Removed `packages/parser/lib/Lexer_context.re` and the old lexer-context-driven classification path.
- Verification: `make test-parser && make test-css-grammar && make test-ppx-native && make test-ppx-snapshot-reason && make test-css-support && make test-runtime && make test-string-interpolation`.

## Parser cleanup - remove `last_buffer` and unclassified-token compatibility

- [x] Remove `Driver.last_buffer` and stop depending on global source slices during PPX/runtime lowering.
- [x] Remove `Lexer_context.unclassified_token` and the buffered unclassified-token machinery from the lexer layer.
- [x] Rework parser-facing tokenization so the handwritten parser consumes direct raw lexer output and does all remaining disambiguation itself.
- [x] Trim compatibility APIs and tests that still depend on context-aware lexer classification.
- [x] Keep parser, css-grammar, PPX, css-support, runtime, and string-interpolation suites green.

### Review

- User correction: the parser owns the control flow now, so transitional layers like `last_buffer` and unclassified-token buffering should be removed rather than preserved.
- Removed `Driver.last_buffer` and threaded the original source string explicitly through `Css_to_runtime` call sites that still need formatting-sensitive substrings.
- Deleted `packages/parser/lib/Lexer_context.re` and collapsed the lexer down to direct raw-token emission with no buffered unclassified-token state machine.
- Kept `Lexer.from_string` as the single lexer entrypoint, but it now returns raw lexer tokens rather than context-aware parser tokens.
- Simplified lexer tests to focus on actual lexical behavior and left selector/declaration disambiguation coverage to parser, render, and PPX suites.
- Verification: `make test-parser && make test-css-grammar && make test-ppx-native && make test-ppx-snapshot-reason && make test-css-support && make test-runtime && make test-string-interpolation`.

## css-grammar AST-native refactor

- [x] Rewrite `packages/css-grammar/lib/Rule.re` so `rule('a)` consumes parser AST component values directly rather than token lists.
- [x] Port `packages/css-grammar/lib/Css_value_types.re`, `Modifier.re`, and `Combinators.re` to the AST-native rule substrate.
- [x] Update `packages/css-grammar/ppx/Generate.re` so generated `[%spec_module]` modules emit AST-native rules and wrappers instead of calling `Rule.parse_string`.
- [x] Adjust `packages/css-grammar/lib/Parser.ml` registry glue and tests to the new `spec_module` API.
- [x] Re-run parser, css-grammar, PPX, css-support, runtime, and string-interpolation suites.

### Review

- User direction: the ambitious version is the right one here - `Rule.re` itself should stop parsing token lists and should operate on `component_value_list`/AST cursors directly.
- Replaced the token-list substrate in `packages/css-grammar/lib/Rule.re` with an AST-native rule substrate over `Styled_ppx_css_parser.Ast.component_value_list`.
- Reworked `packages/css-grammar/lib/Css_value_types.re` to match parser AST nodes directly and use parser-owned helpers from `Component_value_classifier`.
- Updated `packages/css-grammar/ppx/Generate.re` so generated `[%spec_module]` modules expose AST-native `rule` / `parse_component_values`, keep `parse` as a wrapper outside `Rule.re`, and special-case parenthesized/bracketed blocks in generated grammar code.
- Updated `packages/css-grammar/lib/Parser.ml` registry glue so module packing, validation, interpolation extraction, and public parse wrappers all run through AST-native rules.
- Reworked rule/modifier tests to the AST-native behavior and kept the wider parser, PPX, css-support, runtime, and string-interpolation suites green.
- Correction: this finished the AST-native boundary, but `packages/css-grammar/lib/Rule.re` still contains parser-combinator control flow over `component_value_list`. Removing parsing responsibilities from `Rule.re` itself is still open work.

## Rule.re AST-only follow-up

- [x] Audit which `packages/parser/lib/Ast.re` component-value constructors are still too stringly for `Rule.re` matching, starting with delimiters, dimension units, and hash kind.
- [x] Enrich parser AST nodes so `Rule.re` can keep the `(ast => data, ast)` shape while matching semantic constructors instead of reparsing strings for delimiters, dimensions, and hash kind.
- [x] Update parser construction/helpers/rendering/tests to preserve the richer AST information end-to-end for delimiters, dimensions, and hash kind.
- [x] Port `packages/css-grammar/lib/Rule.re`, `Css_value_types.re`, and generated grammar code to the richer AST constructors for those slices.
- [x] Preserve lexer-level `FUNCTION` vs `NTH_FUNCTION` semantics on parser value AST so component-value functions stop collapsing to just a string name.
- [x] Replace selector combinator strings with typed AST constructors across parser, selector transforms, and renderers.
- [ ] Identify and implement the next remaining value-AST enrichment after delimiters, dimensions, and hash kind.
- [x] Re-run `make test-css-grammar`, `make test-css-support`, and any affected parser/PPX/runtime suites once that follow-up lands.
- [x] Split the giant css-grammar registry file into `Types`, `Definitions`, `Registry`, `Values`, and qualified `Properties/*` section modules.

### Review

- User clarification: `rule('a) = ast => (data('a), ast)` is still the intended shape; the next refactor is about richer AST constructors, not removing AST cursor consumption.
- Landed slices: `Ast.Delim(string)` became `Ast.Delim(delimiter)`, `Ast.Dimension((float, string))` became a richer `Ast.dimension` with parser-classified `dimension_kind`, and `Ast.Hash(string)` now preserves lexer hash kind.
- Landed slices: component-value functions now preserve `FUNCTION` vs `NTH_FUNCTION` as `Ast.function_kind`, and selector combinators now use typed `Ast.selector_combinator` constructors instead of raw strings.
- Registry split: `packages/css-grammar/lib/Parser.ml` is now a compatibility facade over `packages/css-grammar/lib/Types.ml`, `packages/css-grammar/lib/Definitions.ml`, and `packages/css-grammar/lib/Registry.ml`, with uncategorized/base registrations in `packages/css-grammar/lib/Values.ml` and sectioned registration lists in `packages/css-grammar/lib/Properties/Layout.ml`, `packages/css-grammar/lib/Properties/Font.ml`, `packages/css-grammar/lib/Properties/Text.ml`, `packages/css-grammar/lib/Properties/Color.ml`, `packages/css-grammar/lib/Properties/Animation.ml`, and `packages/css-grammar/lib/Properties/Backgrounds.ml`.
- Build layout: `packages/css-grammar/lib/dune` now uses `include_subdirs qualified` so the new section modules are imported as `Properties.*` while `Definitions.ml` remains the only file preprocessed by `css_grammar_ppx`.
- Verification so far: `make test-parser`, `make test-css-grammar`, `make test-ppx-native`, and `opam exec -- dune build -j1 @test-css-support` pass after the delimiter, dimension, hash-kind, function-kind, selector-combinator, and registry/section split refactors.
- Remaining work: there are still some string-carrying AST areas, but the highest-value lexer/parser semantics in component values and selector combinators are now preserved directly on the AST.
- Target state: parser AST should carry enough semantic structure that `Rule.re` and `Css_value_types.re` mostly pattern-match AST constructors directly, with parser-owned construction/rendering preserving the needed raw details.

## Step 2 - css-grammar on `component_value_list`

- [x] Add a `component_value_list` -> grammar input bridge so css-grammar can parse parser AST values without going through rendered strings.
- [x] Add css-grammar entrypoints for property validation, interpolation extraction, and at-rule prelude parsing over `component_value_list`.
- [x] Rewire PPX typechecking, cx2 extraction, and runtime lowering to pass parser AST values directly into css-grammar.
- [x] Stop using declaration value source slicing as the semantic input to runtime lowering.
- [x] Preserve pipeline behavior with parser, css-grammar, PPX, runtime, and css-support verification.

### Review

- Target design for step 2: remove the parser/css-grammar string handoff from the active PPX/runtime pipeline while keeping string wrappers only where compatibility still needs them.
- `Rule.re` now consumes `Styled_ppx_css_parser.Ast.component_value_list` directly; the earlier AST-to-token bridge has been removed.
- Extended `packages/css-grammar/lib/Parser.ml` with AST-based property validation, interpolation extraction, generic parsing, and at-rule prelude parsing while preserving string wrappers for compatibility.
- Rewired `packages/ppx/src/ppx.re`, `packages/ppx/src/Css_file.re`, `packages/ppx/src/Css_to_runtime.re`, and `packages/ppx/src/Property_to_runtime.re` so the active pipeline no longer renders declaration values back into strings before css-grammar typechecking and typed runtime lowering.
- Kept raw source slices only for unsafe fallback rendering and formatting-sensitive output, not for semantic parsing.
- Added css-grammar regression coverage for AST-based property validation, interpolation extraction, and at-rule prelude parsing.
- Verification: `make test-parser && make test-css-grammar && make test-ppx-native && make test-ppx-snapshot-reason && make test-css-support && make test-runtime && make test-string-interpolation`.

## Property category split

- [x] Inventory `Property_*` definitions and current registry entries, including shared-module aliases.
- [x] Generate one `packages/css-grammar/lib/Properties/*.ml` module for each requested CSS property category and move the matching `Property_*` definitions out of `Definitions.ml`.
- [x] Keep the parser surface stable by re-exporting moved property modules/types from `Parser.ml`.
- [x] Move remaining property-like entries omitted from the requested list into explicit fallback category modules: `Media`, `Descriptors`, and `Legacy`.
- [x] Rebuild `Values.ml` so it only carries non-property registry entries, and rebuild `Registry.ml` around the new category module list.
- [x] Update `packages/css-grammar/lib/dune` for the moved `[%spec_module]` definitions.
- [x] Spawn one subagent per requested category to validate the generated category slices.
- [x] Run the affected parser/css-grammar/ppx suites and fix any breakage until they pass.

### Review

- The requested 143-category list does not cover all existing `Property` registry entries. Current gaps include media features/descriptors (`media-*`, `media-type`), CSS property descriptors (`syntax`, `inherits`, `initial-value`), and several legacy properties (`behavior`, `ime-mode`, `nav-*`).
- To keep the refactor complete and preserve behavior, the move will create the 143 requested category modules plus `Properties.Media`, `Properties.Descriptors`, and `Properties.Legacy` for the omitted registry entries.
- Two registered property names currently share existing modules: `box-orient`/`-webkit-box-orient` and `box-shadow`/`-webkit-box-shadow`. The generated split will keep a single canonical module definition and reference it from both registry buckets.
- Completed split: `Definitions.ml` now retains only shared helpers/value definitions, and all 678 moved `Property_*` modules live under `packages/css-grammar/lib/Properties/`.
- Compatibility choice: `Parser.ml` still includes each property category module because downstream code still imports `Css_grammar.Parser.property_*` definitions directly; `Registry.ml` only registers entries and does not re-export those definitions.
- Validation choice: requested category files now contain only literal category members. Omitted/internal/descriptor-style entries were moved into `Media`, `Descriptors`, and `Legacy` instead of staying in the closest semantic bucket.
- Follow-up: `word-wrap` no longer lives in the generic `Legacy` bucket; it now has its own `Properties.WordWrap` module because it is still a first-class exposed property in the parser/runtime surface.
- Follow-up: the obvious non-legacy leftovers were split out of `Legacy.ml` into dedicated modules: `Properties.BlockOverflow`, `Properties.HyphenateLimit`, `Properties.InitialLetterAlign`, `Properties.MarkerProperty`, and `Properties.MasonryAutoFlow`.
- Follow-up: the user requested semantic grouping for the remaining obvious leftovers, so `Legacy.ml` was further reduced by moving `layout-grid*` into `Properties.Layout`, `voice-*` into `Properties.Voice`, `rest*` into `Properties.Rest`, `pause*` into `Properties.Pause`, `nav-*` into `Properties.Nav`, and glyph orientation properties into `Properties.Glyph`.
- Follow-up: all remaining MDN CSS properties were added through four parallel implementation slices. `Scroll.ml` is now the single home for both `scroll-*` and `scrollbar-*`, the `*Experimental.ml` filenames were renamed to OcamelCase property names, and wildcard custom-property support (`--*`) now exists in the registry rather than only in the PPX fast path.
- Follow-up: remove `Definitions.ml` and `Parser.ml` entirely. Move `Definitions` helper prelude into `Support.ml`, move all shared `%spec_module` rules into `Shared.ml`, split registry lists into `Values.ml`/`Functions.ml`/`Media.ml`, and turn `Css_grammar.re` into the public façade that re-exports the full grammar surface directly.
- Result: `Definitions.ml` and `Parser.ml` are gone. `Support.ml` now owns the helper prelude, `Shared.ml` owns the shared `%spec_module` rules, `Values.ml`/`Functions.ml`/`Media.ml` are pure registry files, and `Css_grammar.re` is the flattened public façade. In-repo callers were renamed from `Css_grammar.Parser` to `Css_grammar`.
- Follow-up: deduped `Shared.ml` against property ownership. All `Function_*` definitions moved into `Functions.ml`; duplicate shared rules for `x`, `y`, `top`, `right`, `bottom`, `left`, `mask-image`, `mask-position`, `fill-rule`, `border-radius`, `size`, and `syntax` were removed or rewritten away. Dedicated `Properties/Size.ml` and `Properties/Syntax.ml` now own those properties. The only remaining value/property name overlaps are intentional: `color` and `position`.
- Verification: `make test-parser`, `make test-css-grammar`, `make test-ppx-native`, `make test-runtime`, `opam exec -- dune build @test-ppx-snapshot-reason`, and `env DUNE_BUILD_JOBS=1 opam exec -- dune build -j1 @test-css-support` pass after the refactor.
- Validation: one explore subagent was launched for each of the 143 requested categories; the few category leaks they found (`backdrop-blur`, `clip`, `container-name-computed`, descriptor-style `page`, etc.) were moved into fallback buckets and revalidated.

## css-grammar AST-only surface cleanup

- [x] Remove string parsing helpers and string-based public entrypoints from `packages/css-grammar`.
- [x] Collapse `RULE`/registry packing onto a single AST-native `parse` interface over `component_value_list`.
- [x] Regenerate and hand-fix property modules so they expose only AST-native parse entrypoints.
- [x] Update PPX callers and css-grammar tests to use the AST-only names.
- [x] Re-run parser/css-grammar/PPX verification and fix breakages.

### Review

- User direction: inside `packages/css-grammar`, there should be only one parsing path, and tests should carry the compatibility burden instead of preserving string wrappers.
- Landed shape: `packages/css-grammar` now exposes AST-native `parse`, `check_property`, `get_interpolation_types`, and `parse_at_rule_prelude` directly over `component_value_list`; the old string wrappers were deleted instead of preserved under `*_component_values` aliases.
- Generator/runtime alignment: generated `[%spec_module]` modules now emit only AST-native `parse`, handwritten permissive property modules were updated to the same contract, and PPX callers were renamed to the short AST-only entrypoints.
- Test strategy: `css-grammar` tests now build `component_value_list` inputs with local parser-driver helpers, so the library keeps one semantic parse path while the tests still cover string-originating scenarios.
- Verification: `make test-css-grammar`, `make test-parser`, `make test-ppx-native`, `make test-cx2-support`, `make test-css-support`, and `make test-runtime` all pass.

## css-grammar API vocabulary cleanup

- [x] Rename the generic `css-grammar` entrypoint from `parse` to `type_check`.
- [x] Rename property/interpolation entrypoints to `validate_property` and `infer_interpolation_types`.
- [x] Rename the `Rule` runner and generated `RULE` module contract to match the semantic vocabulary.
- [x] Update PPX callers and tests to the renamed API.
- [x] Re-run the affected verification suites and record any remaining environment blockers.

### Review

- User correction: `packages/css-grammar` is not parsing source text, so `parse` was misleading; the API should describe semantic checking over parser AST values.
- Landed shape: `Rule.run`, `Css_grammar.type_check`, `Css_grammar.validate_property`, and `Css_grammar.infer_interpolation_types` are now the canonical public names. The old `parse_at_rule_prelude` wrapper was removed in favor of `type_check` with the appropriate at-rule grammar.
- Generator/runtime alignment: the `RULE` contract now exposes `type_check` plus `infer_interpolation_types*`, handwritten permissive property modules match that contract, and PPX/runtime callers were renamed accordingly.
- Verification: `make test-css-grammar`, `make test-parser`, `make test-ppx-native`, and `make test-runtime` pass after the rename.
- Verification gap: `@test-cx2-support` repeatedly failed in this environment with `Thread.create: Resource temporarily unavailable`, `vfork(): Resource temporarily unavailable`, and linker `fork` failures during cram/PPX subprocess startup, even when rerun with `-j1`. `@test-css-support` also exceeded the available execution window when forced serially.

## Primitive runtime reuse batch

- [x] Retarget exact-match grammar modules to existing `Css_types` primitives (`Color`, `Length`, `LineWidth`, `Cascading`, `Angle`).
- [x] Add runtime declarations for logical size, logical spacing, logical inset, logical border, and scrollbar leaf color properties that can render through existing primitive printers.
- [x] Replace `Property_to_runtime.re` unsafe fallbacks for the first logical-property batch with typed lowerings that reuse existing renderers.
- [x] Add shorthand/lists support for `scroll-margin`, `scroll-padding`, and `inset` using declaration helpers instead of new runtime type modules.
- [x] Run targeted `css-support`, `cx2-support`, and runtime verification for the touched property groups.

### Review

- Focus for this batch: fix the cases that can reuse current runtime primitives or current runtime value modules without refactoring the package layout.
- Guardrail for this batch: only retarget grammar `runtime_module_path` when the whole property value is an exact match for the reused runtime type; list/shorthand properties can still get typed `%css` lowering through declaration helpers without inventing a new `Css_types` module.
- Landed grammar retargets: exact-match missing modules now point at existing `Css_types` primitives for `all`, logical single border colors/widths, column-rule color, glyph angles, `backdrop-blur`, `line-height-step`, `offset-distance`, `shape-margin`, scrollbar leaf colors, selected WebKit color/width properties, and `x`/`y`.
- Landed runtime lowering: `%css` now emits typed calls for logical sizes, logical margin/padding families, logical inset families, several logical border leaves/shorthands, `column-count`, `column-rule-color`, `column-rule-width`, scrollbar leaf colors, `caret-color`, `clear`, `resize`, `offset-distance`, `scroll-margin`, `scroll-padding`, `shape-margin`, and `-webkit-tap-highlight-color`.
- Verification: `opam exec -- dune build -j1`, `opam exec -- dune runtest -j1 packages/runtime/test`, `opam exec -- dune runtest -j1 packages/css-grammar/test`, and focused `css-support`/`cx2-support` cram runs for `logical-propertiesand-values.t`, `scroll-snap-module.t`, `multi-column-layout-module.t`, and `random.t` all pass.
- Intentionally left out of this batch: value spaces that still need true property-specific runtime modules or broader API decisions, including multi-value interpolation typing for wrappers like `border-block-color`, `border-inline-color`, `column-rule-width`, and the not-yet-modeled families such as `view-timeline-inset`.

## Existing Runtime Batch

- [x] Wire enum-backed existing runtime modules in `Property_to_runtime.re` for `direction`, `float`, `isolation`, `scroll-behavior`, `overflow-anchor`, and `table-layout`.
- [x] Add small runtime declaration helpers for `appearance`, `break-before`, `break-after`, `break-inside`, `mix-blend-mode`, and `background-blend-mode`.
- [x] Implement typed lowering for `appearance`, `break-*`, `counter-*`, `list-style-position`, `list-style-type`, `mix-blend-mode`, and `background-blend-mode`.
- [x] Update affected `%css` cram expectations in `basic-user-interface-module`, `fragmentation-module`, `lists-module`, `compositingand-blending`, `writing-modes`, and `random`.
- [x] Run targeted build and cram verification for the new batch.

### Review

- Batch goal: keep reducing `CSS.unsafe` coverage using runtime modules that already exist in `Css_types.ml`, with only small declaration additions where necessary.
- Guardrail: keep partial support acceptable when the current runtime type is narrower than the grammar. For example, `appearance` can type `auto` / `none` in this batch and still leave rarer widget-specific values unsupported until the runtime type grows.
- Landed lowering: `%css` now emits typed runtime calls for `direction`, `float`, `isolation`, `scroll-behavior`, `overflow-anchor`, `table-layout`, `appearance` (`auto` / `none`), `break-before`, `break-after`, `break-inside`, `counter-increment`, `counter-reset`, `counter-set`, `list-style-type`, `list-style-position`, `mix-blend-mode`, and `background-blend-mode`.
- Landed runtime surface: added declaration helpers for `appearance`, `breakBefore`, `breakAfter`, `breakInside`, `mixBlendMode`, `backgroundBlendMode`, and `backgroundBlendModes` in `Declarations.ml`.
- Verification: `opam exec -- dune build -j1`, focused `%css`/`%cx2` cram runs for `basic-user-interface-module`, `compositingand-blending`, `fragmentation-module`, `lists-module`, `logical-propertiesand-values`, `random`, `scroll-behavior-module`, and `writing-modes`, plus `opam exec -- dune runtest -j1 packages/runtime/test`, all pass.

## Border Image Batch

- [x] Implement typed lowering for `border-image-slice`, `border-image-width`, `border-image-outset`, and `border-image-repeat` using existing runtime declarations.
- [x] Update `%css` `backgrounds-and-borders-module` expectations for the new typed output.
- [x] Verify `%css`/`%cx2` `backgrounds-and-borders-module` and refresh the unsupported runtime audit document.

### Review

- Batch goal: convert the `border-image-*` leaf properties that already have `Css_types` and `Declarations` support, while leaving the full `border-image` shorthand for a later pass.
- Landed lowering: `%css` now emits typed runtime calls for `borderImageSlice1..4`, `borderImageWidth[1..4]`, `borderImageOutset[1..4]`, and `borderImageRepeat[1..2]` through the existing runtime surface.
- Verification: `opam exec -- dune build -j1`, `opam exec -- dune runtest -j1 packages/ppx/test/css-support/backgrounds-and-borders-module.t packages/ppx/test/cx2-support/backgrounds-and-borders-module.t`, and a regenerated `documents/unsupported-runtime-audit.md` all completed successfully.

## Scroll Runtime Batch

- [x] Add declaration helpers for `overscroll-behavior*` and `scroll-snap-*` properties that already have runtime value types.
- [x] Implement typed lowering for `overscroll-behavior`, `overscroll-behavior-x`, `overscroll-behavior-y`, `overscroll-behavior-inline`, `overscroll-behavior-block`, `scroll-snap-align`, `scroll-snap-stop`, and `scroll-snap-type`.
- [x] Update `%css` snapshot expectations for `overscroll-behavior-module` and `scroll-snap-module`.
- [x] Refresh the unsupported runtime audit after the batch.

### Review

- Batch goal: remove the remaining checked-in scroll-related `CSS.unsafe` cases that already had runtime value modules, without starting the larger timeline/anchor families.
- Landed runtime surface: added `overscrollBehavior2`, `overscrollBehaviorX`, `overscrollBehaviorY`, `overscrollBehaviorInline`, `overscrollBehaviorBlock`, `scrollSnapAlign`, `scrollSnapAlign2`, `scrollSnapStop`, and `scrollSnapType` to `Declarations.ml`.
- Landed lowering: `%css` now emits typed calls for `overscroll-behavior*`, `scroll-snap-align`, `scroll-snap-stop`, and `scroll-snap-type` using existing `OverscrollBehavior` and `ScrollSnap*` runtime types.
- Verification: `opam exec -- dune build -j1`, `opam exec -- dune runtest -j1 packages/ppx/test/css-support/overscroll-behavior-module.t packages/ppx/test/css-support/scroll-snap-module.t packages/ppx/test/cx2-support/overscroll-behavior-module.t packages/ppx/test/cx2-support/scroll-snap-module.t`, and a regenerated `documents/unsupported-runtime-audit.md` all completed successfully.

## Writing Modes Runtime Batch

- [x] Add declaration helpers for `unicode-bidi`, `writing-mode`, `text-orientation`, and `text-combine-upright`.
- [x] Implement typed lowering for those four properties against the current concrete runtime modules in `Css_types.ml`.
- [x] Update `%css` `writing-modes.t` expectations to the new typed output.
- [x] Refresh the unsupported runtime audit after the batch.

### Review

- Batch goal: convert the remaining direct keyword/string `writing-modes` cases from `CSS.unsafe` to typed runtime calls.
- Landed lowering: `%css` now emits `CSS.unicodeBidi(...)`, `CSS.writingMode(...)`, `CSS.textOrientation(...)`, and `CSS.textCombineUpright(...)` instead of raw unsafe declarations for the checked-in `writing-modes` cases.
- Verification: `opam exec -- dune build -j1`, an isolated `dune describe pp` probe under `packages/tmp_writing_modes_probe` matching `packages/ppx/test/css-support/writing-modes.t/input.re`, and a regenerated `documents/unsupported-runtime-audit.md` completed successfully.
- Verification caveat: the normal `dune runtest` path for this fixture is currently blocked by warning-as-error failures in a large concurrent diff to `packages/runtime/native/shared/Css_types.ml` that was already present in the worktree and not modified here.

## Overflow Clamp Batch

- [x] Add runtime declaration helpers for `line-clamp` and `max-lines`.
- [x] Implement typed lowering for `line-clamp` and `max-lines` in `Property_to_runtime.re`.
- [x] Update `%css` `overflow-module` expectations and refresh the unsupported runtime audit.

### Review

- Batch goal: remove the remaining direct `CSS.unsafe` calls for the simple overflow leaf properties already covered by `%css`/`%cx2` fixtures.
- Landed lowering: `%css` now emits `CSS.lineClamp(`none|`int(_))` and `CSS.maxLines(`none|`int(_))` instead of unsafe raw declarations.
- Verification: `opam exec -- dune build -j1`, `opam exec -- dune runtest -j1 packages/ppx/test/css-support/overflow-module.t packages/ppx/test/cx2-support/overflow-module.t`, and a regenerated `documents/unsupported-runtime-audit.md` all completed successfully.

## Simple Leaf Coverage Batch

- [x] Add runtime declarations and typed lowering for `empty-cells`, `field-sizing`, `interpolate-size`, and the simple `hyphenate-*` properties.
- [x] Add fixture coverage in `text-module` and a new `simple-runtime-leaves` cram fixture for `%css` and `%cx2`.
- [x] Re-run targeted text/simple-leaf verification and refresh the unsupported runtime audit.

### Review

- Batch goal: convert the remaining exact-match uncovered leaves into checked-in coverage instead of leaving them represented only in the audit probe.
- Landed lowering: `%css` now emits typed calls for `emptyCells`, `fieldSizing`, `interpolateSize`, `hyphenateCharacter`, `hyphenateLimitChars`, `hyphenateLimitLines`, and `hyphenateLimitZone`.
- Verification: `opam exec -- dune build -j1`, `opam exec -- dune runtest -j1 packages/ppx/test/css-support/text-module.t packages/ppx/test/cx2-support/text-module.t packages/ppx/test/css-support/simple-runtime-leaves.t packages/ppx/test/cx2-support/simple-runtime-leaves.t`, and a regenerated `documents/unsupported-runtime-audit.md` all completed successfully.

## Fragmentation/Text Unsafe Reduction Batch

- [x] Implement typed lowering for `box-decoration-break`, `orphans`, `widows`, `hanging-punctuation`, `overflow-wrap: break-word`, `word-wrap: break-word`, and logical `caption-side` values.
- [x] Update the affected `%css` snapshots in `fragmentation-module`, `text-module`, and `logical-propertiesand-values`.
- [x] Re-run targeted verification and refresh the unsupported runtime audit.

### Review

- Batch goal: reduce checked-in `CSS.unsafe` usage in the already-covered `%css` fixtures without expanding runtime architecture.
- Landed lowering: `%css` now emits typed calls for `boxDecorationBreak`, `orphans`, `widows`, `hangingPunctuation`, `overflowWrap(`breakWord)`, `wordWrap(`breakWord)`, and `captionSide` logical values.
- Verification: `opam exec -- dune build -j1`, focused `%css`/`%cx2` runs for `fragmentation-module`, `text-module`, and `logical-propertiesand-values`, plus a regenerated `documents/unsupported-runtime-audit.md`, all completed successfully.

## SVG Leaf Batch

- [x] Implement typed lowering for `fill-rule`, `fill-opacity`, `stroke-width`, `stroke-linecap`, `stroke-linejoin`, and `stroke-miterlimit` through `CSS.SVG.*`.
- [x] Add `%css` / `%cx2` coverage for those leaves in `filland-stroke-module`.
- [x] Re-run targeted verification and refresh the unsupported runtime audit.

### Review

- Batch goal: wire the straightforward SVG leaf properties that already had runtime value support but no `%css` lowering.
- Landed lowering: `%css` now emits typed `CSS.SVG.fillRule`, `CSS.SVG.fillOpacity`, `CSS.SVG.strokeWidth`, `CSS.SVG.strokeLinecap`, `CSS.SVG.strokeLinejoin`, and `CSS.SVG.strokeMiterlimit` calls.
- Verification: `opam exec -- dune build -j1`, `opam exec -- dune runtest -j1 packages/ppx/test/css-support/filland-stroke-module.t packages/ppx/test/cx2-support/filland-stroke-module.t`, and a regenerated `documents/unsupported-runtime-audit.md` all completed successfully.

## Initial Letter And Resolution Batch

- [x] Add runtime declarations and typed lowering for `initial-letter`, `initial-letter-align`, and `image-resolution`.
- [x] Extend `simple-runtime-leaves` `%css` / `%cx2` coverage with initial-letter and image-resolution cases.
- [x] Re-run focused verification and refresh the unsupported runtime audit.

### Review

- Batch goal: convert the next runtime-backed uncovered leaves into checked-in `%css` / `%cx2` coverage without widening the runtime module surface.
- Landed lowering: `%css` now emits typed `CSS.initialLetter`, `CSS.initialLetterAlign`, and `CSS.imageResolution` calls. The pair form of `initial-letter` and the combined forms of `image-resolution` use the existing `value(...)` branch on the current runtime types.
- Verification: `opam exec -- dune build -j1`, `opam exec -- dune runtest -j1 packages/ppx/test/css-support/simple-runtime-leaves.t packages/ppx/test/cx2-support/simple-runtime-leaves.t`, and a regenerated `documents/unsupported-runtime-audit.md` all completed successfully.

## Text Transform Batch

- [x] Extend the `TextTransform` runtime type with `full-width` and `full-size-kana`.
- [x] Replace `%css` unsafe lowering for those `text-transform` values with typed output.
- [x] Re-run focused verification and refresh the unsupported runtime audit.

### Review

- Batch goal: remove the remaining checked-in `CSS.unsafe` cases for `text-transform` without changing the parser grammar.
- Landed lowering: `%css` now emits `CSS.textTransform(`fullWidth)` and `CSS.textTransform(`fullSizeKana)` instead of unsafe raw declarations.
- Verification: `opam exec -- dune build -j1`, `opam exec -- dune runtest -j1 packages/ppx/test/css-support/text-module.t packages/ppx/test/cx2-support/text-module.t`, and a regenerated `documents/unsupported-runtime-audit.md` all completed successfully.

## Multi Column Leaf Batch

- [x] Add runtime declarations and typed lowering for `column-fill`, `column-rule-style`, and `column-span`.
- [x] Update `%css` `multi-column-layout-module` expectations to the new typed output.
- [x] Re-run focused verification and refresh the unsupported runtime audit.

### Review

- Batch goal: remove the next cheap checked-in `CSS.unsafe` leaves from `multi-column-layout-module` while leaving the larger `columns` and `column-rule` shorthands for a later pass.
- Landed lowering: `%css` now emits `CSS.columnFill(...)`, `CSS.columnRuleStyle(...)`, and `CSS.columnSpan(...)` instead of unsafe raw declarations.
- Verification: `opam exec -- dune build -j1`, `opam exec -- dune runtest -j1 packages/ppx/test/css-support/multi-column-layout-module.t packages/ppx/test/cx2-support/multi-column-layout-module.t`, and a regenerated `documents/unsupported-runtime-audit.md` all completed successfully.

## Color Adjustment Batch

- [x] Add typed `%css` lowering for `color-adjust`, `forced-color-adjust`, and `color-scheme`.
- [x] Update the `%css` `color-adjustments-module` snapshot to the new typed output.
- [x] Re-run focused verification and refresh the unsupported runtime audit.

### Review

- Batch goal: remove a full checked-in `CSS.unsafe` cluster from `color-adjustments-module` using the existing runtime value modules.
- Landed lowering: `%css` now emits `CSS.colorAdjust(...)`, `CSS.forcedColorAdjust(...)`, and `CSS.colorScheme(...)`. `color-scheme` uses the existing `value(...)` branch for multi-token/custom-ident cases.
- Verification: `opam exec -- dune build -j1`, `opam exec -- dune runtest -j1 packages/ppx/test/css-support/color-adjustments-module.t packages/ppx/test/cx2-support/color-adjustments-module.t`, and a regenerated `documents/unsupported-runtime-audit.md` all completed successfully.

## Clip And Masonry Batch

- [x] Add typed `%css` lowering for `clip-rule` and `masonry-auto-flow`.
- [x] Update the `%css` `masking-module` and `grid-layout-module` snapshots to the new typed output.
- [x] Re-run focused verification and refresh the unsupported runtime audit.

### Review

- Batch goal: convert the next direct checked-in enum/value clusters without changing the larger masking or grid shorthand architecture.
- Landed lowering: `%css` now emits `CSS.clipRule(...)` and `CSS.masonryAutoFlow(...)`; the mixed `masonry-auto-flow` forms use the existing `value(...)` runtime branch.
- Verification: `opam exec -- dune build -j1`, `opam exec -- dune runtest -j1 packages/ppx/test/css-support/masking-module.t packages/ppx/test/cx2-support/masking-module.t packages/ppx/test/css-support/grid-layout-module.t packages/ppx/test/cx2-support/grid-layout-module.t`, and a regenerated `documents/unsupported-runtime-audit.md` all completed successfully.

## Text Indent Batch

- [x] Switch `text-indent` declarations to the existing `TextIndent` runtime type and add typed `%css` lowering for the modifier forms.
- [x] Update the `%css` `text-module` snapshot to the new typed output.
- [x] Re-run focused verification and refresh the unsupported runtime audit.

### Review

- Batch goal: remove the checked-in `CSS.unsafe` cases for the `text-indent` modifier combinations without introducing another helper API.
- Landed lowering: `%css` now emits `CSS.textIndent(...)` with `TextIndent.value(...)` for the `hanging` / `each-line` combinations, while preserving the direct length/percentage path for the simple form.
- Verification: `opam exec -- dune build -j1`, `opam exec -- dune runtest -j1 packages/ppx/test/css-support/text-module.t packages/ppx/test/cx2-support/text-module.t`, and a regenerated `documents/unsupported-runtime-audit.md` all completed successfully.

## Parser lexing/parsing simplification

- [x] Add characterization tests for declaration-vs-nested-rule ambiguity and interpolation edge cases.
- [x] Tighten `packages/parser/lib/Parser.ml` to consume strict tokens after lexing validation instead of carrying `result` tokens plus dead `assert false` branches.
- [x] Collapse duplicated parser list/block helpers and repeated selector-list parsing into shared helpers.
- [x] Replace the duplicated nested-rule/property lookahead scanners with shared block scanners and reduce the pseudo-bias logic to one helper in the ambiguity path.
- [x] Split `packages/parser/lib/Lexer.re` interpolation scanning into smaller helpers while preserving behavior and locations.
- [x] Deduplicate `packages/parser/lib/driver.re` exception mapping helpers.
- [x] Re-run parser and adjacent verification suites after the refactor.

### Review

- Goal for this pass: simplify the handwritten parser front-end without changing the public parser surface or moving syntax meaning back into the lexer.
- Guardrail: add characterization coverage first for the ambiguous cases because the current nesting heuristics are easy to regress silently.
- Added parser regressions for missing-semicolon nested blocks and selector heads with pseudo syntax, plus lexer regressions for interpolation delimiters inside strings/chars.
- `Parser.ml` now validates lexer output once at stream construction and then runs on strict tokens only; the old parser-local `Error _ -> assert false` branches are gone.
- Replaced repeated selector-list parsing and braced-rule block parsing with shared helpers, and deduped `driver.re` through one `wrap_parse` helper.
- The nested-block ambiguity path now shares one block scanner for selector/at-rule lookahead. The remaining pseudo-bias heuristic is isolated to one helper instead of being spread across multiple scanners.
- `Lexer.re` interpolation scanning is split into focused helpers for comments, quoted strings, slash handling, paren handling, and result/error bookkeeping while keeping the existing token/loc contract.
- Verification: `make test-parser`, `make test-css-grammar`, `make test-ppx-native`, and `opam exec -- dune runtest -j1 packages/runtime/test`.
- Verification note: `make test-runtime` itself exceeded the command timeout in this environment, but the underlying serial runtime suite completed without errors.

## Remove Unsafe aliases

- [x] Spawn 10 subagents to map remaining `= Unsafe` aliases to concrete runtime modules or a safer permissive fallback.
- [x] Apply remappings in `packages/runtime/native/shared/Css_types.ml` and eliminate `Unsafe` references from the file.
- [x] Rebuild native/melange/rescript runtime targets.

### Review

- Replaced `module Unsafe` with `module PermissiveValue` and removed all `Unsafe` references from `packages/runtime/native/shared/Css_types.ml`.
- Applied concrete remaps where subagents found compatible existing modules (for example `AnimationDelayEnd -> AnimationDelay`, `BorderBlock -> Border`, `OverscrollBehaviorX -> OverscrollBehavior`, `WordWrap -> OverflowWrap`).
- Kept unresolved cases on `PermissiveValue` as explicit follow-up backlog rather than `Unsafe`.
- Verification: `opam exec -- dune build -j1 packages/runtime/native`, `opam exec -- dune build -j1 packages/runtime/melange`, and `opam exec -- dune build -j1 packages/runtime/rescript` all pass.

## Remove permissive fallback module

- [x] Replace every `module X = PermissiveValue` alias with a concrete `module X = struct ... end` definition.
- [x] Remove `module PermissiveValue` entirely from `Css_types.ml`.
- [x] Keep concrete remaps to existing runtime modules where semantics already match.
- [x] Re-run runtime builds across native, melange, and rescript.

### Review

- Generated concrete modules for the remaining 201 fallback aliases using css-grammar specs as input for keyword constructors plus typed atoms (`Length`, `Time`, `Angle`, `Color`, `Url`, etc.) and module-local `toString` printers.
- `packages/runtime/native/shared/Css_types.ml` now has zero `Unsafe` and zero `PermissiveValue` references.
- Kept previously remapped aliases to existing modules (for example `WordWrap = OverflowWrap`) and only expanded modules that still depended on the fallback alias.
- Verification: `opam exec -- dune build -j1 packages/runtime/native`, `opam exec -- dune build -j1 packages/runtime/melange`, and `opam exec -- dune build -j1 packages/runtime/rescript`.

## MDN syntax annotations

- [x] Find all `Css_types` modules where `type t` includes `` `value of string ``.
- [x] Add an inline `(* MDN syntax: ... *)` comment above `type t` in each such module.
- [x] Verify runtime builds still pass.

### Review

- Added MDN syntax comments in 83 modules within `packages/runtime/native/shared/Css_types.ml`, directly above each `type t` that still carries a `` `value of string `` branch.
- Specs are sourced from the existing css-grammar `%spec_module` definitions (which mirror MDN grammar strings), including alias-linked vendor/runtime modules.
- Verification: `opam exec -- dune build -j1 packages/runtime/native`, `opam exec -- dune build -j1 packages/runtime/melange`, and `opam exec -- dune build -j1 packages/runtime/rescript`.

## Runtime Css_types coverage batch

- [x] Recompute the property/runtime coverage matrix with accurate top-level module detection.
- [x] Add fallback runtime modules for every `Css_types.*` reference used by property grammars and missing from `packages/runtime/native/shared/Css_types.ml`.
- [x] Validate native, melange, and rescript runtime builds after the batch update.

### Review

- Added `RawCssValue` plus 352 alias modules in `packages/runtime/native/shared/Css_types.ml` so every property grammar `Css_types.*` target now exists in runtime.
- The fallback shape is intentionally permissive (`raw` string + `Var` + `Cascading`) to unblock interpolation typing while preserving existing raw-string lowering paths.
- Coverage check now reports zero missing property runtime modules.
- Verification: `opam exec -- dune build -j1 packages/runtime/native`, `opam exec -- dune build -j1 packages/runtime/melange`, and `opam exec -- dune build -j1 packages/runtime/rescript`.
