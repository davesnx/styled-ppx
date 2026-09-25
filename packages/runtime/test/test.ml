let () =
  Alcotest.run ~show_errors:true ~compact:true ~tail_errors:`Unlimited
    "styled-ppx.native"
    (Test_styles.tests @ Test_merge_key.tests)
