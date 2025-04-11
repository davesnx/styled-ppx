type styleEncoding

external injectRaw : string -> unit = "injectGlobal"
[@@bs.module "@emotion/css"]

let renderRaw _ css = injectRaw css

external injectRawRules : Js.Json.t -> unit = "injectGlobal"
[@@bs.module "@emotion/css"]

let injectRules = injectRawRules

let renderRules _ selector rules =
  injectRawRules (Js.Json.object_ (Js.Dict.fromArray [| selector, rules |]))

external mergeStyles : styleEncoding array -> styleEncoding = "cx"
[@@bs.module "@emotion/css"]

external make : Js.Json.t -> string = "css" [@@bs.module "@emotion/css"]

external makeAnimation : Js.Json.t Js.Dict.t -> string = "keyframes"
[@@bs.module "@emotion/css"]

let makeKeyframes frames = makeAnimation frames
let insertRule css = injectRaw css
let renderRule renderer css = renderRaw renderer css
let global rules = injectRules (Rule.toJson rules)

let renderGlobal renderer selector rules =
  renderRules renderer selector (Rule.toJson rules)

let style rules = make (Rule.toJson rules)
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
      Kloth.Option.map Declarations.fontStyle fontStyle;
      Kloth.Option.map Declarations.fontWeight fontWeight;
      Kloth.Option.map Declarations.fontDisplay fontDisplay;
      Kloth.Option.map Declarations.sizeAdjust sizeAdjust;
      Kloth.Option.map Declarations.unicodeRange unicodeRange;
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
