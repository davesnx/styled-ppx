/* Competing declaration pairs the Ahrefs monorepo does not use but a
   styled-ppx author can write (see the test description). Every value is
   unique to its case, so no two cases share an atom and the sheet shows each
   pair alone. */

let show = (id, parts, result) => {
  List.iter(
    ((name, styles)) => {
      Printf.printf("%s %s: %s\n", id, name, CSS.className(styles));
      let style = ReactDOM.Style.to_string(CSS.styles(styles));
      if (style != "") {
        Printf.printf("%s %s style: %s\n", id, name, style);
      };
    },
    parts,
  );
  Printf.printf("%s result: %s\n", id, CSS.className(result));
  let style = ReactDOM.Style.to_string(CSS.styles(result));
  if (style != "") {
    Printf.printf("%s result style: %s\n", id, style);
  };
};

let show_parts = (id, parts) =>
  List.iter(
    ((name, styles)) => {
      Printf.printf("%s %s: %s\n", id, name, CSS.className(styles));
      let style = ReactDOM.Style.to_string(CSS.styles(styles));
      if (style != "") {
        Printf.printf("%s %s style: %s\n", id, name, style);
      };
    },
    parts,
  );

/* E01: A base, B @supports, equal specificity
   intended: B */
let e01_a = [%css {|
  margin-left: 301px;
|}];
let e01_b = [%css {|
  @supports (display: grid) { margin-left: 302px; }
|}];
show("E01", [("a", e01_a), ("b", e01_b)], CSS.merge(e01_a, e01_b));

/* E02: A @media, B @supports, at-rank A>B
   intended: B */
let e02_a = [%css {|
  @media (max-width: 1200px) { margin-left: 303px; }
|}];
let e02_b = [%css {|
  @supports (display: grid) { margin-left: 304px; }
|}];
show("E02", [("a", e02_a), ("b", e02_b)], CSS.merge(e02_a, e02_b));

/* E03: two different @supports conditions, same at-rank, B defined before A
   intended: B */
let e03_b = [%css {|
  @supports (display: grid) { margin-left: 305px; }
|}];
let e03_a = [%css {|
  @supports (display: flex) { margin-left: 306px; }
|}];
show("E03", [("a", e03_a), ("b", e03_b)], CSS.merge(e03_a, e03_b));

/* E04: A margin-left, B all, same context (the all sentinel removes A)
   intended: B */
let e04_a = [%css {|
  margin-left: 307px;
|}];
let e04_b = [%css {|
  all: unset;
|}];
show("E04", [("a", e04_a), ("b", e04_b)], CSS.merge(e04_a, e04_b));

/* E05: A direction and unicode-bidi, B all (both are excluded from all)
   intended: A
   note: all does not reset direction or unicode-bidi, so A survives */
let e05_a = [%css {|
  direction: rtl;
  unicode-bidi: bidi-override;
|}];
let e05_b = [%css {|
  all: initial;
|}];
show("E05", [("a", e05_a), ("b", e05_b)], CSS.merge(e05_a, e05_b));

/* E06: A custom property, B all (custom properties are excluded from all)
   intended: A */
let e06_a = [%css {|
  --e06-a: 308px;
|}];
let e06_b = [%css {|
  all: revert;
|}];
show("E06", [("a", e06_a), ("b", e06_b)], CSS.merge(e06_a, e06_b));

/* E07: A all, B a depth-1 longhand and a depth-0 property, B defined before A
   intended: B
   note: all has depth 0, the same as color, so only definition order separates them */
let e07_b = [%css {|
  margin-left: 309px;
  color: rgb(10, 0, 0);
|}];
let e07_a = [%css {|
  all: revert-layer;
|}];
show("E07", [("a", e07_a), ("b", e07_b)], CSS.merge(e07_a, e07_b));

/* E08: A physical (padding-left), B logical (padding-inline-start), A defined before B
   intended: B
   note: the prefixer adds -webkit-padding-start to B; it counts as padding-inline-start (depth 1), same as E45 */
let e08_a = [%css {|
  padding-left: 311px;
|}];
let e08_b = [%css {|
  padding-inline-start: 312px;
|}];
show("E08", [("a", e08_a), ("b", e08_b)], CSS.merge(e08_a, e08_b));

/* E09: A logical (padding-inline-end), B physical (padding-right), B defined before A
   intended: B
   note: known limit (the writing mode is unknown at compile time, see how-merging-works.md); the prefixer adds -webkit-padding-end to A; it counts as padding-inline-end (depth 1), so A, defined after B, now lands after it (same depth keeps source order) */
let e09_b = [%css {|
  padding-right: 313px;
|}];
let e09_a = [%css {|
  padding-inline-end: 314px;
|}];
show("E09", [("a", e09_a), ("b", e09_b)], CSS.merge(e09_a, e09_b));

/* E10: A logical shorthand (margin-block), B physical longhand (margin-top)
   intended: B */
let e10_a = [%css {|
  margin-block: 315px;
|}];
let e10_b = [%css {|
  margin-top: 316px;
|}];
show("E10", [("a", e10_a), ("b", e10_b)], CSS.merge(e10_a, e10_b));

/* E11: A physical longhand (margin-bottom), B logical shorthand (margin-block)
   intended: B
   note: known limit, as E09 (logical and physical properties are different families) */
let e11_a = [%css {|
  margin-bottom: 317px;
|}];
let e11_b = [%css {|
  margin-block: 318px;
|}];
show("E11", [("a", e11_a), ("b", e11_b)], CSS.merge(e11_a, e11_b));

/* E12: A inset shorthand, B physical longhand (top)
   intended: B */
let e12_a = [%css {|
  inset: 319px;
|}];
let e12_b = [%css {|
  top: 320px;
|}];
show("E12", [("a", e12_a), ("b", e12_b)], CSS.merge(e12_a, e12_b));

/* E13: ::before and ::after, same property, the same pseudo-element rank
   intended: both apply (they style two different elements) */
let e13_a = [%css {|
  &::before { color: rgb(21, 0, 0); }
|}];
let e13_b = [%css {|
  &::after { color: rgb(22, 0, 0); }
|}];
show("E13", [("a", e13_a), ("b", e13_b)], CSS.merge(e13_a, e13_b));

/* E14: pseudo-element alone (A) vs a pseudo-class before the pseudo-element (B)
   intended: B
   note: the other order, `&::before:hover`, is a compile error now (`pseudo-class-after-pseudo-element-error.t`): no browser accepts it, so it could never apply */
let e14_a = [%css {|
  &::before { color: rgb(23, 0, 0); }
|}];
let e14_b = [%css {|
  &:hover::before { color: rgb(24, 0, 0); }
|}];
show("E14", [("a", e14_a), ("b", e14_b)], CSS.merge(e14_a, e14_b));

/* E15: A raw var() shorthand, B longhand
   intended: B */
let e15_a = [%css {|
  margin: var(--e15-x);
|}];
let e15_b = [%css {|
  margin-left: 325px;
|}];
show("E15", [("a", e15_a), ("b", e15_b)], CSS.merge(e15_a, e15_b));

/* E16: A longhand, B raw var() shorthand
   intended: B */
let e16_a = [%css {|
  padding-left: 326px;
|}];
let e16_b = [%css {|
  padding: var(--e16-x);
|}];
show("E16", [("a", e16_a), ("b", e16_b)], CSS.merge(e16_a, e16_b));

/* E17: A is an _in_ bundle (base and :hover share one $(x)), B a plain base override (the card example in how-merging-works.md)
   intended: B
   note: per state. While `:hover` is off B wins; while it is on, A's `:hover` member wins by specificity (0,2,0 against 0,1,0), as in plain CSS. The real gap is the bundle, which `merge` never drops (see Known limits) */
let e17_v1 = CSS.rgb(27, 0, 0);
let e17_a = [%css {|
  border-top-color: $(e17_v1);
  &:hover { border-top-color: $(e17_v1); }
|}];
let e17_b = [%css {|
  border-top-color: rgb(28, 0, 0);
|}];
show("E17", [("a", e17_a), ("b", e17_b)], CSS.merge(e17_a, e17_b));

/* E18: A and B are both _in_ bundles (base and :hover share one $(x) each)
   intended: B */
let e18_v1 = CSS.rgb(29, 0, 0);
let e18_v2 = CSS.rgb(30, 0, 0);
let e18_a = [%css {|
  border-left-color: $(e18_v1);
  &:hover { border-left-color: $(e18_v1); }
|}];
let e18_b = [%css {|
  border-left-color: $(e18_v2);
  &:hover { border-left-color: $(e18_v2); }
|}];
show("E18", [("a", e18_a), ("b", e18_b)], CSS.merge(e18_a, e18_b));

/* E19: :focus longhand (A) then :active shorthand (B), the prefixed twin of C32
   intended: B
   note: the prefixer adds -webkit-animation-duration to A and -webkit-animation to B; the prefixed longhand counts as depth 1 and lands after the shorthand, same as the unprefixed C32 */
let e19_a = [%css {|
  &:focus { animation-duration: 331s; }
|}];
let e19_b = [%css {|
  &:active { animation: 332s ease; }
|}];
show("E19", [("a", e19_a), ("b", e19_b)], CSS.merge(e19_a, e19_b));

/* E20: A author-written -webkit-user-select, B user-select (the prefixer adds -webkit-user-select to B), B defined before A
   intended: B */
let e20_b = [%css {|
  user-select: text;
|}];
let e20_a = [%css {|
  -webkit-user-select: none;
|}];
show("E20", [("a", e20_a), ("b", e20_b)], CSS.merge(e20_a, e20_b));

/* E21: A shorthand (border, depth 0), B depth-2 longhand (border-top-width)
   intended: B */
let e21_a = [%css {|
  border: 333px solid rgb(34, 0, 0);
|}];
let e21_b = [%css {|
  border-top-width: 335px;
|}];
show("E21", [("a", e21_a), ("b", e21_b)], CSS.merge(e21_a, e21_b));

/* E22: A :hover border-width (depth 1), B :focus group mixing depths (border at depth 0 and border-top-width at depth 2 in one rule)
   intended: B */
let e22_a = [%css {|
  &:hover { border-width: 336px; }
|}];
let e22_b = [%css {|
  &:focus { border: 337px solid rgb(38, 0, 0); border-top-width: 339px; }
|}];
show("E22", [("a", e22_a), ("b", e22_b)], CSS.merge(e22_a, e22_b));

/* E23: both !important, A base longhand, B @media shorthand
   intended: B */
let e23_a = [%css {|
  padding-top: 340px !important;
|}];
let e23_b = [%css {|
  @media (max-width: 1200px) { padding: 341px !important; }
|}];
show("E23", [("a", e23_a), ("b", e23_b)], CSS.merge(e23_a, e23_b));

/* E24: three-way merge, the middle shorthand drops the first longhand and the last longhand follows it
   intended: C */
let e24_a = [%css {|
  margin-left: 342px;
|}];
let e24_b = [%css {|
  margin: 343px;
|}];
let e24_c = [%css {|
  margin-left: 344px;
|}];
show("E24", [("a", e24_a), ("b", e24_b), ("c", e24_c)], CSS.merge(CSS.merge(e24_a, e24_b), e24_c));

/* E25: three-way merge, the middle operand sits in @media and survives the base override
   intended: C */
let e25_a = [%css {|
  margin-left: 345px;
|}];
let e25_b = [%css {|
  @media (max-width: 1200px) { margin-left: 346px; }
|}];
let e25_c = [%css {|
  margin-left: 347px;
|}];
show("E25", [("a", e25_a), ("b", e25_b), ("c", e25_c)], CSS.merge(CSS.merge(e25_a, e25_b), e25_c));

/* E26: merge with an empty block on either side
   intended: A */
let e26_a = [%css {|
  margin-left: 348px;
|}];
let e26_empty = [%css ""];
show("E26 left", [("a", e26_a), ("empty", e26_empty)], CSS.merge(e26_a, e26_empty));
show("E26 right", [], CSS.merge(e26_empty, e26_a));

/* E27: merge of a binding with itself
   intended: A */
let e27_a = [%css {|
  margin-left: 349px;
  &:hover { margin-left: 350px; }
|}];
show("E27", [("a", e27_a)], CSS.merge(e27_a, e27_a));

/* E28: A @supports with a nested @media, B @media
   intended: B */
let e28_a = [%css {|
  @supports (display: grid) { @media (max-width: 1200px) { margin-left: 351px; } }
|}];
let e28_b = [%css {|
  @media (max-width: 1100px) { margin-left: 352px; }
|}];
show("E28", [("a", e28_a), ("b", e28_b)], CSS.merge(e28_a, e28_b));

/* E29: A @media with a nested @container, B @container
   intended: B */
let e29_a = [%css {|
  @media (max-width: 1200px) { @container app-main (max-width: 900px) { margin-left: 353px; } }
|}];
let e29_b = [%css {|
  @container app-main (max-width: 1000px) { margin-left: 354px; }
|}];
show("E29", [("a", e29_a), ("b", e29_b)], CSS.merge(e29_a, e29_b));

/* E30: A @container with a nested @media, B @media
   intended: B */
let e30_a = [%css {|
  @container app-main (max-width: 1000px) { @media (max-width: 1200px) { margin-left: 355px; } }
|}];
let e30_b = [%css {|
  @media (max-width: 1100px) { margin-left: 356px; }
|}];
show("E30", [("a", e30_a), ("b", e30_b)], CSS.merge(e30_a, e30_b));

/* E31: one block, two overlapping @media, narrow first and wide second
   intended: B */
let e31 = [%css {|
  @media (max-width: 900px) { margin-left: 357px; }
  @media (max-width: 1200px) { margin-left: 358px; }
|}];
show("E31", [], e31);

/* E32: one block, two overlapping @media, wide first and narrow second
   intended: B
   note: the rewrite makes the two ranges disjoint, so the harness reports the winner per width (mixed): B at and below the narrow width, A in the rest of the wide range */
let e32 = [%css {|
  @media (max-width: 1200px) { margin-left: 359px; }
  @media (max-width: 900px) { margin-left: 360px; }
|}];
show("E32", [], e32);

/* E33: one block, two overlapping @media with the same media type
   intended: B
   note: as E32, the winner is reported per width */
let e33 = [%css {|
  @media screen and (max-width: 1200px) { margin-left: 361px; }
  @media screen and (max-width: 900px) { margin-left: 362px; }
|}];
show("E33", [], e33);

/* E34: one block, two overlapping @media with a not-prefixed media type (never rewritten)
   intended: B */
let e34 = [%css {|
  @media not screen and (min-width: 1200px) { margin-left: 363px; }
  @media not screen and (min-width: 900px) { margin-left: 364px; }
|}];
show("E34", [], e34);

/* E35: one block, two overlapping @media, one with a media type and one without (never rewritten)
   intended: B */
let e35 = [%css {|
  @media screen and (max-width: 1200px) { margin-left: 365px; }
  @media (max-width: 900px) { margin-left: 366px; }
|}];
show("E35", [], e35);

/* E36: ancestor `& *` (specificity 0,1,0) vs the child's own atom
   intended: B (the child's own style) */
let e36_a = [%css {|
  & * { margin-left: 367px; }
|}];
let e36_b = [%css {|
  margin-left: 368px;
|}];
show_parts("E36", [("parent", e36_a), ("child", e36_b)]);

/* E37: ancestor `& span` (specificity 0,1,1) vs the child's own atom
   intended: A (the ancestor selector is the more specific one) */
let e37_a = [%css {|
  & span { margin-left: 369px; }
|}];
let e37_b = [%css {|
  margin-left: 370px;
|}];
show_parts("E37", [("parent", e37_a), ("child", e37_b)]);

/* E38: [%styled.global] rule `.e38-hook` (specificity 0,1,0) vs an atom
   intended: B */
module E38_global = [%styled.global {|
  .e38-hook { margin-left: 371px; }
|}];
let _ = E38_global.make;
let e38_b = [%css {|
  margin-left: 372px;
|}];
show_parts("E38", [("b", e38_b)]);

/* E39: [%styled.global] rule `div.e39-hook` (specificity 0,1,1) vs an atom
   intended: A */
module E39_global = [%styled.global {|
  div.e39-hook { margin-left: 373px; }
|}];
let _ = E39_global.make;
let e39_b = [%css {|
  margin-left: 374px;
|}];
show_parts("E39", [("b", e39_b)]);

/* E40: custom property, A base, B @media, the same name
   intended: B */
let e40_a = [%css {|
  --e40-x: 375px;
|}];
let e40_b = [%css {|
  @media (max-width: 1200px) { --e40-x: 376px; }
|}];
show("E40", [("a", e40_a), ("b", e40_b)], CSS.merge(e40_a, e40_b));

/* E41: two custom properties with different names, same context
   intended: both apply (different properties) */
let e41_a = [%css {|
  --e41-x: 377px;
|}];
let e41_b = [%css {|
  --e41-y: 378px;
|}];
show("E41", [("a", e41_a), ("b", e41_b)], CSS.merge(e41_a, e41_b));

/* E42: A word-wrap, B overflow-wrap (spec alias of A), same context
   intended: B */
let e42_a = [%css {|
  word-wrap: break-word;
|}];
let e42_b = [%css {|
  overflow-wrap: anywhere;
|}];
show("E42", [("a", e42_a), ("b", e42_b)], CSS.merge(e42_a, e42_b));

/* E43: pseudo-class chains of equal specificity, A :hover:focus-within (sum 270), B :active:first-child (sum 222)
   intended: B */
let e43_a = [%css {|
  &:hover:focus-within { margin-left: 379px; }
|}];
let e43_b = [%css {|
  &:active:first-child { margin-left: 380px; }
|}];
show("E43", [("a", e43_a), ("b", e43_b)], CSS.merge(e43_a, e43_b));

/* E44: one block, the same property twice in the same context
   intended: B
   note: control. Both declarations sit in one atom, so there is no A and B class to tell apart; the later declaration wins in the browser */
let e44 = [%css {|
  margin-left: 381px;
  margin-left: 382px;
|}];
show("E44", [], e44);

/* E45: A left, B inset-inline-start (no prefixed twin, so both sit at depth 1), A defined before B
   intended: B
   note: control for E08, whose logical longhand gains a -webkit- twin */
let e45_a = [%css {|
  left: 383px;
|}];
let e45_b = [%css {|
  inset-inline-start: 384px;
|}];
show("E45", [("a", e45_a), ("b", e45_b)], CSS.merge(e45_a, e45_b));
