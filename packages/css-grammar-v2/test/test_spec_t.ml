open Css_grammar_v2

type simple_length = [%spec_t "<length>"]

let simple_length_spec : simple_length Spec.t = [%spec "<length>"]

type simple_xor = [%spec_t "<length> | <percentage>"]

let simple_xor_spec : simple_xor Spec.t = [%spec "<length> | <percentage>"]

type keyword_xor = [%spec_t "'auto' | 'none' | 'inherit'"]

let keyword_xor_spec : keyword_xor Spec.t = [%spec "'auto' | 'none' | 'inherit'"]

type mixed_xor = [%spec_t "<length> | 'auto' | <percentage>"]

let mixed_xor_spec : mixed_xor Spec.t = [%spec "<length> | 'auto' | <percentage>"]

type tuple_type = [%spec_t "<length> <percentage>"]

let tuple_spec : tuple_type Spec.t = [%spec "<length> <percentage>"]

type triple_type = [%spec_t "<length> <number> <percentage>"]

let triple_spec : triple_type Spec.t = [%spec "<length> <number> <percentage>"]

type optional_type = [%spec_t "<length>?"]

let optional_spec : optional_type Spec.t = [%spec "<length>?"]

type list_type = [%spec_t "<length>+"]

let list_spec : list_type Spec.t = [%spec "<length>+"]

type tuple_optional = [%spec_t "<length> <percentage>?"]

let tuple_optional_spec : tuple_optional Spec.t = [%spec "<length> <percentage>?"]

type nested_group = [%spec_t "[ <length> | <percentage> ]+"]

let nested_group_spec : nested_group Spec.t = [%spec "[ <length> | <percentage> ]+"]

let test_simple_length () =
  match Spec.parse simple_length_spec "10px" with
  | Ok (`Px 10.) -> ()
  | Ok _ -> Alcotest.fail "Expected Px 10"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_simple_xor_length () =
  match Spec.parse simple_xor_spec "10px" with
  | Ok (`Length _) -> ()
  | Ok _ -> Alcotest.fail "Expected Length"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_simple_xor_percentage () =
  match Spec.parse simple_xor_spec "50%" with
  | Ok (`Percentage _) -> ()
  | Ok _ -> Alcotest.fail "Expected Percentage"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_keyword_xor () =
  match Spec.parse keyword_xor_spec "auto" with
  | Ok `Auto -> ()
  | Ok _ -> Alcotest.fail "Expected Auto"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_mixed_xor_length () =
  match Spec.parse mixed_xor_spec "10px" with
  | Ok (`Length _) -> ()
  | Ok _ -> Alcotest.fail "Expected Length"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_mixed_xor_auto () =
  match Spec.parse mixed_xor_spec "auto" with
  | Ok `Auto -> ()
  | Ok _ -> Alcotest.fail "Expected Auto"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_tuple () =
  match Spec.parse tuple_spec "10px 50%" with
  | Ok (`Px 10., `Percentage 50.) -> ()
  | Ok _ -> Alcotest.fail "Expected (10px, 50%)"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_triple () =
  match Spec.parse triple_spec "10px 2 50%" with
  | Ok (`Px 10., `Number 2., `Percentage 50.) -> ()
  | Ok _ -> Alcotest.fail "Expected (10px, 2, 50%)"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_optional_some () =
  match Spec.parse optional_spec "10px" with
  | Ok (Some (`Px 10.)) -> ()
  | Ok _ -> Alcotest.fail "Expected Some(10px)"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_list () =
  match Spec.parse list_spec "10px 20px 30px" with
  | Ok values when List.length values = 3 -> ()
  | Ok _ -> Alcotest.fail "Expected 3 values"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_tuple_optional_full () =
  match Spec.parse tuple_optional_spec "10px 50%" with
  | Ok (`Px 10., Some (`Percentage 50.)) -> ()
  | Ok _ -> Alcotest.fail "Expected (10px, Some 50%)"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_tuple_optional_partial () =
  match Spec.parse tuple_optional_spec "10px" with
  | Ok (`Px 10., None) -> ()
  | Ok _ -> Alcotest.fail "Expected (10px, None)"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_nested_group () =
  match Spec.parse nested_group_spec "10px 50% 20px" with
  | Ok values when List.length values = 3 -> ()
  | Ok _ -> Alcotest.fail "Expected 3 values"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let tests =
  ( "spec_t type generation",
    [
      Alcotest.test_case "simple length" `Quick test_simple_length;
      Alcotest.test_case "simple xor length" `Quick test_simple_xor_length;
      Alcotest.test_case "simple xor percentage" `Quick test_simple_xor_percentage;
      Alcotest.test_case "keyword xor" `Quick test_keyword_xor;
      Alcotest.test_case "mixed xor length" `Quick test_mixed_xor_length;
      Alcotest.test_case "mixed xor auto" `Quick test_mixed_xor_auto;
      Alcotest.test_case "tuple" `Quick test_tuple;
      Alcotest.test_case "triple" `Quick test_triple;
      Alcotest.test_case "optional some" `Quick test_optional_some;
      Alcotest.test_case "list" `Quick test_list;
      Alcotest.test_case "tuple optional full" `Quick test_tuple_optional_full;
      Alcotest.test_case "tuple optional partial" `Quick test_tuple_optional_partial;
      Alcotest.test_case "nested group" `Quick test_nested_group;
    ] )
