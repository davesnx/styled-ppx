include Colors
include Alias

(* The reason to have a module called Css_types and not Types directly, is because we use a unwrapped library, so all modules are exposed. "Types" would collide with a lot of modules in user's application *)
module Types = Css_types

type styles = string * ReactDOM.Style.t

let empty : styles = "", ReactDOM.Style.make ()
let styles (carrier : styles) : ReactDOM.Style.t = snd carrier
let className (carrier : styles) : string = fst carrier

let make className vars : styles =
  let style =
    Kloth.List.reduce
      ~f:(fun style (key, value) ->
        ReactDOM.Style.unsafeAddProp style key value)
      ~init:(ReactDOM.Style.make ()) vars
  in
  className, style

let merge (styles1 : styles) (styles2 : styles) =
  let className = Kloth.String.trim (fst styles1 ^ " " ^ fst styles2) in
  let style = ReactDOM.Style.combine (snd styles1) (snd styles2) in
  className, style

external create_style_element : string -> < .. > Js.t -> React.element
  = "createElement"
[@@mel.module "react"]

external inner_html : __html:string -> unit -> < .. > Js.t = "" [@@mel.obj]

external style_props :
  dangerouslySetInnerHTML:< .. > Js.t -> unit -> < .. > Js.t = ""
[@@mel.obj]

let global_style_tag css =
  create_style_element "style"
    (style_props ~dangerouslySetInnerHTML:(inner_html ~__html:css ()) ())
