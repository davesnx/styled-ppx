module Pprintast = Ppxlib.Pprintast
module Location = Ppxlib.Location

let loc = Ppxlib.Location.none
let transform = String_interpolation.transform ~delimiter:"js" ~loc

let ast =
  let pp_ast fmt v =
    Format.fprintf fmt "%S" (Ppxlib_ast.Pprintast.string_of_expression v)
  in
  let compare expected actual =
    String.equal
      (Ppxlib_ast.Pprintast.string_of_expression expected)
      (Ppxlib_ast.Pprintast.string_of_expression actual)
  in
  Alcotest.testable pp_ast compare

let assert_equal actual expected =
  Alcotest.check ast "should match" expected actual

let one_char () = assert_equal (transform "x") [%expr {js|x|js}]

let dont_transform_string () =
  assert_equal (transform "Hello") [%expr {js|Hello|js}]

let dont_transform_multiple_strings () =
  assert_equal (transform "Hello world") [%expr {js|Hello world|js}]

let inline_variable () = assert_equal (transform "$(name)") [%expr name]

let concat_string_before_variable () =
  assert_equal (transform "Hello $(name)") [%expr {js|Hello |js} ^ name]

let concat_char_after_variable () =
  assert_equal (transform "H$(name)") [%expr {js|H|js} ^ name]

let concat_string_after_variable () =
  assert_equal (transform "$(name) Hello") [%expr name ^ {js| Hello|js}]

let concat_more_than_one_variable () =
  assert_equal (transform "$(name)$(name)") [%expr name ^ name]

let concat_more_than_one_variable_with_middle () =
  assert_equal
    (transform "$(name) hello $(name)")
    [%expr name ^ {js| hello |js} ^ name]

let empty_variable () =
  assert_equal
    (transform "$(name) hello $(name) world")
    [%expr name ^ {js| hello |js} ^ name ^ {js| world|js}]

let random_test () =
  assert_equal
    (transform "$(name)$(name) : $(name)$(name)")
    [%expr name ^ name ^ {js| : |js} ^ name ^ name]

let module_access () =
  assert_equal (transform "$(Module.value)") [%expr Module.value]

let module_access_with_text () =
  assert_equal
    (transform "$(Module.value) more")
    [%expr Module.value ^ {js| more|js}]

let simply_a_dollar_sign () = assert_equal (transform {|$|}) [%expr {js|$|js}]

let simply_a_dollar_sign_with_before () =
  assert_equal (transform {|before$|}) [%expr {js|before$|js}]

let simply_a_dollar_sign_with_before_space () =
  assert_equal (transform {|before $|}) [%expr {js|before $|js}]

let simply_a_dollar_sign_with_after () =
  assert_equal (transform {|$after|}) [%expr {js|$after|js}]

let simply_a_dollar_sign_with_both () =
  assert_equal (transform {|before$after|}) [%expr {js|before$after|js}]

let doble_dollar_sign () =
  assert_equal (transform {|$ a $|}) [%expr {js|$ a $|js}]

let empty_dollar_sign () = assert_equal (transform {|$()|}) [%expr {js|$()|js}]
let half_dollar_sign () = assert_equal (transform {|$(|}) [%expr {js|$(|js}]

(* Test interpolation with spaces - Issues #2 and #3 *)
let inline_variable_with_spaces () =
  assert_equal (transform "$( name )") [%expr name]

let inline_variable_with_leading_space () =
  assert_equal (transform "$( name)") [%expr name]

let inline_variable_with_trailing_space () =
  assert_equal (transform "$(name )") [%expr name]

let module_access_with_spaces () =
  assert_equal (transform "$( Module.value )") [%expr Module.value]

let nested_module_with_spaces () =
  assert_equal (transform "$( Color.Border.lineAlpha )") [%expr Color.Border.lineAlpha]

let () =
  Alcotest.run "String interpolation test suit"
    [
      test "one_char" one_char;
      test "dont_transform_string" dont_transform_string;
      test "dont_transform_multiple_strings" dont_transform_multiple_strings;
      test "inline_variable" inline_variable;
      test "concat_string_before_variable" concat_string_before_variable;
      test "concat_char_after_variable" concat_char_after_variable;
      test "concat_string_after_variable" concat_string_after_variable;
      test "concat_more_than_one_variable" concat_more_than_one_variable;
      test "concat_more_than_one_variable_with_middle"
        concat_more_than_one_variable_with_middle;
      test "empty_variable" empty_variable;
      test "random_test" random_test;
      test "module_access" module_access;
      test "module_access_with_text" module_access_with_text;
      test "simply_a_dollar_sign" simply_a_dollar_sign;
      test "simply_a_dollar_sign_with_before" simply_a_dollar_sign_with_before;
      test "simply_a_dollar_sign_with_before_space"
        simply_a_dollar_sign_with_before_space;
      test "simply_a_dollar_sign_with_after" simply_a_dollar_sign_with_after;
      test "simply_a_dollar_sign_with_both" simply_a_dollar_sign_with_both;
      test "doble_dollar_sign" doble_dollar_sign;
      test "empty_dollar_sign" empty_dollar_sign;
      test "half_dollar_sign" half_dollar_sign;
      (* Interpolation with spaces tests *)
      test "inline_variable_with_spaces" inline_variable_with_spaces;
      test "inline_variable_with_leading_space" inline_variable_with_leading_space;
      test "inline_variable_with_trailing_space" inline_variable_with_trailing_space;
      test "module_access_with_spaces" module_access_with_spaces;
      test "nested_module_with_spaces" nested_module_with_spaces;
    ]
