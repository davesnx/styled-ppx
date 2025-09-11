type tests = (string * unit Alcotest.test_case list) list

let assert_string left right =
  Alcotest.check Alcotest.string "should be equal" right left

let assert_string_not_equal left right =
  Alcotest.check (Alcotest.neg Alcotest.string) "should not be equal" right left

let test title fn = title, [ Alcotest.test_case "" `Quick fn ]

let check ~__POS__ testable received expected =
  Alcotest.check ~pos:__POS__ testable "" expected received
