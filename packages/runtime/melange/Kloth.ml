module Array = struct
  external ( .!() ) : 'a array -> int -> 'a = "%array_unsafe_get"
  external length : 'a array -> int = "%array_length"
  external makeUninitializedUnsafe : int -> 'a array = "Array" [@@mel.new]
  external ( .!()<- ) : 'a array -> int -> 'a -> unit = "%array_unsafe_set"

  let reduceU a x f =
    let r = ref x in
    for i = 0 to length a - 1 do
      r.contents <- (f r.contents a.!(i) [@u])
    done;
    r.contents

  let reduce a x f = reduceU a x (fun [@u] a b -> f a b)

  let mapU a f =
    let l = length a in
    let r = makeUninitializedUnsafe l in
    for i = 0 to l - 1 do
      r.!(i) <- (f a.!(i) [@u])
    done;
    r

  let map a f = mapU a (fun [@u] a -> f a)

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
  external get : string -> int -> char = "%string_safe_get"
  external length : string -> int = "length" [@@mel.get]

  external startsWith : prefix:string -> bool = "startsWith"
  [@@mel.send.pipe: string]
end

module Int = struct
  external toStringWithRadix : ?radix:int -> string = "toString"
  [@@mel.send.pipe: int]

  let toString v = toStringWithRadix v
end

module Float = struct
  external toStringWithRadix : ?radix:int -> string = "toString"
  [@@mel.send.pipe: float]

  let toString v = toStringWithRadix v
end

module Option = struct
  let getWithDefault default opt =
    match opt with Some x -> x | None -> default

  let mapWithDefault opt default fn =
    match opt with Some x -> fn x | None -> default

  let map f opt = match opt with Some x -> Some (f x) | None -> None
end
