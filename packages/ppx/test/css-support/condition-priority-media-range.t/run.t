`media_width_bound` used to bail out to `None` on ANY `and` in an `@media`
prelude, treating a genuine two-feature RANGE the same as an unrelated
compound query it truly cannot compare. `media_width_bound` now sorts by
KIND first, then value: a query with a lower bound - a plain `min-width`,
OR a `min-width`/`max-width` RANGE (the range's own upper bound is read
only to confirm it parses, then discarded - never part of the key) - is
min-kind, ascending by that lower bound; a query naming ONLY a
`max-width` is max-kind, descending by its upper bound, and EVERY
max-kind sorts after EVERY min-kind, regardless of value. `None`
(unreadable, or no width feature at all) still sorts first. The
generator only ever sees two CONDITIONS to order, never which one a
`CSS.merge`/`+++` call meant as the override, so it cannot always get
every real, shipped pair "right" by any single rule - it follows the
common real pattern instead (mobile-first `min-width`, a narrower range
as a scoped override INSIDE that breakpoint, a `max-width`-only rule for
an unrelated, desktop-first override) and falls back to DEFINITION ORDER
on a genuine tie.

Six shapes, in one file so their relative sheet order is checked
together, not just each pair in isolation:

`toggleButton`/`toggleButtonShowAtTablet` (`MobileMenu_Css.ml`, the real
regression this key exists to prevent) is `min-width:768px` vs the RANGE
`[768px,1279px]` - both min-kind, tied at `768`, so DEFINITION ORDER
decides (`toggleButtonShowAtTablet` is declared after `toggleButton`, so
it sorts last and wins). `minSix`/`minNine` is `min-width:600px` vs
`min-width:900px` - both min-kind, different lower bounds, ascending
(same as `tiers-condition-tie-media-width.t` and
`condition-priority-media-width.t`). `maxNineNineTwo`/`maxFourEighty` is
`max-width:992px` vs `max-width:480px` - both max-kind, descending (the
narrower one, `480`, sorts last). `rangeLow`/`rangeHigh` is the RANGE
`[0px,767px]` vs the RANGE `[768px,1279px]` - both min-kind, different
lower bounds, so value decides, not definition order.

`header`/`headerWithBanner` (`Header_Css.ml`, `Header.re:86-90`) is the
RANGE `[768px,1279px]` vs `max-width:1279px` ALONE, no lower bound at all
- DIFFERENT kind, so `headerWithBanner` (max-kind) always sorts after
`header` (min-kind) and wins, regardless of declaration order (`header`
is declared first here) and regardless of the numbers (`1279` on both
sides makes no difference - only the KIND does). Both declarations share
one `$(pad)` path, so both rules are `_in_` bundles, not `_a_` atoms - the
width key never looks at the class prefix, only at the rule's own
`@media` text, so a bundle sorts exactly like a plain atom would.
`praiseViewport`/`praiseViewportExpanded` (`Discoverable_Css.ml`,
`Discoverable.re:261`) is the identical range-vs-max-width-only shape,
plain `_a_` atoms this time - confirms the bundle result isn't an
artifact of bundling.

  $ refmt --parse re --print ml input.re > input.ml

  $ ../../standalone.exe --impl input.ml -o output.ml
  $ cat output.ml
  [@@@css "@property --pad-g2wfjo{syntax:\"*\";inherits:false;}"]
  [@@@css "@property --pad-160gt2j{syntax:\"*\";inherits:false;}"]
  [@@@css "@media (min-width: 768px) {._a_p6loh5rnofe{display:none;}}"]
  [@@@css
    "@media (min-width: 768px) and (max-width: 1279px) {._a_5kutk5rhjfe{display:block;}}"]
  [@@@css "@media (min-width: 600px) {._a_izob0ec4xau{width:50%;}}"]
  [@@@css "@media (min-width: 900px) {._a_mp5mkecwpmq{width:33%;}}"]
  [@@@css "@media (max-width: 992px) {._a_4m2ng6lwcm8{height:10px;}}"]
  [@@@css "@media (max-width: 480px) {._a_fjsdf6l280q{height:20px;}}"]
  [@@@css
    "@media (min-width: 0px) and (max-width: 767px) {._a_6b2si4ecs7z{color:red;}}"]
  [@@@css
    "@media (min-width: 768px) and (max-width: 1279px) {._a_5kutk4esajz{color:blue;}}"]
  [@@@css
    "@media (min-width: 768px) and (max-width: 1279px) {._in_yqjybn{padding-top:var(--pad-g2wfjo);}}"]
  [@@@css
    "@media (min-width: 768px) and (max-width: 1279px) {._in_yqjybn{padding-left:var(--pad-g2wfjo);}}"]
  [@@@css
    "@media (max-width: 1279px) {._in_11ru35y{padding-top:var(--pad-160gt2j);}}"]
  [@@@css
    "@media (max-width: 1279px) {._in_11ru35y{padding-left:var(--pad-160gt2j);}}"]
  [@@@css
    "@media (min-width: 768px) and (max-width: 1279px) {._a_5kutk850y8f{max-height:1200px;}}"]
  [@@@css "@media (max-width: 1279px) {._a_9yyk885k4cx{max-height:10000px;}}"]
  [@@@css.bindings
    [("Input.toggleButton", "_id_3ymu7f", "_a_p6loh5rnofe");
    ("Input.toggleButtonShowAtTablet", "_id_12oj7bj", "_a_5kutk5rhjfe");
    ("Input.minSix", "_id_cwqyet", "_a_izob0ec4xau");
    ("Input.minNine", "_id_1c7v7nm", "_a_mp5mkecwpmq");
    ("Input.maxNineNineTwo", "_id_1btosls", "_a_4m2ng6lwcm8");
    ("Input.maxFourEighty", "_id_urm6wh", "_a_fjsdf6l280q");
    ("Input.rangeLow", "_id_b1t7ya", "_a_6b2si4ecs7z");
    ("Input.rangeHigh", "_id_gq07io", "_a_5kutk4esajz");
    ("Input.header", "_id_o6yfa8", "_in_yqjybn");
    ("Input.headerWithBanner", "_id_181aa5d", "_in_11ru35y");
    ("Input.praiseViewport", "_id_1qycs1i", "_a_5kutk850y8f");
    ("Input.praiseViewportExpanded", "_id_5psizx", "_a_9yyk885k4cx")]]
  let toggleButton = CSS.make "label:toggleButton _id_3ymu7f _a_p6loh5rnofe" []
  let toggleButtonShowAtTablet =
    CSS.make "label:toggleButtonShowAtTablet _id_12oj7bj _a_5kutk5rhjfe" []
  let minSix = CSS.make "label:minSix _id_cwqyet _a_izob0ec4xau" []
  let minNine = CSS.make "label:minNine _id_1c7v7nm _a_mp5mkecwpmq" []
  let maxNineNineTwo =
    CSS.make "label:maxNineNineTwo _id_1btosls _a_4m2ng6lwcm8" []
  let maxFourEighty =
    CSS.make "label:maxFourEighty _id_urm6wh _a_fjsdf6l280q" []
  let rangeLow = CSS.make "label:rangeLow _id_b1t7ya _a_6b2si4ecs7z" []
  let rangeHigh = CSS.make "label:rangeHigh _id_gq07io _a_5kutk4esajz" []
  let header ~pad =
    CSS.make "label:header _id_o6yfa8 _in_yqjybn"
      [("--pad-g2wfjo", (CSS.Types.Length.toString pad))]
  let headerWithBanner ~pad =
    CSS.make "label:headerWithBanner _id_181aa5d _in_11ru35y"
      [("--pad-160gt2j", (CSS.Types.Length.toString pad))]
  let praiseViewport =
    CSS.make "label:praiseViewport _id_1qycs1i _a_5kutk850y8f" []
  let praiseViewportExpanded =
    CSS.make "label:praiseViewportExpanded _id_5psizx _a_9yyk885k4cx" []
  let _ =
    (toggleButton, toggleButtonShowAtTablet, minSix, minNine, maxNineNineTwo,
      maxFourEighty, rangeLow, rangeHigh, header, headerWithBanner,
      praiseViewport, praiseViewportExpanded)

  $ styled-ppx.generate output.ml > styles.css
  $ cat styles.css
  /* This file is generated by styled-ppx, do not edit manually */
  @property --pad-g2wfjo{syntax:"*";inherits:false;}
  @property --pad-160gt2j{syntax:"*";inherits:false;}
  @media (min-width: 0px) and (max-width: 767px) {._a_6b2si4ecs7z{color:red;}}
  @media (min-width: 600px) {._a_izob0ec4xau{width:50%;}}
  @media (min-width: 768px) {._a_p6loh5rnofe{display:none;}}
  @media (min-width: 768px) and (max-width: 1279px) {._a_5kutk5rhjfe{display:block;}}
  @media (min-width: 768px) and (max-width: 1279px) {._a_5kutk4esajz{color:blue;}}
  @media (min-width: 768px) and (max-width: 1279px) {._a_5kutk850y8f{max-height:1200px;}}
  @media (min-width: 900px) {._a_mp5mkecwpmq{width:33%;}}
  @media (max-width: 1279px) {._a_9yyk885k4cx{max-height:10000px;}}
  @media (max-width: 992px) {._a_4m2ng6lwcm8{height:10px;}}
  @media (max-width: 480px) {._a_fjsdf6l280q{height:20px;}}
  @media (min-width: 768px) and (max-width: 1279px) {._in_yqjybn{padding-top:var(--pad-g2wfjo);}}
  @media (min-width: 768px) and (max-width: 1279px) {._in_yqjybn{padding-left:var(--pad-g2wfjo);}}
  @media (max-width: 1279px) {._in_11ru35y{padding-top:var(--pad-160gt2j);}}
  @media (max-width: 1279px) {._in_11ru35y{padding-left:var(--pad-160gt2j);}}

`display`, `width`, `height`, `color` and `max-height` are all
shorthand-depth-0 leaf properties (none is a shorthand or a longhand of
one), so every atom here EXCEPT the `header`/`headerWithBanner` bundle
pair ties on descendant-shape, depth, at-rule rank and pseudo rank alike
- the width key (and, on a further tie, DEFINITION ORDER) decides their
FULL relative order across every pair at once, not just within each
pair: `rangeLow` (`0`), `minSix` (`600`), then the four-way tie at `768`
in declaration order (`toggleButton`, `toggleButtonShowAtTablet`,
`rangeHigh`, `praiseViewport`), then `minNine` (`900`) - the last
min-kind rule - then EVERY max-kind rule (`praiseViewportExpanded` at
`1279`, `maxNineNineTwo` at `992`, `maxFourEighty` at `480`, descending).
`header`/`headerWithBanner`'s own property (`padding-top`/`padding-left`,
longhands of the `padding` family) is a DEEPER shorthand depth, so that
bundle pair sorts as its own later cluster - but WITHIN it, the exact
same rule applies: `header` (the range) before `headerWithBanner`
(max-width only), so `headerWithBanner` wins.

Before this track's kind-based rule, `header`/`praiseViewport` (the
ranges) would have WON both real pairs instead - the opposite of the
real, shipped intent - because the previous (lower ascending, upper
descending, as one interval) key encoded `header`/`praiseViewport` as
`(768, -1279)` and `headerWithBanner`/`praiseViewportExpanded` (no lower
bound at all) as `(min_int, -1279)`; ascending on the first component put
the range LAST (`768 > min_int`), so it would have won (checked by
computing both keys independently of `generate.ml`, not by guessing:
`compare (768, -1279) (min_int, -1279)` is positive). The kind-based rule
fixes this: a query with NO lower bound is max-kind, and max-kind always
sorts after EVERY min-kind, never compared to it by raw value.
