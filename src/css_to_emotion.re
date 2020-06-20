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

module Emotion = {
  let lident = name => Ldot(Lident("Css"), name);
};

let grammar_error = (loc, message) =>
  raise(Css_lexer.GrammarError((message, loc)));

let split = (c, s) => {
  let rec loop = (s, accu) =>
    try({
      let index = String.index(s, c);
      [
        String.sub(s, 0, index),
        ...loop(
             String.sub(s, index + 1, String.length(s) - index - 1),
             accu,
           ),
      ];
    }) {
    | Not_found => [s, ...accu]
    };

  loop(s, []);
};

/* https://github.com/ahrefs/bs-emotion/blob/master/bs-emotion/src/Emotion.rei#L68 */
let is_variant = ident =>
  switch (ident) {
  /* float/clear/text-align */
  | "left"
  | "right"
  | "justify"
  /* cursor */
  | "pointer"
  | "alias"
  | "all-scroll"
  | "cell"
  | "context-menu"
  | "default"
  | "crosshair"
  | "copy"
  | "grab"
  | "grabbing"
  | "help"
  | "move"
  | "not-allowed"
  | "progress"
  | "text"
  | "wait"
  | "zoom-in"
  | "zoom-out"
  /* list-style-type */
  | "disc"
  | "circle"
  | "decimal"
  | "lower-alpha"
  | "upper-alpha"
  | "lower-greek"
  | "upper-greek"
  | "lower-latin"
  | "upper-latin"
  | "lower-roman"
  | "upper-roman"
  /* outline-style */
  | "groove"
  | "ridge"
  | "inset"
  | "outset"
  /* transform-style */
  | "preserve-3d"
  | "flat"
  /* font-variant */
  | "small-caps"
  /* step-timing-function */
  | "start"
  | "end"
  /* display */
  | "block"
  | "flex"
  | "inline-flex"
  /* font-weight */
  | "thin"
  | "extra-light"
  | "light"
  | "medium"
  | "semi-bold"
  | "bold"
  | "extra-bold"
  | "lighter"
  | "bolder"
  /* box-sizing */
  | "content-box"
  | "border-box" => true
  | _ => false
  };

let to_caml_case = s => {
  let splitted = split('-', s);
  List.fold_left(
    (s, part) =>
      s
      ++ (
        if (s != "") {
          String.capitalize_ascii(part);
        } else {
          part;
        }
      ),
    "",
    splitted,
  );
};

let number_to_const = number =>
  if (String.contains(number, '.')) {
    Const.float(number);
  } else {
    Const.integer(number);
  };

let float_to_const = number => {
  let number =
    if (String.contains(number, '.')) {
      number;
    } else {
      number ++ ".";
    };
  Const.float(number);
};

/* let p = (prop, value) => [(prop, value)]->Declaration.pack; */
let render_unsafe = (~loc, proproperty, value) => {
  let unsafeFnP = Exp.ident(~loc, {txt: Emotion.lident("unsafe"), loc});
  let labelName = Exp.constant(Pconst_string(proproperty, None));

  Exp.apply(~loc, unsafeFnP, [(Nolabel, labelName), (Nolabel, value)]);
};

let string_to_const = (~loc, s) =>
  Exp.constant(~loc, Const.string(~quotation_delimiter="js", s));

let render_html_color = (~loc, v) =>
  Exp.ident(~loc, {txt: Emotion.lident(v), loc});

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

let group_params = params => {
  let rec group_param = ((accu, loc), xs) =>
    switch (xs) {
    | [] => ((accu, loc), [])
    | [(Delim(","), _), ...rest] => ((accu, loc), rest)
    | [(_, cv_loc) as hd, ...rest] =>
      let loc = {
        let loc_start =
          if (loc == Location.none) {
            cv_loc.Location.loc_start;
          } else {
            loc.Location.loc_start;
          };
        Lex_buffer.make_loc(loc_start, cv_loc.Location.loc_end);
      };
      group_param((accu @ [hd], loc), rest);
    };

  let rec group_params = (accu, xs) =>
    switch (xs) {
    | [] => accu
    | _ =>
      let (param, rest) = group_param(([], Location.none), xs);
      group_params(accu @ [param], rest);
    };

  group_params([], params);
};

let is_time = value =>
  switch (value) {
  | Float_dimension((_, _, Time)) => true
  | _ => false
  };

let is_timing_function = value =>
  switch (value) {
  | Ident("linear")
  /* cubic-bezier-timing-function */
  | Ident("ease")
  | Ident("ease-in")
  | Ident("ease-out")
  | Ident("ease-in-out")
  | Function(("cubic-bezier", _), _)
  /* step-timing-function */
  | Ident("step-start")
  | Ident("step-end")
  | Function(("steps", _), _)
  /* frames-timing-function */
  | Function(("frames", _), _) => true
  | _ => false
  };

let is_animation_iteration_count = value =>
  switch (value) {
  | Ident("infinite")
  | Function(("count", _), _) => true
  | _ => false
  };

let is_animation_direction = value =>
  switch (value) {
  | Ident("normal")
  | Ident("reverse")
  | Ident("alternate")
  | Ident("alternate-reverse") => true
  | _ => false
  };

let is_animation_fill_mode = value =>
  switch (value) {
  | Ident("none")
  | Ident("forwards")
  | Ident("backwards")
  | Ident("both") => true
  | _ => false
  };

let is_animation_play_state = value =>
  switch (value) {
  | Ident("running")
  | Ident("paused") => true
  | _ => false
  };

let is_keyframes_name = value =>
  switch (value) {
  | Ident(_)
  | String(_) => true
  | _ => false
  };

let is_ident = (ident, value) =>
  switch (value) {
  | Ident(i) when i == ident => true
  | _ => false
  };

let is_length = value =>
  switch (value) {
  | Number("0")
  | Float_dimension((_, _, Length)) => true
  | _ => false
  };

let is_color = value =>
  switch (value) {
  | Function(("rgb", _), _)
  | Function(("rgba", _), _)
  | Function(("hsl", _), _)
  | Function(("hsla", _), _)
  | Hash(_) => true
  | Ident(i) => Html.isColor(i)
  | _ => false
  };

let is_line_width = value =>
  switch (value) {
  | Ident(i) =>
    switch (i) {
    | "thin"
    | "medium"
    | "thick" => true
    | _ => false
    }
  | _ => is_length(value)
  };

/* let is_variable = value =>
   switch (value) {
   | Variable(_v) => true
   | _ => false
   };
   */

/* let is_typed_variable = value =>
   switch (value) {
   | TypedVariable((_v, _type)) => true
   | _ => false
   };
   */
let is_line_style = value =>
  switch (value) {
  | Ident(i) =>
    switch (i) {
    | "none"
    | "hidden"
    | "dotted"
    | "dashed"
    | "solid"
    | "double"
    | "groove"
    | "ridge"
    | "inset"
    | "outset" => true
    | _ => false
    }
  | _ => false
  };

let is_css_wide_keyword = string =>
  Reason_css_parser.(
    Parser.parse(Standard.css_wide_keywords, string) |> Result.is_ok
  );

let render_dimension = (~loc, number, dimension, const) => {
  let number_loc = {
    ...loc,
    Location.loc_end: {
      ...loc.Location.loc_end,
      Lexing.pos_cnum:
        loc.Location.loc_end.Lexing.pos_cnum - String.length(dimension),
    },
  };
  let dimension_loc = {
    ...loc,
    Location.loc_start: {
      ...loc.Location.loc_start,
      Lexing.pos_cnum:
        loc.Location.loc_start.Lexing.pos_cnum + String.length(number),
    },
  };
  let ident =
    Exp.ident(
      ~loc=dimension_loc,
      {txt: Emotion.lident(dimension), loc: dimension_loc},
    );
  let arg = Exp.constant(~loc=number_loc, const);
  Exp.apply(~loc, ident, [(Nolabel, arg)]);
};

let rec render_value = ((cv, loc): with_loc(t)): expression => {
  let render_block = (start_char, _, _) =>
    grammar_error(loc, "Unsupported " ++ start_char ++ "-block");

  let render_function = ((name, name_loc), (params, params_loc)) => {
    let caml_case_name = to_caml_case(name);
    let ident =
      Exp.ident(
        ~loc=name_loc,
        {txt: Emotion.lident(caml_case_name), loc: name_loc},
      );
    let grouped_params = group_params(params);
    let args = {
      let side_or_corner_expr = (deg, loc) =>
        render_value((Float_dimension((deg, "deg", Angle)), loc));

      let color_stops_to_expr_list = color_stop_params =>
        List.rev_map(
          fun
          | ([(_, start_loc) as color_cv, (Percentage(perc), end_loc)], _)
          | (
              [(_, start_loc) as color_cv, (Number("0" as perc), end_loc)],
              _,
            ) => {
              let color_expr = render_value(color_cv);
              let perc_expr = render_value((Percentage(perc), end_loc));
              let loc =
                Lex_buffer.make_loc(
                  start_loc.Location.loc_start,
                  end_loc.Location.loc_end,
                );
              Exp.tuple(~loc, [perc_expr, color_expr]);
            }
          | (_, loc) => grammar_error(loc, "Unexpected color stop"),
          color_stop_params,
        );

      let end_loc =
        Lex_buffer.make_loc(
          ~loc_ghost=true,
          loc.Location.loc_end,
          loc.Location.loc_end,
        );
      let render_params = params =>
        params
        |> List.filter(
             fun
             | (Delim(","), _) => false
             | _ => true,
           )
        |> List.map(
             fun
             | (Number("0"), loc) => Exp.constant(~loc, Const.int(0))
             | c => render_value(c),
           );

      switch (name) {
      | "linear-gradient"
      | "repeating-linear-gradient" =>
        let (side_or_corner, color_stop_params) =
          switch (List.hd(grouped_params)) {
          | ([(Float_dimension((_, "deg", Angle)), _) as cv], _) => (
              render_value(cv),
              List.tl(grouped_params),
            )
          | ([(Ident("to"), _), (Ident("bottom"), _)], loc) => (
              side_or_corner_expr("180", loc),
              List.tl(grouped_params),
            )
          | ([(Ident("to"), _), (Ident("top"), _)], loc) => (
              side_or_corner_expr("0", loc),
              List.tl(grouped_params),
            )
          | ([(Ident("to"), _), (Ident("right"), _)], loc) => (
              side_or_corner_expr("90", loc),
              List.tl(grouped_params),
            )
          | ([(Ident("to"), _), (Ident("left"), _)], loc) => (
              side_or_corner_expr("270", loc),
              List.tl(grouped_params),
            )
          | ([(Ident(_), _), ..._], _) =>
            let implicit_side_or_corner_loc =
              Lex_buffer.make_loc(
                ~loc_ghost=true,
                params_loc.Location.loc_start,
                params_loc.Location.loc_start,
              );
            (
              render_value((
                Float_dimension(("180", "deg", Angle)),
                implicit_side_or_corner_loc,
              )),
              grouped_params,
            );
          | (_, loc) => grammar_error(loc, "Unexpected first parameter")
          | exception (Failure(_)) =>
            grammar_error(params_loc, "Missing parameters")
          };

        let color_stops = color_stops_to_expr_list(color_stop_params);
        let color_stop_expr = list_to_expr(end_loc, color_stops);
        [side_or_corner, color_stop_expr];
      | "radial-gradient"
      | "repeating-radial-gradient" =>
        let color_stops = color_stops_to_expr_list(grouped_params);
        let color_stop_expr = list_to_expr(end_loc, color_stops);
        [color_stop_expr];
      | "hsl" =>
        let ps =
          params
          |> List.filter(
               fun
               | (Delim(","), _) => false
               | _ => true,
             );

        switch (ps) {
        | [(Number(n), l1), (Percentage(p1), l2), (Percentage(p2), l3)]
        | [
            (Float_dimension((n, "deg", Angle)), l1),
            (Percentage(p1), l2),
            (Percentage(p2), l3),
          ] => [
            render_value((Float_dimension((n, "deg", Angle)), l1)),
            Exp.constant(~loc=l2, float_to_const(p1)),
            Exp.constant(~loc=l3, float_to_const(p2)),
          ]
        | _ => grammar_error(params_loc, "Unexpected parameters (hsl)")
        };
      | "hsla" =>
        let ps =
          params
          |> List.filter(
               fun
               | (Delim(","), _) => false
               | _ => true,
             );

        switch (ps) {
        | [
            (Number(n), l1),
            (Percentage(p1), l2),
            (Percentage(p2), l3),
            (Number(p3), l4),
          ]
        | [
            (Float_dimension((n, "deg", Angle)), l1),
            (Percentage(p1), l2),
            (Percentage(p2), l3),
            (Number(p3), l4),
          ] => [
            render_value((Float_dimension((n, "deg", Angle)), l1)),
            Exp.constant(~loc=l2, float_to_const(p1)),
            Exp.constant(~loc=l3, float_to_const(p2)),
            Exp.variant(
              ~loc=l4,
              "num",
              Some(Exp.constant(~loc=l4, float_to_const(p3))),
            ),
          ]
        | [
            (Number(n), l1),
            (Percentage(p1), l2),
            (Percentage(p2), l3),
            (Percentage(p3), l4),
          ]
        | [
            (Float_dimension((n, "deg", Angle)), l1),
            (Percentage(p1), l2),
            (Percentage(p2), l3),
            (Percentage(p3), l4),
          ] => [
            render_value((Float_dimension((n, "deg", Angle)), l1)),
            Exp.constant(~loc=l2, float_to_const(p1)),
            Exp.constant(~loc=l3, float_to_const(p2)),
            Exp.variant(
              ~loc=l4,
              "perc",
              Some(Exp.constant(~loc=l4, float_to_const(p3))),
            ),
          ]
        | _ => grammar_error(params_loc, "Unexpected parameters (hsla)")
        };
      | _ => render_params(params)
      };
    };

    Exp.apply(~loc, ident, List.map(a => (Nolabel, a), args));
  };

  switch (cv) {
  | Paren_block(cs) => render_block("(", ")", cs)
  | Bracket_block(cs) => render_block("[", "]", cs)
  | Percentage(p) =>
    let ident = Exp.ident(~loc, {txt: Emotion.lident("pct"), loc});
    let arg = Exp.constant(~loc, float_to_const(p));
    Exp.apply(~loc, ident, [(Nolabel, arg)]);
  | Ident(i) when Html.isColor(i) => render_html_color(~loc, i)
  | Ident(i) =>
    let name = to_caml_case(i);
    if (is_variant(i)) {
      Exp.variant(~loc, name, None);
    } else {
      Exp.ident(~loc, {txt: Emotion.lident(name), loc});
    };
  | String(s) => string_to_const(~loc, s)
  | Selector(s) => Exp.ident(~loc, {txt: Emotion.lident(s), loc})
  | Uri(s) =>
    let ident = Exp.ident(~loc, {txt: Emotion.lident("url"), loc});
    let arg = string_to_const(~loc, s);
    Exp.apply(~loc, ident, [(Nolabel, arg)]);
  | Hash(s) =>
    let ident = Exp.ident(~loc, {txt: Emotion.lident("hex"), loc});
    let arg = string_to_const(~loc, s);
    Exp.apply(~loc, ident, [(Nolabel, arg)]);
  | Number(s) =>
    switch (s) {
    | "0" => Exp.variant(~loc, "zero", None)
    | _ => Exp.constant(~loc, number_to_const(s))
    }
  | Function(f, params) => render_function(f, params)
  | Float_dimension((number, dimension, _)) =>
    let const =
      switch (dimension) {
      | "px"
      | "pt"
      | "ms" => Const.integer(number)
      | _ => float_to_const(number)
      };
    render_dimension(~loc, number, dimension, const);
  | Dimension((number, dimension)) =>
    let const = number_to_const(number);
    render_dimension(~loc, number, dimension, const);
  | Unicode_range(_) => grammar_error(loc, "Unsupported unicode range")
  | Operator(_) => grammar_error(loc, "Unsupported operator")
  | Delim(_) => grammar_error(loc, "Unsupported delimiter")
  | TypedVariable((variable, func)) =>
    let ident = Exp.ident(~loc, {txt: Emotion.lident(func), loc});
    let arg = string_to_const(~loc, variable);
    Exp.apply(~loc, ident, [(Nolabel, arg)]);
  | Variable(x) =>
    grammar_error(
      loc,
      "Unsupported variable in here, you wrote this: "
      ++ x
      ++ ". If you think that's a bug, please open an issue https://github.com/davesnx/styled-ppx/issues/new",
    )
  };
}
and render_at_rule = (ar: At_rule.t): expression =>
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
              let block_expr =
                render_declaration_list(sr.Style_rule.block, None);
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
  | (n, _) =>
    grammar_error(ar.At_rule.loc, "At-rule @" ++ n ++ " not supported")
  }
and render_declaration =
    (
      d: Declaration.t,
      d_loc: Location.t,
      _variables: list((string, string)),
    )
    : list(expression) => {
  let (name, name_loc) = d.Declaration.name;
  let fnName = to_caml_case(name);

  let render_standard_declaration = (fnName, valueList) => {
    let args = List.map(render_value, valueList);
    let ident =
      Exp.ident(
        ~loc=name_loc,
        {txt: Emotion.lident(fnName), loc: name_loc},
      );
    Exp.apply(~loc=d_loc, ident, List.map(a => (Nolabel, a), args));
  };

  /* https://developer.mozilla.org/en-US/docs/Web/CSS/animation */
  let _render_animation = (params, _loc) => {
    let animation_ident =
      Exp.ident(
        ~loc=name_loc,
        {txt: Ldot(Lident("Animation"), "shorthand"), loc: name_loc},
      );
    let animation_args = ((grouped_param, _)) =>
      List.fold_left(
        (args, (v, loc) as cv) =>
          if (is_time(v)) {
            if (!
                  List.exists(
                    fun
                    | (Labelled("duration"), _) => true
                    | _ => false,
                    args,
                  )) {
              [(Labelled("duration"), render_value(cv)), ...args];
            } else if (!
                         List.exists(
                           fun
                           | (Labelled("delay"), _) => true
                           | _ => false,
                           args,
                         )) {
              [(Labelled("delay"), render_value(cv)), ...args];
            } else {
              grammar_error(
                loc,
                "animation canot have more than 2 time values",
              );
            };
          } else if (is_timing_function(v)) {
            [(Labelled("timingFunction"), render_value(cv)), ...args];
          } else if (is_animation_iteration_count(v)) {
            [(Labelled("iterationCount"), render_value(cv)), ...args];
          } else if (is_animation_direction(v)) {
            [(Labelled("direction"), render_value(cv)), ...args];
          } else if (is_animation_fill_mode(v)) {
            [(Labelled("fillMode"), render_value(cv)), ...args];
          } else if (is_animation_play_state(v)) {
            [(Labelled("playState"), render_value(cv)), ...args];
          } else if (is_keyframes_name(v)) {
            let s =
              switch (v) {
              | Ident(s)
              | String(s) => s
              | _ => assert(false)
              };
            let i = Exp.ident(~loc, {txt: Lident(s), loc});
            [(Nolabel, i), ...args];
          } else {
            grammar_error(loc, "Unexpected animation value");
          },
        [],
        grouped_param,
      );

    let grouped_params = group_params(params);
    let args =
      List.rev_map(params => animation_args(params), grouped_params);
    let ident =
      Exp.ident(~loc=name_loc, {txt: Lident("animations"), loc: name_loc});
    let box_shadow_list =
      List.map(arg => Exp.apply(animation_ident, arg), args);
    Exp.apply(ident, [(Nolabel, list_to_expr(name_loc, box_shadow_list))]);
  };

  /* https://developer.mozilla.org/en-US/docs/Web/CSS/text-shadow */
  /* https://developer.mozilla.org/en-US/docs/Web/CSS/box-shadow */
  let render_shadow = (name, params, loc) => {
    let text_shadow_args = ((grouped_param, _)) =>
      List.fold_right(
        (cv, args) => [render_value(cv), ...args],
        grouped_param,
        [],
      );

    let grouped_params = group_params(params);
    let args =
      List.rev_map(params => text_shadow_args(params), grouped_params);
    let ident =
      Exp.ident(~loc=name_loc, {txt: Emotion.lident(name), loc: name_loc});
    let text_shadow_list = List.map(arg => Exp.tuple(~loc, arg), args);

    Exp.apply(
      ident,
      [(Nolabel, list_to_expr(name_loc, text_shadow_list))],
    );
  };

  /* https://developer.mozilla.org/en-US/docs/Web/CSS/transition */
  let render_transition = (params, _loc) => {
    let transition_ident =
      Exp.ident(
        ~loc=name_loc,
        {txt: Ldot(Lident("Transition"), "shorthand"), loc: name_loc},
      );
    let render_property = (property, loc) =>
      Exp.constant(~loc, Const.string(property));

    let transition_args = ((grouped_param, _)) =>
      List.fold_left(
        (args, (v, loc) as cv) =>
          if (is_time(v)) {
            if (!
                  List.exists(
                    fun
                    | (Labelled("duration"), _) => true
                    | _ => false,
                    args,
                  )) {
              [(Labelled("duration"), render_value(cv)), ...args];
            } else if (!
                         List.exists(
                           fun
                           | (Labelled("delay"), _) => true
                           | _ => false,
                           args,
                         )) {
              [(Labelled("delay"), render_value(cv)), ...args];
            } else {
              grammar_error(
                loc,
                "transition cannot have more than 2 time values",
              );
            };
          } else if (is_timing_function(v)) {
            [(Labelled("timingFunction"), render_value(cv)), ...args];
          } else {
            switch (v) {
            | Ident(p) => [(Nolabel, render_property(p, loc)), ...args]
            | _ => grammar_error(loc, "Unexpected transition value")
            };
          },
        [],
        grouped_param,
      );

    let grouped_params = group_params(params);
    let args =
      List.rev_map(params => transition_args(params), grouped_params);
    let ident =
      Exp.ident(~loc=name_loc, {txt: Lident("transitions"), loc: name_loc});
    let transition_list =
      List.map(arg => Exp.apply(transition_ident, arg), args);
    Exp.apply(ident, [(Nolabel, list_to_expr(name_loc, transition_list))]);
  };

  let render_transform = (vs, loc) =>
    if (List.length(vs) == 1) {
      render_standard_declaration(fnName, vs);
    } else {
      let cvs = List.rev_map(v => render_value(v), vs);
      let arg = list_to_expr(loc, cvs);
      let ident =
        Exp.ident(
          ~loc=name_loc,
          {txt: Lident("transforms"), loc: name_loc},
        );
      Exp.apply(~loc=d_loc, ident, [(Nolabel, arg)]);
    };

  let render_font_family = (vs, loc) => {
    let font_family_args = ((params, _)) => {
      let s =
        List.fold_left(
          (s, (v, loc)) =>
            switch (v) {
            | Ident(x)
            | String(x) =>
              s
              ++ (
                if (String.length(s) > 0) {
                  " ";
                } else {
                  "";
                }
              )
              ++ x
            | _ => grammar_error(loc, "Unexpected font-family value")
            },
          "",
          params,
        );

      render_value((String(s), loc));
    };

    let grouped_params = group_params(vs);
    let args =
      List.rev_map(params => font_family_args(params), grouped_params);
    let ident =
      Exp.ident(
        ~loc=name_loc,
        {txt: Emotion.lident("fontFamily"), loc: name_loc},
      );
    Exp.apply(
      ~loc=name_loc,
      ident,
      [(Nolabel, list_to_expr(name_loc, args))],
    );
  };

  let render_z_index = (vs, loc) => {
    let arg =
      if (List.length(vs) == 1) {
        let (v, loc) as c = List.hd(vs);
        switch (v) {
        | Ident(_) => render_value(c)
        | Number(n) => Exp.constant(~loc, Pconst_integer(n, None))
        | _ => grammar_error(loc, "Unexpected z-index value")
        };
      } else {
        grammar_error(loc, "z-index should have a single value");
      };

    let ident =
      Exp.ident(
        ~loc=name_loc,
        {txt: Emotion.lident(fnName), loc: name_loc},
      );
    Exp.apply(~loc=name_loc, ident, [(Nolabel, arg)]);
  };

  /* https://developer.mozilla.org/en-US/docs/Web/CSS/flex-grow */
  let render_flex_grow_shrink = (vs, loc) => {
    let arg =
      if (List.length(vs) == 1) {
        let (v, loc) = List.hd(vs);
        switch (v) {
        | Number(n) => Exp.constant(~loc, float_to_const(n))
        | _ => grammar_error(loc, "Unexpected " ++ name ++ " value")
        };
      } else {
        grammar_error(loc, name ++ " should have a single value");
      };

    let ident =
      Exp.ident(
        ~loc=name_loc,
        {txt: Emotion.lident(fnName), loc: name_loc},
      );
    Exp.apply(~loc=name_loc, ident, [(Nolabel, arg)]);
  };

  /* https://developer.mozilla.org/en/docs/Web/CSS/font-weight */
  let render_font_weight = (vs, loc) => {
    let arg =
      switch (List.length(vs)) {
      | 0 => grammar_error(loc, "font-weight should have a single value")
      | _ =>
        let (v, loc) = List.hd(vs);
        switch (v) {
        /* TODO: Support `normal`, `bold`, `lighter`, `bolder` */
        | Number(n) => Exp.constant(~loc, Pconst_integer(n, None))
        | _ =>
          grammar_error(
            loc,
            "Unexpected font-weight value, expects an integer",
          )
        };
      };

    let ident =
      Exp.ident(
        ~loc=name_loc,
        {txt: Emotion.lident(fnName), loc: name_loc},
      );
    Exp.apply(~loc=name_loc, ident, [(Nolabel, arg)]);
  };

  /* https://developer.mozilla.org/en-US/docs/Web/CSS/border */
  let render_border_outline = (params, loc) => {
    let border_outline_args = (params, _) =>
      List.fold_left(
        (args, (v, loc) as cv) =>
          if (is_line_width(v)) {
            [(Labelled("width"), render_value(cv)), ...args];
          } else if (is_line_style(v)) {
            [(Nolabel, render_value(cv)), ...args];
          } else if (is_color(v)) {
            [(Labelled("color"), render_value(cv)), ...args];
          } else {
            grammar_error(loc, "Unexpected " ++ name ++ " value");
          },
        [],
        params,
      );

    let args = border_outline_args(params, loc);
    let fnName2 = fnName ++ "2";
    let ident =
      Exp.ident(
        ~loc=name_loc,
        {txt: Emotion.lident(fnName2), loc: name_loc},
      );
    Exp.apply(ident, args);
  };

  let render_margin_padding = (vs, _loc) => {
    let parameter_count = List.length(vs);
    let fnNameN =
      parameter_count > 1 ? fnName ++ string_of_int(parameter_count) : fnName;

    let ident =
      Exp.ident(
        ~loc=name_loc,
        {txt: Emotion.lident(fnNameN), loc: name_loc},
      );
    let args = List.map(v => (Nolabel, render_value(v)), vs);
    Exp.apply(~loc=d_loc, ident, args);
  };

  let render_opacity = (vs, loc) => {
    let arg =
      switch (List.length(vs)) {
      | 0 => grammar_error(loc, "opacity should have a single value")
      | _ =>
        let (v, loc) = List.hd(vs);
        switch (v) {
        | Number(n) => Exp.constant(~loc, Pconst_float(n, None))
        | _ => grammar_error(loc, "Unexpected opacity value")
        };
      };

    let ident =
      Exp.ident(
        ~loc=name_loc,
        {txt: Emotion.lident("opacity"), loc: name_loc},
      );
    Exp.apply(~loc=name_loc, ident, [(Nolabel, arg)]);
  };

  /* https://developer.mozilla.org/en-US/docs/Web/CSS/flex */
  let render_flex = (vs, loc) => {
    let expression =
      switch (List.length(vs)) {
      | 0 => grammar_error(loc, "flex should have a single value")
      /*
       TODO: Right now bs-css  https://github.com/MinimaHQ/re-css/issues/11
       | 1 => {
       let (v, loc) = List.hd(vs);
       switch (v) {
         | Number(n) => Exp.constant(~loc, Pconst_float(n, None))
         | _  => grammar_error(loc, "Unexpected flex value")
       }} */
      | _ =>
        Exp.tuple(
          ~loc,
          List.map(
            ((v, loc)) => {
              switch (v) {
              | Percentage(_) => render_value((v, loc))
              | Number(n) => Exp.constant(~loc, Pconst_float(n, None))
              | _ => render_value((v, loc))
              /* TODO: Better handling `flex-basis in px and add grammar_error`
                 | _  => grammar_error(loc, "Unexpected flex value") */
              }
            },
            vs,
          ),
        )
      };

    let args = [(Nolabel, Exp.variant(~loc, "some", Some(expression)))];

    let ident =
      Exp.ident(
        ~loc=name_loc,
        {txt: Emotion.lident(fnName), loc: name_loc},
      );
    Exp.apply(~loc=name_loc, ident, args);
  };

  let render_legacy = (valueList, loc) => {
    let newValueList = List.map(value => value, valueList);

    switch (valueList) {
    /* TODO: Right know we only support variables with functions that
       accepts only one argument, in order to change/improve that, we need to
       "render" variables/typed_variables and static params.
        */
    | [(Variable(v), _loc)] =>
      Exp.ident(~loc, {txt: Lident(v), loc}) |> render_unsafe(~loc, name)
    | [(Ident(string), _loc)] when string |> is_css_wide_keyword =>
      Const.string(string) |> Exp.constant |> render_unsafe(~loc, name)
    | _ =>
      switch (name) {
      /* | "animation" => render_animation(newValueList, loc) */
      | "box-shadow" => render_shadow("boxShadows", newValueList, loc)
      | "text-shadow" => render_shadow("textShadows", newValueList, loc)
      | "transform" => render_transform(newValueList, loc)
      | "transition" => render_transition(newValueList, loc)
      | "font-family" => render_font_family(newValueList, loc)
      | "z-index" => render_z_index(newValueList, loc)
      | "stroke-opacity"
      | "stop-opacity"
      | "flood-opacity"
      | "fill-opacity"
      | "opacity" => render_opacity(newValueList, loc)
      | "flex-grow"
      | "flex-shrink" => render_flex_grow_shrink(newValueList, loc)
      | "font-weight" => render_font_weight(newValueList, loc)
      | "flex" => render_flex(newValueList, loc)
      | "padding"
      | "margin" => render_margin_padding(newValueList, loc)
      | "border"
      | "outline" when List.length(fst(d.Declaration.value)) == 2 =>
        render_border_outline(newValueList, loc)
      | _ => render_standard_declaration(fnName, valueList)
      }
    };
  };
  let (valueList, loc) = d.Declaration.value;

  Declarations_to_emotion.support_property(name)
    ? switch (Declarations_to_emotion.parse_declarations((name, valueList))) {
      | Ok(exprs) => exprs
      | Error(`Not_found) => grammar_error(loc, "something weird happened")
      | Error(`Invalid_value(error)) => grammar_error(loc, error)
      }
    : [render_legacy(valueList, loc)];
}
and render_declarations =
    (ds: list(Declaration_list.kind), variables): list(expression) =>
  List.concat_map(
    declaration =>
      switch (declaration) {
      | Declaration_list.Declaration(decl) =>
        render_declaration(
          decl,
          decl.loc,
          Option.value(~default=[], variables),
        )
      | Declaration_list.At_rule(ar) => [render_at_rule(ar)]
      | Declaration_list.Style_rule(ar) =>
        let loc: Location.t = ar.loc;
        let ident = Exp.ident(~loc, {txt: Emotion.lident("selector"), loc});
        [render_style_rule(ident, ar)];
      },
    ds,
  )
  |> List.rev
and render_declaration_list =
    ((list, loc): Declaration_list.t, variables): expression => {
  let expr_with_loc_list = render_declarations(list, variables);
  list_to_expr(loc, expr_with_loc_list);
}
and render_style_rule = (ident, sr: Style_rule.t): expression => {
  let (prelude, prelude_loc) = sr.Style_rule.prelude;
  let dl_expr = render_declaration_list(sr.Style_rule.block, None);
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

let render_emotion_css =
    ((list, loc): Declaration_list.t, variables): expression => {
  let declarationListValues =
    render_declaration_list((list, loc), variables);
  let ident = Exp.ident(~loc, {txt: Emotion.lident("style"), loc});

  Exp.apply(~loc, ident, [(Nolabel, declarationListValues)]);
};

let render_rule = (ident, r: Rule.t): expression => {
  switch (r) {
  | Rule.Style_rule(sr) => render_style_rule(ident, sr)
  | Rule.At_rule(ar) => render_at_rule(ar)
  };
};

let render_global = ((ruleList, loc): Stylesheet.t): expression => {
  let emotionGlobal = Exp.ident(~loc, {txt: Emotion.lident("global"), loc});

  switch (ruleList) {
  /* There's only one rule: */
  | [rule] => render_rule(emotionGlobal, rule)
  /* There's more than one */
  | _res =>
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
