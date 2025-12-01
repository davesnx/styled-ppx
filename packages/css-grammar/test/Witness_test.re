/* Tests for the GADT witness system */

let test_witness_to_name_property = () => {
  /* Property witnesses should return prefixed names */
  let name = Css_grammar.Types.witness_to_name(Css_grammar.Types.W_property_display);
  Alcotest.(check(string, "property witness returns prefixed name", "property_display", name));
};

let test_witness_to_name_value = () => {
  /* Value witnesses should return unprefixed names */
  let name = Css_grammar.Types.witness_to_name(Css_grammar.Types.W_color);
  Alcotest.(check(string, "value witness returns unprefixed name", "color", name));
};

let test_witness_eq_same = () => {
  /* Same witnesses should be equal */
  let eq_result = Css_grammar.Types.witness_eq(
    Css_grammar.Types.W_property_display,
    Css_grammar.Types.W_property_display
  );
  Alcotest.(check(bool, "same witness equals itself", true, Option.is_some(eq_result)));
};

let test_witness_eq_different = () => {
  /* Different witnesses should not be equal */
  let eq_result = Css_grammar.Types.witness_eq(
    Css_grammar.Types.W_property_display,
    Css_grammar.Types.W_property_overflow
  );
  Alcotest.(check(bool, "different witnesses are not equal", true, Option.is_none(eq_result)));
};

let test_name_to_packed_witness_property = () => {
  /* Property names should resolve to packed witnesses */
  let witness_opt = Css_grammar.Types.name_to_packed_witness("property_display");
  Alcotest.(check(bool, "property name resolves to witness", true, Option.is_some(witness_opt)));
};

let test_name_to_packed_witness_value = () => {
  /* Value names should resolve to packed witnesses */
  let witness_opt = Css_grammar.Types.name_to_packed_witness("color");
  Alcotest.(check(bool, "value name resolves to witness", true, Option.is_some(witness_opt)));
};

let test_name_to_packed_witness_unknown = () => {
  /* Unknown names should return None */
  let witness_opt = Css_grammar.Types.name_to_packed_witness("unknown-property");
  Alcotest.(check(bool, "unknown name returns None", true, Option.is_none(witness_opt)));
};

let test_lookup_property_display = () => {
  /* lookup should successfully find and return a rule for property witnesses */
  let rule = Css_grammar.Parser.lookup(Css_grammar.Types.W_property_display);
  let result = Css_grammar.Parser.parse(rule, "block");
  switch (result) {
  | Ok(_) => ()
  | Error(msg) => Alcotest.fail("lookup should parse 'block': " ++ msg)
  };
};

let test_lookup_value_color = () => {
  /* lookup should successfully find and return a rule for value witnesses */
  let rule = Css_grammar.Parser.lookup(Css_grammar.Types.W_color);
  let result = Css_grammar.Parser.parse(rule, "red");
  switch (result) {
  | Ok(_) => ()
  | Error(msg) => Alcotest.fail("lookup should parse 'red': " ++ msg)
  };
};

let tests = [
  ("witness_to_name returns prefixed name for properties", [
    Alcotest.test_case("property witness", `Quick, test_witness_to_name_property),
  ]),
  ("witness_to_name returns unprefixed name for values", [
    Alcotest.test_case("value witness", `Quick, test_witness_to_name_value),
  ]),
  ("witness_eq for same witnesses", [
    Alcotest.test_case("same witness", `Quick, test_witness_eq_same),
  ]),
  ("witness_eq for different witnesses", [
    Alcotest.test_case("different witnesses", `Quick, test_witness_eq_different),
  ]),
  ("name_to_packed_witness for properties", [
    Alcotest.test_case("property name", `Quick, test_name_to_packed_witness_property),
  ]),
  ("name_to_packed_witness for values", [
    Alcotest.test_case("value name", `Quick, test_name_to_packed_witness_value),
  ]),
  ("name_to_packed_witness for unknown", [
    Alcotest.test_case("unknown name", `Quick, test_name_to_packed_witness_unknown),
  ]),
  ("lookup parses property display correctly", [
    Alcotest.test_case("display:block", `Quick, test_lookup_property_display),
  ]),
  ("lookup parses value color correctly", [
    Alcotest.test_case("color:red", `Quick, test_lookup_value_color),
  ]),
];

