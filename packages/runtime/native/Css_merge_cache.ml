module Pairs = Map.Make (struct
  type t = string * string

  let compare (a1, b1) (a2, b2) =
    let c = String.compare a1 a2 in
    if c <> 0 then c else String.compare b1 b2
end)

let cap = 4096
let cache = Atomic.make (0, Pairs.empty)

let merge a b =
  let ((size, pairs) as current) = Atomic.get cache in
  match Pairs.find_opt (a, b) pairs with
  | Some merged -> merged
  | None ->
    let merged = Css_merge.merge a b in
    let next =
      if size >= cap then 1, Pairs.singleton (a, b) merged
      else size + 1, Pairs.add (a, b) merged pairs
    in
    ignore (Atomic.compare_and_set cache current next);
    merged
