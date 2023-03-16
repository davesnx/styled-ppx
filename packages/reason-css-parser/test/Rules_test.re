open Alcotest;
open Reason_css_parser;
open Reason_css_lexer;
open Rule;

open! Data;
let data_monad_tests: list(Alcotest.test_case(unit)) = [
  // TODO: check static order
  test_case("return with an int", `Quick, _ => {
    switch (return(Ok(1), [COMMA])) {
    | (Ok(1), [COMMA]) => ()
    | _ => fail("should be (Ok(1), [COMMA])")
    }
  }),
  test_case("return with a polymorphic variant", `Quick, _ => {
    switch (return(Ok(`Comma), [COMMA])) {
    | (Ok(`Comma), [COMMA]) => ()
    | _ => fail("Should be (Ok(`Comma), [COMMA])")
    }
  }),
  test_case("return with a string", `Quick, _ => {
    switch (return(Ok(","), [COMMA])) {
    | (Ok(","), [COMMA]) => ()
    | _ => fail("Should be (Ok(,), [COMMA])")
    }
  }),
  test_case("return with more then one token as inputs", `Quick, _ => {
    switch (return(Ok(1), [IDENT("decl"), COLON, IDENT("value")])) {
    | (Ok(1), [IDENT("decl"), COLON, IDENT("value")]) => ()
    | _ => fail("Should be Ok(1), [IDENT(\"decl\"), COLON, IDENT(\"value\")]")
    }
  }),
  test_case("return with a error list", `Quick, _ => {
    switch (return(Error(["error"]), [COLON])) {
    | (Error(["error"]), [COLON]) => ()
    | _ => fail("Should be (Error([error], [COLON]))")
    }
  }),
  test_case(
    "bind",
    `Quick,
    _ => {
      let rule =
        bind(
          return(Ok(2)),
          fun
          | Ok(2) => return(Ok(3))
          | _ => fail("should be Ok(2)"),
        );
      switch (rule([COMMA])) {
      | (Ok(3), [COMMA]) => ()
      | _ => fail("should be (Ok(3), [COMMA])")
      };
    },
  ),
  test_case(
    "bind error",
    `Quick,
    _ => {
      let rule =
        bind(
          return(Error([])),
          fun
          | Ok(_) => fail("should not be called")
          | Error(errs) => return(Error(["fix this", ...errs])),
        );

      switch (rule([COMMA])) {
      | (Error(["fix this"]), [COMMA]) => ()
      | _ => fail("expected (Error([fix this]), [COMMA])")
      };
    },
  ),
  test_case(
    "map",
    `Quick,
    _ => {
      let rule =
        map(
          return(Ok(4)),
          fun
          | Ok(4) => Ok(5)
          | _ => fail("should be Ok(4)"),
        );
      switch (rule([COMMA])) {
      | (Ok(5), [COMMA]) => ()
      | _ => fail("should be (Ok(5), [COMMA])")
      };
    },
  ),
  test_case(
    "map error",
    `Quick,
    _ => {
      let rule =
        map(
          return(Error([])),
          fun
          | Error(errs) => Error(["new error", ...errs])
          | Ok(_) => fail("should be unreachable"),
        );

      switch (rule([COMMA])) {
      | (Error(["new error", ..._]), [COMMA]) => ()
      | _ => fail("expected (Error([new error, ...], [COMMA])")
      };
    },
  ),
  test_case(
    "all",
    `Quick,
    _ => {
      let rule4 = return(Ok(4));
      let rule5 = return(Ok(5));
      let rule = Match.all([rule4, rule5]);

      switch (rule([COMMA])) {
      | (Ok(lst), [COMMA]) when lst == [4, 5] => ()
      | _ => fail("should be (Ok(5), [COMMA])")
      };

      let rule_err = return(Error(["Missing COMMA"]));
      let rule = Match.all([rule_err, rule4, rule5]);
      switch (rule([COMMA])) {
      | (Error(["Missing COMMA"]), [COMMA]) => ()
      | _ => fail("should be (Error(Missing Comma), [COMMA])")
      };
    },
  ),
  test_case(
    "all with error in the beginning",
    `Quick,
    _ => {
      let rule4 = return(Ok(4));
      let rule5 = return(Ok(5));
      let rule_err = return(Error(["Missing COMMA"]));
      let rule = Match.all([rule_err, rule4, rule5]);
      switch (rule([COMMA])) {
      | (Error(["Missing COMMA"]), [COMMA]) => ()
      | _ => fail("should be (Error(Missing Comma), [COMMA])")
      };
    },
  ),
  test_case(
    "all with error in the end",
    `Quick,
    _ => {
      let rule4 = return(Ok(4));
      let rule5 = return(Ok(5));
      let rule_err = return(Error(["Missing COMMA"]));
      let rule = Match.all([rule4, rule5, rule_err]);
      switch (rule([COMMA])) {
      | (Error(["Missing COMMA"]), [COMMA]) => ()
      | _ => fail("should be (Error(Missing Comma), [COMMA])")
      };
    },
  ),
  test_case(
    "all with multiple errors",
    `Quick,
    _ => {
      let rule4 = return(Ok(4));
      let rule5 = return(Ok(5));
      let rule_err = return(Error(["Missing COMMA"]));
      let rule_err2 = return(Error(["Unexpected token"]));
      let rule_err3 = return(Error(["Unclosed string"]));
      let rule = Match.all([rule_err, rule4, rule_err2, rule5, rule_err3]);
      switch (rule([COMMA])) {
      | (Error(["Missing COMMA"]), [COMMA]) => ()
      | _ => fail("should be (Error(Missing Comma), [COMMA])")
      };
    },
  ),
  test_case(
    "bind_shortest",
    `Quick,
    _ => {
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
          | _ => fail("should be Ok(6)"),
        );
      switch (rule([COMMA, COMMA])) {
      | (Ok(8), [COMMA]) => ()
      | _ => fail("should be (Ok(8), [COMMA])")
      };

      let rule =
        bind_shortest(
          (comma, two_comma),
          fun
          | `Left(Ok(6)) => return(Ok(8))
          | _ => fail("should be Ok(6)"),
        );

      switch (rule([COMMA, COMMA])) {
      | (Ok(8), [COMMA]) => ()
      | _ => fail("should be (Ok(8), [COMMA])")
      };
    },
  ),
  test_case(
    "bind_longest",
    `Quick,
    _ => {
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
            | _ => fail("should be Ok(10)"),
          );
        switch (rule([COMMA, COMMA])) {
        | (Ok(11), []) => ()
        | _ => fail("should be (Ok(10), [])")
        };
      };

      let rule =
        bind_longest(
          (comma, two_comma),
          fun
          | `Right(Ok(10)) => return(Ok(11))
          | _ => fail("should be Ok(10)"),
        );

      switch (rule([COMMA, COMMA])) {
      | (Ok(11), []) => ()
      | _ => fail("should be (Ok(10), [])")
      };
    },
  ),
];

open! Match;

let match_monad_tests: list(Alcotest.test_case(unit)) = [
  // TODO: check static order
  test_case("return", `Quick, _ => {
    switch (return(1, [COMMA])) {
    | (Ok(1), [COMMA]) => ()
    | _ => fail("should be (Ok(123), [COMMA])")
    }
  }),
  test_case(
    "bind",
    `Quick,
    _ => {
      let rule =
        bind(
          return(Ok(2)),
          fun
          | Ok(2) => return(3)
          | _ => fail("should be Ok(2)"),
        );
      switch (rule([COMMA])) {
      | (Ok(3), [COMMA]) => ()
      | _ => fail("should be (Ok(3), [COMMA])")
      };
    },
  ),
  test_case(
    "bind Error",
    `Quick,
    _ => {
      let rule =
        bind(
          Data.return(Error(["error message"])),
          fun
          | _ => fail("Should not be reachable"),
        );

      switch (rule([COMMA])) {
      | (Error(["error message"]), [COMMA]) => ()
      | _ => fail("expected (Error([error message], [COMMA])) ")
      };
    },
  ),
  test_case(
    "map",
    `Quick,
    _ => {
      let rule =
        map(
          return(Ok(4)),
          fun
          | Ok(4) => 5
          | _ => fail("should be Ok(4)"),
        );
      switch (rule([COMMA])) {
      | (Ok(5), [COMMA]) => ()
      | _ => fail("should be (Ok(5), [COMMA])")
      };
    },
  ),
  test_case(
    "bind_shortest",
    `Quick,
    _ => {
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
            | _ => fail("should be `Right(6)"),
          );
        switch (rule([COMMA, COMMA])) {
        | (Ok(8), [COMMA]) => ()
        | _ => fail("should be (Ok(8), [COMMA])")
        };
      };
      let () = {
        let rule =
          bind_shortest(
            (comma, two_comma),
            fun
            | `Left(6) => return(8)
            | _ => fail("should be `Left(6)"),
          );
        switch (rule([COMMA, COMMA])) {
        | (Ok(8), [COMMA]) => ()
        | _ => fail("should be (Ok(8), [COMMA])")
        };
      };
      ();
    },
  ),
  test_case(
    "bind_longest",
    `Quick,
    _ => {
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
            | _ => fail("should be `Left(10)"),
          );
        switch (rule([COMMA, COMMA])) {
        | (Ok(11), []) => ()
        | _ => fail("should be (Ok(10), [])")
        };
      };
      let () = {
        let rule =
          bind_longest(
            (comma, two_comma),
            fun
            | `Right(10) => return(11)
            | _ => fail("should be `Right(10)"),
          );
        switch (rule([COMMA, COMMA])) {
        | (Ok(11), []) => ()
        | _ => fail("should be (Ok(10), [])")
        };
      };
      ();
    },
  ),
];

open! Let;
open! Pattern;

let pattern_helpers_test: list(Alcotest.test_case(unit)) = [
  test_case("identity", `Quick, _ => {
    switch (identity([STRING("tomato")])) {
    | (Ok (), [STRING("tomato")]) => ()
    | _ => fail({|should be (Ok(), [STRING("TOMATO")]|})
    }
  }),
  test_case(
    "token",
    `Quick,
    _ => {
      let rule =
        token(
          fun
          | STRING("potato") => Ok(1)
          | _ => Error([""]),
        );
      switch (rule([STRING("potato")])) {
      | (Ok(1), []) => ()
      | _ => fail("should be (Ok(1), [])")
      };

      // shouldn't consume tokens
      switch (rule([STRING("invalid")])) {
      | (Error(_), [STRING("invalid")]) => ()
      | _ => fail({|should be (Error(_), [STRING("invalid")])|})
      };
    },
  ),
  test_case(
    "expect",
    `Quick,
    _ => {
      let rule = {
        let.bind_match () = expect(STRING("auto"));
        Match.return(2);
      };
      switch (rule([STRING("auto")])) {
      | (Ok(2), []) => ()
      | _ => fail("should be (Ok(2), [])")
      };

      // shouldn't consume tokens
      switch (rule([STRING("invalid")])) {
      | (Error(_), [STRING("invalid")]) => ()
      | _ => fail({|should be (Error(_), [STRING("invalid")])|})
      };
      ();
    },
  ),
  test_case(
    "value",
    `Quick,
    _ => {
      let rule = value(3, expect(STRING("none")));
      switch (rule([STRING("none")])) {
      | (Ok(3), []) => ()
      | _ => fail("should be (Ok(3), [])")
      };
    },
  ),
  test_case("next", `Quick, _ => {
    switch (Pattern.next([COMMA, COLON])) {
    | (Ok(COMMA), [COLON]) => ()
    | _ => fail("should be (Ok(COMMA), [COLON])")
    }
  }),
  test_case("next with only token as input", `Quick, _ => {
    switch (Pattern.next([COLON])) {
    | (Ok(COLON), []) => ()
    | _ => fail("should be (Ok(COLON), [])")
    }
  }),
  test_case("next with no tokens as input", `Quick, _ => {
    switch (Pattern.next([])) {
    | (Error(["missing the token expected"]), []) => ()
    | _ => fail("should be (Error([missing the token expected]), [])")
    }
  }),
];

open Let;

let rule_tests: list(Alcotest.test_case(unit)) = [
  test_case(
    "Rule using Pattern.expect",
    `Quick,
    _ => {
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
      | _ => fail("nah")
      };
    },
  ),
  test_case(
    "Rule using Pattern.next",
    `Quick,
    _ => {
      let right_input = [
        CDO,
        IDENT("its"),
        IDENT("a"),
        IDENT("a comment"),
        CDC,
      ];
      let non_comment = [IDENT("not"), IDENT("a"), IDENT("comment")];
      let unclosed_comment = [
        CDO,
        IDENT("its"),
        IDENT("a"),
        IDENT("comment"),
      ];

      let comment_rule = {
        let.bind_match () =
          Pattern.token(
            fun
            | CDO => Ok()
            | _ => Error(["Comment should start with a CDO token"]),
          );

        let consume_comments = tokens => {
          let rec consume = (tokens, acc) => {
            switch (Pattern.next(tokens)) {
            | (Ok(CDC), rest) =>
              Match.return(`Comment(List.rev(acc)), rest)
            | (Ok(token), rest) => consume(rest, [token, ...acc])
            | (Error(_), rest) =>
              Data.return(Error(["Unclosed comment"]), rest)
            };
          };
          consume(tokens, []);
        };

        consume_comments;
      };

      switch (comment_rule(right_input)) {
      | (Ok(`Comment([IDENT("its"), IDENT("a"), IDENT("a comment")])), []) =>
        ()
      | _ => fail("`Comment([IDENT(its), IDENT(a), IDENT(comment)])), []")
      };

      switch (comment_rule(non_comment)) {
      | (
          Error(["Comment should start with a CDO token"]),
          [IDENT("not"), IDENT("a"), IDENT("comment")],
        ) =>
        ()
      | _ =>
        fail(
          "Expected (Error([Comment should start with a CDO token]), [IDENT(not), IDENT(a), IDENT(comment)])",
        )
      };

      switch (comment_rule(unclosed_comment)) {
      | (Error(["Unclosed comment"]), []) => ()
      | _ => fail("Expected (Error([Unclosed comment]), [])")
      };
    },
  ),
];

let tests =
  List.concat([
    data_monad_tests,
    rule_tests,
    pattern_helpers_test,
    rule_tests,
  ]);
