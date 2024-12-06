include Property
include Colors
include Alias
include Rule
include Emotion_bindings

(* The reason to have this alias, and not a module called "Types" directly, is because we use a unwrapped library, so all modules are exposed. "Types" would collide with a lot of modules in user's application *)
module Types = Value
