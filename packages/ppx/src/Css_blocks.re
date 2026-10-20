let entries: ref(list(Css_extraction.block)) = ref([]);

let record = (~loc: Ppxlib.Location.t, ~classNames) => {
  let block =
    Css_extraction.block(
      ~line=loc.loc_start.pos_lnum,
      ~class_string=String.concat(" ", classNames),
    );
  if (!List.mem(block, entries^)) {
    entries := [block, ...entries^];
  };
};

let drain = () => {
  let out = List.rev(entries^);
  entries := [];
  out;
};
