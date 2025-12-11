module List = struct
  let fold_left = Stdlib.List.fold_left
  let length = Stdlib.List.length
  let map = Stdlib.List.map
  let append = Stdlib.List.append
  let rev = Stdlib.List.rev
  let iteri = Stdlib.ListLabels.iteri
end

module Set = Stdlib.Set

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

  let append = Stdlib.ArrayLabels.append
  let concat = Stdlib.ArrayLabels.concat
  let to_list = Stdlib.ArrayLabels.to_list
  let iter = Stdlib.ArrayLabels.iter
  let iteri = Stdlib.ArrayLabels.iteri
  let fold_left = Stdlib.ArrayLabels.fold_left
  let fold_right = Stdlib.ArrayLabels.fold_right
  let is_empty a = Stdlib.Array.length a == 0
  let is_not_empty a = Stdlib.Array.length a != 0

  let partition_map ~f t =
    let (both : _ Either.t array) = map t ~f in
    let firsts =
      filter_map ~f:(function Either.Left x -> Some x | Right _ -> None) both
    in
    let seconds =
      filter_map ~f:(function Either.Left _ -> None | Right x -> Some x) both
    in
    firsts, seconds

  let partition ~f t =
    partition_map t ~f:(fun x ->
      match f x with true -> Left x | false -> Right x)
    [@nontail]

  let flatten a = concat (to_list a)
  let exists = Stdlib.ArrayLabels.exists
  let get = Stdlib.Array.get
  let of_list = Stdlib.Array.of_list
  let find_map = Stdlib.ArrayLabels.find_map
  let ( @ ) = Stdlib.Array.append
end

module String = struct
  type t = string

  let make = Stdlib.String.make
  let get = Stdlib.String.get
  let trim = Stdlib.String.trim
  let length = Stdlib.String.length
  let contact = Stdlib.String.concat
  let contains = Stdlib.String.contains
  let unsafe_get = Stdlib.String.unsafe_get
  let sub = Stdlib.String.sub
  let compare = Stdlib.String.compare

  let starts_with str ~prefix =
    let len_prefix = String.length prefix in
    let len_str = String.length str in
    let rec compare_prefix i =
      i = len_prefix
      || (i < len_str && prefix.[i] = str.[i] && compare_prefix (i + 1))
    in
    compare_prefix 0
end

module Char = struct
  let lowercase_ascii = Stdlib.Char.lowercase_ascii
end

module Int = struct
  let to_string v = Stdlib.string_of_int v
  let add = Stdlib.Int.add
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

  let map fn opt = match opt with Some x -> Some (fn x) | None -> None
end

module Fun = struct
  let id = Fun.id
end [@platforn native]

module Buffer = Stdlib.Buffer [@platforn native]
module Printf = Stdlib.Printf

let ( + ) = Stdlib.Int.add
let ( - ) = Stdlib.Int.sub
let ( * ) = Stdlib.Int.mul
let ( ^ ) = Stdlib.String.cat
let ( |> ) = Stdlib.( |> )
let ( = ) = Stdlib.( = )
let ( != ) = Stdlib.( != )
let ( == ) = Stdlib.( == )
let ( <> ) = Stdlib.( <> )
let ( <= ) = Stdlib.( <= )
let ( >= ) = Stdlib.( >= )
let ( < ) = Stdlib.( < )
let ( > ) = Stdlib.( > )
let ( && ) = Stdlib.( && )
let ( || ) = Stdlib.( || )
let ( @@ ) = Stdlib.( @@ )
let string_of_int = Stdlib.string_of_int
let print_endline = Stdlib.print_endline
let fst = Stdlib.fst
let snd = Stdlib.snd
