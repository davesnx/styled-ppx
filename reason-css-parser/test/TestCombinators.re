open TestFramework;
open Reason_css_parser;
open Rule.Match;
open Modifier;
open Combinator;
open Standard;

let parse_exn = (prop, str) =>
  switch (Parser.parse(prop, str)) {
  | Ok(data) => data
  | Error(message) => failwith(message)
  };

describe("combine_static", ({test, _}) => {
  // TODO: check static order
  test("A B", _ => {
    let ((), ()) = parse_exn([%value "A B"], "A B");
    ();
  });
  test("A B C", _ => {
    // TODO: fix this type
    let ((), (), ()) = parse_exn([%value "A B C"], "A B C");
    ();
  });
  test("<number> B", ({expect, _}) => {
    let (number, ()) = parse_exn([%value "<number> B"], "15 B");
    expect.float(number).toBeCloseTo(15.0);
  });
});

describe("combine_xor", ({test, _}) => {
  test("A | B", _ => {
    let parse = parse_exn([%value "A | B"]);
    let () =
      switch (parse("A")) {
      | `A => ()
      | `B => failwith("should be `A")
      };
    let () =
      switch (parse("B")) {
      | `A => failwith("should be `B")
      | `B => ()
      };
    ();
  });
  test("A | B | C", _ => {
    let parse = parse_exn([%value "A | B | C"]);
    let () =
      switch (parse("A")) {
      | `A => ()
      | `B
      | `C => failwith("should be `A")
      };
    let () =
      switch (parse("B")) {
      | `B => ()
      | `A
      | `C => failwith("should be `B")
      };
    let () =
      switch (parse("C")) {
      | `C => ()
      | `A
      | `B => failwith("should be `C")
      };
    ();
  });
  test("<number> | B", ({expect, _}) => {
    let parse = parse_exn([%value "<number> | B"]);
    let number =
      switch (parse("16")) {
      | `Number(number) => number
      | `B => failwith("should be <number>")
      };
    expect.float(number).toBeCloseTo(16.0);

    let () =
      switch (parse("B")) {
      | `B => ()
      | `Number(_) => failwith("should be `B")
      };
    ();
  });
});

describe("combine_and", ({test, _}) => {
  test("A && B", _ => {
    let parse = parse_exn([%value "A && B"]);
    let ((), ()) = parse("A B");
    let ((), ()) = parse("B A");
    ();
  });
  test("A && B && C", _ => {
    let parse = parse_exn([%value "A && B && C"]);
    let ((), (), ()) = parse("A B C");
    // TODO: and isn't associative
    let ((), (), ()) = parse("A C B");
    let ((), (), ()) = parse("B A C");
    let ((), (), ()) = parse("B C A");
    let ((), (), ()) = parse("C A B");
    let ((), (), ()) = parse("C B A");
    ();
  });
  test("<number> && B", ({expect, _}) => {
    let parse = parse_exn([%value "<number> && B"]);
    let (number, ()) = parse("17 B");
    expect.float(number).toBeCloseTo(17.0);

    let (number, ()) = parse("B 18");
    expect.float(number).toBeCloseTo(18.0);
  });
  test("prefer longest", _ => {
    let parse = parse_exn([%value "A && A B"]);
    let ((), ((), ())) = parse("A A B");
    let ((), ((), ())) = parse("A B A");
    ();
  });
  test("prefer longest with optional", _ => {
    let () = {
      print_string("wat");
      let parse = parse_exn([%value "A? && B"]);
      let () =
        switch (parse("A B")) {
        | (Some (), ()) => ()
        | _ => failwith("should be (Some(), ())")
        };
      let () =
        switch (parse("B A")) {
        | (Some (), ()) => ()
        | _ => failwith("should be (Some(), ())")
        };
      let () =
        switch (parse("B")) {
        | (None, ()) => ()
        | _ => failwith("should be (None, ())")
        };
      ();
    };
    let () = {
      let parse = parse_exn([%value "A && B?"]);
      let () =
        switch (parse("A B")) {
        | ((), Some ()) => ()
        | _ => failwith("should be (Some(), ())")
        };
      let () =
        switch (parse("B A")) {
        | ((), Some ()) => ()
        | _ => failwith("should be (Some(), ())")
        };
      let () =
        switch (parse("A")) {
        | ((), None) => ()
        | _ => failwith("should be (None, ())")
        };
      ();
    };
    ();
  });
});

describe("combine_or", ({test, _}) => {
  // TODO: check invalid cases
  test("A || B", _ => {
    let parse = parse_exn([%value "A || B"]);
    let () =
      switch (parse("A B")) {
      | (Some (), Some ()) => ()
      | (_, _) => failwith("should be (Some(), Some())")
      };
    let () =
      switch (parse("B A")) {
      | (Some (), Some ()) => ()
      | (_, _) => failwith("should be (Some(), Some())")
      };
    let () =
      switch (parse("A")) {
      | (Some (), None) => ()
      | (_, _) => failwith("should be (Some(), None)")
      };
    let () =
      switch (parse("B")) {
      | (None, Some ()) => ()
      | (_, _) => failwith("should be (None, Some())")
      };
    ();
  });
  test("A || B || C", _ => {
    let parse = parse_exn([%value "A || B || C"]);
    let is = (expect, str) =>
      parse(str) == expect ? () : failwith("error at " ++ str);
    is((Some(), Some(), Some()), "A B C");
    is((Some(), Some(), Some()), "A C B");
    is((Some(), Some(), Some()), "B A C");
    is((Some(), Some(), Some()), "B C A");
    is((Some(), Some(), Some()), "C A B");
    is((Some(), Some(), Some()), "C B A");
  });
  test("<number> || B", ({expect, _}) => {
    let parse = parse_exn([%value "<number> || B"]);
    let () =
      switch (parse("19 B")) {
      | (Some(number), Some ()) => expect.float(number).toBeCloseTo(19.0)
      | (_, _) => failwith("should be (Some(number), Some())")
      };
    let () =
      switch (parse("B 20")) {
      | (Some(number), Some ()) => expect.float(number).toBeCloseTo(20.0)
      | (_, _) => failwith("should be (Some(number), Some())")
      };
    let () =
      switch (parse("21")) {
      | (Some(number), None) => expect.float(number).toBeCloseTo(21.0)
      | (_, _) => failwith("should be (Some(number), None)")
      };
    let () =
      switch (parse("B")) {
      | (None, Some ()) => ()
      | (_, _) => failwith("should be (None, Some())")
      };
    ();
  });
});
