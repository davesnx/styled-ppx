module Array = struct
  external reduceU :
    'a array -> f:(('b -> 'a -> 'b)[@mel.uncurry]) -> init:'b -> 'b = "reduce"
  [@@mel.send]

  let reduce ~init ~f t = reduceU t ~init ~f:(fun a b -> f a b)

  external mapU : 'a array -> f:(('a -> 'b)[@mel.uncurry]) -> 'b array = "map"
  [@@mel.send]

  let map ~f t = mapU t ~f:(fun a -> f a)

  let joinWithMap ~sep ~f strings =
    let len = Stdlib.Array.length strings in
    let rec run i acc =
      if i >= len then acc
      else if i = len - 1 then acc ^ f strings.(i)
      else run (i + 1) (acc ^ f strings.(i) ^ sep)
    in
    run 0 ""
end

module String = struct
  external get : string -> int -> char = "%string_safe_get"
  external length : string -> int = "length" [@@mel.get]

  external startsWith : string -> prefix:string -> bool = "startsWith"
  [@@mel.send]

  external trim : string -> string = "trim" [@@mel.send]
end

module Int = struct
  external toStringWithRadix : int -> radix:int -> string = "toString"
  [@@mel.send]

  let toString v = toStringWithRadix ~radix:10 v
end

module Float = struct
  external toStringWithRadix : float -> radix:int -> string = "toString"
  [@@mel.send]

  let toString v = toStringWithRadix ~radix:10 v
end

module Option = struct
  let getWithDefault default opt =
    match opt with Some x -> x | None -> default

  let mapWithDefault opt default fn =
    match opt with Some x -> fn x | None -> default

  let map f opt = match opt with Some x -> Some (f x) | None -> None
end
