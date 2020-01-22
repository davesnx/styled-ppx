(* Based on
 * https://github.com/smolkaj/ocaml-parsing/blob/master/src/LexBuffer.ml *)

(** A custom lexbuffer that automatically keeps track of the source location.
    This module is a thin wrapper arounds sedlexing's default buffer, which does
    not provide this functionality. *)

(** the lex buffer type *)
type t =
  { buf: Sedlexing.lexbuf
  ; mutable pos: Lexing.position
  ; mutable pos_mark: Lexing.position
  ; mutable last_char: int option
  ; mutable last_char_mark: int option }

let of_sedlex ?(file= "<n/a>") ?pos buf =
  let pos =
    match pos with
    | None ->
      { Lexing.pos_fname= file
      ; pos_lnum= 1
      ; (* line number *)
        pos_bol= 0
      ; (* offset of beginning of current line *)
        pos_cnum= 0 (* total offset *) }
    | Some p -> p
  in
  {buf; pos; pos_mark= pos; last_char= None; last_char_mark= None}


let of_ascii_string ?pos s = of_sedlex ?pos (Sedlexing.Latin1.from_string s)

let of_ascii_file file =
  let chan = open_in file in
  of_sedlex ~file (Sedlexing.Latin1.from_channel chan)


(** The next four functions are used by sedlex internally.
    See https://www.lexifi.com/sedlex/libdoc/Sedlexing.html.  *)
let mark lexbuf p =
  lexbuf.pos_mark <- lexbuf.pos ;
  lexbuf.last_char_mark <- lexbuf.last_char ;
  Sedlexing.mark lexbuf.buf p


let backtrack lexbuf =
  lexbuf.pos <- lexbuf.pos_mark ;
  lexbuf.last_char <- lexbuf.last_char_mark ;
  Sedlexing.backtrack lexbuf.buf


let start lexbuf =
  lexbuf.pos_mark <- lexbuf.pos ;
  lexbuf.last_char_mark <- lexbuf.last_char ;
  Sedlexing.start lexbuf.buf


(** location of next character *)
let next_loc lexbuf = {lexbuf.pos with pos_cnum= lexbuf.pos.pos_cnum + 1}

let cr = Char.code '\r'

(** next character *)
let next lexbuf =
  let c = Sedlexing.next lexbuf.buf in
  let pos = next_loc lexbuf in
  let ch = match c with
    | None -> None
    | Some c ->
      try Some (Uchar.to_char c) with Invalid_argument _ -> None in
  begin match ch with
    | Some '\r' ->
      lexbuf.pos
      <- {pos with pos_bol= pos.pos_cnum - 1; pos_lnum= pos.pos_lnum + 1}
    | Some '\n' when not (lexbuf.last_char = Some cr) ->
      lexbuf.pos
      <- {pos with pos_bol= pos.pos_cnum - 1; pos_lnum= pos.pos_lnum + 1}
    | Some '\n' -> ()
    | _ -> lexbuf.pos <- pos
  end;
  begin match c with
    | None -> lexbuf.last_char <- None
    | Some c -> lexbuf.last_char <- Some (Uchar.to_int c)
  end;
  c


let raw lexbuf = Sedlexing.lexeme lexbuf.buf

let latin1 ?(skip= 0) ?(drop= 0) lexbuf =
  let len = Sedlexing.lexeme_length lexbuf.buf - skip - drop in
  Sedlexing.Latin1.sub_lexeme lexbuf.buf skip len


let utf8 ?(skip= 0) ?(drop= 0) lexbuf =
  let len = Sedlexing.lexeme_length lexbuf.buf - skip - drop in
  Sedlexing.Utf8.sub_lexeme lexbuf.buf skip len

let container_lnum_ref = ref 0

let fix_loc loc =
  let fix_pos pos =
    (* It looks like lex_buffer.ml returns a position with 2 extra
     * chars for parsed lines after the first one. Bug? *)
    let pos_cnum = if pos.Lexing.pos_lnum > !container_lnum_ref then
        pos.Lexing.pos_cnum - 2
      else
        pos.Lexing.pos_cnum in
    { pos with
        Lexing.pos_cnum;
    } in
  let loc_start = fix_pos loc.Location.loc_start in
  let loc_end = fix_pos loc.Location.loc_end in
  { loc with
      Location.loc_start;
      loc_end;
  }

let make_loc ?(loc_ghost=false) start_pos end_pos : Location.t =
  { Location.loc_start= start_pos;
    loc_end = end_pos;
    loc_ghost
  }

let make_loc_and_fix ?(loc_ghost=false) start_pos end_pos : Location.t =
  make_loc ~loc_ghost start_pos end_pos |> fix_loc
