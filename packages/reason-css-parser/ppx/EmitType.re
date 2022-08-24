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

  let empty_type = name => {
    let type_ =
      type_declaration(
        ~name=txt(name),
        ~params=[],
        ~cstrs=[],
        ~private_=Private,
        ~manifest=None,
        ~kind=Ptype_variant([]),
      );
    pstr_type(Recursive, [type_]);
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

  let mk_typ = (name, types) => {
    let core_type = ptyp_variant(types, Closed, None);
    let declarations =
      type_declaration(
        ~name=txt(name),
        ~params=[],
        ~cstrs=[],
        ~kind=Ptype_abstract,
        ~private_=Public,
        ~manifest=Some(core_type),
      );
    pstr_type(Recursive, [declarations]);
  };

  let mk_branch = (name, constructor, types) => {
    rtag(txt(name), constructor, types);
  };

  let apply_modifier = (modifier, type_, is_constructor, params) =>
    switch (modifier) {
    | One => mk_branch(type_, is_constructor, params)
    | Optional =>
      let params = [ptyp_constr(txt @@ Lident("option"), params)];
      mk_branch(type_, is_constructor, params);
    | Repeat(_)
    | Repeat_by_comma(_, _)
    | Zero_or_more
    | One_or_more
    | At_least_one =>
      let params = [ptyp_constr(txt @@ Lident("list"), params)];
      mk_branch(type_, is_constructor, params);
    };

  let create_value_parser = (type_name, value) => {
    let terminal_op = (kind, multiplier) => {
      let (type_, is_constructor, params) =
        switch (kind) {
        | Keyword(name) => (first_uppercase(name), false, [])
        | Data_type(name) =>
          let name = value_name_of_css(name);
          let params = [ptyp_constr(txt @@ Lident(name), [])];
          (first_uppercase(name), true, params);
        | Property_type(name) =>
          let name = property_value_name(name) |> value_name_of_css;
          let params = [ptyp_constr(txt @@ Lident(name), [])];
          (first_uppercase(name), true, params);
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
      mk_typ(type_name) @@ [terminal_op(kind, multiplier)]
    | Combinator(kind, values) =>
      mk_typ(type_name) @@ combinator_op(kind, values)
    // | Group(value, multiplier) => group_op(value, multiplier)
    // | Function_call(name, value) => function_call(name, value)
    | _ => empty_type(type_name)
    };
  };
};

let extract_ppx_content = (exp: Parsetree.expression) => {
  switch (exp.pexp_desc) {
  | Pexp_extension((
      _,
      PStr([
        {
          pstr_desc:
            Pstr_eval(
              {
                pexp_desc: Pexp_constant(Pconst_string(value, loc, _delim)),
                _,
              },
              _attrs,
            ),
          _,
        },
      ]),
    )) => (
      value,
      loc,
    )
  | _ => failwith("expected a ppx extension")
  };
};

let extract_variable_name = (pat: Parsetree.pattern) => {
  switch (pat.ppat_desc) {
  | Ppat_var({txt, _}) => txt
  | _ => failwith("expected variable name")
  };
};

let gen_types = bindings => {
  let rec inner = (bindings: list(Parsetree.value_binding), acc) => {
    switch (bindings) {
    | [] => acc
    | [head, ...rest] =>
      let name = extract_variable_name(head.pvb_pat);
      let (payload, loc) = extract_ppx_content(head.pvb_expr);
      let type_ =
        switch (Css_spec_parser.value_of_string(payload)) {
        | Some(ast) =>
          module Loc: {let loc: Location.t;} = {
            let loc = loc;
          };
          module Ast_builder = Ppxlib.Ast_builder.Make(Loc);
          module Emit = Make(Ast_builder);
          try(Emit.create_value_parser(name, ast)) {
          | Unsupported => Emit.empty_type(name)
          };
        | None => failwith("Error while parsing CSS spec")
        };
      inner(rest, [type_, ...acc]);
    };
  };

  let types = inner(bindings, []);
  let loc = List.hd(types).pstr_loc;
  let types = Ast_helper.Mod.structure(~loc, types);
  //   let typ = Emit.create_value_parser(name, ast);
  [%stri module Types = [%m types]];
};