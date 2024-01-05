module List = struct
  let map = Belt.List.map
  let reduceU = Belt.List.reduceU
  let reduce = Belt.List.reduce
  let toArray = Array.of_list

  let joinWith ~sep strings =
    let rec run strings acc =
      match strings with
      | [] -> acc
      | x :: [] -> acc ^ x
      | x :: xs -> run xs ((acc ^ x) ^ sep)
    in
    run strings {js||js}
end

module Array = struct
  let reduceU = Belt.Array.reduceU
  let reduceWithIndex = Belt.Array.reduceWithIndex
  let reduceWithIndexU = Belt.Array.reduceWithIndexU
  let reduce = Belt.Array.reduce
  let map = Belt.Array.map

  let joinWith ~sep strings =
    let len = Array.length strings in
    let rec run i acc =
      if i >= len then acc
      else if i = len - 1 then acc ^ strings.(i)
      else run (i + 1) (acc ^ strings.(i) ^ sep)
    in
    run 0 ""
end

module String = struct
  let get = Js.String2.get
  let startsWith affix str = Js.String2.startsWith str affix
end

module Int = struct
  let toString = Js.Int.toString
end

module Float = struct
  let toString = Js.Float.toString
end

module Option = struct
  let getWithDefault default opt =
    match opt with Some x -> x | None -> default

  let mapWithDefault opt default fn =
    match opt with Some x -> fn x | None -> default

  let map f opt = match opt with Some x -> Some (f x) | None -> None
end
