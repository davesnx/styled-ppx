  $ ../../../standalone.exe --impl input.ml -o output.ml
  $ cat output.ml
  [@@@css "@property --ivpctq8{syntax:\"*\";inherits:false;}"]
  [@@@css "@property --ivpcbne{syntax:\"*\";inherits:false;}"]
  [@@@css "@property --ivpc841{syntax:\"*\";inherits:false;}"]
  [@@@css "@property --ivpcrw9{syntax:\"*\";inherits:false;}"]
  [@@@css ":root{--primary-color:blue;}"]
  [@@@css "body{margin:0;font-family:system-ui, sans-serif;}"]
  [@@@css "@property --ivpcw74{syntax:\"*\";inherits:false;}"]
  [@@@css "@property --ivpcdrc{syntax:\"*\";inherits:false;}"]
  [@@@css "@property --ivpcwqi{syntax:\"*\";inherits:false;}"]
  [@@@css ".css-ivpcrzr{display:flex;justify-content:center;}"]
  [@@@css ".css-ivpch3t{color:var(--ivpctq8);display:flex;}"]
  [@@@css
    ".css-ivpcy76{margin-block:var(--ivpcbne);margin-inline:var(--ivpc841);padding-block-start:var(--ivpcrw9);-webkit-padding-inline-end:var(--ivpcrw9);padding-inline-end:var(--ivpcrw9);inset-block-start:var(--ivpcrw9);}"]
  [@@@css
    ".css-ivpcah4{display:flex;}.css-ivpcah4:hover{opacity:0.8;}.css-ivpcah4 .child{-webkit-flex:1;-ms-flex:1;flex:1;}"]
  [@@@css
    ".css-ivpctqz{display:flex;}@media (max-width: 768px) {.css-ivpctqz{display:block;}}"]
  [@@@css
    ".css-ivpcy60{font-size:16px;}@media (max-width: 768px) {.css-ivpcy60{font-size:14px;}}@media (max-width: 480px) {.css-ivpcy60{font-size:12px;}}"]
  [@@@css
    ".css-ivpco4c{display:flex;}.css-ivpco4c .item{-webkit-flex:1;-ms-flex:1;flex:1;}@media (max-width: 768px) {.css-ivpco4c{-webkit-flex-direction:column;-ms-flex-direction:column;flex-direction:column;}.css-ivpco4c .item{-webkit-flex:none;-ms-flex:none;flex:none;}}"]
  [@@@css
    ".css-ivpc1k0{display:grid;}@media screen and (min-width: 768px) and (max-width: 1024px) {.css-ivpc1k0{display:flex;}}@media (prefers-color-scheme: dark) {.css-ivpc1k0{background-color:#1a1a1a;}}"]
  [@@@css
    ".css-ivpcxxg{color:var(--ivpctq8);}@media (max-width: 768px) {.css-ivpcxxg{opacity:0.8;}}"]
  [@@@css "@keyframes keyframe-jw9oix{from{opacity:0;}to{opacity:1;}}"]
  [@@@css
    "@keyframes keyframe-waibjx{0%{-webkit-transform:translateY(100%);-moz-transform:translateY(100%);-ms-transform:translateY(100%);transform:translateY(100%);}100%{-webkit-transform:translateY(0);-moz-transform:translateY(0);-ms-transform:translateY(0);transform:translateY(0);}}"]
  [@@@css
    ".css-ivpcqrp{color:var(--ivpcw74);background-color:var(--ivpcdrc);font-size:var(--ivpcwqi);padding:10px;}"]
  [@@@css
    ".css-ivpclxl{display:grid;grid-template-columns:1fr 2fr 1fr;gap:20px;}"]
  [@@@css ".css-ivpcz0y{scroll-behavior:smooth;overflow-y:auto;}"]
  [@@@css.classes
    [("css-ivpcrzr", 9, "Input.staticCss", "input.ml", 4, 23, 4, 62);
    ("css-ivpch3t", 10, "Input.dynamicCss", "input.ml", 8, 2, 10, 0);
    ("css-ivpcy76", 11, "Input.logicalProps", "input.ml", 16, 2, 21, 0);
    ("css-ivpcah4", 12, "Input.nestedCss", "input.ml", 27, 2, 34, 0);
    ("css-ivpctqz", 13, "Input.responsiveCss", "input.ml", 40, 2, 44, 0);
    ("css-ivpcy60", 14, "Input.multipleMediaQueries", "input.ml", 50, 2, 57, 0);
    ("css-ivpco4c", 15, "Input.mediaWithSelector", "input.ml", 63, 2, 73, 0);
    ("css-ivpc1k0", 16, "Input.complexMedia", "input.ml", 79, 2, 86, 0);
    ("css-ivpcxxg", 17, "Input.mediaWithInterpolation", "input.ml", 92, 2, 96,
      0);
    ("css-ivpcqrp", 20, "Input.multiVar", "input.ml", 129, 2, 133, 0);
    ("css-ivpclxl", 21, "Input.gridCss", "input.ml", 139, 2, 142, 0);
    ("css-ivpcz0y", 22, "Input.scrollCss", "input.ml", 145, 23, 145, 65)]]
  [@@@css.bindings
    [("Input.staticCss", "css-ivpcrzr");
    ("Input.dynamicCss", "");
    ("Input.logicalProps", "");
    ("Input.nestedCss", "css-ivpcah4");
    ("Input.responsiveCss", "css-ivpctqz");
    ("Input.multipleMediaQueries", "css-ivpcy60");
    ("Input.mediaWithSelector", "css-ivpco4c");
    ("Input.complexMedia", "css-ivpc1k0");
    ("Input.mediaWithInterpolation", "");
    ("Input.multiVar", "");
    ("Input.gridCss", "css-ivpclxl");
    ("Input.scrollCss", "css-ivpcz0y")]]
  let staticCss = CSS.make "css-ivpcrzr" []
  let dynamicCss color =
    CSS.make "css-ivpch3t" [("--ivpctq8", (CSS.Types.Color.toString color))]
  let logicalProps spacing =
    CSS.make "css-ivpcy76"
      [("--ivpcbne", (CSS.Types.MarginBlock.toString spacing));
      ("--ivpc841", (CSS.Types.MarginInline.toString spacing));
      ("--ivpcrw9", (CSS.Types.Length.toString spacing))]
  let nestedCss = CSS.make "css-ivpcah4" []
  let responsiveCss = CSS.make "css-ivpctqz" []
  let multipleMediaQueries = CSS.make "css-ivpcy60" []
  let mediaWithSelector = CSS.make "css-ivpco4c" []
  let complexMedia = CSS.make "css-ivpc1k0" []
  let mediaWithInterpolation color =
    CSS.make "css-ivpcxxg" [("--ivpctq8", (CSS.Types.Color.toString color))]
  let fadeIn = CSS.Types.AnimationName.make "keyframe-jw9oix"
  let slideUp = CSS.Types.AnimationName.make "keyframe-waibjx"
  module GlobalReset =
    struct
      let to_string () = ""
      let makeProps ?key () = Js.Obj.empty ()[@@warning "-27-32"]
      let make _props = CSS.global_style_tag (to_string ())
    end
  let multiVar primary secondary size =
    CSS.make "css-ivpcqrp"
      [("--ivpcw74", (CSS.Types.Color.toString primary));
      ("--ivpcdrc", (CSS.Types.Color.toString secondary));
      ("--ivpcwqi", (CSS.Types.FontSize.toString size))]
  let gridCss = CSS.make "css-ivpclxl" []
  let scrollCss = CSS.make "css-ivpcz0y" []
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
  @property --ivpctq8{syntax:"*";inherits:false;}
  @property --ivpcbne{syntax:"*";inherits:false;}
  @property --ivpc841{syntax:"*";inherits:false;}
  @property --ivpcrw9{syntax:"*";inherits:false;}
  :root{--primary-color:blue;}
  body{margin:0;font-family:system-ui, sans-serif;}
  @property --ivpcw74{syntax:"*";inherits:false;}
  @property --ivpcdrc{syntax:"*";inherits:false;}
  @property --ivpcwqi{syntax:"*";inherits:false;}
  .css-ivpcrzr{display:flex;justify-content:center;}
  .css-ivpch3t{color:var(--ivpctq8);display:flex;}
  .css-ivpcy76{margin-block:var(--ivpcbne);margin-inline:var(--ivpc841);padding-block-start:var(--ivpcrw9);-webkit-padding-inline-end:var(--ivpcrw9);padding-inline-end:var(--ivpcrw9);inset-block-start:var(--ivpcrw9);}
  .css-ivpcah4{display:flex;}.css-ivpcah4:hover{opacity:0.8;}.css-ivpcah4 .child{-webkit-flex:1;-ms-flex:1;flex:1;}
  .css-ivpctqz{display:flex;}@media (max-width: 768px) {.css-ivpctqz{display:block;}}
  .css-ivpcy60{font-size:16px;}@media (max-width: 768px) {.css-ivpcy60{font-size:14px;}}@media (max-width: 480px) {.css-ivpcy60{font-size:12px;}}
  .css-ivpco4c{display:flex;}.css-ivpco4c .item{-webkit-flex:1;-ms-flex:1;flex:1;}@media (max-width: 768px) {.css-ivpco4c{-webkit-flex-direction:column;-ms-flex-direction:column;flex-direction:column;}.css-ivpco4c .item{-webkit-flex:none;-ms-flex:none;flex:none;}}
  .css-ivpc1k0{display:grid;}@media screen and (min-width: 768px) and (max-width: 1024px) {.css-ivpc1k0{display:flex;}}@media (prefers-color-scheme: dark) {.css-ivpc1k0{background-color:#1a1a1a;}}
  .css-ivpcxxg{color:var(--ivpctq8);}@media (max-width: 768px) {.css-ivpcxxg{opacity:0.8;}}
  @keyframes keyframe-jw9oix{from{opacity:0;}to{opacity:1;}}
  @keyframes keyframe-waibjx{0%{-webkit-transform:translateY(100%);-moz-transform:translateY(100%);-ms-transform:translateY(100%);transform:translateY(100%);}100%{-webkit-transform:translateY(0);-moz-transform:translateY(0);-ms-transform:translateY(0);transform:translateY(0);}}
  .css-ivpcqrp{color:var(--ivpcw74);background-color:var(--ivpcdrc);font-size:var(--ivpcwqi);padding:10px;}
  .css-ivpclxl{display:grid;grid-template-columns:1fr 2fr 1fr;gap:20px;}
  .css-ivpcz0y{scroll-behavior:smooth;overflow-y:auto;}
