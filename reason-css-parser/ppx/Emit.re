open Migrate_parsetree;
open Ast_408;
open Ast_helper;
open Longident;

open Reason_css_vds;

let create_variant_name = (type_name, name) =>
  type_name ++ "__make__" ++ name;

let txt = txt => {Location.loc: Location.none, txt};

let lident = name => Lident(name) |> txt |> Exp.ident;
let ldot = (module_name, name) =>
  Ldot(Lident(module_name), name) |> txt |> Exp.ident;

let module_op = ldot("Op");
let module_values = ldot("Values");

let construct = (~expr=None, name) =>
  Exp.construct(txt(Lident(name)), expr);

let kebab_case_to_snake_case = name =>
  name |> String.split_on_char('-') |> String.concat("_");
let first_uppercase = name =>
  (String.sub(name, 0, 1) |> String.uppercase_ascii)
  ++ String.sub(name, 1, String.length(name) - 1);

let property_value_name = property_name => "property-value-" ++ property_name;
let property_name = property_name => "property-" ++ property_name;
let function_value_name = function_name => "function-" ++ function_name;
let value_name_of_css = kebab_case_to_snake_case;

// TODO: multiplier name
let rec variant_name = value => {
  let value_name =
    switch (value) {
    | Terminal(Keyword(name), _)
    | Terminal(Function(name), _)
    | Terminal(Data_type(name), _) => value_name_of_css(name)
    | Terminal(Property_type(name), _) =>
      property_name(name) |> value_name_of_css
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
     );
};

let apply_modifier = {
  let int_to_expr = int => Const.int(int) |> Exp.constant;
  let option_int_to_expr =
    fun
    | None => construct("None")
    | Some(int) => construct(~expr=Some(int_to_expr(int)), "Some");
  let modifier_op =
    fun
    | One => [%expr one]
    | Zero_or_more => [%expr zero_or_more]
    | One_or_more => [%expr one_or_more]
    | Optional => [%expr optional]
    | Repeat(min, max) => [%expr
        repeat(([%e int_to_expr(min)], [%e option_int_to_expr(max)]))
      ]
    | Repeat_by_comma(min, max) => [%expr
        repeat_by_comma((
          [%e int_to_expr(min)],
          [%e option_int_to_expr(max)],
        ))
      ]
    | At_least_one => [%expr at_least_one];
  (modifier, rule) =>
    switch (modifier) {
    | One => rule
    | modifier =>
      let op = modifier_op(modifier);
      let expr = [%expr [%e op]([%e rule])];
      expr;
    };
};

let rec create_value_parser = value => {
  let terminal_op = (kind, modifier) => {
    // as everyrule is in the same namespace
    let rule =
      switch (kind) {
      | Keyword(name) =>
        let name = Const.string(name) |> Exp.constant;
        let expr = [%expr keyword([%e name])];
        expr;
      | Data_type(name) => value_name_of_css(name) |> lident
      | Property_type(name) =>
        property_value_name(name) |> value_name_of_css |> lident
      | Function(name) =>
        function_value_name(name) |> value_name_of_css |> lident
      };
    apply_modifier(modifier, rule);
  };
  let group_op = (value, modifier) =>
    create_value_parser(value) |> apply_modifier(modifier);
  let combinator_op = (kind, values) => {
    let apply = (fn, a, b) => [%expr [%e fn]([%e a], [%e b])];
    let op_ident =
      fun
      | Static => [%expr (+)]
      | And => [%expr (land)]
      | Or => [%expr (lor)]
      | Xor => [%expr (lxor)];
    let emit_xor_values = (v1, vs) => {
      let parse_value = ((name, value)) => {
        let value_expr = create_value_parser(value);
        switch (value) {
        | Terminal(Keyword(_), _) =>
          apply([%expr value], Exp.variant(name, None), value_expr)
        | _ =>
          let body = Exp.variant(name, Some(lident("value")));
          let map_fn = [%expr (value => [%e body])];
          apply([%expr map], value_expr, map_fn);
        };
      };

      let all_values = [v1, ...vs];
      let names = variant_names(all_values) |> List.rev;
      // TODO: can raise
      let (v1, vs) =
        switch (List.combine(names, all_values)) {
        | [v1, ...vs] => (v1, vs)
        | [] => failwith("what? That is impossible")
        };

      (parse_value(v1), List.map(parse_value, vs));
    };

    let emit_combinator = (kind, v1, vs) => {
      let apply = apply(op_ident(kind));
      let (v1, vs) =
        switch (kind) {
        | Xor => emit_xor_values(v1, vs)
        | _ => (create_value_parser(v1), List.map(create_value_parser, vs))
        };
      List.fold_left(apply, v1, vs);
    };

    switch (kind, values) {
    | (_, []) => failwith("should be unreachable")
    | (_, [v1]) => create_value_parser(v1)
    | (kind, [v1, ...vs]) => emit_combinator(kind, v1, vs)
    };
  };
  let function_call = (name, value) => {
    let name = Const.string(name) |> Exp.constant;
    let value = create_value_parser(value);
    let expr = [%expr function_call([%e name], [%e value])];
    expr;
  };

  switch (value) {
  | Terminal(kind, multiplier) => terminal_op(kind, multiplier)
  | Group(value, multiplier) => group_op(value, multiplier)
  | Combinator(kind, values) => combinator_op(kind, values)
  | Function_call(name, value) => function_call(name, value)
  };
};

let create_property_parser = name =>
  create_value_parser(
    Combinator(
      Xor,
      [
        Terminal(Data_type("css-wide-keywords"), One),
        Terminal(Data_type(name), One),
      ],
    ),
  );
