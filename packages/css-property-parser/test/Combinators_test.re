open Alcotest;
open Css_property_parser;
open Rule.Match;
open Modifier;
open Standard;

let check = (location, testable, recived, expected) =>
  Alcotest.check(~pos=location, testable, "", expected, recived);

let test = (title, body) => test_case(title, `Quick, body);

let parse_exn = (prop, str) =>
  switch (Parser.parse(prop, str)) {
  | Ok(data) => data
  | Error(message) => fail(message)
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
    check(__POS__, float(1.), number, 15.0);
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
      | `B => fail("should be `A")
      };
    let () =
      switch (parser("B")) {
      | `A => fail("should be `B")
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
      | `C => fail("should be `A")
      };
    let () =
      switch (parser("B")) {
      | `B => ()
      | `A
      | `C => fail("should be `B")
      };
    let () =
      switch (parser("C")) {
      | `C => ()
      | `A
      | `B => fail("should be `C")
      };
    ();
  }),
  test("A | [A B]", _ => {
    let parser = parse_exn([%value "A | [A B]"]);
    let () =
      switch (parser("A B")) {
      | `Static(_) => ()
      | _ => fail("should be Static")
      };
    let () =
      switch (parser("A")) {
      | `A => ()
      | _ => fail("should be A")
      };
    ();
  }),
  test("<number> | B", () => {
    let parser = parse_exn([%value "<number> | B"]);
    let number =
      switch (parser("16")) {
      | `Number(number) => number
      | `B => fail("should be <number>")
      };

    check(__POS__, float(1.), number, 16.0);

    let () =
      switch (parser("B")) {
      | `B => ()
      | `Number(_) => fail("should be `B")
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
    check(__POS__, float(1.), number, 17.0);

    let (number, ()) = parser("B 18");
    check(__POS__, float(1.), number, 18.0);
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
        | _ => fail("should be (Some(), ())")
        };
      let () =
        switch (parser("B A")) {
        | (Some (), ()) => ()
        | _ => fail("should be (Some(), ())")
        };
      let () =
        switch (parser("B")) {
        | (None, ()) => ()
        | _ => fail("should be (None, ())")
        };
      ();
    };
    let () = {
      let parser = parse_exn([%value "A && B?"]);
      let () =
        switch (parser("A B")) {
        | ((), Some ()) => ()
        | _ => fail("should be (Some(), ())")
        };
      let () =
        switch (parser("B A")) {
        | ((), Some ()) => ()
        | _ => fail("should be (Some(), ())")
        };
      let () =
        switch (parser("A")) {
        | ((), None) => ()
        | _ => fail("should be (None, ())")
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
      | (_, _) => fail("should be (Some(), Some())")
      };
    let () =
      switch (parser("B A")) {
      | (Some (), Some ()) => ()
      | (_, _) => fail("should be (Some(), Some())")
      };
    let () =
      switch (parser("A")) {
      | (Some (), None) => ()
      | (_, _) => fail("should be (Some(), None)")
      };
    let () =
      switch (parser("B")) {
      | (None, Some ()) => ()
      | (_, _) => fail("should be (None, Some())")
      };
    ();
  }),
  test("A || B || C", _ => {
    let parser = parse_exn([%value "A || B || C"]);
    let is = (expect, str) =>
      parser(str) == expect ? () : fail("error at " ++ str);
    is((Some(), Some(), Some()), "A B C");
    is((Some(), Some(), Some()), "A C B");
    is((Some(), Some(), Some()), "B A C");
    is((Some(), Some(), Some()), "B C A");
    is((Some(), Some(), Some()), "C A B");
    is((Some(), Some(), Some()), "C B A");
  }),
  test("<number> || B", () => {
    let parser = parse_exn([%value "<number> || B"]);
    let () =
      switch (parser("19 B")) {
      | (Some(number), Some ()) => check(__POS__, float(1.), number, 19.0)
      | (_, _) => fail("should be (Some(number), Some())")
      };
    let () =
      switch (parser("B 20")) {
      | (Some(number), Some ()) => check(__POS__, float(1.), number, 20.0)
      | (_, _) => fail("should be (Some(number), Some())")
      };
    let () =
      switch (parser("21")) {
      | (Some(number), None) => check(__POS__, float(1.), number, 21.0)
      | (_, _) => fail("should be (Some(number), None)")
      };
    let () =
      switch (parser("B")) {
      | (None, Some ()) => ()
      | (_, _) => fail("should be (None, Some())")
      };
    ();
  }),
  test("A*", _ => {
    let parser = parse_exn([%value "A*"]);
    let () =
      switch (parser("A A A A")) {
      | [_, _, _, _] => ()
      | _ => fail("should be [_, _, _, _]")
      };
    ();
    let () =
      switch (parser("A A")) {
      | [_, _] => ()
      | _ => fail("should be [_, _]")
      };
    ();
  }),
  test("[ A? [B | C] ]+ A?", _ => {
    let parser = parse_exn([%value "[ A? [B | C] ]+ A?"]);
    let () =
      switch (parser("A B A C")) {
      | ([(Some (), `B), (Some (), `C)], None) => ()
      | _ => fail("should be ([(Some(), `B), (Some(), `C)], None)")
      };
    let () =
      switch (parser("B A C A")) {
      | ([(None, `B), (Some (), `C)], Some ()) => ()
      | _ => fail("should be ([(None, `B), (Some(), `C)], Some())")
      };
    ();
  }),
];
