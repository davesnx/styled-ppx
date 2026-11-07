(** [binding_id = ""] means the binding has no id: a reference to it resolves to
    its class chain. *)
type binding = private {
  longident : string;
  class_string : string;
  binding_id : string;
}

(** One hashed field of an atom class. [kind] is ["ctx"], ["name"], ["value"] or
    ["id"]; [token] is the hash as written in the class name; [source] is the
    text that was hashed. *)
type hash_source = {
  kind : string;
  token : string;
  source : string;
}

type atom = {
  cls : string;
  rules : string list;
  tier : int;
  conds : int;
  cover : int;
  hashes : hash_source list;
}

type ref_loc = private {
  longident : string;
  file : string;
  start_line : int;
  start_col : int;
  end_col : int;
}

val css_attribute_name : string
val bindings_attribute_name : string
val refs_attribute_name : string

(** [[@@@css.atoms [ ... ]]] carries the atom classes of a file. [css] keeps the
    loose rules (globals, keyframes, [@property]). *)
val atoms_attribute_name : string

(** [[@@@css.config [(key, value); ...]]] carries PPX-side settings that the
    aggregator must honor. Currently the only key is {!config_env_key}: the PPX
    emits [("env", "production")] when it runs in production mode (labels
    dropped, CSS minified), and the aggregator minifies its output accordingly.
    The attribute is omitted entirely in development mode, so absence means
    development. Unknown keys are ignored by the aggregator (forward
    compatibility). *)
val config_attribute_name : string

val config_env_key : string
val config_env_production : string
val sentinel_byte : char
val sentinel : string -> string
val class_chain_of_class_string : string -> string
val binding : longident:string -> class_string:string -> binding

val binding_with_id :
  longident:string -> class_string:string -> binding_id:string -> binding

val ref_loc :
  longident:string ->
  file:string ->
  start_line:int ->
  start_col:int ->
  end_col:int ->
  ref_loc

val ref_loc_of_location : longident:string -> Ppxlib.Location.t -> ref_loc
val css_attribute : string -> Ppxlib.structure_item
val bindings_attribute : binding list -> Ppxlib.structure_item
val refs_attribute : ref_loc list -> Ppxlib.structure_item
val atoms_attribute : atom list -> Ppxlib.structure_item
val config_attribute : (string * string) list -> Ppxlib.structure_item
val decode_css_payload : Ppxlib.expression -> (string, string) result
val decode_bindings_payload : Ppxlib.expression -> (binding list, string) result
val decode_refs_payload : Ppxlib.expression -> (ref_loc list, string) result
val decode_atoms_payload : Ppxlib.expression -> (atom list, string) result

val decode_config_payload :
  Ppxlib.expression -> ((string * string) list, string) result

val resolve_sentinels :
  lookup:(string -> string option) ->
  on_unresolved:(string -> unit) ->
  on_malformed:(string -> unit) ->
  string ->
  string
