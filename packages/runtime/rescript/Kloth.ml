module Array = struct
  let reduceU = Belt.Array.reduceU
  let reduceWithIndex = Belt.Array.reduceWithIndex
  let reduceWithIndexU = Belt.Array.reduceWithIndexU
  let reduce = Belt.Array.reduce
  let map = Belt.Array.map

  let joinWithMap ~sep strings ~f =
    let len = Array.length strings in
    let rec run i acc =
      if i >= len then acc
      else if i = len - 1 then acc ^ f strings.(i)
      else run (i + 1) (acc ^ f strings.(i) ^ sep)
    in
    run 0 ""
end

module String = struct
  let get = String.get
  let length = Js.String.length
  let startsWith affix str = Js.String.startsWith affix str
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
