open Ppxlib;
open Reason_css_parser;

module Helper = Ast_helper;
module Builder = Ppxlib.Ast_builder.Default;
module Types = Parser.Types;

module Option = {
  include Option;

  let mapWithDefault = (f, default, opt) => {
    switch (opt) {
    | Some(x) => f(x)
    | None => default
    };
  };
};

let txt = (~loc, txt) => {Location.loc, txt};

let (let.ok) = Result.bind;

/* TODO: Separate unsupported_feature from bs-css doesn't support or can't interpolate on those */
/* TODO: Add payload on those exception, maybe move to Result. */
exception Unsupported_feature;

let id = Fun.id;

/* Why this type contains so much when only `string_to_expr` is used? */
type transform('ast, 'value) = {
  ast_of_string: string => result('ast, string),
  value_of_ast: (~loc: Location.t, 'ast) => 'value,
  ast_to_expr: (~loc: Location.t, 'ast) => list(Parsetree.expression),
  string_to_expr:
    (~loc: Location.t, string) => result(list(Parsetree.expression), string),
};

let add_CssJs_rule_constraint = (~loc, expr) => {
  let typ =
    Helper.Typ.constr(~loc, {txt: Ldot(Lident("CssJs"), "rule"), loc}, []);
  Helper.Exp.constraint_(~loc, expr, typ);
};

/* TODO: emit is better to keep value_of_ast and value_to_expr in the same fn */
let emit = (property, value_of_ast, value_to_expr) => {
  let ast_of_string = Parser.parse(property);
  let ast_to_expr = (~loc, ast) =>
    value_of_ast(~loc, ast) |> value_to_expr(~loc);
  let string_to_expr = (~loc, string) =>
    ast_of_string(string) |> Result.map(ast_to_expr(~loc));

  {ast_of_string, value_of_ast, ast_to_expr, string_to_expr};
};

let emit_shorthand = (parser, mapper, value_to_expr) => {
  let ast_of_string = Parser.parse(parser);
  let ast_to_expr = (~loc, ast) =>
    ast |> List.map(mapper(~loc)) |> value_to_expr(~loc);
  let string_to_expr = (~loc, string) =>
    ast_of_string(string) |> Result.map(ast_to_expr(~loc));
  let value_of_ast = (~loc) => List.map(mapper(~loc));

  {ast_of_string, value_of_ast, ast_to_expr, string_to_expr};
};

let list_to_longident = vars => vars |> String.concat(".") |> Longident.parse;

let render_variable = (~loc, name) =>
  list_to_longident(name) |> txt(~loc) |> Helper.Exp.ident(~loc);

let transform_with_variable = (parser, mapper, value_to_expr) =>
  emit(
    /* This Xor is defined here for those properties that aren't defined with
       <interpolation> as a valid definition */
    Combinator.combine_xor([
      /* If the entire CSS value is interpolated, we treat it as a `Variable */
      Rule.Match.map(Standard.interpolation, data => `Variable(data)),
      /* Otherwise it's a regular CSS `Value and match the parser */
      Rule.Match.map(parser, data => `Value(data)),
    ]),
    (~loc) =>
      fun
      | `Variable(name) => render_variable(~loc, name)
      | `Value(ast) => mapper(~loc, ast),
    (~loc, expression) => {
      switch (expression) {
      // Since we are treating with expressions here, we don't have any other way to detect if it's interpolation or not. We want to add type constraints on interpolation only.
      | {pexp_desc: Pexp_ident({txt: Ldot(Lident("CssJs"), _), _}), _} as exp =>
        value_to_expr(~loc, exp)
      | {pexp_desc: Pexp_ident(_), pexp_loc: _, _} as exp =>
        value_to_expr(~loc, exp)
        |> List.map(add_CssJs_rule_constraint(~loc))
      | exp => value_to_expr(~loc, exp)
      }
    },
  );

/* Applies the renderer to a property where the value is one argument */
let apply = (parser, property_renderer, value_renderer) =>
  transform_with_variable(parser, value_renderer, (~loc, value) =>
    [[%expr [%e property_renderer(~loc)]([%e value])]]
  );

/* Triggers Unsupported_feature and it's rendered as a string */
let unsupportedValue = (parser, property) =>
  transform_with_variable(
    parser,
    (~loc as _, _) => raise(Unsupported_feature),
    (~loc, arg) => [[%expr [%e property(~loc)]([%e arg])]],
  );

/* Triggers Unsupported_feature and it's rendered as a string */
let unsupportedProperty = parser =>
  transform_with_variable(
    parser,
    (~loc as _, _) => raise(Unsupported_feature),
    (~loc as _) => raise(Unsupported_feature),
  );

let render_string = (~loc, s) => {
  switch (File.get()) {
  | Some(ReScript) =>
    Helper.Exp.constant(
      ~loc,
      ~attrs=[Generate_lib.BuckleScriptAttributes.uncurried(~loc)],
      Helper.Const.string(~quotation_delimiter="*j", s),
    )
  | Some(Reason)
  | _ =>
    Helper.Exp.constant(
      ~loc,
      Helper.Const.string(~quotation_delimiter="js", s),
    )
  };
};
let render_integer = (~loc, integer) =>
  Helper.Const.int(integer) |> Helper.Exp.constant(~loc);
let render_number = (~loc, number) =>
  Helper.Const.float(number |> string_of_float) |> Helper.Exp.constant(~loc);
let render_percentage = (~loc, number) => [%expr
  `percent([%e render_number(~loc, number)])
];

let render_css_global_values = (~loc, name, value) => {
  let.ok value = Parser.parse(Standard.css_wide_keywords, value);

  let value =
    switch (value) {
    | `Inherit => "inherit"
    | `Initial => "initial"
    | `Unset => "unset"
    };

  /* bs-css doesn't have those */
  Ok([
    [%expr
      CssJs.unsafe(
        [%e render_string(~loc, name)],
        [%e render_string(~loc, value)],
      )
    ],
  ]);
};

let variant_to_expression = (~loc) =>
  fun
  | `Anywhere => id([%expr `anywhere])
  | `Auto => id([%expr `auto])
  | `Baseline => id([%expr `baseline])
  | `Blink => id([%expr `blink])
  | `Bold => id([%expr `bold])
  | `Bolder => id([%expr `bolder])
  | `Border_box => id([%expr `borderBox])
  | `Bottom => id([%expr `bottom])
  | `Break_all => id([%expr `breakAll])
  | `Break_spaces => id([%expr `breakSpaces])
  | `Break_word => raise(Unsupported_feature)
  | `BreakWord => id([%expr `breakWord])
  | `Capitalize => id([%expr `capitalize])
  | `Center => id([%expr `center])
  | `Clip => id([%expr `clip])
  | `Column => id([%expr `column])
  | `Column_reverse => id([%expr `columnReverse])
  | `Contain => id([%expr `contain])
  | `Content => id([%expr `content])
  | `Content_box => id([%expr `contentBox])
  | `Cover => id([%expr `cover])
  | `Dashed => id([%expr `dashed])
  | `Dotted => id([%expr `dotted])
  | `Double => id([%expr `double])
  | `Ellipsis => id([%expr `ellipsis])
  | `End => id([%expr `end_])
  | `Fill => id([%expr `fill])
  | `Flat => id([%expr `flat])
  | `Flex_end => id([%expr `flexEnd])
  | `Flex_start => id([%expr `flexStart])
  | `From_font => raise(Unsupported_feature)
  | `Groove => id([%expr `groove])
  | `Hidden => id([%expr `hidden])
  | `Inset => id([%expr `inset])
  | `Italic => id([%expr `italic])
  | `Justify => id([%expr `justify])
  | `Keep_all => id([%expr `keepAll])
  | `Left => id([%expr `left])
  | `Lighter => id([%expr `lighter])
  | `Line_Through => id([%expr `lineThrough])
  | `Lowercase => id([%expr `lowercase])
  | `MaxContent => id([%expr `maxContent])
  | `MinContent => id([%expr `minContent])
  | `None => id([%expr `none])
  | `Normal => id([%expr `normal])
  | `Nowrap => id([%expr `nowrap])
  | `Oblique => id([%expr `oblique])
  | `Outset => id([%expr `outset])
  | `Overline => id([%expr `overline])
  | `Padding_box => id([%expr `paddingBox])
  | `Pre => id([%expr `pre])
  | `Pre_line => id([%expr `preLine])
  | `Pre_wrap => id([%expr `preWrap])
  | `Preserve_3d => id([%expr `preserve3d])
  | `Repeat_x => id([%expr `repeatX])
  | `Repeat_y => id([%expr `repeatY])
  | `Ridge => id([%expr `ridge])
  | `Right => id([%expr `right])
  | `Row => id([%expr `row])
  | `Row_reverse => id([%expr `rowReverse])
  | `Scale_down => id([%expr `scaleDown])
  | `Scroll => id([%expr `scroll])
  | `Small_caps => id([%expr `smallCaps])
  | `Solid => id([%expr `solid])
  | `Space_around => id([%expr `spaceAround])
  | `Space_between => id([%expr `spaceBetween])
  | `Start => id([%expr `start])
  | `Stretch => id([%expr `stretch])
  | `Top => id([%expr `top])
  | `Transparent => id([%expr `transparent])
  | `Underline => id([%expr `underline])
  | `Unset => id([%expr `unset])
  | `Uppercase => id([%expr `uppercase])
  | `Visible => id([%expr `visible])
  | `Wavy => id([%expr `wavy])
  | `Wrap => id([%expr `wrap])
  | `FitContent => raise(Unsupported_feature)
  | `Justify_all => raise(Unsupported_feature)
  | `Match_parent => raise(Unsupported_feature)
  | `Wrap_reverse => id([%expr `wrapReverse])
  | `Full_width => raise(Unsupported_feature)
  | `Full_size_kana => raise(Unsupported_feature);

// TODO: all of them could be float, but bs-css doesn't support it
let render_length = (~loc) =>
  fun
  | `Cap(_n) => raise(Unsupported_feature)
  | `Ch(n) => [%expr `ch([%e render_number(~loc, n)])]
  | `Cm(n) => [%expr `cm([%e render_number(~loc, n)])]
  | `Em(n) => [%expr `em([%e render_number(~loc, n)])]
  | `Ex(n) => [%expr `ex([%e render_number(~loc, n)])]
  | `Ic(_n) => raise(Unsupported_feature)
  | `In(_n) => raise(Unsupported_feature)
  | `Lh(_n) => raise(Unsupported_feature)
  | `Mm(n) => [%expr `mm([%e render_number(~loc, n)])]
  | `Pc(n) => [%expr `pc([%e render_number(~loc, n)])]
  | `Pt(n) => [%expr `pt([%e render_integer(~loc, n |> int_of_float)])]
  | `Px(n) => [%expr `pxFloat([%e render_number(~loc, n)])]
  | `Q(_n) => raise(Unsupported_feature)
  | `Rem(n) => [%expr `rem([%e render_number(~loc, n)])]
  | `Rlh(_n) => raise(Unsupported_feature)
  | `Vb(_n) => raise(Unsupported_feature)
  | `Vh(n) => [%expr `vh([%e render_number(~loc, n)])]
  | `Vi(_n) => raise(Unsupported_feature)
  | `Vmax(n) => [%expr `vmax([%e render_number(~loc, n)])]
  | `Vmin(n) => [%expr `vmin([%e render_number(~loc, n)])]
  | `Vw(n) => [%expr `vw([%e render_number(~loc, n)])]
  | `Zero => [%expr `zero];

let rec render_function_calc = (~loc, calc_sum) => {
  switch (calc_sum) {
  | (product, []) => render_product(~loc, product)
  | (product, list_of_sums) =>
    /* This isn't a great design of the types, but we need to know the operation
       which is in the first position of the array, we ensure that there's one value
       since we are on this branch of the switch */
    let op = pick_operation(~loc, List.hd(list_of_sums));
    let first = render_product(~loc, product);
    let second = render_list_of_sums(~loc, list_of_sums);
    [%expr `calc(([%e op], [%e first], [%e second]))];
  };
}
and render_sum_op = (~loc, op) => {
  switch (op) {
  | `Dash () => [%expr `sub]
  | `Cross () => [%expr `add]
  };
}
and pick_operation = (~loc, (op, _)) => render_sum_op(~loc, op)
and render_list_of_products = list_of_products => {
  switch (list_of_products) {
  | [one] => render_product_op(one)
  | list => render_list_of_products(list)
  };
}
and render_list_of_sums = (~loc, list_of_sums) => {
  switch (list_of_sums) {
  | [(_, one)] => render_product(~loc, one)
  | list => render_list_of_sums(~loc, list)
  };
}
and render_product = (~loc, product) => {
  switch (product) {
  | (calc_value, []) => render_calc_value(~loc, calc_value)
  | (calc_value, list_of_products) =>
    let _first = render_calc_value(calc_value);
    let _second = render_list_of_products(list_of_products);
    /* [%expr (`mult, [%e first], [%e second])]; */
    failwith("`mult isn't available in bs-css");
  };
}
and render_product_op = (~loc, op) => {
  switch (op) {
  | `Static_0((), calc_value) => render_calc_value(~loc, calc_value)
  | `Static_1((), float) => render_number(~loc, float)
  };
}
and render_calc_value = (~loc, calc_value) => {
  switch (calc_value) {
  | `Number(float) => render_number(~loc, float)
  | `Extended_length(l) => render_extended_length(~loc, l)
  | `Extended_percentage(p) => render_extended_percentage(~loc, p)
  | `Function_calc(fc) => render_function_calc(~loc, fc)
  };
}
and render_extended_length = (~loc) =>
  fun
  | `Length(l) => render_length(~loc, l)
  | `Function_calc(fc) => render_function_calc(~loc, fc)
  | `Interpolation(i) => render_variable(~loc, i)
and render_extended_percentage = (~loc) =>
  fun
  | `Percentage(p) => render_percentage(~loc, p)
  | `Function_calc(fc) => render_function_calc(~loc, fc)
  | `Interpolation(i) => render_variable(~loc, i);

let render_length_percentage = (~loc) =>
  fun
  | `Extended_length(ext) => render_extended_length(~loc, ext)
  | `Extended_percentage(ext) => render_extended_percentage(~loc, ext);

// css-sizing-3
let render_size = (~loc) =>
  fun
  | `Auto => variant_to_expression(~loc, `Auto)
  | `Extended_length(l) => render_extended_length(~loc, l)
  | `Extended_percentage(p) => render_extended_percentage(~loc, p)
  | `Function_calc(fc) => render_function_calc(~loc, fc)
  | `Fit_content_0 => variant_to_expression(~loc, `FitContent)
  | `Max_content => variant_to_expression(~loc, `MaxContent)
  | `Min_content => variant_to_expression(~loc, `MinContent)
  | `Fit_content_1(_)
  | _ => raise(Unsupported_feature);

let render_one_bg_size = (~loc, value) => {
  switch (value) {
  | `Extended_length(l) => render_extended_length(~loc, l)
  | `Extended_percentage(p) => render_extended_percentage(~loc, p)
  | `Auto => variant_to_expression(~loc, `Auto)
  };
};

let render_bg_size = (~loc, value: Types.bg_size) =>
  switch (value) {
  /* bs-css doesn't support auto in each size */
  | `One_bg_size([`Auto, _]) => raise(Unsupported_feature)
  | `One_bg_size([_, `Auto]) => raise(Unsupported_feature)
  | `One_bg_size([one, two]) =>
    [%expr
     `size((
       [%e render_one_bg_size(~loc, one)],
       [%e render_one_bg_size(~loc, two)],
     ))]
  /* bs-css doesn't support one size */
  | `One_bg_size(_) => raise(Unsupported_feature)
  | `Cover => variant_to_expression(~loc, `Cover)
  | `Contain => variant_to_expression(~loc, `Contain)
  };

let render_max_width = (~loc) =>
  fun
  | `Extended_length(l) => render_extended_length(~loc, l)
  | `Extended_percentage(p) => render_extended_percentage(~loc, p)
  | `Function_calc(fc) => render_function_calc(~loc, fc)
  | `Fit_content_0 => variant_to_expression(~loc, `FitContent)
  | `Max_content => variant_to_expression(~loc, `MaxContent)
  | `Min_content => variant_to_expression(~loc, `MinContent)
  | `Fit_content_1(_)
  | _ => raise(Unsupported_feature);

let render_min_size = (~loc) =>
  fun
  | `Extended_length(l) => render_extended_length(~loc, l)
  | `Extended_percentage(p) => render_extended_percentage(~loc, p)
  | `Fit_content_0 => variant_to_expression(~loc, `FitContent)
  | `Max_content => variant_to_expression(~loc, `MaxContent)
  | `Min_content => variant_to_expression(~loc, `MinContent)
  | `Fit_content_1(_)
  | _ => raise(Unsupported_feature);

let render_angle = (~loc) =>
  fun
  | `Deg(number) => id([%expr `deg([%e render_number(~loc, number)])])
  | `Rad(number) => id([%expr `rad([%e render_number(~loc, number)])])
  | `Grad(number) => id([%expr `grad([%e render_number(~loc, number)])])
  | `Turn(number) => id([%expr `turn([%e render_number(~loc, number)])]);

let render_extended_angle = (~loc) =>
  fun
  | `Angle(a) => render_angle(~loc, a)
  | `Function_calc(fc) => render_function_calc(~loc, fc)
  | `Interpolation(i) => render_variable(~loc, i);

/* Applies variants to one argument */
let variants = (parser, identifier) =>
  apply(parser, identifier, variant_to_expression);

let width =
  apply(Parser.property_width, (~loc) => [%expr CssJs.width], render_size);
let height =
  apply(Parser.property_height, (~loc) => [%expr CssJs.height], render_size);
let min_width =
  apply(
    Parser.property_min_width,
    (~loc) => [%expr CssJs.minWidth],
    render_min_size,
  );
let min_height =
  apply(
    Parser.property_min_height,
    (~loc) => [%expr CssJs.minHeight],
    render_min_size,
  );
let max_width =
  apply(
    Parser.property_max_width,
    (~loc) => [%expr CssJs.maxWidth],
    render_max_width,
  );
let max_height =
  apply(
    Parser.property_max_height,
    (~loc) => [%expr CssJs.maxHeight],
    render_size,
  );
let box_sizing =
  apply(
    Parser.property_box_sizing,
    (~loc) => [%expr CssJs.boxSizing],
    variant_to_expression,
  );
let column_width =
  apply(
    Parser.property_column_width,
    (~loc) => [%expr CssJs.columnWidth],
    (~loc, value: Types.property_column_width) =>
      switch (value) {
      | `Auto => variant_to_expression(~loc, `Auto)
      | `Extended_length(l) => render_extended_length(~loc, l)
      },
  );

let render_margin = (~loc) =>
  fun
  | `Auto => variant_to_expression(~loc, `Auto)
  | `Extended_length(l) => render_extended_length(~loc, l)
  | `Extended_percentage(p) => render_extended_percentage(~loc, p);

let render_padding = (~loc) =>
  fun
  | `Auto => variant_to_expression(~loc, `Auto)
  | `Extended_length(l) => render_extended_length(~loc, l)
  | `Extended_percentage(p) => render_extended_percentage(~loc, p);

// css-box-3
let margin_top =
  apply(
    Parser.property_margin_top,
    (~loc) => [%expr CssJs.marginTop],
    render_margin,
  );
let margin_right =
  apply(
    Parser.property_margin_right,
    (~loc) => [%expr CssJs.marginRight],
    render_margin,
  );
let margin_bottom =
  apply(
    Parser.property_margin_bottom,
    (~loc) => [%expr CssJs.marginBottom],
    render_margin,
  );
let margin_left =
  apply(
    Parser.property_margin_left,
    (~loc) => [%expr CssJs.marginLeft],
    render_margin,
  );

let margin =
  emit_shorthand(
    Parser.property_margin,
    (~loc) =>
      fun
      | `Auto => variant_to_expression(~loc, `Auto)
      | `Extended_length(l) => render_extended_length(~loc, l)
      | `Extended_percentage(p) => render_extended_percentage(~loc, p)
      | `Interpolation(name) => render_variable(~loc, name),
    (~loc) =>
      fun
      | [all] => [[%expr CssJs.margin([%e all])]]
      | [v, h] => [[%expr CssJs.margin2(~v=[%e v], ~h=[%e h])]]
      | [t, h, b] => [
          [%expr CssJs.margin3(~top=[%e t], ~h=[%e h], ~bottom=[%e b])],
        ]
      | [t, r, b, l] => [
          [%expr
            CssJs.margin4(
              ~top=[%e t],
              ~right=[%e r],
              ~bottom=[%e b],
              ~left=[%e l],
            )
          ],
        ]
      | [] => failwith("Margin value can't be empty")
      | _ => failwith("There aren't more margin combinations"),
  );

let padding_top =
  apply(
    Parser.property_padding_top,
    (~loc) => [%expr CssJs.paddingTop],
    render_padding,
  );
let padding_right =
  apply(
    Parser.property_padding_right,
    (~loc) => [%expr CssJs.paddingRight],
    render_padding,
  );
let padding_bottom =
  apply(
    Parser.property_padding_bottom,
    (~loc) => [%expr CssJs.paddingBottom],
    render_padding,
  );
let padding_left =
  apply(
    Parser.property_padding_left,
    (~loc) => [%expr CssJs.paddingLeft],
    render_padding,
  );

let padding =
  emit_shorthand(
    Parser.property_padding,
    (~loc) =>
      fun
      | `Extended_length(l) => render_extended_length(~loc, l)
      | `Extended_percentage(p) => render_extended_percentage(~loc, p)
      | `Interpolation(name) => render_variable(~loc, name),
    (~loc) =>
      fun
      | [all] => [[%expr CssJs.padding([%e all])]]
      | [v, h] => [[%expr CssJs.padding2(~v=[%e v], ~h=[%e h])]]
      | [t, h, b] => [
          [%expr CssJs.padding3(~top=[%e t], ~h=[%e h], ~bottom=[%e b])],
        ]
      | [t, r, b, l] => [
          [%expr
            CssJs.padding4(
              ~top=[%e t],
              ~right=[%e r],
              ~bottom=[%e b],
              ~left=[%e l],
            )
          ],
        ]
      | [] => failwith("Padding value can't be empty")
      | _ => failwith("There aren't more padding combinations"),
  );

let render_named_color = (~loc) =>
  fun
  | `Transparent => variant_to_expression(~loc, `Transparent)
  | `Aliceblue => [%expr CssJs.aliceblue]
  | `Antiquewhite => [%expr CssJs.antiquewhite]
  | `Aqua => [%expr CssJs.aqua]
  | `Aquamarine => [%expr CssJs.aquamarine]
  | `Azure => [%expr CssJs.azure]
  | `Beige => [%expr CssJs.beige]
  | `Bisque => [%expr CssJs.bisque]
  | `Black => [%expr CssJs.black]
  | `Blanchedalmond => [%expr CssJs.blanchedalmond]
  | `Blue => [%expr CssJs.blue]
  | `Blueviolet => [%expr CssJs.blueviolet]
  | `Brown => [%expr CssJs.brown]
  | `Burlywood => [%expr CssJs.burlywood]
  | `Cadetblue => [%expr CssJs.cadetblue]
  | `Chartreuse => [%expr CssJs.chartreuse]
  | `Chocolate => [%expr CssJs.chocolate]
  | `Coral => [%expr CssJs.coral]
  | `Cornflowerblue => [%expr CssJs.cornflowerblue]
  | `Cornsilk => [%expr CssJs.cornsilk]
  | `Crimson => [%expr CssJs.crimson]
  | `Cyan => [%expr CssJs.cyan]
  | `Darkblue => [%expr CssJs.darkblue]
  | `Darkcyan => [%expr CssJs.darkcyan]
  | `Darkgoldenrod => [%expr CssJs.darkgoldenrod]
  | `Darkgray => [%expr CssJs.darkgray]
  | `Darkgreen => [%expr CssJs.darkgreen]
  | `Darkgrey => [%expr CssJs.darkgrey]
  | `Darkkhaki => [%expr CssJs.darkkhaki]
  | `Darkmagenta => [%expr CssJs.darkmagenta]
  | `Darkolivegreen => [%expr CssJs.darkolivegreen]
  | `Darkorange => [%expr CssJs.darkorange]
  | `Darkorchid => [%expr CssJs.darkorchid]
  | `Darkred => [%expr CssJs.darkred]
  | `Darksalmon => [%expr CssJs.darksalmon]
  | `Darkseagreen => [%expr CssJs.darkseagreen]
  | `Darkslateblue => [%expr CssJs.darkslateblue]
  | `Darkslategray => [%expr CssJs.darkslategray]
  | `Darkslategrey => [%expr CssJs.darkslategrey]
  | `Darkturquoise => [%expr CssJs.darkturquoise]
  | `Darkviolet => [%expr CssJs.darkviolet]
  | `Deeppink => [%expr CssJs.deeppink]
  | `Deepskyblue => [%expr CssJs.deepskyblue]
  | `Dimgray => [%expr CssJs.dimgray]
  | `Dimgrey => [%expr CssJs.dimgrey]
  | `Dodgerblue => [%expr CssJs.dodgerblue]
  | `Firebrick => [%expr CssJs.firebrick]
  | `Floralwhite => [%expr CssJs.floralwhite]
  | `Forestgreen => [%expr CssJs.forestgreen]
  | `Fuchsia => [%expr CssJs.fuchsia]
  | `Gainsboro => [%expr CssJs.gainsboro]
  | `Ghostwhite => [%expr CssJs.ghostwhite]
  | `Gold => [%expr CssJs.gold]
  | `Goldenrod => [%expr CssJs.goldenrod]
  | `Gray => [%expr CssJs.gray]
  | `Green => [%expr CssJs.green]
  | `Greenyellow => [%expr CssJs.greenyellow]
  | `Grey => [%expr CssJs.grey]
  | `Honeydew => [%expr CssJs.honeydew]
  | `Hotpink => [%expr CssJs.hotpink]
  | `Indianred => [%expr CssJs.indianred]
  | `Indigo => [%expr CssJs.indigo]
  | `Ivory => [%expr CssJs.ivory]
  | `Khaki => [%expr CssJs.khaki]
  | `Lavender => [%expr CssJs.lavender]
  | `Lavenderblush => [%expr CssJs.lavenderblush]
  | `Lawngreen => [%expr CssJs.lawngreen]
  | `Lemonchiffon => [%expr CssJs.lemonchiffon]
  | `Lightblue => [%expr CssJs.lightblue]
  | `Lightcoral => [%expr CssJs.lightcoral]
  | `Lightcyan => [%expr CssJs.lightcyan]
  | `Lightgoldenrodyellow => [%expr CssJs.lightgoldenrodyellow]
  | `Lightgray => [%expr CssJs.lightgray]
  | `Lightgreen => [%expr CssJs.lightgreen]
  | `Lightgrey => [%expr CssJs.lightgrey]
  | `Lightpink => [%expr CssJs.lightpink]
  | `Lightsalmon => [%expr CssJs.lightsalmon]
  | `Lightseagreen => [%expr CssJs.lightseagreen]
  | `Lightskyblue => [%expr CssJs.lightskyblue]
  | `Lightslategray => [%expr CssJs.lightslategray]
  | `Lightslategrey => [%expr CssJs.lightslategrey]
  | `Lightsteelblue => [%expr CssJs.lightsteelblue]
  | `Lightyellow => [%expr CssJs.lightyellow]
  | `Lime => [%expr CssJs.lime]
  | `Limegreen => [%expr CssJs.limegreen]
  | `Linen => [%expr CssJs.linen]
  | `Magenta => [%expr CssJs.magenta]
  | `Maroon => [%expr CssJs.maroon]
  | `Mediumaquamarine => [%expr CssJs.mediumaquamarine]
  | `Mediumblue => [%expr CssJs.mediumblue]
  | `Mediumorchid => [%expr CssJs.mediumorchid]
  | `Mediumpurple => [%expr CssJs.mediumpurple]
  | `Mediumseagreen => [%expr CssJs.mediumseagreen]
  | `Mediumslateblue => [%expr CssJs.mediumslateblue]
  | `Mediumspringgreen => [%expr CssJs.mediumspringgreen]
  | `Mediumturquoise => [%expr CssJs.mediumturquoise]
  | `Mediumvioletred => [%expr CssJs.mediumvioletred]
  | `Midnightblue => [%expr CssJs.midnightblue]
  | `Mintcream => [%expr CssJs.mintcream]
  | `Mistyrose => [%expr CssJs.mistyrose]
  | `Moccasin => [%expr CssJs.moccasin]
  | `Navajowhite => [%expr CssJs.navajowhite]
  | `Navy => [%expr CssJs.navy]
  | `Oldlace => [%expr CssJs.oldlace]
  | `Olive => [%expr CssJs.olive]
  | `Olivedrab => [%expr CssJs.olivedrab]
  | `Orange => [%expr CssJs.orange]
  | `Orangered => [%expr CssJs.orangered]
  | `Orchid => [%expr CssJs.orchid]
  | `Palegoldenrod => [%expr CssJs.palegoldenrod]
  | `Palegreen => [%expr CssJs.palegreen]
  | `Paleturquoise => [%expr CssJs.paleturquoise]
  | `Palevioletred => [%expr CssJs.palevioletred]
  | `Papayawhip => [%expr CssJs.papayawhip]
  | `Peachpuff => [%expr CssJs.peachpuff]
  | `Peru => [%expr CssJs.peru]
  | `Pink => [%expr CssJs.pink]
  | `Plum => [%expr CssJs.plum]
  | `Powderblue => [%expr CssJs.powderblue]
  | `Purple => [%expr CssJs.purple]
  | `Rebeccapurple => [%expr CssJs.rebeccapurple]
  | `Red => [%expr CssJs.red]
  | `Rosybrown => [%expr CssJs.rosybrown]
  | `Royalblue => [%expr CssJs.royalblue]
  | `Saddlebrown => [%expr CssJs.saddlebrown]
  | `Salmon => [%expr CssJs.salmon]
  | `Sandybrown => [%expr CssJs.sandybrown]
  | `Seagreen => [%expr CssJs.seagreen]
  | `Seashell => [%expr CssJs.seashell]
  | `Sienna => [%expr CssJs.sienna]
  | `Silver => [%expr CssJs.silver]
  | `Skyblue => [%expr CssJs.skyblue]
  | `Slateblue => [%expr CssJs.slateblue]
  | `Slategray => [%expr CssJs.slategray]
  | `Slategrey => [%expr CssJs.slategrey]
  | `Snow => [%expr CssJs.snow]
  | `Springgreen => [%expr CssJs.springgreen]
  | `Steelblue => [%expr CssJs.steelblue]
  | `Tan => [%expr CssJs.tan]
  | `Teal => [%expr CssJs.teal]
  | `Thistle => [%expr CssJs.thistle]
  | `Tomato => [%expr CssJs.tomato]
  | `Turquoise => [%expr CssJs.turquoise]
  | `Violet => [%expr CssJs.violet]
  | `Wheat => [%expr CssJs.wheat]
  | `White => [%expr CssJs.white]
  | `Whitesmoke => [%expr CssJs.whitesmoke]
  | `Yellow => [%expr CssJs.yellow]
  | `Yellowgreen => [%expr CssJs.yellowgreen]
  | _ => raise(Unsupported_feature);

let render_color_alpha = (~loc, color_alpha) =>
  switch (color_alpha) {
  | `Number(number) => [%expr `num([%e render_number(~loc, number)])]
  | `Extended_percentage(`Percentage(pct)) =>
    render_percentage(~loc, pct /. 100.0)
  | `Extended_percentage(pct) => render_extended_percentage(~loc, pct)
  };

let render_function_rgb = (~loc, ast: Types.function_rgb) => {
  let color_to_float = v => render_integer(~loc, v |> int_of_float);

  let to_number =
    fun
    // TODO: bs-css rgb(float, float, float)
    | `Percentage(pct) => color_to_float(pct *. 2.55)
    | `Function_calc(fc) => render_function_calc(~loc, fc)
    | `Interpolation(v) => render_variable(~loc, v)
    | `Extended_percentage(ext) => render_extended_percentage(~loc, ext);

  let (colors, alpha) =
    switch (ast) {
    /* 1 and 3 = numbers */
    | `Rgb_1(colors, alpha)
    | `Rgb_3(colors, alpha) => (colors |> List.map(color_to_float), alpha)
    /* 0 and 2 = extended-percentage */
    | `Rgb_0(colors, alpha)
    | `Rgb_2(colors, alpha) => (colors |> List.map(to_number), alpha)
    };
  let (red, green, blue) =
    switch (colors) {
    | [red, green, blue] => (red, green, blue)
    | _ => failwith("unreachable")
    };

  let alpha =
    switch (alpha) {
    | Some(((), alpha)) => Some(alpha)
    | None => None
    };

  let alpha = Option.map(render_color_alpha(~loc), alpha);

  switch (alpha) {
  | Some(a) => id([%expr `rgba(([%e red], [%e green], [%e blue], [%e a]))])
  | None => id([%expr `rgb(([%e red], [%e green], [%e blue]))])
  };
};

let render_function_rgba = (~loc, ast: Types.function_rgba) => {
  let color_to_float = v => render_integer(~loc, v |> int_of_float);

  let to_number =
    fun
    // TODO: bs-css rgb(float, float, float)
    | `Percentage(pct) => color_to_float(pct *. 2.55)
    | `Function_calc(fc) => render_function_calc(~loc, fc)
    | `Interpolation(v) => render_variable(~loc, v)
    | `Extended_percentage(ext) => render_extended_percentage(~loc, ext);

  let (colors, alpha) =
    switch (ast) {
    /* 1 and 3 = numbers */
    | `Rgba_1(colors, alpha)
    | `Rgba_3(colors, alpha) => (colors |> List.map(color_to_float), alpha)
    /* 0 and 2 = extended-percentage */
    | `Rgba_0(colors, alpha)
    | `Rgba_2(colors, alpha) => (colors |> List.map(to_number), alpha)
    };
  let (red, green, blue) =
    switch (colors) {
    | [red, green, blue] => (red, green, blue)
    | _ => failwith("unreachable")
    };

  let alpha =
    switch (alpha) {
    | Some(((), alpha)) => Some(alpha)
    | None => None
    };

  let alpha = Option.map(render_color_alpha(~loc), alpha);

  switch (alpha) {
  | Some(a) => id([%expr `rgba(([%e red], [%e green], [%e blue], [%e a]))])
  | None => id([%expr `rgb(([%e red], [%e green], [%e blue]))])
  };
};

let render_function_hsl = (~loc, (hue, saturation, lightness, alpha)) => {
  let hue =
    switch (hue) {
    | `Number(degs) => render_angle(~loc, `Deg(degs))
    | `Extended_angle(angle) => render_extended_angle(~loc, angle)
    };

  let saturation = render_extended_percentage(~loc, saturation);
  let lightness = render_extended_percentage(~loc, lightness);

  let alpha =
    switch (alpha) {
    | Some(((), alpha)) => Some(alpha)
    | None => None
    };

  let alpha = Option.map(render_color_alpha(~loc), alpha);

  switch (alpha) {
  | Some(alpha) =>
    id(
      [%expr `hsla(([%e hue], [%e saturation], [%e lightness], [%e alpha]))],
    )
  | None => id([%expr `hsl(([%e hue], [%e saturation], [%e lightness]))])
  };
};

let render_function_hsla = (~loc, (hue, saturation, lightness, alpha)) => {
  let hue =
    switch (hue) {
    | `Number(degs) => render_angle(~loc, `Deg(degs))
    | `Extended_angle(angle) => render_extended_angle(~loc, angle)
    };

  let saturation = render_extended_percentage(~loc, saturation);
  let lightness = render_extended_percentage(~loc, lightness);

  let alpha =
    switch (alpha) {
    | Some(((), alpha)) => Some(alpha)
    | None => None
    };

  let alpha = Option.map(render_color_alpha(~loc), alpha);

  switch (alpha) {
  | Some(alpha) =>
    id(
      [%expr `hsla(([%e hue], [%e saturation], [%e lightness], [%e alpha]))],
    )
  | None => id([%expr `hsl(([%e hue], [%e saturation], [%e lightness]))])
  };
};

let render_var = (~loc, string) => {
  let string = render_string(~loc, string);
  [%expr `var([%e string])];
};

let render_color = (~loc, value) =>
  switch ((value: Types.color)) {
  | `Interpolation(v) => render_variable(~loc, v)
  | `Hex_color(hex) => id([%expr `hex([%e render_string(~loc, hex)])])
  | `Named_color(color) => render_named_color(~loc, color)
  | `CurrentColor => id([%expr `currentColor])
  | `Function_rgb(rgb) => render_function_rgb(~loc, rgb)
  | `Function_rgba(rgba) => render_function_rgba(~loc, rgba)
  | `Function_var(v) => render_var(~loc, v)
  | `Function_hsl(`Hsl_0(hsl)) => render_function_hsl(~loc, hsl)
  | `Function_hsla(`Hsla_0(hsla)) => render_function_hsla(~loc, hsla)
  /* Function_hsl(a) with `Hsl(a)_1 aren't supported */
  | `Function_hsl(_)
  | `Function_hsla(_)
  | `Deprecated_system_color(_) => raise(Unsupported_feature)
  };

let color =
  apply(Parser.property_color, (~loc) => [%expr CssJs.color], render_color);
let opacity =
  apply(
    Parser.property_opacity,
    (~loc) => [%expr CssJs.opacity],
    (~loc) =>
      fun
      | `Number(number) => render_number(~loc, number)
      | `Extended_percentage(`Percentage(number)) =>
        render_number(~loc, number /. 100.0)
      | `Extended_percentage(pct) => render_extended_percentage(~loc, pct),
  );

// css-images-4
let render_position = (~loc, position: Types.position) => {
  // TODO: Revisit defaults, see https://drafts.csswg.org/css-images-4/#position
  let pos_to_percentage_offset =
    fun
    | `Left
    | `Top => 0.
    | `Right
    | `Bottom => 100.
    | `Center => 50.;

  let to_value = (~loc) =>
    fun
    | `Position(pos) => variant_to_expression(~loc, pos)
    | `Extended_length(l) => render_extended_length(~loc, l)
    | `Extended_percentage(percentage) =>
      render_extended_percentage(~loc, percentage);

  let horizontal =
    switch (position) {
    | `Or(Some(pos), _) => `Position(pos)
    | `Or(None, _) => `Position(`Center)
    | `Static((`Center | `Left | `Right) as pos, _) => `Position(pos)
    | `Static(`Extended_length(length), _) => `Extended_length(length)
    | `Static(`Extended_percentage(percent), _) =>
      `Extended_percentage(percent)
    | `And((pos, `Extended_percentage(`Percentage(percentage))), _) =>
      `Extended_percentage(
        `Percentage(percentage +. pos_to_percentage_offset(pos)),
      )
    | _ => raise(Unsupported_feature)
    };

  let vertical =
    switch (position) {
    | `Or(_, Some(pos)) => `Position(pos)
    | `Or(_, None) => `Position(`Center)
    | `Static(_, None) => `Position(`Center)
    | `Static(_, Some((`Center | `Bottom | `Top) as pos)) => `Position(pos)
    | `Static(_, Some(`Extended_length(length))) =>
      `Extended_length(length)
    | `And(_, (pos, `Extended_percentage(`Percentage(percentage)))) =>
      `Extended_percentage(
        `Percentage(percentage +. pos_to_percentage_offset(pos)),
      )
    | _ => raise(Unsupported_feature)
    };

  (to_value(~loc, horizontal), to_value(~loc, vertical));
};

let object_fit =
  variants(Parser.property_object_fit, (~loc) => [%expr CssJs.objectFit]);

let object_position =
  apply(
    Parser.property_object_position,
    (~loc) => [%expr CssJs.objectPosition],
    (~loc, position: Types.position) => {
      let (x, y) = render_position(~loc, position);
      [%expr `hv(([%e x], [%e y]))];
    },
  );
let image_resolution = unsupportedProperty(Parser.property_image_resolution);
let image_orientation =
  unsupportedProperty(Parser.property_image_orientation);
let image_rendering = unsupportedProperty(Parser.property_image_rendering);

let render_color_interp = (~loc) =>
  fun
  | `Interpolation(name) => render_variable(~loc, name)
  | `Color(ls) => render_color(~loc, ls);

let render_length_interp = (~loc) =>
  fun
  | `Extended_length(l) => render_extended_length(~loc, l)
  | `Interpolation(name) => render_variable(~loc, name);

// css-backgrounds-3
let render_box_shadow = (~loc, shadow) => {
  let (color, x, y, blur, spread, inset) =
    switch (shadow) {
    | (inset, position, color) =>
      let (x, y, blur, spread) =
        switch (position) {
        | [x, y] => (x, y, None, None)
        | [x, y, blur] => (x, y, Some(blur), None)
        | [x, y, blur, spread] => (x, y, Some(blur), Some(spread))
        | _ => failwith("unreachable")
        };
      (color, x, y, blur, spread, inset);
    };

  let color =
    color
    |> Option.value(~default=`Color(`CurrentColor))
    |> render_color_interp(~loc);

  let x = render_length_interp(~loc, x);
  let y = render_length_interp(~loc, y);
  let blur = Option.map(render_length_interp(~loc), blur);
  let spread = Option.map(render_length_interp(~loc), spread);
  let inset =
    Option.map(
      () => Helper.Exp.construct(~loc, {txt: Lident("true"), loc}, None),
      inset,
    );

  let args =
    [
      (Labelled("x"), Some(x)),
      (Labelled("y"), Some(y)),
      (Labelled("blur"), blur),
      (Labelled("spread"), spread),
      (Labelled("inset"), inset),
      (Nolabel, Some(color)),
    ]
    |> List.filter_map(((label, value)) =>
         Option.map(value => (label, value), value)
       );

  Helper.Exp.apply(~loc, [%expr CssJs.Shadow.box], args);
};
let background_color =
  apply(
    Parser.property_background_color,
    (~loc) => [%expr CssJs.backgroundColor],
    render_color,
  );

let render_color_stop_length = (~loc, value: Types.color_stop_length) => {
  switch (value) {
  | `Extended_length(l) => render_extended_length(~loc, l)
  | `Extended_percentage(p) => render_extended_percentage(~loc, p)
  };
};

let render_color_stop_angle = (~loc, value: Types.color_stop_angle) => {
  switch (value) {
  | [`Angle(a), _] => render_angle(~loc, a)
  | [_, `Angle(a)] => render_angle(~loc, a)
  | _ => raise(Unsupported_feature)
  };
};

let render_linear_color_stop = (~loc, value: Types.linear_color_stop) => {
  switch (value) {
  | (color, None) => render_color(~loc, color)
  | (color, Some(length)) =>
    let color = render_color(~loc, color);
    let length = render_color_stop_length(~loc, length);
    [%expr ([%e color], [%e length])];
  };
};

let render_angular_color_stop = (~loc, value: Types.angular_color_stop) => {
  switch (value) {
  | (color, None) => render_color(~loc, color)
  | (color, Some(angle)) =>
    let color = render_color(~loc, color);
    let angle = render_color_stop_angle(~loc, angle);
    [%expr ([%e color], [%e angle])];
  };
};

/* and color_stop_list = [%value.rec "[ ',' <linear-color-stop> ]# ',' <linear-color-stop>"] */
let render_color_stop_list = (~loc, value: Types.color_stop_list) => {
  let (first, middle_stops, (), last_stop) = value;
  let first_stop = Option.to_list(first);
  let stops =
    first_stop
    |> List.append(middle_stops |> List.map(((_, stop)) => stop))
    |> List.append([last_stop]);

  stops
  |> List.map(stop => render_linear_color_stop(~loc, stop))
  |> List.append([render_linear_color_stop(~loc, last_stop)])
  |> Helper.Exp.array(~loc);
};

let render_angular_color_hint = (~loc, value: Types.angular_color_hint) => {
  switch (value) {
  | `Extended_percentage(pct) => render_extended_percentage(~loc, pct)
  | `Extended_angle(a) => render_extended_angle(~loc, a)
  };
};

let render_angular_color_stop_list =
    (~loc, value: Types.angular_color_stop_list) => {
  let (rest_of_stops, _, last_stops) = value;
  let stops =
    rest_of_stops
    |> List.map(stop => {
         switch (stop) {
         | (stop, None) => render_angular_color_stop(~loc, stop)
         | (stop, Some(((), color_hint: Types.angular_color_hint))) =>
           let stop = render_angular_color_stop(~loc, stop);
           let color_hint = render_angular_color_hint(~loc, color_hint);
           [%expr ([%e stop], [%e color_hint])];
         }
       })
    |> List.append([render_angular_color_stop(~loc, last_stops)]);
  Helper.Exp.array(~loc, stops);
};

let render_function_linear_gradient =
    (~loc, value: Types.function_linear_gradient) => {
  switch (value) {
  | (None, stops) =>
    /* bs-css doesn't support non-angle. Default to 180deg */
    [%expr
     `linearGradient((
       [%e render_extended_angle(~loc, `Angle(`Deg(180.)))],
       [%e render_color_stop_list(~loc, stops)],
     ))]
  | (Some(angle), stops) =>
    [%expr
     `linearGradient((
       [%e render_extended_angle(~loc, angle)],
       [%e render_color_stop_list(~loc, stops)],
     ))]
  };
};

let render_function_repeating_linear_gradient =
    (~loc, value: Types.function_repeating_linear_gradient) => {
  switch (value) {
  | (Some(`Extended_angle(angle)), (), stops) =>
    [%expr
     `repeatingLinearGradient((
       [%e render_extended_angle(~loc, angle)],
       [%e render_color_stop_list(~loc, stops)],
     ))]
  /* Other ways aren't supported in bs-css
     | #repeatingLinearGradient(Angle.t, array<(Length.t, [< Color.t | Var.t] as 'colorOrVar)>) */
  /* | (Some(`Static(_, side)), (), stops) =>
     [%expr `repeatingLinearGradient((
       [%e render_side_or_corner(~loc, side)],
       [%e render_color_stop_list(~loc, stops)]
     ))] */
  | _ => raise(Unsupported_feature)
  };
};

/* | #radialGradient(array<(Length.t, [< Color.t | Var.t] as 'colorOrVar)>) */
let render_function_radial_gradient =
    (~loc, value: Types.function_radial_gradient) => {
  switch (value) {
  | (None, None, (), stops) =>
    [%expr `radialGradient([%e render_color_stop_list(~loc, stops)])]
  | _ => raise(Unsupported_feature)
  };
};

/* | #repeatingRadialGradient(array<(Length.t, [< Color.t | Var.t] as 'colorOrVar)>) */
let render_function_repeating_radial_gradient =
    (~loc, value: Types.function_repeating_radial_gradient) => {
  switch (value) {
  | (None, None, (), stops) =>
    [%expr `radialGradient([%e render_color_stop_list(~loc, stops)])]
  | _ => raise(Unsupported_feature)
  };
};

/* | #conicGradient(Angle.t, array<(Length.t, [< Color.t | Var.t] as 'colorOrVar)>) */
let render_function_conic_gradient =
    (~loc, value: Types.function_conic_gradient) => {
  switch (value) {
  | (None, None, (), stops) =>
    [%expr `conicGradient([%e render_angular_color_stop_list(~loc, stops)])]
  | _ => raise(Unsupported_feature)
  };
};

let render_gradient = (~loc, value: Types.gradient) =>
  switch (value) {
  | `Function_linear_gradient(lg) => render_function_linear_gradient(~loc, lg)
  | `Function_repeating_linear_gradient(rlg) =>
    render_function_repeating_linear_gradient(~loc, rlg)
  | `Function_radial_gradient(rg) => render_function_radial_gradient(~loc, rg)
  | `Function_repeating_radial_gradient(rrg) =>
    render_function_repeating_radial_gradient(~loc, rrg)
  | `Function_conic_gradient(angle) =>
    render_function_conic_gradient(~loc, angle)
  | `_legacy_gradient(_) => raise(Unsupported_feature)
  };

let render_image = (~loc, value: Types.image) =>
  switch (value) {
  | `Gradient(gradient) => render_gradient(~loc, gradient)
  | `Url(url) => [%expr `url([%e render_string(~loc, url)])]
  | `Interpolation(v) => render_variable(~loc, v)
  | `Function_element(_) => raise(Unsupported_feature)
  | `Function_paint(_) => raise(Unsupported_feature)
  | `Function_image(_) => raise(Unsupported_feature)
  | `Function_image_set(_) => raise(Unsupported_feature)
  | `Function_cross_fade(_) => raise(Unsupported_feature)
  };

let render_bg_image = (~loc, value: Types.bg_image) =>
  switch (value) {
  | `None => [%expr `none]
  | `Image(i) => render_image(~loc, i)
  };

let render_repeat_style = (~loc) =>
  fun
  | `Repeat_x => variant_to_expression(~loc, `Repeat_x)
  | `Repeat_y => variant_to_expression(~loc, `Repeat_y)
  | `Xor(values) => {
      let render_xor = (
        fun
        | `Repeat => [%expr `repeat]
        | `Space => [%expr `space]
        | `Round => [%expr `round]
        | `No_repeat => [%expr `noRepeat]
      );

      switch (values) {
      | [x] => [%expr [%e render_xor(x)]]
      | [x, y] => [%expr `hv(([%e render_xor(x)], [%e render_xor(y)]))]
      | [] => failwith("expected at least one value")
      | _ => failwith("repeat doesn't accept more then 2 values")
      };
    };

let render_attachment = (~loc) =>
  fun
  | `Fixed => [%expr `fixed]
  | `Local => [%expr `local]
  | `Scroll => [%expr `scroll];

let background_image =
  apply(
    Parser.property_background_image,
    (~loc) => [%expr CssJs.backgroundImage],
    (~loc) =>
      fun
      | [] => failwith("expected at least one value")
      | [i] => render_bg_image(~loc, i)
      | _ => raise(Unsupported_feature),
  );

let background_repeat =
  apply(
    Parser.property_background_repeat,
    (~loc) => [%expr CssJs.backgroundRepeat],
    (~loc) =>
      fun
      | [] => failwith("expected at least one value")
      | [`Repeat_x] => variant_to_expression(~loc, `Repeat_x)
      | [`Repeat_y] => variant_to_expression(~loc, `Repeat_y)
      | [`Xor(_) as v] => render_repeat_style(~loc, v)
      | _ => raise(Unsupported_feature),
  );
let background_attachment =
  apply(
    Parser.property_background_attachment,
    (~loc) => [%expr CssJs.backgroundAttachment],
    (~loc) =>
      fun
      | [] => failwith("expected at least one argument")
      | [v] => render_attachment(~loc, v)
      | _ => raise(Unsupported_feature),
  );

let render_background_position = (~loc, position) => {
  let render_static =
    fun
    | `Center => variant_to_expression(~loc, `Center)
    | `Left => variant_to_expression(~loc, `Left)
    | `Right => variant_to_expression(~loc, `Right)
    | `Bottom => variant_to_expression(~loc, `Bottom)
    | `Top => variant_to_expression(~loc, `Top)
    | `Extended_length(l) => render_extended_length(~loc, l)
    | `Extended_percentage(p) => render_extended_percentage(~loc, p);

  let render_and =
    fun
    | `Center => [%expr `center]
    | `Static(a, b) =>
      switch (b) {
      | Some(b) =>
        [%expr `hv(([%e render_static(a)], [%e render_static(b)]))]
      | None => render_static(a)
      };

  switch (position) {
  | `Center => variant_to_expression(~loc, `Center)
  | `Left => variant_to_expression(~loc, `Left)
  | `Right => variant_to_expression(~loc, `Right)
  | `Bottom => variant_to_expression(~loc, `Bottom)
  | `Top => variant_to_expression(~loc, `Top)
  | `Extended_length(l) => render_extended_length(~loc, l)
  | `Extended_percentage(a) => render_extended_percentage(~loc, a)
  | `Static(x, y) =>
    [%expr `hv(([%e render_static(x)], [%e render_static(y)]))]
  | `And(left, right) =>
    [%expr `hv(([%e render_and(left)], [%e render_and(right)]))]
  };
};

let background_position =
  apply(
    Parser.property_background_position,
    (~loc) => [%expr CssJs.backgroundPosition],
    (~loc) =>
      fun
      | [] => failwith("expected at least one argument")
      | [l] => render_background_position(~loc, l)
      | _ => raise(Unsupported_feature),
  );
let background_clip =
  apply(
    Parser.property_background_clip,
    (~loc) => [%expr CssJs.backgroundClip],
    (~loc) =>
      fun
      | [] => failwith("expected at least one argument")
      | [v] => variant_to_expression(~loc, v)
      | _ => raise(Unsupported_feature),
  );
let background_origin =
  apply(
    Parser.property_background_origin,
    (~loc) => [%expr CssJs.backgroundOrigin],
    (~loc) =>
      fun
      | [] => failwith("expected at least one argument")
      | [v] => variant_to_expression(~loc, v)
      | _ => raise(Unsupported_feature),
  );

let background_size =
  apply(
    Parser.property_background_size,
    (~loc) => [%expr CssJs.backgroundSize],
    (~loc) =>
      fun
      | [] => failwith("expected at least one argument")
      | [v] => render_bg_size(~loc, v)
      | _ => raise(Unsupported_feature),
  );

let render_background = (~loc, background: Types.property_background) => {
  let (layers, final_layer) = background;
  let render_layer = (layer, fn, render) =>
    layer
    |> Option.fold(~none=[], ~some=l => [[%expr [%e fn]([%e render(l)])]]);

  let render_layers = (value: Types.bg_layer) => {
    let (image, position, repeat_style, attachment, clip, origin) = value;
    [
      render_layer(
        image,
        [%expr CssJs.backgroundImage],
        render_bg_image(~loc),
      ),
      render_layer(
        repeat_style,
        [%expr CssJs.backgroundRepeat],
        render_repeat_style(~loc),
      ),
      render_layer(
        attachment,
        [%expr CssJs.backgroundRepeat],
        render_attachment(~loc),
      ),
      render_layer(
        clip,
        [%expr CssJs.backgroundClip],
        variant_to_expression(~loc),
      ),
      render_layer(
        origin,
        [%expr CssJs.backgroundOrigin],
        variant_to_expression(~loc),
      ),
    ]
    @ (
      switch (position) {
      | Some((pos, Some(((), size)))) => [
          [
            [%expr
              CssJs.backgroundPosition(
                [%e render_background_position(~loc, pos)],
              )
            ],
          ],
          [[%expr CssJs.backgroundSize([%e render_bg_size(~loc, size)])]],
        ]
      | Some((pos, None)) => [
          [
            [%expr
              CssJs.backgroundPosition(
                [%e render_background_position(~loc, pos)],
              )
            ],
          ],
        ]
      | None => []
      }
    );
  };

  let render_final_layer = (value: Types.final_bg_layer) => {
    let (color, image, position, repeat_style, attachment, clip, origin) = value;
    [
      render_layer(color, [%expr CssJs.backgroundColor], render_color(~loc)),
      render_layer(
        image,
        [%expr CssJs.backgroundImage],
        render_bg_image(~loc),
      ),
      render_layer(
        repeat_style,
        [%expr CssJs.backgroundRepeat],
        render_repeat_style(~loc),
      ),
      render_layer(
        attachment,
        [%expr CssJs.backgroundRepeat],
        render_attachment(~loc),
      ),
      render_layer(
        clip,
        [%expr CssJs.backgroundClip],
        variant_to_expression(~loc),
      ),
      render_layer(
        origin,
        [%expr CssJs.backgroundOrigin],
        variant_to_expression(~loc),
      ),
    ]
    @ (
      switch (position) {
      | Some((pos, Some(((), size)))) => [
          [
            [%expr
              CssJs.backgroundPosition(
                [%e render_background_position(~loc, pos)],
              )
            ],
          ],
          [[%expr CssJs.backgroundSize([%e render_bg_size(~loc, size)])]],
        ]
      | Some((pos, None)) => [
          [
            [%expr
              CssJs.backgroundPosition(
                [%e render_background_position(~loc, pos)],
              )
            ],
          ],
        ]
      | None => []
      }
    );
  };

  List.concat([
    render_final_layer(final_layer) |> List.flatten,
    layers |> List.concat_map(x => x |> fst |> render_layers) |> List.flatten,
  ]);
};

let background =
  emit(Parser.property_background, (~loc as _) => id, render_background);

let border_top_color =
  apply(
    Parser.property_border_top_color,
    (~loc) => [%expr CssJs.borderTopColor],
    render_color,
  );

let border_right_color =
  apply(
    Parser.property_border_right_color,
    (~loc) => [%expr CssJs.borderRightColor],
    render_color,
  );

let border_bottom_color =
  apply(
    Parser.property_border_bottom_color,
    (~loc) => [%expr CssJs.borderBottomColor],
    render_color,
  );

let border_left_color =
  apply(
    Parser.property_border_left_color,
    (~loc) => [%expr CssJs.borderLeftColor],
    render_color,
  );

let border_color =
  apply(
    Parser.property_border_color,
    (~loc) => [%expr CssJs.borderColor],
    (~loc) =>
      fun
      | [c] => render_color(~loc, c)
      | _ => raise(Unsupported_feature),
  );

let border_top_style =
  variants(Parser.property_border_top_style, (~loc) =>
    [%expr CssJs.borderTopStyle]
  );

let border_right_style =
  variants(Parser.property_border_right_style, (~loc) =>
    [%expr CssJs.borderRightStyle]
  );
let border_bottom_style =
  variants(Parser.property_border_bottom_style, (~loc) =>
    [%expr CssJs.borderBottomStyle]
  );
let border_left_style =
  variants(Parser.property_border_left_style, (~loc) =>
    [%expr CssJs.borderLeftStyle]
  );
let border_style =
  apply(
    Parser.property_border_style,
    (~loc) => [%expr CssJs.borderStyle],
    variant_to_expression,
  );

let render_line_width = (~loc) =>
  fun
  | `Extended_length(l) => render_extended_length(~loc, l)
  /* Missing `Medium, `Thick, `Thin on the bs-css bindings */
  | _ => raise(Unsupported_feature);

let border_top_width =
  apply(
    Parser.property_border_top_width,
    (~loc) => [%expr CssJs.borderTopWidth],
    render_line_width,
  );
let border_right_width =
  apply(
    Parser.property_border_right_width,
    (~loc) => [%expr CssJs.borderRightWidth],
    render_line_width,
  );
let border_bottom_width =
  apply(
    Parser.property_border_bottom_width,
    (~loc) => [%expr CssJs.borderBottomWidth],
    render_line_width,
  );
let border_left_width =
  apply(
    Parser.property_border_left_width,
    (~loc) => [%expr CssJs.borderLeftWidth],
    render_line_width,
  );
let border_width =
  apply(
    Parser.property_border_width,
    (~loc) => [%expr CssJs.borderWidth],
    (~loc) =>
      fun
      | [w] => render_line_width(~loc, w)
      | _ => raise(Unsupported_feature),
  );

let render_line_width_interp = (~loc) =>
  fun
  | `Line_width(lw) => render_line_width(~loc, lw)
  | `Interpolation(name) => render_variable(~loc, name);

let render_border_style_interp = (~loc) =>
  fun
  | `Interpolation(name) => render_variable(~loc, name)
  | `Line_style(ls) => variant_to_expression(~loc, ls);

type borderDirection =
  | All
  | Left
  | Bottom
  | Right
  | Top;

let direction_to_border = (~loc) =>
  fun
  | All => [%expr CssJs.border]
  | Left => [%expr CssJs.borderLeft]
  | Bottom => [%expr CssJs.borderBottom]
  | Right => [%expr CssJs.borderRight]
  | Top => [%expr CssJs.borderTop];

let direction_to_fn_name = (~loc) =>
  fun
  | All => [%expr {js|border|js}]
  | Left => [%expr {js|borderLeft|js}]
  | Bottom => [%expr {js|borderBottom|js}]
  | Right => [%expr {js|borderRight|js}]
  | Top => [%expr {js|borderTop|js}];

let render_border = (~loc, ~direction: borderDirection, border) => {
  switch (border) {
  | `None =>
    let borderFn = direction_to_fn_name(~loc, direction);
    [[%expr CssJs.unsafe([%e borderFn], {js|none|js})]];
  | `Xor(`Interpolation(name)) =>
    let borderFn = direction_to_border(~loc, direction);
    [[%expr [%e borderFn]([%e render_variable(~loc, name)])]];
  /* bs-css doesn't support border: 1px; */
  | `Xor(_) => raise(Unsupported_feature)
  /* bs-css doesn't support border: 1px solid; */
  | `Static_0(_) => raise(Unsupported_feature)
  | `Static_1(width, style, color) =>
    let borderFn = direction_to_border(~loc, direction);
    [
      [%expr
        [%e borderFn](
          [%e render_line_width_interp(~loc, width)],
          [%e render_border_style_interp(~loc, style)],
          [%e render_color_interp(~loc, color)],
        )
      ],
    ];
  };
};

let render_outline_style_interp = (~loc) =>
  fun
  | `Auto => variant_to_expression(~loc, `Auto)
  | `Interpolation(name) => render_variable(~loc, name)
  | `Line_style(ls) => variant_to_expression(~loc, ls);

let render_outline = (~loc) =>
  fun
  | `None => [[%expr CssJs.unsafe({js|outline|js}, {js|none|js})]]
  | `Property_outline_width(`Interpolation(name)) => [
      [%expr CssJs.outline([%e render_variable(~loc, name)])],
    ]
  /* bs-css doesn't support outline: 1px; */
  | `Property_outline_width(_) => raise(Unsupported_feature)
  /* bs-css doesn't support outline: 1px solid; */
  | `Static_0(_) => raise(Unsupported_feature)
  | `Static_1(line_width, style, color) => [
      [%expr
        CssJs.outline(
          [%e render_line_width_interp(~loc, line_width)],
          [%e render_outline_style_interp(~loc, style)],
          [%e render_color_interp(~loc, color)],
        )
      ],
    ];

let outline =
  emit(Parser.property_outline, (~loc as _) => id, render_outline);

let outline_color =
  apply(
    Parser.property_outline_color,
    (~loc) => [%expr CssJs.outlineColor],
    render_color,
  );
let outline_offset =
  apply(
    Parser.property_outline_offset,
    (~loc) => [%expr CssJs.outlineOffset],
    render_extended_length,
  );
let outline_style =
  apply(
    Parser.property_outline_style,
    (~loc) => [%expr CssJs.outlineStyle],
    render_outline_style_interp,
  );
let outline_width =
  apply(
    Parser.property_outline_width,
    (~loc) => [%expr CssJs.outlineWidth],
    render_line_width_interp,
  );

let border =
  emit(
    Parser.property_border,
    (~loc as _) => id,
    render_border(~direction=All),
  );

let border_top =
  emit(
    Parser.property_border,
    (~loc as _) => id,
    render_border(~direction=Top),
  );

let border_right =
  emit(
    Parser.property_border,
    (~loc as _) => id,
    render_border(~direction=Right),
  );
let border_bottom =
  emit(
    Parser.property_border,
    (~loc as _) => id,
    render_border(~direction=Bottom),
  );
let border_left =
  emit(
    Parser.property_border,
    (~loc as _) => id,
    render_border(~direction=Left),
  );

let render_border_radius_value = (~loc) =>
  fun
  | [`Extended_length(l)] => render_extended_length(~loc, l)
  | [`Extended_percentage(p)] => render_extended_percentage(~loc, p)
  | _ => raise(Unsupported_feature);

let border_top_left_radius =
  apply(
    Parser.property_border_top_left_radius,
    (~loc) => [%expr CssJs.borderTopLeftRadius],
    render_border_radius_value,
  );
let border_top_right_radius =
  apply(
    Parser.property_border_top_right_radius,
    (~loc) => [%expr CssJs.borderTopRightRadius],
    render_border_radius_value,
  );
let border_bottom_right_radius =
  apply(
    Parser.property_border_bottom_right_radius,
    (~loc) => [%expr CssJs.borderBottomRightRadius],
    render_border_radius_value,
  );
let border_bottom_left_radius =
  apply(
    Parser.property_border_bottom_left_radius,
    (~loc) => [%expr CssJs.borderBottomLeftRadius],
    render_border_radius_value,
  );
let border_radius =
  apply(
    Parser.property_border_radius,
    (~loc) => [%expr CssJs.borderRadius],
    render_length_percentage,
  );
let border_image_source =
  unsupportedProperty(Parser.property_border_image_source);
let border_image_slice =
  unsupportedProperty(Parser.property_border_image_slice);
let border_image_width =
  unsupportedProperty(Parser.property_border_image_width);
let border_image_outset =
  unsupportedProperty(Parser.property_border_image_outset);
let border_image_repeat =
  unsupportedProperty(Parser.property_border_image_repeat);
let border_image = unsupportedProperty(Parser.property_border_image);

let box_shadow =
  emit(
    Parser.property_box_shadow,
    (~loc as _, id) => id,
    (~loc, value: Types.property_box_shadow) =>
      switch (value) {
      | `Interpolation(variable) =>
        /* Here we rely on boxShadow*s* which makes the value be an array */
        let var = render_variable(~loc, variable);
        [[%expr CssJs.boxShadows([%e var])]];
      | `None =>
        let none = variant_to_expression(~loc, `None);
        [[%expr CssJs.boxShadow([%e none])]];
      | `Shadow(shadows) =>
        let shadows = shadows |> List.map(render_box_shadow(~loc));
        let shadows = Builder.pexp_array(~loc, shadows);
        [[%expr CssJs.boxShadows([%e shadows])]];
      },
  );

// css-overflow-3
let overflow_x =
  variants(Parser.property_overflow_x, (~loc) => [%expr CssJs.overflowX]);

let overflow_y =
  variants(Parser.property_overflow_y, (~loc) => [%expr CssJs.overflowY]);

let overflow =
  emit(
    Parser.property_overflow,
    (~loc as _) => id,
    (~loc) =>
      fun
      | `Xor([all]) => [
          [%expr CssJs.overflow([%e variant_to_expression(~loc, all)])],
        ]
      | `Xor([x, y]) => [
          [%expr CssJs.overflowX([%e variant_to_expression(~loc, x)])],
          [%expr CssJs.overflowY([%e variant_to_expression(~loc, y)])],
        ]
      | _ => failwith("unreachable"),
  );

// let overflow_clip_margin = unsupportedProperty(Parser.property_overflow_clip_margin);
let overflow_inline = unsupportedProperty(Parser.property_overflow_inline);

/* let overflow_inline =
   apply(
     Parser.property_overflow_inline,
     (~loc) => [%expr "overflow-inline"],
     (~loc, value) => switch (value: Types.property_overflow_inline) {
       | `Auto => [%expr "auto"]
       | `Clip => [%expr "clip"]
       | `Hidden => [%expr "hidden"]
       | `Paged => [%expr "paged"]
       | `Scroll => [%expr "scroll"]
       | `Visible => [%expr "visible"]
       | `None => [%expr "none"]
       | `Optional_paged => [%expr "optional-paged"]
     }
   ); */

let text_overflow =
  apply(
    Parser.property_text_overflow,
    (~loc) => [%expr CssJs.textOverflow],
    (~loc) =>
      fun
      | [one] =>
        switch (one) {
        | `Clip => variant_to_expression(~loc, `Clip)
        | `Ellipsis => variant_to_expression(~loc, `Ellipsis)
        | `String(str) => [%expr `string([%e render_string(~loc, str)])]
        }
      | []
      | _ => raise(Unsupported_feature),
  );
// let block_ellipsis = unsupportedProperty(Parser.property_block_ellipsis);
let max_lines = unsupportedProperty(Parser.property_max_lines);
// let continue = unsupportedProperty(Parser.property_continue);

// css-text-3
let text_transform =
  variants(Parser.property_text_transform, (~loc) =>
    [%expr CssJs.textTransform]
  );
let white_space =
  variants(Parser.property_white_space, (~loc) => [%expr CssJs.whiteSpace]);
let tab_size = unsupportedProperty(Parser.property_tab_size);
let word_break =
  variants(Parser.property_word_break, (~loc) => [%expr CssJs.wordBreak]);
let line_break = unsupportedProperty(Parser.property_line_break);
let render_line_height = (~loc) =>
  fun
  | `Extended_length(ext) => render_extended_length(~loc, ext)
  | `Extended_percentage(ext) => render_extended_percentage(~loc, ext)
  | `Normal => variant_to_expression(~loc, `Normal)
  | `Number(float) => [%expr `abs([%e render_number(~loc, float)])];

let line_height =
  apply(
    Parser.property_line_height,
    (~loc) => [%expr CssJs.lineHeight],
    render_line_height,
  );
let line_height_step =
  apply(
    Parser.property_line_height_step,
    (~loc) => [%expr CssJs.lineHeightStep],
    render_extended_length,
  );
let hyphens = unsupportedProperty(Parser.property_hyphens);
let overflow_wrap =
  variants(Parser.property_overflow_wrap, (~loc) =>
    [%expr CssJs.overflowWrap]
  );
let word_wrap =
  variants(Parser.property_word_wrap, (~loc) => [%expr CssJs.wordWrap]);
let text_align =
  variants(Parser.property_text_align, (~loc) => [%expr CssJs.textAlign]);
// let text_align_all = unsupportedProperty(Parser.property_text_align_all);
let text_align_last = unsupportedProperty(Parser.property_text_align_last);
let text_justify = unsupportedProperty(Parser.property_text_justify);
let word_spacing =
  apply(
    Parser.property_word_spacing,
    (~loc) => [%expr CssJs.wordSpacing],
    (~loc) =>
      fun
      | `Normal => variant_to_expression(~loc, `Normal)
      | `Extended_length(l) => render_extended_length(~loc, l)
      | `Extended_percentage(p) => render_extended_percentage(~loc, p),
  );
let letter_spacing =
  apply(
    Parser.property_word_spacing,
    (~loc) => [%expr CssJs.letterSpacing],
    (~loc) =>
      fun
      | `Normal => variant_to_expression(~loc, `Normal)
      | `Extended_length(l) => render_extended_length(~loc, l)
      | `Extended_percentage(p) => render_extended_percentage(~loc, p),
  );
let text_indent =
  apply(
    Parser.property_text_indent,
    (~loc) => [%expr CssJs.textIndent],
    (~loc) =>
      fun
      | (`Extended_length(l), None, None) => render_extended_length(~loc, l)
      | (`Extended_percentage(p), None, None) =>
        render_extended_percentage(~loc, p)
      | _ => raise(Unsupported_feature),
  );
let hanging_punctuation =
  unsupportedProperty(Parser.property_hanging_punctuation);

let render_generic_family = (~loc) =>
  fun
  | `Cursive => [%expr `cursive]
  | `Fantasy => [%expr `fantasy]
  | `Monospace => [%expr `monospace]
  | `Sans_serif => [%expr `sansSerif]
  | `Serif => [%expr `serif]
  | `_apple_system => [%expr `custom("-apple-system")];

let render_fony_family = (~loc) =>
  fun
  | `Interpolation(v) => render_variable(~loc, v)
  | `Generic_family(v) => render_generic_family(~loc, v)
  | `Family_name(`String(str)) => [%expr
      `custom([%e render_string(~loc, str)])
    ]
  | `Family_name(`Custom_ident(_list)) => raise(Unsupported_feature);

let render_fony_families = (~loc, v) =>
  List.map(render_fony_family(~loc), v) |> Builder.pexp_array(~loc);

// css-fonts-4
let font_family =
  emit(
    Parser.property_font_family,
    (~loc as _) => id,
    (~loc) =>
      fun
      | [v] => [[%expr CssJs.fontFamily([%e render_fony_family(~loc, v)])]]
      | rest => [
          [%expr CssJs.fontFamilies([%e render_fony_families(~loc, rest)])],
        ],
  );

let render_font_weight = (~loc) =>
  fun
  | `Interpolation(v) => render_variable(~loc, v)
  | `Bolder => variant_to_expression(~loc, `Bolder)
  | `Lighter => variant_to_expression(~loc, `Lighter)
  | `Font_weight_absolute(`Normal) => variant_to_expression(~loc, `Normal)
  | `Font_weight_absolute(`Bold) => variant_to_expression(~loc, `Bold)
  | `Font_weight_absolute(`Number(num)) => [%expr
      `num([%e render_number(~loc, num)])
    ];

let font_weight =
  apply(
    Parser.property_font_weight,
    (~loc) => [%expr CssJs.fontWeight],
    render_font_weight,
  );

let font_stretch = unsupportedProperty(Parser.property_font_stretch);

let render_font_style = (~loc) =>
  fun
  | `Normal => variant_to_expression(~loc, `Normal)
  | `Italic => variant_to_expression(~loc, `Italic)
  | `Oblique => variant_to_expression(~loc, `Oblique)
  | `Interpolation(v) => render_variable(~loc, v)
  | `Static(_) => raise(Unsupported_feature);

let font_style =
  apply(
    Parser.property_font_style,
    (~loc) => [%expr CssJs.fontStyle],
    render_font_style,
  );

/* bs-css does not support these variants */
let render_absolute_size = (~loc, value: Types.absolute_size) =>
  switch (value) {
  | `Large => id([%expr `large])
  | `Medium => id([%expr `medium])
  | `Small => id([%expr `small])
  | `X_large => id([%expr `x_large])
  | `X_small => id([%expr `x_small])
  | `Xx_large => id([%expr `xx_large])
  | `Xx_small => id([%expr `xx_small])
  | `Xxx_large => id([%expr `xxx_large])
  };

let render_relative_size = (~loc, value: Types.relative_size) =>
  switch (value) {
  | `Larger => id([%expr `larger])
  | `Smaller => id([%expr `smaller])
  };

let render_font_size = (~loc, value: Types.property_font_size) =>
  switch (value) {
  | `Absolute_size(size) => render_absolute_size(~loc, size)
  | `Relative_size(size) => render_relative_size(~loc, size)
  | `Extended_length(ext) => render_extended_length(~loc, ext)
  | `Extended_percentage(ext) => render_extended_percentage(~loc, ext)
  };

let font_size =
  apply(
    Parser.property_font_size,
    (~loc) => [%expr CssJs.fontSize],
    render_font_size,
  );

let font_size_adjust = unsupportedProperty(Parser.property_font_size_adjust);
let font = unsupportedProperty(Parser.property_font);
// let font_synthesis_weight = unsupportedProperty(Parser.property_font_synthesis_weight);
// let font_synthesis_style = unsupportedProperty(Parser.property_font_synthesis_style);
// let font_synthesis_small_caps =
// unsupportedProperty(Parser.property_font_synthesis_small_caps);
let font_synthesis = unsupportedProperty(Parser.property_font_synthesis);
let font_kerning = unsupportedProperty(Parser.property_font_kerning);
let font_variant_ligatures =
  unsupportedProperty(Parser.property_font_variant_ligatures);
let font_variant_position =
  unsupportedProperty(Parser.property_font_variant_position);
let font_variant_caps =
  unsupportedProperty(Parser.property_font_variant_caps);
let font_variant_numeric =
  unsupportedProperty(Parser.property_font_variant_numeric);
let font_variant_alternates =
  unsupportedProperty(Parser.property_font_variant_alternates);
let font_variant_east_asian =
  unsupportedProperty(Parser.property_font_variant_east_asian);

let font_variant =
  emit(
    Parser.property_font_variant,
    (~loc as _) => id,
    (~loc) =>
      fun
      | `None => [[%expr CssJs.unsafe({|fontVariant|}, {|none|})]]
      | `Normal => [[%expr CssJs.fontVariant(`normal)]]
      | `Small_caps => [[%expr CssJs.fontVariant(`smallCaps)]]
      | _ => raise(Unsupported_feature),
  );
let font_feature_settings =
  unsupportedProperty(Parser.property_font_feature_settings);
let font_optical_sizing =
  unsupportedProperty(Parser.property_font_optical_sizing);
let font_variation_settings =
  unsupportedProperty(Parser.property_font_variation_settings);
// let font_palette = unsupportedProperty(Parser.property_font_palette);
// let font_variant_emoji = unsupportedProperty(Parser.property_font_variant_emoji);

// css-text-decor-3
let render_text_decoration_line =
    (~loc, value: Types.property_text_decoration_line) =>
  switch (value) {
  | `None => variant_to_expression(~loc, `None)
  | `Xor([`Underline]) => variant_to_expression(~loc, `Underline)
  | `Xor([`Overline]) => variant_to_expression(~loc, `Overline)
  | `Xor([`Line_through]) => variant_to_expression(~loc, `Line_Through)
  | `Xor([`Blink]) => variant_to_expression(~loc, `Blink)
  /* bs-css doesn't support multiple text decoration line */
  | `Xor(_) => raise(Unsupported_feature)
  };

let text_decoration_line =
  apply(
    Parser.property_text_decoration_line,
    (~loc) => [%expr CssJs.textDecorationLine],
    render_text_decoration_line,
  );

let render_text_decoration_style = (~loc) =>
  fun
  | `Solid => variant_to_expression(~loc, `Solid)
  | `Double => variant_to_expression(~loc, `Double)
  | `Dotted => variant_to_expression(~loc, `Dotted)
  | `Dashed => variant_to_expression(~loc, `Dashed)
  | `Wavy => variant_to_expression(~loc, `Wavy);

let text_decoration_style =
  apply(
    Parser.property_text_decoration_style,
    (~loc) => [%expr CssJs.textDecorationStyle],
    render_text_decoration_style,
  );

let text_decoration_color =
  apply(
    Parser.property_text_decoration_color,
    (~loc) => [%expr CssJs.textDecorationColor],
    render_color,
  );
let text_decoration_thickness =
  unsupportedProperty(Parser.property_text_decoration_thickness);

let render_text_decoration_thickness = (~loc) =>
  fun
  | `Auto => variant_to_expression(~loc, `Auto)
  | `From_font => variant_to_expression(~loc, `From_font)
  | `Extended_length(l) => render_extended_length(~loc, l)
  | `Extended_percentage(p) => render_extended_percentage(~loc, p);

let _text_decoration_thickness =
  apply(
    Parser.property_text_decoration_thickness,
    (~loc) => [%expr CssJs.textDecorationThickness],
    render_text_decoration_thickness,
  );

/* let render_text_decoration_with_thickness = (~loc, (line, style, color, thickness)) => {
     let _line = line |> Option.map(render_text_decoration_line(~loc));
     let _style = style |> Option.map(render_text_decoration_style(~loc));
     let _color = color |> Option.map(render_color(~loc));
     let _thickness = thickness |> Option.map(render_text_decoration_thickness(~loc));
     // let properties = [line, style, color, thickness];
     // let properties = List.filter((_, v) => v != [], properties);
     // let properties = List.map((_, v) => v, properties);
     // let properties = List.flatten(properties);
     // properties;
   }; */

/* let render_text_decoration = (~loc, (line, style, color)) => {
     let _line = line |> Option.map(render_text_decoration_line(~loc));
     let _style = style |> Option.map(render_text_decoration_style(~loc));
     let _color = color |> Option.map(render_color(~loc));
     // let properties = [line, style, color, thickness];
     // let properties = List.filter((_, v) => v != [], properties);
     // let properties = List.map((_, v) => v, properties);
     // let properties = List.flatten(properties);
     // properties;
     [%expr `none];
   }; */

let text_decoration =
  apply(
    Parser.property_text_decoration,
    (~loc) => [%expr CssJs.textDecoration],
    (~loc, v) =>
      switch (v) {
      | (Some(l), _, _, _) => render_text_decoration_line(~loc, l)
      | (_l, _s, _c, Some(_)) /* render_text_decoration_with_thickness(~loc, v) */
      | (_l, _s, _c, None) => raise(Unsupported_feature)
      },
  );

let text_underline_position =
  unsupportedProperty(Parser.property_text_underline_position);
let text_underline_offset =
  unsupportedProperty(Parser.property_text_underline_offset);
let text_decoration_skip =
  unsupportedProperty(Parser.property_text_decoration_skip);
// let text_decoration_skip_self =
//   unsupportedProperty(Parser.property_text_decoration_skip_self);
// let text_decoration_skip_box = unsupportedProperty(Parser.property_text_decoration_skip_box);
// let text_decoration_skip_inset =
//   unsupportedProperty(Parser.property_text_decoration_skip_inset);
// let text_decoration_skip_spaces =
//   unsupportedProperty(Parser.property_text_decoration_skip_spaces);
let text_decoration_skip_ink =
  unsupportedProperty(Parser.property_text_decoration_skip_ink);
let text_emphasis_style =
  unsupportedProperty(Parser.property_text_emphasis_style);
let text_emphasis_color =
  unsupportedProperty(Parser.property_text_emphasis_color);
let text_emphasis = unsupportedProperty(Parser.property_text_emphasis);
let text_emphasis_position =
  unsupportedProperty(Parser.property_text_emphasis_position);
// let text_emphasis_skip = unsupportedProperty(Parser.property_text_emphasis_skip);

let render_text_shadow = (~loc, shadow) => {
  let (x, y, blur, color) =
    switch (shadow) {
    | ([x, y], None) => (x, y, None, None)
    | ([x, y, blur], None) => (x, y, Some(blur), None)
    | ([x, y, blur], color) => (x, y, Some(blur), color)
    | _ => failwith("unreachable")
    };

  let args =
    [
      (Labelled("x"), Some(render_length_interp(~loc, x))),
      (Labelled("y"), Some(render_length_interp(~loc, y))),
      (Labelled("blur"), Option.map(render_length_interp(~loc), blur)),
      (
        Nolabel,
        Some(
          color
          |> Option.mapWithDefault(
               render_color_interp(~loc),
               [%expr `Color(`CurrentColor)],
             ),
        ),
      ),
    ]
    |> List.filter_map(((label, value)) =>
         Option.map(value => (label, value), value)
       );

  Helper.Exp.apply(~loc, [%expr CssJs.Shadow.text], args);
};

let text_shadow =
  emit(
    Parser.property_text_shadow,
    (~loc as _) => id,
    (~loc) =>
      fun
      | `Interpolation(variable) => [
          [%expr CssJs.textShadows([%e render_variable(~loc, variable)])],
        ]
      | `None => [
          [%expr CssJs.textShadow([%e variant_to_expression(~loc, `None)])],
        ]
      | `Shadow_t([shadow]) => [
          [%expr CssJs.textShadow([%e render_text_shadow(~loc, shadow)])],
        ]
      | `Shadow_t(shadows) => {
          let shadows = shadows |> List.map(render_text_shadow(~loc));
          [
            [%expr CssJs.textShadows([%e Builder.pexp_array(~loc, shadows)])],
          ];
        },
  );

let render_transform_functions = (~loc) =>
  fun
  | `Zero(_) => [%expr `zero]
  | `Extended_angle(a) => [%expr [%e render_extended_angle(~loc, a)]];

let render_transform = (~loc, value: Types.transform_function) =>
  switch (value) {
  | `Function_perspective(_) => raise(Unsupported_feature)
  | `Function_matrix(_) => raise(Unsupported_feature)
  | `Function_matrix3d(_) => raise(Unsupported_feature)
  | `Function_rotate(v) =>
    [%expr CssJs.rotate([%e render_transform_functions(~loc, v)])]
  | `Function_rotate3d(x, (), y, (), z, (), a) =>
    [%expr
     CssJs.rotate3d(
       [%e render_number(~loc, x)],
       [%e render_number(~loc, y)],
       [%e render_number(~loc, z)],
       [%e render_transform_functions(~loc, a)],
     )]
  | `Function_rotateX(v) =>
    [%expr CssJs.rotateX([%e render_transform_functions(~loc, v)])]
  | `Function_rotateY(v) =>
    [%expr CssJs.rotateY([%e render_transform_functions(~loc, v)])]
  | `Function_rotateZ(v) =>
    [%expr CssJs.rotateZ([%e render_transform_functions(~loc, v)])]
  | `Function_skew(a1, a2) =>
    switch (a2) {
    | Some(((), v)) =>
      [%expr
       CssJs.skew(
         [%e render_transform_functions(~loc, a1)],
         [%e render_transform_functions(~loc, v)],
       )]
    | None =>
      [%expr CssJs.skew([%e render_transform_functions(~loc, a1)], 0)]
    }
  | `Function_skewX(v) =>
    [%expr CssJs.skewX([%e render_transform_functions(~loc, v)])]
  | `Function_skewY(v) =>
    [%expr CssJs.skewY([%e render_transform_functions(~loc, v)])]
  | `Function_translate(x, None) =>
    [%expr CssJs.translate([%e render_length_percentage(~loc, x)], 0)]
  | `Function_translate(x, Some(((), v))) =>
    [%expr
     CssJs.translate(
       [%e render_length_percentage(~loc, x)],
       [%e render_length_percentage(~loc, v)],
     )]
  | `Function_translate3d(x, (), y, (), z) =>
    [%expr
     CssJs.translate3d(
       [%e render_length_percentage(~loc, x)],
       [%e render_length_percentage(~loc, y)],
       [%e render_extended_length(~loc, z)],
     )]
  | `Function_translateX(x) =>
    [%expr CssJs.translateX([%e render_length_percentage(~loc, x)])]
  | `Function_translateY(y) =>
    [%expr CssJs.translateY([%e render_length_percentage(~loc, y)])]
  | `Function_translateZ(z) =>
    [%expr CssJs.translateZ([%e render_extended_length(~loc, z)])]
  | `Function_scale(x, None) =>
    [%expr
     CssJs.scale([%e render_number(~loc, x)], [%e render_number(~loc, x)])]
  | `Function_scale(x, Some(((), v))) =>
    [%expr
     CssJs.scale([%e render_number(~loc, x)], [%e render_number(~loc, v)])]
  | `Function_scale3d(x, (), y, (), z) =>
    [%expr
     CssJs.scale3d(
       [%e render_number(~loc, x)],
       [%e render_number(~loc, y)],
       [%e render_number(~loc, z)],
     )]
  | `Function_scaleX(x) => [%expr CssJs.scaleX([%e render_number(~loc, x)])]
  | `Function_scaleY(y) => [%expr CssJs.scaleY([%e render_number(~loc, y)])]
  | `Function_scaleZ(z) => [%expr CssJs.scaleZ([%e render_number(~loc, z)])]
  };

// css-transforms-2
let transform =
  emit(
    Parser.property_transform,
    (~loc as _) => id,
    (~loc) =>
      fun
      | `None => [[%expr CssJs.transform(`none)]]
      | `Transform_list([one]) => [
          [%expr CssJs.transform([%e render_transform(~loc, one)])],
        ]
      | `Transform_list(list) => {
          let transforms =
            List.map(render_transform(~loc), list)
            |> Builder.pexp_array(~loc);
          [[%expr CssJs.transforms([%e transforms])]];
        },
  );

let render_origin = (~loc) =>
  fun
  | `Center => variant_to_expression(~loc, `Center)
  | `Left => variant_to_expression(~loc, `Left)
  | `Right => variant_to_expression(~loc, `Right)
  | `Bottom => variant_to_expression(~loc, `Bottom)
  | `Top => variant_to_expression(~loc, `Top)
  | `Function_calc(fc) => render_function_calc(~loc, fc)
  | `Interpolation(v) => render_variable(~loc, v)
  | `Length(l) => render_length(~loc, l)
  | `Extended_length(l) => render_extended_length(~loc, l)
  | `Extended_percentage(p) => render_extended_percentage(~loc, p);

let transform_origin =
  emit(
    Parser.property_transform_origin,
    (~loc as _) => id,
    (~loc) =>
      fun
      /* x, y are swapped on purpose */
      | `Static((y, x), None) => {
          [
            [%expr
              CssJs.transformOrigin(
                [%e render_origin(~loc, x)],
                [%e render_origin(~loc, y)],
              )
            ],
          ];
        }
      | `Center => [[%expr CssJs.transformOrigin(`Center, `Center)]]
      | `Left => [[%expr CssJs.transformOrigin(`Left, `Center)]]
      | `Right => [[%expr CssJs.transformOrigin(`Right, `Center)]]
      | `Bottom => [[%expr CssJs.transformOrigin(`Bottom, `Center)]]
      | `Top => [[%expr CssJs.transformOrigin(`Top, `Center)]]
      | `Static(_, Some(_))
      | `Extended_length(_)
      | `Extended_percentage(_) => raise(Unsupported_feature),
  );
let transform_box = unsupportedProperty(Parser.property_transform_box);
let translate =
  unsupportedValue(Parser.property_translate, (~loc) =>
    [%expr CssJs.translate]
  );
let rotate =
  unsupportedValue(Parser.property_rotate, (~loc) => [%expr CssJs.rotate]);
let scale =
  unsupportedValue(Parser.property_scale, (~loc) => [%expr CssJs.scale]);
let transform_style =
  apply(
    Parser.property_transform_style,
    (~loc) => [%expr CssJs.transformStyle],
    (~loc) =>
      fun
      | `Flat => variant_to_expression(~loc, `Flat)
      | `Preserve_3d => variant_to_expression(~loc, `Preserve_3d),
  );
let perspective = unsupportedProperty(Parser.property_perspective);

let perspective_origin =
  emit(
    Parser.property_perspective_origin,
    (~loc as _) => id,
    (~loc, position) => {
      let (x, y) = render_position(~loc, position);
      [[%expr CssJs.perspectiveOrigin([%e x], [%e y])]];
    },
  );

let backface_visibility =
  variants(Parser.property_backface_visibility, (~loc) =>
    [%expr CssJs.backfaceVisibility]
  );

let render_single_transition = (~loc, value: Types.single_transition_property) => {
  switch (value) {
  | `All => render_string(~loc, "all")
  | `Custom_ident(v) => render_string(~loc, v)
  | `Interpolation(v) => render_variable(~loc, v)
  };
};

// css-transition-1
let transition_property =
  apply(
    Parser.property_transition_property,
    (~loc) => [%expr CssJs.transitionProperty],
    (~loc) =>
      fun
      | `None => render_string(~loc, "none")
      | `Single_transition_property([transition]) =>
        render_single_transition(~loc, transition)
      /* bs-css unsupports multiple transition_properties,
         but should be easy to bypass with string concatenation */
      | `Single_transition_property(_) => raise(Unsupported_feature),
  );

/* bs-css doesn't support `S. PR: https://github.com/giraud/bs-css/pull/264 */
/* let render_time = (~loc) => fun
   | `Ms(f) => {
     let value = int_of_float(f);
     [%expr `ms([%e render_integer(~loc, value)])]
   }
   | `S(f) => {
     let value = int_of_float(f);
     [%expr `s([%e render_integer(~loc, value)])]
   }; */

let render_time_as_int = (~loc) =>
  fun
  | `Ms(f) => {
      let value = int_of_float(f);
      [%expr [%e render_integer(~loc, value)]];
    }
  | `S(f) => {
      let value = f *. 1000.0 |> int_of_float;
      [%expr [%e render_integer(~loc, value)]];
    };

let render_duration = (~loc) =>
  fun
  | `Time(t) => render_time_as_int(~loc, t)
  | `Function_calc(fc) => render_function_calc(~loc, fc)
  | `Interpolation(v) => render_variable(~loc, v);

let transition_duration =
  apply(
    Parser.property_transition_duration,
    (~loc) => [%expr CssJs.transitionDuration],
    (~loc) =>
      fun
      | [] => [%expr `none]
      | [one] => render_duration(~loc, one)
      | _ => raise(Unsupported_feature),
  );
let widows =
  apply(
    Parser.property_widows,
    (~loc) => [%expr CssJs.widows],
    render_integer,
  );

let render_cubic_bezier_timing_function = (~loc) =>
  fun
  | `Ease => [%expr `ease]
  | `Ease_in => [%expr `easeIn]
  | `Ease_out => [%expr `easeOut]
  | `Ease_in_out => [%expr `easeInOut]
  | `Cubic_bezier(p0, (), p1, (), p2, (), p3) => [%expr
      `cubicBezier((
        [%e render_number(~loc, p0)],
        [%e render_number(~loc, p1)],
        [%e render_number(~loc, p2)],
        [%e render_number(~loc, p3)],
      ))
    ];

let render_step_position = (~loc) =>
  fun
  | `Start => [%expr `start]
  | `End => [%expr `end_]
  | `Jump_start
  | `Jump_end
  | `Jump_none
  | `Jump_both => raise(Unsupported_feature);

let render_steps_function = (~loc) =>
  fun
  | `Step_start => [%expr `stepStart]
  | `Step_end => [%expr `stepEnd]
  | `Steps(int, Some((_, step_position))) => [%expr
      `steps((
        [%e render_integer(~loc, int)],
        [%e render_step_position(~loc, step_position)],
      ))
    ]
  | `Steps(_, None) => raise(Unsupported_feature);

let render_timing = (~loc) =>
  fun
  | `Linear => [%expr `linear]
  | `Cubic_bezier_timing_function(v) =>
    render_cubic_bezier_timing_function(~loc, v)
  | `Step_timing_function(v) => render_steps_function(~loc, v);

let transition_timing_function =
  apply(
    Parser.property_transition_timing_function,
    (~loc) => [%expr CssJs.transitionTimingFunction],
    (~loc) =>
      fun
      | [t] => render_timing(~loc, t)
      | _ => raise(Unsupported_feature),
  );
let transition_delay =
  apply(
    Parser.property_transition_delay,
    (~loc) => [%expr CssJs.transitionDelay],
    (~loc) =>
      fun
      | [`Time(t)] => render_time_as_int(~loc, t)
      | [`Interpolation(v)] => render_variable(~loc, v)
      | _ => raise(Unsupported_feature),
  );
let transition =
  unsupportedValue(Parser.property_transition, (~loc) =>
    [%expr CssJs.transition]
  );

let render_keyframes_name = (~loc) =>
  fun
  | `Custom_ident(label) => render_string(~loc, label)
  | `String(label) => render_string(~loc, label);

let render_animation_name = (~loc) =>
  fun
  | `None => [%expr `none]
  | `Keyframes_name(name) => render_keyframes_name(~loc, name);

// css-animation-1
let animation_name =
  apply(
    Parser.property_animation_name,
    (~loc) => [%expr CssJs.animationName],
    (~loc) =>
      fun
      | [one] => render_animation_name(~loc, one)
      | _ => raise(Unsupported_feature),
  );

let animation_duration =
  apply(
    Parser.property_animation_duration,
    (~loc) => [%expr CssJs.animationDuration],
    (~loc) =>
      fun
      | [] => [%expr `none]
      | [one] => render_duration(~loc, one)
      | _ => raise(Unsupported_feature),
  );

let animation_timing_function =
  apply(
    Parser.property_animation_timing_function,
    (~loc) => [%expr CssJs.animationTimingFunction],
    (~loc) =>
      fun
      | [t] => render_timing(~loc, t)
      | _ => raise(Unsupported_feature),
  );

let render_animation_iteration_count = (~loc) =>
  fun
  | `Infinite => [%expr `infinite]
  | `Number(n) => [%expr `count([%e render_number(~loc, n)])];

let animation_iteration_count =
  apply(
    Parser.property_animation_iteration_count,
    (~loc) => [%expr CssJs.animationIterationCount],
    (~loc) =>
      fun
      | [one] => render_animation_iteration_count(~loc, one)
      | _ => raise(Unsupported_feature),
  );

let render_animation_direction = (~loc) =>
  fun
  | `Normal => [%expr `normal]
  | `Reverse => [%expr `reverse]
  | `Alternate => [%expr `alternate]
  | `Alternate_reverse => [%expr `alternateReverse];

let animation_direction =
  apply(
    Parser.property_animation_direction,
    (~loc) => [%expr CssJs.animationDirection],
    (~loc) =>
      fun
      | [one] => render_animation_direction(~loc, one)
      | _ => raise(Unsupported_feature),
  );

let render_animation_play_state = (~loc) =>
  fun
  | `Paused => [%expr `paused]
  | `Running => [%expr `running];

let animation_play_state =
  apply(
    Parser.property_animation_play_state,
    (~loc) => [%expr CssJs.animationPlayState],
    (~loc) =>
      fun
      | [one] => render_animation_play_state(~loc, one)
      | _ => raise(Unsupported_feature),
  );

let animation_delay =
  apply(
    Parser.property_animation_delay,
    (~loc) => [%expr CssJs.animationDelay],
    (~loc) =>
      fun
      | [one] => render_duration(~loc, one)
      | _ => raise(Unsupported_feature),
  );

let render_animation_fill_mode = (~loc) =>
  fun
  | `None => [%expr `none]
  | `Forwards => [%expr `forwards]
  | `Backwards => [%expr `backwards]
  | `Both => [%expr `both];

let animation_fill_mode =
  apply(
    Parser.property_animation_fill_mode,
    (~loc) => [%expr CssJs.animationFillMode],
    (~loc) =>
      fun
      | [one] => render_animation_fill_mode(~loc, one)
      | _ => raise(Unsupported_feature),
  );

let render_single_animation =
    (
      ~loc,
      (
        duration,
        timing_function,
        delay,
        iteration_count,
        direction,
        fillMode,
        playState,
        name,
      ),
    ) => {
  let duration =
    duration |> Option.mapWithDefault(render_duration(~loc), [%expr `ms(0)]);
  let delay =
    delay |> Option.mapWithDefault(render_duration(~loc), [%expr `ms(0)]);
  let direction =
    direction
    |> Option.mapWithDefault(
         render_animation_direction(~loc),
         [%expr `normal],
       );
  let timingFunction =
    timing_function
    |> Option.mapWithDefault(render_timing(~loc), [%expr `ease]);
  let fillMode =
    fillMode
    |> Option.mapWithDefault(render_animation_fill_mode(~loc), [%expr `none]);
  let playState =
    playState
    |> Option.mapWithDefault(
         render_animation_play_state(~loc),
         [%expr `running],
       );
  let iterationCount =
    iteration_count
    |> Option.mapWithDefault(
         render_animation_iteration_count(~loc),
         [%expr `count(1)],
       );
  let name =
    name |> Option.mapWithDefault(render_animation_name(~loc), [%expr `none]);

  [%expr
   CssJs.animation(
     ~duration=[%e duration],
     ~delay=[%e delay],
     ~direction=[%e direction],
     ~timingFunction=[%e timingFunction],
     ~fillMode=[%e fillMode],
     ~playState=[%e playState],
     ~iterationCount=[%e iterationCount],
     [%e name],
   )];
};

let animation =
  emit(
    Parser.property_animation,
    (~loc as _) => id,
    (~loc) =>
      fun
      | [one] => [render_single_animation(~loc, one)]
      | _ => raise(Unsupported_feature),
  );

// css-flexbox-1
let flex_direction =
  variants(Parser.property_flex_direction, (~loc) =>
    [%expr CssJs.flexDirection]
  );
let flex_wrap =
  variants(Parser.property_flex_wrap, (~loc) => [%expr CssJs.flexWrap]);

// shorthand - https://drafts.csswg.org/css-flexbox-1/#flex-flow-property
/* TODO: Avoid using `Value outside emit/emit_shorthand */
let flex_flow =
  emit(
    Parser.property_flex_flow,
    (~loc as _) => id,
    (~loc, (direction_ast, wrap_ast)) => {
      let direction =
        Option.map(
          ast => flex_direction.ast_to_expr(~loc, `Value(ast)),
          direction_ast,
        );
      let wrap =
        Option.map(
          ast => flex_wrap.ast_to_expr(~loc, `Value(ast)),
          wrap_ast,
        );
      [direction, wrap] |> List.concat_map(Option.value(~default=[]));
    },
  );

// TODO: this is safe?
let order =
  apply(
    Parser.property_order,
    (~loc) => [%expr CssJs.order],
    render_integer,
  );
let flex_grow =
  apply(
    Parser.property_flex_grow,
    (~loc) => [%expr CssJs.flexGrow],
    render_number,
  );
let flex_shrink =
  apply(
    Parser.property_flex_shrink,
    (~loc) => [%expr CssJs.flexShrink],
    render_number,
  );

let flex_basis =
  apply(
    Parser.property_flex_basis,
    (~loc) => [%expr CssJs.flexBasis],
    (~loc) =>
      fun
      | `Content => variant_to_expression(~loc, `Content)
      | `Property_width(value_width) =>
        width.value_of_ast(~loc, `Value(value_width)),
  );

// TODO: this is incomplete
let flex =
  emit(
    Parser.property_flex,
    (~loc as _) => id,
    (~loc) =>
      fun
      | `None => [[%expr CssJs.flex(`none)]]
      | `Or(grow_shrink, basis) => {
          let grow_shrink =
            switch (grow_shrink) {
            | None => []
            | Some((grow, shrink)) =>
              List.concat([
                flex_grow.ast_to_expr(~loc, `Value(grow)),
                Option.map(
                  ast => flex_shrink.ast_to_expr(~loc, `Value(ast)),
                  shrink,
                )
                |> Option.value(~default=[]),
              ])
            };
          let basis =
            switch (basis) {
            | None => []
            | Some(basis) => flex_basis.ast_to_expr(~loc, `Value(basis))
            };
          List.concat([grow_shrink, basis]);
        },
  );

// TODO: justify_content, align_items, align_self, align_content are only for flex, missing the css-align-3 at parser
let justify_content =
  unsupportedValue(Parser.property_justify_content, (~loc) =>
    [%expr CssJs.justifyContent]
  );
let align_items =
  unsupportedValue(Parser.property_align_items, (~loc) =>
    [%expr CssJs.alignItems]
  );
let align_self =
  unsupportedValue(Parser.property_align_self, (~loc) =>
    [%expr CssJs.alignSelf]
  );
let align_content =
  unsupportedValue(Parser.property_align_content, (~loc) =>
    [%expr CssJs.alignContent]
  );

// css-grid-1
let grid_template_columns =
  unsupportedValue(Parser.property_grid_template_columns, (~loc) =>
    [%expr CssJs.gridTemplateColumns]
  );
let grid_template_rows =
  unsupportedValue(Parser.property_grid_template_rows, (~loc) =>
    [%expr CssJs.gridTemplateRows]
  );
let grid_template_areas =
  unsupportedValue(Parser.property_grid_template_areas, (~loc) =>
    [%expr CssJs.gridTemplateAreas]
  );
let grid_template = unsupportedProperty(Parser.property_grid_template);
let grid_auto_columns =
  unsupportedValue(Parser.property_grid_auto_columns, (~loc) =>
    [%expr CssJs.gridAutoColumns]
  );
let grid_auto_rows =
  unsupportedValue(Parser.property_grid_auto_rows, (~loc) =>
    [%expr CssJs.gridAutoRows]
  );
let grid_auto_flow =
  unsupportedValue(Parser.property_grid_auto_flow, (~loc) =>
    [%expr CssJs.gridAutoFlow]
  );
let grid =
  unsupportedValue(Parser.property_grid, (~loc) => [%expr CssJs.grid]);
let grid_row_start =
  unsupportedValue(Parser.property_grid_row_start, (~loc) =>
    [%expr CssJs.gridRowStart]
  );

let grid_row_gap =
  apply(
    Parser.property_grid_row_gap,
    (~loc) => [%expr CssJs.gridRowGap],
    (~loc) =>
      fun
      | `Extended_length(el) => render_extended_length(~loc, el)
      | `Extended_percentage(ep) => render_extended_percentage(~loc, ep),
  );

let grid_column_gap =
  apply(
    Parser.property_grid_column_gap,
    (~loc) => [%expr CssJs.gridColumnGap],
    (~loc) =>
      fun
      | `Extended_length(el) => render_extended_length(~loc, el)
      | `Extended_percentage(ep) => render_extended_percentage(~loc, ep),
  );

let grid_column_start =
  unsupportedValue(Parser.property_grid_column_start, (~loc) =>
    [%expr CssJs.gridColumnStart]
  );
let grid_row_end =
  unsupportedValue(Parser.property_grid_row_end, (~loc) =>
    [%expr CssJs.gridRowEnd]
  );
let grid_column_end =
  unsupportedValue(Parser.property_grid_column_end, (~loc) =>
    [%expr CssJs.gridColumnEnd]
  );
let grid_row =
  unsupportedValue(Parser.property_grid_row, (~loc) => [%expr CssJs.gridRow]);
let grid_column =
  unsupportedValue(Parser.property_grid_column, (~loc) =>
    [%expr CssJs.gridColumn]
  );
let grid_area =
  unsupportedValue(Parser.property_grid_area, (~loc) =>
    [%expr CssJs.gridArea]
  );

let grid_gap =
  apply(
    Parser.property_grid_gap,
    (~loc) => [%expr CssJs.gridGap],
    (~loc) =>
      fun
      | (`Extended_length(el), None) => render_extended_length(~loc, el)
      | (`Extended_percentage(ep), None) =>
        render_extended_percentage(~loc, ep)
      /* gridGrap2 isn't available on bs-css */
      | _ => raise(Unsupported_feature),
  );

let render_gap =
    (~loc, value: [> Types.property_column_gap | Types.property_row_gap]) => {
  switch (value) {
  | `Extended_length(el) => render_extended_length(~loc, el)
  | `Extended_percentage(ep) => render_extended_percentage(~loc, ep)
  | `Normal => [%expr `normal]
  };
};

let render_property_gap = (~loc, value: Types.property_gap) => {
  switch (value) {
  | (row, None) => [[%expr CssJs.gap([%e render_gap(~loc, row)])]]
  | (row, Some(column)) => [
      [%expr
        CssJs.gap2(
          ~rowGap=[%e render_gap(~loc, row)],
          ~columnGap=[%e render_gap(~loc, column)],
        )
      ],
    ]
  };
};

let gap = emit(Parser.property_gap, (~loc as _) => id, render_property_gap);

let z_index =
  unsupportedValue(Parser.property_z_index, (~loc) => [%expr CssJs.zIndex]);

let render_position_value = (~loc) =>
  fun
  | `Auto => variant_to_expression(~loc, `Auto)
  | `Extended_length(l) => render_extended_length(~loc, l)
  | `Extended_percentage(pct) => render_extended_percentage(~loc, pct);

let left =
  apply(
    Parser.property_left,
    (~loc) => [%expr CssJs.left],
    render_position_value,
  );

let top =
  apply(
    Parser.property_top,
    (~loc) => [%expr CssJs.top],
    render_position_value,
  );

let right =
  apply(
    Parser.property_right,
    (~loc) => [%expr CssJs.right],
    render_position_value,
  );

let bottom =
  apply(
    Parser.property_bottom,
    (~loc) => [%expr CssJs.bottom],
    render_position_value,
  );

let render_display = (~loc) =>
  fun
  | `Block => [%expr `block]
  | `Contents => [%expr `contents]
  | `Flex => [%expr `flex]
  | `Grid => [%expr `grid]
  | `Inline => [%expr `inline]
  | `Inline_block => [%expr `inlineBlock]
  | `Inline_flex => [%expr `inlineFlex]
  | `Inline_grid => [%expr `inlineGrid]
  | `Inline_list_item => [%expr `inlineListItem]
  | `Inline_table => [%expr `inlineTable]
  | `List_item => [%expr `listItem]
  | `None => [%expr `none]
  | `Table => [%expr `table]
  | `Table_caption => [%expr `tableCaption]
  | `Table_cell => [%expr `tableCell]
  | `Table_column => [%expr `tableColumn]
  | `Table_column_group => [%expr `tableColumnGroup]
  | `Table_footer_group => [%expr `tableFooterGroup]
  | `Table_header_group => [%expr `tableHeaderGroup]
  | `Table_row => [%expr `tableRow]
  | `Table_row_group => [%expr `tableRowGroup]
  | `Flow
  | `Flow_root
  | `Ruby
  | `Ruby_base
  | `Ruby_base_container
  | `Ruby_text
  | `Ruby_text_container
  | `Run_in
  | `_moz_box
  | `_moz_inline_box
  | `_moz_inline_stack
  | `_ms_flexbox
  | `_ms_grid
  | `_ms_inline_flexbox
  | `_ms_inline_grid
  | `_webkit_box
  | `_webkit_flex
  | `_webkit_inline_box
  | `_webkit_inline_flex
  | _ => raise(Unsupported_feature);

let display =
  apply(
    Parser.property_display,
    (~loc) => [%expr CssJs.display],
    render_display,
  );

/* let render_mask_source = (~loc) => fun
     | `Interpolation(v) => render_variable(v)
     | `Cross_fade()
     | `Element()
     | `Image()
     | `Image_set()
     | `Paint() => raise(Unsupported_feature)
   ; */

let render_mask_image = (~loc) =>
  fun
  | `None => [%expr `none]
  | `Image(i) => render_image(~loc, i)
  | `Mask_source(_) => raise(Unsupported_feature);

let mask_image =
  apply(
    Parser.property_mask_image,
    (~loc) => [%expr CssJs.maskImage],
    (~loc) =>
      fun
      | [one] => render_mask_image(~loc, one)
      | _ => raise(Unsupported_feature),
  );

let found = ({ast_of_string, string_to_expr, _}) => {
  /* TODO: Why we have 'check_value' when we don't use it? */
  let check_value = string => {
    let.ok _ = ast_of_string(string);
    Ok();
  };
  (check_value, string_to_expr);
};

let properties = [
  ("display", found(display)),
  // css-sizing-3
  ("width", found(width)),
  ("height", found(height)),
  ("min-width", found(min_width)),
  ("min-height", found(min_height)),
  ("max-width", found(max_width)),
  ("max-height", found(max_height)),
  ("box-sizing", found(box_sizing)),
  ("column-width", found(column_width)),
  // css-box-3
  ("margin-top", found(margin_top)),
  ("margin-right", found(margin_right)),
  ("margin-bottom", found(margin_bottom)),
  ("margin-left", found(margin_left)),
  ("margin", found(margin)),
  ("padding-top", found(padding_top)),
  ("padding-right", found(padding_right)),
  ("padding-bottom", found(padding_bottom)),
  ("padding-left", found(padding_left)),
  ("padding", found(padding)),
  // css-color-4
  ("color", found(color)),
  ("opacity", found(opacity)),
  // css-images-4
  ("object-fit", found(object_fit)),
  ("object-position", found(object_position)),
  ("image-resolution", found(image_resolution)),
  ("image-orientation", found(image_orientation)),
  ("image-rendering", found(image_rendering)),
  // css-background-3
  ("background-color", found(background_color)),
  ("background-image", found(background_image)),
  ("background-repeat", found(background_repeat)),
  ("background-attachment", found(background_attachment)),
  ("background-position", found(background_position)),
  ("background-clip", found(background_clip)),
  ("background-origin", found(background_origin)),
  ("background-size", found(background_size)),
  ("background", found(background)),
  ("border-top-color", found(border_top_color)),
  ("border-right-color", found(border_right_color)),
  ("border-bottom-color", found(border_bottom_color)),
  ("border-left-color", found(border_left_color)),
  ("border-color", found(border_color)),
  ("border-top-style", found(border_top_style)),
  ("border-right-style", found(border_right_style)),
  ("border-bottom-style", found(border_bottom_style)),
  ("border-left-style", found(border_left_style)),
  ("border-style", found(border_style)),
  ("border-top-width", found(border_top_width)),
  ("border-right-width", found(border_right_width)),
  ("border-bottom-width", found(border_bottom_width)),
  ("border-left-width", found(border_left_width)),
  ("border-width", found(border_width)),
  ("border-top", found(border_top)),
  ("border-right", found(border_right)),
  ("border-bottom", found(border_bottom)),
  ("border-left", found(border_left)),
  ("border", found(border)),
  ("border-top-left-radius", found(border_top_left_radius)),
  ("border-top-right-radius", found(border_top_right_radius)),
  ("border-bottom-right-radius", found(border_bottom_right_radius)),
  ("border-bottom-left-radius", found(border_bottom_left_radius)),
  ("border-radius", found(border_radius)),
  ("border-image-source", found(border_image_source)),
  ("border-image-slice", found(border_image_slice)),
  ("border-image-width", found(border_image_width)),
  ("border-image-outset", found(border_image_outset)),
  ("border-image-repeat", found(border_image_repeat)),
  ("border-image", found(border_image)),
  ("box-shadow", found(box_shadow)),
  // css-overflow-3
  ("overflow-x", found(overflow_x)),
  ("overflow-y", found(overflow_y)),
  ("overflow", found(overflow)),
  // ("overflow-clip-margin", found(overflow_clip_margin)),
  ("overflow-inline", found(overflow_inline)),
  ("text-overflow", found(text_overflow)),
  // ("block-ellipsis", found(block_ellipsis)),
  ("max-lines", found(max_lines)),
  // ("continue", found(continue)),
  // css-text-3
  ("text-transform", found(text_transform)),
  ("white-space", found(white_space)),
  ("tab-size", found(tab_size)),
  ("word-break", found(word_break)),
  ("widows", found(widows)),
  ("line-break", found(line_break)),
  ("hyphens", found(hyphens)),
  ("overflow-wrap", found(overflow_wrap)),
  ("word-wrap", found(word_wrap)),
  ("text-align", found(text_align)),
  // ("text-align-all", found(text_align_all)),
  ("text-align-last", found(text_align_last)),
  ("text-justify", found(text_justify)),
  ("word-spacing", found(word_spacing)),
  ("letter-spacing", found(letter_spacing)),
  ("text-indent", found(text_indent)),
  ("hanging-punctuation", found(hanging_punctuation)),
  // css-fonts-4
  ("font-family", found(font_family)),
  ("font-weight", found(font_weight)),
  ("font-stretch", found(font_stretch)),
  ("font-style", found(font_style)),
  ("font-size", found(font_size)),
  ("font-size-adjust", found(font_size_adjust)),
  ("font", found(font)),
  // ("font-synthesis-weight", found(font_synthesis_weight)),
  // ("font-synthesis-style", found(font_synthesis_style)),
  // ("font-synthesis-small-caps", found(font_synthesis_small_caps)),
  ("font-synthesis", found(font_synthesis)),
  ("font-kerning", found(font_kerning)),
  ("font-variant-ligatures", found(font_variant_ligatures)),
  ("font-variant-position", found(font_variant_position)),
  ("font-variant-caps", found(font_variant_caps)),
  ("font-variant-numeric", found(font_variant_numeric)),
  ("font-variant-alternates", found(font_variant_alternates)),
  ("font-variant-east-asian", found(font_variant_east_asian)),
  ("font-variant", found(font_variant)),
  ("font-feature-settings", found(font_feature_settings)),
  ("font-optical-sizing", found(font_optical_sizing)),
  ("font-variation-settings", found(font_variation_settings)),
  // ("font-palette", found(font_palette)),
  // ("font-variant-emoji", found(font_variant_emoji)),
  // css-text-decor-3
  ("text-decoration-line", found(text_decoration_line)),
  ("text-decoration-style", found(text_decoration_style)),
  ("text-decoration-color", found(text_decoration_color)),
  ("text-decoration-thickness", found(text_decoration_thickness)),
  ("text-decoration", found(text_decoration)),
  ("text-underline-position", found(text_underline_position)),
  ("text-underline-offset", found(text_underline_offset)),
  ("text-decoration-skip", found(text_decoration_skip)),
  // ("text-decoration-skip-self", found(text_decoration_skip_self)),
  // ("text-decoration-skip-box", found(text_decoration_skip_box)),
  // ("text-decoration-skip-inset", found(text_decoration_skip_inset)),
  // ("text-decoration-skip-spaces", found(text_decoration_skip_spaces)),
  ("text-decoration-skip-ink", found(text_decoration_skip_ink)),
  ("text-emphasis-style", found(text_emphasis_style)),
  ("text-emphasis-color", found(text_emphasis_color)),
  ("text-emphasis", found(text_emphasis)),
  ("text-emphasis-position", found(text_emphasis_position)),
  // ("text-emphasis-skip", found(text_emphasis_skip)),
  ("text-shadow", found(text_shadow)),
  // css-transforms2
  ("transform", found(transform)),
  ("transform-origin", found(transform_origin)),
  ("transform-box", found(transform_box)),
  ("translate", found(translate)),
  ("rotate", found(rotate)),
  ("scale", found(scale)),
  ("transform-style", found(transform_style)),
  ("perspective", found(perspective)),
  ("perspective-origin", found(perspective_origin)),
  ("backface-visibility", found(backface_visibility)),
  // css-transition-1
  ("transition-property", found(transition_property)),
  ("transition-duration", found(transition_duration)),
  ("transition-timing-function", found(transition_timing_function)),
  ("transition-delay", found(transition_delay)),
  ("transition", found(transition)),
  // css-animation-1
  ("animation-name", found(animation_name)),
  ("animation-duration", found(animation_duration)),
  ("animation-timing-function", found(animation_timing_function)),
  ("animation-iteration-count", found(animation_iteration_count)),
  ("animation-direction", found(animation_direction)),
  ("animation-play-state", found(animation_play_state)),
  ("animation-delay", found(animation_delay)),
  ("animation-fill-mode", found(animation_fill_mode)),
  ("animation", found(animation)),
  // css-flexbox-1
  ("flex-direction", found(flex_direction)),
  ("flex-wrap", found(flex_wrap)),
  ("flex-flow", found(flex_flow)),
  ("order", found(order)),
  ("flex-grow", found(flex_grow)),
  ("flex-shrink", found(flex_shrink)),
  ("flex-basis", found(flex_basis)),
  ("flex", found(flex)),
  ("justify-content", found(justify_content)),
  ("align-items", found(align_items)),
  ("align-self", found(align_self)),
  ("align-content", found(align_content)),
  // css-grid-1
  ("grid-template-columns", found(grid_template_columns)),
  ("grid-template-rows", found(grid_template_rows)),
  ("grid-template-areas", found(grid_template_areas)),
  ("grid-template", found(grid_template)),
  ("grid-auto-columns", found(grid_auto_columns)),
  ("grid-auto-rows", found(grid_auto_rows)),
  ("grid-auto-flow", found(grid_auto_flow)),
  ("grid", found(grid)),
  ("grid-row-start", found(grid_row_start)),
  ("grid-row-gap", found(grid_row_gap)),
  ("grid-column-start", found(grid_column_start)),
  ("grid-column-gap", found(grid_column_gap)),
  ("grid-row-end", found(grid_row_end)),
  ("grid-column-end", found(grid_column_end)),
  ("grid-row", found(grid_row)),
  ("grid-column", found(grid_column)),
  ("grid-area", found(grid_area)),
  ("grid-gap", found(grid_gap)),
  ("gap", found(gap)),
  ("z-index", found(z_index)),
  ("line-height", found(line_height)),
  ("line-height-step", found(line_height_step)),
  ("left", found(left)),
  ("top", found(top)),
  ("right", found(right)),
  ("bottom", found(bottom)),
  ("mask-image", found(mask_image)),
  ("outline", found(outline)),
  ("outline-color", found(outline_color)),
  ("outline-offset", found(outline_offset)),
  ("outline-style", found(outline_style)),
  ("outline-width", found(outline_width)),
];

let render_when_unsupported_features = (~loc, property, value) => {
  let to_camel_case = txt =>
    (
      switch (String.split_on_char('-', txt)) {
      | [first, ...remaining] => [
          first,
          ...List.map(String.capitalize_ascii, remaining),
        ]
      | [] => []
      }
    )
    |> String.concat("");

  /* Transform property name to camelCase since we bind to emotion with the Object API */
  let propertyName = property |> to_camel_case |> render_string(~loc);
  let value = value |> render_string(~loc);

  [%expr CssJs.unsafe([%e propertyName], [%e value])];
};

let findProperty = name => {
  properties |> List.find_opt(((key, _)) => key == name);
};

let render_to_expr = (~loc, property, value) => {
  let.ok expr_of_string =
    switch (findProperty(property)) {
    | Some((_, (_, expr_of_string))) => Ok(expr_of_string)
    | None => Error(`Not_found)
    };

  expr_of_string(~loc, value) |> Result.map_error(str => `Invalid_value(str));
};

let parse_declarations = (~loc: Location.t, property, value) => {
  let.ok is_valid_string =
    Parser.check_property(~name=property, value)
    |> Result.map_error((`Unknown_value) => `Not_found);

  switch (render_css_global_values(~loc, property, value)) {
  | Ok(value) => Ok(value)
  | Error(_) =>
    switch (render_to_expr(~loc, property, value)) {
    | Ok(value) => Ok(value)
    | Error(_)
    | exception Unsupported_feature =>
      let.ok () = is_valid_string ? Ok() : Error(`Invalid_value(value));
      Ok([render_when_unsupported_features(~loc, property, value)]);
    }
  };
};
