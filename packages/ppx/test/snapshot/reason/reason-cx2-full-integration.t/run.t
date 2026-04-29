  $ standalone --impl input.ml -o output.ml
  $ cat output.ml
  [@@@css ":root{--primary-color:blue;}"]
  [@@@css "body{margin:0;font-family:system-ui, sans-serif;}"]
  [@@@css ".css-k008qs-staticCss{display:flex;}"]
  [@@@css ".css-1tyndxa-staticCss{justify-content:center;}"]
  [@@@css ".css-kusjgz-dynamicCss{color:var(--var-sj55zd);}"]
  [@@@css ".css-k008qs-dynamicCss{display:flex;}"]
  [@@@css ".css-15ikb3s-logicalProps{margin-block:var(--var-m7rmhk);}"]
  [@@@css ".css-1io86c2-logicalProps{margin-inline:var(--var-m7rmhk);}"]
  [@@@css ".css-bcg5v8-logicalProps{padding-block-start:var(--var-m7rmhk);}"]
  [@@@css ".css-1ifadwg-logicalProps{padding-inline-end:var(--var-m7rmhk);}"]
  [@@@css ".css-kdjpx-logicalProps{inset-block-start:var(--var-m7rmhk);}"]
  [@@@css ".css-k008qs-nestedCss{display:flex;}"]
  [@@@css ".css-zqnfaz-nestedCss:hover{opacity:0.8;}"]
  [@@@css ".css-osffsa-nestedCss .child{flex:1;}"]
  [@@@css ".css-k008qs-responsiveCss{display:flex;}"]
  [@@@css
    "@media (max-width: 768px) {.css-1ruz0a1-responsiveCss{display:block;}}"]
  [@@@css ".css-6xix1i-multipleMediaQueries{font-size:16px;}"]
  [@@@css
    "@media (max-width: 768px) {.css-1l3vtdj-multipleMediaQueries{font-size:14px;}}"]
  [@@@css
    "@media (max-width: 480px) {.css-2b7vub-multipleMediaQueries{font-size:12px;}}"]
  [@@@css ".css-k008qs-mediaWithSelector{display:flex;}"]
  [@@@css ".css-5ivle1-mediaWithSelector .item{flex:1;}"]
  [@@@css
    "@media (max-width: 768px) {.css-1cemfq6-mediaWithSelector{flex-direction:column;}}"]
  [@@@css
    "@media (max-width: 768px) {.css-1l7frkw-mediaWithSelector .item{flex:none;}}"]
  [@@@css ".css-lgj0h8-complexMedia{display:grid;}"]
  [@@@css
    "@media screen and (min-width: 768px) and (max-width: 1024px) {.css-mhiow9-complexMedia{display:flex;}}"]
  [@@@css
    "@media (prefers-color-scheme: dark) {.css-1nm9mde-complexMedia{background-color:#1a1a1a;}}"]
  [@@@css ".css-kusjgz-mediaWithInterpolation{color:var(--var-sj55zd);}"]
  [@@@css
    "@media (max-width: 768px) {.css-11qknlj-mediaWithInterpolation{opacity:0.8;}}"]
  [@@@css "@keyframes keyframe-jw9oix{from{opacity:0;}to{opacity:1;}}"]
  [@@@css
    "@keyframes keyframe-waibjx{0%{transform:translateY(100%);}100%{transform:translateY(0);}}"]
  [@@@css ".css-b6lny7-multiVar{color:var(--var-bxenxf);}"]
  [@@@css ".css-12udlbg-multiVar{background-color:var(--var-1czls49);}"]
  [@@@css ".css-u661at-multiVar{font-size:var(--var-1kwx24p);}"]
  [@@@css ".css-nk32ej-multiVar{padding:10px;}"]
  [@@@css ".css-lgj0h8-gridCss{display:grid;}"]
  [@@@css ".css-bghlac-gridCss{grid-template-columns:1fr 2fr 1fr;}"]
  [@@@css ".css-16610y9-gridCss{gap:20px;}"]
  [@@@css ".css-pdjuhq-scrollCss{scroll-behavior:smooth;}"]
  [@@@css ".css-13v3rg8-scrollCss{overflow-y:auto;}"]
  [@@@css.bindings
    [("Input.staticCss", "css-k008qs-staticCss css-1tyndxa-staticCss");
    ("Input.dynamicCss", "css-kusjgz-dynamicCss css-k008qs-dynamicCss");
    ("Input.logicalProps",
      "css-15ikb3s-logicalProps css-1io86c2-logicalProps css-bcg5v8-logicalProps css-1ifadwg-logicalProps css-kdjpx-logicalProps");
    ("Input.nestedCss",
      "css-k008qs-nestedCss css-zqnfaz-nestedCss css-osffsa-nestedCss");
    ("Input.responsiveCss",
      "css-k008qs-responsiveCss css-1ruz0a1-responsiveCss");
    ("Input.multipleMediaQueries",
      "css-6xix1i-multipleMediaQueries css-1l3vtdj-multipleMediaQueries css-2b7vub-multipleMediaQueries");
    ("Input.mediaWithSelector",
      "css-k008qs-mediaWithSelector css-5ivle1-mediaWithSelector css-1cemfq6-mediaWithSelector css-1l7frkw-mediaWithSelector");
    ("Input.complexMedia",
      "css-lgj0h8-complexMedia css-mhiow9-complexMedia css-1nm9mde-complexMedia");
    ("Input.mediaWithInterpolation",
      "css-kusjgz-mediaWithInterpolation css-11qknlj-mediaWithInterpolation");
    ("Input.multiVar",
      "css-b6lny7-multiVar css-12udlbg-multiVar css-u661at-multiVar css-nk32ej-multiVar");
    ("Input.gridCss",
      "css-lgj0h8-gridCss css-bghlac-gridCss css-16610y9-gridCss");
    ("Input.scrollCss", "css-pdjuhq-scrollCss css-13v3rg8-scrollCss")]]
  let staticCss = CSS.make "css-k008qs-staticCss css-1tyndxa-staticCss" []
  let dynamicCss color =
    CSS.make "css-kusjgz-dynamicCss css-k008qs-dynamicCss"
      [("--var-sj55zd", (CSS.Types.Color.toString color))]
  let logicalProps spacing =
    CSS.make
      "css-15ikb3s-logicalProps css-1io86c2-logicalProps css-bcg5v8-logicalProps css-1ifadwg-logicalProps css-kdjpx-logicalProps"
      [("--var-m7rmhk", (CSS.Types.MarginBlock.toString spacing))]
  let nestedCss =
    CSS.make "css-k008qs-nestedCss css-zqnfaz-nestedCss css-osffsa-nestedCss"
      []
  let responsiveCss =
    CSS.make "css-k008qs-responsiveCss css-1ruz0a1-responsiveCss" []
  let multipleMediaQueries =
    CSS.make
      "css-6xix1i-multipleMediaQueries css-1l3vtdj-multipleMediaQueries css-2b7vub-multipleMediaQueries"
      []
  let mediaWithSelector =
    CSS.make
      "css-k008qs-mediaWithSelector css-5ivle1-mediaWithSelector css-1cemfq6-mediaWithSelector css-1l7frkw-mediaWithSelector"
      []
  let complexMedia =
    CSS.make
      "css-lgj0h8-complexMedia css-mhiow9-complexMedia css-1nm9mde-complexMedia"
      []
  let mediaWithInterpolation color =
    CSS.make
      "css-kusjgz-mediaWithInterpolation css-11qknlj-mediaWithInterpolation"
      [("--var-sj55zd", (CSS.Types.Color.toString color))]
  let fadeIn = CSS.Types.AnimationName.make "keyframe-jw9oix"
  let slideUp = CSS.Types.AnimationName.make "keyframe-waibjx"
  let () = ()
  let multiVar primary secondary size =
    CSS.make
      "css-b6lny7-multiVar css-12udlbg-multiVar css-u661at-multiVar css-nk32ej-multiVar"
      [("--var-bxenxf", (CSS.Types.Color.toString primary));
      ("--var-1czls49", (CSS.Types.Color.toString secondary));
      ("--var-1kwx24p", (CSS.Types.FontSize.toString size))]
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
  .css-12udlbg-multiVar{background-color:var(--var-1czls49);}
  .css-13v3rg8-scrollCss{overflow-y:auto;}
  .css-15ikb3s-logicalProps{margin-block:var(--var-m7rmhk);}
  .css-16610y9-gridCss{gap:20px;}
  .css-1ifadwg-logicalProps{padding-inline-end:var(--var-m7rmhk);}
  .css-1io86c2-logicalProps{margin-inline:var(--var-m7rmhk);}
  .css-1tyndxa-staticCss{justify-content:center;}
  .css-5ivle1-mediaWithSelector .item{flex:1;}
  .css-6xix1i-multipleMediaQueries{font-size:16px;}
  .css-b6lny7-multiVar{color:var(--var-bxenxf);}
  .css-bcg5v8-logicalProps{padding-block-start:var(--var-m7rmhk);}
  .css-bghlac-gridCss{grid-template-columns:1fr 2fr 1fr;}
  .css-k008qs-dynamicCss{display:flex;}
  .css-k008qs-mediaWithSelector{display:flex;}
  .css-k008qs-nestedCss{display:flex;}
  .css-k008qs-responsiveCss{display:flex;}
  .css-k008qs-staticCss{display:flex;}
  .css-kdjpx-logicalProps{inset-block-start:var(--var-m7rmhk);}
  .css-kusjgz-dynamicCss{color:var(--var-sj55zd);}
  .css-kusjgz-mediaWithInterpolation{color:var(--var-sj55zd);}
  .css-lgj0h8-complexMedia{display:grid;}
  .css-lgj0h8-gridCss{display:grid;}
  .css-nk32ej-multiVar{padding:10px;}
  .css-osffsa-nestedCss .child{flex:1;}
  .css-pdjuhq-scrollCss{scroll-behavior:smooth;}
  .css-u661at-multiVar{font-size:var(--var-1kwx24p);}
  .css-zqnfaz-nestedCss:hover{opacity:0.8;}
  :root{--primary-color:blue;}
  @keyframes keyframe-jw9oix{from{opacity:0;}to{opacity:1;}}
  @keyframes keyframe-waibjx{0%{transform:translateY(100%);}100%{transform:translateY(0);}}
  @media (max-width: 480px) {.css-2b7vub-multipleMediaQueries{font-size:12px;}}
  @media (max-width: 768px) {.css-11qknlj-mediaWithInterpolation{opacity:0.8;}}
  @media (max-width: 768px) {.css-1cemfq6-mediaWithSelector{flex-direction:column;}}
  @media (max-width: 768px) {.css-1l3vtdj-multipleMediaQueries{font-size:14px;}}
  @media (max-width: 768px) {.css-1l7frkw-mediaWithSelector .item{flex:none;}}
  @media (max-width: 768px) {.css-1ruz0a1-responsiveCss{display:block;}}
  @media (prefers-color-scheme: dark) {.css-1nm9mde-complexMedia{background-color:#1a1a1a;}}
  @media screen and (min-width: 768px) and (max-width: 1024px) {.css-mhiow9-complexMedia{display:flex;}}
  body{margin:0;font-family:system-ui, sans-serif;}

