open Longident;
exception Unsupported;
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

  let abstract_type = name => {
    type_declaration(
      ~name=txt(name),
      ~params=[],
      ~cstrs=[],
      ~private_=Public,
      ~manifest=None,
      ~kind=Ptype_abstract,
    );
  };
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

  let make_type = (name, types) => {
    let core_type = ptyp_variant(types, Closed, None);
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

  let apply_modifier = (modifier, type_, is_constructor, params) =>
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
    let terminal_op = (kind, multiplier) => {
      let (type_, is_constructor, params) =
        switch (kind) {
        | Keyword(name) => (first_uppercase(name), false, [])
        | Data_type(name) =>
          let name = value_name_of_css(name);
          let params = [ptyp_constr(txt @@ Lident(name), [])];
          (first_uppercase(name), false, params);
        | Property_type(name) =>
          let name = property_value_name(name) |> value_name_of_css;
          let params = [ptyp_constr(txt @@ Lident(name), [])];
          (first_uppercase(name), false, params);
        | _ => raise(Unsupported)
        };
      apply_modifier(multiplier, type_, is_constructor, params);
    };

    let combinator_op = (kind, values) => {
      switch (kind) {
      | Xor =>
        List.map(
          fun
          | Terminal(kind, multiplier) => terminal_op(kind, multiplier)
          | _ => raise(Unsupported),
          values,
        )
      | _ => raise(Unsupported)
      };
    };

    switch (value) {
    | Terminal(kind, multiplier) =>
      make_type(type_name) @@ [terminal_op(kind, multiplier)]
    | Combinator(kind, values) =>
      make_type(type_name) @@ combinator_op(kind, values)
    // | Group(value, multiplier) => group_op(value, multiplier)
    // | Function_call(name, value) => function_call(name, value)
    | _ => abstract_type(type_name)
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

  let abstract_type = name => {
    type_declaration(
      ~loc=Location.none,
      ~name={txt: name, loc: Location.none},
      ~params=[],
      ~cstrs=[],
      ~private_=Public,
      ~manifest=None,
      ~kind=Ptype_abstract,
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
          | `Length(
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
              ],
            )
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
    type_("any_value", [%type: unit]),
    // abstract_type("string"), already represented by OCaml string type
    type_("url", [%type: string]),
    type_("hex_color", [%type: string]),
    type_("interpolation", [%type: list(string)]),
    type_("flex_value", [%type: [ | `Fr(float)]]),
    // Not at Standard.re but required by genereted code, should they live here?
    abstract_type("hash_token"),
    abstract_type("dimension"),
    abstract_type("an_plus_b"),
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
    try(Emit.create_value_parser(name, ast)) {
    | Unsupported => Emit.abstract_type(name)
    };
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