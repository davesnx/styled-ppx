type binding = private {
  longident : string;
  class_string : string;
}

type ref_loc = private {
  longident : string;
  file : string;
  start_line : int;
  start_col : int;
  end_col : int;
}

(** One entry of [[@@@css.classes]]: a block's class, the index of its rule
    among the file's [[@@@css]] items, the binding that holds the block ([""]
    when the block is anonymous), and the block's location. *)
type class_entry = private {
  class_name : string;
  rule_index : int;
  binding : string;
  file : string;
  start_line : int;
  start_col : int;
  end_line : int;
  end_col : int;
}

val css_attribute_name : string
val bindings_attribute_name : string
val refs_attribute_name : string

(** [[@@@css.config [(key, value); ...]]] carries PPX-side settings that the
    aggregator must honor. Currently the only key is {!config_env_key}: the PPX
    emits [("env", "production")] when it runs in production mode (CSS
    minified), and the aggregator minifies its output accordingly. The attribute
    is omitted entirely in development mode, so absence means development.
    Unknown keys are ignored by the aggregator (forward compatibility). *)
val config_attribute_name : string

val classes_attribute_name : string
val config_env_key : string
val config_env_production : string
val sentinel_byte : char
val sentinel : string -> string
val binding : longident:string -> class_string:string -> binding

val ref_loc :
  longident:string ->
  file:string ->
  start_line:int ->
  start_col:int ->
  end_col:int ->
  ref_loc

val class_entry :
  class_name:string ->
  rule_index:int ->
  binding:string ->
  Ppxlib.Location.t ->
  class_entry

val ref_loc_of_location : longident:string -> Ppxlib.Location.t -> ref_loc
val css_attribute : string -> Ppxlib.structure_item
val bindings_attribute : binding list -> Ppxlib.structure_item
val refs_attribute : ref_loc list -> Ppxlib.structure_item
val config_attribute : (string * string) list -> Ppxlib.structure_item
val classes_attribute : class_entry list -> Ppxlib.structure_item
val decode_css_payload : Ppxlib.expression -> (string, string) result
val decode_bindings_payload : Ppxlib.expression -> (binding list, string) result
val decode_refs_payload : Ppxlib.expression -> (ref_loc list, string) result

val decode_classes_payload :
  Ppxlib.expression -> (class_entry list, string) result

val decode_config_payload :
  Ppxlib.expression -> ((string * string) list, string) result

(** Why a cross-module selector reference has no class: no binding has that
    longident, the binding lists several classes, or it is a function or a
    binding with several [%css] blocks (exported with an empty class string). *)
type lookup_error =
  | Unresolved
  | Several_blocks of int
  | Not_one_block

val resolve_sentinels :
  lookup:(string -> (string, lookup_error) result) ->
  on_error:(string -> lookup_error -> unit) ->
  on_malformed:(string -> unit) ->
  string ->
  string
