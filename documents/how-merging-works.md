# How merging works

This page is for people writing styles with `styled-ppx`, not for
maintainers of the ppx. See `documents/css-extraction.md` for the
implementation.

## The promise

`CSS.merge(a, b)` combines two `styles` values. For any property both
sides set, **`b`'s declaration wins** — the right argument overrides the
left, the same rule you'd expect from an object spread (`{ ...a, ...b }`),
except in the cases listed under "Known limits".

```reason
let base = [%css "color: red; padding: 8px;"];
let override = [%css "color: blue;"];

<div styles={CSS.merge(base, override)} />;
/* color: blue (override wins); padding: 8px (base's, untouched) */
```

Argument order is what decides, not which one was declared first in your
source, and not which module compiles first. `CSS.merge(a, b)` and
`CSS.merge(b, a)` do not do the same thing.

## How it decides

Every extracted declaration becomes its own class (an "atom"). Each atom's
class name carries a key: which selector/at-rule context it's under (base,
`:hover`, `@media (...)`, ...), which CSS property family it belongs to
(`margin`, `padding`, `color`, ...), and which of that family's longhands
it sets. `merge(a, b)` drops a class of `a` when a class of `b` has the
**same context**, the **same property family**, and covers **every
longhand** the `a` class sets. Nothing else changes: `CSS.styles` still
carries both class name lists and both custom-property values.

**Same property, dropped:**

```reason
let content = [%css "height: auto;"];
let collapsed = [%css "height: 0;"];

CSS.merge(content, collapsed);
/* only height: 0 applies - content's atom is dropped */
```

(`packages/runtime/test/test_merge_key.ml`'s `faq_repro`)

**A longhand, then a shorthand that covers it — dropped:**

```reason
let narrow = [%css "margin-top: 0;"];
let wide = [%css "margin: 10px;"];

CSS.merge(narrow, wide);
/* only margin: 10px applies - it sets every side margin-top could, so it drops it */
```

(`longhand_then_shorthand_drops_longhand`, same file)

**A shorthand, then a lone longhand — both kept:**

```reason
let wide = [%css "margin: 10px;"];
let narrow = [%css "margin-top: 0;"];

CSS.merge(wide, narrow);
/* both classes stay: a single side (margin-top) can never cover the whole
   shorthand's other three sides, so dropping the shorthand would silently
   lose them. Which one wins the TOP edge then depends on sheet order - see
   "Sheet order" below (shorthands sort before their longhands, so
   margin-top: 0 wins here too). */
```

(`shorthand_then_longhand_keeps_both`, same file — this is the accepted
limit "a longhand can't drop an earlier shorthand", not a bug)

**`!important` vs. a plain declaration — both kept:**

```reason
let plain = [%css "color: red;"];
let important = [%css "color: blue !important;"];

CSS.merge(plain, important);
/* both classes stay: !important is part of the key, so a plain declaration
   and its !important twin are never the same slot. The browser's cascade
   decides between them - !important always wins over a plain declaration,
   whichever order you pass them to merge. */
```

(`mismatched_importance_never_merges`, same file)

**Never dropped, on either side:** an interpolation bundle (`_in_...`,
minted when two or more of a block's declarations interpolate the SAME
`$(name)` — typically one value reused across `base`/`:hover`/`@media`
variants, so they share one custom property), an identity class
(`_id_...`, what a `$(binding)` selector reference resolves to), a
`label:<binding>` dev marker, and any class this pipeline didn't mint (a
hand-written class, a third-party class passed through `className`).
`merge` only ever inspects `_a_`-prefixed atoms; it leaves everything
else exactly as it found it.

```reason
let card = accent => [%css "border-color: $(accent); &:hover { border-color: $(accent); }"];
/* one _in_ bundle: base and :hover both interpolate the same $(accent) */

CSS.merge(card("gray"), [%css "border-color: green;"]);
/* both classes stay - the plain override can't see the border-color
   declaration hiding inside the bundle, so it can't drop just that one.
   Which border-color applies is then decided by specificity and sheet
   order, not by merge (see "Known limits") */
```

`packages/runtime/test/test_merge_key.ml`'s `two_declaration_bundle_still_exempt`
proves the mechanism directly against a real `_in_` class.

## Sheet order

Inside one generated stylesheet, rules are grouped, in this fixed order:

1. **Globals** (`[%styled.global]` rules — `html { ... }`, `* { ... }`, an
   author's own selector).
2. **Base atoms** (a `[%css]` declaration's own, unconditional context).
3. **Conditional atoms** (wrapped in `@media`/`@supports`/`@container`, or
   carrying a pseudo-class/pseudo-element directly, like `:hover`).

Inside each group: a parent-to-child rule (`.wrapper * { ... }`,
`.list li { ... }`) is emitted before a same-element rule, and a
shorthand is emitted before its own longhands. Two rules of equal
specificity fall back to this position, so a genuine tie always resolves
the way you'd expect — a component's own class beats an ancestor's blind
`* { ... }` reach even though both are `(0,1,0)`
(`packages/generate/test/descendant-tier.t`), and a shorthand's rule
lands before a lone longhand that overrides just one of its sides
(`packages/generate/test/tiers-shorthand-sort.t`).

**Inside the conditional group, a fixed order between conditions decides
a remaining tie** (two conditional atoms, equal specificity, same
parent-to-child shape, same shorthand depth): at-rule kind first
(`@supports` before `@media` before `@container` - this project's own
choice of what to check first, not StyleX's; only the pseudo-class/
pseudo-element NUMBERS below are StyleX's own table), then a fixed
pseudo-class/pseudo-element priority (`:hover` before `:focus-within`
before `:focus` before `:focus-visible` before `:active`; any
pseudo-element outranks any pseudo-class), then `@media` width — a query
with a lower bound (a plain `min-width`, or a `min-width`/`max-width`
RANGE) sorts ascending by that lower bound; a query naming ONLY a
`max-width` sorts descending by that bound, AFTER every query with a
lower bound, regardless of the actual numbers on either side. This order
cannot know which side of a `CSS.merge`/`+++` call was meant as the
override, so it follows the common real pattern instead: a RANGE tied
with a plain `min-width` at the SAME lower bound (e.g. `@media
(min-width: 768px) and (max-width: 1279px)` next to `@media (min-width:
768px)`) is decided by which one was declared LATER (the range, read as
a scoped override inside the wider breakpoint, normally wins); a RANGE
tied against a `max-width`-only rule is decided by kind alone, and the
`max-width`-only rule always wins, however either one was declared. This
order is the SAME everywhere: in every file, in every block, not
"whichever one this block wrote last".
A single block that writes

```reason
let danger = [%css "&:focus { color: blue; } &:hover { color: red; }"];
```

gets `color: blue` (focus) when both `:hover` and `:focus` apply, even
though `:hover` was written last — the fixed priority, not declaration
order, decides (`packages/generate/test/tiers-condition-tie-single-block.t`).
Plain CSS, read top to bottom, would give `red` here; styled-ppx does not,
on purpose — see "Known limits" below.

**No CSS layer wraps any of this.** Specificity decides first, exactly
like plain CSS; sheet position is only ever the tie-break, never an
unconditional priority. A hand-written selector with higher specificity
than an atom still wins outright (`packages/generate/test/global-tier.t`).

### Overlapping `@media` conditions in one block

The grouping above decides ties BETWEEN rules; it says nothing about two
`@media` rules for the same property inside the SAME block. Plain CSS
would give that tie to stylesheet position too, not to which `@media`
was written last - so extraction rewrites each earlier condition to
exclude every later one on the same selector and property family
(`packages/ppx/src/Css_file.re`'s `rewrite_media_conditions`), before
the rule is hashed into a class:

```css
/* you write */
@media (min-width: 600px) { color: red; }
@media (min-width: 900px) { color: blue; }

/* extracted */
@media (min-width: 600px) and (not (min-width: 900px)) { color: red; }
@media (min-width: 900px) { color: blue; }
```

The negation is always its own parenthesized term - `(not (...))` - never
a bare `and not (...)`, which Media Queries 4 only allows at the very
start of a condition; a browser resolves the bare form as `not all`, a
condition that never matches, which would silently break every
rewritten rule.

Blue now wins at 900px and above no matter where either rule lands in
the sheet, and no matter whether some OTHER block already emitted the
same two `@media` rules in the opposite order. Only `@media` gets this
treatment - see "Known limits" below.

The rewrite changes the printed rule and the class name, not what
`CSS.merge` compares: the merge key keeps the condition as you wrote it.
So `CSS.merge(a, b)` still drops `a`'s `@media (min-width: 600px)` atom
when `b` sets the same property under the same written condition, even if
`b`'s own block rewrote that condition
(`packages/runtime/test/media-merge-context.t`).

## Several libraries on one page

`--namespace` (the ppx flag; defaults to the dune `library-name` cookie,
so it needs no flag in the common case) salts every class with the
compiling library's name. Two different libraries never mint the same
class for the same declaration, so one library's sheet can never win a
position tie against another's — each library's classes only ever compete
with its own (`packages/ppx/test/css-support/atom-namespace-salt.t`).

**A native build and its Melange twin of the same source** are the one
exception on purpose: pass them the SAME explicit `--namespace=<name>`
(one token — `--namespace demo` as two separate tokens in a dune `(pps
...)` list fails, since dune then tries to resolve `demo` itself as a
library) in both `(pps ...)` stanzas, or the server-rendered HTML and the
client bundle mint different classes for what should be identical markup
(`packages/ppx/test/css-support/atom-namespace-twin.t`; see
`demo/melange/lib/native/dune`/`demo/melange/lib/js/dune` for a real
example).

Link every page's stylesheets in library dependency order (a library's
sheet after the sheets of every library it depends on) — the same order
`styled-ppx.generate` already uses to place rules within one sheet
(`--order dependency`, the default). This doesn't fully guarantee
cross-sheet ties: two different `<link>`s' rules simply concatenate on
the page in load order, so a genuine tie between two sheets that DO
share a class (a twin pair, or two libraries built with no namespace at
all) still depends on which one the browser loads first
(`packages/generate/test/tiers-two-stylesheets.t`).

## Known limits

- **Partial cover across libraries.** `merge(a, b)` where `a` sets
  `margin` and `b` sets only `margin-top` keeps both classes (the example
  above) — correct as long as `b`'s library's sheet loads after `a`'s.
- **Interpolation bundles.** `merge` never drops an `_in_` bundle, so an
  override of a property inside a bundle is decided by specificity and
  sheet order, not by argument order (the `card` example above).
- **Mixed shorthand depths in one rule.** A rule combining declarations at
  different shorthand depths (e.g. a bundle with both a `padding` and a
  `margin-top`) sorts by its SHALLOWEST declaration, so it is not
  guaranteed correct against every other rule at once
  (`packages/generate/test/shorthand-depth-stress.t`).
- **A hand-written class shaped like an atom.** `merge` recognizes an atom
  by class-name prefix and length alone; a hand-written class starting
  with `_a_` that happens to land on one of the six real atom lengths can
  be silently dropped
  (`hand_written_class_ambiguity_persists_under_the_new_prefix`,
  `packages/runtime/test/test_merge_key.ml`). Don't hand-write a class
  starting with `_a_`.
- **`merge(wide, narrow)` keeps both classes.** Same fact as the
  shorthand-then-longhand example above — it depends on sheet order, not
  on `merge` itself, to pick the right one.
- **A conditional atom beats an unconditional one at equal specificity.**
  `packages/generate/test/tiers-slider.t`: an always-on
  `padding: 0 24px` and a `@media (min-width:1280px) { padding: 0 120px }`
  override, same specificity — the conditional rule wins the tie above
  1280px, by sheet position, because conditional atoms are always
  emitted after base ones.
- **A fixed pseudo-class/pseudo-element order applies even inside one
  block.** `&:focus { color: blue; } &:hover { color: red; }` in ONE
  `[%css]` block gives `color: blue` (focus outranks hover in the fixed
  order), not `red` — the opposite of what "last declaration wins" would
  give for this exact block on its own
  (`packages/generate/test/tiers-condition-tie-single-block.t`). Chosen on
  purpose: the alternative (each block's own declaration order deciding)
  made the SAME shared pair of conditions resolve differently depending on
  which of two components happened to compile first
  (`packages/generate/test/tiers-condition-tie-pseudo-class.t`). To
  override a lower-priority pseudo's declaration with a higher-priority
  one, write the higher-priority one — its own position in the block no
  longer matters.
- **Two pseudo-elements, or two different `@supports` conditions, still
  tie.** `::before` vs `::after`, or `@supports (display:grid)` vs
  `@supports (display:flex)`, get the same fixed-order rank as each other
  (StyleX has no finer answer for either case either), so the tie falls
  back to sheet position — not guaranteed to match either block's own
  intent. No target/condition split and no CSS layer over this — an
  author who needs one of these two to always win still reaches for a more
  specific selector or `!important`.
- **`@supports`/`@container` are not rewritten.** The overlapping-`@media`
  fix above (StyleX's `lastMediaQueryWinsTransform`) covers `@media`
  only, matching StyleX exactly. Two overlapping `@supports` or
  `@container` rules for the same property in one block still depend on
  sheet position, not source order — a known, deliberate gap.
- **A query carrying a media type is rewritten only when every member of
  the group shares the exact same bare-or-`only` type** (`screen`/`only
  screen`, the common real shape): the shared type is carried through
  unchanged, only each member's own feature chain is negated. Two
  remaining gaps, both deliberate: a comma list mixing a typed and an
  untyped branch, or two DIFFERENT types (a media type can never appear
  inside parentheses, so there is no single form to negate a mix of
  types into); and a `not`-prefixed type (`not screen and (...)`) even
  with a matching type on every member — `not` inverts the WHOLE query
  (type and condition together), so folding a negation into just the
  condition gives a wrong result. Tested by
  `packages/ppx/test/css-support/media-type-query-same-type-rewrite.t`.
- **A later query is negated only when every feature it tests resolves
  to a definite true/false in every browser** — `min-width`/`max-width`/
  `min-height`/`max-height` with a literal px/em/rem length, or
  `orientation`; never `calc()`, a percentage, or range-comparison
  syntax. Media features use three-valued logic: negating a feature the
  browser cannot evaluate gives "unknown", so the earlier rule would never
  apply again and its value would be lost. If any later member of a group is unsafe this way, the WHOLE
  group is left untouched. Tested by
  `packages/ppx/test/css-support/media-calc-feature-unchanged.t`.
- **The rewrite always wraps, even when already disjoint.** It does not
  reason about ranges (`(min-width: 768px) and (max-width: 1279px)`
  never actually overlaps `(min-width: 1280px)`), so a correct,
  non-overlapping pair still gets a redundant `and (not (...))` clause —
  correct, just extra bytes.
- **Browser floor for the rewritten `(not (...))` form.** `<query> and
  (not (<query>))` needs Chrome 104, Firefox 64 (`or`/range syntax) or 102
  (full range syntax), Safari 16.4. Below that floor the rewritten
  condition evaluates to false, so the rewritten earlier rule never
  applies there.
- **A `min-width`/`max-width` range vs. a plain `min-width`, at the SAME
  lower bound, still depends on declaration order.** See "Sheet order"
  above — the range wins only because it is declared later in the real,
  shipped example the fix targets; the same two conditions in the
  opposite declaration order give the opposite winner. Only a range
  against a `max-width`-only rule is independent of declaration order
  (kind alone decides, always the `max-width`-only side).
- **A compound `@media` query beyond one `min`/`max`-width feature still
  ties.** An `or`, a `not`, a third feature (e.g. `orientation`), a
  non-`px` unit, or two terms for the SAME bound (two `min-width`s) all
  still fall back to sheet position instead — the kind-based rule only
  ever resolves a `min-width`/`max-width`/range comparison, not every
  compound `@media` prelude.

## See also

- `documents/css-extraction.md` — the exact class-name encoding, the
  aggregator's ordering rules, and `Merge_key`'s implementation, for
  maintainers
- `packages/runtime/native/shared/Merge_key.ml` — the runtime merge rule
  itself
- `packages/runtime/test/test_merge_key.ml` — every example on this page,
  proven against real atom class names
