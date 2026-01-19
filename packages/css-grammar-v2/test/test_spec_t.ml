open Css_grammar_v2

module Simple_length = [%spec_module "<length>"]
module Simple_xor = [%spec_module "<length> | <percentage>"]
module Keyword_xor = [%spec_module "'auto' | 'none' | 'inherit'"]
module Mixed_xor = [%spec_module "<length> | 'auto' | <percentage>"]
module Tuple_type = [%spec_module "<length> <percentage>"]
module Triple_type = [%spec_module "<length> <number> <percentage>"]
module Optional_type = [%spec_module "<length>?"]
module List_type = [%spec_module "<length>+"]
module Tuple_optional = [%spec_module "<length> <percentage>?"]
module Nested_group = [%spec_module "[ <length> | <percentage> ]+"]

let test_simple_length () =
  match Simple_length.parse "10px" with
  | Ok (`Px 10.) -> ()
  | Ok _ -> Alcotest.fail "Expected Px 10"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_simple_xor_length () =
  match Simple_xor.parse "10px" with
  | Ok (`Length _) -> ()
  | Ok _ -> Alcotest.fail "Expected Length"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_simple_xor_percentage () =
  match Simple_xor.parse "50%" with
  | Ok (`Percentage _) -> ()
  | Ok _ -> Alcotest.fail "Expected Percentage"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_keyword_xor () =
  match Keyword_xor.parse "auto" with
  | Ok `Auto -> ()
  | Ok _ -> Alcotest.fail "Expected Auto"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_mixed_xor_length () =
  match Mixed_xor.parse "10px" with
  | Ok (`Length _) -> ()
  | Ok _ -> Alcotest.fail "Expected Length"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_mixed_xor_auto () =
  match Mixed_xor.parse "auto" with
  | Ok `Auto -> ()
  | Ok _ -> Alcotest.fail "Expected Auto"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_tuple () =
  match Tuple_type.parse "10px 50%" with
  | Ok (`Px 10., `Percentage 50.) -> ()
  | Ok _ -> Alcotest.fail "Expected (10px, 50%)"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_triple () =
  match Triple_type.parse "10px 2 50%" with
  | Ok (`Px 10., `Number 2., `Percentage 50.) -> ()
  | Ok _ -> Alcotest.fail "Expected (10px, 2, 50%)"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_optional_some () =
  match Optional_type.parse "10px" with
  | Ok (Some (`Px 10.)) -> ()
  | Ok _ -> Alcotest.fail "Expected Some(10px)"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_list () =
  match List_type.parse "10px 20px 30px" with
  | Ok values when List.length values = 3 -> ()
  | Ok _ -> Alcotest.fail "Expected 3 values"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_tuple_optional_full () =
  match Tuple_optional.parse "10px 50%" with
  | Ok (`Px 10., Some (`Percentage 50.)) -> ()
  | Ok _ -> Alcotest.fail "Expected (10px, Some 50%)"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_tuple_optional_partial () =
  match Tuple_optional.parse "10px" with
  | Ok (`Px 10., None) -> ()
  | Ok _ -> Alcotest.fail "Expected (10px, None)"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_nested_group () =
  match Nested_group.parse "10px 50% 20px" with
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
