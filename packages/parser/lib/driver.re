module Location = Ppxlib.Location;

let menhir = MenhirLib.Convert.Simplified.traditional2revised;

let make_state = (~initial_mode): Lexer_context.lexer_state => {
  mode: initial_mode,
  paren_depth: 0,
  brace_depth: 0,
  bracket_depth: 0,
  last_was_ident: false,
  last_was_combinator: false,
  last_was_delimiter: false,
};

let parse =
    (
      ~loc: Ppxlib.location,
      ~initial_mode: Lexer_context.lexer_mode,
      lexbuf,
      parser,
    ) => {
  let state = make_state(~initial_mode);
  let last_token = ref((Tokens.EOF, Lexing.dummy_pos, Lexing.dummy_pos));

  let next_token = () => {
    last_token := Lexer.get_next_tokens_with_location(~state, lexbuf);
    last_token^;
  };

  try(Ok(menhir(parser, next_token))) {
  | Lexer.LexingError((start_pos, end_pos, msg)) =>
    let loc = Parser_location.to_ppxlib_location(start_pos, end_pos);
    Error((loc, msg));
  | _ =>
    let (token, start_pos, end_pos) = last_token^;
    let token_loc = Parser_location.to_ppxlib_location(start_pos, end_pos);
    let loc = Parser_location.update_pos_lnum(token_loc, loc);
    let msg =
      Printf.sprintf(
        "Parse error while reading token '%s'",
        Tokens.humanize(token),
      );
    Error((loc, msg));
  };
};

let last_buffer = ref(None);

let parse_string = (~loc, ~initial_mode, parser, string) => {
  let buffer = Sedlexing.Latin1.from_string(string);
  last_buffer := Some(Sedlexing.Latin1.from_string(string));
  parse(~loc, ~initial_mode, buffer, parser);
};

let parse_declaration_list = (~loc, input: string) => {
  parse_string(
    ~loc,
    ~initial_mode=Lexer_context.Declaration_block,
    Parser.declaration_list,
    input,
  );
};

let parse_declaration = (~loc, input: string) =>
  parse_string(
    ~loc,
    ~initial_mode=Lexer_context.Declaration_block,
    Parser.declaration,
    input,
  );

let parse_stylesheet = (~loc, input: string) =>
  parse_string(
    ~loc,
    ~initial_mode=Lexer_context.Toplevel,
    Parser.stylesheet,
    input,
  );

let parse_keyframes = (~loc, input: string) =>
  parse_string(
    ~loc,
    ~initial_mode=Lexer_context.Toplevel,
    Parser.keyframes,
    input,
  );
