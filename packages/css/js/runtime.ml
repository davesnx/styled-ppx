module List = Belt.List

module Array = Belt.Array

module String = Js.String.startsWith

module Int = struct
  let toString = Belt.Int.toString
end

module Float = struct
  let toString = Belt.Float.toString
end

module Option = Belt.Option

let join strings separator =
  let rec run strings acc =
    match strings with
    | [] -> acc
    | x :: [] -> acc ^ x
    | x :: xs -> run xs ((acc ^ x) ^ separator)
  in
  run strings {js||js}
