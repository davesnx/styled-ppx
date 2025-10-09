open Css_grammar;
open Rule.Match;
open Modifier;
open Standard;

let parse_exn = (prop, str) =>
  switch (Css_grammar.parse(prop, str)) {
  | Ok(data) => data
  | Error(message) => Alcotest.fail(message)
  };

let string_contains = (str, substr) => {
  let str_len = String.length(str);
  let substr_len = String.length(substr);
  let rec check_from = pos =>
    if (pos + substr_len > str_len) {
      false;
    } else if (String.sub(str, pos, substr_len) == substr) {
      true;
    } else {
      check_from(pos + 1);
    };
  check_from(0);
};

// TODO: check static order
let tests = [
  test("A B", _ => {
    let parser = parse_exn([%value "A B"]);
    let ((), ()) = parser("A B");
    ();
  }),
  test("A B C", _ => {
    // TODO: fix this type
    let ((), (), ()) = parse_exn([%value "A B C"], "A B C");
    ();
  }),
  test("<number> B", () => {
    let (number, ()) = parse_exn([%value "<number> B"], "15 B");
    Alcotest.check(~pos=__POS__, Alcotest.float(1.), "", number, 15.0);
  }),
  /* test{
       let parser = parse_exn([%value "<number> B"]);
       check_raises("should throw", Failure(), () => {
         let _ = parser("B 15");
         ();
       });
     }), */
  test("A | B", _ => {
    let parser = parse_exn([%value "A | B"]);
    let () =
      switch (parser("A")) {
      | `A => ()
      | `B => Alcotest.fail("should be `A")
      };
    let () =
      switch (parser("B")) {
      | `A => Alcotest.fail("should be `B")
      | `B => ()
      };
    ();
  }),
  test("A | B | C", _ => {
    let parser = parse_exn([%value "A | B | C"]);
    let () =
      switch (parser("A")) {
      | `A => ()
      | `B
      | `C => Alcotest.fail("should be `A")
      };
    let () =
      switch (parser("B")) {
      | `B => ()
      | `A
      | `C => Alcotest.fail("should be `B")
      };
    let () =
      switch (parser("C")) {
      | `C => ()
      | `A
      | `B => Alcotest.fail("should be `C")
      };
    ();
  }),
  test("A | [A B]", _ => {
    let parser = parse_exn([%value "A | [A B]"]);
    let () =
      switch (parser("A B")) {
      | `Static(_) => ()
      | _ => Alcotest.fail("should be Static")
      };
    let () =
      switch (parser("A")) {
      | `A => ()
      | _ => Alcotest.fail("should be A")
      };
    ();
  }),
  test("<number> | B", () => {
    let parser = parse_exn([%value "<number> | B"]);
    let number =
      switch (parser("16")) {
      | `Number(number) => number
      | `B => Alcotest.fail("should be <number>")
      };

    Alcotest.check(~pos=__POS__, Alcotest.float(1.), "", number, 16.0);

    let () =
      switch (parser("B")) {
      | `B => ()
      | `Number(_) => Alcotest.fail("should be `B")
      };
    ();
  }),
  test("A && B", _ => {
    let parser = parse_exn([%value "A && B"]);
    let ((), ()) = parser("A B");
    let ((), ()) = parser("B A");
    ();
  }),
  test("A && B && C", _ => {
    let parser = parse_exn([%value "A && B && C"]);
    let ((), (), ()) = parser("A B C");
    // TODO: and isn't associative
    let ((), (), ()) = parser("A C B");
    let ((), (), ()) = parser("B A C");
    let ((), (), ()) = parser("B C A");
    let ((), (), ()) = parser("C A B");
    let ((), (), ()) = parser("C B A");
    ();
  }),
  test("<number> && B", () => {
    let parser = parse_exn([%value "<number> && B"]);
    let (number, ()) = parser("17 B");
    Alcotest.check(~pos=__POS__, Alcotest.float(1.), "", number, 17.0);

    let (number, ()) = parser("B 18");
    Alcotest.check(~pos=__POS__, Alcotest.float(1.), "", number, 18.0);
  }),
  test("[ A && [A B] ]", _ => {
    let parser = parse_exn([%value "[ A && [A B] ]"]);
    let ((), ((), ())) = parser("A B A");
    let ((), ((), ())) = parser("A A B");
    ();
  }),
  test("prefer longest", _ => {
    let parser = parse_exn([%value "A && A B"]);
    let ((), ((), ())) = parser("A A B");
    let ((), ((), ())) = parser("A B A");
    ();
  }),
  test("prefer longest with optional", _ => {
    let () = {
      let parser = parse_exn([%value "A? && B"]);
      let () =
        switch (parser("A B")) {
        | (Some (), ()) => ()
        | _ => Alcotest.fail("should be (Some(), ())")
        };
      let () =
        switch (parser("B A")) {
        | (Some (), ()) => ()
        | _ => Alcotest.fail("should be (Some(), ())")
        };
      let () =
        switch (parser("B")) {
        | (None, ()) => ()
        | _ => Alcotest.fail("should be (None, ())")
        };
      ();
    };
    let () = {
      let parser = parse_exn([%value "A && B?"]);
      let () =
        switch (parser("A B")) {
        | ((), Some ()) => ()
        | _ => Alcotest.fail("should be (Some(), ())")
        };
      let () =
        switch (parser("B A")) {
        | ((), Some ()) => ()
        | _ => Alcotest.fail("should be (Some(), ())")
        };
      let () =
        switch (parser("A")) {
        | ((), None) => ()
        | _ => Alcotest.fail("should be (None, ())")
        };
      ();
    };
    ();
  }),
  // TODO: check invalid cases
  test("A || B", _ => {
    let parser = parse_exn([%value "A || B"]);
    let () =
      switch (parser("A B")) {
      | (Some (), Some ()) => ()
      | (_, _) => Alcotest.fail("should be (Some(), Some())")
      };
    let () =
      switch (parser("B A")) {
      | (Some (), Some ()) => ()
      | (_, _) => Alcotest.fail("should be (Some(), Some())")
      };
    switch (parser("A")) {
    | (Some (), None) => ()
    | (_, _) => Alcotest.fail("should be (Some(), None)")
    };
    switch (parser("B")) {
    | (None, Some ()) => ()
    | (_, _) => Alcotest.fail("should be (None, Some())")
    };
  }),
  test("A || B || C", _ => {
    let parser = parse_exn([%value "A || B || C"]);
    let is = (expect, str) =>
      parser(str) == expect ? () : Alcotest.fail("error at " ++ str);
    is((Some(), Some(), Some()), "A B C");
    is((Some(), Some(), Some()), "A C B");
    is((Some(), Some(), Some()), "B A C");
    is((Some(), Some(), Some()), "B C A");
    is((Some(), Some(), Some()), "C A B");
    is((Some(), Some(), Some()), "C B A");
  }),
  test("<number> || B", () => {
    let parser = parse_exn([%value "<number> || B"]);
    switch (parser("19 B")) {
    | (Some(number), Some ()) =>
      Alcotest.check(~pos=__POS__, Alcotest.float(1.), "", number, 19.0)
    | (_, _) => Alcotest.fail("should be (Some(number), Some())")
    };
    switch (parser("B 20")) {
    | (Some(number), Some ()) =>
      Alcotest.check(~pos=__POS__, Alcotest.float(1.), "", number, 20.0)
    | (_, _) => Alcotest.fail("should be (Some(number), Some())")
    };
    switch (parser("21")) {
    | (Some(number), None) =>
      Alcotest.check(~pos=__POS__, Alcotest.float(1.), "", number, 21.0)
    | (_, _) => Alcotest.fail("should be (Some(number), None)")
    };
    switch (parser("B")) {
    | (None, Some ()) => ()
    | (_, _) => Alcotest.fail("should be (None, Some())")
    };
  }),
  test("A*", _ => {
    let parser = parse_exn([%value "A*"]);
    switch (parser("A A A A")) {
    | [_, _, _, _] => ()
    | _ => Alcotest.fail("should be [_, _, _, _]")
    };
    switch (parser("A A")) {
    | [_, _] => ()
    | _ => Alcotest.fail("should be [_, _]")
    };
  }),
  test("[ A? [B | C] ]+ A?", _ => {
    let parser = parse_exn([%value "[ A? [B | C] ]+ A?"]);
    switch (parser("A B A C")) {
    | ([(Some (), `B), (Some (), `C)], None) => ()
    | _ => Alcotest.fail("should be ([(Some(), `B), (Some(), `C)], None)")
    };
    switch (parser("B A C A")) {
    | ([(None, `B), (Some (), `C)], Some ()) => ()
    | _ => Alcotest.fail("should be ([(None, `B), (Some(), `C)], Some())")
    };
  }),
  test("xor with three alternatives", _ => {
    let parser = parse_exn([%value "red | blue | green"]);
    switch (parser("red")) {
    | `Red => ()
    | _ => Alcotest.fail("should be `Red")
    };
    switch (parser("blue")) {
    | `Blue => ()
    | _ => Alcotest.fail("should be `Blue")
    };
    switch (parser("green")) {
    | `Green => ()
    | _ => Alcotest.fail("should be `Green")
    };
  }),
  test("xor with data types", () => {
    let parser = parse_exn([%value "<number> | <percentage> | auto"]);
    switch (parser("50")) {
    | `Number(n) =>
      Alcotest.check(~pos=__POS__, Alcotest.float(1.), "", n, 50.0)
    | _ => Alcotest.fail("should be `Number")
    };
    switch (parser("50%")) {
    | `Percentage(p) =>
      Alcotest.check(~pos=__POS__, Alcotest.float(1.), "", p, 50.0)
    | _ => Alcotest.fail("should be `Percentage")
    };
    switch (parser("auto")) {
    | `Auto => ()
    | _ => Alcotest.fail("should be `Auto")
    };
  }),
  test("xor with complex combinations", _ => {
    let parser = parse_exn([%value "[A B] | [C D] | E"]);
    switch (parser("A B")) {
    | `Static_0((), ()) => ()
    | _ => Alcotest.fail("should be `Static_0((), ())")
    };
    switch (parser("C D")) {
    | `Static_1((), ()) => ()
    | _ => Alcotest.fail("should be `Static_1((), ())")
    };
    switch (parser("E")) {
    | `E => ()
    | _ => Alcotest.fail("should be `E")
    };
  }),
  test("xor error handling - invalid input", _ => {
    let output = parse([%value "red | blue | green"], "yellow");
    switch (output) {
    | Error(msg) =>
      let has_red = string_contains(msg, "red");
      let has_blue = string_contains(msg, "blue");
      let has_green = string_contains(msg, "green");
      if (!has_red || !has_blue || !has_green) {
        Alcotest.fail(
          "Error message should mention all valid options: " ++ msg,
        );
      };
    | Ok(_) => Alcotest.fail("Should have failed for invalid input")
    };
  }),
  test("xor error handling - typo suggestion", _ => {
    let output = parse([%value "red | blue | green"], "gren");
    switch (output) {
    | Error(msg) =>
      if (!string_contains(msg, "did you mean")) {
        Alcotest.fail("Error message should suggest correction: " ++ msg);
      };
      if (!string_contains(msg, "green")) {
        Alcotest.fail("Error message should suggest 'green': " ++ msg);
      };
    | Ok(_) => Alcotest.fail("Should have failed for typo input")
    };
  }),
  test("xor with nested alternatives", _ => {
    let parser = parse_exn([%value "A | [B | C]"]);
    switch (parser("A")) {
    | `A => ()
    | _ => Alcotest.fail("should be `A")
    };
    switch (parser("B")) {
    | `Xor(`B) => ()
    | _ => Alcotest.fail("should be `Xor(`B)")
    };
    switch (parser("C")) {
    | `Xor(`C) => ()
    | _ => Alcotest.fail("should be `Xor(`C)")
    };
  }),
  test("xor prefers longest match", _ => {
    let parser = parse_exn([%value "A | A B"]);
    /* When both match, xor should prefer the longer match */
    switch (parser("A B")) {
    | `Static((), ()) => ()
    | _ => Alcotest.fail("should prefer longer match A B")
    };
    switch (parser("A")) {
    | `A => ()
    | _ => Alcotest.fail("should match single A when B is not present")
    };
  }),
  test("xor with mixed types and keywords", () => {
    let parser = parse_exn([%value "<number> | inherit | initial"]);
    switch (parser("42")) {
    | `Number(n) =>
      Alcotest.check(~pos=__POS__, Alcotest.float(1.), "", n, 42.0)
    | _ => Alcotest.fail("should be `Number")
    };
    switch (parser("inherit")) {
    | `Inherit => ()
    | _ => Alcotest.fail("should be `Inherit")
    };
    switch (parser("initial")) {
    | `Initial => ()
    | _ => Alcotest.fail("should be `Initial")
    };
  }),
];
