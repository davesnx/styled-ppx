let make_static_carrier () =
  let styles = CSS.make "card title" [] in
  Alcotest.(check string) "className" "card title" (fst styles);
  Alcotest.(check (list (triple string string string))) "vars" [] (snd styles)

let empty_carrier () =
  Alcotest.(check string) "className" "" (CSS.className CSS.empty);
  Alcotest.(check (list (triple string string string)))
    "styles" [] (CSS.styles CSS.empty)

let accessors_return_carrier_parts () =
  let styles = CSS.make "card" [ "--gap", "8px" ] in
  Alcotest.(check string) "className" "card" (CSS.className styles);
  Alcotest.(check (list (triple string string string)))
    "styles"
    [ "--gap", "--gap", "8px" ]
    (CSS.styles styles)

let make_preserves_class_string () =
  let styles = CSS.make "  card   title  " [] in
  Alcotest.(check string) "className" "  card   title  " (fst styles)

let make_dynamic_carrier () =
  let styles = CSS.make "card" [ "--gap", "8px"; "--color", "red" ] in
  Alcotest.(check string) "className" "card" (fst styles);
  Alcotest.(check (list (triple string string string)))
    "vars"
    [ "--gap", "--gap", "8px"; "--color", "--color", "red" ]
    (snd styles)

let make_allows_duplicate_variables () =
  let styles = CSS.make "card" [ "--gap", "8px"; "--gap", "12px" ] in
  Alcotest.(check (list (triple string string string)))
    "vars"
    [ "--gap", "--gap", "8px"; "--gap", "--gap", "12px" ]
    (snd styles)

let merge_carriers () =
  let left = CSS.make "card" [ "--gap", "8px" ] in
  let right = CSS.make "active" [ "--color", "red" ] in
  let styles = CSS.merge left right in
  Alcotest.(check string) "className" "card active" (fst styles);
  Alcotest.(check (list (triple string string string)))
    "vars"
    [ "--gap", "--gap", "8px"; "--color", "--color", "red" ]
    (snd styles)

let merge_keeps_first_position_and_last_value_of_duplicate_variables () =
  let left = CSS.make "card" [ "--gap", "8px" ] in
  let right = CSS.make "active" [ "--gap", "12px" ] in
  let styles = CSS.merge left right in
  Alcotest.(check (list (triple string string string)))
    "vars"
    [ "--gap", "--gap", "12px" ]
    (snd styles)

let merge_dedupes_variables_across_several_keys () =
  let left = CSS.make "one" [ "--a", "1"; "--b", "2"; "--a", "3" ] in
  let right = CSS.make "two" [ "--c", "4"; "--b", "5"; "--d", "6" ] in
  let styles = CSS.merge left right in
  Alcotest.(check (list (triple string string string)))
    "vars"
    [
      "--a", "--a", "3"; "--b", "--b", "5"; "--c", "--c", "4"; "--d", "--d", "6";
    ]
    (snd styles)

let merge_keeps_distinct_variables_untouched () =
  let styles =
    CSS.merge
      (CSS.make "one" [ "--a", "1"; "--b", "2" ])
      (CSS.make "two" [ "--c", "3" ])
  in
  Alcotest.(check (list (triple string string string)))
    "vars"
    [ "--a", "--a", "1"; "--b", "--b", "2"; "--c", "--c", "3" ]
    (snd styles)

let atom ?(ctx = Css_class_format.plain_ctx) ?(value = "Xk3_9w") name =
  match Css_cover.id_of_name name with
  | Some id -> Css_class_format.encode_atom ~prop:(Id id) ~ctx ~value
  | None -> Alcotest.failf "no id for %s" name

let merge_drops_a_covered_atom () =
  let left = CSS.make (atom "margin-top" ^ " " ^ atom "color") [] in
  let right = CSS.make (atom "margin") [] in
  Alcotest.(check string)
    "className"
    (atom "color" ^ " " ^ atom "margin")
    (CSS.className (CSS.merge left right))

let merge_keeps_an_atom_in_another_context () =
  let left = CSS.make (atom "color") [] in
  let right = CSS.make (atom ~ctx:"3fQ-zT" "color") [] in
  Alcotest.(check string)
    "className"
    (atom "color" ^ " " ^ atom ~ctx:"3fQ-zT" "color")
    (CSS.className (CSS.merge left right))

let merge_drops_a_repeated_foreign_class () =
  let styles = CSS.merge (CSS.make "card active" []) (CSS.make "card" []) in
  Alcotest.(check string) "className" "active card" (fst styles)

let merge_keeps_left_to_right_style_order () =
  let one = CSS.make "one" [ "--one", "1" ] in
  let two = CSS.make "two" [ "--two", "2" ] in
  let three = CSS.make "three" [ "--three", "3" ] in
  let styles = CSS.merge (CSS.merge one two) three in
  Alcotest.(check string) "className" "one two three" (fst styles);
  Alcotest.(check (list (triple string string string)))
    "vars"
    [ "--one", "--one", "1"; "--two", "--two", "2"; "--three", "--three", "3" ]
    (snd styles)

let merge_trims_outer_whitespace_only () =
  let styles = CSS.merge (CSS.make "  card" []) (CSS.make "active  " []) in
  Alcotest.(check string) "className" "card active" (fst styles)

let trim_empty_merge_class () =
  let styles = CSS.merge (CSS.make "" []) (CSS.make "active" []) in
  Alcotest.(check string) "className" "active" (fst styles)

let trim_empty_merge_class_2 () =
  let styles = CSS.merge (CSS.make "    " []) (CSS.make "active" []) in
  Alcotest.(check string) "className" "active" (fst styles)

let trim_empty_merge_class_3 () =
  let styles = CSS.merge (CSS.make "active" []) (CSS.make "" []) in
  Alcotest.(check string) "className" "active" (fst styles)

let merge_empty_carriers () =
  let styles = CSS.merge (CSS.make "" []) (CSS.make "" []) in
  Alcotest.(check string) "className" "" (fst styles);
  Alcotest.(check (list (triple string string string))) "vars" [] (snd styles)

let merge_equals_the_core_merge_on_repeated_vectors () =
  let check (ac, av) (bc, bv) =
    let merged = CSS.className (CSS.merge (CSS.make ac av) (CSS.make bc bv)) in
    Alcotest.(check string) (ac ^ " + " ^ bc) (Css_merge.merge ac bc) merged;
    merged
  in
  for _ = 1 to 2 do
    List.iter
      (fun (a, b, c) ->
        let ab = check a b in
        ignore (check (ab, []) c))
      Vectors.cases
  done

let font_families_single_font () =
  Alcotest.(check string)
    "single font family" {js|"Mono"|js}
    (CSS.Types.FontFamilies.toString [| `quoted {js|Mono|js} |])

let font_families_multiple_fonts () =
  Alcotest.(check string)
    "font family stack" {js|"Inter", system-ui, sans-serif|js}
    (CSS.Types.FontFamilies.toString
       [| `quoted {js|Inter|js}; `system_ui; `sans_serif |])

let tests =
  [
    test "empty carrier" empty_carrier;
    test "accessors return carrier parts" accessors_return_carrier_parts;
    test "make static carrier" make_static_carrier;
    test "make preserves class string" make_preserves_class_string;
    test "make dynamic carrier" make_dynamic_carrier;
    test "make allows duplicate variables" make_allows_duplicate_variables;
    test "merge carriers" merge_carriers;
    test "merge keeps first position and last value of duplicate variables"
      merge_keeps_first_position_and_last_value_of_duplicate_variables;
    test "merge dedupes variables across several keys"
      merge_dedupes_variables_across_several_keys;
    test "merge keeps distinct variables untouched"
      merge_keeps_distinct_variables_untouched;
    test "merge drops a covered atom" merge_drops_a_covered_atom;
    test "merge keeps an atom in another context"
      merge_keeps_an_atom_in_another_context;
    test "merge drops a repeated foreign class"
      merge_drops_a_repeated_foreign_class;
    test "merge keeps left-to-right style order"
      merge_keeps_left_to_right_style_order;
    test "merge trims outer whitespace only" merge_trims_outer_whitespace_only;
    test "trim empty merge class" trim_empty_merge_class;
    test "trim empty merge class 2" trim_empty_merge_class_2;
    test "trim empty merge class 3" trim_empty_merge_class_3;
    test "merge empty carriers" merge_empty_carriers;
    test "merge equals the core merge on repeated vectors"
      merge_equals_the_core_merge_on_repeated_vectors;
    test "font families single font" font_families_single_font;
    test "font families multiple fonts" font_families_multiple_fonts;
  ]
