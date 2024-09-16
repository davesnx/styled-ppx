module Array = struct
  external array_unsafe_get : 'a array -> int -> 'a = "%array_unsafe_get"

  external array_unsafe_set : 'a array -> int -> 'a -> unit
    = "%array_unsafe_set"

  external array_reduce : 'b array -> ('a -> 'b -> 'a) -> 'a -> 'a = "reduce"
  [@@bs.send]

  external array_map : 'a array -> ('a -> 'b) -> 'b array = "map" [@@bs.send]
  external array_new_unsafe : int -> 'a array = "Array" [@@mel.new]

  external truncate_to_length_unsafe : 'a array -> int -> unit = "length"
  [@@mel.set]

  external length : 'a array -> int = "length" [@@mel.get]

  (* Public API *)

  let reduce ~init ~f t = array_reduce t f init
  let map ~f t = array_map t f

  let map_and_join ~sep ~f strings =
    let len = Array.length strings in
    let rec run i acc =
      if i >= len then acc
      else if i = len - 1 then acc ^ f strings.(i)
      else run (i + 1) (acc ^ f strings.(i) ^ sep)
    in
    run 0 ""

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
end

module String = struct
  external get : string -> int -> char = "%string_safe_get"
  external length : string -> int = "length" [@@bs.get]

  (* Public API *)

  external starts_with : prefix:string -> string -> bool = "startsWith"
  [@@bs.send]

  external trim : string -> string = "trim" [@@bs.send]
end

module Int = struct
  external toStringWithRadix : int -> radix:int -> string = "toString"
  [@@bs.send]

  (* Public API *)

  let to_string v = toStringWithRadix ~radix:10 v
end

module Float = struct
  external toStringWithRadix : float -> radix:int -> string = "toString"
  [@@bs.send]

  (* Public API *)

  let to_string v = toStringWithRadix ~radix:10 v
end

module Option = struct
  let get_with_default default opt =
    match opt with Some x -> x | None -> default

  let map_with_default opt default ~f =
    match opt with Some x -> f x | None -> default

  let map ~f opt = match opt with Some x -> Some (f x) | None -> None
end

module Fun = struct
  external id : 'a -> 'a = "%identity"
end