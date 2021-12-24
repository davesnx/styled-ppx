/*
  This file transform CSS AST to Emotion API calls, a simplified example:

    -- CSS Definition
    display: block;

    -- CSS AST
    Declaration: {
      important: false,
      property: "display",
      value: Value {
        "children": [
          Identifier {
            "name": "block"
          }
        ]
      }
    }

    -- Emotion output
    CssJs.(css([display(`block)]))
*/

open Ppxlib;
open Css_types;
open Component_value;

module Helper = Ast_helper;
module Builder = Ast_builder.Default;

module CssJs = {
  let lident = (~loc, name) => {txt: Ldot(Lident("CssJs"), name), loc};
  let selector = (~loc) => lident(~loc, "selector")
  let media = (~loc) => lident(~loc, "media")
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
  Helper.Exp.constant(~loc, Helper.Const.string(~quotation_delimiter="js", s));

let source_code_of_loc = loc => {
  let Location.{loc_start, loc_end, _} = loc;
  let Lex_buffer.{buf, pos, _} = Lex_buffer.last_buffer^;
  let pos_offset = pos.Lexing.pos_cnum;
  let loc_start = loc_start.Lexing.pos_cnum - pos_offset;
  let loc_end = loc_end.Lexing.pos_cnum - pos_offset;
  Sedlexing.Latin1.sub_lexeme(buf, loc_start - 1, loc_end - loc_start);
};

let rec render_at_rule = (ar: At_rule.t): Parsetree.expression =>
  switch (ar.At_rule.name) {
  | ("media", _) => render_media_query(ar)
  | (n, _) =>
    grammar_error(ar.At_rule.loc, "At-rule @" ++ n ++ " not supported")
  }
and render_media_query = (ar: At_rule.t): Parsetree.expression => {
  let invalid_format = loc =>
    grammar_error(loc, "@media value isn't a valid format");

  let loc = ar.loc;
  let (_, name_loc) = ar.name;
  let (prelude, prelude_loc) = ar.prelude;
  let parse_condition =
    fun
    | (
        Paren_block([
          (Ident(ident), ident_loc),
          (Delim(":"), _),
          (_, first_value_loc),
          ...values,
        ]),
        complete_loc,
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
        let () =
          switch (Declarations_to_emotion.parse_declarations(ident, value)) {
          | Error(`Not_found) =>
            grammar_error(ident_loc, "unsupported property: " ++ ident)
          | Error(`Invalid_value(_error)) =>
            grammar_error(loc, "invalid value")
          | Ok(_) => ()
          };
        source_code_of_loc(complete_loc);
      }
    | (Ident(id), _) => id
    | (_, loc) => invalid_format(loc);

  let query = prelude |> List.map(parse_condition) |> String.concat(" ");
  if (query == "") {
    invalid_format(prelude_loc);
  };

  let rules =
    switch (ar.At_rule.block) {
    | Empty => invalid_format(loc)
    | Stylesheet(_) => invalid_format(loc)
    | Declaration_list(declaration) => render_declarations(declaration) |> Builder.pexp_array(~loc)
    };

  let media_ident =
    Builder.pexp_ident(~loc=name_loc, CssJs.media(~loc));

  Helper.Exp.apply(
    ~loc,
    ~attrs=[Create.uncurried(~loc)],
    media_ident,
    [(Nolabel, Builder.estring(~loc=prelude_loc, query)), (Nolabel, rules)],
  );
}
and render_declaration = (d: Declaration.t): list(Parsetree.expression) => {
  let (name, name_loc) = d.Declaration.name;
  let (_valueList, loc) = d.Declaration.value;
  let value_source = source_code_of_loc(loc);

  switch (Declarations_to_emotion.parse_declarations(name, value_source)) {
  | Ok(exprs) => exprs
  | Error(`Not_found) => grammar_error(name_loc, "unknown property " ++ name)
  | Error(`Invalid_value(value)) =>
    grammar_error(loc, "invalid property value " ++ value ++ ". For property " ++ name)
  };
}
and render_unsafe_declaration = (d: Declaration.t, _d_loc: Location.t): list(Parsetree.expression) => {
  let (name, _name_loc) = d.Declaration.name;
  let (_valueList, loc) = d.Declaration.value;
  let value_source = source_code_of_loc(loc);

  [Declarations_to_emotion.render_when_unsupported_features(name, value_source)];
}
and render_declarations = ds => {
  List.concat_map(
    declaration =>
      switch (declaration) {
      | Declaration_list.Declaration(decl) =>
        render_declaration(decl)
      | Declaration_list.Unsafe(decl) =>
        render_unsafe_declaration(decl, decl.loc)
      | Declaration_list.At_rule(ar) => [render_at_rule(ar)]
      | Declaration_list.Style_rule(ar) =>
        let loc: Location.t = ar.loc;
        let ident = Helper.Exp.ident(~loc, CssJs.selector(~loc));
        [render_style_rule(ident, ar)];
      },
    fst(ds),
  )
}
and render_style_rule = (ident, rule: Style_rule.t): Parsetree.expression => {
  let (prelude, prelude_loc) = rule.Style_rule.prelude;
  let block = rule.Style_rule.block;
  let (_, loc) = rule.Style_rule.block;
  let dl_expr = render_declarations(block) |> Builder.pexp_array(~loc);

  let rec render_prelude_value = (s, (value, value_loc)) => {
    switch (value) {
    | Delim(":") => ":" ++ s
    | Delim(".") => "." ++ s
    | Delim(",") => ", " ++ s
    /* v can be ">", so we need an empty space between */
    | Delim(v) => " " ++ v ++ " " ++ s
    | Ident(v)
    | Operator(v)
    | Number(v)
    | Selector(v) => v ++ s
    | Hash(v) => "#" ++ v ++ s
    | String(v) => Format.sprintf("\"%s\"", v) ++ s;
    /*<number><string> is parsed as Dimension */
    | Dimension((number, dimension)) => number ++ dimension ++ " " ++ s
    | Bracket_block(c) =>
     "[" ++ List.fold_left(render_prelude_value, "]", List.rev(c)) ++ s
    | Paren_block(c) =>
      List.fold_left(render_prelude_value, "", List.rev(c)) ++ s
    | Function((f, _l), (args, _la)) =>
      f ++ "(" ++ List.fold_left(render_prelude_value, ")", List.rev(args))
    | _ => grammar_error(value_loc, "Unexpected selector")
    };
  };

  let render_function_value = (ident, selector) => {
    let selector_expr = string_to_const(~loc=prelude_loc, selector);
    Helper.Exp.apply(
      ~loc=rule.Style_rule.loc,
      ~attrs=[Create.uncurried(~loc=rule.Style_rule.loc)],
      ident,
      [(Nolabel, selector_expr), (Nolabel, dl_expr)]);
  }

  let render_rule_value = (ident, selector) => {
    let selector_expr = string_to_const(~loc=prelude_loc, selector);

    Helper.Exp.apply(
      ~loc=rule.Style_rule.loc,
      ~attrs=[Create.uncurried(~loc=rule.Style_rule.loc)],
      ident,
      [(Nolabel, selector_expr), (Nolabel, dl_expr)],
    );
  }

  switch (prelude) {
  | /* two-colons pseudoclasses */
    [
      (Selector("&"), _),
      (Delim(":"), _),
      (Delim(":"), _),
      (Ident(pseudoclasses), loc),
    ] =>
    let pseudoclass =
      switch (pseudoclasses) {
      | "active" => "active"
      | "after" => "after"
      | "before" => "before"
      | "first-line" => "firstLine"
      | "first-letter" => "firstLetter"
      | "selection" => "selection"
      | "placeholder" => "placeholder"
      | _ => grammar_error(loc, "Unexpected pseudo-class")
      };
    let ident = Helper.Exp.ident(~loc, CssJs.lident(~loc, pseudoclass));
    Helper.Exp.apply(~loc=rule.Style_rule.loc, ident, [(Nolabel, dl_expr)]);
  | /* single-colon pseudoclasses */
    [
      (Selector("&"), _),
      (Delim(":"), _),
      (Ident(pseudoclasses), loc)
    ] =>
    let pseudoclass =
      switch (pseudoclasses) {
      | "checked" => "checked"
      | "disabled" => "disabled"
      | "first-child" => "firstChild"
      | "first-of-type" => "firstOfType"
      | "focus" => "focus"
      | "hover" => "hover"
      | "last-child" => "lastChild"
      | "not" => "not"
      | "last-of-type" => "lastOfType"
      | "link" => "link"
      | "read-only" => "readOnly"
      | "required" => "required"
      | "visited" => "visited"
      | "enabled" => "enabled"
      | "empty" => "noContent"
      | "default" => "default"
      | "any-link" => "anyLink"
      | "only-child" => "onlyChild"
      | "only-of-type" => "onlyOfType"
      | "optional" => "optional"
      | "invalid" => "invalid"
      | "out-of-range" => "outOfRange"
      | "target" => "target"
      | _ => grammar_error(loc, "Unexpected pseudo-class")
      };
    let ident = Helper.Exp.ident(~loc, CssJs.lident(~loc, pseudoclass));
    Helper.Exp.apply(~loc=rule.Style_rule.loc, ident, [(Nolabel, dl_expr)]);
   /* nth-child & friends */
  |
    [
      (Selector("&"), _),
      (Delim(":"), _),
      (Function((_pc, loc), (_args, _args_loc)), _f_loc),
    ]
    =>
    // TODO: parses and use the correct functions instead of just strings selector
    let ident = Helper.Exp.ident(~loc, CssJs.selector(~loc));
    let selector =
      List.fold_left(render_prelude_value, "", List.rev(prelude));
      render_function_value(ident, selector);
  | [
    (Selector("&"), _),
    (Ident(_), _),
    ..._
    ]  as v =>
    let prelude = List.tl(v);
    switch(prelude) {
    | [
      (Ident(_), _),
      (Delim(":"), _),
      (Function((_pc, loc), (_args, _args_loc)), _f_loc)
    ]  =>
    let ident = Helper.Exp.ident(~loc, CssJs.selector(~loc));
    let selector =
      "& " ++ List.fold_left(render_prelude_value, "", List.rev(prelude));
    render_function_value(ident, selector);

    | [
      (Ident(_), _),
      (Bracket_block([ (_, loc), ..._]), _)
    ] =>
    let ident = Helper.Exp.ident(~loc, CssJs.selector(~loc));
    let selector = "& " ++
      List.fold_left(render_prelude_value, "", List.rev(prelude));
    render_rule_value(ident, selector);


    |  _ =>
     let selector = "& " ++
      List.fold_left(render_prelude_value, "", List.rev(prelude));
      render_rule_value(ident, selector);
    }

  |  [
      (Ident(_), _),
      (Bracket_block([ (_, loc), ..._]), _)
    ] =>
    let ident = Helper.Exp.ident(~loc, CssJs.selector(~loc));
    let selector = List.fold_left(render_prelude_value, "", List.rev(prelude));
    render_rule_value(ident, selector);

  | _ =>
    let selector =
      List.fold_left(render_prelude_value, "", List.rev(prelude));
      render_rule_value(ident, selector);
  };
};

let bsEmotionLabel = (~loc, label) => {
  Helper.Exp.apply(
    Helper.Exp.ident(CssJs.lident(~loc, "label")),
    [
      (
        Nolabel,
        Helper.Exp.constant(Pconst_string(label, loc, None)),
      ),
    ],
  )
};

let addLabel = (~loc, label, emotionExprs) =>
  [bsEmotionLabel(~loc, label), ...emotionExprs];

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

  let get_percentage_from_prelude =
    fun
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

  let keyframes =
    ruleList
    |> List.map(rule => {
         switch (rule) {
         | Rule.Style_rule({
             prelude: (_, prelude_loc) as prelude,
             block,
             loc: style_loc,
           }) =>
           let percentage =
             get_percentage_from_prelude(prelude) |> Builder.eint(~loc=prelude_loc);
           let rules = render_declarations(block) |> Builder.pexp_array(~loc);
           Builder.pexp_tuple(~loc=style_loc, [percentage, rules]);
         | Rule.At_rule(_) => grammar_error(loc, invalidSelectorErrorMessage)
         }
       })
    |> Builder.pexp_array(~loc);
  let emotionKeyframes =
    Builder.pexp_ident(~loc, CssJs.lident(~loc, "keyframes"));

  {
    ...Builder.eapply(~loc, emotionKeyframes, [keyframes]),
    pexp_attributes: [Create.uncurried(~loc)]
  };
};

let render_global = ((ruleList, loc): Stylesheet.t) => {
  let emotionGlobal = Helper.Exp.ident(~loc, CssJs.lident(~loc, "global"));

    switch (ruleList) {
    /* There's only one rule: */
    | [rule] => render_rule(emotionGlobal, rule)
      |> Create.applyIgnore(~loc)
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
