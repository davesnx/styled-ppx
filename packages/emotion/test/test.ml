let () =
  Alcotest.run "Css"
    [ Test_css_styles.tests; Test_css_autoprefixer.tests; Test_css_hash.tests ]
