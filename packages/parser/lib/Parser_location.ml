let to_ppxlib_location ?(loc_ghost = false) (start_pos : Lexing.position)
  (end_pos : Lexing.position) : Ppxlib.Location.t =
  { loc_start = start_pos; loc_end = end_pos; loc_ghost }
