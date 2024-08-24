module Array = struct
  external array_unsafe_get : 'a array -> int -> 'a = "%array_unsafe_get"

  external array_unsafe_set : 'a array -> int -> 'a -> unit
    = "%array_unsafe_set"

  external array_reduce :
    'a array -> f:(('b -> 'a -> 'b)[@mel.uncurry]) -> init:'b -> 'b = "reduce"
  [@@mel.send]

  external array_map : 'a array -> f:(('a -> 'b)[@mel.uncurry]) -> 'b array
    = "map"
  [@@mel.send]

  external array_new_unsafe : int -> 'a array = "Array" [@@mel.new]

  external truncate_to_length_unsafe : 'a array -> int -> unit = "length"
  [@@mel.set]

  external length : 'a array -> int = "length" [@@mel.get]

  (* Public API *)

  let reduce ~init ~f t = array_reduce t ~init ~f:(fun a b -> f a b)
  let map ~f t = array_map t ~f:(fun a -> f a)

  let filter_map ~f t =
    let len = length t in
    let r = array_new_unsafe len in
    let j = ref 0 in
    for i = 0 to len - 1 do
      let v = array_unsafe_get t i in
      match f v with
      | None -> ()
      | Some v ->
        array_unsafe_set r j.contents v;
        j := j.contents + 1
    done;
    truncate_to_length_unsafe r j.contents;
    r

  let map_and_join ~sep ~f strings =
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

  external starts_with : string -> prefix:string -> bool = "startsWith"
  [@@mel.send]

  external trim : string -> string = "trim" [@@mel.send]
end

module Int = struct
  external toStringWithRadix : int -> radix:int -> string = "toString"
  [@@mel.send]

  let to_string v = toStringWithRadix ~radix:10 v
end

module Float = struct
  external toStringWithRadix : float -> radix:int -> string = "toString"
  [@@mel.send]

  let to_string v = toStringWithRadix ~radix:10 v
end

module Option = struct
  let get_with_default default opt =
    match opt with Some x -> x | None -> default

  let map_with_default opt default fn =
    match opt with Some x -> fn x | None -> default

  let map ~f opt = match opt with Some x -> Some (f x) | None -> None
end

module Fun = struct
  let id = Fun.id
end
