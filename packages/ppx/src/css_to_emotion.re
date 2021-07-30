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
  Emotion.(css([display(`block)]))
 */
open Ppxlib;
open Css_types;
open Component_value;
open Ast_helper;

module Helper = Ast_helper;
module Builder = Ast_builder.Default;

module Emotion = {
  let lident = (~loc, name) => {txt: Ldot(Lident("CssJs"), name), loc};
};

let grammar_error = (loc, message) =>
  raise(Css_lexer.GrammarError((message, loc)));

let number_to_const = number =>
  if (String.contains(number, '.')) {
    Const.float(number);
  } else {
    Const.integer(number);
  };

let string_to_const = (~loc, s) =>
  Exp.constant(~loc, Const.string(~quotation_delimiter="js", s));

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

  let loc = ar.At_rule.loc;
  let (_, name_loc) = ar.At_rule.name;
  let (prelude, prelude_loc) = ar.At_rule.prelude;
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
          switch (Declarations_to_emotion.parse_declarations((ident, value))) {
          | Error(`Not_found) =>
            grammar_error(ident_loc, "unsupported property: " ++ ident)
          | Error(`Invalid_value(_error)) =>
            grammar_error(loc, "invalid value")
          | Ok(_) => ()
          };
        source_code_of_loc(complete_loc);
      }
    | (Ident("and"), _) => "and"
    | (Ident("or"), _) => "or"
    | (_, loc) => invalid_format(loc);

  let query = prelude |> List.map(parse_condition) |> String.concat(" ");
  if (query == "") {
    invalid_format(prelude_loc);
  };

  let rules =
    switch (ar.At_rule.block) {
    | Empty => invalid_format(loc)
    | Stylesheet(_) => invalid_format(loc)
    | Declaration_list(declaration) => render_declaration_list(declaration)
    };

  let media_ident =
    Builder.pexp_ident(~loc=name_loc, Emotion.lident(~loc, "media"));
  Builder.eapply(~loc, media_ident, [Builder.estring(~loc=prelude_loc, query), rules]);
}
and render_declaration =
    (d: Declaration.t): list(Parsetree.expression) => {
  let (name, name_loc) = d.Declaration.name;
  let (_valueList, loc) = d.Declaration.value;
  let value_source = source_code_of_loc(loc);

  switch (Declarations_to_emotion.parse_declarations((name, value_source))) {
  | Ok(exprs) => exprs
  | Error(`Not_found) => grammar_error(name_loc, "unknown property " ++ name)
  | Error(`Invalid_value(value)) =>
    grammar_error(loc, "invalid property value: " ++ value)
  };
}
and render_unsafe_declaration =
    (d: Declaration.t, _d_loc: Location.t): list(Parsetree.expression) => {
  let (name, _name_loc) = d.Declaration.name;
  let (_valueList, loc) = d.Declaration.value;
  let value_source = source_code_of_loc(loc);

  [Declarations_to_emotion.render_when_unsupported_features(name, value_source)];
}
and render_declarations =
    (ds: list(Declaration_list.kind)): list(Parsetree.expression) => {
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
        let ident = Exp.ident(~loc, Emotion.lident(~loc, "selector"));
        [render_style_rule(~isUncurried=false, ident, ar)];
      },
    ds,
  )
}
and render_declaration_list = ((list, loc): Declaration_list.t): Parsetree.expression => {
  Builder.pexp_array(~loc, render_declarations(list));
}
and render_style_rule = (~isUncurried, ident, rule: Style_rule.t): Parsetree.expression => {
  let (prelude, prelude_loc) = rule.Style_rule.prelude;
  let dl_expr = render_declaration_list(rule.Style_rule.block);

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
    /*<number><string> is parsed as Dimension */
    | Dimension((number, dimension)) => number ++ dimension ++ " " ++ s
    | Paren_block(c) =>
      List.fold_left(render_prelude_value, "", List.rev(c)) ++ s
    | Function((f, _l), (args, _la)) =>
      f ++ "(" ++ List.fold_left(render_prelude_value, ")", List.rev(args))
    | _ => grammar_error(value_loc, "Unexpected selector")
    };
  };

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
    let ident = Exp.ident(~loc, Emotion.lident(~loc, pseudoclass));
    Exp.apply(~loc=rule.Style_rule.loc, ident, [(Nolabel, dl_expr)]);
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
    let ident = Exp.ident(~loc, Emotion.lident(~loc, pseudoclass));
    Exp.apply(~loc=rule.Style_rule.loc, ident, [(Nolabel, dl_expr)]);
  | /* nth-child & friends */
    [
      (Selector("&"), _),
      (Delim(":"), _),
      (Function((_pc, loc), (_args, _args_loc)), _f_loc),
    ] =>
    // TODO: parses and use the correct functions instead of just strings selector
    let ident = Exp.ident(~loc, Emotion.lident(~loc, "selector"));
    let selector =
      List.fold_left(render_prelude_value, "", List.rev(prelude));
    let selector_expr = string_to_const(~loc=prelude_loc, selector);
    Exp.apply(
      ~loc=rule.Style_rule.loc,
      ident,
      [(Nolabel, selector_expr), (Nolabel, dl_expr)],
    );
  | _ =>
    let selector =
      List.fold_left(render_prelude_value, "", List.rev(prelude));
    let selector_expr = string_to_const(~loc=prelude_loc, selector);

    Exp.apply(
      ~loc=rule.Style_rule.loc,
      ~attrs=(isUncurried ? [Create.uncurried(~loc=rule.Style_rule.loc)] : []),
      ident,
      [(Nolabel, selector_expr), (Nolabel, dl_expr)],
    );
  };
};

let bsEmotionLabel = (~loc, name) => {
  Exp.apply(
    Exp.ident(Emotion.lident(~loc, "label")),
    [
      (
        Nolabel,
        Exp.constant(Pconst_string(name, loc, None)),
      ),
    ],
  )
};

let addLabel = (~loc, name, emotionExprs) => {
  [bsEmotionLabel(~loc, name), ...emotionExprs]
};

let render_style_call = (declaration_list): Parsetree.expression => {
  let loc = declaration_list.pexp_loc;
  let ident = Exp.ident(~loc, Emotion.lident(~loc, "style"));
  let arguments = [(Nolabel, declaration_list)];

  Exp.apply(~loc, ~attrs=[Create.uncurried(~loc)], ident, arguments);
};

let render_rule = (~isGlobalCall, ident, rule: Rule.t): Parsetree.expression => {
  switch (rule) {
  | Rule.Style_rule(styleRule) => render_style_rule(~isUncurried=isGlobalCall, ident, styleRule)
  | Rule.At_rule(atRule) => render_at_rule(atRule)
  };
};

let render_keyframes = ((ruleList, loc)): Parsetree.expression => {
  let invalidSelectorErrorMessage = {|
    keyframe selector can be from | to | <percentage>

    Like following:
        [%styled.keyframe "
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
           let rules = render_declaration_list(block);
           Builder.pexp_tuple(~loc=style_loc, [percentage, rules]);
         | Rule.At_rule(_) => grammar_error(loc, invalidSelectorErrorMessage)
         }
       })
    |> Builder.pexp_array(~loc);
  let emotionKeyframes =
    Builder.pexp_ident(~loc, Emotion.lident(~loc, "keyframes"));

  {
    ...Builder.eapply(~loc, emotionKeyframes, [keyframes]),
    pexp_attributes: [Create.uncurried(~loc)]
  };
};

let render_global = ((ruleList, loc): Stylesheet.t) => {
  let emotionGlobal = Exp.ident(~loc, Emotion.lident(~loc, "global"));

    switch (ruleList) {
    /* There's only one rule: */
    | [rule] => Create.applyIgnore(~loc, render_rule(~isGlobalCall=true, emotionGlobal, rule))
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
