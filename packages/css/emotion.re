/* include Css;

   module Runtime =
     Functor.Make({
       type styleEncoding = string;
       type renderer = Js.Json.t; // not relevant, maybe remove from interface?

       [@mel.module "@emotion/css"]
       external injectRaw: (. string) => unit = "injectGlobal";
       let renderRaw = (. _, css) => injectRaw(. css);

       [@mel.module "@emotion/css"]
       external injectRawRules: (. Js.Json.t) => unit = "injectGlobal";

       let injectRules =
         (. selector, rules) =>
           injectRawRules(.
             Js.Dict.fromArray([(selector, rules)])->Js.Json.object_,
           );

       let renderRules =
         (. _, selector, rules) =>
           injectRawRules(.
             Js.Dict.fromArray([(selector, rules)])->Js.Json.object_,
           );

       [@mel.module "@emotion/css"]
       external mergeStyles: (. array(styleEncoding)) => styleEncoding = "cx";

       [@mel.module "@emotion/css"]
       external make: (. Js.Json.t) => styleEncoding = "css";

       [@mel.module "@emotion/css"]
       external makeAnimation: (. Js.Dict.t(Js.Json.t)) => string = "keyframes";

       let makeKeyframes = (. frames) => makeAnimation(. frames);
       let renderKeyframes = (. _, frames) => makeAnimation(. frames);
     });

   type cache;

   [@mel.module "@emotion/cache"] external cache: cache = "cache";

   let fontFace =
       (~fontFamily, ~src, ~fontStyle=?, ~fontWeight=?, ~fontDisplay=?, ()) => {
     Runtime.injectRules(. [|
       Css.fontFace(
         ~fontFamily,
         ~src,
         ~fontStyle?,
         ~fontWeight?,
         ~fontDisplay?,
         (),
       ),
     |]);
     fontFamily;
   };

   include Runtime;
    */
