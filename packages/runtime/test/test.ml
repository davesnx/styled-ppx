let () =
  Alcotest.run ~show_errors:true ~compact:true ~tail_errors:`Unlimited
    "styled-ppx.native"
    [
      Test_styles.tests;
      Test_autoprefixer.tests;
      Test_hash.tests;
      Test_emotion_bindings_helper.tests;
    ]
