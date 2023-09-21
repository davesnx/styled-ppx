module Location = Ppxlib.Location;

/* Based on
 * https://github.com/smolkaj/ocaml-parsing/blob/master/src/LexBuffer.ml */

/** A custom lexbuffer that automatically keeps track of the source location.
    This module is a thin wrapper arounds sedlexing's default buffer, which does
    not provide this functionality. */

/** the lex buffer type */
type t = {
  buf: Sedlexing.lexbuf,
  mutable pos: Lexing.position,
  mutable pos_mark: Lexing.position,
  mutable last_char: option(int),
  mutable last_char_mark: option(int),
};

let of_sedlex = (~file="<n/a>", ~pos: option(Lexing.position)=?, buf) => {
  let pos =
    switch (pos) {
    | None => {
        Lexing.pos_fname: file,
        pos_lnum: 1, /* line number */
        pos_bol: 0, /* offset of beginning of current line */
        pos_cnum: 0 /* total offset */
      }
    | Some(p) => p
    };

  {buf, pos, pos_mark: pos, last_char: None, last_char_mark: None};
};

let container_lnum_ref = ref(0);

let from_string_of_sedlex = (~pos: option(Lexing.position)=?, string) => {
  let buf = Sedlexing.Latin1.from_string(string);
  switch (pos) {
  | Some(p) => Sedlexing.set_position(buf, p)
  | None => ()
  };
  of_sedlex(~pos?, buf);
};

let last_buffer = ref(from_string_of_sedlex(""));

let from_string = (~container_lnum=?, ~pos: option(Lexing.position)=?, s) => {
  switch (container_lnum) {
  | None => ()
  | Some(lnum) => container_lnum_ref := lnum
  };
  last_buffer := from_string_of_sedlex(~pos?, s);
  from_string_of_sedlex(~pos?, s);
};

/** The next four functions are used by sedlex internally.
    See https://www.lexifi.com/sedlex/libdoc/Sedlexing.html */

let mark = (lexbuf, p) => {
  lexbuf.pos_mark = lexbuf.pos;
  lexbuf.last_char_mark = lexbuf.last_char;
  Sedlexing.mark(lexbuf.buf, p);
};

let backtrack = lexbuf => {
  lexbuf.pos = lexbuf.pos_mark;
  lexbuf.last_char = lexbuf.last_char_mark;
  Sedlexing.backtrack(lexbuf.buf);
};

let start = lexbuf => {
  lexbuf.pos_mark = lexbuf.pos;
  lexbuf.last_char_mark = lexbuf.last_char;
  Sedlexing.start(lexbuf.buf);
};

let rollback = lexbuf => {
  lexbuf.pos_mark = lexbuf.pos;
  lexbuf.last_char_mark = lexbuf.last_char;
  Sedlexing.rollback(lexbuf.buf);
};

let __private__next_int = lexbuf => {
  lexbuf.pos_mark = lexbuf.pos;
  lexbuf.last_char_mark = lexbuf.last_char;
  Sedlexing.__private__next_int(lexbuf.buf);
};

/** location of next character */
let next_loc = lexbuf => {...lexbuf.pos, pos_cnum: lexbuf.pos.pos_cnum + 1};

let cr = Char.code('\r');

/** next character */
let next = lexbuf => {
  let c = Sedlexing.next(lexbuf.buf);
  let pos = next_loc(lexbuf);
  let ch =
    switch (c) {
    | None => None
    | Some(c) =>
      try(Some(Uchar.to_char(c))) {
      | Invalid_argument(_) => None
      }
    };

  let last_char =
    switch (lexbuf.last_char) {
    | None => 0
    | Some(c) => c
    };

  switch (ch) {
  | Some('\r') =>
    lexbuf.pos = {
      ...pos,
      pos_bol: pos.pos_cnum - 1,
      pos_lnum: pos.pos_lnum + 1,
    }
  | Some('\n') when !(last_char == cr) =>
    lexbuf.pos = {
      ...pos,
      pos_bol: pos.pos_cnum - 1,
      pos_lnum: pos.pos_lnum + 1,
    }
  | Some('\n') => ()
  | _ => lexbuf.pos = pos
  };
  switch (c) {
  | None => lexbuf.last_char = None
  | Some(c) => lexbuf.last_char = Some(Uchar.to_int(c))
  };
  c;
};

let latin1 = (~skip=0, ~drop=0, lexbuf) => {
  let len = Sedlexing.lexeme_length(lexbuf.buf) - skip - drop;
  Sedlexing.Latin1.sub_lexeme(lexbuf.buf, skip, len);
};

let utf8 = (~skip=0, ~drop=0, lexbuf) => {
  let len = Sedlexing.lexeme_length(lexbuf.buf) - skip - drop;
  Sedlexing.Utf8.sub_lexeme(lexbuf.buf, skip, len);
};

let container_lnum_ref = ref(0);

let make_loc =
    (~loc_ghost=false, start_pos: Lexing.position, end_pos: Lexing.position)
    : Location.t => {
  loc_start: start_pos,
  loc_end: end_pos,
  loc_ghost,
};

let lexing_positions = buf => Sedlexing.lexing_positions(buf.buf);
