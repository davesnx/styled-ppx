open Property_class_core
module Format_ = Css_class_format

let prop =
  Alcotest.testable
    (fun fmt p ->
      match (p : Format_.prop) with
      | Id s -> Fmt.pf fmt "Id %s" s
      | Name s -> Fmt.pf fmt "Name %s" s)
    ( = )

let decoded =
  Alcotest.testable
    (fun fmt d ->
      match (d : Format_.decoded) with
      | Atom { prop = Id p; ctx; value } ->
        Fmt.pf fmt "Atom(Id %s,%s,%s)" p ctx value
      | Atom { prop = Name p; ctx; value } ->
        Fmt.pf fmt "Atom(Name %s,%s,%s)" p ctx value
      | Bundle { cells; value } ->
        Fmt.pf fmt "Bundle(%d cells,%s)" (List.length cells) value
      | Binding_id id -> Fmt.pf fmt "Binding_id %s" id
      | Foreign -> Fmt.pf fmt "Foreign")
    ( = )

let is_identifier token =
  token <> ""
  && token.[0] = '_'
  && String.for_all (fun c -> String.contains Format_.alphabet c) token

let case name fn = Alcotest.test_case name `Quick fn

let plain_atom =
  Format_.encode_atom ~prop:(Id "0a") ~ctx:Format_.plain_ctx ~value:"Xk3_9w"

let hover_atom =
  Format_.encode_atom ~prop:(Id "0a") ~ctx:"3fQ-zT" ~value:"Xk3_9w"

let name_atom =
  Format_.encode_atom ~prop:(Name "a-B_c9") ~ctx:"3fQ-zT" ~value:"Xk3_9w"

let cells n =
  List.init n (fun i ->
    ( Format_.Id (Printf.sprintf "0%c" (Char.chr (97 + (i mod 26)))),
      "3fQ-z" ^ String.make 1 Format_.alphabet.[i mod 64] ))

let bundle n = Format_.encode_bundle ~cells:(cells n) ~value:"Xk3_9w"
let binding = Format_.encode_binding_id "aB3_-zZ9"

let format_tests =
  [
    case "documented examples" (fun () ->
      assert_string plain_atom "_a0aXk3_9w";
      assert_string hover_atom "_c0a3fQ-zTXk3_9w");
    case "widths" (fun () ->
      List.iter
        (fun (token, width) ->
          Alcotest.(check int) token width (String.length token))
        [
          plain_atom, 10;
          hover_atom, 16;
          name_atom, 20;
          bundle 1, 18;
          bundle 3, 34;
          bundle 64, 522;
          binding, 10;
        ]);
    case "atoms round trip" (fun () ->
      check ~__POS__ decoded
        (Format_.decode plain_atom)
        (Atom { prop = Id "0a"; ctx = Format_.plain_ctx; value = "Xk3_9w" });
      check ~__POS__ decoded
        (Format_.decode hover_atom)
        (Atom { prop = Id "0a"; ctx = "3fQ-zT"; value = "Xk3_9w" });
      check ~__POS__ decoded (Format_.decode name_atom)
        (Atom { prop = Name "a-B_c9"; ctx = "3fQ-zT"; value = "Xk3_9w" }));
    case "name atom with the plain context round trips" (fun () ->
      let token =
        Format_.encode_atom ~prop:(Name "a-B_c9") ~ctx:Format_.plain_ctx
          ~value:"Xk3_9w"
      in
      check ~__POS__ decoded (Format_.decode token)
        (Atom
           { prop = Name "a-B_c9"; ctx = Format_.plain_ctx; value = "Xk3_9w" }));
    case "bundles round trip" (fun () ->
      List.iter
        (fun n ->
          check ~__POS__ decoded
            (Format_.decode (bundle n))
            (Bundle { cells = cells n; value = "Xk3_9w" }))
        [ 1; 2; 3; 63; 64; 65; 4095 ]);
    case "bundles with name cells round trip" (fun () ->
      let mixed =
        [
          Format_.Id "0a", "3fQ-zT";
          Format_.Name "a-B_c9", "3fQ-zT";
          Format_.Id "0b", "000000";
          Format_.Name "zzzzzz", "000000";
        ]
      in
      let token = Format_.encode_bundle ~cells:mixed ~value:"Xk3_9w" in
      Alcotest.(check int) "width" (10 + 8 + 14 + 8 + 14) (String.length token);
      Alcotest.(check bool) "identifier" true (is_identifier token);
      check ~__POS__ decoded (Format_.decode token)
        (Bundle { cells = mixed; value = "Xk3_9w" }));
    case "binding id round trips" (fun () ->
      check ~__POS__ decoded (Format_.decode binding) (Binding_id "aB3_-zZ9"));
    case "every minted token is a CSS identifier that starts with an underscore"
      (fun () ->
      List.iter
        (fun token -> Alcotest.(check bool) token true (is_identifier token))
        [ plain_atom; hover_atom; name_atom; bundle 1; bundle 4095; binding ]);
    case "foreign tokens" (fun () ->
      List.iter
        (fun token -> check ~__POS__ decoded (Format_.decode token) Foreign)
        [
          "";
          "_";
          "_a";
          "flag-icon";
          "css-1abcde-label";
          "_a0aXk3_9w!";
          "_a0aXk3_9";
          "_a0aXk3_9wZ";
          "_a0aXk3 9w";
          "_azzXk3_9w";
          "_a0AXk3_9w";
          "_q0aXk3_9w";
          "a0aXk3_9w";
          "_c0a3fQ-zTXk3_9";
          "_c0a3fQ-zTXk3_9wZ";
          "_x" ^ String.make 17 'a';
          "_x" ^ String.make 19 'a';
          "_x" ^ String.make 18 '.';
          "_iaB3_-zZ9a";
          "_iaB3_-zZ";
          "_bAA0a3fQ-zTXk3_9w";
          "_bAC" ^ String.make 15 'a';
          "_bAC0a3fQ-zTXk3_9w";
          "_bAB0a3fQ-zT0b3fQ-zTXk3_9";
          "_bACzz3fQ-zT0b3fQ-zTXk3_9w";
          "_bAC0a3fQ-zT0b3fQ-z.Xk3_9w";
          "_bABzz3fQ-zT0b3fQ-zTXk3_9w";
          "_bABzz3fQ-zTXk3_9w";
          "_bABzz3fQ-zT0b3fQ-zTXk3_9";
          "_bAC0azz3fQ-zTXk3_9w";
          "_bABzz3fQ-z.0b3fQ-zTXk3_9w";
        ]);
    case "tokens" (fun () ->
      Alcotest.(check (list string))
        "tokens" [ "a"; "b"; "_c" ]
        (Format_.tokens "  a  b _c ");
      Alcotest.(check (list string)) "empty" [] (Format_.tokens ""));
    case "encoders reject invalid input" (fun () ->
      let rejects name f =
        Alcotest.(check bool)
          name true
          (try
             ignore (f ());
             false
           with Invalid_argument _ -> true)
      in
      rejects "short ctx" (fun () ->
        Format_.encode_atom ~prop:(Id "0a") ~ctx:"abc" ~value:"Xk3_9w");
      rejects "bad value char" (fun () ->
        Format_.encode_atom ~prop:(Id "0a") ~ctx:"3fQ-zT" ~value:"Xk3.9w");
      rejects "reserved id" (fun () ->
        Format_.encode_atom ~prop:(Id "zz") ~ctx:"3fQ-zT" ~value:"Xk3_9w");
      rejects "short name" (fun () ->
        Format_.encode_atom ~prop:(Name "abc") ~ctx:"3fQ-zT" ~value:"Xk3_9w");
      rejects "no cells" (fun () ->
        Format_.encode_bundle ~cells:[] ~value:"Xk3_9w");
      rejects "too many cells" (fun () -> bundle 4096);
      rejects "short name cell" (fun () ->
        Format_.encode_bundle ~cells:[ Name "abc", "3fQ-zT" ] ~value:"Xk3_9w");
      rejects "short binding id" (fun () -> Format_.encode_binding_id "abc"));
  ]

let id name =
  match Css_cover.id_of_name name with
  | Some id -> Format_.Id id
  | None -> Alcotest.failf "no id for %s" name

let ids names = List.sort compare (List.map id names)
let leaves name = Css_cover.leaves (id name)

let covers outer inner =
  List.for_all (fun l -> List.mem l (leaves outer)) (leaves inner)

let base36 i =
  let digit n = String.make 1 "0123456789abcdefghijklmnopqrstuvwxyz".[n] in
  digit (i / 36) ^ digit (i mod 36)

let checksum names =
  Array.fold_left
    (fun acc name ->
      String.fold_left
        (fun acc c -> acc lxor Char.code c * 1099511628211)
        acc (name ^ "\n"))
    5381 names

let cover_tests =
  [
    case "every table row resolves to its own id" (fun () ->
      Array.iteri
        (fun i name ->
          Alcotest.(check (option string))
            name
            (Some (base36 i))
            (Css_cover.id_of_name name))
        Css_property_table.names);
    case "the table fits the two-character ids and keeps zz reserved" (fun () ->
      Alcotest.(check bool)
        "length" true
        (Array.length Css_property_table.names <= 1295));
    case "table rows are unique" (fun () ->
      let sorted =
        List.sort_uniq compare (Array.to_list Css_property_table.names)
      in
      Alcotest.(check int)
        "unique"
        (Array.length Css_property_table.names)
        (List.length sorted));
    case "table is append-only" (fun () ->
      let locked = 846 in
      Alcotest.(check bool)
        "has the locked rows" true
        (Array.length Css_property_table.names >= locked);
      Alcotest.(check int)
        "checksum of the locked rows" 113531088181613104
        (checksum (Array.sub Css_property_table.names 0 locked));
      Alcotest.(check string)
        "first" "-moz-appearance"
        Css_property_table.names.(0);
      Alcotest.(check string)
        "last locked" "zoom"
        Css_property_table.names.(locked - 1));
    case "aliases resolve to the canonical id" (fun () ->
      List.iter
        (fun (alias, canonical) ->
          Alcotest.(check (option string))
            alias
            (Css_cover.id_of_name canonical)
            (Css_cover.id_of_name alias))
        [
          "word-wrap", "overflow-wrap";
          "grid-gap", "gap";
          "grid-row-gap", "row-gap";
          "-webkit-transform", "transform";
          "-webkit-animation", "animation";
          "-webkit-border-after", "border-block-end";
          "page-break-after", "break-after";
          "MARGIN", "margin";
        ]);
    case "unknown and custom properties have no id" (fun () ->
      List.iter
        (fun name ->
          Alcotest.(check (option string)) name None (Css_cover.id_of_name name))
        [ "--my-var"; "--*"; "no-such-property"; "" ]);
    case "margin covers its four longhands (T03)" (fun () ->
      check ~__POS__ (Alcotest.list prop) (leaves "margin")
        (ids [ "margin-top"; "margin-right"; "margin-bottom"; "margin-left" ]);
      Alcotest.(check bool)
        "margin-top in margin" true
        (covers "margin" "margin-top");
      Alcotest.(check bool)
        "margin in margin-top" false
        (covers "margin-top" "margin");
      Alcotest.(check int) "size margin" 4 (Css_cover.size (id "margin"));
      Alcotest.(check int)
        "size margin-top" 1
        (Css_cover.size (id "margin-top")));
    case "a longhand and a Name are their own leaves" (fun () ->
      check ~__POS__ (Alcotest.list prop) (leaves "color") [ id "color" ];
      check ~__POS__ (Alcotest.list prop)
        (Css_cover.leaves (Name "abcdef"))
        [ Name "abcdef" ];
      Alcotest.(check int) "size name" 1 (Css_cover.size (Name "abcdef")));
    case "border-top and border-color overlap without nesting" (fun () ->
      Alcotest.(check bool)
        "border-top covers border-top-color" true
        (covers "border-top" "border-top-color");
      Alcotest.(check bool)
        "border-color covers border-top-color" true
        (covers "border-color" "border-top-color");
      Alcotest.(check bool)
        "border-top covers border-color" false
        (covers "border-top" "border-color");
      Alcotest.(check bool)
        "border-color covers border-top" false
        (covers "border-color" "border-top");
      Alcotest.(check bool)
        "same family" true
        (Css_cover.family (id "border-top")
        = Css_cover.family (id "border-color")));
    case "reset-only members stay in the shorthand" (fun () ->
      Alcotest.(check bool)
        "font resets font-variant-ligatures" true
        (covers "font" "font-variant-ligatures");
      Alcotest.(check bool)
        "font resets font-feature-settings" true
        (covers "font" "font-feature-settings");
      Alcotest.(check bool)
        "border resets border-image-source" true
        (covers "border" "border-image-source"));
    case "all covers everything except direction and unicode-bidi" (fun () ->
      Alcotest.(check bool) "margin-top" true (covers "all" "margin-top");
      Alcotest.(check bool) "color" true (covers "all" "color");
      Alcotest.(check bool) "margin" true (covers "all" "margin");
      Alcotest.(check bool) "direction" false (covers "all" "direction");
      Alcotest.(check bool) "unicode-bidi" false (covers "all" "unicode-bidi");
      Alcotest.(check int) "family" 0 (Css_cover.family (id "all"));
      Alcotest.(check int)
        "size"
        (List.length (leaves "all"))
        (Css_cover.size (id "all")));
    case "families" (fun () ->
      let family name = Css_cover.family (id name) in
      Alcotest.(check bool)
        "margin-top and margin" true
        (family "margin-top" = family "margin");
      Alcotest.(check bool)
        "margin and padding" true
        (family "margin" <> family "padding");
      Alcotest.(check bool)
        "physical and logical margins" true
        (family "margin-top" <> family "margin-block-start");
      Alcotest.(check bool)
        "color and width" true
        (family "color" <> family "width");
      Alcotest.(check bool) "positive" true (family "color" > 0);
      Alcotest.(check int) "name" (-1) (Css_cover.family (Name "abcdef"));
      Alcotest.(check int) "reserved id" (-1) (Css_cover.family (Id "zz")));
    case "an id outside the table is its own leaf" (fun () ->
      check ~__POS__ (Alcotest.list prop)
        (Css_cover.leaves (Id "zz"))
        [ Id "zz" ];
      Alcotest.(check int) "size" 1 (Css_cover.size (Id "zz")));
  ]

let () =
  Alcotest.run "property_class_core"
    [ "css_class_format", format_tests; "css_cover", cover_tests ]
