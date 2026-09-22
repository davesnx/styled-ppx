  $ ../../../standalone.exe --impl input.ml -o output.ml
  $ cat output.ml
  [@@@css "@property --color-1a279q8{syntax:\"*\";inherits:false;}"]
  [@@@css "@property --spacing-y96o3b{syntax:\"*\";inherits:false;}"]
  [@@@css "@property --spacing-vh5lkd{syntax:\"*\";inherits:false;}"]
  [@@@css "@property --spacing-f3qjr{syntax:\"*\";inherits:false;}"]
  [@@@css ":root{--primary-color:blue;}"]
  [@@@css "body{margin:0;font-family:system-ui, sans-serif;}"]
  [@@@css "@property --primary-19vrfgr{syntax:\"*\";inherits:false;}"]
  [@@@css "@property --secondary-1dc81fi{syntax:\"*\";inherits:false;}"]
  [@@@css "@property --size-3mc4ty{syntax:\"*\";inherits:false;}"]
  [@@@css ".css-k008qs{display:flex;}"]
  [@@@css ".css-1tyndxa{justify-content:center;}"]
  [@@@css ".css-kusjgz{color:var(--color-1a279q8);}"]
  [@@@css ".css-15a4g54{margin-block:var(--spacing-y96o3b);}"]
  [@@@css ".css-15a4g54{margin-inline:var(--spacing-vh5lkd);}"]
  [@@@css ".css-15a4g54{padding-block-start:var(--spacing-f3qjr);}"]
  [@@@css
    ".css-15a4g54{-webkit-padding-inline-end:var(--spacing-f3qjr);padding-inline-end:var(--spacing-f3qjr);}"]
  [@@@css ".css-15a4g54{inset-block-start:var(--spacing-f3qjr);}"]
  [@@@css ".css-zqnfaz:hover{opacity:0.8;}"]
  [@@@css ".css-osffsa .child{-webkit-flex:1;-ms-flex:1;flex:1;}"]
  [@@@css "@media (max-width: 768px) {.css-1ruz0a1{display:block;}}"]
  [@@@css ".css-6xix1i{font-size:16px;}"]
  [@@@css "@media (max-width: 768px) {.css-1l3vtdj{font-size:14px;}}"]
  [@@@css "@media (max-width: 480px) {.css-2b7vub{font-size:12px;}}"]
  [@@@css ".css-5ivle1 .item{-webkit-flex:1;-ms-flex:1;flex:1;}"]
  [@@@css
    "@media (max-width: 768px) {.css-1cemfq6{-webkit-flex-direction:column;-ms-flex-direction:column;flex-direction:column;}}"]
  [@@@css
    "@media (max-width: 768px) {.css-1l7frkw .item{-webkit-flex:none;-ms-flex:none;flex:none;}}"]
  [@@@css ".css-lgj0h8{display:grid;}"]
  [@@@css
    "@media screen and (min-width: 768px) and (max-width: 1024px) {.css-mhiow9{display:flex;}}"]
  [@@@css
    "@media (prefers-color-scheme: dark) {.css-1nm9mde{background-color:#1a1a1a;}}"]
  [@@@css "@media (max-width: 768px) {.css-11qknlj{opacity:0.8;}}"]
  [@@@css "@keyframes keyframe-jw9oix{from{opacity:0;}to{opacity:1;}}"]
  [@@@css
    "@keyframes keyframe-waibjx{0%{-webkit-transform:translateY(100%);-moz-transform:translateY(100%);-ms-transform:translateY(100%);transform:translateY(100%);}100%{-webkit-transform:translateY(0);-moz-transform:translateY(0);-ms-transform:translateY(0);transform:translateY(0);}}"]
  [@@@css ".css-1sq1nk7{color:var(--primary-19vrfgr);}"]
  [@@@css ".css-1sq1nk7{background-color:var(--secondary-1dc81fi);}"]
  [@@@css ".css-1sq1nk7{font-size:var(--size-3mc4ty);}"]
  [@@@css ".css-nk32ej{padding:10px;}"]
  [@@@css ".css-bghlac{grid-template-columns:1fr 2fr 1fr;}"]
  [@@@css ".css-16610y9{gap:20px;}"]
  [@@@css ".css-pdjuhq{scroll-behavior:smooth;}"]
  [@@@css ".css-13v3rg8{overflow-y:auto;}"]
  [@@@css.bindings
    [("Input.staticCss", "cid-1ctni4v", "css-k008qs css-1tyndxa");
    ("Input.dynamicCss", "cid-71zk3w", "css-kusjgz css-k008qs");
    ("Input.logicalProps", "cid-r1294l", "css-15a4g54");
    ("Input.nestedCss", "cid-apdklp", "css-k008qs css-zqnfaz css-osffsa");
    ("Input.responsiveCss", "cid-1glbybz", "css-k008qs css-1ruz0a1");
    ("Input.multipleMediaQueries", "cid-4peqig",
      "css-6xix1i css-1l3vtdj css-2b7vub");
    ("Input.mediaWithSelector", "cid-1jbme7d",
      "css-k008qs css-5ivle1 css-1cemfq6 css-1l7frkw");
    ("Input.complexMedia", "cid-yh1q8l", "css-lgj0h8 css-mhiow9 css-1nm9mde");
    ("Input.mediaWithInterpolation", "cid-1c8phv0", "css-kusjgz css-11qknlj");
    ("Input.multiVar", "cid-ckhvyf", "css-1sq1nk7 css-nk32ej");
    ("Input.gridCss", "cid-nutj5n", "css-lgj0h8 css-bghlac css-16610y9");
    ("Input.scrollCss", "cid-1d2kyt3", "css-pdjuhq css-13v3rg8")]]
  let staticCss =
    CSS.make ~label:"staticCss" "cid-1ctni4v css-k008qs css-1tyndxa" []
  let dynamicCss color =
    CSS.make ~label:"dynamicCss" "cid-71zk3w css-kusjgz css-k008qs"
      [("--color-1a279q8", (CSS.Types.Color.toString color))]
  let logicalProps spacing =
    CSS.make ~label:"logicalProps" "cid-r1294l css-15a4g54"
      [("--spacing-y96o3b", (CSS.Types.MarginBlock.toString spacing));
      ("--spacing-vh5lkd", (CSS.Types.MarginInline.toString spacing));
      ("--spacing-f3qjr", (CSS.Types.Length.toString spacing))]
  let nestedCss =
    CSS.make ~label:"nestedCss" "cid-apdklp css-k008qs css-zqnfaz css-osffsa"
      []
  let responsiveCss =
    CSS.make ~label:"responsiveCss" "cid-1glbybz css-k008qs css-1ruz0a1" []
  let multipleMediaQueries =
    CSS.make ~label:"multipleMediaQueries"
      "cid-4peqig css-6xix1i css-1l3vtdj css-2b7vub" []
  let mediaWithSelector =
    CSS.make ~label:"mediaWithSelector"
      "cid-1jbme7d css-k008qs css-5ivle1 css-1cemfq6 css-1l7frkw" []
  let complexMedia =
    CSS.make ~label:"complexMedia"
      "cid-yh1q8l css-lgj0h8 css-mhiow9 css-1nm9mde" []
  let mediaWithInterpolation color =
    CSS.make ~label:"mediaWithInterpolation"
      "cid-1c8phv0 css-kusjgz css-11qknlj"
      [("--color-1a279q8", (CSS.Types.Color.toString color))]
  let fadeIn = CSS.Types.AnimationName.make "keyframe-jw9oix"
  let slideUp = CSS.Types.AnimationName.make "keyframe-waibjx"
  module GlobalReset =
    struct
      let to_string () = ""
      let makeProps ?key () = Js.Obj.empty ()[@@warning "-27-32"]
      let make _props = CSS.global_style_tag (to_string ())
    end
  let multiVar primary secondary size =
    CSS.make ~label:"multiVar" "cid-ckhvyf css-1sq1nk7 css-nk32ej"
      [("--primary-19vrfgr", (CSS.Types.Color.toString primary));
      ("--secondary-1dc81fi", (CSS.Types.Color.toString secondary));
      ("--size-3mc4ty", (CSS.Types.FontSize.toString size))]
  let gridCss =
    CSS.make ~label:"gridCss" "cid-nutj5n css-lgj0h8 css-bghlac css-16610y9" []
  let scrollCss =
    CSS.make ~label:"scrollCss" "cid-1d2kyt3 css-pdjuhq css-13v3rg8" []
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
  @property --color-1a279q8{syntax:"*";inherits:false;}
  @property --spacing-y96o3b{syntax:"*";inherits:false;}
  @property --spacing-vh5lkd{syntax:"*";inherits:false;}
  @property --spacing-f3qjr{syntax:"*";inherits:false;}
  :root{--primary-color:blue;}
  body{margin:0;font-family:system-ui, sans-serif;}
  @property --primary-19vrfgr{syntax:"*";inherits:false;}
  @property --secondary-1dc81fi{syntax:"*";inherits:false;}
  @property --size-3mc4ty{syntax:"*";inherits:false;}
  .css-k008qs{display:flex;}
  .css-1tyndxa{justify-content:center;}
  .css-kusjgz{color:var(--color-1a279q8);}
  .css-15a4g54{margin-block:var(--spacing-y96o3b);}
  .css-15a4g54{margin-inline:var(--spacing-vh5lkd);}
  .css-15a4g54{padding-block-start:var(--spacing-f3qjr);}
  .css-15a4g54{-webkit-padding-inline-end:var(--spacing-f3qjr);padding-inline-end:var(--spacing-f3qjr);}
  .css-15a4g54{inset-block-start:var(--spacing-f3qjr);}
  .css-zqnfaz:hover{opacity:0.8;}
  .css-osffsa .child{-webkit-flex:1;-ms-flex:1;flex:1;}
  @media (max-width: 768px) {.css-1ruz0a1{display:block;}}
  .css-6xix1i{font-size:16px;}
  @media (max-width: 768px) {.css-1l3vtdj{font-size:14px;}}
  @media (max-width: 480px) {.css-2b7vub{font-size:12px;}}
  .css-5ivle1 .item{-webkit-flex:1;-ms-flex:1;flex:1;}
  @media (max-width: 768px) {.css-1cemfq6{-webkit-flex-direction:column;-ms-flex-direction:column;flex-direction:column;}}
  @media (max-width: 768px) {.css-1l7frkw .item{-webkit-flex:none;-ms-flex:none;flex:none;}}
  .css-lgj0h8{display:grid;}
  @media screen and (min-width: 768px) and (max-width: 1024px) {.css-mhiow9{display:flex;}}
  @media (prefers-color-scheme: dark) {.css-1nm9mde{background-color:#1a1a1a;}}
  @media (max-width: 768px) {.css-11qknlj{opacity:0.8;}}
  @keyframes keyframe-jw9oix{from{opacity:0;}to{opacity:1;}}
  @keyframes keyframe-waibjx{0%{-webkit-transform:translateY(100%);-moz-transform:translateY(100%);-ms-transform:translateY(100%);transform:translateY(100%);}100%{-webkit-transform:translateY(0);-moz-transform:translateY(0);-ms-transform:translateY(0);transform:translateY(0);}}
  .css-1sq1nk7{color:var(--primary-19vrfgr);}
  .css-1sq1nk7{background-color:var(--secondary-1dc81fi);}
  .css-1sq1nk7{font-size:var(--size-3mc4ty);}
  .css-nk32ej{padding:10px;}
  .css-bghlac{grid-template-columns:1fr 2fr 1fr;}
  .css-16610y9{gap:20px;}
  .css-pdjuhq{scroll-behavior:smooth;}
  .css-13v3rg8{overflow-y:auto;}
