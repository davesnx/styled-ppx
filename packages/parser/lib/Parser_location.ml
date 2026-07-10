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

(* Given the location of a string constant (which starts at the opening
   quote), return a location whose start points at the first character of
   the payload: one character for a plain quoted string, [String.length d
   + 2] for a delimited string (skipping the opening brace, delimiter and
   pipe). The result is the [base_loc] every payload-relative location is
   rebased against. *)
let update_loc_with_delimiter (loc : Ppxlib.location) delimiter :
  Ppxlib.location =
  let offset =
    match delimiter with None -> 1 | Some s -> String.length s + 2
  in
  let loc_start =
    { loc.loc_start with pos_cnum = loc.loc_start.pos_cnum + offset }
  and loc_end = { loc.loc_end with pos_cnum = loc.loc_end.pos_cnum + offset } in
  { loc_start; loc_end; loc_ghost = false }

(* Rebase a payload-relative position (as produced by the CSS lexer, or by
   re-parsing an interpolation expression: line 1, column 0 = payload
   start) onto [payload_start], the file position of the payload's first
   character.

   The payload occupies a contiguous byte range of the file starting at
   [payload_start.pos_cnum], so every payload-relative offset maps to a
   file offset by adding it. Line 1 of the payload continues
   [payload_start]'s file line (same [pos_bol]); every later payload line
   begins at a fresh file line whose [pos_bol] is itself a payload offset.

   Known approximation: escape sequences in regular quoted strings occupy
   more file bytes than payload bytes, shifting positions after them. *)
let to_file_position ~(payload_start : Lexing.position)
  (pos : Lexing.position) : Lexing.position =
  {
    pos_fname = payload_start.pos_fname;
    pos_lnum = payload_start.pos_lnum + pos.pos_lnum - 1;
    pos_bol =
      (if pos.pos_lnum = 1 then payload_start.pos_bol
       else pos.pos_bol + payload_start.pos_cnum);
    pos_cnum = pos.pos_cnum + payload_start.pos_cnum;
  }

(* Rebase a payload-relative location onto the file location of the
   payload. [base_loc]'s start must point at the payload's first character
   (see [update_loc_with_delimiter]). *)
let adjust_to_file ~(relative_loc : Ppxlib.location)
  ~(base_loc : Ppxlib.location) : Ppxlib.location =
  let payload_start = base_loc.loc_start in
  {
    Ppxlib.loc_start = to_file_position ~payload_start relative_loc.loc_start;
    loc_end = to_file_position ~payload_start relative_loc.loc_end;
    loc_ghost = relative_loc.loc_ghost;
  }

