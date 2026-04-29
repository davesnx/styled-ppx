type entry = {
  longident: string,
  loc: Ppxlib.Location.t,
};

/* NUL byte — cannot appear in valid CSS, in user [%cx2] source, or in OCaml
   string literals as plain text. The aggregator scans for `\x00LONGIDENT\x00`
   pairs in [@@@css ...] payloads and substitutes resolved class chains. */
let sentinel_byte = "\x00";

let sentinel = (longident: string): string =>
  sentinel_byte ++ longident ++ sentinel_byte;

/* Insertion-ordered list of entries; reversed on drain. The companion
   [seen] hashtable dedups by [(longident, file, cnum)] so [record] runs
   in amortized O(1) instead of an O(n) [List.exists] scan per call. */
let entries: ref(list(entry)) = ref([]);
let seen: Hashtbl.t((string, string, int), unit) = Hashtbl.create(16);

let reset = () => {
  entries := [];
  Hashtbl.clear(seen);
};

/* Rewrite [loc]'s pos_fname to [file] on both ends. The CSS parser produces
   locations relative to the [%cx2] string payload with an empty pos_fname;
   the surrounding [%cx2] knows the actual file via Code_path.file_path. We
   attach it here so the aggregator can later format errors against the
   original source. */
let with_filename = (~file: string, loc: Ppxlib.Location.t): Ppxlib.Location.t => {
  let loc_start = {...loc.loc_start, pos_fname: file};
  let loc_end = {...loc.loc_end, pos_fname: file};
  {...loc, loc_start, loc_end};
};

let record = (~file: string, ~longident: string, ~loc: Ppxlib.Location.t) => {
  let loc = with_filename(~file, loc);
  let key = (longident, loc.loc_start.pos_fname, loc.loc_start.pos_cnum);
  if (!Hashtbl.mem(seen, key)) {
    Hashtbl.add(seen, key, ());
    entries := [{longident, loc}, ...entries^];
  };
};

let drain = (): (list(entry), list((string, Ppxlib.Location.t))) => {
  let all = List.rev(entries^);
  let seen_longidents = Hashtbl.create(8);
  let unique =
    List.filter_map(
      ({longident, loc}) =>
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
