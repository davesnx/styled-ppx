open Css_grammar;
open Parser;

let parse_exn = (prop, str) =>
  switch (parse(prop, str)) {
  | Ok(data) => data
  | Error(message) => Alcotest.fail(message)
  };

/* check is shadowed by Parser.check */
let check = Alcotest_extra.check;

let tests: tests = [
  test("<integer>?", () => {
    let parse = parse_exn([%spec "<integer>?"]);
    check(~__POS__, Alcotest.option(Alcotest.int), parse("13"), Some(13));
    check(~__POS__, Alcotest.option(Alcotest.int), parse(""), None);
  }),
  test("'['", () => {
    let parse = parse_exn([%spec "'['"]);
    check(~__POS__, Alcotest.unit, parse("["), ());
  }),
  test("[<integer> A]?", () => {
    let parse = parse_exn([%spec "[<integer> A]?"]);
    /* And combinator already unwraps integer, so no need to unwrap again */
    check(
      ~__POS__,
      Alcotest.option(Alcotest.pair(Alcotest.int, Alcotest.unit)),
      parse("14 A"),
      Some((14, ())),
    );
    check(
      ~__POS__,
      Alcotest.option(Alcotest.pair(Alcotest.int, Alcotest.unit)),
      parse("14 A"),
      Some((14, ())),
    );
    check(
      ~__POS__,
      Alcotest.option(Alcotest.pair(Alcotest.int, Alcotest.unit)),
      parse(""),
      None,
    );
  }),
  test("<integer>*", () => {
    let parse = parse_exn([%spec "<integer>*"]);
    check(~__POS__, Alcotest.list(Alcotest.int), parse(""), []);
    check(~__POS__, Alcotest.list(Alcotest.int), parse("15"), [15]);
    check(~__POS__, Alcotest.list(Alcotest.int), parse("16 17"), [16, 17]);
  }),
  test("[<integer> A]*", () => {
    let parse = parse_exn([%spec "[<integer> A]*"]);
    /* And combinator already unwraps integer, so no need to unwrap again */
    check(
      ~__POS__,
      Alcotest.list(Alcotest.pair(Alcotest.int, Alcotest.unit)),
      parse(""),
      [],
    );
    check(
      ~__POS__,
      Alcotest.list(Alcotest.pair(Alcotest.int, Alcotest.unit)),
      parse("18 A"),
      [(18, ())],
    );
    check(
      ~__POS__,
      Alcotest.list(Alcotest.pair(Alcotest.int, Alcotest.unit)),
      parse("19 A 20 A"),
      [(19, ()), (20, ())],
    );
  }),
  test("<integer>+", () => {
    let parse = parse([%spec "<integer>+"]);
    check(
      ~__POS__,
      Alcotest.result(Alcotest.list(Alcotest.int), Alcotest.string),
      parse(""),
      Error("Expected an integer."),
    );
    check(
      ~__POS__,
      Alcotest.result(Alcotest.list(Alcotest.int), Alcotest.string),
      parse("21"),
      Ok([21]),
    );
    check(
      ~__POS__,
      Alcotest.result(Alcotest.list(Alcotest.int), Alcotest.string),
      parse("22 23"),
      Ok([22, 23]),
    );
  }),
  test("[<integer> A]+", () => {
    let parse = parse([%spec "[<integer> A]+"]);
    /* And combinator already unwraps integer, so no need to unwrap again */
    let to_check =
      Alcotest.result(
        Alcotest.list(Alcotest.pair(Alcotest.int, Alcotest.unit)),
        Alcotest.string,
      );
    check(~__POS__, to_check, parse(""), Error("Expected an integer."));
    check(~__POS__, to_check, parse("24 A"), Ok([(24, ())]));
    check(
      ~__POS__,
      to_check,
      parse("25 A 26 A"),
      Ok([(25, ()), (26, ())]),
    );
  }),
  test("<integer>{2}", () => {
    let parse = parse([%spec "<integer>{2}"]);
    let to_check =
      Alcotest.result(Alcotest.list(Alcotest.int), Alcotest.string);
    check(~__POS__, to_check, parse(""), Error("Expected an integer."));
    check(~__POS__, to_check, parse("27"), Error("Expected an integer."));
    check(~__POS__, to_check, parse("28 29"), Ok([28, 29]));
    check(
      ~__POS__,
      to_check,
      parse("30 31 32"),
      Error("tokens remaining: (NUMBER 32.), EOF"),
    );
  }),
  test("<integer>{2} <integer>", () => {
    let parse = parse([%spec "<integer>{2} <integer>"]);
    /* Static combinator already unwraps integer, so no need to unwrap again */
    let to_check =
      Alcotest.result(
        Alcotest.pair(Alcotest.list(Alcotest.int), Alcotest.int),
        Alcotest.string,
      );
    check(~__POS__, to_check, parse(""), Error("Expected an integer."));
    check(~__POS__, to_check, parse("27"), Error("Expected an integer."));
    check(~__POS__, to_check, parse("28 29 30"), Ok(([28, 29], 30)));
    check(
      ~__POS__,
      to_check,
      parse("30 31 32 33"),
      Error("tokens remaining: (NUMBER 33.), EOF"),
    );
  }),
  test("<integer>{2,3}", () => {
    let parse = parse([%spec "<integer>{2,3}"]);
    let to_check =
      Alcotest.result(Alcotest.list(Alcotest.int), Alcotest.string);
    check(~__POS__, to_check, parse(""), Error("Expected an integer."));
    check(~__POS__, to_check, parse("33"), Error("Expected an integer."));
    check(~__POS__, to_check, parse("34 35"), Ok([34, 35]));
    check(~__POS__, to_check, parse("36 37 38"), Ok([36, 37, 38]));
    check(
      ~__POS__,
      to_check,
      parse("39 40 41 42"),
      Error("tokens remaining: (NUMBER 42.), EOF"),
    );
  }),
  test("<integer>{2,}", () => {
    let parse = parse([%spec "<integer>{2,}"]);
    let to_check =
      Alcotest.result(Alcotest.list(Alcotest.int), Alcotest.string);
    check(~__POS__, to_check, parse(""), Error("Expected an integer."));
    check(~__POS__, to_check, parse("43"), Error("Expected an integer."));
    check(~__POS__, to_check, parse("44 45"), Ok([44, 45]));
    check(~__POS__, to_check, parse("46 47 48"), Ok([46, 47, 48]));
    check(~__POS__, to_check, parse("49 50 51 52"), Ok([49, 50, 51, 52]));
  }),
  test("<integer>#{2,3}", () => {
    let parse = parse([%spec "<integer>#{2,3}"]);
    let to_check =
      Alcotest.result(Alcotest.list(Alcotest.int), Alcotest.string);
    check(~__POS__, to_check, parse(""), Error("Expected an integer."));
    check(
      ~__POS__,
      to_check,
      parse("53"),
      Error("Expected ',' but instead got 'the end'."),
    );
    check(~__POS__, to_check, parse("54, 55"), Ok([54, 55]));
    check(~__POS__, to_check, parse("56, 57, 58"), Ok([56, 57, 58]));
    check(
      ~__POS__,
      to_check,
      parse("59, 60, 61,"),
      Error("tokens remaining: COMMA, EOF"),
    );
    check(
      ~__POS__,
      to_check,
      parse("59, 60, 61, 62"),
      Error("tokens remaining: COMMA, (NUMBER 62.), EOF"),
    );
  }),
  test("<integer>#{2}, <integer>", () => {
    let parse = parse([%spec "<integer>#{2} ',' <integer>"]);
    /* Static combinator already unwraps integer, so no need to unwrap again */
    let to_check =
      Alcotest.result(
        Alcotest.triple(
          Alcotest.list(Alcotest.int),
          Alcotest.unit,
          Alcotest.int,
        ),
        Alcotest.string,
      );
    check(~__POS__, to_check, parse(""), Error("Expected an integer."));
    check(
      ~__POS__,
      to_check,
      parse("53"),
      Error("Expected ',' but instead got 'the end'."),
    );
    check(
      ~__POS__,
      to_check,
      parse("54, 55"),
      Error("Expected ',' but instead got 'the end'."),
    );
    check(~__POS__, to_check, parse("56, 57, 58"), Ok(([56, 57], (), 58)));
    check(
      ~__POS__,
      to_check,
      parse("59, 60, 61,"),
      Error("tokens remaining: COMMA, EOF"),
    );
    check(
      ~__POS__,
      to_check,
      parse("59, 60, 61, 62"),
      Error("tokens remaining: COMMA, (NUMBER 62.), EOF"),
    );
  }),
  test("[<integer> A]{2,3}", () => {
    let parse = parse([%spec "<integer>{2,3}"]);
    let to_check =
      Alcotest.result(Alcotest.list(Alcotest.int), Alcotest.string);
    check(~__POS__, to_check, parse(""), Error("Expected an integer."));
    check(~__POS__, to_check, parse("63"), Error("Expected an integer."));
    check(~__POS__, to_check, parse("64 65"), Ok([64, 65]));
    check(~__POS__, to_check, parse("66 67 68"), Ok([66, 67, 68]));
    /* TODO: Remove "tokens remaining" message */
    check(
      ~__POS__,
      to_check,
      parse("69 70 71 72"),
      Error("tokens remaining: (NUMBER 72.), EOF"),
    );
  }),
];

// TODO: at_least_one
// describe("at_least_one", ({test, _}) => {
//   test("[A? B?]!", `Quick, () => {
//     let parse = parse([%spec "[A? B?]!"]);
//     let x = parse("A");
//     ();
//   })
// }),
