type entry = {
  longident: string,
  class_string: string,
};

/* Insertion-ordered list of entries; reversed on drain. The companion
   [seen] hashtable suppresses duplicate longidents from late writes
   (e.g. shadowing within the same CU) so [record] runs in amortized
   O(1) and the drained list is a sane index export. Last-write-wins
   semantics match [Class_registry]'s same-module behavior. */
let entries: ref(list(entry)) = ref([]);
let seen: Hashtbl.t(string, unit) = Hashtbl.create(16);

let reset = () => {
  entries := [];
  Hashtbl.clear(seen);
};

let record = (~longident: string, ~class_string: string) =>
  if (longident != "") {
    if (Hashtbl.mem(seen, longident)) {
      /* Last-write-wins: replace the older entry in-place instead of
         emitting two index keys for the same longident. */
      entries :=
        List.map(
          e => e.longident == longident ? {longident, class_string} : e,
          entries^,
        );
    } else {
      Hashtbl.add(seen, longident, ());
      entries := [{longident, class_string}, ...entries^];
    };
  };

let drain = (): list(entry) => {
  let out = List.rev(entries^);
  reset();
  out;
};
