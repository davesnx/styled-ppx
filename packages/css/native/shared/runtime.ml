module List = struct
  let map = Belt.List.map
  let reduceU = Belt.List.reduceU
  let reduce = Belt.List.reduce
  let toArray = Array.of_list

  let joinWith strings separator =
    let rec run strings acc =
      match strings with
      | [] -> acc
      | x :: [] -> acc ^ x
      | x :: xs -> run xs ((acc ^ x) ^ separator)
    in
    run strings {js||js}
end

module Array = struct
  let reduceU = Belt.Array.reduceU
  let reduceWithIndexU = Belt.Array.reduceWithIndexU
  let reduce = Belt.Array.reduce
  let map = Belt.Array.map

  let joinWith strings separator =
    let len = Array.length strings in
    let rec run i acc =
      if i >= len then acc
      else if i = len - 1 then acc ^ strings.(i)
      else run (i + 1) (acc ^ strings.(i) ^ separator)
    in
    run 0 ""
end

module String = struct
  let startsWith affix str =
    let start = try String.sub str 0 (String.length affix) with _ -> "" in
    String.equal start str
end

module Int = struct
  let toString = Belt.Int.toString
end

module Float = struct
  let _round x =
    let floor_val = floor x in
    if x -. floor_val < 0.5 then floor_val else ceil x

  let toString f =
    if _round f = f then f |> int_of_float |> string_of_int
    else string_of_float f
end

module Option = struct
  let getWithDefault default opt =
    match opt with Some x -> x | None -> default

  let mapWithDefault opt default fn =
    match opt with Some x -> fn x | None -> default

  let map f opt =
    match opt with Some x -> Some (f x) [@explicit_arity] | None -> None
end
