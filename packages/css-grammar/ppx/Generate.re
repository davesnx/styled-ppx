module Make = (Builder: Ppxlib.Ast_builder.S) => {
  open Ppxlib;
  open Builder;
  open Css_spec_parser;

  let txt = txt => {
    Location.loc: Builder.loc,
    txt,
  };

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

  let value_of_delimiter =
    fun
    | "+" => "cross"
    | "-" => "dash"
    | "*" => "asterisk"
    | "/" => "bar"
    | "@" => "at"
    | "," => "comma"
    | ";" => ""
    | ":" => "doubledot"
    | "." => "dot"
    | "(" => "openparen"
    | ")" => "closeparen"
    | "[" => "openbracket"
    | "]" => "closebracket"
    | "{" => "opencurly"
    | "}" => "closecurly"
    | "^" => "caret"
    | "<" => "lessthan"
    | "=" => "equal"
    | ">" => "biggerthan"
    | "|" => "vbar"
    | "~" => "tilde"
    | "$" => "dollar"
    | _ => "unknown";

  let camel_to_snake_case = name => {
    /* Convert camelCase to snake_case by inserting _ before uppercase letters */
    let result = ref("");
    String.iteri(
      (i, c) =>
        if (i > 0 && Char.uppercase_ascii(c) == c && c >= 'A' && c <= 'Z') {
          result := result^ ++ "_" ++ String.make(1, Char.lowercase_ascii(c));
        } else {
          result := result^ ++ String.make(1, c);
        },
      name,
    );
    result^;
  };

  let value_name_of_css = str => {
    open String;
    let length = length(str);
    let str =
      if (is_function(str)) {
        let str = sub(str, 0, length - 2);
        function_value_name(str);
      } else {
        str;
      };
    /* Convert kebab-case to snake_case, preserve camelCase/underscores */
    kebab_case_to_snake_case(str);
  };

  /* Convert a value name to a valid module name */
  let value_name_to_module_name = name => {
    let name = value_name_of_css(name);
    /* Special case: "string" is a reserved keyword, module is String_value */
    let name =
      if (name == "string") {
        "string_value";
      } else {
        name;
      };
    /* Remove leading underscore if present */
    let name =
      if (String.length(name) > 0 && name.[0] == '_') {
        String.sub(name, 1, String.length(name) - 1);
      } else {
        name;
      };
    /* Capitalize first letter only, preserving snake_case */
    if (String.length(name) > 0) {
      String.mapi((i, c) => i == 0 ? Char.uppercase_ascii(c) : c, name);
    } else {
      name;
    };
  };

  let keyword_to_css = str => {
    switch (str) {
    | "%" => "percent"
    | _ => kebab_case_to_snake_case(str)
    };
  };

  // TODO: multiplier name
  let rec variant_name = value => {
    let value_name =
      switch (value) {
      | Terminal(Delim(name), _) => value_of_delimiter(name)
      | Terminal(Keyword(name), _) => keyword_to_css(name)
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
    value_name |> first_uppercase;
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

  let make_type_declaration = (name, core_type) => {
    type_declaration(
      ~name=txt(name),
      ~params=[],
      ~cstrs=[],
      ~kind=Ptype_abstract,
      ~private_=Public,
      ~manifest=Some(core_type),
    );
  };

  let make_variant_declaration = (name, constructors) => {
    type_declaration(
      ~name=txt(name),
      ~params=[],
      ~cstrs=[],
      ~kind=Ptype_variant(constructors),
      ~private_=Public,
      ~manifest=None,
    );
  };

  let make_variant_branch = (name, constructor, types) => {
    rtag(txt(name), constructor, types);
  };

  let apply_modifier = (modifier, type_) => {
    switch (modifier) {
    | One => type_
    | Optional => ptyp_constr(txt @@ Lident("option"), [type_])
    | Repeat(_)
    | Repeat_by_comma(_, _)
    | Zero_or_more
    | One_or_more
    | At_least_one => ptyp_constr(txt @@ Lident("list"), [type_])
    };
  };

  let apply_xor_modifier = (modifier, type_, is_constructor, params) =>
    switch (modifier) {
    | One => make_variant_branch(type_, is_constructor, params)
    | Optional =>
      let params = [ptyp_constr(txt @@ Lident("option"), params)];
      make_variant_branch(type_, is_constructor, params);
    | Repeat(_)
    | Repeat_by_comma(_, _)
    | Zero_or_more
    | One_or_more
    | At_least_one =>
      let params = [ptyp_constr(txt @@ Lident("list"), params)];
      make_variant_branch(type_, is_constructor, params);
    };

  let create_type_parser = value => {
    let rec create_type =
      fun
      | Terminal(kind, multiplier) => terminal_op(kind, multiplier)
      | Combinator(kind, values) => combinator_op(kind, values)
      | Function_call(name, value) => function_call(name, value)
      | Group(value, multiplier) => group_op(value, multiplier)

    and terminal_xor_op = (type_name, kind, multiplier) => {
      let (type_, is_constructor, params) =
        switch (kind) {
        | Keyword(_)
        | Delim(_) =>
          /* Keywords and Delims don't carry data - no payload */
          (type_name, false, [])
        | Data_type(name) =>
          let module_name = value_name_to_module_name(name);
          let params = [
            ptyp_constr(txt @@ Ldot(Lident(module_name), "t"), []),
          ];
          (type_name, false, params);
        | Property_type(name) =>
          let module_name =
            property_value_name(name) |> value_name_to_module_name;
          let params = [
            ptyp_constr(txt @@ Ldot(Lident(module_name), "t"), []),
          ];
          (type_name, false, params);
        };
      apply_xor_modifier(multiplier, type_, is_constructor, params);
    }

    and terminal_op = (kind, multiplier) => {
      let type_ =
        switch (kind) {
        | Delim(_)
        | Keyword(_) => ptyp_constr(txt @@ Lident("unit"), [])
        | Data_type(name) =>
          let module_name = value_name_to_module_name(name);
          ptyp_constr(txt @@ Ldot(Lident(module_name), "t"), []);
        | Property_type(name) =>
          let module_name =
            property_value_name(name) |> value_name_to_module_name;
          ptyp_constr(txt @@ Ldot(Lident(module_name), "t"), []);
        };
      apply_modifier(multiplier, type_);
    }

    and combinator_op: (combinator, list(value)) => Parsetree.core_type =
      (kind, values) => {
        switch (kind) {
        | Xor =>
          let names = variant_names(values);
          let pairs = List.combine(names, values);
          let constructors =
            List.map(
              ((type_name, value)) => {
                let args =
                  switch (value) {
                  | Terminal(Keyword(_), _)
                  | Terminal(Delim(_), _) =>
                    /* No payload for keywords/delimiters */
                    Pcstr_tuple([])
                  | Terminal(kind, multiplier) =>
                    Pcstr_tuple([terminal_op(kind, multiplier)])
                  | Function_call(name, value) =>
                    let name =
                      first_uppercase(name) |> kebab_case_to_snake_case;
                    let type_ = function_call(name, value);
                    Pcstr_tuple([type_]);
                  | Combinator(kind, values) =>
                    let type_ = combinator_op(kind, values);
                    Pcstr_tuple([type_]);
                  | Group(value, multiplier) =>
                    let type_ = group_op(value, multiplier);
                    Pcstr_tuple([type_]);
                  };
                constructor_declaration(
                  ~name=txt(type_name),
                  ~args,
                  ~res=None,
                );
              },
              pairs,
            );
          ptyp_constr(txt(Lident("t")), []);
        | Static
        | And => ptyp_tuple(List.map(create_type, values))
        | Or =>
          let types =
            List.map(create_type, values)
            |> List.map(apply_modifier(Optional));
          ptyp_tuple(types);
        };
      }

    and function_call = (_name, value) => create_type(value)

    and group_op = (value, multiplier) =>
      create_type(value) |> apply_modifier(multiplier);

    switch (value) {
    | Terminal(kind, multiplier) => terminal_op(kind, multiplier)
    | Combinator(kind, values) => combinator_op(kind, values)
    | Function_call(name, value) => function_call(name, value)
    | Group(value, multiplier) => group_op(value, multiplier)
    };
  };

  let make_type = (binding: Parsetree.value_binding) => {
    let (name, payload) =
      switch (binding) {
      | {
          pvb_pat: {ppat_desc: Ppat_var({txt, _}), _},
          pvb_expr:
            {
              pexp_desc:
                Pexp_extension((
                  _,
                  PStr([
                    {
                      pstr_desc:
                        Pstr_eval(
                          {
                            pexp_desc:
                              Pexp_constant(
                                Pconst_string(value, _loc, _delim),
                              ),
                            _,
                          },
                          _attrs,
                        ),
                      _,
                    },
                  ]),
                )),
              _,
            },
          _,
        } => (
          txt,
          value,
        )
      | _ => failwith("Error when extracting CSS spec content")
      };
    switch (Css_spec_parser.value_of_string(payload)) {
    | Some(ast) => (name, create_type_parser(ast))
    | None => failwith("Error while parsing CSS spec")
    };
  };

  let add_type_to_expr = (name: string, expression) => {
    let core_type =
      Ast_helper.Typ.constr(
        ~loc,
        {
          loc: Location.none,
          txt: Ldot(Lident("Types"), name),
        },
        [],
      );
    let type_anotation = [%type:
      list(Styled_ppx_css_parser.Tokens.t) =>
      (
        Css_grammar_parser__Rule.data([%t core_type]),
        list(Styled_ppx_css_parser.Tokens.t),
      )
    ];
    [%expr ([%e expression]: [%t type_anotation])];
  };

  let get_name_from_binding = (binding: Parsetree.value_binding) => {
    switch (binding) {
    | {pvb_pat: {ppat_desc: Ppat_var({txt, _}), _}, _} => Some(txt)
    | _ => None
    };
  };

  let add_types = (~loc, bindings): list(Ppxlib.structure_item) => {
    let new_bindings =
      bindings
      |> List.map(value_binding => {
           let name = value_binding |> get_name_from_binding;
           switch (name) {
           | Some(type_name) =>
             let new_expression =
               add_type_to_expr(type_name, value_binding.pvb_expr);
             {
               ...value_binding,
               pvb_expr: new_expression,
             };
           | None => value_binding
           };
         });

    [Ast_helper.Str.value(~loc, Recursive, new_bindings)];
  };

  let create_variant_name = (type_name, name) =>
    type_name ++ "__make__" ++ name;

  let txt = txt => {
    Location.loc: Builder.loc,
    txt,
  };

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

  let value_of_delimiter =
    fun
    | "+" => "cross"
    | "-" => "dash"
    | "*" => "asterisk"
    | "/" => "bar"
    | "@" => "at"
    | "," => "comma"
    | ";" => ""
    | ":" => "doubledot"
    | "." => "dot"
    | "(" => "openparen"
    | ")" => "closeparen"
    | "[" => "openbracket"
    | "]" => "closebracket"
    | "{" => "opencurly"
    | "}" => "closecurly"
    | "^" => "caret"
    | "<" => "lessthan"
    | "=" => "equal"
    | ">" => "biggerthan"
    | "|" => "vbar"
    | "~" => "tilde"
    | "$" => "dollar"
    | _ => "unknown";

  let value_name_of_css = str => {
    open String;
    let str =
      if (is_function(str)) {
        let str = sub(str, 0, length(str) - 2);
        function_value_name(str);
      } else {
        str;
      };
    kebab_case_to_snake_case(str);
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

  let rec make_value = value => {
    let terminal_op = (kind, modifier) => {
      // as everyrule is in the same namespace
      let rule =
        switch (kind) {
        | Delim(delim) when delim == "," => evar("comma")
        | Delim(delim) => eapply(evar("delim"), [estring(delim)])
        | Keyword(name) => eapply(evar("keyword"), [estring(name)])
        | Data_type(name) =>
          let module_name = value_name_to_module_name(name);
          eapply(evar(module_name ++ ".parser"), []);
        | Property_type(name) =>
          let module_name =
            property_value_name(name) |> value_name_to_module_name;
          eapply(evar(module_name ++ ".parser"), []);
        };
      apply_modifier(modifier, rule);
    };
    let group_op = (value, modifier) =>
      make_value(value) |> apply_modifier(modifier);
    let combinator_op = (kind, values) => {
      let apply = (fn, args) => {
        let args = elist(args);
        eapply(fn, [args]);
      };
      let op_ident =
        fun
        | Static => evar("Combinators.static")
        | Xor => evar("Combinators.xor")
        | And => evar("Combinators.and_")
        | Or => evar("Combinators.or_");

      let map_value = (content, (name, value)) => {
        let variant = pexp_variant(name, content ? Some(evar("v")) : None);
        let map_fn =
          pexp_fun(Nolabel, None, pvar(content ? "v" : "_v"), variant);
        eapply(evar("map"), [make_value(value), map_fn]);
      };

      switch (kind) {
      | Xor =>
        let names = variant_names(values);
        let args =
          List.combine(names, values)
          |> List.map(((_, value) as pair) => {
               let has_content =
                 switch (value) {
                 | Terminal(Keyword(_), _)
                 | Terminal(Delim(_), _) => false
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
            ~payload=PStr([pstr_eval(estring("-8-26-27"), [])]),
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
      eapply(evar("function_call"), [estring(name), make_value(value)]);
    };

    switch (value) {
    | Terminal(kind, multiplier) => terminal_op(kind, multiplier)
    | Group(value, multiplier) => group_op(value, multiplier)
    | Combinator(kind, values) => combinator_op(kind, values)
    | Function_call(name, value) => function_call(name, value)
    };
  };

  let make_to_string = (value: Css_spec_parser.value) => {
    let rec make_to_string_expr = (value: Css_spec_parser.value, expr) => {
      switch (value) {
      | Terminal(kind, multiplier) =>
        let make_base = var_expr =>
          switch (kind) {
          | Keyword(name) => estring(name)
          | Delim(d) => estring(d)
          | Data_type(name) =>
            let module_name = value_name_to_module_name(name);
            eapply(evar(module_name ++ ".toString"), [var_expr]);
          | Property_type(name) =>
            let module_name =
              property_value_name(name) |> value_name_to_module_name;
            eapply(evar(module_name ++ ".toString"), [var_expr]);
          };
        apply_to_string_multiplier(multiplier, make_base, expr);
      | Combinator(kind, values) =>
        switch (kind) {
        | Xor =>
          let names = variant_names(values);
          let pairs = List.combine(names, values);
          let cases =
            List.map(
              ((variant_name, value)) => {
                let pattern =
                  switch (value) {
                  | Terminal(Keyword(_), _)
                  | Terminal(Delim(_), _) => ppat_variant(variant_name, None)
                  | _ =>
                    let var_name = "v";
                    ppat_variant(variant_name, Some(pvar(var_name)));
                  };
                let body =
                  switch (value) {
                  | Terminal(Keyword(name), _) => estring(name)
                  | Terminal(Delim(d), _) => estring(d)
                  | _ => make_to_string_expr(value, evar("v"))
                  };
                case(~lhs=pattern, ~guard=None, ~rhs=body);
              },
              pairs,
            );
          pexp_match(expr, cases);
        | Static
        | And =>
          let var_names =
            List.mapi((i, _) => "v" ++ string_of_int(i), values);
          let pattern = ppat_tuple(List.map(pvar, var_names));
          let exprs =
            List.map2(
              (var_name, value) => {
                make_to_string_expr(value, evar(var_name))
              },
              var_names,
              values,
            );
          let combined =
            List.fold_left(
              (acc, e) => {
                eapply(
                  evar("^"),
                  [eapply(evar("^"), [acc, estring(" ")]), e],
                )
              },
              List.hd(exprs),
              List.tl(exprs),
            );
          pexp_let(
            Nonrecursive,
            [value_binding(~pat=pattern, ~expr)],
            combined,
          );
        | Or =>
          let var_names =
            List.mapi((i, _) => "v" ++ string_of_int(i), values);
          let pattern = ppat_tuple(List.map(pvar, var_names));
          let exprs =
            List.map2(
              (var_name, value) => {
                let inner_expr = make_to_string_expr(value, evar("x"));
                pexp_match(
                  evar(var_name),
                  [
                    case(
                      ~lhs=
                        ppat_construct(
                          txt(Lident("Some")),
                          Some(pvar("x")),
                        ),
                      ~guard=None,
                      ~rhs=inner_expr,
                    ),
                    case(
                      ~lhs=ppat_construct(txt(Lident("None")), None),
                      ~guard=None,
                      ~rhs=estring(""),
                    ),
                  ],
                );
              },
              var_names,
              values,
            );

          let rec build_combine = exprs => {
            switch (exprs) {
            | [] => estring("")
            | [single] => single
            | [first, ...rest] =>
              let rest_combined = build_combine(rest);
              let s1_name = "s" ++ string_of_int(List.length(exprs));
              let s2_name = "s" ++ string_of_int(List.length(exprs) + 1);
              pexp_let(
                Nonrecursive,
                [value_binding(~pat=pvar(s1_name), ~expr=first)],
                pexp_let(
                  Nonrecursive,
                  [value_binding(~pat=pvar(s2_name), ~expr=rest_combined)],
                  pexp_ifthenelse(
                    eapply(evar("=="), [evar(s1_name), estring("")]),
                    evar(s2_name),
                    Some(
                      pexp_ifthenelse(
                        eapply(evar("=="), [evar(s2_name), estring("")]),
                        evar(s1_name),
                        Some(
                          eapply(
                            evar("^"),
                            [
                              eapply(
                                evar("^"),
                                [evar(s1_name), estring(" ")],
                              ),
                              evar(s2_name),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            };
          };
          let combined = build_combine(exprs);
          pexp_let(
            Nonrecursive,
            [value_binding(~pat=pattern, ~expr)],
            combined,
          );
        }
      | Group(value, multiplier) =>
        let make_inner = var_expr => make_to_string_expr(value, var_expr);
        apply_to_string_multiplier(multiplier, make_inner, expr);
      | Function_call(name, value) =>
        let inner = make_to_string_expr(value, expr);
        eapply(
          evar("^"),
          [
            eapply(
              evar("^"),
              [eapply(evar("^"), [estring(name), estring("(")]), inner],
            ),
            estring(")"),
          ],
        );
      };
    }
    and apply_to_string_multiplier = (multiplier, make_base, expr) => {
      switch (multiplier) {
      | One => make_base(expr)
      | Optional =>
        pexp_match(
          expr,
          [
            case(
              ~lhs=ppat_construct(txt(Lident("Some")), Some(pvar("x"))),
              ~guard=None,
              ~rhs=make_base(evar("x")),
            ),
            case(
              ~lhs=ppat_construct(txt(Lident("None")), None),
              ~guard=None,
              ~rhs=estring(""),
            ),
          ],
        )
      | Zero_or_more
      | One_or_more
      | At_least_one
      | Repeat(_)
      | Repeat_by_comma(_, _) =>
        let mapper =
          pexp_fun(Nolabel, None, pvar("x"), make_base(evar("x")));
        [%expr [%e expr] |> List.map([%e mapper]) |> String.concat(" ")];
      };
    };

    let body = make_to_string_expr(value, evar("value"));
    [%expr (value: t) => [%e body]];
  };

  let get_module_binding_info = (mb: Ppxlib.module_binding) => {
    switch (mb) {
    | {
        pmb_name: {txt: Some(module_name), _},
        pmb_expr:
          {
            pmod_desc:
              Pmod_extension((
                {txt: "value.rec", _},
                PStr([
                  {
                    pstr_desc:
                      Pstr_eval(
                        {
                          pexp_desc:
                            Pexp_constant(
                              Pconst_string(value_spec, _loc, _delim),
                            ),
                          _,
                        },
                        _attrs,
                      ),
                    _,
                  },
                ]),
              )),
            _,
          },
        _,
      } =>
      Some((module_name, value_spec))
    | _ => None
    };
  };

  /* Helper to check if value is an Xor at top level */
  let is_xor_value = value =>
    switch (value) {
    | Combinator(Xor, _) => true
    | _ => false
    };

  /* Generate variant constructors from Xor values */
  let make_xor_constructors = values => {
    let names = variant_names(values);
    let pairs = List.combine(names, values);
    List.map(
      ((type_name, value)) => {
        let args =
          switch (value) {
          | Terminal(Keyword(_), _)
          | Terminal(Delim(_), _) => Pcstr_tuple([])
          | Terminal(kind, multiplier) =>
            let type_ =
              switch (kind) {
              | Delim(_)
              | Keyword(_) => ptyp_constr(txt @@ Lident("unit"), [])
              | Data_type(name) =>
                let module_name = value_name_to_module_name(name);
                ptyp_constr(txt @@ Ldot(Lident(module_name), "t"), []);
              | Property_type(name) =>
                let module_name =
                  property_value_name(name) |> value_name_to_module_name;
                ptyp_constr(txt @@ Ldot(Lident(module_name), "t"), []);
              };
            let type_ = apply_modifier(multiplier, type_);
            Pcstr_tuple([type_]);
          | _ =>
            let type_ = create_type_parser(value);
            Pcstr_tuple([type_]);
          };
        constructor_declaration(~name=txt(type_name), ~args, ~res=None);
      },
      pairs,
    );
  };

  let make_module = (module_name: string, value_spec: string) => {
    switch (Css_spec_parser.value_of_string(value_spec)) {
    | Some(ast) =>
      let parse_expr = make_value(ast);
      let to_string_expr = make_to_string(ast);

      /* Check if we should generate a variant type */
      let (type_decl, core_type_ref) =
        switch (ast) {
        | Combinator(Xor, values) =>
          /* Generate variant type */
          let constructors = make_xor_constructors(values);
          let type_decl = make_variant_declaration("t", constructors);
          let core_type_ref = ptyp_constr(txt(Lident("t")), []);
          (type_decl, core_type_ref);
        | _ =>
          /* Generate abstract type with manifest */
          let core_type = create_type_parser(ast);
          let type_decl = make_type_declaration("t", core_type);
          (type_decl, core_type);
        };

      let sig_t =
        Ast_helper.Sig.type_(~loc, Nonrecursive, [type_decl]);
      let sig_parse =
        Ast_helper.Sig.value(
          ~loc,
          Ast_helper.Val.mk(
            ~loc,
            {
              txt: "parser",
              loc,
            },
            [%type:
              list(Styled_ppx_css_parser.Tokens.t) =>
              (
                Css_grammar_parser__Rule.data(t),
                list(Styled_ppx_css_parser.Tokens.t),
              )
            ],
          ),
        );
      let sig_toString =
        Ast_helper.Sig.value(
          ~loc,
          Ast_helper.Val.mk(
            ~loc,
            {
              txt: "toString",
              loc,
            },
            [%type: t => string],
          ),
        );
      let module_type =
        Ast_helper.Mty.signature(~loc, [sig_t, sig_parse, sig_toString]);

      /* Module implementation */
      let type_item = Ast_helper.Str.type_(~loc, Nonrecursive, [type_decl]);

      let parse_val = [%stri let parser = [%e parse_expr]];
      let toString_val = [%stri let toString = [%e to_string_expr]];

      /* Add warning suppression for unused variables in generated code */
      let parse_val_with_attr = {
        ...parse_val,
        pstr_desc:
          switch (parse_val.pstr_desc) {
          | Pstr_value(rec_flag, bindings) =>
            let bindings_with_attr =
              List.map(
                vb =>
                  {
                    ...vb,
                    pvb_attributes: [
                      attribute(
                        ~name=txt("ocaml.warning"),
                        ~payload=PStr([pstr_eval(estring("-8-26-27"), [])]),
                      ),
                      ...vb.pvb_attributes,
                    ],
                  },
                bindings,
              );
            Pstr_value(rec_flag, bindings_with_attr);
          | other => other
          },
      };

      let module_struct =
        Ast_helper.Mod.structure(
          ~loc,
          [type_item, parse_val_with_attr, toString_val],
        );
      let mb =
        Ast_helper.Mb.mk(
          ~loc,
          {
            txt: Some(module_name),
            loc,
          },
          Ast_helper.Mod.constraint_(~loc, module_struct, module_type),
        );

      Some(mb);
    | None => None
    };
  };

  let make_modules = (module_bindings: list(Ppxlib.module_binding)) => {
    module_bindings
    |> List.filter_map(mb => {
         switch (get_module_binding_info(mb)) {
         | Some((module_name, value_spec)) =>
           make_module(module_name, value_spec)
         | None => None
         }
       });
  };
};
