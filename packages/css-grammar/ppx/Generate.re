module Make = (Builder: Ppxlib.Ast_builder.S) => {
  open Ppxlib;
  open Builder;
  open Css_spec_parser;

  let txt = txt => {
    Location.loc: Builder.loc,
    txt,
  };

  let kebab_case_to_snake_case = name => {
    let name =
      if (String.length(name) > 0 && name.[0] == '-') {
        String.sub(name, 1, String.length(name) - 1);
      } else {
        name;
      };
    name |> String.split_on_char('-') |> String.concat("_");
  };

  let first_uppercase = name =>
    if (String.length(name) == 0) {
      "";
    } else {
      (String.sub(name, 0, 1) |> String.uppercase_ascii)
      ++ String.sub(name, 1, String.length(name) - 1);
    };

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
    | "||" => "doublevbar"
    | "~" => "tilde"
    | "$" => "dollar"
    | _ => "unknown";

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
    kebab_case_to_snake_case(str);
  };

  let keyword_to_css = str => {
    let str =
      if (String.length(str) > 0 && str.[0] == '@') {
        "at_" ++ String.sub(str, 1, String.length(str) - 1);
      } else {
        str;
      };
    switch (str) {
    | "%" => "percent"
    | ">" => "biggerthan"
    | ">=" => "biggerthan_equal"
    | "<" => "lessthan"
    | "<=" => "lessthan_equal"
    | "+" => "cross"
    | "~" => "tilde"
    | "||" => "doublevbar"
    | "|" => "vbar"
    | "=" => "equal"
    | "#" => "hash"
    | "!" => "bang"
    | _ => kebab_case_to_snake_case(str)
    };
  };

  let rec variant_name = value => {
    let value_name =
      switch (value) {
      | Terminal(Delim(name), _) => value_of_delimiter(name)
      | Terminal(Keyword(name), _) => keyword_to_css(name)
      | Terminal(Data_type(name, _), _) => value_name_of_css(name)
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

  let make_variant_branch = (name, constructor, types) => {
    rtag(txt(name), constructor, types);
  };

  type standard_spec_kind =
    | Valid
    | Primitive
    | Invalid;

  let spec_names: list((string, standard_spec_kind)) = [
    ("integer", Primitive),
    ("number", Primitive),
    ("percentage", Primitive),
    ("ident", Primitive),
    ("custom-ident", Primitive),
    ("dashed-ident", Primitive),
    ("custom-ident-without-span-or-auto", Primitive),
    ("hex-color", Primitive),
    ("interpolation", Primitive),
    ("media-type", Primitive),
    ("container-name", Primitive),
    ("ident-token", Primitive),
    ("string-token", Primitive),
    ("url-no-interp", Primitive),
    ("string", Primitive),
    ("length", Valid),
    ("angle", Valid),
    ("time", Valid),
    ("frequency", Valid),
    ("resolution", Valid),
    ("flex-value", Valid),
    ("css-wide-keywords", Valid),
    ("declaration-value", Primitive),
    ("any-value", Invalid),
    ("function-token", Invalid),
    ("hash-token", Invalid),
    ("custom-property-name", Invalid),
    ("an-plus-b", Invalid),
    ("decibel", Invalid),
    ("urange", Invalid),
    ("semitones", Invalid),
    ("url-token", Invalid),
  ];

  let find_spec_kind = snake_name => {
    let css_name = String.map(c => c == '_' ? '-' : c, snake_name);
    List.assoc_opt(css_name, spec_names);
  };

  let is_invalid_type = name => find_spec_kind(name) == Some(Invalid);

  let is_primitive_wrapper_type = name =>
    find_spec_kind(name) == Some(Primitive);

  let get_primitive_inner_type = name => {
    switch (name) {
    | "integer" => [%type: int]
    | "number"
    | "percentage" => [%type: float]
    | "interpolation" => [%type: list(string)]
    | "url_no_interp" => [%type: string]
    | "ident"
    | "custom_ident"
    | "dashed_ident"
    | "custom_ident_without_span_or_auto"
    | "hex_color"
    | "media_type"
    | "container_name"
    | "ident_token"
    | "string_token"
    | "string" => [%type: string]
    | "declaration_value" => [%type: string]
    | _ => failwith("Not a primitive wrapper type")
    };
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

  let is_standard_spec = name => List.mem_assoc(name, spec_names);

  let property_registry_prefix = "property_";

  let registry_key_of_terminal = kind =>
    switch (kind) {
    | Data_type(name, _) =>
      if (is_primitive_wrapper_type(value_name_of_css(name))
          || is_standard_spec(name)) {
        None;
      } else {
        Some(name);
      }
    | Property_type(name) => Some(property_registry_prefix ++ name)
    | Delim(_)
    | Keyword(_) => None
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
        | Keyword(_name) => (type_name, false, [])
        | Data_type(name, _) =>
          let snake_name = value_name_of_css(name);
          let params =
            if (is_invalid_type(snake_name)) {
              [[%type: unit]];
            } else if (is_primitive_wrapper_type(snake_name)) {
              [get_primitive_inner_type(snake_name)];
            } else {
              [ptyp_constr(txt @@ Lident(snake_name), [])];
            };
          (type_name, false, params);
        | Property_type(name) =>
          let snake_name = value_name_of_css(name);
          let property_type_name = "property_" ++ snake_name;
          let params = [ptyp_constr(txt @@ Lident(property_type_name), [])];
          (type_name, false, params);
        | Delim(_string) =>
          let params = [ptyp_constr(txt @@ Lident("unit"), [])];
          (type_name, false, params);
        };
      apply_xor_modifier(multiplier, type_, is_constructor, params);
    }

    and terminal_op = (kind, multiplier) => {
      switch (kind) {
      | Delim(_)
      | Keyword(_) =>
        let t = ptyp_constr(txt @@ Lident("unit"), []);
        apply_modifier(multiplier, t);
      | Data_type(name, _) =>
        let snake_name = value_name_of_css(name);
        if (is_invalid_type(snake_name)) {
          apply_modifier(multiplier, [%type: unit]);
        } else if (is_primitive_wrapper_type(snake_name)) {
          switch (multiplier) {
          | One => get_primitive_inner_type(snake_name)
          | Optional =>
            ptyp_constr(
              txt @@ Lident("option"),
              [get_primitive_inner_type(snake_name)],
            )
          | Repeat(_)
          | Repeat_by_comma(_, _)
          | Zero_or_more
          | One_or_more
          | At_least_one =>
            ptyp_constr(
              txt @@ Lident("list"),
              [get_primitive_inner_type(snake_name)],
            )
          };
        } else {
          let t = ptyp_constr(txt @@ Lident(snake_name), []);
          apply_modifier(multiplier, t);
        };
      | Property_type(name) =>
        let snake_name = value_name_of_css(name);
        let property_type_name = "property_" ++ snake_name;
        let t = ptyp_constr(txt @@ Lident(property_type_name), []);
        apply_modifier(multiplier, t);
      };
    }

    and combinator_op: (combinator, list(value)) => Parsetree.core_type =
        (kind, values) => {
      switch (kind) {
      | Xor =>
        let names = variant_names(values);
        let pairs = List.combine(names, values);
        let types =
          List.map(
            ((type_name, value)) =>
              switch (value) {
              | Terminal(kind, multiplier) =>
                terminal_xor_op(type_name, kind, multiplier)
              | Function_call(name, value) =>
                let name = first_uppercase(name) |> kebab_case_to_snake_case;
                let type_ = function_call(name, value);
                make_variant_branch(type_name, false, [type_]);
              | Combinator(kind, values) =>
                let type_ = combinator_op(kind, values);
                make_variant_branch(type_name, false, [type_]);
              | Group(value, multiplier) =>
                let type_ = group_op(value, multiplier);
                make_variant_branch(type_name, false, [type_]);
              },
            pairs,
          );
        ptyp_variant(types, Closed, None);
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

  let construct = (~expr=None, name) =>
    pexp_construct(txt(Lident(name)), expr);

  let apply_modifier = {
    let option_int_to_expr =
      fun
      | None => construct("None")
      | Some(int) => construct(~expr=Some(eint(int)), "Some");
    let modifier_op =
      fun
      | One => evar("Modifier.one")
      | Zero_or_more => evar("Modifier.zero_or_more")
      | One_or_more => evar("Modifier.one_or_more")
      | Optional => evar("Modifier.optional")
      | Repeat(min, max) =>
        eapply(
          evar("Modifier.repeat"),
          [pexp_tuple([eint(min), option_int_to_expr(max)])],
        )
      | Repeat_by_comma(min, max) =>
        eapply(
          evar("Modifier.repeat_by_comma"),
          [pexp_tuple([eint(min), option_int_to_expr(max)])],
        )
      | At_least_one => evar("Modifier.at_least_one");

    (modifier, rule) =>
      switch (modifier) {
      | One => rule
      | modifier =>
        let op = modifier_op(modifier);
        eapply(op, [rule]);
      };
  };

  let rec make_value = value => {
    let split_last = values => {
      let rec loop = (acc, values) =>
        switch (values) {
        | [] => None
        | [last] => Some((List.rev(acc), last))
        | [value, ...rest] => loop([value, ...acc], rest)
        };
      loop([], values);
    };
    let extract_block_wrapper = value =>
      switch (value) {
      | Combinator(Static, [first, ...rest]) =>
        switch (split_last(rest)) {
        | Some((middle, last)) =>
          switch (first, last) {
          | (Terminal(Delim("("), One), Terminal(Delim(")"), One)) =>
            Some((`Paren, middle))
          | (Terminal(Delim("["), One), Terminal(Delim("]"), One)) =>
            Some((`Bracket, middle))
          | _ => None
          }
        | None => None
        }
      | _ => None
      };
    let wrap_block_rule = (kind, inner_values) => {
      let unit_expr = pexp_construct(txt(Lident("()")), None);
      let inner_rule =
        switch (inner_values) {
        | [] => evar("Rule.Pattern.identity")
        | [single] => make_value(single)
        | values => make_value(Combinator(Static, values))
        };
      let block_rule =
        eapply(
          evar(
            switch (kind) {
            | `Paren => "Css_value_types.paren_block"
            | `Bracket => "Css_value_types.bracket_block"
            },
          ),
          [inner_rule],
        );
      let (pattern, expr) =
        switch (inner_values) {
        | [] => (
            ppat_construct(txt(Lident("()")), None),
            pexp_tuple([unit_expr, unit_expr]),
          )
        | [_single] => (
            pvar("v"),
            pexp_tuple([unit_expr, evar("v"), unit_expr]),
          )
        | values =>
          let names =
            values |> List.mapi((index, _) => "v" ++ string_of_int(index));
          let pattern = ppat_tuple(List.map(name => pvar(name), names));
          let expr_values =
            [unit_expr, ...List.map(name => evar(name), names)]
            @ [unit_expr];
          let expr = pexp_tuple(expr_values);
          (pattern, expr);
        };
      let map_fn = pexp_fun(Nolabel, None, pattern, expr);
      eapply(evar("Rule.Match.map"), [block_rule, map_fn]);
    };
    let terminal_op = (kind, modifier) => {
      let rule =
        switch (kind) {
        | Delim(delim) when delim == "," => evar("Css_value_types.comma")
        | Delim(delim) =>
          eapply(evar("Css_value_types.delim"), [estring(delim)])
        | Keyword(name) =>
          eapply(evar("Css_value_types.keyword"), [estring(name)])
        | Data_type(name, _)
        | Property_type(name) =>
          switch (registry_key_of_terminal(kind)) {
          | Some(key) => eapply(evar("lookup"), [estring(key)])
          | None => "Css_value_types." ++ value_name_of_css(name) |> evar
          }
        };
      apply_modifier(modifier, rule);
    };
    let group_op = (value, modifier) => {
      let base_rule = make_value(value);
      apply_modifier(modifier, base_rule);
    };
    let combinator_op = (kind, values) => {
      let apply = (fn, args) => {
        let args = elist(args);
        eapply(fn, [args]);
      };
      let op_ident =
        fun
        | Static => evar("Combinators.static")
        | Xor => evar("Combinators.xor_with_expected")
        | And => evar("Combinators.and_")
        | Or => evar("Combinators.or_");

      let map_value = (content, _should_unwrap, (name, value)) => {
        let (pattern, expr) =
          if (content) {
            let variant = pexp_variant(name, Some(evar("v")));
            (pvar("v"), variant);
          } else {
            let variant = pexp_variant(name, None);
            (pvar("_v"), variant);
          };

        let map_fn = pexp_fun(Nolabel, None, pattern, expr);
        eapply(evar("Rule.Match.map"), [make_value(value), map_fn]);
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
               let expected =
                 switch (value) {
                 | Terminal(Keyword(name), _) => Some(name)
                 | Function_call(name, _) => Some("function " ++ name)
                 | _ => None
                 };
               let expected_expr =
                 switch (expected) {
                 | Some(value) =>
                   pexp_construct(
                     txt(Lident("Some")),
                     Some(estring(value)),
                   )
                 | None => pexp_construct(txt(Lident("None")), None)
                 };
               let rule_expr = map_value(has_content, true, pair);
               pexp_tuple([expected_expr, rule_expr]);
             });
        apply(op_ident(kind), args);
      | _ =>
        let combinator_args =
          values
          |> List.mapi((index, v) => ("V" ++ string_of_int(index), v))
          |> List.map(map_value(true, true));
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
        eapply(evar("Rule.Match.map"), [combinator, map_fn]);
      };
    };
    let function_call = (name, value) => {
      let arg_expr = make_value(value);
      eapply(
        evar("Css_value_types.function_call"),
        [estring(name), arg_expr],
      );
    };

    switch (extract_block_wrapper(value)) {
    | Some((kind, inner_values)) => wrap_block_rule(kind, inner_values)
    | None =>
      switch (value) {
      | Terminal(kind, multiplier) => terminal_op(kind, multiplier)
      | Group(value, multiplier) => group_op(value, multiplier)
      | Combinator(kind, values) => combinator_op(kind, values)
      | Function_call(name, value) => function_call(name, value)
      }
    };
  };

  let extract_module_name_from_path = (path: string): option(string) =>
    if (String.length(path) == 0) {
      None;
    } else {
      switch (String.split_on_char('.', path)) {
      | ["Css_types", module_name] => Some(module_name)
      | _ => None
      };
    };

  let make_type_path_expr = (path: string): Parsetree.expression => {
    switch (extract_module_name_from_path(path)) {
    | Some(module_name) =>
      let lid = Longident.Ldot(Longident.Lident("Css_types"), module_name);
      let construct_expr = pexp_construct(txt(lid), None);
      pexp_extension((
        txt("module_path"),
        PStr([pstr_eval(construct_expr, [])]),
      ));
    | None => estring(path)
    };
  };

  let is_primitive_type = name => {
    switch (name) {
    | "integer"
    | "number"
    | "percentage"
    | "interpolation"
    | "url_no_interp"
    | "ident"
    | "custom-ident"
    | "custom_ident"
    | "dashed-ident"
    | "dashed_ident"
    | "custom-ident-without-span-or-auto"
    | "custom_ident_without_span_or_auto"
    | "hex-color"
    | "hex_color"
    | "media-type"
    | "media_type"
    | "container-name"
    | "container_name"
    | "ident-token"
    | "ident_token"
    | "string-token"
    | "string_token"
    | "string" => true
    | _ => false
    };
  };

  let rec spec_may_contain_interpolation = (spec: Css_spec_parser.value): bool => {
    switch (spec) {
    | Terminal(Data_type("interpolation", _), _) => true
    | Terminal(Data_type(name, _), _) =>
      !is_primitive_type(name) && !is_standard_spec(name)
    | Terminal(Property_type(_), _) => true
    | Terminal(_, _) => false
    | Group(inner, _) => spec_may_contain_interpolation(inner)
    | Combinator(_, values) =>
      List.exists(spec_may_contain_interpolation, values)
    | Function_call(_, inner) => spec_may_contain_interpolation(inner)
    };
  };

  let rec get_registry_key_from_spec =
          (spec: Css_spec_parser.value): option(string) => {
    switch (spec) {
    | Terminal(Data_type(name, _), _) =>
      if (is_primitive_type(name)) {
        None;
      } else {
        Some(name);
      }
    | Terminal(Property_type(name), _) => Some("property_" ++ name)
    | Group(inner, _) => get_registry_key_from_spec(inner)
    | Combinator(Xor, [single]) => get_registry_key_from_spec(single)
    | Combinator(Xor, options) =>
      List.find_map(
        opt =>
          switch (opt) {
          | Terminal(Data_type("interpolation", _), _) => None
          | _ => get_registry_key_from_spec(opt)
          },
        options,
      )
    | _ => None
    };
  };

  let resolve_context_expr =
      (~registry_key: option(string), ~fallback_expr: Parsetree.expression) =>
    switch (registry_key) {
    | Some(key) => [%expr
       resolve_runtime_module_path(
         [%e estring(key)],
         ~fallback=[%e fallback_expr],
       )
      ]
    | None => fallback_expr
    };

  let generate_extract_interpolations_function =
      (
        spec: Css_spec_parser.value,
        ~runtime_module_path: option(string),
        ~initial_type_context_expr: Parsetree.expression,
        ~loc as _: Location.t,
      )
      : Parsetree.expression => {
    let rec generate_typed_extraction =
            (
              spec: Css_spec_parser.value,
              var_expr: Parsetree.expression,
              type_context_expr: Parsetree.expression,
            )
            : Parsetree.expression => {
      switch (spec) {
      | Terminal(Data_type("interpolation", _), modifier) =>
        let name_expr = [%expr String.concat(".", [%e var_expr])];
        let pair = [%expr ([%e name_expr], [%e type_context_expr])];
        switch (modifier) {
        | One => [%expr [[%e pair]]]
        | Optional =>
          switch%expr ([%e var_expr]) {
          | None => []
          | Some(parts) => [
              (String.concat(".", parts), [%e type_context_expr]),
            ]
          }
        | Zero_or_more
        | One_or_more
        | At_least_one
        | Repeat(_)
        | Repeat_by_comma(_, _) => [%expr
           List.map(
             parts => (String.concat(".", parts), [%e type_context_expr]),
             [%e var_expr],
           )
          ]
        };

      | Terminal(Data_type(name, _), modifier)
          when !is_primitive_type(name) && !is_standard_spec(name) =>
        let css_name = estring(name);
        let generate_delegation = inner_expr => [%expr
          extract_from_registry_ast(
            [%e css_name],
            [%e type_context_expr],
            Obj.repr([%e inner_expr]),
          )
        ];
        switch (modifier) {
        | One => generate_delegation(var_expr)
        | Optional =>
          switch%expr ([%e var_expr]) {
          | None => []
          | Some(inner) => [%e generate_delegation(evar("inner"))]
          }
        | Zero_or_more
        | One_or_more
        | At_least_one
        | Repeat(_)
        | Repeat_by_comma(_, _) => [%expr
           List.concat_map(
             item => [%e generate_delegation(evar("item"))],
             [%e var_expr],
           )
          ]
        };

      | Terminal(Property_type(name), modifier) =>
        let css_name = estring("property_" ++ name);
        let generate_delegation = inner_expr => [%expr
          extract_from_registry_ast(
            [%e css_name],
            [%e type_context_expr],
            Obj.repr([%e inner_expr]),
          )
        ];
        switch (modifier) {
        | One => generate_delegation(var_expr)
        | Optional =>
          switch%expr ([%e var_expr]) {
          | None => []
          | Some(inner) => [%e generate_delegation(evar("inner"))]
          }
        | Zero_or_more
        | One_or_more
        | At_least_one
        | Repeat(_)
        | Repeat_by_comma(_, _) => [%expr
           List.concat_map(
             item => [%e generate_delegation(evar("item"))],
             [%e var_expr],
           )
          ]
        };

      | Terminal(_, _) => [%expr []]

      | Group(inner, modifier) =>
        let inner_extract =
          generate_typed_extraction(inner, var_expr, type_context_expr);
        switch (modifier) {
        | One => inner_extract
        | Optional =>
          switch%expr ([%e var_expr]) {
          | None => []
          | Some(v) => [%e
             generate_typed_extraction(inner, evar("v"), type_context_expr)
            ]
          }
        | Zero_or_more
        | One_or_more
        | At_least_one
        | Repeat(_)
        | Repeat_by_comma(_, _) => [%expr
           List.concat(
             List.map(
               v =>
                 [%e
                  generate_typed_extraction(
                    inner,
                    evar("v"),
                    type_context_expr,
                  )
                 ],
               [%e var_expr],
             ),
           )
          ]
        };

      | Combinator(Xor, values) =>
        let names = variant_names(values);
        let pairs = List.combine(names, values);

        let sibling_type =
          List.find_map(
            inner_spec =>
              switch (inner_spec) {
              | Terminal(Data_type("interpolation", _), _) => None
              | _ => get_registry_key_from_spec(inner_spec)
              },
            values,
          );

        let effective_context_expr =
          resolve_context_expr(
            ~registry_key=sibling_type,
            ~fallback_expr=type_context_expr,
          );

        let cases =
          List.map(
            ((name, inner_spec)) => {
              let has_content =
                switch (inner_spec) {
                | Terminal(Keyword(_), _) => false
                | _ => true
                };
              if (has_content && spec_may_contain_interpolation(inner_spec)) {
                let context_for_this_spec =
                  switch (inner_spec, runtime_module_path) {
                  | (
                      Terminal(Data_type("interpolation", _), _),
                      Some("Css_types.Border"),
                    ) => effective_context_expr
                  | (Terminal(Data_type("interpolation", _), _), Some(_)) => type_context_expr
                  | (Terminal(Data_type("interpolation", _), _), None) => effective_context_expr
                  | _ => effective_context_expr
                  };
                case(
                  ~lhs=ppat_variant(name, Some(pvar("inner"))),
                  ~guard=None,
                  ~rhs=
                    generate_typed_extraction(
                      inner_spec,
                      evar("inner"),
                      context_for_this_spec,
                    ),
                );
              } else {
                case(
                  ~lhs=
                    ppat_variant(
                      name,
                      has_content ? Some(pvar("_")) : None,
                    ),
                  ~guard=None,
                  ~rhs=[%expr []],
                );
              };
            },
            pairs,
          );
        pexp_match(var_expr, cases);

      | Combinator(Static, values)
      | Combinator(And, values) =>
        let extractions =
          List.mapi(
            (i, inner_spec) =>
              if (spec_may_contain_interpolation(inner_spec)) {
                let var_name = "v" ++ string_of_int(i);
                let pos_type_expr =
                  resolve_context_expr(
                    ~registry_key=get_registry_key_from_spec(inner_spec),
                    ~fallback_expr=type_context_expr,
                  );
                generate_typed_extraction(
                  inner_spec,
                  evar(var_name),
                  pos_type_expr,
                );
              } else {
                [%expr []];
              },
            values,
          );
        let combined =
          List.fold_right(
            (extract, acc) => [%expr [%e extract] @ [%e acc]],
            extractions,
            [%expr []],
          );
        let tuple_pat =
          ppat_tuple(
            List.mapi((i, _) => pvar("v" ++ string_of_int(i)), values),
          );
        pexp_let(
          Nonrecursive,
          [Ast_helper.Vb.mk(tuple_pat, var_expr)],
          combined,
        );

      | Combinator(Or, values) =>
        let extractions =
          List.mapi(
            (i, inner_spec) =>
              if (spec_may_contain_interpolation(inner_spec)) {
                let var_name = "v" ++ string_of_int(i);
                let pos_type_expr =
                  resolve_context_expr(
                    ~registry_key=get_registry_key_from_spec(inner_spec),
                    ~fallback_expr=type_context_expr,
                  );
                switch%expr ([%e evar(var_name)]) {
                | None => []
                | Some(inner) => [%e
                   generate_typed_extraction(
                     inner_spec,
                     evar("inner"),
                     pos_type_expr,
                   )
                  ]
                };
              } else {
                [%expr []];
              },
            values,
          );
        let combined =
          List.fold_right(
            (extract, acc) => [%expr [%e extract] @ [%e acc]],
            extractions,
            [%expr []],
          );
        let tuple_pat =
          ppat_tuple(
            List.mapi((i, _) => pvar("v" ++ string_of_int(i)), values),
          );
        pexp_let(
          Nonrecursive,
          [Ast_helper.Vb.mk(tuple_pat, var_expr)],
          combined,
        );

      | Function_call(_, inner) =>
        generate_typed_extraction(inner, var_expr, type_context_expr)
      };
    };

    let body =
      if (spec_may_contain_interpolation(spec)) {
        generate_typed_extraction(
          spec,
          evar("value"),
          initial_type_context_expr,
        );
      } else {
        [%expr []];
      };

    body;
  };

  let generate_spec_module =
      (
        ~spec: Css_spec_parser.value,
        ~runtime_module_path: option(string),
        ~loc: Location.t,
      )
      : list(Ppxlib.structure_item) => {
    let core_type = create_type_parser(spec);
    let type_decl =
      Ast_helper.Str.type_(
        ~loc,
        Nonrecursive,
        [make_type_declaration("t", core_type)],
      );

    let t_type = ptyp_constr(txt @@ Lident("t"), []);
    let string_type = ptyp_constr(txt @@ Lident("string"), []);
    let default_type_path_expr =
      switch (runtime_module_path) {
      | Some(path) => make_type_path_expr(path)
      | None => estring("")
      };

    let rule_body = make_value(spec);
    let rule_type =
      ptyp_constr(txt @@ Ldot(Lident("Rule"), "rule"), [t_type]);
    let rule_binding =
      Ast_helper.Str.value(
        ~loc,
        Nonrecursive,
        [
          Ast_helper.Vb.mk(
            ~loc,
            Ast_helper.Pat.constraint_(~loc, pvar("rule"), rule_type),
            rule_body,
          ),
        ],
      );

    let error_info_type =
      ptyp_constr(txt @@ Ldot(Lident("Rule"), "error_info"), []);
    let result_type =
      ptyp_constr(txt @@ Lident("result"), [t_type, error_info_type]);
    let component_value_list_type =
      ptyp_constr(
        txt @@
        Ldot(
          Ldot(Lident("Styled_ppx_css_parser"), "Ast"),
          "component_value_list",
        ),
        [],
      );
    let type_check_body =
      pexp_fun(
        Nolabel,
        None,
        Ast_helper.Pat.constraint_(
          ~loc,
          pvar("input"),
          component_value_list_type,
        ),
        pexp_constraint([%expr Rule.run(rule, input)], result_type),
      );
    let type_check_binding =
      Ast_helper.Str.value(
        ~loc,
        Nonrecursive,
        [Ast_helper.Vb.mk(~loc, pvar("type_check"), type_check_body)],
      );

    let string_string_pair_type = ptyp_tuple([string_type, string_type]);
    let string_string_list_type =
      ptyp_constr(txt @@ Lident("list"), [string_string_pair_type]);
    let extract_interpolations_inner =
      generate_extract_interpolations_function(
        spec,
        ~runtime_module_path,
        ~initial_type_context_expr=default_type_path_expr,
        ~loc,
      );
    let infer_interpolation_types_body =
      pexp_fun(
        Nolabel,
        None,
        Ast_helper.Pat.constraint_(~loc, pvar("value"), t_type),
        pexp_constraint(
          extract_interpolations_inner,
          string_string_list_type,
        ),
      );
    let infer_interpolation_types_with_context_initial_type_expr =
      if%expr (type_context == "") {
        [%e default_type_path_expr];
      } else {
        type_context;
      };
    let infer_interpolation_types_with_context_inner =
      generate_extract_interpolations_function(
        spec,
        ~runtime_module_path,
        ~initial_type_context_expr=infer_interpolation_types_with_context_initial_type_expr,
        ~loc,
      );
    let infer_interpolation_types_with_context_body =
      pexp_fun(
        Nolabel,
        None,
        Ast_helper.Pat.constraint_(~loc, pvar("type_context"), string_type),
        pexp_fun(
          Nolabel,
          None,
          Ast_helper.Pat.constraint_(~loc, pvar("value"), t_type),
          pexp_constraint(
            infer_interpolation_types_with_context_inner,
            string_string_list_type,
          ),
        ),
      );
    let infer_interpolation_types_binding =
      Ast_helper.Str.value(
        ~loc,
        Nonrecursive,
        [
          Ast_helper.Vb.mk(
            ~loc,
            pvar("infer_interpolation_types"),
            infer_interpolation_types_body,
          ),
        ],
      );
    let infer_interpolation_types_with_context_binding =
      Ast_helper.Str.value(
        ~loc,
        Nonrecursive,
        [
          Ast_helper.Vb.mk(
            ~loc,
            pvar("infer_interpolation_types_with_context"),
            infer_interpolation_types_with_context_body,
          ),
        ],
      );

    let runtime_module_path_binding =
      switch (runtime_module_path) {
      | Some(path) =>
        Ast_helper.Str.value(
          ~loc,
          Nonrecursive,
          [
            Ast_helper.Vb.mk(
              ~loc,
              pvar("runtime_module_path"),
              pexp_construct(txt(Lident("Some")), Some(estring(path))),
            ),
          ],
        )
      | None =>
        Ast_helper.Str.value(
          ~loc,
          Nonrecursive,
          [
            Ast_helper.Vb.mk(
              ~loc,
              pvar("runtime_module_path"),
              pexp_construct(txt(Lident("None")), None),
            ),
          ],
        )
      };

    [
      type_decl,
      rule_binding,
      type_check_binding,
      infer_interpolation_types_binding,
      infer_interpolation_types_with_context_binding,
      runtime_module_path_binding,
    ];
  };
};
