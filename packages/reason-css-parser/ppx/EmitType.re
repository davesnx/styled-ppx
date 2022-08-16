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

  let mk_typ = (name, types) => {
    let core_type = ptyp_variant(types, Closed, None);
    let declarations = type_declaration(~name=txt(name), ~params=[], ~cstrs=[], ~kind=Ptype_abstract, ~private_=Public, ~manifest=Some(core_type));
    pstr_type(Recursive, [declarations])
  }

  let mk_branch = (name, constructor, types) => {
    rtag(txt(name), constructor, types)
  }
  
  let apply_modifier = {
    (modifier, rule) =>
      switch (modifier) {
      | One => { 
        mk_branch(rule, false, [])
      }
      | _ => failwith("todo")
      };
  };

  let create_value_parser = (type_name, value) => {
    let terminal_op = (kind, multiplier) => {
      let rule = switch(kind){
        | Keyword(name) => name
        | _ => assert false;
      }
      apply_modifier(multiplier, rule);
    };

    let combinator_op = (kind, values) => {
      switch(kind) {
        | Xor => List.map(fun
          | Terminal(kind, multiplier) => terminal_op(kind, multiplier) 
          | _ => failwith("todo")
          , values
        )
        | _ => assert false
      }
    }

    let apply = fun
    | Terminal(kind, multiplier) => [terminal_op(kind, multiplier)]
    // | Group(value, multiplier) => group_op(value, multiplier)
    | Combinator(kind, values) => combinator_op(kind, values)
    // | Function_call(name, value) => function_call(name, value)
    | _ => failwith("todo");
  
    let rows = apply(value);
    mk_typ(type_name, rows);
  };
};

let extract_ppx_content = (exp : Parsetree.expression ) => {
  switch(exp.pexp_desc){
    | Pexp_extension((_, PStr([{pstr_desc: Pstr_eval({pexp_desc: Pexp_constant(Pconst_string(value, loc, _delim)), _}, _attrs) , _}]))) => (value, loc)
    | _ => assert false
  }
}
let extract_variable_name = (pat : Parsetree.pattern) => {
    switch(pat.ppat_desc){
      | Ppat_var({txt, _}) => txt
      | _ => failwith("expected variable name")
    }
  };