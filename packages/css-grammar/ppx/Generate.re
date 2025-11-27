module Make = (Builder: Ppxlib.Ast_builder.S) => {
  open Ppxlib;
  open Builder;
  open Css_spec_parser;

  let txt = txt => {
    Location.loc: Builder.loc,
    txt,
  };

  let kebab_case_to_snake_case = name => {
    /* Strip leading hyphens (e.g., "-non-standard-color" -> "non_standard_color") */
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

  let kebab_case_to_pascal_case = name =>
    name
    |> String.split_on_char('-')
    |> List.filter(s => String.length(s) > 0)
    |> List.map(first_uppercase)
    |> String.concat("");

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
    /* Handle special characters that can't be OCaml identifiers */
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

  let make_variant_branch = (name, constructor, types) => {
    rtag(txt(name), constructor, types);
  };

  /* Helper to check if a type is unimplemented (always fails at parse time). These should generate `unit` as a placeholder type. */
  let is_invalid_type = name => {
    switch (name) {
    | "declaration_value"
    | "function_token"
    | "any_value"
    | "hash_token"
    | "zero"
    | "custom_property_name"
    | "declaration_list"
    | "an_plus_b"
    | "declaration"
    | "decibel"
    | "urange"
    | "semitones"
    | "url_token" => true
    | _ => false
    };
  };

  /* Helper to check if a type is a primitive wrapper */
  let is_primitive_wrapper_type = name => {
    switch (name) {
    | "integer"
    | "number"
    | "percentage"
    | "ident"
    | "custom_ident"
    | "dashed_ident"
    | "custom_ident_without_span_or_auto"
    | "hex_color"
    | "interpolation"
    | "media_type"
    | "container_name"
    | "ident_token"
    | "string_token"
    | "url_no_interp" /* url_no_interp returns string */
    | "string" /* string is an alias to string_token */ => true
    | _ => false
    };
  };

  /* Helper to get the inner type of a primitive wrapper */
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
    | "string" /* string is an alias to string_token */ => [%type: string]
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

  // List of ONLY standard specs defined in Standard.re that use direct parser references
  // Everything else uses local bindings (for let rec) or lookup_property_rule()
  let standard_specs = [
    "integer",
    "number",
    "length",
    "angle",
    "time",
    "frequency",
    "resolution",
    "percentage",
    "ident",
    "custom-ident",
    "dashed-ident",
    "custom-ident-without-span-or-auto",
    "url-no-interp",
    "hex-color",
    "interpolation",
    "flex-value",
    "media-type",
    "ident-token",
    "string-token",
    "string",
    "css-wide-keywords",
    /* Note: extended-length, extended-angle, extended-percentage, extended-time, extended-frequency
       are NOT in this list. They use lazy_lookup_property_rule to reference the generated modules
       in Parser.ml which include calc(), min(), and max() support. */
  ];

  let is_standard_spec = name => List.mem(name, standard_specs);

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
        | Data_type(name) =>
          let snake_name = value_name_of_css(name);
          /* Priority order:
             1. Invalid/unimplemented types -> unit
             2. Primitive wrappers (integer, number, etc.) -> unwrapped OCaml types
             3. Everything else -> direct type reference (will be in Types.ml) */
          let params =
            if (is_invalid_type(snake_name)) {
              [
                /* Unimplemented types get unit as placeholder */
                [%type: unit],
              ];
            } else if (is_primitive_wrapper_type(snake_name)) {
              [get_primitive_inner_type(snake_name)];
            } else {
              [
                /* Direct type reference - all types are in the same recursive block */
                ptyp_constr(txt @@ Lident(snake_name), []),
              ];
            };
          (type_name, false, params);
        | Property_type(name) =>
          /* Property types - direct reference */
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
      | Data_type(name) =>
        let snake_name = value_name_of_css(name);
        /* Priority order:
           1. Invalid/unimplemented types -> unit
           2. Primitive wrappers (integer, number, etc.) -> unwrapped OCaml types with modifiers
           3. Everything else -> direct type reference (will be in Types.ml) */
        if (is_invalid_type(snake_name)) {
          /* Unimplemented types get unit as placeholder */
          apply_modifier(
            multiplier,
            [%type: unit],
          );
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
          /* Direct type reference - all types are in the same recursive block */
          let t = ptyp_constr(txt @@ Lident(snake_name), []);
          apply_modifier(multiplier, t);
        };
      | Property_type(name) =>
        /* Property types - direct reference */
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
                  let name =
                    first_uppercase(name) |> kebab_case_to_snake_case;
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

  let create_variant_name = (type_name, name) =>
    type_name ++ "__make__" ++ name;

  let txt = txt => {
    Location.loc: Builder.loc,
    txt,
  };

  let construct = (~expr=None, name) =>
    pexp_construct(txt(Lident(name)), expr);

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

  let rec make_value = (~use_lookup=false, value) => {
    let terminal_op = (kind, modifier) => {
      // as everyrule is in the same namespace
      let rule =
        switch (kind) {
        | Delim(delim) when delim == "," => evar("Standard.comma")
        | Delim(delim) => eapply(evar("Standard.delim"), [estring(delim)])
        | Keyword(name) =>
          eapply(evar("Standard.keyword"), [estring(name)])
        | Data_type(name) =>
          let snake_name = value_name_of_css(name);
          if (is_primitive_wrapper_type(snake_name)) {
            // Primitive wrapper - use Standard.name directly (returns unwrapped values like int, float, string)
            "Standard." ++ snake_name |> evar;
          } else if (is_standard_spec(name)) {
            // Standard spec (length, angle, css-wide-keywords, etc.) - use Standard.name directly
            "Standard." ++ snake_name |> evar;
          } else if (use_lookup) {
            // Use lazy_lookup_value_rule for data types (values and functions)
            eapply(
              evar("lazy_lookup_value_rule"),
              [estring(name)],
            );
          } else {
            // Without lookup - reference local binding directly (for let rec)
            snake_name |> evar;
          };
        | Property_type(name) =>
          if (use_lookup) {
            // Property types use lazy_lookup_property_rule for property references
            eapply(
              evar("lazy_lookup_property_rule"),
              [estring(name)],
            );
          } else {
            // Without lookup - reference local binding directly (for let rec)
            property_value_name(name) |> value_name_of_css |> evar;
          }
        };
      apply_modifier(modifier, rule);
    };
    let group_op = (value, modifier) => {
      /* Primitives now return unwrapped values directly, no need for special handling */
      let base_rule = make_value(~use_lookup, value);
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
        | Xor => evar("Combinators.xor")
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
        eapply(
          evar("Rule.Match.map"),
          [make_value(~use_lookup, value), map_fn],
        );
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
               /* Unwrap primitives in Xor */
               map_value(has_content, true, pair);
             });
        apply(op_ident(kind), args);
      | _ =>
        let combinator_args =
          values
          |> List.mapi((index, v) => ("V" ++ string_of_int(index), v))
          /* Unwrap primitives in Static/And/Or runtime code */
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
      /* Primitives now return unwrapped values directly */
      let arg_expr = make_value(~use_lookup, value);
      eapply(evar("Standard.function_call"), [estring(name), arg_expr]);
    };

    switch (value) {
    | Terminal(kind, multiplier) => terminal_op(kind, multiplier)
    | Group(value, multiplier) => group_op(value, multiplier)
    | Combinator(kind, values) => combinator_op(kind, values)
    | Function_call(name, value) => function_call(name, value)
    };
  };

  /* Check if a spec contains interpolation */
  let rec spec_contains_interpolation = (spec: Css_spec_parser.value): bool => {
    switch (spec) {
    | Terminal(Data_type("interpolation"), _) => true
    | Terminal(_, _) => false
    | Group(inner, _) => spec_contains_interpolation(inner)
    | Combinator(_, values) =>
      List.exists(spec_contains_interpolation, values)
    | Function_call(_, inner) => spec_contains_interpolation(inner)
    };
  };

  /* Generate extract_interpolations function from spec
     This generates a function that walks the parsed value and collects all interpolation strings */
  let generate_extract_interpolations_function =
      (spec: Css_spec_parser.value, ~loc as _: Location.t)
      : Parsetree.expression => {
    /* Helper to generate extraction expression for a value accessed by a variable name */
    let rec generate_extraction =
            (spec: Css_spec_parser.value, var_expr: Parsetree.expression)
            : Parsetree.expression => {
      switch (spec) {
      /* Direct interpolation - extract the string list and join with "." */
      | Terminal(Data_type("interpolation"), modifier) =>
        let extract_one = [%expr String.concat(".", [%e var_expr])];
        switch (modifier) {
        | One => [%expr [[%e extract_one]]]
        | Optional =>
          switch%expr ([%e var_expr]) {
          | None => []
          | Some(parts) => [String.concat(".", parts)]
          }
        | Zero_or_more
        | One_or_more
        | At_least_one
        | Repeat(_)
        | Repeat_by_comma(_, _) => [%expr
           List.map(parts => String.concat(".", parts), [%e var_expr])
          ]
        };

      /* Other terminals (keywords, other data types) - no interpolations */
      | Terminal(_, _) => [%expr []]

      /* Groups - recurse into the inner value */
      | Group(inner, modifier) =>
        let inner_extract = generate_extraction(inner, var_expr);
        switch (modifier) {
        | One => inner_extract
        | Optional =>
          switch%expr ([%e var_expr]) {
          | None => []
          | Some(v) => [%e generate_extraction(inner, evar("v"))]
          }
        | Zero_or_more
        | One_or_more
        | At_least_one
        | Repeat(_)
        | Repeat_by_comma(_, _) => [%expr
           List.concat(
             List.map(
               v => [%e generate_extraction(inner, evar("v"))],
               [%e var_expr],
             ),
           )
          ]
        };

      /* Xor combinator - pattern match on variants */
      | Combinator(Xor, values) =>
        let names = variant_names(values);
        let pairs = List.combine(names, values);
        let cases =
          List.map(
            ((name, inner_spec)) => {
              let has_content =
                switch (inner_spec) {
                | Terminal(Keyword(_), _) => false
                | _ => true
                };
              if (has_content && spec_contains_interpolation(inner_spec)) {
                case(
                  ~lhs=ppat_variant(name, Some(pvar("inner"))),
                  ~guard=None,
                  ~rhs=generate_extraction(inner_spec, evar("inner")),
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

      /* Static/And combinator - tuple, extract from each element */
      | Combinator(Static, values)
      | Combinator(And, values) =>
        let extractions =
          List.mapi(
            (i, inner_spec) =>
              if (spec_contains_interpolation(inner_spec)) {
                let var_name = "v" ++ string_of_int(i);
                generate_extraction(inner_spec, evar(var_name));
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
        /* Generate: let (v0, v1, ...) = var_expr in combined */
        let tuple_pat =
          ppat_tuple(
            List.mapi((i, _) => pvar("v" ++ string_of_int(i)), values),
          );
        pexp_let(
          Nonrecursive,
          [Ast_helper.Vb.mk(tuple_pat, var_expr)],
          combined,
        );

      /* Or combinator - tuple of options, extract from each Some */
      | Combinator(Or, values) =>
        let extractions =
          List.mapi(
            (i, inner_spec) =>
              if (spec_contains_interpolation(inner_spec)) {
                let var_name = "v" ++ string_of_int(i);
                switch%expr ([%e evar(var_name)]) {
                | None => []
                | Some(inner) => [%e
                   generate_extraction(inner_spec, evar("inner"))
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

      /* Function call - recurse into the argument */
      | Function_call(_, inner) => generate_extraction(inner, var_expr)
      };
    };

    /* Generate the function body */
    let body =
      if (spec_contains_interpolation(spec)) {
        generate_extraction(spec, evar("value"));
      } else {
        /* Optimization: if spec doesn't contain interpolation, just return [] */

        [%expr []];
      };

    pexp_fun(Nolabel, None, pvar("value"), body);
  };

  /* Generate to_string function from spec */
  let generate_to_string_function =
      (spec: Css_spec_parser.value, ~loc as _: Location.t)
      : Parsetree.expression => {
    /* For now, generate simple placeholder to_string */
    let collect_cases = (_spec: Css_spec_parser.value): list(Parsetree.case) => {
      [
        /* Placeholder: generate a wildcard case that returns "TODO" */
        case(~lhs=ppat_any, ~guard=None, ~rhs=estring("TODO: to_string")),
      ];
    };

    let cases = collect_cases(spec);
    pexp_fun(
      Nolabel,
      None,
      pvar("value"),
      pexp_match(evar("value"), cases),
    );
  };

  let generate_spec_module =
      (
        ~spec: Css_spec_parser.value,
        ~witness: option(Parsetree.expression),
        ~runtime_module_path: option(string),
        ~type_name: option(string),
        ~loc: Location.t,
      )
      : list(Ppxlib.structure_item) => {
    /* When type_name is provided, generate an alias to Types.<type_name>
       Otherwise, generate the full inline type */
    let core_type =
      switch (type_name) {
      | Some(name) =>
        /* Generate type t = Types.<name> */
        ptyp_constr(txt @@ Ldot(Lident("Types"), name), [])
      | None =>
        /* Generate inline type */
        create_type_parser(spec)
      };
    let type_decl =
      Ast_helper.Str.type_(
        ~loc,
        Nonrecursive,
        [make_type_declaration("t", core_type)],
      );

    let t_type = ptyp_constr(txt @@ Lident("t"), []);
    let string_type = ptyp_constr(txt @@ Lident("string"), []);

    let rule_body = make_value(~use_lookup=true, spec);
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

    let result_type =
      ptyp_constr(txt @@ Lident("result"), [t_type, string_type]);
    let parse_body =
      pexp_fun(
        Nolabel,
        None,
        Ast_helper.Pat.constraint_(~loc, pvar("input"), string_type),
        pexp_constraint([%expr Rule.parse_string(rule, input)], result_type),
      );
    let parse_binding =
      Ast_helper.Str.value(
        ~loc,
        Nonrecursive,
        [Ast_helper.Vb.mk(~loc, pvar("parse"), parse_body)],
      );

    let to_string_inner = generate_to_string_function(spec, ~loc);
    /* Wrap the body with type annotations */
    let to_string_body =
      switch (to_string_inner.pexp_desc) {
      | Pexp_fun(lbl, default, pat, body) =>
        /* Add type constraint to parameter and return type */
        let typed_pat = Ast_helper.Pat.constraint_(~loc, pat, t_type);
        let typed_body = pexp_constraint(body, string_type);
        pexp_fun(lbl, default, typed_pat, typed_body);
      | _ =>
        /* Fallback: wrap entire expression */
        pexp_fun(
          Nolabel,
          None,
          Ast_helper.Pat.constraint_(~loc, pvar("value"), t_type),
          pexp_constraint(
            pexp_apply(to_string_inner, [(Nolabel, evar("value"))]),
            string_type,
          ),
        )
      };
    let to_string_binding =
      Ast_helper.Str.value(
        ~loc,
        Nonrecursive,
        [Ast_helper.Vb.mk(~loc, pvar("to_string"), to_string_body)],
      );

    let string_list_type =
      ptyp_constr(txt @@ Lident("list"), [string_type]);
    let extract_interpolations_inner =
      generate_extract_interpolations_function(spec, ~loc);
    /* Wrap with type annotations */
    let extract_interpolations_body =
      switch (extract_interpolations_inner.pexp_desc) {
      | Pexp_fun(lbl, default, pat, body) =>
        let typed_pat = Ast_helper.Pat.constraint_(~loc, pat, t_type);
        let typed_body = pexp_constraint(body, string_list_type);
        pexp_fun(lbl, default, typed_pat, typed_body);
      | _ =>
        /* Fallback: wrap entire expression */
        pexp_fun(
          Nolabel,
          None,
          Ast_helper.Pat.constraint_(~loc, pvar("value"), t_type),
          pexp_constraint(
            pexp_apply(
              extract_interpolations_inner,
              [(Nolabel, evar("value"))],
            ),
            string_list_type,
          ),
        )
      };
    let extract_interpolations_binding =
      Ast_helper.Str.value(
        ~loc,
        Nonrecursive,
        [
          Ast_helper.Vb.mk(
            ~loc,
            pvar("extract_interpolations"),
            extract_interpolations_body,
          ),
        ],
      );

    let base_bindings = [
      type_decl,
      rule_binding,
      parse_binding,
      to_string_binding,
      extract_interpolations_binding,
    ];

    /* Always emit runtime_module and runtime_module_path bindings (as option types) */
    let runtime_module_binding =
      switch (witness) {
      | Some(witness_expr) =>
        /* Wrap the witness module in Some */
        Ast_helper.Str.value(
          ~loc,
          Nonrecursive,
          [
            Ast_helper.Vb.mk(
              ~loc,
              pvar("runtime_module"),
              pexp_construct(txt(Lident("Some")), Some(witness_expr)),
            ),
          ],
        )
      | None =>
        /* No runtime module provided - emit None */
        Ast_helper.Str.value(
          ~loc,
          Nonrecursive,
          [
            Ast_helper.Vb.mk(
              ~loc,
              pvar("runtime_module"),
              pexp_construct(txt(Lident("None")), None),
            ),
          ],
        )
      };

    let runtime_module_path_binding =
      switch (runtime_module_path) {
      | Some(path) =>
        /* Wrap the path string in Some */
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
        /* No runtime module path provided - emit None */
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

    base_bindings @ [runtime_module_binding, runtime_module_path_binding];
  };
};
