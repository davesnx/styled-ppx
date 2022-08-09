module Parser = struct
  type token = String of string | Variable of string

  let token_to_string = function
    | String s -> "String(" ^ s ^ ")"
    | Variable v -> "Variable(" ^ v ^ ")"

  let _print_tokens tokens =
    List.iter (fun (p, _) -> print_endline (token_to_string p)) tokens

  let lexeme ?(skip = 0) ?(drop = 0) lexbuf =
    let len = Sedlexing.lexeme_length lexbuf - skip - drop in
    Sedlexing.Utf8.sub_lexeme lexbuf skip len

  (** Parse string, producing a list of tokens from this module. *)
  let from_string ~(loc : Location.t) (str : string) =
    let lexbuf = Sedlexing.Utf8.from_string str in
    Sedlexing.set_position lexbuf loc.loc_start;
    let loc (lexbuf : Sedlexing.lexbuf) =
      let adjust base rel = Lexing.{ rel with pos_fname = base.pos_fname } in
      let loc_start, loc_end = Sedlexing.lexing_positions lexbuf in
      Location.
        {
          loc_start = adjust loc.loc_start loc_start;
          loc_end = adjust loc.loc_start loc_end;
          loc_ghost = false;
        }
    in
    let raise_error lexbuf msg = Location.raise_errorf ~loc:(loc lexbuf) msg in
    let rec parse acc lexbuf =
      let letter = [%sedlex.regexp? 'a' .. 'z' | 'A' .. 'Z'] in
      let ident =
        [%sedlex.regexp? (letter | '_'), Star (letter | '0' .. '9' | '_')]
      in
      let case_ident =
        [%sedlex.regexp?
          ('a' .. 'z' | '_' | '\''), Star (letter | '0' .. '9' | '_')]
      in
      let variable = [%sedlex.regexp? Star (ident, '.'), case_ident] in
      let interpolation = [%sedlex.regexp? "$(", variable, ")"] in
      let rest = [%sedlex.regexp? Plus (Compl '$')] in
      match%sedlex lexbuf with
      | interpolation ->
          parse
            ((Variable (lexeme ~skip:2 ~drop:1 lexbuf), loc lexbuf) :: acc)
            lexbuf
      | rest -> parse ((String (lexeme lexbuf), loc lexbuf) :: acc) lexbuf
      | eof -> acc
      | _ -> raise_error lexbuf "Internal error in 'string_to_tokens'"
    in
    List.rev @@ parse [] lexbuf
end

module Emitter = struct
  open Ppxlib
  open Ast_helper
  open Ast_builder.Default

  type element = string * Location.t
  type token = String of element | Variable of element * element option

  let token_to_string = function
    | String (s, _) -> s
    | Variable ((v, _), _) -> "$(" ^ v ^ ")"

  let _print_tokens = List.iter (fun p -> print_string (token_to_string p))
  let loc = Location.none
  let with_loc ~loc txt = { loc; txt }

  let js_string_to_const ~loc s =
    Exp.constant ~loc (Const.string ~quotation_delimiter:"js" s)

  let inline_const ~loc s = Exp.ident ~loc (with_loc s ~loc)
  let concat_fn = { txt = Lident "^"; loc = Location.none } |> Exp.ident ~loc

  let rec apply (func : expression) (args : (arg_label * expression) list) =
    match args with
    | [] -> assert false
    | [ (_, arg) ] -> arg
    | arg :: args ->
        let rest = apply func args in
        pexp_apply ~loc func [ arg; (Nolabel, rest) ]

  let to_arguments tokens =
    List.rev
    @@ List.fold_left
         (fun acc token ->
           match token with
           | Variable ((v, loc), _) ->
               (Nolabel, v |> Longident.parse |> inline_const ~loc) :: acc
           | String (v, loc) -> (Nolabel, js_string_to_const ~loc v) :: acc)
         [] tokens

  (* Copied from future version of ppxlib https://github.com/ocaml-ppx/ppxlib/blob/6857ca9ec803f16975e8c2e7984c35cfb50c4a5d/ast/location_error.ml *)
  let error_extension msg =
    let err_extension_name loc = { Location.loc; txt = "ocaml.error" } in
    let constant = Str.eval (Exp.constant (Const.string msg)) in
    (err_extension_name loc, PStr [ constant ])

  let generate tokens =
    match to_arguments tokens with
    | [] ->
        pexp_extension ~loc:Location.none
        @@ error_extension "Missing string payload"
    | args -> apply concat_fn args
end

let parser_to_emitter (tokens : (Parser.token * Location.t) list) :
    Emitter.token list =
  List.rev @@ snd
  @@ List.fold_left
       (fun (cur_fmt, acc) (token, loc) ->
         match (token, cur_fmt) with
         | Parser.Variable v, curr_fmt ->
             (None, Emitter.Variable ((v, loc), curr_fmt) :: acc)
         | _, Some (_, loc) ->
             Location.raise_errorf ~loc
               "Format is not followed by variable/expression. Missing %%?"
         | Parser.String s, None -> (None, Emitter.String (s, loc) :: acc))
       (None, []) tokens

let transform ~loc str =
  str |> Parser.from_string ~loc |> parser_to_emitter |> Emitter.generate
