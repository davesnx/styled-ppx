open Ppxlib;
open Css_types;

module Helper = Ast_helper;
module Builder = Ast_builder.Default;

exception Empty_buffer(string);

let reduce_result = (~empty, fn, list) => {
  let rec sequence_result =
    fun
    | [] => empty
    | [x, ...xs] =>
      switch (fn(x)) {
      | Error(_) as error => error
      | Ok(value) =>
        switch (sequence_result(xs)) {
        | Error(_) as error => error
        | Ok(values) => Ok([value, ...values])
        }
      };
  sequence_result(list);
};

module CssJs = {
  let ident = (~loc, name) =>
    {txt: Ldot(Lident("CssJs"), name), loc} |> Builder.pexp_ident(~loc);
  let selector = (~loc) => ident(~loc, "selector");
  let media = (~loc) => ident(~loc, "media");
  let global = (~loc) => ident(~loc, "global");
  let label = (~loc) => ident(~loc, "label");
  let style = (~loc) => ident(~loc, "style");
  let keyframes = (~loc) => ident(~loc, "keyframes");
};

let number_to_const = number =>
  if (String.contains(number, '.')) {
    Helper.Const.float(number);
  } else {
    Helper.Const.integer(number);
  };

let string_to_const = (~loc, s) => {
  switch (File.get()) {
  | Some(ReScript) =>
    Helper.Exp.constant(
      ~loc,
      ~attrs=Platform_attributes.template(~loc),
      Helper.Const.string(~quotation_delimiter="*j", s),
    )
  | Some(Reason)
  | _ =>
    Helper.Exp.constant(
      ~loc,
      Helper.Const.string(~quotation_delimiter="js", s),
    )
  };
};
let render_variable = (~loc, v) => {
  let txt = v |> String.concat(".") |> Longident.parse;
  Helper.Exp.ident({loc, txt});
};

let source_code_of_loc = (loc: Location.t) => {
  let Location.{loc_start, loc_end, _} = loc;
  switch (Driver_.last_buffer^) {
  | Some(buffer: Sedlexing.lexbuf) =>
    /* TODO: pos_offset is hardcoded to 0, unsure about the effects */
    let pos_offset = 0;
    let loc_start = loc_start.pos_cnum - pos_offset;
    let loc_end = loc_end.pos_cnum - pos_offset;
    Sedlexing.Latin1.sub_lexeme(buffer, loc_start, loc_end - loc_start);
  | None => raise(Empty_buffer("last buffer not set"))
  };
};
let concat = (~loc, expr, acc) => {
  let concat_fn = {txt: Lident("^"), loc} |> Helper.Exp.ident(~loc);
  Helper.Exp.apply(~loc, concat_fn, [(Nolabel, expr), (Nolabel, acc)]);
};

let rec render_at_rule = (at_rule: at_rule): Parsetree.expression => {
  switch (at_rule.name) {
  | ("media", _) => render_media_query(at_rule)
  | ("keyframes", loc) =>
    Generate_lib.error(
      ~loc,
      "@keyframes should be defined with %%keyframe(...)",
    )
  | (
      "charset" as n | "import" as n | "namespace" as n | "supports" as n |
      "page" as n |
      "font-face" as n |
      "counter-style" as n |
      "font-feature-values" as n |
      "swash" as n |
      "ornaments" as n |
      "annotation" as n |
      "stylistic" as n |
      "styleset" as n |
      "character-variant" as n |
      "property" as n |
      /* Experimental */ "color-profile" as n |
      /* Experimental */ "viewport" as n |
      /* Deprecated */ "document" as n, /* Deprecated */
      loc,
    ) =>
    Generate_lib.error(
      ~loc,
      Printf.sprintf("At-rule @%s is not supported in styled-ppx", n),
    )
  | (n, loc) => Generate_lib.error(~loc, Printf.sprintf("Unknown @%s ", n))
  };
}
and render_media_query = (at_rule: at_rule): Parsetree.expression => {
  let (prelude, prelude_loc) = at_rule.prelude;
  let parse_condition =
      (component_value: (component_value, location))
      : result(string, Parsetree.expression) => {
    let (value, loc) = component_value;
    let component_value_location = loc;
    switch (value) {
    | Variable(variable) => Ok(render_variable_as_string(variable))
    /* (color) */
    | Paren_block([(Ident(_), ident_loc)]) =>
      Ok(source_code_of_loc(ident_loc))
    /* (min-width: 30px) */
    | Paren_block([
        (Ident(property), _),
        (Delim(":"), _),
        (_value, value_loc),
      ]) =>
      /* We need the value as a string to pipe it to the Property parser */
      let value = source_code_of_loc(value_loc) |> String.trim;
      /* String.trim is a hack, location should be correct and not contain any whitespace */
      switch (Declarations_to_string.parse_declarations(property, value)) {
      | Error(`Not_found) =>
        Error(
          Generate_lib.error(
            ~loc=component_value_location,
            Printf.sprintf("unsupported property: %s", property),
          ),
        )
      | Error(`Invalid_value(_error)) =>
        Error(
          Generate_lib.error(~loc=component_value_location, "invalid value"),
        )
      | Ok(_exprs) =>
        /* Here we receive the expressions transformed, but we prefer the stringed value */
        Ok(value)
      };
    | Paren_block([(Ident(property), _), (Delim(":"), _), ..._value]) =>
      Error(
        Generate_lib.error(
          ~loc=component_value_location,
          Printf.sprintf(
            "There's more than one value assiged to a property: %s",
            property,
          ),
        ),
      )
    /* In any other case, we believe on the source_code and transform it to string. This is unsafe */
    | _whatever => Ok(source_code_of_loc(component_value_location))
    };
  };

  let parse_conditions = prelude => {
    switch (prelude) {
    | (Paren_block(blocks), _) =>
      let conditions = reduce_result(~empty=Ok([]), parse_condition, blocks);
      switch (conditions) {
      | Error(error_expr) => Error(error_expr)
      | Ok(conditions) => Ok("(" ++ String.concat("", conditions) ++ ")")
      };
    | (Ident(i), _) => Ok(i)
    | (Variable(v), _) => Ok(render_variable_as_string(v))
    | _ =>
      /* This branch is whildcared (_) by design of the parser. It won't allow any other component_value */
      Error(Generate_lib.error(~loc=prelude_loc, "Invalid media query"))
    };
  };

  let accumulate_parsed_conditions = condition => {
    reduce_result(~empty=Ok([]), parse_conditions, condition);
  };

  let (delimiter, attrs) =
    Platform_attributes.string_delimiter(~loc=at_rule.loc);

  switch (accumulate_parsed_conditions(prelude)) {
  | Error(error_expr) => error_expr
  | Ok([]) =>
    Generate_lib.error(~loc=prelude_loc, "@media prelude can't be empty")
  | Ok(conditions) =>
    let query =
      conditions
      |> String.concat(" ")
      |> String_interpolation.transform(~attrs, ~delimiter, ~loc=at_rule.loc);

    let rules =
      switch (at_rule.block) {
      | Empty => Builder.pexp_array(~loc=at_rule.loc, [])
      | Rule_list(declaration) =>
        render_declarations(declaration)
        |> Builder.pexp_array(~loc=at_rule.loc)
      | Stylesheet(_) =>
        Generate_lib.error(
          ~loc=at_rule.loc,
          "@media content expect to have declarations, not an stylesheets. Selectors aren't allowed in @media.",
        )
      };

    Helper.Exp.apply(
      ~loc=at_rule.loc,
      /* ~attrs=[Platform_attributes.uncurried(~loc=at_rule.loc)], */
      CssJs.media(~loc=at_rule.loc),
      [(Nolabel, query), (Nolabel, rules)],
    );
  };
}
and render_declaration = (d: declaration): list(Parsetree.expression) => {
  let (property, name_loc) = d.name;
  let (_valueList, loc) = d.value;
  /* String.trim is a hack, location should be correct and not contain any whitespace */
  let value_source = source_code_of_loc(loc) |> String.trim;

  switch (
    Declarations_to_emotion.parse_declarations(
      ~loc=name_loc,
      property,
      value_source,
    )
  ) {
  | Ok(exprs) => exprs
  | Error(`Not_found) => [
      Generate_lib.error(
        ~loc=name_loc,
        "Unknown property '" ++ property ++ "'",
      ),
    ]
  | Error(`Invalid_value(value)) => [
      Generate_lib.error(
        ~loc,
        "Property '"
        ++ property
        ++ "' has an invalid value: '"
        ++ String.trim(value)
        ++ "'",
      ),
    ]
  };
}
and render_declarations = ((ds, _loc: location)) => {
  ds
  |> List.concat_map(declaration =>
       switch (declaration) {
       | Declaration(decl) => render_declaration(decl)
       | At_rule(ar) => [render_at_rule(ar)]
       | Style_rule(style_rules) => [
           render_style_rule(
             CssJs.selector(~loc=style_rules.loc),
             style_rules,
           ),
         ]
       }
     );
}
and render_variable_as_string = variable => {
  "$(" ++ String.concat(".", variable) ++ ")";
}
and render_selector = (selector: selector) => {
  let rec render_simple_selector =
    fun
    | Ampersand => "&"
    | Universal => "*"
    | Type(v) => v
    | Subclass(v) => render_subclass_selector(v)
    | Variable(v) => render_variable_as_string(v)
    | Percentage(v) => Printf.sprintf("%s%%", v)
  /* TODO: Add locations to selector */
  /* TODO: Generate an error here */
  /* Generate_lib.error(
       ~loc=Location.none,
       "Percentage is not a valid selector",
     ) */
  and render_subclass_selector =
    fun
    | Id(v) => Printf.sprintf("#%s", v)
    | Class(v) => Printf.sprintf(".%s", v)
    | ClassVariable(v) => "." ++ render_variable_as_string(v)
    | Attribute(Attr_value(v)) => Printf.sprintf("[%s]", v)
    | Attribute(To_equal({name, kind, value})) => {
        let value =
          switch (value) {
          | Attr_ident(ident) => ident
          | Attr_string(ident) => {|"|} ++ ident ++ {|"|}
          };
        Printf.sprintf("[%s%s%s]", name, kind, value);
      }
    | Pseudo_class(psc) => render_pseudo_selector(psc)
  and render_nth =
    /* TODO: Add location in ast, pass it here */
    fun
    | Even => "even"
    | Odd => "odd"
    | A(a) => Int.to_string(a)
    | AN(an) when an == 1 => "n"
    | AN(an) when an == (-1) => "-n"
    | AN(an) => Int.to_string(an) ++ "n"
    | ANB(a, op, b) when a == 1 => "n" ++ op ++ Int.to_string(b)
    | ANB(a, op, b) when a == (-1) => "-n" ++ op ++ Int.to_string(b)
    | ANB(a, op, b) => Int.to_string(a) ++ "n" ++ op ++ Int.to_string(b)
  and render_nth_payload =
    fun
    | Nth(nth) => render_nth(nth)
    | NthSelector(v) =>
      v |> List.map(render_complex_selector) |> String.concat(", ")
  and render_pseudoclass =
    fun
    | PseudoIdent(i) => ":" ++ i
    | NthFunction({name, payload: (payload, _loc)}) =>
      ":"
      ++ name
      ++ "("
      ++ (render_nth_payload(payload) |> String.trim)
      ++ ")"
    | Function({name, payload: (payload, _loc)}) => {
        ":" ++ name ++ "(" ++ (render_selector(payload) |> String.trim) ++ ")";
      }
  and render_pseudo_selector =
    fun
    | Pseudoelement(v) => "::" ++ v
    | Pseudoclass(pc) => render_pseudoclass(pc)
  and render_compound_selector = compound_selector => {
    let simple_selector =
      Option.fold(
        ~none="",
        ~some=render_simple_selector,
        compound_selector.type_selector,
      );
    let subclass_selectors =
      List.map(render_subclass_selector, compound_selector.subclass_selectors)
      |> String.concat("");
    let pseudo_selectors =
      List.map(render_pseudo_selector, compound_selector.pseudo_selectors)
      |> String.concat("");
    simple_selector ++ subclass_selectors ++ pseudo_selectors;
  }
  and render_complex_selector = complex => {
    switch (complex) {
    | Combinator({left, right}) =>
      let left = render_selector(left);
      let right = render_right_combinator(right);
      left ++ right;
    | Selector(selector) => render_selector(selector)
    };
  }
  and render_right_combinator = right => {
    right
    |> List.map(((combinator, selector)) => {
         Option.fold(~none=" ", ~some=o => " " ++ o ++ " ", combinator)
         ++ render_selector(selector)
       })
    |> String.concat("");
  };

  switch (selector) {
  | SimpleSelector(simple) => simple |> render_simple_selector
  | ComplexSelector(complex) => complex |> render_complex_selector
  | CompoundSelector(compound) => compound |> render_compound_selector
  };
}
and render_selectors = selectors => {
  selectors
  |> List.map(((selector, _loc)) => render_selector(selector))
  |> String.concat(", ");
}
and render_style_rule = (ident, rule: style_rule): Parsetree.expression => {
  let (prelude, _loc) = rule.prelude;
  let (_block, loc) = rule.block;
  let selector_expr =
    render_declarations(rule.block) |> Builder.pexp_array(~loc);
  let (delimiter, attrs) = Platform_attributes.string_delimiter(~loc);

  let selector_name =
    prelude
    |> render_selectors
    |> String.trim
    |> String_interpolation.transform(~attrs, ~delimiter, ~loc);

  Helper.Exp.apply(
    ~loc=rule.loc,
    /* ~attrs=[Platform_attributes.uncurried(~loc=rule.loc)], */
    ident,
    [(Nolabel, selector_name), (Nolabel, selector_expr)],
  );
};

let bsEmotionLabel = (~loc, label) => {
  Helper.Exp.apply(
    CssJs.label(~loc),
    [(Nolabel, Helper.Exp.constant(Pconst_string(label, loc, None)))],
  );
};

let addLabel = (~loc, label, emotionExprs) => [
  bsEmotionLabel(~loc, label),
  ...emotionExprs,
];

let render_style_call = (declaration_list): Parsetree.expression => {
  let loc = declaration_list.pexp_loc;
  let arguments = [(Nolabel, declaration_list)];

  Helper.Exp.apply(
    ~loc,
    /* ~attrs=[Platform_attributes.uncurried(~loc)], */
    CssJs.style(~loc),
    arguments,
  );
};

let render_keyframes = (declarations: rule_list): Parsetree.expression => {
  let (declarations, loc) = declarations;
  let invalid_selector = {|
    keyframe selector can be from | to | <percentage>

    Like following:
        [%keyframe "
          from { opacity: 1; }
          to { opacity: 0; }
        "];
  |};

  let invalid_percentage_value = value =>
    Printf.sprintf(
      "'%s' isn't valid. Only accept percentage with integers",
      value,
    );
  let invalid_prelude_value = value =>
    Printf.sprintf("'%s' isn't a valid keyframe value", value);
  let invalid_prelude_value_opaque = "This isn't a valid keyframe value";

  let render_select_as_keyframe = prelude => {
    switch (prelude |> fst) {
    | SimpleSelector(selector) =>
      switch (selector) {
      // https://drafts.csswg.org/css-animations/#keyframes
      // `from` is equivalent to the value 0%
      | Type(v) when v == "from" => Builder.eint(~loc, 0)
      // `to` is equivalent to the value 100%
      | Type(v) when v == "to" => Builder.eint(~loc, 100)
      | Type(t) => Generate_lib.error(~loc, invalid_prelude_value(t))
      | Percentage(n) =>
        switch (int_of_string_opt(n)) {
        | Some(n) when n >= 0 && n <= 100 => Builder.eint(~loc, n)
        | _ => Generate_lib.error(~loc, invalid_percentage_value(n))
        }
      | Ampersand => Generate_lib.error(~loc, invalid_prelude_value("&"))
      | Universal => Generate_lib.error(~loc, invalid_prelude_value("*"))
      | Subclass(_) => Generate_lib.error(~loc, invalid_prelude_value_opaque)
      | Variable(_) => Generate_lib.error(~loc, invalid_prelude_value_opaque)
      }
    | _ => Generate_lib.error(~loc, invalid_selector)
    };
  };

  let keyframes =
    declarations
    |> List.map(declaration => {
         switch (declaration) {
         | Style_rule({prelude: (prelude, _), block, loc: style_loc}) =>
           let percentages = prelude |> List.map(render_select_as_keyframe);
           let rules =
             render_declarations(block) |> Builder.pexp_array(~loc);
           percentages
           |> List.map(p => Builder.pexp_tuple(~loc=style_loc, [p, rules]));
         | _ => [Generate_lib.error(~loc, invalid_selector)]
         }
       })
    |> List.flatten
    |> Builder.pexp_array(~loc);

  {
    ...Builder.eapply(~loc, CssJs.keyframes(~loc), [keyframes]),
    pexp_attributes: [] /* Platform_attributes.uncurried(~loc) */,
  };
};

let render_global = ((ruleList, loc): stylesheet) => {
  switch (ruleList) {
  /* There's only one style_rule */
  | [Style_rule(rule)] =>
    render_style_rule(CssJs.global(~loc), rule)
    |> Generate_lib.applyIgnore(~loc)
  /* More than one isn't supported by bs-css */
  | _res =>
    Generate_lib.error(
      ~loc,
      {|
        `styled.global` only supports one style definition. Transform each definition into a separate styled.global call

        Like following:
          %styled.global(" ... ")
          %styled.global(" ... ")
      |},
    )
  /* TODO: Add rule to string to finish this error message */
  };
};
