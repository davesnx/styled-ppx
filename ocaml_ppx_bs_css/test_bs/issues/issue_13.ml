open Css
let test = [%style {|
  flex-grow: 0;
  flex-shrink: 0;
|}]

let equal = [flexGrow 0.0; flexShrink 0.0]
let _ = assert (test = equal)
