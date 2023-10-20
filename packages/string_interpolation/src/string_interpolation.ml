module Location = Ppxlib.Location

type token =
  | String of string
  | Variable of string

let token_to_string = function
  | String s -> "String(" ^ s ^ ")"
  | Variable v -> "Variable(" ^ v ^ ")"

let print_tokens tokens =
  List.iter (fun (p, _) -> print_endline (token_to_string p)) tokens
[@@warning "-32"]

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
  let interpolation = [%sedlex.regexp? "$(", variable, ")"]
  let rest = [%sedlex.regexp? Plus (Compl '$')]

  (** Parse string, producing a list of tokens from this module. *)
  let from_string ~(loc : Location.t) (input : string) =
    let lexbuf = Sedlexing.Utf8.from_string input in
    Sedlexing.set_position lexbuf loc.loc_start;
    let rec parse acc lexbuf =
      match%sedlex lexbuf with
      | rest ->
        let str = sub_lexeme lexbuf in
        parse (String str :: acc) lexbuf
      | any ->
        let str = sub_lexeme lexbuf in
        parse (String str :: acc) lexbuf
      | interpolation ->
        let variable = sub_lexeme ~skip:2 ~drop:1 lexbuf in
        parse (Variable variable :: acc) lexbuf
      | eof -> acc
      | _ ->
        let adjust base rel = Lexing.{ rel with pos_fname = base.pos_fname } in
        let loc_start, loc_end = Sedlexing.lexing_positions lexbuf in
        let loc =
          Location.
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
           match token with
           | Variable v ->
             (Nolabel, v |> Longident.parse |> inline_const ~loc) :: acc
           | String v ->
             (Nolabel, js_string_to_const ~attrs ~delimiter ~loc v) :: acc)
         [] tokens

  (* Copied from future version of ppxlib https://github.com/ocaml-ppx/ppxlib/blob/6857ca9ec803f16975e8c2e7984c35cfb50c4a5d/ast/location_error.ml *)
  let error_extension msg =
    let err_extension_name loc = { Location.loc; txt = "ocaml.error" } in
    let constant = Str.eval (Exp.constant (Const.string msg)) in
    err_extension_name loc, PStr [ constant ]

  let generate ~attrs ~delimiter tokens =
    match to_arguments ~attrs ~delimiter tokens with
    | [] ->
      pexp_extension ~loc:Location.none
      @@ error_extension "Missing string payload"
    | args -> apply concat_fn args
end

(* This is currently a hack, since we can't diferentiate between sedlexes' rest
   and interpolation, it generates different tokens. Here we "join" them back *)
let optimize_strings tokens =
  List.fold_left
    (fun acc token ->
      match acc with
      | [] -> [ token ]
      | String s :: rest -> begin
        match token with
        | String s' -> String (s ^ s') :: rest
        | _ -> token :: acc
      end
      | _ -> token :: acc)
    [] tokens
  |> List.rev

let transform ?(attrs = []) ~delimiter ~loc str =
  str
  |> Parser.from_string ~loc
  |> optimize_strings
  |> Emitter.generate ~delimiter ~attrs
