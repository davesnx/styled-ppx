open Styled_ppx_css_parser.Ast;

module Parser = Css_grammar.Parser;
module Helper = Ppxlib.Ast_helper;
module Builder = Ppxlib.Ast_builder.Default;

exception Empty_buffer(string);

module CSS = {
  /* This is the public API of the CSS module */
  let ident = (~loc, name) =>
    Builder.pexp_ident(
      ~loc,
      {
        txt: Ldot(Lident("CSS"), name),
        loc,
      },
    );
  let selectorMany = (~loc) => ident(~loc, "selectorMany");
  let media = (~loc) => ident(~loc, "media");
  let global = (~loc) => ident(~loc, "global");
  let label = (~loc) => ident(~loc, "label");
  let style = (~loc) => ident(~loc, "style");
  let keyframes = (~loc) => ident(~loc, "keyframes");
  let make = (~loc) => ident(~loc, "make");
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
  let txt = v |> String.concat(".") |> Ppxlib.Longident.parse;
  Builder.pexp_ident(
    ~loc,
    {
      txt,
      loc,
    },
  );
};

let concat = (~loc, expr, acc) => {
  let concat_fn =
    {
      txt: Lident("^"),
      loc,
    }
    |> Helper.Exp.ident(~loc);
  Helper.Exp.apply(~loc, concat_fn, [(Nolabel, expr), (Nolabel, acc)]);
};

let rec render_at_rule = (~loc, at_rule: at_rule) => {
  let (at_rule_name, at_rule_name_loc) = at_rule.name;
  /* TODO: Make sure this location correct */
  let at_rule_name_loc =
    Styled_ppx_css_parser.Parser_location.intersection(
      loc,
      {
        ...at_rule_name_loc,
        loc_start: {
          ...at_rule_name_loc.loc_start,
          pos_bol: at_rule_name_loc.loc_end.pos_bol,
          pos_cnum:
            at_rule_name_loc.loc_end.pos_cnum - String.length(at_rule_name),
          pos_lnum: at_rule_name_loc.loc_end.pos_lnum,
        },
      },
    );
  switch (at_rule_name) {
  | "media" => render_media_query(~loc, at_rule)
  | "container" => render_container_query(~loc, at_rule)
  | "keyframes" =>
    Error.expr(
      ~loc=at_rule_name_loc,
      "@keyframes should be defined with %%keyframe(...)",
    )
  | "charset" as n
  | "import" as n
  | "namespace" as n
  | "supports" as n
  | "page" as n
  | "font-face" as n
  | "counter-style" as n
  | "font-feature-values" as n
  | "swash" as n
  | "ornaments" as n
  | "annotation" as n
  | "stylistic" as n
  | "styleset" as n
  | "character-variant" as n
  | "property" as n
  | "font-palette-values" as n
  | "layer" as n
  | "scope" as n
  | "starting-style" as n
  | /* Experimental */ "color-profile" as n
  | /* Experimental */ "viewport" as n
  | /* Deprecated */ "document" as n =>
    Error.expr(
      ~loc=at_rule_name_loc,
      Printf.sprintf("At-rule @%s is not supported in styled-ppx", n),
    )
  | n => Error.expr(~loc=at_rule_name_loc, Printf.sprintf("Unknown @%s ", n))
  };
}
and render_media_query = (~loc, at_rule: at_rule) => {
  let (at_rule_prelude_ast, at_rule_prelude_loc) = at_rule.prelude;
  let parse_condition = {
    /* TODO: Trimming is a mistake from the lexer/parser, it should be fixed */
    let prelude =
      Styled_ppx_css_parser.Render.component_value_list(at_rule_prelude_ast)
      |> String.trim;
    Parser.parse(Parser.media_query_list, prelude) |> Result.map(_ => prelude);
  };

  let (delimiter, attrs) =
    Platform_attributes.string_delimiter(~loc=at_rule.loc);

  switch (parse_condition) {
  | Error(error_msg) =>
    Error.expr(
      ~loc=
        Styled_ppx_css_parser.Parser_location.intersection(
          loc,
          at_rule_prelude_loc,
        ),
      error_msg,
    )
  | Ok(conditions) =>
    let query =
      conditions
      |> String_interpolation.transform(~attrs, ~delimiter, ~loc=at_rule.loc);

    let rules =
      switch (at_rule.block) {
      | Empty => Builder.pexp_array(~loc=at_rule.loc, [])
      | Rule_list(declaration) =>
        render_declarations(~loc, declaration)
        |> Builder.pexp_array(~loc=at_rule.loc)
      };

    Helper.Exp.apply(
      ~loc=at_rule.loc,
      CSS.media(~loc=at_rule.loc),
      [(Nolabel, query), (Nolabel, rules)],
    );
  };
}
and render_container_query = (~loc, at_rule: at_rule) => {
  let (at_rule_prelude_ast, at_rule_prelude_loc) = at_rule.prelude;
  let parse_condition = {
    /* TODO: Trimming is a mistake from the lexer/parser */
    let prelude =
      Styled_ppx_css_parser.Render.component_value_list(at_rule_prelude_ast)
      |> String.trim;
    Parser.parse(Parser.container_condition, prelude) |> Result.map(_ => prelude);
  };

  let (delimiter, attrs) =
    Platform_attributes.string_delimiter(~loc=at_rule.loc);

  switch (parse_condition) {
  | Error(error_msg) =>
    Error.expr(
      ~loc=
        Styled_ppx_css_parser.Parser_location.intersection(
          loc,
          at_rule_prelude_loc,
        ),
      error_msg,
    )
  | Ok(conditions) =>
    let query =
      [
        String_interpolation.transform(
          ~attrs,
          ~delimiter,
          ~loc=at_rule.loc,
          "@container " ++ conditions,
        ),
      ]
      |> Builder.pexp_array(~loc=at_rule.loc);

    let rules =
      switch (at_rule.block) {
      | Empty => Builder.pexp_array(~loc=at_rule.loc, [])
      | Rule_list(declaration) =>
        render_declarations(~loc, declaration)
        |> Builder.pexp_array(~loc=at_rule.loc)
      };

    Helper.Exp.apply(
      ~loc=at_rule.loc,
      CSS.selectorMany(~loc=at_rule.loc),
      [(Nolabel, query), (Nolabel, rules)],
    );
  };
}
and render_declaration = (~loc: Ppxlib.location, d: declaration) => {
  let (property, property_loc) = d.name;
  let (valueList, value_loc) = d.value;
  let (important, _) = d.important;
  /* TODO: Trimming is a mistake from the lexer/parser */
  let value_source =
    Styled_ppx_css_parser.Render.component_value_list(valueList)
    |> String.trim;

  let value_loc =
    Styled_ppx_css_parser.Parser_location.intersection(loc, value_loc);
  let property_loc =
    Styled_ppx_css_parser.Parser_location.intersection(loc, property_loc);
  let declaration_loc =
    Styled_ppx_css_parser.Parser_location.intersection(loc, property_loc);

  switch (
    Property_to_runtime.render(
      ~loc=declaration_loc,
      property,
      value_source,
      important,
    )
  ) {
  | Ok(exprs) => exprs
  | Error(`Property_not_found) => [
      Error.expr(~loc=property_loc, "Unknown property '" ++ property ++ "'"),
    ]
  | Error(`Impossible_state) => [
      Error.expr(
        ~loc=declaration_loc,
        "This is a broken state of the CSS parser and probably a bug. Please report back!",
      ),
    ]
  | Error(`Invalid_value(_reason)) => [
      Error.expr(
        ~loc=value_loc,
        Format.sprintf(
          "@[Property@ '%s'@ has@ an@ invalid@ value:@ '%s'@]",
          property,
          value_source,
        ),
      ),
    ]
  };
}
and render_declarations = (~loc: Ppxlib.location, (ds, _d_loc)) => {
  ds
  |> List.concat_map(declaration =>
       switch (declaration) {
       | Declaration(decl) => render_declaration(~loc, decl)
       | At_rule(ar) => [render_at_rule(~loc, ar)]
       | Style_rule(style_rules) => [render_style_rule(~loc, style_rules)]
       }
     );
}
and render_variable_as_string = variable => {
  "$(" ++ String.concat(".", variable) ++ ")";
}
and render_selector = (~loc, selector: selector) => {
  let rec render_simple_selector =
    fun
    | Ampersand => "&"
    | Universal => "*"
    | Type(v) => v
    | Subclass(v) => render_subclass_selector(v)
    | Variable(v) => render_variable_as_string(v)
    | Percentage(v) => Printf.sprintf("%s%%", v)
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
    | PseudoFunction({name, payload: (payload, _loc)}) => {
        ":"
        ++ name
        ++ "("
        ++ (
          render_selectors(~loc, payload)
          |> String.concat(", ")
          |> String.trim
        )
        ++ ")";
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
      let left = render_selector(~loc, left);
      let right = render_right_combinator(right);
      left ++ right;
    | Selector(selector) => render_selector(~loc, selector)
    };
  }
  and render_right_combinator = right => {
    right
    |> List.map(((combinator, selector)) => {
         Option.fold(~none=" ", ~some=o => " " ++ o ++ " ", combinator)
         ++ render_selector(~loc, selector)
       })
    |> String.concat("");
  }
  and render_relative_selector = ({combinator, complex_selector}) => {
    Option.fold(~none="", ~some=o => o ++ " ", combinator)
    ++ render_complex_selector(complex_selector);
  };

  switch (selector) {
  | SimpleSelector(simple) => simple |> render_simple_selector
  | ComplexSelector(complex) => complex |> render_complex_selector
  | CompoundSelector(compound) => compound |> render_compound_selector
  | RelativeSelector(relative) => relative |> render_relative_selector
  };
}
and render_selectors = (~loc, selectors) => {
  selectors
  |> List.map(((selector, _loc)) => render_selector(~loc, selector));
}
and render_style_rule = (~loc, rule: style_rule) => {
  let (prelude, prelude_loc) = rule.prelude;
  let selector_location =
    Styled_ppx_css_parser.Parser_location.intersection(loc, prelude_loc);

  let selector_expr =
    render_declarations(~loc, rule.block)
    |> Builder.pexp_array(~loc=selector_location);

  let (delimiter, attrs) =
    Platform_attributes.string_delimiter(~loc=selector_location);

  let selector_name =
    prelude
    |> render_selectors(~loc=selector_location)
    |> List.map(String.trim)
    |> List.map(
         String_interpolation.transform(
           ~attrs,
           ~delimiter,
           ~loc=selector_location,
         ),
       )
    |> Builder.pexp_array(~loc=selector_location);

  Helper.Exp.apply(
    ~loc=selector_location,
    CSS.selectorMany(~loc=selector_location),
    [(Nolabel, selector_name), (Nolabel, selector_expr)],
  );
};

let add_label = (~loc, label, emotionExprs) => [
  Helper.Exp.apply(
    ~loc,
    CSS.label(~loc),
    [
      (Nolabel, Helper.Exp.constant(~loc, Pconst_string(label, loc, None))),
    ],
  ),
  ...emotionExprs,
];

let render_style_call = (~loc, declaration_list) => {
  Helper.Exp.apply(~loc, CSS.style(~loc), [(Nolabel, declaration_list)]);
};

let render_keyframes = (~loc, declarations: rule_list) => {
  let (declarations, declarations_loc) = declarations;
  let invalid_selector = {|
    keyframe selector can be `from`, `to` or <percentage>`

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
      | Type(v) when v == "from" => Builder.eint(~loc=declarations_loc, 0)
      // `to` is equivalent to the value 100%
      | Type(v) when v == "to" => Builder.eint(~loc=declarations_loc, 100)
      | Type(t) =>
        Error.expr(~loc=declarations_loc, invalid_prelude_value(t))
      | Percentage(n) =>
        switch (int_of_string_opt(n)) {
        | Some(n) when n >= 0 && n <= 100 =>
          Builder.eint(~loc=declarations_loc, n)
        | _ => Error.expr(~loc=declarations_loc, invalid_percentage_value(n))
        }
      | Ampersand =>
        Error.expr(~loc=declarations_loc, invalid_prelude_value("&"))
      | Universal =>
        Error.expr(~loc=declarations_loc, invalid_prelude_value("*"))
      | Subclass(_) =>
        Error.expr(~loc=declarations_loc, invalid_prelude_value_opaque)
      | Variable(_) =>
        Error.expr(~loc=declarations_loc, invalid_prelude_value_opaque)
      }
    | _ => Error.expr(~loc=declarations_loc, invalid_selector)
    };
  };

  let keyframes =
    declarations
    |> List.map(declaration => {
         switch (declaration) {
         | Style_rule({prelude: (prelude, _), block, loc: style_loc}) =>
           let percentages = prelude |> List.map(render_select_as_keyframe);
           let rules =
             render_declarations(~loc, block)
             |> Builder.pexp_array(~loc=declarations_loc);
           percentages
           |> List.map(p => Builder.pexp_tuple(~loc=style_loc, [p, rules]));
         | _ => [Error.expr(~loc=declarations_loc, invalid_selector)]
         }
       })
    |> List.flatten
    |> Builder.pexp_array(~loc=declarations_loc);

  Builder.eapply(
    ~loc=declarations_loc,
    CSS.keyframes(~loc=declarations_loc),
    [keyframes],
  );
};

let render_global = (~loc, (rule_list, stylesheet_loc): rule_list) => {
  let onlyStyleRulesAndAtRulesSupported = {|Declarations does not make sense in global styles. Global should consists of style rules or at-rules (e.g @media, @print, etc.)

If your intent is to apply the declaration to all elements, use the universal selector
* {
  /* Your declarations here */
}|};

  let styles =
    rule_list
    |> List.map(rule => {
         switch (rule) {
         | Style_rule(style_rule) => render_style_rule(~loc, style_rule)
         | At_rule(at_rule) => render_at_rule(~loc, at_rule)
         | _ =>
           Error.expr(~loc=stylesheet_loc, onlyStyleRulesAndAtRulesSupported)
         }
       })
    |> Builder.pexp_array(~loc=stylesheet_loc);

  let expr =
    Helper.Exp.apply(
      ~loc=stylesheet_loc,
      CSS.global(~loc=stylesheet_loc),
      [(Nolabel, styles)],
    );
  [%expr ignore([%e expr])];
};

let render_make_call = (~loc, ~classNames, ~dynamic_vars) => {
  /* Join multiple classNames with spaces for atomic CSS */
  let className_string = String.concat(" ", classNames);
  let className_expr =
    Helper.Exp.constant(~loc, Pconst_string(className_string, loc, None));

  let var_list =
    dynamic_vars
    |> List.map(((var_name, original_path, type_path)) => {
         let field_name = "--" ++ var_name;
         let field_name_expr =
           Helper.Exp.constant(~loc, Pconst_string(field_name, loc, None));

         let var_value =
           render_variable(~loc, String.split_on_char('.', original_path));

         /* If type_path starts with "Css_types.", use it directly as the module path.
            Otherwise, fall back to property-based lookup. */
         let field_value =
           if (String.length(type_path) > 10
               && String.sub(type_path, 0, 10) == "Css_types.") {
             /* Extract module name from "Css_types.Color" -> "Color" */
             let module_name =
               String.sub(type_path, 10, String.length(type_path) - 10);
             Property_to_types.make_to_string_call(
               ~loc,
               module_name,
               var_value,
             );
           } else {
             /* Fall back to property-name-based lookup */
             Property_to_types.get_to_string_for_property(
               ~loc,
               type_path,
               var_value,
             );
           };

         Builder.pexp_tuple(~loc, [field_name_expr, field_value]);
       });

  let list_expr =
    List.fold_right(
      (item, acc) =>
        Builder.pexp_construct(
          ~loc,
          Builder.Located.lident(~loc, "::"),
          Some(Builder.pexp_tuple(~loc, [item, acc])),
        ),
      var_list,
      Builder.pexp_construct(~loc, Builder.Located.lident(~loc, "[]"), None),
    );

  [%expr CSS.make([%e className_expr], [%e list_expr])];
};
