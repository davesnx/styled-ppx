/* Gaps of the base-removes merge rule: shapes where the author's intended
   winner and the winner `CSS.merge` produces can differ (see the test
   description). Every value is unique to its case, so no two cases share an
   atom and the sheet shows each pair alone. */

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

/* G01: A @media `padding: $(x)` (one path on four sides), B base padding-top
   intended: B */
let g01_x = CSS.px(111);
let g01_a = [%css {|
  @media (max-width: 1200px) { padding: $(g01_x); }
|}];
let g01_b = [%css {|
  padding-top: 112px;
|}];
show("G01", [("a", g01_a), ("b", g01_b)], CSS.merge(g01_a, g01_b));

/* G02: A @media `padding: $(a) $(b)` (each path on two sides), B base padding-top
   intended: B */
let g02_a_v1 = CSS.px(121);
let g02_a_v2 = CSS.px(122);
let g02_a = [%css {|
  @media (max-width: 1200px) { padding: $(g02_a_v1) $(g02_a_v2); }
|}];
let g02_b = [%css {|
  padding-top: 123px;
|}];
show("G02", [("a", g02_a), ("b", g02_b)], CSS.merge(g02_a, g02_b));

/* G03: A @media `padding: 131px $(x)` (static top and bottom, path on left and right), B base padding-top
   intended: B
   note: the path is repeated, and the top side is static */
let g03_x = CSS.px(132);
let g03_a = [%css {|
  @media (max-width: 1200px) { padding: 131px $(g03_x); }
|}];
let g03_b = [%css {|
  padding-top: 133px;
|}];
show("G03", [("a", g03_a), ("b", g03_b)], CSS.merge(g03_a, g03_b));

/* G04: A @media `padding: $(a) $(b) $(c) $(d)` (four distinct paths), B base padding-top
   intended: B
   note: control, no path repeats */
let g04_a_v1 = CSS.px(141);
let g04_a_v2 = CSS.px(142);
let g04_a_v3 = CSS.px(143);
let g04_a_v4 = CSS.px(144);
let g04_a = [%css {|
  @media (max-width: 1200px) { padding: $(g04_a_v1) $(g04_a_v2) $(g04_a_v3) $(g04_a_v4); }
|}];
let g04_b = [%css {|
  padding-top: 145px;
|}];
show("G04", [("a", g04_a), ("b", g04_b)], CSS.merge(g04_a, g04_b));

/* G05: A @media `padding: var(--g05-p, 152px)` (top-level var()), B base padding-top
   intended: B */
let g05_a = [%css {|
  @media (max-width: 1200px) { padding: var(--g05-p, 152px); }
|}];
let g05_b = [%css {|
  padding-top: 151px;
|}];
show("G05", [("a", g05_a), ("b", g05_b)], CSS.merge(g05_a, g05_b));

/* G06: A @media `padding: 161px`, B base `padding-top: $(x)` (interpolated)
   intended: B */
let g06_b_v1 = CSS.px(162);
let g06_a = [%css {|
  @media (max-width: 1200px) { padding: 161px; }
|}];
let g06_b = [%css {|
  padding-top: $(g06_b_v1);
|}];
show("G06", [("a", g06_a), ("b", g06_b)], CSS.merge(g06_a, g06_b));

/* G07: A is a group of atoms sharing one `$(x)` (base and @media on padding-top), B base padding-top
   intended: B */
let g07_a_v1 = CSS.px(171);
let g07_a = [%css {|
  padding-top: $(g07_a_v1);
  @media (max-width: 1200px) { padding-top: $(g07_a_v1); }
|}];
let g07_b = [%css {|
  padding-top: 172px;
|}];
show("G07", [("a", g07_a), ("b", g07_b)], CSS.merge(g07_a, g07_b));

/* G08: A @media `padding: $(x)`, B base shorthand `padding: 182px`
   intended: B
   note: the full masks match, so the base shorthand drops A */
let g08_a_v1 = CSS.px(181);
let g08_a = [%css {|
  @media (max-width: 1200px) { padding: $(g08_a_v1); }
|}];
let g08_b = [%css {|
  padding: 182px;
|}];
show("G08", [("a", g08_a), ("b", g08_b)], CSS.merge(g08_a, g08_b));

/* G09: A base padding-top, B is a group of atoms sharing one `$(x)` (base and @media)
   intended: B */
let g09_b_v1 = CSS.px(192);
let g09_a = [%css {|
  padding-top: 191px;
|}];
let g09_b = [%css {|
  padding-top: $(g09_b_v1);
  @media (max-width: 1200px) { padding-top: $(g09_b_v1); }
|}];
show("G09", [("a", g09_a), ("b", g09_b)], CSS.merge(g09_a, g09_b));

/* G10: A is a group of atoms sharing one `$(x)` (base and @media), B @media padding-top
   intended: B */
let g10_a_v1 = CSS.px(201);
let g10_a = [%css {|
  padding-top: $(g10_a_v1);
  @media (max-width: 1200px) { padding-top: $(g10_a_v1); }
|}];
let g10_b = [%css {|
  @media (max-width: 1200px) { padding-top: 202px; }
|}];
show("G10", [("a", g10_a), ("b", g10_b)], CSS.merge(g10_a, g10_b));

/* G11: A and B are both groups of atoms sharing one `$(x)`, on padding-top
   intended: B */
let g11_a_v1 = CSS.px(211);
let g11_a = [%css {|
  padding-top: $(g11_a_v1);
  @media (max-width: 1200px) { padding-top: $(g11_a_v1); }
|}];
let g11_b_v1 = CSS.px(212);
let g11_b = [%css {|
  padding-top: $(g11_b_v1);
  @media (max-width: 1200px) { padding-top: $(g11_b_v1); }
|}];
show("G11", [("a", g11_a), ("b", g11_b)], CSS.merge(g11_a, g11_b));

/* G12: A `.child` with @media color, B `.child` color (same selector, A has an extra at-rule)
   intended: B */
let g12_a = [%css {|
  & .child { @media (max-width: 1200px) { color: rgb(221, 0, 0); } }
|}];
let g12_b = [%css {|
  & .child { color: rgb(222, 0, 0); }
|}];
show("G12", [("a", g12_a), ("b", g12_b)], CSS.merge(g12_a, g12_b));

/* G13: A `&:hover` with @media color, B `&:hover` color (C33 shape)
   intended: B */
let g13_a = [%css {|
  &:hover { @media (max-width: 1200px) { color: rgb(231, 0, 0); } }
|}];
let g13_b = [%css {|
  &:hover { color: rgb(232, 0, 0); }
|}];
show("G13", [("a", g13_a), ("b", g13_b)], CSS.merge(g13_a, g13_b));

/* G14: A @media with `.child` inside (at-rule outside), B `.child` color
   intended: B */
let g14_a = [%css {|
  @media (max-width: 1200px) { & .child { color: rgb(241, 0, 0); } }
|}];
let g14_b = [%css {|
  & .child { color: rgb(242, 0, 0); }
|}];
show("G14", [("a", g14_a), ("b", g14_b)], CSS.merge(g14_a, g14_b));

/* G15: A and B both `.child` with the same @media (equal context)
   intended: B
   note: control */
let g15_a = [%css {|
  & .child { @media (max-width: 1200px) { color: rgb(251, 0, 0); } }
|}];
let g15_b = [%css {|
  & .child { @media (max-width: 1200px) { color: rgb(252, 0, 0); } }
|}];
show("G15", [("a", g15_a), ("b", g15_b)], CSS.merge(g15_a, g15_b));

/* G16: A `@supports { @media { padding } }`, B base padding-top
   intended: B */
let g16_a = [%css {|
  @supports (display: grid) { @media (max-width: 1200px) { padding: 261px; } }
|}];
let g16_b = [%css {|
  padding-top: 262px;
|}];
show("G16", [("a", g16_a), ("b", g16_b)], CSS.merge(g16_a, g16_b));

/* G17: A `@container { @media { margin-left } }`, B base margin-left
   intended: B */
let g17_a = [%css {|
  @container app-main (max-width: 1000px) { @media (max-width: 1200px) { margin-left: 271px; } }
|}];
let g17_b = [%css {|
  margin-left: 272px;
|}];
show("G17", [("a", g17_a), ("b", g17_b)], CSS.merge(g17_a, g17_b));

/* G18: A `@media { @container { margin-left } }`, B base margin-left
   intended: B */
let g18_a = [%css {|
  @media (max-width: 1200px) { @container app-main (max-width: 1000px) { margin-left: 281px; } }
|}];
let g18_b = [%css {|
  margin-left: 282px;
|}];
show("G18", [("a", g18_a), ("b", g18_b)], CSS.merge(g18_a, g18_b));

/* G19: A `@media { @supports }`, B `@supports { @media }` (same two at-rules, other nesting order)
   intended: B */
let g19_a = [%css {|
  @media (max-width: 1200px) { @supports (display: grid) { margin-left: 291px; } }
|}];
let g19_b = [%css {|
  @supports (display: grid) { @media (max-width: 1200px) { margin-left: 292px; } }
|}];
show("G19", [("a", g19_a), ("b", g19_b)], CSS.merge(g19_a, g19_b));

/* G20: A @media (max-width: 1200px), B @media (max-width: 900px), both apply below 900px
   intended: B */
let g20_a = [%css {|
  @media (max-width: 1200px) { margin-left: 301px; }
|}];
let g20_b = [%css {|
  @media (max-width: 900px) { margin-left: 302px; }
|}];
show("G20", [("a", g20_a), ("b", g20_b)], CSS.merge(g20_a, g20_b));

/* G21: A @media padding, B padding-top in the same @media (equal context)
   intended: B
   note: control */
let g21_a = [%css {|
  @media (max-width: 1200px) { padding: 311px; }
|}];
let g21_b = [%css {|
  @media (max-width: 1200px) { padding-top: 312px; }
|}];
show("G21", [("a", g21_a), ("b", g21_b)], CSS.merge(g21_a, g21_b));

/* G22: A @media (max-width: 900px) padding, B @media (max-width: 1200px) padding-top
   intended: B */
let g22_a = [%css {|
  @media (max-width: 900px) { padding: 321px; }
|}];
let g22_b = [%css {|
  @media (max-width: 1200px) { padding-top: 322px; }
|}];
show("G22", [("a", g22_a), ("b", g22_b)], CSS.merge(g22_a, g22_b));

/* G23: A @media `margin: 331px auto`, B base margin-left
   intended: B
   note: B sets only one side, so the winner is per property (A or B, reported as mixed): B for margin-left, A for the other three sides */
let g23_a = [%css {|
  @media (max-width: 1200px) { margin: 331px auto; }
|}];
let g23_b = [%css {|
  margin-left: 332px;
|}];
show("G23", [("a", g23_a), ("b", g23_b)], CSS.merge(g23_a, g23_b));

/* G24: A @media padding-inline (logical), B base padding-left (physical)
   intended: B
   note: left-to-right, so padding-inline-start and padding-left are one property. Known limit: the writing mode is unknown at compile time (see how-merging-works.md), so merge does not relate them */
let g24_a = [%css {|
  @media (max-width: 1200px) { padding-inline: 341px; }
|}];
let g24_b = [%css {|
  padding-left: 342px;
|}];
show("G24", [("a", g24_a), ("b", g24_b)], CSS.merge(g24_a, g24_b));

/* G25: A @media border shorthand, B base border-top-color
   intended: B */
let g25_a = [%css {|
  @media (max-width: 1200px) { border: 351px solid rgb(35, 1, 0); }
|}];
let g25_b = [%css {|
  border-top-color: rgb(35, 2, 0);
|}];
show("G25", [("a", g25_a), ("b", g25_b)], CSS.merge(g25_a, g25_b));

/* G26: A @media border-radius, B base border-top-left-radius
   intended: B */
let g26_a = [%css {|
  @media (max-width: 1200px) { border-radius: 361px; }
|}];
let g26_b = [%css {|
  border-top-left-radius: 362px;
|}];
show("G26", [("a", g26_a), ("b", g26_b)], CSS.merge(g26_a, g26_b));

/* G27: A @media `padding: 371px !important`, B base padding-top (not important)
   intended: A
   note: !important wins whatever the order, so the author asked for A */
let g27_a = [%css {|
  @media (max-width: 1200px) { padding: 371px !important; }
|}];
let g27_b = [%css {|
  padding-top: 372px;
|}];
show("G27", [("a", g27_a), ("b", g27_b)], CSS.merge(g27_a, g27_b));

/* G28: A @media `overflow: hidden`, B base overflow-y (monorepo shape)
   intended: B
   note: B sets only overflow-y, so the winner is per property (A or B, reported as mixed): B for overflow-y, A for overflow-x */
let g28_a = [%css {|
  @media (max-width: 1200px) { overflow: hidden; }
|}];
let g28_b = [%css {|
  overflow-y: auto;
|}];
show("G28", [("a", g28_a), ("b", g28_b)], CSS.merge(g28_a, g28_b));

/* G29: A @media gap, B base row-gap
   intended: B */
let g29_a = [%css {|
  @media (max-width: 1200px) { gap: 391px; }
|}];
let g29_b = [%css {|
  row-gap: 392px;
|}];
show("G29", [("a", g29_a), ("b", g29_b)], CSS.merge(g29_a, g29_b));

/* G30: A @media inset, B base top
   intended: B */
let g30_a = [%css {|
  @media (max-width: 1200px) { inset: 401px; }
|}];
let g30_b = [%css {|
  top: 402px;
|}];
show("G30", [("a", g30_a), ("b", g30_b)], CSS.merge(g30_a, g30_b));

/* G31: A @container padding, B base padding-top
   intended: B */
let g31_a = [%css {|
  @container app-main (max-width: 1000px) { padding: 411px; }
|}];
let g31_b = [%css {|
  padding-top: 412px;
|}];
show("G31", [("a", g31_a), ("b", g31_b)], CSS.merge(g31_a, g31_b));

/* G32: A @media `margin: 421px 422px 423px` (right and left share a value), B base margin-right
   intended: B */
let g32_a = [%css {|
  @media (max-width: 1200px) { margin: 421px 422px 423px; }
|}];
let g32_b = [%css {|
  margin-right: 424px;
|}];
show("G32", [("a", g32_a), ("b", g32_b)], CSS.merge(g32_a, g32_b));

/* G33: A @media padding-block (logical), B base padding-top (physical)
   intended: B
   note: known limit, as G24 */
let g33_a = [%css {|
  @media (max-width: 1200px) { padding-block: 431px; }
|}];
let g33_b = [%css {|
  padding-top: 432px;
|}];
show("G33", [("a", g33_a), ("b", g33_b)], CSS.merge(g33_a, g33_b));

/* G34: A `&:hover` padding, B `&:hover` padding-top (equal context)
   intended: B
   note: control */
let g34_a = [%css {|
  &:hover { padding: 441px; }
|}];
let g34_b = [%css {|
  &:hover { padding-top: 442px; }
|}];
show("G34", [("a", g34_a), ("b", g34_b)], CSS.merge(g34_a, g34_b));

/* G35: A @media padding, B base `padding-top: 452px !important`
   intended: B */
let g35_a = [%css {|
  @media (max-width: 1200px) { padding: 451px; }
|}];
let g35_b = [%css {|
  padding-top: 452px !important;
|}];
show("G35", [("a", g35_a), ("b", g35_b)], CSS.merge(g35_a, g35_b));

/* G36: A @media padding, B base padding-top
   intended: B
   note: control, the case the base-removes rule was built for */
let g36_a = [%css {|
  @media (max-width: 1200px) { padding: 461px; }
|}];
let g36_b = [%css {|
  padding-top: 462px;
|}];
show("G36", [("a", g36_a), ("b", g36_b)], CSS.merge(g36_a, g36_b));

/* G37: A @media font shorthand, B base font-size
   intended: B */
let g37_a = [%css {|
  @media (max-width: 1200px) { font: 14px/47px serif; }
|}];
let g37_b = [%css {|
  font-size: 29px;
|}];
show("G37", [("a", g37_a), ("b", g37_b)], CSS.merge(g37_a, g37_b));

/* G38: A @media background shorthand, B base background-color
   intended: B */
let g38_a = [%css {|
  @media (max-width: 1200px) { background: rgb(48, 0, 0); }
|}];
let g38_b = [%css {|
  background-color: rgb(48, 0, 1);
|}];
show("G38", [("a", g38_a), ("b", g38_b)], CSS.merge(g38_a, g38_b));

/* G39: A @media flex shorthand, B base flex-grow
   intended: B */
let g39_a = [%css {|
  @media (max-width: 1200px) { flex: 1 1 491px; }
|}];
let g39_b = [%css {|
  flex-grow: 3;
|}];
show("G39", [("a", g39_a), ("b", g39_b)], CSS.merge(g39_a, g39_b));

/* G40: A @media border-width, B base border-top-width
   intended: B */
let g40_a = [%css {|
  @media (max-width: 1200px) { border-width: 501px; }
|}];
let g40_b = [%css {|
  border-top-width: 502px;
|}];
show("G40", [("a", g40_a), ("b", g40_b)], CSS.merge(g40_a, g40_b));

/* G41: A base padding shorthand, B @media padding-top
   intended: B
   note: control, nothing is dropped, the sheet puts the @media rule last */
let g41_a = [%css {|
  padding: 511px;
|}];
let g41_b = [%css {|
  @media (max-width: 1200px) { padding-top: 512px; }
|}];
show("G41", [("a", g41_a), ("b", g41_b)], CSS.merge(g41_a, g41_b));

/* G42: A base `padding: 521px !important`, B base padding-top
   intended: A
   note: !important wins whatever the order */
let g42_a = [%css {|
  padding: 521px !important;
|}];
let g42_b = [%css {|
  padding-top: 522px;
|}];
show("G42", [("a", g42_a), ("b", g42_b)], CSS.merge(g42_a, g42_b));

/* G43: three-way, left grouping: merge(merge(a, b), c); a base padding, b @media padding, c base padding-top
   intended: C on top, B elsewhere
   note: per property (B or C, reported as mixed): C for padding-top, B for the other sides */
let g43_a = [%css {|
  padding: 531px;
|}];
let g43_b = [%css {|
  @media (max-width: 1200px) { padding: 532px; }
|}];
let g43_c = [%css {|
  padding-top: 533px;
|}];
show("G43", [("a", g43_a), ("b", g43_b), ("c", g43_c)], CSS.merge(CSS.merge(g43_a, g43_b), g43_c));

/* G44: G43 with right grouping: merge(a, merge(b, c))
   intended: C on top, B elsewhere
   note: per property (B or C, reported as mixed): C for padding-top, B for the other sides */
let g44_a = [%css {|
  padding: 541px;
|}];
let g44_b = [%css {|
  @media (max-width: 1200px) { padding: 542px; }
|}];
let g44_c = [%css {|
  padding-top: 543px;
|}];
show("G44", [("a", g44_a), ("b", g44_b), ("c", g44_c)], CSS.merge(g44_a, CSS.merge(g44_b, g44_c)));

/* G45: three-way, left grouping: a base padding-top, b @media padding-top, c base padding shorthand
   intended: C */
let g45_a = [%css {|
  padding-top: 551px;
|}];
let g45_b = [%css {|
  @media (max-width: 1200px) { padding-top: 552px; }
|}];
let g45_c = [%css {|
  padding: 553px;
|}];
show("G45", [("a", g45_a), ("b", g45_b), ("c", g45_c)], CSS.merge(CSS.merge(g45_a, g45_b), g45_c));

/* G46: G45 with right grouping
   intended: C */
let g46_a = [%css {|
  padding-top: 561px;
|}];
let g46_b = [%css {|
  @media (max-width: 1200px) { padding-top: 562px; }
|}];
let g46_c = [%css {|
  padding: 563px;
|}];
show("G46", [("a", g46_a), ("b", g46_b), ("c", g46_c)], CSS.merge(g46_a, CSS.merge(g46_b, g46_c)));

/* G47: one block, base padding then @media padding-top (no merge)
   intended: B */
let g47_a = [%css {|
  padding: 571px;
|}];
let g47_b = [%css {|
  @media (max-width: 1200px) { padding-top: 572px; }
|}];
let g47 = [%css {|
  padding: 571px;
  @media (max-width: 1200px) { padding-top: 572px; }
|}];
show("G47", [("a", g47_a), ("b", g47_b)], g47);

/* G48: one block, @media padding-top then base padding (no merge)
   intended: B */
let g48_a = [%css {|
  @media (max-width: 1200px) { padding-top: 581px; }
|}];
let g48_b = [%css {|
  padding: 582px;
|}];
let g48 = [%css {|
  @media (max-width: 1200px) { padding-top: 581px; }
  padding: 582px;
|}];
show("G48", [("a", g48_a), ("b", g48_b)], g48);

/* G49: one block, @media padding then base padding-top (no merge)
   intended: B */
let g49_a = [%css {|
  @media (max-width: 1200px) { padding: 591px; }
|}];
let g49_b = [%css {|
  padding-top: 592px;
|}];
let g49 = [%css {|
  @media (max-width: 1200px) { padding: 591px; }
  padding-top: 592px;
|}];
show("G49", [("a", g49_a), ("b", g49_b)], g49);

/* G50: one block, base padding-top then @media padding (no merge)
   intended: B */
let g50_a = [%css {|
  padding-top: 601px;
|}];
let g50_b = [%css {|
  @media (max-width: 1200px) { padding: 602px; }
|}];
let g50 = [%css {|
  padding-top: 601px;
  @media (max-width: 1200px) { padding: 602px; }
|}];
show("G50", [("a", g50_a), ("b", g50_b)], g50);

/* G51: A @media padding, B base padding-top, operands in two files, A's file sorts first
   intended: B */
show("G51", [("a", G51_first.g51_a), ("b", G51_second.g51_b)], CSS.merge(G51_first.g51_a, G51_second.g51_b));

/* G51S: G51 with A's file sorting after B's file
   intended: B */
show("G51S", [("a", G51s_second.g51s_a), ("b", G51s_first.g51s_b)], CSS.merge(G51s_second.g51s_a, G51s_first.g51s_b));
