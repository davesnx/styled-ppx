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

(* Drop a class of [styles1] when a class of [styles2] covers the same
   merge-key slot (context + family, [styles1]'s longhands a subset of
   [styles2]'s) - see [Merge_key.removes]. A bundle ([in-]), identity
   ([id-]), `label:<binding>` marker, or any class this module can't parse
   is never dropped and never drops anything else; [styles2]'s own classes
   are never dropped either way. *)
let merge (styles1 : styles) (styles2 : styles) =
  let className = Merge_key.merge_class_names (fst styles1) (fst styles2) in
  let style = ReactDOM.Style.combine (snd styles1) (snd styles2) in
  className, style

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
