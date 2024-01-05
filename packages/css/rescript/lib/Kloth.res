module List = {
  let map = Belt.List.map
  let reduceU = Belt.List.reduceU
  let reduce = Belt.List.reduce
  let toArray = Array.of_list

  let joinWith = (~sep, strings) => {
    let rec run = (strings, acc) =>
      switch strings {
      | list{} => acc
      | list{x} => acc ++ x
      | list{x, ...xs} => run(xs, acc ++ x ++ sep)
      }

    run(strings, ``)
  }
}

module Array = {
  let reduceU = Belt.Array.reduceU
  let reduceWithIndex = Belt.Array.reduceWithIndex
  let reduceWithIndexU = Belt.Array.reduceWithIndexU
  let reduce = Belt.Array.reduce
  let map = Belt.Array.map

  let joinWith = (~sep, strings) => {
    let len = Array.length(strings)
    let rec run = (i, acc) =>
      if i >= len {
        acc
      } else if i == len - 1 {
        acc ++ strings[i]
      } else {
        run(i + 1, acc ++ (strings[i] ++ sep))
      }

    run(0, "")
  }
}

module String = {
  let get = Js.String2.get
  let startsWith = (affix, str) => Js.String2.startsWith(str, affix)
}

module Int = {
  let toString = Js.Int.toString
}

module Float = {
  let toString = Js.Float.toString
}

module Option = {
  let getWithDefault = (default, opt) =>
    switch opt {
    | Some(x) => x
    | None => default
    }

  let mapWithDefault = (opt, default, fn) =>
    switch opt {
    | Some(x) => fn(x)
    | None => default
    }

  let map = (f, opt) =>
    switch opt {
    | Some(x) => Some(f(x))
    | None => None
    }
}
