/* Remaining cascade gaps after the specificity twin: cases that need the
   twin to stay below an author selector of more class-like parts. Every
   value is unique to its case. */


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

/* R02: four state atoms on one property, merged in the order hover, focus, active, disabled
   intended: D
   note: the chain needs three twin levels and the cap is two, so active and disabled tie and the pseudo-class rank of the sheet decides; the sheet puts active after disabled, so the result differs from the intended winner and the test records the gap */
let r02_a = [%css {|
  &:hover { color: rgb(21, 0, 0); }
|}];
let r02_b = [%css {|
  &:focus { color: rgb(22, 0, 0); }
|}];
let r02_c = [%css {|
  &:active { color: rgb(23, 0, 0); }
|}];
let r02_d = [%css {|
  &:disabled { color: rgb(24, 0, 0); }
|}];
show("R02", [("a", r02_a), ("b", r02_b), ("c", r02_c), ("d", r02_d)], CSS.merge(CSS.merge(CSS.merge(r02_a, r02_b), r02_c), r02_d));

/* R02R: R02 in the reverse order, disabled, active, focus, hover
   intended: D
   note: focus and hover tie at the cap and the sheet puts focus after hover, so the result differs from the intended winner and the test records the gap */
let r02r_a = [%css {|
  &:disabled { color: rgb(25, 0, 0); }
|}];
let r02r_b = [%css {|
  &:active { color: rgb(26, 0, 0); }
|}];
let r02r_c = [%css {|
  &:focus { color: rgb(27, 0, 0); }
|}];
let r02r_d = [%css {|
  &:hover { color: rgb(28, 0, 0); }
|}];
show("R02R", [("a", r02r_a), ("b", r02r_b), ("c", r02r_c), ("d", r02r_d)], CSS.merge(CSS.merge(CSS.merge(r02r_a, r02r_b), r02r_c), r02r_d));

/* R03: A `&:hover:focus` (more specific), B `&:hover` after it
   intended: A (when both match, the rule with more pseudo-classes wins in plain CSS) */
let r03_a = [%css {|
  &:hover:focus { color: rgb(31, 0, 0); }
|}];
let r03_b = [%css {|
  &:hover { color: rgb(32, 0, 0); }
|}];
show("R03", [("a", r03_a), ("b", r03_b)], CSS.merge(r03_a, r03_b));

/* R04: A `& .child:focus`, B `& .child:hover` (equal specificity, descendant on both sides)
   intended: B */
let r04_b = [%css {|
  & .child:hover { color: rgb(42, 0, 0); }
|}];
let r04_a = [%css {|
  & .child:focus { color: rgb(41, 0, 0); }
|}];
show("R04", [("a", r04_a), ("b", r04_b)], CSS.merge(r04_a, r04_b));

/* R04P: A `&:focus::before`, B `&:hover::before` (pseudo-element on both sides)
   intended: B */
let r04p_a = [%css {|
  &:focus::before { color: rgb(43, 0, 0); }
|}];
let r04p_b = [%css {|
  &:hover::before { color: rgb(44, 0, 0); }
|}];
show("R04P", [("a", r04p_a), ("b", r04p_b)], CSS.merge(r04p_a, r04p_b));

/* R05: A and B both !important, in two different @media
   intended: B */
let r05_a = [%css {|
  @media (max-width: 1200px) { color: rgb(51, 0, 0) !important; }
|}];
let r05_b = [%css {|
  @media (max-width: 900px) { color: rgb(52, 0, 0) !important; }
|}];
show("R05", [("a", r05_a), ("b", r05_b)], CSS.merge(r05_a, r05_b));

/* R05P: A !important in @media, B plain base after it
   intended: A (an important declaration beats a later plain one) */
let r05p_a = [%css {|
  @media (max-width: 1200px) { color: rgb(53, 0, 0) !important; }
|}];
let r05p_b = [%css {|
  color: rgb(54, 0, 0);
|}];
show("R05P", [("a", r05p_a), ("b", r05p_b)], CSS.merge(r05p_a, r05p_b));

/* R09: nested media, one inner sibling rewrite. A is one nested `@media (min-width: 100px) { @media (max-width: 1200px) }`,
   B has the same nest twice, `(max-width: 1200px)` and `(max-width: 900px)`, and the first one is rewritten to exclude the second
   intended: B
   note: the first atom of B has the context of A (the rewrite is block-local), so merge drops A and keeps both atoms of B */
let r09_a = [%css {|
  @media (min-width: 100px) { @media (max-width: 1200px) { color: rgb(91, 0, 0); } }
|}];
let r09_b = [%css {|
  @media (min-width: 100px) {
    @media (max-width: 1200px) { color: rgb(92, 0, 0); }
    @media (max-width: 900px) { color: rgb(93, 0, 0); }
  }
|}];
show("R09", [("a", r09_a), ("b", r09_b)], CSS.merge(r09_a, r09_b));

/* R09R: R09 with the operands swapped
   intended: B
   note: A, one atom with the context of B's first atom, drops it and wins over B's second atom by its twin */
show("R09R", [("a", r09_b), ("b", r09_a)], CSS.merge(r09_b, r09_a));

/* R09S: the same nest written in the other order, with the inner rewrite
   intended: B */
let r09s_a = [%css {|
  @media (max-width: 1200px) { @media (min-width: 100px) { color: rgb(94, 0, 0); } }
|}];
show("R09S", [("a", r09_b), ("b", r09s_a)], CSS.merge(r09_b, r09s_a));

/* R08B: author two-class selector `.r08b-a.r08b-b` (0,2,0) against B, a merged atom at twin level 2
   (A @media border-top, B @media border-color needs level 1, C base border-top needs level 2)
   intended: A (the author selector is the more specific one in plain CSS) */
module R08b_global = [%styled.global {|
  .r08b-a.r08b-b { border-top-width: 801px; }
|}];
let _ = R08b_global.make;
let r08b_x = [%css {|
  @media (max-width: 1200px) { border-top: 802px solid rgb(80, 0, 0); }
|}];
let r08b_y = [%css {|
  @media (max-width: 900px) { border-color: rgb(81, 0, 0); }
|}];
let r08b_z = [%css {|
  border-top: 804px dotted rgb(82, 0, 0);
|}];
show_parts("R08B", [("b", CSS.merge(CSS.merge(r08b_x, r08b_y), r08b_z))]);

/* R08C: author three-class selector `.r08c-a.r08c-b.r08c-c` (0,3,0) against B, a merged atom at twin level 2
   intended: A (the author selector is the more specific one in plain CSS) */
module R08c_global = [%styled.global {|
  .r08c-a.r08c-b.r08c-c { border-top-width: 811px; }
|}];
let _ = R08c_global.make;
let r08c_x = [%css {|
  @media (max-width: 1200px) { border-top: 812px solid rgb(81, 0, 0); }
|}];
let r08c_y = [%css {|
  @media (max-width: 900px) { border-color: rgb(82, 0, 0); }
|}];
let r08c_z = [%css {|
  border-top: 814px dotted rgb(83, 0, 0);
|}];
show_parts("R08C", [("b", CSS.merge(CSS.merge(r08c_x, r08c_y), r08c_z))]);

/* R08D: author one-class selector `.r08d-a` (0,1,0) against B, a merged atom at twin level 1
   intended: B (a twin beats one class whatever the sheet order)
   note: control */
module R08d_global = [%styled.global {|
  .r08d-a { margin-left: 821px; }
|}];
let _ = R08d_global.make;
let r08d_x = [%css {|
  @media (max-width: 1200px) { margin: 822px; }
|}];
let r08d_y = [%css {|
  margin-left: 823px;
|}];
show_parts("R08D", [("b", CSS.merge(r08d_x, r08d_y))]);
