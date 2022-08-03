open Setup;
open Reason_css_parser;
open Reason_css_lexer;
open Rule;

describe("Data monad", ({test, _}) => {
  open! Data;

  // TODO: check static order
  test("return", _ => {
    switch (return(Ok(1), [COMMA])) {
    | (Ok(1), [COMMA]) => ()
    | _ => failwith("should be (Ok(1), [COMMA])")
    }

    switch(return(Ok(`Comma), [COMMA])){
      | (Ok(`Comma), [COMMA]) => ()
      | _ => assert false
    }
    switch(return(Ok(","), [COMMA])){
      | (Ok(","), [COMMA]) => ()
      | _ => assert false
    }

    switch (return(Ok(1), [IDENT("decl"), COLON, IDENT("value")])) {
      | (Ok(1), [IDENT("decl"), COLON, IDENT("value")]) => ()
      | _ => failwith("Should be Ok(1), [IDENT(\"decl\"), COLON, IDENT(\"value\")]")
    }

    switch (return(Error(["error"]), [COLON])){
      | (Error(["error"]), [COLON]) => ()
      | _ => failwith("Should be (Error([error], [COLON]))")
    }
  });

  test("bind", _ => {
    let rule =
      bind(
        return(Ok(2)),
        fun
        | Ok(2) => return(Ok(3))
        | _ => failwith("should be Ok(2)"),
      );
    switch (rule([COMMA])) {
    | (Ok(3), [COMMA]) => ()
    | _ => failwith("should be (Ok(3), [COMMA])")
    };

    let rule =
      bind(return(Error([])),
        fun
        | Ok(_) => failwith("should not be called")
        | Error(errs)=> return(Error(["fix this", ...errs]))
      )

    switch(rule([COMMA])){
      | (Error(["fix this"]), [COMMA]) => ()
      | _ => failwith("expected (Error([fix this]), [COMMA])")
    }
  });

  test("map", _ => {
    let rule =
      map(
        return(Ok(4)),
        fun
        | Ok(4) => Ok(5)
        | _ => failwith("should be Ok(4)"),
      );
    switch (rule([COMMA])) {
    | (Ok(5), [COMMA]) => ()
    | _ => failwith("should be (Ok(5), [COMMA])")
    };

    let rule =
      map(
        return(Error([])),
        fun
        | Error(errs) => Error(["new error", ...errs])
        | Ok(_) => failwith("should be unreachable")
      );


    switch (rule([COMMA])){
      | (Error(["new error", ..._]), [COMMA]) => ()
      | _ => failwith("expected (Error([new error, ...], [COMMA])")
    }

  });

  test("all", _ => {
    let rule4 = return(Ok(4));
    let rule5 = return(Ok(5));
    let rule = Match.all([rule4, rule5]);

    switch (rule([COMMA])) {
    | (Ok(lst), [COMMA]) when lst == [4, 5] => ()
    | _ => failwith("should be (Ok(5), [COMMA])")
    };

    let rule_err = return(Error(["Missing COMMA"]));
    let rule = Match.all([rule_err, rule4, rule5]);
    switch (rule([COMMA])) {
      | (Error(["Missing COMMA"]), [COMMA]) => ()
      | _ => failwith("should be (Error(Missing Comma), [COMMA])")
    }
  });

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
          | `Right(Ok(6)) => return(Ok(8))
          | _ => failwith("should be Ok(6)"),
        );
      switch (rule([COMMA, COMMA])) {
      | (Ok(8), [COMMA]) => ()
      | _ => failwith("should be (Ok(8), [COMMA])")
      };
    };
    let () = {
      let rule =
        bind_shortest(
          (comma, two_comma),
          fun
          | `Left(Ok(6)) => return(Ok(8))
          | _ => failwith("should be Ok(6)"),
        );
      switch (rule([COMMA, COMMA])) {
      | (Ok(8), [COMMA]) => ()
      | _ => failwith("should be (Ok(8), [COMMA])")
      };
    };
    ();
  });

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
          | _ => failwith("should be Ok(10)"),
        );
      switch (rule([COMMA, COMMA])) {
      | (Ok(11), []) => ()
      | _ => failwith("should be (Ok(10), [])")
      };
    };
    let () = {
      let rule =
        bind_longest(
          (comma, two_comma),
          fun
          | `Right(Ok(10)) => return(Ok(11))
          | _ => failwith("should be Ok(10)"),
        );
      switch (rule([COMMA, COMMA])) {
      | (Ok(11), []) => ()
      | _ => failwith("should be (Ok(10), [])")
      };
    };
    ();
  });
});

describe("Match monad", ({test, _}) => {
  open! Match;

  // TODO: check static order
  test("return", _ => {
    switch (return(1, [COMMA])) {
    | (Ok(1), [COMMA]) => ()
    | _ => failwith("should be (Ok(123), [COMMA])")
    }
  });

  test("bind", _ => {
    let rule =
      bind(
        return(Ok(2)),
        fun
        | Ok(2) => return(3)
        | _ => failwith("should be Ok(2)"),
      );
    switch (rule([COMMA])) {
    | (Ok(3), [COMMA]) => ()
    | _ => failwith("should be (Ok(3), [COMMA])")
    };

  let rule =
    bind(
      Data.return(Error(["error message"])),
      fun
      | _ => failwith("Should not be reachable")
    )

    switch(rule([COMMA])){
      | ((Error(["error message"])), [COMMA]) => ()
      | _ => failwith("expected (Error([error message], [COMMA])) ")
    };
  });

  test("map", _ => {
    let rule =
      map(
        return(Ok(4)),
        fun
        | Ok(4) => 5
        | _ => failwith("should be Ok(4)"),
      );
    switch (rule([COMMA])) {
    | (Ok(5), [COMMA]) => ()
    | _ => failwith("should be (Ok(5), [COMMA])")
    };
  });

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
          | _ => failwith("should be `Right(6)"),
        );
      switch (rule([COMMA, COMMA])) {
      | (Ok(8), [COMMA]) => ()
      | _ => failwith("should be (Ok(8), [COMMA])")
      };
    };
    let () = {
      let rule =
        bind_shortest(
          (comma, two_comma),
          fun
          | `Left(6) => return(8)
          | _ => failwith("should be `Left(6)"),
        );
      switch (rule([COMMA, COMMA])) {
      | (Ok(8), [COMMA]) => ()
      | _ => failwith("should be (Ok(8), [COMMA])")
      };
    };
    ();
  });

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
          | _ => failwith("should be `Left(10)"),
        );
      switch (rule([COMMA, COMMA])) {
      | (Ok(11), []) => ()
      | _ => failwith("should be (Ok(10), [])")
      };
    };
    let () = {
      let rule =
        bind_longest(
          (comma, two_comma),
          fun
          | `Right(10) => return(11)
          | _ => failwith("should be `Right(10)"),
        );
      switch (rule([COMMA, COMMA])) {
      | (Ok(11), []) => ()
      | _ => failwith("should be (Ok(10), [])")
      };
    };
    ();
  });
});

describe("Pattern helpers", ({test, _}) => {
  open! Let;
  open! Pattern;

  test("identity", _ => {
    switch (identity([STRING("tomato")])) {
    | (Ok (), [STRING("tomato")]) => ()
    | _ => failwith({|should be (Ok(), [STRING("TOMATO")]|})
    }
  });

  test("token", _ => {
    let rule =
      token(
        fun
        | STRING("potato") => Ok(1)
        | _ => Error([""]),
      );
    switch (rule([STRING("potato")])) {
    | (Ok(1), []) => ()
    | _ => failwith("should be (Ok(1), [])")
    };

    // shouldn't consume tokens
    switch (rule([STRING("invalid")])) {
    | (Error(_), [STRING("invalid")]) => ()
    | _ => failwith({|should be (Error(_), [STRING("invalid")])|})
    };
  });

  test("expect", _ => {
    let rule = {
      let.bind_match () = expect(STRING("auto"));
      Match.return(2);
    };
    switch (rule([STRING("auto")])) {
    | (Ok(2), []) => ()
    | _ => failwith("should be (Ok(2), [])")
    };

    // shouldn't consume tokens
    switch (rule([STRING("invalid")])) {
    | (Error(_), [STRING("invalid")]) => ()
    | _ => failwith({|should be (Error(_), [STRING("invalid")])|})
    };
    ();
  });

  test("value", _ => {
    let rule = value(3, expect(STRING("none")));
    switch (rule([STRING("none")])) {
    | (Ok(3), []) => ()
    | _ => failwith("should be (Ok(3), [])")
    };
  });

  test("next", _ => {
    switch(Pattern.next([COMMA, COLON])) {
      | (Ok(COMMA), [COLON]) => ()
      | _ => failwith("should be (Ok(COMMA), [COLON])")
    }
   switch(Pattern.next([COLON])) {
      | (Ok(COLON), []) => ()
      | _ => failwith("should be (Ok(COLON), [])")
    }
    switch(Pattern.next([])) {
      | (Error(["missing the token expected"]), []) => ()
      | _ => failwith("should be (Error([missing the token expected]), [])")
    }
  });
});
