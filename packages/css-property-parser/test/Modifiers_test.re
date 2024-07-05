open Alcotest;
open Css_property_parser;
open Combinator;
open Standard;
open Modifier;
open Parser;
open Rule.Match;

let check = (location, testable, recived, expected) =>
  Alcotest.check(~pos=location, testable, "", expected, recived);

let test = (title, body) => test_case(title, `Quick, body);

let parse_exn = (prop, str) =>
  switch (parse(prop, str)) {
  | Ok(data) => data
  | Error(message) => fail(message)
  };

let tests = [
  test("<integer>?", () => {
    let parse = parse_exn([%value "<integer>?"]);
    check(__POS__, option(int), parse("13"), Some(13));
    check(__POS__, option(int), parse(""), None);
  }),
  test("'['", () => {
    let parse = parse_exn([%value "'['"]);
    check(__POS__, unit, parse("["), ());
  }),
  test("[<integer> A]?", () => {
    let parse = parse_exn([%value "[<integer> A]?"]);
    check(
      __POS__,
      option(pair(int, unit)),
      parse("14 A"),
      Some((14, ())),
    );
    check(
      __POS__,
      option(pair(int, unit)),
      parse("14 A"),
      Some((14, ())),
    );
    check(__POS__, option(pair(int, unit)), parse(""), None);
  }),
  test("<integer>*", () => {
    let parse = parse_exn([%value "<integer>*"]);
    check(__POS__, list(int), parse(""), []);
    check(__POS__, list(int), parse("15"), [15]);
    check(__POS__, list(int), parse("16 17"), [16, 17]);
  }),
  test("[<integer> A]*", () => {
    let parse = parse_exn([%value "[<integer> A]*"]);
    check(__POS__, list(pair(int, unit)), parse(""), []);
    check(__POS__, list(pair(int, unit)), parse("18 A"), [(18, ())]);
    check(
      __POS__,
      list(pair(int, unit)),
      parse("19 A 20 A"),
      [(19, ()), (20, ())],
    );
  }),
  test("<integer>+", () => {
    let parse = parse([%value "<integer>+"]);
    check(
      __POS__,
      result(list(int), Alcotest.string),
      parse(""),
      Error("expected an integer"),
    );
    check(
      __POS__,
      result(list(int), Alcotest.string),
      parse("21"),
      Ok([21]),
    );
    check(
      __POS__,
      result(list(int), Alcotest.string),
      parse("22 23"),
      Ok([22, 23]),
    );
  }),
  test("[<integer> A]+", () => {
    let parse = parse([%value "[<integer> A]+"]);
    let to_check = result(list(pair(int, unit)), Alcotest.string);
    check(__POS__, to_check, parse(""), Error("expected an integer"));
    check(__POS__, to_check, parse("24 A"), Ok([(24, ())]));
    check(
      __POS__,
      to_check,
      parse("25 A 26 A"),
      Ok([(25, ()), (26, ())]),
    );
  }),
  test("<integer>{2}", () => {
    let parse = parse([%value "<integer>{2}"]);
    let to_check = result(list(int), Alcotest.string);
    check(__POS__, to_check, parse(""), Error("expected an integer"));
    check(__POS__, to_check, parse("27"), Error("expected an integer"));
    check(__POS__, to_check, parse("28 29"), Ok([28, 29]));
    check(
      __POS__,
      to_check,
      parse("30 31 32"),
      Error("tokens remaining: (NUMBER 32.), EOF"),
    );
  }),
  test("<integer>{2} <integer>", () => {
    let parse = parse([%value "<integer>{2} <integer>"]);
    let to_check = result(pair(list(int), int), Alcotest.string);
    check(__POS__, to_check, parse(""), Error("expected an integer"));
    check(__POS__, to_check, parse("27"), Error("expected an integer"));
    check(__POS__, to_check, parse("28 29 30"), Ok(([28, 29], 30)));
    check(
      __POS__,
      to_check,
      parse("30 31 32 33"),
      Error("tokens remaining: (NUMBER 33.), EOF"),
    );
  }),
  test("<integer>{2,3}", () => {
    let parse = parse([%value "<integer>{2,3}"]);
    let to_check = result(list(int), Alcotest.string);
    check(__POS__, to_check, parse(""), Error("expected an integer"));
    check(__POS__, to_check, parse("33"), Error("expected an integer"));
    check(__POS__, to_check, parse("34 35"), Ok([34, 35]));
    check(__POS__, to_check, parse("36 37 38"), Ok([36, 37, 38]));
    check(
      __POS__,
      to_check,
      parse("39 40 41 42"),
      Error("tokens remaining: (NUMBER 42.), EOF"),
    );
  }),
  test("<integer>{2,}", () => {
    let parse = parse([%value "<integer>{2,}"]);
    let to_check = result(list(int), Alcotest.string);
    check(__POS__, to_check, parse(""), Error("expected an integer"));
    check(__POS__, to_check, parse("43"), Error("expected an integer"));
    check(__POS__, to_check, parse("44 45"), Ok([44, 45]));
    check(__POS__, to_check, parse("46 47 48"), Ok([46, 47, 48]));
    check(__POS__, to_check, parse("49 50 51 52"), Ok([49, 50, 51, 52]));
  }),
  test("<integer>#{2,3}", () => {
    let parse = parse([%value "<integer>#{2,3}"]);
    let to_check = result(list(int), Alcotest.string);
    check(__POS__, to_check, parse(""), Error("expected an integer"));
    check(
      __POS__,
      to_check,
      parse("53"),
      Error("Expected ',' but instead got the end"),
    );
    check(__POS__, to_check, parse("54, 55"), Ok([54, 55]));
    check(__POS__, to_check, parse("56, 57, 58"), Ok([56, 57, 58]));
    check(
      __POS__,
      to_check,
      parse("59, 60, 61,"),
      Error("tokens remaining: COMMA, EOF"),
    );
    check(
      __POS__,
      to_check,
      parse("59, 60, 61, 62"),
      Error("tokens remaining: COMMA, (NUMBER 62.), EOF"),
    );
  }),
  test("<integer>#{2}, <integer>", () => {
    let parse = parse([%value "<integer>#{2} ',' <integer>"]);
    let to_check = result(triple(list(int), unit, int), Alcotest.string);
    check(__POS__, to_check, parse(""), Error("expected an integer"));
    check(
      __POS__,
      to_check,
      parse("53"),
      Error("Expected ',' but instead got the end"),
    );
    check(
      __POS__,
      to_check,
      parse("54, 55"),
      Error("Expected ',' but instead got the end"),
    );
    check(__POS__, to_check, parse("56, 57, 58"), Ok(([56, 57], (), 58)));
    check(
      __POS__,
      to_check,
      parse("59, 60, 61,"),
      Error("tokens remaining: COMMA, EOF"),
    );
    check(
      __POS__,
      to_check,
      parse("59, 60, 61, 62"),
      Error("tokens remaining: COMMA, (NUMBER 62.), EOF"),
    );
  }),
  test("[<integer> A]{2,3}", () => {
    let parse = parse([%value "<integer>{2,3}"]);
    let to_check = result(list(int), Alcotest.string);
    check(__POS__, to_check, parse(""), Error("expected an integer"));
    check(__POS__, to_check, parse("63"), Error("expected an integer"));
    check(__POS__, to_check, parse("64 65"), Ok([64, 65]));
    check(__POS__, to_check, parse("66 67 68"), Ok([66, 67, 68]));
    /* TODO: Remove "tokens remaining" message */
    check(
      __POS__,
      to_check,
      parse("69 70 71 72"),
      Error("tokens remaining: (NUMBER 72.), EOF"),
    );
  }),
];

// TODO: at_least_one
// describe("at_least_one", ({test, _}) => {
//   test("[A? B?]!", `Quick, () => {
//     let parse = parse([%value "[A? B?]!"]);
//     let x = parse("A");
//     ();
//   })
// }),
