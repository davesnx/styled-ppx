module type CssImplementationIntf = sig
  type styleEncoding
  type renderer

  val injectRaw : string -> unit
  val renderRaw : renderer -> string -> unit
  val injectRules : string -> Js.Json.t -> unit
  val renderRules : renderer -> string -> Js.Json.t -> unit
  val make : Js.Json.t -> styleEncoding
  val mergeStyles : styleEncoding array -> styleEncoding
  val makeKeyframes : Js.Json.t Js.Dict.t -> string
  val renderKeyframes : renderer -> Js.Json.t Js.Dict.t -> string
end
