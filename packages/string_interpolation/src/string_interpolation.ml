module Location = Ppxlib.Location

type token =
  | String of string
  | Variable of string

let token_to_string = function
  | String s -> Printf.sprintf "String(%S)" s
  | Variable v -> Printf.sprintf "Variable(%S)" v

let[@warning "-32"] print_tokens tokens =
  List.iter (fun (p, _) -> print_endline (token_to_string p)) tokens

module Parser = struct
  let sub_lexeme ?(skip = 0) ?(drop = 0) lexbuf =
    let len = Sedlexing.lexeme_length lexbuf - skip - drop in
    Sedlexing.Utf8.sub_lexeme lexbuf skip len

  let letter = [%sedlex.regexp? 'a' .. 'z' | 'A' .. 'Z']

  let case_ident =
    [%sedlex.regexp?
      ('a' .. 'z' | '_' | '\''), Star (letter | '0' .. '9' | '_')]

  let ident = [%sedlex.regexp? (letter | '_'), Star (letter | '0' .. '9' | '_')]
  let variable = [%sedlex.regexp? Star (ident, '.'), case_ident]
  let whitespaces = [%sedlex.regexp? Star (' ' | '\t')]

  let interpolation =
    [%sedlex.regexp? "$(", whitespaces, variable, whitespaces, ")"]

  (* Match any non-'$' character, OR '$' followed by non-'(' *)
  let not_interpolation_start = [%sedlex.regexp? Compl '$' | '$', Compl '(']
  let text = [%sedlex.regexp? Plus not_interpolation_start]
  let standalone_dollar = [%sedlex.regexp? '$']

  (** Parse string, producing a list of tokens from this module. *)
  let from_string ~(loc : Location.t) (input : string) =
    let lexbuf = Sedlexing.Utf8.from_string input in
    let { loc_start; _ } : Location.t = loc in
    Sedlexing.set_position lexbuf loc_start;
    let rec parse acc lexbuf =
      match%sedlex lexbuf with
      | interpolation ->
        let variable = lexbuf |> sub_lexeme ~skip:2 ~drop:1 |> String.trim in
        parse (Variable variable :: acc) lexbuf
      | text ->
        let str = sub_lexeme lexbuf in
        parse (String str :: acc) lexbuf
      | standalone_dollar -> parse (String "$" :: acc) lexbuf
      | eof -> acc
      | _ ->
        let adjust base rel = Lexing.{ rel with pos_fname = base.pos_fname } in
        let loc_start, loc_end = Sedlexing.lexing_positions lexbuf in
        let loc =
          Ppxlib.Location.
            {
              loc_start = adjust loc.loc_start loc_start;
              loc_end = adjust loc.loc_start loc_end;
              loc_ghost = false;
            }
        in
        Location.raise_errorf ~loc
          "Internal error in 'String_interpolation.parse'"
    in
    List.rev @@ parse [] lexbuf
end

module Emitter = struct
  open Ppxlib
  open Ast_helper
  open Ast_builder.Default

  let loc = Location.none
  let with_loc ~loc txt = { loc; txt }

  let js_string_to_const ~attrs ~delimiter ~loc s =
    Exp.constant ~attrs ~loc (Const.string ~quotation_delimiter:delimiter s)

  let inline_const ~loc s = Exp.ident ~loc (with_loc s ~loc)
  let concat_fn = { txt = Lident "^"; loc = Location.none } |> Exp.ident ~loc

  let rec apply (func : expression) (args : (arg_label * expression) list) =
    match args with
    | [] -> assert false
    | [ (_, arg) ] -> arg
    | arg :: args ->
      let rest = apply func args in
      pexp_apply ~loc func [ arg; Nolabel, rest ]

  let to_arguments ~attrs ~delimiter tokens =
    List.rev
    @@ List.fold_left
         (fun acc token ->
           match acc, token with
           | ( ( Nolabel,
                 { pexp_desc = Pexp_constant (Pconst_string (s, _, _)); _ } )
               :: rest,
               String v ) ->
             (Nolabel, js_string_to_const ~attrs ~delimiter ~loc (s ^ v))
             :: rest
           | _, Variable v ->
             (Nolabel, v |> Longident.parse |> inline_const ~loc) :: acc
           | _, String v ->
             (Nolabel, js_string_to_const ~attrs ~delimiter ~loc v) :: acc)
         [] tokens

  let generate ~attrs ~delimiter tokens =
    match to_arguments ~attrs ~delimiter tokens with
    | [] ->
      pexp_extension ~loc:Location.none
      @@ Location.error_extensionf ~loc:Location.none "Missing string payload"
    | args -> apply concat_fn args
end

let transform ?(attrs = []) ~delimiter ~loc str =
  str |> Parser.from_string ~loc |> Emitter.generate ~delimiter ~attrs
