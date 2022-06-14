open Ppxlib;
open Reason_css_parser;

module Helper = Ast_helper;
module Builder = Ppxlib.Ast_builder.Default;

/* helpers */
let loc = Location.none;
let txt = txt => {Location.loc: Location.none, txt};

let (let.ok) = Result.bind;

let id = Fun.id;

let render_string = string =>
  Helper.Const.string(string) |> Helper.Exp.constant;

let render_integer = integer =>
  Helper.Const.int(integer) |> Helper.Exp.constant;

let list_to_longident = vars => vars |> String.concat(".") |> Longident.parse;

let render_variable = name =>
  list_to_longident(name) |> txt |> Helper.Exp.ident;

type transform('ast, 'value) = {
  ast_of_string: string => result('ast, string),
  value_of_ast: 'ast => 'value,
  value_to_expr: 'value => list(Parsetree.expression),
  ast_to_expr: 'ast => list(Parsetree.expression),
  string_to_expr: string => result(list(Parsetree.expression), string),
};

let emit = (property, value_of_ast, value_to_expr) => {
  let ast_of_string = Parser.parse(property);
  let ast_to_expr = ast => value_of_ast(ast) |> value_to_expr;
  let string_to_expr = string =>
    ast_of_string(string) |> Result.map(ast_to_expr);

  {ast_of_string, value_of_ast, value_to_expr, ast_to_expr, string_to_expr};
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
  | `Cm(n) => render_number(n, "cm")
  | `Em(n) => render_number(n, "em")
  | `Ex(n) => render_number(n, "ex")
  | `Ic(n) => render_number(n, "ic")
  | `In(n) => render_number(n, "in")
  | `Lh(n) => render_number(n, "lh")
  | `Mm(n) => render_number(n, "mm")
  | `Pc(n) => render_number(n, "pc")
  | `Pt(n) => render_number(n, "pt")
  | `Px(n) => render_number(n, "px")
  | `Q(n) => render_number(n, "q")
  | `Rem(n) => render_number(n, "rem")
  | `Rlh(n) => render_number(n, "rlh")
  | `Vb(n) => render_number(n, "vb")
  | `Vh(n) => render_number(n, "vh")
  | `Vi(n) => render_number(n, "vi")
  | `Vmax(n) => render_number(n, "vmax")
  | `Vmin(n) => render_number(n, "vmin")
  | `Vw(n) => render_number(n, "vw")
  | `Zero => render_string("0");


let rec render_function_calc = (calc_sum) => {
  switch (calc_sum) {
    | (product, []) => render_product(product)
    | (product, list_of_sums) => {
      /* This isn't a great design of the types, but we need to know the operation
      which is in the first position of the array, we ensure that there's one value
      since we are on this branch of the switch */
      let op = pick_operation(List.hd(list_of_sums));
      let first = render_product(product);
      let second = render_list_of_sums(list_of_sums);
      [%expr "calc(" + [%e first] ++ [%e op] ++ [%e second] ++ ")"];
    }
  }
}
and render_sum_op = op => {
  switch (op) {
    | `Dash(()) => [%expr " - "]
    | `Cross(()) => [%expr " + "]
  }
}
and pick_operation = ((op, _)) => render_sum_op(op)
and render_list_of_products = (list_of_products) => {
  switch (list_of_products) {
    | [one] => render_product_op(one)
    | list => render_list_of_products(list)
  }
} and render_list_of_sums = (list_of_sums) => {
  switch (list_of_sums) {
    | [(_, one)] => render_product(one)
    | list => render_list_of_sums(list)
  }
} and render_product = product => {
  switch (product) {
    | (calc_value, []) => render_calc_value(calc_value)
    | (calc_value, list_of_products) => {
      let first = render_calc_value(calc_value);
      let second = render_list_of_products(list_of_products);
      [%expr "calc(" ++ [%e first] ++ " " ++ "*" ++ " " ++ [%e second] ++ ")"];
    }
  }
} and render_product_op = (op) => {
  switch (op) {
    | `Static_0((), calc_value) => render_calc_value(calc_value)
    | `Static_1((), float) => render_number(float, "")
  }
} and render_calc_value = calc_value => {
  switch (calc_value) {
    | `Number(float) => render_number(float, "")
    | `Extended_length(l) => render_extended_length(l)
    | `Extended_percentage(p) => render_extended_percentage(p)
    | `Function_calc(fc) => render_function_calc(fc)
  }

  }  and render_extended_length =
  fun
  | `Length(l) => render_length(l)
  | `Function_calc(fc) => render_function_calc(fc)
  | `Interpolation(i) => render_variable(i)

  and render_extended_percentage = fun
  | `Percentage(p) => render_percentage(p)
  | `Function_calc(fc) => render_function_calc(fc)
  | `Interpolation(i) => render_variable(i);

let render_length_percentage =
  fun
  | `Extended_length(length) => render_extended_length(length)
  | `Extended_percentage(percentage) => render_extended_percentage(percentage);

let render_size =
  fun
  | `Auto => variants_to_string(`Auto)
  | `Extended_length(_) as lp
  | `Extended_percentage(_) as lp => render_length_percentage(lp)
  | `Max_content => [%expr "max-content"]
  | `Min_content => [%expr "min-content"]
  | `Fit_content_0 => [%expr "fit-content"]
  | `Fit_content_1(lp) => render_length_percentage(lp)
  | `Function_calc(fc) => render_function_calc(fc)

let render_css_global_values = (name, value) => {
  let.ok value = Parser.parse(Standard.css_wide_keywords, value);

  let value =
    switch (value) {
    | `Inherit =>
      %expr
      "inherit"
    | `Initial =>
      %expr
      "initial"
    | `Unset =>
      %expr
      "unset"
    };

  /* bs-css doesn't have those */
  Ok([[%expr CssJs.unsafe([%e render_string(name)], [%e value])]]);
};

let found = ({ast_of_string, string_to_expr, _}) => {
  let check_value = string => {
    let.ok _ = ast_of_string(string);
    Ok();
  };
  (check_value, string_to_expr);
};

let transform_with_variable = (parser, mapper, value_to_expr) =>
  emit(
    Combinator.combine_xor([
      /* If the CSS value is an interpolation, we treat as one `
         ariable */
      Rule.Match.map(Standard.interpolation, data => `Variable(data)),
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

let width = apply(Parser.property_width, [%expr "width"], render_size);
let min_width =
  apply(Parser.property_width, [%expr "min-width"], render_size);

let max_width =
  apply(Parser.property_width, [%expr "max-width"], render_size);
let height = apply(Parser.property_height, [%expr "height"], render_size);
let min_height = apply(Parser.property_height, [%expr "min-height"], render_size);
let max_height = apply(Parser.property_height, [%expr "max-height"], render_size);
let aspect_ratio =
  apply(
    Parser.property_media_max_aspect_ratio,
    [%expr "aspect-ratio"],
    ((a, (), b)) => [%expr [%e string_of_int(a) |> render_string] ++ "/" ++ [%e string_of_int(b) |> render_string]]
  );
let min_aspect_ratio =
  apply(
    Parser.property_media_max_aspect_ratio,
    [%expr "min-aspect-ratio"],
    ((a, (), b)) => [%expr [%e string_of_int(a) |> render_string] ++ "/" ++ [%e string_of_int(b) |> render_string]]
  );
let max_aspect_ratio =
  apply(
    Parser.property_media_max_aspect_ratio,
    [%expr "max-aspect-ratio"],
    ((a, (), b)) => [%expr [%e string_of_int(a) |> render_string] ++ "/" ++ [%e string_of_int(b) |> render_string]]
  );
let orientation =
  apply(
    Parser.property_media_orientation,
    [%expr "orientation"],
    fun
    | `Landscape => [%expr "landscape"]
    | `Portrait => [%expr "portrait"],
  );
let grid = apply(Parser.property_media_grid, [%expr "grid"], render_integer);
let update =
  apply(
    Parser.property_media_update,
    [%expr "update"],
    fun
    | `Fast => [%expr "fast"]
    | `None => [%expr "none"]
    | `Slow => [%expr "slow"],
  );
let overflow_block =
  apply(
    Parser.property_overflow_block,
    [%expr "overflow-block"],
    fun
    | `Auto => [%expr "auto"]
    | `Clip => [%expr "clip"]
    | `Hidden => [%expr "hidden"]
    | `Scroll => [%expr "scroll"]
    | `Visible => [%expr "visible"],
  );
let overflow_inline =
  apply(
    Parser.property_overflow_inline,
    [%expr "overflow-inline"],
    fun
    | `Auto => [%expr "auto"]
    | `Clip => [%expr "clip"]
    | `Hidden => [%expr "hidden"]
    | `Paged => [%expr "paged"]
    | `Scroll => [%expr "scroll"]
    | `Visible => [%expr "visible"]
    | `Static(_) => [%expr "static"] // Why this branch exists?
  );
let color = apply(Parser.positive_integer, [%expr "color"], render_integer);
let min_color = apply(Parser.positive_integer, [%expr "min-color"], render_integer);
let max_color = apply(Parser.positive_integer, [%expr "max-color"], render_integer);

let color_gamut =
  apply(
    Parser.property_media_color_gamut,
    [%expr "color_gamut"],
    fun
    | `P3 => [%expr "p3"]
    | `Rec2020 => [%expr "Rec2020"]
    | `Srgb => [%expr "Srgb"],
  );
let display_mode =
  apply(
    Parser.property_media_display_mode,
    [%expr "display-mode"],
    fun
    | `Browser => [%expr "browser"]
    | `Fullscreen => [%expr "fullscreen"]
    | `Minimal_ui => [%expr "minimal-ui"]
    | `Standalone => [%expr "standalone"],
  );
let monochrome =
  apply(
    Parser.property_media_monochrome,
    [%expr "monochrome"],
    render_integer,
  );

let min_monochrome =
  apply(
    Parser.property_media_monochrome,
    [%expr "min-monochrome"],
    render_integer,
  );

let max_monochrome =
  apply(
    Parser.property_media_monochrome,
    [%expr "max-monochrome"],
    render_integer,
  );
let inverted_colors =
  apply(
    Parser.property_media_inverted_colors,
    [%expr "inverted-colors"],
    fun
    | `Inverted => [%expr "Inverted"]
    | `None => [%expr "none"],
  );
let pointer =
  apply(
    Parser.property_media_pointer,
    [%expr "pointer"],
    fun
    | `Coarse => [%expr "coarse"]
    | `Fine => [%expr "fine"]
    | `None => [%expr "none"],
  );
let hover =
  apply(
    Parser.property_media_hover,
    [%expr "hover"],
    fun
    | `Hover => [%expr "hover"]
    | `None => [%expr "none"],
  );
let any_pointer =
  apply(
    Parser.property_media_any_pointer,
    [%expr "any_pointer"],
    fun
    | `Coarse => [%expr "coarse"]
    | `Fine => [%expr "fine"]
    | `None => [%expr "none"],
  );
let any_hover =
  apply(
    Parser.property_media_any_hover,
    [%expr "any_hover"],
    fun
    | `Hover => [%expr "hover"]
    | `None => [%expr "none"],
  );
let scripting =
  apply(
    Parser.property_media_scripting,
    [%expr "scripting"],
    fun
    | `Enabled => [%expr "enabled"]
    | `Initial_only => [%expr "initial-only"]
    | `None => [%expr "none"],
  );

let resolution =
  apply(
    Parser.property_media_resolution,
    [%expr "resolution"],
    fun
    | `Dpcm(v) => render_number(v, "dpcm")
    | `Dpi(v) => render_number(v, "dpi")
    | `Dppx(v) => render_number(v, "dppx"),
  );

let max_resolution =
  apply(
    Parser.property_media_resolution,
    [%expr "min-resolution"],
    fun
    | `Dpcm(v) => render_number(v, "dpcm")
    | `Dpi(v) => render_number(v, "dpi")
    | `Dppx(v) => render_number(v, "dppx"),
  );
let min_resolution =
  apply(
    Parser.property_media_resolution,
    [%expr "max-resolution"],
    fun
    | `Dpcm(v) => render_number(v, "dpcm")
    | `Dpi(v) => render_number(v, "dpi")
    | `Dppx(v) => render_number(v, "dppx"),
  );
let color_index =
  apply(
    Parser.property_media_color_index,
    [%expr "color-index"],
    render_integer,
  );
let min_color_index =
  apply(
    Parser.property_media_color_index,
    [%expr "min-color-index"],
    render_integer,
  );
let max_color_index =
  apply(
    Parser.property_media_color_index,
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
    | None => Error(`Not_found)
    };

  expr_of_string(value) |> Result.map_error(str => `Invalid_value(str));
};

let parse_declarations = (property: string, value: string) => {
  let.ok _ =
    Parser.check_property(~name=property, value)
    |> Result.map_error((`Unknown_value) => `Not_found);

  switch (render_css_global_values(property, value)) {
  | Ok(value) => Ok(value)
  | Error(_) => render_to_expr(property, value)
  };
};
