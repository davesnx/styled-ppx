module Css_types = Css_types;
module Css_lexer = Css_lexer;
module Css_parser = Css_parser;
module Lex_buffer = Lex_buffer;
module New_css_parser = New_css_parser;
module New_css_types = New_css_types;
module Selectors_parser = Selectors_parser;
module Helpers = Helpers;

open Location;
open New_css_types;

let parse = (f, string) => {
  let buf =
    Reason_css_lexer.from_string(string)
    |> Result.get_ok
    |> List.map(({txt, loc}) =>
         switch (txt) {
         | Ok(txt) => {txt, loc}
         | Error((txt, _)) => {txt, loc}
         }
       )
    |> List.map(Helpers.from_lexer)
    |> List.rev;
  let buf = ref(buf);
  let next = () => {
    let {txt: token, loc: {loc_start, loc_end, _}} =
      switch (buf^) {
      | [token, ...new_buf] =>
        buf := new_buf;
        token;
      | [] => {txt: EOF, loc: Location.none}
      };
    (token, loc_start, loc_end);
  };
  // TODO: trim
  let f = MenhirLib.Convert.Simplified.traditional2revised(f);
  f(next);
};

let parse_rule = parse(New_css_parser.parse_rule);
