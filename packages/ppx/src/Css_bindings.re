type entry = {
  longident: string,
  class_string: string,
  binding_id: string,
};

/* Insertion-ordered list of entries; reversed on drain. The companion
   [seen] hashtable suppresses duplicate longidents from late writes
   (e.g. shadowing within the same CU) so [record] runs in amortized
   O(1) and the drained list is a sane index export. Last-write-wins
   semantics match [Local_selector_environment]'s same-module behavior. */
let entries: ref(list(entry)) = ref([]);
let seen: Hashtbl.t(string, unit) = Hashtbl.create(16);

let occurrences: Hashtbl.t((string, string), int) = Hashtbl.create(16);
let minted_ids: ref(list((string, string))) = ref([]);
let library = ref("");

let set_library = name => library := name;

let reset = () => {
  entries := [];
  Hashtbl.clear(seen);
  Hashtbl.clear(occurrences);
  minted_ids := [];
};

let mint_id = (~main_module: string, ~scope: list(string), ~name: string) => {
  let key = (String.concat(".", scope), name);
  let occurrence =
    Option.value(Hashtbl.find_opt(occurrences, key), ~default=0);
  Hashtbl.replace(occurrences, key, occurrence + 1);
  let token =
    Hash_class.binding_id(
      ~library=library^,
      ~module_name=main_module,
      ~scope,
      ~name,
      ~occurrence,
    );
  minted_ids :=
    [
      (
        token,
        Hash_class.binding_id_source(
          ~library=library^,
          ~module_name=main_module,
          ~scope,
          ~name,
          ~occurrence,
        ),
      ),
      ...minted_ids^,
    ];
  token;
};

let drain_ids = () => List.rev(minted_ids^);

let record = (~longident: string, ~class_string: string, ~binding_id: string) =>
  if (longident != "") {
    if (Hashtbl.mem(seen, longident)) {
      /* Last-write-wins: replace the older entry in-place instead of
         emitting two index keys for the same longident. */
      entries :=
        List.map(
          e =>
            e.longident == longident
              ? {
                longident,
                class_string,
                binding_id,
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
            binding_id,
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
