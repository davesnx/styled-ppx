include Colors
include Alias

(* The reason to have a module called Css_types and not Types directly, is because we use a unwrapped library, so all modules are exposed. "Types" would collide with a lot of modules in user's application *)
module Types = Css_types

(* The carrier is `(className, inline vars, debug label)`. The label is
   dev-only metadata (the `let` binding or module name the styles came
   from); the PPX omits it under --minify/--env production, so it costs
   nothing in prod. Always go through the accessors below — the
   representation is an internal detail shared with the PPX. *)
type styles = string * ReactDOM.Style.t * string option

let empty : styles = "", ReactDOM.Style.make (), None

let styles (carrier : styles) : ReactDOM.Style.t =
  let _, style, _ = carrier in
  style

let className (carrier : styles) : string =
  let name, _, _ = carrier in
  name

let label (carrier : styles) : string option =
  let _, _, label = carrier in
  label

let inline_vars vars =
  List.fold_left
    (fun style (key, value) -> ReactDOM.Style.unsafeAddProp style key value)
    (ReactDOM.Style.make ()) vars

(* `make` deliberately has no optional label argument, mirroring the
   melange runtime (where optional-arg saturation would cost bytes on
   every production binding). Dev-mode codegen calls `make_labeled`. *)
let make className vars : styles = className, inline_vars vars, None

let make_labeled label className vars : styles =
  className, inline_vars vars, Some label

let merge_labels left right =
  match left, right with
  | None, None -> None
  | Some l, None | None, Some l -> Some l
  | Some l, Some r -> Some (l ^ " " ^ r)

let merge (styles1 : styles) (styles2 : styles) =
  let merged_className =
    String.trim (className styles1 ^ " " ^ className styles2)
  in
  let style = ReactDOM.Style.combine (styles styles1) (styles styles2) in
  merged_className, style, merge_labels (label styles1) (label styles2)

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
