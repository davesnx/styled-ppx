open Setup;
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

describe("Combinators: static", ({test, _}) => {
  // TODO: check static order
  test("A B", _ => {
    let parser = parse_exn([%value "A B"]);
    let ((), ()) = parser("A B");
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

  test("Running '<number> B' with wrong input", ({expect, _}) => {
    let parser = parse_exn([%value "<number> B"]);
    expect.fn(() => parser("15 15")).toThrow();
  });
});

describe("Combinators: xor", ({test, _}) => {
  test("A | B", _ => {
    let parser = parse_exn([%value "A | B"]);
    let () =
      switch (parser("A")) {
      | `A => ()
      | `B => failwith("should be `A")
      };
    let () =
      switch (parser("B")) {
      | `A => failwith("should be `B")
      | `B => ()
      };
    ();
  });

  test("A | B | C", _ => {
    let parser = parse_exn([%value "A | B | C"]);
    let () =
      switch (parser("A")) {
      | `A => ()
      | `B
      | `C => failwith("should be `A")
      };
    let () =
      switch (parser("B")) {
      | `B => ()
      | `A
      | `C => failwith("should be `B")
      };
    let () =
      switch (parser("C")) {
      | `C => ()
      | `A
      | `B => failwith("should be `C")
      };
    ();
  });

  test("A | [A B]", _ => {
    let parser = parse_exn([%value "A | [A B]"]);
    let () = switch (parser("A B")) {
      | `Static(_) => ()
      | _ => failwith("should be Static")
    };
    let () = switch (parser("A")) {
      | `A => ()
      | _ => failwith("should be A")
    };
    ();
  });

  test("<number> | B", ({expect, _}) => {
    let parser = parse_exn([%value "<number> | B"]);
    let number =
      switch (parser("16")) {
      | `Number(number) => number
      | `B => failwith("should be <number>")
      };
    expect.float(number).toBeCloseTo(16.0);

    let () =
      switch (parser("B")) {
      | `B => ()
      | `Number(_) => failwith("should be `B")
      };
    ();
  });
});

describe("Combinators: and", ({test, _}) => {
  test("A && B", _ => {
    let parser = parse_exn([%value "A && B"]);
    let ((), ()) = parser("A B");
    let ((), ()) = parser("B A");
    ();
  });

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
  });

  test("<number> && B", ({expect, _}) => {
    let parser = parse_exn([%value "<number> && B"]);
    let (number, ()) = parser("17 B");
    expect.float(number).toBeCloseTo(17.0);

    let (number, ()) = parser("B 18");
    expect.float(number).toBeCloseTo(18.0);
  });

  test("[ A && [A B] ]", _ => {
    let parser = parse_exn([%value "[ A && [A B] ]"]);
    let ((), ((), ())) = parser("A B A");
    let ((), ((), ())) = parser("A A B");
  });

  test("prefer longest", _ => {
    let parser = parse_exn([%value "A && A B"]);
    let ((), ((), ())) = parser("A A B");
    let ((), ((), ())) = parser("A B A");
    ();
  });

  test("prefer longest with optional", _ => {
    let () = {
      let parser = parse_exn([%value "A? && B"]);
      let () =
        switch (parser("A B")) {
        | (Some(), ()) => ()
        | _ => failwith("should be (Some(), ())")
        };
      let () =
        switch (parser("B A")) {
        | (Some(), ()) => ()
        | _ => failwith("should be (Some(), ())")
        };
      let () =
        switch (parser("B")) {
        | (None, ()) => ()
        | _ => failwith("should be (None, ())")
        };
      ();
    };
    let () = {
      let parser = parse_exn([%value "A && B?"]);
      let () =
        switch (parser("A B")) {
        | ((), Some()) => ()
        | _ => failwith("should be (Some(), ())")
        };
      let () =
        switch (parser("B A")) {
        | ((), Some()) => ()
        | _ => failwith("should be (Some(), ())")
        };
      let () =
        switch (parser("A")) {
        | ((), None) => ()
        | _ => failwith("should be (None, ())")
        };
      ();
    };
    ();
  });
});

describe("Combinators: or", ({test, _}) => {
  // TODO: check invalid cases
  test("A || B", _ => {
    let parser = parse_exn([%value "A || B"]);
    let () =
      switch (parser("A B")) {
      | (Some(), Some()) => ()
      | (_, _) => failwith("should be (Some(), Some())")
      };
    let () =
      switch (parser("B A")) {
      | (Some(), Some()) => ()
      | (_, _) => failwith("should be (Some(), Some())")
      };
    let () =
      switch (parser("A")) {
      | (Some(), None) => ()
      | (_, _) => failwith("should be (Some(), None)")
      };
    let () =
      switch (parser("B")) {
      | (None, Some()) => ()
      | (_, _) => failwith("should be (None, Some())")
      };
    ();
  });

  test("A || B || C", _ => {
    let parser = parse_exn([%value "A || B || C"]);
    let is = (expect, str) =>
      parser(str) == expect ? () : failwith("error at " ++ str);
    is((Some(), Some(), Some()), "A B C");
    is((Some(), Some(), Some()), "A C B");
    is((Some(), Some(), Some()), "B A C");
    is((Some(), Some(), Some()), "B C A");
    is((Some(), Some(), Some()), "C A B");
    is((Some(), Some(), Some()), "C B A");
  });

  test("<number> || B", ({expect, _}) => {
    let parser = parse_exn([%value "<number> || B"]);
    let () =
      switch (parser("19 B")) {
      | (Some(number), Some()) => expect.float(number).toBeCloseTo(19.0)
      | (_, _) => failwith("should be (Some(number), Some())")
      };
    let () =
      switch (parser("B 20")) {
      | (Some(number), Some()) => expect.float(number).toBeCloseTo(20.0)
      | (_, _) => failwith("should be (Some(number), Some())")
      };
    let () =
      switch (parser("21")) {
      | (Some(number), None) => expect.float(number).toBeCloseTo(21.0)
      | (_, _) => failwith("should be (Some(number), None)")
      };
    let () =
      switch (parser("B")) {
      | (None, Some()) => ()
      | (_, _) => failwith("should be (None, Some())")
      };
    ();
  });
});

describe("Combinators: list", ({test, _}) => {
  test("A*", _ => {
    let parser = parse_exn([%value "A*"]);
    let () =
      switch (parser("A A A A")) {
      | [_, _, _, _] => ()
      | _ => failwith("should be [_, _, _, _]")
      };
    ();
    let () =
      switch (parser("A A")) {
      | [_, _] => ()
      | _ => failwith("should be [_, _]")
      };
    ();
  });

  test("[ A? [B | C] ]+ A?", _ => {
    let parser = parse_exn([%value "[ A? [B | C] ]+ A?"]);
    let () = switch(parser("A B A C")) {
      | ([(Some(), `B), (Some(), `C)], None) => ()
      | _ => failwith("should be ([(Some(), `B), (Some(), `C)], None)")
    };
    let () = switch(parser("B A C A")) {
      | ([(None, `B), (Some(), `C)], Some()) => ()
      | _ => failwith("should be ([(None, `B), (Some(), `C)], Some())")
    };
  });
});
