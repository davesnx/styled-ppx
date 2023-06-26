module type CssImplementationIntf  =
  sig
    type nonrec styleEncoding
    type nonrec renderer
    val injectRaw : ((string -> unit)[@bs ])
    val renderRaw : ((renderer -> string -> unit)[@bs ])
    val injectRules : ((string -> Js.Json.t -> unit)[@bs ])
    val renderRules : ((renderer -> string -> Js.Json.t -> unit)[@bs ])
    val make : ((Js.Json.t -> styleEncoding)[@bs ])
    val mergeStyles : ((styleEncoding array -> styleEncoding)[@bs ])
    val makeKeyframes : ((Js.Json.t Js.Dict.t -> string)[@bs ])
    val renderKeyframes : ((renderer -> Js.Json.t Js.Dict.t -> string)[@bs ])
  end
