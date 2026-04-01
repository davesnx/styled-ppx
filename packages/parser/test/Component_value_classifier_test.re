open Alcotest;

module Ast = Styled_ppx_css_parser.Ast;
module Classifier = Styled_ppx_css_parser.Component_value_classifier;

let loc = Ppxlib.Location.none;

let tests = [
  test_case("ident matches expected string", `Quick, () => {
    check(
      bool,
      "ident helper matches expected keyword",
      true,
      Classifier.Ident.matches(~expected="screen", Ast.Ident("screen")),
    );
    check(
      bool,
      "ident helper rejects non-matching keyword",
      false,
      Classifier.Ident.matches(~expected="print", Ast.Ident("screen")),
    );
  }),
  test_case("function classifier extracts matching body", `Quick, () => {
    let body = [(Ast.Number(10.), loc)];
    let function_value =
      Ast.Function({
        name: ("calc", loc),
        kind: Ast.Function_kind_regular,
        body: (body, loc),
      });
    check(
      bool,
      "matching function returns body",
      true,
      switch (Classifier.Function.body_if_named(~expected="calc", function_value)) {
      | Some(found) => found == body
      | None => false
      },
    );
    check(
      bool,
      "other function name does not match",
      false,
      switch (Classifier.Function.body_if_named(~expected="min", function_value)) {
      | Some(_) => true
      | None => false
      },
    );
    check(
      bool,
      "function helper exposes regular kind",
      true,
      switch (Classifier.Function.kind(function_value)) {
      | Some(Ast.Function_kind_regular) => true
      | _ => false
      },
    );
  }),
  test_case("dimension unit classifiers normalize units", `Quick, () => {
    let px_dimension = Classifier.Dimension.make((10., "px"));
    let resolution_dimension = Classifier.Dimension.make((2., "X"));
    let nth_dimension = Classifier.Dimension.make((2., "n"));
    check(
      bool,
      "dimension payload stores parsed length kind",
      true,
      px_dimension.kind == Ast.Dimension_length(Ast.Length_unit_px),
    );
    check(
      bool,
      "length unit px classified",
      true,
      switch (Classifier.Dimension.Length_unit.of_string("px")) {
      | Some(_) => true
      | None => false
      },
    );
    check(
      bool,
      "resolution unit upper-case X classified as dppx",
      true,
      switch (Classifier.Dimension.Resolution_unit.of_string("X")) {
      | Some(_) => true
      | None => false
      },
    );
    check(
      bool,
      "dimension payload stores parsed resolution kind",
      true,
      resolution_dimension.kind == Ast.Dimension_resolution(Ast.Resolution_unit_dppx),
    );
    check(
      bool,
      "unknown dimension unit stays unknown",
      true,
      nth_dimension.kind == Ast.Dimension_unknown,
    );
  }),
  test_case("keyword classifiers detect reserved names", `Quick, () => {
    check(
      bool,
      "media reserved helper detects only",
      true,
      switch (Classifier.Keyword.media_reserved(Ast.Ident("only"))) {
      | Some(_) => true
      | None => false
      },
    );
    check(
      bool,
      "container reserved helper detects none",
      true,
      switch (Classifier.Keyword.container_reserved_of_string("none")) {
      | Some(_) => true
      | None => false
      },
    );
    check(
      bool,
      "custom ident exclusion helper detects auto string",
      true,
      switch (Classifier.Keyword.custom_ident_exclusion(Ast.String("auto"))) {
      | Some(_) => true
      | None => false
      },
    );
  }),
];
