/* Remaining cascade gaps after the specificity twin: cases that need the
   twin to stay below an author selector of more class-like parts. Every
   value is unique to its case. */


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
