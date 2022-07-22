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

type selector_interpolation =
  | String(string)
  | Expr(expression);

/* let join_strings_on_selector_interpolation = (si: list(selector_interpolation)): list(selector_interpolation) => {
     switch (si) {
       | [String(s), ...rest] => {
         si |> List.fold_left((acc, item) => {

         }, String(s))
       }
       | [Expr(e)] => {
         si |> List.fold_left((acc, item) => {

         }, Expr(e))
       | [_] => {
       }
     }
   } */

let concat = (~loc, expr, acc) => {
  let concat_fn = {txt: Lident("^"), loc} |> Helper.Exp.ident(~loc);
  Helper.Exp.apply(~loc, concat_fn, [(Nolabel, expr), (Nolabel, acc)]);
};

let rec concat_selector_interpolation =
        (si: list(selector_interpolation)): expression => {
  /* let interp_or_string = join_strings_on_selector_interpolation(si); */
  let loc = Ast_helper.default_loc^;

  switch (si) {
  | [Expr(e)] => e
  | [String(a), String(b), ...rest] => concat_selector_interpolation([String(a ++ " " ++ b), ...rest])
  | [String(s)] => string_to_const(~loc, s)
  | [String(s), Expr(e)] =>
    concat(~loc, string_to_const(~loc, s), e)
  | [Expr(e), String(s)] =>
    concat(~loc, e, string_to_const(~loc, s))
  | rest => concat_selector_interpolation(rest)
  };
};

let rec render_at_rule = (ar: At_rule.t): Parsetree.expression =>
  switch (ar.At_rule.name) {
  | ("media", _) => render_media_query(ar)
  | (
      "charset" as n | "import" as n | "namespace" as n | "supports" as n |
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
      "property" as n |
      /* Experimental */ "color-profile" as n |
      /* Experimental */ "viewport" as n |
      /* Deprecated */ "document" as n, /* Deprecated */
      _,
    ) =>
    grammar_error(
      ar.At_rule.loc,
      "At-rule @" ++ n ++ " is not supported in styled-ppx",
    )
  | (n, _) => grammar_error(ar.At_rule.loc, "Unknown @" ++ n ++ "")
  }
and render_media_query = (ar: At_rule.t): Parsetree.expression => {
  let concat = (~loc, expr, acc) => {
    let concat_fn = {txt: Lident("^"), loc} |> Helper.Exp.ident(~loc);
    Helper.Exp.apply(~loc, concat_fn, [(Nolabel, expr), (Nolabel, acc)]);
  };

  let invalid_format = loc =>
    grammar_error(loc, "@media value isn't a valid format");

  let loc = ar.loc;
  let (_, name_loc) = ar.name;
  let (prelude, _) = ar.prelude;
  let parse_condition = acc =>
    fun
    | (Component_value.Delim("*"), _) => acc
    | (
        Component_value.Paren_block([
          (Ident(ident), ident_loc),
          (Delim(":"), _) | (Delim("::"), _),
          (_, first_value_loc),
          ...values,
        ]),
        _,
      ) => {
        let values = values |> List.map(((_, loc)) => loc);
        let values_length = List.length(values);
        let last_value_loc =
          values_length == 0
            ? first_value_loc : List.nth(values, values_length - 1);
        let loc = {
          ...first_value_loc,
          loc_end: last_value_loc.Location.loc_end,
        };
        let value = source_code_of_loc(loc);
        let exprs =
          switch (Declarations_to_string.parse_declarations(ident, value)) {
          | Error(`Not_found) =>
            grammar_error(ident_loc, "unsupported property: " ++ ident)
          | Error(`Invalid_value(_error)) =>
            grammar_error(loc, "invalid value")
          | Ok(exprs) => exprs
          };
        List.fold_left(concat(~loc), acc, exprs);
      }
    | (Variable(v), loc) => {
        let ident =
          (
            switch (v) {
            | [lident] => {txt: Lident(lident), loc}
            | [longident, lident] => {
                txt: Ldot(Lident(longident), lident),
                loc,
              }
            | _ =>
              grammar_error(
                loc,
                "Variable can not be empty, please refer to a variable or module value",
              )
            }
          )
          |> Helper.Exp.ident(~loc);
        let space = string_to_const(~loc, " ");
        %expr
        [%e acc] ++ [%e ident] ++ [%e space];
      }
    /* and, only, all */
    | (Ident(id), loc) => {
        let id = string_to_const(~loc, id);
        let space = string_to_const(~loc, " ");
        %expr
        [%e acc] ++ [%e id] ++ [%e space];
      }
    /* (color) */
    | (Paren_block([(Ident(_), ident_loc)]), _) => {
        source_code_of_loc(ident_loc)
        |> string_to_const(~loc=ident_loc);
      }
    | (_, loc) => invalid_format(loc);

  if (prelude == []) {
    invalid_format(loc);
  };

  let empty = string_to_const(~loc, "");
  let query = prelude |> List.fold_left(parse_condition, empty);

  let rules =
    switch (ar.At_rule.block) {
    | Stylesheet(_) =>
      /* TODO: expected a list of declarations, got an stylesheet. */
      invalid_format(loc)
    | Empty => Builder.pexp_array(~loc, [])
    | Declaration_list(declaration) =>
      render_declarations(declaration) |> Builder.pexp_array(~loc)
    };

  let media_ident = Builder.pexp_ident(~loc=name_loc, CssJs.media(~loc));

  Helper.Exp.apply(
    ~loc,
    ~attrs=[Create.uncurried(~loc)],
    media_ident,
    [(Nolabel, query), (Nolabel, rules)],
  );
}
and render_declaration = (d: Declaration.t): list(Parsetree.expression) => {
  let (name, name_loc) = d.Declaration.name;
  let (_valueList, loc) = d.Declaration.value;
  let value_source = source_code_of_loc(loc);

  switch (Declarations_to_emotion.parse_declarations(name, value_source)) {
  | Ok(exprs) => exprs
  | Error(`Not_found) => grammar_error(name_loc, "Unknown property " ++ name)
  | Error(`Invalid_value(value)) =>
    grammar_error(
      loc,
      "Error in property '" ++ name ++ "' invalid value: " ++ value ++ "",
    )
  };
}
and render_unsafe_declaration =
    (d: Declaration.t, _d_loc: Location.t): list(Parsetree.expression) => {
  let (name, _name_loc) = d.Declaration.name;
  let (_valueList, loc) = d.Declaration.value;
  let value_source = source_code_of_loc(loc);

  [
    Declarations_to_emotion.render_when_unsupported_features(
      name,
      value_source,
    ),
  ];
}
and render_declarations = ds => {
  List.concat_map(
    declaration =>
      switch (declaration) {
      | Declaration_list.Declaration(decl) => render_declaration(decl)
      | Declaration_list.Unsafe(decl) =>
        render_unsafe_declaration(decl, decl.loc)
      | Declaration_list.At_rule(ar) => [render_at_rule(ar)]
      | Declaration_list.Style_rule(ar) =>
        let loc: Location.t = ar.loc;
        let ident = Helper.Exp.ident(~loc, CssJs.selector(~loc));
        [render_style_rule(ident, ar)];
      },
    fst(ds),
  );
}
and render_selector = (selector: Selector.t) => {
  open Selector;
  let loc = Ast_helper.default_loc^;
  let rec render_simple_selector =
    fun
    | Variable(v) => Expr(render_variable(~loc, v))
    | Ampersand => String("&")
    | Type(v) => String(v)
    | Subclass(v) => render_subclass_selector(v)
  and render_subclass_selector =
    fun
    | Id(v) => String("#" ++ v)
    | Class(v) => String("." ++ v)
    | Attribute(Attr_value(v)) => String("[" ++ v ++ "]")
    | Attribute(To_equal({name, kind, value})) =>  {
      let value = Selector.(
        switch(value) {
          | Attr_ident(ident) => ident
          | Attr_string(ident) => "\"" ++ ident ++ "\""
        }
      )
      String("[" ++ name ++ kind ++ value ++ "]")
    }
    | Pseudo_class(psc) => render_pseudo_selector(psc)
  and render_pseudo_selector =
    fun
    | Pseudoelement(v) => String("::" ++ v)
    | Pseudoclass(Ident(i)) => String(":" ++ i)
    | Pseudoclass(Function({name, payload: _})) =>
      String(
        ":"
        ++ name
        /* ++ (List.map(render_component_value, payload) |> String.concat("")) */
        ++ "))",
      );

  let rec render_compound_selector = compound_selector => {
    let render_selector_list = ((first, rest)): list(selector_interpolation) => {
      let first = first |> render_pseudo_selector;
      let rest = rest |> List.map(render_pseudo_selector);
      [first, ...rest];
    };
    let simple_selector =
      Option.fold(
        ~none=String(""),
        ~some=render_simple_selector,
        compound_selector.type_selector,
      );
    let subclass_selectors =
      List.map(
        render_subclass_selector,
        compound_selector.subclass_selectors,
      );
    let pseudo_selectors =
      List.concat_map(
        render_selector_list,
        compound_selector.pseudo_selectors,
      );
    List.concat([[simple_selector], subclass_selectors, pseudo_selectors]);
  }
  and render_complex_selector = (complex): list(selector_interpolation) => {
    switch (complex) {
    | Combinator({left, right}) =>
      let left = render_compound_selector(left);
      let right = render_right_combinator(right);
      List.concat([left, right]);
    | Selector(compound) => render_compound_selector(compound)
    };
  }
  and render_right_combinator = right => {
    right
    |> List.map(((combinator, compound_selector)) => {
         List.cons(
           Option.fold(~none=String(""), ~some=o => String(o), combinator),
           render_compound_selector(compound_selector),
         )
       })
    |> List.flatten;
  };

  switch (selector) {
  | SimpleSelector(simple) =>
    List.map(render_simple_selector, simple) |> concat_selector_interpolation
  | ComplexSelector(complex) =>
    List.map(render_complex_selector, complex)
    |> List.flatten
    |> concat_selector_interpolation
  | CompoundSelector(compound) =>
    List.map(render_compound_selector, compound)
    |> List.flatten
    |> concat_selector_interpolation
  };
}
and render_style_rule = (ident, rule: Style_rule.t): Parsetree.expression => {
  let (prelude, _preludeloc) = rule.Style_rule.prelude;
  let block = rule.Style_rule.block;
  let loc = block |> snd;
  let selector_expr = render_declarations(block) |> Builder.pexp_array(~loc);
  let selector_name: expression = render_selector(prelude);

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
