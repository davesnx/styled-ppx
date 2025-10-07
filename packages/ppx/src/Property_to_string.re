open Css_grammar_parser;

module Helper = Ppxlib.Ast_helper;
module Builder = Ppxlib.Ast_builder.Default;
module Property_parser = Css_grammar_parser.Parser;

exception Invalid_value(string);

let loc = Ppxlib.Location.none;
let txt = txt => {
  Ppxlib.Location.loc: Ppxlib.Location.none,
  txt,
};

let (let.ok) = Result.bind;

let id = Fun.id;

let render_string = string =>
  Helper.Const.string(string) |> Helper.Exp.constant;

let render_integer = integer =>
  Helper.Const.int(integer) |> Helper.Exp.constant;

let list_to_longident = vars =>
  vars |> String.concat(".") |> Ppxlib.Longident.parse;

let render_variable = name =>
  list_to_longident(name) |> txt |> Helper.Exp.ident;

type transform('ast, 'value) = {
  ast_of_string: string => result('ast, string),
  string_to_expr:
    string => result(list(Ppxlib.Parsetree.expression), string),
};

let emit = (property, value_of_ast, value_to_expr) => {
  let ast_of_string = Parser.parse(property);
  let ast_to_expr = ast => value_of_ast(ast) |> value_to_expr;
  let string_to_expr = string =>
    ast_of_string(string) |> Result.map(ast_to_expr);

  {
    ast_of_string,
    string_to_expr,
  };
};

let variants_to_string =
  fun
  | `Row => id([%expr "row"])
  | `Row_reverse => id([%expr "row-reverse"])
  | `Column => id([%expr "column"])
  | `Column_reverse => id([%expr "column-reverse"])
  | `Nowrap => id([%expr "nowrap"])
  | `Wrap => id([%expr "wrap"])
  | `Wrap_reverse => id([%expr "wrap-reverse"])
  | `Content => id([%expr "content"])
  | `Flex_start => id([%expr "flex-start"])
  | `Flex_end => id([%expr "flex-end"])
  | `Center => id([%expr "center"])
  | `Space_between => id([%expr "space-between"])
  | `Space_around => id([%expr "space-around"])
  | `Baseline => id([%expr "baseline"])
  | `Stretch => id([%expr "strecth"])
  | `Auto => id([%expr "auto"])
  | `None => id([%expr "none"])
  | `Content_box => id([%expr "content-box"])
  | `Border_box => id([%expr "border-box"])
  | `Clip => id([%expr "clip"])
  | `Hidden => id([%expr "hidden"])
  | `Visible => id([%expr "visible"])
  | `Scroll => id([%expr "scroll"])
  | `Ellipsis => id([%expr "ellipsis"])
  | `Capitalize => id([%expr "capitalize"])
  | `Lowercase => id([%expr "lowercase"])
  | `Uppercase => id([%expr "uppercase"])
  | `Break_spaces => id([%expr "break-spaces"])
  | `Normal => id([%expr "normal"])
  | `Break_all => id([%expr "break-all"])
  | `Break_word => id([%expr "break-word"])
  | `Keep_all => id([%expr "keep-all"])
  | `Anywhere => id([%expr "anywhere"])
  | `BreakWord => id([%expr "breakword"])
  | `End => id([%expr "end"])
  | `Justify => id([%expr "justify"])
  | `Left => id([%expr "left"])
  | `Match_parent => id([%expr "match-parent"])
  | `Right => id([%expr "right"])
  | `Start => id([%expr "start"])
  | `Transparent => id([%expr "transparent"])
  | `Bottom => id([%expr "bottom"])
  | `Top => id([%expr "top"])
  | `Fill => id([%expr "fill"])
  | `Dotted => id([%expr "dotted"])
  | `Dashed => id([%expr "dashlet"])
  | `Solid => id([%expr "solid"])
  | `Double => id([%expr "double"])
  | `Groove => id([%expr "groove"])
  | `Ridge => id([%expr "ridge"])
  | `Inset => id([%expr "inset"])
  | `Outset => id([%expr "outset"])
  | `Contain => id([%expr "contain"])
  | `Scale_down => id([%expr "scale-down"])
  | `Cover => id([%expr "cover"])
  | `Full_width => [%expr "full-width"]
  | `Unset => id([%expr "unset"])
  | `Full_size_kana => id([%expr "full-size-kana"]);
let render_number = (number, unit) =>
  string_of_int(Float.to_int(number)) ++ unit |> render_string;
let render_percentage = percentage =>
  string_of_int(Float.to_int(percentage)) ++ "%" |> render_string;
let render_length =
  fun
  | `Cap(n) => render_number(n, "cap")
  | `Ch(n) => render_number(n, "cm")
  | `Em(n) => render_number(n, "em")
  | `Ex(n) => render_number(n, "ex")
  | `Ic(n) => render_number(n, "ic")
  | `Lh(n) => render_number(n, "lh")

  | `Rcap(n) => render_number(n, "rcap")
  | `Rch(n) => render_number(n, "rch")
  | `Rem(n) => render_number(n, "rem")
  | `Rex(n) => render_number(n, "rex")
  | `Ric(n) => render_number(n, "ric")
  | `Rlh(n) => render_number(n, "rlh")

  | `Vh(n) => render_number(n, "vh")
  | `Vw(n) => render_number(n, "vw")
  | `Vmax(n) => render_number(n, "vmax")
  | `Vmin(n) => render_number(n, "vmin")
  | `Vb(n) => render_number(n, "vb")
  | `Vi(n) => render_number(n, "vi")

  | `Cqw(n) => render_number(n, "cqw")
  | `Cqh(n) => render_number(n, "cqh")
  | `Cqi(n) => render_number(n, "cqi")
  | `Cqb(n) => render_number(n, "cqb")
  | `Cqmin(n) => render_number(n, "cqmin")
  | `Cqmax(n) => render_number(n, "cqmax")

  | `Px(n) => render_number(n, "px")
  | `Cm(n) => render_number(n, "cm")
  | `Mm(n) => render_number(n, "mm")
  | `Q(n) => render_number(n, "q")
  | `In(n) => render_number(n, "in")
  | `Pc(n) => render_number(n, "pc")
  | `Pt(n) => render_number(n, "pt")

  | `Zero => render_string("0");

let rec render_function_calc = (calc_sum: Property_parser.Calc_sum.t) => {
  [%expr "calc(" ++ [%e render_calc_sum(calc_sum)] ++ ")"];
}
and render_calc_sum = ((product, sums)) => {
  let rec go = (left, rest) => {
    switch (rest) {
    | [] => left
    | [x, ...xs] =>
      switch (x) {
      | (`Cross, calc_product) =>
        go(
          [%expr [%e left] ++ " + " ++ [%e render_product(calc_product)]],
          xs,
        )
      | (`Dash, calc_product) =>
        go(
          [%expr [%e left] ++ " - " ++ [%e render_product(calc_product)]],
          xs,
        )
      }
    };
  };
  go(render_product(product), sums);
}
and render_function_min_or_max = calc_sums => {
  switch (calc_sums) {
  | [] => raise(Invalid_value("expected at least one argument"))
  | [x, ...xs] =>
    let calc_sums = [x] |> List.append(xs |> List.map(x => x)) |> List.rev;
    calc_sums |> List.map(v => render_calc_sum(v)) |> Helper.Exp.array;
  };
}
and render_function_min = calc_sums => {
  render_function_min_or_max(calc_sums);
}
and render_function_max = calc_sums => {
  render_function_min_or_max(calc_sums);
}
and render_product = ((value, products)) => {
  let rec go = (left, rest) => {
    switch (rest) {
    | [] => left
    | [x, ...xs] =>
      switch (x) {
      | `Static_0(_, value) =>
        go([%expr [%e left] ++ " * " ++ [%e render_calc_value(value)]], xs)
      | `Static_1(_, float_value) =>
        go(
          [%expr [%e left] ++ " / " ++ [%e render_number(float_value, "")]],
          xs,
        )
      }
    };
  };
  go(render_calc_value(value), products);
}
and render_calc_value = calc_value => {
  switch (calc_value) {
  | `Number(float) => render_number(float, "")
  | `Extended_length(l) => render_extended_length(l)
  | `Extended_percentage(p) => render_extended_percentage(p)
  | `Extended_angle(a) => render_extended_angle(a)
  | `Extended_time(t) => render_extended_time(t)
  | `Static(_, calc_sum, _) => render_calc_sum(calc_sum)
  };
}
and render_time_as_int =
  fun
  | `Ms(f) => {
      let value = Float.to_int(f);
      render_integer(value);
    }
  | `S(f) => {
      let value = Float.to_int(f);
      render_integer(value);
    }

and render_extended_time =
  fun
  | `Time(t) => render_time_as_int(t)
  | `Function_calc(fc) => render_function_calc(fc)
  | `Interpolation(v) => render_variable(v)
  | `Function_min(values) => render_function_min(values)
  | `Function_max(values) => render_function_max(values)

and render_angle =
  fun
  | `Deg(number)
  | `Rad(number)
  | `Grad(number)
  | `Turn(number) => render_number(number, "")

and render_extended_angle =
  fun
  | `Angle(a) => render_angle(a)
  | `Function_calc(fc) => render_function_calc(fc)
  | `Interpolation(i) => render_variable(i)
  | `Function_min(values) => render_function_min(values)
  | `Function_max(values) => render_function_max(values)

and render_extended_length =
  fun
  | `Length(l) => render_length(l)
  | `Function_calc(fc) => render_function_calc(fc)
  | `Function_min(values) => render_function_min(values)
  | `Function_max(values) => render_function_max(values)
  | `Interpolation(i) => render_variable(i)

and render_extended_percentage =
  fun
  | `Percentage(p) => render_percentage(p)
  | `Function_calc(fc) => render_function_calc(fc)
  | `Interpolation(i) => render_variable(i)
  | `Function_min(values) => render_function_min(values)
  | `Function_max(values) => render_function_max(values);

let render_length_percentage =
  fun
  | `Extended_length(length) => render_extended_length(length)
  | `Extended_percentage(percentage) =>
    render_extended_percentage(percentage);

let render_size =
  fun
  | `Auto => variants_to_string(`Auto)
  | `Extended_length(_) as lp
  | `Extended_percentage(_) as lp => render_length_percentage(lp)
  | `Max_content => [%expr "max-content"]
  | `Min_content => [%expr "min-content"]
  | `Fit_content_0 => [%expr "fit-content"]
  | `Fit_content_1(lp) => render_length_percentage(lp);

let found = ({ast_of_string, string_to_expr, _}) => {
  let check_value = string => {
    let.ok _ = ast_of_string(string);
    Ok();
  };
  (check_value, string_to_expr);
};

let transform_with_variable = (parser, mapper, value_to_expr) =>
  emit(
    Combinators.xor([
      /* If the CSS value is an interpolation, we treat as one `
         ariable */
      Rule.Match.map(Standard.Interpolation.parser, data => `Variable(data)),
      /* Otherwise it's a regular CSS `Value */
      Rule.Match.map(parser, data => `Value(data)),
    ]),
    fun
    | `Variable(name) => render_variable(name)
    | `Value(ast) => mapper(ast),
    value_to_expr,
  );

let apply = (parser, id, map) =>
  transform_with_variable(parser, map, arg =>
    [[%expr "(" ++ [%e id] ++ ": " ++ [%e arg] ++ ") "]]
  );

let width =
  apply(Property_parser.Property_width.parser, [%expr "width"], render_size);
let min_width =
  apply(
    Property_parser.Property_width.parser,
    [%expr "min-width"],
    render_size,
  );

let max_width =
  apply(
    Property_parser.Property_width.parser,
    [%expr "max-width"],
    render_size,
  );
let height =
  apply(
    Property_parser.Property_height.parser,
    [%expr "height"],
    render_size,
  );
let min_height =
  apply(
    Property_parser.Property_height.parser,
    [%expr "min-height"],
    render_size,
  );
let max_height =
  apply(
    Property_parser.Property_height.parser,
    [%expr "max-height"],
    render_size,
  );

let render_ratio =
  fun
  | `Static(a, (), b) => [%expr
      [%e string_of_int(a) |> render_string]
      ++ " / "
      ++ [%e string_of_int(b) |> render_string]
    ]
  | `Number(i) => [%expr [%e string_of_float(i) |> render_string]]
  | `Interpolation(v) => render_variable(v);

let aspect_ratio =
  apply(
    Parser.Property_media_max_aspect_ratio.parser,
    [%expr "aspect-ratio"],
    render_ratio,
  );
let min_aspect_ratio =
  apply(
    Parser.Property_media_max_aspect_ratio.parser,
    [%expr "min-aspect-ratio"],
    render_ratio,
  );
let max_aspect_ratio =
  apply(
    Parser.Property_media_max_aspect_ratio.parser,
    [%expr "max-aspect-ratio"],
    render_ratio,
  );
let orientation =
  apply(
    Parser.Property_media_orientation.parser,
    [%expr "orientation"],
    fun
    | `Landscape => [%expr "landscape"]
    | `Portrait => [%expr "portrait"],
  );
let grid =
  apply(Parser.Property_media_grid.parser, [%expr "grid"], render_integer);
let update =
  apply(
    Parser.Property_media_update.parser,
    [%expr "update"],
    fun
    | `Fast => [%expr "fast"]
    | `None => [%expr "none"]
    | `Slow => [%expr "slow"],
  );
let overflow_block =
  apply(
    Parser.Property_overflow_block.parser,
    [%expr "overflow-block"],
    fun
    | `Auto => [%expr "auto"]
    | `Clip => [%expr "clip"]
    | `Hidden => [%expr "hidden"]
    | `Scroll => [%expr "scroll"]
    | `Visible => [%expr "visible"]
    | `Interpolation(i) => render_variable(i),
  );

let overflow_inline =
  apply(
    Parser.Property_overflow_inline.parser,
    [%expr "overflow-inline"],
    fun
    | `Auto => [%expr "auto"]
    | `Clip => [%expr "clip"]
    | `Hidden => [%expr "hidden"]
    | `Scroll => [%expr "scroll"]
    | `Visible => [%expr "visible"]
    | `Interpolation(i) => render_variable(i),
  );

let color =
  apply(Parser.Positive_integer.parser, [%expr "color"], render_integer);
let min_color =
  apply(Parser.Positive_integer.parser, [%expr "min-color"], render_integer);
let max_color =
  apply(Parser.Positive_integer.parser, [%expr "max-color"], render_integer);

let color_gamut =
  apply(
    Parser.Property_media_color_gamut.parser,
    [%expr "color_gamut"],
    fun
    | `P3 => [%expr "p3"]
    | `Rec2020 => [%expr "Rec2020"]
    | `Srgb => [%expr "Srgb"],
  );
let display_mode =
  apply(
    Parser.Property_media_display_mode.parser,
    [%expr "display-mode"],
    fun
    | `Browser => [%expr "browser"]
    | `Fullscreen => [%expr "fullscreen"]
    | `Minimal_ui => [%expr "minimal-ui"]
    | `Standalone => [%expr "standalone"],
  );
let monochrome =
  apply(
    Parser.Property_media_monochrome.parser,
    [%expr "monochrome"],
    render_integer,
  );

let min_monochrome =
  apply(
    Parser.Property_media_monochrome.parser,
    [%expr "min-monochrome"],
    render_integer,
  );

let max_monochrome =
  apply(
    Parser.Property_media_monochrome.parser,
    [%expr "max-monochrome"],
    render_integer,
  );
let inverted_colors =
  apply(
    Parser.Property_media_inverted_colors.parser,
    [%expr "inverted-colors"],
    fun
    | `Inverted => [%expr "Inverted"]
    | `None => [%expr "none"],
  );
let pointer =
  apply(
    Parser.Property_media_pointer.parser,
    [%expr "pointer"],
    fun
    | `Coarse => [%expr "coarse"]
    | `Fine => [%expr "fine"]
    | `None => [%expr "none"],
  );
let hover =
  apply(
    Parser.Property_media_hover.parser,
    [%expr "hover"],
    fun
    | `Hover => [%expr "hover"]
    | `None => [%expr "none"],
  );
let any_pointer =
  apply(
    Parser.Property_media_any_pointer.parser,
    [%expr "any_pointer"],
    fun
    | `Coarse => [%expr "coarse"]
    | `Fine => [%expr "fine"]
    | `None => [%expr "none"],
  );
let any_hover =
  apply(
    Parser.Property_media_any_hover.parser,
    [%expr "any_hover"],
    fun
    | `Hover => [%expr "hover"]
    | `None => [%expr "none"],
  );
let scripting =
  apply(
    Parser.Property_media_scripting.parser,
    [%expr "scripting"],
    fun
    | `Enabled => [%expr "enabled"]
    | `Initial_only => [%expr "initial-only"]
    | `None => [%expr "none"],
  );

let resolution =
  apply(
    Parser.Property_media_resolution.parser,
    [%expr "resolution"],
    fun
    | `Dpcm(v) => render_number(v, "dpcm")
    | `Dpi(v) => render_number(v, "dpi")
    | `Dppx(v) => render_number(v, "dppx"),
  );

let max_resolution =
  apply(
    Parser.Property_media_resolution.parser,
    [%expr "min-resolution"],
    fun
    | `Dpcm(v) => render_number(v, "dpcm")
    | `Dpi(v) => render_number(v, "dpi")
    | `Dppx(v) => render_number(v, "dppx"),
  );
let min_resolution =
  apply(
    Parser.Property_media_resolution.parser,
    [%expr "max-resolution"],
    fun
    | `Dpcm(v) => render_number(v, "dpcm")
    | `Dpi(v) => render_number(v, "dpi")
    | `Dppx(v) => render_number(v, "dppx"),
  );
let color_index =
  apply(
    Parser.Property_media_color_index.parser,
    [%expr "color-index"],
    render_integer,
  );
let min_color_index =
  apply(
    Parser.Property_media_color_index.parser,
    [%expr "min-color-index"],
    render_integer,
  );
let max_color_index =
  apply(
    Parser.Property_media_color_index.parser,
    [%expr "max-color-index"],
    render_integer,
  );

let properties = [
  ("width", found(width)),
  ("min-width", found(min_width)),
  ("max-width", found(max_width)),
  ("height", found(height)),
  ("min-height", found(min_height)),
  ("max-height", found(max_height)),
  ("aspect-ratio", found(aspect_ratio)),
  ("min-aspect-ratio", found(min_aspect_ratio)),
  ("max-aspect-ratio", found(max_aspect_ratio)),
  ("orientation", found(orientation)),
  ("resolution", found(resolution)),
  ("min-resolution", found(min_resolution)),
  ("max-resolution", found(max_resolution)),
  ("grid", found(grid)),
  ("update", found(update)),
  ("overflow-block", found(overflow_block)),
  ("overflow-inline", found(overflow_inline)),
  ("color", found(color)),
  ("min_color", found(min_color)),
  ("max_color", found(max_color)),
  ("color-gamut", found(color_gamut)),
  ("color-index", found(color_index)),
  ("min_color-index", found(min_color_index)),
  ("max_color-index", found(max_color_index)),
  ("display-mode", found(display_mode)), // display-mode
  ("monochrome", found(monochrome)),
  ("min-monochrome", found(min_monochrome)),
  ("max-monochrome", found(max_monochrome)),
  ("inverted-colors", found(inverted_colors)),
  ("pointer", found(pointer)),
  ("hover", found(hover)),
  ("any-pointer", found(any_pointer)),
  ("any-hover", found(any_hover)),
  ("scripting", found(scripting)),
];

let findProperty = name => {
  properties |> List.find_opt(((key, _)) => key == name);
};

let render_to_expr = (property, value) => {
  let.ok expr_of_string =
    switch (findProperty(property)) {
    | Some((_, (_, expr_of_string))) => Ok(expr_of_string)
    | None => Error(`Property_not_found)
    };

  expr_of_string(value) |> Result.map_error(str => `Invalid_value(str));
};

let parse_declarations = (property: string, value: string) => {
  switch (value) {
  | "inherit"
  | "initial"
  | "unset"
  | "revert"
  | "revert-layer" =>
    let unsafe = [%expr
      CSS.unsafe([%e render_string(property)], [%e render_string(value)])
    ];
    Ok([unsafe]);
  | _ =>
    switch (Parser.check_property(~loc, ~name=property, value)) {
    | Ok () =>
      switch (render_to_expr(property, value)) {
      | Ok(value) => Ok(value)
      | Error(error) => Error(error)
      }
    | Error((_loc, error)) => Error(error)
    }
  };
};
