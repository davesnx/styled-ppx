type styleEncoding

external injectRaw : string -> unit = "injectGlobal"
[@@bs.module "@emotion/css"]

let renderRaw _ css = injectRaw css

external injectRawRules : Js.Json.t -> unit = "injectGlobal"
[@@bs.module "@emotion/css"]

let injectRules = injectRawRules

let renderRules _ selector rules =
  injectRawRules (Js.Dict.fromArray [| selector, rules |] |. Js.Json.object_)

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
  Kloth.Array.reduce frames (Js.Dict.empty ()) (fun dict (stop, rules) ->
      Js.Dict.set dict (Kloth.Int.toString stop ^ {js|%|js}) (Rule.toJson rules);
      dict)

let keyframes frames = makeKeyframes (framesToDict frames)
let renderKeyframes _renderer frames = makeAnimation (framesToDict frames)

(* This method is a Css_type function, but with side-effects. It pushes the fontFace as global style *)
let fontFace ~fontFamily ~src ?fontStyle ?fontWeight ?fontDisplay ?sizeAdjust ()
    =
  let open Css_types in
  let fontStyle =
    match fontStyle with
    | Some value -> {js|font-style: |js} ^ FontStyle.toString value ^ {js|;|js}
    | _ -> ""
  in
  let src =
    src
    |. Kloth.Array.map FontFace.toString
    |. Kloth.Array.joinWith ~sep:{js|, |js}
  in
  let fontWeight =
    Kloth.Option.mapWithDefault fontWeight {js||js} (fun w ->
        ({js|font-weight: |js}
        ^
        match w with
        | #FontWeight.t as f -> FontWeight.toString f
        | #Var.t as va -> Var.toString va
        | #Cascading.t as c -> Cascading.toString c)
        ^ {js|;|js})
  in
  let fontDisplay =
    Kloth.Option.mapWithDefault fontDisplay {js||js} (fun f ->
        {js|font-display: |js} ^ FontDisplay.toString f ^ {js|;|js})
  in
  let sizeAdjust =
    Kloth.Option.mapWithDefault sizeAdjust {js||js} (fun s ->
        {js|size-adjust: |js} ^ Percentage.toString s ^ {js|;|js})
  in
  let fontFace =
    {js|@font-face {|js}
    ^ ({js|font-family: |js} ^ fontFamily)
    ^ ({js|; src: |js} ^ src ^ {js|;|js})
    ^ fontStyle
    ^ fontWeight
    ^ fontDisplay
    ^ sizeAdjust
    ^ {js|}|js}
  in
  injectRaw fontFace;
  fontFamily
