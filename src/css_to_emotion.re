open Migrate_parsetree;
open Ast_406;
open Ast_helper;
open Asttypes;
open Parsetree;
open Css_types;

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
let is_variant = (ident) =>
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
    | "bolder" => true
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

let group_params = params => {
  let rec group_param = ((accu, loc), xs) =>
    switch (xs) {
    | [] => ((accu, loc), [])
    | [(Component_value.Delim(","), _), ...rest] => ((accu, loc), rest)
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

let is_time = component_value =>
  Component_value.(
    switch (component_value) {
    | Float_dimension((_, _, Time)) => true
    | _ => false
    }
  );

let is_timing_function = component_value =>
  Component_value.(
    switch (component_value) {
    | Ident("linear")
    /* cubic-bezier-timing-function */
    | Ident("ease")
    | Ident("ease-in")
    | Ident("ease-out")
    | Ident("ease-in-out")
    | Function((("cubic-bezier", _)), _)
    /* step-timing-function */
    | Ident("step-start")
    | Ident("step-end")
    | Function((("steps", _)), _)
    /* frames-timing-function */
    | Function((("frames", _)), _) => true
    | _ => false
    }
  );

let is_animation_iteration_count = component_value =>
  Component_value.(
    switch (component_value) {
    | Ident("infinite")
    | Function((("count", _)), _) => true
    | _ => false
    }
  );

let is_animation_direction = component_value =>
  Component_value.(
    switch (component_value) {
    | Ident("normal")
    | Ident("reverse")
    | Ident("alternate")
    | Ident("alternate-reverse") => true
    | _ => false
    }
  );

let is_animation_fill_mode = component_value =>
  Component_value.(
    switch (component_value) {
    | Ident("none")
    | Ident("forwards")
    | Ident("backwards")
    | Ident("both") => true
    | _ => false
    }
  );

let is_animation_play_state = component_value =>
  Component_value.(
    switch (component_value) {
    | Ident("running")
    | Ident("paused") => true
    | _ => false
    }
  );

let is_keyframes_name = component_value =>
  Component_value.(
    switch (component_value) {
    | Ident(_)
    | String(_) => true
    | _ => false
    }
  );

let is_ident = (ident, component_value) =>
  Component_value.(
    switch (component_value) {
    | Ident(i) when i == ident => true
    | _ => false
    }
  );

let is_length = component_value =>
  Component_value.(
    switch (component_value) {
    | Number("0")
    | Float_dimension((_, _, Length)) => true
    | _ => false
    }
  );

let is_color = component_value =>
  Component_value.(
    switch (component_value) {
    | Function((("rgb", _)), _)
    | Function((("rgba", _)), _)
    | Function((("hsl", _)), _)
    | Function((("hsla", _)), _)
    | Hash(_)
    | Ident(_) => true
    | _ => false
    }
  );

let is_line_width = component_value =>
  Component_value.(
    switch (component_value) {
    | Ident(i) =>
      switch (i) {
      | "thin"
      | "medium"
      | "thick" => true
      | _ => false
      }
    | _ => is_length(component_value)
    }
  );

let is_line_style = component_value =>
  Component_value.(
    switch (component_value) {
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
    }
  );

let rec render_component_value = ((cv, loc): with_loc(Component_value.t)): expression => {
  let render_block = (start_char, _, _) =>
    grammar_error(loc, "Unsupported " ++ start_char ++ "-block");

  let render_dimension = (number, dimension, const) => {
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
        {txt: Lident(dimension), loc: dimension_loc},
      );
    let arg = Exp.constant(~loc=number_loc, const);
    Exp.apply(~loc, ident, [(Nolabel, arg)]);
  };

  let render_function = ((name, name_loc), (params, params_loc)) => {
    let caml_case_name = to_caml_case(name);
    let ident =
      Exp.ident(
        ~loc=name_loc,
        {txt: Lident(caml_case_name), loc: name_loc},
      );
    let grouped_params = group_params(params);
    let rcv = render_component_value;
    let args = {
      open Component_value;
      let side_or_corner_expr = (deg, loc) =>
        rcv((Float_dimension((deg, "deg", Angle)), loc));

      let color_stops_to_expr_list = color_stop_params =>
        List.rev_map(
          fun
          | ([(_, start_loc) as color_cv, (Percentage(perc), end_loc)], _)
          | (
              [(_, start_loc) as color_cv, (Number("0" as perc), end_loc)],
              _,
            ) => {
              let color_expr = rcv(color_cv);
              let perc_expr = rcv((Percentage(perc), end_loc));
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
             | c => rcv(c),
           );

      switch (name) {
      | "linear-gradient"
      | "repeating-linear-gradient" =>
        let (side_or_corner, color_stop_params) =
          switch (List.hd(grouped_params)) {
          | (
              [
                (Float_dimension((_, "deg", Angle)), _) as cv,
              ],
              _,
            ) => (
              rcv(cv),
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
              rcv((
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
            rcv((Float_dimension((n, "deg", Angle)), l1)),
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
            rcv((Float_dimension((n, "deg", Angle)), l1)),
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
            rcv((Float_dimension((n, "deg", Angle)), l1)),
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
  | Component_value.Paren_block(cs) => render_block("(", ")", cs)
  | Bracket_block(cs) => render_block("[", "]", cs)
  | Percentage(p) =>
    let ident = Exp.ident(~loc, {txt: Lident("pct"), loc});
    let const = float_to_const(p);
    let arg = Exp.constant(~loc, const);
    Exp.apply(~loc, ident, [(Nolabel, arg)]);
  | Ident(i) =>
    let name = to_caml_case(i);
    if (is_variant(i)) {
      Exp.variant(~loc, name, None);
    } else {
      Exp.ident(~loc, {txt: Lident(name), loc});
    };
  | String(s) => string_to_const(~loc, s)
  | Uri(s) =>
    let ident = Exp.ident(~loc, {txt: Lident("url"), loc});
    let arg = string_to_const(~loc, s);
    Exp.apply(~loc, ident, [(Nolabel, arg)]);
  | Operator(_) => grammar_error(loc, "Unsupported operator")
  | Delim(_) => grammar_error(loc, "Unsupported delimiter")
  | Hash(s) =>
    let ident = Exp.ident(~loc, {txt: Lident("hex"), loc});
    let arg = string_to_const(~loc, s);
    Exp.apply(~loc, ident, [(Nolabel, arg)]);
  | Number(s) =>
    if (s == "0") {
      Exp.ident(~loc, {txt: Lident("zero"), loc});
    } else {
      Exp.constant(~loc, number_to_const(s));
    }
  | Unicode_range(_) => grammar_error(loc, "Unsupported unicode range")
  | Function(f, params) => render_function(f, params)
  | Float_dimension((number, "ms", Time)) =>
    /* bs-css expects milliseconds as an int constant */
    let const = Const.integer(number);
    Exp.constant(~loc, const);
  | Float_dimension((number, dimension, _)) =>
    let const =
      if (dimension == "px") {
        /* Pixels are treated as integers by both libraries */
        Const.integer(
          number,
        );
      } else if (dimension == "pt") {
        /* bs-css uses int points */
        Const.integer(number);
      } else if (dimension == "ms") {
        /* bs-typed-css uses int milliseconds */
        Const.integer(number);
      } else {
        float_to_const(number);
      };
    render_dimension(number, dimension, const);
  | Dimension((number, dimension)) =>
    let const = number_to_const(number);
    render_dimension(number, dimension, const);
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
                | ([(Component_value.Percentage(p), loc)], _) =>
                  Exp.constant(~loc, number_to_const(p))
                | ([(Component_value.Ident("from"), loc)], _)
                | ([(Component_value.Number("0"), loc)], _) =>
                  Exp.constant(~loc, Const.int(0))
                | ([(Component_value.Ident("to"), loc)], _) =>
                  Exp.constant(~loc, Const.int(100))
                | (_, loc) =>
                  grammar_error(loc, "Unexpected @keyframes prelude")
                };
              let block_expr =
                render_declaration_list(sr.Style_rule.block);
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
    (d: Declaration.t, d_loc: Location.t): expression => {
  open Component_value;
  let rcv = render_component_value;
  let (name, name_loc) = d.Declaration.name;

  /* https://developer.mozilla.org/en-US/docs/Web/CSS/animation */
  let render_animation = () => {
    let animation_ident =
      Exp.ident(
        ~loc=name_loc,
        {
          txt: Ldot(Lident("Animation"), "shorthand"),
          loc: name_loc,
        },
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
              [(Labelled("duration"), rcv(cv)), ...args];
            } else if (!
                         List.exists(
                           fun
                           | (Labelled("delay"), _) => true
                           | _ => false,
                           args,
                         )) {
              [(Labelled("delay"), rcv(cv)), ...args];
            } else {
              grammar_error(
                loc,
                "animation canot have more than 2 time values",
              );
            };
          } else if (is_timing_function(v)) {
            [(Labelled("timingFunction"), rcv(cv)), ...args];
          } else if (is_animation_iteration_count(v)) {
            [(Labelled("iterationCount"), rcv(cv)), ...args];
          } else if (is_animation_direction(v)) {
            [(Labelled("direction"), rcv(cv)), ...args];
          } else if (is_animation_fill_mode(v)) {
            [(Labelled("fillMode"), rcv(cv)), ...args];
          } else if (is_animation_play_state(v)) {
            [(Labelled("playState"), rcv(cv)), ...args];
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

    let (params, _) = d.Declaration.value;
    let grouped_params = group_params(params);
    let args =
      List.rev_map(params => animation_args(params), grouped_params);
    let ident =
      Exp.ident(~loc=name_loc, {txt: Lident("animations"), loc: name_loc});
    let box_shadow_list =
      List.map(arg => Exp.apply(animation_ident, arg), args);
    Exp.apply(ident, [(Nolabel, list_to_expr(name_loc, box_shadow_list))]);
  };

  /* https://developer.mozilla.org/en-US/docs/Web/CSS/box-shadow */
  let render_box_shadow = () => {
    let box_shadow_args = (args, (v, loc) as cv) =>
      if (is_ident("inset", v)) {
        [
          (
            Labelled("inset"),
            Exp.construct(~loc, {txt: Lident("true"), loc}, None),
          ),
          ...args,
        ];
      } else if (is_length(v)) {
        if (!
              List.exists(
                fun
                | (Labelled("x"), _) => true
                | _ => false,
                args,
              )) {
          [(Labelled("x"), rcv(cv)), ...args];
        } else if (!
                     List.exists(
                       fun
                       | (Labelled("y"), _) => true
                       | _ => false,
                       args,
                     )) {
          [(Labelled("y"), rcv(cv)), ...args];
        } else if (!
                     List.exists(
                       fun
                       | (Labelled("blur"), _) => true
                       | _ => false,
                       args,
                     )) {
          [(Labelled("blur"), rcv(cv)), ...args];
        } else if (!
                     List.exists(
                       fun
                       | (Labelled("spread"), _) => true
                       | _ => false,
                       args,
                     )) {
          [(Labelled("spread"), rcv(cv)), ...args];
        } else {
          grammar_error(
            loc,
            "box-shadow cannot have more than 4 length values",
          );
        };
      } else if (is_color(v)) {
        [(Nolabel, rcv(cv)), ...args];
      } else {
        grammar_error(loc, "Unexpected box-shadow value");
      };

    let txt = Longident.Lident("shadow");
    let box_shadow_ident = Exp.ident(~loc=name_loc, {txt, loc: name_loc});
    let box_shadow_args = ((grouped_param, _)) =>
      List.fold_left(box_shadow_args, [], grouped_param);

    let (params, _) = d.Declaration.value;
    let grouped_params = group_params(params);
    let args =
      List.rev_map(params => box_shadow_args(params), grouped_params);
    let ident =
      Exp.ident(~loc=name_loc, {txt: Lident("boxShadows"), loc: name_loc});
    let box_shadow_list =
      List.map(arg => Exp.apply(box_shadow_ident, arg), args);
    Exp.apply(ident, [(Nolabel, list_to_expr(name_loc, box_shadow_list))]);
  };

  /* https://developer.mozilla.org/en-US/docs/Web/CSS/text-shadow */
  let render_text_shadow = () => {
    let text_shadow_args = (args, (v, loc) as cv) =>
      if (is_ident("inset", v)) {
        [
          (
            Labelled("inset"),
            Exp.construct(~loc, {txt: Lident("true"), loc}, None),
          ),
          ...args,
        ];
      } else if (is_length(v)) {
        if (!
              List.exists(
                fun
                | (Labelled("x"), _) => true
                | _ => false,
                args,
              )) {
          [(Labelled("x"), rcv(cv)), ...args];
        } else if (!
                     List.exists(
                       fun
                       | (Labelled("y"), _) => true
                       | _ => false,
                       args,
                     )) {
          [(Labelled("y"), rcv(cv)), ...args];
        } else if (!
                     List.exists(
                       fun
                       | (Labelled("blur"), _) => true
                       | _ => false,
                       args,
                     )) {
          [(Labelled("blur"), rcv(cv)), ...args];
        } else {
          grammar_error(
            loc,
            "box-shadow cannot have more than 3 length values",
          );
        };
      } else if (is_color(v)) {
        [(Nolabel, rcv(cv)), ...args];
      } else {
        grammar_error(loc, "Unexpected box-shadow value");
      };

    let text_shadow_ident =
      Exp.ident(
        ~loc=name_loc,
        {
          txt: Ldot(Lident("Shadow"), "text"),
          loc: name_loc,
        },
      );
    let text_shadow_args = ((grouped_param, _)) =>
      List.fold_left(text_shadow_args, [], grouped_param);

    let (params, _) = d.Declaration.value;
    let grouped_params = group_params(params);
    let args =
      List.rev_map(params => text_shadow_args(params), grouped_params);
    let ident =
      Exp.ident(~loc=name_loc, {txt: Lident("textShadows"), loc: name_loc});
    let text_shadow_list =
      List.map(arg => Exp.apply(text_shadow_ident, arg), args);
    Exp.apply(
      ident,
      [(Nolabel, list_to_expr(name_loc, text_shadow_list))],
    );
  };

  /* https://developer.mozilla.org/en-US/docs/Web/CSS/transition */
  let render_transition = () => {
    let transition_ident =
      Exp.ident(
        ~loc=name_loc,
        {
          txt: Ldot(Lident("Transition"), "shorthand"),
          loc: name_loc,
        },
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
              [(Labelled("duration"), rcv(cv)), ...args];
            } else if (!
                         List.exists(
                           fun
                           | (Labelled("delay"), _) => true
                           | _ => false,
                           args,
                         )) {
              [(Labelled("delay"), rcv(cv)), ...args];
            } else {
              grammar_error(
                loc,
                "transition cannot have more than 2 time values",
              );
            };
          } else if (is_timing_function(v)) {
            [(Labelled("timingFunction"), rcv(cv)), ...args];
          } else {
            switch (v) {
            | Ident(p) => [(Nolabel, render_property(p, loc)), ...args]
            | _ => grammar_error(loc, "Unexpected transition value")
            };
          },
        [],
        grouped_param,
      );

    let (params, _) = d.Declaration.value;
    let grouped_params = group_params(params);
    let args =
      List.rev_map(params => transition_args(params), grouped_params);
    let ident =
      Exp.ident(~loc=name_loc, {txt: Lident("transitions"), loc: name_loc});
    let transition_list =
      List.map(arg => Exp.apply(transition_ident, arg), args);
    Exp.apply(ident, [(Nolabel, list_to_expr(name_loc, transition_list))]);
  };

  let render_standard_declaration = () => {
    let name = to_caml_case(name);
    let (vs, _) = d.Declaration.value;
    let ident =
      Exp.ident(~loc=name_loc, {txt: Lident(name), loc: name_loc});
    let args = List.map(v => rcv(v), vs);
    Exp.apply(~loc=d_loc, ident, List.map(a => (Nolabel, a), args));
  };

  let render_transform = () => {
    let (vs, loc) = d.Declaration.value;
    if (List.length(vs) == 1) {
      render_standard_declaration();
    } else {
      let cvs = List.rev_map(v => rcv(v), vs);
      let arg = list_to_expr(loc, cvs);
      let ident =
        Exp.ident(
          ~loc=name_loc,
          {txt: Lident("transforms"), loc: name_loc},
        );
      Exp.apply(~loc=d_loc, ident, [(Nolabel, arg)]);
    };
  };

  let render_font_family = () => {
    let (vs, loc) = d.Declaration.value;
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

        rcv((String(s), loc));
      };

      let grouped_params = group_params(vs);
      let args =
        List.rev_map(params => font_family_args(params), grouped_params);
      let ident =
        Exp.ident(
          ~loc=name_loc,
          {txt: Lident("fontFamilies"), loc: name_loc},
        );
      Exp.apply(
        ~loc=name_loc,
        ident,
        [(Nolabel, list_to_expr(name_loc, args))],
      );
  };

  let render_z_index = () => {
    let (vs, loc) = d.Declaration.value;
    let arg =
      if (List.length(vs) == 1) {
        let (v, loc) as c = List.hd(vs);
        switch (v) {
        | Ident(_) => rcv(c)
        | Number(_) =>
          let ident = Exp.ident(~loc=name_loc, {txt: Lident("int"), loc});
          Exp.apply(~loc, ident, [(Nolabel, rcv(c))]);
        | _ => grammar_error(loc, "Unexpected z-index value")
        };
      } else {
        grammar_error(loc, "z-index should have a single value");
      };

    let ident =
      Exp.ident(~loc=name_loc, {txt: Lident("zIndex"), loc: name_loc});
    Exp.apply(~loc=name_loc, ident, [(Nolabel, arg)]);
  };

  let render_flex_grow_shrink = () => {
    let name = to_caml_case(name);
    let (vs, loc) = d.Declaration.value;
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
      Exp.ident(~loc=name_loc, {txt: Lident(name), loc: name_loc});
    Exp.apply(~loc=name_loc, ident, [(Nolabel, arg)]);
  };

  let render_font_weight = () => {
    let (vs, loc) = d.Declaration.value;
    let arg =
      if (List.length(vs) == 1) {
        let (v, loc) as c = List.hd(vs);
        switch (v) {
        | Ident(_) => rcv(c)
        | Number(_) => Exp.variant(~loc, "num", Some(rcv(c)))
        | _ => grammar_error(loc, "Unexpected font-weight value")
        };
      } else {
        grammar_error(loc, "font-weight should have a single value");
      };

    let ident =
      Exp.ident(~loc=name_loc, {txt: Lident("fontWeight"), loc: name_loc});
    Exp.apply(~loc=name_loc, ident, [(Nolabel, arg)]);
  };

  let render_border_outline = () => {
    let border_outline_args = (params, _) =>
      List.fold_left(
        (args, (v, loc) as cv) =>
          if (is_line_width(v)) {
            [(Labelled("width"), rcv(cv)), ...args];
          } else if (is_line_style(v)) {
            [(Nolabel, rcv(cv)), ...args];
          } else if (is_color(v)) {
            [(Labelled("color"), rcv(cv)), ...args];
          } else {
            grammar_error(loc, "Unexpected " ++ name ++ " value");
          },
        [],
        params,
      );

    let (params, loc) = d.Declaration.value;
    let args = border_outline_args(params, loc);
    let name = to_caml_case(name) ++ "2";
    let ident =
      Exp.ident(~loc=name_loc, {txt: Lident(name), loc: name_loc});
    Exp.apply(ident, args);
  };

  let render_with_labels = labels => {
    let name = to_caml_case(name);
    let (vs, _) = d.Declaration.value;
    let parameter_count = List.length(vs);
    let name =
      if (parameter_count > 1) {
        name ++ string_of_int(parameter_count);
      } else {
        name;
      };

    let ident =
      Exp.ident(~loc=name_loc, {txt: Lident(name), loc: name_loc});
    let args = List.map(v => rcv(v), vs);
    Exp.apply(
      ~loc=d_loc,
      ident,
      List.mapi(
        (i, a) =>
          try({
            let (_, matching_label) =
              List.find(
                (((params, param), _)) =>
                  params == parameter_count && param == i,
                labels,
              );

            (Labelled(matching_label), a);
          }) {
          | Not_found => (Nolabel, a)
          },
        args,
      ),
    );
  };

  switch (name) {
  | "animation" => render_animation()
  | "box-shadow" => render_box_shadow()
  | "text-shadow" => render_text_shadow()
  | "transform" => render_transform()
  | "transition" => render_transition()
  | "font-family" => render_font_family()
  | "z-index" => render_z_index()
  | "flex-grow"
  | "flex-shrink" => render_flex_grow_shrink()
  | "font-weight" => render_font_weight()
  | "padding"
  | "margin" =>
    render_with_labels([
      ((2, 0), "v"),
      ((2, 1), "h"),
      ((3, 0), "top"),
      ((3, 1), "h"),
      ((3, 2), "bottom"),
      ((4, 0), "top"),
      ((4, 1), "right"),
      ((4, 2), "bottom"),
      ((4, 3), "left"),
    ])
  | "border-top-right-radius"
  | "border-top-left-radius"
  | "border-bottom-right-radius"
  | "border-bottom-left-radius"  =>
    render_with_labels([((2, 0), "v"), ((2, 1), "h")])
  | "background-position"
  | "transform-origin"  =>
    render_with_labels([((2, 0), "h"), ((2, 1), "v")])
  | "flex"  =>
    render_with_labels([((3, 0), "grow"), ((3, 1), "shrink")])
  | "border"
  | "outline" when List.length(fst(d.Declaration.value)) == 2 =>
    render_border_outline()
  | _ => render_standard_declaration()
  };
}
and render_declarations =
    (ds: list(Declaration_list.kind)): list(expression) =>
  List.rev_map(
    declaration =>
      switch (declaration) {
      | Declaration_list.Declaration(decl) =>
        render_declaration(decl, decl.loc)
      | Declaration_list.At_rule(ar) => render_at_rule(ar)
      },
    ds,
  )
and render_declaration_list =
    ((dl, loc): Declaration_list.t): expression => {
  let expr_with_loc_list = render_declarations(dl);
  let styles = list_to_expr(loc, expr_with_loc_list);
  let ident =
    Exp.ident(
      ~loc,
      {txt: Lident("css"), loc},
    );
  let expression = Exp.apply(~loc, ident, [(Nolabel, styles)]);

  Exp.open_(~loc, Fresh , {txt: Lident("Emotion"), loc}, expression);
}
and render_style_rule = (sr: Style_rule.t): expression => {
  let (prelude, prelude_loc) = sr.Style_rule.prelude;
  let selector =
    List.fold_left(
      (s, (value, value_loc)) =>
        switch (value) {
        | Component_value.Delim(":") => ":" ++ s
        | Ident(v)
        | Operator(v)
        | Delim(v) =>
          if (String.length(s) > 0) {
            v ++ " " ++ s;
          } else {
            v ++ s;
          }
        | _ => grammar_error(value_loc, "Unexpected selector")
        },
      "",
      List.rev(prelude),
    );
  let selector_expr = string_to_const(~loc=prelude_loc, selector);
  let dl_expr = render_declaration_list(sr.Style_rule.block);
  let lident = "selector";
  let ident =
    Exp.ident(~loc=prelude_loc, {txt: Lident(lident), loc: prelude_loc});
  Exp.apply(
    ~loc=sr.Style_rule.loc,
    ident,
    [(Nolabel, selector_expr), (Nolabel, dl_expr)],
  );
}
and render_rule = (r: Rule.t): expression =>
  switch (r) {
  | Rule.Style_rule(sr) => render_style_rule(sr)
  | Rule.At_rule(ar) => render_at_rule(ar)
  }
and render_stylesheet = ((rs, loc): Stylesheet.t): expression => {
  let rule_expr_list =
    List.rev_map(
      rule =>
        switch (rule) {
        | Rule.Style_rule({
            Style_rule.prelude: ([], _),
            block: (ds, _),
            loc: _,
          }) =>
          render_declarations(ds)
        | Rule.Style_rule(_)
        | Rule.At_rule(_) => [render_rule(rule)]
        },
      rs,
    )
    |> List.concat;
  list_to_expr(loc, rule_expr_list);
};
