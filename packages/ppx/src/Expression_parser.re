open Ppxlib;

let parse_expression = (~loc, ~source) => {
  let lexbuf = Lexing.from_string(source);
  let result =
    try(Ok(Parse.expression(lexbuf))) {
    | exn => Error(Printexc.to_string(exn))
    };
  Result.map(
    Styled_ppx_css_parser.Parser_location.relocate_expression(loc),
    result,
  );
};
