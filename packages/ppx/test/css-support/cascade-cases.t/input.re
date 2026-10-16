/* One binding or merge per class of competing declaration pair mined from the
   Ahrefs monorepo (see the test description). Every value is unique to its
   case, so no two cases share an atom and the sheet shows each pair alone. */

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

/* C01: merge drops A (same context, covered longhands)
   intended: B */
let c01_a = [%css {|
  margin-left: 101px;
|}];
let c01_b = [%css {|
  margin-left: 102px;
|}];
show("C01", [("a", c01_a), ("b", c01_b)], CSS.merge(c01_a, c01_b));

/* C02: B is !important, A is not
   intended: B */
let c02_a = [%css {|
  margin-left: 103px;
|}];
let c02_b = [%css {|
  margin-left: 104px !important;
|}];
show("C02", [("a", c02_a), ("b", c02_b)], CSS.merge(c02_a, c02_b));

/* C03: A is !important, B is not
   intended: A
   note: an important declaration beats a later plain one in plain CSS, so A is right; the label said B before */
let c03_a = [%css {|
  margin-left: 105px !important;
|}];
let c03_b = [%css {|
  margin-left: 106px;
|}];
show("C03", [("a", c03_a), ("b", c03_b)], CSS.merge(c03_a, c03_b));

/* C04: B more specific than A (browser decides, order irrelevant)
   intended: B */
let c04_sticky = [%css ""];
let c04_a = [%css {|
  margin-left: 107px;
|}];
let c04_b = [%css {|
  &.$(c04_sticky) { margin-left: 108px; }
|}];
show("C04", [("ctx c04_sticky", c04_sticky), ("a", c04_a), ("b", c04_b)], CSS.merge(c04_a, c04_b));

/* C05: A more specific than B (browser decides, order irrelevant)
   intended: A
   note: the more specific selector wins whatever the source order, in plain CSS too; the label said B before */
let c05_a = [%css {|
  &:first-child { margin-left: 109px; }
|}];
let c05_b = [%css {|
  margin-left: 110px;
|}];
show("C05", [("a", c05_a), ("b", c05_b)], CSS.merge(c05_a, c05_b));

/* C06: equal specificity, A base, B @container, depth A=B
   intended: B */
let c06_a = [%css {|
  margin-left: 111px;
|}];
let c06_b = [%css {|
  @container (max-width: 768px) { margin-left: 112px; }
|}];
show("C06", [("a", c06_a), ("b", c06_b)], CSS.merge(c06_a, c06_b));

/* C07: equal specificity, A @media, B @media, depth A=B, A defined before B
   intended: B */
let c07_a = [%css {|
  @media (max-width: 1200px) { margin-left: 113px; }
|}];
let c07_b = [%css {|
  @media (max-width: 992px) { margin-left: 114px; }
|}];
show("C07", [("a", c07_a), ("b", c07_b)], CSS.merge(c07_a, c07_b));

/* C08: equal specificity, both base, depth A=B, A defined before B
   intended: B
   note: monorepo source: border: 1px solid $(v1) vs border-bottom: none; here B has a width so the winner is visible */
let c08_a_v1 = CSS.rgb(116, 0, 0);
let c08_a = [%css {|
  border: 115px solid $(c08_a_v1);
|}];
let c08_b = [%css {|
  border-bottom: 117px dotted;
|}];
show("C08", [("a", c08_a), ("b", c08_b)], CSS.merge(c08_a, c08_b));

/* C09: equal specificity, both base, depth A<B (shorthand then longhand)
   intended: B */
let c09_a = [%css {|
  margin: 118px;
|}];
let c09_b = [%css {|
  margin-left: 119px;
|}];
show("C09", [("a", c09_a), ("b", c09_b)], CSS.merge(c09_a, c09_b));

/* C10: equal specificity, @media vs @container, depth A=B, at-rank A<B
   intended: B */
let c10_a = [%css {|
  @media print { margin-left: 120px; }
|}];
let c10_b = [%css {|
  @container app-main (max-width: 768px) { margin-left: 121px; }
|}];
show("C10", [("a", c10_a), ("b", c10_b)], CSS.merge(c10_a, c10_b));

/* C11: equal specificity, :disabled then :hover, pseudo-rank A<B
   intended: B */
let c11_a = [%css {|
  &:disabled { margin-left: 122px !important; }
|}];
let c11_b = [%css {|
  &:hover { margin-left: 123px !important; }
|}];
show("C11", [("a", c11_a), ("b", c11_b)], CSS.merge(c11_a, c11_b));

/* C12: equal specificity, A :disabled (cond), B class-qualified (base), pseudo-rank A>B
   intended: B */
let c12_selected = [%css ""];
let c12_a = [%css {|
  &:disabled { margin-left: 124px; }
|}];
let c12_b = [%css {|
  &.$(c12_selected) { margin-left: 125px; }
|}];
show("C12", [("ctx c12_selected", c12_selected), ("a", c12_a), ("b", c12_b)], CSS.merge(c12_a, c12_b));

/* C13: equal specificity, A @container (cond), B base
   intended: B */
let c13_a = [%css {|
  @container (max-width: 768px) { margin-left: 126px; }
|}];
let c13_b = [%css {|
  margin-left: 127px;
|}];
show("C13", [("a", c13_a), ("b", c13_b)], CSS.merge(c13_a, c13_b));

/* C14: equal specificity, @media vs @media, depth A=B, B defined before A
   intended: B */
let c14_b = [%css {|
  @media (max-width: 1200px) { margin-left: 128px; }
|}];
let c14_a = [%css {|
  @media (max-width: 992px) { margin-left: 129px; }
|}];
show("C14", [("a", c14_a), ("b", c14_b)], CSS.merge(c14_a, c14_b));

/* C15: equal specificity, :hover then :disabled, pseudo-rank A>B
   intended: B */
let c15_a = [%css {|
  &:hover { margin-left: 130px !important; }
|}];
let c15_b = [%css {|
  &:disabled { margin-left: 131px !important; }
|}];
show("C15", [("a", c15_a), ("b", c15_b)], CSS.merge(c15_a, c15_b));

/* C16: A base longhand, B @media shorthand (depth A>B, at-rank A<B)
   intended: B
   note: monorepo source: overflow-y vs overflow */
let c16_a = [%css {|
  padding-top: 132px;
|}];
let c16_b = [%css {|
  @media (max-width: 768px) { padding: 133px; }
|}];
show("C16", [("a", c16_a), ("b", c16_b)], CSS.merge(c16_a, c16_b));

/* C17: equal specificity, A class-qualified (base), B :disabled (cond), pseudo-rank A<B
   intended: B */
let c17_buttonDisabled = [%css ""];
let c17_a = [%css {|
  &.$(c17_buttonDisabled) { margin-left: 134px; }
|}];
let c17_b = [%css {|
  &:disabled { margin-left: 135px; }
|}];
show("C17", [("ctx c17_buttonDisabled", c17_buttonDisabled), ("a", c17_a), ("b", c17_b)], CSS.merge(c17_a, c17_b));

/* C18: equal specificity, both base, depth A>B (longhand-ish then shorthand)
   intended: B */
let c18_a = [%css {|
  border-width: 136px;
|}];
let c18_b_v1 = CSS.rgb(138, 0, 0);
let c18_b = [%css {|
  border-bottom: 137px solid $(c18_b_v1);
|}];
show("C18", [("a", c18_a), ("b", c18_b)], CSS.merge(c18_a, c18_b));

/* C19: equal specificity, @media vs @media, depth A<B (shorthand then longhand)
   intended: B
   note: monorepo ranges (max-width: 767px) and (min-width: 768px)+(max-width: 1279px) never overlap; B's range is (max-width: 1279px) here so both can apply */
let c19_a_v1 = CSS.px(139);
let c19_a_v2 = CSS.px(140);
let c19_a_v3 = CSS.px(141);
let c19_a_v4 = CSS.px(142);
let c19_a = [%css {|
  @media (max-width: 767px) { padding: $(c19_a_v1) $(c19_a_v2) $(c19_a_v3) $(c19_a_v4); }
|}];
let c19_b_v1 = CSS.px(143);
let c19_b = [%css {|
  @media (max-width: 1279px) { padding-bottom: $(c19_b_v1); }
|}];
show("C19", [("a", c19_a), ("b", c19_b)], CSS.merge(c19_a, c19_b));

/* C20: equal specificity, descendant vs child combinator, both base, A defined before B
   intended: B */
let c20_a = [%css {|
  svg { margin-left: 144px !important; }
|}];
let c20_b = [%css {|
  & > svg { margin-left: 145px !important; }
|}];
show("C20", [("a", c20_a), ("b", c20_b)], CSS.merge(c20_a, c20_b));

/* C21: A base shorthand, B @media longhand (depth A<B)
   intended: B
   note: monorepo source: overflow vs overflow-y */
let c21_a = [%css {|
  padding: 146px;
|}];
let c21_b = [%css {|
  @media (max-width: 767px) { padding-top: 147px; }
|}];
show("C21", [("a", c21_a), ("b", c21_b)], CSS.merge(c21_a, c21_b));

/* C22: equal specificity, both class-qualified, B defined before A
   intended: B */
let c22_inputNoBorder = [%css ""];
let c22_inputError = [%css ""];
let c22_b = [%css {|
  &.$(c22_inputNoBorder) { margin-left: 148px; }
|}];
let c22_a_v1 = CSS.px(149);
let c22_a = [%css {|
  &.$(c22_inputError) { margin-left: $(c22_a_v1); }
|}];
show("C22", [("ctx c22_inputNoBorder", c22_inputNoBorder), ("ctx c22_inputError", c22_inputError), ("a", c22_a), ("b", c22_b)], CSS.merge(c22_a, c22_b));

/* C23: descendant: A base, B @media, depth A=B
   intended: B */
let c23_a = [%css {|
  & > a { margin-left: 150px; }
|}];
let c23_b = [%css {|
  @media (min-width: 1280px) { & > a { margin-left: 151px; } }
|}];
show("C23", [("a", c23_a), ("b", c23_b)], CSS.merge(c23_a, c23_b));

/* C24: A @media shorthand, B base longhand (depth A<B, at-rank A>B)
   intended: B
   note: monorepo source: overflow vs overflow-y */
let c24_a = [%css {|
  @media (max-width: 768px) { padding: 152px; }
|}];
let c24_b = [%css {|
  padding-top: 153px;
|}];
show("C24", [("a", c24_a), ("b", c24_b)], CSS.merge(c24_a, c24_b));

/* C25: descendant: both base, depth A<B (shorthand then longhand)
   intended: B */
let c25_a = [%css {|
  input { padding: 154px; }
|}];
let c25_b = [%css {|
  input { padding-right: 155px; }
|}];
show("C25", [("a", c25_a), ("b", c25_b)], CSS.merge(c25_a, c25_b));

/* C26: A :focus (cond) longhand, B class-qualified (base) shorthand (depth A>B)
   intended: B
   note: monorepo source: outline-style: none vs outline: 0 none transparent; values differ here so the winner is visible */
let c26_buttonSelected = [%css ""];
let c26_a = [%css {|
  &:focus { outline-style: dotted; }
|}];
let c26_b = [%css {|
  &.$(c26_buttonSelected) { outline: 156px dashed red; }
|}];
show("C26", [("ctx c26_buttonSelected", c26_buttonSelected), ("a", c26_a), ("b", c26_b)], CSS.merge(c26_a, c26_b));

/* C27: equal specificity, @media vs @media, depth A>B (longhand then shorthand)
   intended: B
   note: monorepo ranges never overlap; B's range is (max-width: 1279px) here */
let c27_a_v1 = CSS.px(157);
let c27_a = [%css {|
  @media (max-width: 767px) { padding-bottom: $(c27_a_v1); }
|}];
let c27_b_v1 = CSS.px(158);
let c27_b_v2 = CSS.px(159);
let c27_b_v3 = CSS.px(160);
let c27_b_v4 = CSS.px(161);
let c27_b = [%css {|
  @media (max-width: 1279px) { padding: $(c27_b_v1) $(c27_b_v2) $(c27_b_v3) $(c27_b_v4); }
|}];
show("C27", [("a", c27_a), ("b", c27_b)], CSS.merge(c27_a, c27_b));

/* C28: descendant: :hover then :disabled, pseudo-rank A>B
   intended: B */
let c28_a = [%css {|
  &:hover { span { margin-left: 162px !important; } }
|}];
let c28_b = [%css {|
  &:disabled { span { margin-left: 163px !important; } }
|}];
show("C28", [("a", c28_a), ("b", c28_b)], CSS.merge(c28_a, c28_b));

/* C29: @media print vs @media (max-width), operands in two files, A's file sorts first
   intended: B */
show("C29", [("a", C29_first.c29_a), ("b", C29_second.c29_b)], CSS.merge(C29_first.c29_a, C29_second.c29_b));

/* C29S: C29 with A's file sorting after B's file
   intended: B */
show("C29S", [("a", C29s_second.c29s_a), ("b", C29s_first.c29s_b)], CSS.merge(C29s_second.c29s_a, C29s_first.c29s_b));

/* C30: same block, descendant pseudo: @media vs @media, A defined before B
   intended: B
   note: the two @media ranges never overlap, so no width has two rules; the harness reports the winner per width (mixed) and only the sheet order is pinned */
let c30 = [%css {|
  th { &:first-child { @media (min-width: 768px) and (max-width: 1279px) { margin-left: 168px; } } }
  th { &:first-child { @media (max-width: 767px) { margin-left: 169px; } } }
|}];
show("C30", [], c30);

/* C31: descendant: :disabled then :hover, pseudo-rank A<B
   intended: B */
let c31_a = [%css {|
  &:disabled { span { margin-left: 170px !important; } }
|}];
let c31_b = [%css {|
  &:hover { span { margin-left: 171px !important; } }
|}];
show("C31", [("a", c31_a), ("b", c31_b)], CSS.merge(c31_a, c31_b));

/* C32: :focus longhand then :active shorthand (depth A>B, pseudo-rank A<B)
   intended: B
   note: monorepo source: outline-style: none vs outline: 0 none transparent; values differ here so the winner is visible */
let c32_a = [%css {|
  &:focus { outline-style: double; }
|}];
let c32_b = [%css {|
  &:active { outline: 172px groove red; }
|}];
show("C32", [("a", c32_a), ("b", c32_b)], CSS.merge(c32_a, c32_b));

/* C33: descendant: A @media, B base, depth A=B
   intended: B */
let c33_a = [%css {|
  @media (min-width: 1280px) { & > a { margin-left: 173px; } }
|}];
let c33_b = [%css {|
  & > a { margin-left: 174px; }
|}];
show("C33", [("a", c33_a), ("b", c33_b)], CSS.merge(c33_a, c33_b));

/* C34: A is an _in_ bundle (@container + :disabled), B @media, at-rank A>B
   intended: B
   note: per state. While `:disabled` is off B wins; while it is on, A's `:disabled` member wins by specificity (0,2,0 against a bare @media), as in plain CSS */
let c34_a_v1 = CSS.px(175);
let c34_a = [%css {|
  @container app-main (max-width: 992px) { margin-left: $(c34_a_v1); }
  &:disabled { margin-left: $(c34_a_v1); }
|}];
let c34_b = [%css {|
  @media (max-width: 1200px) { margin-left: 176px; }
|}];
show("C34", [("a", c34_a), ("b", c34_b)], CSS.merge(c34_a, c34_b));

/* C35: A is an _in_ bundle (:last-child + @media, :disabled), B ancestor-class (base)
   intended: B */
let c35_rowIndented = [%css ""];
let c35_a_v1 = CSS.px(177);
let c35_a = [%css {|
  &:last-child { @media (max-width: 1279px) { padding-left: $(c35_a_v1); } }
  &:disabled { padding-left: $(c35_a_v1); }
|}];
let c35_b_v1 = CSS.px(178);
let c35_b = [%css {|
  .$(c35_rowIndented) & { padding-left: $(c35_b_v1); }
|}];
show("C35", [("ctx c35_rowIndented", c35_rowIndented), ("a", c35_a), ("b", c35_b)], CSS.merge(c35_a, c35_b));

/* C36: same block: :first-child vs @media :nth-child(2)
   intended: B
   note: the two selectors can never match one element; only the sheet order is pinned */
let c36 = [%css {|
  &:first-child { margin-left: 179px; }
  @media (max-width: 1279px) { &:nth-child(2) { margin-left: 180px; } }
|}];
show("C36", [], c36);

/* C37: A base, B an _in_ bundle with equal key, operands in two files, A's file sorts first
   intended: B */
show("C37", [("a", C37_first.c37_a), ("b", C37_second.c37_b)], CSS.merge(C37_first.c37_a, C37_second.c37_b));

/* C37S: C37 with A's file sorting after B's file
   intended: B */
show("C37S", [("a", C37s_second.c37s_a), ("b", C37s_first.c37s_b)], CSS.merge(C37s_second.c37s_a, C37s_first.c37s_b));

/* C38: descendant: child combinator vs descendant, !important, B defined before A
   intended: B */
let c38_b = [%css {|
  input { margin-left: 185px !important; }
|}];
let c38_a = [%css {|
  & > input { margin-left: 186px !important; }
|}];
show("C38", [("a", c38_a), ("b", c38_b)], CSS.merge(c38_a, c38_b));

/* C39: same block: :first-child shorthand then :hover longhand (depth A<B)
   intended: B
   note: monorepo source: border-top: 0 then border-top-style: solid */
let c39 = [%css {|
  &:first-child { border-top: 187px dotted red; }
  &:hover { border-top-style: solid; }
|}];
show("C39", [], c39);

/* C40: same block, descendant: base longhand then @media shorthand (depth A>B)
   intended: B */
let c40_v1 = CSS.px(189);
let c40_v2 = CSS.px(190);
let c40 = [%css {|
  a { padding-bottom: $(c40_v1); }
  a { @media (max-width: 767px) { padding: 188px 0 $(c40_v2); } }
|}];
show("C40", [], c40);

/* C41: same block: ancestor-class (base) vs @media :first-child ancestor-class, depth A=B
   intended: B */
let c41_tbody = [%css ""];
let c41_rowTitleAlwaysVisible = [%css ""];
let c41_v1 = CSS.px(192);
let c41 = [%css {|
  .$(c41_tbody):first-child & { padding-top: 191px; }
  &:first-child { @media (max-width: 1279px) { .$(c41_rowTitleAlwaysVisible) & { padding-top: $(c41_v1); } } }
  &:disabled { padding-top: $(c41_v1); }
|}];
show("C41", [("ctx c41_tbody", c41_tbody), ("ctx c41_rowTitleAlwaysVisible", c41_rowTitleAlwaysVisible)], c41);

/* C42: same block, descendant: base shorthand then @media longhand (depth A<B)
   intended: B */
let c42 = [%css {|
  td { padding: 193px 194px; }
  @media (max-width: 767px) { td { padding-top: 195px; } }
|}];
show("C42", [], c42);

/* C43: A @media longhand, B an _in_ bundle shorthand (depth A>B, at-rank A>B)
   intended: B */
let c43_a = [%css {|
  @media (max-width: 767px) { margin-top: 196px; }
|}];
let c43_b_v1 = CSS.px(199);
let c43_b = [%css {|
  margin: 197px 0 $(c43_b_v1);
  &:disabled { margin: 198px 0 $(c43_b_v1); }
|}];
show("C43", [("a", c43_a), ("b", c43_b)], CSS.merge(c43_a, c43_b));

/* C44: same block, descendant: base shorthand then ancestor-pseudo longhand (depth A<B)
   intended: B */
let c44 = [%css {|
  td { &:first-child { border-width: 200px; } }
  &:last-child { td { border-bottom-width: 201px; } }
|}];
show("C44", [], c44);

/* C45: same block: class-qualified shorthand-ish then :disabled longhand, partial overlap
   intended: B */
let c45_compactButtonLeft = [%css ""];
let c45_v1 = CSS.rgb(204, 0, 0);
let c45_v2 = CSS.rgb(205, 0, 0);
let c45 = [%css {|
  &.$(c45_compactButtonLeft) { border-left: 202px solid $(c45_v1); }
  &:disabled { border-left: 203px solid $(c45_v1); }
  &:disabled { border-color: $(c45_v2); }
|}];
show("C45", [("ctx c45_compactButtonLeft", c45_compactButtonLeft)], c45);

/* C46: same block, pseudo-element: longhand then @media shorthand (depth A>B)
   intended: B
   note: monorepo source: animation-duration then animation: none; B has a duration here so the winner is visible. The prefixer adds -webkit-animation-duration; it counts as the longhand it is (depth 1), so the longhand rule lands after the shorthand, same as the unprefixed C32 */
let c46 = [%css {|
  &::before { animation-duration: 206s; }
  &::before { @media (prefers-reduced-motion: reduce) { animation: 207s ease; } }
|}];
show("C46", [], c46);

/* C47: same block: class-qualified @media (A) vs :hover bundle (B), at-rank A>B
   intended: B */
let c47_headerMenuOpened = [%css ""];
let c47_v1 = CSS.px(208);
let c47_v2 = CSS.px(209);
let c47 = [%css {|
  &.$(c47_headerMenuOpened) { @media (max-width: 767px) { margin-left: $(c47_v1); } }
  &:disabled { margin-left: $(c47_v1); }
  &:hover { margin-left: $(c47_v2); }
  &:disabled { margin-left: $(c47_v2); }
|}];
show("C47", [("ctx c47_headerMenuOpened", c47_headerMenuOpened)], c47);

/* C48: same block: :nth-child(2) vs @media :first-child, at-rank A<B, pseudo-rank A>B
   intended: B
   note: the two selectors can never match one element; only the sheet order is pinned */
let c48 = [%css {|
  &:nth-child(2) { margin-left: 210px; }
  @media (max-width: 1279px) { &:first-child { margin-left: 211px; } }
|}];
show("C48", [], c48);

/* C49: same block, descendant: :hover longhand then :focus shorthand (depth A>B)
   intended: B */
let c49 = [%css {|
  input { &:hover { border-color: rgb(213, 0, 0); } }
  input { &:focus { border: 212px solid rgb(214, 0, 0); } }
|}];
show("C49", [], c49);
