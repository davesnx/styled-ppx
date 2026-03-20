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

/* Phase 0: Verify [%spec_module] extract_interpolations works at runtime */
let test_spec_module_runtime_module_path_none = () => {
  Alcotest.(check(option(string)))(
    "spec_module without path has runtime_module_path = None",
    None,
    Parser.Test_simple.runtime_module_path,
  );
};

let test_spec_module_runtime_module_path_some = () => {
  Alcotest.(check(option(string)))(
    "spec_module with path has runtime_module_path = Some",
    Some("Css_types.Color"),
    Parser.Test_with_path.runtime_module_path,
  );
};

let test_spec_module_parse = () => {
  let result = Parser.Test_with_path.parse("red");
  switch (result) {
  | Ok(_) =>
    Alcotest.(check(bool))("parse succeeds for valid color", true, true)
  | Error(msg) =>
    Alcotest.fail("parse should succeed for 'red', got: " ++ msg)
  };
};

let test_spec_module_extract_on_parsed = () => {
  /* For [%spec_module "<color>"], the spec is a single terminal data type.
     The PPX-generated extract_interpolations only finds interpolations
     explicitly in the SPEC, not inside referenced types like <color>.
     The <color> type itself includes <interpolation> internally, but
     that's opaque to the spec-level extractor.
     This is handled by the hybrid approach in pack_module. */
  let result = Parser.Test_with_path.parse("$(myVar)");
  switch (result) {
  | Ok(ast) =>
    let interps = Parser.Test_with_path.extract_interpolations(ast);
    Alcotest.(check(list(pair(string, string))))(
      "extract_interpolations returns empty for opaque type reference (expected)",
      [],
      interps,
    );
  | Error(msg) =>
    Alcotest.fail("parse should succeed for '$(myVar)', got: " ++ msg)
  };
};

let test_spec_module_explicit_interpolation = () => {
  /* This spec has <interpolation> explicitly in the union.
     extract_interpolations should find it and return the module path. */
  let result = Parser.Test_with_interp.parse("$(myLength)");
  switch (result) {
  | Ok(ast) =>
    let interps = Parser.Test_with_interp.extract_interpolations(ast);
    Alcotest.(check(list(pair(string, string))))(
      "extract_interpolations finds explicit interpolation with Length type path",
      [("myLength", "Css_types.Length")],
      interps,
    );
  | Error(msg) =>
    Alcotest.fail("parse should succeed for '$(myLength)', got: " ++ msg)
  };
};

let test_pack_module_hybrid_extraction = () => {
  /* Verify pack_module's hybrid approach: for <color> (opaque type containing
     interpolation internally), the module's extract_interpolations returns [],
     but pack_module falls back to whole-value interpolation detection. */
  let packed = Parser.pack_module((module Parser.Test_with_path));
  let Parser.Pack_rule({ extract_interpolations, _ }) = packed;
  let result = extract_interpolations("$(myColor)");
  Alcotest.(check(list(pair(string, string))))(
    "pack_module hybrid: falls back to runtime_module_path for opaque types",
    [("myColor", "Css_types.Color")],
    result,
  );
};

let test_pack_module_rich_extraction = () => {
  /* Verify pack_module uses the module's rich extraction when available */
  let packed = Parser.pack_module((module Parser.Test_with_interp));
  let Parser.Pack_rule({ extract_interpolations, _ }) = packed;
  let result = extract_interpolations("$(myLength)");
  Alcotest.(check(list(pair(string, string))))(
    "pack_module rich: uses module's extract_interpolations",
    [("myLength", "Css_types.Length")],
    result,
  );
};

let test_spec_module_extract_no_interp = () => {
  let result = Parser.Test_with_path.parse("red");
  switch (result) {
  | Ok(ast) =>
    let interps = Parser.Test_with_path.extract_interpolations(ast);
    Alcotest.(check(list(pair(string, string))))(
      "extract_interpolations returns empty for non-interpolated value",
      [],
      interps,
    );
  | Error(msg) =>
    Alcotest.fail("parse should succeed for 'red', got: " ++ msg)
  };
};

/* Test get_interpolation_types for properties WITH runtime_module_path */
let test_color_full_interp = () => {
  let result = Parser.get_interpolation_types(~name="color", "$(myColor)");
  Alcotest.(check(list(pair(string, string))))(
    "color full interp returns Css_types.Color",
    [("myColor", "Css_types.Color")],
    result,
  );
};

let test_display_full_interp = () => {
  let result = Parser.get_interpolation_types(~name="display", "$(myDisplay)");
  Alcotest.(check(list(pair(string, string))))(
    "display full interp returns Css_types.Display",
    [("myDisplay", "Css_types.Display")],
    result,
  );
};

let test_width_full_interp = () => {
  let result = Parser.get_interpolation_types(~name="width", "$(myWidth)");
  Alcotest.(check(list(pair(string, string))))(
    "width full interp returns Css_types.Width",
    [("myWidth", "Css_types.Width")],
    result,
  );
};

/* Test get_interpolation_types for properties that previously lacked runtime_module_path */
let test_background_color_full_interp = () => {
  let result =
    Parser.get_interpolation_types(~name="background-color", "$(myBg)");
  Alcotest.(check(list(pair(string, string))))(
    "background-color full interp returns Css_types.Color",
    [("myBg", "Css_types.Color")],
    result,
  );
};

let test_padding_top_full_interp = () => {
  let result =
    Parser.get_interpolation_types(~name="padding-top", "$(myPad)");
  Alcotest.(check(list(pair(string, string))))(
    "padding-top full interp returns Css_types.Length",
    [("myPad", "Css_types.Length")],
    result,
  );
};

let test_opacity_full_interp = () => {
  let result =
    Parser.get_interpolation_types(~name="opacity", "$(myOpacity)");
  Alcotest.(check(list(pair(string, string))))(
    "opacity full interp returns Css_types.Opacity",
    [("myOpacity", "Css_types.Opacity")],
    result,
  );
};

/* Test non-interpolated values return empty */
let test_color_no_interp = () => {
  let result = Parser.get_interpolation_types(~name="color", "red");
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
  (
    "spec_module verification",
    [
      Alcotest.test_case(
        "runtime_module_path is None without path arg",
        `Quick,
        test_spec_module_runtime_module_path_none,
      ),
      Alcotest.test_case(
        "runtime_module_path is Some with path arg",
        `Quick,
        test_spec_module_runtime_module_path_some,
      ),
      Alcotest.test_case(
        "parse works on valid value",
        `Quick,
        test_spec_module_parse,
      ),
      Alcotest.test_case(
        "extract_interpolations on interpolated value",
        `Quick,
        test_spec_module_extract_on_parsed,
      ),
      Alcotest.test_case(
        "extract_interpolations with explicit <interpolation> in spec",
        `Quick,
        test_spec_module_explicit_interpolation,
      ),
      Alcotest.test_case(
        "extract_interpolations on non-interpolated value",
        `Quick,
        test_spec_module_extract_no_interp,
      ),
      Alcotest.test_case(
        "pack_module hybrid extraction for opaque types",
        `Quick,
        test_pack_module_hybrid_extraction,
      ),
      Alcotest.test_case(
        "pack_module rich extraction for explicit interpolation",
        `Quick,
        test_pack_module_rich_extraction,
      ),
    ],
  ),
];
