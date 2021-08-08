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
open Migrate_parsetree;
open Ast_410;
open Ast_helper;
open Asttypes;
open Parsetree;
open Longident;
open Styled_ppx_parser;
open Css_types;
open Component_value;
open Ppxlib.Ast_builder.Default;
open New_css_types;

let with_loc = (txt, ~loc) => {txt, loc};
module Emotion = {
  let lident = name => Ldot(Lident("Css"), name);
};

let grammar_error = (loc, message) =>
  raise(Css_lexer.GrammarError((message, loc)));

let number_to_const = number =>
  if (String.contains(number, '.')) {
    Const.float(number);
  } else {
    Const.integer(number);
  };

let float_to_const = number =>
  if (Float.is_integer(number)) {
    Const.float(string_of_float(number));
  } else {
    Const.integer(string_of_int(Float.to_int(number)));
  };
let string_to_const = (~loc, s) =>
  Exp.constant(~loc, Const.string(~quotation_delimiter="js", s));

let list_to_expr = (end_loc, xs) =>
  List.fold_left(
    (e, param) => {
      let loc =
        Lex_buffer.make_loc(
          ~loc_ghost=true,
          e.pexp_loc.Location.loc_start,
          end_loc.Location.loc_end,
        );
      Exp.construct(
        ~loc,
        {txt: Lident("::"), loc},
        Some(Exp.tuple(~loc, [param, e])),
      );
    },
    Exp.construct(~loc=end_loc, {txt: Lident("[]"), loc: end_loc}, None),
    xs,
  );

let source_code_of_loc = loc => {
  let Warnings.{loc_start, loc_end, _} = loc;
  let Lex_buffer.{buf, pos, _} = Lex_buffer.last_buffer^;
  let pos_offset = pos.Lexing.pos_cnum;
  let loc_start = loc_start.Lexing.pos_cnum - pos_offset;
  let loc_end = loc_end.Lexing.pos_cnum - pos_offset;
  Sedlexing.Latin1.sub_lexeme(buf, loc_start - 1, loc_end - loc_start);
};
let rec render_at_rule = (name: loc(string), rule: loc(rule)): expression =>
  switch (name.txt) {
  | "keyframes" as n =>
    let {txt: rule, loc} = rule;
    let rules =
      rule.block.txt
      |> List.map(
           fun
           | {txt: Rule(rule), loc} => with_loc(~loc, rule)
           | {txt: Declaration(_), loc} =>
             grammar_error(loc, "Unexpected declaration in @keyframes body"),
         );
    let ident = Exp.ident(~loc, {txt: Lident(n), loc});
    let end_loc =
      Lex_buffer.make_loc(
        ~loc_ghost=true,
        loc.Location.loc_end,
        loc.Location.loc_end,
      );
    let arg =
      List.fold_left(
        (e, {txt: r, loc}) =>
          switch (r.kind) {
          | Style =>
            let progress_expr =
              switch (r.prelude.txt) {
              | [{txt: PERCENTAGE(p), loc}] =>
                Exp.constant(~loc, float_to_const(p))
              | [{txt: IDENT("from"), loc}]
              | [{txt: NUMBER(0.0), loc}] =>
                Exp.constant(~loc, Const.int(0))
              | [{txt: IDENT("to"), loc}] =>
                Exp.constant(~loc, Const.int(100))
              | _ =>
                grammar_error(r.prelude.loc, "Unexpected @keyframes prelude")
              };
            let block_expr = render_block(r.block);
            let tuple = Exp.tuple(~loc, [progress_expr, block_expr]);
            Exp.construct(
              ~loc,
              {txt: Lident("::"), loc},
              Some(Exp.tuple(~loc, [tuple, e])),
            );
          | At(_) =>
            grammar_error(loc, "Unexpected at-rule in @keyframes body")
          },
        Exp.construct(
          ~loc=end_loc,
          {txt: Lident("[]"), loc: end_loc},
          None,
        ),
        List.rev(rules),
      );
    Exp.apply(~loc, ident, [(Nolabel, arg)]);
  | "media" => render_media_query(name, rule)
  | n => grammar_error(name.loc, "At-rule @" ++ n ++ " not supported")
  }
and render_media_query = (name: loc(string), rule: loc(rule)): expression => {
  let invalid_format = loc =>
    grammar_error(loc, "@media value isn't a valid format");

  let {txt: rule, loc} = rule;
  let {txt: _, loc: name_loc} = name;
  let rec match_parens = (acc, {txt: prelude, loc}) =>
    // TODO: please kill this block
    switch (acc, prelude) {
    | ([], [])
    | ([`Block(_), ..._], []) => invalid_format(loc)
    // this prevents non finished blocks
    | ([`Block(_), ..._], [{txt: LEFT_PARENS, loc}, ..._]) =>
      invalid_format(loc)
    | (acc, []) => acc
    | (acc, [{txt: WHITESPACE, _}, ...prelude]) =>
      match_parens(acc, with_loc(~loc, prelude))
    | (acc, [{txt: LEFT_PARENS, _}, ...prelude]) =>
      match_parens([`Block([]), ...acc], with_loc(~loc, prelude))
    | (acc, [{txt: RIGHT_PARENS, _}, ...prelude]) =>
      match_parens([`Tokens([]), ...acc], with_loc(~loc, prelude))
    | ([`Tokens(body), ...acc], [token, ...prelude]) =>
      match_parens(
        [`Tokens([token, ...body]), ...acc],
        with_loc(~loc, prelude),
      )
    | ([`Block(body), ...acc], [token, ...prelude]) =>
      match_parens(
        [`Block([token, ...body]), ...acc],
        with_loc(~loc, prelude),
      )
    | (_, [{loc, _}, ..._]) => invalid_format(loc)
    };

  let parse_condition = prelude =>
    switch (prelude) {
    | `Block([
        {txt: IDENT(ident), loc: ident_loc},
        {txt: DELIM(":"), _},
        {loc: first_value_loc, _},
        ...values,
      ]) =>
      let values = values |> List.map(({loc, _}) => loc);
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
      source_code_of_loc(loc);
    | `Tokens([{txt: IDENT("and"), _}]) => "and"
    | `Tokens([{txt: IDENT("or"), _}]) => "or"
    | _ => invalid_format(loc)
    };
  let query =
    match_parens([], rule.prelude)
    |> List.map(parse_condition)
    |> String.concat(" ");

  let rules =
    switch (rule.block) {
    | {txt: [], _} => invalid_format(rule.block.loc)
    | {txt: block, loc} =>
      let declarations =
        block
        |> List.map(
             fun
             | {txt: Declaration(declaration), loc} =>
               with_loc(~loc, declaration)
             | {txt: Rule(_), loc} => invalid_format(loc),
           );
      render_declaration_list(with_loc(~loc, declarations));
    };

  let media_ident =
    Emotion.lident("media")
    |> Located.mk(~loc=name_loc)
    |> pexp_ident(~loc=name_loc);
  eapply(~loc, media_ident, [estring(~loc=rule.prelude.loc, query), rules]);
}
and render_declaration =
    ({txt: d, loc: _}: loc(declaration)): list(expression) => {
  let {txt: name, loc: name_loc} = d.name;
  let {txt: _valueList, loc} = d.value;

  let value_source = source_code_of_loc(loc);

  switch (Declarations_to_emotion.parse_declarations((name, value_source))) {
  | Ok(exprs) => exprs
  | Error(`Not_found) => grammar_error(name_loc, "unknown property " ++ name)
  | Error(`Invalid_value(_error)) =>
    grammar_error(loc, "invalid property value")
  };
}
and render_declaration_list =
    ({txt: list, loc}: loc(list(loc(declaration)))) =>
  list |> List.concat_map(render_declaration) |> list_to_expr(loc)
and render_block_value = ({txt: block_value, loc}) =>
  switch (block_value) {
  | Declaration(decl) => render_declaration(with_loc(~loc, decl))
  | Rule({kind: At(name), _} as rule) => [
      render_at_rule(name, with_loc(~loc, rule)),
    ]
  | Rule(rule) =>
    let ident = Exp.ident(~loc, {txt: Emotion.lident("selector"), loc});
    [render_style_rule(ident, with_loc(~loc, rule))];
  }
and render_block = ({txt: block, loc}: loc(block)): expression =>
  List.concat_map(render_block_value, block) |> List.rev |> list_to_expr(loc)
and render_style_rule = (ident, {txt: sr, loc}: loc(rule)): expression => {
  let {txt: prelude, loc: prelude_loc} = sr.prelude;
  let dl_expr = render_block(sr.block);
  let rec render_prelude_value = (s, (value, value_loc)) => {
    switch (value) {
    | Delim(":") => ":" ++ s
    | Delim(v) => " " ++ v ++ " " ++ s
    | Ident(v)
    | Operator(v)
    | Number(v)
    | Selector(v) => v ++ s
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
  /* two-colons pseudoclasses */
  | [
      (Selector("&"), _),
      (Delim(":"), _),
      (Delim(":"), _),
      (Ident(pc), loc),
    ] =>
    let f =
      switch (pc) {
      | "active" => "active"
      | "after" => "after"
      | "before" => "before"
      | "first-line" => "firstLine"
      | "first-letter" => "firstLetter"
      | "selection" => "selection"
      | "placeholder" => "placeholder"
      | _ => grammar_error(loc, "Unexpected pseudo-class")
      };
    let ident = Exp.ident(~loc, {txt: Emotion.lident(f), loc});
    Exp.apply(~loc=sr.Style_rule.loc, ident, [(Nolabel, dl_expr)]);
  | [(Selector("&"), _), (Delim(":"), _), (Ident(pc), loc)] =>
    /* single-colon pseudoclasses */
    let f =
      switch (pc) {
      | "checked" => "checked"
      | "disabled" => "disabled"
      | "first-child" => "firstChild"
      | "first-of-type" => "firstOfType"
      | "focus" => "focus"
      | "hover" => "hover"
      | "last-child" => "lastChild"
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
    let ident = Exp.ident(~loc, {txt: Emotion.lident(f), loc});
    Exp.apply(~loc=sr.Style_rule.loc, ident, [(Nolabel, dl_expr)]);
  | [
      (Selector("&"), _),
      (Delim(":"), _),
      (Function((_pc, loc), (_args, _args_loc)), _f_loc),
    ] =>
    /* nth-child & friends */
    // TODO: parses and use the correct functions instead of just strings selector
    let ident = Exp.ident(~loc, {txt: Emotion.lident("selector"), loc});
    let selector =
      List.fold_left(render_prelude_value, "", List.rev(prelude));
    let selector_expr = string_to_const(~loc=prelude_loc, selector);
    Exp.apply(
      ~loc=sr.Style_rule.loc,
      ident,
      [(Nolabel, selector_expr), (Nolabel, dl_expr)],
    );
  | _ =>
    let selector =
      List.fold_left(render_prelude_value, "", List.rev(prelude));
    let selector_expr = string_to_const(~loc=prelude_loc, selector);

    Exp.apply(
      ~loc=sr.Style_rule.loc,
      ident,
      [(Nolabel, selector_expr), (Nolabel, dl_expr)],
    );
  };
};

let render_emotion_style = (declaration_list: expression): expression => {
  let loc = declaration_list.pexp_loc;
  let ident = Exp.ident(~loc, {txt: Emotion.lident("style"), loc});

  Exp.apply(~loc, ident, [(Nolabel, declaration_list)]);
};
let render_emotion_css = ((list, loc): Declaration_list.t): expression => {
  let declarationListValues = render_declaration_list((list, loc));
  render_emotion_style(declarationListValues);
};

let render_rule = (ident, rule: loc(rule)): expression =>
  switch (rule.txt.kind) {
  | Style => render_style_rule(ident, rule)
  | At(name) => render_at_rule(name, rule)
  };

let render_emotion_keyframe = ((ruleList, loc)): expression => {
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
             get_percentage_from_prelude(prelude) |> eint(~loc=prelude_loc);
           let rules = render_declaration_list(block);
           pexp_tuple(~loc=style_loc, [percentage, rules]);
         | Rule.At_rule(_) => grammar_error(loc, invalidSelectorErrorMessage)
         }
       })
    |> elist(~loc);
  let emotionKeyframes =
    pexp_ident(~loc, {txt: Emotion.lident("keyframes"), loc});
  eapply(~loc, emotionKeyframes, [keyframes]);
};
let render_global =
    ({txt: ruleList, loc}: loc(list(loc(rule)))): expression => {
  let emotionGlobal = Exp.ident(~loc, {txt: Emotion.lident("global"), loc});

  switch (ruleList) {
  /* There's only one rule: */
  | [rule] => render_rule(emotionGlobal, rule)
  /* There's more than one */
  | _ =>
    grammar_error(
      loc,
      {|
      styled.global only supports one style selector, add one styled.global per selector.

      Like following:

        [%styled.global ""];
        [%styled.global ""];
    |},
    )
  /* TODO: Add rule to string to finish this error message */
  };
};
