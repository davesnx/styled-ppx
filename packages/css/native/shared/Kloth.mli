module List : sig
  val map : 'a list -> ('a -> 'b) -> 'b list
  val reduceU : 'a list -> 'b -> ('b -> 'a -> 'b) -> 'b
  val reduce : 'a list -> 'b -> ('b -> 'a -> 'b) -> 'b
  val toArray : 'a list -> 'a array
  val joinWith : sep:string -> string list -> string
end

module Array : sig
  val reduceU : 'a array -> 'b -> ('b -> 'a -> 'b) -> 'b
  val reduceWithIndexU : 'a array -> 'b -> ('b -> 'a -> int -> 'b) -> 'b
  val reduce : 'a array -> 'b -> ('b -> 'a -> 'b) -> 'b
  val map : 'a array -> ('a -> 'b) -> 'b array
  val joinWith : sep:string -> string array -> string
end

module String : sig
  val get : string -> int -> string
  val startsWith : string -> string -> bool
end

module Int : sig
  val toString : int -> string
end

module Float : sig
  val toString : float -> string
end

module Option : sig
  val getWithDefault : 'a -> 'a option -> 'a
  val mapWithDefault : 'a option -> 'b -> ('a -> 'b) -> 'b
  val map : ('a -> 'b) -> 'a option -> 'b option
end
