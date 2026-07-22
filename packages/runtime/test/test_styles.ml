let make_static_carrier () =
  let styles = CSS.make "card title" [] in
  Alcotest.(check string) "className" "card title" (CSS.className styles);
  Alcotest.(check (list (triple string string string))) "vars" [] (CSS.styles styles)

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
  Alcotest.(check string) "className" "  card   title  " (CSS.className styles)

let make_dynamic_carrier () =
  let styles = CSS.make "card" [ "--gap", "8px"; "--color", "red" ] in
  Alcotest.(check string) "className" "card" (CSS.className styles);
  Alcotest.(check (list (triple string string string)))
    "vars"
    [ "--color", "--color", "red"; "--gap", "--gap", "8px" ]
    (CSS.styles styles)

let make_allows_duplicate_variables () =
  let styles = CSS.make "card" [ "--gap", "8px"; "--gap", "12px" ] in
  Alcotest.(check (list (triple string string string)))
    "vars"
    [ "--gap", "--gap", "12px"; "--gap", "--gap", "8px" ]
    (CSS.styles styles)

let merge_carriers () =
  let left = CSS.make "card" [ "--gap", "8px" ] in
  let right = CSS.make "active" [ "--color", "red" ] in
  let styles = CSS.merge left right in
  Alcotest.(check string) "className" "card active" (CSS.className styles);
  Alcotest.(check (list (triple string string string)))
    "vars"
    [ "--gap", "--gap", "8px"; "--color", "--color", "red" ]
    (CSS.styles styles)

let merge_preserves_duplicate_variables () =
  let left = CSS.make "card" [ "--gap", "8px" ] in
  let right = CSS.make "active" [ "--gap", "12px" ] in
  let styles = CSS.merge left right in
  Alcotest.(check (list (triple string string string)))
    "vars"
    [ "--gap", "--gap", "8px"; "--gap", "--gap", "12px" ]
    (CSS.styles styles)

let merge_keeps_left_to_right_style_order () =
  let one = CSS.make "one" [ "--one", "1" ] in
  let two = CSS.make "two" [ "--two", "2" ] in
  let three = CSS.make "three" [ "--three", "3" ] in
  let styles = CSS.merge (CSS.merge one two) three in
  Alcotest.(check string) "className" "one two three" (CSS.className styles);
  Alcotest.(check (list (triple string string string)))
    "vars"
    [ "--one", "--one", "1"; "--two", "--two", "2"; "--three", "--three", "3" ]
    (CSS.styles styles)

let merge_trims_outer_whitespace_only () =
  let styles = CSS.merge (CSS.make "  card" []) (CSS.make "active  " []) in
  Alcotest.(check string) "className" "card active" (CSS.className styles)

let trim_empty_merge_class () =
  let styles = CSS.merge (CSS.make "" []) (CSS.make "active" []) in
  Alcotest.(check string) "className" "active" (CSS.className styles)

let trim_empty_merge_class_2 () =
  let styles = CSS.merge (CSS.make "    " []) (CSS.make "active" []) in
  Alcotest.(check string) "className" "active" (CSS.className styles)

let trim_empty_merge_class_3 () =
  let styles = CSS.merge (CSS.make "active" []) (CSS.make "" []) in
  Alcotest.(check string) "className" "active" (CSS.className styles)

let merge_empty_carriers () =
  let styles = CSS.merge (CSS.make "" []) (CSS.make "" []) in
  Alcotest.(check string) "className" "" (CSS.className styles);
  Alcotest.(check (list (triple string string string))) "vars" [] (CSS.styles styles)

let label_defaults_to_none () =
  Alcotest.(check (option string)) "empty" None (CSS.label CSS.empty);
  Alcotest.(check (option string))
    "make without label" None
    (CSS.label (CSS.make "card" []))

let make_carries_label () =
  let styles = CSS.make_labeled "card" "css-abc" [] in
  Alcotest.(check (option string)) "label" (Some "card") (CSS.label styles);
  Alcotest.(check string) "className untouched" "css-abc"
    (CSS.className styles)

let merge_joins_labels () =
  let left = CSS.make_labeled "card" "css-a" [] in
  let right = CSS.make_labeled "elevated" "css-b" [] in
  Alcotest.(check (option string))
    "both" (Some "card elevated")
    (CSS.label (CSS.merge left right))

let merge_keeps_present_label () =
  let labelled = CSS.make_labeled "card" "css-a" [] in
  let unlabelled = CSS.make "css-b" [] in
  Alcotest.(check (option string))
    "left only" (Some "card")
    (CSS.label (CSS.merge labelled unlabelled));
  Alcotest.(check (option string))
    "right only" (Some "card")
    (CSS.label (CSS.merge unlabelled labelled));
  Alcotest.(check (option string))
    "neither" None
    (CSS.label (CSS.merge unlabelled unlabelled))

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
    test "merge preserves duplicate variables"
      merge_preserves_duplicate_variables;
    test "merge keeps left-to-right style order"
      merge_keeps_left_to_right_style_order;
    test "merge trims outer whitespace only" merge_trims_outer_whitespace_only;
    test "trim empty merge class" trim_empty_merge_class;
    test "trim empty merge class 2" trim_empty_merge_class_2;
    test "trim empty merge class 3" trim_empty_merge_class_3;
    test "merge empty carriers" merge_empty_carriers;
    test "label defaults to none" label_defaults_to_none;
    test "make carries label" make_carries_label;
    test "merge joins labels" merge_joins_labels;
    test "merge keeps present label" merge_keeps_present_label;
    test "font families single font" font_families_single_font;
    test "font families multiple fonts" font_families_multiple_fonts;
  ]
