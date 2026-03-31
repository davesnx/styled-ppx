open Css_grammar;
open Rule;
open! Data;
module Tokens = Styled_ppx_css_parser.Tokens;
open Styled_ppx_css_parser.Tokens;

module Ast = Styled_ppx_css_parser.Ast;

let loc = Ppxlib.Location.none;

let node_of_token =
  fun
  | COMMA => (Ast.Delim(Ast.Delimiter_comma), loc)
  | COLON => (Ast.Delim(Ast.Delimiter_colon), loc)
  | STRING(value) => (Ast.String(value), loc)
  | IDENT(value) => (Ast.Ident(value), loc)
  | NUMBER(value) => (Ast.Number(value), loc)
  | token => failwith("Unsupported test token: " ++ Tokens.show_token(token));

let nodes = tokens => List.map(node_of_token, tokens);

let delim = value => (Ast.Delim(value), loc);
let string = value => (Ast.String(value), loc);
let ident = value => (Ast.Ident(value), loc);

let data_monad_tests: tests = [
  test("return with an int", _ => {
    switch (return(Ok(1), nodes([COMMA]))) {
    | (Ok(1), values) when values == nodes([COMMA]) => ()
    | _ => Alcotest.fail("should be (Ok(1), [comma])")
    }
  }),
  test("return with more then one input node", _ => {
    switch (return(Ok(1), nodes([IDENT("decl"), COLON, IDENT("value")]))) {
    | (Ok(1), values) when values == nodes([IDENT("decl"), COLON, IDENT("value")]) => ()
    | _ => Alcotest.fail("should preserve remaining nodes")
    }
  }),
  test("return with a error list", _ => {
    switch (return(Error(["error"]), nodes([COLON]))) {
    | (Error(["error"]), values) when values == nodes([COLON]) => ()
    | _ => Alcotest.fail("Should be (Error([error]), [colon])")
    }
  }),
  test("data bind", _ => {
    let rule =
      bind(
        return(Ok(2)),
        fun
        | Ok(2) => return(Ok(3))
        | _ => Alcotest.fail("should be Ok(2)"),
      );
    switch (rule(nodes([COMMA]))) {
    | (Ok(3), values) when values == nodes([COMMA]) => ()
    | _ => Alcotest.fail("should be (Ok(3), [comma])")
    };
  }),
  test("data bind error", _ => {
    let rule =
      bind(
        return(Error([])),
        fun
        | Ok(_) => Alcotest.fail("should not be called")
        | Error(errs) => return(Error(["fix this", ...errs])),
      );

    switch (rule(nodes([COMMA]))) {
    | (Error(["fix this"]), values) when values == nodes([COMMA]) => ()
    | _ => Alcotest.fail("expected (Error([fix this]), [comma])")
    };
  }),
  test("data map", _ => {
    let rule =
      map(
        return(Ok(4)),
        fun
        | Ok(4) => Ok(5)
        | _ => Alcotest.fail("should be Ok(4)"),
      );
    switch (rule(nodes([COMMA]))) {
    | (Ok(5), values) when values == nodes([COMMA]) => ()
    | _ => Alcotest.fail("should be (Ok(5), [comma])")
    };
  }),
  test("data all", _ => {
    let rule4 = return(Ok(4));
    let rule5 = return(Ok(5));
    let rule = Match.all([rule4, rule5]);

    switch (rule(nodes([COMMA]))) {
    | (Ok(lst), values) when lst == [4, 5] && values == nodes([COMMA]) => ()
    | _ => Alcotest.fail("should be (Ok([4, 5]), [comma])")
    };
  }),
  test("data bind_shortest", _ => {
    let comma =
      fun
      | [value, ...values] when value == delim(Ast.Delimiter_comma) => (Ok(6), values)
      | values => (Error([""]), values);
    let two_comma =
      fun
      | [value1, value2, ...values]
          when value1 == delim(Ast.Delimiter_comma) && value2 == delim(Ast.Delimiter_comma) =>
        (Ok(7), values)
      | values => (Error([""]), values);

    let rule =
      bind_shortest(
        (two_comma, comma),
        fun
        | `Right(Ok(6)) => return(Ok(8))
        | _ => Alcotest.fail("should be Ok(6)"),
      );
    switch (rule(nodes([COMMA, COMMA]))) {
    | (Ok(8), values) when values == nodes([COMMA]) => ()
    | _ => Alcotest.fail("should be (Ok(8), [comma])")
    };
  }),
  test("data bind_longest", _ => {
    let comma =
      fun
      | [value, ...values] when value == delim(Ast.Delimiter_comma) => (Ok(9), values)
      | values => (Error([""]), values);
    let two_comma =
      fun
      | [value1, value2, ...values]
          when value1 == delim(Ast.Delimiter_comma) && value2 == delim(Ast.Delimiter_comma) =>
        (Ok(10), values)
      | values => (Error([""]), values);
    let rule =
      bind_longest(
        (two_comma, comma),
        fun
        | `Left(Ok(10)) => return(Ok(11))
        | _ => Alcotest.fail("should be Ok(10)"),
      );
    switch (rule(nodes([COMMA, COMMA]))) {
    | (Ok(11), []) => ()
    | _ => Alcotest.fail("should be (Ok(11), [])")
    };
  }),
];

open! Match;

let match_monad_tests: tests = [
  test("match return", _ => {
    switch (return(1, nodes([COMMA]))) {
    | (Ok(1), values) when values == nodes([COMMA]) => ()
    | _ => Alcotest.fail("should be (Ok(1), [comma])")
    }
  }),
  test("match bind", _ => {
    let rule =
      bind(
        return(Ok(2)),
        fun
        | Ok(2) => return(3)
        | _ => Alcotest.fail("should be Ok(2)"),
      );
    switch (rule(nodes([COMMA]))) {
    | (Ok(3), values) when values == nodes([COMMA]) => ()
    | _ => Alcotest.fail("should be (Ok(3), [comma])")
    };
  }),
  test("match map", _ => {
    let rule =
      map(
        return(Ok(4)),
        fun
        | Ok(4) => 5
        | _ => Alcotest.fail("should be Ok(4)"),
      );
    switch (rule(nodes([COMMA]))) {
    | (Ok(5), values) when values == nodes([COMMA]) => ()
    | _ => Alcotest.fail("should be (Ok(5), [comma])")
    };
  }),
];

open! Let;
open! Pattern;

let pattern_helpers_test: tests = [
  test("identity", _ => {
    switch (identity([string("tomato")])) {
    | (Ok(), [value]) when value == string("tomato") => ()
    | _ => Alcotest.fail("should preserve remaining component values")
    }
  }),
  test("component", _ => {
    let rule =
      component(
        fun
        | (Ast.String("potato"), _) => Ok(1)
        | _ => Error([""]),
      );
    switch (rule([string("potato")])) {
    | (Ok(1), []) => ()
    | _ => Alcotest.fail("should be (Ok(1), [])")
    };

    switch (rule([string("invalid")])) {
    | (Error(_), [value]) when value == string("invalid") => ()
    | _ => Alcotest.fail("should not consume invalid input")
    };
  }),
  test("expect_delim", _ => {
    let rule = {
      let.bind_match () = expect_delim(Ast.Delimiter_colon);
      Match.return(2);
    };
    switch (rule([delim(Ast.Delimiter_colon)])) {
    | (Ok(2), []) => ()
    | _ => Alcotest.fail("should be (Ok(2), [])")
    };
  }),
  test("value", _ => {
    let rule = value(3, expect_delim(Ast.Delimiter_comma));
    switch (rule([delim(Ast.Delimiter_comma)])) {
    | (Ok(3), []) => ()
    | _ => Alcotest.fail("should be (Ok(3), [])")
    };
  }),
  test("next", _ => {
    switch (Pattern.next([delim(Ast.Delimiter_comma), delim(Ast.Delimiter_colon)])) {
    | (Ok(value), [remaining]) when value == delim(Ast.Delimiter_comma) && remaining == delim(Ast.Delimiter_colon) => ()
    | _ => Alcotest.fail("should be (Ok(comma), [colon])")
    }
  }),
  test("next with no input", _ => {
    switch (Pattern.next([])) {
    | (Error(["Unexpected end of input."]), []) => ()
    | _ => Alcotest.fail("should be (Error([Unexpected end of input.]), [])")
    }
  }),
];

let rule_tests: tests = [
  test("Rule using expect_delim", _ => {
    let input = [ident("decl"), delim(Ast.Delimiter_colon), ident("value")];

    let rule = {
      let.bind_match decl =
        Pattern.component(
          fun
          | (Ast.Ident("decl"), _) => Ok("decl")
          | _ => Error(["Expected an Ident"]),
        );
      let.bind_match () = Pattern.expect_delim(Ast.Delimiter_colon);

      let.bind_match value =
        Pattern.component(
          fun
          | (Ast.Ident("value"), _) => Ok("value")
          | _ => Error(["Expected a valid value"]),
        );
      Match.return(`Declaration((decl, value)));
    };

    switch (rule(input)) {
    | (Ok(`Declaration("decl", "value")), []) => ()
    | _ => Alcotest.fail("nah")
    };
  }),
];

let tests: tests =
  List.flatten([data_monad_tests, match_monad_tests, pattern_helpers_test, rule_tests]);
