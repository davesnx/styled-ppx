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

let update_pos_lnum (css_loc : Ppxlib.location) (source_loc : Ppxlib.location) =
  (* Map a location from CSS parser (relative to CSS string) to source file location.

     css_loc: location within the CSS string (e.g., "display: fley")
     source_loc: location of the entire CSS string in the source file (e.g., "{| color: rex; display: fley; |}")

     The CSS parser returns positions relative to the CSS content with:
     - Line numbers starting from 1
     - pos_cnum as absolute character positions from start of CSS string
     - pos_bol as the position of the beginning of the current line
  *)

  (* Calculate the mapped start position *)
  let mapped_start_line =
    source_loc.loc_start.pos_lnum + css_loc.loc_start.pos_lnum - 1
  in

  (* Calculate column offset within the CSS line *)
  let css_start_column =
    css_loc.loc_start.pos_cnum - css_loc.loc_start.pos_bol
  in

  let mapped_start_cnum =
    if css_loc.loc_start.pos_lnum = 1 then
      (* First line of CSS: add column offset to source start position *)
      source_loc.loc_start.pos_cnum + css_start_column
    else
      (* Subsequent lines: need to calculate the actual position in source file *)
      (* This is complex for multi-line strings - for now, approximate *)
      source_loc.loc_start.pos_bol + css_start_column
  in

  let mapped_start_bol =
    if css_loc.loc_start.pos_lnum = 1 then source_loc.loc_start.pos_bol
    else
      (* For lines after the first, calculate the proper beginning of line *)
      mapped_start_cnum - css_start_column
  in

  (* Calculate the mapped end position *)
  let mapped_end_line =
    source_loc.loc_start.pos_lnum + css_loc.loc_end.pos_lnum - 1
  in

  (* Calculate column offset for end position *)
  let css_end_column = css_loc.loc_end.pos_cnum - css_loc.loc_end.pos_bol in

  let mapped_end_cnum =
    if css_loc.loc_end.pos_lnum = 1 then
      (* End is on first line of CSS *)
      source_loc.loc_start.pos_cnum + css_end_column
    else
      (* End is on a subsequent line *)
      source_loc.loc_start.pos_bol + css_end_column
  in

  let mapped_end_bol =
    if css_loc.loc_end.pos_lnum = 1 then source_loc.loc_start.pos_bol
    else mapped_end_cnum - css_end_column
  in

  let loc_start : Lexing.position =
    {
      pos_fname = source_loc.loc_start.pos_fname;
      pos_lnum = mapped_start_line;
      pos_bol = mapped_start_bol;
      pos_cnum = mapped_start_cnum;
    }
  in

  let loc_end : Lexing.position =
    {
      pos_fname = source_loc.loc_end.pos_fname;
      pos_lnum = mapped_end_line;
      pos_bol = mapped_end_bol;
      pos_cnum = mapped_end_cnum;
    }
  in

  ({ loc_start; loc_end; loc_ghost = false } : Ppxlib.location)

let map_to_source_location (source_loc : Ppxlib.location)
  (css_start_pos : Lexing.position) (css_end_pos : Lexing.position) :
  Ppxlib.location =
  (* CSS parser returns positions relative to the CSS string content.
     In OCaml/Reason, for multi-line strings {|...|}, the source_loc
     points to the first character of content AFTER the opening delimiter.

     For example, in:
       let _css2 = [%cx2 {|       <- Line 10
         color: red;              <- Line 11 (source_loc points here)
         padding: 10pxx;          <- Line 12 (error is here)
       |}];                       <- Line 13

     The source_loc.loc_start.pos_lnum would be 11 (first content line).
     CSS parser sees this as line 1 = "color: red", line 2 = "padding: 10pxx".
     So when CSS reports error at line 2, we need to map to source line 12.
  *)

  (* The source_loc already points to the first line of CSS content *)
  let source_line = source_loc.loc_start.pos_lnum in

  (* Map CSS lines: CSS line N maps to source_line + (N - 1) *)
  let mapped_start_line = source_line + css_start_pos.pos_lnum - 1 in
  let mapped_start_cnum =
    if css_start_pos.pos_lnum = 1 then
      (* First line of CSS: add offset within the source line *)
      source_loc.loc_start.pos_cnum + css_start_pos.pos_cnum
    else
      (* Subsequent lines: use the CSS position + source file base offset *)
      source_loc.loc_start.pos_cnum
      - (source_loc.loc_start.pos_cnum - source_loc.loc_start.pos_bol)
      + css_start_pos.pos_cnum
  in

  let mapped_start_bol =
    if css_start_pos.pos_lnum = 1 then source_loc.loc_start.pos_bol
    else
      (* For lines after the first, we need to calculate the proper bol *)
      mapped_start_cnum - (css_start_pos.pos_cnum - css_start_pos.pos_bol)
  in

  (* Map the end position similarly *)
  let mapped_end_line = source_line + css_end_pos.pos_lnum - 1 in
  let mapped_end_cnum =
    if css_end_pos.pos_lnum = 1 then
      source_loc.loc_start.pos_cnum + css_end_pos.pos_cnum
    else
      source_loc.loc_start.pos_cnum
      - (source_loc.loc_start.pos_cnum - source_loc.loc_start.pos_bol)
      + css_end_pos.pos_cnum
  in

  let mapped_end_bol =
    if css_end_pos.pos_lnum = 1 then source_loc.loc_start.pos_bol
    else mapped_end_cnum - (css_end_pos.pos_cnum - css_end_pos.pos_bol)
  in

  let mapped_start : Lexing.position =
    {
      pos_fname = source_loc.loc_start.pos_fname;
      pos_lnum = mapped_start_line;
      pos_bol = mapped_start_bol;
      pos_cnum = mapped_start_cnum;
    }
  in

  let mapped_end : Lexing.position =
    {
      pos_fname = source_loc.loc_end.pos_fname;
      pos_lnum = mapped_end_line;
      pos_bol = mapped_end_bol;
      pos_cnum = mapped_end_cnum;
    }
  in

  { loc_start = mapped_start; loc_end = mapped_end; loc_ghost = false }
