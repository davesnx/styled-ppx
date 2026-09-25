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
  [@@@css ".a-k008qs{display:flex;}"]
  [@@@css ".a-1tyndxa{justify-content:center;}"]
  [@@@css ".in-kusjgz{color:var(--color-1a279q8);}"]
  [@@@css ".in-15a4g54{margin-block:var(--spacing-y96o3b);}"]
  [@@@css ".in-15a4g54{margin-inline:var(--spacing-vh5lkd);}"]
  [@@@css ".in-15a4g54{padding-block-start:var(--spacing-f3qjr);}"]
  [@@@css
    ".in-15a4g54{-webkit-padding-inline-end:var(--spacing-f3qjr);padding-inline-end:var(--spacing-f3qjr);}"]
  [@@@css ".in-15a4g54{inset-block-start:var(--spacing-f3qjr);}"]
  [@@@css ".a-zqnfaz:hover{opacity:0.8;}"]
  [@@@css ".a-osffsa .child{-webkit-flex:1;-ms-flex:1;flex:1;}"]
  [@@@css "@media (max-width: 768px) {.a-1ruz0a1{display:block;}}"]
  [@@@css ".a-6xix1i{font-size:16px;}"]
  [@@@css "@media (max-width: 768px) {.a-1l3vtdj{font-size:14px;}}"]
  [@@@css "@media (max-width: 480px) {.a-2b7vub{font-size:12px;}}"]
  [@@@css ".a-5ivle1 .item{-webkit-flex:1;-ms-flex:1;flex:1;}"]
  [@@@css
    "@media (max-width: 768px) {.a-1cemfq6{-webkit-flex-direction:column;-ms-flex-direction:column;flex-direction:column;}}"]
  [@@@css
    "@media (max-width: 768px) {.a-1l7frkw .item{-webkit-flex:none;-ms-flex:none;flex:none;}}"]
  [@@@css ".a-lgj0h8{display:grid;}"]
  [@@@css
    "@media screen and (min-width: 768px) and (max-width: 1024px) {.a-mhiow9{display:flex;}}"]
  [@@@css
    "@media (prefers-color-scheme: dark) {.a-1nm9mde{background-color:#1a1a1a;}}"]
  [@@@css "@media (max-width: 768px) {.a-11qknlj{opacity:0.8;}}"]
  [@@@css "@keyframes k-jw9oix{from{opacity:0;}to{opacity:1;}}"]
  [@@@css
    "@keyframes k-waibjx{0%{-webkit-transform:translateY(100%);-moz-transform:translateY(100%);-ms-transform:translateY(100%);transform:translateY(100%);}100%{-webkit-transform:translateY(0);-moz-transform:translateY(0);-ms-transform:translateY(0);transform:translateY(0);}}"]
  [@@@css ".in-1sq1nk7{color:var(--primary-19vrfgr);}"]
  [@@@css ".in-1sq1nk7{background-color:var(--secondary-1dc81fi);}"]
  [@@@css ".in-1sq1nk7{font-size:var(--size-3mc4ty);}"]
  [@@@css ".a-nk32ej{padding:10px;}"]
  [@@@css ".a-bghlac{grid-template-columns:1fr 2fr 1fr;}"]
  [@@@css ".a-16610y9{gap:20px;}"]
  [@@@css ".a-pdjuhq{scroll-behavior:smooth;}"]
  [@@@css ".a-13v3rg8{overflow-y:auto;}"]
  [@@@css.bindings
    [("Input.staticCss", "id-1ctni4v", "a-k008qs a-1tyndxa");
    ("Input.dynamicCss", "id-71zk3w", "in-kusjgz a-k008qs");
    ("Input.logicalProps", "id-r1294l", "in-15a4g54");
    ("Input.nestedCss", "id-apdklp", "a-k008qs a-zqnfaz a-osffsa");
    ("Input.responsiveCss", "id-1glbybz", "a-k008qs a-1ruz0a1");
    ("Input.multipleMediaQueries", "id-4peqig", "a-6xix1i a-1l3vtdj a-2b7vub");
    ("Input.mediaWithSelector", "id-1jbme7d",
      "a-k008qs a-5ivle1 a-1cemfq6 a-1l7frkw");
    ("Input.complexMedia", "id-yh1q8l", "a-lgj0h8 a-mhiow9 a-1nm9mde");
    ("Input.mediaWithInterpolation", "id-1c8phv0", "in-kusjgz a-11qknlj");
    ("Input.multiVar", "id-ckhvyf", "in-1sq1nk7 a-nk32ej");
    ("Input.gridCss", "id-nutj5n", "a-lgj0h8 a-bghlac a-16610y9");
    ("Input.scrollCss", "id-1d2kyt3", "a-pdjuhq a-13v3rg8")]]
  let staticCss = CSS.make "label:staticCss id-1ctni4v a-k008qs a-1tyndxa" []
  let dynamicCss color =
    CSS.make "label:dynamicCss id-71zk3w in-kusjgz a-k008qs"
      [("--color-1a279q8", (CSS.Types.Color.toString color))]
  let logicalProps spacing =
    CSS.make "label:logicalProps id-r1294l in-15a4g54"
      [("--spacing-y96o3b", (CSS.Types.MarginBlock.toString spacing));
      ("--spacing-vh5lkd", (CSS.Types.MarginInline.toString spacing));
      ("--spacing-f3qjr", (CSS.Types.Length.toString spacing))]
  let nestedCss =
    CSS.make "label:nestedCss id-apdklp a-k008qs a-zqnfaz a-osffsa" []
  let responsiveCss =
    CSS.make "label:responsiveCss id-1glbybz a-k008qs a-1ruz0a1" []
  let multipleMediaQueries =
    CSS.make "label:multipleMediaQueries id-4peqig a-6xix1i a-1l3vtdj a-2b7vub"
      []
  let mediaWithSelector =
    CSS.make
      "label:mediaWithSelector id-1jbme7d a-k008qs a-5ivle1 a-1cemfq6 a-1l7frkw"
      []
  let complexMedia =
    CSS.make "label:complexMedia id-yh1q8l a-lgj0h8 a-mhiow9 a-1nm9mde" []
  let mediaWithInterpolation color =
    CSS.make "label:mediaWithInterpolation id-1c8phv0 in-kusjgz a-11qknlj"
      [("--color-1a279q8", (CSS.Types.Color.toString color))]
  let fadeIn = CSS.Types.AnimationName.make "k-jw9oix"
  let slideUp = CSS.Types.AnimationName.make "k-waibjx"
  module GlobalReset =
    struct
      let to_string () = ""
      let makeProps ?key () = Js.Obj.empty ()[@@warning "-27-32"]
      let make _props = CSS.global_style_tag (to_string ())
    end
  let multiVar primary secondary size =
    CSS.make "label:multiVar id-ckhvyf in-1sq1nk7 a-nk32ej"
      [("--primary-19vrfgr", (CSS.Types.Color.toString primary));
      ("--secondary-1dc81fi", (CSS.Types.Color.toString secondary));
      ("--size-3mc4ty", (CSS.Types.FontSize.toString size))]
  let gridCss =
    CSS.make "label:gridCss id-nutj5n a-lgj0h8 a-bghlac a-16610y9" []
  let scrollCss = CSS.make "label:scrollCss id-1d2kyt3 a-pdjuhq a-13v3rg8" []
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
  .a-k008qs{display:flex;}
  .a-1tyndxa{justify-content:center;}
  .in-kusjgz{color:var(--color-1a279q8);}
  .in-15a4g54{margin-block:var(--spacing-y96o3b);}
  .in-15a4g54{margin-inline:var(--spacing-vh5lkd);}
  .in-15a4g54{padding-block-start:var(--spacing-f3qjr);}
  .in-15a4g54{-webkit-padding-inline-end:var(--spacing-f3qjr);padding-inline-end:var(--spacing-f3qjr);}
  .in-15a4g54{inset-block-start:var(--spacing-f3qjr);}
  .a-zqnfaz:hover{opacity:0.8;}
  .a-osffsa .child{-webkit-flex:1;-ms-flex:1;flex:1;}
  @media (max-width: 768px) {.a-1ruz0a1{display:block;}}
  .a-6xix1i{font-size:16px;}
  @media (max-width: 768px) {.a-1l3vtdj{font-size:14px;}}
  @media (max-width: 480px) {.a-2b7vub{font-size:12px;}}
  .a-5ivle1 .item{-webkit-flex:1;-ms-flex:1;flex:1;}
  @media (max-width: 768px) {.a-1cemfq6{-webkit-flex-direction:column;-ms-flex-direction:column;flex-direction:column;}}
  @media (max-width: 768px) {.a-1l7frkw .item{-webkit-flex:none;-ms-flex:none;flex:none;}}
  .a-lgj0h8{display:grid;}
  @media screen and (min-width: 768px) and (max-width: 1024px) {.a-mhiow9{display:flex;}}
  @media (prefers-color-scheme: dark) {.a-1nm9mde{background-color:#1a1a1a;}}
  @media (max-width: 768px) {.a-11qknlj{opacity:0.8;}}
  @keyframes k-jw9oix{from{opacity:0;}to{opacity:1;}}
  @keyframes k-waibjx{0%{-webkit-transform:translateY(100%);-moz-transform:translateY(100%);-ms-transform:translateY(100%);transform:translateY(100%);}100%{-webkit-transform:translateY(0);-moz-transform:translateY(0);-ms-transform:translateY(0);transform:translateY(0);}}
  .in-1sq1nk7{color:var(--primary-19vrfgr);}
  .in-1sq1nk7{background-color:var(--secondary-1dc81fi);}
  .in-1sq1nk7{font-size:var(--size-3mc4ty);}
  .a-nk32ej{padding:10px;}
  .a-bghlac{grid-template-columns:1fr 2fr 1fr;}
  .a-16610y9{gap:20px;}
  .a-pdjuhq{scroll-behavior:smooth;}
  .a-13v3rg8{overflow-y:auto;}
