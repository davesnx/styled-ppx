open Css_types;

let rec dump_component_value = (ppf, (cv, _)) => {
  let dump_block = (start_char, end_char, cs) => {
    let pp = Fmt.(list(~sep=const(string, " "), dump_component_value));
    let pp =
      pp
      |> Fmt.(prefix(const(string, start_char)))
      |> Fmt.(suffix(const(string, end_char)));

    pp(ppf, cs);
  };

  switch (cv) {
  | Component_value.Paren_block(cs) => dump_block("(", ")", cs)
  | Bracket_block(cs) => dump_block("[", "]", cs)
  | Percentage(p) =>
    let pp = Fmt.string |> Fmt.(suffix(const(string, "%")));
    pp(ppf, p);
  | Ident(s)
  | Uri(s)
  | Operator(s)
  | Delim(s)
  | Number(s)
  | Variable(s)
  | TypedVariable((s, _))
  | Unicode_range(s) =>
    let pp = Fmt.string;
    pp(ppf, s);
  | Hash(s) =>
    let pp = Fmt.(string |> prefix(const(string, "#")));
    pp(ppf, s);
  | String(s) =>
    let pp =
      Fmt.(
        string
        |> prefix(const(string, "\""))
        |> suffix(const(string, "\""))
      );
    pp(ppf, s);
  | [@implicit_arity] Function((name, _), (params, _)) =>
    let pp_name = Fmt.string |> Fmt.(suffix(const(string, "(")));
    let pp_params =
      Fmt.(list(~sep=const(string, ", "), dump_component_value))
      |> Fmt.(suffix(const(string, ")")));

    let pp = Fmt.pair(~sep=Fmt.nop, pp_name, pp_params);
    pp(ppf, (name, params));
  | [@implicit_arity] Float_dimension(number, dimension, _)
  | [@implicit_arity] Dimension(number, dimension) =>
    let pp = Fmt.fmt("%s%s");
    pp(ppf, number, dimension);
  };
}
and dump_at_rule = (ppf, ar: At_rule.t) => {
  let pp_name = Fmt.string |> Fmt.(prefix(const(string, "@")));
  let pp_prelude = Fmt.(list(~sep=const(string, " "), dump_component_value));
  let pp_block = (ppf, ()) =>
    switch (ar.At_rule.block) {
    | Brace_block.Empty => Fmt.nop(ppf, ())
    | Declaration_list(dl) =>
      Fmt.(
        dump_declaration_list
        |> prefix(cut)
        |> prefix(const(string, "{"))
        |> suffix(cut)
        |> suffix(const(string, "}"))
      )(
        ppf,
        dl,
      )
    | Stylesheet(s) =>
      Fmt.(
        vbox(~indent=2, dump_stylesheet |> prefix(cut))
        |> prefix(cut)
        |> prefix(const(string, "{"))
        |> suffix(cut)
        |> suffix(const(string, "}"))
      )(
        ppf,
        s,
      )
    };

  let (name, _) = ar.At_rule.name;
  let (prelude, _) = ar.At_rule.prelude;
  Fmt.fmt("%a %a %a", ppf, pp_name, name, pp_prelude, prelude, pp_block, ());
}
and dump_declaration = (ppf, d: Declaration.t) => {
  let pp_name = Fmt.string;
  let pp_values = Fmt.(list(~sep=const(string, " "), dump_component_value));
  let pp_important =
    switch (d.Declaration.important) {
    | (false, _) => Fmt.nop
    | (true, _) => Fmt.(const(string, " !important"))
    };

  let (name, _) = d.Declaration.name;
  let (value, _) = d.Declaration.value;
  Fmt.fmt("%a: %a%a", ppf, pp_name, name, pp_values, value, pp_important, ());
}
and dump_declaration_list = (ppf, (dl, _)): unit => {
  let pp_elem = (ppf, d) =>
    switch (d) {
    | Declaration_list.Declaration(d) => dump_declaration(ppf, d)
    | Declaration_list.At_rule(ar) => dump_at_rule(ppf, ar)
    };

  let pp =
    Fmt.(
      vbox(
        ~indent=2,
        list(~sep=const(string, ";") |> suffix(cut), pp_elem)
        |> prefix(cut),
      )
    );

  pp(ppf, dl);
}
and dump_style_rule = (ppf, sr: Style_rule.t) => {
  let pp_prelude = Fmt.(list(~sep=const(string, " "), dump_component_value));
  let (prelude, _) = sr.Style_rule.prelude;
  Fmt.fmt(
    "%a {@,%a@,}@,",
    ppf,
    pp_prelude,
    prelude,
    dump_declaration_list,
    sr.Style_rule.block,
  );
}
and dump_rule = (ppf, r: Rule.t) =>
  switch (r) {
  | Rule.Style_rule(sr) => dump_style_rule(ppf, sr)
  | Rule.At_rule(ar) => dump_at_rule(ppf, ar)
  }
and dump_stylesheet = (ppf, (s, _)) => {
  let pp = Fmt.(vbox(list(dump_rule)));
  pp(ppf, s);
};
