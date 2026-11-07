(** Merging of class strings. Operands are the class strings of [CSS.make] or of
    an earlier merge: tokens separated by single spaces, each already
    normalized. Merging normalized operands gives a normalized result. *)

(** [merge a b] is [normalize (a ^ " " ^ b)] for normalized [a] and [b]. When
    the cover families of the atoms of [a] and [b] are disjoint and the two
    sides share no other token, it joins the strings without decoding them. *)
val merge : string -> string -> string

(** Keeps the tokens that win. Walking from the last token to the first, an atom
    or bundle is dropped when every (context, longhand) cell it sets is set by a
    later token. An atom in another context never drops it. A token that is not
    an atom (a binding id or a foreign class) is dropped only when the same
    token occurs later. Tokens keep their order and are joined by one space. *)
val normalize : string -> string

module type Text = Css_merge_core.Text
module type S = Css_merge_core.S

module Make : functor (_ : Text) -> S
