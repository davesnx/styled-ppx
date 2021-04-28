open Ppxlib;
open Ast_helper;
open Asttypes;
open Longident;
open Reason_css_parser;
open Reason_css_lexer;
open Parser;

module Builder = Ppxlib.Ast_builder.Default;

/* helpers */
let loc = Location.none;
let txt = txt => {Location.loc: Location.none, txt};
let lid = name => txt(Lident(name));

let (let.ok) = Result.bind;

exception Unsupported_feature;

let id = Fun.id;
let apply_value = (f, v) => f(`Value(v));

type transform('ast, 'value) = {
  ast_of_string: string => result('ast, string),
  value_of_ast: 'ast => 'value,
  value_to_expr: 'value => list(Parsetree.expression),
  ast_to_expr: 'ast => list(Parsetree.expression),
  string_to_expr: string => result(list(Parsetree.expression), string),
};

let emit = (parser, value_of_ast, value_to_expr) => {
  let ast_of_string = Parser.parse(parser);
  let ast_to_expr = ast => value_of_ast(ast) |> value_to_expr;
  let string_to_expr = string =>
    ast_of_string(string) |> Result.map(ast_to_expr);
  {ast_of_string, value_of_ast, value_to_expr, ast_to_expr, string_to_expr};
};

let render_css_wide_keywords = (name, value) => {
  let.ok value = Parser.parse(Standard.css_wide_keywords, value);
  let value =
    switch (value) {
    | `Inherit => [%expr "inherit"]
    | `Initial => [%expr "initial"]
    | `Unset => [%expr "unset"]
    };

  let name = Const.string(name) |> Exp.constant;
  Ok([[%expr CssJs.unsafe([%e name], [%e value])]]);
};

let render_string = string => Const.string(string) |> Exp.constant;
let render_integer = integer => Const.int(integer) |> Exp.constant;
let render_number = number =>
  Const.float(number |> string_of_float) |> Exp.constant;
let render_percentage = number => [%expr
  `percent([%e render_number(number)])
];
let render_angle =
  fun
  | `Deg(number) => id([%expr `deg([%e render_number(number)])])
  | `Rad(number) => id([%expr `rad([%e render_number(number)])])
  | `Grad(number) => id([%expr `grad([%e render_number(number)])])
  | `Turn(number) => id([%expr `turn([%e render_number(number)])]);

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
  | `End => raise(Unsupported_feature)
  | `Justify => id([%expr `justify])
  | `Justify_all => raise(Unsupported_feature)
  | `Left => id([%expr `left])
  | `Match_parent => raise(Unsupported_feature)
  | `Right => id([%expr `right])
  | `Start => id([%expr `start])
  | `Currentcolor => id([%expr `currentColor])
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
  | `Full_size_kana => raise(Unsupported_feature);

let variable_rule = {
  open Rule;
  open Let;

  let.bind_match () = Pattern.expect(DELIM("$"));
  let.bind_match _ = Pattern.expect(LEFT_PARENS) |> Modifier.optional;
  let.bind_match string = Standard.ident;
  let.bind_match _ = Pattern.expect(RIGHT_PARENS) |> Modifier.optional;
  return_match(string);
};
let variable = parser =>
  Combinator.combine_xor([
    Rule.Match.map(variable_rule, data => `Variable(data)),
    Rule.Match.map(parser, data => `Value(data)),
  ]);

let transform_with_variable = (parser, map, value_to_expr) =>
  emit(
    variable(parser),
    fun
    | `Variable(name) => name |> lid |> Exp.ident
    | `Value(ast) => map(ast),
    value_to_expr,
  );
let apply = (parser, map, id) =>
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
  apply(parser, variants_to_expression, identifier);

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

let render_length_percentage =
  fun
  | `Length(length) => render_length(length)
  | `Percentage(percentage) => render_percentage(percentage);

// css-sizing-3
let render_function_fit_content = _lp => raise(Unsupported_feature);
let width =
  apply(
    property_width,
    fun
    | `Auto => variants_to_expression(`Auto)
    | `Length(_) as lp
    | `Percentage(_) as lp => render_length_percentage(lp)
    | `Max_content
    | `Min_content => raise(Unsupported_feature)
    | `Fit_content(lp) => render_function_fit_content(lp)
    | _ => raise(Unsupported_feature),
    [%expr CssJs.width],
  );
let height =
  apply(
    property_height,
    apply_value(width.value_of_ast),
    [%expr CssJs.height],
  );
let min_width =
  apply(
    property_min_width,
    apply_value(width.value_of_ast),
    [%expr CssJs.minWidth],
  );
let min_height =
  apply(
    property_min_height,
    apply_value(width.value_of_ast),
    [%expr CssJs.minHeight],
  );
let max_width =
  apply(
    property_max_width,
    fun
    | `Auto => raise(Unsupported_feature)
    | `None => variants_to_expression(`None)
    | `Length(_) as ast
    | `Percentage(_) as ast
    | `Max_content as ast
    | `Min_content as ast
    | `Fit_content(_) as ast => apply_value(width.value_of_ast, ast)
    | _ => raise(Unsupported_feature),
    [%expr CssJs.maxWidth],
  );
let max_height =
  apply(
    property_max_height,
    data => max_width.value_of_ast(`Value(data)),
    [%expr CssJs.maxHeight],
  );
let box_sizing =
  apply(property_box_sizing, variants_to_expression, [%expr CssJs.boxSizing]);
let column_width = unsupported(property_column_width);

// css-box-3
let margin_top =
  apply(
    property_margin_top,
    fun
    | `Auto => variants_to_expression(`Auto)
    | `Length(_) as lp
    | `Percentage(_) as lp => render_length_percentage(lp),
    [%expr CssJs.marginTop],
  );
let margin_right =
  apply(
    property_margin_right,
    apply_value(margin_top.value_of_ast),
    [%expr CssJs.marginRight],
  );
let margin_bottom =
  apply(
    property_margin_bottom,
    apply_value(margin_top.value_of_ast),
    [%expr CssJs.marginBottom],
  );
let margin_left =
  apply(
    property_margin_left,
    apply_value(margin_top.value_of_ast),
    [%expr CssJs.marginLeft],
  );
let margin =
  emit(
    property_margin,
    List.map(apply_value(margin_top.value_of_ast)),
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
    | _ => failwith("unreachable"),
  );
let padding_top =
  apply(
    property_padding_top,
    render_length_percentage,
    [%expr CssJs.paddingTop],
  );
let padding_right =
  apply(
    property_padding_right,
    apply_value(padding_top.value_of_ast),
    [%expr CssJs.paddingRight],
  );
let padding_bottom =
  apply(
    property_padding_bottom,
    apply_value(padding_top.value_of_ast),
    [%expr CssJs.paddingBottom],
  );
let padding_left =
  apply(
    property_padding_left,
    apply_value(padding_top.value_of_ast),
    [%expr CssJs.paddingLeft],
  );
let padding =
  emit(
    property_padding,
    List.map(apply_value(padding_top.value_of_ast)),
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
    | _ => failwith("unreachable"),
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
  | `Number(number) => render_number(number)
  | `Percentage(percentage) => render_number(percentage /. 100.0);

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
  | Some(alpha) =>
    id([%expr `rgba(([%e red], [%e green], [%e blue], [%e alpha]))])
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
    id(
      [%expr `hsla(([%e hue], [%e saturation], [%e lightness], [%e alpha]))],
    )
  | None => id([%expr `hsl(([%e hue], [%e saturation], [%e lightness]))])
  };
};

let render_color =
  fun
  | `Hex_color(hex) => id([%expr `hex([%e render_string(hex)])])
  | `Named_color(color) => render_named_color(color)
  | `Currentcolor => variants_to_expression(`Currentcolor)
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

let color = apply(property_color, render_color, [%expr CssJs.color]);
let opacity =
  apply(
    property_opacity,
    fun
    | `Number(number) =>
      string_of_float(number) |> Const.float |> Exp.constant
    | `Percentage(number) =>
      string_of_float(number /. 100.0) |> Const.float |> Exp.constant,
    [%expr CssJs.opacity],
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

let object_fit = variants(property_object_fit, [%expr CssJs.objectFit]);
let object_position =
  apply(
    property_object_position,
    render_position,
    [%expr CssJs.objectPosition],
  );
let image_resolution = unsupported(property_image_resolution);
let image_orientation = unsupported(property_image_orientation);
let image_rendering = unsupported(property_image_rendering);

// css-backgrounds-3
let render_shadow = shadow => {
  let (color, x, y, blur, spread, inset) =
    switch (shadow) {
    | `Box(inset, position, color) =>
      let color = Option.value(~default=`Currentcolor, color);
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

  let color = render_color(color);
  let x = render_length(x);
  let y = render_length(y);
  let blur = Option.map(render_length, blur);
  let spread = Option.map(render_length, spread);
  let inset =
    Option.map(
      () => Exp.construct({txt: Lident("true"), loc: Location.none}, None),
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
  let id =
    switch (shadow) {
    | `Box(_) => id([%expr CssJs.Shadow.box])
    };
  Exp.apply(id, args);
};
let background_color =
  apply(property_background_color, render_color, [%expr CssJs.backgroundColor]);
let background_image =
  unsupported(property_background_image, ~call=[%expr CssJs.backgroundImage]);
let background_repeat =
  unsupported(property_background_repeat, ~call=[%expr CssJs.backgroundRepeat]);
let background_attachment =
  unsupported(
    property_background_attachment,
    ~call=[%expr CssJs.backgroundAttachment],
  );
let background_position =
  unsupported(
    property_background_position,
    ~call=[%expr CssJs.backgroundPosition],
  );
let background_clip =
  unsupported(property_background_clip, ~call=[%expr CssJs.backgroundClip]);
let background_origin =
  unsupported(property_background_origin, ~call=[%expr CssJs.backgroundOrigin]);
let background_size =
  unsupported(property_background_size, ~call=[%expr CssJs.backgroundSize]);
let background =
  unsupported(property_background, ~call=[%expr CssJs.background]);
let border_top_color =
  apply(property_border_top_color, render_color, [%expr CssJs.borderTopColor]);
let border_right_color =
  apply(
    property_border_right_color,
    apply_value(border_top_color.value_of_ast),
    [%expr CssJs.borderRightColor],
  );
let border_bottom_color =
  apply(
    property_border_bottom_color,
    apply_value(border_top_color.value_of_ast),
    [%expr CssJs.borderBottomColor],
  );
let border_left_color =
  apply(
    property_border_left_color,
    apply_value(border_top_color.value_of_ast),
    [%expr CssJs.borderLeftColor],
  );
let border_color =
  unsupported(property_border_color, ~call=[%expr CssJs.borderColor]);
let border_top_style =
  variants(property_border_top_style, [%expr CssJs.borderTopStyle]);
let border_right_style =
  variants(property_border_right_style, [%expr CssJs.borderRightStyle]);
let border_bottom_style =
  variants(property_border_bottom_style, [%expr CssJs.borderBottomStyle]);
let border_left_style =
  variants(property_border_left_style, [%expr CssJs.borderLeftStyle]);
let border_style =
  unsupported(property_border_style, ~call=[%expr CssJs.borderStyle]);

let render_line_width =
  fun
  | `Length(length) => render_length(length)
  | _ => raise(Unsupported_feature);
let border_top_width =
  apply(
    property_border_top_width,
    render_line_width,
    [%expr CssJs.borderTopWidth],
  );
let border_right_width =
  apply(
    property_border_right_width,
    render_line_width,
    [%expr CssJs.borderRightWidth],
  );
let border_bottom_width =
  apply(
    property_border_bottom_width,
    render_line_width,
    [%expr CssJs.borderBottomWidth],
  );
let border_left_width =
  apply(
    property_border_left_width,
    render_line_width,
    [%expr CssJs.borderLeftWidth],
  );
let border_width =
  unsupported(property_border_width, ~call=[%expr CssJs.borderWidth]);
let border_top =
  unsupported(property_border_top, ~call=[%expr CssJs.borderTop]);
let border_right =
  unsupported(property_border_right, ~call=[%expr CssJs.borderRight]);
let border_bottom =
  unsupported(property_border_bottom, ~call=[%expr CssJs.borderBottom]);
let border_left =
  unsupported(property_border_left, ~call=[%expr CssJs.borderLeft]);
let border = unsupported(property_border, ~call=[%expr CssJs.border]);
let border_top_left_radius =
  apply(
    property_border_top_left_radius,
    fun
    | [lp] => render_length_percentage(lp)
    | _ => raise(Unsupported_feature),
    [%expr CssJs.borderTopLeftRadius],
  );
let border_top_right_radius =
  apply(
    property_border_top_right_radius,
    apply_value(border_top_left_radius.value_of_ast),
    [%expr CssJs.borderTopRightRadius],
  );
let border_bottom_right_radius =
  apply(
    property_border_bottom_right_radius,
    apply_value(border_top_left_radius.value_of_ast),
    [%expr CssJs.borderBottomRightRadius],
  );
let border_bottom_left_radius =
  apply(
    property_border_bottom_left_radius,
    apply_value(border_top_left_radius.value_of_ast),
    [%expr CssJs.borderBottomLeftRadius],
  );
let border_radius =
  unsupported(property_border_radius, ~call=[%expr CssJs.borderRadius]);
let border_image_source = unsupported(property_border_image_source);
let border_image_slice = unsupported(property_border_image_slice);
let border_image_width = unsupported(property_border_image_width);
let border_image_outset = unsupported(property_border_image_outset);
let border_image_repeat = unsupported(property_border_image_repeat);
let border_image = unsupported(property_border_image);
let box_shadow =
  apply(
    property_box_shadow,
    fun
    | `None => variants_to_expression(`None)
    | `Shadow(shadows) => {
        let shadows =
          shadows
          |> List.map(shadow => `Box(shadow))
          |> List.map(render_shadow);
        Builder.pexp_array(~loc, shadows);
      },
    [%expr CssJs.boxShadows],
  );

// css-overflow-3
// TODO: maybe implement using strings?
let overflow_x =
  apply(
    property_overflow_x,
    fun
    | `Clip => raise(Unsupported_feature)
    | otherwise => variants_to_expression(otherwise),
    [%expr CssJs.overflowX],
  );
let overflow_y = variants(property_overflow_y, [%expr CssJs.overflowY]);
let overflow =
  emit(
    property_overflow,
    fun
    | `Xor(values) =>
      values |> List.map(apply_value(overflow_x.value_of_ast))
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
// let overflow_clip_margin = unsupported(property_overflow_clip_margin);
let overflow_inline = unsupported(property_overflow_inline);
let text_overflow =
  unsupported(property_text_overflow, ~call=[%expr CssJs.textOverflow]);
// let block_ellipsis = unsupported(property_block_ellipsis);
let max_lines = unsupported(property_max_lines);
// let continue = unsupported(property_continue);

// css-text-3
let text_transform =
  variants(property_text_transform, [%expr CssJs.textTransform]);
let white_space = variants(property_white_space, [%expr CssJs.whiteSpace]);
let tab_size = unsupported(property_tab_size);
let word_break = variants(property_word_break, [%expr CssJs.wordBreak]);
let line_break = unsupported(property_line_break);
let hyphens = unsupported(property_hyphens);
let overflow_wrap =
  variants(property_overflow_wrap, [%expr CssJs.overflowWrap]);
let word_wrap = variants(property_word_wrap, [%expr CssJs.wordWrap]);
let text_align = variants(property_text_align, [%expr CssJs.textAlign]);
// let text_align_all = unsupported(property_text_align_all);
let text_align_last = unsupported(property_text_align_last);
let text_justify = unsupported(property_text_justify);
let word_spacing =
  apply(
    property_word_spacing,
    fun
    | `Normal => variants_to_expression(`Normal)
    | `Length_percentage(lp) => render_length_percentage(lp),
    [%expr CssJs.wordSpacing],
  );
let letter_spacing =
  apply(
    property_word_spacing,
    fun
    | `Normal => variants_to_expression(`Normal)
    | `Length_percentage(lp) => render_length_percentage(lp),
    [%expr CssJs.letterSpacing],
  );
let text_indent =
  apply(
    property_text_indent,
    fun
    | (lp, None, None) => render_length_percentage(lp)
    | _ => raise(Unsupported_feature),
    [%expr CssJs.textIndent],
  );
let hanging_punctuation = unsupported(property_hanging_punctuation);

// css-fonts-4
let font_family =
  unsupported(property_font_family, ~call=[%expr CssJs.fontFamily]);
let font_weight =
  unsupported(property_font_weight, ~call=[%expr CssJs.fontWeight]);
let font_stretch = unsupported(property_font_stretch);
let font_style =
  unsupported(property_font_style, ~call=[%expr CssJs.fontStyle]);
let font_size = unsupported(property_font_size, ~call=[%expr CssJs.fontSize]);
let font_size_adjust = unsupported(property_font_size_adjust);
let font = unsupported(property_font);
// let font_synthesis_weight = unsupported(property_font_synthesis_weight);
// let font_synthesis_style = unsupported(property_font_synthesis_style);
// let font_synthesis_small_caps =
// unsupported(property_font_synthesis_small_caps);
let font_synthesis = unsupported(property_font_synthesis);
let font_kerning = unsupported(property_font_kerning);
let font_variant_ligatures = unsupported(property_font_variant_ligatures);
let font_variant_position = unsupported(property_font_variant_position);
let font_variant_caps = unsupported(property_font_variant_caps);
let font_variant_numeric = unsupported(property_font_variant_numeric);
let font_variant_alternates = unsupported(property_font_variant_alternates);
let font_variant_east_asian = unsupported(property_font_variant_east_asian);
let font_variant =
  unsupported(property_font_variant, ~call=[%expr CssJs.fontVariant]);
let font_feature_settings = unsupported(property_font_feature_settings);
let font_optical_sizing = unsupported(property_font_optical_sizing);
let font_variation_settings = unsupported(property_font_variation_settings);
// let font_palette = unsupported(property_font_palette);
// let font_variant_emoji = unsupported(property_font_variant_emoji);

// css-text-decor-3
let text_decoration_line =
  unsupported(
    property_text_decoration_line,
    ~call=[%expr CssJs.textDecorationLine],
  );
let text_decoration_style =
  unsupported(
    property_text_decoration_style,
    ~call=[%expr CssJs.textDecorationStyle],
  );
let text_decoration_color =
  unsupported(
    property_text_decoration_color,
    ~call=[%expr CssJs.textDecorationColor],
  );
let text_decoration_thickness =
  unsupported(property_text_decoration_thickness);
let text_decoration =
  unsupported(property_text_decoration, ~call=[%expr CssJs.textDecoration]);
let text_underline_position = unsupported(property_text_underline_position);
let text_underline_offset = unsupported(property_text_underline_offset);
let text_decoration_skip = unsupported(property_text_decoration_skip);
// let text_decoration_skip_self =
//   unsupported(property_text_decoration_skip_self);
// let text_decoration_skip_box = unsupported(property_text_decoration_skip_box);
// let text_decoration_skip_inset =
//   unsupported(property_text_decoration_skip_inset);
// let text_decoration_skip_spaces =
//   unsupported(property_text_decoration_skip_spaces);
let text_decoration_skip_ink = unsupported(property_text_decoration_skip_ink);
let text_emphasis_style = unsupported(property_text_emphasis_style);
let text_emphasis_color = unsupported(property_text_emphasis_color);
let text_emphasis = unsupported(property_text_emphasis);
let text_emphasis_position = unsupported(property_text_emphasis_position);
// let text_emphasis_skip = unsupported(property_text_emphasis_skip);
let text_shadow =
  unsupported(property_text_shadow, ~call=[%expr CssJs.textShadow]);

// css-transforms-2
let transform = unsupported(property_transform, ~call=[%expr CssJs.transform]);
let transform_origin =
  unsupported(property_transform_origin, ~call=[%expr CssJs.transformOrigin]);
let transform_box =
  unsupported(property_transform_box, ~call=[%expr CssJs.transformOrigin]);
let translate = unsupported(property_translate, ~call=[%expr CssJs.translate]);
let rotate = unsupported(property_rotate, ~call=[%expr CssJs.rotate]);
let scale = unsupported(property_scale, ~call=[%expr CssJs.scale]);
let transform_style =
  unsupported(property_transform_style, ~call=[%expr CssJs.transformStyle]);
let perspective = unsupported(property_perspective);
let perspective_origin =
  unsupported(property_perspective_origin, ~call=[%expr CssJs.transformStyle]);
let backface_visibility =
  unsupported(
    property_backface_visibility,
    ~call=[%expr CssJs.backfaceVisibility],
  );

// css-transition-1
let transition_property =
  unsupported(
    property_transition_property,
    ~call=[%expr CssJs.transitionProperty],
  );
let transition_duration =
  unsupported(
    property_transition_duration,
    ~call=[%expr CssJs.transitionDuration],
  );
let transition_timing_function =
  unsupported(
    property_transition_timing_function,
    ~call=[%expr CssJs.transitionTimingFunction],
  );
let transition_delay =
  unsupported(property_transition_delay, ~call=[%expr CssJs.transitionDelay]);
let transition =
  unsupported(property_transition, ~call=[%expr CssJs.transition]);

// css-animation-1
let animation_name =
  unsupported(property_animation_name, ~call=[%expr CssJs.animationName]);
let animation_duration =
  unsupported(
    property_animation_duration,
    ~call=[%expr CssJs.animationDuration],
  );
let animation_timing_function =
  unsupported(
    property_animation_timing_function,
    ~call=[%expr CssJs.CssJs.animationTimingFunction],
  );
let animation_iteration_count =
  unsupported(
    property_animation_iteration_count,
    ~call=[%expr CssJs.animationIterationCount],
  );
let animation_direction =
  unsupported(
    property_animation_direction,
    ~call=[%expr CssJs.animationDirection],
  );
let animation_play_state =
  unsupported(
    property_animation_play_state,
    ~call=[%expr CssJs.animationPlayState],
  );
let animation_delay =
  unsupported(property_animation_delay, ~call=[%expr CssJs.animationDelay]);
let animation_fill_mode =
  unsupported(
    property_animation_fill_mode,
    ~call=[%expr CssJs.animationFillMode],
  );
let animation = unsupported(property_animation, ~call=[%expr CssJs.animation]);

// css-flexbox-1
// using id() because refmt
let flex_direction =
  variants(property_flex_direction, [%expr CssJs.flexDirection]);
let flex_wrap = variants(property_flex_wrap, [%expr CssJs.flexWrap]);

// shorthand - https://drafts.csswg.org/css-flexbox-1/#flex-flow-property
let flex_flow =
  emit(
    property_flex_flow,
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
let order = apply(property_order, render_integer, [%expr CssJs.order]);
let flex_grow =
  apply(property_flex_grow, render_number, [%expr CssJs.flexGrow]);
let flex_shrink =
  apply(property_flex_shrink, render_number, [%expr CssJs.flexShrink]);
// TODO: is safe to just return CssJs.width when flex_basis?
let flex_basis =
  apply(
    property_flex_basis,
    fun
    | `Content => variants_to_expression(`Content)
    | `Property_width(value_width) =>
      width.value_of_ast(`Value(value_width)),
    [%expr CssJs.flexBasis],
  );
// TODO: this is incomplete
let flex =
  emit(
    property_flex,
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
  unsupported(property_justify_content, ~call=[%expr CssJs.justifyContent]);
let align_items =
  unsupported(property_align_items, ~call=[%expr CssJs.alignItems]);
let align_self =
  unsupported(property_align_self, ~call=[%expr CssJs.alignSelf]);
let align_content =
  unsupported(property_align_content, ~call=[%expr CssJs.alignContent]);

// css-grid-1
let grid_template_columns =
  unsupported(
    property_grid_template_columns,
    ~call=[%expr CssJs.gridTemplateColumns],
  );
let grid_template_rows =
  unsupported(
    property_grid_template_rows,
    ~call=[%expr CssJs.gridTemplateRows],
  );
let grid_template_areas =
  unsupported(
    property_grid_template_areas,
    ~call=[%expr CssJs.gridTemplateAreas],
  );
let grid_template = unsupported(property_grid_template);
let grid_auto_columns =
  unsupported(property_grid_auto_columns, ~call=[%expr CssJs.gridAutoColumns]);
let grid_auto_rows =
  unsupported(property_grid_auto_rows, ~call=[%expr CssJs.gridAutoRows]);
let grid_auto_flow =
  unsupported(property_grid_auto_flow, ~call=[%expr CssJs.gridAutoFlow]);
let grid = unsupported(property_grid, ~call=[%expr CssJs.grid]);
let grid_row_start =
  unsupported(property_grid_row_start, ~call=[%expr CssJs.gridRowStart]);
let grid_column_start =
  unsupported(property_grid_column_start, ~call=[%expr CssJs.gridColumnStart]);
let grid_row_end =
  unsupported(property_grid_row_end, ~call=[%expr CssJs.gridRowEnd]);
let grid_column_end =
  unsupported(property_grid_column_end, ~call=[%expr CssJs.gridColumnEnd]);
let grid_row = unsupported(property_grid_row, ~call=[%expr CssJs.gridRow]);
let grid_column =
  unsupported(property_grid_column, ~call=[%expr CssJs.gridColumn]);
let grid_area = unsupported(property_grid_area, ~call=[%expr CssJs.gridArea]);
let display = unsupported(property_display, ~call=[%expr CssJs.display]);

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
];

let support_property = name =>
  Parser.check_map
  |> StringMap.find_opt("property-" ++ name)
  |> Option.is_some;

let render_when_unsupported_features = (name, value) => {
  let to_camel_case = name =>
    (
      switch (String.split_on_char('-', name)) {
      | [first, ...remaining] => [
          first,
          ...List.map(String.capitalize_ascii, remaining),
        ]
      | [] => []
      }
    )
    |> String.concat("");

  /* Transform property name to camelCase since we bind emotion to the Object API */
  let name = name |> to_camel_case |> Const.string |> Exp.constant;
  let value = value |> Const.string |> Exp.constant;

  id([%expr CssJs.unsafe([%e name], [%e value])]);
};

let render_to_expr = (name, value) => {
  let.ok string_to_expr =
    switch (properties |> List.find_opt(((key, _)) => key == name)) {
    | Some((_, (_, string_to_expr))) => Ok(string_to_expr)
    | None => Error(`Not_found)
    };
  string_to_expr(value) |> Result.map_error(str => `Invalid_value(str));
};

let parse_declarations = ((name, value)) => {
  open Parser;

  let.ok is_valid_string =
    check_property(~name, value)
    |> Result.map_error((`Unknown_value) => `Not_found);

  switch (render_css_wide_keywords(name, value)) {
  | Ok(value) => Ok(value)
  | Error(_) =>
    switch (render_to_expr(name, value)) {
    | Ok(value) => Ok(value)
    | Error(_)
    | exception Unsupported_feature =>
      let.ok () = is_valid_string ? Ok() : Error(`Invalid_value(value));
      Ok([render_when_unsupported_features(name, value)]);
    }
  };
};
