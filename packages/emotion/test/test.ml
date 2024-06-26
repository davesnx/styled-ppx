let () =
  Alcotest.run ~show_errors:true ~compact:true ~tail_errors:`Unlimited "Emotion"
    [
      (* Test_css_js_styles.tests; *)
      Test_css_styles.tests;
      (* Test_css_autoprefixer.tests; *)
      (* Test_css_hash.tests; *)
    ]
