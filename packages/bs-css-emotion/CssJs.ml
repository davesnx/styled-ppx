include Css_Js_Core
include Css_Colors

include Css_Js_Core.Make (struct
  type styleEncoding = string
  type renderer = Js.Json.t

  external injectRaw : (string -> unit[@bs]) = "injectGlobal"
    [@@bs.module "@emotion/css"]

  let renderRaw = fun [@bs] _ css -> (injectRaw css [@bs])

  external injectRawRules : (Js.Json.t -> unit[@bs]) = "injectGlobal"
    [@@bs.module "@emotion/css"]

  let injectRules =
   fun [@bs] selector rules ->
    (injectRawRules
       (Js.Dict.fromArray [| selector, rules |] |. Js.Json.object_) [@bs])

  let renderRules =
   fun [@bs] _ selector rules ->
    (injectRawRules
       (Js.Dict.fromArray [| selector, rules |] |. Js.Json.object_) [@bs])

  external mergeStyles : (styleEncoding array -> styleEncoding[@bs]) = "cx"
    [@@bs.module "@emotion/css"]

  external make : (Js.Json.t -> styleEncoding[@bs]) = "css"
    [@@bs.module "@emotion/css"]

  external makeAnimation : (Js.Json.t Js.Dict.t -> string[@bs]) = "keyframes"
    [@@bs.module "@emotion/css"]

  let makeKeyframes = fun [@bs] frames -> (makeAnimation frames [@bs])
  let renderKeyframes = fun [@bs] _ frames -> (makeAnimation frames [@bs])
end)

type cache

external cache : cache = "cache" [@@bs.module "@emotion/cache"]

let fontFace ~fontFamily ~src ?fontStyle ?fontWeight ?fontDisplay ?sizeAdjust ()
    =
  insertRule
    (Css_Js_Core.fontFace ~fontFamily ~src ?fontStyle ?fontWeight ?fontDisplay
       ?sizeAdjust ()) [@bs];
  fontFamily
