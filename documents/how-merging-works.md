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

Nested `@supports`, `@media` and `@container` count as one condition that
holds when all of them hold, so their written order does not matter:
`@media (...) { @supports (...) { ... } }` and
`@supports (...) { @media (...) { ... } }` are the same context, and the
generated rule always nests them in the order `@supports`, `@media`,
`@container` (two of the same kind in the order of their text).
`@starting-style` is not reordered.

There is one exception to "same context". When `b`'s declaration is
unconditional (base context: no `@media`/`@supports`/`@container`, no
selector, not `!important`), it also drops `a`'s atoms of the same
longhands that sit under at-rules alone. `b` sets the property for the
element in every state, so an `@media` value of `a` for it would
otherwise still win while the condition holds. A selector context
(`:hover`, `& .child`, `::before`) or an `!important` context of `a` is
not dropped: it matches other states of the element, or beats `b` anyway.
The same holds inside one block: a base declaration written after an
`@media`/`@supports`/`@container` one for the same longhands drops the
earlier one (`@media (...) { padding-top: 8px; } padding: 0;` keeps only
`padding: 0`), and written before it does not (`padding: 0; @media (...)
{ padding-top: 8px; }` keeps both). When the base declaration covers only part of the
earlier one (`@media (...) { padding: 8px; } padding-top: 0;`), both stay and the
base one is a twin (below). A declaration that interpolates `$(...)`
takes part like any other. The dropped atom ships no class or rule, but its
value is still read and set inline, so the variable it uses stays used (no
unused-variable warning) and a later base declaration changes no other name
(`packages/ppx/test/css-support/cascade-review.t`, V01).
The reverse never happens: a conditional `b` does not drop a base `a`,
since `a` still applies when the condition is false.

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

**An `@media` shorthand, then a base longhand — a specificity twin:**

```reason
let responsive = [%css "@media (max-width: 600px) { padding: 8px; }"];
let override = [%css "padding-top: 0;"];

CSS.merge(responsive, override);
/* padding-top: 0 applies at every width; the media query still sets the
   other three sides below 600px */
```

`padding` covers more than `padding-top`, so `merge` cannot drop it, and a
rule under `@media` sorts after a base rule in the sheet. `merge` therefore
adds a **twin** class after the class of `padding-top`. `styled-ppx.generate`
writes the rule of an atom with extra selectors for the twin classes, when the
atom has a competitor in its own source file (see "Where the twin rule
exists" below):

```css
._a_<x>,._t1_<x>:not(x-) { padding-top: 0; }
```

`._a_<x>` has specificity (0,1,0), `._t1_<x>:not(x-)` (0,1,1) and the level 2
twin (0,1,2), so a twin wins over a lower level whatever the sheet order, and
`padding` still applies to the sides the twin does not set. The twin class
sits next to the atom class on the element (`_a_<x> _t1_<x>`), so an atom
whose twin rule does not exist still applies through `._a_<x>`. The runtime
only adds a prefixed copy of the class name, with no table.

**Where the twin rule exists.** `generate` writes twin selectors only for an
atom that a merge may need to raise: the atom has a competitor in the same
source file (or in a file it uses in a selector, `$(X)`) that
- may hit the same element with the same specificity. Two facts keep selectors
  apart: whether the rule styles the `&` element itself or another element
  reached through a combinator (`& > div`), and its pseudo-element
  (`:before` and `::before` are one). Everything else is compared through the
  specificity of the whole selector (ids, classes, types, with `:is`, `:not`
  and `:has` weighing their most specific argument and `:where` nothing), as
  `& .x` and `& .y` can hit one element. So `&:hover` against `&:focus`,
  `&.on` or `&:is(.a, .b)` compete, and a rule against the same rule under
  `@media`; `&:hover` against the base rule, or `& > ::before` against the base
  rule, never do,
- gives the element another value (identical declarations under two at-rules
  never need a twin),
- overlaps it without being replaced by it (`merge` drops what a later atom
  covers), and
- the sheet order may put after it. A base rule comes before an `@media` rule,
  and a shorthand before its longhand in one context, so a base declaration
  and the same property under `@media`, or `padding` and `padding-left`, need
  no twin.

`generate` cannot know which of these pairs a merge will meet, and the runtime
cannot know which `generate` left out, so an atom that gets any twin gets both
levels. Most atoms have no competitor, and their rule is a plain
`._a_<x> { ... }`. A merge of atoms from two files has no twin rule, unless
each atom has such a competitor in its own file, so the sheet order decides, as
it did before the twin (`packages/ppx/test/css-support/cascade-twin-scope.t`;
`cascade-gaps.t` G51 and G51S). Known limit: a twin can win over a later atom
that has no twin rules. If an earlier atom has a twin rule from its own file,
and the later atom from another file has none, the later atom gets only a twin
class, and the earlier twin wins (`cascade-twin-review.t`, `xc.re` and
`xd.re`). Keep atoms that must override each other in one file or link them
with `$(X)`.

When the atom has a selector (`.parent &`, `& + &`, `&:hover`), each twin
selector is the same selector with one `._a_<x>` replaced by the twin class,
so the twin applies only where the atom applies:

```css
._id_<p> ._a_<x>,._id_<p> ._t1_<x>:not(x-),._id_<p> ._t2_<x>:not(x-):not(x-) { padding-top: 0; }
```

A `:not(...)` that holds the class is left as it is and takes no twin. The
element keeps its `_a_<x>` class next to the twin, so `:not(._a_<x>)` is right
for every element that carries the atom (`cascade-not-amp.t`).

When the atom repeats its class in several compound selectors (`& + &`), either
element may be the merged one, so there is one twin selector per compound, the
other compounds keep `._a_<x>`:

```css
._t1_<x>:not(x-) + ._a_<x>,._a_<x> + ._t1_<x>:not(x-)
```

Where `merge(a, b)` (and a block, for its own atoms, in source order) uses a
twin: an atom of `a` that survives overlaps `b`'s atom (same family, masks that
meet and are not covered, or `all`), both are of the same kind (both in the
base context or under at-rules alone, or both with a selector or `!important`),
and the sheet order would not surely put `b` last. The sheet surely puts `b`
last when `a` is base and `b` is under at-rules, or when both share a context
and `a` is a shorthand and `b` a longhand: no twin there. A level is one above
the highest level of the atoms it must beat (0 when the sheet order already
does it). The atoms it must beat are `a`'s survivors and the atoms of `b`
before it, at the level they were just given, so a twin raised by `a` carries
over to the later atoms of `b` (`cascade-review.t`, V05). The cap is level 2: at the cap the sheet order decides, as it did
before the twin (`packages/ppx/test/css-support/cascade-twin.t`, G55; a chain of
four state atoms, R02 in `cascade-remaining.t`). This covers two different
selectors of equal specificity (`:hover` then `:disabled`, `& .a` then `& .b`,
`&.x` then `&:focus`) and the same selector with an extra at-rule
(`@media { &:hover }` then `&:hover`): the later one wins, as in plain CSS.
Atoms of different kinds are not compared. An atom with a selector has more
class-like parts than a plain atom, so it wins or loses against it by
specificity, as in plain CSS, and a twin (a type-selector weight) never changes
that: `&:hover:focus` then `&:hover` keeps the first one winning when both match
(R03), and `:hover` still beats `@media` (G58, G60). The runtime does not know
whether two selectors style one element. A twin that is not needed changes
nothing. One known gap: an earlier `& span.x` and a later `& .x` on one element
differ by one type selector, which a level 1 twin only ties.

The same rule makes these cases follow source order, with nothing split:
`border-radius`, `border`, `outline`, `background`, `font`, a top-level
`var()`, a repeated `$(path)` (`padding: $(x)`) and a conditional shorthand
against its longhand. A logical longhand (`padding-inline-start`) and a
physical one (`padding-left`) are different properties for merge, whatever
the writing mode, so they get no twin.
(`cascade-gaps.t` and `cascade-twin.t` pin each of these.)

**A twin stays below an author selector with more classes.** `:not(x-)` weighs
as one type selector (0,0,1; `x-` matches no element), so a twin only decides
ties between rules with the same number of classes and pseudo-classes, as a
later rule would. An author selector such as `.parent.on` (0,2,0) still beats
a twin of any level (G56, R08B, R08C). A twin still beats a one-class author
rule (R08D), and ties with an author selector that adds one type selector to
one class (`a.link`, 0,1,1) at level 1: the later rule in the sheet wins.

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

**Never dropped, on either side:** an identity class
(`_id_...`, what a `$(binding)` selector reference resolves to), a
`label:<binding>` dev marker, and any class this pipeline didn't mint (a
hand-written class, a third-party class passed through `className`).
`merge` only ever inspects `_a_`-prefixed atoms; it leaves everything
else exactly as it found it.

**Declarations that share one `$(name)` are separate atoms.** When two or
more of a block's declarations interpolate the SAME `$(name)` — typically one
value reused across `base`/`:hover`/`@media` variants — they share one custom
property (one inline variable), but each is still its own atom with its own
class, context and property family, so `merge` treats each like any other atom:

```reason
let card = accent => [%css "border-color: $(accent); &:hover { border-color: $(accent); }"];
/* two atoms: base and :hover, one shared variable for $(accent) */

CSS.merge(card("gray"), [%css "border-color: green;"]);
/* the base atom is dropped (same context, same property); the :hover atom
   stays, and while hovered it still wins by specificity (0,2,0 against
   0,1,0), as in plain CSS. */
```

`packages/runtime/test/test_merge_key.ml`'s `group_members_merge_one_by_one`
proves the mechanism against real atom classes, and
`packages/ppx/test/css-support/cascade-remaining.t` (R06, R07, R10) against the
generated sheet. The class value of a member also covers the group (the
rendered members), so one class still means one exact rule body; the group
holds the members only, so changing another declaration of the block changes
neither the variable nor the member classes.

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
pseudo-element outranks any pseudo-class). Two conditions tied on BOTH
still resolve deterministically, by falling through to DEFINITION
ORDER: whichever one was declared later wins - the same order a
`CSS.merge`/`+++` call's right-hand (override) argument needs to win.
This order is the SAME everywhere: in every file, in every block, not
"whichever one this block wrote last". It decides only between atoms the
specificity twin does not relate (two blocks that reach one element as two
class names, or a chain past the twin cap).
A single block that writes

```reason
let danger = [%css "&:focus { color: blue; } &:hover { color: red; }"];
```

gets `color: red` (hover, written last) when both apply: the block gives
`:hover` a twin, so source order decides, as in plain CSS
(`packages/ppx/test/css-support/condition-priority-pseudo-class.t`: the `:hover` class is `_t1_`). The same holds for
`CSS.merge` of the two. The sheet by itself, with no twin class in use,
still puts `:focus` last (`packages/generate/test/tiers-condition-tie-single-block.t`
pins that sheet order); see "Known limits" below for what the twin cannot
decide.

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
(`packages/runtime/test/media-merge-context.t`). This holds at every level of
nesting: for `@media (min-width: 100px) { @media (max-width: 1200px) { ... }
@media (max-width: 900px) { ... } }` the first inner atom keeps the key of the
unrewritten `(min-width: 100px)` / `(max-width: 1200px)` pair, so it drops an
earlier atom written that way (`packages/ppx/test/css-support/cascade-remaining.t`,
R09).

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
- **Logical against physical properties.** `padding-inline-start` and
  `padding-left` are different families for `merge`, so neither drops nor
  twins the other (`cascade-gaps.t` G24, G33; `cascade-exotic.t` E09, E11).
  Which side a logical property sets depends on `writing-mode` and
  `direction`, and the compiler does not know them. Both classes stay and the
  sheet order decides. Write both with the same kind of property when one must
  override the other.
- **Twin cap.** A chain of more than two overlapping merges stops at level 2,
  so in a chain of four state atoms on one property (`:hover`, `:focus`,
  `:active`, `:disabled`) the last two tie and the sheet's pseudo-class rank
  decides (`cascade-remaining.t`, R02 and R02R). The result then depends on
  the rank, not on the merge order.
- **A twin does not weigh type selectors.** A twin adds one type selector of
  weight per level. An earlier `& span.x` and a later `& .x` on one element
  differ by one type selector, which a level 1 twin only ties (level 2
  beats it). A later `& span.x` over an earlier `& .x` needs no twin.
- **A merge across files has no twin rule.** Twin rules exist only for atoms
  with a competitor in their own file. Two atoms from two files that overlap
  fall back to the sheet order (`cascade-gaps.t` G51, G51S; `cascade-cases.t`
  C29S under `print`).
- **The twin raises the sheet size** only for atoms that need it (see "Where the twin rule exists").
- **A selector context is not dropped by a base declaration.** `&:hover`,
  `& .child` and `::before` atoms of `a` stay, even with the same
  property in `b`; so does an `@media` atom under such a selector.
- **Mixed shorthand depths in one rule.** A rule combining declarations at
  different shorthand depths (e.g. a family atom with both a `padding` and a
  `margin-top`) sorts by its SHALLOWEST declaration, so it is not
  guaranteed correct against every other rule at once
  (`packages/generate/test/shorthand-depth-stress.t`).
- **A hand-written class shaped like an atom.** `merge` recognizes an atom
  by class-name prefix and length alone; a hand-written class starting
  with `_a_` that happens to land on one of the six real atom lengths can
  be silently dropped
  (`hand_written_atom_shaped_class_is_read_as_an_atom`,
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
- **A fixed pseudo-class order decides what the twin cannot.**
  `&:focus { color: blue; } &:hover { color: red; }` in ONE `[%css]` block, or
  `CSS.merge` of the two, follows source order: the twin raises `:hover`, so
  `color: red` wins when both match, as in plain CSS (`cascade-cases.t` C11,
  C15). Where no twin applies (two blocks put on one element as two class
  names, or a chain past the cap), the generated sheet's fixed order
  (`:hover` before `:focus` before `:active`; the same for pseudo-elements and
  for two `@supports` conditions) decides, the same for every block in every
  file (`packages/generate/test/tiers-condition-tie-single-block.t` pins that
  sheet order). To make one of them win there, write the more specific
  selector.
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
- **Two conditions tied on at-rule kind and pseudo rank depend on
  DEFINITION order, not on either condition's own numbers.** There used
  to be a third tie-break here — a `min-width`/`max-width` comparison —
  removed by decision: a real monorepo round found it got 2 of 4 real,
  shipped ties wrong (a range tied against a plain `max-width` rule for
  the same property has no reliable width-only answer; only definition
  order, which is what the generator's own input order actually encodes,
  gets every real, shipped pair right). Within ONE library, dependency
  order then a module's own definition order decide — which matches the
  usual pattern of writing a base rule, then a narrower modifier, in that
  order. Between two DIFFERENT, unrelated modules whose rules reach one
  element (not through one `[%css]` block's own author order, and not
  through a `CSS.merge`/`+++` call, which already has its own argument
  order to decide by) — file order decides, and file order is exactly
  the thing this whole track exists to stop depending on for a shared
  pair of conditions. A block or a `CSS.merge` that writes both gives the
  later one a twin, so source order decides there (see "Known limits"); the
  fixed priority above still decides when no twin applies. Either way, an
  author who still needs a specific winner can always raise specificity or use
  `!important`.

## See also

- `documents/css-extraction.md` — the exact class-name encoding, the
  aggregator's ordering rules, and `Merge_key`'s implementation, for
  maintainers
- `packages/runtime/native/shared/Merge_key.ml` — the runtime merge rule
  itself
- `packages/runtime/test/test_merge_key.ml` — every example on this page,
  proven against real atom class names
