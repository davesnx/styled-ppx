type styleEncoding
type renderer = Js.Json.t

external injectRaw : string -> unit = "injectGlobal"
[@@mel.module "@emotion/css"]

let renderRaw _ css = injectRaw css

external injectRawRules : Js.Json.t -> unit = "injectGlobal"
[@@mel.module "@emotion/css"]

let injectRules = injectRawRules

let renderRules _ selector rules =
  injectRawRules (Js.Dict.fromArray [| selector, rules |] |. Js.Json.object_)

external mergeStyles : styleEncoding array -> styleEncoding = "cx"
[@@mel.module "@emotion/css"]

external make : Js.Json.t -> string = "css" [@@mel.module "@emotion/css"]

external makeAnimation : Js.Json.t Js.Dict.t -> string = "keyframes"
[@@mel.module "@emotion/css"]

let makeKeyframes frames = makeAnimation frames
let insertRule css = injectRaw css
let renderRule renderer css = renderRaw renderer css

let global rules =
  rules
  |> Emotion_bindings_helper.replaceSelectorGlobal
  |> Rule.toJson
  |> injectRules

let renderGlobal renderer selector rules =
  renderRules renderer selector (Rule.toJson rules)

let style rules =
  rules |> Emotion_bindings_helper.replaceSelector |> Rule.toJson |> make

let merge styles = mergeStyles styles
let merge2 s s2 = merge [| s; s2 |]
let merge3 s s2 s3 = merge [| s; s2; s3 |]
let merge4 s s2 s3 s4 = merge [| s; s2; s3; s4 |]

let framesToDict frames =
  Kloth.Array.reduce ~init:(Js.Dict.empty ())
    ~f:(fun dict (stop, rules) ->
      Js.Dict.set dict
        (Kloth.Int.to_string stop ^ {js|%|js})
        (Rule.toJson rules);
      dict)
    frames

let keyframes frames =
  makeKeyframes (framesToDict frames) |> Css_types.AnimationName.make

let renderKeyframes _renderer frames = makeAnimation (framesToDict frames)

(* This method is a Css_type function, but with side-effects. It pushes the fontFace as global style *)
let fontFace ~fontFamily ~src ?fontStyle ?fontWeight ?fontDisplay ?sizeAdjust
  ?unicodeRange () =
  let fontFace =
    [|
      Kloth.Option.map ~f:Declarations.fontStyle fontStyle;
      Kloth.Option.map ~f:Declarations.fontWeight fontWeight;
      Kloth.Option.map ~f:Declarations.fontDisplay fontDisplay;
      Kloth.Option.map ~f:Declarations.sizeAdjust sizeAdjust;
      Kloth.Option.map ~f:Declarations.unicodeRange unicodeRange;
      Some (Declarations.fontFamily fontFamily);
      Some
        (Rule.Declaration
           ( "src",
             Kloth.Array.map_and_join ~sep:{js|, |js}
               ~f:Css_types.FontFace.toString src ));
    |]
    |> Kloth.Array.filter_map ~f:(fun i -> i)
  in
  global [| Rule.Selector ([| "@font-face" |], fontFace) |];
  fontFamily
