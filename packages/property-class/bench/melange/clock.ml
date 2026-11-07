external now : unit -> float = "now" [@@mel.scope "performance"]

let now_ms = now
let trim = Js.String.trim
let merge = CSS.Class_merge.merge
let cached_merge = merge
