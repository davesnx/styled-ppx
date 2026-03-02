module Parser = Css_grammar.Parser;

let test_box_shadow_partial_interp = () => {
  /* Test box-shadow with partial interpolation in color position.
     TODO: Partial interpolation extraction requires architectural changes
     to walk the parsed AST and extract interpolation types from inner positions.
     Currently only full-value interpolations are supported. */
  let value = "0 1px 0 0 $(myColor)";
  let result = Parser.get_interpolation_types(~name="box-shadow", value);

  Alcotest.(check(list(pair(string, string))))(
    "partial interpolation returns empty (not yet supported)",
    [],
    result,
  );
};

let test_box_shadow_full_interp = () => {
  /* Test box-shadow with full interpolation */
  let value = "$(shadow)";
  let result = Parser.get_interpolation_types(~name="box-shadow", value);

  Alcotest.(check(list(pair(string, string))))(
    "full interpolation should return BoxShadow type",
    [("shadow", "Css_types.BoxShadow")],
    result,
  );
};

let test_box_shadow_length_interp = () => {
  /* Test box-shadow with interpolation in length position.
     TODO: Partial interpolation extraction not yet supported. */
  let value = "$(xOffset) 1px 0 0 red";
  let result = Parser.get_interpolation_types(~name="box-shadow", value);

  Alcotest.(check(list(pair(string, string))))(
    "length interpolation returns empty (not yet supported)",
    [],
    result,
  );
};

let test_text_shadow_partial_interp = () => {
  /* Test text-shadow with partial interpolation.
     TODO: Partial interpolation extraction not yet supported. */
  let value = "1px 1px 2px $(myColor)";
  let result = Parser.get_interpolation_types(~name="text-shadow", value);

  Alcotest.(check(list(pair(string, string))))(
    "partial interpolation returns empty (not yet supported)",
    [],
    result,
  );
};

let tests = [
  (
    "Partial interpolation extraction",
    [
      Alcotest.test_case(
        "box-shadow partial interp in color position",
        `Quick,
        test_box_shadow_partial_interp,
      ),
      Alcotest.test_case(
        "box-shadow full interpolation",
        `Quick,
        test_box_shadow_full_interp,
      ),
      Alcotest.test_case(
        "box-shadow partial interp in length position",
        `Quick,
        test_box_shadow_length_interp,
      ),
      Alcotest.test_case(
        "text-shadow partial interp in color position",
        `Quick,
        test_text_shadow_partial_interp,
      ),
    ],
  ),
];
