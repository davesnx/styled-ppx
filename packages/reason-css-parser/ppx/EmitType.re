open Longident;
module Make = (Ast_builder: Ppxlib.Ast_builder.S) => {
  open Ast_builder;
  open Css_spec_parser;

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

  let make_type = (name, core_type) => {
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

  let create_value_parser = (type_name, value) => {
    let rec create_type =
      fun
      | Terminal(kind, multiplier) => terminal_op(kind, multiplier)
      | Combinator(kind, values) => combinator_op(kind, values)
      | Function_call(name, value) => function_call(name, value)
      | Group(value, multiplier) => group_op(value, multiplier)

    and terminal_xor_op = (kind, multiplier) => {
      let (type_, is_constructor, params) =
        switch (kind) {
        | Keyword(name) => (
            first_uppercase(name) |> kebab_case_to_snake_case,
            false,
            [],
          )
        | Data_type(name) =>
          let name = value_name_of_css(name);
          let params = [ptyp_constr(txt @@ Lident(name), [])];
          (first_uppercase(name), false, params);
        | Property_type(name) =>
          let name = property_value_name(name) |> value_name_of_css;
          let params = [ptyp_constr(txt @@ Lident(name), [])];
          (first_uppercase(name), false, params);

        | Delim(string) =>
          let name = value_of_delimiter(string) |> first_uppercase;
          let params = [ptyp_constr(txt @@ Lident("unit"), [])];
          (name, false, params);
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
                | Terminal(kind, multiplier) =>
                  terminal_xor_op(kind, multiplier)
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
        | And =>
          let types = List.map(create_type, values);
          ptyp_tuple(types);

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
    | Terminal(kind, multiplier) =>
      make_type(type_name) @@ terminal_op(kind, multiplier)
    | Combinator(kind, values) =>
      make_type(type_name) @@ combinator_op(kind, values)
    | Function_call(name, value) =>
      make_type(type_name) @@ function_call(name, value)
    | Group(value, multiplier) =>
      make_type(type_name) @@ group_op(value, multiplier)
    };
  };
};

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

  let loc = Location.none;

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


    // From Parser_helper, those are implemented as `invalid`, thats why they have type unit
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

let gen_type = (binding: Parsetree.value_binding) => {
  let (name, payload, loc) =
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
                          Pexp_constant(Pconst_string(value, loc, _delim)),
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
        loc,
      )
    | _ => failwith("Error when extracting CSS spec content")
    };
  switch (Css_spec_parser.value_of_string(payload)) {
  | Some(ast) =>
    module Loc: {let loc: Location.t;} = {
      let loc = loc;
    };
    module Ast_builder = Ppxlib.Ast_builder.Make(Loc);
    module Emit = Make(Ast_builder);
    Emit.create_value_parser(name, ast)
  | None => failwith("Error while parsing CSS spec")
  };
};

let gen_types = bindings => {
  let type_declarations = List.map(gen_type, bindings);
  let loc = List.hd(type_declarations).ptype_loc;
  let types =
    Ast_helper.Str.type_(~loc, Recursive, type_declarations @ standard_types);
  let types_structure = Ast_helper.Mod.structure(~loc, [types]);
  [%stri module Types = [%m types_structure]];
};