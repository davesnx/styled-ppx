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
      Js.Dict.set dict (Kloth.Int.toString stop ^ {js|%|js}) (Rule.toJson rules);
      dict)
    frames

let keyframes frames = makeKeyframes (framesToDict frames)
let renderKeyframes _renderer frames = makeAnimation (framesToDict frames)

(* This method is a Css_type function, but with side-effects. It pushes the fontFace as global style *)
let fontFace ~fontFamily ~src ?fontStyle ?fontWeight ?fontDisplay ?sizeAdjust ()
    =
  let fontFace =
    {js|@font-face {| font-family: |js}
    ^ fontFamily
    ^ ({js|; src: |js}
      ^ Kloth.Array.joinWithMap ~sep:{js|, |js} ~f:Css_types.FontFace.toString
          src
      ^ {js|;|js})
    ^ Kloth.Option.mapWithDefault fontStyle {js||js} (fun value ->
          {js|font-style: |js} ^ Css_types.FontStyle.toString value ^ {js|;|js})
    ^ Kloth.Option.mapWithDefault fontWeight {js||js} (fun w ->
          ({js|font-weight: |js}
          ^
          match w with
          | #Css_types.FontWeight.t as f -> Css_types.FontWeight.toString f
          | #Css_types.Var.t as va -> Css_types.Var.toString va
          | #Css_types.Cascading.t as c -> Css_types.Cascading.toString c)
          ^ {js|;|js})
    ^ Kloth.Option.mapWithDefault fontDisplay {js||js} (fun f ->
          {js|font-display: |js} ^ Css_types.FontDisplay.toString f ^ {js|;|js})
    ^ Kloth.Option.mapWithDefault sizeAdjust {js||js} (fun s ->
          {js|size-adjust: |js} ^ Css_types.Percentage.toString s ^ {js|;|js})
    ^ {js|}|js}
  in
  injectRaw fontFace;
  fontFamily
