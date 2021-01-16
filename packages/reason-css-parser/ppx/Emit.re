open Migrate_parsetree;
open Ast_410;
open Longident;

module Make = (Ast_builder: Ppxlib.Ast_builder.S) => {
  open Ast_builder;
  open Reason_css_vds;

  let create_variant_name = (type_name, name) =>
    type_name ++ "__make__" ++ name;

  let txt = txt => {Location.loc: Ast_builder.loc, txt};

  let ldot = (module_name, name) =>
    Ldot(Lident(module_name), name) |> txt |> pexp_ident;

  let module_op = ldot("Op");
  let module_values = ldot("Values");

  let construct = (~expr=None, name) =>
    pexp_construct(txt(Lident(name)), expr);

  let kebab_case_to_snake_case = name =>
    name |> String.split_on_char('-') |> String.concat("_");
  let first_uppercase = name =>
    (String.sub(name, 0, 1) |> String.uppercase_ascii)
    ++ String.sub(name, 1, String.length(name) - 1);

  let is_function = str => {
    open String;
    let length = length(str);
    length >= 2 && sub(str, length - 2, 2) == "()";
  };
  let function_value_name = function_name => "function-" ++ function_name;
  let property_value_name = property_name =>
    is_function(property_name)
      ? function_value_name(property_name) : "property-" ++ property_name;
  let value_name_of_css = str =>
    String.(
      {
        let length = length(str);
        let str =
          if (is_function(str)) {
            let str = sub(str, 0, length - 2);
            function_value_name(str);
          } else {
            str;
          };
        kebab_case_to_snake_case(str);
      }
    );

  // TODO: multiplier name
  let rec variant_name = value => {
    let value_name =
      switch (value) {
      | Terminal(Keyword(name), _)
      | Terminal(Data_type(name), _) => value_name_of_css(name)
      | Terminal(Property_type(name), _) =>
        property_value_name(name) |> value_name_of_css
      | Group(value, _) => variant_name(value)
      | Combinator(Static, _) => "static"
      | Combinator(And, _) => "and"
      | Combinator(Or, _) => "or"
      | Combinator(Xor, _) => "xor"
      | Function_call(name, _) => value_name_of_css(name)
      };
    value_name |> first_uppercase |> Escape.variant;
  };
  let variant_names = values => {
    // TODO: not exactly a fast algorithm
    let values = values |> List.map(variant_name);
    let occurrences = (values, value) =>
      values |> List.filter((==)(value)) |> List.length;
    values
    |> List.fold_left(
         (acc, value) => {
           let total = occurrences(values, value);
           let current_values = acc |> List.map(((name, _)) => name);
           let current = occurrences(current_values, value);
           let value = total == 1 ? (value, None) : (value, Some(current));
           [value, ...acc];
         },
         [],
       )
    |> List.map(
         fun
         | (value, None) => value
         | (value, Some(int)) => value ++ "_" ++ string_of_int(int),
       )
    |> List.rev;
  };

  let apply_modifier = {
    let option_int_to_expr =
      fun
      | None => construct("None")
      | Some(int) => construct(~expr=Some(eint(int)), "Some");
    let modifier_op =
      fun
      | One => evar("one")
      | Zero_or_more => evar("zero_or_more")
      | One_or_more => evar("one_or_more")
      | Optional => evar("optional")
      | Repeat(min, max) =>
        eapply(
          evar("repeat"),
          [pexp_tuple([eint(min), option_int_to_expr(max)])],
        )
      | Repeat_by_comma(min, max) =>
        eapply(
          evar("repeat_by_comma"),
          [pexp_tuple([eint(min), option_int_to_expr(max)])],
        )
      | At_least_one => evar("at_least_one");
    (modifier, rule) =>
      switch (modifier) {
      | One => rule
      | modifier =>
        let op = modifier_op(modifier);
        eapply(op, [rule]);
      };
  };

  let rec create_value_parser = value => {
    let terminal_op = (kind, modifier) => {
      // as everyrule is in the same namespace
      let rule =
        switch (kind) {
        | Keyword(name) =>
          // TODO: find a better way to separate keywords of delimiters
          switch (name) {
          | "," => evar("comma")
          | "/" => eapply(evar("delim"), [estring("/")])
          | _ =>
            let name = estring(name);
            eapply(evar("keyword"), [name]);
          }
        | Data_type(name) => value_name_of_css(name) |> evar
        | Property_type(name) =>
          property_value_name(name) |> value_name_of_css |> evar
        };
      apply_modifier(modifier, rule);
    };
    let group_op = (value, modifier) =>
      create_value_parser(value) |> apply_modifier(modifier);
    let combinator_op = (kind, values) => {
      let apply = (fn, args) => {
        let args = elist(args);
        eapply(fn, [args]);
      };
      let op_ident =
        fun
        | Static => evar("combine_static")
        | Xor => evar("combine_xor")
        | And => evar("combine_and")
        | Or => evar("combine_or");

      let map_value = (content, (name, value)) => {
        let value = create_value_parser(value);
        let variant = pexp_variant(name, content ? Some(evar("v")) : None);
        let map_fn =
          pexp_fun(Nolabel, None, pvar(content ? "v" : "_v"), variant);
        eapply(evar("map"), [value, map_fn]);
      };

      switch (kind) {
      | Xor =>
        let names = variant_names(values);
        let args =
          List.combine(names, values)
          |> List.map(((_, value) as pair) => {
               let has_content =
                 switch (value) {
                 | Terminal(Keyword(_), _) => false
                 | _ => true
                 };
               map_value(has_content, pair);
             });
        apply(op_ident(kind), args);
      | _ =>
        let combinator_args =
          values
          |> List.mapi((index, v) => ("V" ++ string_of_int(index), v))
          |> List.map(map_value(true));
        let combinator = apply(op_ident(kind), combinator_args);
        let (args, body) =
          values
          |> List.mapi((index, _) => {
               let id_name = "v" ++ string_of_int(index);
               let id_expr = pexp_ident(txt(Lident(id_name)));
               let id_pat = ppat_var(txt(id_name));
               let extract_variant =
                 ppat_variant("V" ++ string_of_int(index), Some(id_pat));
               switch (kind) {
               | Or =>
                 let expr =
                   pexp_match(
                     id_expr,
                     [
                       case(
                         ~lhs=ppat_construct(txt(Lident("None")), None),
                         ~rhs=pexp_construct(txt(Lident("None")), None),
                         ~guard=None,
                       ),
                       case(
                         ~lhs=
                           ppat_construct(
                             txt(Lident("Some")),
                             Some(extract_variant),
                           ),
                         ~rhs=
                           pexp_construct(
                             txt(Lident("Some")),
                             Some(id_expr),
                           ),
                         ~guard=None,
                       ),
                     ],
                   );
                 (id_pat, expr);
               | _ => (extract_variant, id_expr)
               };
             })
          |> List.split;
        let disable_warning =
          attribute(
            ~name=txt("ocaml.warning"),
            ~payload=PStr([pstr_eval(estring("-8"), [])]),
          );
        let args = plist(args);
        let body = pexp_tuple(body);
        let map_fn = {
          ...pexp_fun(Nolabel, None, args, body),
          pexp_attributes: [disable_warning],
        };
        eapply(evar("map"), [combinator, map_fn]);
      };
    };
    let function_call = (name, value) => {
      let name = estring(name);
      let value = create_value_parser(value);
      eapply(evar("function_call"), [name, value]);
    };

    switch (value) {
    | Terminal(kind, multiplier) => terminal_op(kind, multiplier)
    | Group(value, multiplier) => group_op(value, multiplier)
    | Combinator(kind, values) => combinator_op(kind, values)
    | Function_call(name, value) => function_call(name, value)
    };
  };
};
