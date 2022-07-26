open Ppxlib;
open Css_types;

module Helper = Ast_helper;
module Builder = Ast_builder.Default;

module CssJs = {
  let lident = (~loc, name) => {txt: Ldot(Lident("CssJs"), name), loc};
  let selector = (~loc) => lident(~loc, "selector");
  let media = (~loc) => lident(~loc, "media");
};

let grammar_error = (loc, message) =>
  raise(Css_lexer.GrammarError((message, loc)));

let number_to_const = number =>
  if (String.contains(number, '.')) {
    Helper.Const.float(number);
  } else {
    Helper.Const.integer(number);
  };

let string_to_const = (~loc, s) =>
  Helper.Exp.constant(
    ~loc,
    Helper.Const.string(~quotation_delimiter="js", s),
  );
let render_variable = (~loc, v) => {
  let txt = v |> String.concat(".") |> Longident.parse;
  Helper.Exp.ident({loc, txt});
};
let source_code_of_loc = loc => {
  let Location.{loc_start, loc_end, _} = loc;
  let Lex_buffer.{buf, pos, _} = Lex_buffer.last_buffer^;
  let pos_offset = pos.Lexing.pos_cnum;
  let loc_start = loc_start.Lexing.pos_cnum - pos_offset;
  let loc_end = loc_end.Lexing.pos_cnum - pos_offset;
  Sedlexing.Latin1.sub_lexeme(buf, loc_start - 1, loc_end - loc_start);
};

let concat = (~loc, expr, acc) => {
  let concat_fn = {txt: Lident("^"), loc} |> Helper.Exp.ident(~loc);
  Helper.Exp.apply(~loc, concat_fn, [(Nolabel, expr), (Nolabel, acc)]);
};

let rec render_at_rule = (ar: At_rule.t): Parsetree.expression =>
  switch (ar.At_rule.name) {
  | ("media", _) => render_media_query(ar)
  | ("keyframe", _) => grammar_error(ar.loc, "@keyframe should be defined outside")
  | (
      "charset" as n |
      "import" as n |
      "namespace" as n |
      "supports" as n |
      "page" as n |
      "font-face" as n |
      "keyframes" as n |
      "counter-style" as n |
      "font-feature-values" as n |
      "swash" as n |
      "ornaments" as n |
      "annotation" as n |
      "stylistic" as n |
      "styleset" as n |
      "character-variant" as n |
      "property" as n | /* Experimental */
      "color-profile" as n | /* Experimental */
      "viewport" as n | /* Deprecated */
      "document" as n, /* Deprecated */
      _,
    ) =>
    grammar_error(
      ar.At_rule.loc,
      "At-rule @" ++ n ++ " is not supported in styled-ppx",
    )
  | (n, _) => grammar_error(ar.At_rule.loc, "Unknown @" ++ n ++ "")
  }
and render_media_query = (ar: At_rule.t): Parsetree.expression => {
  let loc = ar.loc;
  let (_, name_loc) = ar.name;
  let (prelude, prelude_loc) = ar.prelude;
  open Component_value;

  let parse_condition = (component_value: with_loc(Component_value.t)) => {
    let (value, loc) = component_value;
    switch (value) {
      | Variable(variable) => render_variable_as_string(variable)
      /* (color) */
      | Paren_block([(Ident(_), ident_loc)]) => source_code_of_loc(ident_loc)
      /* (min-width: 30px) */
      | Paren_block([
          (Ident(property), _),
          (Delim(":"), _),
          (_value, value_loc),
        ]) => {
          /* We need the value as a string to pipe it to the Property parser */
          let value = source_code_of_loc(value_loc);
          switch (Declarations_to_string.parse_declarations(property, value)) {
          | Error(`Not_found) =>
            grammar_error(loc, "unsupported property: " ++ property)
          | Error(`Invalid_value(_error)) =>
            grammar_error(loc, "invalid value")
          | Ok(_exprs) => {
            /* Here we receive the expressions transformed, but we prefer the stringed value */
              value
            }
          };
        }
        | Paren_block([(Ident(property), _), (Delim(":"), _), ..._value]) =>
          grammar_error(loc, "There's more than one value assiged to a property: " ++ property)
        /* In any other case, we believe on the source_code and transform it to string. This is unsafe */
        | _whatever => source_code_of_loc(loc)
    }};

  let parse_conditions = (prelude) => {
    switch (prelude) {
      | (Component_value.Paren_block((blocks)), _) =>
        let conditions = List.map(parse_condition, blocks) |> String.concat("");
        "(" ++ conditions ++ ")";
      | (Ident(i), _) => i
      | _ =>
        /* This branch is whildcared (_) by design of the parser. It won't allow
        any other Component_value */
        grammar_error(prelude_loc, "Invalid media query")
    };
  };

  if (prelude == []) {
    grammar_error(prelude_loc, "@media prelude can't be empty")
  };

  let query = prelude |> List.map(parse_conditions) |> String.concat(" ") |> String_interpolation.Transform.transform(~loc);

  let rules =
    switch (ar.block) {
    | Empty => Builder.pexp_array(~loc, [])
    | Declaration_list(declaration) =>
      render_declarations(declaration) |> Builder.pexp_array(~loc)
    | Stylesheet(_) =>
      grammar_error(ar.loc, "@media content expect to have declarations, not an stylesheets. Selectors aren't allowed in @media.")
    };

  Helper.Exp.apply(
    ~loc,
    ~attrs=[Create.uncurried(~loc)],
    Builder.pexp_ident(~loc=name_loc, CssJs.media(~loc)),
    [(Nolabel, query), (Nolabel, rules)],
  );
}
and render_declaration = (d: Declaration.t): list(Parsetree.expression) => {
  let (property, name_loc) = d.name;
  let (_valueList, loc) = d.value;
  let value_source = source_code_of_loc(loc);

  switch (Declarations_to_emotion.parse_declarations(property, value_source)) {
  | Ok(exprs) => exprs
  | Error(`Not_found) => grammar_error(name_loc, "Unknown property " ++ property)
  | Error(`Invalid_value(value)) =>
    grammar_error(
      loc,
      "Invalid value: '" ++ value ++ "' in property '" ++ property ++ "'",
    )
  };
}
and render_declarations = ((ds, _loc: Location.t)) => {
  ds |> List.concat_map(
    declaration =>
      switch (declaration) {
      | Declaration_list.Declaration(decl) => render_declaration(decl)
      | Declaration_list.At_rule(ar) => [render_at_rule(ar)]
      | Declaration_list.Style_rule(style_rules) =>
        let loc = style_rules.loc;
        let selector = Helper.Exp.ident(~loc, CssJs.selector(~loc));
        [render_style_rule(selector, style_rules)];
      }
  );
}
and render_variable_as_string = variable => {
  "$(" ++ String.concat(".", variable) ++ ")";
}
and render_selector = (selector: Selector.t) => {
  open Selector;
  let rec render_simple_selector =
    fun
    | Ampersand => "&"
    | Universal => "*"
    | Type(v) => v
    | Subclass(v) => render_subclass_selector(v)
    | Variable(v) => render_variable_as_string(v)
  and render_subclass_selector =
    fun
    | Id(v) => "#" ++ v
    | Class(v) => "." ++ v
    | Attribute(Attr_value(v)) => "[" ++ v ++ "]"
    | Attribute(To_equal({name, kind, value})) =>  {
      let value = switch (value) {
        | Attr_ident(ident) => ident
        | Attr_string(ident) => "\"" ++ ident ++ "\""
      };
      "[" ++ name ++ kind ++ value ++ "]"
    }
    | Pseudo_class(psc) => render_pseudo_selector(psc)
  and render_pseudo_selector =
    fun
    | Pseudoelement(v) => "::" ++ v
    | Pseudoclass(Ident(i)) => ":" ++ i
    | Pseudoclass(Function({name, payload: (payload, _loc)})) => {
        ":"
        ++ name
        ++ "("
        ++ (render_selector(payload) |> String.trim)
        ++ ")";
      };

  let rec render_compound_selector = compound_selector => {
    let simple_selector =
      Option.fold(
        ~none="",
        ~some=render_simple_selector,
        compound_selector.type_selector,
      );
    let subclass_selectors =
      List.map(
        render_subclass_selector,
        compound_selector.subclass_selectors,
      ) |> String.concat("");
    let pseudo_selectors =
      List.map(
        render_pseudo_selector,
        compound_selector.pseudo_selectors,
      ) |> String.concat("");
    simple_selector ++ subclass_selectors ++ pseudo_selectors;
  }
  and render_complex_selector = complex => {
    switch (complex) {
    | Combinator({left, right}) =>
      let left = render_compound_selector(left);
      let right = render_right_combinator(right);
      left ++ right;
    | Selector(compound) => render_compound_selector(compound)
    };
  }
  and render_right_combinator = right => {
    right
    |> List.map(((combinator, compound_selector)) => {
      Option.fold(
        ~none=" ",
        ~some=o => " " ++ o ++ " ",
        combinator,
      )
      ++ render_compound_selector(compound_selector)
    }) |> String.concat("")
  };

  switch (selector) {
    | SimpleSelector(simple) =>
      simple |> List.map(render_simple_selector) |> String.concat(", ")
    | ComplexSelector(complex) =>
      complex |> List.map(render_complex_selector) |> String.concat(", ")
    | CompoundSelector(compound) =>
      compound |> List.map(render_compound_selector) |> String.concat(", ")
  };
}
and render_style_rule = (ident, rule: Style_rule.t): Parsetree.expression => {
  let (prelude, _loc) = rule.prelude;
  let (_block, loc) = rule.block;
  let selector_expr = render_declarations(rule.block) |> Builder.pexp_array(~loc);
  let selector_name = render_selector(prelude) |> String.trim |> String_interpolation.Transform.transform(~loc);

  Helper.Exp.apply(
    ~loc=rule.Style_rule.loc,
    ~attrs=[Create.uncurried(~loc=rule.Style_rule.loc)],
    ident,
    [(Nolabel, selector_name), (Nolabel, selector_expr)],
  );
};

let bsEmotionLabel = (~loc, label) => {
  Helper.Exp.apply(
    Helper.Exp.ident(CssJs.lident(~loc, "label")),
    [(Nolabel, Helper.Exp.constant(Pconst_string(label, loc, None)))],
  );
};

let addLabel = (~loc, label, emotionExprs) => [
  bsEmotionLabel(~loc, label),
  ...emotionExprs,
];

let render_style_call = (declaration_list): Parsetree.expression => {
  let loc = declaration_list.pexp_loc;
  let ident = Helper.Exp.ident(~loc, CssJs.lident(~loc, "style"));
  let arguments = [(Nolabel, declaration_list)];

  Helper.Exp.apply(~loc, ~attrs=[Create.uncurried(~loc)], ident, arguments);
};

let render_rule = (ident, rule: Rule.t): Parsetree.expression => {
  switch (rule) {
  | Rule.Style_rule(styleRule) => render_style_rule(ident, styleRule)
  | Rule.At_rule(atRule) => render_at_rule(atRule)
  };
};

let render_keyframes = ((ruleList, loc)): Parsetree.expression => {
  let invalidSelectorErrorMessage = {|
    keyframe selector can be from | to | <percentage>

    Like following:
        [%keyframe "
          0% { opacity: 1; }
          to { opacity: 0; }
        "];
  |};

  let render_select_as_keyframe = (_prelude: Selector.t) => 0;
  /* switch (prelude) {
     | ([(Percentage(n), loc)], _) =>
       // TODO: can percentage be a decimal value?
       switch (int_of_string_opt(n)) {
       | Some(n) when n >= 0 && n <= 100 => n
       | _ => grammar_error(loc, invalidSelectorErrorMessage)
       }
     // https://drafts.csswg.org/css-animations/#keyframes
     // The keyword from is equivalent to the value 0%
     | ([(Ident("from"), _)], _) => 0
     // The keyword to is equivalent to the value 100%
     | ([(Ident("to"), _)], _) => 100
     | _ => grammar_error(loc, invalidSelectorErrorMessage);
     }; */

  let keyframes =
    ruleList
    |> List.map(rule => {
         switch (rule) {
         | Rule.Style_rule({
             prelude: (selector, prelude_loc),
             block,
             loc: style_loc,
           }) =>
           let percentage =
             render_select_as_keyframe(selector)
             |> Builder.eint(~loc=prelude_loc);
           let rules =
             render_declarations(block) |> Builder.pexp_array(~loc);
           Builder.pexp_tuple(~loc=style_loc, [percentage, rules]);
         | Rule.At_rule(_) => grammar_error(loc, invalidSelectorErrorMessage)
         }
       })
    |> Builder.pexp_array(~loc);
  let emotionKeyframes =
    Builder.pexp_ident(~loc, CssJs.lident(~loc, "keyframes"));

  {
    ...Builder.eapply(~loc, emotionKeyframes, [keyframes]),
    pexp_attributes: [Create.uncurried(~loc)],
  };
};

let render_global = ((ruleList, loc): Stylesheet.t) => {
  let emotionGlobal = Helper.Exp.ident(~loc, CssJs.lident(~loc, "global"));

  switch (ruleList) {
  /* There's only one rule: */
  | [rule] => render_rule(emotionGlobal, rule) |> Create.applyIgnore(~loc)
  /* There's more than one */
  | _res =>
    grammar_error(
      loc,
      {|
        `styled.global` only supports one style definition. Transform each definition into a separate styled.global call

        Like following:
          [%styled.global " ... "];
          [%styled.global " ... "];
      |},
    )
  /* TODO: Add rule to string to finish this error message */
  };
};
