module Array : sig
  val reduce : 'a array -> 'b -> ('b -> 'a -> 'b) -> 'b
  val map : ('a -> 'b) -> 'a array -> 'b array
  val joinWithMap : sep:string -> 'a array -> f:('a -> string) -> string
end

module String : sig
  val get : string -> int -> char
  val length : string -> int
  val startsWith : prefix:string -> string -> bool
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
