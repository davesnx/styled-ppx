let to_ppxlib_location ?(loc_ghost = false) (start_pos : Lexing.position)
  (end_pos : Lexing.position) : Ppxlib.location =
  { loc_start = start_pos; loc_end = end_pos; loc_ghost }

let print_location label ({ loc_start; loc_end; _ } : Ppxlib.location) =
  let loc_start_column = loc_start.pos_cnum - loc_start.pos_bol in
  let loc_end_column = loc_end.pos_cnum - loc_end.pos_bol in
  Printf.sprintf "%s start %d %d %d (L:%d c:%d) end %d %d %d (L:%d c:%d)" label
    loc_start.pos_lnum loc_start.pos_bol loc_start.pos_cnum loc_start.pos_lnum
    loc_start_column loc_end.pos_lnum loc_end.pos_bol loc_end.pos_cnum
    loc_end_column loc_end.pos_lnum

let intersection (loc1 : Ppxlib.location) (loc2 : Ppxlib.location) :
  Ppxlib.location =
  let start_pos =
    Lexing.
      {
        pos_fname = loc1.loc_start.pos_fname;
        pos_lnum = loc1.loc_start.pos_lnum + loc2.loc_start.pos_lnum;
        pos_bol = loc1.loc_start.pos_bol + loc2.loc_start.pos_bol;
        pos_cnum = loc1.loc_start.pos_cnum + loc2.loc_start.pos_cnum + 1;
      }
  in
  let end_pos =
    Lexing.
      {
        pos_fname = loc1.loc_end.pos_fname;
        pos_lnum = loc1.loc_start.pos_lnum + loc2.loc_start.pos_lnum;
        pos_bol = loc1.loc_start.pos_bol + loc2.loc_end.pos_bol;
        pos_cnum = loc1.loc_start.pos_cnum + loc2.loc_end.pos_cnum + 1;
      }
  in
  { loc_start = start_pos; loc_end = end_pos; loc_ghost = false }

let update_loc_with_delimiter (loc : Ppxlib.location) delimiter :
  Ppxlib.location =
  let offset =
    match delimiter with None -> 0 | Some s -> String.length s + 1
  in
  let loc_start =
    { loc.loc_start with pos_cnum = loc.loc_start.pos_cnum + offset }
  and loc_end = { loc.loc_end with pos_cnum = loc.loc_end.pos_cnum + offset } in
  { loc_start; loc_end; loc_ghost = false }
