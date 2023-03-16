open Ppxlib;
open Css_types;

module Helper = Ast_helper;
module Builder = Ast_builder.Default;
module Lexer = Css_lexer;

module CssJs = {
  let ident = (~loc, name) => {txt: Ldot(Lident("CssJs"), name), loc} |> Builder.pexp_ident(~loc);
  let selector = (~loc) => ident(~loc, "selector");
  let media = (~loc) => ident(~loc, "media");
  let global = (~loc) => ident(~loc, "global")
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

let string_to_const = (~loc, s) =>
  Helper.Exp.constant(
    ~loc,
    Helper.Const.string(~quotation_delimiter="js", s),
  );
let render_variable = (~loc, v) => {
  let txt = v |> String.concat(".") |> Longident.parse;
  Helper.Exp.ident({loc, txt});
};

let source_code_of_loc = (loc: Location.t) => {
  let Location.{loc_start, loc_end, _} = loc;
  let Lex_buffer.{buf, pos, _} = Lex_buffer.last_buffer^;
  let pos_offset = pos.pos_cnum;
  let loc_start = loc_start.pos_cnum - pos_offset;
  let loc_end = loc_end.pos_cnum - pos_offset;
  Sedlexing.Latin1.sub_lexeme(buf, loc_start, loc_end - loc_start);
};

let concat = (~loc, expr, acc) => {
  let concat_fn = {txt: Lident("^"), loc} |> Helper.Exp.ident(~loc);
  Helper.Exp.apply(~loc, concat_fn, [(Nolabel, expr), (Nolabel, acc)]);
};

let rec render_at_rule = (ar: at_rule): Parsetree.expression =>
  switch (ar.name) {
  | ("media", _) => render_media_query(ar)
  | ("keyframes", _) => Lexer.grammar_error(ar.loc, {|@keyframes should be defined with %keyframe(...)|})
  | (
      "charset" as n |
      "import" as n |
      "namespace" as n |
      "supports" as n |
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
      "property" as n | /* Experimental */
      "color-profile" as n | /* Experimental */
      "viewport" as n | /* Deprecated */
      "document" as n, /* Deprecated */
      _,
    ) =>
    Lexer.grammar_error(
      ar.loc,
      "At-rule @" ++ n ++ " is not supported in styled-ppx",
    )
  | (n, _) => Lexer.grammar_error(ar.loc, "Unknown @" ++ n ++ "")
  }
and render_media_query = (at_rule: at_rule): Parsetree.expression => {
  let (prelude, prelude_loc) = at_rule.prelude;
  let parse_condition = (component_value: (component_value, location)) => {
    let (value, loc) = component_value;
    let component_value_location = loc;
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
          let value = source_code_of_loc(value_loc) |> String.trim;
          /* String.trim is a hack, location should be correct and not contain any whitespace */
          switch (Declarations_to_string.parse_declarations(property, value)) {
          | Error(`Not_found) =>
            Lexer.grammar_error(component_value_location, "unsupported property: " ++ property)
          | Error(`Invalid_value(_error)) =>
            Lexer.grammar_error(component_value_location, "invalid value")
          | Ok(_exprs) => {
            /* Here we receive the expressions transformed, but we prefer the stringed value */
              value
            }
          };
        }
        | Paren_block([(Ident(property), _), (Delim(":"), _), ..._value]) =>
          Lexer.grammar_error(component_value_location, "There's more than one value assiged to a property: " ++ property)
        /* In any other case, we believe on the source_code and transform it to string. This is unsafe */
        | _whatever => source_code_of_loc(component_value_location)
    }};

  let parse_conditions = (prelude) => {
    switch (prelude) {
      | (Paren_block((blocks)), _) =>
        let conditions = List.map(parse_condition, blocks) |> String.concat("");
        "(" ++ conditions ++ ")";
      | (Ident(i), _) => i
      | (Variable(v), _) => render_variable_as_string(v)
      | _ =>
        /* This branch is whildcared (_) by design of the parser. It won't allow any other component_value */
        Lexer.grammar_error(prelude_loc, "Invalid media query")
    };
  };

  if (prelude == []) {
    Lexer.grammar_error(prelude_loc, "@media prelude can't be empty")
  };

  let query = prelude |> List.map(parse_conditions) |> String.concat(" ") |> String_interpolation.Transform.transform(~loc=at_rule.loc);

  let rules =
    switch (at_rule.block) {
    | Empty => Builder.pexp_array(~loc=at_rule.loc, [])
    | Rule_list(declaration) =>
      render_declarations(declaration) |> Builder.pexp_array(~loc=at_rule.loc)
    | Stylesheet(_) =>
      Lexer.grammar_error(at_rule.loc, "@media content expect to have declarations, not an stylesheets. Selectors aren't allowed in @media.")
    };

  Helper.Exp.apply(
    ~loc=at_rule.loc,
    ~attrs=[Create.uncurried(~loc=at_rule.loc)],
    CssJs.media(~loc=at_rule.loc),
    [(Nolabel, query), (Nolabel, rules)],
  );
}
and render_declaration = (d: declaration): list(Parsetree.expression) => {
  let (property, name_loc) = d.name;
  let (_valueList, loc) = d.value;
  /* String.trim is a hack, location should be correct and not contain any whitespace */
  let value_source = source_code_of_loc(loc) |> String.trim;

  switch (Declarations_to_emotion.parse_declarations(~loc=name_loc, property, value_source)) {
  | Ok(exprs) => exprs
  | Error(`Not_found) => Lexer.grammar_error(name_loc, "Unknown property '" ++ property ++ "'")
  | Error(`Invalid_value(value)) =>
    Lexer.grammar_error(
      loc,
      "Property '" ++ property ++ "' has an invalid value: '" ++ String.trim(value) ++ "'",
    )
  };
}
and render_declarations = ((ds, _loc: location)) => {
  ds |> List.concat_map(
    declaration =>
      switch (declaration) {
      | Declaration(decl) => render_declaration(decl)
      | At_rule(ar) => [render_at_rule(ar)]
      | Style_rule(style_rules) =>
        [
          render_style_rule(
            CssJs.selector(~loc=style_rules.loc), style_rules
          )
        ];
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
    | Percentage(_v) =>
      /* TODO: Add locations to selector */
      Lexer.grammar_error(Location.none, "Percentage is not a valid selector")
  and render_subclass_selector =
    fun
    | Id(v) => "#" ++ v
    | Class(v) => "." ++ v
    | ClassVariable(v) => "." ++ render_variable_as_string(v)
    | Attribute(Attr_value(v)) => "[" ++ v ++ "]"
    | Attribute(To_equal({name, kind, value})) =>  {
      let value = switch (value) {
        | Attr_ident(ident) => ident
        | Attr_string(ident) => "\"" ++ ident ++ "\""
      };
      "[" ++ name ++ kind ++ value ++ "]"
    }
    | Pseudo_class(psc) => render_pseudo_selector(psc)
  and render_nth =
    fun
      | NthIdent(i) when i == "even" => i
      | NthIdent(i) when i == "odd" => i
      | NthIdent(i) when i == "n" => i
      /* TODO: Add location in ast, pass it here */
      | NthIdent(ident) => Lexer.grammar_error(Location.none, "'" ++ ident ++ "' is invalid")
      | A(a) => a
      | AN(an) => an ++ "n"
      | ANB(a, op, b) => a ++ "n" ++ op ++ b
  and render_nth_payload =
    fun
    | Nth(nth) => render_nth(nth)
    | NthSelector(v) => "NthSelector(ComplexSelector(["
    ++ (v |> List.map(render_complex_selector) |> String.concat(", "))
    ++ "]))"
  and render_pseudoclass =
    fun
    | Ident(i) => ":" ++ i
    | NthFunction({name, payload: (payload, _loc)}) =>
      ":"
        ++ name
        ++ "("
        ++ (render_nth_payload(payload) |> String.trim)
        ++ ")"
    | Function({name, payload: (payload, _loc)}) => {
        ":"
        ++ name
        ++ "("
        ++ (render_selector(payload) |> String.trim)
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
      List.map(
        render_subclass_selector,
        compound_selector.subclass_selectors,
      ) |> String.concat("");
    /* let _pseudo_selectors =
      List.map(
        render_pseudo_selector,
        compound_selector.pseudo_selectors,
      ) |> String.concat(""); */
    simple_selector ++ subclass_selectors /* ++ pseudo_selectors */;
  }
  and render_complex_selector = complex => {
    switch (complex) {
    | Combinator({left, right}) =>
      /* let left = render_compound_selector(left); */
      let left = render_selector(left);
      let right = render_right_combinator(right);
      left ++ right;
    | Selector(compound) => render_compound_selector(compound)
    };
  }
  and render_right_combinator = right => {
    right
    |> List.map(((combinator, selector)) => {
      Option.fold(
        ~none=" ",
        ~some=o => " " ++ o ++ " ",
        combinator,
      )
      ++ render_selector(selector)
    }) |> String.concat("")
  };

  switch (selector) {
    | SimpleSelector(simple) => simple |> render_simple_selector
    | ComplexSelector(complex) => complex |> render_complex_selector
    | CompoundSelector(compound) => compound |> render_compound_selector
  };
}
and render_style_rule = (ident, rule: style_rule): Parsetree.expression => {
  let (_prelude, _loc) = rule.prelude;
  let (_block, loc) = rule.block;
  let selector_expr = render_declarations(rule.block) |> Builder.pexp_array(~loc);
  let selector_name = "wat" |> String.trim |> String_interpolation.Transform.transform(~loc);
  /* let selector_name = render_selector(prelude |> List.hd) |> String.trim |> String_interpolation.Transform.transform(~loc); */

  Helper.Exp.apply(
    ~loc=rule.loc,
    ~attrs=[Create.uncurried(~loc=rule.loc)],
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

  Helper.Exp.apply(~loc, ~attrs=[Create.uncurried(~loc)], CssJs.style(~loc), arguments);
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

  let invalid_percentage_value = (value) => "'" ++ value ++ "' isn't valid. Only accept percentage with integers";
  let invalid_prelude_value = (value) => "'" ++ value ++ "' isn't a valid keyframe value";
  let invalid_prelude_value_opaque = "This isn't a valid keyframe value";

  let _render_select_as_keyframe = (prelude: selector): int => {
    switch (prelude) {
     | SimpleSelector(selector) => {
       switch (selector) {
        // https://drafts.csswg.org/css-animations/#keyframes
        // from is equivalent to the value 0%
        | Type(v) when v == "from" => 0
        // to is equivalent to the value 100%
        | Type(v) when v == "to" => 100
        | Type(t) => Lexer.grammar_error(loc, invalid_prelude_value(t))
        | Percentage(n) => switch (int_of_string_opt(n)) {
          | Some(n) when n >= 0 && n <= 100 => n
          | _ => Lexer.grammar_error(loc, invalid_percentage_value(n))
        }
        | Ampersand => Lexer.grammar_error(loc, invalid_prelude_value("&"))
        | Universal => Lexer.grammar_error(loc, invalid_prelude_value("*"))
        | Subclass(_) => Lexer.grammar_error(loc, invalid_prelude_value_opaque)
        | Variable(_) => Lexer.grammar_error(loc, invalid_prelude_value_opaque)
        }
     }
     | _ => Lexer.grammar_error(loc, invalid_selector);
    }
  };

  let keyframes =
    declarations
    |> List.map(declaration => {
      switch (declaration) {
        | Style_rule({
          prelude: (_selector, prelude_loc),
          block,
          loc: style_loc,
        }) =>
        let percentage =
          33
          /* render_select_as_keyframe(selector |> List.hd) */
          |> Builder.eint(~loc=prelude_loc);
        let rules =
          render_declarations(block) |> Builder.pexp_array(~loc);
        Builder.pexp_tuple(~loc=style_loc, [percentage, rules]);
      | _ => Lexer.grammar_error(loc, invalid_selector)
      }
    })
    |> Builder.pexp_array(~loc);

  {
    ...Builder.eapply(~loc, CssJs.keyframes(~loc), [keyframes]),
    pexp_attributes: [Create.uncurried(~loc)],
  };
};

let render_global = ((ruleList, loc): stylesheet) => {
  switch (ruleList) {
  /* There's only one style_rule */
  | [Style_rule(rule)] => render_style_rule(CssJs.global(~loc), rule) |> Create.applyIgnore(~loc)
  /* More than one isn't supported by bs-css */
  | _res =>
    Lexer.grammar_error(
      loc,
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
