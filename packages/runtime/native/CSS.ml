include Colors
include Alias

(* The reason to have a module called Css_types and not Types directly, is because we use a unwrapped library, so all modules are exposed. "Types" would collide with a lot of modules in user's application *)
module Types = Css_types

(* className, inline style, label. The label is the binding name(s) the styles
   came from, space-separated like a DOMTokenList; styled components render it
   as the element's [part] attribute, in every build mode, so a style can be
   found in the DOM inspector without a class-name suffix. *)
type styles = string * ReactDOM.Style.t * string

let empty : styles = "", ReactDOM.Style.make (), ""
let styles ((_, style, _) : styles) : ReactDOM.Style.t = style
let className ((className, _, _) : styles) : string = className
let label ((_, _, label) : styles) : string = label

let make ?(label = "") className vars : styles =
  let style =
    List.fold_left
      (fun style (key, value) -> ReactDOM.Style.unsafeAddProp style key value)
      (ReactDOM.Style.make ()) vars
  in
  className, style, label

let join left right = String.trim (left ^ " " ^ right)

let merge ((c1, s1, l1) : styles) ((c2, s2, l2) : styles) : styles =
  join c1 c2, ReactDOM.Style.combine s1 s2, join l1 l2

let global_style_tag css =
  ReactDOM.createDOMElementVariadic "style"
    ~props:
      (ReactDOM.domProps
         ~dangerouslySetInnerHTML:
           object
             method __html = css
           end
         ())
    [||]
