type entry = {
  longident: string,
  loc: Ppxlib.Location.t,
};

let sentinel = (longident: string): string =>
  Css_extraction.sentinel(longident);

let entries: ref(list(entry)) = ref([]);
let seen: Hashtbl.t((string, string, int), unit) = Hashtbl.create(16);

let reset = () => {
  entries := [];
  Hashtbl.clear(seen);
};

let with_filename = (~file: string, loc: Ppxlib.Location.t): Ppxlib.Location.t => {
  let loc_start = {
    ...loc.loc_start,
    pos_fname: file,
  };
  let loc_end = {
    ...loc.loc_end,
    pos_fname: file,
  };
  {
    ...loc,
    loc_start,
    loc_end,
  };
};

let record = (~file: string, ~longident: string, ~loc: Ppxlib.Location.t) => {
  let loc = with_filename(~file, loc);
  let key = (longident, loc.loc_start.pos_fname, loc.loc_start.pos_cnum);
  if (!Hashtbl.mem(seen, key)) {
    Hashtbl.add(seen, key, ());
    entries :=
      [
        {
          longident,
          loc,
        },
        ...entries^,
      ];
  };
};

let drain = (): (list(entry), list((string, Ppxlib.Location.t))) => {
  let all = List.rev(entries^);
  let seen_longidents = Hashtbl.create(8);
  let unique =
    List.filter_map(
      ({ longident, loc }) =>
        if (Hashtbl.mem(seen_longidents, longident)) {
          None;
        } else {
          Hashtbl.add(seen_longidents, longident, ());
          Some((longident, loc));
        },
      all,
    );
  reset();
  (all, unique);
};
