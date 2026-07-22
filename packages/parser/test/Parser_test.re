open Alcotest;

module Ast = Styled_ppx_css_parser.Ast;
module Driver = Styled_ppx_css_parser.Driver;
module Parser_location = Styled_ppx_css_parser.Parser_location;

/* Parse the input as a whole file, so error positions come back unshifted. */
let source_position_start = Parser_location.file_start();

let parse = input => {
  switch (Driver.parse_stylesheet(~source_position_start, input)) {
  | Ok(ast) => Ok(ast)
  | Error((loc, msg)) =>
    let pos = loc.loc_start;
    let err =
      Printf.sprintf(
        "%s on line %i at position %i",
        msg,
        pos.pos_lnum,
        pos.pos_cnum - pos.pos_bol,
      );
    Error(err);
  };
};

let parse_declaration_list_exn = input => {
  switch (Driver.parse_declaration_list(~source_position_start, input)) {
  | Ok(value) => value
  | Error((_, msg)) =>
    fail("expected declaration list parse success: " ++ msg)
  };
};

let error_test_cases = data =>
  data
  |> List.map(((input, output)) => {
       let assertion = () =>
         check(
           string,
           "should error " ++ input,
           output,
           parse(input) |> Result.get_error,
         );

       test_case(input, `Quick, assertion);
     });

let error_tests_data =
  [
    ("{}", "Parse error while reading token '{' on line 1 at position 0"),
    (
      {|div
        { color: red; _ }
      |},
      "Parse error while reading token '}' on line 2 at position 24",
    ),
    (
      "@media $",
      "Parse error while reading token 'the end' on line 1 at position 8",
    ),
    (
      {|div { color: $(x)) }|},
      "Parse error while reading token ')' on line 1 at position 17",
    ),
  ]
  |> error_test_cases;

let parse_nth_payload_exn = input => {
  switch (Driver.parse_stylesheet(~source_position_start, input)) {
  | Ok((
      [
        Ast.Style_rule({
          prelude:
            (
              [
                (
                  Ast.ComplexSelector(
                    Ast.Selector(
                      Ast.CompoundSelector({
                        subclass_selectors:
                          [
                            Ast.Pseudo_class(
                              Ast.Pseudoclass(
                                Ast.NthFunction({
                                  payload: (Ast.Nth(nth), _),
                                  _,
                                }),
                              ),
                            ),
                          ],
                        _,
                      }),
                    ),
                  ),
                  _,
                ),
              ],
              _,
            ),
          _,
        }),
      ],
      _,
    )) => nth
  | Ok(_) => fail("expected nth payload AST for: " ++ input)
  | Error((_, msg)) =>
    fail("expected nth parse success for " ++ input ++ ": " ++ msg)
  };
};

/* An+B microsyntax: valid payloads and their parsed representation. */
let nth_payload_tests_data =
  [
    ("li:nth-child(2n+1) { color: red; }", Ast.ANB(2, "+", 1)),
    ("li:nth-child(-n+6) { color: red; }", Ast.ANB(-1, "+", 6)),
    ("li:nth-child(3n-6) { color: red; }", Ast.ANB(3, "-", 6)),
    /* "n-<digits>" idents carry b, it must not be dropped */
    ("li:nth-child(n-3) { color: red; }", Ast.ANB(1, "-", 3)),
    ("li:nth-child(-n-3) { color: red; }", Ast.ANB(-1, "-", 3)),
    /* "an-" followed by a signless integer means b is negative */
    ("li:nth-child(2n- 3) { color: red; }", Ast.ANB(2, "-", 3)),
    ("li:nth-child(n- 3) { color: red; }", Ast.ANB(1, "-", 3)),
    /* CSS is ASCII case-insensitive */
    ("li:nth-child(2N) { color: red; }", Ast.AN(2)),
    ("li:nth-child(2N-1) { color: red; }", Ast.ANB(2, "-", 1)),
    ("li:nth-child(-N+3) { color: red; }", Ast.ANB(-1, "+", 3)),
    ("li:nth-child(EVEN) { color: red; }", Ast.Even),
    ("li:nth-child(even) { color: red; }", Ast.Even),
    ("li:nth-child(odd) { color: red; }", Ast.Odd),
    ("li:nth-child(5) { color: red; }", Ast.A(5)),
    ("li:nth-child(n) { color: red; }", Ast.AN(1)),
    ("li:nth-child(-n) { color: red; }", Ast.AN(-1)),
  ]
  |> List.map(((input, expected)) => {
       let assertion = () =>
         check(
           string,
           "should parse " ++ input,
           Ast.show_nth(expected),
           Ast.show_nth(parse_nth_payload_exn(input)),
         );

       test_case(input, `Quick, assertion);
     });

/* An+B microsyntax: invalid payloads must produce a located parse error,
   never an exception (int_of_string used to escape as Failure). */
let nth_error_tests_data =
  [
    (
      "li:nth-child(3n-abc) { color: red; }",
      "Invalid an+b value in :nth-child() on line 1 at position 13",
    ),
    (
      "li:nth-child(3n-99999999999999999999) { color: red; }",
      "Invalid an+b value in :nth-child() on line 1 at position 13",
    ),
    (
      "li:nth-child(99999999999999999999n) { color: red; }",
      "Invalid an+b value in :nth-child() on line 1 at position 13",
    ),
    (
      "li:nth-child(2px) { color: red; }",
      "Invalid an+b value in :nth-child() on line 1 at position 13",
    ),
    (
      "li:nth-child(n-abc) { color: red; }",
      "Invalid an+b value in :nth-child() on line 1 at position 13",
    ),
    (
      "li:nth-child(foo) { color: red; }",
      "Invalid an+b value in :nth-child() on line 1 at position 13",
    ),
    (
      "li:nth-child(2.5) { color: red; }",
      "Invalid an+b value in :nth-child() on line 1 at position 13",
    ),
    /* int_of_string would silently accept hex and underscores */
    (
      "li:nth-child(3n-0x10) { color: red; }",
      "Invalid an+b value in :nth-child() on line 1 at position 13",
    ),
    (
      "li:nth-child(3n-1_0) { color: red; }",
      "Invalid an+b value in :nth-child() on line 1 at position 13",
    ),
    /* "an-" requires a signless integer after it */
    (
      "li:nth-child(2n-) { color: red; }",
      "Parse error while reading token ')' on line 1 at position 16",
    ),
    (
      "li:nth-child(2n- -3) { color: red; }",
      "Invalid an+b value in :nth-child() on line 1 at position 17",
    ),
    (
      "li:nth-of-type(2px) { color: red; }",
      "Invalid an+b value in :nth-of-type() on line 1 at position 15",
    ),
  ]
  |> error_test_cases;

let declaration_ast_tests = [
  test_case("declaration preserves id-like hash kind", `Quick, () => {
    switch (Driver.parse_declaration(~source_position_start, "color:#abc;")) {
    | Ok({ value: ([(Ast.Hash((value, kind)), _)], _), _ }) =>
      check(string, "preserves hash text", "abc", value);
      check(bool, "preserves id hash kind", true, kind == Ast.Hash_kind_id);
    | _ => fail("expected hash declaration AST")
    }
  }),
  test_case("declaration preserves unrestricted hash kind", `Quick, () => {
    switch (Driver.parse_declaration(~source_position_start, "color:#2;")) {
    | Ok({ value: ([(Ast.Hash((value, kind)), _)], _), _ }) =>
      check(string, "preserves hash text", "2", value);
      check(
        bool,
        "preserves unrestricted hash kind",
        true,
        kind == Ast.Hash_kind_unrestricted,
      );
    | _ => fail("expected hash declaration AST")
    }
  }),
];

let function_ast_tests = [
  test_case("declaration preserves regular function kind", `Quick, () => {
    switch (
      Driver.parse_declaration(~source_position_start, "color:calc(1px);")
    ) {
    | Ok({
        value: ([(Ast.Function({ name: (name, _), kind, _ }), _)], _),
        _,
      }) =>
      check(string, "preserves function name", "calc", name);
      check(
        bool,
        "preserves regular function kind",
        true,
        kind == Ast.Function_kind_regular,
      );
    | _ => fail("expected regular function AST")
    }
  }),
  test_case("declaration preserves nth function kind", `Quick, () => {
    switch (
      Driver.parse_declaration(
        ~source_position_start,
        "color:nth-child(2n+1);",
      )
    ) {
    | Ok({
        value: ([(Ast.Function({ name: (name, _), kind, _ }), _)], _),
        _,
      }) =>
      check(string, "preserves function name", "nth-child", name);
      check(
        bool,
        "preserves nth function kind",
        true,
        kind == Ast.Function_kind_nth,
      );
    | _ => fail("expected nth function AST")
    }
  }),
];

let selector_combinator_ast_tests = [
  test_case("stylesheet preserves child combinator", `Quick, () => {
    switch (Driver.parse_stylesheet(~source_position_start, "a > b {}")) {
    | Ok((
        [
          Ast.Style_rule({
            prelude:
              (
                [
                  (
                    Ast.ComplexSelector(
                      Ast.Combinator({
                        left: Ast.SimpleSelector(Ast.Type("a")),
                        right:
                          [
                            (
                              Ast.Selector_child,
                              Ast.SimpleSelector(Ast.Type("b")),
                            ),
                          ],
                      }),
                    ),
                    _,
                  ),
                ],
                _,
              ),
            _,
          }),
        ],
        _,
      )) =>
      ()
    | _ => fail("expected child combinator AST")
    }
  }),
  test_case("stylesheet preserves descendant combinator", `Quick, () => {
    switch (Driver.parse_stylesheet(~source_position_start, "a b {}")) {
    | Ok((
        [
          Ast.Style_rule({
            prelude:
              (
                [
                  (
                    Ast.ComplexSelector(
                      Ast.Combinator({
                        left: Ast.SimpleSelector(Ast.Type("a")),
                        right:
                          [
                            (
                              Ast.Selector_descendant,
                              Ast.SimpleSelector(Ast.Type("b")),
                            ),
                          ],
                      }),
                    ),
                    _,
                  ),
                ],
                _,
              ),
            _,
          }),
        ],
        _,
      )) =>
      ()
    | _ => fail("expected descendant combinator AST")
    }
  }),
  test_case(
    "selector function payload preserves relative combinator", `Quick, () => {
    switch (
      Driver.parse_stylesheet(~source_position_start, "div:has(> span) {}")
    ) {
    | Ok(([Ast.Style_rule({ prelude: ([(selector, _)], _), _ })], _)) =>
      switch (selector) {
      | Ast.ComplexSelector(
          Ast.Selector(
            Ast.CompoundSelector({
              type_selector: Some(Ast.Type("div")),
              subclass_selectors:
                [
                  Ast.Pseudo_class(
                    Ast.Pseudoclass(
                      Ast.Function({
                        name: "has",
                        payload:
                          (
                            [
                              (
                                Ast.RelativeSelector({
                                  combinator: Some(Ast.Selector_child),
                                  _,
                                }),
                                _,
                              ),
                            ],
                            _,
                          ),
                      }),
                    ),
                  ),
                ],
              _,
            }),
          ),
        ) =>
        ()
      | _ => fail("expected relative combinator AST")
      }
    | _ => fail("expected relative combinator AST")
    }
  }),
];

let ambiguity_regression_tests = [
  test_case(
    "declaration list stops before nested descendant selector", `Quick, () => {
    switch (
      parse_declaration_list_exn("color: red\nsvg path { fill: blue; }")
    ) {
    | ([Ast.Declaration({ name: ("color", _), _ }), Ast.Style_rule(_)], _) =>
      ()
    | _ => fail("expected declaration followed by nested descendant selector")
    }
  }),
  test_case(
    "declaration list stops before nested media rule after interpolation",
    `Quick,
    () => {
    switch (
      parse_declaration_list_exn(
        "margin-bottom: $(Size.lg) @media (min-width: 1024px) { width: 50%; }",
      )
    ) {
    | (
        [
          Ast.Declaration({ name: ("margin-bottom", _), _ }),
          Ast.At_rule({ name: ("media", _), _ }),
        ],
        _,
      ) =>
      ()
    | _ => fail("expected declaration followed by nested media rule")
    }
  }),
  test_case("selector head with pseudo parses as style rule", `Quick, () => {
    switch (
      Driver.parse_declaration_list(
        ~source_position_start,
        "a:hover { color: blue; }",
      )
    ) {
    | Ok(([Ast.Style_rule(_)], _)) => ()
    | Ok(_) => fail("expected style rule")
    | Error((_, msg)) => fail("expected style rule parse success: " ++ msg)
    }
  }),
  test_case(
    "selector head with unknown pseudo parses as style rule", `Quick, () => {
    switch (
      Driver.parse_declaration_list(
        ~source_position_start,
        "a:future-state { color: blue; }",
      )
    ) {
    | Ok(([Ast.Style_rule(_)], _)) => ()
    | Ok(_) => fail("expected style rule")
    | Error((_, msg)) => fail("expected style rule parse success: " ++ msg)
    }
  }),
];

/* Invalid UTF-8 bytes must produce a located Error, never an exception:
   sedlex raises [MalFormed] on the first malformed byte and the lexer turns
   it into a [LexingError] pointing at that byte. Regression test for the
   crash `Fatal error: exception Sedlexing.MalFormed`. */
let invalid_utf8_tests = [
  test_case("stylesheet with invalid UTF-8 in a string errors", `Quick, () => {
    check(
      string,
      "points at the invalid byte",
      "This CSS is not valid UTF-8 on line 1 at position 13",
      parse("content: \"caf\xe9\"") |> Result.get_error,
    )
  }),
  test_case("stylesheet with invalid UTF-8 in a selector errors", `Quick, () => {
    check(
      string,
      "points at the invalid byte",
      "This CSS is not valid UTF-8 on line 1 at position 4",
      parse(".caf\xe9 { color: red; }") |> Result.get_error,
    )
  }),
  test_case("declaration list with invalid UTF-8 errors", `Quick, () => {
    switch (
      Driver.parse_declaration_list(
        ~source_position_start,
        "content: \"caf\xe9\"",
      )
    ) {
    | Error((loc, msg)) =>
      check(
        string,
        "reports invalid UTF-8",
        "This CSS is not valid UTF-8",
        msg,
      );
      check(int, "starts at the invalid byte", 13, loc.loc_start.pos_cnum);
      check(int, "spans a single byte", 14, loc.loc_end.pos_cnum);
    | Ok(_) => fail("expected invalid UTF-8 error")
    }
  }),
  test_case("declaration with invalid UTF-8 errors", `Quick, () => {
    switch (
      Driver.parse_declaration(
        ~source_position_start,
        "content: \"caf\xe9\";",
      )
    ) {
    | Error((_, msg)) =>
      check(
        string,
        "reports invalid UTF-8",
        "This CSS is not valid UTF-8",
        msg,
      )
    | Ok(_) => fail("expected invalid UTF-8 error")
    }
  }),
  test_case("keyframes with invalid UTF-8 errors", `Quick, () => {
    switch (
      Driver.parse_keyframes(
        ~source_position_start,
        "from { content: \"caf\xe9\" } to { opacity: 1 }",
      )
    ) {
    | Error((_, msg)) =>
      check(
        string,
        "reports invalid UTF-8",
        "This CSS is not valid UTF-8",
        msg,
      )
    | Ok(_) => fail("expected invalid UTF-8 error")
    }
  }),
];

let tests =
  List.concat([
    error_tests_data,
    nth_payload_tests_data,
    nth_error_tests_data,
    declaration_ast_tests,
    function_ast_tests,
    selector_combinator_ast_tests,
    ambiguity_regression_tests,
    invalid_utf8_tests,
  ]);
