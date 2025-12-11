let to_ppxlib_location ?(loc_ghost = false) (start_pos : Lexing.position)
  (end_pos : Lexing.position) : Ppxlib.location =
  { loc_start = start_pos; loc_end = end_pos; loc_ghost }

let print_location label ({ loc_start; loc_end; _ } : Ppxlib.location) =
  let loc_start_column = loc_start.pos_cnum - loc_start.pos_bol in
  let loc_end_column = loc_end.pos_cnum - loc_end.pos_bol in
  Printf.sprintf
    "%s\n\
    \  start %d %d %d (Line %d column %d)\n\
    \  end %d %d %d (Line %d column %d)"
    label loc_start.pos_lnum loc_start.pos_bol loc_start.pos_cnum
    loc_start.pos_lnum loc_start_column loc_end.pos_lnum loc_end.pos_bol
    loc_end.pos_cnum loc_end.pos_lnum loc_end_column

let intersection (loc1 : Ppxlib.location) (loc2 : Ppxlib.location) :
    Ppxlib.location =
  let start_cnum = loc1.loc_start.pos_cnum + loc2.loc_start.pos_cnum in
  let end_cnum = loc1.loc_start.pos_cnum + loc2.loc_end.pos_cnum in
  (* Compute pos_bol correctly for both single-line and multiline cases.
     For single-line (error on line 1 of CSS content): use loc1's bol
     For multiline (error on line 2+ of CSS content): compute bol to preserve CSS column *)
  let start_bol =
    if loc2.loc_start.pos_lnum = 1 then loc1.loc_start.pos_bol
    else
      let css_column = loc2.loc_start.pos_cnum - loc2.loc_start.pos_bol in
      start_cnum - css_column
  in
  let end_bol =
    if loc2.loc_end.pos_lnum = 1 then loc1.loc_start.pos_bol
    else
      let css_column = loc2.loc_end.pos_cnum - loc2.loc_end.pos_bol in
      end_cnum - css_column
  in
  let start_pos =
    Lexing.
      {
        pos_fname = loc1.loc_start.pos_fname;
        pos_lnum = loc1.loc_start.pos_lnum + loc2.loc_start.pos_lnum - 1;
        pos_bol = start_bol;
        pos_cnum = start_cnum;
      }
  in
  let end_pos =
    Lexing.
      {
        pos_fname = loc1.loc_end.pos_fname;
        pos_lnum = loc1.loc_start.pos_lnum + loc2.loc_end.pos_lnum - 1;
        pos_bol = end_bol;
        pos_cnum = end_cnum;
      }
  in
  { loc_start = start_pos; loc_end = end_pos; loc_ghost = false }

let update_loc_with_delimiter (loc : Ppxlib.location) delimiter :
    Ppxlib.location =
  let offset =
    match delimiter with None -> 1 | Some s -> String.length s + 2
  in
  let loc_start =
    { loc.loc_start with pos_cnum = loc.loc_start.pos_cnum + offset }
  and loc_end = { loc.loc_end with pos_cnum = loc.loc_end.pos_cnum + offset } in
  { loc_start; loc_end; loc_ghost = false }

(* make_loc_from_loc is like make_loc_from_pos, but takes a Ppxlib.location instead of
   Lexing.position values. This is used for type errors where the CSS parser
   already produces Ppxlib.location values. *)
let make_loc_from_loc ~(string_loc : Ppxlib.location) ~delimiter
    (css_loc : Ppxlib.location) : Ppxlib.location =
  let delimiter_offset =
    match delimiter with None -> 1 | Some s -> String.length s + 2
  in
  (* Compute absolute position in file *)
  let start_cnum =
    string_loc.loc_start.pos_cnum + css_loc.loc_start.pos_cnum + delimiter_offset
  in
  let end_cnum =
    string_loc.loc_start.pos_cnum + css_loc.loc_end.pos_cnum + delimiter_offset
  in
  (* Compute line numbers *)
  let start_lnum =
    string_loc.loc_start.pos_lnum + css_loc.loc_start.pos_lnum - 1
  in
  let end_lnum = string_loc.loc_start.pos_lnum + css_loc.loc_end.pos_lnum - 1 in
  (* Compute pos_bol correctly for both single-line and multiline cases. *)
  let start_bol =
    if css_loc.loc_start.pos_lnum = 1 then string_loc.loc_start.pos_bol
    else
      let css_column = css_loc.loc_start.pos_cnum - css_loc.loc_start.pos_bol in
      start_cnum - css_column
  in
  let end_bol =
    if css_loc.loc_end.pos_lnum = 1 then string_loc.loc_start.pos_bol
    else
      let css_column = css_loc.loc_end.pos_cnum - css_loc.loc_end.pos_bol in
      end_cnum - css_column
  in
  let result_loc_start =
    Lexing.
      {
        pos_fname = string_loc.loc_start.pos_fname;
        pos_lnum = start_lnum;
        pos_bol = start_bol;
        pos_cnum = start_cnum;
      }
  in
  let result_loc_end =
    Lexing.
      {
        pos_fname = string_loc.loc_end.pos_fname;
        pos_lnum = end_lnum;
        pos_bol = end_bol;
        pos_cnum = end_cnum;
      }
  in
  { loc_start = result_loc_start; loc_end = result_loc_end; loc_ghost = false }

let make_loc_from_pos ~(loc : Ppxlib.location) ~delimiter
    (start_pos : Lexing.position) (end_pos : Lexing.position) : Ppxlib.location
    =
  let delimiter_offset =
    match delimiter with None -> 1 | Some s -> String.length s + 2
  in
  (* Compute absolute position in file *)
  let start_cnum =
    loc.loc_start.pos_cnum + start_pos.pos_cnum + delimiter_offset
  in
  let end_cnum =
    loc.loc_start.pos_cnum + end_pos.pos_cnum + delimiter_offset
  in
  (* Compute line numbers *)
  let start_lnum = loc.loc_start.pos_lnum + start_pos.pos_lnum - 1 in
  let end_lnum = loc.loc_start.pos_lnum + end_pos.pos_lnum - 1 in
  (* Compute pos_bol correctly for both single-line and multiline cases.
     For single-line (error on line 1 of CSS content): use the file's line bol
     For multiline (error on line 2+ of CSS content): compute bol to preserve CSS column *)
  let start_bol =
    if start_pos.pos_lnum = 1 then loc.loc_start.pos_bol
    else
      let css_column = start_pos.pos_cnum - start_pos.pos_bol in
      start_cnum - css_column
  in
  let end_bol =
    if end_pos.pos_lnum = 1 then loc.loc_start.pos_bol
    else
      let css_column = end_pos.pos_cnum - end_pos.pos_bol in
      end_cnum - css_column
  in
  let result_loc_start =
    Lexing.
      {
        pos_fname = loc.loc_start.pos_fname;
        pos_lnum = start_lnum;
        pos_bol = start_bol;
        pos_cnum = start_cnum;
      }
  in
  let result_loc_end =
    Lexing.
      {
        pos_fname = loc.loc_end.pos_fname;
        pos_lnum = end_lnum;
        pos_bol = end_bol;
        pos_cnum = end_cnum;
      }
  in
  { loc_start = result_loc_start; loc_end = result_loc_end; loc_ghost = false }
