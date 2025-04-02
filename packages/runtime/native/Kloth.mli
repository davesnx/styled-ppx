module Array : sig
  val reduce : init:'b -> f:('b -> 'a -> 'b) -> 'a array -> 'b
  val map : f:('a -> 'b) -> 'a array -> 'b array
  val filter_map : f:('a -> 'b option) -> 'a array -> 'b array
  val map_and_join : sep:string -> f:('a -> string) -> 'a array -> string
end

module String : sig
  val get : string -> int -> char
  val length : string -> int
  val trim : string -> string
  val starts_with : prefix:string -> string -> bool
  val contains: string -> char -> bool
end

module Int : sig
  val to_string : int -> string
end

module Float : sig
  val to_string : float -> string
end

module Option : sig
  val get_with_default : 'a -> 'a option -> 'a
  val map_with_default : 'a option -> 'b -> ('a -> 'b) -> 'b
  val map : f:('a -> 'b) -> 'a option -> 'b option
end

module Fun : sig
  val id : 'a -> 'a
end
