include Declarations
include Colors
include Alias
include Rule
include Emotion_bindings

(* The reason to have a module called Css_types and not Types directly, is because we use a unwrapped library, so all modules are exposed. "Types" would collide with a lot of modules in user's application *)
module Types = Css_types

type styles = {
  className : string;
  dynamic : (string * string) list;
}

let make className dynamic = { className; dynamic }

(* Helper functions for JSX transformation *)
let get_className styles = styles.className
let get_dynamic styles = styles.dynamic

(* Convert dynamic list to JavaScript object for style prop *)
let dynamic_to_object dynamic_list =
  (* For now, just return the list - proper implementation would convert to JS object *)
  dynamic_list
