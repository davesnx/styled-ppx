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

  {ast_of_string, value_of_ast: List.map(mapper), value_to_expr, ast_to_expr, string_to_expr};
};

let render_string = string => Helper.Const.string(string) |> Helper.Exp.constant;
let render_integer = integer => Helper.Const.int(integer) |> Helper.Exp.constant;
let render_number = number =>
  Helper.Const.float(number |> string_of_float) |> Helper.Exp.constant;
let render_percentage = number => [%expr `percent([%e render_number(number)])];

let render_css_global_values = (name, value) => {
  let.ok value = Parser.parse(Standard.css_wide_keywords, value);

  let value =
    switch (value) {
    | `Inherit => [%expr "inherit"]
    | `Initial => [%expr "initial"]
    | `Unset => [%expr "unset"]
    };

  /* bs-css doesn't have those */
  Ok([[%expr CssJs.unsafe([%e render_string(name)], [%e value])]]);
};

let render_angle =
  fun
  | `Deg(number) => id([%expr `deg([%e render_number(number)])])
  | `Rad(number) => id([%expr `rad([%e render_number(number)])])
  | `Grad(number) => id([%expr `grad([%e render_number(number)])])
  | `Turn(number) => id([%expr `turn([%e render_number(number)])]);

let list_to_longident = vars => vars |> String.concat(".") |> Longident.parse;

let render_variable = (name) => list_to_longident(name) |> txt |> Helper.Exp.ident;

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
  | `End => raise(Unsupported_feature)
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
  | `Full_size_kana => raise(Unsupported_feature);

let transform_with_variable = (parser, mapper, value_to_expr) =>
  emit(
    Combinator.combine_xor([
      /* If the CSS value is an interpolation, we treat as one `Variable */
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
  transform_with_variable(parser, map, arg => [[%expr [%e id]([%e arg])]]);

let unsupported = (~call=?, parser) =>
  transform_with_variable(
    parser,
    _ => raise(Unsupported_feature),
    call
    |> Option.map((call, arg) => [[%expr [%e call]([%e arg])]])
    |> Option.value(~default=_ => raise(Unsupported_feature)),
  );

let variants = (parser, identifier) =>
  apply(parser, identifier, variants_to_expression);

// TODO: all of them could be float, but bs-css doesn't support it
let render_length =
  fun
  | `Interpolation(v) => render_variable(v)
  | `Length(l) => switch(l) {
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
    | `Zero => [%expr `zero]
  };

let render_length_percentage =
  fun
  | `Length(length) => render_length(length)
  | `Percentage(percentage) => render_percentage(percentage)
  | `Interpolation(v) => render_variable(v);

// css-sizing-3
let render_size =
  fun
    | `Auto => variants_to_expression(`Auto)
    | `Length(_) as lp
    | `Percentage(_) as lp => render_length_percentage(lp)
    | `Max_content
    | `Min_content => raise(Unsupported_feature)
    | `Fit_content(_) => raise(Unsupported_feature)
    | _ => raise(Unsupported_feature);

let width =
  apply(
    Parser.property_width,
    [%expr CssJs.width],
    render_size,
  );
let height =
  apply(
    Parser.property_height,
    [%expr CssJs.height],
    render_size,
  );
let min_width =
  apply(
    Parser.property_min_width,
    [%expr CssJs.minWidth],
    render_size,
  );
let min_height =
  apply(
    Parser.property_min_height,
    [%expr CssJs.minHeight],
    render_size,
  );
let max_width =
  apply(
    Parser.property_max_width,
    [%expr CssJs.maxWidth],
    fun
    | `Auto as e
    | `None as e => variants_to_expression(e)
    | `Length(_) as ast
    | `Percentage(_) as ast
    | `Max_content as ast
    | `Min_content as ast
    | `Fit_content(_) as ast => render_size(ast)
    | _ => raise(Unsupported_feature),
  );
let max_height =
  apply(
    Parser.property_max_height,
    [%expr CssJs.maxHeight],
    data => max_width.value_of_ast(`Value(data)),
  );
let box_sizing =
  apply(Parser.property_box_sizing, [%expr CssJs.boxSizing], variants_to_expression);
let column_width = unsupported(Parser.property_column_width);

let margin_value =
  fun
    | `Auto => variants_to_expression(`Auto)
    | `Length(_) as lp
    | `Percentage(_) as lp => render_length_percentage(lp);

let padding_value =
  fun
    | `Auto => variants_to_expression(`Auto)
    | `Length(_) as lp
    | `Percentage(_) as lp => render_length_percentage(lp);

// css-box-3
let margin_top =
  apply(
    Parser.property_margin_top,
    [%expr CssJs.marginTop],
    margin_value,
  );
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
  apply(
    Parser.property_margin_left,
    [%expr CssJs.marginLeft],
    margin_value,
  );

let margin =
  emit_shorthand(
    Parser.property_margin,
    fun
    | `Auto => variants_to_expression(`Auto)
    | `Length(_) as lp
    | `Percentage(_) as lp => render_length_percentage(lp)
    | `Interpolation(name) => render_variable(name),
    fun
    | [all] => [[%expr CssJs.margin([%e all])]]
    | [v, h] => [[%expr CssJs.margin2(~v=[%e v], ~h=[%e h])]]
    | [t, h, b] =>
        [[%expr CssJs.margin3(~top=[%e t], ~h=[%e h], ~bottom=[%e b])]]
    | [t, r, b, l] =>
        [[%expr
          CssJs.margin4(
            ~top=[%e t],
            ~right=[%e r],
            ~bottom=[%e b],
            ~left=[%e l],
          )
        ]]
    | [] => failwith("Margin value can't be empty")
    | _ => failwith("There aren't more margin combinations")
  );

let padding_top =
  apply(
    Parser.property_padding_top,
    [%expr CssJs.paddingTop],
    padding_value,
  );
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
    | `Length(_) as lp
    | `Percentage(_) as lp => render_length_percentage(lp)
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
  | `Aqua => Builder.pexp_ident(~loc, {loc: Location.none, txt: Ldot(Lident("CssJs"), "aqua")})
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
  | `Percentage(percentage) => [%expr `percent([%e render_number(percentage /. 100.0)])];

let render_function_rgb = ast => {
  let to_number = percentage => percentage *. 2.55;

  let (colors, alpha) =
    switch (ast) {
    /* 1 and 3 = numbers, 0 and 2 = percentage */
    | `Rgb_1(colors, alpha)
    | `Rgba_1(colors, alpha)
    | `Rgb_3(colors, alpha)
    | `Rgba_3(colors, alpha) => (colors, alpha)
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

  // TODO: bs-css rgb(float, float, float)
  let red = render_integer(red |> int_of_float);
  let green = render_integer(green |> int_of_float);
  let blue = render_integer(blue |> int_of_float);
  let alpha = Option.map(render_color_alpha, alpha);

  switch (alpha) {
  | Some(a) => id([%expr `rgba(([%e red], [%e green], [%e blue], [%e a]))])
  | None => id([%expr `rgb(([%e red], [%e green], [%e blue]))])
  };
};
let render_function_hsl = ((hue, saturation, lightness, alpha)) => {
  let hue =
    switch (hue) {
    | `Angle(angle) => angle
    | `Number(degs) => `Deg(degs)
    };

  let hue = render_angle(hue);
  let saturation = render_percentage(saturation);
  let lightness = render_percentage(lightness);
  let alpha =
    Option.map((((), alpha)) => render_color_alpha(alpha), alpha);

  switch (alpha) {
  | Some(alpha) =>
    id([%expr `hsla(([%e hue], [%e saturation], [%e lightness], [%e alpha]))])
  | None => id([%expr `hsl(([%e hue], [%e saturation], [%e lightness]))])
  };
};

let render_color =
  fun
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
  | `Deprecated_system_color(_) => raise(Unsupported_feature);

let color = apply(Parser.property_color, [%expr CssJs.color], render_color);
let opacity =
  apply(
    Parser.property_opacity,
    [%expr CssJs.opacity],
    fun
    | `Number(number) => render_number(number)
    | `Percentage(number) => render_number(number /. 100.0),
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
    | `Length(length) => render_length(length)
    | `Percentage(percentage) => render_percentage(percentage);

  let horizontal =
    switch (position) {
    | `Or(Some(pos), _) => (pos, `Zero)
    | `Or(None, _) => (`Center, `Zero)
    | `Static(`Length_percentage(offset), _) => (`Left, offset)
    | `Static((`Center | `Left | `Right) as pos, _) => (pos, `Zero)
    | `And((pos, offset), _) => (pos, offset)
    };

  let horizontal =
    switch (horizontal) {
    | (`Left, `Length(length)) => `Length(length)
    | (_, `Length(_)) => raise(Unsupported_feature)
    | (pos, `Zero) => `Position(pos)
    | (pos, `Percentage(percentage)) =>
      `Percentage(percentage +. pos_to_percentage_offset(pos))
    };

  let horizontal = to_value(horizontal);

  let vertical =
    switch (position) {
    | `Or(_, Some(pos)) => (pos, `Zero)
    | `Or(_, None) => (`Center, `Zero)
    | `Static(_, None) => (`Center, `Zero)
    | `Static(_, Some(`Length_percentage(offset))) => (`Top, offset)
    | `Static(_, Some((`Center | `Bottom | `Top) as pos)) => (pos, `Zero)
    | `And(_, (pos, offset)) => (pos, offset)
    };

  let vertical =
    switch (vertical) {
    | (`Top, `Length(length)) => `Length(length)
    | (_, `Length(_)) => raise(Unsupported_feature)
    | (pos, `Zero) => `Position(pos)
    | (pos, `Percentage(percentage)) =>
      `Percentage(percentage +. pos_to_percentage_offset(pos))
    };

  let vertical = to_value(vertical);

  id([%expr `hv(([%e horizontal], [%e vertical]))]);
};

let object_fit = variants(Parser.property_object_fit, [%expr CssJs.objectFit]);
let object_position =
  apply(
    Parser.property_object_position,
    [%expr CssJs.objectPosition],
    render_position,
  );
let image_resolution = unsupported(Parser.property_image_resolution);
let image_orientation = unsupported(Parser.property_image_orientation);
let image_rendering = unsupported(Parser.property_image_rendering);

let render_color_interp = fun
  | `Interpolation(name) => render_variable(name)
  | `Color(ls) => render_color(ls);

let render_length_interp =
  fun
  | `Length(length) => render_length(length)
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

  let color = color |> Option.value(~default=`Color(`CurrentColor)) |> render_color_interp;
  let x = render_length_interp(x);
  let y = render_length_interp(y);
  let blur = Option.map(render_length_interp, blur);
  let spread = Option.map(render_length_interp, spread);
  let inset =
    Option.map(
      () => Helper.Exp.construct({txt: Lident("true"), loc: Location.none}, None),
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
  apply(Parser.property_background_color, [%expr CssJs.backgroundColor], render_color);
let background_image =
  unsupported(Parser.property_background_image, ~call=[%expr CssJs.backgroundImage]);
let background_repeat =
  unsupported(Parser.property_background_repeat, ~call=[%expr CssJs.backgroundRepeat]);
let background_attachment =
  unsupported(
    Parser.property_background_attachment,
    ~call=[%expr CssJs.backgroundAttachment],
  );
let background_position =
  unsupported(
    Parser.property_background_position,
    ~call=[%expr CssJs.backgroundPosition],
  );
let background_clip =
  unsupported(Parser.property_background_clip, ~call=[%expr CssJs.backgroundClip]);
let background_origin =
  unsupported(Parser.property_background_origin, ~call=[%expr CssJs.backgroundOrigin]);
let background_size =
  unsupported(Parser.property_background_size, ~call=[%expr CssJs.backgroundSize]);
let background =
  unsupported(Parser.property_background, ~call=[%expr CssJs.background]);
let border_top_color =
  apply(Parser.property_border_top_color, [%expr CssJs.borderTopColor], render_color);
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
  apply(
    Parser.property_border_color,
    [%expr CssJs.borderColor],
    c => switch c {
      | [c] => render_color(c)
      | _ => raise(Unsupported_feature)
    }
  );
let border_top_style =
  variants(Parser.property_border_top_style, [%expr CssJs.borderTopStyle]);
let border_right_style =
  variants(Parser.property_border_right_style, [%expr CssJs.borderRightStyle]);
let border_bottom_style =
  variants(Parser.property_border_bottom_style, [%expr CssJs.borderBottomStyle]);
let border_left_style =
  variants(Parser.property_border_left_style, [%expr CssJs.borderLeftStyle]);
let border_style =
  unsupported(Parser.property_border_style, ~call=[%expr CssJs.borderStyle]);

let render_line_width =
  fun
  | `Length(length) => render_length(length)
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

let border_style_interp = fun
  | `Interpolation(name) => render_variable(name)
  | `Line_style(ls) => variants_to_expression(ls);

let border =
  emit(
    Parser.property_border,
    id,
    ((width, style, color)) => {
      let w = render_line_width_interp(width);
      let s = border_style_interp(style);
      let c = render_color_interp(color);
      [[%expr CssJs.border([%e w], [%e s], [%e c])]];
    },
  );
let border_top =
  emit(
    Parser.property_border,
    id,
    ((width, style, color)) => {
      let w = render_line_width_interp(width);
      let s = border_style_interp(style);
      let c = render_color_interp(color);
      [[%expr CssJs.borderTop([%e w], [%e s], [%e c])]];
    },
  );
let border_right =
  emit(
    Parser.property_border,
    id,
    ((width, style, color)) => {
      let w = render_line_width_interp(width);
      let s = border_style_interp(style);
      let c = render_color_interp(color);
      [[%expr CssJs.borderRight([%e w], [%e s], [%e c])]];
    },
  );
let border_bottom =
  emit(
    Parser.property_border,
    id,
    ((width, style, color)) => {
      let w = render_line_width_interp(width);
      let s = border_style_interp(style);
      let c = render_color_interp(color);
      [[%expr CssJs.borderBottom([%e w], [%e s], [%e c])]];
    },
  );
let border_left =
  emit(
    Parser.property_border,
    id,
    ((width, style, color)) => {
      let w = render_line_width_interp(width);
      let s = border_style_interp(style);
      let c = render_color_interp(color);
      [[%expr CssJs.borderLeft([%e w], [%e s], [%e c])]];
    },
  );

let border_value = fun
  | [lp] => render_length_percentage(lp)
  | _ => raise(Unsupported_feature);

let border_top_left_radius =
  apply(
    Parser.property_border_top_left_radius,
    [%expr CssJs.borderTopLeftRadius],
    border_value
  );
let border_top_right_radius =
  apply(
    Parser.property_border_top_right_radius,
    [%expr CssJs.borderTopRightRadius],
    border_value,
  );
let border_bottom_right_radius =
  apply(
    Parser.property_border_bottom_right_radius,
    [%expr CssJs.borderBottomRightRadius],
    border_value,
  );
let border_bottom_left_radius =
  apply(
    Parser.property_border_bottom_left_radius,
    [%expr CssJs.borderBottomLeftRadius],
    border_value,
  );
let border_radius =
  unsupported(Parser.property_border_radius, ~call=[%expr CssJs.borderRadius]);
let border_image_source = unsupported(Parser.property_border_image_source);
let border_image_slice = unsupported(Parser.property_border_image_slice);
let border_image_width = unsupported(Parser.property_border_image_width);
let border_image_outset = unsupported(Parser.property_border_image_outset);
let border_image_repeat = unsupported(Parser.property_border_image_repeat);
let border_image = unsupported(Parser.property_border_image);
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

let overflow_value = fun
  | `Clip => raise(Unsupported_feature)
  | rest => variants_to_expression(rest);

// css-overflow-3
// TODO: maybe implement using strings?
let overflow_x =
  apply(
    Parser.property_overflow_x,
    [%expr CssJs.overflowX],
    overflow_value,
  );
let overflow_y = variants(Parser.property_overflow_y, [%expr CssJs.overflowY]);
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
// let overflow_clip_margin = unsupported(Parser.property_overflow_clip_margin);
let overflow_inline = unsupported(Parser.property_overflow_inline);
let text_overflow =
  unsupported(Parser.property_text_overflow, ~call=[%expr CssJs.textOverflow]);
// let block_ellipsis = unsupported(Parser.property_block_ellipsis);
let max_lines = unsupported(Parser.property_max_lines);
// let continue = unsupported(Parser.property_continue);

// css-text-3
let text_transform =
  variants(Parser.property_text_transform, [%expr CssJs.textTransform]);
let white_space = variants(Parser.property_white_space, [%expr CssJs.whiteSpace]);
let tab_size = unsupported(Parser.property_tab_size);
let word_break = variants(Parser.property_word_break, [%expr CssJs.wordBreak]);
let line_break = unsupported(Parser.property_line_break);

let line_height =
  apply(
    Parser.property_line_height,
    [%expr CssJs.lineHeight],
    fun
    | `Normal => variants_to_expression(`Normal)
    | `Number(n) =>  render_number(n)
    | `Length(_) as lh
    | `Percentage(_) as lh => render_length_percentage(lh),
  );

let line_height_step = unsupported(Parser.property_line_height_step);
let hyphens = unsupported(Parser.property_hyphens);
let overflow_wrap =
  variants(Parser.property_overflow_wrap, [%expr CssJs.overflowWrap]);
let word_wrap = variants(Parser.property_word_wrap, [%expr CssJs.wordWrap]);
let text_align = variants(Parser.property_text_align, [%expr CssJs.textAlign]);
// let text_align_all = unsupported(Parser.property_text_align_all);
let text_align_last = unsupported(Parser.property_text_align_last);
let text_justify = unsupported(Parser.property_text_justify);
let word_spacing =
  apply(
    Parser.property_word_spacing,
    [%expr CssJs.wordSpacing],
    fun
    | `Normal => variants_to_expression(`Normal)
    | `Length_percentage(lp) => render_length_percentage(lp),
  );
let letter_spacing =
  apply(
    Parser.property_word_spacing,
    [%expr CssJs.letterSpacing],
    fun
    | `Normal => variants_to_expression(`Normal)
    | `Length_percentage(lp) => render_length_percentage(lp),
  );
let text_indent =
  apply(
    Parser.property_text_indent,
    [%expr CssJs.textIndent],
    fun
    | (lp, None, None) => render_length_percentage(lp)
    | _ => raise(Unsupported_feature),
  );
let hanging_punctuation = unsupported(Parser.property_hanging_punctuation);

// css-fonts-4
let font_family =
  unsupported(Parser.property_font_family, ~call=[%expr CssJs.fontFamily]);
let font_weight =
  unsupported(Parser.property_font_weight, ~call=[%expr CssJs.fontWeight]);
let font_stretch = unsupported(Parser.property_font_stretch);
let font_style =
  unsupported(Parser.property_font_style, ~call=[%expr CssJs.fontStyle]);

let fs_value =
  fun
    | `Absolute_size(v) => render_size(v)
    | `Relative_size(v) => render_size(v)
    | `Length_percentage(v) => render_length_percentage(v)

let font_size =
  apply(
    Parser.property_font_size,
    [%expr CssJs.fontSize],
    fs_value,
  );

let font_size_adjust = unsupported(Parser.property_font_size_adjust);
let font = unsupported(Parser.property_font);
// let font_synthesis_weight = unsupported(Parser.property_font_synthesis_weight);
// let font_synthesis_style = unsupported(Parser.property_font_synthesis_style);
// let font_synthesis_small_caps =
// unsupported(Parser.property_font_synthesis_small_caps);
let font_synthesis = unsupported(Parser.property_font_synthesis);
let font_kerning = unsupported(Parser.property_font_kerning);
let font_variant_ligatures = unsupported(Parser.property_font_variant_ligatures);
let font_variant_position = unsupported(Parser.property_font_variant_position);
let font_variant_caps = unsupported(Parser.property_font_variant_caps);
let font_variant_numeric = unsupported(Parser.property_font_variant_numeric);
let font_variant_alternates = unsupported(Parser.property_font_variant_alternates);
let font_variant_east_asian = unsupported(Parser.property_font_variant_east_asian);
let font_variant =
  unsupported(Parser.property_font_variant, ~call=[%expr CssJs.fontVariant]);
let font_feature_settings = unsupported(Parser.property_font_feature_settings);
let font_optical_sizing = unsupported(Parser.property_font_optical_sizing);
let font_variation_settings = unsupported(Parser.property_font_variation_settings);
// let font_palette = unsupported(Parser.property_font_palette);
// let font_variant_emoji = unsupported(Parser.property_font_variant_emoji);

// css-text-decor-3
let text_decoration_line =
  unsupported(
    Parser.property_text_decoration_line,
    ~call=[%expr CssJs.textDecorationLine],
  );
let text_decoration_style =
  unsupported(
    Parser.property_text_decoration_style,
    ~call=[%expr CssJs.textDecorationStyle],
  );
let text_decoration_color =
  apply(
    Parser.property_text_decoration_color,
    [%expr CssJs.textDecorationColor],
    render_color
  );
let text_decoration_thickness =
  unsupported(Parser.property_text_decoration_thickness);
let text_decoration =
  unsupported(Parser.property_text_decoration, ~call=[%expr CssJs.textDecoration]);
let text_underline_position = unsupported(Parser.property_text_underline_position);
let text_underline_offset = unsupported(Parser.property_text_underline_offset);
let text_decoration_skip = unsupported(Parser.property_text_decoration_skip);
// let text_decoration_skip_self =
//   unsupported(Parser.property_text_decoration_skip_self);
// let text_decoration_skip_box = unsupported(Parser.property_text_decoration_skip_box);
// let text_decoration_skip_inset =
//   unsupported(Parser.property_text_decoration_skip_inset);
// let text_decoration_skip_spaces =
//   unsupported(Parser.property_text_decoration_skip_spaces);
let text_decoration_skip_ink = unsupported(Parser.property_text_decoration_skip_ink);
let text_emphasis_style = unsupported(Parser.property_text_emphasis_style);
let text_emphasis_color = unsupported(Parser.property_text_emphasis_color);
let text_emphasis = unsupported(Parser.property_text_emphasis);
let text_emphasis_position = unsupported(Parser.property_text_emphasis_position);
// let text_emphasis_skip = unsupported(Parser.property_text_emphasis_skip);
let text_shadow =
  unsupported(Parser.property_text_shadow, ~call=[%expr CssJs.textShadow]);

// css-transforms-2
let transform = unsupported(Parser.property_transform, ~call=[%expr CssJs.transform]);
let transform_origin =
  unsupported(Parser.property_transform_origin, ~call=[%expr CssJs.transformOrigin]);
let transform_box =
  unsupported(Parser.property_transform_box, ~call=[%expr CssJs.transformOrigin]);
let translate = unsupported(Parser.property_translate, ~call=[%expr CssJs.translate]);
let rotate = unsupported(Parser.property_rotate, ~call=[%expr CssJs.rotate]);
let scale = unsupported(Parser.property_scale, ~call=[%expr CssJs.scale]);
let transform_style =
  unsupported(Parser.property_transform_style, ~call=[%expr CssJs.transformStyle]);
let perspective = unsupported(Parser.property_perspective);
let perspective_origin =
  unsupported(Parser.property_perspective_origin, ~call=[%expr CssJs.transformStyle]);
let backface_visibility =
  unsupported(
    Parser.property_backface_visibility,
    ~call=[%expr CssJs.backfaceVisibility],
  );

// css-transition-1
let transition_property =
  unsupported(
    Parser.property_transition_property,
    ~call=[%expr CssJs.transitionProperty],
  );
let transition_duration =
  unsupported(
    Parser.property_transition_duration,
    ~call=[%expr CssJs.transitionDuration],
  );
let transition_timing_function =
  unsupported(
    Parser.property_transition_timing_function,
    ~call=[%expr CssJs.transitionTimingFunction],
  );
let transition_delay =
  unsupported(Parser.property_transition_delay, ~call=[%expr CssJs.transitionDelay]);
let transition =
  unsupported(Parser.property_transition, ~call=[%expr CssJs.transition]);

// css-animation-1
let animation_name =
  unsupported(Parser.property_animation_name, ~call=[%expr CssJs.animationName]);
let animation_duration =
  unsupported(
    Parser.property_animation_duration,
    ~call=[%expr CssJs.animationDuration],
  );
let animation_timing_function =
  unsupported(
    Parser.property_animation_timing_function,
    ~call=[%expr CssJs.CssJs.animationTimingFunction],
  );
let animation_iteration_count =
  unsupported(
    Parser.property_animation_iteration_count,
    ~call=[%expr CssJs.animationIterationCount],
  );
let animation_direction =
  unsupported(
    Parser.property_animation_direction,
    ~call=[%expr CssJs.animationDirection],
  );
let animation_play_state =
  unsupported(
    Parser.property_animation_play_state,
    ~call=[%expr CssJs.animationPlayState],
  );
let animation_delay =
  unsupported(Parser.property_animation_delay, ~call=[%expr CssJs.animationDelay]);
let animation_fill_mode =
  unsupported(
    Parser.property_animation_fill_mode,
    ~call=[%expr CssJs.animationFillMode],
  );
let animation = unsupported(Parser.property_animation, ~call=[%expr CssJs.animation]);

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
// TODO: is safe to just return CssJs.width when flex_basis?
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
  unsupported(Parser.property_justify_content, ~call=[%expr CssJs.justifyContent]);
let align_items =
  unsupported(Parser.property_align_items, ~call=[%expr CssJs.alignItems]);
let align_self =
  unsupported(Parser.property_align_self, ~call=[%expr CssJs.alignSelf]);
let align_content =
  unsupported(Parser.property_align_content, ~call=[%expr CssJs.alignContent]);

// css-grid-1
let grid_template_columns =
  unsupported(
    Parser.property_grid_template_columns,
    ~call=[%expr CssJs.gridTemplateColumns],
  );
let grid_template_rows =
  unsupported(
    Parser.property_grid_template_rows,
    ~call=[%expr CssJs.gridTemplateRows],
  );
let grid_template_areas =
  unsupported(
    Parser.property_grid_template_areas,
    ~call=[%expr CssJs.gridTemplateAreas],
  );
let grid_template = unsupported(Parser.property_grid_template);
let grid_auto_columns =
  unsupported(Parser.property_grid_auto_columns, ~call=[%expr CssJs.gridAutoColumns]);
let grid_auto_rows =
  unsupported(Parser.property_grid_auto_rows, ~call=[%expr CssJs.gridAutoRows]);
let grid_auto_flow =
  unsupported(Parser.property_grid_auto_flow, ~call=[%expr CssJs.gridAutoFlow]);
let grid = unsupported(Parser.property_grid, ~call=[%expr CssJs.grid]);
let grid_row_start =
  unsupported(Parser.property_grid_row_start, ~call=[%expr CssJs.gridRowStart]);
let grid_column_start =
  unsupported(Parser.property_grid_column_start, ~call=[%expr CssJs.gridColumnStart]);
let grid_row_end =
  unsupported(Parser.property_grid_row_end, ~call=[%expr CssJs.gridRowEnd]);
let grid_column_end =
  unsupported(Parser.property_grid_column_end, ~call=[%expr CssJs.gridColumnEnd]);
let grid_row = unsupported(Parser.property_grid_row, ~call=[%expr CssJs.gridRow]);
let grid_column =
  unsupported(Parser.property_grid_column, ~call=[%expr CssJs.gridColumn]);
let grid_area = unsupported(Parser.property_grid_area, ~call=[%expr CssJs.gridArea]);
let z_index = unsupported(Parser.property_z_index, ~call=[%expr CssJs.zIndex]);

let position_value =
  fun
    | `Auto => variants_to_expression(`Auto)
    | `Length(_) as lh
    | `Percentage(_) as lh => render_length_percentage(lh);

let left =
  apply(
    Parser.property_left,
    [%expr CssJs.left],
    position_value,
  );

let top =
  apply(
    Parser.property_top,
    [%expr CssJs.top],
    position_value,
  );

let right =
  apply(
    Parser.property_right,
    [%expr CssJs.right],
    position_value,
  );

let bottom =
  apply(
    Parser.property_bottom,
    [%expr CssJs.bottom],
    position_value,
  );

let display = apply(
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
  | `Table_row => [%expr `tableRow ]
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

  [%expr CssJs.unsafe([%e propertyName], [%e value])];
};

let findProperty = (name) => {
  properties |> List.find_opt(((key, _)) => key == name)
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
