let id name =
  match Css_cover.id_of_name name with
  | Some id -> Css_class_format.Id id
  | None -> failwith ("no id for " ^ name)

let plain = Css_class_format.plain_ctx
let contexts = [| plain; plain; plain; "3fQ-zT"; "3fQaaa"; "9-_Aab" |]
let values = [| "Xk3_9w"; "aaaaaa"; "bbbbbb" |]

let names =
  [|
    "margin";
    "margin-top";
    "margin-left";
    "padding";
    "padding-top";
    "color";
    "border";
    "border-top";
    "border-color";
    "font";
    "line-height";
    "display";
    "width";
    "gap";
    "overflow";
    "all";
  |]

let atom ctx value name =
  Css_class_format.encode_atom ~prop:(id name) ~ctx ~value

let bundle ctx value (n1, n2) =
  Css_class_format.encode_bundle ~cells:[ id n1, ctx; id n2, ctx ] ~value

let state = ref 12345

let next bound =
  state := !state * 75 mod 65537;
  (!state - 1) mod bound

let pick arr = arr.(next (Array.length arr))

let token () =
  let kind = next 12 in
  let ctx = pick contexts in
  let value = pick values in
  match kind with
  | 0 -> pick [| "card"; "active"; "css-1abc" |]
  | 1 -> Css_class_format.encode_binding_id (pick [| "AAAAAAAA"; "BBBBBBBB" |])
  | 2 ->
    Css_class_format.encode_atom
      ~prop:(Name (pick [| "abcdef"; "ghijkl" |]))
      ~ctx ~value
  | 3 ->
    bundle ctx value
      (pick [| "margin-top", "padding-top"; "color", "margin-left" |])
  | _ -> atom ctx value (pick names)

let rec repeat n f =
  if n <= 0 then []
  else (
    let x = f () in
    x :: repeat (n - 1) f)

let vars () =
  repeat (next 4) (fun () ->
    let name = pick [| "--a"; "--b"; "--c"; "--d" |] in
    let value = string_of_int (next 100) in
    name, value)

let operand () =
  let classes = String.concat " " (repeat (next 7) token) in
  let vars = vars () in
  classes, vars

let fixed =
  let a = atom plain "Xk3_9w" in
  let h = atom "3fQ-zT" "Xk3_9w" in
  [
    [ a "margin-top"; a "color" ], [ a "margin" ];
    [ a "margin" ], [ a "margin-top" ];
    [ a "color" ], [ h "color" ];
    [ "card"; a "color" ], [ "card"; a "width" ];
    [ a "color"; a "direction" ], [ a "all" ];
    [ bundle plain "Xk3_9w" ("margin-top", "padding-top") ], [ a "margin" ];
    [ " card" ], [ "active " ];
    [ {js|_ad3ĀĀĀĀĀĀ|js} ], [ a "margin-top" ];
    [ {js|_ad3😀3_9w|js} ], [ a "margin-top" ];
    [], [ "x" ];
  ]

let cases =
  List.map
    (fun (a, b) ->
      ( (String.concat " " a, [ "--x", "1"; "--y", "2" ]),
        (String.concat " " b, [ "--y", "3"; "--x", "4" ]),
        ("", []) ))
    fixed
  @ repeat 3000 (fun () ->
    let a = operand () in
    let b = operand () in
    let c = operand () in
    a, b, c)

let run ~make ~merge ~class_name ~dump_style =
  List.iter
    (fun ((ac, av), (bc, bv), (cc, cv)) ->
      let ab = merge (make ac av) (make bc bv) in
      let abc = merge ab (make cc cv) in
      List.iter
        (fun r -> print_endline (class_name r ^ " | " ^ dump_style r))
        [ ab; abc ])
    cases
