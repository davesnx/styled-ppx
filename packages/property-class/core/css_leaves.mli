(** The cover table a runtime needs, decoded at load from {!Css_cover_data}. *)

(** The number of property ids in the table. *)
val count : int

(** The leaf indices of the property at an index below {!count}: itself for a
    longhand. Sorted. The array is shared: do not mutate it. *)
val leaf_indices : int -> int array

(** The family of the property at an index below {!count}. *)
val family_of_index : int -> int
