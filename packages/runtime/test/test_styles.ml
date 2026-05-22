let make_static_carrier () =
  let styles = CSS.make "card title" [] in
  Alcotest.(check string) "className" "card title" (fst styles);
  Alcotest.(check (list (triple string string string))) "vars" [] (snd styles)

let make_dynamic_carrier () =
  let styles = CSS.make "card" [ ("--gap", "8px"); ("--color", "red") ] in
  Alcotest.(check string) "className" "card" (fst styles);
  Alcotest.(check (list (triple string string string))) "vars"
    [ ("--color", "--color", "red"); ("--gap", "--gap", "8px") ]
    (snd styles)

let merge_carriers () =
  let left = CSS.make "card" [ ("--gap", "8px") ] in
  let right = CSS.make "active" [ ("--color", "red") ] in
  let styles = CSS.merge left right in
  Alcotest.(check string) "className" "card active" (fst styles);
  Alcotest.(check (list (triple string string string))) "vars"
    [ ("--gap", "--gap", "8px"); ("--color", "--color", "red") ]
    (snd styles)

let trim_empty_merge_class () =
  let styles = CSS.merge (CSS.make "" []) (CSS.make "active" []) in
  Alcotest.(check string) "className" "active" (fst styles)

let tests =
  [
    test "make static carrier" make_static_carrier;
    test "make dynamic carrier" make_dynamic_carrier;
    test "merge carriers" merge_carriers;
    test "trim empty merge class" trim_empty_merge_class;
  ]
