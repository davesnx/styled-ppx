type styleEncoding = string
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

external make : Js.Json.t -> styleEncoding = "css" [@@mel.module "@emotion/css"]

external makeAnimation : Js.Json.t Js.Dict.t -> string = "keyframes"
[@@mel.module "@emotion/css"]

let makeKeyframes frames = makeAnimation frames
let renderKeyframes _ frames = makeAnimation frames
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

let renderKeyframes renderer frames =
  renderKeyframes renderer (framesToDict frames)
