module Location = Ppxlib.Location;

let make_loc =
    (~loc_ghost=false, start_pos: Lexing.position, end_pos: Lexing.position)
    : Location.t => {
  loc_start: start_pos,
  loc_end: end_pos,
  loc_ghost,
};
