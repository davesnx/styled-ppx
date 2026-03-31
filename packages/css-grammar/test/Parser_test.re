module Parser = Css_grammar;
module Driver = Styled_ppx_css_parser.Driver;
module Ast = Styled_ppx_css_parser.Ast;

let parse_declaration_value_component_values = (~name, value) =>
  switch (Driver.parse_declaration(~loc=Ppxlib.Location.none, name ++ ": " ++ value)) {
  | Ok({ Ast.value: (values, _), _ }) => values
  | Error((_, msg)) => Alcotest.fail("parser should succeed: " ++ msg)
  };

let parse_at_rule_prelude_values = css =>
  switch (Driver.parse_stylesheet(~loc=Ppxlib.Location.none, css)) {
  | Ok(([Ast.At_rule({ prelude: (values, _), _ })], _)) => values
  | Ok(_) => Alcotest.fail("expected a single at-rule")
  | Error((_, msg)) => Alcotest.fail("parser should succeed: " ++ msg)
  };

let infer_interpolation_types = (name, value) =>
  Parser.infer_interpolation_types(
    ~name,
    parse_declaration_value_component_values(~name, value),
  );

let validate_property = (name, value) =>
  switch (Parser.find_property_packed(name)) {
  | None => Alcotest.fail(name ++ " property should be registered")
  | Some(prop) =>
    prop.validate(parse_declaration_value_component_values(~name, value))
  };

let test_flex_grow_with_interpolation = () =>
  switch (validate_property("flex-grow", "$(myVar)")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_flex_grow_without_interpolation = () =>
  switch (validate_property("flex-grow", "1.5")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_overflow_with_interpolation = () =>
  switch (validate_property("overflow", "$(x)")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_flex_basis_with_interpolation = () =>
  switch (validate_property("flex-basis", "$(basis)")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_unregistered_property = () =>
  switch (Parser.find_property_packed("unknown-property")) {
  | Some(_) => Alcotest.fail("unknown property should not be registered")
  | None => ()
  };

let test_display_keywords = () => {
  let keywords = ["block", "inline", "flex", "grid", "none", "contents"];
  List.iter(
    keyword => {
      switch (validate_property("display", keyword)) {
      | Error(msg) =>
        Alcotest.fail("parsing '" ++ keyword ++ "' should succeed: " ++ msg)
      | Ok () =>
        let interps =
          infer_interpolation_types("display", keyword);
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

let test_flex_direction = () => {
  let keywords = ["row", "row-reverse", "column", "column-reverse"];
  List.iter(
    keyword =>
      switch (validate_property("flex-direction", keyword)) {
      | Error(msg) =>
        Alcotest.fail("parsing '" ++ keyword ++ "' should succeed: " ++ msg)
      | Ok () => ()
      },
    keywords,
  );
};

let test_align_items = () => {
  let keywords = [
    "center",
    "start",
    "end",
    "flex-start",
    "flex-end",
    "stretch",
  ];
  List.iter(
    keyword =>
      switch (validate_property("align-items", keyword)) {
      | Error(msg) =>
        Alcotest.fail("parsing '" ++ keyword ++ "' should succeed: " ++ msg)
      | Ok () => ()
      },
    keywords,
  );
};

let test_justify_content = () => {
  let keywords = [
    "flex-start",
    "flex-end",
    "center",
    "space-between",
    "space-around",
  ];
  List.iter(
    keyword =>
      switch (validate_property("justify-content", keyword)) {
      | Error(msg) =>
        Alcotest.fail("parsing '" ++ keyword ++ "' should succeed: " ++ msg)
      | Ok () => ()
      },
    keywords,
  );
};

let test_box_sizing = () => {
  switch (validate_property("box-sizing", "content-box")) {
  | Error(msg) => Alcotest.fail("parsing content-box should succeed: " ++ msg)
  | Ok () => ()
  };
  switch (validate_property("box-sizing", "border-box")) {
  | Error(msg) => Alcotest.fail("parsing border-box should succeed: " ++ msg)
  | Ok () => ()
  };
};

let test_white_space = () => {
  let keywords = [
    "normal",
    "pre",
    "nowrap",
    "pre-wrap",
    "pre-line",
    "break-spaces",
  ];
  List.iter(
    keyword =>
      switch (validate_property("white-space", keyword)) {
      | Error(msg) =>
        Alcotest.fail("parsing '" ++ keyword ++ "' should succeed: " ++ msg)
      | Ok () => ()
      },
    keywords,
  );
};

let test_width_with_interpolation = () =>
  switch (validate_property("width", "$(w)")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_color_with_interpolation = () =>
  switch (validate_property("color", "$(c)")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_width_with_component_values = () =>
  switch (validate_property("width", "calc(100vh + $(topMenuHeight))")) {
  | Error(msg) => Alcotest.fail("component_value_list parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_media_query_prelude_with_component_values = () =>
  switch (
    Parser.type_check(
      Parser.media_query_list,
      parse_at_rule_prelude_values(
        "@media screen and (min-width: 33px) {}",
      ),
    )
  ) {
  | Ok(_) => ()
  | Error(msg) =>
    Alcotest.fail("media query component_value_list parsing should succeed: " ++ msg)
  };

let test_container_query_prelude_with_component_values = () =>
  switch (
    Parser.type_check(
      Parser.container_condition_list,
      parse_at_rule_prelude_values(
        "@container name (width >= 150px) {}",
      ),
    )
  ) {
  | Ok(_) => ()
  | Error(msg) =>
    Alcotest.fail(
      "container query component_value_list parsing should succeed: " ++ msg,
    )
  };

let tests = [
  (
    "Parser",
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
      Alcotest.test_case(
        "width with component_value_list",
        `Quick,
        test_width_with_component_values,
      ),
      Alcotest.test_case(
        "media query prelude with component_value_list",
        `Quick,
        test_media_query_prelude_with_component_values,
      ),
      Alcotest.test_case(
        "container query prelude with component_value_list",
        `Quick,
        test_container_query_prelude_with_component_values,
      ),
    ],
  ),
];
