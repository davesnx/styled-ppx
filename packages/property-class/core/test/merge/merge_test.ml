open Property_class_core
module Format_ = Css_class_format

let id name =
  match Css_cover.id_of_name name with
  | Some id -> Format_.Id id
  | None -> Alcotest.failf "no id for %s" name

let plain = Format_.plain_ctx
let hover = "3fQ-zT"
let focus = "9-_Aab"
let v1 = "Xk3_9w"
let v2 = "aaaaaa"
let v3 = "bbbbbb"

let atom ?(ctx = plain) ?(value = v1) name =
  Format_.encode_atom ~prop:(id name) ~ctx ~value

let name_atom ?(ctx = plain) ?(value = v1) name =
  Format_.encode_atom ~prop:(Name name) ~ctx ~value

let plain_as_c name value =
  match id name with
  | Id pid -> "_c" ^ pid ^ plain ^ value
  | Name _ -> assert false

let bundle ?(value = v1) cells =
  Format_.encode_bundle
    ~cells:(List.map (fun (name, ctx) -> id name, ctx) cells)
    ~value

let binding = Format_.encode_binding_id "AAAAAAAA"
let other_binding = Format_.encode_binding_id "BBBBBBBB"
let join = String.concat " "
let merge2 a b = Css_merge.merge (join a) (join b)

let check_merge ?(msg = "merge") a b expected =
  Alcotest.(check string) msg (join expected) (merge2 a b)

let golden_tests =
  let case name fn = Alcotest.test_case name `Quick fn in
  [
    case "a later shorthand drops the longhand it covers" (fun () ->
      check_merge [ atom "margin-top" ] [ atom "margin" ] [ atom "margin" ];
      check_merge
        [ atom "margin-top"; atom "color" ]
        [ atom "margin" ]
        [ atom "color"; atom "margin" ]);
    case "a later longhand does not drop the shorthand" (fun () ->
      check_merge
        [ atom "margin" ]
        [ atom "margin-top" ]
        [ atom "margin"; atom "margin-top" ]);
    case "a partial cover keeps the atom" (fun () ->
      check_merge
        [ atom "border-top" ]
        [ atom "border-color" ]
        [ atom "border-top"; atom "border-color" ]);
    case "the same property drops the earlier value" (fun () ->
      check_merge
        [ atom ~value:v1 "color"; atom "display" ]
        [ atom ~value:v2 "color" ]
        [ atom "display"; atom ~value:v2 "color" ]);
    case "properties of different families all stay" (fun () ->
      check_merge
        [ atom "color"; atom "width" ]
        [ atom "display"; atom "margin" ]
        [ atom "color"; atom "width"; atom "display"; atom "margin" ]);
    case "another context never drops an atom" (fun () ->
      check_merge
        [ atom "color" ]
        [ atom ~ctx:hover "color" ]
        [ atom "color"; atom ~ctx:hover "color" ];
      check_merge
        [ atom ~ctx:hover "margin-top" ]
        [ atom "margin" ]
        [ atom ~ctx:hover "margin-top"; atom "margin" ];
      check_merge
        [ atom ~ctx:hover "color" ]
        [ atom ~ctx:focus "color" ]
        [ atom ~ctx:hover "color"; atom ~ctx:focus "color" ]);
    case "the same context drops across values" (fun () ->
      check_merge
        [ atom ~ctx:hover ~value:v1 "color" ]
        [ atom ~ctx:hover ~value:v2 "color" ]
        [ atom ~ctx:hover ~value:v2 "color" ]);
    case "a bundle drops only when all its cells are covered" (fun () ->
      let b = bundle [ "margin-top", plain; "padding-top", plain ] in
      check_merge [ b ] [ atom "margin-top" ] [ b; atom "margin-top" ];
      check_merge [ b ]
        [ atom "margin-top"; atom "padding-top" ]
        [ atom "margin-top"; atom "padding-top" ];
      check_merge [ b ]
        [ atom "margin"; atom "padding" ]
        [ atom "margin"; atom "padding" ]);
    case "a bundle cell in another context is not covered" (fun () ->
      let b = bundle [ "margin-top", plain; "padding-top", hover ] in
      check_merge [ b ]
        [ atom "margin"; atom "padding" ]
        [ b; atom "margin"; atom "padding" ];
      check_merge [ b ]
        [ atom "margin"; atom ~ctx:hover "padding" ]
        [ atom "margin"; atom ~ctx:hover "padding" ]);
    case "a bundle covers an atom with its cells" (fun () ->
      let b = bundle [ "margin-top", plain; "padding-top", plain ] in
      check_merge [ atom "margin-top"; atom "color" ] [ b ] [ atom "color"; b ]);
    case "a bundle is covered by the union of later tokens" (fun () ->
      let b = bundle [ "margin-top", plain; "padding-top", plain ] in
      let c = bundle ~value:v2 [ "padding-top", plain ] in
      check_merge [ b ] [ atom "margin"; c ] [ atom "margin"; c ];
      check_merge [ b ] [ atom "margin" ] [ b; atom "margin" ]);
    case "a binding id is never dropped for coverage" (fun () ->
      check_merge
        [ binding; atom "color" ]
        [ atom "color"; atom ~value:v2 "color" ]
        [ binding; atom ~value:v2 "color" ];
      check_merge [ atom "color" ] [ binding ] [ atom "color"; binding ]);
    case "a duplicate binding id keeps the last" (fun () ->
      check_merge
        [ binding; other_binding; atom "color" ]
        [ binding ]
        [ other_binding; atom "color"; binding ]);
    case "a foreign class stays" (fun () ->
      check_merge
        [ "card"; atom "color" ]
        [ atom "margin"; "flag-icon" ]
        [ "card"; atom "color"; atom "margin"; "flag-icon" ]);
    case "a duplicate foreign class keeps the last" (fun () ->
      check_merge [ "card"; "active" ] [ "card" ] [ "active"; "card" ];
      check_merge [ "a"; "b" ] [ "b"; "a" ] [ "b"; "a" ]);
    case "a malformed styled-ppx token is foreign" (fun () ->
      let bad = atom "color" ^ "!" in
      check_merge [ bad ] [ atom "color" ] [ bad; atom "color" ];
      check_merge [ bad ] [ bad ] [ bad ]);
    case "a c token with the plain context is the plain context" (fun () ->
      check_merge
        [ atom "color"; atom "width" ]
        [ plain_as_c "color" v2 ]
        [ atom "width"; plain_as_c "color" v2 ]);
    case "an atom whose property id is outside the table" (fun () ->
      check_merge [ "_azyXk3_9w" ] [ "_azyXk3_9w" ] [ "_azyXk3_9w" ];
      check_merge
        [ "_azyXk3_9w"; atom "color" ]
        [ "_azyaaaaaa" ]
        [ atom "color"; "_azyaaaaaa" ];
      check_merge [ "_azzXk3_9w" ] [ "_azzXk3_9w" ] [ "_azzXk3_9w" ]);
    case "an identical atom twice keeps the last" (fun () ->
      check_merge
        [ atom "color"; atom "width" ]
        [ atom "color" ]
        [ atom "width"; atom "color" ]);
    case "all covers every property except direction and custom ones" (fun () ->
      check_merge
        [
          atom "color";
          atom "margin-top";
          atom ~ctx:hover "color";
          atom "direction";
          atom "unicode-bidi";
          name_atom "abcdef";
        ]
        [ atom "all" ]
        [
          atom ~ctx:hover "color";
          atom "direction";
          atom "unicode-bidi";
          name_atom "abcdef";
          atom "all";
        ];
      check_merge [ atom "all" ] [ atom "color" ] [ atom "all"; atom "color" ]);
    case "a custom property is its own cell" (fun () ->
      check_merge
        [ name_atom ~value:v1 "abcdef"; name_atom "ghijkl" ]
        [ name_atom ~value:v2 "abcdef" ]
        [ name_atom "ghijkl"; name_atom ~value:v2 "abcdef" ];
      check_merge
        [ name_atom "abcdef" ]
        [ name_atom ~ctx:hover "abcdef" ]
        [ name_atom "abcdef"; name_atom ~ctx:hover "abcdef" ]);
    case "an empty side returns the other side" (fun () ->
      let a = join [ atom "color"; "card" ] in
      Alcotest.(check string) "right empty" a (Css_merge.merge a "");
      Alcotest.(check string) "left empty" a (Css_merge.merge "" a);
      Alcotest.(check string) "both empty" "" (Css_merge.merge "" ""));
    case "whitespace is trimmed and collapsed" (fun () ->
      Alcotest.(check string)
        "outer" "card active"
        (Css_merge.merge "  card" "active  ");
      Alcotest.(check string)
        "blank left" "active"
        (Css_merge.merge "    " "active");
      Alcotest.(check string)
        "blank right" "active"
        (Css_merge.merge "active" "    ");
      Alcotest.(check string) "both blank" "" (Css_merge.merge "  " "   ");
      Alcotest.(check string) "inner" "a b c" (Css_merge.merge "a  b" "c"));
  ]

let rng = ref 0x2545F491

let next bound =
  rng := ((!rng * 1103515245) + 12345) land 0x3fffffff;
  (!rng lsr 8) mod bound

let pick arr = arr.(next (Array.length arr))

let group_a =
  [| "margin"; "margin-top"; "margin-left"; "padding"; "padding-top" |]

let group_b =
  [| "color"; "border"; "border-top"; "border-color"; "font"; "line-height" |]

let group_c = [| "display"; "width"; "gap"; "overflow"; "overflow-x"; "all" |]
let contexts = [| plain; plain; plain; hover; focus |]
let values = [| v1; v2; v3 |]

let random_token groups =
  let name = pick (pick groups) in
  let ctx = pick contexts
  and value = pick values in
  match next 14 with
  | 12 ->
    pick [| "_azyXk3_9w"; "_azzXk3_9w"; atom name ^ "!"; "_c0a3fQ-zTXk3_9" |]
  | 13 -> plain_as_c name value
  | 0 -> pick [| "card"; "active"; "css-1abc" |]
  | 1 -> pick [| binding; other_binding |]
  | 2 -> name_atom ~ctx ~value (pick [| "abcdef"; "ghijkl" |])
  | 3 ->
    bundle ~value
      [
        pick [| "margin-top"; "padding-top"; "color" |], pick contexts;
        pick [| "margin-left"; "padding"; "border-top" |], pick contexts;
      ]
  | _ -> atom ~ctx ~value name

let random_list ?(max = 7) groups =
  List.init (next max) (fun _ -> random_token groups)

let reference tokens =
  let cells_of token =
    match Format_.decode token with
    | Atom { prop; ctx; _ } -> Some [ prop, ctx ]
    | Bundle { cells; _ } -> Some cells
    | Binding_id _ | Foreign -> None
  in
  let expand cells =
    List.concat_map
      (fun (prop, ctx) ->
        List.map (fun leaf -> ctx, leaf) (Css_cover.leaves prop))
      cells
  in
  let rec go = function
    | [] -> []
    | token :: later ->
      let covered =
        match cells_of token with
        | None -> List.mem token later
        | Some cells ->
          let union =
            List.concat_map
              (fun t -> match cells_of t with Some c -> expand c | None -> [])
              later
          in
          List.for_all (fun cell -> List.mem cell union) (expand cells)
      in
      if covered then go later else token :: go later
  in
  go tokens

let normalized groups = reference (random_list groups)
let rounds = 4000

let property_tests =
  let case name fn = Alcotest.test_case name `Quick fn in
  let all_groups = [| group_a; group_b; group_c |] in
  let side_groups () =
    match next 3 with
    | 0 -> [| group_a |], [| group_b |]
    | 1 -> [| group_a; group_b |], [| group_c |]
    | _ -> all_groups, all_groups
  in
  let families tokens =
    List.filter_map
      (fun t ->
        match Format_.decode t with
        | Atom { prop; _ } -> Some (Css_cover.family prop)
        | _ -> None)
      tokens
  in
  let pairs =
    List.init rounds (fun _ ->
      let ga, gb = side_groups () in
      let a = normalized ga in
      let b = normalized gb in
      a, b)
  in
  [
    case "merge of normalized operands equals the reference model" (fun () ->
      List.iter
        (fun (a, b) ->
          Alcotest.(check string)
            (join a ^ " + " ^ join b)
            (join (reference (a @ b)))
            (merge2 a b))
        pairs);
    case "merge equals normalize of the joined strings" (fun () ->
      List.iter
        (fun (a, b) ->
          Alcotest.(check string)
            (join a ^ " + " ^ join b)
            (Css_merge.normalize (join (a @ b)))
            (merge2 a b))
        pairs);
    case "normalize equals the reference model on any list" (fun () ->
      for _ = 1 to rounds do
        let tokens = random_list all_groups @ random_list all_groups in
        Alcotest.(check string)
          (join tokens)
          (join (reference tokens))
          (Css_merge.normalize (join tokens))
      done);
    case "the random pairs reach both the joined and the decoded path"
      (fun () ->
      let disjoint (a, b) =
        let fa = families a
        and fb = families b in
        List.for_all (fun f -> f > 0 && not (List.mem f fb)) fa
      in
      let n = List.length (List.filter disjoint pairs) in
      Alcotest.(check bool) "some disjoint" true (n > rounds / 10);
      Alcotest.(check bool) "some overlapping" true (n < rounds * 9 / 10));
    case "foreign-only lists give the reference result" (fun () ->
      let pool =
        [|
          "card";
          "active";
          "css-1abc-x";
          "css-2def-y";
          "flag-icon";
          "_qzzzzzzzz";
          binding;
          other_binding;
          "_iAAAAAAA";
          "_a";
          "_ab";
          "x_a0aXk3_9w";
        |]
      in
      let list () = List.init (next 8) (fun _ -> pick pool) in
      let duplicates = ref 0 in
      for _ = 1 to rounds do
        let a = reference (list ())
        and b = reference (list ()) in
        if List.exists (fun t -> List.mem t a) b then incr duplicates;
        Alcotest.(check string)
          (join a ^ " + " ^ join b)
          (join (reference (a @ b)))
          (merge2 a b);
        Alcotest.(check string)
          (join a ^ " + " ^ join b)
          (Css_merge.normalize (join (a @ b)))
          (merge2 a b)
      done;
      Alcotest.(check bool) "duplicates reached" true (!duplicates > rounds / 10));
    case "long operands give the reference result" (fun () ->
      for _ = 1 to 300 do
        let a = reference (random_list ~max:60 all_groups) in
        let b = reference (random_list ~max:60 all_groups) in
        Alcotest.(check string)
          (join a ^ " + " ^ join b)
          (join (reference (a @ b)))
          (merge2 a b)
      done);
    case "merge is associative" (fun () ->
      for _ = 1 to rounds do
        let ga, gb = side_groups () in
        let a = normalized ga
        and b = normalized gb
        and c = normalized ga in
        let m x y = Css_merge.merge x y in
        let a = join a
        and b = join b
        and c = join c in
        Alcotest.(check string)
          (a ^ " | " ^ b ^ " | " ^ c)
          (m (m a b) c)
          (m a (m b c))
      done);
    case "merge is idempotent" (fun () ->
      List.iter
        (fun (a, b) ->
          let a = join a
          and ab = merge2 a b in
          Alcotest.(check string) a a (Css_merge.merge a a);
          Alcotest.(check string) ab ab (Css_merge.merge ab ab);
          Alcotest.(check string) ab ab (Css_merge.merge ab (join b)))
        pairs);
    case "the empty string is the identity" (fun () ->
      List.iter
        (fun (a, _) ->
          let a = join a in
          Alcotest.(check string) a a (Css_merge.merge a "");
          Alcotest.(check string) a a (Css_merge.merge "" a))
        pairs);
  ]

let () =
  Alcotest.run "property_class_merge"
    [ "golden", golden_tests; "properties", property_tests ]
