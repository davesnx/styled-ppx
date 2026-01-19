module type RULE = sig
  type t

  val rule : t Rule.rule
  val parse : string -> (t, string) result
  val to_string : t -> string
  val runtime_module_path : string option
  val extract_interpolations : t -> (string * string) list
end

type packed = Pack : (module RULE with type t = 'a) -> packed

let pack (module M : RULE) = Pack (module M)

let parse_with_rule rule input =
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
  match rule tokens_without_ws_and_eof with
  | Ok value, [] -> Ok value
  | Ok value, _ :: _ -> Ok value
  | Error errors, _ -> Error (String.concat "\n" errors)
