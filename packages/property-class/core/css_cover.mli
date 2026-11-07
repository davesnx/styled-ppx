(** The two-character property id of a property name, with aliases resolved to
    their canonical property. [None] for a name outside the table and for custom
    properties. *)
val id_of_name : string -> string option

(** The longhands a property sets, sorted by id. A longhand and a [Name] return
    themselves. *)
val leaves : Css_class_format.prop -> Css_class_format.prop list

(** The number of {!leaves}. *)
val size : Css_class_format.prop -> int

(** [0] for [all]. Otherwise the connected component of the "shares a leaf"
    graph, numbered from [1]. [-1] for a [Name] or an id outside the table: its
    overlap is unknown. *)
val family : Css_class_format.prop -> int
