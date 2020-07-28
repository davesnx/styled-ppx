let (let.ok) = Result.bind;
let parse_tokens = (prop, tokens_with_loc) => {
  open Standard;
  open Reason_css_lexer;

  let tokens =
    tokens_with_loc
    |> List.map(({Location.txt, _}) =>
         switch (txt) {
         | Ok(token) => token
         | Error((token, _)) => token
         }
       )
    |> List.filter((!=)(WHITESPACE))
    |> List.rev;
  let (output, tokens) = prop(tokens);

  let.ok output = output;
  let.ok () =
    switch (tokens) {
    | []
    | [EOF] => Ok()
    | tokens =>
      let tokens = List.map(show_token, tokens) |> String.concat(" * ");
      Error("tokens remaining: " ++ tokens);
    };
  Ok(output);
};
let parse = (prop, str) => {
  let.ok tokens_with_loc =
    Reason_css_lexer.from_string(str) |> Result.map_error(_ => "frozen");
  parse_tokens(prop, tokens_with_loc);
};
