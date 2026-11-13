  $ ../../../standalone.exe --impl input.ml -o output.ml
  $ cat output.ml
  [@@@css "@property --1ugawkv-0{syntax:\"*\";inherits:false;}"]
  [@@@css "@property --1e3z403-0{syntax:\"*\";inherits:false;}"]
  [@@@css "@property --1e3z403-1{syntax:\"*\";inherits:false;}"]
  [@@@css "@property --1e3z403-2{syntax:\"*\";inherits:false;}"]
  [@@@css "@property --9csk6n-0{syntax:\"*\";inherits:false;}"]
  [@@@css ":root{--primary-color:blue;}"]
  [@@@css "body{margin:0;font-family:system-ui, sans-serif;}"]
  [@@@css "@property --msxjyb-0{syntax:\"*\";inherits:false;}"]
  [@@@css "@property --msxjyb-1{syntax:\"*\";inherits:false;}"]
  [@@@css "@property --msxjyb-2{syntax:\"*\";inherits:false;}"]
  [@@@css ".css-tgurzr{display:flex;justify-content:center;}"]
  [@@@css ".css-1ugawkv{color:var(--1ugawkv-0);display:flex;}"]
  [@@@css
    ".css-1e3z403{margin-block:var(--1e3z403-0);margin-inline:var(--1e3z403-1);padding-block-start:var(--1e3z403-2);-webkit-padding-inline-end:var(--1e3z403-2);padding-inline-end:var(--1e3z403-2);inset-block-start:var(--1e3z403-2);}"]
  [@@@css
    ".css-1p3wah4{display:flex;}.css-1p3wah4:hover{opacity:0.8;}.css-1p3wah4 .child{-webkit-flex:1;-ms-flex:1;flex:1;}"]
  [@@@css
    ".css-gv5tqz{display:flex;}@media (max-width: 768px) {.css-gv5tqz{display:block;}}"]
  [@@@css
    ".css-1rrqy60{font-size:16px;}@media (max-width: 768px) {.css-1rrqy60{font-size:14px;}}@media (max-width: 480px) {.css-1rrqy60{font-size:12px;}}"]
  [@@@css
    ".css-hupo4c{display:flex;}.css-hupo4c .item{-webkit-flex:1;-ms-flex:1;flex:1;}@media (max-width: 768px) {.css-hupo4c{-webkit-flex-direction:column;-ms-flex-direction:column;flex-direction:column;}.css-hupo4c .item{-webkit-flex:none;-ms-flex:none;flex:none;}}"]
  [@@@css
    ".css-ff51k0{display:grid;}@media screen and (min-width: 768px) and (max-width: 1024px) {.css-ff51k0{display:flex;}}@media (prefers-color-scheme: dark) {.css-ff51k0{background-color:#1a1a1a;}}"]
  [@@@css
    ".css-9csk6n{color:var(--9csk6n-0);}@media (max-width: 768px) {.css-9csk6n{opacity:0.8;}}"]
  [@@@css "@keyframes keyframe-jw9oix{from{opacity:0;}to{opacity:1;}}"]
  [@@@css
    "@keyframes keyframe-waibjx{0%{-webkit-transform:translateY(100%);-moz-transform:translateY(100%);-ms-transform:translateY(100%);transform:translateY(100%);}100%{-webkit-transform:translateY(0);-moz-transform:translateY(0);-ms-transform:translateY(0);transform:translateY(0);}}"]
  [@@@css
    ".css-msxjyb{color:var(--msxjyb-0);background-color:var(--msxjyb-1);font-size:var(--msxjyb-2);padding:10px;}"]
  [@@@css
    ".css-1id5lxl{display:grid;grid-template-columns:1fr 2fr 1fr;gap:20px;}"]
  [@@@css ".css-17q9z0y{scroll-behavior:smooth;overflow-y:auto;}"]
  [@@@css.classes
    [("css-tgurzr", 10, "Input.staticCss", "input.ml", 4, 23, 4, 62);
    ("css-1ugawkv", 11, "Input.dynamicCss", "input.ml", 8, 2, 10, 0);
    ("css-1e3z403", 12, "Input.logicalProps", "input.ml", 16, 2, 21, 0);
    ("css-1p3wah4", 13, "Input.nestedCss", "input.ml", 27, 2, 34, 0);
    ("css-gv5tqz", 14, "Input.responsiveCss", "input.ml", 40, 2, 44, 0);
    ("css-1rrqy60", 15, "Input.multipleMediaQueries", "input.ml", 50, 2, 57, 0);
    ("css-hupo4c", 16, "Input.mediaWithSelector", "input.ml", 63, 2, 73, 0);
    ("css-ff51k0", 17, "Input.complexMedia", "input.ml", 79, 2, 86, 0);
    ("css-9csk6n", 18, "Input.mediaWithInterpolation", "input.ml", 92, 2, 96,
      0);
    ("css-msxjyb", 21, "Input.multiVar", "input.ml", 129, 2, 133, 0);
    ("css-1id5lxl", 22, "Input.gridCss", "input.ml", 139, 2, 142, 0);
    ("css-17q9z0y", 23, "Input.scrollCss", "input.ml", 145, 23, 145, 65)]]
  [@@@css.bindings
    [("Input.staticCss", "css-tgurzr");
    ("Input.dynamicCss", "");
    ("Input.logicalProps", "");
    ("Input.nestedCss", "css-1p3wah4");
    ("Input.responsiveCss", "css-gv5tqz");
    ("Input.multipleMediaQueries", "css-1rrqy60");
    ("Input.mediaWithSelector", "css-hupo4c");
    ("Input.complexMedia", "css-ff51k0");
    ("Input.mediaWithInterpolation", "");
    ("Input.multiVar", "");
    ("Input.gridCss", "css-1id5lxl");
    ("Input.scrollCss", "css-17q9z0y")]]
  let staticCss = CSS.make "css-tgurzr" []
  let dynamicCss color =
    CSS.make "css-1ugawkv" [("--1ugawkv-0", (CSS.Types.Color.toString color))]
  let logicalProps spacing =
    CSS.make "css-1e3z403"
      [("--1e3z403-0", (CSS.Types.MarginBlock.toString spacing));
      ("--1e3z403-1", (CSS.Types.MarginInline.toString spacing));
      ("--1e3z403-2", (CSS.Types.Length.toString spacing))]
  let nestedCss = CSS.make "css-1p3wah4" []
  let responsiveCss = CSS.make "css-gv5tqz" []
  let multipleMediaQueries = CSS.make "css-1rrqy60" []
  let mediaWithSelector = CSS.make "css-hupo4c" []
  let complexMedia = CSS.make "css-ff51k0" []
  let mediaWithInterpolation color =
    CSS.make "css-9csk6n" [("--9csk6n-0", (CSS.Types.Color.toString color))]
  let fadeIn = CSS.Types.AnimationName.make "keyframe-jw9oix"
  let slideUp = CSS.Types.AnimationName.make "keyframe-waibjx"
  module GlobalReset =
    struct
      let to_string () = ""
      let makeProps ?key () = Js.Obj.empty ()[@@warning "-27-32"]
      let make _props = CSS.global_style_tag (to_string ())
    end
  let multiVar primary secondary size =
    CSS.make "css-msxjyb"
      [("--msxjyb-0", (CSS.Types.Color.toString primary));
      ("--msxjyb-1", (CSS.Types.Color.toString secondary));
      ("--msxjyb-2", (CSS.Types.FontSize.toString size))]
  let gridCss = CSS.make "css-1id5lxl" []
  let scrollCss = CSS.make "css-17q9z0y" []
  let _ = ReactDOM.jsx "div" (ReactDOM.domProps ~className:(fst staticCss) ())
  let _ =
    ReactDOM.jsx "div"
      (ReactDOM.domProps ~className:(fst (dynamicCss CSS.red))
         ~style:(snd (dynamicCss CSS.red)) ())
  let _ =
    ReactDOM.jsx "div"
      (ReactDOM.domProps ~className:(fst (logicalProps (CSS.px 20)))
         ~style:(snd (logicalProps (CSS.px 20))) ())
  let _ =
    ReactDOM.jsx "div" (ReactDOM.domProps ~className:(fst responsiveCss) ())
  let _ =
    ReactDOM.jsx "div"
      (ReactDOM.domProps ~className:(fst multipleMediaQueries) ())
  let _ =
    ReactDOM.jsx "div"
      (ReactDOM.domProps ~className:(fst mediaWithSelector) ())
  let _ =
    ReactDOM.jsx "div" (ReactDOM.domProps ~className:(fst complexMedia) ())
  let _ =
    ReactDOM.jsx "div"
      (ReactDOM.domProps ~className:(fst (mediaWithInterpolation CSS.blue))
         ~style:(snd (mediaWithInterpolation CSS.blue)) ())

  $ styled-ppx.generate output.ml > styles.css
  $ cat styles.css
  /* This file is generated by styled-ppx, do not edit manually */
  @property --1ugawkv-0{syntax:"*";inherits:false;}
  @property --1e3z403-0{syntax:"*";inherits:false;}
  @property --1e3z403-1{syntax:"*";inherits:false;}
  @property --1e3z403-2{syntax:"*";inherits:false;}
  @property --9csk6n-0{syntax:"*";inherits:false;}
  :root{--primary-color:blue;}
  body{margin:0;font-family:system-ui, sans-serif;}
  @property --msxjyb-0{syntax:"*";inherits:false;}
  @property --msxjyb-1{syntax:"*";inherits:false;}
  @property --msxjyb-2{syntax:"*";inherits:false;}
  .css-tgurzr{display:flex;justify-content:center;}
  .css-1ugawkv{color:var(--1ugawkv-0);display:flex;}
  .css-1e3z403{margin-block:var(--1e3z403-0);margin-inline:var(--1e3z403-1);padding-block-start:var(--1e3z403-2);-webkit-padding-inline-end:var(--1e3z403-2);padding-inline-end:var(--1e3z403-2);inset-block-start:var(--1e3z403-2);}
  .css-1p3wah4{display:flex;}.css-1p3wah4:hover{opacity:0.8;}.css-1p3wah4 .child{-webkit-flex:1;-ms-flex:1;flex:1;}
  .css-gv5tqz{display:flex;}@media (max-width: 768px) {.css-gv5tqz{display:block;}}
  .css-1rrqy60{font-size:16px;}@media (max-width: 768px) {.css-1rrqy60{font-size:14px;}}@media (max-width: 480px) {.css-1rrqy60{font-size:12px;}}
  .css-hupo4c{display:flex;}.css-hupo4c .item{-webkit-flex:1;-ms-flex:1;flex:1;}@media (max-width: 768px) {.css-hupo4c{-webkit-flex-direction:column;-ms-flex-direction:column;flex-direction:column;}.css-hupo4c .item{-webkit-flex:none;-ms-flex:none;flex:none;}}
  .css-ff51k0{display:grid;}@media screen and (min-width: 768px) and (max-width: 1024px) {.css-ff51k0{display:flex;}}@media (prefers-color-scheme: dark) {.css-ff51k0{background-color:#1a1a1a;}}
  .css-9csk6n{color:var(--9csk6n-0);}@media (max-width: 768px) {.css-9csk6n{opacity:0.8;}}
  @keyframes keyframe-jw9oix{from{opacity:0;}to{opacity:1;}}
  @keyframes keyframe-waibjx{0%{-webkit-transform:translateY(100%);-moz-transform:translateY(100%);-ms-transform:translateY(100%);transform:translateY(100%);}100%{-webkit-transform:translateY(0);-moz-transform:translateY(0);-ms-transform:translateY(0);transform:translateY(0);}}
  .css-msxjyb{color:var(--msxjyb-0);background-color:var(--msxjyb-1);font-size:var(--msxjyb-2);padding:10px;}
  .css-1id5lxl{display:grid;grid-template-columns:1fr 2fr 1fr;gap:20px;}
  .css-17q9z0y{scroll-behavior:smooth;overflow-y:auto;}
