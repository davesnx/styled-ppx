include Parser;
module Standard = Standard;
let parse = (prop, str) => {
  let (output, _) =
    Sedlexing.Utf8.from_string(str) |> Lexer.read_all |> prop;
  output;
};
