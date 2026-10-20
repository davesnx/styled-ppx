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

Inside one generated stylesheet, `[%styled.global]` rules (`html { ... }`,
`* { ... }`, an author's own selector) come first. All atom rules follow, in
one order that `styled-ppx.generate` builds from three sources:

1. **Parent-to-child rules first.** A rule that reaches an unclassed
   descendant (`.wrapper * { ... }`, `.list li { ... }`) is emitted before
   same-element rules, so a component's own class beats an ancestor's blind
   `* { ... }` reach on a `(0,1,0)` tie
   (`packages/generate/test/descendant-tier.t`).
2. **Edges.** Two atom rules *compete* when only the sheet position can
   decide between them: equal importance, equal specificity, the same
   element and pseudo-element, and at least one shared longhand.
   - *Block edge*: inside one block (one `[%css]`, named or not), an earlier
     competing rule comes first. One block reads as plain CSS:
     `[%css "&:focus { color: blue; } &:hover { color: red; }"]` gives `red`
     when both apply, because `:hover` is written last
     (`packages/generate/test/tiers-condition-tie-single-block.t`).
   - *Cover edge*: in one context (same at-rules, same selector), a shorthand
     comes before a rule whose longhands it all sets
     (`packages/generate/test/tiers-shorthand-sort.t`). This is always right:
     when the shorthand is the later merge argument, `CSS.merge` drops the
     covered atom.
3. **Definition order** for every pair the edges leave open: library, then
   module dependency order, then the order of definition in a file. A
   `CSS.merge(a, b)` gets `b`'s rules last when `b` is defined after `a`.

The sheet is built from its end, so a rule stays at its definition position
unless an edge pulls it ahead of a rule it must precede. Two blocks that put
the same two rules in opposite orders are a conflict: the build prints a
warning that names both blocks, and the pair keeps definition order
(`packages/generate/test/tiers-condition-tie-pseudo-class.t`). A longer
cycle of blocks is cut at one rule, with a warning
(`packages/generate/test/ordered-sheet-cycle.t`).

There is no fixed rank between conditions (`:hover` against `:focus`,
`@media` against `@supports`): a block or definition order decides.

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
- **Cover edges compare whole rules.** A rule that groups several
  declarations (a bundle with both a `padding` and a `margin-top`) covers
  another rule only when it sets every longhand of that rule, so a partial
  overlap gets no cover edge and falls to definition order
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
- **A merge whose later argument is defined earlier.** `CSS.merge(a, b)`
  where `b` is defined before `a` (earlier in the file, or in a file the
  dependency order puts first) and no block orders the two competing rules:
  definition order puts `b`'s rule first, so `a`'s rule wins the tie. Same
  when the two blocks are in two files that do not depend on each other.
  Define the override after the base, or write both in one block.
- **Two blocks that disagree.** Two blocks that put the same two competing
  rules in opposite orders can not both hold; the build warns, names both
  blocks, and keeps definition order for the pair
  (`packages/generate/test/tiers-condition-tie-pseudo-class.t`).
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
## See also

- `documents/css-extraction.md` — the exact class-name encoding, the
  aggregator's ordering rules, and `Merge_key`'s implementation, for
  maintainers
- `packages/runtime/native/shared/Merge_key.ml` — the runtime merge rule
  itself
- `packages/runtime/test/test_merge_key.ml` — every example on this page,
  proven against real atom class names
