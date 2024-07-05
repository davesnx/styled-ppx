module Array : sig
  val reduce : init:'b -> f:('b -> 'a -> 'b) -> 'a array -> 'b
  val map : f:('a -> 'b) -> 'a array -> 'b array
  val joinWithMap : sep:string -> f:('a -> string) -> 'a array -> string
end

module String : sig
  val get : string -> int -> char
  val length : string -> int
  val trim : string -> string
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
