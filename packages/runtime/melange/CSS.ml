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
