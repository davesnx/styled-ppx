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
    List.fold_left
      (fun style (key, value) -> ReactDOM.Style.unsafeAddProp style key value)
      (ReactDOM.Style.make ()) vars
  in
  className, style

let combine_vars style1 style2 =
  let all = ReactDOM.Style.combine style1 style2 in
  let rec last_value key value = function
    | [] -> value
    | (_, k, v) :: rest -> last_value key (if k = key then v else value) rest
  in
  let rec dedupe seen = function
    | [] -> []
    | (property, key, value) :: rest ->
      if List.mem key seen then dedupe seen rest
      else
        (property, key, last_value key value rest) :: dedupe (key :: seen) rest
  in
  dedupe [] all

let merge (styles1 : styles) (styles2 : styles) =
  ( Css_merge.merge (fst styles1) (fst styles2),
    combine_vars (snd styles1) (snd styles2) )

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
