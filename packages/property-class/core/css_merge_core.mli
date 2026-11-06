(** The functor of {!Css_merge}, without the stdlib instance: a runtime that
    supplies its own string primitives links no [String] or [Bytes]. *)

(** String primitives that a runtime may replace. [String.sub] and
    [String.concat] copy through [Bytes], which is slow in Melange. *)
module type Text = sig
  val sub : string -> int -> int -> string
  val concat : string -> string list -> string
end

module type S = sig
  val merge : string -> string -> string
  val normalize : string -> string
end

module Make (_ : Text) : S
