let run_tests = () => {
  let test = (name, rule, input) =>
    switch (Css_grammar.Parser.parse(rule, input)) {
    | Ok(_) => Printf.printf("%s: OK\n%!", name)
    | Error(msg) => Printf.printf("%s: ERROR: %s\n%!", name, msg)
    };

  test("function_rgb space", Css_grammar.Parser.function_rgb, "rgb(1 2 3 / .4)");
  test("function_rgb comma", Css_grammar.Parser.function_rgb, "rgb(1, 2, 3)");
  test("property_color red", Css_grammar.Parser.property_color, "red");
  test("property_color rgb-space", Css_grammar.Parser.property_color, "rgb(1 2 3 / .4)");
  test("property_color hex", Css_grammar.Parser.property_color, "#ff0000");
  test("property_width calc", Css_grammar.Parser.property_width, "calc(100vh - 120px)");
};

let () = run_tests();
