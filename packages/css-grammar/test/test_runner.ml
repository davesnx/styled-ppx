let () =
  Alcotest.run "css-grammar"
    [
      Test_standard.tests;
      Test_calc.tests;
      Test_properties.tests;
      Test_interpolation.tests;
      Test_battle.tests;
      Test_ppx_edge_cases.tests;
      Test_real_world.tests;
      Test_spec_t.tests;
      Test_spec_t_standard.tests;
      Test_migration.tests;
    ]
