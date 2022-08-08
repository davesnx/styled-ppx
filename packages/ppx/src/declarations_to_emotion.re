open Ppxlib;
open Reason_css_parser;

module Helper = Ast_helper;
module Builder = Ppxlib.Ast_builder.Default;

let txt = (~loc, txt) => {Location.loc: loc, txt};

let (let.ok) = Result.bind;

/* TODO: Separate unsupported_feature from bs-css doesn't support or can't interpolate on those */
/* TODO: Add payload on those exception, maybe move to Result. */
exception Unsupported_feature;

let id = Fun.id;

/* Why this type contains so much when only `string_to_expr` is used? */
type transform('ast, 'value) = {
  ast_of_string: string => result('ast, string),
  value_of_ast: (~loc: Location.t, 'ast) => 'value,
  value_to_expr: (~loc: Location.t, 'value) => list(Parsetree.expression),
  ast_to_expr: (~loc: Location.t, 'ast) => list(Parsetree.expression),
  string_to_expr: (~loc: Location.t, string) => result(list(Parsetree.expression), string),
};

let add_CssJs_rule_constraint = (~loc, expr) => {
  let typ = Helper.Typ.constr(~loc, {txt: Ldot(Lident("CssJs"), "rule"), loc}, []);
  Helper.Exp.constraint_(~loc, expr, typ);
};

/* TODO: emit is better to keep value_of_ast and value_to_expr in the same fn */
let emit = (property, value_of_ast, value_to_expr) => {
  let ast_of_string = Parser.parse(property);
  let ast_to_expr = (~loc, ast) => value_of_ast(~loc, ast) |> value_to_expr(~loc);
  let string_to_expr = (~loc, string) =>
    ast_of_string(string) |> Result.map(ast_to_expr(~loc));

  {ast_of_string, value_of_ast, value_to_expr, ast_to_expr, string_to_expr};
};

let emit_shorthand = (parser, mapper, value_to_expr) => {
  let ast_of_string = Parser.parse(parser);
  let ast_to_expr = (~loc, ast) => ast |> List.map(mapper(~loc)) |> value_to_expr(~loc);
  let string_to_expr = (~loc, string) =>
    ast_of_string(string) |> Result.map(ast_to_expr(~loc));
  let value_of_ast = (~loc) => List.map(mapper(~loc));

  {
    ast_of_string,
    value_of_ast,
    value_to_expr,
    ast_to_expr,
    string_to_expr,
  };
};

let render_string = (~loc, string) =>
  Helper.Const.string(~quotation_delimiter="js", string) |> Helper.Exp.constant(~loc);
let render_integer = (~loc, integer) =>
  Helper.Const.int(integer) |> Helper.Exp.constant(~loc);
let render_number = (~loc, number) =>
  Helper.Const.float(number |> string_of_float) |> Helper.Exp.constant(~loc);
let render_percentage = (~loc, number) => [%expr `percent([%e render_number(~loc, number)])];

let render_css_global_values = (~loc, name, value) => {
  let.ok value = Parser.parse(Standard.css_wide_keywords, value);

  let value =
    switch (value) {
    | `Inherit => render_string(~loc, "inherit")
    | `Initial => render_string(~loc, "initial")
    | `Unset => render_string(~loc, "unset")
    };

  /* bs-css doesn't have those */
  Ok([[%expr CssJs.unsafe([%e render_string(~loc, name)], [%e value])]]);
};

let variants_to_expression =
  (~loc) => fun
  | `Row => id([%expr `row])
  | `Row_reverse => id([%expr `rowReverse])
  | `Column => id([%expr `column])
  | `Column_reverse => id([%expr `columnReverse])
  | `Nowrap => id([%expr `nowrap])
  | `Wrap => id([%expr `wrap])
  | `Wrap_reverse => id([%expr `wrapReverse])
  | `Content => id([%expr `content])
  | `Flex_start => id([%expr `flexStart])
  | `Flex_end => id([%expr `flexEnd])
  | `Center => id([%expr `center])
  | `Space_between => id([%expr `spaceBetween])
  | `Space_around => id([%expr `spaceAround])
  | `Baseline => id([%expr `baseline])
  | `Stretch => id([%expr `stretch])
  | `Auto => id([%expr `auto])
  | `None => id([%expr `none])
  | `Content_box => id([%expr `contentBox])
  | `Border_box => id([%expr `borderBox])
  | `Clip => id([%expr `clip])
  | `Hidden => id([%expr `hidden])
  | `Visible => id([%expr `visible])
  | `Scroll => id([%expr `scroll])
  | `Ellipsis => id([%expr `ellipsis])
  | `Capitalize => id([%expr `capitalize])
  | `Lowercase => id([%expr `lowercase])
  | `Uppercase => id([%expr `uppercase])
  | `Break_spaces => id([%expr `breakSpaces])
  | `Normal => id([%expr `normal])
  | `Pre => id([%expr `pre])
  | `Pre_line => id([%expr `preLine])
  | `Pre_wrap => id([%expr `preWrap])
  | `Break_all => id([%expr `breakAll])
  | `Break_word => raise(Unsupported_feature)
  | `Keep_all => id([%expr `keepAll])
  | `Anywhere => id([%expr `anywhere])
  | `BreakWord => id([%expr `breakWord])
  | `End => id([%expr `end_])
  | `Justify => id([%expr `justify])
  | `Justify_all => raise(Unsupported_feature)
  | `Left => id([%expr `left])
  | `Match_parent => raise(Unsupported_feature)
  | `Right => id([%expr `right])
  | `Start => id([%expr `start])
  | `Transparent => id([%expr `transparent])
  | `Bottom => id([%expr `bottom])
  | `Top => id([%expr `top])
  | `Fill => id([%expr `fill])
  | `Dotted => id([%expr `dotted])
  | `Dashed => id([%expr `dashed])
  | `Solid => id([%expr `solid])
  | `Double => id([%expr `double])
  | `Groove => id([%expr `groove])
  | `Ridge => id([%expr `ridge])
  | `Inset => id([%expr `inset])
  | `Outset => id([%expr `outset])
  | `Contain => id([%expr `contain])
  | `Scale_down => id([%expr `scaleDown])
  | `Cover => id([%expr `cover])
  | `Full_width => raise(Unsupported_feature)
  | `Unset => id([%expr `unset])
  | `Padding_box => id([%expr `padding_box])
  | `FitContent => raise(Unsupported_feature)
  | `MaxContent => id([%expr `maxContent])
  | `MinContent => id([%expr `minContent])
  | `Full_size_kana => raise(Unsupported_feature);

let list_to_longident = vars => vars |> String.concat(".") |> Longident.parse;

let render_variable = (~loc, name) =>
  list_to_longident(name) |> txt(~loc) |> Helper.Exp.ident(~loc);

// TODO: all of them could be float, but bs-css doesn't support it
let render_length =
  (~loc) => fun
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
    | (product, list_of_sums) => {
      /* This isn't a great design of the types, but we need to know the operation
      which is in the first position of the array, we ensure that there's one value
      since we are on this branch of the switch */
      let op = pick_operation(~loc, List.hd(list_of_sums));
      let first = render_product(~loc, product);
      let second = render_list_of_sums(~loc, list_of_sums);
      [%expr `calc([%e op], [%e first], [%e second])];
    }
  }
}
and render_sum_op = (~loc, op) => {
  switch (op) {
    | `Dash(()) => [%expr `sub]
    | `Cross(()) => [%expr `add]
  }
}
and pick_operation = (~loc, (op, _)) => render_sum_op(~loc, op)
and render_list_of_products = (list_of_products) => {
  switch (list_of_products) {
    | [one] => render_product_op(one)
    | list => render_list_of_products(list)
  }
} and render_list_of_sums = (~loc, list_of_sums) => {
  switch (list_of_sums) {
    | [(_, one)] => render_product(~loc, one)
    | list => render_list_of_sums(~loc, list)
  }
} and render_product = (~loc, product) => {
  switch (product) {
    | (calc_value, []) => render_calc_value(~loc, calc_value)
    | (calc_value, list_of_products) => {
      let _first = render_calc_value(calc_value);
      let _second = render_list_of_products(list_of_products);
      /* [%expr (`mult, [%e first], [%e second])]; */
      failwith("`mult isn't available in bs-css");
    }
  }
} and render_product_op = (~loc, op) => {
  switch (op) {
    | `Static_0((), calc_value) => render_calc_value(~loc, calc_value)
    | `Static_1((), float) => render_number(~loc, float)
  }
} and render_calc_value = (~loc, calc_value) => {
  switch (calc_value) {
    | `Number(float) => render_number(~loc, float)
    | `Extended_length(l) => render_extended_length(~loc, l)
    | `Extended_percentage(p) => render_extended_percentage(~loc, p)
    | `Function_calc(fc) => render_function_calc(~loc, fc)
  }
} and render_extended_length = (~loc) => fun
  | `Length(l) => render_length(~loc, l)
  | `Function_calc(fc) => render_function_calc(~loc, fc)
  | `Interpolation(i) => render_variable(~loc, i)
and render_extended_percentage = (~loc) => fun
  | `Percentage(p) => render_percentage(~loc, p)
  | `Function_calc(fc) => render_function_calc(~loc, fc)
  | `Interpolation(i) => render_variable(~loc, i);

let render_length_percentage = (~loc) => fun
  | `Extended_length(ext) => render_extended_length(~loc, ext)
  | `Extended_percentage(ext) => render_extended_percentage(~loc, ext);

// css-sizing-3
let render_size = (~loc) => fun
  | `Auto => variants_to_expression(~loc, `Auto)
  | `Extended_length(l) => render_extended_length(~loc, l)
  | `Extended_percentage(p) => render_extended_percentage(~loc, p)
  | `Function_calc(fc) => render_function_calc(~loc, fc)
  | `Fit_content_0 => variants_to_expression(~loc, `FitContent)
  | `Max_content => variants_to_expression(~loc, `MaxContent)
  | `Min_content => variants_to_expression(~loc, `MinContent)
  | `Fit_content_1(_)
  | _ => raise(Unsupported_feature);

let render_angle = (~loc) => fun
  | `Deg(number) => id([%expr `deg([%e render_number(~loc, number)])])
  | `Rad(number) => id([%expr `rad([%e render_number(~loc, number)])])
  | `Grad(number) => id([%expr `grad([%e render_number(~loc, number)])])
  | `Turn(number) => id([%expr `turn([%e render_number(~loc, number)])]);

let render_extended_angle = (~loc) => fun
  | `Angle(a) => render_angle(~loc, a)
  | `Function_calc(fc) => render_function_calc(~loc, fc)
  | `Interpolation(i) => render_variable(~loc, i)
;


let transform_with_variable = (parser, mapper, value_to_expr) =>
  emit(
    /* This Xor is defined here for those properties that aren't specifically
      added <interpolation> as a valid variant */
    Combinator.combine_xor([
      /* If the entire CSS value is interpolated, we treat it as a `Variable */
      Rule.Match.map(Standard.interpolation, data => `Variable(data)),
      /* Otherwise it's a regular CSS `Value and run the mapper below */
      Rule.Match.map(parser, data => `Value(data)),
    ]),
    (~loc) => fun
    | `Variable(name) => render_variable(~loc, name)
    | `Value(ast) => mapper(~loc, ast),
    (~loc, expression) => {
      switch (expression) {
        // Since we are treating with expressions here, we don't have any other way to detect if it's interpolation or not. We want to add type constraints on interpolation only.
        | {pexp_desc: Pexp_ident({txt: Ldot(Lident("CssJs"), _), _}), _} as exp =>
          value_to_expr(~loc, exp)
        | {pexp_desc: Pexp_ident(_), pexp_loc: _, _} as exp =>
          value_to_expr(~loc, exp) |> List.map(add_CssJs_rule_constraint(~loc))
        | exp => value_to_expr(~loc, exp)
      }
    }
  );

let apply = (parser, property_renderer, value_renderer) =>
  transform_with_variable(
    parser,
    value_renderer,
    (~loc, value) => [[%expr [%e property_renderer(~loc)]([%e value])]]
  );

let unsupportedValue = (parser, property) =>
  transform_with_variable(
    parser,
    (~loc as _, _) => raise(Unsupported_feature),
    (~loc, arg) => [[%expr [%e property(~loc)]([%e arg])]],
  );

let unsupportedProperty = (parser) =>
  transform_with_variable(
    parser,
    (~loc as _, _) => raise(Unsupported_feature),
    (~loc as _) => raise(Unsupported_feature),
  );

let variants = (parser, identifier) =>
  apply(parser, identifier, variants_to_expression);

let width = apply(Parser.property_width, (~loc) => [%expr CssJs.width], render_size);
let height = apply(Parser.property_height, (~loc) => [%expr CssJs.height], render_size);
let min_width =
  apply(Parser.property_min_width, (~loc) => [%expr CssJs.minWidth], render_size);
let min_height =
  apply(Parser.property_min_height, (~loc) => [%expr CssJs.minHeight], render_size);
let max_width =
  apply(
    Parser.property_max_width,
    (~loc) => [%expr CssJs.maxWidth],
    render_size
  );
let max_height =
  apply(Parser.property_max_height, (~loc) => [%expr CssJs.maxHeight], render_size
  );
let box_sizing =
  apply(
    Parser.property_box_sizing,
    (~loc) => [%expr CssJs.boxSizing],
    variants_to_expression,
  );
let column_width = unsupportedProperty(Parser.property_column_width);

let render_margin =
  (~loc) => fun
  | `Auto => variants_to_expression(~loc, `Auto)
  | `Extended_length(l) => render_extended_length(~loc, l)
  | `Extended_percentage(p) => render_extended_percentage(~loc, p)
;

let render_padding =
  (~loc) => fun
  | `Auto => variants_to_expression(~loc, `Auto)
  | `Extended_length(l) => render_extended_length(~loc, l)
  | `Extended_percentage(p) => render_extended_percentage(~loc, p)
;

// css-box-3
let margin_top =
  apply(Parser.property_margin_top, (~loc) => [%expr CssJs.marginTop], render_margin);
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
  apply(Parser.property_margin_left, (~loc) => [%expr CssJs.marginLeft], render_margin);

let margin =
  emit_shorthand(
    Parser.property_margin,
    (~loc) => fun
    | `Auto => variants_to_expression(~loc, `Auto)
    | `Extended_length(l) => render_extended_length(~loc, l)
    | `Extended_percentage(p) => render_extended_percentage(~loc, p)
    | `Interpolation(name) => render_variable(~loc, name),
    (~loc) => fun
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
  apply(Parser.property_padding_top, (~loc) => [%expr CssJs.paddingTop], render_padding);
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
    (~loc) => fun
    | `Extended_length(l) => render_extended_length(~loc, l)
    | `Extended_percentage(p) => render_extended_percentage(~loc, p)
    | `Interpolation(name) => render_variable(~loc, name),
    (~loc) => fun
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

let render_named_color =
  (~loc) => fun
  | `Transparent => variants_to_expression(~loc, `Transparent)
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

let render_color_alpha =
  (~loc) => fun
  | `Number(number) => [%expr `num([%e render_number(~loc, number)])]
  | `Extended_percentage(`Percentage(pct)) => render_percentage(~loc, pct /. 100.0)
  | `Extended_percentage(pct) => render_extended_percentage(~loc, pct);

let render_function_rgb = (~loc, ast) => {
  let color_to_float = v => render_integer(~loc, v |> int_of_float);

  let to_number = fun
    // TODO: bs-css rgb(float, float, float)
    | `Percentage(pct) => color_to_float(pct *. 2.55)
    | `Function_calc(fc) => render_function_calc(~loc, fc)
    | `Interpolation(v) => render_variable(~loc, v)
    | `Extended_percentage(ext) => render_extended_percentage(~loc, ext);

  let (colors, alpha) =
    switch (ast) {
    /* 1 and 3 = numbers */
    | `Rgb_1(colors, alpha)
    | `Rgba_1(colors, alpha)
    | `Rgb_3(colors, alpha)
    | `Rgba_3(colors, alpha) => (colors |> List.map(color_to_float), alpha)
    /* 0 and 2 = extended-percentage */
    | `Rgb_0(colors, alpha)
    | `Rgba_0(colors, alpha)
    | `Rgb_2(colors, alpha)
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

let render_var = (~loc, string) => {
  let string = render_string(~loc, string);
  [%expr `var([%e string])];
};

let render_color =
  (~loc) => fun
  | `Interpolation(v) => render_variable(~loc, v)
  | `Hex_color(hex) => id([%expr `hex([%e render_string(~loc, hex)])])
  | `Named_color(color) => render_named_color(~loc, color)
  | `CurrentColor => id([%expr `currentColor])
  | `Function_rgb(rgb)
  | `Function_rgba(rgb) => render_function_rgb(~loc, rgb)
  | `Function_hsl(`Hsl_0(hsl))
  | `Function_hsla(`Hsl_0(hsl)) => render_function_hsl(~loc, hsl)
  | `Function_var(v) => render_var(~loc, v)
  | `Function_hsl(_)
  | `Function_hsla(_)
  | `Function_hwb(_)
  | `Function_lab(_)
  | `Function_lch(_)
  | `Function_color(_)
  | `Function_device_cmyk(_)
  | `Deprecated_system_color(_)
  | _ => raise(Unsupported_feature);

let color = apply(Parser.property_color, (~loc) => [%expr CssJs.color], render_color);
let opacity =
  apply(
    Parser.property_opacity,
    (~loc) => [%expr CssJs.opacity],
    (~loc) => fun
    | `Number(number) => render_number(~loc, number)
    | `Extended_percentage(`Percentage(number)) => render_number(~loc, number /. 100.0)
    | `Extended_percentage(pct) => render_extended_percentage(~loc, pct)
  );

// css-images-4
let render_position = (~loc, position) => {
  let pos_to_percentage_offset =
    fun
    | `Left
    | `Top => 0.
    | `Right
    | `Bottom => 100.
    | `Center => 50.;

  let to_value = (~loc) => fun
    | `Position(pos) => variants_to_expression(~loc, pos)
    | `Extended_length(l) => render_extended_length(~loc, l)
    | `Extended_percentage(percentage) => render_extended_percentage(~loc, percentage);

  let horizontal =
    switch (position) {
    | `Or(Some(pos), _) => (pos, `Zero)
    | `Or(None, _) => (`Center, `Zero)
    | `Static((`Center | `Left | `Right) as pos, _) => (pos, `Zero)
    | `Static(static, _) => (`Left, static)
    | `And((pos, offset), _) => (pos, offset)
    };

  let horizontal =
    switch (horizontal) {
    | (`Left, `Extended_length(length)) => `Extended_length(length)
    | (pos, `Zero) => `Position(pos)
    | (pos, `Extended_percentage(`Percentage(percentage))) =>
      `Extended_percentage(`Percentage(percentage +. pos_to_percentage_offset(pos)))
    | (_, _) => raise(Unsupported_feature)
    };

  let horizontal = to_value(~loc, horizontal);

  let vertical =
    switch (position) {
    | `Or(_, Some(pos)) => (pos, `Zero)
    | `Or(_, None) => (`Center, `Zero)
    | `Static(_, None) => (`Center, `Zero)
    | `Static(_, Some((`Center | `Bottom | `Top) as pos)) => (pos, `Zero)
    | `Static(_, Some(offset)) => (`Top, offset)
    | `And(_, (pos, offset)) => (pos, offset)
    };

  let vertical =
    switch (vertical) {
    | (`Top, `Extended_length(length)) => `Extended_length(length)
    | (pos, `Zero) => `Position(pos)
    | (pos, `Extended_percentage(`Percentage(percentage))) =>
      `Extended_percentage(`Percentage(percentage +. pos_to_percentage_offset(pos)))
    | (_, _) => raise(Unsupported_feature)
    };

  let vertical = to_value(~loc, vertical);

  id([%expr `hv(([%e horizontal], [%e vertical]))]);
};

let object_fit =
  variants(Parser.property_object_fit, (~loc) => [%expr CssJs.objectFit]);

let object_position =
  apply(
    Parser.property_object_position,
    (~loc) => [%expr CssJs.objectPosition],
    render_position,
  );
let image_resolution = unsupportedProperty(Parser.property_image_resolution);
let image_orientation = unsupportedProperty(Parser.property_image_orientation);
let image_rendering = unsupportedProperty(Parser.property_image_rendering);

let render_color_interp =
  (~loc) => fun
  | `Interpolation(name) => render_variable(~loc, name)
  | `Color(ls) => render_color(~loc, ls);

let render_length_interp =
  (~loc) => fun
  | `Extended_length(l) => render_extended_length(~loc, l)
  | `Interpolation(name) => render_variable(~loc, name);

// css-backgrounds-3
let render_shadow = (~loc, shadow) => {
  let (color, x, y, blur, spread, inset) =
    switch (shadow) {
    | `Box(inset, position, color) =>
      let (x, y, blur, spread) = {
        let (x, y, blur, spread) =
          switch (position) {
          | [x, y] => (x, y, None, None)
          | [x, y, blur] => (x, y, Some(blur), None)
          | [x, y, blur, spread] => (x, y, Some(blur), Some(spread))
          | _ => failwith("unreachable")
          };
        (x, y, blur, spread);
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
      () =>
        Helper.Exp.construct(
          ~loc,
          {txt: Lident("true"), loc},
          None,
        ),
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
    |> List.filter_map(
        ((label, value)) => Option.map(value => (label, value), value)
      );

  Helper.Exp.apply(~loc, [%expr CssJs.Shadow.box], args);
};
let background_color =
  apply(
    Parser.property_background_color,
    (~loc) => [%expr CssJs.backgroundColor],
    render_color,
  );

/* TODO: Incomplete */
/* let render_stops = (~loc as _, s) => [%expr [%e s]] */

/* TODO: Support gradients */
/* let render_gradient = (~loc) => fun
  | `Linear_gradient(angle, stops) =>
    [%expr `linearGradient([%e render_extended_angle(~loc, angle)], [%e render_stops(~loc, stops)])]
  | `Repeating_linear_gradient(angle, stops) =>
    [%expr `repeatingLinearGradient([%e render_extended_angle(~loc, angle)], [%e render_stops(~loc, stops)])]
  | `Radial_gradient(stops) =>
    [%expr `radialGradient([%e render_stops(~loc, stops)])]
  | `Repeating_radial_gradient(stops) =>
    [%expr `repeatingRadialGradient([%e render_stops(~loc, stops)])]
  | `conicGradient(angle, stops) =>
    [%expr `conicGradient([%e render_extended_angle(~loc, angle)], [%e render_stops(~loc, stops)])]
; */

let render_image = (~loc) => fun
  /* | `Gradient(gradient) => render_gradient(gradient) */
  | `Url(url) => [%expr `url([%e render_string(~loc, url)])]
  | `Interpolation(v) => render_variable(~loc, v)
  | `Image(_)
  | `Image_set(_)
  | `Element(_)
  | `Paint(_)
  | `Cross_fade(_)
  // bs-css only accepts | BackgroundImage.t | #Url.t | #Gradient.t
  | _ => raise(Unsupported_feature)
;

let render_image_or_none = (~loc) => fun
  | `None => [%expr `none]
  | `Image(i) => render_image(~loc, i);

let render_repeat_style = (~loc) => fun
  | `Repeat_x => [%expr `repeatX]
  | `Repeat_y => [%expr `repeatY]
  | `Xor(values) => {
    let render_xor = fun
      | `Repeat => [%expr `repeat]
      | `Space => [%expr `space]
      | `Round => [%expr `round]
      | `No_repeat => [%expr `noRepeat];

      switch (values) {
        | [x] => [%expr [%e render_xor(x)]]
        | [x, y] => [%expr `hv([%e render_xor(x)], [%e render_xor(y)])]
        | [] => failwith("expected at least one value")
        | _ => failwith("repeat doesn't accept more then 2 values");
      }
  };


let render_attachment = (~loc) => fun
  | `Fixed => [%expr `fixed]
  | `Local => [%expr `local]
  | `Scroll => [%expr `scroll];

let background_image =
  apply(
    Parser.property_background_image,
    (~loc) => [%expr CssJs.backgroundImage],
    (~loc) => fun
    | [] => failwith("expected at least one value")
    | [i] => render_image_or_none(~loc, i)
    | _ => raise(Unsupported_feature)
  );

let background_repeat =
  apply(
    Parser.property_background_repeat,
    (~loc) => [%expr CssJs.backgroundRepeat],
    (~loc) => fun
    | [] => failwith("expected at least one value")
    | [`Repeat_x] => [%expr `repeatX]
    | [`Repeat_y] => [%expr `repeatY]
    | [`Xor(_) as v] => render_repeat_style(~loc, v)
    | _ => raise(Unsupported_feature)
  );
let background_attachment =
  apply(
    Parser.property_background_attachment,
    (~loc) => [%expr CssJs.backgroundAttachment],
    (~loc) => fun
    | [] => failwith("expected at least one argument")
    | [v] => render_attachment(~loc, v)
    | _ => raise(Unsupported_feature)
  );

let render_background_position = (~loc, position) => {
  let render_static = fun
    | `Center => [%expr `center]
    | `Left => [%expr `center]
    | `Right => [%expr `center]
    | `Bottom => [%expr `center]
    | `Top => [%expr `center]
    | `Extended_length(l) => render_extended_length(~loc, l)
    | `Extended_percentage(p) => render_extended_percentage(~loc, p);

  let render_and = fun
    | `Center => [%expr `center]
    | `Static((a, b)) => switch (b) {
      | Some(b) => [%expr `hv([%e render_static(a)], [%e render_static(b)])]
      | None => render_static(a)
    };

  switch (position) {
    | `Bottom => [%expr `bottom]
    | `Center => [%expr `center]
    | `Top => [%expr `top]
    | `Left => [%expr `left]
    | `Right => [%expr `right]
    | `Extended_length(l) => render_extended_length(~loc, l)
    | `Extended_percentage(a) => render_extended_percentage(~loc, a)
    | `Static((x, y)) => [%expr `hv([%e render_static(x)], [%e render_static(y)])]
    | `And(left, right) => [%expr `hv([%e render_and(left)], [%e render_and(right)])]
  };
};

let background_position =
  apply(
    Parser.property_background_position,
    (~loc) => [%expr CssJs.backgroundPosition],
    (~loc) => fun
    | [] => failwith("expected at least one argument")
    | [l] => render_background_position(~loc, l)
    | _ => raise(Unsupported_feature)
  );
let background_clip =
  apply(
    Parser.property_background_clip,
    (~loc) => [%expr CssJs.backgroundClip],
    (~loc) => fun
    | [] => failwith("expected at least one argument")
    | [v] => variants_to_expression(~loc, v)
    | _ => raise(Unsupported_feature)
  );
let background_origin =
  apply(
    Parser.property_background_origin,
    (~loc) => [%expr CssJs.backgroundOrigin],
    (~loc) => fun
    | [] => failwith("expected at least one argument")
    | [v] => variants_to_expression(~loc, v)
    | _ => raise(Unsupported_feature)
  );

let background_size =
  apply(
    Parser.property_background_size,
    (~loc) => [%expr CssJs.backgroundSize],
    (~loc) => fun
    | [] => failwith("expected at least one argument")
    | [v] => switch (v) {
        | `Contain => [%expr `contain]
        | `Cover => [%expr `cover]
        | `Xor([`Auto]) => [%expr `auto]
        | `Xor(l) when List.mem(`Auto, l) => raise(Unsupported_feature)
        | `Xor([x, y]) => [%expr `size([%e render_size(~loc, x)], [%e render_size(~loc, y)])]
        | `Xor([_])
        | _ => raise(Unsupported_feature)
      }
    | _ => raise(Unsupported_feature)
  );

let render_background = (~loc, (layers, final_layer)) => {
  let render_layer = (layer, fn, render) =>
    layer |> Option.fold(~none=[], ~some=(l => [[%expr [%e fn]([%e render(l)])]]));

  let render_layers = ((bg_image, bg_position, repeat_style, attachment, b1, b2)) => {
    [
      render_layer(bg_image, [%expr CssJs.backgroundImage], render_image(~loc)),
      render_layer(repeat_style, [%expr CssJs.backgroundRepeat], render_repeat_style(~loc)),
      render_layer(attachment, [%expr CssJs.backgroundRepeat], render_attachment(~loc)),
      render_layer(b1, [%expr CssJs.clip], variants_to_expression(~loc)),
      render_layer(b2, [%expr CssJs.origin], variants_to_expression(~loc)),
    ] @ switch (bg_position) {
      | Some((bg_pos, Some(((), bg_size)))) => [
        [[%expr CssJs.backgroundPosition([%e render_background_position(~loc, bg_pos)])]],
        [[%expr CssJs.backgroundSize([%e render_size(~loc, bg_size)])]],
      ]
      | Some((bg_pos, None)) => [
        [[%expr CssJs.backgroundPosition([%e render_background_position(~loc, bg_pos)])]],
      ]
      | None => []
    };
  }

  let render_final_layer = ((bg_color, bg_image, bg_position, repeat_style, attachment, b1, b2)) => {
    [
      render_layer(bg_color, [%expr CssJs.backgroundColor], render_color(~loc)),
      render_layer(bg_image, [%expr CssJs.backgroundImage], render_image(~loc)),
      render_layer(repeat_style, [%expr CssJs.backgroundRepeat], render_repeat_style(~loc)),
      render_layer(attachment, [%expr CssJs.backgroundRepeat], render_attachment(~loc)),
      render_layer(b1, [%expr CssJs.clip], variants_to_expression(~loc)),
      render_layer(b2, [%expr CssJs.origin], variants_to_expression(~loc)),
    ] @ switch (bg_position) {
      | Some((bg_pos, Some(((), bg_size)))) => [
        [[%expr CssJs.backgroundPosition([%e render_background_position(~loc, bg_pos)])]],
        [[%expr CssJs.backgroundSize([%e render_size(~loc, bg_size)])]],
      ]
      | Some((bg_pos, None)) => [
        [[%expr CssJs.backgroundPosition([%e render_background_position(~loc, bg_pos)])]],
      ]
      | None => []
    };
  }

  List.concat([
    render_final_layer(final_layer) |> List.flatten,
    layers |> List.concat_map(x => x |> fst |> render_layers) |> List.flatten
  ])
};

let background =
  emit(
    Parser.property_background,
    (~loc as _) => id,
    render_background
  );

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
    (~loc) => fun
    | [c] => render_color(~loc, c)
    | _ => raise(Unsupported_feature),
  );

let border_top_style =
  variants(Parser.property_border_top_style, (~loc) => [%expr CssJs.borderTopStyle]);

let border_right_style =
  variants(
    Parser.property_border_right_style,
    (~loc) => [%expr CssJs.borderRightStyle],
  );
let border_bottom_style =
  variants(
    Parser.property_border_bottom_style,
    (~loc) => [%expr CssJs.borderBottomStyle],
  );
let border_left_style =
  variants(Parser.property_border_left_style, (~loc) => [%expr CssJs.borderLeftStyle]);
let border_style =
  apply(Parser.property_border_style, (~loc) => [%expr CssJs.borderStyle], variants_to_expression);

let render_line_width =
  (~loc) => fun
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
    (~loc) => fun
    | [w] => render_size(~loc, w)
    | _ => raise(Unsupported_feature),
  );

let render_line_width_interp =
  (~loc) => fun
  | `Line_width(lw) => render_line_width(~loc, lw)
  | `Interpolation(name) => render_variable(~loc, name);

let render_border_style_interp =
  (~loc) => fun
  | `Interpolation(name) => render_variable(~loc, name)
  | `Line_style(ls) => variants_to_expression(~loc, ls);

type borderDirection = All | Left | Bottom | Right | Top;

let direction_to_border = (~loc) => fun
  | All => [%expr CssJs.border]
  | Left => [%expr CssJs.borderLeft]
  | Bottom => [%expr CssJs.borderBottom]
  | Right => [%expr CssJs.borderRight]
  | Top => [%expr CssJs.borderTop];

let direction_to_fn_name = (~loc) => fun
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
    [[%expr [%e borderFn]([%e render_variable(~loc, name)])]]
  /* bs-css doesn't support border: 1px; */
  | `Xor(_) => raise(Unsupported_feature)
  /* bs-css doesn't support border: 1px solid; */
  | `Static_0(_) => raise(Unsupported_feature)
  | `Static_1((width, style, color)) =>
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

let render_outline_style_interp = (~loc) => fun
  | `Auto => variants_to_expression(~loc, `Auto)
  | `Interpolation(name) => render_variable(~loc, name)
  | `Line_style(ls) => variants_to_expression(~loc, ls)
;

let render_outline = (~loc) => fun
  | `None => [[%expr CssJs.unsafe({js|outline|js}, {js|none|js})]]
  | `Property_outline_width(`Interpolation(name)) =>
    [[%expr CssJs.outline([%e render_variable(~loc, name)])]]
  /* bs-css doesn't support outline: 1px; */
  | `Property_outline_width(_) => raise(Unsupported_feature)
  /* bs-css doesn't support outline: 1px solid; */
  | `Static_0(_) => raise(Unsupported_feature)
  | `Static_1((line_width, style, color)) => [
      [%expr
        CssJs.outline(
          [%e render_line_width_interp(~loc, line_width)],
          [%e render_outline_style_interp(~loc, style)],
          [%e render_color_interp(~loc, color)],
        )
      ],
    ];

let outline =
  emit(
    Parser.property_outline,
    (~loc as _) => id,
    render_outline,
  );

let outline_color = apply(Parser.property_outline_color, (~loc) => [%expr CssJs.outlineColor], render_color);
let outline_offset = apply(Parser.property_outline_offset, (~loc) => [%expr CssJs.outlineOffset], render_extended_length);
let outline_style = apply(Parser.property_outline_style, (~loc) => [%expr CssJs.outlineStyle], render_outline_style_interp)
let outline_width = apply(Parser.property_outline_width, (~loc) => [%expr CssJs.outlineWidth], render_line_width_interp)

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
    render_border(~direction=Bottom)
  );
let border_left =
  emit(
    Parser.property_border,
    (~loc as _) => id,
    render_border(~direction=Left)
  );

let render_border_radius_value =
  (~loc) => fun
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
    render_length_percentage
  );
let border_image_source = unsupportedProperty(Parser.property_border_image_source);
let border_image_slice = unsupportedProperty(Parser.property_border_image_slice);
let border_image_width = unsupportedProperty(Parser.property_border_image_width);
let border_image_outset = unsupportedProperty(Parser.property_border_image_outset);
let border_image_repeat = unsupportedProperty(Parser.property_border_image_repeat);
let border_image = unsupportedProperty(Parser.property_border_image);
let box_shadow =
  apply(
    Parser.property_box_shadow,
    (~loc) => [%expr CssJs.boxShadows],
    (~loc) => fun
    | `None => variants_to_expression(~loc, `None)
    | `Shadow(shadows) => {
        let shadows =
          shadows
          |> List.map(shadow => `Box(shadow))
          |> List.map(render_shadow(~loc));
        Builder.pexp_array(~loc, shadows);
      },
  );

let render_overflow =
  (~loc) => fun
  | `Clip => raise(Unsupported_feature)
  | rest => variants_to_expression(~loc, rest);

// css-overflow-3
// TODO: maybe implement using strings?
let overflow_x =
  apply(Parser.property_overflow_x, (~loc) => [%expr CssJs.overflowX], render_overflow);

let overflow_y =
  variants(Parser.property_overflow_y, (~loc) => [%expr CssJs.overflowY]);

let overflow =
  emit(
    Parser.property_overflow,
    (~loc) => fun
    | `Xor(values) => values |> List.map(render_overflow(~loc))
    | _ => raise(Unsupported_feature),
    (~loc) => fun
    | [all] => [[%expr CssJs.overflow([%e all])]]
    | [_x, _y] => raise(Unsupported_feature)
    | _ => failwith("unreachable"),
  );

// let overflow_clip_margin = unsupportedProperty(Parser.property_overflow_clip_margin);
let overflow_inline = unsupportedProperty(Parser.property_overflow_inline);
let text_overflow =
  unsupportedValue(
    Parser.property_text_overflow,
    (~loc) => [%expr CssJs.textOverflow],
  );
// let block_ellipsis = unsupportedProperty(Parser.property_block_ellipsis);
let max_lines = unsupportedProperty(Parser.property_max_lines);
// let continue = unsupportedProperty(Parser.property_continue);

// css-text-3
let text_transform =
  variants(Parser.property_text_transform, (~loc) => [%expr CssJs.textTransform]);
let white_space =
  variants(Parser.property_white_space, (~loc) => [%expr CssJs.whiteSpace]);
let tab_size = unsupportedProperty(Parser.property_tab_size);
let word_break =
  variants(Parser.property_word_break, (~loc) => [%expr CssJs.wordBreak]);
let line_break = unsupportedProperty(Parser.property_line_break);
let render_line_height = (~loc) => fun
  | `Extended_length(ext) => render_extended_length(~loc, ext)
  | `Extended_percentage(ext) => render_extended_percentage(~loc, ext)
  | `Normal => variants_to_expression(~loc, `Normal)
  | `Number(float) => [%expr `abs([%e render_number(~loc, float) ])];

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
  variants(Parser.property_overflow_wrap, (~loc) => [%expr CssJs.overflowWrap]);
let word_wrap = variants(Parser.property_word_wrap, (~loc) => [%expr CssJs.wordWrap]);
let text_align =
  variants(Parser.property_text_align, (~loc) => [%expr CssJs.textAlign]);
// let text_align_all = unsupportedProperty(Parser.property_text_align_all);
let text_align_last = unsupportedProperty(Parser.property_text_align_last);
let text_justify = unsupportedProperty(Parser.property_text_justify);
let word_spacing =
  apply(
    Parser.property_word_spacing,
    (~loc) => [%expr CssJs.wordSpacing],
    (~loc) => fun
    | `Normal => variants_to_expression(~loc, `Normal)
    | `Extended_length(l) => render_extended_length(~loc, l)
    | `Extended_percentage(p) => render_extended_percentage(~loc, p),
  );
let letter_spacing =
  apply(
    Parser.property_word_spacing,
    (~loc) => [%expr CssJs.letterSpacing],
    (~loc) => fun
    | `Normal => variants_to_expression(~loc, `Normal)
    | `Extended_length(l) => render_extended_length(~loc, l)
    | `Extended_percentage(p) => render_extended_percentage(~loc, p),
  );
let text_indent =
  apply(
    Parser.property_text_indent,
    (~loc) => [%expr CssJs.textIndent],
    (~loc) => fun
    | (`Extended_length(l), None, None) => render_extended_length(~loc, l)
    | (`Extended_percentage(p), None, None) => render_extended_percentage(~loc, p)
    | _ => raise(Unsupported_feature),
  );
let hanging_punctuation = unsupportedProperty(Parser.property_hanging_punctuation);

// css-fonts-4
let font_family =
  unsupportedValue(Parser.property_font_family, (~loc) => [%expr CssJs.fontFamily]);
let font_weight =
  unsupportedValue(Parser.property_font_weight, (~loc) => [%expr CssJs.fontWeight]);
let font_stretch = unsupportedProperty(Parser.property_font_stretch);
let font_style =
  unsupportedValue(Parser.property_font_style, (~loc) => [%expr CssJs.fontStyle]);

/* bs-css does not support these variants */
let render_size_variants = (~loc) => fun
  | `Large => id([%expr `large])
  | `Medium => id([%expr `medium])
  | `Small => id([%expr `small])
  | `X_large => id([%expr `x_large])
  | `X_small => id([%expr `x_small])
  | `Xx_large => id([%expr `xx_large])
  | `Xx_small => id([%expr `xx_small])
  | `Xxx_large => id([%expr `xxx_large])
  | `Larger => id([%expr `larger])
  | `Smaller => id([%expr `smaller]);

let render_font_size = (~loc) => fun
  | `Absolute_size(size)
  | `Relative_size(size) => render_size_variants(~loc, size)
  | `Extended_length(ext) => render_extended_length(~loc, ext)
  | `Extended_percentage(ext) => render_extended_percentage(~loc, ext);
let font_size =
  apply(Parser.property_font_size, (~loc) => [%expr CssJs.fontSize], render_font_size);
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
let font_variant_caps = unsupportedProperty(Parser.property_font_variant_caps);
let font_variant_numeric = unsupportedProperty(Parser.property_font_variant_numeric);
let font_variant_alternates =
  unsupportedProperty(Parser.property_font_variant_alternates);
let font_variant_east_asian =
  unsupportedProperty(Parser.property_font_variant_east_asian);
let font_variant =
  unsupportedValue(Parser.property_font_variant, (~loc) => [%expr CssJs.fontVariant]);
let font_feature_settings =
  unsupportedProperty(Parser.property_font_feature_settings);
let font_optical_sizing = unsupportedProperty(Parser.property_font_optical_sizing);
let font_variation_settings =
  unsupportedProperty(Parser.property_font_variation_settings);
// let font_palette = unsupportedProperty(Parser.property_font_palette);
// let font_variant_emoji = unsupportedProperty(Parser.property_font_variant_emoji);

// css-text-decor-3
let text_decoration_line =
  unsupportedValue(
    Parser.property_text_decoration_line,
    (~loc) => [%expr CssJs.textDecorationLine],
  );
let text_decoration_style =
  unsupportedValue(
    Parser.property_text_decoration_style,
    (~loc) => [%expr CssJs.textDecorationStyle],
  );
let text_decoration_color =
  apply(
    Parser.property_text_decoration_color,
    (~loc) => [%expr CssJs.textDecorationColor],
    render_color,
  );
let text_decoration_thickness =
  unsupportedProperty(Parser.property_text_decoration_thickness);
let text_decoration =
  unsupportedValue(
    Parser.property_text_decoration,
    (~loc) => [%expr CssJs.textDecoration],
  );
let text_underline_position =
  unsupportedProperty(Parser.property_text_underline_position);
let text_underline_offset =
  unsupportedProperty(Parser.property_text_underline_offset);
let text_decoration_skip = unsupportedProperty(Parser.property_text_decoration_skip);
// let text_decoration_skip_self =
//   unsupportedProperty(Parser.property_text_decoration_skip_self);
// let text_decoration_skip_box = unsupportedProperty(Parser.property_text_decoration_skip_box);
// let text_decoration_skip_inset =
//   unsupportedProperty(Parser.property_text_decoration_skip_inset);
// let text_decoration_skip_spaces =
//   unsupportedProperty(Parser.property_text_decoration_skip_spaces);
let text_decoration_skip_ink =
  unsupportedProperty(Parser.property_text_decoration_skip_ink);
let text_emphasis_style = unsupportedProperty(Parser.property_text_emphasis_style);
let text_emphasis_color = unsupportedProperty(Parser.property_text_emphasis_color);
let text_emphasis = unsupportedProperty(Parser.property_text_emphasis);
let text_emphasis_position =
  unsupportedProperty(Parser.property_text_emphasis_position);
// let text_emphasis_skip = unsupportedProperty(Parser.property_text_emphasis_skip);
let text_shadow =
  unsupportedValue(Parser.property_text_shadow, (~loc) => [%expr CssJs.textShadow]);

let render_transform_functions = (~loc) => fun
  | `Zero(_) => [%expr `zero]
  | `Extended_angle(a) => [%expr [%e render_extended_angle(~loc, a)]];

let render_transform = (~loc) => fun
  | `Function_perspective(_) => raise(Unsupported_feature)
  | `Function_matrix(_) => raise(Unsupported_feature)
  | `Function_matrix3d(_) => raise(Unsupported_feature)
  | `Function_rotate(v) => [%expr CssJs.rotate([%e render_transform_functions(~loc, v)])]
  | `Function_rotate3d((x, (), y, (), z, (), a)) =>
      [%expr CssJs.rotate3d(
        [%e render_number(~loc, x)],
        [%e render_number(~loc, y)],
        [%e render_number(~loc, z)],
        [%e render_transform_functions(~loc, a)]
      )]
  | `Function_rotateX(v) => [%expr CssJs.rotateX([%e render_transform_functions(~loc, v)])]
  | `Function_rotateY(v) => [%expr CssJs.rotateY([%e render_transform_functions(~loc, v)])]
  | `Function_rotateZ(v) => [%expr CssJs.rotateZ([%e render_transform_functions(~loc, v)])]
  | `Function_skew((a1, a2)) => switch (a2) {
     | Some(((), v)) =>
        [%expr CssJs.skew(
          [%e render_transform_functions(~loc, a1)], [%e render_transform_functions(~loc, v)]
        )]
     | None => [%expr CssJs.skew([%e render_transform_functions(~loc, a1)], 0)]
   }
  | `Function_skewX(v) => [%expr CssJs.skewX([%e render_transform_functions(~loc, v)])]
  | `Function_skewY(v) => [%expr CssJs.skewY([%e render_transform_functions(~loc, v)])]
  | `Function_translate((x, None)) => [%expr CssJs.translate([%e render_size(~loc, x)], 0)]
  | `Function_translate((x, Some(((), v)))) => [%expr CssJs.translate([%e render_size(~loc, x)], [%e render_size(~loc, v)])]
  | `Function_translate3d((x, (), y, (), z)) => [%expr CssJs.translate3d([%e render_size(~loc, x)], [%e render_size(~loc, y)], [%e render_extended_length(~loc, z)])]
  | `Function_translateX(x) => [%expr CssJs.translateX([%e render_size(~loc, x)])]
  | `Function_translateY(y) => [%expr CssJs.translateY([%e render_size(~loc, y)])]
  | `Function_translateZ(z) => [%expr CssJs.translateZ([%e render_extended_length(~loc, z)])]
  | `Function_scale((x, None)) => [%expr CssJs.scale([%e render_number(~loc, x)], [%e render_number(~loc, x)])]
  | `Function_scale((x, Some(((), v)))) => [%expr CssJs.scale([%e render_number(~loc, x)], [%e render_number(~loc, v)])]
  | `Function_scale3d((x, (), y, (), z)) => [%expr CssJs.scale3d([%e render_number(~loc, x)], [%e render_number(~loc, y)], [%e render_number(~loc, z)])]
  | `Function_scaleX(x) => [%expr CssJs.scaleX([%e render_number(~loc, x)])]
  | `Function_scaleY(y) => [%expr CssJs.scaleY([%e render_number(~loc, y)])]
  | `Function_scaleZ(z) => [%expr CssJs.scaleZ([%e render_number(~loc, z)])];

// css-transforms-2
let transform =
  emit(
    Parser.property_transform,
    (~loc as _) => id,
    (~loc) => fun
    | `None => [[%expr CssJs.transform(`none)]]
    | `Transform_list([one]) => [[%expr CssJs.transform([%e render_transform(~loc, one)])]]
    | `Transform_list(list) => {
      let transforms = List.map(render_transform(~loc), list) |> Builder.pexp_array(~loc=Location.none);
      [[%expr CssJs.transforms([%e transforms])]];
    }
  );

let transform_origin =
  unsupportedValue(
    Parser.property_transform_origin,
    (~loc) => [%expr CssJs.transformOrigin],
  );
let transform_box =
  unsupportedValue(
    Parser.property_transform_box,
    (~loc) => [%expr CssJs.transformOrigin],
  );
let translate =
  unsupportedValue(Parser.property_translate, (~loc) => [%expr CssJs.translate]);
let rotate = unsupportedValue(Parser.property_rotate, (~loc) => [%expr CssJs.rotate]);
let scale = unsupportedValue(Parser.property_scale, (~loc) => [%expr CssJs.scale]);
let transform_style =
  unsupportedValue(
    Parser.property_transform_style,
    (~loc) => [%expr CssJs.transformStyle],
  );
let perspective = unsupportedProperty(Parser.property_perspective);
let perspective_origin =
  unsupportedValue(
    Parser.property_perspective_origin,
    (~loc) => [%expr CssJs.transformStyle],
  );
let backface_visibility =
  unsupportedValue(
    Parser.property_backface_visibility,
    (~loc) => [%expr CssJs.backfaceVisibility],
  );

// css-transition-1
let transition_property =
  unsupportedValue(
    Parser.property_transition_property,
    (~loc) => [%expr CssJs.transitionProperty],
  );
let transition_duration =
  unsupportedValue(
    Parser.property_transition_duration,
    (~loc) => [%expr CssJs.transitionDuration],
  );
let widows = apply(Parser.property_widows, (~loc) => [%expr CssJs.widows], render_integer);
let transition_timing_function =
  unsupportedValue(
    Parser.property_transition_timing_function,
    (~loc) => [%expr CssJs.transitionTimingFunction],
  );
let transition_delay =
  unsupportedValue(
    Parser.property_transition_delay,
    (~loc) => [%expr CssJs.transitionDelay],
  );
let transition =
  unsupportedValue(Parser.property_transition, (~loc) => [%expr CssJs.transition]);

// css-animation-1
let animation_name =
  unsupportedValue(
    Parser.property_animation_name,
    (~loc) => [%expr CssJs.animationName],
  );
let animation_duration =
  unsupportedValue(
    Parser.property_animation_duration,
    (~loc) => [%expr CssJs.animationDuration],
  );
let animation_timing_function =
  unsupportedValue(
    Parser.property_animation_timing_function,
    (~loc) => [%expr CssJs.CssJs.animationTimingFunction],
  );
let animation_iteration_count =
  unsupportedValue(
    Parser.property_animation_iteration_count,
    (~loc) => [%expr CssJs.animationIterationCount],
  );
let animation_direction =
  unsupportedValue(
    Parser.property_animation_direction,
    (~loc) => [%expr CssJs.animationDirection],
  );
let animation_play_state =
  unsupportedValue(
    Parser.property_animation_play_state,
    (~loc) => [%expr CssJs.animationPlayState],
  );
let animation_delay =
  unsupportedValue(
    Parser.property_animation_delay,
    (~loc) => [%expr CssJs.animationDelay],
  );
let animation_fill_mode =
  unsupportedValue(
    Parser.property_animation_fill_mode,
    (~loc) => [%expr CssJs.animationFillMode],
  );
let animation =
  unsupportedValue(Parser.property_animation, (~loc) => [%expr CssJs.animation]);

// css-flexbox-1
let flex_direction =
  variants(Parser.property_flex_direction, (~loc) => [%expr CssJs.flexDirection]);
let flex_wrap = variants(Parser.property_flex_wrap, (~loc) => [%expr CssJs.flexWrap]);

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
        Option.map(ast => flex_wrap.ast_to_expr(~loc, `Value(ast)), wrap_ast);
      [direction, wrap] |> List.concat_map(Option.value(~default=[]));
    },
  );
// TODO: this is safe?
let order = apply(Parser.property_order, (~loc) => [%expr CssJs.order], render_integer);
let flex_grow =
  apply(Parser.property_flex_grow, (~loc) => [%expr CssJs.flexGrow], render_number);
let flex_shrink =
  apply(Parser.property_flex_shrink, (~loc) => [%expr CssJs.flexShrink], render_number);

let flex_basis =
  apply(
    Parser.property_flex_basis,
    (~loc) => [%expr CssJs.flexBasis],
    (~loc) => fun
    | `Content => variants_to_expression(~loc, `Content)
    | `Property_width(value_width) =>
      width.value_of_ast(~loc, `Value(value_width)),
  );

// TODO: this is incomplete
let flex =
  emit(
    Parser.property_flex,
    (~loc as _) => id,
    (~loc) => fun
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
  unsupportedValue(
    Parser.property_justify_content,
    (~loc) => [%expr CssJs.justifyContent],
  );
let align_items =
  unsupportedValue(Parser.property_align_items, (~loc) => [%expr CssJs.alignItems]);
let align_self =
  unsupportedValue(Parser.property_align_self, (~loc) => [%expr CssJs.alignSelf]);
let align_content =
  unsupportedValue(
    Parser.property_align_content,
    (~loc) => [%expr CssJs.alignContent],
  );

// css-grid-1
let grid_template_columns =
  unsupportedValue(
    Parser.property_grid_template_columns,
    (~loc) => [%expr CssJs.gridTemplateColumns],
  );
let grid_template_rows =
  unsupportedValue(
    Parser.property_grid_template_rows,
    (~loc) => [%expr CssJs.gridTemplateRows],
  );
let grid_template_areas =
  unsupportedValue(
    Parser.property_grid_template_areas,
    (~loc) => [%expr CssJs.gridTemplateAreas],
  );
let grid_template = unsupportedProperty(Parser.property_grid_template);
let grid_auto_columns =
  unsupportedValue(
    Parser.property_grid_auto_columns,
    (~loc) => [%expr CssJs.gridAutoColumns],
  );
let grid_auto_rows =
  unsupportedValue(
    Parser.property_grid_auto_rows,
    (~loc) => [%expr CssJs.gridAutoRows],
  );
let grid_auto_flow =
  unsupportedValue(
    Parser.property_grid_auto_flow,
    (~loc) => [%expr CssJs.gridAutoFlow],
  );
let grid = unsupportedValue(Parser.property_grid, (~loc) => [%expr CssJs.grid]);
let grid_row_start =
  unsupportedValue(
    Parser.property_grid_row_start,
    (~loc) => [%expr CssJs.gridRowStart],
  );
let grid_column_start =
  unsupportedValue(
    Parser.property_grid_column_start,
    (~loc) => [%expr CssJs.gridColumnStart],
  );
let grid_row_end =
  unsupportedValue(Parser.property_grid_row_end, (~loc) => [%expr CssJs.gridRowEnd]);
let grid_column_end =
  unsupportedValue(
    Parser.property_grid_column_end,
    (~loc) => [%expr CssJs.gridColumnEnd],
  );
let grid_row =
  unsupportedValue(Parser.property_grid_row, (~loc) => [%expr CssJs.gridRow]);
let grid_column =
  unsupportedValue(Parser.property_grid_column, (~loc) => [%expr CssJs.gridColumn]);
let grid_area =
  unsupportedValue(Parser.property_grid_area, (~loc) => [%expr CssJs.gridArea]);
let z_index =
  unsupportedValue(Parser.property_z_index, (~loc) => [%expr CssJs.zIndex]);

let render_position_value = (~loc) => fun
  | `Auto => variants_to_expression(~loc, `Auto)
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
    render_display
  );

/* let render_mask_source = (~loc) => fun
  | `Interpolation(v) => render_variable(v)
  | `Cross_fade()
  | `Element()
  | `Image()
  | `Image_set()
  | `Paint() => raise(Unsupported_feature)
; */

let render_mask_image = (~loc) => fun
  | `None => [%expr `none]
  | `Image(i) => render_image(~loc, i)
  | `Mask_source(_) => raise(Unsupported_feature);

let mask_image =
  apply(
    Parser.property_mask_image,
    (~loc) => [%expr CssJs.maskImage],
    (~loc) => fun
      | [one] => render_mask_image(~loc, one)
      | []
      | _ => raise(Unsupported_feature)
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
  ("grid-column-start", found(grid_column_start)),
  ("grid-row-end", found(grid_row_end)),
  ("grid-column-end", found(grid_column_end)),
  ("grid-row", found(grid_row)),
  ("grid-column", found(grid_column)),
  ("grid-area", found(grid_area)),
  //
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
  ("outline-width", found(outline_width))
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

let parse_declarations = (~loc, property, value) => {
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
