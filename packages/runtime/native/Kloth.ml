module Array = struct
  let reduce a x f =
    let r = ref x in
    for i = 0 to Stdlib.Array.length a - 1 do
      r := f !r (Stdlib.Array.unsafe_get a i)
    done;
    !r

  let map f a = Stdlib.Array.map f a

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
  let get = String.get
  let length = Stdlib.String.length

  let startsWith ~prefix str =
    let len_prefix = String.length prefix in
    let len_str = String.length str in
    let rec compare_prefix i =
      i = len_prefix
      || (i < len_str && prefix.[i] = str.[i] && compare_prefix (i + 1))
    in
    compare_prefix 0
end

module Int = struct
  let toString v = Stdlib.string_of_int v
end

module Float = struct
  let toString t =
    (* round x rounds x to the nearest integer with ties (fractional values of 0.5) rounded away from zero, regardless of the current rounding direction. If x is an integer, +0., -0., nan, or infinite, x itself is returned.

       On 64-bit mingw-w64, this function may be emulated owing to a bug in the C runtime library (CRT) on this platform. *)
    (* if round(f) == f, print the integer (since string_of_float 1.0 => "1.") *)
    if Stdlib.Float.equal (Stdlib.Float.round t) t then
      t |> int_of_float |> string_of_int
    else Printf.sprintf "%g" t
end

module Option = struct
  let getWithDefault default opt =
    match opt with Some x -> x | None -> default

  let mapWithDefault opt default fn =
    match opt with Some x -> fn x | None -> default

  let map f opt = match opt with Some x -> Some (f x) | None -> None
end
