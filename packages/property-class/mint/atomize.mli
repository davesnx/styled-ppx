type context = Context_key.context = {
  scope : string;
  conditions : string list;
  important : bool;
}

(** [scope] marks the element itself with [&]. [prop] is the name as written and
    [text] is the whole declaration, references resolved. *)
type decl = {
  context : context;
  prop : string;
  text : string;
}

type unit_ = {
  pieces : decl list;
  bundle : bool;
  tier : int;
  conds : int;
  cover : int;
}

(** A property as the class format keys it. [Known] holds the two-character id,
    with aliases resolved. [Unknown] holds the name: lowercase, except for
    custom properties. *)
type property =
  | Known of string
  | Unknown of string

val property : string -> property

(** [0] for a child, descendant or sibling scope, [1] for the plain own context,
    [2] for any other own context. *)
val tier : context -> int

(** One unit per class, in block order of its last piece. Overlapping
    declarations of one block are joined into a bundle, except an important
    declaration and a normal one, which never share a unit. A unit that a later
    unit of the block covers cell for cell is dropped. *)
val units : decl list -> unit_ list
