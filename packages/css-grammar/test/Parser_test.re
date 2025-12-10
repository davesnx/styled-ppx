module Parser = Css_grammar.Parser;

/* Test flex-grow validates interpolation syntax */
let test_flex_grow_with_interpolation = () => {
  switch (Parser.find_property("flex-grow")) {
  | None => Alcotest.fail("flex-grow property should be registered")
  | Some(Parser.PackRule({ validate, _ })) =>
    switch (validate("$(myVar)")) {
    | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
    | Ok () => ()
    };
  };
};

/* Test flex-grow without interpolation - parses a number */
let test_flex_grow_without_interpolation = () => {
  switch (Parser.find_property("flex-grow")) {
  | None => Alcotest.fail("flex-grow property should be registered")
  | Some(Parser.PackRule({ validate, _ })) =>
    switch (validate("1.5")) {
    | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
    | Ok () => ()
    };
  };
};

/* Test overflow validates interpolation syntax */
let test_overflow_with_interpolation = () => {
  switch (Parser.find_property("overflow")) {
  | None => Alcotest.fail("overflow property should be registered")
  | Some(Parser.PackRule({ validate, _ })) =>
    switch (validate("$(x)")) {
    | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
    | Ok () => ()
    };
  };
};

/* Test flex-basis validates interpolation syntax */
let test_flex_basis_with_interpolation = () => {
  switch (Parser.find_property("flex-basis")) {
  | None => Alcotest.fail("flex-basis property should be registered")
  | Some(Parser.PackRule({ validate, _ })) =>
    switch (validate("$(basis)")) {
    | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
    | Ok () => ()
    };
  };
};

let test_unregistered_property = () => {
  switch (Parser.find_property("unknown-property")) {
  | Some(_) => Alcotest.fail("unknown property should not be registered")
  | None => ()
  };
};

let test_display_keywords = () => {
  switch (Parser.find_property("display")) {
  | None => Alcotest.fail("display property should be registered")
  | Some(Parser.PackRule({ validate, _ })) =>
    /* Test each keyword */
    let keywords = ["block", "inline", "flex", "grid", "none", "contents"];
    List.iter(
      keyword => {
        switch (validate(keyword)) {
        | Error(msg) =>
          Alcotest.fail("parsing '" ++ keyword ++ "' should succeed: " ++ msg)
        | Ok () =>
          let interps = Parser.get_interpolation_types(~name="display", keyword);
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

/* flex-direction does NOT have <interpolation> in its spec - only test keywords */
let test_flex_direction = () => {
  switch (Parser.find_property("flex-direction")) {
  | None => Alcotest.fail("flex-direction property should be registered")
  | Some(Parser.PackRule({ validate, _ })) =>
    /* Test keywords */
    let keywords = ["row", "row-reverse", "column", "column-reverse"];
    List.iter(
      keyword => {
        switch (validate(keyword)) {
        | Error(msg) =>
          Alcotest.fail("parsing '" ++ keyword ++ "' should succeed: " ++ msg)
        | Ok () => ()
        }
      },
      keywords,
    );
  };
};

let test_align_items = () => {
  switch (Parser.find_property("align-items")) {
  | None => Alcotest.fail("align-items property should be registered")
  | Some(Parser.PackRule({ validate, _ })) =>
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
        switch (validate(keyword)) {
        | Error(msg) =>
          Alcotest.fail("parsing '" ++ keyword ++ "' should succeed: " ++ msg)
        | Ok () => ()
        }
      },
      keywords,
    );
  };
};

let test_justify_content = () => {
  switch (Parser.find_property("justify-content")) {
  | None => Alcotest.fail("justify-content property should be registered")
  | Some(Parser.PackRule({ validate, _ })) =>
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
        switch (validate(keyword)) {
        | Error(msg) =>
          Alcotest.fail("parsing '" ++ keyword ++ "' should succeed: " ++ msg)
        | Ok () => ()
        }
      },
      keywords,
    );
  };
};

let test_box_sizing = () => {
  switch (Parser.find_property("box-sizing")) {
  | None => Alcotest.fail("box-sizing property should be registered")
  | Some(Parser.PackRule({ validate, _ })) =>
    switch (validate("content-box")) {
    | Error(msg) =>
      Alcotest.fail("parsing content-box should succeed: " ++ msg)
    | Ok () => ()
    };
    switch (validate("border-box")) {
    | Error(msg) =>
      Alcotest.fail("parsing border-box should succeed: " ++ msg)
    | Ok () => ()
    };
  };
};

let test_white_space = () => {
  switch (Parser.find_property("white-space")) {
  | None => Alcotest.fail("white-space property should be registered")
  | Some(Parser.PackRule({ validate, _ })) =>
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
        switch (validate(keyword)) {
        | Error(msg) =>
          Alcotest.fail("parsing '" ++ keyword ++ "' should succeed: " ++ msg)
        | Ok () => ()
        }
      },
      keywords,
    );
  };
};

let test_width_with_interpolation = () => {
  switch (Parser.find_property("width")) {
  | None => Alcotest.fail("width property should be registered")
  | Some(Parser.PackRule({ validate, _ })) =>
    switch (validate("$(w)")) {
    | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
    | Ok () => ()
    };
  };
};

let test_color_with_interpolation = () => {
  switch (Parser.find_property("color")) {
  | None => Alcotest.fail("color property should be registered")
  | Some(Parser.PackRule({ validate, _ })) =>
    switch (validate("$(c)")) {
    | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
    | Ok () => ()
    };
  };
};

let tests = [
  ( "Parser",
    [
      Alcotest.test_case(
        "flex-grow with interpolation",
        `Quick,
        test_flex_grow_with_interpolation,
      ),
      Alcotest.test_case(
        "flex-grow without interpolation",
        `Quick,
        test_flex_grow_without_interpolation,
      ),
      Alcotest.test_case(
        "overflow with interpolation",
        `Quick,
        test_overflow_with_interpolation,
      ),
      Alcotest.test_case(
        "flex-basis with interpolation",
        `Quick,
        test_flex_basis_with_interpolation,
      ),
      Alcotest.test_case(
        "unregistered property",
        `Quick,
        test_unregistered_property,
      ),
      Alcotest.test_case("display keywords", `Quick, test_display_keywords),
      Alcotest.test_case("flex-direction", `Quick, test_flex_direction),
      Alcotest.test_case("align-items", `Quick, test_align_items),
      Alcotest.test_case("justify-content", `Quick, test_justify_content),
      Alcotest.test_case("box-sizing", `Quick, test_box_sizing),
      Alcotest.test_case("white-space", `Quick, test_white_space),
      Alcotest.test_case(
        "width with interpolation",
        `Quick,
        test_width_with_interpolation,
      ),
      Alcotest.test_case(
        "color with interpolation",
        `Quick,
        test_color_with_interpolation,
      ),
    ],
  ),
];
