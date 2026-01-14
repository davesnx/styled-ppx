type 'a t = {
  rule : 'a Rule.rule;
  extract_interpolations : 'a -> (string * string) list;
  runtime_module_path : string option;
}

let make ?runtime_module_path ~extract_interpolations rule =
  { rule; extract_interpolations; runtime_module_path }

type packed = Pack : 'a t -> packed

let pack spec = Pack spec

let parse ?(strict = false) spec input =
  let tokens_with_loc = Styled_ppx_css_parser.Lexer.from_string input in
  let tokens =
    List.filter_map
      (fun (twl : Styled_ppx_css_parser.Lexer.token_with_location) ->
        match twl.txt with Ok tok -> Some tok | Error _ -> None)
      tokens_with_loc
  in
  let tokens_without_ws_and_eof =
    List.filter
      (fun tok ->
        tok <> Styled_ppx_css_parser.Parser.WS
        && tok <> Styled_ppx_css_parser.Parser.EOF)
      tokens
  in
  match spec.rule tokens_without_ws_and_eof with
  | Ok value, [] -> Ok value
  | Ok _, remaining when strict ->
    Error
      (Printf.sprintf "Unexpected tokens remaining: %d" (List.length remaining))
  | Ok value, _ :: _ -> Ok value
  | Error errors, _ -> Error (String.concat "\n" errors)

let extract_interpolations spec value = spec.extract_interpolations value
