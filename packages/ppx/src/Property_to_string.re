module Helper = Ppxlib.Ast_helper;
module Builder = Ppxlib.Ast_builder.Default;
module Parser = Css_grammar.Parser;
module Standard = Css_grammar.Standard;

exception Invalid_value(string);

let loc = Ppxlib.Location.none;

let render_string = string =>
  string |> Helper.Const.string |> Helper.Exp.constant;

let render_integer = integer =>
  integer |> Helper.Const.int |> Helper.Exp.constant;

let list_to_longident = vars =>
  vars |> String.concat(".") |> Ppxlib.Longident.parse;

let render_variable = name =>
  Helper.Exp.ident({
    loc,
    txt: list_to_longident(name),
  });

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

let rec render_function_calc = calc_sum => {
  [%expr "calc(" ++ [%e render_calc_sum(calc_sum)] ++ ")"];
}
and render_calc_sum = ((product, sums)) => {
  let rec go = (left, rest) => {
    switch (rest) {
    | [] => left
    | [x, ...xs] =>
      switch (x) {
      | (`Cross (), calc_product) =>
        go(
          [%expr [%e left] ++ " + " ++ [%e render_product(calc_product)]],
          xs,
        )
      | (`Dash (), calc_product) =>
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

and render_angle = (value: Parser.angle) =>
  switch (value) {
  | `Deg(number)
  | `Rad(number)
  | `Grad(number)
  | `Turn(number) => render_number(number, "")
  }
and render_extended_angle = (value: Parser.extended_angle) =>
  switch (value) {
  | `Angle(a) => render_angle(a)
  | `Function_calc(fc) => render_function_calc(fc)
  | `Interpolation(i) => render_variable(i)
  | `Function_min(values) => render_function_min(values)
  | `Function_max(values) => render_function_max(values)
  }
and render_extended_length = (value: Parser.extended_length) =>
  switch (value) {
  | `Length(l) => render_length(l)
  | `Function_calc(fc) => render_function_calc(fc)
  | `Function_min(values) => render_function_min(values)
  | `Function_max(values) => render_function_max(values)
  | `Interpolation(i) => render_variable(i)
  }

and render_extended_percentage = (value: Parser.extended_percentage) =>
  switch (value) {
  | `Percentage(p) => render_percentage(p)
  | `Function_calc(fc) => render_function_calc(fc)
  | `Interpolation(i) => render_variable(i)
  | `Function_min(values) => render_function_min(values)
  | `Function_max(values) => render_function_max(values)
  };

let render_length_percentage = (value: Parser.length_percentage) =>
  switch (value) {
  | `Extended_length(length) => render_extended_length(length)
  | `Extended_percentage(percentage) =>
    render_extended_percentage(percentage)
  };

let render_size = (value: Parser.property_width) =>
  switch (value) {
  | `Auto => [%expr "auto"]
  | `Extended_length(_) as lp => render_length_percentage(lp)
  | `Extended_percentage(_) as lp => render_length_percentage(lp)
  | `Max_content => [%expr "max-content"]
  | `Min_content => [%expr "min-content"]
  | `Fit_content_0 => [%expr "fit-content"]
  | `Fit_content_1(lp) => render_length_percentage(lp)
  };

let transform_with_variable = (parser, mapper, value_to_expr, string) => {
  Css_grammar.(
    Parser.parse(
      Combinators.xor([
        /* If the CSS value is an interpolation */
        Rule.Match.map(Standard.interpolation, data => `Interpolation(data)),
        /* Otherwise it's a regular CSS `Value */
        Rule.Match.map(parser, data => `Value(data)),
      ]),
      string,
    )
    |> Result.map(ast =>
         switch (ast) {
         | `Interpolation(name) => render_variable(name) |> value_to_expr
         | `Value(ast) => mapper(ast) |> value_to_expr
         }
       )
  );
};

let transform = (parser, id, map) =>
  transform_with_variable(parser, map, arg =>
    [[%expr "(" ++ [%e id] ++ ": " ++ [%e arg] ++ ") "]]
  );

let width =
  transform(Parser.property_width, [%expr "width"], render_size);
let min_width =
  transform(Parser.property_width, [%expr "min-width"], render_size);

let max_width =
  transform(Parser.property_width, [%expr "max-width"], render_size);
let height =
  transform(Parser.property_height, [%expr "height"], render_size);
let min_height =
  transform(Parser.property_height, [%expr "min-height"], render_size);
let max_height =
  transform(Parser.property_height, [%expr "max-height"], render_size);

let render_ratio_inner =
  fun
  | `Static(a, (), b) => [%expr
      [%e string_of_int(a) |> render_string]
      ++ " / "
      ++ [%e string_of_int(b) |> render_string]
    ]
  | `Number(i) => [%expr [%e string_of_float(i) |> render_string]]
  | `Interpolation(v) => render_variable(v);

let render_aspect_ratio = (value: Parser.property_aspect_ratio) =>
  switch (value) {
  | `Auto => render_string("auto")
  | `Ratio(r) => render_ratio_inner(r)
  };

let aspect_ratio =
  transform(
    Parser.property_aspect_ratio,
    [%expr "aspect-ratio"],
    render_aspect_ratio,
  );
let min_aspect_ratio =
  transform(
    Parser.property_aspect_ratio,
    [%expr "min-aspect-ratio"],
    render_aspect_ratio,
  );
let max_aspect_ratio =
  transform(
    Parser.property_aspect_ratio,
    [%expr "max-aspect-ratio"],
    render_aspect_ratio,
  );
let orientation =
  transform(
    Parser.property_media_orientation,
    [%expr "orientation"],
    fun
    | `Landscape => [%expr "landscape"]
    | `Portrait => [%expr "portrait"],
  );
let grid =
  transform(Parser.property_media_grid, [%expr "grid"], render_integer);
let update =
  transform(
    Parser.property_media_update,
    [%expr "update"],
    fun
    | `Fast => [%expr "fast"]
    | `None => [%expr "none"]
    | `Slow => [%expr "slow"],
  );
let overflow_block =
  transform(
    Parser.property_overflow_block,
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
  transform(
    Parser.property_overflow_inline,
    [%expr "overflow-inline"],
    fun
    | `Auto => [%expr "auto"]
    | `Clip => [%expr "clip"]
    | `Hidden => [%expr "hidden"]
    | `Scroll => [%expr "scroll"]
    | `Visible => [%expr "visible"]
    | `Interpolation(i) => render_variable(i),
  );

/* TODO: is this correct? Positive_integer??? */
let color =
  transform(Standard.positive_integer, [%expr "color"], render_integer);
let min_color =
  transform(Standard.positive_integer, [%expr "min-color"], render_integer);
let max_color =
  transform(Standard.positive_integer, [%expr "max-color"], render_integer);

let color_gamut =
  transform(
    Parser.property_media_color_gamut,
    [%expr "color_gamut"],
    fun
    | `P3 => [%expr "p3"]
    | `Rec2020 => [%expr "Rec2020"]
    | `Srgb => [%expr "Srgb"],
  );
let display_mode =
  transform(
    Parser.property_media_display_mode,
    [%expr "display-mode"],
    fun
    | `Browser => [%expr "browser"]
    | `Fullscreen => [%expr "fullscreen"]
    | `Minimal_ui => [%expr "minimal-ui"]
    | `Standalone => [%expr "standalone"],
  );
let monochrome =
  transform(
    Parser.property_media_monochrome,
    [%expr "monochrome"],
    render_integer,
  );

let min_monochrome =
  transform(
    Parser.property_media_monochrome,
    [%expr "min-monochrome"],
    render_integer,
  );

let max_monochrome =
  transform(
    Parser.property_media_monochrome,
    [%expr "max-monochrome"],
    render_integer,
  );
let inverted_colors =
  transform(
    Parser.property_media_inverted_colors,
    [%expr "inverted-colors"],
    fun
    | `Inverted => [%expr "Inverted"]
    | `None => [%expr "none"],
  );
let pointer =
  transform(
    Parser.property_media_pointer,
    [%expr "pointer"],
    fun
    | `Coarse => [%expr "coarse"]
    | `Fine => [%expr "fine"]
    | `None => [%expr "none"],
  );
let hover =
  transform(
    Parser.property_media_hover,
    [%expr "hover"],
    fun
    | `Hover => [%expr "hover"]
    | `None => [%expr "none"],
  );
let any_pointer =
  transform(
    Parser.property_media_any_pointer,
    [%expr "any_pointer"],
    fun
    | `Coarse => [%expr "coarse"]
    | `Fine => [%expr "fine"]
    | `None => [%expr "none"],
  );
let any_hover =
  transform(
    Parser.property_media_any_hover,
    [%expr "any_hover"],
    fun
    | `Hover => [%expr "hover"]
    | `None => [%expr "none"],
  );
let scripting =
  transform(
    Parser.property_media_scripting,
    [%expr "scripting"],
    fun
    | `Enabled => [%expr "enabled"]
    | `Initial_only => [%expr "initial-only"]
    | `None => [%expr "none"],
  );

let resolution =
  transform(
    Parser.property_media_resolution,
    [%expr "resolution"],
    fun
    | `Dpcm(v) => render_number(v, "dpcm")
    | `Dpi(v) => render_number(v, "dpi")
    | `Dppx(v) => render_number(v, "dppx"),
  );

let max_resolution =
  transform(
    Parser.property_media_min_resolution,
    [%expr "min-resolution"],
    fun
    | `Dpcm(v) => render_number(v, "dpcm")
    | `Dpi(v) => render_number(v, "dpi")
    | `Dppx(v) => render_number(v, "dppx"),
  );

let min_resolution =
  transform(
    Parser.property_media_max_resolution,
    [%expr "max-resolution"],
    fun
    | `Dpcm(v) => render_number(v, "dpcm")
    | `Dpi(v) => render_number(v, "dpi")
    | `Dppx(v) => render_number(v, "dppx"),
  );

let color_index =
  transform(
    Parser.property_media_color_index,
    [%expr "color-index"],
    render_integer,
  );
let min_color_index =
  transform(
    Parser.property_media_min_color_index,
    [%expr "min-color-index"],
    render_integer,
  );
let max_color_index =
  transform(
    Parser.property_media_color_index,
    [%expr "max-color-index"],
    render_integer,
  );

let properties = [
  ("width", width),
  ("min-width", min_width),
  ("max-width", max_width),
  ("height", height),
  ("min-height", min_height),
  ("max-height", max_height),
  ("aspect-ratio", aspect_ratio),
  ("min-aspect-ratio", min_aspect_ratio),
  ("max-aspect-ratio", max_aspect_ratio),
  ("orientation", orientation),
  ("resolution", resolution),
  ("min-resolution", min_resolution),
  ("max-resolution", max_resolution),
  ("grid", grid),
  ("update", update),
  ("overflow-block", overflow_block),
  ("overflow-inline", overflow_inline),
  ("color", color),
  ("min_color", min_color),
  ("max_color", max_color),
  ("color-gamut", color_gamut),
  ("color-index", color_index),
  ("min_color-index", min_color_index),
  ("max_color-index", max_color_index),
  ("display-mode", display_mode), // display-mode
  ("monochrome", monochrome),
  ("min-monochrome", min_monochrome),
  ("max-monochrome", max_monochrome),
  ("inverted-colors", inverted_colors),
  ("pointer", pointer),
  ("hover", hover),
  ("any-pointer", any_pointer),
  ("any-hover", any_hover),
  ("scripting", scripting),
];

let findProperty = name => {
  properties |> List.find_opt(((key, _)) => key == name);
};

let render_to_expr = (property, value) => {
  switch (findProperty(property)) {
  | None => Error(`Property_not_found)
  | Some((_, transform)) =>
    switch (transform(value)) {
    | Ok(v) => Ok(v)
    | Error(str) => Error(`Invalid_value(str))
    }
  };
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
