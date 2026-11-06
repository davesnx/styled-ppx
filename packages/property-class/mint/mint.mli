(** A field of a class name that comes from a hash. [token] is the written field
    and [source] is what it was hashed from, NUL and backslash escaped. *)
type hashed = {
  kind : string;
  token : string;
  source : string;
}

(** The class name of a unit: a plain context atom, another context atom, a
    custom or unknown property atom, or a bundle. Raises [Invalid_argument] for
    a unit without pieces. A bundle that holds a custom or unknown property gets
    the reserved id [zz] in its cell, so it decodes as foreign. *)
val token : Atomize.unit_ -> string

(** Every hash behind {!token}, for the collision check. *)
val hashes : Atomize.unit_ -> hashed list
