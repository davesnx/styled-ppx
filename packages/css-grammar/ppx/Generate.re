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

  let make_variant_branch = (name, constructor, types) => {
    rtag(txt(name), constructor, types);
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
          let name = value_name_of_css(name);
          /* For primitive wrappers, unwrap to get the inner type */
          let params =
            if (is_primitive_wrapper_type(name)) {
              [get_primitive_inner_type(name)];
            } else {
              [ptyp_constr(txt @@ Lident(name), [])];
            };
          (type_name, false, params);
        | Property_type(name) =>
          let name = property_value_name(name) |> value_name_of_css;
          let params = [ptyp_constr(txt @@ Lident(name), [])];
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
        let name = value_name_of_css(name);
        /* Unwrap primitives, applying modifiers to the inner type */
        if (is_primitive_wrapper_type(name)) {
          switch (multiplier) {
          | One => get_primitive_inner_type(name)
          | Optional =>
            ptyp_constr(
              txt @@ Lident("option"),
              [get_primitive_inner_type(name)],
            )
          | Repeat(_)
          | Repeat_by_comma(_, _)
          | Zero_or_more
          | One_or_more
          | At_least_one =>
            ptyp_constr(
              txt @@ Lident("list"),
              [get_primitive_inner_type(name)],
            )
          };
        } else {
          let t = ptyp_constr(txt @@ Lident(name), []);
          apply_modifier(multiplier, t);
        };
      | Property_type(name) =>
        let name = property_value_name(name) |> value_name_of_css;
        let t = ptyp_constr(txt @@ Lident(name), []);
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

  /* TODO: Move this to Standard and use as ppx_runtime */
  let standard_types = {
    let type_ = (~kind=Parsetree.Ptype_abstract, name, core_type) => {
      Builder.type_declaration(
        ~name={
          txt: name,
          loc: Location.none,
        },
        ~params=[],
        ~cstrs=[],
        ~private_=Public,
        ~manifest=Some(core_type),
        ~kind,
      );
    };

    [
      type_("integer", [%type: [ | `Integer(int)]]),
      type_("number", [%type: [ | `Number(float)]]),
      type_(
        "length",
        [%type:
          [
            | `Cap(float)
            | `Ch(float)
            | `Em(float)
            | `Ex(float)
            | `Ic(float)
            | `Lh(float)
            | `Rcap(float)
            | `Rch(float)
            | `Rem(float)
            | `Rex(float)
            | `Ric(float)
            | `Rlh(float)
            | `Vh(float)
            | `Vw(float)
            | `Vmax(float)
            | `Vmin(float)
            | `Vb(float)
            | `Vi(float)
            | `Cqw(float)
            | `Cqh(float)
            | `Cqi(float)
            | `Cqb(float)
            | `Cqmin(float)
            | `Cqmax(float)
            | `Px(float)
            | `Cm(float)
            | `Mm(float)
            | `Q(float)
            | `In(float)
            | `Pc(float)
            | `Pt(float)
            | `Zero
          ]
        ],
      ),
      type_(
        "angle",
        [%type:
          [
            | `Deg(float)
            | `Grad(float)
            | `Rad(float)
            | `Turn(float)
          ]
        ],
      ),
      type_(
        "time",
        [%type:
          [
            | `Ms(float)
            | `S(float)
          ]
        ],
      ),
      type_(
        "frequency",
        [%type:
          [
            | `Hz(float)
            | `KHz(float)
          ]
        ],
      ),
      type_(
        "resolution",
        [%type:
          [
            | `Dpi(float)
            | `Dpcm(float)
            | `Dppx(float)
          ]
        ],
      ),
      type_("percentage", [%type: [ | `Percentage(float)]]),
      type_("ident", [%type: [ | `Ident(string)]]),
      type_("custom_ident", [%type: [ | `Custom_ident(string)]]),
      type_("dashed_ident", [%type: [ | `Dashed_ident(string)]]),
      type_(
        "custom_ident_without_span_or_auto",
        [%type: [ | `Custom_ident_without_span_or_auto(string)]],
      ),
      type_("url_no_interp", [%type: string]),
      type_("hex_color", [%type: [ | `Hex_color(string)]]),
      type_("interpolation", [%type: [ | `Interpolation(list(string))]]),
      type_("flex_value", [%type: [ | `Fr(float)]]),
      type_("media_type", [%type: [ | `Media_type(string)]]),
      type_("container_name", [%type: [ | `Container_name(string)]]),
      type_("ident_token", [%type: [ | `Ident_token(string)]]),
      type_("string_token", [%type: [ | `String_token(string)]]),
      // From Parser_helper, those are `invalid` represented here as plain unit
      type_("function_token", [%type: unit]),
      type_("hash_token", [%type: unit]),
      type_("any_value", [%type: unit]),
      type_("declaration_value", [%type: unit]),
      type_("zero", [%type: unit]),
      type_("decibel", [%type: unit]),
      type_("urange", [%type: unit]),
      type_("semitones", [%type: unit]),
      type_("an_plus_b", [%type: unit]),
    ];
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

  let make_all_type = type_declarations => {
    let variants =
      List.map(
        (decl: Parsetree.type_declaration) => {
          let name = decl.ptype_name.txt;
          let variant_name = String.capitalize_ascii(name);
          switch (decl.ptype_manifest) {
          | Some(core_type) => rtag(txt(variant_name), false, [core_type])
          | None =>
            rtag(
              txt(variant_name),
              false,
              [ptyp_constr(txt @@ Lident(name), [])],
            )
          };
        },
        type_declarations,
      );
    let all_type = ptyp_variant(variants, Closed, None);
    make_type_declaration("all", all_type);
  };

  let make_types = bindings => {
    let type_declarations =
      List.map(
        binding => {
          let (name, core_type) = make_type(binding);
          make_type_declaration(name, core_type);
        },
        bindings,
      );

    let all_types = type_declarations @ standard_types;
    let all_type_decl = make_all_type(all_types);

    let loc = List.hd(type_declarations).ptype_loc;
    let types =
      Ast_helper.Str.type_(~loc, Recursive, all_types @ [all_type_decl]);
    let types_structure = Ast_helper.Mod.structure(~loc, [types]);
    [%stri module Types = [%m types_structure]];
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
      list(Tokens.t) =>
      (Css_grammar__Rule.data([%t core_type]), list(Tokens.t))
    ];
    [%expr ([%e expression]: [%t type_anotation])];
  };

  let get_name_from_binding = (binding: Parsetree.value_binding) => {
    switch (binding) {
    | {pvb_pat: {ppat_desc: Ppat_var({txt, _}), _}, _} => Some(txt)
    | _ => None
    };
  };

  let get_source_primitive = (binding: Parsetree.value_binding) => {
    /* Check if this binding is a single primitive wrapper and return the source primitive name */
    switch (binding.pvb_expr.pexp_desc) {
    | Pexp_extension((
        {txt: "value.rec", _},
        PStr([
          {
            pstr_desc:
              Pstr_eval(
                {pexp_desc: Pexp_constant(Pconst_string(value, _, _)), _},
                _,
              ),
            _,
          },
        ]),
      )) =>
      switch (Css_spec_parser.value_of_string(value)) {
      | Some(Terminal(Data_type(name), One)) =>
        let name = value_name_of_css(name);
        if (is_primitive_wrapper_type(name)) {
          Some(name);
        } else {
          None;
        };
      | _ => None
      }
    | _ => None
    };
  };

  let add_unwrapping = (name, expression) => {
    /* Wrap expression with unwrapping logic using Rule.Let monadic bind */
    let tag =
      switch (name) {
      | "integer" => "Integer"
      | "number" => "Number"
      | "percentage" => "Percentage"
      | "ident" => "Ident"
      | "custom_ident" => "Custom_ident"
      | "dashed_ident" => "Dashed_ident"
      | "custom_ident_without_span_or_auto" => "Custom_ident_without_span_or_auto"
      | "hex_color" => "Hex_color"
      | "interpolation" => "Interpolation"
      | "media_type" => "Media_type"
      | "container_name" => "Container_name"
      | "ident_token" => "Ident_token"
      | "string_token" => "String_token"
      | "string" => "String_token" /* string is an alias to string_token */
      | _ => failwith("Not a primitive wrapper: " ++ name)
      };

    [@reason.preserve_braces]
    open%expr Rule.Let;
    let.bind_match [%p ppat_variant(tag, Some(pvar("v")))] = [%e
      expression
    ];
    Rule.Match.return([%e evar("v")]);
  };

  let add_types = (~loc, bindings): list(Ppxlib.structure_item) => {
    let new_bindings =
      bindings
      |> List.map(value_binding => {
           let name = value_binding |> get_name_from_binding;
           switch (name) {
           | Some(type_name) =>
             let expr =
               switch (get_source_primitive(value_binding)) {
               | Some(source_primitive) =>
                 add_unwrapping(source_primitive, value_binding.pvb_expr)
               | None => value_binding.pvb_expr
               };
             let new_expression = add_type_to_expr(type_name, expr);
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
        | Data_type(name) => value_name_of_css(name) |> evar
        | Property_type(name) =>
          property_value_name(name) |> value_name_of_css |> evar
        };
      apply_modifier(modifier, rule);
    };
    let group_op = (value, modifier) => {
      /* Check if this is a primitive that needs unwrapping */
      let base_rule = make_value(value);
      let with_modifier = apply_modifier(modifier, base_rule);

      /* If the inner value is a simple primitive terminal, add unwrapping */
      switch (value) {
      | Terminal(Data_type(name), One) =>
        let name = value_name_of_css(name);
        if (is_primitive_wrapper_type(name)) {
          /* Generate unwrapping code for groups containing primitives */
          let tag =
            switch (name) {
            | "integer" => "Integer"
            | "number" => "Number"
            | "percentage" => "Percentage"
            | "ident" => "Ident"
            | "custom_ident" => "Custom_ident"
            | "dashed_ident" => "Dashed_ident"
            | "custom_ident_without_span_or_auto" => "Custom_ident_without_span_or_auto"
            | "hex_color" => "Hex_color"
            | "interpolation" => "Interpolation"
            | "media_type" => "Media_type"
            | "container_name" => "Container_name"
            | "ident_token" => "Ident_token"
            | "string_token" => "String_token"
            | "string" => "String_token"
            | _ => failwith("Unknown primitive: " ++ name)
            };

          /* Only unwrap for list/optional modifiers in groups (function call context) */
          /* For One multiplier in groups used in combinators, don't unwrap here */
          switch (modifier) {
          | One => with_modifier /* Don't unwrap - will be handled by map_value if in combinator */
          | Optional =>
            /* Optional primitive: map option */
            eapply(
              evar("map"),
              [
                with_modifier,
                pexp_fun(
                  Nolabel,
                  None,
                  pvar("opt"),
                  eapply(
                    evar("Option.map"),
                    [
                      pexp_fun(
                        Nolabel,
                        None,
                        ppat_variant(tag, Some(pvar("v"))),
                        evar("v"),
                      ),
                      evar("opt"),
                    ],
                  ),
                ),
              ],
            )
          | Repeat(_)
          | Repeat_by_comma(_, _)
          | Zero_or_more
          | One_or_more
          | At_least_one =>
            /* List of primitives: map list */
            eapply(
              evar("map"),
              [
                with_modifier,
                pexp_fun(
                  Nolabel,
                  None,
                  pvar("lst"),
                  eapply(
                    evar("List.map"),
                    [
                      pexp_fun(
                        Nolabel,
                        None,
                        ppat_variant(tag, Some(pvar("v"))),
                        evar("v"),
                      ),
                      evar("lst"),
                    ],
                  ),
                ),
              ],
            )
          };
        } else {
          with_modifier;
        };
      | _ => with_modifier
      };
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

      let map_value = (content, should_unwrap, (name, value)) => {
        /* Check if this value is a primitive that needs unwrapping */
        let (pattern, expr) =
          switch (value) {
          | Terminal(Data_type(data_name), multiplier) =>
            let data_name = value_name_of_css(data_name);
            /* Only unwrap primitives in Xor context or in And/Static/Or with One multiplier */
            if (is_primitive_wrapper_type(data_name)
                && content
                && should_unwrap) {
              /* Unwrap the primitive variant */
              let make_unwrap_pattern = tag => {
                switch (multiplier) {
                | One => ppat_variant(tag, Some(pvar("v")))
                | Optional =>
                  /* For optional primitives, match both Some and None cases */
                  pvar("opt_v")
                | Repeat(_)
                | Repeat_by_comma(_, _)
                | Zero_or_more
                | One_or_more
                | At_least_one =>
                  /* For lists of primitives, need to unwrap each element */
                  pvar("list_v")
                };
              };
              let make_unwrap_expr = tag => {
                switch (multiplier) {
                | One => evar("v")
                | Optional =>
                  /* Unwrap the optional primitive */
                  pexp_match(
                    evar("opt_v"),
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
                            Some(ppat_variant(tag, Some(pvar("inner_v")))),
                          ),
                        ~rhs=
                          pexp_construct(
                            txt(Lident("Some")),
                            Some(evar("inner_v")),
                          ),
                        ~guard=None,
                      ),
                    ],
                  )
                | Repeat(_)
                | Repeat_by_comma(_, _)
                | Zero_or_more
                | One_or_more
                | At_least_one =>
                  /* Unwrap each element in the list */
                  eapply(
                    evar("List.map"),
                    [
                      pexp_fun(
                        Nolabel,
                        None,
                        ppat_variant(tag, Some(pvar("item_v"))),
                        evar("item_v"),
                      ),
                      evar("list_v"),
                    ],
                  )
                };
              };

              let tag =
                switch (data_name) {
                | "integer" => "Integer"
                | "number" => "Number"
                | "percentage" => "Percentage"
                | "ident" => "Ident"
                | "custom_ident" => "Custom_ident"
                | "dashed_ident" => "Dashed_ident"
                | "custom_ident_without_span_or_auto" => "Custom_ident_without_span_or_auto"
                | "hex_color" => "Hex_color"
                | "interpolation" => "Interpolation"
                | "media_type" => "Media_type"
                | "container_name" => "Container_name"
                | "ident_token" => "Ident_token"
                | "string_token" => "String_token"
                | "string" => "String_token" /* string is an alias */
                | _ => failwith("Unknown primitive wrapper: " ++ data_name)
                };

              let inner_pattern = make_unwrap_pattern(tag);
              let inner_expr = make_unwrap_expr(tag);
              let variant = pexp_variant(name, Some(inner_expr));
              (inner_pattern, variant);
            } else {
              let variant =
                pexp_variant(name, content ? Some(evar("v")) : None);
              (pvar(content ? "v" : "_v"), variant);
            };
          | _ =>
            let variant =
              pexp_variant(name, content ? Some(evar("v")) : None);
            (pvar(content ? "v" : "_v"), variant);
          };

        let map_fn = pexp_fun(Nolabel, None, pattern, expr);
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
        eapply(evar("map"), [combinator, map_fn]);
      };
    };
    let function_call = (name, value) => {
      /* Check if the function argument is a simple primitive that needs unwrapping */
      let arg_expr =
        switch (value) {
        | Terminal(Data_type(data_name), One) =>
          let data_name = value_name_of_css(data_name);
          if (is_primitive_wrapper_type(data_name)) {
            /* Unwrap the primitive argument */
            let tag =
              switch (data_name) {
              | "integer" => "Integer"
              | "number" => "Number"
              | "percentage" => "Percentage"
              | "ident" => "Ident"
              | "custom_ident" => "Custom_ident"
              | "dashed_ident" => "Dashed_ident"
              | "custom_ident_without_span_or_auto" => "Custom_ident_without_span_or_auto"
              | "hex_color" => "Hex_color"
              | "interpolation" => "Interpolation"
              | "media_type" => "Media_type"
              | "container_name" => "Container_name"
              | "ident_token" => "Ident_token"
              | "string_token" => "String_token"
              | "string" => "String_token"
              | _ => failwith("Unknown primitive: " ++ data_name)
              };
            eapply(
              evar("map"),
              [
                make_value(value),
                pexp_fun(
                  Nolabel,
                  None,
                  ppat_variant(tag, Some(pvar("v"))),
                  evar("v"),
                ),
              ],
            );
          } else {
            make_value(value);
          };
        | _ => make_value(value)
        };

      eapply(evar("function_call"), [estring(name), arg_expr]);
    };

    switch (value) {
    | Terminal(kind, multiplier) => terminal_op(kind, multiplier)
    | Group(value, multiplier) => group_op(value, multiplier)
    | Combinator(kind, values) => combinator_op(kind, values)
    | Function_call(name, value) => function_call(name, value)
    };
  };
};
