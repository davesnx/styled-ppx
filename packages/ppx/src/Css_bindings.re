type entry = {
  longident: string,
  class_string: string,
};

let entries: ref(list(entry)) = ref([]);
let seen: Hashtbl.t(string, unit) = Hashtbl.create(16);

let reset = () => {
  entries := [];
  Hashtbl.clear(seen);
};

let record = (~longident: string, ~class_string: string) =>
  if (longident != "") {
    if (Hashtbl.mem(seen, longident)) {
      entries :=
        List.map(
          e =>
            e.longident == longident
              ? {
                longident,
                class_string,
              }
              : e,
          entries^,
        );
    } else {
      Hashtbl.add(seen, longident, ());
      entries :=
        [
          {
            longident,
            class_string,
          },
          ...entries^,
        ];
    };
  };

let drain = (): list(entry) => {
  let out = List.rev(entries^);
  reset();
  out;
};
