open Cases;

let el = (~id, s, children) =>
  <div id className={CSS.className(s)} style={CSS.styles(s)}>
    {React.array(children)}
  </div>;

let page =
  <div>
    {el(~id="a1_rb", CSS.merge(a1(red), b1(blue)), [||])}
    {el(~id="a1_br", CSS.merge(b1(blue), a1(red)), [||])}
    {el(~id="a2_rb", CSS.merge(a2(red), b2(blue)), [||])}
    {el(~id="a2_br", CSS.merge(b2(blue), a2(red)), [||])}
    {el(~id="a3_rb", CSS.merge(a1(red), b3(blue)), [||])}
    {el(~id="a3_br", CSS.merge(b3(blue), a1(red)), [||])}
    {el(~id="b_parent", own(red), [|el(~id="b_child", own(blue), [||])|])}
    {el(
       ~id="c_direct_outer",
       direct(red),
       [|
         <span id="c_direct_mid" />,
         el(~id="c_direct_inner", direct(blue), [|<span id="c_direct_leaf" />|]),
       |],
     )}
    {el(
       ~id="c_desc_outer",
       desc(red),
       [|
         <div className="child" id="c_desc_mid" />,
         el(
           ~id="c_desc_inner",
           desc(blue),
           [|<div className="child" id="c_desc_leaf" />|],
         ),
       |],
     )}
    {el(~id="d_rb", CSS.merge(f(red), f(blue)), [||])}
    {el(~id="d_br", CSS.merge(f(blue), f(red)), [||])}
    {el(~id="e_rb", CSS.merge(Cases.a1(red), Other.a1(blue)), [||])}
    {el(~id="e_br", CSS.merge(Other.a1(blue), Cases.a1(red)), [||])}
    {el(
       ~id="e_outer",
       Cases.desc(red),
       [|
         el(
           ~id="e_inner",
           Other.desc(blue),
           [|<div className="child" id="e_leaf" />|],
         ),
         <div className="child" id="e_mid" />,
       |],
     )}
    {el(~id="f_host", CSS.merge(host, tone), [||])}
  </div>;

let () = print_endline(ReactDOM.renderToStaticMarkup(page));
