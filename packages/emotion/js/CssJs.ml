include Css_Colors
include Css_Js_Core
module Types = Css_AtomicTypes

include Css_Js_Core.Make (struct
  type styleEncoding = string
  type renderer = Js.Json.t

  external injectRaw : (string -> unit[@u]) = "injectGlobal"
  [@@mel.module "@emotion/css"]

  let renderRaw = fun [@u] _ css -> (injectRaw css [@u])

  external injectRawRules : (Js.Json.t -> unit[@u]) = "injectGlobal"
  [@@mel.module "@emotion/css"]

  let injectRules =
   fun [@u] selector rules ->
    (injectRawRules
       (Js.Dict.fromArray [| selector, rules |] |. Js.Json.object_) [@u])

  let renderRules =
   fun [@u] _ selector rules ->
    (injectRawRules
       (Js.Dict.fromArray [| selector, rules |] |. Js.Json.object_) [@u])

  external mergeStyles : (styleEncoding array -> styleEncoding[@u]) = "cx"
  [@@mel.module "@emotion/css"]

  external make : (Js.Json.t -> styleEncoding[@u]) = "css"
  [@@mel.module "@emotion/css"]

  external makeAnimation : (Js.Json.t Js.Dict.t -> string[@u]) = "keyframes"
  [@@mel.module "@emotion/css"]

  let makeKeyframes = fun [@u] frames -> (makeAnimation frames [@u])
  let renderKeyframes = fun [@u] _ frames -> (makeAnimation frames [@u])
end)

type cache

external cache : cache = "cache" [@@mel.module "@emotion/cache"]

let fontFace ~fontFamily ~src ?fontStyle ?fontWeight ?fontDisplay ?sizeAdjust ()
    =
  let fontFace =
    Css_Js_Core.fontFace ~fontFamily ~src ?fontStyle ?fontWeight ?fontDisplay
      ?sizeAdjust ()
  in
  insertRule fontFace [@u];
  fontFamily
