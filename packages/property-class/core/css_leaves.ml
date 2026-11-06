let count = Css_cover_data.count
let universal = Css_cover_data.universal
let digit c = if c <= '9' then Char.code c - 48 else Char.code c - 87

let leaf_table =
  let packed = Css_cover_data.packed in
  let table = Array.make count [||] in
  let scratch = Array.make count 0 in
  let len = String.length packed in
  let id = ref 0
  and prev = ref 0
  and num = ref 0
  and n = ref 0 in
  let push () =
    let d = !num in
    prev := !prev + if d land 1 = 0 then d / 2 else -((d + 1) / 2);
    scratch.(!n) <- !prev;
    incr n;
    num := 0
  in
  for i = 0 to len do
    let c = if i = len then ' ' else String.unsafe_get packed i in
    if c = '=' then (
      id := !id + !num;
      num := 0;
      prev := !id;
      n := 0)
    else if c = ',' then push ()
    else if c = ' ' then (
      push ();
      table.(!id) <- Array.sub scratch 0 !n)
    else num := (!num * 36) + digit c
  done;
  for i = 0 to count - 1 do
    if Array.length table.(i) = 0 then table.(i) <- Array.make 1 i
  done;
  table

let family_table =
  let parent = Array.init count (fun i -> i) in
  let rec find i =
    let p = parent.(i) in
    if p = i then i
    else (
      let r = find p in
      parent.(i) <- r;
      r)
  in
  for i = 0 to count - 1 do
    if i <> universal then
      Array.iter
        (fun leaf ->
          let root = find leaf in
          parent.(root) <- find i)
        leaf_table.(i)
  done;
  let numbers = Array.make count 0 in
  let next = ref 0 in
  Array.init count (fun i ->
    if i = universal then 0
    else (
      let root = find i in
      if numbers.(root) = 0 then (
        incr next;
        numbers.(root) <- !next);
      numbers.(root)))

let leaf_indices i = Array.unsafe_get leaf_table i
let family_of_index i = Array.unsafe_get family_table i
