  $ ../../../standalone.exe --impl input.ml -o output.ml
  $ cat output.ml
  [@@@css "@property --color-1a279q8{syntax:\"*\";inherits:false;}"]
  [@@@css "@property --spacing-y96o3b{syntax:\"*\";inherits:false;}"]
  [@@@css "@property --spacing-vh5lkd{syntax:\"*\";inherits:false;}"]
  [@@@css "@property --spacing-f3qjr{syntax:\"*\";inherits:false;}"]
  [@@@css ":root{--primary-color:blue;}"]
  [@@@css "body{margin:0;font-family:system-ui, sans-serif;}"]
  [@@@css "@property --primary-1e50z5r{syntax:\"*\";inherits:false;}"]
  [@@@css "@property --secondary-12msuqq{syntax:\"*\";inherits:false;}"]
  [@@@css "@property --size-1tljh9b{syntax:\"*\";inherits:false;}"]
  [@@@css "._a_5r08qs{display:flex;}"]
  [@@@css "._a_9h002ndxa{justify-content:center;}"]
  [@@@css "._a_4esjgz{color:var(--color-1a279q8);}"]
  [@@@css "._in_15a4g54{margin-block:var(--spacing-y96o3b);}"]
  [@@@css "._in_15a4g54{margin-inline:var(--spacing-vh5lkd);}"]
  [@@@css "._in_15a4g54{padding-block-start:var(--spacing-f3qjr);}"]
  [@@@css
    "._in_15a4g54{-webkit-padding-inline-end:var(--spacing-f3qjr);padding-inline-end:var(--spacing-f3qjr);}"]
  [@@@css "._in_15a4g54{inset-block-start:var(--spacing-f3qjr);}"]
  [@@@css "._a_qyw7u8mnfaz:hover{opacity:0.8;}"]
  [@@@css "._a_3rgzi60ffsa .child{-webkit-flex:1;-ms-flex:1;flex:1;}"]
  [@@@css "@media (max-width: 768px) {._a_5eyct5rz0a1{display:block;}}"]
  [@@@css "._a_6500wix1i{font-size:16px;}"]
  [@@@css "@media (max-width: 768px) {._a_5eyct6500wvtdj{font-size:14px;}}"]
  [@@@css "@media (max-width: 480px) {._a_fjsdf6500w7vub{font-size:12px;}}"]
  [@@@css "._a_5ixlc60vle1 .item{-webkit-flex:1;-ms-flex:1;flex:1;}"]
  [@@@css
    "@media (max-width: 768px) {._a_5eyct61001mfq6{-webkit-flex-direction:column;-ms-flex-direction:column;flex-direction:column;}}"]
  [@@@css
    "@media (max-width: 768px) {._a_xdd5e60frkw .item{-webkit-flex:none;-ms-flex:none;flex:none;}}"]
  [@@@css "._a_5rj0h8{display:grid;}"]
  [@@@css
    "@media screen and (min-width: 768px) and (max-width: 1024px) {._a_hgkhj5riow9{display:flex;}}"]
  [@@@css
    "@media (prefers-color-scheme: dark) {._a_wkmu5390049mde{background-color:#1a1a1a;}}"]
  [@@@css "@media (max-width: 768px) {._a_5eyct8mknlj{opacity:0.8;}}"]
  [@@@css "@keyframes _k_jw9oix{from{opacity:0;}to{opacity:1;}}"]
  [@@@css
    "@keyframes _k_waibjx{0%{-webkit-transform:translateY(100%);-moz-transform:translateY(100%);-ms-transform:translateY(100%);transform:translateY(100%);}100%{-webkit-transform:translateY(0);-moz-transform:translateY(0);-ms-transform:translateY(0);transform:translateY(0);}}"]
  [@@@css "._a_4elny7{color:var(--primary-1e50z5r);}"]
  [@@@css "._a_39004dlbg{background-color:var(--secondary-12msuqq);}"]
  [@@@css "._a_6500w61at{font-size:var(--size-1tljh9b);}"]
  [@@@css "._a_9432ej{padding:10px;}"]
  [@@@css "._a_6i00ghlac{grid-template-columns:1fr 2fr 1fr;}"]
  [@@@css "._a_6f10y9{gap:20px;}"]
  [@@@css "._a_aajuhq{scroll-behavior:smooth;}"]
  [@@@css "._a_8r0023rg8{overflow-y:auto;}"]
  [@@@css.bindings
    [("Input.staticCss", "_id_1ctni4v", "_a_5r08qs _a_9h002ndxa");
    ("Input.dynamicCss", "_id_71zk3w", "_a_4esjgz _a_5r08qs");
    ("Input.logicalProps", "_id_r1294l", "_in_15a4g54");
    ("Input.nestedCss", "_id_apdklp",
      "_a_5r08qs _a_qyw7u8mnfaz _a_3rgzi60ffsa");
    ("Input.responsiveCss", "_id_1glbybz", "_a_5r08qs _a_5eyct5rz0a1");
    ("Input.multipleMediaQueries", "_id_4peqig",
      "_a_6500wix1i _a_5eyct6500wvtdj _a_fjsdf6500w7vub");
    ("Input.mediaWithSelector", "_id_1jbme7d",
      "_a_5r08qs _a_5ixlc60vle1 _a_5eyct61001mfq6 _a_xdd5e60frkw");
    ("Input.complexMedia", "_id_yh1q8l",
      "_a_5rj0h8 _a_hgkhj5riow9 _a_wkmu5390049mde");
    ("Input.mediaWithInterpolation", "_id_1c8phv0", "_a_4esjgz _a_5eyct8mknlj");
    ("Input.multiVar", "_id_ckhvyf",
      "_a_4elny7 _a_39004dlbg _a_6500w61at _a_9432ej");
    ("Input.gridCss", "_id_nutj5n", "_a_5rj0h8 _a_6i00ghlac _a_6f10y9");
    ("Input.scrollCss", "_id_1d2kyt3", "_a_aajuhq _a_8r0023rg8")]]
  let staticCss =
    CSS.make "label:staticCss _id_1ctni4v _a_5r08qs _a_9h002ndxa" []
  let dynamicCss color =
    CSS.make "label:dynamicCss _id_71zk3w _a_4esjgz _a_5r08qs"
      [("--color-1a279q8", (CSS.Types.Color.toString color))]
  let logicalProps spacing =
    CSS.make "label:logicalProps _id_r1294l _in_15a4g54"
      [("--spacing-y96o3b", (CSS.Types.MarginBlock.toString spacing));
      ("--spacing-vh5lkd", (CSS.Types.MarginInline.toString spacing));
      ("--spacing-f3qjr", (CSS.Types.Length.toString spacing))]
  let nestedCss =
    CSS.make
      "label:nestedCss _id_apdklp _a_5r08qs _a_qyw7u8mnfaz _a_3rgzi60ffsa" []
  let responsiveCss =
    CSS.make "label:responsiveCss _id_1glbybz _a_5r08qs _a_5eyct5rz0a1" []
  let multipleMediaQueries =
    CSS.make
      "label:multipleMediaQueries _id_4peqig _a_6500wix1i _a_5eyct6500wvtdj _a_fjsdf6500w7vub"
      []
  let mediaWithSelector =
    CSS.make
      "label:mediaWithSelector _id_1jbme7d _a_5r08qs _a_5ixlc60vle1 _a_5eyct61001mfq6 _a_xdd5e60frkw"
      []
  let complexMedia =
    CSS.make
      "label:complexMedia _id_yh1q8l _a_5rj0h8 _a_hgkhj5riow9 _a_wkmu5390049mde"
      []
  let mediaWithInterpolation color =
    CSS.make
      "label:mediaWithInterpolation _id_1c8phv0 _a_4esjgz _a_5eyct8mknlj"
      [("--color-1a279q8", (CSS.Types.Color.toString color))]
  let fadeIn = CSS.Types.AnimationName.make "_k_jw9oix"
  let slideUp = CSS.Types.AnimationName.make "_k_waibjx"
  module GlobalReset =
    struct
      let to_string () = ""
      let makeProps ?key () = Js.Obj.empty ()[@@warning "-27-32"]
      let make _props = CSS.global_style_tag (to_string ())
    end
  let multiVar primary secondary size =
    CSS.make
      "label:multiVar _id_ckhvyf _a_4elny7 _a_39004dlbg _a_6500w61at _a_9432ej"
      [("--primary-1e50z5r", (CSS.Types.Color.toString primary));
      ("--secondary-12msuqq", (CSS.Types.Color.toString secondary));
      ("--size-1tljh9b", (CSS.Types.FontSize.toString size))]
  let gridCss =
    CSS.make "label:gridCss _id_nutj5n _a_5rj0h8 _a_6i00ghlac _a_6f10y9" []
  let scrollCss =
    CSS.make "label:scrollCss _id_1d2kyt3 _a_aajuhq _a_8r0023rg8" []
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
  @property --primary-1e50z5r{syntax:"*";inherits:false;}
  @property --secondary-12msuqq{syntax:"*";inherits:false;}
  @property --size-1tljh9b{syntax:"*";inherits:false;}
  @keyframes _k_jw9oix{from{opacity:0;}to{opacity:1;}}
  @keyframes _k_waibjx{0%{-webkit-transform:translateY(100%);-moz-transform:translateY(100%);-ms-transform:translateY(100%);transform:translateY(100%);}100%{-webkit-transform:translateY(0);-moz-transform:translateY(0);-ms-transform:translateY(0);transform:translateY(0);}}
  @layer styled-ppx.global, styled-ppx.descendant, styled-ppx.base, styled-ppx.conditional;
  @layer styled-ppx.global {
  :root{--primary-color:blue;}
  body{margin:0;font-family:system-ui, sans-serif;}
  }
  @layer styled-ppx.base {
  ._a_5r08qs{display:flex;}
  ._a_9h002ndxa{justify-content:center;}
  ._a_4esjgz{color:var(--color-1a279q8);}
  ._in_15a4g54{margin-block:var(--spacing-y96o3b);}
  ._in_15a4g54{margin-inline:var(--spacing-vh5lkd);}
  ._in_15a4g54{padding-block-start:var(--spacing-f3qjr);}
  ._in_15a4g54{-webkit-padding-inline-end:var(--spacing-f3qjr);padding-inline-end:var(--spacing-f3qjr);}
  ._in_15a4g54{inset-block-start:var(--spacing-f3qjr);}
  ._a_3rgzi60ffsa .child{-webkit-flex:1;-ms-flex:1;flex:1;}
  ._a_6500wix1i{font-size:16px;}
  ._a_5ixlc60vle1 .item{-webkit-flex:1;-ms-flex:1;flex:1;}
  ._a_5rj0h8{display:grid;}
  ._a_4elny7{color:var(--primary-1e50z5r);}
  ._a_39004dlbg{background-color:var(--secondary-12msuqq);}
  ._a_6500w61at{font-size:var(--size-1tljh9b);}
  ._a_9432ej{padding:10px;}
  ._a_6i00ghlac{grid-template-columns:1fr 2fr 1fr;}
  ._a_6f10y9{gap:20px;}
  ._a_aajuhq{scroll-behavior:smooth;}
  ._a_8r0023rg8{overflow-y:auto;}
  }
  @layer styled-ppx.conditional {
  ._a_qyw7u8mnfaz:hover{opacity:0.8;}
  @media (max-width: 768px) {._a_5eyct5rz0a1{display:block;}}
  @media (max-width: 768px) {._a_5eyct6500wvtdj{font-size:14px;}}
  @media (max-width: 480px) {._a_fjsdf6500w7vub{font-size:12px;}}
  @media (max-width: 768px) {._a_5eyct61001mfq6{-webkit-flex-direction:column;-ms-flex-direction:column;flex-direction:column;}}
  @media (max-width: 768px) {._a_xdd5e60frkw .item{-webkit-flex:none;-ms-flex:none;flex:none;}}
  @media screen and (min-width: 768px) and (max-width: 1024px) {._a_hgkhj5riow9{display:flex;}}
  @media (prefers-color-scheme: dark) {._a_wkmu5390049mde{background-color:#1a1a1a;}}
  @media (max-width: 768px) {._a_5eyct8mknlj{opacity:0.8;}}
  }
