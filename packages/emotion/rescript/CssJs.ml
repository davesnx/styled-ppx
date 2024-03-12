include Css_Colors
include Css_Js_Core
module Types = Css_AtomicTypes

include Css_Js_Core.Make (struct
  type styleEncoding = string
  type renderer = Js.Json.t

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

  external make : Js.Json.t -> styleEncoding = "css"
  [@@bs.module "@emotion/css"]

  external makeAnimation : Js.Json.t Js.Dict.t -> string = "keyframes"
  [@@bs.module "@emotion/css"]

  let makeKeyframes frames = makeAnimation frames
  let renderKeyframes _ frames = makeAnimation frames
end)

type cache

external cache : cache = "cache" [@@bs.module "@emotion/cache"]

let fontFace ~fontFamily ~src ?fontStyle ?fontWeight ?fontDisplay ?sizeAdjust ()
    =
  let fontFace =
    Css_Js_Core.fontFace ~fontFamily ~src ?fontStyle ?fontWeight ?fontDisplay
      ?sizeAdjust ()
  in
  insertRule fontFace;
  fontFamily
