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
   lose them. The TOP edge is then decided by sheet order - see "Sheet
   order" below: the merge puts margin-top: 0 after margin: 10px, so it
   wins. */
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

Inside one generated stylesheet, `[%styled.global]` rules (`html { ... }`,
`* { ... }`, an author's own selector) come first, in the order you wrote
them (`packages/generate/test/global-source-order.t`). All atom rules
follow, in one order that `styled-ppx.generate` builds from three sources:

1. **Parent-to-child rules first.** A rule that reaches an unclassed
   descendant (`.wrapper * { ... }`, `.list li { ... }`) is emitted before
   same-element rules, so a component's own class beats an ancestor's blind
   `* { ... }` reach on a `(0,1,0)` tie
   (`packages/generate/test/descendant-tier.t`).
2. **Edges.** Two atom rules *compete* when only the sheet position can
   decide between them: equal importance, equal specificity, the same
   element and pseudo-element, and at least one shared longhand. A legacy
   alias counts as its canonical property: `grid-gap` competes with `gap`,
   `word-wrap` with `overflow-wrap`.
   - *Block edge*: inside one block (one `[%css]`, named or not), an earlier
     competing rule comes first, in the order emotion prints the block: the
     block's own declarations first, then its nested rules (`&:hover`,
     `@media`, selectors), each in source order, and the same inside each
     nested rule.
     `[%css "&:focus { color: blue; } &:hover { color: red; }"]` gives `red`
     when both apply, because `:hover` is written last
     (`packages/generate/test/tiers-condition-tie-single-block.t`).
     `[%css "@media (max-width: 600px) { color: pink; } color: black;"]`
     gives `pink` under the media query: `color: black` is a declaration of
     the block, so it comes before the nested `@media` rule
     (`packages/ppx/test/css-support/ordered-sheet-emotion-order.t`).
   - *Merge edge*: in a `CSS.merge(a, b)` or `a +++ b` whose arguments the
     ppx can resolve (a `[%css]` binding of the same file or of another
     module, or an inline `[%css]`), each competing rule of `a` comes before
     each rule of `b`, whichever block defined each shared atom first
     (`packages/ppx/test/css-support/ordered-sheet-merge-edges.t`). A class
     the merge drops at run time takes no part.
3. **Definition order** for every pair the edges leave open: library, then
   module dependency order, then the order of definition in a file.

The sheet is built from its end, so a rule stays at its definition position
unless an edge pulls it ahead of a rule it must precede. Two blocks or
merges that put the same two rules in opposite orders are a conflict: the
build prints a warning that names both, and the pair keeps definition order
(`packages/generate/test/tiers-condition-tie-pseudo-class.t`). A longer
cycle is cut at one rule, with a warning
(`packages/generate/test/ordered-sheet-cycle.t`).

There is no fixed rank between conditions (`:hover` against `:focus`,
`@media` against `@supports`), and no rank between a shorthand and its
longhands across blocks: a block, a merge or definition order decides. A
"shorthand before the longhands it covers" rule would reach through
unrelated blocks: a `padding-right` rule under one `@media` in another file
would pull `headerWithBanner`'s `padding` rules ahead of `header`'s, and
`CSS.merge(header, headerWithBanner)` would give `header` the tie
(`packages/ppx/test/css-support/ordered-sheet-monorepo-regressions.t`).

**No CSS layer wraps any of this.** Specificity decides first, exactly
like plain CSS; sheet position is only ever the tie-break, never an
unconditional priority. A hand-written selector with higher specificity
than an atom still wins outright (`packages/generate/test/global-tier.t`).

### Overlapping `@media` conditions in one block

The grouping above decides ties BETWEEN rules; it says nothing about two
`@media` rules for the same property inside the SAME block. Plain CSS
would give that tie to stylesheet position too, not to which `@media`
was written last - so extraction rewrites each earlier condition to
exclude every later one on the same selector that sets all of the
earlier rule's longhands
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

A later rule that sets other longhands, or only some of them, does not
exclude the earlier condition: `margin: 1px` at 600px followed by
`margin-top: 2px` at 900px keeps `margin: 1px` at 900px and above, so
the other three sides stay 1px, as in plain CSS. Both rules then apply
at 900px and above, and the block order above puts `margin: 1px` first
in the sheet, so `margin-top: 2px` wins there. When the two rules come
from different blocks, `CSS.merge(a, b)` orders `a`'s rule first
(`packages/ppx/test/css-support/media-overlap-longhand-cover.t`).

The rewrite changes the printed rule and the class name, not what
`CSS.merge` compares: the merge key keeps the condition as you wrote it.
So `CSS.merge(a, b)` still drops `a`'s `@media (min-width: 600px)` atom
when `b` sets the same property under the same written condition, even if
`b`'s own block rewrote that condition
(`packages/runtime/test/media-merge-context.t`).

## Several libraries on one page

No class hash takes a library name. Two libraries that declare the same
atom share its class, and a native build and its Melange twin of the same
source mint identical classes with no configuration, so the
server-rendered HTML matches the client stylesheet
(`packages/ppx/test/css-support/library-twin-same-classes.t`).

Run one `styled-ppx.generate` per app, over every library the app links,
and serve the one sheet it writes. That run orders every library's rules
in library dependency order (a library's rules after the rules of every
library it depends on, `--order dependency`, the default), keeps one copy
of each shared atom, and fails on a class collision between any two
libraries.

Two separate runs (two `<link>`s) give no such guarantee: their rules
concatenate on the page in load order, so a tie between two sheets that
share a class depends on which one the browser loads first
(`packages/generate/test/tiers-two-stylesheets.t`).

## Known limits

- **Partial cover across libraries.** `merge(a, b)` where `a` sets
  `margin` and `b` sets only `margin-top` keeps both classes (the example
  above) — correct as long as `b`'s library comes after `a`'s in the
  sheet, which dependency order gives when `b`'s library depends on `a`'s.
- **Interpolation bundles.** `merge` never drops an `_in_` bundle, so an
  override of a property inside a bundle is decided by specificity and
  sheet order, not by argument order (the `card` example above).
- **A hand-written class shaped like an atom.** `merge` recognizes an atom
  by class-name prefix and length alone; a hand-written class starting
  with `_a_` that happens to land on one of the six real atom lengths can
  be silently dropped
  (`hand_written_class_ambiguity_persists_under_the_new_prefix`,
  `packages/runtime/test/test_merge_key.ml`). Don't hand-write a class
  starting with `_a_`.
- **`merge(wide, narrow)` keeps both classes.** Same fact as the
  shorthand-then-longhand example above — it depends on sheet order, not
  on `merge` itself, to pick the right one. A merge the ppx resolves gives
  that order (`packages/generate/test/tiers-shorthand-sort.t`); see the
  next limit for one it can not resolve.
- **A merge the ppx can not resolve.** Merge edges need both arguments to
  name a `[%css]` block the ppx can see: a binding, or an inline `[%css]`.
  A function call (`merge(base, variant(x))`, the `card` example above), a
  function parameter, or a binding inside a function body gives no edge.
  Then, when no block orders the two competing rules, definition order
  decides: `b`'s rule wins only if its first definition (anywhere in the
  app, an atom shared with another binding included) comes after `a`'s.
  Same when the two blocks are in two files that do not depend on each
  other.
- **Two orders that disagree.** Two blocks or merges that put the same two
  competing rules in opposite orders can not both hold; the build warns,
  names both, and keeps definition order for the pair
  (`packages/generate/test/tiers-condition-tie-pseudo-class.t`). This
  includes `merge(a, b)` in one place and `merge(b, a)` elsewhere when
  both calls keep both classes; a call that drops a class orders nothing
  for it (`packages/ppx/test/css-support/ordered-sheet-merge-both-orders.t`).
- **Rules of different specificity are not reordered.** An at-rule adds no
  specificity, a pseudo-class does: `&:hover` beats a bare `@media` atom
  whatever the order, as in plain CSS.
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
  apply again and its value would be lost. If any later member that
  would be negated is unsafe this way, the WHOLE group is left untouched. Tested by
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
## See also

- `documents/css-extraction.md` — the exact class-name encoding, the
  aggregator's ordering rules, and `Merge_key`'s implementation, for
  maintainers
- `packages/runtime/native/shared/Merge_key.ml` — the runtime merge rule
  itself
- `packages/runtime/test/test_merge_key.ml` — every example on this page,
  proven against real atom class names
