open Css_property_parser;
open Rule;
open! Data;
open Styled_ppx_css_parser.Tokens;

let data_monad_tests: tests = [
  // TODO: check static order
  test("return with an int", _ => {
    switch (return(Ok(1), [COMMA])) {
    | (Ok(1), [COMMA]) => ()
    | _ => Alcotest.fail("should be (Ok(1), [COMMA])")
    }
  }),
  test("return with a polymorphic variant", _ => {
    switch (return(Ok(`Comma), [COMMA])) {
    | (Ok(`Comma), [COMMA]) => ()
    | _ => Alcotest.fail("Should be (Ok(`Comma), [COMMA])")
    }
  }),
  test("return with a string", _ => {
    switch (return(Ok(","), [COMMA])) {
    | (Ok(","), [COMMA]) => ()
    | _ => Alcotest.fail("Should be (Ok(,), [COMMA])")
    }
  }),
  test("return with more then one token as inputs", _ => {
    switch (return(Ok(1), [IDENT("decl"), COLON, IDENT("value")])) {
    | (Ok(1), [IDENT("decl"), COLON, IDENT("value")]) => ()
    | _ =>
      Alcotest.fail(
        "Should be Ok(1), [IDENT(\"decl\"), COLON, IDENT(\"value\")]",
      )
    }
  }),
  test("return with a error list", _ => {
    switch (return(Error(["error"]), [COLON])) {
    | (Error(["error"]), [COLON]) => ()
    | _ => Alcotest.fail("Should be (Error([error], [COLON]))")
    }
  }),
  test("bind", _ => {
    let rule =
      bind(
        return(Ok(2)),
        fun
        | Ok(2) => return(Ok(3))
        | _ => Alcotest.fail("should be Ok(2)"),
      );
    switch (rule([COMMA])) {
    | (Ok(3), [COMMA]) => ()
    | _ => Alcotest.fail("should be (Ok(3), [COMMA])")
    };
  }),
  test("bind error", _ => {
    let rule =
      bind(
        return(Error([])),
        fun
        | Ok(_) => Alcotest.fail("should not be called")
        | Error(errs) => return(Error(["fix this", ...errs])),
      );

    switch (rule([COMMA])) {
    | (Error(["fix this"]), [COMMA]) => ()
    | _ => Alcotest.fail("expected (Error([fix this]), [COMMA])")
    };
  }),
  test("map", _ => {
    let rule =
      map(
        return(Ok(4)),
        fun
        | Ok(4) => Ok(5)
        | _ => Alcotest.fail("should be Ok(4)"),
      );
    switch (rule([COMMA])) {
    | (Ok(5), [COMMA]) => ()
    | _ => Alcotest.fail("should be (Ok(5), [COMMA])")
    };
  }),
  test("map error", _ => {
    let rule =
      map(
        return(Error([])),
        fun
        | Error(errs) => Error(["new error", ...errs])
        | Ok(_) => Alcotest.fail("should be unreachable"),
      );

    switch (rule([COMMA])) {
    | (Error(["new error", ..._]), [COMMA]) => ()
    | _ => Alcotest.fail("expected (Error([new error, ...], [COMMA])")
    };
  }),
  test("all", _ => {
    let rule4 = return(Ok(4));
    let rule5 = return(Ok(5));
    let rule = Match.all([rule4, rule5]);

    switch (rule([COMMA])) {
    | (Ok(lst), [COMMA]) when lst == [4, 5] => ()
    | _ => Alcotest.fail("should be (Ok(5), [COMMA])")
    };

    let rule_err = return(Error(["Missing COMMA"]));
    let rule = Match.all([rule_err, rule4, rule5]);
    switch (rule([COMMA])) {
    | (Error(["Missing COMMA"]), [COMMA]) => ()
    | _ => Alcotest.fail("should be (Error(Missing Comma), [COMMA])")
    };
  }),
  test("all with error in the beginning", _ => {
    let rule4 = return(Ok(4));
    let rule5 = return(Ok(5));
    let rule_err = return(Error(["Missing COMMA"]));
    let rule = Match.all([rule_err, rule4, rule5]);
    switch (rule([COMMA])) {
    | (Error(["Missing COMMA"]), [COMMA]) => ()
    | _ => Alcotest.fail("should be (Error(Missing Comma), [COMMA])")
    };
  }),
  test("all with error in the end", _ => {
    let rule4 = return(Ok(4));
    let rule5 = return(Ok(5));
    let rule_err = return(Error(["Missing COMMA"]));
    let rule = Match.all([rule4, rule5, rule_err]);
    switch (rule([COMMA])) {
    | (Error(["Missing COMMA"]), [COMMA]) => ()
    | _ => Alcotest.fail("should be (Error(Missing Comma), [COMMA])")
    };
  }),
  test("all with multiple errors", _ => {
    let rule4 = return(Ok(4));
    let rule5 = return(Ok(5));
    let rule_err = return(Error(["Missing COMMA"]));
    let rule_err2 = return(Error(["Unexpected token"]));
    let rule_err3 = return(Error(["Unclosed string"]));
    let rule = Match.all([rule_err, rule4, rule_err2, rule5, rule_err3]);
    switch (rule([COMMA])) {
    | (Error(["Missing COMMA"]), [COMMA]) => ()
    | _ => Alcotest.fail("should be (Error(Missing Comma), [COMMA])")
    };
  }),
  test("bind_shortest", _ => {
    let comma =
      fun
      | [COMMA, ...tokens] => (Ok(6), tokens)
      | tokens => (Error([""]), tokens);
    let two_comma =
      fun
      | [COMMA, COMMA, ...tokens] => (Ok(7), tokens)
      | tokens => (Error([""]), tokens);

    let rule =
      bind_shortest(
        (two_comma, comma),
        fun
        | `Right(Ok(6)) => return(Ok(8))
        | _ => Alcotest.fail("should be Ok(6)"),
      );
    switch (rule([COMMA, COMMA])) {
    | (Ok(8), [COMMA]) => ()
    | _ => Alcotest.fail("should be (Ok(8), [COMMA])")
    };

    let rule =
      bind_shortest(
        (comma, two_comma),
        fun
        | `Left(Ok(6)) => return(Ok(8))
        | _ => Alcotest.fail("should be Ok(6)"),
      );

    switch (rule([COMMA, COMMA])) {
    | (Ok(8), [COMMA]) => ()
    | _ => Alcotest.fail("should be (Ok(8), [COMMA])")
    };
  }),
  test("bind_longest", _ => {
    let comma =
      fun
      | [COMMA, ...tokens] => (Ok(9), tokens)
      | tokens => (Error([""]), tokens);
    let two_comma =
      fun
      | [COMMA, COMMA, ...tokens] => (Ok(10), tokens)
      | tokens => (Error([""]), tokens);
    let () = {
      let rule =
        bind_longest(
          (two_comma, comma),
          fun
          | `Left(Ok(10)) => return(Ok(11))
          | _ => Alcotest.fail("should be Ok(10)"),
        );
      switch (rule([COMMA, COMMA])) {
      | (Ok(11), []) => ()
      | _ => Alcotest.fail("should be (Ok(10), [])")
      };
    };

    let rule =
      bind_longest(
        (comma, two_comma),
        fun
        | `Right(Ok(10)) => return(Ok(11))
        | _ => Alcotest.fail("should be Ok(10)"),
      );

    switch (rule([COMMA, COMMA])) {
    | (Ok(11), []) => ()
    | _ => Alcotest.fail("should be (Ok(10), [])")
    };
  }),
];

open! Match;

let match_monad_tests: tests = [
  // TODO: check static order
  test("return", _ => {
    switch (return(1, [COMMA])) {
    | (Ok(1), [COMMA]) => ()
    | _ => Alcotest.fail("should be (Ok(1), [COMMA])")
    }
  }),
  test("bind", _ => {
    let rule =
      bind(
        return(Ok(2)),
        fun
        | Ok(2) => return(3)
        | _ => Alcotest.fail("should be Ok(2)"),
      );
    switch (rule([COMMA])) {
    | (Ok(3), [COMMA]) => ()
    | _ => Alcotest.fail("should be (Ok(3), [COMMA])")
    };
  }),
  test("bind Error", _ => {
    let rule =
      bind(
        Data.return(Error(["error message"])),
        fun
        | _ => Alcotest.fail("Should not be reachable"),
      );

    switch (rule([COMMA])) {
    | (Error(["error message"]), [COMMA]) => ()
    | _ => Alcotest.fail("expected (Error([error message], [COMMA])) ")
    };
  }),
  test("map", _ => {
    let rule =
      map(
        return(Ok(4)),
        fun
        | Ok(4) => 5
        | _ => Alcotest.fail("should be Ok(4)"),
      );
    switch (rule([COMMA])) {
    | (Ok(5), [COMMA]) => ()
    | _ => Alcotest.fail("should be (Ok(5), [COMMA])")
    };
  }),
  test("bind_shortest", _ => {
    let comma =
      fun
      | [COMMA, ...tokens] => (Ok(6), tokens)
      | tokens => (Error([""]), tokens);
    let two_comma =
      fun
      | [COMMA, COMMA, ...tokens] => (Ok(7), tokens)
      | tokens => (Error([""]), tokens);
    let () = {
      let rule =
        bind_shortest(
          (two_comma, comma),
          fun
          | `Right(6) => return(8)
          | _ => Alcotest.fail("should be `Right(6)"),
        );
      switch (rule([COMMA, COMMA])) {
      | (Ok(8), [COMMA]) => ()
      | _ => Alcotest.fail("should be (Ok(8), [COMMA])")
      };
    };
    let () = {
      let rule =
        bind_shortest(
          (comma, two_comma),
          fun
          | `Left(6) => return(8)
          | _ => Alcotest.fail("should be `Left(6)"),
        );
      switch (rule([COMMA, COMMA])) {
      | (Ok(8), [COMMA]) => ()
      | _ => Alcotest.fail("should be (Ok(8), [COMMA])")
      };
    };
    ();
  }),
  test("bind_longest", _ => {
    let comma =
      fun
      | [COMMA, ...tokens] => (Ok(9), tokens)
      | tokens => (Error([""]), tokens);
    let two_comma =
      fun
      | [COMMA, COMMA, ...tokens] => (Ok(10), tokens)
      | tokens => (Error([""]), tokens);
    let () = {
      let rule =
        bind_longest(
          (two_comma, comma),
          fun
          | `Left(10) => return(11)
          | _ => Alcotest.fail("should be `Left(10)"),
        );
      switch (rule([COMMA, COMMA])) {
      | (Ok(11), []) => ()
      | _ => Alcotest.fail("should be (Ok(10), [])")
      };
    };
    let () = {
      let rule =
        bind_longest(
          (comma, two_comma),
          fun
          | `Right(10) => return(11)
          | _ => Alcotest.fail("should be `Right(10)"),
        );
      switch (rule([COMMA, COMMA])) {
      | (Ok(11), []) => ()
      | _ => Alcotest.fail("should be (Ok(10), [])")
      };
    };
    ();
  }),
];

open! Let;
open! Pattern;

let pattern_helpers_test: tests = [
  test("identity", _ => {
    switch (identity([STRING("tomato")])) {
    | (Ok (), [STRING("tomato")]) => ()
    | _ => Alcotest.fail({|should be (Ok(), [STRING("TOMATO")]|})
    }
  }),
  test("token", _ => {
    let rule =
      token(
        fun
        | STRING("potato") => Ok(1)
        | _ => Error([""]),
      );
    switch (rule([STRING("potato")])) {
    | (Ok(1), []) => ()
    | _ => Alcotest.fail("should be (Ok(1), [])")
    };

    // shouldn't consume tokens
    switch (rule([STRING("invalid")])) {
    | (Error(_), [STRING("invalid")]) => ()
    | _ => Alcotest.fail({|should be (Error(_), [STRING("invalid")])|})
    };
  }),
  test("expect", _ => {
    let rule = {
      let.bind_match () = expect(STRING("auto"));
      Match.return(2);
    };
    switch (rule([STRING("auto")])) {
    | (Ok(2), []) => ()
    | _ => Alcotest.fail("should be (Ok(2), [])")
    };

    // shouldn't consume tokens
    switch (rule([STRING("invalid")])) {
    | (Error(_), [STRING("invalid")]) => ()
    | _ => Alcotest.fail({|should be (Error(_), [STRING("invalid")])|})
    };
    ();
  }),
  test("value", _ => {
    let rule = value(3, expect(STRING("none")));
    switch (rule([STRING("none")])) {
    | (Ok(3), []) => ()
    | _ => Alcotest.fail("should be (Ok(3), [])")
    };
  }),
  test("next", _ => {
    switch (Pattern.next([COMMA, COLON])) {
    | (Ok(COMMA), [COLON]) => ()
    | _ => Alcotest.fail("should be (Ok(COMMA), [COLON])")
    }
  }),
  test("next with only token as input", _ => {
    switch (Pattern.next([COLON])) {
    | (Ok(COLON), []) => ()
    | _ => Alcotest.fail("should be (Ok(COLON), [])")
    }
  }),
  test("next with no tokens as input", _ => {
    switch (Pattern.next([])) {
    | (Error(["missing the token expected"]), []) => ()
    | _ =>
      Alcotest.fail("should be (Error([missing the token expected]), [])")
    }
  }),
];

open Let;

let rule_tests: tests = [
  test("Rule using Pattern.expect", _ => {
    let input = [IDENT("decl"), COLON, IDENT("value")];

    let rule = {
      let.bind_match decl =
        Pattern.token(
          fun
          | IDENT("decl") => Ok("decl")
          | _ => Error(["Expected an Ident"]),
        );
      let.bind_match () = Pattern.expect(COLON);

      let.bind_match value =
        Pattern.token(
          fun
          | IDENT("value") => Ok("value")
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
  List.concat([
    data_monad_tests,
    rule_tests,
    pattern_helpers_test,
    rule_tests,
  ]);
