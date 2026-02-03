let to_ppxlib_location ?(loc_ghost = false) (start_pos : Lexing.position)
  (end_pos : Lexing.position) : Ppxlib.location =
  { loc_start = start_pos; loc_end = end_pos; loc_ghost }

let print_location label ({ loc_start; loc_end; _ } : Ppxlib.location) =
  let loc_start_column = loc_start.pos_cnum - loc_start.pos_bol in
  let loc_end_column = loc_end.pos_cnum - loc_end.pos_bol in
  Printf.sprintf "%s start %d %d %d (L:%d c:%d) end %d %d %d (L:%d c:%d)" label
    loc_start.pos_lnum loc_start.pos_bol loc_start.pos_cnum loc_start.pos_lnum
    loc_start_column loc_end.pos_lnum loc_end.pos_bol loc_end.pos_cnum
    loc_end.pos_lnum loc_end_column

let intersection (loc1 : Ppxlib.location) (loc2 : Ppxlib.location) :
  Ppxlib.location =
  let start_pos =
    Lexing.
      {
        pos_fname = loc1.loc_start.pos_fname;
        pos_lnum = loc1.loc_start.pos_lnum + loc2.loc_start.pos_lnum - 1;
        pos_bol = loc1.loc_start.pos_bol + loc2.loc_start.pos_bol;
        pos_cnum = loc1.loc_start.pos_cnum + loc2.loc_start.pos_cnum;
      }
  in
  let end_pos =
    Lexing.
      {
        pos_fname = loc1.loc_end.pos_fname;
        pos_lnum = loc1.loc_start.pos_lnum + loc2.loc_end.pos_lnum - 1;
        pos_bol = loc1.loc_start.pos_bol + loc2.loc_end.pos_bol;
        pos_cnum = loc1.loc_start.pos_cnum + loc2.loc_end.pos_cnum;
      }
  in
  {
    Ppxlib.Location.loc_start = start_pos;
    loc_end = end_pos;
    loc_ghost = false;
  }

let update_loc_with_delimiter (loc : Ppxlib.location) delimiter :
  Ppxlib.location =
  let offset =
    match delimiter with None -> 0 | Some s -> String.length s + 1
  in
  let loc_start =
    { loc.loc_start with pos_cnum = loc.loc_start.pos_cnum + offset }
  and loc_end = { loc.loc_end with pos_cnum = loc.loc_end.pos_cnum + offset } in
  { loc_start; loc_end; loc_ghost = false }

let make_loc_from_loc ~string_loc ~delimiter loc =
  let loc = update_loc_with_delimiter loc delimiter in
  intersection string_loc loc

let update_pos_lnum (a : Ppxlib.location) (b : Ppxlib.location) =
  let loc_start =
    {
      a.loc_start with
      pos_lnum = a.loc_start.pos_lnum + b.loc_start.pos_lnum - 1;
    }
  in
  let loc_end =
    { a.loc_end with pos_lnum = a.loc_end.pos_lnum + b.loc_start.pos_lnum - 1 }
  in
  { a with loc_start; loc_end }

let adjust_to_file ~(relative_loc : Ppxlib.location)
  ~(base_loc : Ppxlib.location) : Ppxlib.location =
  let offset =
    if relative_loc.loc_start.pos_lnum = 1 then
      base_loc.loc_start.pos_cnum - base_loc.loc_start.pos_bol + 1
    else 0
  in
  let with_offset =
    {
      relative_loc with
      loc_start =
        {
          relative_loc.loc_start with
          pos_cnum = relative_loc.loc_start.pos_cnum + offset;
        };
      loc_end =
        {
          relative_loc.loc_end with
          pos_cnum = relative_loc.loc_end.pos_cnum + offset;
        };
    }
  in
  update_pos_lnum with_offset base_loc

class expression_mapper base_loc =
  let offset_cnum = base_loc.Ppxlib.loc_start.pos_cnum in
  let offset_lnum = base_loc.loc_start.pos_lnum - 1 in
  let base_bol = base_loc.loc_start.pos_bol in
  let base_fname = base_loc.loc_start.pos_fname in

  let relocate_position pos =
    {
      Lexing.pos_fname = base_fname;
      pos_lnum = pos.Lexing.pos_lnum + offset_lnum;
      pos_bol = base_bol;
      pos_cnum = pos.Lexing.pos_cnum + offset_cnum;
    }
  in

  object
    inherit Ppxlib.Ast_traverse.map

    method! location loc =
      {
        Ppxlib.loc_start = relocate_position loc.loc_start;
        loc_end = relocate_position loc.loc_end;
        loc_ghost = loc.loc_ghost;
      }
  end

let relocate_expression base_loc expr =
  let mapper = new expression_mapper base_loc in
  mapper#expression expr
