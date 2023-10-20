open Alcotest
module Pprintast = Ppxlib.Pprintast
module Location = Ppxlib.Location

let loc = Ppxlib.Location.none
let transform = String_interpolation.transform ~delimiter:"js" ~loc

let ast =
  let pp_ast fmt v =
    Format.fprintf fmt "%S" (Pprintast.string_of_expression v)
  in
  let compare expected actual =
    String.equal
      (Pprintast.string_of_expression expected)
      (Pprintast.string_of_expression actual)
  in
  testable pp_ast compare

let assert_equal title actual expected = check ast title expected actual
let test1 () = assert_equal "one char" (transform "x") [%expr {js|x|js}]

let test2 () =
  assert_equal "dont transform string" (transform "Hello") [%expr {js|Hello|js}]

let test3 () =
  assert_equal "dont transform multiple strings" (transform "Hello world")
    [%expr {js|Hello world|js}]

let test4 () = assert_equal "inline variable" (transform "$(name)") [%expr name]

let test5 () =
  assert_equal "concat string before variable"
    (transform "Hello $(name)")
    [%expr {js|Hello |js} ^ name]

let test6 () =
  assert_equal "concat string after variable"
    (transform "$(name) Hello")
    [%expr name ^ {js| Hello|js}]

let test7 () =
  assert_equal "concat more than one variable"
    (transform "$(name)$(name)")
    [%expr name ^ name]

let test8 () =
  assert_equal "concat more than one variable"
    (transform "$(name) hello $(name)")
    [%expr name ^ {js| hello |js} ^ name]

let test9 () =
  assert_equal "empty variable"
    (transform "$(name) hello $(name) world")
    [%expr name ^ {js| hello |js} ^ name ^ {js| world|js}]

let test10 () =
  assert_equal "test"
    (transform "$(name)$(name) : $(name)$(name)")
    [%expr name ^ name ^ {js| : |js} ^ name ^ name]

let test11 () =
  assert_equal "test" (transform "$(Module.value)") [%expr Module.value]

let test12 () =
  assert_equal "test"
    (transform "$(Module.value) more")
    [%expr Module.value ^ {js| more|js}]

let cases =
  [
    "Test 1", `Quick, test1;
    "Test 2", `Quick, test2;
    "Test 3", `Quick, test3;
    "Test 4", `Quick, test4;
    "Test 5", `Quick, test5;
    "Test 6", `Quick, test6;
    "Test 7", `Quick, test7;
    "Test 8", `Quick, test8;
    "Test 9", `Quick, test9;
    "Test 10", `Quick, test10;
    "Test 11", `Quick, test11;
    "Test 12", `Quick, test12;
  ]

let () = run "String interpolation test suit" [ "Transform", cases ]
