module Array = struct
  (* Taken from https://github.com/janestreet/base *)

  external caml_make_vect : int -> 'a -> 'a array = "caml_make_vect"

  let length = Stdlib.Array.length
  let unsafe_get = Stdlib.Array.unsafe_get
  let unsafe_set = Stdlib.Array.unsafe_set
  let sub = Stdlib.ArrayLabels.sub

  let create ~len x =
    try caml_make_vect len x
    with Invalid_argument _ ->
      failwith @@ Printf.sprintf "Array.create ~len:%d: invalid length" len

  let filter_mapi ~f t =
    let r = ref [||] in
    let k = ref 0 in
    for i = 0 to length t - 1 do
      match f i (unsafe_get t i) with
      | None -> ()
      | Some a ->
        if !k = 0 then r := create ~len:(length t) a;
        unsafe_set !r !k a;
        incr k
    done;
    if !k = length t then !r else if !k > 0 then sub ~pos:0 ~len:!k !r else [||]

  (* Public API *)

  let reduce ~init ~f t =
    let r = ref init in
    for i = 0 to Stdlib.Array.length t - 1 do
      r := f !r (Stdlib.Array.unsafe_get t i)
    done;
    !r

  let map = Stdlib.ArrayLabels.map
  let filter_map ~f t = filter_mapi t ~f:(fun _i a -> f a) [@nontail]

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
  let get = Stdlib.String.get
  let trim = Stdlib.String.trim
  let length = Stdlib.String.length

  let starts_with str ~prefix =
    let len_prefix = String.length prefix in
    let len_str = String.length str in
    let rec compare_prefix i =
      i = len_prefix
      || (i < len_str && prefix.[i] = str.[i] && compare_prefix (i + 1))
    in
    compare_prefix 0
end

module Int = struct
  let to_string v = Stdlib.string_of_int v
end

module Float = struct
  let to_string t =
    (* round x rounds x to the nearest integer with ties (fractional values of 0.5) rounded away from zero, regardless of the current rounding direction. If x is an integer, +0., -0., nan, or infinite, x itself is returned.

       On 64-bit mingw-w64, this function may be emulated owing to a bug in the C runtime library (CRT) on this platform. *)
    (* if round(f) == f, print the integer (since string_of_float 1.0 => "1.") *)
    if Stdlib.Float.equal (Stdlib.Float.round t) t then
      t |> int_of_float |> string_of_int
    else Printf.sprintf "%g" t
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
