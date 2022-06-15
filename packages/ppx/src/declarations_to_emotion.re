open Ppxlib;
open Reason_css_parser;

module Helper = Ast_helper;
module Builder = Ppxlib.Ast_builder.Default;

/* helpers */
let loc = Location.none;
let txt = txt => {Location.loc: Location.none, txt};

let (let.ok) = Result.bind;

exception Unsupported_feature;

let id = Fun.id;

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

let emit_shorthand = (parser, mapper, value_to_expr) => {
  let ast_of_string = Parser.parse(parser);
  let ast_to_expr = ast => ast |> List.map(mapper) |> value_to_expr;
  let string_to_expr = string =>
    ast_of_string(string) |> Result.map(ast_to_expr);

  {
    ast_of_string,
    value_of_ast: List.map(mapper),
    value_to_expr,
    ast_to_expr,
    string_to_expr,
  };
};

let render_string = string =>
  Helper.Const.string(string) |> Helper.Exp.constant;
let render_integer = integer =>
  Helper.Const.int(integer) |> Helper.Exp.constant;
let render_number = number =>
  Helper.Const.float(number |> string_of_float) |> Helper.Exp.constant;
let render_percentage = number => [%expr `percent([%e render_number(number)])];

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

let variants_to_expression =
  fun
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
  | `FitContent => id([%expr `fitContent])
  | `MaxContent => id([%expr `maxContent])
  | `MinContent => id([%expr `minContent])
  | `Full_size_kana => raise(Unsupported_feature);

let list_to_longident = vars => vars |> String.concat(".") |> Longident.parse;

let render_variable = name =>
  list_to_longident(name) |> txt |> Helper.Exp.ident;

// TODO: all of them could be float, but bs-css doesn't support it
let render_length =
  fun
  | `Cap(_n) => raise(Unsupported_feature)
  | `Ch(n) => [%expr `ch([%e render_number(n)])]
  | `Cm(n) => [%expr `cm([%e render_number(n)])]
  | `Em(n) => [%expr `em([%e render_number(n)])]
  | `Ex(n) => [%expr `ex([%e render_number(n)])]
  | `Ic(_n) => raise(Unsupported_feature)
  | `In(_n) => raise(Unsupported_feature)
  | `Lh(_n) => raise(Unsupported_feature)
  | `Mm(n) => [%expr `mm([%e render_number(n)])]
  | `Pc(n) => [%expr `pc([%e render_number(n)])]
  | `Pt(n) => [%expr `pt([%e render_integer(n |> int_of_float)])]
  | `Px(n) => [%expr `pxFloat([%e render_number(n)])]
  | `Q(_n) => raise(Unsupported_feature)
  | `Rem(n) => [%expr `rem([%e render_number(n)])]
  | `Rlh(_n) => raise(Unsupported_feature)
  | `Vb(_n) => raise(Unsupported_feature)
  | `Vh(n) => [%expr `vh([%e render_number(n)])]
  | `Vi(_n) => raise(Unsupported_feature)
  | `Vmax(n) => [%expr `vmax([%e render_number(n)])]
  | `Vmin(n) => [%expr `vmin([%e render_number(n)])]
  | `Vw(n) => [%expr `vw([%e render_number(n)])]
  | `Zero => [%expr `zero];

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
      [%expr `calc([%e op], [%e first], [%e second])];
    }
  }
}
and render_sum_op = op => {
  switch (op) {
    | `Dash(()) => [%expr `sub]
    | `Cross(()) => [%expr `add]
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
      let _first = render_calc_value(calc_value);
      let _second = render_list_of_products(list_of_products);
      /* [%expr (`mult, [%e first], [%e second])]; */
      failwith("`mult isn't available in bs-css");
    }
  }
} and render_product_op = (op) => {
  switch (op) {
    | `Static_0((), calc_value) => render_calc_value(calc_value)
    | `Static_1((), float) => render_number(float)
  }
} and render_calc_value = calc_value => {
  switch (calc_value) {
    | `Number(float) => render_number(float)
    | `Extended_length(l) => render_extended_length(l)
    | `Extended_percentage(p) => render_extended_percentage(p)
    | `Function_calc(fc) => render_function_calc(fc)
  }
} and render_extended_length = fun
  | `Length(l) => render_length(l)
  | `Function_calc(fc) => render_function_calc(fc)
  | `Interpolation(i) => render_variable(i)
and render_extended_percentage = fun
  | `Percentage(p) => render_percentage(p)
  | `Function_calc(fc) => render_function_calc(fc)
  | `Interpolation(i) => render_variable(i);

let render_length_percentage = fun
  | `Extended_length(ext) => render_extended_length(ext)
  | `Extended_percentage(ext) => render_extended_percentage(ext);

// css-sizing-3
let render_size =
  fun
  | `Auto => variants_to_expression(`Auto)
  | `Extended_length(l) => render_extended_length(l)
  | `Extended_percentage(p) => render_extended_percentage(p)
  | `Function_calc(fc) => render_function_calc(fc)
  | `Fit_content_0 => variants_to_expression(`FitContent)
  | `Max_content => variants_to_expression(`MaxContent)
  | `Min_content => variants_to_expression(`MinContent)
  | `Fit_content_1(_)
  | _ => raise(Unsupported_feature);

let render_angle =
  fun
  | `Deg(number) => id([%expr `deg([%e render_number(number)])])
  | `Rad(number) => id([%expr `rad([%e render_number(number)])])
  | `Grad(number) => id([%expr `grad([%e render_number(number)])])
  | `Turn(number) => id([%expr `turn([%e render_number(number)])]);

let render_extended_angle = fun
  | `Angle(a) => render_angle(a)
  | `Function_calc(fc) => render_function_calc(fc)
  | `Interpolation(i) => render_variable(i);

let transform_with_variable = (parser, mapper, value_to_expr) =>
  emit(
    Combinator.combine_xor([
      /* If the entire CSS value is interpolated, we treat it as a `Variable */
      Rule.Match.map(Standard.interpolation, data => `Variable(data)),
      /* Otherwise it's a regular CSS `Value and run the mapper below*/
      Rule.Match.map(parser, data => `Value(data)),
    ]),
    fun
    | `Variable(name) => render_variable(name)
    | `Value(ast) => mapper(ast),
    value_to_expr,
  );

let apply = (parser, id, map) =>
  transform_with_variable(parser, map, arg => [[%expr [%e id]([%e arg])]]);

let unsupportedValue = (parser, call: expression) =>
  transform_with_variable(
    parser,
    _ => raise(Unsupported_feature),
    arg => [[%expr [%e call]([%e arg])]],
  );

let unsupportedProperty = (~call=?, parser) =>
  transform_with_variable(
    parser,
    _ => raise(Unsupported_feature),
    call
    |> Option.map((call, arg) => [[%expr [%e call]([%e arg])]])
    |> Option.value(~default=_ => raise(Unsupported_feature)),
  );

let variants = (parser, identifier) =>
  apply(parser, identifier, variants_to_expression);

let width = apply(Parser.property_width, [%expr CssJs.width], render_size);
let height = apply(Parser.property_height, [%expr CssJs.height], render_size);
let min_width =
  apply(Parser.property_min_width, [%expr CssJs.minWidth], render_size);
let min_height =
  apply(Parser.property_min_height, [%expr CssJs.minHeight], render_size);
let max_width =
  apply(
    Parser.property_max_width,
    [%expr CssJs.maxWidth],
    render_size
  );
let max_height =
  apply(Parser.property_max_height, [%expr CssJs.maxHeight], render_size
  );
let box_sizing =
  apply(
    Parser.property_box_sizing,
    [%expr CssJs.boxSizing],
    variants_to_expression,
  );
let column_width = unsupportedProperty(Parser.property_column_width);

let margin_value =
  fun
  | `Auto => variants_to_expression(`Auto)
  | `Extended_length(l) => render_extended_length(l)
  | `Extended_percentage(p) => render_extended_percentage(p);

let padding_value =
  fun
  | `Auto => variants_to_expression(`Auto)
  | `Extended_length(l) => render_extended_length(l)
  | `Extended_percentage(p) => render_extended_percentage(p)

// css-box-3
let margin_top =
  apply(Parser.property_margin_top, [%expr CssJs.marginTop], margin_value);
let margin_right =
  apply(
    Parser.property_margin_right,
    [%expr CssJs.marginRight],
    margin_value,
  );
let margin_bottom =
  apply(
    Parser.property_margin_bottom,
    [%expr CssJs.marginBottom],
    margin_value,
  );
let margin_left =
  apply(Parser.property_margin_left, [%expr CssJs.marginLeft], margin_value);

let margin =
  emit_shorthand(
    Parser.property_margin,
    fun
    | `Auto => variants_to_expression(`Auto)
    | `Extended_length(l) => render_extended_length(l)
    | `Extended_percentage(p) => render_extended_percentage(p)
    | `Interpolation(name) => render_variable(name),
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
  apply(Parser.property_padding_top, [%expr CssJs.paddingTop], padding_value);
let padding_right =
  apply(
    Parser.property_padding_right,
    [%expr CssJs.paddingRight],
    padding_value,
  );
let padding_bottom =
  apply(
    Parser.property_padding_bottom,
    [%expr CssJs.paddingBottom],
    padding_value,
  );
let padding_left =
  apply(
    Parser.property_padding_left,
    [%expr CssJs.paddingLeft],
    padding_value,
  );

let padding =
  emit_shorthand(
    Parser.property_padding,
    fun
    | `Extended_length(l) => render_extended_length(l)
    | `Extended_percentage(p) => render_extended_percentage(p)
    | `Interpolation(name) => render_variable(name),
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

let render_named_color =
  fun
  | `Transparent => variants_to_expression(`Transparent)
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
  fun
  | `Number(number) => [%expr `num([%e render_number(number)])]
  | `Extended_percentage(`Percentage(pct)) => render_percentage(pct /. 100.0)
  | `Extended_percentage(pct) => render_extended_percentage(pct);

let render_function_rgb = ast => {
  let color_to_float = v => render_integer(v |> int_of_float);

  let to_number = fun
    // TODO: bs-css rgb(float, float, float)
    | `Percentage(pct) => color_to_float(pct *. 2.55)
    | `Function_calc(fc) => render_function_calc(fc)
    | `Interpolation(v) => render_variable(v)
    | `Extended_percentage(ext) => render_extended_percentage(ext);

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

  let alpha = Option.map(render_color_alpha, alpha);

  switch (alpha) {
  | Some(a) => id([%expr `rgba(([%e red], [%e green], [%e blue], [%e a]))])
  | None => id([%expr `rgb(([%e red], [%e green], [%e blue]))])
  };
};

let render_function_hsl = ((hue, saturation, lightness, alpha)) => {
  let hue =
    switch (hue) {
    | `Number(degs) => render_angle(`Deg(degs))
    | `Extended_angle(angle) => render_extended_angle(angle)
    };

  let saturation = render_extended_percentage(saturation);
  let lightness = render_extended_percentage(lightness);

  let alpha =
    switch (alpha) {
    | Some(((), alpha)) => Some(alpha)
    | None => None
    };

  let alpha = Option.map(render_color_alpha, alpha);

  switch (alpha) {
  | Some(alpha) =>
    id(
      [%expr `hsla(([%e hue], [%e saturation], [%e lightness], [%e alpha]))],
    )
  | None => id([%expr `hsl(([%e hue], [%e saturation], [%e lightness]))])
  };
};

let render_color =
  fun
  | `Interpolation(v) => render_variable(v)
  | `Hex_color(hex) => id([%expr `hex([%e render_string(hex)])])
  | `Named_color(color) => render_named_color(color)
  | `CurrentColor => id([%expr `currentColor])
  | `Function_rgb(rgb)
  | `Function_rgba(rgb) => render_function_rgb(rgb)
  | `Function_hsl(`Hsl_0(hsl))
  | `Function_hsla(`Hsl_0(hsl)) => render_function_hsl(hsl)
  | `Function_hsl(_)
  | `Function_hsla(_)
  | `Function_hwb(_)
  | `Function_lab(_)
  | `Function_lch(_)
  | `Function_color(_)
  | `Function_device_cmyk(_)
  | `Deprecated_system_color(_)
  | _ => raise(Unsupported_feature);

let color = apply(Parser.property_color, [%expr CssJs.color], render_color);
let opacity =
  apply(
    Parser.property_opacity,
    [%expr CssJs.opacity],
    fun
    | `Number(number) => render_number(number)
    | `Extended_percentage(`Percentage(number)) => render_number(number /. 100.0)
    | `Extended_percentage(pct) => render_extended_percentage(pct)
  );

// css-images-4
let render_position = position => {
  let pos_to_percentage_offset =
    fun
    | `Left
    | `Top => 0.
    | `Right
    | `Bottom => 100.
    | `Center => 50.;

  let to_value =
    fun
    | `Position(pos) => variants_to_expression(pos)
    | `Extended_length(l) => render_extended_length(l)
    | `Extended_percentage(percentage) => render_extended_percentage(percentage);

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

  let horizontal = to_value(horizontal);

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

  let vertical = to_value(vertical);

  id([%expr `hv(([%e horizontal], [%e vertical]))]);
};

let object_fit =
  variants(Parser.property_object_fit, [%expr CssJs.objectFit]);
let object_position =
  apply(
    Parser.property_object_position,
    [%expr CssJs.objectPosition],
    render_position,
  );
let image_resolution = unsupportedProperty(Parser.property_image_resolution);
let image_orientation = unsupportedProperty(Parser.property_image_orientation);
let image_rendering = unsupportedProperty(Parser.property_image_rendering);

let render_color_interp =
  fun
  | `Interpolation(name) => render_variable(name)
  | `Color(ls) => render_color(ls);

let render_length_interp =
  fun
  | `Extended_length(l) => render_extended_length(l)
  | `Interpolation(name) => render_variable(name);

// css-backgrounds-3
let render_shadow = shadow => {
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
    |> render_color_interp;
  let x = render_length_interp(x);
  let y = render_length_interp(y);
  let blur = Option.map(render_length_interp, blur);
  let spread = Option.map(render_length_interp, spread);
  let inset =
    Option.map(
      () =>
        Helper.Exp.construct(
          {txt: Lident("true"), loc: Location.none},
          None,
        ),
      inset,
    );

  let id =
    switch (shadow) {
    | `Box(_) => id([%expr CssJs.Shadow.box])
    };

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

  Helper.Exp.apply(id, args);
};
let background_color =
  apply(
    Parser.property_background_color,
    [%expr CssJs.backgroundColor],
    render_color,
  );

let render_background_image = fun
  | `None => [%expr `none]
  | _ => raise(Unsupported_feature); // bs-css only accepts none

let render_repeat_style = fun
  | `Xor(values) => {
     let render_xor = fun
      | `Repeat => [%expr `repeat]
      | `Space => [%expr `space]
      | `Round => [%expr `round]
      | `No_repeat => [%expr `noRepeat]
      switch(values){
        | [] => failwith("expected at least one value")
        | [x] => [%expr [%e render_xor(x)]]
        | [x, y] => [%expr `hv([%e render_xor(x)], [%e render_xor(y)])]
        | _ => failwith("repeat doesn't accept more then 2 values");
      }
  }
  | `Repeat_x => [%expr `repeatX]
  | `Repeat_y => [%expr `repeatY];


let render_attachment = fun
  | `Fixed => [%expr `fixed]
  | `Local => [%expr `local]
  | `Scroll => [%expr `scroll];

let background_image =
  emit(
    Parser.property_background_image,
    id,
    fun
    | [] => failwith("expected at least one value")
    | [v] => [[%expr CssJs.backgroundImage([%e render_background_image(v)])]]
    | _ => raise(Unsupported_feature)
  );

let background_repeat =
  emit(
    Parser.property_background_repeat,
    id,
    fun
    | [] => failwith("expected at least one value")
    | [`Repeat_x] => [[%expr CssJs.backgroundRepeat([`repeatX])]]
    | [`Repeat_y] =>[[%expr CssJs.backgroundRepeat(`repeatY)]]
    | [`Xor(_) as v] => [[%expr CssJs.backgroundRepeat([%e render_repeat_style(v)])]]
    | _ => raise(Unsupported_feature)
  );
let background_attachment =
  emit(
    Parser.property_background_attachment,
    id,
    fun
    | [] => failwith("expected at least one argument")
    | [v] => [[%expr CssJs.backgroundAttachment([%e render_attachment(v)])]]
    | _ => raise(Unsupported_feature)
  );

let render_bg_position = (bg_position) => {

  let render_static = fun
  | `Center => [%expr `center]
  | `Left => [%expr `center]
  | `Right => [%expr `center]
  | `Bottom => [%expr `center]
  | `Top => [%expr `center]
  | `Extended_length(l) => render_extended_length(l)
  | `Extended_percentage(p) => render_extended_percentage(p);

  let render_and = fun
    | `Center => [%expr `center]
    | `Static((a, b)) => switch(b){
      | Some(b) => [%expr `hv([%e render_static(a)], [%e render_static(b)])]
      | None => render_static(a)
    };

  switch(bg_position){
  | `And(left, right) => [%expr `hv([%e render_and(left)], [%e render_and(right)])]
  | `Bottom => [%expr `bottom]
  | `Center => [%expr `center]
  | `Top => [%expr `top]
  | `Left => [%expr `left]
  | `Right => [%expr `right]
  | `Extended_length(l) => render_extended_length(l)
  | `Extended_percentage(a) => render_extended_percentage(a)
  | `Static((x,y)) => [%expr `hv([%e render_static(x)], [%e render_static(y)])];
  };
}

let background_position =
  apply(
    Parser.property_background_position,
    [%expr CssJs.backgroundPosition],
    fun
    | [] => failwith("expected at least one argument")
    | [l] => render_bg_position(l)
    | _ => raise(Unsupported_feature)
  );
let background_clip =
  apply(
    Parser.property_background_clip,
    [%expr CssJs.backgroundClip],
    fun
    | [] => failwith("expected at least one argument")
    | [v] => variants_to_expression(v)
    | _ => raise(Unsupported_feature)
  );
let background_origin =
  apply(
    Parser.property_background_origin,
    [%expr CssJs.backgroundOrigin],
    fun
    | [] => failwith("expected at least one argument")
    | [v] => variants_to_expression(v)
    | _ => raise(Unsupported_feature)
  );
let background_size =
  apply(
    Parser.property_background_size,
    [%expr CssJs.backgroundSize],
    fun
    | [] => failwith("expected at least one argument")
    | [v] => switch(v){
        | `Contain => [%expr `contain]
        | `Cover => [%expr `cover]
        | `Xor([`Auto]) => [%expr `auto]
        | `Xor(l) when List.mem(`Auto, l) => raise(Unsupported_feature)
        | `Xor([x,y]) => [%expr `size([%e render_size(x)], [%e render_size(y)])]
        | `Xor([_])
        | _ => raise(Unsupported_feature)
        }
    | _ => raise(Unsupported_feature)
  );
let render_background = ((layers, final_layer)) => {

  let render_layer = (layer, fn_call, render_fn) => Option.fold(~none=[], ~some=(l => [[%expr [%e fn_call]([%e render_fn(l)])]]), layer);

  let render_layers = ((bg_image, bg_position, repeat_style, attachment, b1, b2)) => {
    [
      render_layer(bg_image, [%expr CssJs.background_image], render_background_image),
      render_layer(repeat_style, [%expr CssJs.backgroundRepeat], render_repeat_style),
      render_layer(attachment, [%expr CssJs.backgroundRepeat], render_attachment),
      render_layer(b1, [%expr CssJs.clip], variants_to_expression),
      render_layer(b2, [%expr CssJs.origin], variants_to_expression),
    ] @ switch(bg_position){
      | Some((bg_pos, Some(((), bg_size)))) => [
        [[%expr CssJs.backgroundPosition([%e render_bg_position(bg_pos)])]],
        [[%expr CssJs.backgroundSize([%e render_size(bg_size)])]],
      ]
      | Some((bg_pos, None)) => [
        [[%expr CssJs.backgroundPosition([%e render_bg_position(bg_pos)])]],
      ]
      | None => []
    };
  }

  let render_final_layer = ((bg_color, bg_image, bg_position, repeat_style, attachment, b1, b2)) => {
    [
      render_layer(bg_color, [%expr CssJs.backgroundColor], render_color),
      render_layer(bg_image, [%expr CssJs.background_image], render_background_image),
      render_layer(repeat_style, [%expr CssJs.backgroundRepeat], render_repeat_style),
      render_layer(attachment, [%expr CssJs.backgroundRepeat], render_attachment),
      render_layer(b1, [%expr CssJs.clip], variants_to_expression),
      render_layer(b2, [%expr CssJs.origin], variants_to_expression),
    ] @ switch(bg_position){
      | Some((bg_pos, Some(((), bg_size)))) => [
        [[%expr CssJs.backgroundPosition([%e render_bg_position(bg_pos)])]],
        [[%expr CssJs.backgroundSize([%e render_size(bg_size)])]],
      ]
      | Some((bg_pos, None)) => [
        [[%expr CssJs.backgroundPosition([%e render_bg_position(bg_pos)])]],
      ]
      | None => []
    };
  }

    let l = layers |> List.concat_map(x => x |> fst |> render_layers)

    List.concat([
     render_final_layer(final_layer) |> List.flatten,
     l |> List.flatten
    ])
}
let background =
  emit(
    Parser.property_background,
    id,
    render_background
  );

let border_top_color =
  apply(
    Parser.property_border_top_color,
    [%expr CssJs.borderTopColor],
    render_color,
  );
let border_right_color =
  apply(
    Parser.property_border_right_color,
    [%expr CssJs.borderRightColor],
    render_color,
  );
let border_bottom_color =
  apply(
    Parser.property_border_bottom_color,
    [%expr CssJs.borderBottomColor],
    render_color,
  );
let border_left_color =
  apply(
    Parser.property_border_left_color,
    [%expr CssJs.borderLeftColor],
    render_color,
  );
let border_color =
  apply(Parser.property_border_color, [%expr CssJs.borderColor], c =>
    switch (c) {
    | [c] => render_color(c)
    | _ => raise(Unsupported_feature)
    }
  );
let border_top_style =
  variants(Parser.property_border_top_style, [%expr CssJs.borderTopStyle]);
let border_right_style =
  variants(
    Parser.property_border_right_style,
    [%expr CssJs.borderRightStyle],
  );
let border_bottom_style =
  variants(
    Parser.property_border_bottom_style,
    [%expr CssJs.borderBottomStyle],
  );
let border_left_style =
  variants(Parser.property_border_left_style, [%expr CssJs.borderLeftStyle]);
let border_style =
  apply(Parser.property_border_style, [%expr CssJs.borderStyle], variants_to_expression);

let render_line_width =
  fun
  | `Extended_length(l) => render_extended_length(l)
  /* Missing `Medium, `Thick, `Thin on the bs-css bindings */
  | _ => raise(Unsupported_feature);

let border_top_width =
  apply(
    Parser.property_border_top_width,
    [%expr CssJs.borderTopWidth],
    render_line_width,
  );
let border_right_width =
  apply(
    Parser.property_border_right_width,
    [%expr CssJs.borderRightWidth],
    render_line_width,
  );
let border_bottom_width =
  apply(
    Parser.property_border_bottom_width,
    [%expr CssJs.borderBottomWidth],
    render_line_width,
  );
let border_left_width =
  apply(
    Parser.property_border_left_width,
    [%expr CssJs.borderLeftWidth],
    render_line_width,
  );
let border_width =
  apply(
    Parser.property_border_width,
    [%expr CssJs.borderWidth],
    fun
    | [w] => render_size(w)
    | _ => raise(Unsupported_feature),
  );

let render_line_width_interp =
  fun
  | `Line_width(lw) => render_line_width(lw)
  | `Interpolation(name) => render_variable(name);

let border_style_interp =
  fun
  | `Interpolation(name) => render_variable(name)
  | `Line_style(ls) => variants_to_expression(ls);

let render_border = border => {
  switch (border) {
    | `None => [[%expr CssJs.unsafe("border", "none")]];
    | `Static((width, style, color)) => {
      [[%expr CssJs.border(
        [%e render_line_width_interp(width)],
        [%e border_style_interp(style)],
        [%e render_color_interp(color)])
      ]];
    }
  }
}

let border =
  emit(
    Parser.property_border,
    id,
    render_border,
  );

let border_top =
  emit(
    Parser.property_border,
    id,
    render_border,
  );

let border_right =
  emit(
    Parser.property_border,
    id,
    render_border,
  );
let border_bottom =
  emit(
    Parser.property_border,
    id,
    render_border,
  );
let border_left =
  emit(
    Parser.property_border,
    id,
    render_border,
  );

let render_border_value =
  fun
  | [`Extended_length(l)] => render_extended_length(l)
  | [`Extended_percentage(p)] => render_extended_percentage(p)
  | _ => raise(Unsupported_feature);

let border_top_left_radius =
  apply(
    Parser.property_border_top_left_radius,
    [%expr CssJs.borderTopLeftRadius],
    render_border_value,
  );
let border_top_right_radius =
  apply(
    Parser.property_border_top_right_radius,
    [%expr CssJs.borderTopRightRadius],
    render_border_value,
  );
let border_bottom_right_radius =
  apply(
    Parser.property_border_bottom_right_radius,
    [%expr CssJs.borderBottomRightRadius],
    render_border_value,
  );
let border_bottom_left_radius =
  apply(
    Parser.property_border_bottom_left_radius,
    [%expr CssJs.borderBottomLeftRadius],
    render_border_value,
  );
let border_radius =
  apply(
    Parser.property_border_radius,
    [%expr CssJs.borderRadius],
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
    [%expr CssJs.boxShadows],
    fun
    | `None => variants_to_expression(`None)
    | `Shadow(shadows) => {
        let shadows =
          shadows
          |> List.map(shadow => `Box(shadow))
          |> List.map(render_shadow);
        Builder.pexp_array(~loc, shadows);
      },
  );

let overflow_value =
  fun
  | `Clip => raise(Unsupported_feature)
  | rest => variants_to_expression(rest);

// css-overflow-3
// TODO: maybe implement using strings?
let overflow_x =
  apply(Parser.property_overflow_x, [%expr CssJs.overflowX], overflow_value);
let overflow_y =
  variants(Parser.property_overflow_y, [%expr CssJs.overflowY]);
let overflow =
  emit(
    Parser.property_overflow,
    fun
    | `Xor(values) => values |> List.map(overflow_value)
    | _ => raise(Unsupported_feature),
    fun
    | [all] => [[%expr CssJs.overflow([%e all])]]
    | [x, y] =>
      List.concat([
        overflow_x.value_to_expr(x),
        overflow_y.value_to_expr(y),
      ])
    | _ => failwith("unreachable"),
  );
// let overflow_clip_margin = unsupportedProperty(Parser.property_overflow_clip_margin);
let overflow_inline = unsupportedProperty(Parser.property_overflow_inline);
let text_overflow =
  unsupportedValue(
    Parser.property_text_overflow,
    [%expr CssJs.textOverflow],
  );
// let block_ellipsis = unsupportedProperty(Parser.property_block_ellipsis);
let max_lines = unsupportedProperty(Parser.property_max_lines);
// let continue = unsupportedProperty(Parser.property_continue);

// css-text-3
let text_transform =
  variants(Parser.property_text_transform, [%expr CssJs.textTransform]);
let white_space =
  variants(Parser.property_white_space, [%expr CssJs.whiteSpace]);
let tab_size = unsupportedProperty(Parser.property_tab_size);
let word_break =
  variants(Parser.property_word_break, [%expr CssJs.wordBreak]);
let line_break = unsupportedProperty(Parser.property_line_break);
let render_line_height = fun
  | `Extended_length(ext) => render_extended_length(ext)
  | `Extended_percentage(ext) => render_extended_percentage(ext)
  | `Normal => variants_to_expression(`Normal)
  | `Number(float) => [%expr `abs([%e render_number(float) ])];

let line_height =
  apply(
    Parser.property_line_height,
    [%expr CssJs.lineHeight],
    render_line_height,
  );
let line_height_step =
apply(
  Parser.property_line_height_step,
  [%expr CssJs.lineHeightStep],
  render_extended_length,
);
let hyphens = unsupportedProperty(Parser.property_hyphens);
let overflow_wrap =
  variants(Parser.property_overflow_wrap, [%expr CssJs.overflowWrap]);
let word_wrap = variants(Parser.property_word_wrap, [%expr CssJs.wordWrap]);
let text_align =
  variants(Parser.property_text_align, [%expr CssJs.textAlign]);
// let text_align_all = unsupportedProperty(Parser.property_text_align_all);
let text_align_last = unsupportedProperty(Parser.property_text_align_last);
let text_justify = unsupportedProperty(Parser.property_text_justify);
let word_spacing =
  apply(
    Parser.property_word_spacing,
    [%expr CssJs.wordSpacing],
    fun
    | `Normal => variants_to_expression(`Normal)
    | `Extended_length(l) => render_extended_length(l)
    | `Extended_percentage(p) => render_extended_percentage(p),
  );
let letter_spacing =
  apply(
    Parser.property_word_spacing,
    [%expr CssJs.letterSpacing],
    fun
    | `Normal => variants_to_expression(`Normal)
    | `Extended_length(l) => render_extended_length(l)
    | `Extended_percentage(p) => render_extended_percentage(p),
  );
let text_indent =
  apply(
    Parser.property_text_indent,
    [%expr CssJs.textIndent],
    fun
    | (`Extended_length(l), None, None) => render_extended_length(l)
    | (`Extended_percentage(p), None, None) => render_extended_percentage(p)
    | _ => raise(Unsupported_feature),
  );
let hanging_punctuation = unsupportedProperty(Parser.property_hanging_punctuation);

// css-fonts-4
let font_family =
  unsupportedValue(Parser.property_font_family, [%expr CssJs.fontFamily]);
let font_weight =
  unsupportedValue(Parser.property_font_weight, [%expr CssJs.fontWeight]);
let font_stretch = unsupportedProperty(Parser.property_font_stretch);
let font_style =
  unsupportedValue(Parser.property_font_style, [%expr CssJs.fontStyle]);

/* bs-css does not support these variants */
let render_size_variants = fun
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

let render_font_size = fun
  | `Absolute_size(size)
  | `Relative_size(size) => render_size_variants(size)
  | `Extended_length(ext) => render_extended_length(ext)
  | `Extended_percentage(ext) => render_extended_percentage(ext);
let font_size =
  apply(Parser.property_font_size, [%expr CssJs.fontSize], render_font_size);
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
  unsupportedValue(Parser.property_font_variant, [%expr CssJs.fontVariant]);
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
    [%expr CssJs.textDecorationLine],
  );
let text_decoration_style =
  unsupportedValue(
    Parser.property_text_decoration_style,
    [%expr CssJs.textDecorationStyle],
  );
let text_decoration_color =
  apply(
    Parser.property_text_decoration_color,
    [%expr CssJs.textDecorationColor],
    render_color,
  );
let text_decoration_thickness =
  unsupportedProperty(Parser.property_text_decoration_thickness);
let text_decoration =
  unsupportedValue(
    Parser.property_text_decoration,
    [%expr CssJs.textDecoration],
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
  unsupportedValue(Parser.property_text_shadow, [%expr CssJs.textShadow]);

let render_transform_functions = fun
  | `Zero(_) => [%expr `zero]
  | `Extended_angle(a) => [%expr [%e render_extended_angle(a)]];

let render_transform = fun
  | `Function_perspective(_) => raise(Unsupported_feature)
  | `Function_matrix(_) => raise(Unsupported_feature)
  | `Function_matrix3d(_) => raise(Unsupported_feature)
  | `Function_rotate(v) =>  [%expr CssJs.rotate([%e render_transform_functions(v)])]
  | `Function_rotate3d((x, (), y, (), z, (), a)) => [%expr CssJs.rotate3d([%e render_number(x)], [%e render_number(y)], [%e render_number(z)], [%e render_transform_functions(a)])]
  | `Function_rotateX(v) => [%expr CssJs.rotateX([%e render_transform_functions(v)])]
  | `Function_rotateY(v) => [%expr CssJs.rotateY([%e render_transform_functions(v)])]
  | `Function_rotateZ(v) => [%expr CssJs.rotateZ([%e render_transform_functions(v)])]
  | `Function_skew((a1, a2)) => switch(a2) {
     | Some(((), v)) => [%expr CssJs.skew([%e render_transform_functions(a1)], [%e render_transform_functions(v)])]
     | None => [%expr CssJs.skew([%e render_transform_functions(a1)], 0)]
   }
  | `Function_skewX(v) => [%expr CssJs.skewX([%e render_transform_functions(v)])]
  | `Function_skewY(v) => [%expr CssJs.skewY([%e render_transform_functions(v)])]
  | `Function_translate((x, y)) => switch(y) {
     | Some(((), v)) => [%expr CssJs.translate([%e render_size(x)], [%e render_size(v)])]
     | None => [%expr CssJs.translate([%e render_size(x)], 0)]
   }
  | `Function_translate3d((x, (), y, (), z)) => [%expr CssJs.translate3d([%e render_size(x)], [%e render_size(y)], [%e render_extended_length(z)])]
  | `Function_translateX(x) => [%expr CssJs.translateX([%e render_size(x)])]
  | `Function_translateY(y) => [%expr CssJs.translateY([%e render_size(y)])]
  | `Function_translateZ(z) => [%expr CssJs.translateZ([%e render_extended_length(z)])]
  | `Function_scale((x, y)) => switch(y) {
     | Some(((), v)) => [%expr CssJs.scale([%e render_number(x)], [%e render_number(v)])]
     | None => [%expr CssJs.scale([%e render_number(x)], [%e render_number(x)])]
   }
  | `Function_scale3d((x, (), y, (), z)) => [%expr CssJs.scale3d([%e render_number(x)], [%e render_number(y)], [%e render_number(z)])]
  | `Function_scaleX(x) => [%expr CssJs.scaleX([%e render_number(x)])]
  | `Function_scaleY(y) => [%expr CssJs.scaleY([%e render_number(y)])]
  | `Function_scaleZ(z) => [%expr CssJs.scaleZ([%e render_number(z)])];

// css-transforms-2
let transform =
  emit(
    Parser.property_transform,
    id,
    fun
    | `None => [[%expr CssJs.transform(`none)]]
    | `Transform_list([v]) => [[%expr CssJs.transform([%e render_transform(v)])]]
    | `Transform_list(l) => [[%expr CssJs.transforms([%e List.map(render_transform, l) |> Builder.pexp_array(~loc=Location.none)])]]
  )

let transform_origin =
  unsupportedValue(
    Parser.property_transform_origin,
    [%expr CssJs.transformOrigin],
  );
let transform_box =
  unsupportedValue(
    Parser.property_transform_box,
    [%expr CssJs.transformOrigin],
  );
let translate =
  unsupportedValue(Parser.property_translate, [%expr CssJs.translate]);
let rotate = unsupportedValue(Parser.property_rotate, [%expr CssJs.rotate]);
let scale = unsupportedValue(Parser.property_scale, [%expr CssJs.scale]);
let transform_style =
  unsupportedValue(
    Parser.property_transform_style,
    [%expr CssJs.transformStyle],
  );
let perspective = unsupportedProperty(Parser.property_perspective);
let perspective_origin =
  unsupportedValue(
    Parser.property_perspective_origin,
    [%expr CssJs.transformStyle],
  );
let backface_visibility =
  unsupportedValue(
    Parser.property_backface_visibility,
    [%expr CssJs.backfaceVisibility],
  );

// css-transition-1
let transition_property =
  unsupportedValue(
    Parser.property_transition_property,
    [%expr CssJs.transitionProperty],
  );
let transition_duration =
  unsupportedValue(
    Parser.property_transition_duration,
    [%expr CssJs.transitionDuration],
  );
let widows = apply(Parser.property_widows, [%expr CssJs.widows], render_integer);
let transition_timing_function =
  unsupportedValue(
    Parser.property_transition_timing_function,
    [%expr CssJs.transitionTimingFunction],
  );
let transition_delay =
  unsupportedValue(
    Parser.property_transition_delay,
    [%expr CssJs.transitionDelay],
  );
let transition =
  unsupportedValue(Parser.property_transition, [%expr CssJs.transition]);

// css-animation-1
let animation_name =
  unsupportedValue(
    Parser.property_animation_name,
    [%expr CssJs.animationName],
  );
let animation_duration =
  unsupportedValue(
    Parser.property_animation_duration,
    [%expr CssJs.animationDuration],
  );
let animation_timing_function =
  unsupportedValue(
    Parser.property_animation_timing_function,
    [%expr CssJs.CssJs.animationTimingFunction],
  );
let animation_iteration_count =
  unsupportedValue(
    Parser.property_animation_iteration_count,
    [%expr CssJs.animationIterationCount],
  );
let animation_direction =
  unsupportedValue(
    Parser.property_animation_direction,
    [%expr CssJs.animationDirection],
  );
let animation_play_state =
  unsupportedValue(
    Parser.property_animation_play_state,
    [%expr CssJs.animationPlayState],
  );
let animation_delay =
  unsupportedValue(
    Parser.property_animation_delay,
    [%expr CssJs.animationDelay],
  );
let animation_fill_mode =
  unsupportedValue(
    Parser.property_animation_fill_mode,
    [%expr CssJs.animationFillMode],
  );
let animation =
  unsupportedValue(Parser.property_animation, [%expr CssJs.animation]);

// css-flexbox-1
// using id() because refmt
let flex_direction =
  variants(Parser.property_flex_direction, [%expr CssJs.flexDirection]);
let flex_wrap = variants(Parser.property_flex_wrap, [%expr CssJs.flexWrap]);

// shorthand - https://drafts.csswg.org/css-flexbox-1/#flex-flow-property
let flex_flow =
  emit(
    Parser.property_flex_flow,
    id,
    ((direction_ast, wrap_ast)) => {
      let direction =
        Option.map(
          ast => flex_direction.ast_to_expr(`Value(ast)),
          direction_ast,
        );
      let wrap =
        Option.map(ast => flex_wrap.ast_to_expr(`Value(ast)), wrap_ast);
      [direction, wrap] |> List.concat_map(Option.value(~default=[]));
    },
  );
// TODO: this is safe?
let order = apply(Parser.property_order, [%expr CssJs.order], render_integer);
let flex_grow =
  apply(Parser.property_flex_grow, [%expr CssJs.flexGrow], render_number);
let flex_shrink =
  apply(Parser.property_flex_shrink, [%expr CssJs.flexShrink], render_number);

let flex_basis =
  apply(
    Parser.property_flex_basis,
    [%expr CssJs.flexBasis],
    fun
    | `Content => variants_to_expression(`Content)
    | `Property_width(value_width) =>
      width.value_of_ast(`Value(value_width)),
  );

// TODO: this is incomplete
let flex =
  emit(
    Parser.property_flex,
    id,
    fun
    | `None => [[%expr CssJs.flex(`none)]]
    | `Or(grow_shrink, basis) => {
        let grow_shrink =
          switch (grow_shrink) {
          | None => []
          | Some((grow, shrink)) =>
            List.concat([
              flex_grow.ast_to_expr(`Value(grow)),
              Option.map(
                ast => flex_shrink.ast_to_expr(`Value(ast)),
                shrink,
              )
              |> Option.value(~default=[]),
            ])
          };
        let basis =
          switch (basis) {
          | None => []
          | Some(basis) => flex_basis.ast_to_expr(`Value(basis))
          };
        List.concat([grow_shrink, basis]);
      },
  );

// TODO: justify_content, align_items, align_self, align_content are only for flex, missing the css-align-3 at parser
let justify_content =
  unsupportedValue(
    Parser.property_justify_content,
    [%expr CssJs.justifyContent],
  );
let align_items =
  unsupportedValue(Parser.property_align_items, [%expr CssJs.alignItems]);
let align_self =
  unsupportedValue(Parser.property_align_self, [%expr CssJs.alignSelf]);
let align_content =
  unsupportedValue(
    Parser.property_align_content,
    [%expr CssJs.alignContent],
  );

// css-grid-1
let grid_template_columns =
  unsupportedValue(
    Parser.property_grid_template_columns,
    [%expr CssJs.gridTemplateColumns],
  );
let grid_template_rows =
  unsupportedValue(
    Parser.property_grid_template_rows,
    [%expr CssJs.gridTemplateRows],
  );
let grid_template_areas =
  unsupportedValue(
    Parser.property_grid_template_areas,
    [%expr CssJs.gridTemplateAreas],
  );
let grid_template = unsupportedProperty(Parser.property_grid_template);
let grid_auto_columns =
  unsupportedValue(
    Parser.property_grid_auto_columns,
    [%expr CssJs.gridAutoColumns],
  );
let grid_auto_rows =
  unsupportedValue(
    Parser.property_grid_auto_rows,
    [%expr CssJs.gridAutoRows],
  );
let grid_auto_flow =
  unsupportedValue(
    Parser.property_grid_auto_flow,
    [%expr CssJs.gridAutoFlow],
  );
let grid = unsupportedValue(Parser.property_grid, [%expr CssJs.grid]);
let grid_row_start =
  unsupportedValue(
    Parser.property_grid_row_start,
    [%expr CssJs.gridRowStart],
  );
let grid_column_start =
  unsupportedValue(
    Parser.property_grid_column_start,
    [%expr CssJs.gridColumnStart],
  );
let grid_row_end =
  unsupportedValue(Parser.property_grid_row_end, [%expr CssJs.gridRowEnd]);
let grid_column_end =
  unsupportedValue(
    Parser.property_grid_column_end,
    [%expr CssJs.gridColumnEnd],
  );
let grid_row =
  unsupportedValue(Parser.property_grid_row, [%expr CssJs.gridRow]);
let grid_column =
  unsupportedValue(Parser.property_grid_column, [%expr CssJs.gridColumn]);
let grid_area =
  unsupportedValue(Parser.property_grid_area, [%expr CssJs.gridArea]);
let z_index =
  unsupportedValue(Parser.property_z_index, [%expr CssJs.zIndex]);

let render_position_value =
  fun
    | `Auto => variants_to_expression(`Auto)
    | `Extended_length(l) => render_extended_length(l)
    | `Extended_percentage(pct) => render_extended_percentage(pct);

let left =
  apply(
    Parser.property_left,
    [%expr CssJs.left],
    render_position_value,
  );

let top =
  apply(
    Parser.property_top,
    [%expr CssJs.top],
    render_position_value,
  );

let right =
  apply(
    Parser.property_right,
    [%expr CssJs.right],
    render_position_value,
  );

let bottom =
  apply(
    Parser.property_bottom,
    [%expr CssJs.bottom],
    render_position_value,
  );

let display =
  apply(
    Parser.property_display,
    [%expr CssJs.display],
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
    | _ => raise(Unsupported_feature),
  );

let found = ({ast_of_string, string_to_expr, _}) => {
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
];

let render_when_unsupported_features = (property, value) => {
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

  /* Transform property name to camelCase since we bind emotion to the Object API */
  let propertyName = property |> to_camel_case |> render_string;
  let value = value |> render_string;

  %expr
  CssJs.unsafe([%e propertyName], [%e value]);
};

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
  let.ok is_valid_string =
    Parser.check_property(~name=property, value)
    |> Result.map_error((`Unknown_value) => `Not_found);

  switch (render_css_global_values(property, value)) {
  | Ok(value) => Ok(value)
  | Error(_) =>
    switch (render_to_expr(property, value)) {
    | Ok(value) => Ok(value)
    | Error(_)
    | exception Unsupported_feature =>
      let.ok () = is_valid_string ? Ok() : Error(`Invalid_value(value));
      Ok([render_when_unsupported_features(property, value)]);
    }
  };
};
