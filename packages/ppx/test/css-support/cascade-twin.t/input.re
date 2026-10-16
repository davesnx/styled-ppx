/* Twin levels of the specificity twin: shapes where `CSS.merge` raises an atom
   to a twin class so that it wins by source order (see the test description).
   Every value is unique to its case, so no two cases share an atom and the
   sheet shows each pair alone. */

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

/* G52: three-way, left grouping. A @media(1200) border-top, B @media(900) border-color, C base border-top.
   B only overlaps A (top colour) and sits after it: B needs one twin level; C removes A, and must beat B (already a twin): two levels
   intended: C */
let g52_a = [%css {|
  @media (max-width: 1200px) { border-top: 1px solid rgb(10, 0, 0); }
|}];
let g52_b = [%css {|
  @media (max-width: 900px) { border-color: rgb(20, 0, 0); }
|}];
let g52_c = [%css {|
  border-top: 3px dotted rgb(30, 0, 0);
|}];
show("G52", [("a", g52_a), ("b", g52_b), ("c", g52_c)], CSS.merge(CSS.merge(g52_a, g52_b), g52_c));

/* G53: G52 with right grouping merge(a, merge(b, c))
   intended: C */
let g53_a = [%css {|
  @media (max-width: 1200px) { border-top: 1px solid rgb(11, 0, 0); }
|}];
let g53_b = [%css {|
  @media (max-width: 900px) { border-color: rgb(21, 0, 0); }
|}];
let g53_c = [%css {|
  border-top: 3px dotted rgb(31, 0, 0);
|}];
show("G53", [("a", g53_a), ("b", g53_b), ("c", g53_c)], CSS.merge(g53_a, CSS.merge(g53_b, g53_c)));

/* G54: two-way. A @media border-top, B base border-color (partial overlap, B after A)
   intended: B */
let g54_a = [%css {|
  @media (max-width: 1200px) { border-top: 1px solid rgb(12, 0, 0); }
|}];
let g54_b = [%css {|
  border-color: rgb(22, 0, 0);
|}];
show("G54", [("a", g54_a), ("b", g54_b)], CSS.merge(g54_a, g54_b));

/* G55: four-way chain of overlapping @media, each one after the last
   intended: D
   Needs three twin levels; the cap is two, so D stays at level 2 next to C (both `_t2_`) and the sheet order decides their tie: here the sheet puts D's `@media (max-width: 500px)` rule after C's, so D still wins, by position and not by specificity */
let g55_a = [%css {|
  @media (max-width: 1200px) { border-top: 1px solid rgb(13, 0, 0); }
|}];
let g55_b = [%css {|
  @media (max-width: 900px) { border-color: rgb(23, 0, 0); }
|}];
let g55_c = [%css {|
  @media (max-width: 700px) { border-top: 2px dashed rgb(33, 0, 0); }
|}];
let g55_d = [%css {|
  @media (max-width: 500px) { border-color: rgb(43, 0, 0); }
|}];
show("G55", [("a", g55_a), ("b", g55_b), ("c", g55_c), ("d", g55_d)], CSS.merge(CSS.merge(CSS.merge(g55_a, g55_b), g55_c), g55_d));

/* G56: author two-class selector `.g56-hook.g56-on` (0,2,0) against B, a merged atom that got a twin (0,2,0)
   intended: A (the author selector is the more specific one in plain CSS) */
module G56_global = [%styled.global {|
  .g56-hook.g56-on { margin-left: 561px; }
|}];
let _ = G56_global.make;
let g56_x = [%css {|
  @media (max-width: 1200px) { margin: 562px; }
|}];
let g56_y = [%css {|
  margin-left: 563px;
|}];
show_parts("G56", [("b", CSS.merge(g56_x, g56_y))]);

/* G57: A @media `font` shorthand (not split), B base font-size
   intended: B */
let g57_a = [%css {|
  @media (max-width: 1200px) { font: 14px/1.2 serif; }
|}];
let g57_b = [%css {|
  font-size: 16px;
|}];
show("G57", [("a", g57_a), ("b", g57_b)], CSS.merge(g57_a, g57_b));

/* G58: A @media(1200) padding-top, B @media(900) padding-top (twin), C `&:hover` padding-top
   intended: C (hover is more specific than an at-rule alone) */
let g58_a = [%css {|
  @media (max-width: 1200px) { padding-top: 581px; }
|}];
let g58_b = [%css {|
  @media (max-width: 900px) { padding-top: 582px; }
|}];
let g58_c = [%css {|
  &:hover { padding-top: 583px; }
|}];
show("G58", [("a", g58_a), ("b", g58_b), ("c", g58_c)], CSS.merge(CSS.merge(g58_a, g58_b), g58_c));

/* G59: A @media(1200) padding-left, B @media(900) padding: A's mask is covered by B's, so A is dropped and B needs no twin
   intended: B */
let g59_a = [%css {|
  @media (max-width: 1200px) { padding-left: 591px; }
|}];
let g59_b = [%css {|
  @media (max-width: 900px) { padding: 592px; }
|}];
show("G59", [("a", g59_a), ("b", g59_b)], CSS.merge(g59_a, g59_b));

/* G60: A @media(1200) padding-top, B `&:hover` padding-top, C @media(900) padding-top (C gets a twin, so the hover atom must follow)
   intended: B (hover is more specific than an at-rule alone) */
let g60_a = [%css {|
  @media (max-width: 1200px) { padding-top: 601px; }
|}];
let g60_b = [%css {|
  &:hover { padding-top: 602px; }
|}];
let g60_c = [%css {|
  @media (max-width: 900px) { padding-top: 603px; }
|}];
show("G60", [("a", g60_a), ("b", g60_b), ("c", g60_c)], CSS.merge(CSS.merge(g60_a, g60_b), g60_c));

/* G61: B is a selector list (`:hover, :focus`, a descendant list, a pseudo-element); the ppx makes one atom per branch, each with its own class and its own twin rule.
   C is an at-rule atom that gets a twin over A, so every branch of B is raised to the twin too
   intended: B (hover and focus are more specific than an at-rule alone) */
let g61_a = [%css {|
  @media (max-width: 1200px) { color: rgb(61, 0, 0); }
|}];
let g61_b = [%css {|
  &:hover, &:focus { color: rgb(62, 0, 0); }
  & a, & :is(b, i) { color: rgb(63, 0, 0); }
  &::placeholder { color: rgb(64, 0, 0); }
|}];
let g61_c = [%css {|
  @media (max-width: 900px) { color: rgb(65, 0, 0); }
|}];
show("G61", [("a", g61_a), ("b", g61_b), ("c", g61_c)], CSS.merge(CSS.merge(g61_a, g61_b), g61_c));
