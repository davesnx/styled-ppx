open Alcotest

let loc = Location.none

let transform = String_interpolation.Transform.transform ~loc

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

let test1 () = check ast "one char" [%expr {js|x|js}] (transform "x")

let test2 () =
  check ast "dont transform string" [%expr {js|Hello|js}] (transform "Hello")

let test3 () =
  check ast "dont transform multiple strings" [%expr {js|Hello world|js}]
    (transform "Hello world")

let test4 () = check ast "inline variable" [%expr {js||js} ^ name ^ {js||js}] (transform "$(name)")

let test5 () =
  check ast "concat string before variable" [%expr {js|Hello |js} ^ name]
    (transform "Hello $(name)")

let test6 () =
  check ast "concat string after variable" [%expr name ^ {js| Hello|js}]
    (transform "$(name) Hello")

let test7 () =
  check ast "concat more than one variable" [%expr name ^ name]
    (transform "$(name)$(name)")

let test8 () =
  check ast "concat more than one variable"
    [%expr name ^ {js| hello |js} ^ name]
    (transform "$(name) hello $(name)")

let test9 () =
  check ast "empty variable"
    [%expr name ^ {js| hello |js} ^ name ^ {js| world|js}]
    (transform "$(name) hello $(name) world")

let test10 () =
  check ast "test"
    [%expr name ^ name ^ {js| : |js} ^ name ^ name]
    (transform "$(name)$(name) : $(name)$(name)")

let cases =
  [
    ("Test 1", `Quick, test1);
    ("Test 2", `Quick, test2);
    ("Test 3", `Quick, test3);
    ("Test 4", `Quick, test4);
    ("Test 5", `Quick, test5);
    ("Test 6", `Quick, test6);
    ("Test 7", `Quick, test7);
    ("Test 8", `Quick, test8);
    ("Test 9", `Quick, test9);
    ("Test 10", `Quick, test10);
  ]

let () = run "String interpolation test suit" [ ("Transform", cases) ]
