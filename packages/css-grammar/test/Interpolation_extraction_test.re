module Parser = Css_grammar;
module Driver = Styled_ppx_css_parser.Driver;
module Ast = Styled_ppx_css_parser.Ast;

let parse_declaration_value_component_values = (~name, value) =>
  switch (
    Driver.parse_declaration(~loc=Ppxlib.Location.none, name ++ ": " ++ value)
  ) {
  | Ok({ Ast.value: (values, _), _ }) => values
  | Error((_, msg)) => Alcotest.fail("parser should succeed: " ++ msg)
  };

let infer_interpolation_types = (name, value) =>
  Parser.infer_interpolation_types(
    ~name,
    parse_declaration_value_component_values(~name, value),
  );

let test_box_shadow_partial_interp = () => {
  /* Test box-shadow with partial interpolation in color position.
     Extraction delegates through the registry to find interpolation types
     from inner type positions (e.g., <color> inside <shadow>). */
  let result =
    infer_interpolation_types("box-shadow", "0 1px 0 0 $(myColor)");

  Alcotest.(check(list(pair(string, string))))(
    "partial interpolation extracts color type",
    [("myColor", "Css_types.Color")],
    result,
  );
};

let test_box_shadow_full_interp = () => {
  /* Test box-shadow with full interpolation */
  let value = "$(shadow)";
  let result = infer_interpolation_types("box-shadow", value);

  Alcotest.(check(list(pair(string, string))))(
    "full interpolation should return BoxShadows type",
    [("shadow", "Css_types.BoxShadows")],
    result,
  );
};

let test_text_shadow_full_interp = () => {
  let value = "$(shadow)";
  let result = infer_interpolation_types("text-shadow", value);

  Alcotest.(check(list(pair(string, string))))(
    "full interpolation should return TextShadows type",
    [("shadow", "Css_types.TextShadows")],
    result,
  );
};

let test_box_shadow_length_interp = () => {
  /* Test box-shadow with interpolation in length position.
     Extraction delegates through the registry to find interpolation types
     from inner type positions (e.g., <extended-length> inside <shadow>). */
  let value = "$(xOffset) 1px 0 0 red";
  let result = infer_interpolation_types("box-shadow", value);

  Alcotest.(check(list(pair(string, string))))(
    "length interpolation extracts Length type",
    [("xOffset", "Css_types.Length")],
    result,
  );
};

let test_text_shadow_partial_interp = () => {
  /* Test text-shadow with partial interpolation in color position.
     Extraction delegates through the registry to find interpolation types
     from inner type positions (e.g., <color> inside <shadow-t>). */
  let value = "1px 1px 2px $(myColor)";
  let result = infer_interpolation_types("text-shadow", value);

  Alcotest.(check(list(pair(string, string))))(
    "partial interpolation extracts color type",
    [("myColor", "Css_types.Color")],
    result,
  );
};

let test_border_top_color_partial_interp = () => {
  let result = infer_interpolation_types("border-top", "1px solid $(myColor)");

  Alcotest.(check(list(pair(string, string))))(
    "border-top partial interpolation extracts color type",
    [("myColor", "Css_types.Color")],
    result,
  );
};

let test_height_calc_interp = () => {
  let result =
    infer_interpolation_types("height", "calc(100vh + $(topMenuHeight))");

  Alcotest.(check(list(pair(string, string))))(
    "height calc interpolation keeps the length context",
    [("topMenuHeight", "Css_types.Length")],
    result,
  );
};

let test_font_family_partial_interp = () => {
  let result = infer_interpolation_types("font-family", "Inter, $(font)");

  Alcotest.(check(list(pair(string, string))))(
    "font-family partial interpolation keeps FontFamily context",
    [("font", "Css_types.FontFamily")],
    result,
  );
};

let test_flex_duplicate_interpolation_names = () => {
  let result = infer_interpolation_types("flex", "$(value) $(value)");

  Alcotest.(check(list(pair(string, string))))(
    "flex keeps both duplicate interpolation slots",
    [("value", "Css_types.FlexGrow"), ("value", "Css_types.FlexShrink")],
    result,
  );
};

let test_box_shadow_partial_interp_component_values = () => {
  let result =
    Parser.infer_interpolation_types(
      ~name="box-shadow",
      parse_declaration_value_component_values(
        ~name="box-shadow",
        "0 1px 0 0 $(myColor)",
      ),
    );

  Alcotest.(check(list(pair(string, string))))(
    "component_value_list extraction keeps color type",
    [("myColor", "Css_types.Color")],
    result,
  );
};

let test_flex_duplicate_interpolation_names_component_values = () => {
  let result =
    Parser.infer_interpolation_types(
      ~name="flex",
      parse_declaration_value_component_values(
        ~name="flex",
        "$(value) $(value)",
      ),
    );

  Alcotest.(check(list(pair(string, string))))(
    "component_value_list keeps duplicate interpolation slots",
    [("value", "Css_types.FlexGrow"), ("value", "Css_types.FlexShrink")],
    result,
  );
};

/* Test infer_interpolation_types for properties WITH runtime_module_path */
let test_color_full_interp = () => {
  let result = infer_interpolation_types("color", "$(myColor)");
  Alcotest.(check(list(pair(string, string))))(
    "color full interp returns Css_types.Color",
    [("myColor", "Css_types.Color")],
    result,
  );
};

let test_display_full_interp = () => {
  let result = infer_interpolation_types("display", "$(myDisplay)");
  Alcotest.(check(list(pair(string, string))))(
    "display full interp returns Css_types.Display",
    [("myDisplay", "Css_types.Display")],
    result,
  );
};

let test_width_full_interp = () => {
  let result = infer_interpolation_types("width", "$(myWidth)");
  Alcotest.(check(list(pair(string, string))))(
    "width full interp returns Css_types.Width",
    [("myWidth", "Css_types.Width")],
    result,
  );
};

/* Test infer_interpolation_types for properties with derived runtime_module_path */
let test_background_color_full_interp = () => {
  let result = infer_interpolation_types("background-color", "$(myBg)");
  Alcotest.(check(list(pair(string, string))))(
    "background-color full interp returns Css_types.Color",
    [("myBg", "Css_types.Color")],
    result,
  );
};

let test_padding_top_full_interp = () => {
  let result = infer_interpolation_types("padding-top", "$(myPad)");
  Alcotest.(check(list(pair(string, string))))(
    "padding-top full interp returns Css_types.Length",
    [("myPad", "Css_types.Length")],
    result,
  );
};

let test_opacity_full_interp = () => {
  let result = infer_interpolation_types("opacity", "$(myOpacity)");
  Alcotest.(check(list(pair(string, string))))(
    "opacity full interp returns Css_types.Opacity",
    [("myOpacity", "Css_types.Opacity")],
    result,
  );
};

/* Test non-interpolated values return empty */
let test_color_no_interp = () => {
  let result = infer_interpolation_types("color", "red");
  Alcotest.(check(list(pair(string, string))))(
    "color with literal returns empty",
    [],
    result,
  );
};

let tests = [
  (
    "Interpolation extraction - properties with runtime_module_path",
    [
      Alcotest.test_case(
        "color full interpolation",
        `Quick,
        test_color_full_interp,
      ),
      Alcotest.test_case(
        "display full interpolation",
        `Quick,
        test_display_full_interp,
      ),
      Alcotest.test_case(
        "width full interpolation",
        `Quick,
        test_width_full_interp,
      ),
      Alcotest.test_case(
        "color no interpolation",
        `Quick,
        test_color_no_interp,
      ),
    ],
  ),
  (
    "Interpolation extraction - previously pathless properties",
    [
      Alcotest.test_case(
        "background-color full interpolation",
        `Quick,
        test_background_color_full_interp,
      ),
      Alcotest.test_case(
        "padding-top full interpolation",
        `Quick,
        test_padding_top_full_interp,
      ),
      Alcotest.test_case(
        "opacity full interpolation",
        `Quick,
        test_opacity_full_interp,
      ),
    ],
  ),
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
        "text-shadow full interpolation",
        `Quick,
        test_text_shadow_full_interp,
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
      Alcotest.test_case(
        "border-top partial interp in color position",
        `Quick,
        test_border_top_color_partial_interp,
      ),
      Alcotest.test_case(
        "height calc interpolation",
        `Quick,
        test_height_calc_interp,
      ),
      Alcotest.test_case(
        "font-family partial interpolation",
        `Quick,
        test_font_family_partial_interp,
      ),
      Alcotest.test_case(
        "flex duplicate interpolation names",
        `Quick,
        test_flex_duplicate_interpolation_names,
      ),
      Alcotest.test_case(
        "box-shadow partial interp with component_value_list",
        `Quick,
        test_box_shadow_partial_interp_component_values,
      ),
      Alcotest.test_case(
        "flex duplicate interpolation names with component_value_list",
        `Quick,
        test_flex_duplicate_interpolation_names_component_values,
      ),
    ],
  ),
];
