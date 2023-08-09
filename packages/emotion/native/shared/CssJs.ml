include Css_native.Css_Colors
include Css_native.Css_Js_Core
module Core = Css_native.Css_Js_Core

let style arr = Css.style (Array.to_list arr)
