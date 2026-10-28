type binding = private {
  longident : string;
  identity : string;
  class_string : string;
}

(** What the aggregator needs to order one atom rule, computed by the PPX from
    the rule's AST.

    - [class_name]: the atom's own [_a_]/[_in_] class.
    - [scope]: importance, specificity and the element the rule styles, as one
      string. Two rules can only compete when their scopes are equal.
    - [family], [mask]: the longhands the declarations set, on the canonical
      property name (an alias resolved, no vendor prefix). Two rules set a
      shared longhand when their families are equal and their masks share a bit.
      [family] is ["*"] for [all], and starts with ['-'] when [all] does not
      reset the property ([direction], [unicode-bidi], custom properties).
    - [descendant]: the rule styles an element other than the atom's own,
      through a combinator, and that element's compound has no class. *)
type atom_key = private {
  class_name : string;
  scope : string;
  family : string;
  mask : int;
  descendant : bool;
}

(** One [[@@@css ...]] entry: an atom rule carries its {!atom_key}; a
    [%styled.global] rule, a [@keyframes] or a [@property] registration carries
    none. *)
type rule = {
  text : string;
  key : atom_key option;
}

(** One [%css]/[%styled.<tag>] block, named or anonymous: the source line of its
    CSS string, its identity class ([None] when anonymous) and its rules as
    indices into the file's [[@@@css ...]] list, in emotion order (the block's
    own declarations, then its nested rules, each in source order). The
    aggregator orders competing rules of one block in this order. No file field:
    the block's file is the input file that carries the attribute. *)
type block = private {
  line : int;
  identity : string option;
  rules : int list;
}

(** A [CSS.merge] or [+++] argument the PPX resolved: a block of the same file
    (index into its [[@@@css.blocks ...]] list), or a binding of another module
    (its longident, as in [[@@@css.bindings ...]]). *)
type operand =
  | Block of int
  | Binding of string

(** A [CSS.merge(a, b)] or [a +++ b] chain at [merge_line], with its arguments
    in call order; arguments the PPX could not resolve are left out. *)
type merge = private {
  merge_line : int;
  operands : operand list;
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

(** [[@@@css.blocks [(line, identity, [rule index; ...]); ...]]]: every block of
    the compilation unit, see {!block}. *)
val blocks_attribute_name : string

(** [[@@@css.merges [(line, [operand; ...]); ...]]]: every merge of the
    compilation unit, see {!merge}. An operand is an integer (a block index) or
    a string (a longident). *)
val merges_attribute_name : string

(** [[@@@css.config [(key, value); ...]]] carries PPX-side settings that the
    aggregator must honor. Keys today: {!config_env_key} — the PPX emits
    [("env", "production")] when it runs in production mode (CSS whitespace
    minified, dev markers off), and the aggregator minifies its output
    accordingly; and {!config_library_key} — the PPX emits
    [("library-name", name)] when dune passed it a `library-name` cookie (set on
    `(library ...)` stanzas), which the aggregator uses to group and order rules
    by owning library. The attribute is omitted entirely when no key applies
    (development, no library cookie), so absence means development. Unknown keys
    are ignored by the aggregator (forward compatibility). *)
val config_attribute_name : string

val config_env_key : string
val config_env_production : string
val config_library_key : string
val sentinel_byte : char
val sentinel : string -> string

val binding :
  longident:string -> identity:string -> class_string:string -> binding

val atom_key :
  class_name:string ->
  scope:string ->
  family:string ->
  mask:int ->
  descendant:bool ->
  atom_key

(** The [family] of a rule that sets [all]. *)
val all_family : string

(** True when the two rules set at least one shared longhand. *)
val overlaps : atom_key -> atom_key -> bool

val block : line:int -> identity:string option -> rules:int list -> block
val merge : line:int -> operands:operand list -> merge

val ref_loc :
  longident:string ->
  file:string ->
  start_line:int ->
  start_col:int ->
  end_col:int ->
  ref_loc

val ref_loc_of_location : longident:string -> Ppxlib.Location.t -> ref_loc
val css_attribute : rule -> Ppxlib.structure_item
val bindings_attribute : binding list -> Ppxlib.structure_item
val refs_attribute : ref_loc list -> Ppxlib.structure_item
val blocks_attribute : block list -> Ppxlib.structure_item
val merges_attribute : merge list -> Ppxlib.structure_item
val config_attribute : (string * string) list -> Ppxlib.structure_item
val decode_css_payload : Ppxlib.expression -> (rule, string) result
val decode_bindings_payload : Ppxlib.expression -> (binding list, string) result
val decode_refs_payload : Ppxlib.expression -> (ref_loc list, string) result
val decode_blocks_payload : Ppxlib.expression -> (block list, string) result
val decode_merges_payload : Ppxlib.expression -> (merge list, string) result

val decode_config_payload :
  Ppxlib.expression -> ((string * string) list, string) result

val resolve_sentinels :
  lookup:(string -> string option) ->
  on_unresolved:(string -> unit) ->
  on_malformed:(string -> unit) ->
  string ->
  string
