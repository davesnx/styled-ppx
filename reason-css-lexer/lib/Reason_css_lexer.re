include Token;
open Location;

// TODO: that's definitly ugly
let from_string = string => {
  let buf = Sedlexing.Utf8.from_string(string);
  let rec read = acc => {
    let (loc_start, _) = Sedlexing.lexing_positions(buf);
    let value = Tokenizer.consume(buf);
    let (_, loc_end) = Sedlexing.lexing_positions(buf);

    let token_with_loc = {
      txt: value,
      loc: {
        loc_start,
        loc_end,
        loc_ghost: false,
      },
    };

    let acc = [token_with_loc, ...acc];
    switch (value) {
    | Ok(EOF) => Ok(acc)
    | _ when loc_start.pos_cnum == loc_end.pos_cnum => Error(`Frozen)
    | _ => read(acc)
    };
  };
  read([]);
};
