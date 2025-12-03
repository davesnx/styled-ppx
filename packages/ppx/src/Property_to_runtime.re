module Parsetree = Ppxlib.Parsetree;
module Builder = Ppxlib.Ast_builder.Default;

module Standard = Css_grammar.Standard;
module Parser = Css_grammar.Parser;
module Types = Css_grammar.Types;
module Location = Ppxlib.Location;

let txt = (~loc, txt) => {
  Location.loc,
  txt,
};

/* TODO: Separate unsupported_feature from bs-css doesn't support or can't interpolate on those */
/* TODO: Add payload on those exceptions */
exception Unsupported_feature;

/* This should be thrown when handling cases impossible to generate by the css property parser */
exception Impossible_state;

exception Invalid_value(string);

let add_CSS_rule_constraint = (~loc, expr) => {
  let typ =
    Builder.ptyp_constr(
      ~loc,
      {
        txt: Ldot(Lident("CSS"), "rule"),
        loc,
      },
      [],
    );
  Builder.pexp_constraint(~loc, expr, typ);
};

let render_option = (~loc, f) =>
  fun
  | Some(v) => [%expr Some([%e f(~loc, v)])]
  | None => [%expr None];

let list_to_longident = vars =>
  vars |> String.concat(".") |> Ppxlib.Longident.parse;

let render_variable = (~loc, name) => {
  let ident = list_to_longident(name) |> txt(~loc);
  Builder.pexp_ident(~loc, ident);
};

let variant_to_expression = (~loc) =>
  fun
  | `Anywhere => [%expr `anywhere]
  | `Auto => [%expr `auto]
  | `Baseline => [%expr `baseline]
  | `Blink => [%expr `blink]
  | `Bold => [%expr `bold]
  | `Bolder => [%expr `bolder]
  | `Border_box => [%expr `borderBox]
  | `Border_area => [%expr `borderArea]
  | `Bottom => [%expr `bottom]
  | `Break_all => [%expr `breakAll]
  | `Break_spaces => [%expr `breakSpaces]
  | `Break_word => raise(Unsupported_feature)
  | `BreakWord => [%expr `breakWord]
  | `Capitalize => [%expr `capitalize]
  | `Center => [%expr `center]
  | `Clip => [%expr `clip]
  | `Column => [%expr `column]
  | `Column_reverse => [%expr `columnReverse]
  | `Contain => [%expr `contain]
  | `Content => [%expr `content]
  | `Content_box => [%expr `contentBox]
  | `Cover => [%expr `cover]
  | `Dashed => [%expr `dashed]
  | `Dotted => [%expr `dotted]
  | `Double => [%expr `double]
  | `Ellipsis => [%expr `ellipsis]
  | `End => [%expr `end_]
  | `Fill => [%expr `fill]
  | `Flat => [%expr `flat]
  | `Flex_end => [%expr `flexEnd]
  | `Flex_start => [%expr `flexStart]
  | `From_font => raise(Unsupported_feature)
  | `Groove => [%expr `groove]
  | `Hidden => [%expr `hidden]
  | `Inset => [%expr `inset]
  | `Italic => [%expr `italic]
  | `Justify => [%expr `justify]
  | `Keep_all => [%expr `keepAll]
  | `Left => [%expr `left]
  | `Lighter => [%expr `lighter]
  | `Line_Through => [%expr `lineThrough]
  | `Lowercase => [%expr `lowercase]
  | `MaxContent => [%expr `maxContent]
  | `MinContent => [%expr `minContent]
  | `None => [%expr `none]
  | `Normal => [%expr `normal]
  | `Nowrap => [%expr `nowrap]
  | `Oblique => [%expr `oblique]
  | `Outset => [%expr `outset]
  | `Overline => [%expr `overline]
  | `Padding_box => [%expr `paddingBox]
  | `Pre => [%expr `pre]
  | `Pre_line => [%expr `preLine]
  | `Pre_wrap => [%expr `preWrap]
  | `Preserve_3d => [%expr `preserve3d]
  | `Repeat_x => [%expr `repeatX]
  | `Repeat_y => [%expr `repeatY]
  | `Ridge => [%expr `ridge]
  | `Right => [%expr `right]
  | `Row => [%expr `row]
  | `Row_reverse => [%expr `rowReverse]
  | `Scale_down => [%expr `scaleDown]
  | `Scroll => [%expr `scroll]
  | `Small_caps => [%expr `smallCaps]
  | `Solid => [%expr `solid]
  | `Space_around => [%expr `spaceAround]
  | `Space_between => [%expr `spaceBetween]
  | `Start => [%expr `start]
  | `Stretch => [%expr `stretch]
  | `Top => [%expr `top]
  | `Transparent => [%expr `transparent]
  | `Underline => [%expr `underline]
  | `Unset => [%expr `unset]
  | `Uppercase => [%expr `uppercase]
  | `Visible => [%expr `visible]
  | `Wavy => [%expr `wavy]
  | `Wrap => [%expr `wrap]
  | `Match_parent => [%expr `matchParent]
  | `Justify_all => [%expr `justifyAll]
  | `Wrap_reverse => [%expr `wrapReverse]
  | `Manual => [%expr `manual]
  | `Inter_word => [%expr `interWord]
  | `Inter_character => [%expr `interCharacter]
  | `Sub => [%expr `sub]
  | `Super => [%expr `super]
  | `All_small_caps => [%expr `allSmallCaps]
  | `Petite_caps => [%expr `petiteCaps]
  | `All_petite_caps => [%expr `allPetiteCaps]
  | `Unicase => [%expr `unicase]
  | `Titling_caps => [%expr `titlingCaps]
  | `Text => [%expr `text]
  | `Emoji => [%expr `emoji]
  | `Unicode => [%expr `unicode]
  | `All => [%expr `all]
  | `Fill_box => [%expr `fillBox]
  | `Stroke_box => [%expr `strokeBox]
  | `View_box => [%expr `viewBox]
  | `Smooth => [%expr `smooth]
  | `High_quality => [%expr `highQuality]
  | `Pixelated => [%expr `pixelated]
  | `Crisp_edges => [%expr `crispEdges]
  | `FitContent => raise(Unsupported_feature)
  | `Full_width => raise(Unsupported_feature)
  | `Full_size_kana => raise(Unsupported_feature);

let transform_with_variable = (parser, mapper, value_to_expr, ~loc, string) => {
  open Css_grammar;
  let parse =
    Parser.parse(
      Combinators.xor([
        /* This xor ensures that interpolation could be placed as the entire value, without the need of modifying the entire grammar. */
        Rule.Match.map(Standard.interpolation, data => `Interpolation(data)),
        /* Otherwise it's a regular CSS `Value and match the parser */
        Rule.Match.map(parser, data => `Value(data)),
      ]),
    );
  let to_expr = (~loc, ast) => {
    switch (ast) {
    | `Interpolation(name) =>
      render_variable(~loc, name)
      |> value_to_expr(~loc)
      |> List.map(add_CSS_rule_constraint(~loc))
    | `Value(ast) => mapper(~loc, ast) |> value_to_expr(~loc)
    };
  };

  parse(string) |> Result.map(to_expr(~loc));
};

/* Monomoprhipc properties are the ones that can only have one representation
    of the value (and it's one argument also) which it's also possible to interpolate on them.

   For example: Parser.Property_font_size.rule => CSS.fontSize
   */
let monomorphic = (parser, property_renderer, value_renderer) =>
  transform_with_variable(parser, value_renderer, (~loc, value) =>
    [[%expr [%e property_renderer(~loc)]([%e value])]]
  );

/* Polymorphic is when a property can have multiple representations and/or can generate multiple declarations */
let polymorphic = (property, to_expr, ~loc, string) =>
  Parser.parse(property, string) |> Result.map(to_expr(~loc));

let variants = (parser, identifier) =>
  monomorphic(parser, identifier, variant_to_expression);

/* Triggers Unsupported_feature and it's rendered as a string,
   supports interpolation as a string, which is unsafe */
let unsupportedProperty = parser =>
  transform_with_variable(
    parser,
    (~loc as _) => raise(Unsupported_feature),
    (~loc as _) => raise(Unsupported_feature),
  );

let render_string = (~loc, s) => {
  switch (File.get()) {
  | Some(ReScript) =>
    Builder.pexp_constant(~loc, Pconst_string(s, loc, Some("*j")))
  | Some(Reason)
  | _ => Builder.pexp_constant(~loc, Pconst_string(s, loc, Some("js")))
  };
};

let render_integer = (~loc, integer) => {
  Builder.pexp_constant(~loc, Pconst_integer(Int.to_string(integer), None));
};

let render_float = (~loc, number) =>
  Builder.pexp_constant(~loc, Pconst_float(Float.to_string(number), None));

let render_percentage = (~loc, number) => [%expr
  `percent([%e render_float(~loc, number)])
];

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

// TODO: all of them could be float, but bs-css doesn't support it
let render_length = (~loc) =>
  fun
  | `Cap(_n) => raise(Unsupported_feature)
  | `Ch(n) => [%expr `ch([%e render_float(~loc, n)])]
  | `Em(n) => [%expr `em([%e render_float(~loc, n)])]
  | `Ex(n) => [%expr `ex([%e render_float(~loc, n)])]
  | `Ic(_n) => raise(Unsupported_feature)
  | `Lh(_n) => raise(Unsupported_feature)
  | `Rcap(_n) => raise(Unsupported_feature)
  | `Rch(_n) => raise(Unsupported_feature)
  | `Rem(n) => [%expr `rem([%e render_float(~loc, n)])]
  | `Rex(_n) => raise(Unsupported_feature)
  | `Ric(_n) => raise(Unsupported_feature)
  | `Rlh(_n) => raise(Unsupported_feature)

  | `Vh(n) => [%expr `vh([%e render_float(~loc, n)])]
  | `Vw(n) => [%expr `vw([%e render_float(~loc, n)])]
  | `Vmax(n) => [%expr `vmax([%e render_float(~loc, n)])]
  | `Vmin(n) => [%expr `vmin([%e render_float(~loc, n)])]
  | `Vb(_n) => raise(Unsupported_feature)
  | `Vi(_n) => raise(Unsupported_feature)

  | `Cqw(n) => [%expr `cqw([%e render_float(~loc, n)])]
  | `Cqh(n) => [%expr `cqh([%e render_float(~loc, n)])]
  | `Cqi(n) => [%expr `cqi([%e render_float(~loc, n)])]
  | `Cqb(n) => [%expr `cqb([%e render_float(~loc, n)])]
  | `Cqmin(n) => [%expr `cqmin([%e render_float(~loc, n)])]
  | `Cqmax(n) => [%expr `cqmax([%e render_float(~loc, n)])]

  | `Px(n) => [%expr `pxFloat([%e render_float(~loc, n)])]
  | `Cm(n) => [%expr `cm([%e render_float(~loc, n)])]
  | `Mm(n) => [%expr `mm([%e render_float(~loc, n)])]
  | `Q(_n) => raise(Unsupported_feature)
  | `In(_n) => raise(Unsupported_feature)
  | `Pc(n) => [%expr `pc([%e render_float(~loc, n)])]
  | `Pt(n) => [%expr `pt([%e render_integer(~loc, n |> Float.to_int)])]
  | `Zero => [%expr `zero];

let rec render_function_calc = (~loc, calc_sum) => {
  [%expr `calc([%e render_calc_sum(~loc, calc_sum)])];
}

and render_calc_sum = (~loc, (product, sums): Parser.Calc_sum.t) => {
  let rec go = (left, rest) => {
    switch (rest) {
    | [] => left
    | [x, ...xs] =>
      switch (x) {
      | (`Cross (), calc_product) =>
        go(
          [%expr
            `add(([%e left], [%e render_calc_product(~loc, calc_product)]))
          ],
          xs,
        )
      | (`Dash (), calc_product) =>
        go(
          [%expr
            `sub(([%e left], [%e render_calc_product(~loc, calc_product)]))
          ],
          xs,
        )
      }
    };
  };
  go(render_calc_product(~loc, product), sums);
}
and render_function_min_or_max = (~loc, calc_sums: list(Parser.Calc_sum.t)) => {
  switch (calc_sums) {
  | [] => raise(Impossible_state)
  | [x, ...xs] =>
    let calc_sums = [x] @ List.map(Fun.id, xs);
    List.map(render_calc_sum(~loc), calc_sums) |> Builder.pexp_array(~loc);
  };
}
and render_function_min = (~loc, calc_sums) => {
  [%expr `min([%e render_function_min_or_max(~loc, calc_sums)])];
}
and render_function_max = (~loc, calc_sums) => {
  [%expr `max([%e render_function_min_or_max(~loc, calc_sums)])];
}
and render_calc_product = (~loc, (value, products): Parser.Calc_product.t) => {
  let rec go = (left, rest) => {
    switch (rest) {
    | [] => left
    | [x, ...xs] =>
      switch (x) {
      | `Static_0(_, value) =>
        go(
          [%expr `mult(([%e left], [%e render_calc_value(~loc, value)]))],
          xs,
        )
      | `Static_1(_, float_value) =>
        go(
          [%expr `div(([%e left], [%e render_float(~loc, float_value)]))],
          xs,
        )
      }
    };
  };
  go(render_calc_value(~loc, value), products);
}
and render_angle = (~loc) =>
  fun
  | `Deg(number) => [%expr `deg([%e render_float(~loc, number)])]
  | `Rad(number) => [%expr `rad([%e render_float(~loc, number)])]
  | `Grad(number) => [%expr `grad([%e render_float(~loc, number)])]
  | `Turn(number) => [%expr `turn([%e render_float(~loc, number)])]

and render_extended_angle = (~loc) =>
  fun
  | `Angle(a) => render_angle(~loc, a)
  | `Function_calc(fc) => render_function_calc(~loc, fc)
  | `Interpolation(i) => render_variable(~loc, i)
  | `Function_min(values) => render_function_min(~loc, values)
  | `Function_max(values) => render_function_max(~loc, values)

and render_time_as_int = (~loc) =>
  fun
  | `Ms(f) => {
      let value = Float.to_int(f);
      [%expr `ms([%e render_integer(~loc, value)])];
    }
  | `S(f) =>
    if (f > 0. && f < 1.) {
      render_time_as_int(~loc, `Ms(f *. 1000.));
    } else {
      let value = Float.to_int(f);
      [%expr `s([%e render_integer(~loc, value)])];
    }

and render_extended_time_no_interp = (~loc) =>
  fun
  | `Time(t) => render_time_as_int(~loc, t)
  | `Function_calc(fc) => render_function_calc(~loc, fc)
  | `Function_min(values) => render_function_min(~loc, values)
  | `Function_max(values) => render_function_max(~loc, values)

and render_extended_time = (~loc) =>
  fun
  | #Types.extended_time_no_interp as x =>
    render_extended_time_no_interp(~loc, x)
  | `Interpolation(v) => render_variable(~loc, v)

and render_calc_value = (~loc, calc_value: Types.calc_value) => {
  switch (calc_value) {
  | `Number(float) => [%expr `num([%e render_float(~loc, float)])]
  | `Extended_length(l) => render_extended_length(~loc, l)
  | `Extended_percentage(p) => render_extended_percentage(~loc, p)
  | `Extended_angle(a) => render_extended_angle(~loc, a)
  | `Extended_time(t) => render_extended_time(~loc, t)
  | `Static(_, calc_sum, _) => render_calc_sum(~loc, calc_sum)
  };
}
and render_extended_length = (~loc) =>
  fun
  | `Length(l) => render_length(~loc, l)
  | `Function_calc(fc) => render_function_calc(~loc, fc)
  | `Function_min(values) => render_function_min(~loc, values)
  | `Function_max(values) => render_function_max(~loc, values)
  | `Interpolation(i) => render_variable(~loc, i)
and render_extended_percentage = (~loc) =>
  fun
  | `Percentage(p) => render_percentage(~loc, p)
  | `Function_calc(fc) => render_function_calc(~loc, fc)
  | `Interpolation(i) => render_variable(~loc, i)
  | `Function_min(values) => render_function_min(~loc, values)
  | `Function_max(values) => render_function_max(~loc, values);

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

let render_bg_size = (~loc, value: Parser.Bg_size.t) =>
  switch (value) {
  | `One_bg_size(one, None) => render_one_bg_size(~loc, one)
  | `One_bg_size(one, Some(two)) => [%expr
     `size((
       [%e render_one_bg_size(~loc, one)],
       [%e render_one_bg_size(~loc, two)],
     ))
    ]
  | `Cover => variant_to_expression(~loc, `Cover)
  | `Contain => variant_to_expression(~loc, `Contain)
  };

let render_max_width = (~loc) =>
  fun
  | `Extended_length(l) => render_extended_length(~loc, l)
  | `Extended_percentage(p) => render_extended_percentage(~loc, p)
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
  | `Deg(number) => [%expr `deg([%e render_float(~loc, number)])]
  | `Rad(number) => [%expr `rad([%e render_float(~loc, number)])]
  | `Grad(number) => [%expr `grad([%e render_float(~loc, number)])]
  | `Turn(number) => [%expr `turn([%e render_float(~loc, number)])];

let render_extended_angle = (~loc) =>
  fun
  | `Angle(a) => render_angle(~loc, a)
  | `Function_calc(fc) => render_function_calc(~loc, fc)
  | `Interpolation(i) => render_variable(~loc, i)
  | `Function_min(values) => render_function_min(~loc, values)
  | `Function_max(values) => render_function_max(~loc, values);

let render_side_or_corner = (~loc, value: Parser.Side_or_corner.t) => {
  switch (value) {
  | (None, Some(`Top)) => [%expr `Top]
  | (Some(`Left), None) => [%expr `Left]
  | (None, Some(`Bottom)) => [%expr `Bottom]
  | (Some(`Right), None) => [%expr `Right]
  | (Some(`Left), Some(`Top)) => [%expr `TopLeft]
  | (Some(`Right), Some(`Top)) => [%expr `TopRight]
  | (Some(`Left), Some(`Bottom)) => [%expr `BottomLeft]
  | (Some(`Right), Some(`Bottom)) => [%expr `BottomRight]
  /* by ast, that can't be possible */
  | (None, None) => assert(false)
  };
};

let width =
  monomorphic(
    Parser.Property_width.rule,
    (~loc) => [%expr CSS.width],
    render_size,
  );

let height =
  monomorphic(
    Parser.Property_height.rule,
    (~loc) => [%expr CSS.height],
    render_size,
  );

let min_width =
  monomorphic(
    Parser.Property_min_width.rule,
    (~loc) => [%expr CSS.minWidth],
    render_min_size,
  );

let min_height =
  monomorphic(
    Parser.Property_min_height.rule,
    (~loc) => [%expr CSS.minHeight],
    render_min_size,
  );

let max_width =
  monomorphic(
    Parser.Property_max_width.rule,
    (~loc) => [%expr CSS.maxWidth],
    render_max_width,
  );

let max_height =
  monomorphic(
    Parser.Property_max_height.rule,
    (~loc) => [%expr CSS.maxHeight],
    render_size,
  );

let box_sizing =
  monomorphic(
    Parser.Property_box_sizing.rule,
    (~loc) => [%expr CSS.boxSizing],
    variant_to_expression,
  );

let column_width =
  monomorphic(
    Parser.Property_column_width.rule,
    (~loc) => [%expr CSS.columnWidth],
    (~loc, value: Parser.Property_column_width.t) =>
      switch (value) {
      | `Auto => variant_to_expression(~loc, `Auto)
      | `Extended_length(l) => render_extended_length(~loc, l)
      },
  );

let render_margin = (~loc) =>
  fun
  | `Auto => variant_to_expression(~loc, `Auto)
  | `Extended_length(l) => render_extended_length(~loc, l)
  | `Extended_percentage(p) => render_extended_percentage(~loc, p)
  | `Interpolation(name) => render_variable(~loc, name);

let render_padding = (~loc) =>
  fun
  | `Auto => variant_to_expression(~loc, `Auto)
  | `Extended_length(l) => render_extended_length(~loc, l)
  | `Extended_percentage(p) => render_extended_percentage(~loc, p)
  | `Interpolation(name) => render_variable(~loc, name);

// css-box-3
let margin_top =
  monomorphic(
    Parser.Property_margin_top.rule,
    (~loc) => [%expr CSS.marginTop],
    render_margin,
  );

let margin_right =
  monomorphic(
    Parser.Property_margin_right.rule,
    (~loc) => [%expr CSS.marginRight],
    render_margin,
  );

let margin_bottom =
  monomorphic(
    Parser.Property_margin_bottom.rule,
    (~loc) => [%expr CSS.marginBottom],
    render_margin,
  );

let margin_left =
  monomorphic(
    Parser.Property_margin_left.rule,
    (~loc) => [%expr CSS.marginLeft],
    render_margin,
  );

let margin =
  polymorphic(Parser.Property_margin.rule, (~loc) =>
    fun
    | [one] => [[%expr CSS.margin([%e render_margin(~loc, one)])]]
    | [v, h] => [
        [%expr
          CSS.margin2(
            ~v=[%e render_margin(~loc, v)],
            ~h=[%e render_margin(~loc, h)],
          )
        ],
      ]
    | [t, h, b] => [
        [%expr
          CSS.margin3(
            ~top=[%e render_margin(~loc, t)],
            ~h=[%e render_margin(~loc, h)],
            ~bottom=[%e render_margin(~loc, b)],
          )
        ],
      ]
    | [t, r, b, l] => [
        [%expr
          CSS.margin4(
            ~top=[%e render_margin(~loc, t)],
            ~right=[%e render_margin(~loc, r)],
            ~bottom=[%e render_margin(~loc, b)],
            ~left=[%e render_margin(~loc, l)],
          )
        ],
      ]
    | []
    | _ => raise(Impossible_state)
  );

let padding_top =
  monomorphic(
    Parser.Property_padding_top.rule,
    (~loc) => [%expr CSS.paddingTop],
    render_padding,
  );

let padding_right =
  monomorphic(
    Parser.Property_padding_right.rule,
    (~loc) => [%expr CSS.paddingRight],
    render_padding,
  );

let padding_bottom =
  monomorphic(
    Parser.Property_padding_bottom.rule,
    (~loc) => [%expr CSS.paddingBottom],
    render_padding,
  );

let padding_left =
  monomorphic(
    Parser.Property_padding_left.rule,
    (~loc) => [%expr CSS.paddingLeft],
    render_padding,
  );

let padding =
  polymorphic(Parser.Property_padding.rule, (~loc) =>
    fun
    | [one] => [[%expr CSS.padding([%e render_padding(~loc, one)])]]
    | [v, h] => [
        [%expr
          CSS.padding2(
            ~v=[%e render_padding(~loc, v)],
            ~h=[%e render_padding(~loc, h)],
          )
        ],
      ]
    | [t, h, b] => [
        [%expr
          CSS.padding3(
            ~top=[%e render_padding(~loc, t)],
            ~h=[%e render_padding(~loc, h)],
            ~bottom=[%e render_padding(~loc, b)],
          )
        ],
      ]
    | [t, r, b, l] => [
        [%expr
          CSS.padding4(
            ~top=[%e render_padding(~loc, t)],
            ~right=[%e render_padding(~loc, r)],
            ~bottom=[%e render_padding(~loc, b)],
            ~left=[%e render_padding(~loc, l)],
          )
        ],
      ]
    | []
    | _ => raise(Impossible_state)
  );
let render_named_color = (~loc) =>
  fun
  | `Transparent => variant_to_expression(~loc, `Transparent)
  | `Aliceblue => [%expr CSS.aliceblue]
  | `Antiquewhite => [%expr CSS.antiquewhite]
  | `Aqua => [%expr CSS.aqua]
  | `Aquamarine => [%expr CSS.aquamarine]
  | `Azure => [%expr CSS.azure]
  | `Beige => [%expr CSS.beige]
  | `Bisque => [%expr CSS.bisque]
  | `Black => [%expr CSS.black]
  | `Blanchedalmond => [%expr CSS.blanchedalmond]
  | `Blue => [%expr CSS.blue]
  | `Blueviolet => [%expr CSS.blueviolet]
  | `Brown => [%expr CSS.brown]
  | `Burlywood => [%expr CSS.burlywood]
  | `Cadetblue => [%expr CSS.cadetblue]
  | `Chartreuse => [%expr CSS.chartreuse]
  | `Chocolate => [%expr CSS.chocolate]
  | `Coral => [%expr CSS.coral]
  | `Cornflowerblue => [%expr CSS.cornflowerblue]
  | `Cornsilk => [%expr CSS.cornsilk]
  | `Crimson => [%expr CSS.crimson]
  | `Cyan => [%expr CSS.cyan]
  | `Darkblue => [%expr CSS.darkblue]
  | `Darkcyan => [%expr CSS.darkcyan]
  | `Darkgoldenrod => [%expr CSS.darkgoldenrod]
  | `Darkgray => [%expr CSS.darkgray]
  | `Darkgreen => [%expr CSS.darkgreen]
  | `Darkgrey => [%expr CSS.darkgrey]
  | `Darkkhaki => [%expr CSS.darkkhaki]
  | `Darkmagenta => [%expr CSS.darkmagenta]
  | `Darkolivegreen => [%expr CSS.darkolivegreen]
  | `Darkorange => [%expr CSS.darkorange]
  | `Darkorchid => [%expr CSS.darkorchid]
  | `Darkred => [%expr CSS.darkred]
  | `Darksalmon => [%expr CSS.darksalmon]
  | `Darkseagreen => [%expr CSS.darkseagreen]
  | `Darkslateblue => [%expr CSS.darkslateblue]
  | `Darkslategray => [%expr CSS.darkslategray]
  | `Darkslategrey => [%expr CSS.darkslategrey]
  | `Darkturquoise => [%expr CSS.darkturquoise]
  | `Darkviolet => [%expr CSS.darkviolet]
  | `Deeppink => [%expr CSS.deeppink]
  | `Deepskyblue => [%expr CSS.deepskyblue]
  | `Dimgray => [%expr CSS.dimgray]
  | `Dimgrey => [%expr CSS.dimgrey]
  | `Dodgerblue => [%expr CSS.dodgerblue]
  | `Firebrick => [%expr CSS.firebrick]
  | `Floralwhite => [%expr CSS.floralwhite]
  | `Forestgreen => [%expr CSS.forestgreen]
  | `Fuchsia => [%expr CSS.fuchsia]
  | `Gainsboro => [%expr CSS.gainsboro]
  | `Ghostwhite => [%expr CSS.ghostwhite]
  | `Gold => [%expr CSS.gold]
  | `Goldenrod => [%expr CSS.goldenrod]
  | `Gray => [%expr CSS.gray]
  | `Green => [%expr CSS.green]
  | `Greenyellow => [%expr CSS.greenyellow]
  | `Grey => [%expr CSS.grey]
  | `Honeydew => [%expr CSS.honeydew]
  | `Hotpink => [%expr CSS.hotpink]
  | `Indianred => [%expr CSS.indianred]
  | `Indigo => [%expr CSS.indigo]
  | `Ivory => [%expr CSS.ivory]
  | `Khaki => [%expr CSS.khaki]
  | `Lavender => [%expr CSS.lavender]
  | `Lavenderblush => [%expr CSS.lavenderblush]
  | `Lawngreen => [%expr CSS.lawngreen]
  | `Lemonchiffon => [%expr CSS.lemonchiffon]
  | `Lightblue => [%expr CSS.lightblue]
  | `Lightcoral => [%expr CSS.lightcoral]
  | `Lightcyan => [%expr CSS.lightcyan]
  | `Lightgoldenrodyellow => [%expr CSS.lightgoldenrodyellow]
  | `Lightgray => [%expr CSS.lightgray]
  | `Lightgreen => [%expr CSS.lightgreen]
  | `Lightgrey => [%expr CSS.lightgrey]
  | `Lightpink => [%expr CSS.lightpink]
  | `Lightsalmon => [%expr CSS.lightsalmon]
  | `Lightseagreen => [%expr CSS.lightseagreen]
  | `Lightskyblue => [%expr CSS.lightskyblue]
  | `Lightslategray => [%expr CSS.lightslategray]
  | `Lightslategrey => [%expr CSS.lightslategrey]
  | `Lightsteelblue => [%expr CSS.lightsteelblue]
  | `Lightyellow => [%expr CSS.lightyellow]
  | `Lime => [%expr CSS.lime]
  | `Limegreen => [%expr CSS.limegreen]
  | `Linen => [%expr CSS.linen]
  | `Magenta => [%expr CSS.magenta]
  | `Maroon => [%expr CSS.maroon]
  | `Mediumaquamarine => [%expr CSS.mediumaquamarine]
  | `Mediumblue => [%expr CSS.mediumblue]
  | `Mediumorchid => [%expr CSS.mediumorchid]
  | `Mediumpurple => [%expr CSS.mediumpurple]
  | `Mediumseagreen => [%expr CSS.mediumseagreen]
  | `Mediumslateblue => [%expr CSS.mediumslateblue]
  | `Mediumspringgreen => [%expr CSS.mediumspringgreen]
  | `Mediumturquoise => [%expr CSS.mediumturquoise]
  | `Mediumvioletred => [%expr CSS.mediumvioletred]
  | `Midnightblue => [%expr CSS.midnightblue]
  | `Mintcream => [%expr CSS.mintcream]
  | `Mistyrose => [%expr CSS.mistyrose]
  | `Moccasin => [%expr CSS.moccasin]
  | `Navajowhite => [%expr CSS.navajowhite]
  | `Navy => [%expr CSS.navy]
  | `Oldlace => [%expr CSS.oldlace]
  | `Olive => [%expr CSS.olive]
  | `Olivedrab => [%expr CSS.olivedrab]
  | `Orange => [%expr CSS.orange]
  | `Orangered => [%expr CSS.orangered]
  | `Orchid => [%expr CSS.orchid]
  | `Palegoldenrod => [%expr CSS.palegoldenrod]
  | `Palegreen => [%expr CSS.palegreen]
  | `Paleturquoise => [%expr CSS.paleturquoise]
  | `Palevioletred => [%expr CSS.palevioletred]
  | `Papayawhip => [%expr CSS.papayawhip]
  | `Peachpuff => [%expr CSS.peachpuff]
  | `Peru => [%expr CSS.peru]
  | `Pink => [%expr CSS.pink]
  | `Plum => [%expr CSS.plum]
  | `Powderblue => [%expr CSS.powderblue]
  | `Purple => [%expr CSS.purple]
  | `Rebeccapurple => [%expr CSS.rebeccapurple]
  | `Red => [%expr CSS.red]
  | `Rosybrown => [%expr CSS.rosybrown]
  | `Royalblue => [%expr CSS.royalblue]
  | `Saddlebrown => [%expr CSS.saddlebrown]
  | `Salmon => [%expr CSS.salmon]
  | `Sandybrown => [%expr CSS.sandybrown]
  | `Seagreen => [%expr CSS.seagreen]
  | `Seashell => [%expr CSS.seashell]
  | `Sienna => [%expr CSS.sienna]
  | `Silver => [%expr CSS.silver]
  | `Skyblue => [%expr CSS.skyblue]
  | `Slateblue => [%expr CSS.slateblue]
  | `Slategray => [%expr CSS.slategray]
  | `Slategrey => [%expr CSS.slategrey]
  | `Snow => [%expr CSS.snow]
  | `Springgreen => [%expr CSS.springgreen]
  | `Steelblue => [%expr CSS.steelblue]
  | `Tan => [%expr CSS.tan]
  | `Teal => [%expr CSS.teal]
  | `Thistle => [%expr CSS.thistle]
  | `Tomato => [%expr CSS.tomato]
  | `Turquoise => [%expr CSS.turquoise]
  | `Violet => [%expr CSS.violet]
  | `Wheat => [%expr CSS.wheat]
  | `White => [%expr CSS.white]
  | `Whitesmoke => [%expr CSS.whitesmoke]
  | `Yellow => [%expr CSS.yellow]
  | `Yellowgreen => [%expr CSS.yellowgreen]
  | _ => raise(Unsupported_feature);

let render_color_alpha = (~loc, color_alpha: Types.alpha_value) =>
  switch (color_alpha) {
  | `Number(number) => [%expr `num([%e render_float(~loc, number)])]
  | `Extended_percentage(`Percentage(pct)) =>
    render_percentage(~loc, pct /. 100.0)
  | `Extended_percentage(pct) => render_extended_percentage(~loc, pct)
  };

let render_function_rgb = (~loc, ast: Parser.Function_rgb.t) => {
  let color_to_float = v => render_integer(~loc, v |> Float.to_int);

  let to_number =
    fun
    // TODO: bs-css rgb(float, float, float)
    | `Percentage(pct) => color_to_float(pct *. 2.55)
    | `Function_calc(fc) => render_function_calc(~loc, fc)
    | `Interpolation(v) => render_variable(~loc, v)
    | `Extended_percentage(ext) => render_extended_percentage(~loc, ext)
    | `Function_min(values) => render_function_min(~loc, values)
    | `Function_max(values) => render_function_max(~loc, values);

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
    | _ => raise(Impossible_state)
    };

  let alpha =
    switch (alpha) {
    | Some(((), alpha)) => Some(alpha)
    | None => None
    };

  let alpha = Option.map(render_color_alpha(~loc), alpha);

  switch (alpha) {
  | Some(a) => [%expr `rgba(([%e red], [%e green], [%e blue], [%e a]))]
  | None => [%expr `rgb(([%e red], [%e green], [%e blue]))]
  };
};

let render_function_rgba = (~loc, ast: Parser.Function_rgba.t) => {
  let color_to_float = v => render_integer(~loc, v |> Float.to_int);

  let to_number =
    fun
    // TODO: bs-css rgb(float, float, float)
    | `Percentage(pct) => color_to_float(pct *. 2.55)
    | `Function_calc(fc) => render_function_calc(~loc, fc)
    | `Interpolation(v) => render_variable(~loc, v)
    | `Extended_percentage(ext) => render_extended_percentage(~loc, ext)
    | `Function_min(values) => render_function_min(~loc, values)
    | `Function_max(values) => render_function_max(~loc, values);

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
    | _ => raise(Impossible_state)
    };

  let alpha =
    switch (alpha) {
    | Some(((), alpha)) => Some(alpha)
    | None => None
    };

  let alpha = Option.map(render_color_alpha(~loc), alpha);

  switch (alpha) {
  | Some(a) => [%expr `rgba(([%e red], [%e green], [%e blue], [%e a]))]
  | None => [%expr `rgb(([%e red], [%e green], [%e blue]))]
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
  | Some(alpha) => [%expr
     `hsla(([%e hue], [%e saturation], [%e lightness], [%e alpha]))
    ]
  | None => [%expr `hsl(([%e hue], [%e saturation], [%e lightness]))]
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
  | Some(alpha) => [%expr
     `hsla(([%e hue], [%e saturation], [%e lightness], [%e alpha]))
    ]
  | None => [%expr `hsl(([%e hue], [%e saturation], [%e lightness]))]
  };
};

let render_var = (~loc, string) => {
  let string = render_string(~loc, string);
  [%expr `var([%e string])];
};

let rec render_color = (~loc, value: Types.color) =>
  switch (value) {
  | `Interpolation(v) => render_variable(~loc, v)
  | `Hex_color(hex) => [%expr `hex([%e render_string(~loc, hex)])]
  | `Named_color(color) => render_named_color(~loc, color)
  | `CurrentColor => [%expr `currentColor]
  | `Function_color_mix(color_mix) =>
    render_function_color_mix(~loc, color_mix)
  | `Function_rgb(rgb) => render_function_rgb(~loc, rgb)
  | `Function_rgba(rgba) => render_function_rgba(~loc, rgba)
  | `Function_var(v) => render_var(~loc, v)
  | `Function_hsl(hsl) =>
    switch (hsl) {
    | `Hsl_0(hue, sat, light, alpha) =>
      render_function_hsl(~loc, (hue, sat, light, alpha))
    | _ => raise(Unsupported_feature)
    }
  | `Function_hsla(hsla_obj) =>
    switch (hsla_obj) {
    | `Hsla_0(hue, sat, light, alpha) =>
      render_function_hsla(~loc, (hue, sat, light, alpha))
    | _ => raise(Unsupported_feature)
    }
  | `Deprecated_system_color(_) => raise(Unsupported_feature)
  }

and render_function_color_mix = (~loc, value: Types.function_color_mix) => {
  let render_rectangular_color_space = (x: Types.rectangular_color_space) => {
    switch (x) {
    | `Srgb => [%expr `srgb]
    | `Srgb_linear => [%expr `srgbLinear]
    | `Display_p3 => [%expr `displayP3]
    | `A98_rgb => [%expr `a98Rgb]
    | `Prophoto_rgb => [%expr `prophotoRgb]
    | `Rec2020 => [%expr `rec2020]
    | `Lab => [%expr `lab]
    | `Oklab => [%expr `oklab]
    | `Xyz => [%expr `xyz]
    | `Xyz_d50 => [%expr `xyzD50]
    | `Xyz_d65 => [%expr `xyzD65]
    };
  };
  let render_polar_color_space = (x: Types.polar_color_space) => {
    switch (x) {
    | `Hsl => [%expr `hsl]
    | `Hwb => [%expr `hwb]
    | `Lch => [%expr `lch]
    | `Oklch => [%expr `oklch]
    };
  };

  let render_hue_size = size =>
    switch (size) {
    | `Shorter => [%expr `shorter]
    | `Longer => [%expr `longer]
    | `Increasing => [%expr `increasing]
    | `Decreasing => [%expr `decreasing]
    };

  let (color_interpolation_method, (), color_x, (), color_y) = value;
  let ((), color_space_variant) = color_interpolation_method;

  let color_interpolation_method_expr =
    switch (color_space_variant) {
    | `Rectangular_color_space(x) => render_rectangular_color_space(x)
    | `Static(pcs, None) => render_polar_color_space(pcs)
    | `Static(pcs, Some((size, ()))) => [%expr
       `polar_with_hue((
         [%e render_polar_color_space(pcs)],
         [%e render_hue_size(size)],
       ))
      ]
    };

  let render_color_with_percentage = (~loc, (color, percentage)) => {
    switch (percentage) {
    | Some(percentage) => [%expr
       (
         [%e render_color(~loc, color)],
         Some([%e render_percentage(~loc, percentage)]),
       )
      ]
    | None => [%expr ([%e render_color(~loc, color)], None)]
    };
  };

  [%expr
   `colorMix((
     [%e color_interpolation_method_expr],
     [%e render_color_with_percentage(~loc, color_x)],
     [%e render_color_with_percentage(~loc, color_y)],
   ))
  ];
};

let color =
  monomorphic(
    Parser.Property_color.rule,
    (~loc) => [%expr CSS.color],
    (~loc, v) => render_color(~loc, v),
  );

let opacity =
  monomorphic(
    Parser.Property_opacity.rule,
    (~loc) => [%expr CSS.opacity],
    (~loc, v: Types.property_opacity) => {
      switch (v) {
      | `Number(number) => render_float(~loc, number)
      | `Extended_percentage(`Percentage(number)) =>
        render_float(~loc, number /. 100.0)
      | `Extended_percentage(pct) => render_extended_percentage(~loc, pct)
      }
    },
  );

let render_position_one = (~loc) =>
  fun
  | `Center => variant_to_expression(~loc, `Center)
  | `Left => variant_to_expression(~loc, `Left)
  | `Right => variant_to_expression(~loc, `Right)
  | `Bottom => variant_to_expression(~loc, `Bottom)
  | `Top => variant_to_expression(~loc, `Top)
  | `Length_percentage(l) => render_length_percentage(~loc, l);

let render_position_two = (~loc, x, y) => [%expr
  `hv((
    [%e render_position_one(~loc, x)],
    [%e render_position_one(~loc, y)],
  ))
];

let render_position_four = (~loc, x, xo, y, yo) => [%expr
  `hvOffset((
    [%e render_position_one(~loc, x)],
    [%e render_position_one(~loc, xo)],
    [%e render_position_one(~loc, y)],
    [%e render_position_one(~loc, yo)],
  ))
];

// css-images-4
let render_position = (~loc, position: Parser.Position.t) => {
  switch (position) {
  | `Xor(x) => render_position_one(~loc, x)
  | `And_0(x, y) => render_position_two(~loc, x, y)
  | `Static(x, y) => render_position_two(~loc, x, y)
  | `And_1((x, xo), (y, yo)) =>
    render_position_four(
      ~loc,
      x,
      `Length_percentage(xo),
      y,
      `Length_percentage(yo),
    )
  };
};

let object_fit =
  variants(Parser.Property_object_fit.rule, (~loc) => [%expr CSS.objectFit]);

let object_position =
  monomorphic(
    Parser.Property_object_position.rule,
    (~loc) => [%expr CSS.objectPosition],
    (~loc, v: Parser.Property_object_position.t) => {
      switch (v) {
      | `Position(pos) => render_position(~loc, pos)
      | `Inherit => [%expr `inherit_]
      | `Initial => [%expr `initial]
      | `Unset => [%expr `unset]
      | `Revert => [%expr `revert]
      | `Revert_layer => [%expr `revertLayer]
      }
    },
  );

let pointer_events =
  monomorphic(
    Parser.Property_pointer_events.rule,
    (~loc) => [%expr CSS.pointerEvents],
    (~loc, value: Parser.Property_pointer_events.t) => {
      switch (value) {
      | `Auto => [%expr `auto]
      | `None => [%expr `none]
      | `VisiblePainted => [%expr `visiblePainted]
      | `VisibleFill => [%expr `visibleFill]
      | `VisibleStroke => [%expr `visibleStroke]
      | `Visible => [%expr `visible]
      | `Painted => [%expr `painted]
      | `Fill => [%expr `fill]
      | `Stroke => [%expr `stroke]
      | `All => [%expr `all]
      | `Inherit => [%expr `inherit_]
      }
    },
  );

let image_resolution =
  unsupportedProperty(Parser.Property_image_resolution.rule);

let image_orientation =
  unsupportedProperty(Parser.Property_image_orientation.rule);

let image_rendering =
  variants(Parser.Property_image_rendering.rule, (~loc) =>
    [%expr CSS.imageRendering]
  );

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
        | _ => raise(Impossible_state)
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
        Builder.pexp_construct(
          ~loc,
          {
            txt: Lident("true"),
            loc,
          },
          None,
        ),
      inset,
    );

  let args =
    Ppxlib.Asttypes.[
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

  Builder.pexp_apply(~loc, [%expr CSS.BoxShadow.box], args);
};

let background_color =
  monomorphic(
    Parser.Property_background_color.rule,
    (~loc) => [%expr CSS.backgroundColor],
    (~loc, v) => render_color(~loc, v),
  );

let _render_color_stop_length = (~loc, value: Types.color_stop_length) => {
  switch (value) {
  | `Extended_length(l) => render_extended_length(~loc, l)
  | `Extended_percentage(p) => render_extended_percentage(~loc, p)
  };
};

let render_color_stop_angle = (~loc, value: Types.color_stop_angle) => {
  /* color_stop_angle is [ <extended-angle> ]{1,2} - a list of 1 or 2 angles */
  switch (value) {
  | [a] => render_extended_angle(~loc, a)
  | [a, _b] => render_extended_angle(~loc, a) /* TODO: handle second angle */
  | _ => raise(Invalid_value("color_stop_angle expects 1 or 2 angles"))
  };
};

let render_angular_color_stop = (~loc, value: Types.angular_color_stop) => {
  let (color, angle_opt) = value;
  let color = render_color(~loc, color);
  switch (angle_opt) {
  | None => [%expr ([%e color], None)]
  | Some(angle) =>
    let angle = render_color_stop_angle(~loc, angle);
    [%expr ([%e color], Some([%e angle]))];
  };
};

let render_color_stop_list = (~loc, value: Types.color_stop_list) => {
  value
  |> List.map(stop =>
       switch (stop) {
       | `Static_0(None, length_percentage) =>
         let length = render_length_percentage(~loc, length_percentage);
         [%expr (None, Some([%e length]))];
       | `Static_0(Some(color), length_percentage) =>
         let length = render_length_percentage(~loc, length_percentage);
         let color = render_color(~loc, color);
         [%expr (Some([%e color]), Some([%e length]))];
       | `Static_1(color, None) =>
         let color = render_color(~loc, color);
         [%expr (Some([%e color]), None)];
       | `Static_1(color, Some(length_percentage)) =>
         let length = render_length_percentage(~loc, length_percentage);
         let color = render_color(~loc, color);
         [%expr (Some([%e color]), Some([%e length]))];
       }
     )
  |> Builder.pexp_array(~loc);
};

let render_angular_color_hint = (~loc, value: Types.angular_color_hint) => {
  switch (value) {
  | `Extended_angle(a) => render_extended_angle(~loc, a)
  | `Extended_percentage(pct) => render_extended_percentage(~loc, pct)
  };
};

let render_angular_color_stop_list =
    (~loc, value: Types.angular_color_stop_list) => {
  let (rest_of_stops, _unit, last_stop) = value;
  let stops =
    rest_of_stops
    |> List.map(((stop, hint_opt)) => {
         let stop = render_angular_color_stop(~loc, stop);
         switch (hint_opt) {
         | None => [%expr ([%e stop], None)]
         | Some((_unit, color_hint)) =>
           let color_hint = render_angular_color_hint(~loc, color_hint);
           [%expr ([%e stop], Some([%e color_hint]))];
         };
       })
    |> List.append([render_angular_color_stop(~loc, last_stop)]);
  Builder.pexp_array(~loc, stops);
};

let render_function_linear_gradient =
    (~loc, value: Types.function_linear_gradient) => {
  let (direction_opt, stops) = value;
  switch (direction_opt) {
  | None => [%expr
     `linearGradient((
       None,
       [%e render_color_stop_list(~loc, stops)]: CSS.Types.Gradient.color_stop_list,
     ))
    ]
  | Some(`Static_0(angle, ())) => [%expr
     `linearGradient((
       Some([%e render_extended_angle(~loc, angle)]),
       [%e render_color_stop_list(~loc, stops)]: CSS.Types.Gradient.color_stop_list,
     ))
    ]
  | Some(`Static_1((), side_or_corner, ())) => [%expr
     `linearGradient((
       Some([%e render_side_or_corner(~loc, side_or_corner)]),
       [%e render_color_stop_list(~loc, stops)]: CSS.Types.Gradient.color_stop_list,
     ))
    ]
  };
};

let render_function_repeating_linear_gradient =
    (~loc, value: Types.function_repeating_linear_gradient) => {
  switch (value) {
  | (Some(`Extended_angle(angle)), (), stops) => [%expr
     `repeatingLinearGradient((
       Some([%e render_extended_angle(~loc, angle)]),
       [%e render_color_stop_list(~loc, stops)]: CSS.Types.Gradient.color_stop_list,
     ))
    ]
  | (None, (), stops) => [%expr
     `repeatingLinearGradient((
       None,
       [%e render_color_stop_list(~loc, stops)]: CSS.Types.Gradient.color_stop_list,
     ))
    ]
  | (Some(`Static((), _side_or_corner)), (), _stops) =>
    raise(Unsupported_feature)
  };
};

let render_eding_shape = (~loc, value) => {
  switch (value) {
  | Some(`Circle) => [%expr Some(`circle)]
  | Some(`Ellipse) => [%expr Some(`ellipse)]
  | None => [%expr Some(`ellipse)]
  };
};

let render_radial_size = (~loc, value: Types.radial_size) => {
  switch (value) {
  | `Extended_length(l) => render_extended_length(~loc, l)
  | `Farthest_side => [%expr `farthestSide]
  | `Closest_side => [%expr `closestSide]
  | `Closest_corner => [%expr `closestCorner]
  | `Farthest_corner => [%expr `farthestCorner]
  | `Xor(_) => raise(Unsupported_feature)
  };
};

let render_function_radial_gradient =
    (~loc, value: Types.function_radial_gradient) => {
  switch (value) {
  | (shape, None, None, None | Some (), color_stop_list) =>
    let shape = render_eding_shape(~loc, shape);
    [%expr
     `radialGradient((
       [%e shape],
       None,
       None,
       [%e render_color_stop_list(~loc, color_stop_list)]: CSS.Types.Gradient.color_stop_list,
     ))
    ];
  | (shape, Some(radial_size), None, None | Some (), color_stop_list) =>
    let shape = render_eding_shape(~loc, shape);
    let size = render_radial_size(~loc, radial_size);
    [%expr
     `radialGradient((
       [%e shape],
       Some([%e size]),
       None,
       [%e render_color_stop_list(~loc, color_stop_list)]: CSS.Types.Gradient.color_stop_list,
     ))
    ];
  | (shape, None, Some(((), position)), None | Some (), color_stop_list) =>
    let shape = render_eding_shape(~loc, shape);
    let position = render_position(~loc, position);
    [%expr
     `radialGradient((
       [%e shape],
       None,
       Some([%e position]),
       [%e render_color_stop_list(~loc, color_stop_list)]: CSS.Types.Gradient.color_stop_list,
     ))
    ];
  | (
      shape,
      Some(radial_size),
      Some(((), position)),
      None | Some (),
      color_stop_list,
    ) =>
    let shape = render_eding_shape(~loc, shape);
    let size = render_radial_size(~loc, radial_size);
    let position = render_position(~loc, position);
    [%expr
     `radialGradient((
       [%e shape],
       Some([%e size]),
       Some([%e position]),
       [%e render_color_stop_list(~loc, color_stop_list)]: CSS.Types.Gradient.color_stop_list,
     ))
    ];
  };
};

let render_function_repeating_radial_gradient =
    (~loc, value: Types.function_repeating_radial_gradient) => {
  switch (value) {
  | (None, None, (), stops) => [%expr
     `radialGradient([%e render_color_stop_list(~loc, stops)])
    ]
  | _ => raise(Unsupported_feature)
  };
};

let render_function_conic_gradient =
    (~loc, value: Types.function_conic_gradient) => {
  switch (value) {
  | (None, None, (), stops) => [%expr
     `conicGradient([%e render_angular_color_stop_list(~loc, stops)])
    ]
  | _ => raise(Unsupported_feature)
  };
};

let render_gradient = (~loc, value: Parser.Gradient.t) =>
  switch (value) {
  | `Function_linear_gradient(lg) => render_function_linear_gradient(~loc, lg)
  | `Function_repeating_linear_gradient(rlg) =>
    render_function_repeating_linear_gradient(~loc, rlg)
  | `Function_radial_gradient(rg) => render_function_radial_gradient(~loc, rg)
  | `Function_repeating_radial_gradient(rrg) =>
    render_function_repeating_radial_gradient(~loc, rrg)
  | `Function_conic_gradient(angle) =>
    render_function_conic_gradient(~loc, angle)
  | `Legacy_gradient(_) => raise(Unsupported_feature)
  };

let render_url_no_interp = (~loc, url) => [%expr
  `url([%e render_string(~loc, url)])
];

let render_url = (~loc, url: Types.url) => {
  switch (url) {
  | `Url(v) => [%expr `url([%e render_variable(~loc, v)])]
  | `Url_no_interp(v) => render_url_no_interp(~loc, v)
  };
};

let render_image = (~loc, value: Types.image) =>
  switch (value) {
  | `Gradient(gradient) => render_gradient(~loc, gradient)
  | `Url(url) => render_url(~loc, url)
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

let render_bg_images = (~loc, value: list(Parser.Bg_image.t)) => {
  value |> List.map(render_bg_image(~loc)) |> Builder.pexp_array(~loc);
};

let render_repeat_style = (~loc) =>
  fun
  | `Repeat_x => variant_to_expression(~loc, `Repeat_x)
  | `Repeat_y => variant_to_expression(~loc, `Repeat_y)
  | `Static(values) => {
      let render_xor = (
        fun
        | `Repeat => [%expr `repeat]
        | `Space => [%expr `space]
        | `Round => [%expr `round]
        | `No_repeat => [%expr `noRepeat]
      );

      switch (values) {
      | (x, None) => [%expr [%e render_xor(x)]]
      | (x, Some(y)) => [%expr
         `hv(([%e render_xor(x)], [%e render_xor(y)]))
        ]
      };
    };

let render_attachment = (~loc) =>
  fun
  | `Fixed => [%expr `fixed]
  | `Local => [%expr `local]
  | `Scroll => [%expr `scroll];

let background_image =
  polymorphic(Parser.Property_background_image.rule, (~loc) =>
    fun
    | [one] => [
        [%expr CSS.backgroundImage([%e render_bg_image(~loc, one)])],
      ]
    | more => [
        [%expr CSS.backgroundImages([%e render_bg_images(~loc, more)])],
      ]
  );

let background_repeat =
  polymorphic(Parser.Property_background_repeat.rule, (~loc) =>
    fun
    | [one] => [
        [%expr CSS.backgroundRepeat([%e render_repeat_style(~loc, one)])],
      ]
    | more => [
        [%expr
          CSS.backgroundRepeats(
            [%e
              more
              |> List.map(x => render_repeat_style(~loc, x))
              |> Builder.pexp_array(~loc)
            ],
          )
        ],
      ]
  );

let background_attachment =
  monomorphic(
    Parser.Property_background_attachment.rule,
    (~loc) => [%expr CSS.backgroundAttachment],
    (~loc) =>
      fun
      | [] => raise(Impossible_state)
      | [v] => render_attachment(~loc, v)
      | _ => raise(Unsupported_feature),
  );

let render_bg_position_three_and_four = (~loc) =>
  fun
  | `Center => variant_to_expression(~loc, `Center)
  | `Static(v, None) => render_position_one(~loc, v)
  | `Static(z, Some(o)) => {
      let offset = render_length_percentage(~loc, o);
      switch (z) {
      | `Top => [%expr `topOffset([%e offset])]
      | `Bottom => [%expr `bottomOffset([%e offset])]
      | `Left => [%expr `leftOffset([%e offset])]
      | `Right => [%expr `rightOffset([%e offset])]
      };
    };

let render_bg_position = (~loc, position: Types.bg_position) => {
  switch (position) {
  | `Xor(x) => render_position_one(~loc, x)
  | `Static(x, y) => render_position_two(~loc, x, y)
  | `And(x, y) => [%expr
     `hvOffset((
       [%e render_bg_position_three_and_four(~loc, x)],
       [%e render_bg_position_three_and_four(~loc, y)],
     ))
    ]
  };
};

let background_position =
  polymorphic(Parser.Property_background_position.rule, (~loc) =>
    fun
    | [one] => [
        [%expr CSS.backgroundPosition([%e render_bg_position(~loc, one)])],
      ]
    | more => [
        [%expr
          CSS.backgroundPositions(
            [%e
              more
              |> List.map(x => render_bg_position(~loc, x))
              |> Builder.pexp_array(~loc)
            ],
          )
        ],
      ]
  );

let background_position_x =
  unsupportedProperty(Parser.Property_background_position_x.rule);

let background_position_y =
  unsupportedProperty(Parser.Property_background_position_y.rule);

let render_background_clip = (~loc) =>
  fun
  | `Box(b) => variant_to_expression(~loc, b)
  | `Text => variant_to_expression(~loc, `Text)
  | `Border_area => variant_to_expression(~loc, `Border_area);

let background_clip =
  polymorphic(Parser.Property_background_clip.rule, (~loc) =>
    fun
    | [one] => [
        [%expr CSS.backgroundClip([%e render_background_clip(~loc, one)])],
      ]
    | more => [
        [%expr
          CSS.backgroundClips(
            [%e
              more
              |> List.map(render_background_clip(~loc))
              |> Builder.pexp_array(~loc)
            ],
          )
        ],
      ]
  );

let background_origin =
  monomorphic(
    Parser.Property_background_origin.rule,
    (~loc) => [%expr CSS.backgroundOrigin],
    (~loc) =>
      fun
      | [] => raise(Impossible_state)
      | [v] => variant_to_expression(~loc, v)
      | _ => raise(Unsupported_feature),
  );

let background_size =
  monomorphic(
    Parser.Property_background_size.rule,
    (~loc) => [%expr CSS.backgroundSize],
    (~loc) =>
      fun
      | [] => raise(Impossible_state)
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
      render_layer(image, [%expr CSS.backgroundImage], render_bg_image(~loc)),
      render_layer(
        repeat_style,
        [%expr CSS.backgroundRepeat],
        render_repeat_style(~loc),
      ),
      render_layer(
        attachment,
        [%expr CSS.backgroundRepeat],
        render_attachment(~loc),
      ),
      render_layer(
        clip,
        [%expr CSS.backgroundClip],
        variant_to_expression(~loc),
      ),
      render_layer(
        origin,
        [%expr CSS.backgroundOrigin],
        variant_to_expression(~loc),
      ),
    ]
    @ (
      switch (position) {
      | Some((pos, Some(((), size)))) => [
          [
            [%expr
              CSS.backgroundPosition([%e render_bg_position(~loc, pos)])
            ],
          ],
          [[%expr CSS.backgroundSize([%e render_bg_size(~loc, size)])]],
        ]
      | Some((pos, None)) => [
          [
            [%expr
              CSS.backgroundPosition([%e render_bg_position(~loc, pos)])
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
      render_layer(color, [%expr CSS.backgroundColor], render_color(~loc)),
      render_layer(
        image,
        [%expr CSS.backgroundImage],
        render_bg_image(~loc),
      ),
      render_layer(
        repeat_style,
        [%expr CSS.backgroundRepeat],
        render_repeat_style(~loc),
      ),
      render_layer(
        attachment,
        [%expr CSS.backgroundRepeat],
        render_attachment(~loc),
      ),
      render_layer(
        clip,
        [%expr CSS.backgroundClip],
        variant_to_expression(~loc),
      ),
      render_layer(
        origin,
        [%expr CSS.backgroundOrigin],
        variant_to_expression(~loc),
      ),
    ]
    @ (
      switch (position) {
      | Some((pos, Some(((), size)))) => [
          [
            [%expr
              CSS.backgroundPosition([%e render_bg_position(~loc, pos)])
            ],
          ],
          [[%expr CSS.backgroundSize([%e render_bg_size(~loc, size)])]],
        ]
      | Some((pos, None)) => [
          [
            [%expr
              CSS.backgroundPosition([%e render_bg_position(~loc, pos)])
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
  polymorphic(Parser.Property_background.rule, render_background);

let border_top_color =
  monomorphic(
    Parser.Property_border_top_color.rule,
    (~loc) => [%expr CSS.borderTopColor],
    render_color,
  );

let border_right_color =
  monomorphic(
    Parser.Property_border_right_color.rule,
    (~loc) => [%expr CSS.borderRightColor],
    render_color,
  );

let border_bottom_color =
  monomorphic(
    Parser.Property_border_bottom_color.rule,
    (~loc) => [%expr CSS.borderBottomColor],
    render_color,
  );

let border_left_color =
  monomorphic(
    Parser.Property_border_left_color.rule,
    (~loc) => [%expr CSS.borderLeftColor],
    render_color,
  );

let border_color =
  monomorphic(
    Parser.Property_border_color.rule,
    (~loc) => [%expr CSS.borderColor],
    (~loc) =>
      fun
      | [c] => render_color(~loc, c)
      | _ => raise(Unsupported_feature),
  );

let border_top_style =
  variants(Parser.Property_border_top_style.rule, (~loc) =>
    [%expr CSS.borderTopStyle]
  );

let border_right_style =
  variants(Parser.Property_border_right_style.rule, (~loc) =>
    [%expr CSS.borderRightStyle]
  );

let border_bottom_style =
  variants(Parser.Property_border_bottom_style.rule, (~loc) =>
    [%expr CSS.borderBottomStyle]
  );

let border_left_style =
  variants(Parser.Property_border_left_style.rule, (~loc) =>
    [%expr CSS.borderLeftStyle]
  );

let border_style =
  monomorphic(
    Parser.Property_border_style.rule,
    (~loc) => [%expr CSS.borderStyle],
    variant_to_expression,
  );

let render_line_width = (~loc, value: Parser.Line_width.t) =>
  switch (value) {
  | `Extended_length(l) => render_extended_length(~loc, l)
  | `Thick => [%expr `thick]
  | `Medium => [%expr `medium]
  | `Thin => [%expr `thin]
  };

let border_top_width =
  monomorphic(
    Parser.Property_border_top_width.rule,
    (~loc) => [%expr CSS.borderTopWidth],
    render_line_width,
  );

let border_right_width =
  monomorphic(
    Parser.Property_border_right_width.rule,
    (~loc) => [%expr CSS.borderRightWidth],
    render_line_width,
  );

let border_bottom_width =
  monomorphic(
    Parser.Property_border_bottom_width.rule,
    (~loc) => [%expr CSS.borderBottomWidth],
    render_line_width,
  );

let border_left_width =
  monomorphic(
    Parser.Property_border_left_width.rule,
    (~loc) => [%expr CSS.borderLeftWidth],
    render_line_width,
  );

let border_width =
  monomorphic(
    Parser.Property_border_width.rule,
    (~loc) => [%expr CSS.borderWidth],
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
  | All => [%expr CSS.border]
  | Left => [%expr CSS.borderLeft]
  | Bottom => [%expr CSS.borderBottom]
  | Right => [%expr CSS.borderRight]
  | Top => [%expr CSS.borderTop];

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
    [[%expr CSS.unsafe([%e borderFn], {js|none|js})]];
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
  | `None => [[%expr CSS.unsafe({js|outline|js}, {js|none|js})]]
  | `Property_outline_width(`Interpolation(name)) => [
      [%expr CSS.outline([%e render_variable(~loc, name)])],
    ]
  /* bs-css doesn't support outline: 1px; */
  | `Property_outline_width(_) => raise(Unsupported_feature)
  /* bs-css doesn't support outline: 1px solid; */
  | `Static_0(_) => raise(Unsupported_feature)
  | `Static_1(line_width, style, color) => [
      [%expr
        CSS.outline(
          [%e render_line_width_interp(~loc, line_width)],
          [%e render_outline_style_interp(~loc, style)],
          [%e render_color_interp(~loc, color)],
        )
      ],
    ];

let outline = polymorphic(Parser.Property_outline.rule, render_outline);

let outline_color =
  monomorphic(
    Parser.Property_outline_color.rule,
    (~loc) => [%expr CSS.outlineColor],
    render_color,
  );

let outline_offset =
  monomorphic(
    Parser.Property_outline_offset.rule,
    (~loc) => [%expr CSS.outlineOffset],
    render_extended_length,
  );

let outline_style =
  monomorphic(
    Parser.Property_outline_style.rule,
    (~loc) => [%expr CSS.outlineStyle],
    render_outline_style_interp,
  );

let outline_width =
  monomorphic(
    Parser.Property_outline_width.rule,
    (~loc) => [%expr CSS.outlineWidth],
    render_line_width_interp,
  );

let vertical_align =
  monomorphic(
    Parser.Property_vertical_align.rule,
    (~loc) => [%expr CSS.verticalAlign],
    (~loc, value) => {
      switch (value) {
      | `Baseline => [%expr `baseline]
      | `Sub => [%expr `sub]
      | `Super => [%expr `super]
      | `Text_top => [%expr `textTop]
      | `Text_bottom => [%expr `textBottom]
      | `Middle => [%expr `middle]
      | `Top => [%expr `top]
      | `Bottom => [%expr `bottom]
      | `Extended_length(l) => render_extended_length(~loc, l)
      | `Extended_percentage(p) => render_extended_percentage(~loc, p)
      }
    },
  );

let border =
  polymorphic(Parser.Property_border.rule, render_border(~direction=All));

let border_top =
  polymorphic(Parser.Property_border.rule, render_border(~direction=Top));

let border_right =
  polymorphic(Parser.Property_border.rule, render_border(~direction=Right));

let border_bottom =
  polymorphic(Parser.Property_border.rule, render_border(~direction=Bottom));

let border_left =
  polymorphic(Parser.Property_border.rule, render_border(~direction=Left));

let render_border_radius_value = (~loc) =>
  fun
  | [`Extended_length(l)] => render_extended_length(~loc, l)
  | [`Extended_percentage(p)] => render_extended_percentage(~loc, p)
  | _ => raise(Unsupported_feature);

let border_top_left_radius =
  monomorphic(
    Parser.Property_border_top_left_radius.rule,
    (~loc) => [%expr CSS.borderTopLeftRadius],
    render_border_radius_value,
  );

let border_top_right_radius =
  monomorphic(
    Parser.Property_border_top_right_radius.rule,
    (~loc) => [%expr CSS.borderTopRightRadius],
    render_border_radius_value,
  );

let border_bottom_right_radius =
  monomorphic(
    Parser.Property_border_bottom_right_radius.rule,
    (~loc) => [%expr CSS.borderBottomRightRadius],
    render_border_radius_value,
  );

let border_bottom_left_radius =
  monomorphic(
    Parser.Property_border_bottom_left_radius.rule,
    (~loc) => [%expr CSS.borderBottomLeftRadius],
    render_border_radius_value,
  );

let border_radius =
  monomorphic(
    Parser.Property_border_radius.rule,
    (~loc) => [%expr CSS.borderRadius],
    render_length_percentage,
  );

let border_image_source =
  monomorphic(
    Parser.Property_border_image_source.rule,
    (~loc) => [%expr CSS.borderImageSource],
    (~loc, value) => {
      switch (value) {
      | `None => [%expr `none]
      | `Image(i) => render_image(~loc, i)
      }
    },
  );

let border_image_slice =
  unsupportedProperty(Parser.Property_border_image_slice.rule);

let border_image_width =
  unsupportedProperty(Parser.Property_border_image_width.rule);

let border_image_outset =
  unsupportedProperty(Parser.Property_border_image_outset.rule);

let border_image_repeat =
  unsupportedProperty(Parser.Property_border_image_repeat.rule);

let border_image = unsupportedProperty(Parser.Property_border_image.rule);

let box_shadow =
  polymorphic(
    Parser.Property_box_shadow.rule,
    (~loc, value: Parser.Property_box_shadow.t) =>
    switch (value) {
    | `Interpolation(variable) =>
      /* Here we rely on boxShadow*s* which makes the value be an array */
      let var = render_variable(~loc, variable);
      [[%expr CSS.boxShadows([%e var])]];
    | `None =>
      let none = variant_to_expression(~loc, `None);
      [[%expr CSS.boxShadow([%e none])]];
    | `Shadow(shadows) =>
      let shadows = shadows |> List.map(render_box_shadow(~loc));
      let shadows = Builder.pexp_array(~loc, shadows);
      [[%expr CSS.boxShadows([%e shadows])]];
    }
  );

// css-overflow-3
let overflow_x =
  monomorphic(
    Parser.Property_overflow_x.rule,
    (~loc) => [%expr CSS.overflowX],
    (~loc) =>
      fun
      | `Interpolation(x) => render_variable(~loc, x)
      | (`Visible | `Hidden | `Clip | `Scroll | `Auto) as x =>
        variant_to_expression(~loc, x),
  );

let overflow_y =
  monomorphic(
    Parser.Property_overflow_y.rule,
    (~loc) => [%expr CSS.overflowY],
    (~loc) =>
      fun
      | `Interpolation(x) => render_variable(~loc, x)
      | (`Visible | `Hidden | `Clip | `Scroll | `Auto) as x =>
        variant_to_expression(~loc, x),
  );

let overflow =
  polymorphic(Parser.Property_overflow.rule, (~loc) =>
    fun
    | `Interpolation(i) => [
        [%expr CSS.overflow([%e render_variable(~loc, i)])],
      ]
    | `Xor([x]) => [
        [%expr CSS.overflow([%e variant_to_expression(~loc, x)])],
      ]
    | `Xor(many) => {
        let overflows =
          many
          |> List.map(variant_to_expression(~loc))
          |> Builder.pexp_array(~loc);
        [[%expr CSS.overflows([%e overflows])]];
      }
    | `Non_standard_overflow(non_standard) => {
        switch (non_standard) {
        | `Moz_scrollbars_none => [
            [%expr CSS.unsafe("overflow", "-moz-scrollbars-none")],
          ]
        | `Moz_scrollbars_horizontal => [
            [%expr CSS.unsafe("overflow", "-moz-scrollbars-horizontal")],
          ]
        | `Moz_scrollbars_vertical => [
            [%expr CSS.unsafe("overflow", "-moz-scrollbars-vertical")],
          ]
        | _moz_hidden_unscrollable => [
            [%expr CSS.unsafe("overflow", "-moz-hidden-unscrollable")],
          ]
        };
      }
  );

let overflow_clip_margin =
  polymorphic(
    Parser.Property_overflow_clip_margin.rule,
    (~loc, (clipEdgeOrigin, margin)) => {
      let margin = Option.value(margin, ~default=`Length(`Px(0.)));
      [
        [%expr
          CSS.overflowClipMargin2(
            ~clipEdgeOrigin=?[%e
              render_option(~loc, variant_to_expression, clipEdgeOrigin)
            ],
            [%e render_extended_length(~loc, margin)],
          )
        ],
      ];
    },
  );

let overflow_block =
  monomorphic(
    Parser.Property_overflow_block.rule,
    (~loc) => [%expr CSS.overflowBlock],
    (~loc) =>
      fun
      | `Interpolation(x) => render_variable(~loc, x)
      | (`Visible | `Hidden | `Clip | `Scroll | `Auto) as x =>
        variant_to_expression(~loc, x),
  );

let overflow_inline =
  monomorphic(
    Parser.Property_overflow_inline.rule,
    (~loc) => [%expr CSS.overflowInline],
    (~loc) =>
      fun
      | `Interpolation(x) => render_variable(~loc, x)
      | (`Visible | `Hidden | `Clip | `Scroll | `Auto) as x =>
        variant_to_expression(~loc, x),
  );

let scrollbar_gutter =
  monomorphic(
    Parser.Property_scrollbar_gutter.rule,
    (~loc) => [%expr CSS.scrollbarGutter],
    (~loc, value: Parser.Property_scrollbar_gutter.t) => {
      switch (value) {
      | `Auto => [%expr `auto]
      | `And(_, None) => [%expr `stable]
      | `And(_, Some(_)) => [%expr `stableBothEdges]
      }
    },
  );

let text_overflow =
  monomorphic(
    Parser.Property_text_overflow.rule,
    (~loc) => [%expr CSS.textOverflow],
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
// let block_ellipsis = unsupportedProperty(Parser.Property_block_ellipsis.rule);

let max_lines = unsupportedProperty(Parser.Property_max_lines.rule);
// let continue = unsupportedProperty(Parser.Property_continue.rule);

// css-text-3
let text_transform =
  variants(Parser.Property_text_transform.rule, (~loc) =>
    [%expr CSS.textTransform]
  );

let white_space =
  variants(Parser.Property_white_space.rule, (~loc) =>
    [%expr CSS.whiteSpace]
  );

let render_tab_size = (~loc, value: Parser.Property_tab_size.t) => {
  switch (value) {
  | `Number(n) =>
    int_of_float(n) < 0
      ? raise(
          Invalid_value("Property 'tab-size' value can't be less than 0."),
        )
      : [%expr `num([%e render_float(~loc, n)])]
  | `Extended_length(ext) => render_extended_length(~loc, ext)
  };
};

let tab_size =
  monomorphic(
    Parser.Property_tab_size.rule,
    (~loc) => [%expr CSS.tabSize],
    render_tab_size,
  );

let word_break =
  variants(Parser.Property_word_break.rule, (~loc) => [%expr CSS.wordBreak]);

let render_line_height = (~loc) =>
  fun
  | `Extended_length(ext) => render_extended_length(~loc, ext)
  | `Extended_percentage(ext) => render_extended_percentage(~loc, ext)
  | `Normal => variant_to_expression(~loc, `Normal)
  | `Number(float) => [%expr `abs([%e render_float(~loc, float)])];

let line_height =
  monomorphic(
    Parser.Property_line_height.rule,
    (~loc) => [%expr CSS.lineHeight],
    render_line_height,
  );

let line_height_step =
  monomorphic(
    Parser.Property_line_height_step.rule,
    (~loc) => [%expr CSS.lineHeightStep],
    render_extended_length,
  );

let hyphens =
  variants(Parser.Property_hyphens.rule, (~loc) => [%expr CSS.hyphens]);

let overflow_wrap =
  variants(Parser.Property_overflow_wrap.rule, (~loc) =>
    [%expr CSS.overflowWrap]
  );

let word_wrap =
  variants(Parser.Property_word_wrap.rule, (~loc) => [%expr CSS.wordWrap]);

let text_align =
  variants(Parser.Property_text_align.rule, (~loc) => [%expr CSS.textAlign]);

let text_align_all =
  variants(Parser.Property_text_align_all.rule, (~loc) =>
    [%expr CSS.textAlignAll]
  );

let text_align_last =
  variants(Parser.Property_text_align_last.rule, (~loc) =>
    [%expr CSS.textAlignLast]
  );

let text_justify =
  variants(Parser.Property_text_justify.rule, (~loc) =>
    [%expr CSS.textJustify]
  );

let word_spacing =
  monomorphic(
    Parser.Property_word_spacing.rule,
    (~loc) => [%expr CSS.wordSpacing],
    (~loc) =>
      fun
      | `Normal => variant_to_expression(~loc, `Normal)
      | `Extended_length(l) => render_extended_length(~loc, l)
      | `Extended_percentage(p) => render_extended_percentage(~loc, p),
  );

let letter_spacing =
  monomorphic(
    Parser.Property_word_spacing.rule,
    (~loc) => [%expr CSS.letterSpacing],
    (~loc) =>
      fun
      | `Normal => variant_to_expression(~loc, `Normal)
      | `Extended_length(l) => render_extended_length(~loc, l)
      | `Extended_percentage(p) => render_extended_percentage(~loc, p),
  );

let text_indent =
  monomorphic(
    Parser.Property_text_indent.rule,
    (~loc) => [%expr CSS.textIndent],
    (~loc) =>
      fun
      | (`Extended_length(l), None, None) => render_extended_length(~loc, l)
      | (`Extended_percentage(p), None, None) =>
        render_extended_percentage(~loc, p)
      | _ => raise(Unsupported_feature),
  );

let hanging_punctuation =
  unsupportedProperty(Parser.Property_hanging_punctuation.rule);

let render_generic_family = (~loc) =>
  fun
  | `Cursive => [%expr `cursive]
  | `Fantasy => [%expr `fantasy]
  | `Monospace => [%expr `monospace]
  | `Sans_serif => [%expr `sans_serif]
  | `Serif => [%expr `serif]
  | `System_ui => [%expr `system_ui]
  | `Ui_serif => [%expr `ui_serif]
  | `Ui_sans_serif => [%expr `ui_sans_serif]
  | `Ui_monospace => [%expr `ui_monospace]
  | `Ui_rounded => [%expr `ui_rounded]
  | `Emoji => [%expr `emoji]
  | `Math => [%expr `math]
  | `Fangsong => [%expr `fangsong]
  | `Apple_system => [%expr `apple_system];

let render_font_family = (~loc, value) =>
  switch (value) {
  | `Interpolation(v) => render_variable(~loc, v)
  | `Generic_family(v) => render_generic_family(~loc, v)
  | `Family_name(`String(str)) => [%expr
     `quoted([%e render_string(~loc, str)])
    ]
  | `Family_name(`Custom_ident(ident)) => [%expr
     `quoted([%e render_string(~loc, ident)])
    ]
  };

// css-fonts-4
let font_family =
  polymorphic(
    Parser.Property_font_family.rule,
    (~loc, value: Parser.Property_font_family.t) =>
    switch (value) {
    | `Interpolation(v) =>
      /* We need to add annotation since arrays can be mutable and the type isn't scoped enough */
      let annotation = [%type: array(CSS.Types.FontFamilyName.t)];
      [
        [%expr
          CSS.fontFamilies([%e render_variable(~loc, v)]: [%t annotation])
        ],
      ];
    | `Font_families(font_families) => [
        [%expr
          CSS.fontFamilies(
            [%e
              font_families
              |> List.map(render_font_family(~loc))
              |> Builder.pexp_array(~loc)
            ],
          )
        ],
      ]
    }
  );

let render_font_weight = (~loc) =>
  fun
  | `Interpolation(v) => render_variable(~loc, v)
  | `Bolder => variant_to_expression(~loc, `Bolder)
  | `Lighter => variant_to_expression(~loc, `Lighter)
  | `Font_weight_absolute(`Normal) => variant_to_expression(~loc, `Normal)
  | `Font_weight_absolute(`Bold) => variant_to_expression(~loc, `Bold)
  | `Font_weight_absolute(`Integer(num)) => [%expr
      `num([%e render_integer(~loc, num)])
    ];

let font_weight =
  monomorphic(
    Parser.Property_font_weight.rule,
    (~loc) => [%expr CSS.fontWeight],
    render_font_weight,
  );

let font_stretch = unsupportedProperty(Parser.Property_font_stretch.rule);

let render_font_style = (~loc) =>
  fun
  | `Normal => variant_to_expression(~loc, `Normal)
  | `Italic => variant_to_expression(~loc, `Italic)
  | `Oblique => variant_to_expression(~loc, `Oblique)
  | `Interpolation(v) => render_variable(~loc, v)
  | `Static(_) => raise(Unsupported_feature);

let font_style =
  monomorphic(
    Parser.Property_font_style.rule,
    (~loc) => [%expr CSS.fontStyle],
    render_font_style,
  );

/* bs-css does not support these variants */
let render_absolute_size = (~loc, value: Parser.Absolute_size.t) =>
  switch (value) {
  | `Large => [%expr `large]
  | `Medium => [%expr `medium]
  | `Small => [%expr `small]
  | `X_large => [%expr `x_large]
  | `X_small => [%expr `x_small]
  | `Xx_large => [%expr `xx_large]
  | `Xx_small => [%expr `xx_small]
  | `Xxx_large => [%expr `xxx_large]
  };

let render_relative_size = (~loc, value: Parser.Relative_size.t) =>
  switch (value) {
  | `Larger => [%expr `larger]
  | `Smaller => [%expr `smaller]
  };

let render_font_size = (~loc, value: Parser.Property_font_size.t) =>
  switch (value) {
  | `Absolute_size(size) => render_absolute_size(~loc, size)
  | `Relative_size(size) => render_relative_size(~loc, size)
  | `Extended_length(ext) => render_extended_length(~loc, ext)
  | `Extended_percentage(ext) => render_extended_percentage(~loc, ext)
  };

let font_size =
  monomorphic(
    Parser.Property_font_size.rule,
    (~loc) => [%expr CSS.fontSize],
    render_font_size,
  );

let font_size_adjust =
  unsupportedProperty(Parser.Property_font_size_adjust.rule);

let font = unsupportedProperty(Parser.Property_font.rule);

let font_synthesis_weight =
  variants(Parser.Property_font_synthesis_weight.rule, (~loc) =>
    [%expr CSS.fontSynthesisWeight]
  );

let font_synthesis_style =
  variants(Parser.Property_font_synthesis_style.rule, (~loc) =>
    [%expr CSS.fontSynthesisStyle]
  );

let font_synthesis_small_caps =
  variants(Parser.Property_font_synthesis_small_caps.rule, (~loc) =>
    [%expr CSS.fontSynthesisSmallCaps]
  );

let font_synthesis_position =
  variants(Parser.Property_font_synthesis_position.rule, (~loc) =>
    [%expr CSS.fontSynthesisPosition]
  );

let font_synthesis = unsupportedProperty(Parser.Property_font_synthesis.rule);

let font_kerning =
  variants(Parser.Property_font_kerning.rule, (~loc) =>
    [%expr CSS.fontKerning]
  );

let font_variant_ligatures =
  unsupportedProperty(Parser.Property_font_variant_ligatures.rule);

let font_variant_position =
  variants(Parser.Property_font_variant_position.rule, (~loc) =>
    [%expr CSS.fontVariantPosition]
  );

let font_variant_caps =
  variants(Parser.Property_font_variant_caps.rule, (~loc) =>
    [%expr CSS.fontVariantCaps]
  );

let font_variant_numeric =
  unsupportedProperty(Parser.Property_font_variant_numeric.rule);

let font_variant_alternates =
  unsupportedProperty(Parser.Property_font_variant_alternates.rule);

let font_variant_east_asian =
  unsupportedProperty(Parser.Property_font_variant_east_asian.rule);

let font_variant =
  polymorphic(Parser.Property_font_variant.rule, (~loc) =>
    fun
    | `None => [[%expr CSS.unsafe({|fontVariant|}, {|none|})]]
    | `Normal => [[%expr CSS.fontVariant(`normal)]]
    | `Small_caps => [[%expr CSS.fontVariant(`smallCaps)]]
    | _ => raise(Unsupported_feature)
  );

let font_feature_settings =
  unsupportedProperty(Parser.Property_font_feature_settings.rule);

let font_optical_sizing =
  variants(Parser.Property_font_optical_sizing.rule, (~loc) =>
    [%expr CSS.fontOpticalSizing]
  );

let font_variation_settings =
  unsupportedProperty(Parser.Property_font_variation_settings.rule);

let font_palette = unsupportedProperty(Parser.Property_font_palette.rule);

let font_variant_emoji =
  variants(Parser.Property_font_variant_emoji.rule, (~loc) =>
    [%expr CSS.fontVariantEmoji]
  );

let render_text_decoration_line = (~loc) =>
  fun
  | `Interpolation(v) => render_variable(~loc, v)
  | `None => [%expr `none]
  | `Or(underline, overline, lineThrough, blink) => [%expr
      CSS.Types.TextDecorationLine.Value.make(
        ~underline=?[%e
          render_option(~loc, (~loc, _) => [%expr true], underline)
        ],
        ~overline=?[%e
          render_option(~loc, (~loc, _) => [%expr true], overline)
        ],
        ~lineThrough=?[%e
          render_option(~loc, (~loc, _) => [%expr true], lineThrough)
        ],
        ~blink=?[%e render_option(~loc, (~loc, _) => [%expr true], blink)],
        (),
      )
    ];

// css-text-decor-3
let text_decoration_line =
  monomorphic(
    Parser.Property_text_decoration_line.rule,
    (~loc) => [%expr CSS.textDecorationLine],
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
  monomorphic(
    Parser.Property_text_decoration_style.rule,
    (~loc) => [%expr CSS.textDecorationStyle],
    render_text_decoration_style,
  );

let text_decoration_color =
  monomorphic(
    Parser.Property_text_decoration_color.rule,
    (~loc) => [%expr CSS.textDecorationColor],
    render_color,
  );

let render_text_decoration_thickness = (~loc) =>
  fun
  | `Auto => variant_to_expression(~loc, `Auto)
  | `From_font => variant_to_expression(~loc, `From_font)
  | `Extended_length(l) => render_extended_length(~loc, l)
  | `Extended_percentage(p) => render_extended_percentage(~loc, p);

let text_decoration_thickness =
  monomorphic(
    Parser.Property_text_decoration_thickness.rule,
    (~loc) => [%expr CSS.textDecorationThickness],
    render_text_decoration_thickness,
  );

let text_decoration =
  polymorphic(
    Parser.Property_text_decoration.rule,
    (~loc, (color, style, thickness, line)) =>
    [
      [%expr
        CSS.textDecorations(
          ~line=?[%e render_option(~loc, render_text_decoration_line, line)],
          ~thickness=?[%e
            render_option(~loc, render_text_decoration_thickness, thickness)
          ],
          ~style=?[%e
            render_option(~loc, render_text_decoration_style, style)
          ],
          ~color=?[%e render_option(~loc, render_color, color)],
          (),
        )
      ],
    ]
  );

let text_underline_position =
  unsupportedProperty(Parser.Property_text_underline_position.rule);

let text_underline_offset =
  unsupportedProperty(Parser.Property_text_underline_offset.rule);

let text_decoration_skip =
  unsupportedProperty(Parser.Property_text_decoration_skip.rule);

let text_decoration_skip_self =
  unsupportedProperty(Parser.Property_text_decoration_skip_self.rule);

let text_decoration_skip_box =
  variants(Parser.Property_text_decoration_skip_box.rule, (~loc) =>
    [%expr CSS.textDecorationSkipBox]
  );

let text_decoration_skip_inset =
  variants(Parser.Property_text_decoration_skip_inset.rule, (~loc) =>
    [%expr CSS.textDecorationSkipInset]
  );

let text_decoration_skip_spaces =
  unsupportedProperty(Parser.Property_text_decoration_skip_spaces.rule);

let text_decoration_skip_ink =
  variants(Parser.Property_text_decoration_skip_ink.rule, (~loc) =>
    [%expr CSS.textDecorationSkipInk]
  );

let text_emphasis_style =
  polymorphic(
    Parser.Property_text_emphasis_style.rule,
    (~loc, value) => {
      let render_filled_or_open = (~loc) => {
        fun
        | `Filled => [%expr `filled]
        | `Open => [%expr `open_];
      };

      let render_shape = (~loc) => {
        fun
        | `Dot => [%expr `dot]
        | `Circle => [%expr `circle]
        | `Double_circle => [%expr `double_circle]
        | `Triangle => [%expr `triangle]
        | `Sesame => [%expr `sesame];
      };

      switch (value) {
      | `Or(Some(x), None) => [
          [%expr CSS.textEmphasisStyle([%e render_filled_or_open(~loc, x)])],
        ]
      | `Or(None, Some(y)) => [
          [%expr CSS.textEmphasisStyle([%e render_shape(~loc, y)])],
        ]
      | `Or(Some(x), Some(y)) => [
          [%expr
            CSS.textEmphasisStyles(
              [%e render_filled_or_open(~loc, x)],
              [%e render_shape(~loc, y)],
            )
          ],
        ]
      | `Or(None, None)
      | `None => [[%expr CSS.textEmphasisStyle(`none)]]
      | `String(str) => [
          [%expr
            CSS.textEmphasisStyle(`string([%e render_string(~loc, str)]))
          ],
        ]
      };
    },
  );

let text_emphasis_color =
  monomorphic(
    Parser.Property_text_emphasis_color.rule,
    (~loc) => [%expr CSS.textEmphasisColor],
    render_color,
  );

let text_emphasis = unsupportedProperty(Parser.Property_text_emphasis.rule);

let text_emphasis_position =
  polymorphic(
    Parser.Property_text_emphasis_position.rule,
    (~loc, value) => {
      let render_position_left_right = (~loc) => {
        fun
        | `Left => [%expr `left]
        | `Right => [%expr `right];
      };

      let render_over_or_under = (~loc) => {
        fun
        | `Over => [%expr `over]
        | `Under => [%expr `under];
      };

      switch (value) {
      | (y, None) => [
          [%expr
            CSS.textEmphasisPosition([%e render_over_or_under(~loc, y)])
          ],
        ]
      | (y, Some(position)) => [
          [%expr
            CSS.textEmphasisPositions(
              [%e render_over_or_under(~loc, y)],
              [%e render_position_left_right(~loc, position)],
            )
          ],
        ]
      };
    },
  );

// let text_emphasis_skip = unsupportedProperty(Parser.Property_text_emphasis_skip.rule);

let render_text_shadow = (~loc, shadow) => {
  let (x, y, blur, color) =
    switch (shadow) {
    | ([x, y], None) => (x, y, None, None)
    | ([x, y, blur], None) => (x, y, Some(blur), None)
    | ([x, y, blur], color) => (x, y, Some(blur), color)
    | _ => raise(Impossible_state)
    };

  let args =
    Ppxlib.Asttypes.[
      (Labelled("x"), Some(render_length_interp(~loc, x))),
      (Labelled("y"), Some(render_length_interp(~loc, y))),
      (Labelled("blur"), Option.map(render_length_interp(~loc), blur)),
      (
        Nolabel,
        Some(
          color
          |> Option.map(render_color_interp(~loc))
          |> Option.value(~default=[%expr `Color(`CurrentColor)]),
        ),
      ),
    ]
    |> List.filter_map(((label, value)) =>
         Option.map(value => (label, value), value)
       );

  Builder.pexp_apply(~loc, [%expr CSS.TextShadow.text], args);
};

let text_shadow =
  polymorphic(Parser.Property_text_shadow.rule, (~loc) =>
    fun
    | `Interpolation(variable) => [
        [%expr CSS.textShadows([%e render_variable(~loc, variable)])],
      ]
    | `None => [
        [%expr CSS.textShadow([%e variant_to_expression(~loc, `None)])],
      ]
    | `Shadow_t([shadow]) => [
        [%expr CSS.textShadow([%e render_text_shadow(~loc, shadow)])],
      ]
    | `Shadow_t(shadows) => {
        let shadows = shadows |> List.map(render_text_shadow(~loc));
        [[%expr CSS.textShadows([%e Builder.pexp_array(~loc, shadows)])]];
      }
  );

let render_transform_functions = (~loc, value) =>
  switch (value) {
  | `Zero(_) => [%expr `zero]
  | `Extended_angle(a) => [%expr [%e render_extended_angle(~loc, a)]]
  };

let render_transform = (~loc, value: Parser.Transform_function.t) =>
  switch (value) {
  | `Function_perspective(_) => raise(Unsupported_feature)
  | `Function_matrix(_) => raise(Unsupported_feature)
  | `Function_matrix3d(_) => raise(Unsupported_feature)
  | `Function_rotate(v) => [%expr
     CSS.rotate([%e render_transform_functions(~loc, v)])
    ]
  | `Function_rotate3d(x, (), y, (), z, (), a) => [%expr
     CSS.rotate3d(
       [%e render_float(~loc, x)],
       [%e render_float(~loc, y)],
       [%e render_float(~loc, z)],
       [%e render_transform_functions(~loc, a)],
     )
    ]
  | `Function_rotateX(v) => [%expr
     CSS.rotateX([%e render_transform_functions(~loc, v)])
    ]
  | `Function_rotateY(v) => [%expr
     CSS.rotateY([%e render_transform_functions(~loc, v)])
    ]
  | `Function_rotateZ(v) => [%expr
     CSS.rotateZ([%e render_transform_functions(~loc, v)])
    ]
  | `Function_skew(a1, a2) =>
    switch (a2) {
    | Some(((), v)) => [%expr
       CSS.skew(
         [%e render_transform_functions(~loc, a1)],
         [%e render_transform_functions(~loc, v)],
       )
      ]
    | None => [%expr
       CSS.skew([%e render_transform_functions(~loc, a1)], `deg(0.))
      ]
    }
  | `Function_skewX(v) => [%expr
     CSS.skewX([%e render_transform_functions(~loc, v)])
    ]
  | `Function_skewY(v) => [%expr
     CSS.skewY([%e render_transform_functions(~loc, v)])
    ]
  | `Function_translate(x, None) => [%expr
     CSS.translate([%e render_length_percentage(~loc, x)], `zero)
    ]
  | `Function_translate(x, Some(((), v))) => [%expr
     CSS.translate(
       [%e render_length_percentage(~loc, x)],
       [%e render_length_percentage(~loc, v)],
     )
    ]
  | `Function_translate3d(x, (), y, (), z) => [%expr
     CSS.translate3d(
       [%e render_length_percentage(~loc, x)],
       [%e render_length_percentage(~loc, y)],
       [%e render_extended_length(~loc, z)],
     )
    ]
  | `Function_translateX(x) => [%expr
     CSS.translateX([%e render_length_percentage(~loc, x)])
    ]
  | `Function_translateY(y) => [%expr
     CSS.translateY([%e render_length_percentage(~loc, y)])
    ]
  | `Function_translateZ(z) => [%expr
     CSS.translateZ([%e render_extended_length(~loc, z)])
    ]
  | `Function_scale(x, None) => [%expr
     CSS.scale([%e render_float(~loc, x)], [%e render_float(~loc, x)])
    ]
  | `Function_scale(x, Some(((), v))) => [%expr
     CSS.scale([%e render_float(~loc, x)], [%e render_float(~loc, v)])
    ]
  | `Function_scale3d(x, (), y, (), z) => [%expr
     CSS.scale3d(
       [%e render_float(~loc, x)],
       [%e render_float(~loc, y)],
       [%e render_float(~loc, z)],
     )
    ]
  | `Function_scaleX(x) => [%expr CSS.scaleX([%e render_float(~loc, x)])]
  | `Function_scaleY(y) => [%expr CSS.scaleY([%e render_float(~loc, y)])]
  | `Function_scaleZ(z) => [%expr CSS.scaleZ([%e render_float(~loc, z)])]
  };

// css-transforms-2
let transform =
  polymorphic(Parser.Property_transform.rule, (~loc) =>
    fun
    | `None => [[%expr CSS.transform(`none)]]
    | `Transform_list([one]) => [
        [%expr CSS.transform([%e render_transform(~loc, one)])],
      ]
    | `Transform_list(list) => {
        let transforms =
          List.map(render_transform(~loc), list) |> Builder.pexp_array(~loc);
        [[%expr CSS.transforms([%e transforms])]];
      }
  );

let render_transform_origin_3 = (~loc, x, y, z) => [%expr
  `hvOffset((
    [%e render_position_one(~loc, x)],
    [%e render_position_one(~loc, y)],
    [%e render_length(~loc, z)],
  ))
];

let transform_origin =
  monomorphic(
    Parser.Property_transform_origin.rule,
    (~loc) => [%expr CSS.transformOrigin],
    (~loc) =>
      fun
      | `Xor(x) => render_position_one(~loc, x)
      | `Static_0(h, v, None) => render_position_two(~loc, h, v)
      | `Static_1((h, v), None) => render_position_two(~loc, h, v)
      | `Static_0(h, v, Some(o)) => render_transform_origin_3(~loc, h, v, o)
      | `Static_1((h, v), Some(o)) =>
        render_transform_origin_3(~loc, h, v, o),
  );

let transform_box =
  variants(Parser.Property_transform_box.rule, (~loc) =>
    [%expr CSS.transformBox]
  );

let translate =
  polymorphic(Parser.Property_translate.rule, (~loc) =>
    fun
    | `None => [[%expr CSS.translateProperty(`none)]]
    | `Static(x, None) => [
        [%expr
          CSS.translateProperty([%e render_length_percentage(~loc, x)])
        ],
      ]
    | `Static(x, Some((y, None))) => [
        [%expr
          CSS.translateProperty2(
            [%e render_length_percentage(~loc, x)],
            [%e render_length_percentage(~loc, y)],
          )
        ],
      ]
    | `Static(x, Some((y, Some(z)))) => [
        [%expr
          CSS.translateProperty3(
            [%e render_length_percentage(~loc, x)],
            [%e render_length_percentage(~loc, y)],
            [%e render_length(~loc, z)],
          )
        ],
      ]
  );

let rotate =
  monomorphic(
    Parser.Property_rotate.rule,
    (~loc) => [%expr CSS.rotateProperty],
    (~loc) =>
      fun
      | `None => [%expr `none]
      | `Extended_angle(x) => [%expr
          `rotate([%e render_extended_angle(~loc, x)])
        ]
      | `And(`X, angle) => [%expr
          `rotateX([%e render_extended_angle(~loc, angle)])
        ]
      | `And(`Y, angle) => [%expr
          `rotateY([%e render_extended_angle(~loc, angle)])
        ]
      | `And(`Z, angle) => [%expr
          `rotateZ([%e render_extended_angle(~loc, angle)])
        ]
      | `And(`Number([x, y, z, ..._]), angle) => [%expr
          `rotate3d((
            [%e render_float(~loc, x)],
            [%e render_float(~loc, y)],
            [%e render_float(~loc, z)],
            [%e render_extended_angle(~loc, angle)],
          ))
        ]
      | `And(`Number(_), _angle) => raise(Impossible_state),
  );

let render_number_percentage = (~loc) =>
  fun
  | `Number(x) => [%expr `num([%e render_float(~loc, x)])]
  | `Extended_percentage(x) => render_extended_percentage(~loc, x);

let scale =
  polymorphic(Parser.Property_scale.rule, (~loc) =>
    fun
    | `None => [[%expr CSS.scaleProperty(`none)]]
    | `Number_percentage([x, y, z]) => [
        [%expr
          CSS.scaleProperty3(
            [%e render_number_percentage(~loc, x)],
            [%e render_number_percentage(~loc, y)],
            [%e render_number_percentage(~loc, z)],
          )
        ],
      ]
    | `Number_percentage([x, y]) => [
        [%expr
          CSS.scaleProperty2(
            [%e render_number_percentage(~loc, x)],
            [%e render_number_percentage(~loc, y)],
          )
        ],
      ]
    | `Number_percentage([x]) => [
        [%expr CSS.scaleProperty([%e render_number_percentage(~loc, x)])],
      ]
    | `Number_percentage(_) => raise(Impossible_state)
  );

let transform_style =
  monomorphic(
    Parser.Property_transform_style.rule,
    (~loc) => [%expr CSS.transformStyle],
    (~loc) =>
      fun
      | `Flat => variant_to_expression(~loc, `Flat)
      | `Preserve_3d => variant_to_expression(~loc, `Preserve_3d),
  );

let perspective =
  monomorphic(
    Parser.Property_perspective.rule,
    (~loc) => [%expr CSS.perspectiveProperty],
    (~loc) =>
      fun
      | `None => [%expr `none]
      | `Extended_length(x) => render_extended_length(~loc, x),
  );

let perspective_origin =
  monomorphic(
    Parser.Property_perspective_origin.rule,
    (~loc) => [%expr CSS.perspectiveOrigin],
    render_position,
  );

let backface_visibility =
  variants(Parser.Property_backface_visibility.rule, (~loc) =>
    [%expr CSS.backfaceVisibility]
  );

let render_single_transition_property_no_interp = (~loc) =>
  fun
  | `All => [%expr CSS.Types.TransitionProperty.all]
  | `Custom_ident(v) => [%expr
      CSS.Types.TransitionProperty.make([%e render_string(~loc, v)])
    ];

let render_single_transition_property = (~loc, value) => {
  switch (value) {
  | `Interpolation(v) => render_variable(~loc, v)
  | #Parser.Single_transition_property_no_interp.t as x =>
    render_single_transition_property_no_interp(~loc, x)
  };
};

// css-transition-1
let transition_property =
  polymorphic(Parser.Property_transition_property.rule, (~loc) =>
    fun
    | `None => [
        [%expr CSS.transitionProperty(CSS.Types.TransitionProperty.none)],
      ]
    | `Single_transition_property(transition_properties) => {
        let value =
          transition_properties
          |> List.map(render_single_transition_property(~loc))
          |> Builder.pexp_array(~loc);
        [[%expr CSS.transitionProperties([%e value])]];
      }
  );

let transition_duration =
  polymorphic(Parser.Property_transition_duration.rule, (~loc) =>
    fun
    | [one] => [
        [%expr CSS.transitionDuration([%e render_extended_time(~loc, one)])],
      ]
    | more => [
        [%expr
          CSS.transitionDurations(
            [%e
              more
              |> List.map(render_extended_time(~loc))
              |> Builder.pexp_array(~loc)
            ],
          )
        ],
      ]
  );

let widows =
  monomorphic(
    Parser.Property_widows.rule,
    (~loc) => [%expr CSS.widows],
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
        [%e render_float(~loc, p0)],
        [%e render_float(~loc, p1)],
        [%e render_float(~loc, p2)],
        [%e render_float(~loc, p3)],
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

let render_timing_no_interp = (~loc) =>
  fun
  | `Linear => [%expr `linear]
  | `Cubic_bezier_timing_function(v) =>
    render_cubic_bezier_timing_function(~loc, v)
  | `Step_timing_function(v) => render_steps_function(~loc, v);

let render_timing = (~loc) =>
  fun
  | #Parser.Timing_function_no_interp.t as x =>
    render_timing_no_interp(~loc, x)
  | `Interpolation(v) => render_variable(~loc, v);

let transition_timing_function =
  polymorphic(Parser.Property_transition_timing_function.rule, (~loc) =>
    fun
    | [one] => [
        [%expr CSS.transitionTimingFunction([%e render_timing(~loc, one)])],
      ]
    | many => [
        [%expr
          CSS.transitionTimingFunctions(
            [%e
              many
              |> List.map(render_timing(~loc))
              |> Builder.pexp_array(~loc)
            ],
          )
        ],
      ]
  );

let transition_delay =
  polymorphic(Parser.Property_transition_delay.rule, (~loc) =>
    fun
    | [one] => [
        [%expr CSS.transitionDelay([%e render_extended_time(~loc, one)])],
      ]
    | more => [
        [%expr
          CSS.transitionDelays(
            [%e
              more
              |> List.map(render_extended_time(~loc))
              |> Builder.pexp_array(~loc)
            ],
          )
        ],
      ]
  );

let render_transition_behavior_value_no_interp = (~loc) =>
  fun
  | `Normal => [%expr `normal]
  | `Allow_discrete => [%expr `allowDiscrete];

let render_transition_behavior_value = (~loc) =>
  fun
  | #Parser.Transition_behavior_value_no_interp.t as x =>
    render_transition_behavior_value_no_interp(~loc, x)
  | `Interpolation(v) => render_variable(~loc, v);

let transition_behavior =
  polymorphic(Parser.Property_transition_behavior.rule, (~loc) =>
    fun
    | [one] => [
        [%expr
          CSS.transitionBehavior(
            [%e render_transition_behavior_value(~loc, one)],
          )
        ],
      ]
    | more => [
        [%expr
          CSS.transitionBehaviors(
            [%e
              more
              |> List.map(render_transition_behavior_value(~loc))
              |> Builder.pexp_array(~loc)
            ],
          )
        ],
      ]
  );

let render_transition_property = (~loc) =>
  fun
  | `None => [%expr CSS.Types.TransitionProperty.none]
  | `Single_transition_property_no_interp(x) =>
    render_single_transition_property_no_interp(~loc, x)
  | `Single_transition_property(x) =>
    render_single_transition_property(~loc, x);

let render_single_transition = (~loc) =>
  fun
  | `Xor(property) => {
      [%expr
       CSS.Types.Transition.Value.make(
         ~property=[%e render_transition_property(~loc, property)],
         (),
       )
      ];
    }
  | `Static_0(property, duration) => {
      [%expr
       CSS.Types.Transition.Value.make(
         ~duration=[%e render_extended_time(~loc, duration)],
         ~property=[%e render_transition_property(~loc, property)],
         (),
       )
      ];
    }
  | `Static_1(property, duration, timingFunction) => {
      [%expr
       CSS.Types.Transition.Value.make(
         ~duration=[%e render_extended_time(~loc, duration)],
         ~timingFunction=[%e render_timing(~loc, timingFunction)],
         ~property=[%e render_transition_property(~loc, property)],
         (),
       )
      ];
    }
  | `Static_2(property, duration, timingFunction, delay) => {
      [%expr
       CSS.Types.Transition.Value.make(
         ~duration=[%e render_extended_time(~loc, duration)],
         ~delay=[%e render_extended_time(~loc, delay)],
         ~timingFunction=[%e render_timing(~loc, timingFunction)],
         ~property=[%e render_transition_property(~loc, property)],
         (),
       )
      ];
    }
  | `Static_3(property, duration, timingFunction, delay, behavior) => {
      [%expr
       CSS.Types.Transition.Value.make(
         ~behavior=[%e render_transition_behavior_value(~loc, behavior)],
         ~duration=[%e render_extended_time(~loc, duration)],
         ~delay=[%e render_extended_time(~loc, delay)],
         ~timingFunction=[%e render_timing(~loc, timingFunction)],
         ~property=[%e render_transition_property(~loc, property)],
         (),
       )
      ];
    };

let render_single_transition_no_interp =
    (
      ~loc,
      (property, delay, timingFunction, duration, behavior): Parser.Single_transition_no_interp.t,
    ) => {
  [%expr
   CSS.Types.Transition.Value.make(
     ~behavior=?[%e
       render_option(
         ~loc,
         render_transition_behavior_value_no_interp,
         behavior,
       )
     ],
     ~duration=?[%e
       render_option(~loc, render_extended_time_no_interp, duration)
     ],
     ~delay=?[%e render_option(~loc, render_extended_time_no_interp, delay)],
     ~timingFunction=?[%e
       render_option(~loc, render_timing_no_interp, timingFunction)
     ],
     ~property=?[%e
       render_option(~loc, render_transition_property, property)
     ],
     (),
   )
  ];
};

let transition =
  monomorphic(
    Parser.Property_transition.rule,
    (~loc) => [%expr CSS.transitions],
    (~loc, transitions) =>
      transitions
      |> List.map(
           fun
           | `Single_transition(x) => render_single_transition(~loc, x)
           | `Single_transition_no_interp(x) =>
             render_single_transition_no_interp(~loc, x),
         )
      |> Builder.pexp_array(~loc),
  );

let render_keyframes_name = (~loc) =>
  fun
  | `Custom_ident(label) => render_string(~loc, label)
  | `String(label) => render_string(~loc, label);

let render_animation_name = (~loc) =>
  fun
  | `None => [%expr CSS.Types.AnimationName.none]
  | `Keyframes_name(name) => {
      [%expr
       CSS.Types.AnimationName.make([%e render_keyframes_name(~loc, name)])
      ];
    }
  | `Interpolation(v) => render_variable(~loc, v);

// css-animation-1
let animation_name =
  polymorphic(Parser.Property_animation_name.rule, (~loc) =>
    fun
    | [one] => [
        [%expr CSS.animationName([%e render_animation_name(~loc, one)])],
      ]
    | more => [
        [%expr
          CSS.animationNames(
            [%e
              more
              |> List.map(render_animation_name(~loc))
              |> Builder.pexp_array(~loc)
            ],
          )
        ],
      ]
  );

let animation_duration =
  polymorphic(Parser.Property_animation_duration.rule, (~loc) =>
    fun
    | [one] => [
        [%expr CSS.animationDuration([%e render_extended_time(~loc, one)])],
      ]
    | more => [
        [%expr
          CSS.animationDurations(
            [%e
              more
              |> List.map(render_extended_time(~loc))
              |> Builder.pexp_array(~loc)
            ],
          )
        ],
      ]
  );

let animation_timing_function =
  polymorphic(Parser.Property_animation_timing_function.rule, (~loc) =>
    fun
    | [one] => [
        [%expr CSS.animationTimingFunction([%e render_timing(~loc, one)])],
      ]
    | more => [
        [%expr
          CSS.animationTimingFunctions(
            [%e
              more
              |> List.map(render_timing(~loc))
              |> Builder.pexp_array(~loc)
            ],
          )
        ],
      ]
  );

let render_single_animation_iteration_count_no_interp = (~loc) =>
  fun
  | `Infinite => [%expr `infinite]
  | `Number(n) => [%expr `count([%e render_float(~loc, n)])];

let render_single_animation_iteration_count = (~loc) =>
  fun
  | #Parser.Single_animation_iteration_count_no_interp.t as x =>
    render_single_animation_iteration_count_no_interp(~loc, x)
  | `Interpolation(v) => render_variable(~loc, v);

let animation_iteration_count =
  polymorphic(Parser.Property_animation_iteration_count.rule, (~loc) =>
    fun
    | [one] => [
        [%expr
          CSS.animationIterationCount(
            [%e render_single_animation_iteration_count(~loc, one)],
          )
        ],
      ]
    | more => [
        [%expr
          CSS.animationIterationCounts(
            [%e
              more
              |> List.map(render_single_animation_iteration_count(~loc))
              |> Builder.pexp_array(~loc)
            ],
          )
        ],
      ]
  );

let render_single_animation_direction_no_interp = (~loc) =>
  fun
  | `Normal => [%expr `normal]
  | `Reverse => [%expr `reverse]
  | `Alternate => [%expr `alternate]
  | `Alternate_reverse => [%expr `alternateReverse];

let render_single_animation_direction = (~loc) =>
  fun
  | #Parser.Single_animation_direction_no_interp.t as x =>
    render_single_animation_direction_no_interp(~loc, x)
  | `Interpolation(v) => render_variable(~loc, v);

let animation_direction =
  polymorphic(Parser.Property_animation_direction.rule, (~loc) =>
    fun
    | [one] => [
        [%expr
          CSS.animationDirection(
            [%e render_single_animation_direction(~loc, one)],
          )
        ],
      ]
    | more => [
        [%expr
          CSS.animationDirections(
            [%e
              more
              |> List.map(render_single_animation_direction(~loc))
              |> Builder.pexp_array(~loc)
            ],
          )
        ],
      ]
  );

let render_single_animation_play_state_no_interp = (~loc) =>
  fun
  | `Paused => [%expr `paused]
  | `Running => [%expr `running];

let render_single_animation_play_state = (~loc) =>
  fun
  | #Parser.Single_animation_play_state_no_interp.t as x =>
    render_single_animation_play_state_no_interp(~loc, x)
  | `Interpolation(v) => render_variable(~loc, v);

let animation_play_state =
  polymorphic(Parser.Property_animation_play_state.rule, (~loc) =>
    fun
    | [one] => [
        [%expr
          CSS.animationPlayState(
            [%e render_single_animation_play_state(~loc, one)],
          )
        ],
      ]
    | more => [
        [%expr
          CSS.animationPlayStates(
            [%e
              more
              |> List.map(render_single_animation_play_state(~loc))
              |> Builder.pexp_array(~loc)
            ],
          )
        ],
      ]
  );

let animation_delay =
  polymorphic(Parser.Property_animation_delay.rule, (~loc) =>
    fun
    | [one] => [
        [%expr CSS.animationDelay([%e render_extended_time(~loc, one)])],
      ]
    | more => [
        [%expr
          CSS.animationDelays(
            [%e
              more
              |> List.map(render_extended_time(~loc))
              |> Builder.pexp_array(~loc)
            ],
          )
        ],
      ]
  );

let render_single_animation_fill_mode_no_interp = (~loc) =>
  fun
  | `None => [%expr `none]
  | `Forwards => [%expr `forwards]
  | `Backwards => [%expr `backwards]
  | `Both => [%expr `both];

let render_single_animation_fill_mode = (~loc) =>
  fun
  | #Parser.Single_animation_fill_mode_no_interp.t as x =>
    render_single_animation_fill_mode_no_interp(~loc, x)
  | `Interpolation(v) => render_variable(~loc, v);

let animation_fill_mode =
  polymorphic(Parser.Property_animation_fill_mode.rule, (~loc) =>
    fun
    | [one] => [
        [%expr
          CSS.animationFillMode(
            [%e render_single_animation_fill_mode(~loc, one)],
          )
        ],
      ]
    | more => [
        [%expr
          CSS.animationFillModes(
            [%e
              more
              |> List.map(render_single_animation_fill_mode(~loc))
              |> Builder.pexp_array(~loc)
            ],
          )
        ],
      ]
  );

let render_single_animation = (~loc) =>
  fun
  | `Xor(name) => [%expr
      CSS.Types.Animation.Value.make(
        ~name=[%e render_animation_name(~loc, name)],
        (),
      )
    ]
  | `Static_0(name, duration) => [%expr
      CSS.Types.Animation.Value.make(
        ~name=[%e render_animation_name(~loc, name)],
        ~duration=[%e render_extended_time(~loc, duration)],
        (),
      )
    ]
  | `Static_1(name, duration, timingFunction) => [%expr
      CSS.Types.Animation.Value.make(
        ~name=[%e render_animation_name(~loc, name)],
        ~duration=[%e render_extended_time(~loc, duration)],
        ~timingFunction=[%e render_timing(~loc, timingFunction)],
        (),
      )
    ]
  | `Static_2(name, duration, timingFunction, delay) => [%expr
      CSS.Types.Animation.Value.make(
        ~name=[%e render_animation_name(~loc, name)],
        ~duration=[%e render_extended_time(~loc, duration)],
        ~timingFunction=[%e render_timing(~loc, timingFunction)],
        ~delay=[%e render_extended_time(~loc, delay)],
        (),
      )
    ]
  | `Static_3(name, duration, timingFunction, delay, iterationCount) => [%expr
      CSS.Types.Animation.Value.make(
        ~name=[%e render_animation_name(~loc, name)],
        ~duration=[%e render_extended_time(~loc, duration)],
        ~timingFunction=[%e render_timing(~loc, timingFunction)],
        ~delay=[%e render_extended_time(~loc, delay)],
        ~iterationCount=[%e
          render_single_animation_iteration_count(~loc, iterationCount)
        ],
        (),
      )
    ]
  | `Static_4(
      name,
      duration,
      timingFunction,
      delay,
      iterationCount,
      direction,
    ) => [%expr
      CSS.Types.Animation.Value.make(
        ~name=[%e render_animation_name(~loc, name)],
        ~duration=[%e render_extended_time(~loc, duration)],
        ~timingFunction=[%e render_timing(~loc, timingFunction)],
        ~delay=[%e render_extended_time(~loc, delay)],
        ~iterationCount=[%e
          render_single_animation_iteration_count(~loc, iterationCount)
        ],
        ~direction=[%e render_single_animation_direction(~loc, direction)],
        (),
      )
    ]

  | `Static_5(
      name,
      duration,
      timingFunction,
      delay,
      iterationCount,
      direction,
      fillMode,
    ) => [%expr
      CSS.Types.Animation.Value.make(
        ~name=[%e render_animation_name(~loc, name)],
        ~duration=[%e render_extended_time(~loc, duration)],
        ~timingFunction=[%e render_timing(~loc, timingFunction)],
        ~delay=[%e render_extended_time(~loc, delay)],
        ~iterationCount=[%e
          render_single_animation_iteration_count(~loc, iterationCount)
        ],
        ~direction=[%e render_single_animation_direction(~loc, direction)],
        ~fillMode=[%e render_single_animation_fill_mode(~loc, fillMode)],
        (),
      )
    ]
  | `Static_6(
      name,
      duration,
      timingFunction,
      delay,
      iterationCount,
      direction,
      fillMode,
      playState,
    ) => [%expr
      CSS.Types.Animation.Value.make(
        ~name=[%e render_animation_name(~loc, name)],
        ~duration=[%e render_extended_time(~loc, duration)],
        ~timingFunction=[%e render_timing(~loc, timingFunction)],
        ~delay=[%e render_extended_time(~loc, delay)],
        ~iterationCount=[%e
          render_single_animation_iteration_count(~loc, iterationCount)
        ],
        ~direction=[%e render_single_animation_direction(~loc, direction)],
        ~fillMode=[%e render_single_animation_fill_mode(~loc, fillMode)],
        ~playState=[%e render_single_animation_play_state(~loc, playState)],
        (),
      )
    ];

let render_single_animation_no_interp =
    (
      ~loc,
      (
        name,
        delay,
        timingFunction,
        duration,
        iterationCount,
        direction,
        fillMode,
        playState,
      ): Parser.Single_animation_no_interp.t,
    ) => {
  [%expr
   CSS.Types.Animation.Value.make(
     ~duration=?[%e
       render_option(~loc, render_extended_time_no_interp, duration)
     ],
     ~delay=?[%e render_option(~loc, render_extended_time_no_interp, delay)],
     ~direction=?[%e
       render_option(
         ~loc,
         render_single_animation_direction_no_interp,
         direction,
       )
     ],
     ~timingFunction=?[%e
       render_option(~loc, render_timing_no_interp, timingFunction)
     ],
     ~fillMode=?[%e
       render_option(
         ~loc,
         render_single_animation_fill_mode_no_interp,
         fillMode,
       )
     ],
     ~playState=?[%e
       render_option(
         ~loc,
         render_single_animation_play_state_no_interp,
         playState,
       )
     ],
     ~iterationCount=?[%e
       render_option(
         ~loc,
         render_single_animation_iteration_count_no_interp,
         iterationCount,
       )
     ],
     ~name=?[%e render_option(~loc, render_animation_name, name)],
     (),
   )
  ];
};

let animation =
  monomorphic(
    Parser.Property_animation.rule,
    (~loc) => [%expr CSS.animations],
    (~loc, animations) => {
      animations
      |> List.map(
           fun
           | `Single_animation(x) => render_single_animation(~loc, x)
           | `Single_animation_no_interp(x) =>
             render_single_animation_no_interp(~loc, x),
         )
      |> Builder.pexp_array(~loc)
    },
  );

let render_ratio = (~loc, value: Parser.Ratio.t) => {
  switch (value) {
  | `Number(n) => [%expr `num([%e render_float(~loc, n)])]
  | `Interpolation(v) => render_variable(~loc, v)
  | `Static(up, _, down) => [%expr
     `ratio((
       [%e render_integer(~loc, up)],
       [%e render_integer(~loc, down)],
     ))
    ]
  };
};

let aspect_ratio =
  monomorphic(
    Parser.Property_aspect_ratio.rule,
    (~loc) => [%expr CSS.aspectRatio],
    (~loc, value) => {
      switch (value) {
      | `Auto => [%expr `auto]
      | `Ratio(ratio) => render_ratio(~loc, ratio)
      }
    },
  );

// css-flexbox-1
let flex_direction =
  variants(Parser.Property_flex_direction.rule, (~loc) =>
    [%expr CSS.flexDirection]
  );

let flex_wrap =
  variants(Parser.Property_flex_wrap.rule, (~loc) => [%expr CSS.flexWrap]);

// https://drafts.csswg.org/css-flexbox-1/#flex-flow-property
let flex_flow =
  polymorphic(
    Parser.Property_flex_flow.rule,
    (~loc, (direction, wrap)) => {
      let direction =
        switch (direction) {
        | Some(value) => variant_to_expression(~loc, value)
        | None => [%expr None]
        };
      let wrap =
        switch (wrap) {
        | Some(value) => variant_to_expression(~loc, value)
        | None => [%expr None]
        };
      [[%expr CSS.flexFlow([%e direction], [%e wrap])]];
    },
  );

// TODO: this is safe?
let order =
  monomorphic(
    Parser.Property_order.rule,
    (~loc) => [%expr CSS.order],
    render_integer,
  );

let render_float_interp = (~loc, value) => {
  switch (value) {
  | `Number(n) => [%expr [%e render_float(~loc, n)]]
  | `Interpolation(v) => render_variable(~loc, v)
  };
};

let flex_grow =
  monomorphic(
    Parser.Property_flex_grow.rule,
    (~loc) => [%expr CSS.flexGrow],
    render_float_interp,
  );

let flex_shrink =
  monomorphic(
    Parser.Property_flex_shrink.rule,
    (~loc) => [%expr CSS.flexShrink],
    render_float_interp,
  );

let render_flex_basis = (~loc) =>
  fun
  | `Content => variant_to_expression(~loc, `Content)
  | `Property_width(value_width) => render_size(~loc, value_width)
  | `Interpolation(v) => render_variable(~loc, v);

let flex_basis =
  monomorphic(
    Parser.Property_flex_basis.rule,
    (~loc) => [%expr CSS.flexBasis],
    render_flex_basis,
  );

let flex =
  polymorphic(Parser.Property_flex.rule, (~loc, value) =>
    switch (value) {
    | `None => [[%expr CSS.flex1(`none)]]
    | `Interpolation(interp) => [
        [%expr CSS.flex1([%e render_variable(~loc, interp)])],
      ]
    | `Or(None, None) => [[%expr CSS.flex1(`none)]]
    | `Or(Some((grow, None)), None) => [
        [%expr CSS.flex1(`num([%e render_float_interp(~loc, grow)]))],
      ]
    | `Or(Some((grow, Some(shrink))), None) => [
        [%expr
          CSS.flex2(
            ~shrink=[%e render_float_interp(~loc, shrink)],
            [%e render_float_interp(~loc, grow)],
          )
        ],
      ]
    | `Or(Some((grow, None)), Some(basis)) => [
        [%expr
          CSS.flex2(
            ~basis=[%e render_flex_basis(~loc, basis)],
            [%e render_float_interp(~loc, grow)],
          )
        ],
      ]
    | `Or(Some((grow, Some(shrink))), Some(basis)) => [
        [%expr
          CSS.flex(
            [%e render_float_interp(~loc, grow)],
            [%e render_float_interp(~loc, shrink)],
            [%e render_flex_basis(~loc, basis)],
          )
        ],
      ]
    | `Or(None, Some(basis)) => [
        [%expr CSS.flexBasis([%e render_flex_basis(~loc, basis)])],
      ]
    }
  );

let render_content_position = (~loc, value: Parser.Content_position.t) => {
  switch (value) {
  | `Center => [%expr `center]
  | `Start => [%expr `start]
  | `End => [%expr `end_]
  | `Flex_start => [%expr `flexStart]
  | `Flex_end => [%expr `flexEnd]
  };
};

let render_self_position = (~loc, value: Parser.Self_position.t) => {
  switch (value) {
  | `Center => [%expr `center]
  | `Start => [%expr `start]
  | `End => [%expr `end_]
  | `Flex_start => [%expr `flexStart]
  | `Flex_end => [%expr `flexEnd]
  | `Self_start => [%expr `selfStart]
  | `Self_end => [%expr `selfEnd]
  };
};

let render_content_position_left_right = (~loc, value) => {
  switch (value) {
  | `Content_position(position) => render_content_position(~loc, position)
  | `Left => [%expr `left]
  | `Right => [%expr `right]
  };
};

let render_self_position_left_right = (~loc, value) => {
  switch (value) {
  | `Self_position(position) => render_self_position(~loc, position)
  | `Left => [%expr `left]
  | `Right => [%expr `right]
  };
};

let render_content_distribution = (~loc) =>
  fun
  | `Space_between => [%expr `spaceBetween]
  | `Space_around => [%expr `spaceAround]
  | `Space_evenly => [%expr `spaceEvenly]
  | `Stretch => [%expr `stretch];

let justify_content =
  monomorphic(
    Parser.Property_justify_content.rule,
    (~loc) => [%expr CSS.justifyContent],
    (~loc, value) => {
      switch (value) {
      | `Normal => [%expr `normal]
      | `Content_distribution(distribution) =>
        render_content_distribution(~loc, distribution)
      | `Static(None, position) => [%expr
         [%e render_content_position_left_right(~loc, position)]
        ]
      | `Static(Some(`Safe), position) => [%expr
         `safe([%e render_content_position_left_right(~loc, position)])
        ]
      | `Static(Some(`Unsafe), position) => [%expr
         `unsafe([%e render_content_position_left_right(~loc, position)])
        ]
      }
    },
  );

let render_legacy_alignment = (~loc, value) => {
  switch (value) {
  | `Left => [%expr `legacyLeft]
  | `Right => [%expr `legacyRight]
  | `Center => [%expr `legacyCenter]
  };
};

let render_baseline_position = (~loc, value) => {
  switch (value) {
  | None => [%expr `baseline]
  | Some(`First) => [%expr `firstBaseline]
  | Some(`Last) => [%expr `lastBaseline]
  };
};

let justify_items =
  monomorphic(
    Parser.Property_justify_items.rule,
    (~loc) => [%expr CSS.justifyItems],
    (~loc, value) => {
      switch (value) {
      | `Normal => [%expr `normal]
      | `Stretch => [%expr `stretch]
      | `Legacy => [%expr `legacy]
      | `And(_, alignment) => render_legacy_alignment(~loc, alignment)
      | `Static(None, position) => [%expr
         [%e render_self_position_left_right(~loc, position)]
        ]
      | `Static(Some(`Safe), position) => [%expr
         `safe([%e render_self_position_left_right(~loc, position)])
        ]
      | `Static(Some(`Unsafe), position) => [%expr
         `unsafe([%e render_self_position_left_right(~loc, position)])
        ]
      | `Baseline_position(pos, ()) => render_baseline_position(~loc, pos)
      }
    },
  );

let justify_self =
  monomorphic(
    Parser.Property_justify_self.rule,
    (~loc) => [%expr CSS.justifySelf],
    (~loc, value) => {
      switch (value) {
      | `Auto => [%expr `auto]
      | `Normal => [%expr `normal]
      | `Stretch => [%expr `stretch]
      | `Static(None, position) => [%expr
         [%e render_self_position_left_right(~loc, position)]
        ]
      | `Static(Some(`Safe), position) => [%expr
         `safe([%e render_self_position_left_right(~loc, position)])
        ]
      | `Static(Some(`Unsafe), position) => [%expr
         `unsafe([%e render_self_position_left_right(~loc, position)])
        ]
      | `Baseline_position(pos, ()) => render_baseline_position(~loc, pos)
      }
    },
  );

let align_items =
  monomorphic(
    Parser.Property_align_items.rule,
    (~loc) => [%expr CSS.alignItems],
    (~loc, value) => {
      switch (value) {
      | `Normal => [%expr `normal]
      | `Stretch => [%expr `stretch]
      | `Baseline_position(pos, ()) => render_baseline_position(~loc, pos)
      | `Static(None, position) => [%expr
         [%e render_self_position(~loc, position)]
        ]
      | `Static(Some(`Safe), position) => [%expr
         `safe([%e render_self_position(~loc, position)])
        ]
      | `Static(Some(`Unsafe), position) => [%expr
         `unsafe([%e render_self_position(~loc, position)])
        ]
      | `Interpolation(v) => render_variable(~loc, v)
      }
    },
  );

let align_self =
  monomorphic(
    Parser.Property_align_self.rule,
    (~loc) => [%expr CSS.alignSelf],
    (~loc, value) => {
      switch (value) {
      | `Auto => [%expr `auto]
      | `Normal => [%expr `normal]
      | `Stretch => [%expr `stretch]
      | `Baseline_position(pos, ()) => render_baseline_position(~loc, pos)
      | `Static(None, position) => [%expr
         [%e render_self_position(~loc, position)]
        ]
      | `Static(Some(`Safe), position) => [%expr
         `safe([%e render_self_position(~loc, position)])
        ]
      | `Static(Some(`Unsafe), position) => [%expr
         `unsafe([%e render_self_position(~loc, position)])
        ]
      | `Interpolation(v) => render_variable(~loc, v)
      }
    },
  );

let align_content =
  monomorphic(
    Parser.Property_align_content.rule,
    (~loc) => [%expr CSS.alignContent],
    (~loc, value) => {
      switch (value) {
      | `Baseline_position(pos, ()) => render_baseline_position(~loc, pos)
      | `Normal => [%expr `normal]
      | `Content_distribution(distribution) =>
        render_content_distribution(~loc, distribution)
      | `Static(None, position) => [%expr
         [%e render_content_position(~loc, position)]
        ]
      | `Static(Some(`Safe), position) => [%expr
         `safe([%e render_content_position(~loc, position)])
        ]
      | `Static(Some(`Unsafe), position) => [%expr
         `unsafe([%e render_content_position(~loc, position)])
        ]
      }
    },
  );

let render_line_names = (~loc, value: Parser.Line_names.t) => {
  let ((), line_names, ()) = value;
  line_names
  |> String.concat(" ")
  |> Printf.sprintf("[%s]")
  |> (name => [[%expr `lineNames([%e render_string(~loc, name)])]]);
};

let render_maybe_line_names = (~loc, value) => {
  switch (value) {
  | None => []
  | Some(names) => render_line_names(~loc, names)
  };
};

let render_inflexible_breadth = (~loc, value: Parser.Inflexible_breadth.t) => {
  switch (value) {
  | `Auto => [%expr `auto]
  | `Min_content => [%expr `minContent]
  | `Max_content => [%expr `maxContent]
  | `Extended_length(l) => render_extended_length(~loc, l)
  | `Extended_percentage(p) => render_extended_percentage(~loc, p)
  /* TODO: Maybe fit-content is also valid? */
  };
};

let render_fixed_breadth = (~loc, value: Parser.Fixed_breadth.t) => {
  switch (value) {
  | `Extended_length(l) => render_extended_length(~loc, l)
  | `Extended_percentage(p) => render_extended_percentage(~loc, p)
  };
};

let render_flex_value = (~loc, value) => {
  switch (value) {
  | `Fr(f) => [%expr `fr([%e render_float(~loc, f)])]
  };
};

let render_track_breadth = (~loc, value: Parser.Track_breadth.t) => {
  switch (value) {
  | `Flex_value(f) => render_flex_value(~loc, f)
  | `Auto => [%expr `auto]
  | `Min_content => [%expr `minContent]
  | `Max_content => [%expr `maxContent]
  | `Extended_length(l) => render_extended_length(~loc, l)
  | `Extended_percentage(p) => render_extended_percentage(~loc, p)
  /* TODO: Maybe fit-content is also valid? */
  };
};

let rec render_track_repeat = (~loc, repeat: Parser.Track_repeat.t) => {
  let (positiveInteger, (), trackSizes, lineNames) = repeat;
  let lineNamesExpr = render_maybe_line_names(~loc, lineNames);
  let trackSizesExpr =
    trackSizes
    |> List.concat_map(((lineNames, trackSize)) => {
         let lineName = render_maybe_line_names(~loc, lineNames);
         List.append(lineName, [render_track_size(~loc, trackSize)]);
       });
  let items =
    List.append(trackSizesExpr, lineNamesExpr) |> Builder.pexp_array(~loc);
  [%expr
   `repeat((`num([%e render_integer(~loc, positiveInteger)]), [%e items]))
  ];
}
and render_track_size = (~loc, value: Parser.Track_size.t) => {
  switch (value) {
  | `Track_breadth(breadth) => render_track_breadth(~loc, breadth)
  | `Minmax(inflexible, (), breadth) => [%expr
     `minmax((
       [%e render_inflexible_breadth(~loc, inflexible)],
       [%e render_track_breadth(~loc, breadth)],
     ))
    ]
  | `Fit_content(`Extended_length(el)) => [%expr
     `fitContent([%e render_extended_length(~loc, el)])
    ]
  | `Fit_content(`Extended_percentage(ep)) => [%expr
     `fitContent([%e render_extended_percentage(~loc, ep)])
    ]
  };
};

let render_maybe_track_size = (~loc, value) => {
  switch (value) {
  | None => []
  | Some(size) => [render_track_size(~loc, size)]
  };
};

let render_track_list = (~loc, track_list, line_names) => {
  let tracks =
    track_list
    |> List.concat_map(((line_name, track)) => {
         let value =
           switch (track) {
           | `Track_repeat(repeat) => render_track_repeat(~loc, repeat)
           | `Track_size(size) => render_track_size(~loc, size)
           };
         let lineNameExpr = render_maybe_line_names(~loc, line_name);
         List.append(lineNameExpr, [value]);
       });
  let lineNamesExpr = render_maybe_line_names(~loc, line_names);
  List.append(lineNamesExpr, tracks) |> Builder.pexp_array(~loc);
};

let render_fixed_size = (~loc, value: Parser.Fixed_size.t) => {
  switch (value) {
  | `Fixed_breadth(breadth) => render_fixed_breadth(~loc, breadth)
  | `Minmax_0(fixed, (), breadth) => [%expr
     `minmax((
       [%e render_fixed_breadth(~loc, fixed)],
       [%e render_track_breadth(~loc, breadth)],
     ))
    ]
  | `Minmax_1(inflexible, (), breadth) => [%expr
     `minmax((
       [%e render_inflexible_breadth(~loc, inflexible)],
       [%e render_fixed_breadth(~loc, breadth)],
     ))
    ]
  };
};

let render_fixed_repeat = (~loc, value: Parser.Fixed_repeat.t) => {
  let (positiveInteger, (), fixedSizes, lineNames) = value;
  let number = render_integer(~loc, positiveInteger);
  let lineNamesExpr = render_maybe_line_names(~loc, lineNames);
  let fixedSizesExpr =
    fixedSizes
    |> List.concat_map(((lineName, value)) => {
         let fixed = render_fixed_size(~loc, value);
         let lineName = render_maybe_line_names(~loc, lineName);
         List.append(lineName, [fixed]);
       })
    |> List.append(lineNamesExpr)
    |> Builder.pexp_array(~loc);
  [%expr `repeat((`num([%e number]), [%e fixedSizesExpr]))];
};

let render_auto_repeat = (~loc, value: Parser.Auto_repeat.t) => {
  let (autos, (), fixedSized, lineNames) = value;
  let lineNamesExpr = render_maybe_line_names(~loc, lineNames);
  let autosExpr =
    switch (autos) {
    | `Auto_fill => [%expr `autoFill]
    | `Auto_fit => [%expr `autoFit]
    };
  let fixedExpr =
    fixedSized
    |> List.concat_map(((lineName, value)) => {
         let fixed = render_fixed_size(~loc, value);
         let lineName = render_maybe_line_names(~loc, lineName);
         List.append(lineName, [fixed]);
       });
  let items =
    List.append(lineNamesExpr, fixedExpr) |> Builder.pexp_array(~loc);
  [%expr `repeat(([%e autosExpr], [%e items]))];
};

let render_repeat_fixed = (~loc, value) => {
  value
  |> List.concat_map(((lineName, value)) => {
       let valueExpr =
         switch (value) {
         | `Fixed_size(size) => render_fixed_size(~loc, size)
         | `Fixed_repeat(repeat) => render_fixed_repeat(~loc, repeat)
         };
       let lineNamesExpr = render_maybe_line_names(~loc, lineName);
       List.append(lineNamesExpr, [valueExpr]);
     });
};

let render_auto_track_list = (~loc, value: Parser.Auto_track_list.t) => {
  let (fixed, lineNames, autoRepeat, fixed2, lineNames2) = value;
  let fixed1Expr = render_repeat_fixed(~loc, fixed);
  let lineNamesExpr = render_maybe_line_names(~loc, lineNames);
  let fixed1 = List.append(fixed1Expr, lineNamesExpr);
  let fixed2Expr = render_repeat_fixed(~loc, fixed2);
  let lineNamesExpr2 = render_maybe_line_names(~loc, lineNames2);
  let fixed2 = List.append(fixed2Expr, lineNamesExpr2);
  let autoRepeatExpr = render_auto_repeat(~loc, autoRepeat);
  List.append(fixed1, [autoRepeatExpr, ...fixed2])
  |> Builder.pexp_array(~loc);
};

let render_name_repeat = (~loc, value: Parser.Name_repeat.t) => {
  let (repeatValue, (), listOfLineNames) = value;
  let lineNamesExpr =
    listOfLineNames
    |> List.concat_map(render_line_names(~loc))
    |> Builder.pexp_array(~loc);
  switch (repeatValue) {
  | `Auto_fill => [[%expr `repeat((`autoFill, [%e lineNamesExpr]))]]
  | `Positive_integer(i) => [
      [%expr
        `repeat((`num([%e render_integer(~loc, i)]), [%e lineNamesExpr]))
      ],
    ]
  };
};

let render_subgrid = (~loc, line_name_list: Parser.Line_name_list.t) => {
  line_name_list
  |> List.concat_map(value => {
       switch (value) {
       | `Line_names(line_names) => render_line_names(~loc, line_names)
       | `Name_repeat(name_repeat) => render_name_repeat(~loc, name_repeat)
       }
     })
  |> List.append([[%expr `subgrid]])
  |> Builder.pexp_array(~loc);
};

let render_grid_template_rows_and_columns = (~loc) =>
  fun
  | `Interpolation(v) => render_variable(~loc, v)
  | `None => [%expr `none]
  | `Masonry => [%expr `masonry]
  | `Track_list(track_list, line_names) => [%expr
      `tracks([%e render_track_list(~loc, track_list, line_names)])
    ]
  | `Auto_track_list(list) => [%expr
      `tracks([%e render_auto_track_list(~loc, list)])
    ]
  | `Static((), None) => [%expr `tracks([|`subgrid|])]
  | `Static((), Some(subgrid)) => [%expr
      `tracks([%e render_subgrid(~loc, subgrid)])
    ];

// css-grid-1
let grid_template_columns =
  monomorphic(
    Parser.Property_grid_template_columns.rule,
    (~loc) => [%expr CSS.gridTemplateColumns],
    render_grid_template_rows_and_columns,
  );

let grid_template_rows =
  monomorphic(
    Parser.Property_grid_template_rows.rule,
    (~loc) => [%expr CSS.gridTemplateRows],
    render_grid_template_rows_and_columns,
  );

let grid_template_areas =
  monomorphic(
    Parser.Property_grid_template_areas.rule,
    (~loc) => [%expr CSS.gridTemplateAreas],
    (~loc) =>
      fun
      | `None => [%expr `none]
      | `Xor(areas) => {
          let areasExpr =
            areas
            |> List.map(area =>
                 switch (area) {
                 | `Interpolation(value) => render_variable(~loc, value)
                 | `String(value) => render_string(~loc, value)
                 }
               )
            |> Builder.pexp_array(~loc);
          [%expr `areas([%e areasExpr])];
        },
  );

let render_area_rows = (~loc, area_rows) =>
  area_rows
  |> List.concat_map(((names_before, area, track_size, names_after)) => {
       render_maybe_line_names(~loc, names_before)
       @ [[%expr `area([%e render_string(~loc, area)])]]
       @ render_maybe_track_size(~loc, track_size)
       @ render_maybe_line_names(~loc, names_after)
     })
  |> Builder.pexp_array(~loc);
let render_explicit_track_list = (~loc, track_list, line_names) => {
  let tracks =
    track_list
    |> List.concat_map(((line_name, track)) => {
         let lineNameExpr = render_maybe_line_names(~loc, line_name);
         List.append(lineNameExpr, [render_track_size(~loc, track)]);
       });
  let lineNamesExpr = render_maybe_line_names(~loc, line_names);
  List.append(lineNamesExpr, tracks) |> Builder.pexp_array(~loc);
};

let render_grid_template = (~loc) =>
  fun
  | `None => [%expr `none]
  | `Static_0(rows, _, columns) => [%expr
      `rowsColumns((
        [%e render_grid_template_rows_and_columns(~loc, rows)],
        [%e render_grid_template_rows_and_columns(~loc, columns)],
      ))
    ]
  | `Static_1(area_rows, None) => [%expr
      `areasRows([%e render_area_rows(~loc, area_rows)])
    ]
  | `Static_1(area_rows, Some((_, (explicit_track_list, line_names)))) => [%expr
      `areasRowsColumns((
        [%e render_area_rows(~loc, area_rows)],
        [%e
          render_explicit_track_list(~loc, explicit_track_list, line_names)
        ],
      ))
    ];

let grid_template =
  monomorphic(
    Parser.Property_grid_template.rule,
    (~loc) => [%expr CSS.gridTemplate],
    render_grid_template,
  );

let grid_auto_columns =
  monomorphic(
    Parser.Property_grid_auto_columns.rule,
    (~loc) => [%expr CSS.gridAutoColumns],
    (~loc, sizes) => {
      let sizesExpr =
        sizes
        |> List.map(render_track_size(~loc))
        |> Builder.pexp_array(~loc);
      [%expr `trackSizes([%e sizesExpr])];
    },
  );

let grid_auto_rows =
  monomorphic(
    Parser.Property_grid_auto_rows.rule,
    (~loc) => [%expr CSS.gridAutoRows],
    (~loc, sizes) => {
      let sizesExpr =
        sizes
        |> List.map(render_track_size(~loc))
        |> Builder.pexp_array(~loc);
      [%expr `trackSizes([%e sizesExpr])];
    },
  );

let grid_auto_flow =
  monomorphic(
    Parser.Property_grid_auto_flow.rule,
    (~loc) => [%expr CSS.gridAutoFlow],
    (~loc) =>
      fun
      | `Interpolation(values) => render_variable(~loc, values)
      | `Or(Some(`Row), None) => [%expr `row]
      | `Or(Some(`Column), None) => [%expr `column]
      | `Or(None, Some(_)) => [%expr `dense]
      | `Or(Some(`Row), Some(_)) => [%expr `rowDense]
      | `Or(Some(`Column), Some(_)) => [%expr `columnDense]
      | `Or(None, None) => raise(Impossible_state),
  );

let render_grid_line = (~loc, x: Parser.Grid_line.t) =>
  switch (x) {
  | `Interpolation(x) => render_variable(~loc, x)
  | `Auto => [%expr `auto]
  | `Custom_ident_without_span_or_auto(x) => [%expr
     `ident([%e render_string(~loc, x)])
    ]
  | `And_0(num, None) => [%expr `num([%e render_integer(~loc, num)])]
  | `And_0(num, Some(ident)) => [%expr
     `numIdent((
       [%e render_integer(~loc, num)],
       [%e render_string(~loc, ident)],
     ))
    ]
  | `And_1(_span, (Some(num), None)) => [%expr
     `span(`num([%e render_integer(~loc, num)]))
    ]
  | `And_1(_span, (None, Some(ident))) => [%expr
     `span(`ident([%e render_string(~loc, ident)]))
    ]
  | `And_1(_span, (Some(num), Some(ident))) => [%expr
     `span(
       `numIdent((
         [%e render_integer(~loc, num)],
         [%e render_string(~loc, ident)],
       )),
     )
    ]
  | `And_1(_span, (None, None)) => raise(Impossible_state)
  };

let grid =
  monomorphic(
    Parser.Property_grid.rule,
    (~loc) => [%expr CSS.gridProperty],
    (~loc) =>
      fun
      | `Property_grid_template(x) => [%expr
          `template([%e render_grid_template(~loc, x)])
        ]
      | `Static_0(template_rows, _, (_, dense), auto_columns) => {
          let template_rows =
            render_grid_template_rows_and_columns(~loc, template_rows);
          let dense =
            switch (dense) {
            | Some(_) => [%expr true]
            | None => [%expr false]
            };
          let auto_columns =
            switch (auto_columns) {
            | Some(cols) => [%expr
               Some(
                 [%e
                   cols
                   |> List.map(render_track_size(~loc))
                   |> Builder.pexp_array(~loc)
                 ],
               )
              ]
            | None => [%expr None]
            };
          [%expr
           `autoColumns(([%e template_rows], [%e dense], [%e auto_columns]))
          ];
        }
      | `Static_1((_, dense), auto_rows, _, template_columns) => {
          let dense =
            switch (dense) {
            | Some(_) => [%expr true]
            | None => [%expr false]
            };
          let auto_rows =
            switch (auto_rows) {
            | Some(cols) => [%expr
               Some(
                 [%e
                   cols
                   |> List.map(render_track_size(~loc))
                   |> Builder.pexp_array(~loc)
                 ],
               )
              ]
            | None => [%expr None]
            };
          let template_columns =
            render_grid_template_rows_and_columns(~loc, template_columns);
          [%expr
           `autoRows(([%e dense], [%e auto_rows], [%e template_columns]))
          ];
        },
  );

let grid_row_gap =
  monomorphic(
    Parser.Property_grid_row_gap.rule,
    (~loc) => [%expr CSS.gridRowGap],
    (~loc) =>
      fun
      | `Extended_length(el) => render_extended_length(~loc, el)
      | `Extended_percentage(ep) => render_extended_percentage(~loc, ep),
  );

let grid_column_gap =
  monomorphic(
    Parser.Property_grid_column_gap.rule,
    (~loc) => [%expr CSS.gridColumnGap],
    (~loc) =>
      fun
      | `Extended_length(el) => render_extended_length(~loc, el)
      | `Extended_percentage(ep) => render_extended_percentage(~loc, ep),
  );

let grid_row_start =
  monomorphic(
    Parser.Property_grid_row_start.rule,
    (~loc) => [%expr CSS.gridRowStart],
    render_grid_line,
  );

let grid_column_start =
  monomorphic(
    Parser.Property_grid_column_start.rule,
    (~loc) => [%expr CSS.gridColumnStart],
    render_grid_line,
  );

let grid_row_end =
  monomorphic(
    Parser.Property_grid_row_end.rule,
    (~loc) => [%expr CSS.gridRowEnd],
    render_grid_line,
  );

let grid_column_end =
  monomorphic(
    Parser.Property_grid_column_end.rule,
    (~loc) => [%expr CSS.gridColumnEnd],
    render_grid_line,
  );

let grid_area =
  polymorphic(Parser.Property_grid_area.rule, (~loc, value) =>
    switch (value) {
    | (gl1, [(_, gl2), (_, gl3), (_, gl4), ..._]) => [
        [%expr
          CSS.gridArea4(
            [%e render_grid_line(~loc, gl1)],
            [%e render_grid_line(~loc, gl2)],
            [%e render_grid_line(~loc, gl3)],
            [%e render_grid_line(~loc, gl4)],
          )
        ],
      ]
    | (gl1, [(_, gl2), (_, gl3), ..._]) => [
        [%expr
          CSS.gridArea3(
            [%e render_grid_line(~loc, gl1)],
            [%e render_grid_line(~loc, gl2)],
            [%e render_grid_line(~loc, gl3)],
          )
        ],
      ]

    | (gl1, [(_, gl2), ..._]) => [
        [%expr
          CSS.gridArea2(
            [%e render_grid_line(~loc, gl1)],
            [%e render_grid_line(~loc, gl2)],
          )
        ],
      ]
    | (gl1, []) => [[%expr CSS.gridArea([%e render_grid_line(~loc, gl1)])]]
    }
  );

let grid_row =
  polymorphic(Parser.Property_grid_row.rule, (~loc) =>
    fun
    | (start, None) => [
        [%expr CSS.gridRow([%e render_grid_line(~loc, start)])],
      ]
    | (start, Some((_, end_))) => [
        [%expr
          CSS.gridRow2(
            [%e render_grid_line(~loc, start)],
            [%e render_grid_line(~loc, end_)],
          )
        ],
      ]
  );

let grid_column =
  polymorphic(Parser.Property_grid_column.rule, (~loc) =>
    fun
    | (start, None) => [
        [%expr CSS.gridColumn([%e render_grid_line(~loc, start)])],
      ]
    | (start, Some((_, end_))) => [
        [%expr
          CSS.gridColumn2(
            [%e render_grid_line(~loc, start)],
            [%e render_grid_line(~loc, end_)],
          )
        ],
      ]
  );

let render_gap =
    (
      ~loc,
      value: [<
        Parser.Property_column_gap.t
        | Parser.Property_row_gap.t
        | `Normal
      ],
    ) => {
  switch (value) {
  | `Extended_length(el) => render_extended_length(~loc, el)
  | `Extended_percentage(ep) => render_extended_percentage(~loc, ep)
  | `Normal => [%expr `normal]
  };
};

let grid_gap =
  polymorphic(Parser.Property_grid_gap.rule, (~loc) =>
    fun
    | (row, None) => [[%expr CSS.gridGap([%e render_gap(~loc, row)])]]
    | (row, Some(column)) => [
        [%expr
          CSS.gridGap2(
            ~rowGap=[%e render_gap(~loc, row)],
            ~columnGap=[%e render_gap(~loc, column)],
          )
        ],
      ]
  );

let gap =
  polymorphic(Parser.Property_gap.rule, (~loc) =>
    fun
    | (row, None) => [[%expr CSS.gap([%e render_gap(~loc, row)])]]
    | (row, Some(column)) => [
        [%expr
          CSS.gap2(
            ~rowGap=[%e render_gap(~loc, row)],
            ~columnGap=[%e render_gap(~loc, column)],
          )
        ],
      ]
  );

let z_index =
  monomorphic(
    Parser.Property_z_index.rule,
    (~loc) => [%expr CSS.zIndex],
    (~loc, value) => {
      switch (value) {
      | `Auto => [%expr `auto]
      | `Interpolation(v) => render_variable(~loc, v)
      | `Integer(i) => [%expr `num([%e render_integer(~loc, i)])]
      }
    },
  );

let render_position_value = (~loc) =>
  fun
  | `Auto => variant_to_expression(~loc, `Auto)
  | `Extended_length(l) => render_extended_length(~loc, l)
  | `Extended_percentage(pct) => render_extended_percentage(~loc, pct);

let left =
  monomorphic(
    Parser.Property_left.rule,
    (~loc) => [%expr CSS.left],
    render_position_value,
  );

let top =
  monomorphic(
    Parser.Property_top.rule,
    (~loc) => [%expr CSS.top],
    render_position_value,
  );

let right =
  monomorphic(
    Parser.Property_right.rule,
    (~loc) => [%expr CSS.right],
    render_position_value,
  );

let bottom =
  monomorphic(
    Parser.Property_bottom.rule,
    (~loc) => [%expr CSS.bottom],
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
  | `Flow => [%expr `flow]
  | `Flow_root => [%expr `flowRoot]
  | `Ruby => [%expr `ruby]
  | `Ruby_base => [%expr `rubyBase]
  | `Ruby_base_container => [%expr `rubyBaseContainer]
  | `Ruby_text => [%expr `rubyText]
  | `Ruby_text_container => [%expr `rubyTextContainer]
  | `Run_in => [%expr `runIn]
  | `Moz_box => [%expr `mozBox]
  | `Moz_inline_box => [%expr `mozInlineBox]
  | `Moz_inline_stack => [%expr `mozInlineStack]
  | `Ms_flexbox => [%expr `msFlexbox]
  | `Ms_grid => [%expr `msGrid]
  | `Ms_inline_flexbox => [%expr `msInlineFlexbox]
  | `Ms_inline_grid => [%expr `msInlineGrid]
  | `Webkit_box => [%expr `webkitBox]
  | `Webkit_flex => [%expr `webkitFlex]
  | `Webkit_inline_box => [%expr `webkitInlineBox]
  | `Webkit_inline_flex => [%expr `webkitInlineFlex];

let display =
  monomorphic(
    Parser.Property_display.rule,
    (~loc) => [%expr CSS.display],
    render_display,
  );

let render_mask_image = (~loc) =>
  fun
  | `None => [%expr `none]
  | `Image(i) => render_image(~loc, i)
  | `Mask_source(_) => raise(Unsupported_feature);

let mask_image =
  monomorphic(
    Parser.Property_mask_image.rule,
    (~loc) => [%expr CSS.maskImage],
    (~loc) =>
      fun
      | [one] => render_mask_image(~loc, one)
      | _ => raise(Unsupported_feature),
  );

let render_paint = (~loc, value: Parser.Paint.t) => {
  switch (value) {
  | `Color(c) => render_color(~loc, c)
  | `Interpolation(variable) => render_variable(~loc, variable)
  | `Context_stroke => [%expr `contextStroke]
  | `Context_fill => [%expr `contextFill]
  | `Static(_, _)
  | _ => raise(Unsupported_feature)
  };
};

let fill =
  monomorphic(
    Parser.Property_fill.rule,
    (~loc) => [%expr CSS.SVG.fill],
    render_paint,
  );

let stroke =
  monomorphic(
    Parser.Property_stroke.rule,
    (~loc) => [%expr CSS.SVG.stroke],
    render_paint,
  );

let render_alpha_value = (~loc, value: Parser.Alpha_value.t) => {
  switch (value) {
  | `Number(n) => [%expr `num([%e render_float(~loc, n)])]
  | `Extended_percentage(pct) => render_extended_percentage(~loc, pct)
  };
};

let stroke_opacity =
  monomorphic(
    Parser.Property_stroke_opacity.rule,
    (~loc) => [%expr CSS.SVG.strokeOpacity],
    render_alpha_value,
  );

let line_break =
  monomorphic(
    Parser.Property_line_break.rule,
    (~loc) => [%expr CSS.lineBreak],
    (~loc, value) => {
      switch (value) {
      | `Auto => [%expr `auto]
      | `Loose => [%expr `loose]
      | `Normal => [%expr `normal]
      | `Strict => [%expr `strict]
      | `Anywhere => [%expr `anywhere]
      | `Interpolation(var) => render_variable(~loc, var)
      }
    },
  );

let caret_color = unsupportedProperty(Parser.Property_caret_color.rule);

let clear = unsupportedProperty(Parser.Property_clear.rule);

let clip = unsupportedProperty(Parser.Property_clip.rule);

let clip_path = unsupportedProperty(Parser.Property_clip_path.rule);

let column_count = unsupportedProperty(Parser.Property_column_count.rule);

let column_fill = unsupportedProperty(Parser.Property_column_fill.rule);

let column_gap =
  monomorphic(
    Parser.Property_column_gap.rule,
    (~loc) => [%expr CSS.columnGap],
    (~loc) => render_gap(~loc),
  );

let column_rule = unsupportedProperty(Parser.Property_column_rule.rule);

let column_rule_color =
  unsupportedProperty(Parser.Property_column_rule_color.rule);

let column_rule_style =
  unsupportedProperty(Parser.Property_column_rule_style.rule);

let column_rule_width =
  unsupportedProperty(Parser.Property_column_rule_width.rule);

let column_span = unsupportedProperty(Parser.Property_column_span.rule);

let columns = unsupportedProperty(Parser.Property_columns.rule);

let counter_increment =
  unsupportedProperty(Parser.Property_counter_increment.rule);

let counter_reset = unsupportedProperty(Parser.Property_counter_reset.rule);

let counter_set = unsupportedProperty(Parser.Property_counter_set.rule);

let render_cursor = (~loc, value) =>
  switch (value) {
  | `Interpolation(variable) => render_variable(~loc, variable)
  | `Auto => [%expr `auto]
  | `Default => [%expr `default]
  | `None => [%expr `none]
  | `Context_menu => [%expr `contextMenu]
  | `Help => [%expr `help]
  | `Pointer => [%expr `pointer]
  | `Progress => [%expr `progress]
  | `Wait => [%expr `wait]
  | `Cell => [%expr `cell]
  | `Crosshair => [%expr `crosshair]
  | `Text => [%expr `text]
  | `Vertical_text => [%expr `verticalText]
  | `Alias => [%expr `alias]
  | `Copy => [%expr `copy]
  | `Move => [%expr `move]
  | `No_drop => [%expr `noDrop]
  | `Not_allowed => [%expr `notAllowed]
  | `Grab => [%expr `grab]
  | `Grabbing => [%expr `grabbing]
  | `All_scroll => [%expr `allScroll]
  | `Col_resize => [%expr `colResize]
  | `Row_resize => [%expr `rowResize]
  | `N_resize => [%expr `nResize]
  | `E_resize => [%expr `eResize]
  | `S_resize => [%expr `sResize]
  | `W_resize => [%expr `wResize]
  | `Ne_resize => [%expr `neResize]
  | `Nw_resize => [%expr `nwResize]
  | `Se_resize => [%expr `seResize]
  | `Sw_resize => [%expr `swResize]
  | `Ew_resize => [%expr `ewResize]
  | `Ns_resize => [%expr `nsResize]
  | `Nesw_resize => [%expr `neswResize]
  | `Nwse_resize => [%expr `nwseResize]
  | `Zoom_in => [%expr `zoomIn]
  | `Zoom_out => [%expr `zoomOut]
  | `Hand => [%expr `hand]
  | `Moz_grab => [%expr `Moz_grab]
  | `Moz_grabbing => [%expr `Moz_grabbing]
  | `Moz_zoom_in => [%expr `Moz_zoom_in]
  | `Moz_zoom_out => [%expr `Moz_zoom_out]
  | `Webkit_grab => [%expr `Webkit_grab]
  | `Webkit_grabbing => [%expr `Webkit_grabbing]
  | `Webkit_zoom_in => [%expr `Webkit_zoom_in]
  | `Webkit_zoom_out => [%expr `Webkit_zoom_out]
  };

let cursor =
  monomorphic(
    Parser.Property_cursor.rule,
    (~loc) => [%expr CSS.cursor],
    render_cursor,
  );

let direction = unsupportedProperty(Parser.Property_direction.rule);

let render_drop_shadow = (~loc, value: Parser.Function_drop_shadow.t) => {
  let (offset1, offset2, offset3, color) = value;
  let offset1Expr = render_extended_length(~loc, offset1);
  let offset2Expr = render_extended_length(~loc, offset2);
  let offset3Expr = render_extended_length(~loc, offset3);
  let colorExpr =
    switch (color) {
    /* We default to currentColor since code-generation becomes very easy */
    | None => [%expr `currentColor]
    | Some(c) => render_color(~loc, c)
    };
  [%expr
   `dropShadow((
     [%e offset1Expr],
     [%e offset2Expr],
     [%e offset3Expr],
     [%e colorExpr],
   ))
  ];
};

let render_float_percentage = (~loc, value: Parser.Number_percentage.t) => {
  switch (value) {
  | `Number(number) => [%expr `num([%e render_float(~loc, number)])]
  | `Extended_percentage(pct) => render_extended_percentage(~loc, pct)
  };
};

let render_filter_function = (~loc, value: Parser.Filter_function.t) => {
  switch (value) {
  | `Function_blur(v) => [%expr `blur([%e render_extended_length(~loc, v)])]
  | `Function_brightness(v) => [%expr
     `brightness([%e render_float_percentage(~loc, v)])
    ]
  | `Function_contrast(v) => [%expr
     `contrast([%e render_float_percentage(~loc, v)])
    ]
  | `Function_drop_shadow(v) => render_drop_shadow(~loc, v)
  | `Function_grayscale(v) => [%expr
     `grayscale([%e render_float_percentage(~loc, v)])
    ]
  | `Function_hue_rotate(v) => [%expr
     `hueRotate([%e render_extended_angle(~loc, v)])
    ]
  | `Function_invert(v) => [%expr
     `invert([%e render_float_percentage(~loc, v)])
    ]
  | `Function_opacity(v) => [%expr
     `opacity([%e render_float_percentage(~loc, v)])
    ]
  | `Function_saturate(v) => [%expr
     `saturate([%e render_float_percentage(~loc, v)])
    ]
  | `Function_sepia(v) => [%expr
     `sepia([%e render_float_percentage(~loc, v)])
    ]
  };
};

let render_filter_function_list = (~loc, value: Parser.Filter_function_list.t) => {
  value
  |> List.map(ff =>
       switch (ff) {
       | `Filter_function(f) => render_filter_function(~loc, f)
       | `Url(u) => render_url(~loc, u)
       }
     )
  |> Builder.pexp_array(~loc);
};

let filter =
  monomorphic(
    Parser.Property_filter.rule,
    (~loc) => [%expr CSS.filter],
    (~loc, value) => {
      switch (value) {
      | `None => [%expr [|`none|]]
      | `Interpolation(v) => render_variable(~loc, v)
      | `Filter_function_list(ffl) => render_filter_function_list(~loc, ffl)
      }
    },
  );

let backdrop_filter =
  monomorphic(
    Parser.Property_backdrop_filter.rule,
    (~loc) => [%expr CSS.backdropFilter],
    (~loc, value) =>
      switch (value) {
      | `None => [%expr [|`none|]]
      | `Interpolation(v) => render_variable(~loc, v)
      | `Filter_function_list(ffl) => render_filter_function_list(~loc, ffl)
      },
  );

let float = unsupportedProperty(Parser.Property_float.rule);

let font_language_override =
  unsupportedProperty(Parser.Property_font_language_override.rule);

let ime_mode = unsupportedProperty(Parser.Property_ime_mode.rule);

let isolation = unsupportedProperty(Parser.Property_isolation.rule);

let line_clamp = unsupportedProperty(Parser.Property_line_clamp.rule);

let list_style = unsupportedProperty(Parser.Property_list_style.rule);

let list_style_image =
  monomorphic(
    Parser.Property_list_style_image.rule,
    (~loc) => [%expr CSS.listStyleImage],
    (~loc, value: Parser.Property_list_style_image.t) => {
      switch (value) {
      | `None => [%expr `none]
      | `Image(i) => render_image(~loc, i)
      }
    },
  );

let list_style_position =
  unsupportedProperty(Parser.Property_list_style_position.rule);

let list_style_type =
  unsupportedProperty(Parser.Property_list_style_type.rule);

let mix_blend_mode = unsupportedProperty(Parser.Property_mix_blend_mode.rule);

let position = unsupportedProperty(Parser.Property_position.rule);

let resize = unsupportedProperty(Parser.Property_resize.rule);

let row_gap =
  monomorphic(
    Parser.Property_row_gap.rule,
    (~loc) => [%expr CSS.rowGap],
    (~loc) => render_gap(~loc),
  );

let scrollbar_3dlight_color =
  unsupportedProperty(Parser.Property_scrollbar_3dlight_color.rule);

let scrollbar_arrow_color =
  unsupportedProperty(Parser.Property_scrollbar_arrow_color.rule);

let scrollbar_base_color =
  unsupportedProperty(Parser.Property_scrollbar_base_color.rule);

let scrollbar_color =
  monomorphic(
    Parser.Property_scrollbar_color.rule,
    (~loc) => [%expr CSS.scrollbarColor],
    (~loc, value: Parser.Property_scrollbar_color.t) =>
      switch (value) {
      | `Auto => [%expr `auto]
      | `Static(thumbColor, trackColor) => [%expr
         `thumbTrackColor((
           [%e render_color(~loc, thumbColor)],
           [%e render_color(~loc, trackColor)],
         ))
        ]
      },
  );

let scrollbar_darkshadow_color =
  unsupportedProperty(Parser.Property_scrollbar_darkshadow_color.rule);

let scrollbar_face_color =
  unsupportedProperty(Parser.Property_scrollbar_face_color.rule);

let scrollbar_highlight_color =
  unsupportedProperty(Parser.Property_scrollbar_highlight_color.rule);

let scrollbar_shadow_color =
  unsupportedProperty(Parser.Property_scrollbar_shadow_color.rule);

let scrollbar_track_color =
  unsupportedProperty(Parser.Property_scrollbar_track_color.rule);

let scrollbar_width =
  monomorphic(
    Parser.Property_scrollbar_width.rule,
    (~loc) => [%expr CSS.scrollbarWidth],
    (~loc, value: Parser.Property_scrollbar_width.t) =>
      switch (value) {
      | `Thin => [%expr `thin]
      | `Auto => [%expr `auto]
      | `None => [%expr `none]
      },
  );

let stroke_dasharray =
  unsupportedProperty(Parser.Property_stroke_dasharray.rule);

let stroke_linecap = unsupportedProperty(Parser.Property_stroke_linecap.rule);

let stroke_linejoin =
  unsupportedProperty(Parser.Property_stroke_linejoin.rule);

let stroke_miterlimit =
  unsupportedProperty(Parser.Property_stroke_miterlimit.rule);

let stroke_width = unsupportedProperty(Parser.Property_stroke_width.rule);

let text_combine_upright =
  unsupportedProperty(Parser.Property_text_combine_upright.rule);

let all = unsupportedProperty(Parser.Property_all.rule);

let appearance = unsupportedProperty(Parser.Property_appearance.rule);

let background_blend_mode =
  unsupportedProperty(Parser.Property_background_blend_mode.rule);

let baseline_shift = unsupportedProperty(Parser.Property_baseline_shift.rule);

let block_size = unsupportedProperty(Parser.Property_block_size.rule);

let border_block_color =
  unsupportedProperty(Parser.Property_border_block_color.rule);

let border_block_end_color =
  unsupportedProperty(Parser.Property_border_block_end_color.rule);

let border_block_end_style =
  unsupportedProperty(Parser.Property_border_block_end_style.rule);

let border_block_end_width =
  unsupportedProperty(Parser.Property_border_block_end_width.rule);

let border_block_end =
  unsupportedProperty(Parser.Property_border_block_end.rule);

let border_block_start_color =
  unsupportedProperty(Parser.Property_border_block_start_color.rule);

let border_block_start_style =
  unsupportedProperty(Parser.Property_border_block_start_style.rule);

let border_block_start_width =
  unsupportedProperty(Parser.Property_border_block_start_width.rule);

let border_block_start =
  unsupportedProperty(Parser.Property_border_block_start.rule);

let border_block_style =
  unsupportedProperty(Parser.Property_border_block_style.rule);

let border_block_width =
  unsupportedProperty(Parser.Property_border_block_width.rule);

let border_block = unsupportedProperty(Parser.Property_border_block.rule);

let border_collapse =
  unsupportedProperty(Parser.Property_border_collapse.rule);

let border_end_end_radius =
  unsupportedProperty(Parser.Property_border_end_end_radius.rule);

let border_end_start_radius =
  unsupportedProperty(Parser.Property_border_end_start_radius.rule);

let border_inline_color =
  unsupportedProperty(Parser.Property_border_inline_color.rule);

let border_inline_end_color =
  unsupportedProperty(Parser.Property_border_inline_end_color.rule);

let border_inline_end_style =
  unsupportedProperty(Parser.Property_border_inline_end_style.rule);

let border_inline_end_width =
  unsupportedProperty(Parser.Property_border_inline_end_width.rule);

let border_inline_end =
  unsupportedProperty(Parser.Property_border_inline_end.rule);

let border_inline_start_color =
  unsupportedProperty(Parser.Property_border_inline_start_color.rule);

let border_inline_start_style =
  unsupportedProperty(Parser.Property_border_inline_start_style.rule);

let border_inline_start_width =
  unsupportedProperty(Parser.Property_border_inline_start_width.rule);

let border_inline_start =
  unsupportedProperty(Parser.Property_border_inline_start.rule);

let border_inline_style =
  unsupportedProperty(Parser.Property_border_inline_style.rule);

let border_inline_width =
  unsupportedProperty(Parser.Property_border_inline_width.rule);

let border_inline = unsupportedProperty(Parser.Property_border_inline.rule);

let border_spacing = unsupportedProperty(Parser.Property_border_spacing.rule);

let border_start_end_radius =
  unsupportedProperty(Parser.Property_border_start_end_radius.rule);

let border_start_start_radius =
  unsupportedProperty(Parser.Property_border_start_start_radius.rule);

let box_decoration_break =
  unsupportedProperty(Parser.Property_box_decoration_break.rule);

let break_after = unsupportedProperty(Parser.Property_break_after.rule);

let break_before = unsupportedProperty(Parser.Property_break_before.rule);

let break_inside = unsupportedProperty(Parser.Property_break_inside.rule);

let caption_side = unsupportedProperty(Parser.Property_caption_side.rule);

let clip_rule = unsupportedProperty(Parser.Property_clip_rule.rule);

let color_adjust = unsupportedProperty(Parser.Property_color_adjust.rule);

let color_interpolation_filters =
  unsupportedProperty(Parser.Property_color_interpolation_filters.rule);

let color_interpolation =
  unsupportedProperty(Parser.Property_color_interpolation.rule);

let color_scheme = unsupportedProperty(Parser.Property_color_scheme.rule);

let contain = unsupportedProperty(Parser.Property_contain.rule);

let content_visibility =
  unsupportedProperty(Parser.Property_content_visibility.rule);

let render_quote = (~loc, quote: Parser.Quote.t) => {
  switch (quote) {
  | `Close_quote => [%expr `closeQuote]
  | `No_close_quote => [%expr `noCloseQuote]
  | `No_open_quote => [%expr `noOpenQuote]
  | `Open_quote => [%expr `openQuote]
  };
};

let render_content_string = (~loc, str) => {
  let length = String.length(str);
  let get = String.get;
  let str =
    if (length == 0) {
      [%expr {js||js}];
    } else if (length == 1 && get(str, 0) == '"') {
      [%expr {js|"|js}];
    } else if (length == 1 && get(str, 0) == ' ') {
      [%expr {js| |js}];
    } else if (length == 1 && get(str, 0) == '\'') {
      [%expr {js|'|js}];
    } else if (length == 2 && get(str, 0) == '"' && get(str, 1) == '"') {
      [%expr {js|""|js}];
    } else {
      let first = get(str, 0);
      let last = get(str, length - 1);
      switch (first, last) {
      | ('\'', '\'') => [%expr [%e render_string(~loc, str)]]
      | ('"', '"') => [%expr [%e render_string(~loc, str)]]
      | _ => [%expr [%e render_string(~loc, str)]]
      };
    };
  [%expr `text([%e str])];
};

let render_attr_name = (~loc, attr_name: Parser.Attr_name.t) => {
  switch (attr_name) {
  | (Some((Some(label), _)), _label) => [%expr
     [%e render_string(~loc, label)]
    ]
  | (Some((None, _)), label) => [%expr [%e render_string(~loc, label)]]
  | (None, label) => [%expr [%e render_string(~loc, label)]]
  };
};

let render_attr_unit = (~loc, attr_unit: Parser.Attr_unit.t) => {
  switch (attr_unit) {
  | `Percent => [%expr [%e render_string(~loc, "%")]]
  | `Em => [%expr [%e render_string(~loc, "em")]]
  | `Vmin => [%expr [%e render_string(~loc, "vmin")]]
  | `In => [%expr [%e render_string(~loc, "in")]]
  | `Vw => [%expr [%e render_string(~loc, "vw")]]
  | `Mm => [%expr [%e render_string(~loc, "mm")]]
  | `Deg => [%expr [%e render_string(~loc, "deg")]]
  | `Cm => [%expr [%e render_string(~loc, "cm")]]
  | `Grad => [%expr [%e render_string(~loc, "grad")]]
  | `Px => [%expr [%e render_string(~loc, "px")]]
  | `KHz => [%expr [%e render_string(~loc, "kHz")]]
  | `Ex => [%expr [%e render_string(~loc, "ex")]]
  | `Rad => [%expr [%e render_string(~loc, "rad")]]
  | `Ch => [%expr [%e render_string(~loc, "ch")]]
  | `Rem => [%expr [%e render_string(~loc, "rem")]]
  | `Pt => [%expr [%e render_string(~loc, "pt")]]
  | `Hz => [%expr [%e render_string(~loc, "Hz")]]
  | `Pc => [%expr [%e render_string(~loc, "pc")]]
  | `Turn => [%expr [%e render_string(~loc, "turn")]]
  | `S => [%expr [%e render_string(~loc, "s")]]
  | `Vmax => [%expr [%e render_string(~loc, "vmax")]]
  | `Ms => [%expr [%e render_string(~loc, "ms")]]
  | `Vh => [%expr [%e render_string(~loc, "vh")]]
  };
};

let render_attr_type = (~loc, attr_type: Parser.Attr_type.t) => {
  switch (attr_type) {
  | `Raw_string => [%expr [%e render_string(~loc, "raw-string")]]
  | `Attr_unit(attr_unit) => [%expr [%e render_attr_unit(~loc, attr_unit)]]
  };
};

let render_function_attr =
    (
      ~loc,
      attr_name: Parser.Attr_name.t,
      attr_type: option(Parser.Attr_type.t),
    ) => {
  switch (attr_type) {
  | Some(attr_type) => [%expr
     `attrWithType((
       [%e render_attr_name(~loc, attr_name)],
       [%e render_attr_type(~loc, attr_type)],
     ))
    ]
  | None => [%expr `attr([%e render_attr_name(~loc, attr_name)])]
  };
};

let render_symbols_type = (~loc, symbols_type: Parser.Symbols_type.t) => {
  switch (symbols_type) {
  | `Cyclic => [%expr `cyclic]
  | `Numeric => [%expr `numeric]
  | `Alphabetic => [%expr `alphabetic]
  | `Symbolic => [%expr `symbolic]
  | `Fixed => [%expr `fixed]
  };
};

let render_list_image_or_string = (~loc, list_image_or_string) => {
  list_image_or_string
  |> List.map(image_or_string =>
       switch (image_or_string) {
       | `Image(image) => render_image(~loc, image)
       | `String(str) => render_string(~loc, str)
       }
     )
  |> Builder.pexp_array(~loc);
};

let render_symbols =
    (~loc, symbols_type: option(Parser.Symbols_type.t), list_image_or_string) => {
  switch (symbols_type) {
  | Some(symbols_type) => [%expr
     `symbols((
       [%e render_symbols_type(~loc, symbols_type)],
       [%e render_list_image_or_string(~loc, list_image_or_string)],
     ))
    ]
  | None => [%expr
     `symbols((
       None,
       [%e render_list_image_or_string(~loc, list_image_or_string)],
     ))
    ]
  };
};

let render_counter_style = (~loc, counter_style: Parser.Counter_style.t) => {
  switch (counter_style) {
  | `Counter_style_name(label) => [%expr
     `Custom([%e render_string(~loc, label)])
    ]
  | `Function_symbols(symbols_type, list_image_or_string) => [%expr
     [%e render_symbols(~loc, symbols_type, list_image_or_string)]
    ]
  };
};

let render_counter =
    (~loc, label: string, style: option(Parser.Counter_style.t)) => {
  switch (style) {
  | Some(counter_style) => [%expr
     `counter((
       [%e render_string(~loc, label)],
       Some([%e render_counter_style(~loc, counter_style)]),
     ))
    ]
  | None => [%expr `counter(([%e render_string(~loc, label)], None))]
  };
};

let render_content_list = (~loc, content_list: Parser.Content_list.t) => {
  content_list
  |> List.map(content_item =>
       switch (content_item) {
       | `Contents => [%expr `contents]
       | `Quote(quote) => render_quote(~loc, quote)
       | `String(str) => render_content_string(~loc, str)
       | `Url(u) => render_url(~loc, u)
       | `Counter(counter_name, _, list_style_type_opt) =>
         let counter_style_opt =
           switch (list_style_type_opt) {
           | Some(`Counter_style(cs)) => Some(cs)
           | Some(`None | `String(_)) => None
           | None => None
           };
         render_counter(~loc, counter_name, counter_style_opt);
       | `Function_attr((attr_name, attr_type): Parser.Function_attr.t) =>
         render_function_attr(~loc, attr_name, attr_type)
       }
     )
  |> Builder.pexp_array(~loc);
};

let content =
  polymorphic(Parser.Property_content.rule, (~loc, value) => {
    switch (value) {
    | `Normal => [[%expr CSS.contentRule(`normal)]]
    | `None => [[%expr CSS.contentRule(`none)]]
    | `String(str) => [
        [%expr CSS.contentRule([%e render_content_string(~loc, str)])],
      ]
    | `Interpolation(v) => [
        [%expr CSS.contentRule([%e render_variable(~loc, v)])],
      ]
    | `Static(`Content_list(lst), None) => [
        [%expr CSS.contentsRule([%e render_content_list(~loc, lst)], None)],
      ]
    | `Static(`Content_list(lst), Some((_, alt))) => [
        [%expr
          CSS.contentsRule(
            [%e render_content_list(~loc, lst)],
            Some([%e render_string(~loc, alt)]),
          )
        ],
      ]
    | `Static(`Content_replacement(image), None) => [
        [%expr CSS.contentRule([%e render_image(~loc, image)])],
      ]
    | `Static(`Content_replacement(image), Some((_, alt))) => [
        [%expr
          CSS.contentsRule(
            [|`url([%e render_image(~loc, image)])|],
            Some([%e render_string(~loc, alt)]),
          )
        ],
      ]
    }
  });

let empty_cells = unsupportedProperty(Parser.Property_empty_cells.rule);

let fill_opacity = unsupportedProperty(Parser.Property_fill_opacity.rule);

let fill_rule = unsupportedProperty(Parser.Property_fill_rule.rule);

let hyphenate_character =
  unsupportedProperty(Parser.Property_hyphenate_character.rule);

let hyphenate_limit_chars =
  unsupportedProperty(Parser.Property_hyphenate_limit_chars.rule);

let hyphenate_limit_lines =
  unsupportedProperty(Parser.Property_hyphenate_limit_lines.rule);

let hyphenate_limit_zone =
  unsupportedProperty(Parser.Property_hyphenate_limit_zone.rule);

let initial_letter_align =
  unsupportedProperty(Parser.Property_initial_letter_align.rule);

let initial_letter = unsupportedProperty(Parser.Property_initial_letter.rule);

let inline_size = unsupportedProperty(Parser.Property_inline_size.rule);

let inset_block_end =
  unsupportedProperty(Parser.Property_inset_block_end.rule);

let inset_block_start =
  unsupportedProperty(Parser.Property_inset_block_start.rule);

let inset_block = unsupportedProperty(Parser.Property_inset_block.rule);

let inset_inline_end =
  unsupportedProperty(Parser.Property_inset_inline_end.rule);

let inset_inline_start =
  unsupportedProperty(Parser.Property_inset_inline_start.rule);

let inset_inline = unsupportedProperty(Parser.Property_inset_inline.rule);

let inset = unsupportedProperty(Parser.Property_inset.rule);

let layout_grid_char =
  unsupportedProperty(Parser.Property_layout_grid_char.rule);

let layout_grid_line =
  unsupportedProperty(Parser.Property_layout_grid_line.rule);

let layout_grid_mode =
  unsupportedProperty(Parser.Property_layout_grid_mode.rule);

let layout_grid_type =
  unsupportedProperty(Parser.Property_layout_grid_type.rule);

let layout_grid = unsupportedProperty(Parser.Property_layout_grid.rule);

let mask_border_mode =
  unsupportedProperty(Parser.Property_mask_border_mode.rule);

let mask_border_outset =
  unsupportedProperty(Parser.Property_mask_border_outset.rule);

let mask_border_repeat =
  unsupportedProperty(Parser.Property_mask_border_repeat.rule);

let mask_border_slice =
  unsupportedProperty(Parser.Property_mask_border_slice.rule);

let mask_border_source =
  unsupportedProperty(Parser.Property_mask_border_source.rule);

let mask_border_width =
  unsupportedProperty(Parser.Property_mask_border_width.rule);

let mask_clip = unsupportedProperty(Parser.Property_mask_clip.rule);

let mask_composite = unsupportedProperty(Parser.Property_mask_composite.rule);

let mask_mode = unsupportedProperty(Parser.Property_mask_mode.rule);

let mask_origin = unsupportedProperty(Parser.Property_mask_origin.rule);

let mask_position =
  polymorphic(Parser.Property_mask_position.rule, (~loc) =>
    fun
    | [one] => [[%expr CSS.maskPosition([%e render_position(~loc, one)])]]
    | more => [
        [%expr
          CSS.maskPositions(
            [%e
              more
              |> List.map(render_position(~loc))
              |> Builder.pexp_array(~loc)
            ],
          )
        ],
      ]
  );

let mask_repeat = unsupportedProperty(Parser.Property_mask_repeat.rule);

let mask_size = unsupportedProperty(Parser.Property_mask_size.rule);

let mask_type = unsupportedProperty(Parser.Property_mask_type.rule);

let max_block_size = unsupportedProperty(Parser.Property_max_block_size.rule);

let max_inline_size =
  unsupportedProperty(Parser.Property_max_inline_size.rule);

let min_block_size = unsupportedProperty(Parser.Property_min_block_size.rule);

let min_inline_size =
  unsupportedProperty(Parser.Property_min_inline_size.rule);

let nav_down = unsupportedProperty(Parser.Property_nav_down.rule);

let nav_left = unsupportedProperty(Parser.Property_nav_left.rule);

let nav_right = unsupportedProperty(Parser.Property_nav_right.rule);

let nav_up = unsupportedProperty(Parser.Property_nav_up.rule);

let offset_anchor =
  monomorphic(
    Parser.Property_offset_anchor.rule,
    (~loc) => [%expr CSS.offsetAnchor],
    (~loc) =>
      fun
      | `Auto => [%expr `auto]
      | `Position(x) => render_position(~loc, x),
  );

let offset_distance =
  unsupportedProperty(Parser.Property_offset_distance.rule);

let offset_path = unsupportedProperty(Parser.Property_offset_path.rule);

let offset_position =
  unsupportedProperty(Parser.Property_offset_position.rule);

let offset_rotate = unsupportedProperty(Parser.Property_offset_rotate.rule);

let offset = unsupportedProperty(Parser.Property_offset.rule);

let orphans = unsupportedProperty(Parser.Property_orphans.rule);

let overflow_anchor =
  unsupportedProperty(Parser.Property_overflow_anchor.rule);

let padding_block_end =
  unsupportedProperty(Parser.Property_padding_block_end.rule);

let padding_block_start =
  unsupportedProperty(Parser.Property_padding_block_start.rule);

let padding_block = unsupportedProperty(Parser.Property_padding_block.rule);

let padding_inline_end =
  unsupportedProperty(Parser.Property_padding_inline_end.rule);

let padding_inline_start =
  unsupportedProperty(Parser.Property_padding_inline_start.rule);

let padding_inline = unsupportedProperty(Parser.Property_padding_inline.rule);

let page_break_after =
  unsupportedProperty(Parser.Property_page_break_after.rule);

let page_break_before =
  unsupportedProperty(Parser.Property_page_break_before.rule);

let page_break_inside =
  unsupportedProperty(Parser.Property_page_break_inside.rule);

let table_layout = unsupportedProperty(Parser.Property_table_layout.rule);

/* let render_animatable_feature = (~loc) =>
   fun
   | `Scroll_position => [%expr `scrollPosition]
   | `Contents => [%expr `contents]
   | `Custom_ident(v) => render_string(~loc, v); */

let will_change =
  monomorphic(
    Parser.Property_will_change.rule,
    (~loc) => [%expr CSS.willChange],
    (~loc, value: Parser.Property_will_change.t) => {
      switch (value) {
      | `Auto => [%expr `auto]
      | _ => raise(Unsupported_feature)
      }
    },
  );

let writing_mode = unsupportedProperty(Parser.Property_writing_mode.rule);

let text_orientation =
  unsupportedProperty(Parser.Property_text_orientation.rule);

let touch_action = unsupportedProperty(Parser.Property_touch_action.rule);

let user_select =
  monomorphic(
    Parser.Property_user_select.rule,
    (~loc) => [%expr CSS.userSelect],
    (~loc) =>
      fun
      | `Auto => [%expr `auto]
      | `Text => [%expr `text]
      | `Contain => [%expr `contain]
      | `All => [%expr `all]
      | `None => [%expr `none]
      | `Interpolation(v) => render_variable(~loc, v),
  );

let zoom =
  monomorphic(
    Parser.Property_zoom.rule,
    (~loc) => [%expr CSS.zoom],
    (~loc) =>
      fun
      | `Number(number) => [%expr `num([%e render_float(~loc, number)])]
      | `Extended_percentage(v) => render_extended_percentage(~loc, v)
      | `Reset => [%expr `reset]
      | `Normal => [%expr `normal],
  );

let visibility =
  monomorphic(
    Parser.Property_visibility.rule,
    (~loc) => [%expr CSS.visibility],
    (~loc) =>
      fun
      | `Visible => [%expr `visible]
      | `Hidden => [%expr `hidden]
      | `Collapse => [%expr `collapse]
      | `Interpolation(v) => render_variable(~loc, v),
  );

let accent_color = unsupportedProperty(Parser.Property_accent_color.rule);
let animation_composition =
  unsupportedProperty(Parser.Property_animation_composition.rule);
let animation_range =
  unsupportedProperty(Parser.Property_animation_range.rule);
let animation_range_end =
  unsupportedProperty(Parser.Property_animation_range_end.rule);
let animation_range_start =
  unsupportedProperty(Parser.Property_animation_range_start.rule);
let animation_timeline =
  unsupportedProperty(Parser.Property_animation_timeline.rule);
let anchor_name = unsupportedProperty(Parser.Property_anchor_name.rule);
let anchor_scope = unsupportedProperty(Parser.Property_anchor_scope.rule);
let field_sizing = unsupportedProperty(Parser.Property_field_sizing.rule);
let interpolate_size =
  unsupportedProperty(Parser.Property_interpolate_size.rule);
let inset_area = unsupportedProperty(Parser.Property_inset_area.rule);
let overlay = unsupportedProperty(Parser.Property_overlay.rule);
let position_anchor =
  unsupportedProperty(Parser.Property_position_anchor.rule);
let position_area = unsupportedProperty(Parser.Property_position_area.rule);
let position_try = unsupportedProperty(Parser.Property_position_try.rule);
let position_try_fallbacks =
  unsupportedProperty(Parser.Property_position_try_fallbacks.rule);
let position_try_options =
  unsupportedProperty(Parser.Property_position_try_options.rule);
let position_visibility =
  unsupportedProperty(Parser.Property_position_visibility.rule);
let reading_flow = unsupportedProperty(Parser.Property_reading_flow.rule);
let scroll_start = unsupportedProperty(Parser.Property_scroll_start.rule);
let scroll_start_block =
  unsupportedProperty(Parser.Property_scroll_start_block.rule);
let scroll_start_inline =
  unsupportedProperty(Parser.Property_scroll_start_inline.rule);
let scroll_start_x = unsupportedProperty(Parser.Property_scroll_start_x.rule);
let scroll_start_y = unsupportedProperty(Parser.Property_scroll_start_y.rule);
let scroll_start_target =
  unsupportedProperty(Parser.Property_scroll_start_target.rule);
let scroll_start_target_block =
  unsupportedProperty(Parser.Property_scroll_start_target_block.rule);
let scroll_start_target_inline =
  unsupportedProperty(Parser.Property_scroll_start_target_inline.rule);
let scroll_start_target_x =
  unsupportedProperty(Parser.Property_scroll_start_target_x.rule);
let scroll_start_target_y =
  unsupportedProperty(Parser.Property_scroll_start_target_y.rule);
let scroll_timeline =
  unsupportedProperty(Parser.Property_scroll_timeline.rule);
let scroll_timeline_axis =
  unsupportedProperty(Parser.Property_scroll_timeline_axis.rule);
let scroll_timeline_name =
  unsupportedProperty(Parser.Property_scroll_timeline_name.rule);
let text_spacing_trim =
  unsupportedProperty(Parser.Property_text_spacing_trim.rule);
let text_wrap = unsupportedProperty(Parser.Property_text_wrap.rule);
let text_wrap_mode = unsupportedProperty(Parser.Property_text_wrap_mode.rule);
let text_wrap_style =
  unsupportedProperty(Parser.Property_text_wrap_style.rule);
let text_box_trim = unsupportedProperty(Parser.Property_text_box_trim.rule);
let text_box_edge = unsupportedProperty(Parser.Property_text_box_edge.rule);
let white_space_collapse =
  unsupportedProperty(Parser.Property_white_space_collapse.rule);
let math_depth = unsupportedProperty(Parser.Property_math_depth.rule);
let math_shift = unsupportedProperty(Parser.Property_math_shift.rule);
let math_style = unsupportedProperty(Parser.Property_math_style.rule);
let font_display = unsupportedProperty(Parser.Property_font_display.rule);
let page = unsupportedProperty(Parser.Property_page.rule);
let size = unsupportedProperty(Parser.Property_size.rule);
let marks = unsupportedProperty(Parser.Property_marks.rule);
let bleed = unsupportedProperty(Parser.Property_bleed.rule);
let stop_color = unsupportedProperty(Parser.Property_stop_color.rule);
let stop_opacity = unsupportedProperty(Parser.Property_stop_opacity.rule);
let flood_color = unsupportedProperty(Parser.Property_flood_color.rule);
let flood_opacity = unsupportedProperty(Parser.Property_flood_opacity.rule);
let lighting_color = unsupportedProperty(Parser.Property_lighting_color.rule);
let contain_intrinsic_size =
  unsupportedProperty(Parser.Property_contain_intrinsic_size.rule);
let contain_intrinsic_width =
  unsupportedProperty(Parser.Property_contain_intrinsic_width.rule);
let contain_intrinsic_height =
  unsupportedProperty(Parser.Property_contain_intrinsic_height.rule);
let contain_intrinsic_block_size =
  unsupportedProperty(Parser.Property_contain_intrinsic_block_size.rule);
let contain_intrinsic_inline_size =
  unsupportedProperty(Parser.Property_contain_intrinsic_inline_size.rule);
let print_color_adjust =
  unsupportedProperty(Parser.Property_print_color_adjust.rule);
let ruby_overhang = unsupportedProperty(Parser.Property_ruby_overhang.rule);
let timeline_scope = unsupportedProperty(Parser.Property_timeline_scope.rule);
let animation_delay_end =
  unsupportedProperty(Parser.Property_animation_delay_end.rule);
let animation_delay_start =
  unsupportedProperty(Parser.Property_animation_delay_start.rule);
let syntax = unsupportedProperty(Parser.Property_syntax.rule);
let inherits = unsupportedProperty(Parser.Property_inherits.rule);
let initial_value = unsupportedProperty(Parser.Property_initial_value.rule);
let color_rendering =
  unsupportedProperty(Parser.Property_color_rendering.rule);
let vector_effect = unsupportedProperty(Parser.Property_vector_effect.rule);
let cx = unsupportedProperty(Parser.Property_cx.rule);
let cy = unsupportedProperty(Parser.Property_cy.rule);
let d = unsupportedProperty(Parser.Property_d.rule);
let r = unsupportedProperty(Parser.Property_r.rule);
let rx = unsupportedProperty(Parser.Property_rx.rule);
let ry = unsupportedProperty(Parser.Property_ry.rule);
let x = unsupportedProperty(Parser.Property_x.rule);
let y = unsupportedProperty(Parser.Property_y.rule);
let scroll_marker_group =
  unsupportedProperty(Parser.Property_scroll_marker_group.rule);
let container_name_computed =
  unsupportedProperty(Parser.Property_container_name_computed.rule);
let text_edge = unsupportedProperty(Parser.Property_text_edge.rule);
let hyphenate_limit_last =
  unsupportedProperty(Parser.Property_hyphenate_limit_last.rule);
let margin_trim = unsupportedProperty(Parser.Property_margin_trim.rule);
let marker = unsupportedProperty(Parser.Property_marker.rule);
let marker_end = unsupportedProperty(Parser.Property_marker_end.rule);
let marker_mid = unsupportedProperty(Parser.Property_marker_mid.rule);
let marker_start = unsupportedProperty(Parser.Property_marker_start.rule);
let margin_block = unsupportedProperty(Parser.Property_margin_block.rule);
let margin_block_end =
  unsupportedProperty(Parser.Property_margin_block_end.rule);
let margin_block_start =
  unsupportedProperty(Parser.Property_margin_block_start.rule);
let margin_inline = unsupportedProperty(Parser.Property_margin_inline.rule);
let margin_inline_end =
  unsupportedProperty(Parser.Property_margin_inline_end.rule);
let margin_inline_start =
  unsupportedProperty(Parser.Property_margin_inline_start.rule);
let alignment_baseline =
  unsupportedProperty(Parser.Property_alignment_baseline.rule);
let azimuth = unsupportedProperty(Parser.Property_azimuth.rule);
let backdrop_blur = unsupportedProperty(Parser.Property_backdrop_blur.rule);
let behavior = unsupportedProperty(Parser.Property_behavior.rule);
let block_overflow = unsupportedProperty(Parser.Property_block_overflow.rule);
let box_align = unsupportedProperty(Parser.Property_box_align.rule);
let box_direction = unsupportedProperty(Parser.Property_box_direction.rule);
let box_flex = unsupportedProperty(Parser.Property_box_flex.rule);
let box_flex_group = unsupportedProperty(Parser.Property_box_flex_group.rule);
let box_lines = unsupportedProperty(Parser.Property_box_lines.rule);
let box_ordinal_group =
  unsupportedProperty(Parser.Property_box_ordinal_group.rule);
let box_orient = unsupportedProperty(Parser.Property_box_orient.rule);
let box_pack = unsupportedProperty(Parser.Property_box_pack.rule);
let container = unsupportedProperty(Parser.Property_container.rule);
let container_name = unsupportedProperty(Parser.Property_container_name.rule);
let container_type = unsupportedProperty(Parser.Property_container_type.rule);
let cue = unsupportedProperty(Parser.Property_cue.rule);
let cue_after = unsupportedProperty(Parser.Property_cue_after.rule);
let cue_before = unsupportedProperty(Parser.Property_cue_before.rule);
let dominant_baseline =
  unsupportedProperty(Parser.Property_dominant_baseline.rule);
let font_smooth = unsupportedProperty(Parser.Property_font_smooth.rule);
let glyph_orientation_horizontal =
  unsupportedProperty(Parser.Property_glyph_orientation_horizontal.rule);
let glyph_orientation_vertical =
  unsupportedProperty(Parser.Property_glyph_orientation_vertical.rule);
let kerning = unsupportedProperty(Parser.Property_kerning.rule);
let paint_order = unsupportedProperty(Parser.Property_paint_order.rule);
let pause = unsupportedProperty(Parser.Property_pause.rule);
let pause_after = unsupportedProperty(Parser.Property_pause_after.rule);
let pause_before = unsupportedProperty(Parser.Property_pause_before.rule);
let rest = unsupportedProperty(Parser.Property_rest.rule);
let rest_after = unsupportedProperty(Parser.Property_rest_after.rule);
let rest_before = unsupportedProperty(Parser.Property_rest_before.rule);
let voice_family = unsupportedProperty(Parser.Property_voice_family.rule);
let voice_pitch = unsupportedProperty(Parser.Property_voice_pitch.rule);
let voice_range = unsupportedProperty(Parser.Property_voice_range.rule);
let voice_balance = unsupportedProperty(Parser.Property_voice_balance.rule);
let voice_duration = unsupportedProperty(Parser.Property_voice_duration.rule);
let voice_rate = unsupportedProperty(Parser.Property_voice_rate.rule);
let voice_stress = unsupportedProperty(Parser.Property_voice_stress.rule);
let voice_volume = unsupportedProperty(Parser.Property_voice_volume.rule);
let speak = unsupportedProperty(Parser.Property_speak.rule);
let speak_as = unsupportedProperty(Parser.Property_speak_as.rule);
let shape_image_threshold =
  unsupportedProperty(Parser.Property_shape_image_threshold.rule);
let shape_margin = unsupportedProperty(Parser.Property_shape_margin.rule);
let shape_outside = unsupportedProperty(Parser.Property_shape_outside.rule);
let shape_rendering =
  unsupportedProperty(Parser.Property_shape_rendering.rule);
let src = unsupportedProperty(Parser.Property_src.rule);
let stroke_dashoffset =
  unsupportedProperty(Parser.Property_stroke_dashoffset.rule);
let unicode_bidi = unsupportedProperty(Parser.Property_unicode_bidi.rule);
let unicode_range = unsupportedProperty(Parser.Property_unicode_range.rule);
let text_autospace = unsupportedProperty(Parser.Property_text_autospace.rule);
let text_blink = unsupportedProperty(Parser.Property_text_blink.rule);
let text_justify_trim =
  unsupportedProperty(Parser.Property_text_justify_trim.rule);
let text_kashida = unsupportedProperty(Parser.Property_text_kashida.rule);
let text_kashida_space =
  unsupportedProperty(Parser.Property_text_kashida_space.rule);
let text_anchor = unsupportedProperty(Parser.Property_text_anchor.rule);
let text_rendering = unsupportedProperty(Parser.Property_text_rendering.rule);
let text_size_adjust =
  unsupportedProperty(Parser.Property_text_size_adjust.rule);
let scroll_behavior =
  unsupportedProperty(Parser.Property_scroll_behavior.rule);
let scroll_margin = unsupportedProperty(Parser.Property_scroll_margin.rule);
let scroll_margin_block =
  unsupportedProperty(Parser.Property_scroll_margin_block.rule);
let scroll_margin_block_end =
  unsupportedProperty(Parser.Property_scroll_margin_block_end.rule);
let scroll_margin_block_start =
  unsupportedProperty(Parser.Property_scroll_margin_block_start.rule);
let scroll_margin_bottom =
  unsupportedProperty(Parser.Property_scroll_margin_bottom.rule);
let scroll_margin_inline =
  unsupportedProperty(Parser.Property_scroll_margin_inline.rule);
let scroll_margin_inline_end =
  unsupportedProperty(Parser.Property_scroll_margin_inline_end.rule);
let scroll_margin_inline_start =
  unsupportedProperty(Parser.Property_scroll_margin_inline_start.rule);
let scroll_margin_left =
  unsupportedProperty(Parser.Property_scroll_margin_left.rule);
let scroll_margin_right =
  unsupportedProperty(Parser.Property_scroll_margin_right.rule);
let scroll_margin_top =
  unsupportedProperty(Parser.Property_scroll_margin_top.rule);
let scroll_padding = unsupportedProperty(Parser.Property_scroll_padding.rule);
let scroll_padding_block =
  unsupportedProperty(Parser.Property_scroll_padding_block.rule);
let scroll_padding_block_end =
  unsupportedProperty(Parser.Property_scroll_padding_block_end.rule);
let scroll_padding_block_start =
  unsupportedProperty(Parser.Property_scroll_padding_block_start.rule);
let scroll_padding_bottom =
  unsupportedProperty(Parser.Property_scroll_padding_bottom.rule);
let scroll_padding_inline =
  unsupportedProperty(Parser.Property_scroll_padding_inline.rule);
let scroll_padding_inline_end =
  unsupportedProperty(Parser.Property_scroll_padding_inline_end.rule);
let scroll_padding_inline_start =
  unsupportedProperty(Parser.Property_scroll_padding_inline_start.rule);
let scroll_padding_left =
  unsupportedProperty(Parser.Property_scroll_padding_left.rule);
let scroll_padding_right =
  unsupportedProperty(Parser.Property_scroll_padding_right.rule);
let scroll_padding_top =
  unsupportedProperty(Parser.Property_scroll_padding_top.rule);
let scroll_snap_align =
  unsupportedProperty(Parser.Property_scroll_snap_align.rule);
let scroll_snap_coordinate =
  unsupportedProperty(Parser.Property_scroll_snap_coordinate.rule);
let scroll_snap_destination =
  unsupportedProperty(Parser.Property_scroll_snap_destination.rule);
let scroll_snap_points_x =
  unsupportedProperty(Parser.Property_scroll_snap_points_x.rule);
let scroll_snap_points_y =
  unsupportedProperty(Parser.Property_scroll_snap_points_y.rule);
let scroll_snap_stop =
  unsupportedProperty(Parser.Property_scroll_snap_stop.rule);
let scroll_snap_type =
  unsupportedProperty(Parser.Property_scroll_snap_type.rule);
let scroll_snap_type_x =
  unsupportedProperty(Parser.Property_scroll_snap_type_x.rule);
let scroll_snap_type_y =
  unsupportedProperty(Parser.Property_scroll_snap_type_y.rule);
let view_timeline = unsupportedProperty(Parser.Property_view_timeline.rule);
let view_timeline_axis =
  unsupportedProperty(Parser.Property_view_timeline_axis.rule);
let view_timeline_inset =
  unsupportedProperty(Parser.Property_view_timeline_inset.rule);
let view_timeline_name =
  unsupportedProperty(Parser.Property_view_timeline_name.rule);
let view_transition_name =
  unsupportedProperty(Parser.Property_view_transition_name.rule);
let word_space_transform =
  unsupportedProperty(Parser.Property_word_space_transform.rule);

let properties = [
  ("accent-color", accent_color),
  ("align-content", align_content),
  ("align-items", align_items),
  ("align-self", align_self),
  ("alignment-baseline", alignment_baseline),
  ("all", all),
  ("anchor-name", anchor_name),
  ("anchor-scope", anchor_scope),
  ("animation-composition", animation_composition),
  ("animation-delay", animation_delay),
  ("animation-delay-end", animation_delay_end),
  ("animation-delay-start", animation_delay_start),
  ("animation-direction", animation_direction),
  ("animation-duration", animation_duration),
  ("animation-fill-mode", animation_fill_mode),
  ("animation-iteration-count", animation_iteration_count),
  ("animation-name", animation_name),
  ("animation-play-state", animation_play_state),
  ("animation-range", animation_range),
  ("animation-range-end", animation_range_end),
  ("animation-range-start", animation_range_start),
  ("animation-timeline", animation_timeline),
  ("animation-timing-function", animation_timing_function),
  ("animation", animation),
  ("appearance", appearance),
  ("aspect-ratio", aspect_ratio),
  ("azimuth", azimuth),
  ("backdrop-blur", backdrop_blur),
  ("backdrop-filter", backdrop_filter),
  ("backface-visibility", backface_visibility),
  ("background-attachment", background_attachment),
  ("background-blend-mode", background_blend_mode),
  ("background-clip", background_clip),
  ("background-color", background_color),
  ("background-image", background_image),
  ("background-origin", background_origin),
  ("background-position-x", background_position_x),
  ("background-position-y", background_position_y),
  ("background-position", background_position),
  ("background-repeat", background_repeat),
  ("background-size", background_size),
  ("background", background),
  ("baseline-shift", baseline_shift),
  ("behavior", behavior),
  ("bleed", bleed),
  ("block-overflow", block_overflow),
  ("block-size", block_size),
  ("border-block-color", border_block_color),
  ("border-block-end-color", border_block_end_color),
  ("border-block-end-style", border_block_end_style),
  ("border-block-end-width", border_block_end_width),
  ("border-block-end", border_block_end),
  ("border-block-start-color", border_block_start_color),
  ("border-block-start-style", border_block_start_style),
  ("border-block-start-width", border_block_start_width),
  ("border-block-start", border_block_start),
  ("border-block-style", border_block_style),
  ("border-block-width", border_block_width),
  ("border-block", border_block),
  ("border-bottom-color", border_bottom_color),
  ("border-bottom-left-radius", border_bottom_left_radius),
  ("border-bottom-right-radius", border_bottom_right_radius),
  ("border-bottom-style", border_bottom_style),
  ("border-bottom-width", border_bottom_width),
  ("border-bottom", border_bottom),
  ("border-collapse", border_collapse),
  ("border-color", border_color),
  ("border-end-end-radius", border_end_end_radius),
  ("border-end-start-radius", border_end_start_radius),
  ("border-image-outset", border_image_outset),
  ("border-image-repeat", border_image_repeat),
  ("border-image-slice", border_image_slice),
  ("border-image-source", border_image_source),
  ("border-image-width", border_image_width),
  ("border-image", border_image),
  ("border-inline-color", border_inline_color),
  ("border-inline-end-color", border_inline_end_color),
  ("border-inline-end-style", border_inline_end_style),
  ("border-inline-end-width", border_inline_end_width),
  ("border-inline-end", border_inline_end),
  ("border-inline-start-color", border_inline_start_color),
  ("border-inline-start-style", border_inline_start_style),
  ("border-inline-start-width", border_inline_start_width),
  ("border-inline-start", border_inline_start),
  ("border-inline-style", border_inline_style),
  ("border-inline-width", border_inline_width),
  ("border-inline", border_inline),
  ("border-left-color", border_left_color),
  ("border-left-style", border_left_style),
  ("border-left-width", border_left_width),
  ("border-left", border_left),
  ("border-radius", border_radius),
  ("border-right-color", border_right_color),
  ("border-right-style", border_right_style),
  ("border-right-width", border_right_width),
  ("border-right", border_right),
  ("border-spacing", border_spacing),
  ("border-start-end-radius", border_start_end_radius),
  ("border-start-start-radius", border_start_start_radius),
  ("border-style", border_style),
  ("border-top-color", border_top_color),
  ("border-top-left-radius", border_top_left_radius),
  ("border-top-right-radius", border_top_right_radius),
  ("border-top-style", border_top_style),
  ("border-top-width", border_top_width),
  ("border-top", border_top),
  ("border-width", border_width),
  ("border", border),
  ("bottom", bottom),
  ("box-align", box_align),
  ("box-decoration-break", box_decoration_break),
  ("box-direction", box_direction),
  ("box-flex", box_flex),
  ("box-flex-group", box_flex_group),
  ("box-lines", box_lines),
  ("box-ordinal-group", box_ordinal_group),
  ("box-orient", box_orient),
  ("box-pack", box_pack),
  ("box-shadow", box_shadow),
  ("box-sizing", box_sizing),
  ("break-after", break_after),
  ("break-before", break_before),
  ("break-inside", break_inside),
  ("caption-side", caption_side),
  ("caret-color", caret_color),
  ("clear", clear),
  ("clip-path", clip_path),
  ("clip-rule", clip_rule),
  ("clip", clip),
  ("content", content),
  ("color-adjust", color_adjust),
  ("color-interpolation-filters", color_interpolation_filters),
  ("color-interpolation", color_interpolation),
  ("color-rendering", color_rendering),
  ("color-scheme", color_scheme),
  ("color", color),
  ("column-count", column_count),
  ("column-fill", column_fill),
  ("column-gap", column_gap),
  ("column-rule-color", column_rule_color),
  ("column-rule-style", column_rule_style),
  ("column-rule-width", column_rule_width),
  ("column-rule", column_rule),
  ("column-span", column_span),
  ("column-width", column_width),
  ("columns", columns),
  ("contain", contain),
  ("container", container),
  ("container-name", container_name),
  ("container-name-computed", container_name_computed),
  ("container-type", container_type),
  ("contain-intrinsic-block-size", contain_intrinsic_block_size),
  ("contain-intrinsic-height", contain_intrinsic_height),
  ("contain-intrinsic-inline-size", contain_intrinsic_inline_size),
  ("contain-intrinsic-size", contain_intrinsic_size),
  ("contain-intrinsic-width", contain_intrinsic_width),
  ("content-visibility", content_visibility),
  ("content", content),
  ("counter-increment", counter_increment),
  ("counter-reset", counter_reset),
  ("counter-set", counter_set),
  ("cue", cue),
  ("cue-after", cue_after),
  ("cue-before", cue_before),
  ("cursor", cursor),
  ("cx", cx),
  ("cy", cy),
  ("d", d),
  ("direction", direction),
  ("display", display),
  ("dominant-baseline", dominant_baseline),
  ("empty-cells", empty_cells),
  ("field-sizing", field_sizing),
  ("fill-opacity", fill_opacity),
  ("fill-rule", fill_rule),
  ("fill", fill),
  ("filter", filter),
  ("flex", flex),
  ("flex-basis", flex_basis),
  ("flex-direction", flex_direction),
  ("flex-flow", flex_flow),
  ("flex-grow", flex_grow),
  ("flex-shrink", flex_shrink),
  ("flex-wrap", flex_wrap),
  ("float", float),
  ("flood-color", flood_color),
  ("flood-opacity", flood_opacity),
  ("font-family", font_family),
  ("font-display", font_display),
  ("font-feature-settings", font_feature_settings),
  ("font-kerning", font_kerning),
  ("font-language-override", font_language_override),
  ("font-optical-sizing", font_optical_sizing),
  ("font-size-adjust", font_size_adjust),
  ("font-size", font_size),
  ("font-palette", font_palette),
  ("font-smooth", font_smooth),
  ("font-stretch", font_stretch),
  ("font-style", font_style),
  ("font-synthesis-position", font_synthesis_position),
  ("font-synthesis-small-caps", font_synthesis_small_caps),
  ("font-synthesis-style", font_synthesis_style),
  ("font-synthesis-weight", font_synthesis_weight),
  ("font-synthesis", font_synthesis),
  ("font-variant-alternates", font_variant_alternates),
  ("font-variant-caps", font_variant_caps),
  ("font-variant-east-asian", font_variant_east_asian),
  ("font-variant-ligatures", font_variant_ligatures),
  ("font-variant-numeric", font_variant_numeric),
  ("font-variant-position", font_variant_position),
  ("font-variant-emoji", font_variant_emoji),
  ("font-variant", font_variant),
  ("font-variation-settings", font_variation_settings),
  ("font-weight", font_weight),
  ("font", font),
  ("gap", gap),
  ("glyph-orientation-horizontal", glyph_orientation_horizontal),
  ("glyph-orientation-vertical", glyph_orientation_vertical),
  ("grid-area", grid_area),
  ("grid-auto-columns", grid_auto_columns),
  ("grid-auto-flow", grid_auto_flow),
  ("grid-auto-rows", grid_auto_rows),
  ("grid-column-end", grid_column_end),
  ("grid-column-gap", grid_column_gap),
  ("grid-column-start", grid_column_start),
  ("grid-column", grid_column),
  ("grid-gap", grid_gap),
  ("grid-row-end", grid_row_end),
  ("grid-row-gap", grid_row_gap),
  ("grid-row-start", grid_row_start),
  ("grid-row", grid_row),
  ("grid-template-areas", grid_template_areas),
  ("grid-template-columns", grid_template_columns),
  ("grid-template-rows", grid_template_rows),
  ("grid-template", grid_template),
  ("grid", grid),
  ("hanging-punctuation", hanging_punctuation),
  ("height", height),
  ("hyphenate-character", hyphenate_character),
  ("hyphenate-limit-chars", hyphenate_limit_chars),
  ("hyphenate-limit-lines", hyphenate_limit_lines),
  ("hyphenate-limit-last", hyphenate_limit_last),
  ("hyphenate-limit-zone", hyphenate_limit_zone),
  ("hyphens", hyphens),
  ("image-orientation", image_orientation),
  ("image-rendering", image_rendering),
  ("image-resolution", image_resolution),
  ("ime-mode", ime_mode),
  ("inherits", inherits),
  ("initial-letter-align", initial_letter_align),
  ("initial-letter", initial_letter),
  ("initial-value", initial_value),
  ("inline-size", inline_size),
  ("inset-area", inset_area),
  ("inset-block-end", inset_block_end),
  ("inset-block-start", inset_block_start),
  ("inset-block", inset_block),
  ("inset-inline-end", inset_inline_end),
  ("inset-inline-start", inset_inline_start),
  ("inset-inline", inset_inline),
  ("inset", inset),
  ("interpolate-size", interpolate_size),
  ("isolation", isolation),
  ("justify-content", justify_content),
  ("justify-items", justify_items),
  ("justify-self", justify_self),
  ("kerning", kerning),
  ("layout-grid-char", layout_grid_char),
  ("layout-grid-line", layout_grid_line),
  ("layout-grid-mode", layout_grid_mode),
  ("layout-grid-type", layout_grid_type),
  ("layout-grid", layout_grid),
  ("left", left),
  ("letter-spacing", letter_spacing),
  ("lighting-color", lighting_color),
  ("line-break", line_break),
  ("line-clamp", line_clamp),
  ("line-height-step", line_height_step),
  ("line-height", line_height),
  ("list-style-image", list_style_image),
  ("list-style-position", list_style_position),
  ("list-style-type", list_style_type),
  ("list-style", list_style),
  ("margin-block", margin_block),
  ("margin-block-end", margin_block_end),
  ("margin-block-start", margin_block_start),
  ("margin-bottom", margin_bottom),
  ("margin-inline", margin_inline),
  ("margin-inline-end", margin_inline_end),
  ("margin-inline-start", margin_inline_start),
  ("margin-left", margin_left),
  ("margin-right", margin_right),
  ("margin-top", margin_top),
  ("margin-trim", margin_trim),
  ("margin", margin),
  ("marker", marker),
  ("marker-end", marker_end),
  ("marker-mid", marker_mid),
  ("marker-start", marker_start),
  ("marks", marks),
  ("mask-border-mode", mask_border_mode),
  ("mask-border-outset", mask_border_outset),
  ("mask-border-repeat", mask_border_repeat),
  ("mask-border-slice", mask_border_slice),
  ("mask-border-source", mask_border_source),
  ("mask-border-width", mask_border_width),
  ("mask-clip", mask_clip),
  ("mask-composite", mask_composite),
  ("mask-image", mask_image),
  ("mask-mode", mask_mode),
  ("mask-origin", mask_origin),
  ("mask-position", mask_position),
  ("mask-repeat", mask_repeat),
  ("mask-size", mask_size),
  ("mask-type", mask_type),
  ("math-depth", math_depth),
  ("math-shift", math_shift),
  ("math-style", math_style),
  ("max-block-size", max_block_size),
  ("max-height", max_height),
  ("max-inline-size", max_inline_size),
  ("max-lines", max_lines),
  ("max-width", max_width),
  ("min-block-size", min_block_size),
  ("min-height", min_height),
  ("min-inline-size", min_inline_size),
  ("min-width", min_width),
  ("mix-blend-mode", mix_blend_mode),
  ("nav-down", nav_down),
  ("nav-left", nav_left),
  ("nav-right", nav_right),
  ("nav-up", nav_up),
  ("object-fit", object_fit),
  ("object-position", object_position),
  ("offset-anchor", offset_anchor),
  ("offset-distance", offset_distance),
  ("offset-path", offset_path),
  ("offset-position", offset_position),
  ("offset-rotate", offset_rotate),
  ("offset", offset),
  ("opacity", opacity),
  ("order", order),
  ("orphans", orphans),
  ("outline", outline),
  ("outline-color", outline_color),
  ("outline-offset", outline_offset),
  ("outline-style", outline_style),
  ("outline-width", outline_width),
  ("overlay", overlay),
  ("overflow-anchor", overflow_anchor),
  ("overflow-block", overflow_block),
  ("overflow-clip-margin", overflow_clip_margin),
  ("overflow-inline", overflow_inline),
  ("overflow-wrap", overflow_wrap),
  ("overflow-x", overflow_x),
  ("overflow-y", overflow_y),
  ("overflow", overflow),
  ("padding-block-end", padding_block_end),
  ("padding-block-start", padding_block_start),
  ("padding-block", padding_block),
  ("padding-bottom", padding_bottom),
  ("padding-inline-end", padding_inline_end),
  ("padding-inline-start", padding_inline_start),
  ("padding-inline", padding_inline),
  ("padding-left", padding_left),
  ("padding-right", padding_right),
  ("padding-top", padding_top),
  ("padding", padding),
  ("page", page),
  ("page-break-after", page_break_after),
  ("paint-order", paint_order),
  ("pause", pause),
  ("pause-after", pause_after),
  ("pause-before", pause_before),
  ("page-break-before", page_break_before),
  ("page-break-inside", page_break_inside),
  ("perspective-origin", perspective_origin),
  ("perspective", perspective),
  ("pointer-events", pointer_events),
  ("position", position),
  ("position-anchor", position_anchor),
  ("print-color-adjust", print_color_adjust),
  ("position-area", position_area),
  ("position-try", position_try),
  ("position-try-fallbacks", position_try_fallbacks),
  ("position-try-options", position_try_options),
  ("position-visibility", position_visibility),
  ("r", r),
  ("reading-flow", reading_flow),
  ("resize", resize),
  ("rest", rest),
  ("rest-after", rest_after),
  ("rest-before", rest_before),
  ("right", right),
  ("rotate", rotate),
  ("row-gap", row_gap),
  ("ruby-overhang", ruby_overhang),
  ("rx", rx),
  ("ry", ry),
  ("scale", scale),
  ("shape-image-threshold", shape_image_threshold),
  ("shape-margin", shape_margin),
  ("shape-outside", shape_outside),
  ("shape-rendering", shape_rendering),
  ("scrollbar-3dlight-color", scrollbar_3dlight_color),
  ("scrollbar-arrow-color", scrollbar_arrow_color),
  ("scrollbar-base-color", scrollbar_base_color),
  ("scrollbar-color", scrollbar_color),
  ("scrollbar-darkshadow-color", scrollbar_darkshadow_color),
  ("scrollbar-face-color", scrollbar_face_color),
  ("scrollbar-highlight-color", scrollbar_highlight_color),
  ("scrollbar-shadow-color", scrollbar_shadow_color),
  ("scrollbar-track-color", scrollbar_track_color),
  ("scrollbar-width", scrollbar_width),
  ("scrollbar-gutter", scrollbar_gutter),
  ("speak", speak),
  ("speak-as", speak_as),
  ("src", src),
  ("scroll-behavior", scroll_behavior),
  ("scroll-margin", scroll_margin),
  ("scroll-margin-block", scroll_margin_block),
  ("scroll-margin-block-end", scroll_margin_block_end),
  ("scroll-margin-block-start", scroll_margin_block_start),
  ("scroll-margin-bottom", scroll_margin_bottom),
  ("scroll-margin-inline", scroll_margin_inline),
  ("scroll-margin-inline-end", scroll_margin_inline_end),
  ("scroll-margin-inline-start", scroll_margin_inline_start),
  ("scroll-margin-left", scroll_margin_left),
  ("scroll-margin-right", scroll_margin_right),
  ("scroll-margin-top", scroll_margin_top),
  ("scroll-marker-group", scroll_marker_group),
  ("scroll-padding", scroll_padding),
  ("scroll-padding-block", scroll_padding_block),
  ("scroll-padding-block-end", scroll_padding_block_end),
  ("scroll-padding-block-start", scroll_padding_block_start),
  ("scroll-padding-bottom", scroll_padding_bottom),
  ("scroll-padding-inline", scroll_padding_inline),
  ("scroll-padding-inline-end", scroll_padding_inline_end),
  ("scroll-padding-inline-start", scroll_padding_inline_start),
  ("scroll-padding-left", scroll_padding_left),
  ("scroll-padding-right", scroll_padding_right),
  ("scroll-padding-top", scroll_padding_top),
  ("scroll-snap-align", scroll_snap_align),
  ("scroll-snap-coordinate", scroll_snap_coordinate),
  ("scroll-snap-destination", scroll_snap_destination),
  ("scroll-snap-points-x", scroll_snap_points_x),
  ("scroll-snap-points-y", scroll_snap_points_y),
  ("scroll-snap-stop", scroll_snap_stop),
  ("scroll-snap-type", scroll_snap_type),
  ("scroll-snap-type-x", scroll_snap_type_x),
  ("scroll-snap-type-y", scroll_snap_type_y),
  ("size", size),
  ("scroll-start", scroll_start),
  ("scroll-start-block", scroll_start_block),
  ("scroll-start-inline", scroll_start_inline),
  ("scroll-start-x", scroll_start_x),
  ("scroll-start-y", scroll_start_y),
  ("scroll-start-target", scroll_start_target),
  ("scroll-start-target-block", scroll_start_target_block),
  ("scroll-start-target-inline", scroll_start_target_inline),
  ("scroll-start-target-x", scroll_start_target_x),
  ("scroll-start-target-y", scroll_start_target_y),
  ("scroll-timeline", scroll_timeline),
  ("scroll-timeline-axis", scroll_timeline_axis),
  ("scroll-timeline-name", scroll_timeline_name),
  ("stop-color", stop_color),
  ("stop-opacity", stop_opacity),
  ("stroke", stroke),
  ("stroke-dasharray", stroke_dasharray),
  ("stroke-dashoffset", stroke_dashoffset),
  ("stroke-linecap", stroke_linecap),
  ("stroke-linejoin", stroke_linejoin),
  ("stroke-miterlimit", stroke_miterlimit),
  ("stroke-opacity", stroke_opacity),
  ("stroke-width", stroke_width),
  ("syntax", syntax),
  ("tab-size", tab_size),
  ("table-layout", table_layout),
  ("text-align-last", text_align_last),
  ("text-align", text_align),
  ("text-align-all", text_align_all),
  ("text-anchor", text_anchor),
  ("text-autospace", text_autospace),
  ("text-blink", text_blink),
  ("text-box-edge", text_box_edge),
  ("text-box-trim", text_box_trim),
  ("text-combine-upright", text_combine_upright),
  ("text-decoration-color", text_decoration_color),
  ("text-decoration-line", text_decoration_line),
  ("text-decoration-skip-ink", text_decoration_skip_ink),
  ("text-decoration-skip", text_decoration_skip),
  ("text-decoration-style", text_decoration_style),
  ("text-decoration-thickness", text_decoration_thickness),
  ("text-decoration", text_decoration),
  ("text-edge", text_edge),
  ("text-decoration-skip-box", text_decoration_skip_box),
  ("text-decoration-skip-inset", text_decoration_skip_inset),
  ("text-decoration-skip-self", text_decoration_skip_self),
  ("text-decoration-skip-spaces", text_decoration_skip_spaces),
  ("text-emphasis-color", text_emphasis_color),
  ("text-emphasis-position", text_emphasis_position),
  ("text-emphasis-style", text_emphasis_style),
  ("text-emphasis", text_emphasis),
  ("text-indent", text_indent),
  ("text-justify", text_justify),
  ("text-justify-trim", text_justify_trim),
  ("text-kashida", text_kashida),
  ("text-kashida-space", text_kashida_space),
  ("text-orientation", text_orientation),
  ("text-overflow", text_overflow),
  ("text-rendering", text_rendering),
  ("text-shadow", text_shadow),
  ("text-size-adjust", text_size_adjust),
  ("text-spacing-trim", text_spacing_trim),
  ("text-transform", text_transform),
  ("text-underline-offset", text_underline_offset),
  ("text-underline-position", text_underline_position),
  ("text-wrap", text_wrap),
  ("text-wrap-mode", text_wrap_mode),
  ("text-wrap-style", text_wrap_style),
  ("timeline-scope", timeline_scope),
  ("top", top),
  ("touch-action", touch_action),
  ("transform-box", transform_box),
  ("transform-origin", transform_origin),
  ("transform-style", transform_style),
  ("transform", transform),
  ("transition-behavior", transition_behavior),
  ("transition-delay", transition_delay),
  ("transition-duration", transition_duration),
  ("transition-property", transition_property),
  ("transition-timing-function", transition_timing_function),
  ("transition", transition),
  ("translate", translate),
  ("unicode-bidi", unicode_bidi),
  ("unicode-range", unicode_range),
  ("user-select", user_select),
  ("vector-effect", vector_effect),
  ("vertical-align", vertical_align),
  ("view-timeline", view_timeline),
  ("view-timeline-axis", view_timeline_axis),
  ("view-timeline-inset", view_timeline_inset),
  ("view-timeline-name", view_timeline_name),
  ("view-transition-name", view_transition_name),
  ("visibility", visibility),
  ("voice-balance", voice_balance),
  ("voice-duration", voice_duration),
  ("voice-family", voice_family),
  ("voice-pitch", voice_pitch),
  ("voice-range", voice_range),
  ("voice-rate", voice_rate),
  ("voice-stress", voice_stress),
  ("voice-volume", voice_volume),
  ("will-change", will_change),
  ("white-space", white_space),
  ("white-space-collapse", white_space_collapse),
  ("widows", widows),
  ("width", width),
  ("word-break", word_break),
  ("word-space-transform", word_space_transform),
  ("word-spacing", word_spacing),
  ("word-wrap", word_wrap),
  ("writing-mode", writing_mode),
  ("x", x),
  ("y", y),
  ("z-index", z_index),
  ("zoom", zoom),
];

let render_when_unsupported_features = (~loc, property, value) => {
  /* Transform property name to camelCase since we bind to emotion with the Object API */
  let propertyExpr = property |> to_camel_case |> render_string(~loc);
  let valueExpr =
    String_interpolation.transform(~loc, ~delimiter="js", value);

  [%expr CSS.unsafe([%e propertyExpr], [%e valueExpr])];
};

let findProperty = name => {
  properties |> List.find_opt(((key, _)) => key == name);
};

let isVariableDeclaration = name => String.sub(name, 0, 2) == "--";

let render_variable_declaration = (~loc, property, value) => {
  [%expr
   CSS.unsafe(
     [%e render_string(~loc, property)],
     [%e render_string(~loc, value)],
   )
  ];
};

let render_to_expr = (~loc, property, value, important) => {
  let (let.ok) = Result.bind;
  let.ok parse_and_transform =
    switch (findProperty(property)) {
    | Some((_, parse_and_transform)) => Ok(parse_and_transform)
    | None => Error(`Property_not_found)
    };

  switch (parse_and_transform(~loc, value)) {
  | Ok(expr) when important =>
    Ok(expr |> List.map(expr => [%expr CSS.important([%e expr])]))
  | Ok(expr) => Ok(expr)
  | Error(err) => Error(`Invalid_value(err))
  | exception (Invalid_value(v)) => Error(`Invalid_value(v))
  };
};

let render = (~loc: Location.t, property, value, important) =>
  if (isVariableDeclaration(property)) {
    Ok([render_variable_declaration(~loc, property, value)]);
  } else {
    switch (value) {
    | "inherit"
    | "initial"
    | "unset"
    | "revert"
    | "revert-layer" =>
      Ok([
        [%expr
          CSS.unsafe(
            [%e property |> to_camel_case |> render_string(~loc)],
            [%e render_string(~loc, value)],
          )
        ],
      ])
    | value =>
      switch (render_to_expr(~loc, property, value, important)) {
      | Ok(value) => Ok(value)
      | Error(`Invalid_value(_)) as x => x
      | exception Impossible_state => Error(`Impossible_state)
      | Error(_)
      | exception Unsupported_feature =>
        switch (Parser.check_property(~loc, ~name=property, value)) {
        | Ok () =>
          Ok([render_when_unsupported_features(~loc, property, value)])
        | Error((_, error)) => Error(error)
        }
      }
    };
  };
