open Longident;

module Make = (Ast_builder: Ppxlib.Ast_builder.S) => {
  open Ast_builder;
  open Css_spec_parser;

  let txt = txt => {Location.loc: Ast_builder.loc, txt};

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
      | Terminal(Delim(name), _) => value_of_delimiter(name)
      | Terminal(Keyword(name), _) => kebab_case_to_snake_case(name)
      | Terminal(Data_type(name), _) => value_name_of_css(name)
      | Terminal(Property_type(name), _) => property_value_name(name) |> value_name_of_css
      | Group(value, _) => variant_name(value)
      | Combinator(Static, _) => "static"
      | Combinator(And, _) => "and"
      | Combinator(Or, _) => "or"
      | Combinator(Xor, _) => "xor"
      | Function_call(name, _) => value_name_of_css(name)
      };
    value_name |> first_uppercase;
  };

  let variant_names = (values) => {
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

  let create_type_parser = (value) => {
    let rec create_type =
      fun
      | Terminal(kind, multiplier) => terminal_op(kind, multiplier)
      | Combinator(kind, values)   => combinator_op(kind, values)
      | Function_call(name, value) => function_call(name, value)
      | Group(value, multiplier)   => group_op(value, multiplier)

    and terminal_xor_op = (type_name, kind, multiplier) => {
      let (type_, is_constructor, params) =
        switch (kind) {
        | Keyword(_name) => (type_name, false, [])
        | Data_type(name) =>
          let name = value_name_of_css(name);
          let params = [ptyp_constr(txt @@ Lident(name), [])];
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
      let type_ =
        switch (kind) {
        | Delim(_)
        | Keyword(_) => ptyp_constr(txt @@ Lident("unit"), [])
        | Data_type(name) =>
          let name = value_name_of_css(name);
          ptyp_constr(txt @@ Lident(name), []);
        | Property_type(name) =>
          let name = property_value_name(name) |> value_name_of_css;
          ptyp_constr(txt @@ Lident(name), []);
        };
      apply_modifier(multiplier, type_);
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
                | Terminal(kind, multiplier) => terminal_xor_op(type_name, kind, multiplier)
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
        | And => ptyp_tuple(List.map(create_type, values));
        | Or =>
          let types =
            List.map(create_type, values) |> List.map(apply_modifier(Optional));
          ptyp_tuple(types);
        };
      }

    and function_call = (_name, value) => create_type(value)

    and group_op = (value, multiplier) =>
      create_type(value) |> apply_modifier(multiplier);

    switch (value) {
    | Terminal(kind, multiplier) => terminal_op(kind, multiplier)
    | Combinator(kind, values)   => combinator_op(kind, values)
    | Function_call(name, value) => function_call(name, value)
    | Group(value, multiplier)   => group_op(value, multiplier)
    };
  };

  /* TODO: Move this to Standard and use as ppx_runtime */
  let standard_types = {
    open Ppxlib.Ast_builder.Default;

    let type_ = (~kind=Parsetree.Ptype_abstract, name, core_type) => {
      type_declaration(
        ~loc=Location.none,
        ~name={txt: name, loc: Location.none},
        ~params=[],
        ~cstrs=[],
        ~private_=Public,
        ~manifest=Some(core_type),
        ~kind,
      );
    };

    [
      type_("integer", [%type: int]),
      type_("number", [%type: float]),
      type_(
        "length",
        [%type:
          [
            | `Em(number)
            | `Ex(number)
            | `Cap(number)
            | `Ch(number)
            | `Ic(number)
            | `Rem(number)
            | `Lh(number)
            | `Rlh(number)
            | `Vw(number)
            | `Vh(number)
            | `Vi(number)
            | `Vb(number)
            | `Vmin(number)
            | `Vmax(number)
            | `Cm(number)
            | `Mm(number)
            | `Q(number)
            | `In(number)
            | `Pt(number)
            | `Pc(number)
            | `Px(number)
            | `Zero
          ]
        ],
      ),
      type_(
        "angle",
        [%type:
          [ | `Deg(number) | `Grad(number) | `Rad(number) | `Turn(number)]
        ],
      ),
      type_("time", [%type: [ | `Ms(float) | `S(float)]]),
      type_("frequency", [%type: [ | `Hz(float) | `KHz(float)]]),
      type_(
        "resolution",
        [%type: [ | `Dpi(float) | `Dpcm(float) | `Dppx(float)]],
      ),
      type_("percentage", [%type: float]),
      type_("ident", [%type: string]),
      type_("custom_ident", [%type: string]),
      // abstract_type("string"), already represented by OCaml string type
      type_("url", [%type: string]),
      type_("hex_color", [%type: string]),
      type_("interpolation", [%type: list(string)]),
      type_("flex_value", [%type: [ | `Fr(float)]]),
      type_("line_names", [%type: (unit, list(string), unit)]),

      // From Parser_helper, those are `invalid` represented here as unit
      type_("ident_token", [%type: unit]),
      type_("function_token", [%type: unit]),
      type_("string_token", [%type: unit]),
      type_("hash_token", [%type: unit]),
      type_("dimension", [%type: unit]),
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
          pvb_expr: {
            pexp_desc:
              Pexp_extension((
                _,
                PStr([
                  {
                    pstr_desc:
                      Pstr_eval(
                        {
                          pexp_desc:
                            Pexp_constant(Pconst_string(value, _loc, _delim)),
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

  let make_types = bindings => {
    let type_declarations = List.map((binding) => {
      let (name, core_type) = make_type(binding);
      make_type_declaration(name, core_type);
    }, bindings);

    let loc = List.hd(type_declarations).ptype_loc;
    let types =
      Ast_helper.Str.type_(~loc, Recursive, type_declarations @ standard_types);
    let types_structure = Ast_helper.Mod.structure(~loc, [types]);
    [%stri module Types = [%m types_structure]];
  };

  let add_type_to_expr = (name: string, expression) => {
    let core_type = Ast_helper.Typ.constr(~loc, { loc: Location.none, txt: Ldot(Lident("Types"), name) }, []);
    let type_anotation = [%type: list(Reason_css_lexer.token) => (Reason_css_parser__Rule.data([%t core_type]), list(Reason_css_lexer.token))];
    [%expr ([%e expression]: [%t type_anotation])];
  };

  let get_name_from_binding = (binding: Parsetree.value_binding) => {
    switch (binding) {
    | { pvb_pat: {ppat_desc: Ppat_var({txt, _}), _}, _ } => Some(txt)
    | _ => None
    };
  };

  let add_types = (~loc, bindings) => {
    open Ppxlib;
    let new_bindings = bindings |> List.map((value_binding) => {
      let name = value_binding |> get_name_from_binding;
      switch (name) {
      | Some(type_name) => {
        let new_expression = add_type_to_expr(type_name, value_binding.pvb_expr);
        { ...value_binding, pvb_expr: new_expression}
      }
      | None => value_binding
      }
    });

    [Ast_helper.Str.value(~loc, Recursive, new_bindings)];
  };

  let create_variant_name = (type_name, name) =>
    type_name ++ "__make__" ++ name;

  let txt = txt => {Location.loc: Ast_builder.loc, txt};

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

  let value_of_delimiter = fun
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

  let value_of_keyword = str => {
    switch (str) {
    | "," => "comma"
    | "+" => "cross"
    | "-" => "dash"
    | "*" => "asterisk"
    | "/" => "bar"
    | "@" => "at"
    | s => kebab_case_to_snake_case(s)
    }
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
        | Property_type(name) => property_value_name(name) |> value_name_of_css |> evar
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
        | Static => evar("combine_static")
        | Xor => evar("combine_xor")
        | And => evar("combine_and")
        | Or => evar("combine_or");

      let map_value = (content, (name, value)) => {
        let variant = pexp_variant(name, content ? Some(evar("v")) : None);
        let map_fn =
          pexp_fun(Nolabel, None, pvar(content ? "v" : "_v"), variant);
        eapply(evar("map"), [make_value(value), map_fn]);
      };

      switch (kind) {
      | Xor => {
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
      }
      | _ => {
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

	let make_printer = {
			let standard_printers = [
        [%stri let build_variant = (~loc, name, args) => Ast_helper.Exp.variant(~loc, name, args) ],
        [%stri let txt = (~loc, txt) => {Location.loc: loc, txt}],
        [%stri let list_to_longident = vars => vars |> String.concat(".") |> Lexing.from_string |> Parse.longident],
        [%stri let render_variable = (~loc, name) => list_to_longident(name) |> txt(~loc) |> Ast_helper.Exp.ident],
				[%stri let render_string = (~loc, string) => Helper.Const.string(~quotation_delimiter="js", string) |> Ast_helper.Exp.constant(~loc)],
				[%stri let render_integer = (~loc, int) => Helper.Const.int(int) |> Helper.Exp.constant(~loc)],
				[%stri let render_number  = (~loc, number) => Helper.Const.float(number |> string_of_float) |> Helper.Exp.constant(~loc)],
        [%stri let render_length  = {
              (~loc) => fun
              | `Cap(n) => build_variant(~loc, "cap", Some(render_number(~loc, n)))
              | `Ch(n) => build_variant(~loc, "ch", Some(render_number(~loc, n)))
              | `Cm(n) => build_variant(~loc, "cm", Some(render_number(~loc, n)))
              | `Em(n) => build_variant(~loc, "em", Some(render_number(~loc, n)))
              | `Ex(n) => build_variant(~loc, "ex", Some(render_number(~loc, n)))
              | `Ic(n) => build_variant(~loc, "ic", Some(render_number(~loc, n)))
              | `In(n) => build_variant(~loc, "In", Some(render_number(~loc, n)))
              | `Lh(n) => build_variant(~loc, "lh", Some(render_number(~loc, n)))
              | `Mm(n) => build_variant(~loc, "mm", Some(render_number(~loc, n)))
              | `Pc(n) => build_variant(~loc, "pc", Some(render_number(~loc, n)))
              | `Pt(n) => build_variant(~loc, "pt", Some(render_integer(~loc, n |> int_of_float)))
              | `Px(n) => build_variant(~loc, "pxFloat", Some(render_number(~loc, n)))
              | `Q(n) => build_variant(~loc, "Q", Some(render_number(~loc, n)))
              | `Rem(n) => build_variant(~loc, "em", Some(render_number(~loc, n)))
              | `Rlh(n) => build_variant(~loc, "rlh", Some(render_number(~loc, n)))
              | `Vb(n) => build_variant(~loc, "vb", Some(render_number(~loc, n)))
              | `Vh(n) => build_variant(~loc, "vh", Some(render_number(~loc, n)))
              | `Vi(n) => build_variant(~loc, "vi", Some(render_number(~loc, n)))
              | `Vmax(n) => build_variant(~loc, "vmax", Some(render_number(~loc, n)))
              | `Vmin(n) => build_variant(~loc, "vmin", Some(render_number(~loc, n)))
              | `Vw(n) => build_variant(~loc, "vw", Some(render_number(~loc, n)))
              | `Zero => build_variant(~loc, "zero", None);

        }
            ],
        [%stri let render_angle = (~loc) => fun
              | `Deg(number) =>  build_variant(~loc, "deg", Some(render_number(~loc, number)))
              | `Rad(number) =>  build_variant(~loc, "rad", Some(render_number(~loc, number)))
              | `Grad(number) => build_variant(~loc, "grad", Some(render_number(~loc, number)))
              | `Turn(number) => build_variant(~loc, "turn", Some(render_number(~loc, number)))
            ],
        [%stri let render_percentage = (~loc, number) => build_variant(~loc, "percent", Some(render_number(~loc, number)))]
      ];

    let printers_module = Ast_helper.Mod.structure(~loc, standard_printers);
    [%stri module Printers = [%m printers_module]];
	};
};
