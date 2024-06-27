let test title fn = Alcotest.test_case title `Quick fn

let assert_string left right =
  Alcotest.check Alcotest.string "should be equal" right left

let assert_not_equal_string left right =
  Alcotest.check (Alcotest.neg Alcotest.string) "should not be equal" right left
