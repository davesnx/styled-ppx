/*
  let delimLength =
    match delim with Some s -> 2 + String.length s | None -> 1
  in
 */

/*
  let add_loc delimLength base span =
  let _, _, col = Ocaml_common.Location.get_pos_info base.loc_start in
  let pos_bol_start =
    base.loc_start.pos_bol + col + delimLength + (fst span).index
    - (fst span).col
  in
  let pos_bol_end =
    base.loc_start.pos_bol + col + delimLength + (snd span).index
    - (snd span).col
  in
  let start = pos_bol_start + (fst span).col in
  let end_ = pos_bol_end + (snd span).col in
  {
    loc_start =
      {
        pos_fname = base.loc_start.pos_fname;
        pos_lnum = base.loc_start.pos_lnum + (fst span).line;
        pos_bol = pos_bol_start;
        pos_cnum = start;
      };
    loc_end =
      {
        pos_fname = base.loc_start.pos_fname;
        pos_lnum = base.loc_start.pos_lnum + (snd span).line;
        pos_bol = pos_bol_end;
        pos_cnum = end_;
      };
    loc_ghost = false;
  }
 */

let parse = (~loc: Ppxlib.location, payload) => {
  let loc_start = loc.loc_start;
  /* TODO: Bring back "delimiter location conditional logic" */
  /* let loc_start =
     switch (delim) {
     | None => payload.loc.loc_start
     | Some(s) => {
         ...payload.loc.loc_start,
         Lexing.pos_cnum:
           payload.loc.loc_start.Lexing.pos_cnum + String.length(s) + 1,
       }
     }; */

  switch (Driver.parse_declaration_list(~pos=Some(loc_start), payload)) {
  | Ok(declarations) => Ok(declarations)
  | Error((loc, msg)) => Error((loc, msg))
  };
};
