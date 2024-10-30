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

let one_char =
  test "one char" @@ fun () -> assert_equal (transform "x") [%expr {js|x|js}]

let dont_transform_string =
  test "dont transform string" @@ fun () ->
  assert_equal (transform "Hello") [%expr {js|Hello|js}]

let dont_transform_multiple_strings =
  test "dont transform multiple strings" @@ fun () ->
  assert_equal (transform "Hello world") [%expr {js|Hello world|js}]

let inline_variable =
  test "inline variable" @@ fun () ->
  assert_equal (transform "$(name)") [%expr name]

let concat_string_before_variable =
  test "concat string before variable" @@ fun () ->
  assert_equal (transform "Hello $(name)") [%expr {js|Hello |js} ^ name]

let concat_char_after_variable =
  test "concat char after variable" @@ fun () ->
  assert_equal (transform "H$(name)") [%expr {js|H|js} ^ name]

let concat_string_after_variable =
  test "concat string after variable" @@ fun () ->
  assert_equal (transform "$(name) Hello") [%expr name ^ {js| Hello|js}]

let concat_more_than_one_variable =
  test "concat more than one variable" @@ fun () ->
  assert_equal (transform "$(name)$(name)") [%expr name ^ name]

let concat_more_than_one_variable_with_middle =
  test "concat more than one variable with middle" @@ fun () ->
  assert_equal
    (transform "$(name) hello $(name)")
    [%expr name ^ {js| hello |js} ^ name]

let empty_variable =
  test "empty variable" @@ fun () ->
  assert_equal
    (transform "$(name) hello $(name) world")
    [%expr name ^ {js| hello |js} ^ name ^ {js| world|js}]

let random_test =
  test "random test" @@ fun () ->
  assert_equal
    (transform "$(name)$(name) : $(name)$(name)")
    [%expr name ^ name ^ {js| : |js} ^ name ^ name]

let module_access =
  test "module access" @@ fun () ->
  assert_equal (transform "$(Module.value)") [%expr Module.value]

let module_access_with_text =
  test "module access with text" @@ fun () ->
  assert_equal
    (transform "$(Module.value) more")
    [%expr Module.value ^ {js| more|js}]

let simply_a_dollar_sign =
  test "simply a dollar sign" @@ fun () ->
  assert_equal (transform {|$|}) [%expr {js|$|js}]

let simply_a_dollar_sign_with_before =
  test "simply a dollar sign with before" @@ fun () ->
  assert_equal (transform {|before$|}) [%expr {js|before$|js}]

let simply_a_dollar_sign_with_before_space =
  test "simply a dollar sign with before space" @@ fun () ->
  assert_equal (transform {|before $|}) [%expr {js|before $|js}]

let simply_a_dollar_sign_with_after =
  test "simply a dollar sign with after" @@ fun () ->
  assert_equal (transform {|$after|}) [%expr {js|$after|js}]

let simply_a_dollar_sign_with_both =
  test "simply a dollar sign with both" @@ fun () ->
  assert_equal (transform {|before$after|}) [%expr {js|before$after|js}]

let doble_dollar_sign =
  test "doble dollar sign" @@ fun () ->
  assert_equal (transform {|$ a $|}) [%expr {js|$ a $|js}]

let empty_dollar_sign =
  test "empty dollar sign" @@ fun () ->
  assert_equal (transform {|$()|}) [%expr {js|$()|js}]

let half_dollar_sign =
  test "half dollar sign" @@ fun () ->
  assert_equal (transform {|$(|}) [%expr {js|$(|js}]

let () =
  Alcotest.run "String interpolation test suit"
    [
      ( "Transform",
        [
          one_char;
          dont_transform_string;
          dont_transform_multiple_strings;
          inline_variable;
          concat_string_before_variable;
          concat_char_after_variable;
          concat_string_after_variable;
          concat_more_than_one_variable;
          concat_more_than_one_variable_with_middle;
          empty_variable;
          random_test;
          module_access;
          module_access_with_text;
          simply_a_dollar_sign;
          simply_a_dollar_sign_with_before;
          simply_a_dollar_sign_with_before_space;
          simply_a_dollar_sign_with_after;
          simply_a_dollar_sign_with_both;
          doble_dollar_sign;
          empty_dollar_sign;
          half_dollar_sign;
        ] );
    ]
