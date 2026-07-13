let to_ppxlib_location ?(loc_ghost = false) (start_pos : Lexing.position)
  (end_pos : Lexing.position) : Ppxlib.location =
  { loc_start = start_pos; loc_end = end_pos; loc_ghost }

(* Location covering both inputs, for AST nodes synthesized by merging two
   source-adjacent nodes (e.g. nested @media preludes joined with `and`). *)
let span (loc1 : Ppxlib.location) (loc2 : Ppxlib.location) : Ppxlib.location =
  {
    loc_start = loc1.loc_start;
    loc_end = loc2.loc_end;
    loc_ghost = loc1.loc_ghost || loc2.loc_ghost;
  }

(* Position of a file's first character. Rebasing against it is the
   identity; [Location.none] is not ([pos_cnum] is [-1]). *)
let file_start ?(filename = "") () : Lexing.position =
  { pos_fname = filename; pos_lnum = 1; pos_bol = 0; pos_cnum = 0 }

(* File position of a string constant's first content character: skips the
   opening quote, or brace + delimiter + pipe for delimited strings. All
   source-relative locations are rebased against it. *)
let source_position_start ~delimiter (loc : Ppxlib.location) : Lexing.position =
  let offset =
    match delimiter with None -> 1 | Some d -> String.length d + 2
  in
  { loc.loc_start with pos_cnum = loc.loc_start.pos_cnum + offset }

(* Rebase a source-relative position (line 1, column 0 = first parsed
   character) onto [source_position_start]. The source is a contiguous
   byte range of the file, so offsets shift by [pos_cnum]; line 1
   continues [source_position_start]'s file line, later lines start their
   own. Escape sequences in quoted strings break the 1:1 byte mapping and
   shift positions after them. *)
let to_file_position ~(source_position_start : Lexing.position)
  (pos : Lexing.position) : Lexing.position =
  {
    pos_fname = source_position_start.pos_fname;
    pos_lnum = source_position_start.pos_lnum + pos.pos_lnum - 1;
    pos_bol =
      (if pos.pos_lnum = 1 then source_position_start.pos_bol
       else pos.pos_bol + source_position_start.pos_cnum);
    pos_cnum = pos.pos_cnum + source_position_start.pos_cnum;
  }

(* Rebase a source-relative location onto the file. *)
let to_file_location ~(source_position_start : Lexing.position)
  (relative_loc : Ppxlib.location) : Ppxlib.location =
  {
    Ppxlib.loc_start =
      to_file_position ~source_position_start relative_loc.loc_start;
    loc_end = to_file_position ~source_position_start relative_loc.loc_end;
    loc_ghost = relative_loc.loc_ghost;
  }
