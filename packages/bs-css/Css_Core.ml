module type CssImplementationIntf = sig
  type nonrec styleEncoding
  type nonrec renderer

  val injectRaw : (string -> unit[@u])
  val renderRaw : (renderer -> string -> unit[@u])
  val injectRules : (string -> Js.Json.t -> unit[@u])
  val renderRules : (renderer -> string -> Js.Json.t -> unit[@u])
  val make : (Js.Json.t -> styleEncoding[@u])
  val mergeStyles : (styleEncoding array -> styleEncoding[@u])
  val makeKeyframes : (Js.Json.t Js.Dict.t -> string[@u])
  val renderKeyframes : (renderer -> Js.Json.t Js.Dict.t -> string[@u])
end
