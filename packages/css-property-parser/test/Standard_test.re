open Alcotest;
open Css_property_parser;
open Combinator;
open Standard;
open Modifier;
open Parser;
open Rule.Match;

let check = (location, testable, recived, expected) =>
  check(~pos=location, testable, "", expected, recived);

let test = (title, body) => test_case(title, `Quick, body);

let tests = [
  // TODO: case insensitive
  test("integer", () => {
    let parse = parse([%value "<integer>"]);
    check(__POS__, result(int, Alcotest.string), parse("54"), Ok(54));
    check(
      __POS__,
      result(int, Alcotest.string),
      parse("54.4"),
      Error("expected an integer, received a float"),
    );
    check(
      __POS__,
      result(int, Alcotest.string),
      parse("ident"),
      Error("expected an integer"),
    );
  }),
  test("<number>", () => {
    let parse = parse([%value "<number>"]);
    check(
      __POS__,
      result(float(1.), Alcotest.string),
      parse("55"),
      Ok(55.),
    );
    check(
      __POS__,
      result(float(1.), Alcotest.string),
      parse("55.5"),
      Ok(55.5),
    );
    check(
      __POS__,
      result(float(1.), Alcotest.string),
      parse("ident"),
      Error("expected a number, receveid (IDENT \"ident\")"),
    );
  }),
  test("<length>", () => {
    let parse = parse([%value "<length>"]);
    let render_length = (x: Types.length) => {
      switch (x) {
      | `Cm(x) => string_of_float(x) ++ "cm"
      | `Cqw(x) => string_of_float(x) ++ "cqw"
      | `Cqh(x) => string_of_float(x) ++ "cqh"
      | `Cqi(x) => string_of_float(x) ++ "cqi"
      | `Cqb(x) => string_of_float(x) ++ "cqb"
      | `Cqmin(x) => string_of_float(x) ++ "cqmin"
      | `Cqmax(x) => string_of_float(x) ++ "cqmax"
      | `Em(x) => string_of_float(x) ++ "em"
      | `Ex(x) => string_of_float(x) ++ "ex"
      | `In(x) => string_of_float(x) ++ "in"
      | `Mm(x) => string_of_float(x) ++ "mm"
      | `Pc(x) => string_of_float(x) ++ "pc"
      | `Pt(x) => string_of_float(x) ++ "pt"
      | `Px(x) => string_of_float(x) ++ "px"
      | `Q(x) => string_of_float(x) ++ "q"
      | `Rem(x) => string_of_float(x) ++ "rem"
      | `Vh(x) => string_of_float(x) ++ "vh"
      | `Vmax(x) => string_of_float(x) ++ "vmax"
      | `Vmin(x) => string_of_float(x) ++ "vmin"
      | `Vw(x) => string_of_float(x) ++ "vw"
      | `Cap(n) => string_of_float(n) ++ "cap"
      | `Ch(n) => string_of_float(n) ++ "ch"
      | `Ic(n) => string_of_float(n) ++ "ic"
      | `Lh(n) => string_of_float(n) ++ "lh"
      | `Rlh(n) => string_of_float(n) ++ "rlh"
      | `Vb(n) => string_of_float(n) ++ "vb"
      | `Vi(n) => string_of_float(n) ++ "vi"
      | `Zero => "0"
      };
    };
    let pp_length = (ppf, x) => Fmt.pf(ppf, "%S", render_length(x));
    let length = testable(pp_length, (==));
    let to_check = result(length, Alcotest.string);
    check(__POS__, to_check, parse("56cm"), Ok(`Cm(56.)));
    check(__POS__, to_check, parse("57px"), Ok(`Px(57.)));
    check(
      __POS__,
      to_check,
      parse("59invalid"),
      Error("unknown dimension"),
    );
    check(__POS__, to_check, parse("0"), Ok(`Zero));
    check(__POS__, to_check, parse("60"), Error("expected length"));
  }),
  test("<angle>", () => {
    let parse = parse([%value "<angle>"]);
    let render_angle = (x: Types.angle) => {
      switch (x) {
      | `Deg(x) => string_of_float(x) ++ "deg"
      | `Grad(x) => string_of_float(x) ++ "grad"
      | `Rad(x) => string_of_float(x) ++ "rad"
      | `Turn(x) => string_of_float(x) ++ "turn"
      };
    };
    let pp_length = (ppf, x) => Fmt.pf(ppf, "%S", render_angle(x));
    let angle = testable(pp_length, (==));
    check(
      __POS__,
      result(angle, Alcotest.string),
      parse("1deg"),
      Ok(`Deg(1.)),
    );
    check(
      __POS__,
      result(angle, Alcotest.string),
      parse("0.2turn"),
      Ok(`Turn(0.2)),
    );
    check(
      __POS__,
      result(angle, Alcotest.string),
      parse("59px"),
      Error("unknown dimension"),
    );
    check(
      __POS__,
      result(angle, Alcotest.string),
      parse("0"),
      Ok(`Deg(0.)),
    );
    check(
      __POS__,
      result(angle, Alcotest.string),
      parse("60"),
      Error("expected angle"),
    );
  }),
  test("<time>", () => {
    let parse = parse([%value "<time>"]);
    let render_time = (x: Types.time) => {
      switch (x) {
      | `S(x) => string_of_float(x) ++ "s"
      | `Ms(x) => string_of_float(x) ++ "ms"
      };
    };
    let pp_length = (ppf, x) => Fmt.pf(ppf, "%S", render_time(x));
    let time = testable(pp_length, (==));
    check(
      __POS__,
      result(time, Alcotest.string),
      parse(".5s"),
      Ok(`S(0.5)),
    );
    check(
      __POS__,
      result(time, Alcotest.string),
      parse("50ms"),
      Ok(`Ms(50.)),
    );
    check(
      __POS__,
      result(time, Alcotest.string),
      parse("59px"),
      Error("unknown time unit"),
    );
    check(
      __POS__,
      result(time, Alcotest.string),
      parse("0"),
      Error("expected time"),
    );
    check(
      __POS__,
      result(time, Alcotest.string),
      parse("60"),
      Error("expected time"),
    );
  }),
  test("<frequency>", () => {
    let parse = parse([%value "<frequency>"]);
    let render_frequency = (x: Types.frequency) => {
      switch (x) {
      | `Hz(x) => string_of_float(x) ++ "hz"
      | `KHz(x) => string_of_float(x) ++ "khz"
      };
    };
    let pp_length = (ppf, x) => Fmt.pf(ppf, "%S", render_frequency(x));
    let frequency = testable(pp_length, (==));
    check(
      __POS__,
      result(frequency, Alcotest.string),
      parse("6hz"),
      Ok(`Hz(6.)),
    );
    check(
      __POS__,
      result(frequency, Alcotest.string),
      parse(".6kHz"),
      Ok(`KHz(0.6)),
    );
    check(
      __POS__,
      result(frequency, Alcotest.string),
      parse("59px"),
      Error("unknown dimension px"),
    );
    check(
      __POS__,
      result(frequency, Alcotest.string),
      parse("0"),
      Error("expected frequency. got(NUMBER 0.)"),
    );
    check(
      __POS__,
      result(frequency, Alcotest.string),
      parse("60"),
      Error("expected frequency. got(NUMBER 60.)"),
    );
  }),
  test("<resolution>", () => {
    let parse = parse([%value "<resolution>"]);
    let render_resolution = (x: Types.resolution) => {
      switch (x) {
      | `Dpi(x) => string_of_float(x) ++ "dpi"
      | `Dppx(x) => string_of_float(x) ++ "dppx"
      | `Dpcm(x) => string_of_float(x) ++ "dpcm"
      };
    };
    let pp_length = (ppf, x) => Fmt.pf(ppf, "%S", render_resolution(x));
    let resolution = testable(pp_length, (==));
    check(
      __POS__,
      result(resolution, Alcotest.string),
      parse("6x"),
      Ok(`Dppx(6.)),
    );
    check(
      __POS__,
      result(resolution, Alcotest.string),
      parse("3dpi"),
      Ok(`Dpi(3.)),
    );
    check(
      __POS__,
      result(resolution, Alcotest.string),
      parse("59px"),
      Error("unknown dimension"),
    );
    check(
      __POS__,
      result(resolution, Alcotest.string),
      parse("0"),
      Error("expected resolution"),
    );
    check(
      __POS__,
      result(resolution, Alcotest.string),
      parse("60"),
      Error("expected resolution"),
    );
  }),
  test("<percentage>", () => {
    let parse = parse([%value "<percentage>"]);
    check(
      __POS__,
      result(float(1.), Alcotest.string),
      parse("61%"),
      Ok(61.),
    );
    check(
      __POS__,
      result(float(1.), Alcotest.string),
      parse("62.3%"),
      Ok(62.3),
    );
    check(
      __POS__,
      result(float(1.), Alcotest.string),
      parse("63.4:"),
      Error("expected percentage"),
    );
  }),
  test("keyword", () => {
    let parse = parse([%value "gintoki"]);
    check(__POS__, result(unit, Alcotest.string), parse("gintoki"), Ok());
    check(
      __POS__,
      result(unit, Alcotest.string),
      parse("nope"),
      Error("Expected 'ident gintoki' but instead got ident nope"),
    );
  }),
  test("<ident>", () => {
    let parse = parse([%value "<ident>"]);
    let to_check = result(Alcotest.string, Alcotest.string);
    check(__POS__, to_check, parse("test"), Ok("test"));
    check(
      __POS__,
      to_check,
      parse("'ohno'"),
      Error("expected an indentifier"),
    );
  }),
  test("<css-wide-keywords>", () => {
    let parse = parse([%value "<css-wide-keywords>"]);
    let render_css_wide_keywords = x => {
      switch (x) {
      | `Initial => "initial"
      | `Inherit => "inherit"
      | `Unset => "unset"
      | `Revert => "revert"
      | `RevertLayer => "revert-layer"
      };
    };
    let pp_css_wide_keywords = (ppf, x) =>
      Fmt.pf(ppf, "%S", render_css_wide_keywords(x));
    let css_wide_keywords = testable(pp_css_wide_keywords, (==));
    check(
      __POS__,
      result(css_wide_keywords, Alcotest.string),
      parse("initial"),
      Ok(`Initial),
    );
    check(
      __POS__,
      result(css_wide_keywords, Alcotest.string),
      parse("inherit"),
      Ok(`Inherit),
    );
    check(
      __POS__,
      result(css_wide_keywords, Alcotest.string),
      parse("unset"),
      Ok(`Unset),
    );
    check(
      __POS__,
      result(css_wide_keywords, Alcotest.string),
      parse("revert"),
      Ok(`Revert),
    );
    check(
      __POS__,
      result(css_wide_keywords, Alcotest.string),
      parse("revert-layer"),
      Ok(`RevertLayer),
    );
    /* TODO: combine_xor should combine the error messages */
    check(
      __POS__,
      result(css_wide_keywords, Alcotest.string),
      parse("nope"),
      Error("Expected 'ident revert-layer' but instead got ident nope"),
    );
  }),
  test("<string>", () => {
    let parse = parse([%value "<string>"]);
    let to_check = result(Alcotest.string, Alcotest.string);
    check(__POS__, to_check, parse("'tuturu'"), Ok("tuturu"));
    check(__POS__, to_check, parse("'67.8'"), Ok("67.8"));
    check(__POS__, to_check, parse("ident"), Error("expected a string"));
    check(__POS__, to_check, parse("68.9"), Error("expected a string"));
  }),
  test("<dashed-ident>", () => {
    let parse = parse([%value "<dashed-ident>"]);
    let to_check = result(Alcotest.string, Alcotest.string);
    check(__POS__, to_check, parse("--random"), Ok("--random"));
    check(
      __POS__,
      to_check,
      parse("random'"),
      Error("expected a --variable"),
    );
  }),
  test("<url>", () => {
    let parse = parse([%value "<url>"]);
    let to_check = result(Alcotest.string, Alcotest.string);
    check(
      __POS__,
      to_check,
      parse("url(https://google.com)"),
      Ok("https://google.com"),
    );
    check(
      __POS__,
      to_check,
      parse("url(\"https://duckduckgo.com\")"),
      Ok("https://duckduckgo.com"),
    );
  }),
  // css-color-4
  test("<hex-color>", () => {
    let parse = parse([%value "<hex-color>"]);
    let to_check = result(Alcotest.string, Alcotest.string);
    check(__POS__, to_check, parse("#abc"), Ok("abc"));
    check(__POS__, to_check, parse("#abcdefgh"), Ok("abcdefgh"));
    check(
      __POS__,
      to_check,
      parse("#abcdefghi"),
      Error("expected a hex-color"),
    );
  }),
  test("<linenames>", () => {
    let parse = parse([%value "<line_names>"]);
    let to_check =
      result(triple(unit, list(Alcotest.string), unit), Alcotest.string);
    check(__POS__, to_check, parse("[abc]"), Ok(((), ["abc"], ())));
    check(__POS__, to_check, parse("[a b]"), Ok(((), ["a", "b"], ())));
    check(
      __POS__,
      to_check,
      parse("[a b c]"),
      Ok(((), ["a", "b", "c"], ())),
    );
  }),
  test("chars", () => {
    let parse = parse([%value "<string>? ',' <string>"]);
    let to_check =
      result(
        triple(option(Alcotest.string), unit, Alcotest.string),
        Alcotest.string,
      );
    check(
      __POS__,
      to_check,
      parse("'lola' , 'flores'"),
      Ok((Some("lola"), (), "flores")),
    );
  }),
  test("custom-ident vs all", () => {
    let parse = parse([%value "<custom-ident> | 'all'"]);
    let render_output = (x: [> | `All | `Custom_ident(string)]) => {
      switch (x) {
      | `All => "ALL"
      | `Custom_ident(ident) => Printf.sprintf("IDENT(%s)", ident)
      };
    };
    let pp_output = (ppf, x) => Fmt.pf(ppf, "%S", render_output(x));
    let output = testable(pp_output, (==));
    let to_check = result(output, Alcotest.string);
    check(__POS__, to_check, parse("all"), Ok(`All));
    check(__POS__, to_check, parse("moar"), Ok(`Custom_ident("moar")));
  }),
  test("interpolation", () => {
    let parse = parse([%value "<interpolation>"]);
    let to_check = result(list(Alcotest.string), Alcotest.string);
    check(
      __POS__,
      to_check,
      parse("$(Module.value)"),
      Ok(["Module", "value"]),
    );
    check(
      __POS__,
      to_check,
      parse("$(Module'.value')"),
      Ok(["Module'", "value'"]),
    );
    /* TODO: Add error message into interpolation */
    check(
      __POS__,
      to_check,
      parse("asd"),
      Error("Expected 'delimiter $' but instead got ident asd"),
    );
  }),
];
