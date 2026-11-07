let sizes =
  [|
    0, 2;
    1, 4906;
    2, 1652;
    3, 1123;
    4, 895;
    5, 541;
    6, 409;
    7, 233;
    8, 172;
    9, 129;
    10, 89;
    11, 54;
    12, 40;
    13, 41;
    14, 37;
    15, 19;
    16, 10;
    17, 19;
    18, 10;
    19, 4;
    20, 4;
    21, 6;
    22, 8;
    23, 2;
    24, 4;
    26, 4;
    27, 3;
    28, 4;
    32, 2;
    33, 5;
    34, 2;
    35, 1;
    41, 2;
    46, 1;
    47, 1;
    58, 1;
    61, 2;
    64, 1;
    73, 1;
  |]

let properties =
  [|
    "background-color", 1260;
    "color", 956;
    "padding", 917;
    "width", 763;
    "height", 622;
    "line-height", 300;
    "border-radius", 295;
    "font-size", 292;
    "border", 281;
    "display", 278;
    "margin", 277;
    "border-color", 274;
    "padding-top", 120;
    "padding-left", 120;
    "margin-top", 110;
    "margin-bottom", 100;
    "margin-left", 100;
    "font-weight", 150;
    "position", 120;
    "flex", 110;
    "align-items", 120;
    "justify-content", 110;
    "overflow", 100;
    "cursor", 90;
    "opacity", 80;
    "text-align", 100;
    "gap", 90;
    "top", 60;
    "left", 60;
    "z-index", 50;
    "box-shadow", 70;
    "transition", 70;
    "max-width", 100;
    "min-width", 60;
    "flex-direction", 80;
    "text-decoration", 60;
    "white-space", 50;
    "border-top", 50;
    "background", 80;
  |]

let state = ref 12345

let next bound =
  state := !state * 75 mod 65537;
  (!state - 1) mod bound

let weighted table =
  let total = Array.fold_left (fun acc (_, w) -> acc + w) 0 table in
  fun () ->
    let target = next 65536 * total / 65536 in
    let rec go i acc =
      let v, w = table.(i) in
      if target < acc + w || i = Array.length table - 1 then v
      else go (i + 1) (acc + w)
    in
    go 0 0

let size = weighted sizes

let property =
  weighted (Array.map (fun (n, w) -> Css_cover.id_of_name n, w) properties)

let symbols = Css_class_format.alphabet
let six seed = String.init 6 (fun i -> symbols.[(seed + (i * 7)) mod 64])

let contexts =
  Array.init 12 (fun i ->
    if i = 0 then Css_class_format.plain_ctx else six (i * 5))

let context () =
  let r = next 100 in
  if r < 60 then contexts.(0) else contexts.(1 + next 11)

let atom () =
  let prop = property () in
  let ctx = context () in
  let value = six (next 8 + 100) in
  match prop with
  | Some id -> Css_class_format.encode_atom ~prop:(Id id) ~ctx ~value
  | None -> "_x"

let foreign () = "css-" ^ six (next 4096) ^ "-" ^ six (next 4096)
let fixed_size = ref (-1)

let operand ~scale token =
  let n =
    if !fixed_size >= 0 then !fixed_size else ((size () * scale) + 3) / 4
  in
  let rec go k acc = if k = 0 then acc else go (k - 1) (token () :: acc) in
  String.concat " " (go n [])

let pairs = 50_000

let family_set s =
  List.filter_map
    (fun t ->
      match Css_class_format.decode t with
      | Atom { prop; _ } -> Some (Css_cover.family prop)
      | _ -> None)
    (Css_class_format.tokens s)

let fast_share left right =
  let hits = ref 0 in
  for i = 0 to 9_999 do
    let fa = family_set left.(i)
    and fb = family_set right.(i) in
    if List.for_all (fun f -> f > 0 && not (List.mem f fb)) fa then incr hits
  done;
  !hits / 100

let time f left right =
  let sink = ref 0 in
  for _ = 1 to 2 do
    for i = 0 to pairs - 1 do
      sink := !sink + String.length (f left.(i) right.(i))
    done
  done;
  let t0 = Clock.now_ms () in
  let rounds = 6 in
  for _ = 1 to rounds do
    for i = 0 to pairs - 1 do
      sink := !sink + String.length (f left.(i) right.(i))
    done
  done;
  let ms = Clock.now_ms () -. t0 in
  ms *. 1e6 /. float_of_int (rounds * pairs), !sink

let concat a b = Clock.trim (a ^ " " ^ b)

let report name ~scale token =
  let gen () = Array.init pairs (fun _ -> operand ~scale token) in
  let left = gen () in
  let right = gen () in
  let c, s1 = time concat left right in
  let m, s2 = time Clock.merge left right in
  let share =
    if token == foreign then "n/a"
    else string_of_int (fast_share left right) ^ "%"
  in
  Printf.printf
    "%-34s concat %6.1f ns   merge %6.1f ns   ratio %5.2fx   disjoint %s   \
     (sink %d)\n"
    name c m (m /. c) share
    ((s1 + s2) mod 7)

let report_repeated name ~distinct =
  let pool () = Array.init distinct (fun _ -> operand ~scale:4 atom) in
  let pool_left = pool () in
  let pool_right = pool () in
  let left = Array.init pairs (fun i -> pool_left.(i mod distinct)) in
  let right = Array.init pairs (fun i -> pool_right.(i mod distinct)) in
  let m, s1 = time Clock.merge left right in
  let c, s2 = time Clock.cached_merge left right in
  Printf.printf
    "%-34s merge %6.1f ns   cached %6.1f ns   ratio %5.2fx   (sink %d)\n" name m
    c (c /. m)
    ((s1 + s2) mod 7)

let () =
  List.iter
    (fun n ->
      fixed_size := n;
      report (Printf.sprintf "atoms, %d + %d tokens" n n) ~scale:4 atom;
      report (Printf.sprintf "foreign, %d + %d tokens" n n) ~scale:4 foreign)
    [ 1; 2; 4; 8; 16 ];
  fixed_size := -1;
  report "foreign tokens, real sizes" ~scale:4 foreign;
  report "atoms, real sizes" ~scale:4 atom;
  report "atoms, bundles split (x1.25)" ~scale:5 atom;
  report_repeated "atoms, real sizes, 945 pairs" ~distinct:945;
  report_repeated "atoms, real sizes, all distinct" ~distinct:pairs
