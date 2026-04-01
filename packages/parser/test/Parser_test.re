open Alcotest;

module Ast = Styled_ppx_css_parser.Ast;
module Driver = Styled_ppx_css_parser.Driver;
module Parser_location = Styled_ppx_css_parser.Parser_location;

let dummy_pos = Lexing.dummy_pos;
let loc = Parser_location.to_ppxlib_location(dummy_pos, dummy_pos);

let parse = input => {
  switch (Driver.parse_stylesheet(~loc, input)) {
  | Ok(ast) => Ok(ast)
  | Error((loc, msg)) =>
    let pos = loc.loc_start;
    let curr_pos = pos.pos_cnum;
    let lnum = pos.pos_lnum + 1;
    let pos_bol = pos.pos_bol;
    let err =
      Printf.sprintf(
        "%s on line %i at position %i",
        msg,
        lnum,
        curr_pos - pos_bol,
      );
    Error(err);
  };
};

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
  |> List.mapi((_index, (input, output)) => {
       let assertion = () =>
         check(
           string,
           "should error" ++ input,
           output,
           parse(input) |> Result.get_error,
         );

       test_case(input, `Quick, assertion);
     });

let declaration_ast_tests = [
  test_case("declaration preserves id-like hash kind", `Quick, () => {
    switch (Driver.parse_declaration(~loc, "color:#abc;")) {
    | Ok({ value: ([(Ast.Hash((value, kind)), _)], _), _ }) =>
      check(string, "preserves hash text", "abc", value);
      check(bool, "preserves id hash kind", true, kind == Ast.Hash_kind_id);
    | _ => fail("expected hash declaration AST")
    }
  }),
  test_case("declaration preserves unrestricted hash kind", `Quick, () => {
    switch (Driver.parse_declaration(~loc, "color:#2;")) {
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
    switch (Driver.parse_declaration(~loc, "color:calc(1px);")) {
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
    switch (Driver.parse_declaration(~loc, "color:nth-child(2n+1);")) {
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
    switch (Driver.parse_stylesheet(~loc, "a > b {}")) {
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
    switch (Driver.parse_stylesheet(~loc, "a b {}")) {
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
    switch (Driver.parse_stylesheet(~loc, "div:has(> span) {}")) {
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

let tests =
  List.concat([
    error_tests_data,
    declaration_ast_tests,
    function_ast_tests,
    selector_combinator_ast_tests,
  ]);
