open TestFramework;
open Reason_css_parser;
open Combinator;
open Standard;
open Modifier;
open Parser;

let parse_exn = (prop, str) =>
  switch (parse(prop, str)) {
  | Ok(data) => data
  | Error(message) => failwith(message)
  };

describe("optional", ({test, _}) => {
  test("<integer>?", ({expect, _}) => {
    let parse = parse_exn([%value "<integer>?"]);
    expect.option(parse("13")).toBe(Some(13));
    expect.option(parse("")).toBe(None);
  });
  test("[<integer> A]?", ({expect, _}) => {
    let parse = parse_exn([%value "[<integer> A]?"]);
    expect.option(parse("14 A")).toBe(Some((14, ())));
    expect.option(parse("")).toBe(None);
  });
});

describe("zero_or_more", ({test, _}) => {
  test("<integer>*", ({expect, _}) => {
    let parse = parse_exn([%value "<integer>*"]);
    expect.list(parse("")).toEqual([]);
    expect.list(parse("15")).toEqual([15]);
    expect.list(parse("16 17")).toEqual([16, 17]);
  });
  test("[<integer> A]?", ({expect, _}) => {
    let parse = parse_exn([%value "[<integer> A]*"]);
    expect.list(parse("")).toEqual([]);
    expect.list(parse("18 A")).toEqual([(18, ())]);
    expect.list(parse("19 A 20 A")).toEqual([(19, ()), (20, ())]);
  });
});

describe("one_or_more", ({test, _}) => {
  test("<integer>+", ({expect, _}) => {
    let parse = parse([%value "<integer>+"]);
    expect.result(parse("")).toBeError();
    expect.result(parse("21")).toBe(Ok([21]));
    expect.result(parse("22 23")).toBe(Ok([22, 23]));
  });
  test("[<integer> A]+", ({expect, _}) => {
    let parse = parse([%value "[<integer> A]+"]);
    expect.result(parse("")).toBeError();
    expect.result(parse("24 A")).toBe(Ok([(24, ())]));
    expect.result(parse("25 A 26 A")).toBe(Ok([(25, ()), (26, ())]));
  });
});

describe("repeat", ({test, _}) => {
  test("<integer>{2}", ({expect, _}) => {
    let parse = parse([%value "<integer>{2}"]);
    expect.result(parse("")).toBeError();
    expect.result(parse("27")).toBeError();
    expect.result(parse("28 29")).toBe(Ok([28, 29]));
    expect.result(parse("30 31 32")).toBeError();
  });
  test("<integer>{2,3}", ({expect, _}) => {
    let parse = parse([%value "<integer>{2,3}"]);
    expect.result(parse("")).toBeError();
    expect.result(parse("33")).toBeError();
    expect.result(parse("34 35")).toBe(Ok([34, 35]));
    expect.result(parse("36 37 38")).toBe(Ok([36, 37, 38]));
    expect.result(parse("39 40 41 42")).toBeError();
  });
  test("<integer>{2,}", ({expect, _}) => {
    let parse = parse([%value "<integer>{2,}"]);
    expect.result(parse("")).toBeError();
    expect.result(parse("43")).toBeError();
    expect.result(parse("44 45")).toBe(Ok([44, 45]));
    expect.result(parse("46 47 48")).toBe(Ok([46, 47, 48]));
    expect.result(parse("49 50 51 52")).toBe(Ok([49, 50, 51, 52]));
  });
  test("<integer>#{2,3}", ({expect, _}) => {
    let parse = parse([%value "<integer>#{2,3}"]);
    expect.result(parse("")).toBeError();
    expect.result(parse("53")).toBeError();
    expect.result(parse("54, 55")).toBe(Ok([54, 55]));
    expect.result(parse("56, 57, 58")).toBe(Ok([56, 57, 58]));
    expect.result(parse("59, 60, 61, 62")).toBeError();
  });
  test("[<integer> A]{2,3}", ({expect, _}) => {
    let parse = parse([%value "<integer>{2,3}"]);
    expect.result(parse("")).toBeError();
    expect.result(parse("63")).toBeError();
    expect.result(parse("64 65")).toBe(Ok([64, 65]));
    expect.result(parse("66 67 68")).toBe(Ok([66, 67, 68]));
    expect.result(parse("69 70 71 72")).toBeError();
  });
});

// TODO: at_least_one
// describe("at_least_one", ({test, _}) => {
//   test("[A? B?]!", ({expect, _}) => {
//     let parse = parse([%value "[A? B?]!"]);
//     let x = parse("A");
//     ();
//   })
// });
