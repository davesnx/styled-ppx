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

let nth_payload_tests_data =
  [
    ("li:nth-child(2n+1) { color: red; }", Ast.ANB(2, "+", 1)),
    ("li:nth-child(-n+6) { color: red; }", Ast.ANB(-1, "+", 6)),
    ("li:nth-child(3n-6) { color: red; }", Ast.ANB(3, "-", 6)),
    /* Preserve b from "n-<digits>" idents. */
    ("li:nth-child(n-3) { color: red; }", Ast.ANB(1, "-", 3)),
    ("li:nth-child(-n-3) { color: red; }", Ast.ANB(-1, "-", 3)),
    ("li:nth-child(2n- 3) { color: red; }", Ast.ANB(2, "-", 3)),
    ("li:nth-child(n- 3) { color: red; }", Ast.ANB(1, "-", 3)),
    /* "n", "odd", and "even" are ASCII-case-insensitive. */
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

/* Invalid An+B regression cases return located parse errors. */
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
    (
      "li:nth-child(3n-0x10) { color: red; }",
      "Invalid an+b value in :nth-child() on line 1 at position 13",
    ),
    (
      "li:nth-child(3n-1_0) { color: red; }",
      "Invalid an+b value in :nth-child() on line 1 at position 13",
    ),
    /* "an-" requires a signless integer after it. */
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
  test_case(
    "declaration parses signed-fraction dimension without crashing", `Quick, () => {
    switch (
      Driver.parse_declaration(
        ~source_position_start,
        "transition:opacity .3s ease -.1s;",
      )
    ) {
    | Ok({
        value:
          (
            [
              (Ast.Ident("opacity"), _),
              (Ast.Whitespace, _),
              (
                Ast.Dimension({
                  value: positive_value,
                  unit: "s",
                  kind: Ast.Dimension_time(Ast.Time_unit_s),
                }),
                _,
              ),
              (Ast.Whitespace, _),
              (Ast.Ident("ease"), _),
              (Ast.Whitespace, _),
              (
                Ast.Dimension({
                  value: negative_value,
                  unit: "s",
                  kind: Ast.Dimension_time(Ast.Time_unit_s),
                }),
                _,
              ),
            ],
            _,
          ),
        _,
      }) =>
      check(bool, "preserves .3s", true, positive_value == 0.3);
      check(bool, "preserves -.1s", true, negative_value == (-0.1));
    | Ok(_) => fail("unexpected declaration AST shape")
    | Error((_, msg)) => fail("expected declaration parse success: " ++ msg)
    }
  }),
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

let functional_selector_ast_tests = [
  test_case("::part() parses as a functional pseudo-element", `Quick, () => {
    switch (Driver.parse_stylesheet(~source_position_start, "::part(foo) {}")) {
    | Ok(([Ast.Style_rule({ prelude: ([(selector, _)], _), _ })], _)) =>
      switch (selector) {
      | Ast.ComplexSelector(
          Ast.Selector(
            Ast.CompoundSelector({
              pseudo_selectors:
                [
                  Ast.PseudoelementFunction({
                    name: "part",
                    payload:
                      (
                        [
                          (
                            Ast.RelativeSelector({
                              combinator: None,
                              complex_selector:
                                Ast.Selector(
                                  Ast.SimpleSelector(Ast.Type("foo")),
                                ),
                            }),
                            _,
                          ),
                        ],
                        _,
                      ),
                  }),
                ],
              _,
            }),
          ),
        ) =>
        ()
      | _ => fail("expected functional pseudo-element AST")
      }
    | _ => fail("expected functional pseudo-element AST")
    }
  }),
  test_case(
    ":nth-child(An+B of S) parses the selector list alongside An+B", `Quick, () => {
    switch (
      Driver.parse_stylesheet(
        ~source_position_start,
        "li:nth-child(2n+1 of .x) {}",
      )
    ) {
    | Ok(([Ast.Style_rule({ prelude: ([(selector, _)], _), _ })], _)) =>
      switch (selector) {
      | Ast.ComplexSelector(
          Ast.Selector(
            Ast.CompoundSelector({
              subclass_selectors:
                [
                  Ast.Pseudo_class(
                    Ast.Pseudoclass(
                      Ast.NthFunction({
                        payload:
                          (
                            Ast.NthSelector({
                              nth: Ast.ANB(2, "+", 1),
                              selectors: [Ast.Selector(_)],
                            }),
                            _,
                          ),
                        _,
                      }),
                    ),
                  ),
                ],
              _,
            }),
          ),
        ) =>
        ()
      | _ => fail("expected nth-of-selector-list AST")
      }
    | _ => fail("expected nth-of-selector-list AST")
    }
  }),
];

let at_rule_dispatch_tests = [
  test_case("@layer comma list parses as a statement at-rule", `Quick, () => {
    switch (Driver.parse_stylesheet(~source_position_start, "@layer a, b;")) {
    | Ok(([Ast.At_rule({ name: ("layer", _), block: Ast.Empty, _ })], _)) =>
      ()
    | Ok(_) => fail("expected a single blockless @layer at-rule")
    | Error((_, msg)) => fail("expected @layer a, b; to parse: " ++ msg)
    }
  }),
  test_case("@layer single name parses as a statement at-rule", `Quick, () => {
    switch (Driver.parse_stylesheet(~source_position_start, "@layer base;")) {
    | Ok(([Ast.At_rule({ name: ("layer", _), block: Ast.Empty, _ })], _)) =>
      ()
    | Ok(_) => fail("expected a single blockless @layer at-rule")
    | Error((_, msg)) => fail("expected @layer base; to parse: " ++ msg)
    }
  }),
  test_case("@layer block form still parses as a block at-rule", `Quick, () => {
    switch (
      Driver.parse_stylesheet(
        ~source_position_start,
        "@layer base { .a { color: red } }",
      )
    ) {
    | Ok((
        [Ast.At_rule({ name: ("layer", _), block: Ast.Stylesheet(_), _ })],
        _,
      )) =>
      ()
    | Ok(_) => fail("expected a single block @layer at-rule")
    | Error((_, msg)) =>
      fail("expected @layer base { ... } to parse: " ++ msg)
    }
  }),
  test_case("@import url() still parses as a statement at-rule", `Quick, () => {
    switch (
      Driver.parse_stylesheet(
        ~source_position_start,
        {|@import url("x.css");|},
      )
    ) {
    | Ok(([Ast.At_rule({ name: ("import", _), block: Ast.Empty, _ })], _)) =>
      ()
    | Ok(_) => fail("expected a single blockless @import at-rule")
    | Error((_, msg)) => fail("expected @import url(...); to parse: " ++ msg)
    }
  }),
  test_case(
    "@import with layer()/supports() prelude still parses as a statement at-rule",
    `Quick,
    () => {
    switch (
      Driver.parse_stylesheet(
        ~source_position_start,
        {|@import "x.css" layer(base) supports(display: grid);|},
      )
    ) {
    | Ok(([Ast.At_rule({ name: ("import", _), block: Ast.Empty, _ })], _)) =>
      ()
    | Ok(_) => fail("expected a single blockless @import at-rule")
    | Error((_, msg)) =>
      fail("expected @import with layer()/supports() to parse: " ++ msg)
    }
  }),
  test_case("@namespace still parses as a statement at-rule", `Quick, () => {
    switch (
      Driver.parse_stylesheet(
        ~source_position_start,
        "@namespace svg url(http://www.w3.org/2000/svg);",
      )
    ) {
    | Ok((
        [Ast.At_rule({ name: ("namespace", _), block: Ast.Empty, _ })],
        _,
      )) =>
      ()
    | Ok(_) => fail("expected a single blockless @namespace at-rule")
    | Error((_, msg)) => fail("expected @namespace to parse: " ++ msg)
    }
  }),
  test_case("@charset still parses as a statement at-rule", `Quick, () => {
    switch (
      Driver.parse_stylesheet(~source_position_start, {|@charset "utf-8";|})
    ) {
    | Ok(([Ast.At_rule({ name: ("charset", _), block: Ast.Empty, _ })], _)) =>
      ()
    | Ok(_) => fail("expected a single blockless @charset at-rule")
    | Error((_, msg)) => fail("expected @charset to parse: " ++ msg)
    }
  }),
  test_case("@media block form still parses as a block at-rule", `Quick, () => {
    switch (
      Driver.parse_stylesheet(
        ~source_position_start,
        "@media (min-width: 1px) { .a { color: red } }",
      )
    ) {
    | Ok((
        [Ast.At_rule({ name: ("media", _), block: Ast.Stylesheet(_), _ })],
        _,
      )) =>
      ()
    | Ok(_) => fail("expected a single block @media at-rule")
    | Error((_, msg)) =>
      fail("expected @media (min-width: 1px) { ... } to parse: " ++ msg)
    }
  }),
  test_case(
    "@font-face block form still parses as a block at-rule", `Quick, () => {
    switch (
      Driver.parse_stylesheet(
        ~source_position_start,
        "@font-face { font-family: X; }",
      )
    ) {
    | Ok((
        [
          Ast.At_rule({
            name: ("font-face", _),
            block: Ast.Stylesheet(_),
            _,
          }),
        ],
        _,
      )) =>
      ()
    | Ok(_) => fail("expected a single block @font-face at-rule")
    | Error((_, msg)) =>
      fail("expected @font-face { ... } to parse: " ++ msg)
    }
  }),
];

let parse_nested_relative_selector_exn = input => {
  switch (Driver.parse_declaration_list(~source_position_start, input)) {
  | Ok((
      [
        Ast.Style_rule({
          block:
            ([Ast.Style_rule({ prelude: ([(selector, _)], _), _ })], _),
          _,
        }),
      ],
      _,
    )) => selector
  | Ok(_) => fail("expected a single nested style rule for: " ++ input)
  | Error((_, msg)) =>
    fail(
      "expected nested relative selector parse success for "
      ++ input
      ++ ": "
      ++ msg,
    )
  };
};

let nested_relative_selector_combinator_tests =
  [
    (".parent { > .child { color: red; } }", Ast.Selector_child),
    (".parent { + .child { color: red; } }", Ast.Selector_adjacent_sibling),
    (".parent { ~ .child { color: red; } }", Ast.Selector_general_sibling),
  ]
  |> List.map(((input, expected_combinator)) =>
       test_case(
         "nested rule accepts leading combinator: " ++ input, `Quick, () => {
         switch (parse_nested_relative_selector_exn(input)) {
         | Ast.RelativeSelector({
             combinator: Some(actual_combinator),
             complex_selector:
               Ast.Selector(
                 Ast.CompoundSelector({
                   type_selector: None,
                   subclass_selectors: [Ast.Class("child")],
                   pseudo_selectors: [],
                 }),
               ),
           }) =>
           check(
             bool,
             "combinator matches",
             true,
             actual_combinator == expected_combinator,
           )
         | _ => fail("expected RelativeSelector AST for: " ++ input)
         }
       })
     );

let nested_relative_selector_tests =
  nested_relative_selector_combinator_tests
  @ [
    test_case(
      "nested rule accepts a compound selector after the combinator (`> .a.b:hover`)",
      `Quick,
      () => {
      switch (
        parse_nested_relative_selector_exn(
          ".parent { > .a.b:hover { color: red; } }",
        )
      ) {
      | Ast.RelativeSelector({
          combinator: Some(Ast.Selector_child),
          complex_selector:
            Ast.Selector(
              Ast.CompoundSelector({
                type_selector: None,
                subclass_selectors:
                  [
                    Ast.Class("a"),
                    Ast.Class("b"),
                    Ast.Pseudo_class(
                      Ast.Pseudoclass(Ast.PseudoIdent("hover")),
                    ),
                  ],
                pseudo_selectors: [],
              }),
            ),
        }) =>
        ()
      | _ => fail("expected compound relative selector AST")
      }
    }),
    test_case(
      "nested rule accepts a relative selector list (`> .a, + .b`)", `Quick, () => {
      switch (
        Driver.parse_declaration_list(
          ~source_position_start,
          ".parent { > .a, + .b { color: red; } }",
        )
      ) {
      | Ok((
          [
            Ast.Style_rule({
              block:
                (
                  [
                    Ast.Style_rule({
                      prelude:
                        (
                          [
                            (
                              Ast.RelativeSelector({
                                combinator: first_combinator,
                                _,
                              }),
                              _,
                            ),
                            (
                              Ast.RelativeSelector({
                                combinator: second_combinator,
                                _,
                              }),
                              _,
                            ),
                          ],
                          _,
                        ),
                      _,
                    }),
                  ],
                  _,
                ),
              _,
            }),
          ],
          _,
        )) =>
        check(
          bool,
          "first item is `>`",
          true,
          first_combinator == Some(Ast.Selector_child),
        );
        check(
          bool,
          "second item is `+`",
          true,
          second_combinator == Some(Ast.Selector_adjacent_sibling),
        );
      | Ok(_) => fail("expected two relative selectors")
      | Error((_, msg)) =>
        fail("expected relative selector list parse success: " ++ msg)
      }
    }),
    test_case(
      "nested rule accepts a leading combinator inside @media", `Quick, () => {
      switch (
        Driver.parse_declaration_list(
          ~source_position_start,
          "@media (min-width: 1px) { > .a { color: red; } }",
        )
      ) {
      | Ok((
          [
            Ast.At_rule({
              name: ("media", _),
              block:
                Ast.Stylesheet((
                  [
                    Ast.Style_rule({
                      prelude:
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
                      _,
                    }),
                  ],
                  _,
                )),
              _,
            }),
          ],
          _,
        )) =>
        ()
      | Ok(_) => fail("expected relative selector nested inside @media")
      | Error((_, msg)) =>
        fail(
          "expected @media nested relative selector parse success: " ++ msg,
        )
      }
    }),
    test_case(
      "declaration-list root still rejects a leading combinator", `Quick, () => {
      switch (
        Driver.parse_declaration_list(
          ~source_position_start,
          "> .a { color: red; }",
        )
      ) {
      | Error((loc, msg)) =>
        check(
          string,
          "existing parse error message preserved",
          "Parse error while reading token '>'",
          msg,
        );
        check(
          int,
          "error points at the leading combinator",
          0,
          loc.loc_start.pos_cnum,
        );
      | Ok(_) =>
        fail("expected a leading top-level combinator to still error")
      }
    }),
    test_case(
      "stylesheet level still rejects a leading combinator", `Quick, () => {
      check(
        string,
        "existing parse error message preserved",
        "Parse error while reading token '>' on line 1 at position 0",
        parse("> .a {}") |> Result.get_error,
      )
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

/* Malformed UTF-8 is reported at the offending byte. */
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
    functional_selector_ast_tests,
    at_rule_dispatch_tests,
    nested_relative_selector_tests,
    ambiguity_regression_tests,
    invalid_utf8_tests,
  ]);
