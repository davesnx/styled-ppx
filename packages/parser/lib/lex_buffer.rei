type t = {
  buf: Sedlexing.lexbuf,
  mutable pos: Lexing.position,
  mutable pos_mark: Lexing.position,
  mutable last_char: option(int),
  mutable last_char_mark: option(int),
};

let last_buffer: ref(t);

let from_string: (~container_lnum: int = ?, ~pos: Lexing.position = ?, string) => t;

let mark: (t, int) => unit;
let backtrack: t => int;
let start: t => unit;
let rollback: t => unit;

let next_loc: t => Lexing.position;
let next: t => option(Uchar.t);

let lexeme: (~skip: int = ?, ~drop: int = ?, t) => string;
let make_loc: (~loc_ghost: bool = ?, Lexing.position, Lexing.position) => Location.t;
