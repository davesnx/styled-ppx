module Array = struct
  external array_reduce : 'b array -> ('a -> 'b -> 'a) -> 'a -> 'a = "reduce"
  [@@mel.send]

  let reduce ~init ~f t = array_reduce t f init

  external array_map : 'a array -> ('a -> 'b) -> 'b array = "map" [@@mel.send]

  let map ~f t = array_map t f

  let joinWithMap ~sep ~f strings =
    let len = Array.length strings in
    let rec run i acc =
      if i >= len then acc
      else if i = len - 1 then acc ^ f strings.(i)
      else run (i + 1) (acc ^ f strings.(i) ^ sep)
    in
    run 0 ""
end

module String = struct
  external get : string -> int -> char = "%string_safe_get"
  external length : string -> int = "length" [@@bs.get]

  external startsWith : prefix:string -> string -> bool = "startsWith"
  [@@bs.send]

  external trim : string -> string = "trim" [@@bs.send]
end

module Int = struct
  external toStringWithRadix : int -> radix:int -> string = "toString"
  [@@bs.send]

  let toString v = toStringWithRadix ~radix:10 v
end

module Float = struct
  external toStringWithRadix : float -> radix:int -> string = "toString"
  [@@bs.send]

  let toString v = toStringWithRadix ~radix:10 v
end

module Option = struct
  let getWithDefault default opt =
    match opt with Some x -> x | None -> default

  let mapWithDefault opt default fn =
    match opt with Some x -> fn x | None -> default

  let map f opt = match opt with Some x -> Some (f x) | None -> None
end
