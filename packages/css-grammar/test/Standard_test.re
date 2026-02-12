open Css_grammar;
open Parser;

let check = Alcotest_extra.check;

let render_angle = (x: angle) => {
  switch (x) {
  | `Deg(x) => string_of_float(x) ++ "deg"
  | `Grad(x) => string_of_float(x) ++ "grad"
  | `Rad(x) => string_of_float(x) ++ "rad"
  | `Turn(x) => string_of_float(x) ++ "turn"
  };
};

let tests = [
  // TODO: case insensitive
  test("integer", () => {
    let parse = parse([%spec "<integer>"]);
    check(
      ~__POS__,
      Alcotest.result(Alcotest.int, Alcotest.string),
      parse("54"),
      Ok(54),
    );
    check(
      ~__POS__,
      Alcotest.result(Alcotest.int, Alcotest.string),
      parse("54.4"),
      Error("Expected an integer, got a float instead."),
    );
    check(
      ~__POS__,
      Alcotest.result(Alcotest.int, Alcotest.string),
      parse("ident"),
      Error("Expected an integer."),
    );
  }),
  test("<number>", () => {
    let parse = parse([%spec "<number>"]);
    check(
      ~__POS__,
      Alcotest.result(Alcotest.float(1.), Alcotest.string),
      parse("55"),
      Ok(55.),
    );
    check(
      ~__POS__,
      Alcotest.result(Alcotest.float(1.), Alcotest.string),
      parse("55.5"),
      Ok(55.5),
    );
    check(
      ~__POS__,
      Alcotest.result(Alcotest.float(1.), Alcotest.string),
      parse("ident"),
      Error("Expected a number. Got 'ident' instead."),
    );
  }),
  test("<length>", () => {
    let parse = parse([%spec "<length>"]);
    let render_length = x => {
      switch (x) {
      | `Cap(n) => string_of_float(n) ++ "cap"
      | `Ch(n) => string_of_float(n) ++ "ch"
      | `Em(x) => string_of_float(x) ++ "em"
      | `Ex(x) => string_of_float(x) ++ "ex"
      | `Ic(n) => string_of_float(n) ++ "ic"
      | `Lh(n) => string_of_float(n) ++ "lh"
      | `Rcap(n) => string_of_float(n) ++ "rcap"
      | `Rch(n) => string_of_float(n) ++ "rch"
      | `Rem(x) => string_of_float(x) ++ "rem"
      | `Rex(x) => string_of_float(x) ++ "rex"
      | `Ric(n) => string_of_float(n) ++ "ric"
      | `Rlh(n) => string_of_float(n) ++ "rlh"
      | `Vh(x) => string_of_float(x) ++ "vh"
      | `Vw(x) => string_of_float(x) ++ "vw"
      | `Vmax(x) => string_of_float(x) ++ "vmax"
      | `Vmin(x) => string_of_float(x) ++ "vmin"
      | `Vb(n) => string_of_float(n) ++ "vb"
      | `Vi(n) => string_of_float(n) ++ "vi"
      | `Cqw(x) => string_of_float(x) ++ "cqw"
      | `Cqh(x) => string_of_float(x) ++ "cqh"
      | `Cqi(x) => string_of_float(x) ++ "cqi"
      | `Cqb(x) => string_of_float(x) ++ "cqb"
      | `Cqmin(x) => string_of_float(x) ++ "cqmin"
      | `Cqmax(x) => string_of_float(x) ++ "cqmax"
      | `Px(x) => string_of_float(x) ++ "px"
      | `Cm(x) => string_of_float(x) ++ "cm"
      | `Mm(x) => string_of_float(x) ++ "mm"
      | `Q(x) => string_of_float(x) ++ "q"
      | `In(x) => string_of_float(x) ++ "in"
      | `Pc(x) => string_of_float(x) ++ "pc"
      | `Pt(x) => string_of_float(x) ++ "pt"
      | `Zero => "0"
      };
    };
    let pp_length = (ppf, x) => Fmt.pf(ppf, "%S", render_length(x));
    let length = Alcotest.testable(pp_length, (==));
    let to_check = Alcotest.result(length, Alcotest.string);
    let expect = check(~__POS__, to_check);
    expect(parse("56cm"), Ok(`Cm(56.)));
    expect(parse("57px"), Ok(`Px(57.)));
    expect(parse("59invalid"), Error("Invalid length unit 'invalid'."));
    expect(parse("0"), Ok(`Zero));
    expect(parse("60"), Error("Expected length."));
  }),
  test("<angle>", () => {
    let parse = parse([%spec "<angle>"]);
    let pp_length = (ppf, x) => Fmt.pf(ppf, "%S", render_angle(x));
    let angle = Alcotest.testable(pp_length, (==));
    check(
      ~__POS__,
      Alcotest.result(angle, Alcotest.string),
      parse("1deg"),
      Ok(`Deg(1.)),
    );
    check(
      ~__POS__,
      Alcotest.result(angle, Alcotest.string),
      parse("0.2turn"),
      Ok(`Turn(0.2)),
    );
    check(
      ~__POS__,
      Alcotest.result(angle, Alcotest.string),
      parse("59px"),
      Error("Invalid angle unit 'px'."),
    );
    check(
      ~__POS__,
      Alcotest.result(angle, Alcotest.string),
      parse("0"),
      Ok(`Deg(0.)),
    );
    check(
      ~__POS__,
      Alcotest.result(angle, Alcotest.string),
      parse("60"),
      Error("Expected angle."),
    );
  }),
  test("<time>", () => {
    let parse = parse([%spec "<time>"]);
    let render_time = x => {
      switch (x) {
      | `S(x) => string_of_float(x) ++ "s"
      | `Ms(x) => string_of_float(x) ++ "ms"
      };
    };
    let pp_length = (ppf, x) => Fmt.pf(ppf, "%S", render_time(x));
    let time = Alcotest.testable(pp_length, (==));
    check(
      ~__POS__,
      Alcotest.result(time, Alcotest.string),
      parse(".5s"),
      Ok(`S(0.5)),
    );
    check(
      ~__POS__,
      Alcotest.result(time, Alcotest.string),
      parse("50ms"),
      Ok(`Ms(50.)),
    );
    check(
      ~__POS__,
      Alcotest.result(time, Alcotest.string),
      parse("59px"),
      Error("Invalid time unit 'px'."),
    );
    check(
      ~__POS__,
      Alcotest.result(time, Alcotest.string),
      parse("0"),
      Error("Expected time."),
    );
    check(
      ~__POS__,
      Alcotest.result(time, Alcotest.string),
      parse("60"),
      Error("Expected time."),
    );
  }),
  test("<frequency>", () => {
    let parse = parse([%spec "<frequency>"]);
    let render_frequency = x => {
      switch (x) {
      | `Hz(x) => string_of_float(x) ++ "hz"
      | `KHz(x) => string_of_float(x) ++ "khz"
      };
    };
    let pp_length = (ppf, x) => Fmt.pf(ppf, "%S", render_frequency(x));
    let frequency = Alcotest.testable(pp_length, (==));
    check(
      ~__POS__,
      Alcotest.result(frequency, Alcotest.string),
      parse("6hz"),
      Ok(`Hz(6.)),
    );
    check(
      ~__POS__,
      Alcotest.result(frequency, Alcotest.string),
      parse(".6kHz"),
      Ok(`KHz(0.6)),
    );
    check(
      ~__POS__,
      Alcotest.result(frequency, Alcotest.string),
      parse("59px"),
      Error("Invalid frequency unit 'px'."),
    );
    check(
      ~__POS__,
      Alcotest.result(frequency, Alcotest.string),
      parse("0"),
      Error("Expected frequency."),
    );
    check(
      ~__POS__,
      Alcotest.result(frequency, Alcotest.string),
      parse("60"),
      Error("Expected frequency."),
    );
  }),
  test("<resolution>", () => {
    let parse = parse([%spec "<resolution>"]);
    let render_resolution = x => {
      switch (x) {
      | `Dpi(x) => string_of_float(x) ++ "dpi"
      | `Dppx(x) => string_of_float(x) ++ "dppx"
      | `Dpcm(x) => string_of_float(x) ++ "dpcm"
      };
    };
    let pp_length = (ppf, x) => Fmt.pf(ppf, "%S", render_resolution(x));
    let resolution = Alcotest.testable(pp_length, (==));
    check(
      ~__POS__,
      Alcotest.result(resolution, Alcotest.string),
      parse("6x"),
      Ok(`Dppx(6.)),
    );
    check(
      ~__POS__,
      Alcotest.result(resolution, Alcotest.string),
      parse("3dpi"),
      Ok(`Dpi(3.)),
    );
    check(
      ~__POS__,
      Alcotest.result(resolution, Alcotest.string),
      parse("59px"),
      Error("Invalid resolution unit 'px'."),
    );
    check(
      ~__POS__,
      Alcotest.result(resolution, Alcotest.string),
      parse("0"),
      Error("Expected resolution."),
    );
    check(
      ~__POS__,
      Alcotest.result(resolution, Alcotest.string),
      parse("60"),
      Error("Expected resolution."),
    );
  }),
  test("<percentage>", () => {
    let parse = parse([%spec "<percentage>"]);
    check(
      ~__POS__,
      Alcotest.result(Alcotest.float(1.), Alcotest.string),
      parse("61%"),
      Ok(61.),
    );
    check(
      ~__POS__,
      Alcotest.result(Alcotest.float(1.), Alcotest.string),
      parse("62.3%"),
      Ok(62.3),
    );
    check(
      ~__POS__,
      Alcotest.result(Alcotest.float(1.), Alcotest.string),
      parse("63.4:"),
      Error("Expected a percentage."),
    );
  }),
  test("keyword", () => {
    let parse = parse([%spec "gintoki"]);
    check(
      ~__POS__,
      Alcotest.result(Alcotest.unit, Alcotest.string),
      parse("gintoki"),
      Ok(),
    );
    check(
      ~__POS__,
      Alcotest.result(Alcotest.unit, Alcotest.string),
      parse("nope"),
      Error("Expected 'gintoki' but instead got 'nope'."),
    );
  }),
  test("<ident>", () => {
    let parse = parse([%spec "<ident>"]);
    let to_check = Alcotest.result(Alcotest.string, Alcotest.string);
    let expect = check(~__POS__, to_check);
    expect(parse("test"), Ok("test"));
    expect(parse("'ohno'"), Error("Expected an indentifier."));
  }),
  test("<css-wide-keywords>", () => {
    let parse = parse([%spec "<css-wide-keywords>"]);
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
    let css_wide_keywords = Alcotest.testable(pp_css_wide_keywords, (==));
    check(
      ~__POS__,
      Alcotest.result(css_wide_keywords, Alcotest.string),
      parse("initial"),
      Ok(`Initial),
    );
    check(
      ~__POS__,
      Alcotest.result(css_wide_keywords, Alcotest.string),
      parse("inherit"),
      Ok(`Inherit),
    );
    check(
      ~__POS__,
      Alcotest.result(css_wide_keywords, Alcotest.string),
      parse("unset"),
      Ok(`Unset),
    );
    check(
      ~__POS__,
      Alcotest.result(css_wide_keywords, Alcotest.string),
      parse("revert"),
      Ok(`Revert),
    );
    check(
      ~__POS__,
      Alcotest.result(css_wide_keywords, Alcotest.string),
      parse("revert-layer"),
      Ok(`RevertLayer),
    );
    check(
      ~__POS__,
      Alcotest.result(css_wide_keywords, Alcotest.string),
      parse("nope"),
      Error(
        {|Got 'nope', expected 'inherit', 'initial', 'revert', 'revert-layer', or 'unset'.|},
      ),
    );
  }),
  test("<string>", () => {
    let parse = parse([%spec "<string>"]);
    let to_check = Alcotest.result(Alcotest.string, Alcotest.string);
    let expect = check(~__POS__, to_check);
    expect(parse({|'tuturu'|}), Ok("tuturu"));
    expect(parse({|'67.8'|}), Ok("67.8"));
    expect(parse({|ident|}), Error("Expected a string."));
    expect(parse({|68.9|}), Error("Expected a string."));
    expect(parse({|"this is a 'string'."|}), Ok("this is a 'string'."));
    expect(parse({|""|}), Ok(""));
    expect(parse({|''|}), Ok(""));
    expect(parse({|" "|}), Ok(" "));
    expect(parse({|'"'|}), Ok("\""));
    expect(parse({|' '|}), Ok(" "));
    expect(parse({|"this is a \"string\"."|}), Ok("this is a \"string\"."));
    expect(parse({|'this is a "string".'|}), Ok("this is a \"string\"."));
    expect(parse({|'this is a \'string\'.'|}), Ok("this is a \'string\'."));
  }),
  test("<dashed-ident>", () => {
    let parse = parse([%spec "<dashed-ident>"]);
    let to_check = Alcotest.result(Alcotest.string, Alcotest.string);
    let expect = check(~__POS__, to_check);
    expect(parse("--random"), Ok("--random"));
    expect(parse("random'"), Error("Expected a --variable."));
  }),
  test("<url-no-interp>", () => {
    let parse = parse([%spec "<url-no-interp>"]);
    let to_check = Alcotest.result(Alcotest.string, Alcotest.string);
    let expect = check(~__POS__, to_check);
    expect(parse("url(https://google.com)"), Ok("https://google.com"));
    expect(
      parse("url(\"https://duckduckgo.com\")"),
      Ok("https://duckduckgo.com"),
    );
  }),
  // css-color-4
  test("<hex-color>", () => {
    let parse = parse([%spec "<hex-color>"]);
    let to_check = Alcotest.result(Alcotest.string, Alcotest.string);
    let expect = check(~__POS__, to_check);
    expect(parse("#abc"), Ok("abc"));
    expect(parse("#abcdefgh"), Ok("abcdefgh"));
    expect(parse("#abcdefghi"), Error("Expected a hex-color."));
  }),
  test("<linenames>", () => {
    let parse = parse([%spec "'[' <custom-ident>+ ']'"]);
    /* Static combinator uses unwrapped custom_ident (string) directly */
    let to_check =
      Alcotest.result(
        Alcotest.triple(
          Alcotest.unit,
          Alcotest.list(Alcotest.string),
          Alcotest.unit,
        ),
        Alcotest.string,
      );
    let expect = check(~__POS__, to_check);
    expect(parse("[abc]"), Ok(((), ["abc"], ())));
    expect(parse("[a b]"), Ok(((), ["a", "b"], ())));
    expect(parse("[a b c]"), Ok(((), ["a", "b", "c"], ())));
  }),
  test("chars", () => {
    let parse = parse([%spec "<string>? ',' <string>"]);
    /* Static combinator already unwraps string_token, so no need to unwrap again */
    let to_check =
      Alcotest.result(
        Alcotest.triple(
          Alcotest.option(Alcotest.string),
          Alcotest.unit,
          Alcotest.string,
        ),
        Alcotest.string,
      );
    let expect = check(~__POS__, to_check);
    expect(parse("'lola' , 'flores'"), Ok((Some("lola"), (), "flores")));
  }),
  test("custom-ident vs all", () => {
    let parse = parse([%spec "<custom-ident> | 'all'"]);
    let render_output =
        (
          x: [>
            | `All
            | `Custom_ident(string)
          ],
        ) => {
      switch (x) {
      | `All => "ALL"
      | `Custom_ident(ident) => Printf.sprintf("IDENT(%s)", ident)
      };
    };
    let pp_output = (ppf, x) => Fmt.pf(ppf, "%S", render_output(x));
    let output = Alcotest.testable(pp_output, (==));
    let to_check = Alcotest.result(output, Alcotest.string);
    let expect = check(~__POS__, to_check);
    expect(parse("all"), Ok(`All));
    expect(parse("moar"), Ok(`Custom_ident("moar")));
  }),
  test("interpolation", () => {
    let parse = parse([%spec "<interpolation>"]);
    let to_check =
      Alcotest.result(Alcotest.list(Alcotest.string), Alcotest.string);
    let expect = check(~__POS__, to_check);
    expect(parse("$(Module.value)"), Ok(["Module.value"]));
    expect(parse("$(Module'.value')"), Ok(["Module'.value'"]));
    /* TODO: Add error message into interpolation */
    expect(parse("asd"), Error("Expected interpolation."));
  }),
];
