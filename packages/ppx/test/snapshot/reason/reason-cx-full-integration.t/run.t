  $ ../../../standalone.exe --impl input.ml -o output.ml
  $ cat output.ml
  [@@@css "@property --color-1a279q8{syntax:\"*\";inherits:false;}"]
  [@@@css "@property --spacing-y96o3b{syntax:\"*\";inherits:false;}"]
  [@@@css "@property --spacing-vh5lkd{syntax:\"*\";inherits:false;}"]
  [@@@css "@property --spacing-f3qjr{syntax:\"*\";inherits:false;}"]
  [@@@css ":root{--primary-color:blue}"]
  [@@@css "body{margin:0;font-family:system-ui,sans-serif}"]
  [@@@css "@property --primary-19vrfgr{syntax:\"*\";inherits:false;}"]
  [@@@css "@property --secondary-1dc81fi{syntax:\"*\";inherits:false;}"]
  [@@@css "@property --size-3mc4ty{syntax:\"*\";inherits:false;}"]
  [@@@css ".css-k008qs-staticCss{display:flex}"]
  [@@@css ".css-1tyndxa-staticCss{justify-content:center}"]
  [@@@css ".css-kusjgz-dynamicCss{color:var(--color-1a279q8)}"]
  [@@@css ".css-k008qs-dynamicCss{display:flex}"]
  [@@@css ".css-15a4g54-logicalProps{margin-block:var(--spacing-y96o3b)}"]
  [@@@css ".css-15a4g54-logicalProps{margin-inline:var(--spacing-vh5lkd)}"]
  [@@@css
    ".css-15a4g54-logicalProps{padding-block-start:var(--spacing-f3qjr)}"]
  [@@@css
    ".css-15a4g54-logicalProps{-webkit-padding-inline-end:var(--spacing-f3qjr);padding-inline-end:var(--spacing-f3qjr)}"]
  [@@@css ".css-15a4g54-logicalProps{inset-block-start:var(--spacing-f3qjr)}"]
  [@@@css ".css-k008qs-nestedCss{display:flex}"]
  [@@@css ".css-t2xfa5-nestedCss:hover{opacity:0.8}"]
  [@@@css ".css-16i2mb0-nestedCss .child{-webkit-flex:1;-ms-flex:1;flex:1}"]
  [@@@css ".css-k008qs-responsiveCss{display:flex}"]
  [@@@css "@media (max-width:768px){.css-5ok5af-responsiveCss{display:block}}"]
  [@@@css ".css-6xix1i-multipleMediaQueries{font-size:16px}"]
  [@@@css
    "@media (max-width:768px){.css-15xbu8k-multipleMediaQueries{font-size:14px}}"]
  [@@@css
    "@media (max-width:480px){.css-t4luht-multipleMediaQueries{font-size:12px}}"]
  [@@@css ".css-k008qs-mediaWithSelector{display:flex}"]
  [@@@css
    ".css-r3okhn-mediaWithSelector .item{-webkit-flex:1;-ms-flex:1;flex:1}"]
  [@@@css
    "@media (max-width:768px){.css-2nmn4s-mediaWithSelector{-webkit-flex-direction:column;-ms-flex-direction:column;flex-direction:column}}"]
  [@@@css
    "@media (max-width:768px){.css-5tc233-mediaWithSelector .item{-webkit-flex:none;-ms-flex:none;flex:none}}"]
  [@@@css ".css-lgj0h8-complexMedia{display:grid}"]
  [@@@css
    "@media screen and (min-width:768px) and (max-width:1024px){.css-1xh9stc-complexMedia{display:flex}}"]
  [@@@css
    "@media (prefers-color-scheme:dark){.css-1spsdb6-complexMedia{background-color:#1a1a1a}}"]
  [@@@css ".css-kusjgz-mediaWithInterpolation{color:var(--color-1a279q8)}"]
  [@@@css
    "@media (max-width:768px){.css-ltnkwb-mediaWithInterpolation{opacity:0.8}}"]
  [@@@css "@keyframes keyframe-1urc19q{from{opacity:0}to{opacity:1}}"]
  [@@@css
    "@keyframes keyframe-1k51lkp{0%{-webkit-transform:translateY(100%);-moz-transform:translateY(100%);-ms-transform:translateY(100%);transform:translateY(100%)}100%{-webkit-transform:translateY(0);-moz-transform:translateY(0);-ms-transform:translateY(0);transform:translateY(0)}}"]
  [@@@css ".css-1sq1nk7-multiVar{color:var(--primary-19vrfgr)}"]
  [@@@css ".css-1sq1nk7-multiVar{background-color:var(--secondary-1dc81fi)}"]
  [@@@css ".css-1sq1nk7-multiVar{font-size:var(--size-3mc4ty)}"]
  [@@@css ".css-nk32ej-multiVar{padding:10px}"]
  [@@@css ".css-lgj0h8-gridCss{display:grid}"]
  [@@@css ".css-bghlac-gridCss{grid-template-columns:1fr 2fr 1fr}"]
  [@@@css ".css-16610y9-gridCss{gap:20px}"]
  [@@@css ".css-pdjuhq-scrollCss{scroll-behavior:smooth}"]
  [@@@css ".css-13v3rg8-scrollCss{overflow-y:auto}"]
  [@@@css.bindings
    [("Input.staticCss", "css-k008qs-staticCss css-1tyndxa-staticCss");
    ("Input.dynamicCss", "css-kusjgz-dynamicCss css-k008qs-dynamicCss");
    ("Input.logicalProps", "css-15a4g54-logicalProps");
    ("Input.nestedCss",
      "css-k008qs-nestedCss css-t2xfa5-nestedCss css-16i2mb0-nestedCss");
    ("Input.responsiveCss",
      "css-k008qs-responsiveCss css-5ok5af-responsiveCss");
    ("Input.multipleMediaQueries",
      "css-6xix1i-multipleMediaQueries css-15xbu8k-multipleMediaQueries css-t4luht-multipleMediaQueries");
    ("Input.mediaWithSelector",
      "css-k008qs-mediaWithSelector css-r3okhn-mediaWithSelector css-2nmn4s-mediaWithSelector css-5tc233-mediaWithSelector");
    ("Input.complexMedia",
      "css-lgj0h8-complexMedia css-1xh9stc-complexMedia css-1spsdb6-complexMedia");
    ("Input.mediaWithInterpolation",
      "css-kusjgz-mediaWithInterpolation css-ltnkwb-mediaWithInterpolation");
    ("Input.multiVar", "css-1sq1nk7-multiVar css-nk32ej-multiVar");
    ("Input.gridCss",
      "css-lgj0h8-gridCss css-bghlac-gridCss css-16610y9-gridCss");
    ("Input.scrollCss", "css-pdjuhq-scrollCss css-13v3rg8-scrollCss")]]
  let staticCss = CSS.make "css-k008qs-staticCss css-1tyndxa-staticCss" []
  let dynamicCss color =
    CSS.make "css-kusjgz-dynamicCss css-k008qs-dynamicCss"
      [("--color-1a279q8", (CSS.Types.Color.toString color))]
  let logicalProps spacing =
    CSS.make "css-15a4g54-logicalProps"
      [("--spacing-y96o3b", (CSS.Types.MarginBlock.toString spacing));
      ("--spacing-vh5lkd", (CSS.Types.MarginInline.toString spacing));
      ("--spacing-f3qjr", (CSS.Types.Length.toString spacing))]
  let nestedCss =
    CSS.make "css-k008qs-nestedCss css-t2xfa5-nestedCss css-16i2mb0-nestedCss"
      []
  let responsiveCss =
    CSS.make "css-k008qs-responsiveCss css-5ok5af-responsiveCss" []
  let multipleMediaQueries =
    CSS.make
      "css-6xix1i-multipleMediaQueries css-15xbu8k-multipleMediaQueries css-t4luht-multipleMediaQueries"
      []
  let mediaWithSelector =
    CSS.make
      "css-k008qs-mediaWithSelector css-r3okhn-mediaWithSelector css-2nmn4s-mediaWithSelector css-5tc233-mediaWithSelector"
      []
  let complexMedia =
    CSS.make
      "css-lgj0h8-complexMedia css-1xh9stc-complexMedia css-1spsdb6-complexMedia"
      []
  let mediaWithInterpolation color =
    CSS.make
      "css-kusjgz-mediaWithInterpolation css-ltnkwb-mediaWithInterpolation"
      [("--color-1a279q8", (CSS.Types.Color.toString color))]
  let fadeIn = CSS.Types.AnimationName.make "keyframe-1urc19q"
  let slideUp = CSS.Types.AnimationName.make "keyframe-1k51lkp"
  module GlobalReset =
    struct
      let to_string () = ""
      let makeProps ?key () = Js.Obj.empty ()[@@warning "-27-32"]
      let make _props = CSS.global_style_tag (to_string ())
    end
  let multiVar primary secondary size =
    CSS.make "css-1sq1nk7-multiVar css-nk32ej-multiVar"
      [("--primary-19vrfgr", (CSS.Types.Color.toString primary));
      ("--secondary-1dc81fi", (CSS.Types.Color.toString secondary));
      ("--size-3mc4ty", (CSS.Types.FontSize.toString size))]
  let gridCss =
    CSS.make "css-lgj0h8-gridCss css-bghlac-gridCss css-16610y9-gridCss" []
  let scrollCss = CSS.make "css-pdjuhq-scrollCss css-13v3rg8-scrollCss" []
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
  :root{--primary-color:blue}
  body{margin:0;font-family:system-ui,sans-serif}
  @property --primary-19vrfgr{syntax:"*";inherits:false;}
  @property --secondary-1dc81fi{syntax:"*";inherits:false;}
  @property --size-3mc4ty{syntax:"*";inherits:false;}
  .css-k008qs-staticCss{display:flex}
  .css-1tyndxa-staticCss{justify-content:center}
  .css-kusjgz-dynamicCss{color:var(--color-1a279q8)}
  .css-k008qs-dynamicCss{display:flex}
  .css-15a4g54-logicalProps{margin-block:var(--spacing-y96o3b)}
  .css-15a4g54-logicalProps{margin-inline:var(--spacing-vh5lkd)}
  .css-15a4g54-logicalProps{padding-block-start:var(--spacing-f3qjr)}
  .css-15a4g54-logicalProps{-webkit-padding-inline-end:var(--spacing-f3qjr);padding-inline-end:var(--spacing-f3qjr)}
  .css-15a4g54-logicalProps{inset-block-start:var(--spacing-f3qjr)}
  .css-k008qs-nestedCss{display:flex}
  .css-t2xfa5-nestedCss:hover{opacity:0.8}
  .css-16i2mb0-nestedCss .child{-webkit-flex:1;-ms-flex:1;flex:1}
  .css-k008qs-responsiveCss{display:flex}
  @media (max-width:768px){.css-5ok5af-responsiveCss{display:block}}
  .css-6xix1i-multipleMediaQueries{font-size:16px}
  @media (max-width:768px){.css-15xbu8k-multipleMediaQueries{font-size:14px}}
  @media (max-width:480px){.css-t4luht-multipleMediaQueries{font-size:12px}}
  .css-k008qs-mediaWithSelector{display:flex}
  .css-r3okhn-mediaWithSelector .item{-webkit-flex:1;-ms-flex:1;flex:1}
  @media (max-width:768px){.css-2nmn4s-mediaWithSelector{-webkit-flex-direction:column;-ms-flex-direction:column;flex-direction:column}}
  @media (max-width:768px){.css-5tc233-mediaWithSelector .item{-webkit-flex:none;-ms-flex:none;flex:none}}
  .css-lgj0h8-complexMedia{display:grid}
  @media screen and (min-width:768px) and (max-width:1024px){.css-1xh9stc-complexMedia{display:flex}}
  @media (prefers-color-scheme:dark){.css-1spsdb6-complexMedia{background-color:#1a1a1a}}
  .css-kusjgz-mediaWithInterpolation{color:var(--color-1a279q8)}
  @media (max-width:768px){.css-ltnkwb-mediaWithInterpolation{opacity:0.8}}
  @keyframes keyframe-1urc19q{from{opacity:0}to{opacity:1}}
  @keyframes keyframe-1k51lkp{0%{-webkit-transform:translateY(100%);-moz-transform:translateY(100%);-ms-transform:translateY(100%);transform:translateY(100%)}100%{-webkit-transform:translateY(0);-moz-transform:translateY(0);-ms-transform:translateY(0);transform:translateY(0)}}
  .css-1sq1nk7-multiVar{color:var(--primary-19vrfgr)}
  .css-1sq1nk7-multiVar{background-color:var(--secondary-1dc81fi)}
  .css-1sq1nk7-multiVar{font-size:var(--size-3mc4ty)}
  .css-nk32ej-multiVar{padding:10px}
  .css-lgj0h8-gridCss{display:grid}
  .css-bghlac-gridCss{grid-template-columns:1fr 2fr 1fr}
  .css-16610y9-gridCss{gap:20px}
  .css-pdjuhq-scrollCss{scroll-behavior:smooth}
  .css-13v3rg8-scrollCss{overflow-y:auto}
