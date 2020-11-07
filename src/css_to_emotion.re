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
open Css_types;
open Component_value;
open Ppxlib.Ast_builder.Default;

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
let rec render_at_rule = (ar: At_rule.t): expression =>
  switch (ar.At_rule.name) {
  | ("keyframes" as n, loc) =>
    let ident = Exp.ident(~loc, {txt: Lident(n), loc});
    switch (ar.At_rule.block) {
    | Brace_block.Stylesheet((rs, loc)) =>
      let end_loc =
        Lex_buffer.make_loc(
          ~loc_ghost=true,
          loc.Location.loc_end,
          loc.Location.loc_end,
        );
      let arg =
        List.fold_left(
          (e, r) =>
            switch (r) {
            | Rule.Style_rule(sr) =>
              let progress_expr =
                switch (sr.Style_rule.prelude) {
                | ([(Percentage(p), loc)], _) =>
                  Exp.constant(~loc, number_to_const(p))
                | ([(Ident("from"), loc)], _)
                | ([(Number("0"), loc)], _) =>
                  Exp.constant(~loc, Const.int(0))
                | ([(Ident("to"), loc)], _) =>
                  Exp.constant(~loc, Const.int(100))
                | (_, loc) =>
                  grammar_error(loc, "Unexpected @keyframes prelude")
                };
              let block_expr = render_declaration_list(sr.Style_rule.block);
              let tuple =
                Exp.tuple(
                  ~loc=sr.Style_rule.loc,
                  [progress_expr, block_expr],
                );
              let loc =
                Lex_buffer.make_loc(
                  ~loc_ghost=true,
                  sr.Style_rule.loc.Location.loc_start,
                  loc.Location.loc_end,
                );
              Exp.construct(
                ~loc,
                {txt: Lident("::"), loc},
                Some(Exp.tuple(~loc, [tuple, e])),
              );
            | Rule.At_rule(ar) =>
              grammar_error(
                ar.At_rule.loc,
                "Unexpected at-rule in @keyframes body",
              )
            },
          Exp.construct(
            ~loc=end_loc,
            {txt: Lident("[]"), loc: end_loc},
            None,
          ),
          List.rev(rs),
        );
      Exp.apply(~loc=ar.At_rule.loc, ident, [(Nolabel, arg)]);
    | _ => assert(false)
    };
  | ("media", _) => render_media_query(ar)
  | (n, _) =>
    grammar_error(ar.At_rule.loc, "At-rule @" ++ n ++ " not supported")
  }
and render_media_query = (ar: At_rule.t): expression => {
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
    | Brace_block.Empty => invalid_format(loc)
    | Declaration_list(declaration) => render_declaration_list(declaration)
    | Stylesheet(_) => invalid_format(loc)
    };

  let media_ident =
    Emotion.lident("media")
    |> Located.mk(~loc=name_loc)
    |> pexp_ident(~loc=name_loc);
  eapply(~loc, media_ident, [estring(~loc=prelude_loc, query), rules]);
}
and render_declaration =
    (d: Declaration.t, _d_loc: Location.t): list(expression) => {
  let (name, name_loc) = d.Declaration.name;
  let (_valueList, loc) = d.Declaration.value;

  let value_source = source_code_of_loc(loc);

  switch (Declarations_to_emotion.parse_declarations((name, value_source))) {
  | Ok(exprs) => exprs
  | Error(`Not_found) => grammar_error(name_loc, "unknown property " ++ name)
  | Error(`Invalid_value(_error)) =>
    grammar_error(loc, "invalid property value")
  };
}
and render_declarations =
    (ds: list(Declaration_list.kind)): list(expression) =>
  List.concat_map(
    declaration =>
      switch (declaration) {
      | Declaration_list.Declaration(decl) =>
        render_declaration(decl, decl.loc)
      | Declaration_list.At_rule(ar) => [render_at_rule(ar)]
      | Declaration_list.Style_rule(ar) =>
        let loc: Location.t = ar.loc;
        let ident = Exp.ident(~loc, {txt: Emotion.lident("selector"), loc});
        [render_style_rule(ident, ar)];
      },
    ds,
  )
  |> List.rev
and render_declaration_list = ((list, loc): Declaration_list.t): expression => {
  let expr_with_loc_list = render_declarations(list);
  list_to_expr(loc, expr_with_loc_list);
}
and render_style_rule = (ident, sr: Style_rule.t): expression => {
  let (prelude, prelude_loc) = sr.Style_rule.prelude;
  let dl_expr = render_declaration_list(sr.Style_rule.block);
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

let render_rule = (ident, r: Rule.t): expression => {
  switch (r) {
  | Rule.Style_rule(sr) => render_style_rule(ident, sr)
  | Rule.At_rule(ar) => render_at_rule(ar)
  };
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
let render_global = ((ruleList, loc): Stylesheet.t): expression => {
  let emotionGlobal = Exp.ident(~loc, {txt: Emotion.lident("global"), loc});

  let rec seq = (~exp, ~make, list) => {
    switch (list) {
    | [] => exp
    | [x, ...list] => seq(~exp=x |> make |> Exp.sequence(exp), ~make, list)
    };
  };

  switch (ruleList) {
  | [rule] => render_rule(emotionGlobal, rule)
  | [rule, ...rules] =>
    seq(
      ~exp=render_rule(emotionGlobal, rule),
      ~make=render_rule(emotionGlobal),
      rules,
    )
  | [] => grammar_error(loc, "styled.global shoudn't be empty.")
  };
};
