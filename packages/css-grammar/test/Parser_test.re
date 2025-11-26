module Parser = Css_grammar.Parser;

let test_display_with_interpolation = () => {
  switch (Parser.find_property("display")) {
  | None => Alcotest.fail("display property should be registered")
  | Some(spec_module) =>
    module M = (val spec_module: Parser.RULE);
    switch (M.parse("$(myVar)")) {
    | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
    | Ok(parsed_value) =>
      let interps = M.extract_interpolations(parsed_value);
      Alcotest.check(
        Alcotest.int,
        "should have one interpolation",
        1,
        List.length(interps),
      );
      Alcotest.check(
        Alcotest.string,
        "variable name should be myVar",
        "myVar",
        List.hd(interps),
      );
      Alcotest.check(
        Alcotest.option(Alcotest.string),
        "runtime_module_path should be Css_types.Display",
        Some("Css_types.Display"),
        M.runtime_module_path,
      );
    };
  };
};

let test_display_without_interpolation = () => {
  switch (Parser.find_property("display")) {
  | None => Alcotest.fail("display property should be registered")
  | Some(spec_module) =>
    module M = (val spec_module: Parser.RULE);
    switch (M.parse("block")) {
    | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
    | Ok(parsed_value) =>
      let interps = M.extract_interpolations(parsed_value);
      Alcotest.check(
        Alcotest.int,
        "should have no interpolations",
        0,
        List.length(interps),
      );
    };
  };
};

let test_overflow_with_interpolation = () => {
  switch (Parser.find_property("overflow")) {
  | None => Alcotest.fail("overflow property should be registered")
  | Some(spec_module) =>
    module M = (val spec_module: Parser.RULE);
    switch (M.parse("$(x)")) {
    | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
    | Ok(parsed_value) =>
      let interps = M.extract_interpolations(parsed_value);
      Alcotest.check(
        Alcotest.int,
        "should have one interpolation",
        1,
        List.length(interps),
      );
      Alcotest.check(
        Alcotest.string,
        "variable name should be x",
        "x",
        List.hd(interps),
      );
      Alcotest.check(
        Alcotest.option(Alcotest.string),
        "runtime_module_path should be Css_types.Overflow",
        Some("Css_types.Overflow"),
        M.runtime_module_path,
      );
    };
  };
};

let test_position_with_interpolation = () => {
  switch (Parser.find_property("position")) {
  | None => Alcotest.fail("position property should be registered")
  | Some(spec_module) =>
    module M = (val spec_module: Parser.RULE);
    switch (M.parse("$(pos)")) {
    | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
    | Ok(parsed_value) =>
      let interps = M.extract_interpolations(parsed_value);
      Alcotest.check(
        Alcotest.int,
        "should have one interpolation",
        1,
        List.length(interps),
      );
      Alcotest.check(
        Alcotest.string,
        "variable name should be pos",
        "pos",
        List.hd(interps),
      );
      Alcotest.check(
        Alcotest.option(Alcotest.string),
        "runtime_module_path should be Css_types.PropertyPosition",
        Some("Css_types.PropertyPosition"),
        M.runtime_module_path,
      );
    };
  };
};

let test_unregistered_property = () => {
  switch (Parser.find_property("unknown-property")) {
  | Some(_) => Alcotest.fail("unknown property should not be registered")
  | None => ()
  };
};

let test_property_names = () => {
  let names = Parser.property_names();
  Alcotest.check(
    Alcotest.bool,
    "should have at least 3 properties",
    true,
    List.length(names) >= 3,
  );
  Alcotest.check(
    Alcotest.bool,
    "should include display",
    true,
    List.mem("display", names),
  );
  Alcotest.check(
    Alcotest.bool,
    "should include overflow",
    true,
    List.mem("overflow", names),
  );
  Alcotest.check(
    Alcotest.bool,
    "should include position",
    true,
    List.mem("position", names),
  );
};

let test_display_keywords = () => {
  switch (Parser.find_property("display")) {
  | None => Alcotest.fail("display property should be registered")
  | Some(spec_module) =>
    module M = (val spec_module: Parser.RULE);
    /* Test each keyword */
    let keywords = ["block", "inline", "flex", "grid", "none", "contents"];
    List.iter(
      keyword => {
        switch (M.parse(keyword)) {
        | Error(msg) =>
          Alcotest.fail("parsing '" ++ keyword ++ "' should succeed: " ++ msg)
        | Ok(parsed_value) =>
          let interps = M.extract_interpolations(parsed_value);
          Alcotest.check(
            Alcotest.int,
            "keyword " ++ keyword ++ " should have no interpolations",
            0,
            List.length(interps),
          );
        }
      },
      keywords,
    );
  };
};

let test_flex_direction = () => {
  switch (Parser.find_property("flex-direction")) {
  | None => Alcotest.fail("flex-direction property should be registered")
  | Some(spec_module) =>
    module M = (val spec_module: Parser.RULE);
    /* Test keywords */
    let keywords = ["row", "row-reverse", "column", "column-reverse"];
    List.iter(
      keyword => {
        switch (M.parse(keyword)) {
        | Error(msg) =>
          Alcotest.fail("parsing '" ++ keyword ++ "' should succeed: " ++ msg)
        | Ok(_) => ()
        }
      },
      keywords,
    );
    /* Test interpolation */
    switch (M.parse("$(dir)")) {
    | Error(msg) =>
      Alcotest.fail("parsing interpolation should succeed: " ++ msg)
    | Ok(parsed) =>
      let interps = M.extract_interpolations(parsed);
      Alcotest.check(
        Alcotest.int,
        "should have one interpolation",
        1,
        List.length(interps),
      );
    };
  };
};

let test_align_items = () => {
  switch (Parser.find_property("align-items")) {
  | None => Alcotest.fail("align-items property should be registered")
  | Some(spec_module) =>
    module M = (val spec_module: Parser.RULE);
    /* Test keywords */
    let keywords = [
      "center",
      "start",
      "end",
      "flex-start",
      "flex-end",
      "stretch",
    ];
    List.iter(
      keyword => {
        switch (M.parse(keyword)) {
        | Error(msg) =>
          Alcotest.fail("parsing '" ++ keyword ++ "' should succeed: " ++ msg)
        | Ok(_) => ()
        }
      },
      keywords,
    );
  };
};

let test_justify_content = () => {
  switch (Parser.find_property("justify-content")) {
  | None => Alcotest.fail("justify-content property should be registered")
  | Some(spec_module) =>
    module M = (val spec_module: Parser.RULE);
    /* Test keywords */
    let keywords = [
      "flex-start",
      "flex-end",
      "center",
      "space-between",
      "space-around",
    ];
    List.iter(
      keyword => {
        switch (M.parse(keyword)) {
        | Error(msg) =>
          Alcotest.fail("parsing '" ++ keyword ++ "' should succeed: " ++ msg)
        | Ok(_) => ()
        }
      },
      keywords,
    );
  };
};

let test_box_sizing = () => {
  switch (Parser.find_property("box-sizing")) {
  | None => Alcotest.fail("box-sizing property should be registered")
  | Some(spec_module) =>
    module M = (val spec_module: Parser.RULE);
    switch (M.parse("content-box")) {
    | Error(msg) =>
      Alcotest.fail("parsing content-box should succeed: " ++ msg)
    | Ok(_) => ()
    };
    switch (M.parse("border-box")) {
    | Error(msg) =>
      Alcotest.fail("parsing border-box should succeed: " ++ msg)
    | Ok(_) => ()
    };
    Alcotest.check(
      Alcotest.option(Alcotest.string),
      "runtime_module_path should be Css_types.BoxSizing",
      Some("Css_types.BoxSizing"),
      M.runtime_module_path,
    );
  };
};

let test_white_space = () => {
  switch (Parser.find_property("white-space")) {
  | None => Alcotest.fail("white-space property should be registered")
  | Some(spec_module) =>
    module M = (val spec_module: Parser.RULE);
    let keywords = [
      "normal",
      "pre",
      "nowrap",
      "pre-wrap",
      "pre-line",
      "break-spaces",
    ];
    List.iter(
      keyword => {
        switch (M.parse(keyword)) {
        | Error(msg) =>
          Alcotest.fail("parsing '" ++ keyword ++ "' should succeed: " ++ msg)
        | Ok(_) => ()
        }
      },
      keywords,
    );
  };
};

/* Test the kind variant registry - values are separate from properties */
let test_find_value = () => {
  /* Test finding a value (not a property) */
  switch (Parser.find_value("box")) {
  | None => Alcotest.fail("box value should be registered")
  | Some(spec_module) =>
    module M = (val spec_module: Parser.RULE);
    /* Test keywords */
    switch (M.parse("border-box")) {
    | Error(msg) =>
      Alcotest.fail("parsing border-box should succeed: " ++ msg)
    | Ok(_) => ()
    };
    switch (M.parse("content-box")) {
    | Error(msg) =>
      Alcotest.fail("parsing content-box should succeed: " ++ msg)
    | Ok(_) => ()
    };
  };
};

let test_value_names = () => {
  let names = Parser.value_names();
  Alcotest.check(
    Alcotest.bool,
    "should have values registered",
    true,
    List.length(names) > 0,
  );
  Alcotest.check(
    Alcotest.bool,
    "should include box value",
    true,
    List.mem("box", names),
  );
  Alcotest.check(
    Alcotest.bool,
    "should include line-style value",
    true,
    List.mem("line-style", names),
  );
};

let test_property_value_separation = () => {
  /* 'display' is a property, not a value */
  Alcotest.check(
    Alcotest.bool,
    "display should be found as property",
    true,
    Option.is_some(Parser.find_property("display")),
  );
  Alcotest.check(
    Alcotest.bool,
    "display should NOT be found as value",
    true,
    Option.is_none(Parser.find_value("display")),
  );

  /* 'box' is a value, not a property */
  Alcotest.check(
    Alcotest.bool,
    "box should NOT be found as property",
    true,
    Option.is_none(Parser.find_property("box")),
  );
  Alcotest.check(
    Alcotest.bool,
    "box should be found as value",
    true,
    Option.is_some(Parser.find_value("box")),
  );
};

let tests = [
  test("display with interpolation", test_display_with_interpolation),
  test("display without interpolation", test_display_without_interpolation),
  test("overflow with interpolation", test_overflow_with_interpolation),
  test("position with interpolation", test_position_with_interpolation),
  test("unregistered property", test_unregistered_property),
  test("property_names returns registered properties", test_property_names),
  test("display keywords parse correctly", test_display_keywords),
  test("flex-direction keywords and interpolation", test_flex_direction),
  test("align-items keywords", test_align_items),
  test("justify-content keywords", test_justify_content),
  test("box-sizing keywords", test_box_sizing),
  test("white-space keywords", test_white_space),
  test("find_value works for CSS values", test_find_value),
  test("value_names returns registered values", test_value_names),
  test(
    "properties and values are separate in registry",
    test_property_value_separation,
  ),
];
