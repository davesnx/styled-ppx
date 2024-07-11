open Ppxlib;

module Builder = Ppxlib.Ast_builder.Default;

module Standard = Css_property_parser.Standard;
module Property_parser = Css_property_parser.Parser;
module Types = Property_parser.Types;

let txt = (~loc, txt) => {Location.loc, txt};

let (let.ok) = Result.bind;

/* TODO: Separate unsupported_feature from bs-css doesn't support or can't interpolate on those */
/* TODO: Add payload on those exceptions */
exception Unsupported_feature;

exception Invalid_value(string);

let id = Fun.id;

/* Why this type contains so much when only `string_to_expr` is used? */
type transform('ast, 'value) = {
  ast_of_string: string => result('ast, string),
  ast_to_expr: (~loc: Location.t, 'ast) => list(Parsetree.expression),
  string_to_expr:
    (~loc: Location.t, string) => result(list(Parsetree.expression), string),
};

let add_CSS_rule_constraint = (~loc, expr) => {
  let typ =
    Builder.ptyp_constr(~loc, {txt: Ldot(Lident("CSS"), "rule"), loc}, []);
  Builder.pexp_constraint(~loc, expr, typ);
};

/* TODO: emit is better to keep value_of_ast and value_to_expr in the same fn */
let emit = (property, value_of_ast, value_to_expr) => {
  let ast_of_string = Css_property_parser.Parser.parse(property);
  let ast_to_expr = (~loc, ast) =>
    value_of_ast(~loc, ast) |> value_to_expr(~loc);
  let string_to_expr = (~loc, string) =>
    ast_of_string(string) |> Result.map(ast_to_expr(~loc));

  {ast_of_string, ast_to_expr, string_to_expr};
};

let emit_shorthand = (parser, mapper, value_to_expr) => {
  let ast_of_string = Css_property_parser.Parser.parse(parser);
  let ast_to_expr = (~loc, ast) =>
    ast |> List.map(mapper(~loc)) |> value_to_expr(~loc);
  let string_to_expr = (~loc, string) =>
    ast_of_string(string) |> Result.map(ast_to_expr(~loc));

  {ast_of_string, ast_to_expr, string_to_expr};
};

let render_option = (~loc, f) =>
  fun
  | Some(v) => [%expr Some([%e f(~loc, v)])]
  | None => [%expr None];

let list_to_longident = vars => vars |> String.concat(".") |> Longident.parse;

let render_variable = (~loc, name) =>
  list_to_longident(name) |> txt(~loc) |> Builder.pexp_ident(~loc);

let transform_with_variable = (parser, mapper, value_to_expr) => {
  Css_property_parser.(
    emit(
      Combinator.xor([
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
        | {pexp_desc: Pexp_ident({txt: Ldot(Lident("CSS"), _), _}), _} as exp =>
          value_to_expr(~loc, exp)
        | {pexp_desc: Pexp_ident(_), pexp_loc: _, _} as exp =>
          value_to_expr(~loc, exp)
          |> List.map(add_CSS_rule_constraint(~loc))
        | exp => value_to_expr(~loc, exp)
        }
      },
    )
  );
};

/* Monomoprhipc properties are the ones that can only have one representation
    of the value (and it's one argument also) which it's also possible to interpolate on them.

   For example: Property_parser.property_font_size => CSS.fontSize
   */
let monomorphic = (parser, property_renderer, value_renderer) =>
  transform_with_variable(parser, value_renderer, (~loc, value) =>
    [[%expr [%e property_renderer(~loc)]([%e value])]]
  );

/* Polymorphic is when a property can have multiple representations and/or can generate multiple declarations */
let polymorphic = (property, value_to_expr) => {
  emit(property, (~loc as _, ast) => ast, value_to_expr);
};

/* Triggers Unsupported_feature and it's rendered as a string */
let unsupportedValue = (parser, property) =>
  transform_with_variable(
    parser,
    (~loc as _, _) => raise(Unsupported_feature),
    (~loc, arg) => [[%expr [%e property(~loc)]([%e arg])]],
  );

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

let render_css_global_values = (~loc, name, value) => {
  let.ok value =
    Css_property_parser.Parser.parse(
      Css_property_parser.Standard.css_wide_keywords,
      value,
    );

  let value =
    switch (value) {
    | `Inherit => [%expr {js|inherit|js}]
    | `Initial => [%expr {js|initial|js}]
    | `Unset => [%expr {js|unset|js}]
    | `Revert => [%expr {js|revert|js}]
    | `RevertLayer => [%expr {js|revert-layer|js}]
    };

  Ok([
    [%expr
      CSS.unsafe(
        [%e name |> to_camel_case |> render_string(~loc)],
        [%e value],
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
  | `Match_parent => id([%expr `matchParent])
  | `Justify_all => id([%expr `justifyAll])
  | `Wrap_reverse => id([%expr `wrapReverse])
  | `Manual => id([%expr `manual])
  | `Inter_word => id([%expr `interWord])
  | `Inter_character => id([%expr `interCharacter])
  | `Sub => id([%expr `sub])
  | `Super => id([%expr `super])
  | `All_small_caps => id([%expr `allSmallCaps])
  | `Petite_caps => id([%expr `petiteCaps])
  | `All_petite_caps => id([%expr `allPetiteCaps])
  | `Unicase => id([%expr `unicase])
  | `Titling_caps => id([%expr `titlingCaps])
  | `Text => id([%expr `text])
  | `Emoji => id([%expr `emoji])
  | `Unicode => id([%expr `unicode])
  | `All => id([%expr `all])
  | `Fill_box => id([%expr `fillBox])
  | `Stroke_box => id([%expr `strokeBox])
  | `View_box => id([%expr `viewBox])
  | `Smooth => id([%expr `smooth])
  | `High_quality => id([%expr `highQuality])
  | `Pixelated => id([%expr `pixelated])
  | `Crisp_edges => id([%expr `crispEdges])
  | `FitContent => raise(Unsupported_feature)
  | `Full_width => raise(Unsupported_feature)
  | `Full_size_kana => raise(Unsupported_feature);

// TODO: all of them could be float, but bs-css doesn't support it
let render_length = (~loc) =>
  fun
  | `Cap(_n) => raise(Unsupported_feature)
  | `Ch(n) => [%expr `ch([%e render_float(~loc, n)])]
  | `Cm(n) => [%expr `cm([%e render_float(~loc, n)])]
  | `Cqw(n) => [%expr `cqw([%e render_float(~loc, n)])]
  | `Cqh(n) => [%expr `cqh([%e render_float(~loc, n)])]
  | `Cqi(n) => [%expr `cqi([%e render_float(~loc, n)])]
  | `Cqb(n) => [%expr `cqb([%e render_float(~loc, n)])]
  | `Cqmin(n) => [%expr `cqmin([%e render_float(~loc, n)])]
  | `Cqmax(n) => [%expr `cqmax([%e render_float(~loc, n)])]
  | `Em(n) => [%expr `em([%e render_float(~loc, n)])]
  | `Ex(n) => [%expr `ex([%e render_float(~loc, n)])]
  | `Ic(_n) => raise(Unsupported_feature)
  | `In(_n) => raise(Unsupported_feature)
  | `Lh(_n) => raise(Unsupported_feature)
  | `Mm(n) => [%expr `mm([%e render_float(~loc, n)])]
  | `Pc(n) => [%expr `pc([%e render_float(~loc, n)])]
  | `Pt(n) => [%expr `pt([%e render_integer(~loc, n |> Float.to_int)])]
  | `Px(n) => [%expr `pxFloat([%e render_float(~loc, n)])]
  | `Q(_n) => raise(Unsupported_feature)
  | `Rem(n) => [%expr `rem([%e render_float(~loc, n)])]
  | `Rlh(_n) => raise(Unsupported_feature)
  | `Vb(_n) => raise(Unsupported_feature)
  | `Vh(n) => [%expr `vh([%e render_float(~loc, n)])]
  | `Vi(_n) => raise(Unsupported_feature)
  | `Vmax(n) => [%expr `vmax([%e render_float(~loc, n)])]
  | `Vmin(n) => [%expr `vmin([%e render_float(~loc, n)])]
  | `Vw(n) => [%expr `vw([%e render_float(~loc, n)])]
  | `Zero => [%expr `zero];

let rec render_function_calc = (~loc, calc_sum) => {
  render_calc_sum(~loc, calc_sum);
}

and render_calc_sum = (~loc, calc_sum) => {
  switch (calc_sum) {
  | (product, []) => render_product(~loc, product)
  | (product, list_of_sums) =>
    /* This isn't a great design of the types, but we need to know the operation
       which is in the first position of the array, we ensure that there's one value
       since we are on this branch of the switch */
    let op = pick_operation(List.hd(list_of_sums));
    switch (op) {
    | `Dash () =>
      let first = render_product(~loc, product);
      let second = render_list_of_sums(~loc, list_of_sums);
      [%expr `calc(`sub(([%e first], [%e second])))];
    | `Cross () =>
      let first = render_product(~loc, product);
      let second = render_list_of_sums(~loc, list_of_sums);
      [%expr `calc(`add(([%e first], [%e second])))];
    };
  };
}
and render_function_min_or_max = (~loc, calc_sums: list(Types.calc_sum)) => {
  switch (calc_sums) {
  | [] => raise(Invalid_value("expected at least one argument"))
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
and pick_operation = ((op, _)) => op
and render_list_of_products = (~loc, list_of_products) => {
  switch (list_of_products) {
  | [one] => render_product_op(~loc, one)
  | list => render_list_of_products(~loc, list)
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
    let first = render_calc_value(~loc, calc_value);
    let second = render_list_of_products(~loc, list_of_products);
    [%expr `calc(`mult(([%e first], [%e second])))];
  };
}
and render_product_op = (~loc, op) => {
  switch (op) {
  | `Static_0((), calc_value) => render_calc_value(~loc, calc_value)
  | `Static_1((), float) => [%expr `num([%e render_float(~loc, float)])]
  };
}
and render_angle = (~loc) =>
  fun
  | `Deg(number) => id([%expr `deg([%e render_float(~loc, number)])])
  | `Rad(number) => id([%expr `rad([%e render_float(~loc, number)])])
  | `Grad(number) => id([%expr `grad([%e render_float(~loc, number)])])
  | `Turn(number) => id([%expr `turn([%e render_float(~loc, number)])])

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

and render_calc_value = (~loc, calc_value) => {
  switch ((calc_value: Types.calc_value)) {
  | `Number(float) => [%expr `num([%e render_float(~loc, float)])]
  | `Extended_length(l) => render_extended_length(~loc, l)
  | `Extended_percentage(p) => render_extended_percentage(~loc, p)
  | `Extended_angle(a) => render_extended_angle(~loc, a)
  | `Extended_time(t) => render_extended_time(~loc, t)
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
  | `Deg(number) => id([%expr `deg([%e render_float(~loc, number)])])
  | `Rad(number) => id([%expr `rad([%e render_float(~loc, number)])])
  | `Grad(number) => id([%expr `grad([%e render_float(~loc, number)])])
  | `Turn(number) => id([%expr `turn([%e render_float(~loc, number)])]);

let render_extended_angle = (~loc) =>
  fun
  | `Angle(a) => render_angle(~loc, a)
  | `Function_calc(fc) => render_function_calc(~loc, fc)
  | `Interpolation(i) => render_variable(~loc, i)
  | `Function_min(values) => render_function_min(~loc, values)
  | `Function_max(values) => render_function_max(~loc, values);

let render_side_or_corner = (~loc, value: Types.side_or_corner) => {
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

/* Applies variants to one argument */
let variants = (parser, identifier) =>
  monomorphic(parser, identifier, variant_to_expression);

let width =
  monomorphic(
    Property_parser.property_width,
    (~loc) => [%expr CSS.width],
    render_size,
  );

let height =
  monomorphic(
    Property_parser.property_height,
    (~loc) => [%expr CSS.height],
    render_size,
  );

let min_width =
  monomorphic(
    Property_parser.property_min_width,
    (~loc) => [%expr CSS.minWidth],
    render_min_size,
  );

let min_height =
  monomorphic(
    Property_parser.property_min_height,
    (~loc) => [%expr CSS.minHeight],
    render_min_size,
  );

let max_width =
  monomorphic(
    Property_parser.property_max_width,
    (~loc) => [%expr CSS.maxWidth],
    render_max_width,
  );

let max_height =
  monomorphic(
    Property_parser.property_max_height,
    (~loc) => [%expr CSS.maxHeight],
    render_size,
  );

let box_sizing =
  monomorphic(
    Property_parser.property_box_sizing,
    (~loc) => [%expr CSS.boxSizing],
    variant_to_expression,
  );

let column_width =
  monomorphic(
    Property_parser.property_column_width,
    (~loc) => [%expr CSS.columnWidth],
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
  monomorphic(
    Property_parser.property_margin_top,
    (~loc) => [%expr CSS.marginTop],
    render_margin,
  );

let margin_right =
  monomorphic(
    Property_parser.property_margin_right,
    (~loc) => [%expr CSS.marginRight],
    render_margin,
  );

let margin_bottom =
  monomorphic(
    Property_parser.property_margin_bottom,
    (~loc) => [%expr CSS.marginBottom],
    render_margin,
  );

let margin_left =
  monomorphic(
    Property_parser.property_margin_left,
    (~loc) => [%expr CSS.marginLeft],
    render_margin,
  );

let margin =
  emit_shorthand(
    Property_parser.property_margin,
    (~loc) =>
      fun
      | `Auto => variant_to_expression(~loc, `Auto)
      | `Extended_length(l) => render_extended_length(~loc, l)
      | `Extended_percentage(p) => render_extended_percentage(~loc, p)
      | `Interpolation(name) => render_variable(~loc, name),
    (~loc) =>
      fun
      | [all] => [[%expr CSS.margin([%e all])]]
      | [v, h] => [[%expr CSS.margin2(~v=[%e v], ~h=[%e h])]]
      | [t, h, b] => [
          [%expr CSS.margin3(~top=[%e t], ~h=[%e h], ~bottom=[%e b])],
        ]
      | [t, r, b, l] => [
          [%expr
            CSS.margin4(
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
  monomorphic(
    Property_parser.property_padding_top,
    (~loc) => [%expr CSS.paddingTop],
    render_padding,
  );

let padding_right =
  monomorphic(
    Property_parser.property_padding_right,
    (~loc) => [%expr CSS.paddingRight],
    render_padding,
  );

let padding_bottom =
  monomorphic(
    Property_parser.property_padding_bottom,
    (~loc) => [%expr CSS.paddingBottom],
    render_padding,
  );

let padding_left =
  monomorphic(
    Property_parser.property_padding_left,
    (~loc) => [%expr CSS.paddingLeft],
    render_padding,
  );

let padding =
  emit_shorthand(
    Property_parser.property_padding,
    (~loc) =>
      fun
      | `Extended_length(l) => render_extended_length(~loc, l)
      | `Extended_percentage(p) => render_extended_percentage(~loc, p)
      | `Interpolation(name) => render_variable(~loc, name),
    (~loc) =>
      fun
      | [all] => [[%expr CSS.padding([%e all])]]
      | [v, h] => [[%expr CSS.padding2(~v=[%e v], ~h=[%e h])]]
      | [t, h, b] => [
          [%expr CSS.padding3(~top=[%e t], ~h=[%e h], ~bottom=[%e b])],
        ]
      | [t, r, b, l] => [
          [%expr
            CSS.padding4(
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

let render_color_alpha = (~loc, color_alpha) =>
  switch (color_alpha) {
  | `Number(number) => [%expr `num([%e render_float(~loc, number)])]
  | `Extended_percentage(`Percentage(pct)) =>
    render_percentage(~loc, pct /. 100.0)
  | `Extended_percentage(pct) => render_extended_percentage(~loc, pct)
  };

let render_function_rgb = (~loc, ast: Types.function_rgb) => {
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

let rec render_color = (~loc, value) =>
  switch ((value: Types.color)) {
  | `Interpolation(v) => render_variable(~loc, v)
  | `Hex_color(hex) => id([%expr `hex([%e render_string(~loc, hex)])])
  | `Named_color(color) => render_named_color(~loc, color)
  | `CurrentColor => id([%expr `currentColor])
  | `Function_color_mix(color_mix) =>
    render_function_color_mix(~loc, color_mix)
  | `Function_rgb(rgb) => render_function_rgb(~loc, rgb)
  | `Function_rgba(rgba) => render_function_rgba(~loc, rgba)
  | `Function_var(v) => render_var(~loc, v)
  | `Function_hsl(`Hsl_0(hsl)) => render_function_hsl(~loc, hsl)
  | `Function_hsla(`Hsla_0(hsla)) => render_function_hsla(~loc, hsla)
  /* Function_hsl(a) with `Hsl(a)_1 aren't supported */
  | `Function_hsl(_)
  | `Function_hsla(_)
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

  let render_hue_size = () =>
    fun
    | `Shorter => [%expr `shorter]
    | `Longer => [%expr `longer]
    | `Increasing => [%expr `increasing]
    | `Decreasing => [%expr `decreasing];

  let (color_interpolation_method, (), color_x, (), color_y) = value;

  let color_interpolation_method_expr =
    switch (color_interpolation_method) {
    | ((), `Rectangular_color_space(x)) => render_rectangular_color_space(x)
    | ((), `Static(pcs, None)) => render_polar_color_space(pcs)
    | ((), `Static(pcs, Some((size, ())))) =>
      [%expr
       `polar_with_hue((
         [%e render_polar_color_space(pcs)],
         [%e render_hue_size((), size)],
       ))]
    };

  let render_color_with_percentage = (~loc, (color, percentage)) => {
    switch (percentage) {
    | Some(percentage) =>
      [%expr
       (
         [%e render_color(~loc, color)],
         Some([%e render_percentage(~loc, percentage)]),
       )]
    | None => [%expr ([%e render_color(~loc, color)], None)]
    };
  };

  [%expr
   `colorMix((
     [%e color_interpolation_method_expr],
     [%e render_color_with_percentage(~loc, color_x)],
     [%e render_color_with_percentage(~loc, color_y)],
   ))];
};

let color =
  monomorphic(
    Property_parser.property_color,
    (~loc) => [%expr CSS.color],
    render_color,
  );

let opacity =
  monomorphic(
    Property_parser.property_opacity,
    (~loc) => [%expr CSS.opacity],
    (~loc) =>
      fun
      | `Number(number) => render_float(~loc, number)
      | `Extended_percentage(`Percentage(number)) =>
        render_float(~loc, number /. 100.0)
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
  variants(Property_parser.property_object_fit, (~loc) =>
    [%expr CSS.objectFit]
  );

let object_position =
  polymorphic(
    Property_parser.property_object_position,
    (~loc, position: Types.position) => {
      let (x, y) = render_position(~loc, position);
      [[%expr CSS.objectPosition2([%e x], [%e y])]];
    },
  );

let pointer_events =
  monomorphic(
    Property_parser.property_pointer_events,
    (~loc) => [%expr CSS.pointerEvents],
    (~loc, value: Types.property_pointer_events) => {
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
  unsupportedProperty(Property_parser.property_image_resolution);

let image_orientation =
  unsupportedProperty(Property_parser.property_image_orientation);

let image_rendering =
  variants(Property_parser.property_image_rendering, (~loc) =>
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
      () => Builder.pexp_construct(~loc, {txt: Lident("true"), loc}, None),
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

  Builder.pexp_apply(~loc, [%expr CSS.Shadow.box], args);
};

let background_color =
  monomorphic(
    Property_parser.property_background_color,
    (~loc) => [%expr CSS.backgroundColor],
    render_color,
  );

let _render_color_stop_length = (~loc, value: Types.color_stop_length) => {
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

let render_angular_color_stop = (~loc, value: Types.angular_color_stop) => {
  switch (value) {
  | (color, None) =>
    let color = render_color(~loc, color);
    [%expr ([%e color], None)];
  | (color, Some(angle)) =>
    let color = render_color(~loc, color);
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
  | `Extended_percentage(pct) => render_extended_percentage(~loc, pct)
  | `Extended_angle(a) => render_extended_angle(~loc, a)
  };
};

let render_angular_color_stop_list =
    (~loc, value: Types.angular_color_stop_list) => {
  let (rest_of_stops, (), last_stops) = value;
  let stops =
    rest_of_stops
    |> List.map(stop => {
         switch (stop) {
         | (stop, None) =>
           let stop = render_angular_color_stop(~loc, stop);
           [%expr ([%e stop], None)];
         | (stop, Some(((), color_hint: Types.angular_color_hint))) =>
           let stop = render_angular_color_stop(~loc, stop);
           let color_hint = render_angular_color_hint(~loc, color_hint);
           [%expr ([%e stop], Some([%e color_hint]))];
         }
       })
    |> List.append([render_angular_color_stop(~loc, last_stops)]);
  Builder.pexp_array(~loc, stops);
};

let render_function_linear_gradient =
    (~loc, value: Types.function_linear_gradient) => {
  switch (value) {
  | (None, stops) =>
    [%expr
     `linearGradient((
       None,
       [%e render_color_stop_list(~loc, stops)]: CSS.Types.Gradient.color_stop_list,
     ))]
  | (Some(`Static_0(angle, ())), stops) =>
    [%expr
     `linearGradient((
       Some([%e render_extended_angle(~loc, angle)]),
       [%e render_color_stop_list(~loc, stops)]: CSS.Types.Gradient.color_stop_list,
     ))]
  | (Some(`Static_1((), side_or_corner, ())), stops) =>
    [%expr
     `linearGradient((
       Some([%e render_side_or_corner(~loc, side_or_corner)]),
       [%e render_color_stop_list(~loc, stops)]: CSS.Types.Gradient.color_stop_list,
     ))]
  };
};

let render_function_repeating_linear_gradient =
    (~loc, value: Types.function_repeating_linear_gradient) => {
  switch (value) {
  | (Some(`Extended_angle(angle)), (), stops) =>
    [%expr
     `repeatingLinearGradient((
       Some([%e render_extended_angle(~loc, angle)]),
       [%e render_color_stop_list(~loc, stops)]: CSS.Types.Gradient.color_stop_list,
     ))]
  | (None, (), stops) =>
    [%expr
     `repeatingLinearGradient((
       None,
       [%e render_color_stop_list(~loc, stops)]: CSS.Types.Gradient.color_stop_list,
     ))]
  | (Some(_), (), _stops) => raise(Unsupported_feature)
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
     ))];
  | (shape, Some(radial_size), None, None | Some (), color_stop_list) =>
    let shape = render_eding_shape(~loc, shape);
    let size = render_radial_size(~loc, radial_size);
    [%expr
     `radialGradient((
       [%e shape],
       Some([%e size]),
       None,
       [%e render_color_stop_list(~loc, color_stop_list)]: CSS.Types.Gradient.color_stop_list,
     ))];
  | (shape, None, Some(((), position)), None | Some (), color_stop_list) =>
    let shape = render_eding_shape(~loc, shape);
    let (positionX, positionY) = render_position(~loc, position);
    [%expr
     `radialGradient((
       [%e shape],
       None,
       Some(([%e positionX], [%e positionY])),
       [%e render_color_stop_list(~loc, color_stop_list)]: CSS.Types.Gradient.color_stop_list,
     ))];
  | (
      shape,
      Some(radial_size),
      Some(((), position)),
      None | Some (),
      color_stop_list,
    ) =>
    let shape = render_eding_shape(~loc, shape);
    let size = render_radial_size(~loc, radial_size);
    let (positionX, positionY) = render_position(~loc, position);
    [%expr
     `radialGradient((
       [%e shape],
       Some([%e size]),
       Some(([%e positionX], [%e positionY])),
       [%e render_color_stop_list(~loc, color_stop_list)]: CSS.Types.Gradient.color_stop_list,
     ))];
  };
};

let render_function_repeating_radial_gradient =
    (~loc, value: Types.function_repeating_radial_gradient) => {
  switch (value) {
  | (None, None, (), stops) =>
    [%expr `radialGradient([%e render_color_stop_list(~loc, stops)])]
  | _ => raise(Unsupported_feature)
  };
};

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

let render_url = (~loc, url) => [%expr `url([%e render_string(~loc, url)])];

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

let render_bg_images = (~loc, value: list(Types.bg_image)) => {
  value |> List.map(render_bg_image(~loc)) |> Builder.pexp_array(~loc);
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
  polymorphic(Property_parser.property_background_image, (~loc) =>
    fun
    | [] => failwith("expected at least one value")
    | [i] => [[%expr CSS.backgroundImage([%e render_bg_image(~loc, i)])]]
    | more => [
        [%expr CSS.backgroundImages([%e render_bg_images(~loc, more)])],
      ]
  );

let background_repeat =
  monomorphic(
    Property_parser.property_background_repeat,
    (~loc) => [%expr CSS.backgroundRepeat],
    (~loc) =>
      fun
      | [] => failwith("expected at least one value")
      | [`Repeat_x] => variant_to_expression(~loc, `Repeat_x)
      | [`Repeat_y] => variant_to_expression(~loc, `Repeat_y)
      | [`Xor(_) as v] => render_repeat_style(~loc, v)
      | _ => raise(Unsupported_feature),
  );

let background_attachment =
  monomorphic(
    Property_parser.property_background_attachment,
    (~loc) => [%expr CSS.backgroundAttachment],
    (~loc) =>
      fun
      | [] => failwith("expected at least one argument")
      | [v] => render_attachment(~loc, v)
      | _ => raise(Unsupported_feature),
  );

let render_background_position_one = (~loc) =>
  fun
  | `Center => variant_to_expression(~loc, `Center)
  | `Left => variant_to_expression(~loc, `Left)
  | `Right => variant_to_expression(~loc, `Right)
  | `Bottom => variant_to_expression(~loc, `Bottom)
  | `Top => variant_to_expression(~loc, `Top)
  | `Extended_length(l) => render_extended_length(~loc, l)
  | `Extended_percentage(p) => render_extended_percentage(~loc, p);

let render_background_position = (~loc, position: Types.bg_position) => {
  switch (position) {
  | `Center as position
  | `Left as position
  | `Right as position
  | `Bottom as position
  | `Top as position
  | `Extended_length(_) as position
  | `Extended_percentage(_) as position =>
    [%expr
     CSS.backgroundPosition(
       [%e render_background_position_one(~loc, position)],
     )]
  | `Static(x, y) =>
    [%expr
     CSS.backgroundPosition2(
       [%e render_background_position_one(~loc, x)],
       [%e render_background_position_one(~loc, y)],
     )]
  | `And(_left, _right) => raise(Unsupported_feature)
  };
};

let background_position =
  polymorphic(Property_parser.property_background_position, (~loc) =>
    fun
    | [] => failwith("expected at least one argument")
    | [l] => [render_background_position(~loc, l)]
    | _ => raise(Unsupported_feature)
  );

let background_position_x =
  unsupportedProperty(Property_parser.property_background_position_x);

let background_position_y =
  unsupportedProperty(Property_parser.property_background_position_y);

let background_clip =
  monomorphic(
    Property_parser.property_background_clip,
    (~loc) => [%expr CSS.backgroundClip],
    (~loc) =>
      fun
      | [] => failwith("expected at least one argument")
      | [`Box(b)] => variant_to_expression(~loc, b)
      | [`Text] => variant_to_expression(~loc, `Text)
      | _ => raise(Unsupported_feature),
  );

let background_origin =
  monomorphic(
    Property_parser.property_background_origin,
    (~loc) => [%expr CSS.backgroundOrigin],
    (~loc) =>
      fun
      | [] => failwith("expected at least one argument")
      | [v] => variant_to_expression(~loc, v)
      | _ => raise(Unsupported_feature),
  );

let background_size =
  monomorphic(
    Property_parser.property_background_size,
    (~loc) => [%expr CSS.backgroundSize],
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
          [render_background_position(~loc, pos)],
          [[%expr CSS.backgroundSize([%e render_bg_size(~loc, size)])]],
        ]
      | Some((pos, None)) => [[render_background_position(~loc, pos)]]
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
          [render_background_position(~loc, pos)],
          [[%expr CSS.backgroundSize([%e render_bg_size(~loc, size)])]],
        ]
      | Some((pos, None)) => [[render_background_position(~loc, pos)]]
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
  polymorphic(Property_parser.property_background, render_background);

let border_top_color =
  monomorphic(
    Property_parser.property_border_top_color,
    (~loc) => [%expr CSS.borderTopColor],
    render_color,
  );

let border_right_color =
  monomorphic(
    Property_parser.property_border_right_color,
    (~loc) => [%expr CSS.borderRightColor],
    render_color,
  );

let border_bottom_color =
  monomorphic(
    Property_parser.property_border_bottom_color,
    (~loc) => [%expr CSS.borderBottomColor],
    render_color,
  );

let border_left_color =
  monomorphic(
    Property_parser.property_border_left_color,
    (~loc) => [%expr CSS.borderLeftColor],
    render_color,
  );

let border_color =
  monomorphic(
    Property_parser.property_border_color,
    (~loc) => [%expr CSS.borderColor],
    (~loc) =>
      fun
      | [c] => render_color(~loc, c)
      | _ => raise(Unsupported_feature),
  );

let border_top_style =
  variants(Property_parser.property_border_top_style, (~loc) =>
    [%expr CSS.borderTopStyle]
  );

let border_right_style =
  variants(Property_parser.property_border_right_style, (~loc) =>
    [%expr CSS.borderRightStyle]
  );

let border_bottom_style =
  variants(Property_parser.property_border_bottom_style, (~loc) =>
    [%expr CSS.borderBottomStyle]
  );

let border_left_style =
  variants(Property_parser.property_border_left_style, (~loc) =>
    [%expr CSS.borderLeftStyle]
  );

let border_style =
  monomorphic(
    Property_parser.property_border_style,
    (~loc) => [%expr CSS.borderStyle],
    variant_to_expression,
  );

let render_line_width = (~loc, value: Types.line_width) =>
  switch (value) {
  | `Extended_length(l) => render_extended_length(~loc, l)
  | `Thick => [%expr `thick]
  | `Medium => [%expr `medium]
  | `Thin => [%expr `thin]
  };

let border_top_width =
  monomorphic(
    Property_parser.property_border_top_width,
    (~loc) => [%expr CSS.borderTopWidth],
    render_line_width,
  );

let border_right_width =
  monomorphic(
    Property_parser.property_border_right_width,
    (~loc) => [%expr CSS.borderRightWidth],
    render_line_width,
  );

let border_bottom_width =
  monomorphic(
    Property_parser.property_border_bottom_width,
    (~loc) => [%expr CSS.borderBottomWidth],
    render_line_width,
  );

let border_left_width =
  monomorphic(
    Property_parser.property_border_left_width,
    (~loc) => [%expr CSS.borderLeftWidth],
    render_line_width,
  );

let border_width =
  monomorphic(
    Property_parser.property_border_width,
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

let outline = polymorphic(Property_parser.property_outline, render_outline);

let outline_color =
  monomorphic(
    Property_parser.property_outline_color,
    (~loc) => [%expr CSS.outlineColor],
    render_color,
  );

let outline_offset =
  monomorphic(
    Property_parser.property_outline_offset,
    (~loc) => [%expr CSS.outlineOffset],
    render_extended_length,
  );

let outline_style =
  monomorphic(
    Property_parser.property_outline_style,
    (~loc) => [%expr CSS.outlineStyle],
    render_outline_style_interp,
  );

let outline_width =
  monomorphic(
    Property_parser.property_outline_width,
    (~loc) => [%expr CSS.outlineWidth],
    render_line_width_interp,
  );

let vertical_align =
  monomorphic(
    Property_parser.property_vertical_align,
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
  polymorphic(
    Property_parser.property_border,
    render_border(~direction=All),
  );

let border_top =
  polymorphic(
    Property_parser.property_border,
    render_border(~direction=Top),
  );

let border_right =
  polymorphic(
    Property_parser.property_border,
    render_border(~direction=Right),
  );

let border_bottom =
  polymorphic(
    Property_parser.property_border,
    render_border(~direction=Bottom),
  );

let border_left =
  polymorphic(
    Property_parser.property_border,
    render_border(~direction=Left),
  );

let render_border_radius_value = (~loc) =>
  fun
  | [`Extended_length(l)] => render_extended_length(~loc, l)
  | [`Extended_percentage(p)] => render_extended_percentage(~loc, p)
  | _ => raise(Unsupported_feature);

let border_top_left_radius =
  monomorphic(
    Property_parser.property_border_top_left_radius,
    (~loc) => [%expr CSS.borderTopLeftRadius],
    render_border_radius_value,
  );

let border_top_right_radius =
  monomorphic(
    Property_parser.property_border_top_right_radius,
    (~loc) => [%expr CSS.borderTopRightRadius],
    render_border_radius_value,
  );

let border_bottom_right_radius =
  monomorphic(
    Property_parser.property_border_bottom_right_radius,
    (~loc) => [%expr CSS.borderBottomRightRadius],
    render_border_radius_value,
  );

let border_bottom_left_radius =
  monomorphic(
    Property_parser.property_border_bottom_left_radius,
    (~loc) => [%expr CSS.borderBottomLeftRadius],
    render_border_radius_value,
  );

let border_radius =
  monomorphic(
    Property_parser.property_border_radius,
    (~loc) => [%expr CSS.borderRadius],
    render_length_percentage,
  );

let border_image_source =
  monomorphic(
    Property_parser.property_border_image_source,
    (~loc) => [%expr CSS.borderImageSource],
    (~loc, value) => {
      switch (value) {
      | `None => [%expr `none]
      | `Image(i) => render_image(~loc, i)
      }
    },
  );

let border_image_slice =
  unsupportedProperty(Property_parser.property_border_image_slice);

let border_image_width =
  unsupportedProperty(Property_parser.property_border_image_width);

let border_image_outset =
  unsupportedProperty(Property_parser.property_border_image_outset);

let border_image_repeat =
  unsupportedProperty(Property_parser.property_border_image_repeat);

let border_image = unsupportedProperty(Property_parser.property_border_image);

let box_shadow =
  polymorphic(
    Property_parser.property_box_shadow,
    (~loc, value: Types.property_box_shadow) =>
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
  variants(Property_parser.property_overflow_x, (~loc) =>
    [%expr CSS.overflowX]
  );

let overflow_y =
  variants(Property_parser.property_overflow_y, (~loc) =>
    [%expr CSS.overflowY]
  );

let overflow =
  polymorphic(Property_parser.property_overflow, (~loc) =>
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
    | `_non_standard_overflow(non_standard) => {
        switch (non_standard) {
        | `_moz_scrollbars_none => [
            [%expr CSS.unsafe("overflow", "-moz-scrollbars-none")],
          ]
        | `_moz_scrollbars_horizontal => [
            [%expr CSS.unsafe("overflow", "-moz-scrollbars-horizontal")],
          ]
        | `_moz_scrollbars_vertical => [
            [%expr CSS.unsafe("overflow", "-moz-scrollbars-vertical")],
          ]
        | _moz_hidden_unscrollable => [
            [%expr CSS.unsafe("overflow", "-moz-hidden-unscrollable")],
          ]
        };
      }
  );

/* let overflow_clip_margin =
   unsupportedProperty(Property_parser.property_overflow_clip_margin); */

let overflow_block =
  monomorphic(
    Property_parser.property_overflow_block,
    (~loc) => [%expr CSS.overflowBlock],
    (~loc, value) => {
      switch (value) {
      | `Interpolation(i) => render_variable(~loc, i)
      | `Auto => variant_to_expression(~loc, `Auto)
      | `Clip => variant_to_expression(~loc, `Clip)
      | `Hidden => variant_to_expression(~loc, `Hidden)
      | `Scroll => variant_to_expression(~loc, `Scroll)
      | `Visible => variant_to_expression(~loc, `Visible)
      }
    },
  );

let overflow_inline =
  monomorphic(
    Property_parser.property_overflow_inline,
    (~loc) => [%expr CSS.overflowInline],
    (~loc, value) => {
      switch (value) {
      | `Interpolation(i) => render_variable(~loc, i)
      | `Auto => variant_to_expression(~loc, `Auto)
      | `Clip => variant_to_expression(~loc, `Clip)
      | `Hidden => variant_to_expression(~loc, `Hidden)
      | `Scroll => variant_to_expression(~loc, `Scroll)
      | `Visible => variant_to_expression(~loc, `Visible)
      }
    },
  );

let text_overflow =
  monomorphic(
    Property_parser.property_text_overflow,
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
// let block_ellipsis = unsupportedProperty(Property_parser.property_block_ellipsis);

let max_lines = unsupportedProperty(Property_parser.property_max_lines);
// let continue = unsupportedProperty(Property_parser.property_continue);

// css-text-3
let text_transform =
  variants(Property_parser.property_text_transform, (~loc) =>
    [%expr CSS.textTransform]
  );

let white_space =
  variants(Property_parser.property_white_space, (~loc) =>
    [%expr CSS.whiteSpace]
  );

let render_tab_size = (~loc, value: Types.property_tab_size) => {
  switch (value) {
  | `Number(n) =>
    int_of_float(n) < 0
      ? raise(Invalid_value("tab-size value can not be less than 0!"))
      : [%expr `num([%e render_float(~loc, n)])]
  | `Extended_length(ext) => render_extended_length(~loc, ext)
  };
};

let tab_size =
  monomorphic(
    Property_parser.property_tab_size,
    (~loc) => [%expr CSS.tabSize],
    render_tab_size,
  );

let word_break =
  variants(Property_parser.property_word_break, (~loc) =>
    [%expr CSS.wordBreak]
  );

let render_line_height = (~loc) =>
  fun
  | `Extended_length(ext) => render_extended_length(~loc, ext)
  | `Extended_percentage(ext) => render_extended_percentage(~loc, ext)
  | `Normal => variant_to_expression(~loc, `Normal)
  | `Number(float) => [%expr `abs([%e render_float(~loc, float)])];

let line_height =
  monomorphic(
    Property_parser.property_line_height,
    (~loc) => [%expr CSS.lineHeight],
    render_line_height,
  );

let line_height_step =
  monomorphic(
    Property_parser.property_line_height_step,
    (~loc) => [%expr CSS.lineHeightStep],
    render_extended_length,
  );

let hyphens =
  variants(Property_parser.property_hyphens, (~loc) => [%expr CSS.hyphens]);

let overflow_wrap =
  variants(Property_parser.property_overflow_wrap, (~loc) =>
    [%expr CSS.overflowWrap]
  );

let word_wrap =
  variants(Property_parser.property_word_wrap, (~loc) =>
    [%expr CSS.wordWrap]
  );

let text_align =
  variants(Property_parser.property_text_align, (~loc) =>
    [%expr CSS.textAlign]
  );

let text_align_all =
  variants(Property_parser.property_text_align_all, (~loc) =>
    [%expr CSS.textAlignAll]
  );

let text_align_last =
  variants(Property_parser.property_text_align_last, (~loc) =>
    [%expr CSS.textAlignLast]
  );

let text_justify =
  variants(Property_parser.property_text_justify, (~loc) =>
    [%expr CSS.textJustify]
  );

let word_spacing =
  monomorphic(
    Property_parser.property_word_spacing,
    (~loc) => [%expr CSS.wordSpacing],
    (~loc) =>
      fun
      | `Normal => variant_to_expression(~loc, `Normal)
      | `Extended_length(l) => render_extended_length(~loc, l)
      | `Extended_percentage(p) => render_extended_percentage(~loc, p),
  );

let letter_spacing =
  monomorphic(
    Property_parser.property_word_spacing,
    (~loc) => [%expr CSS.letterSpacing],
    (~loc) =>
      fun
      | `Normal => variant_to_expression(~loc, `Normal)
      | `Extended_length(l) => render_extended_length(~loc, l)
      | `Extended_percentage(p) => render_extended_percentage(~loc, p),
  );

let text_indent =
  monomorphic(
    Property_parser.property_text_indent,
    (~loc) => [%expr CSS.textIndent],
    (~loc) =>
      fun
      | (`Extended_length(l), None, None) => render_extended_length(~loc, l)
      | (`Extended_percentage(p), None, None) =>
        render_extended_percentage(~loc, p)
      | _ => raise(Unsupported_feature),
  );

let hanging_punctuation =
  unsupportedProperty(Property_parser.property_hanging_punctuation);

let render_generic_family = (~loc) =>
  fun
  | `Cursive => [%expr "cursive"]
  | `Fantasy => [%expr "fantasy"]
  | `Monospace => [%expr "monospace"]
  | `Sans_serif => [%expr "sans-serif"]
  | `Serif => [%expr "serif"]
  | `_apple_system => [%expr "-apple-system"];

let render_font_family = (~loc, value) =>
  switch (value) {
  | `Interpolation(v) => render_variable(~loc, v)
  | `Generic_family(v) => render_generic_family(~loc, v)
  | `Family_name(`String(str)) => render_string(~loc, str)
  | `Family_name(`Custom_ident(ident)) => render_string(~loc, ident)
  };

// css-fonts-4
let font_family =
  polymorphic(
    Property_parser.property_font_family,
    (~loc, value: Types.property_font_family) =>
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
    Property_parser.property_font_weight,
    (~loc) => [%expr CSS.fontWeight],
    render_font_weight,
  );

let font_stretch = unsupportedProperty(Property_parser.property_font_stretch);

let render_font_style = (~loc) =>
  fun
  | `Normal => variant_to_expression(~loc, `Normal)
  | `Italic => variant_to_expression(~loc, `Italic)
  | `Oblique => variant_to_expression(~loc, `Oblique)
  | `Interpolation(v) => render_variable(~loc, v)
  | `Static(_) => raise(Unsupported_feature);

let font_style =
  monomorphic(
    Property_parser.property_font_style,
    (~loc) => [%expr CSS.fontStyle],
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
  monomorphic(
    Property_parser.property_font_size,
    (~loc) => [%expr CSS.fontSize],
    render_font_size,
  );

let font_size_adjust =
  unsupportedProperty(Property_parser.property_font_size_adjust);

let font = unsupportedProperty(Property_parser.property_font);

let font_synthesis_weight =
  variants(Property_parser.property_font_synthesis_weight, (~loc) =>
    [%expr CSS.fontSynthesisWeight]
  );

let font_synthesis_style =
  variants(Property_parser.property_font_synthesis_style, (~loc) =>
    [%expr CSS.fontSynthesisStyle]
  );

let font_synthesis_small_caps =
  variants(Property_parser.property_font_synthesis_small_caps, (~loc) =>
    [%expr CSS.fontSynthesisSmallCaps]
  );

let font_synthesis_position =
  variants(Property_parser.property_font_synthesis_position, (~loc) =>
    [%expr CSS.fontSynthesisPosition]
  );

let font_synthesis =
  unsupportedProperty(Property_parser.property_font_synthesis);

let font_kerning =
  variants(Property_parser.property_font_kerning, (~loc) =>
    [%expr CSS.fontKerning]
  );

let font_variant_ligatures =
  unsupportedProperty(Property_parser.property_font_variant_ligatures);

let font_variant_position =
  variants(Property_parser.property_font_variant_position, (~loc) =>
    [%expr CSS.fontVariantPosition]
  );

let font_variant_caps =
  variants(Property_parser.property_font_variant_caps, (~loc) =>
    [%expr CSS.fontVariantCaps]
  );

let font_variant_numeric =
  unsupportedProperty(Property_parser.property_font_variant_numeric);

let font_variant_alternates =
  unsupportedProperty(Property_parser.property_font_variant_alternates);

let font_variant_east_asian =
  unsupportedProperty(Property_parser.property_font_variant_east_asian);

let font_variant =
  polymorphic(Property_parser.property_font_variant, (~loc) =>
    fun
    | `None => [[%expr CSS.unsafe({|fontVariant|}, {|none|})]]
    | `Normal => [[%expr CSS.fontVariant(`normal)]]
    | `Small_caps => [[%expr CSS.fontVariant(`smallCaps)]]
    | _ => raise(Unsupported_feature)
  );

let font_feature_settings =
  unsupportedProperty(Property_parser.property_font_feature_settings);

let font_optical_sizing =
  variants(Property_parser.property_font_optical_sizing, (~loc) =>
    [%expr CSS.fontOpticalSizing]
  );

let font_variation_settings =
  unsupportedProperty(Property_parser.property_font_variation_settings);

let font_palette = unsupportedProperty(Property_parser.property_font_palette);

let font_variant_emoji =
  variants(Property_parser.property_font_variant_emoji, (~loc) =>
    [%expr CSS.fontVariantEmoji]
  );

// css-text-decor-3
let render_text_decoration_line =
    (~loc, value: Types.property_text_decoration_line) =>
  switch (value) {
  | `Interpolation(v) => render_variable(~loc, v)
  | `None => variant_to_expression(~loc, `None)
  | `Xor([`Underline]) => variant_to_expression(~loc, `Underline)
  | `Xor([`Overline]) => variant_to_expression(~loc, `Overline)
  | `Xor([`Line_through]) => variant_to_expression(~loc, `Line_Through)
  | `Xor([`Blink]) => variant_to_expression(~loc, `Blink)
  /* bs-css doesn't support multiple text decoration line */
  | `Xor(_) => raise(Unsupported_feature)
  };

let text_decoration_line =
  monomorphic(
    Property_parser.property_text_decoration_line,
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
    Property_parser.property_text_decoration_style,
    (~loc) => [%expr CSS.textDecorationStyle],
    render_text_decoration_style,
  );

let text_decoration_color =
  monomorphic(
    Property_parser.property_text_decoration_color,
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
    Property_parser.property_text_decoration_thickness,
    (~loc) => [%expr CSS.textDecorationThickness],
    render_text_decoration_thickness,
  );

let text_decoration =
  monomorphic(
    Property_parser.property_text_decoration,
    (~loc) => [%expr CSS.textDecoration],
    (~loc, v) =>
      switch (v) {
      | (line, None, None) => render_text_decoration_line(~loc, line)
      | (_line, None, Some(_color)) => raise(Unsupported_feature)
      | (_line, Some(_style), None) => raise(Unsupported_feature)
      | (_line, Some(_style), Some(_color)) => raise(Unsupported_feature)
      },
  );

let text_underline_position =
  unsupportedProperty(Property_parser.property_text_underline_position);

let text_underline_offset =
  unsupportedProperty(Property_parser.property_text_underline_offset);

let text_decoration_skip =
  unsupportedProperty(Property_parser.property_text_decoration_skip);

let text_decoration_skip_self =
  unsupportedProperty(Property_parser.property_text_decoration_skip_self);

let text_decoration_skip_box =
  variants(Property_parser.property_text_decoration_skip_box, (~loc) =>
    [%expr CSS.textDecorationSkipBox]
  );

let text_decoration_skip_inset =
  variants(Property_parser.property_text_decoration_skip_inset, (~loc) =>
    [%expr CSS.textDecorationSkipInset]
  );

let text_decoration_skip_spaces =
  unsupportedProperty(Property_parser.property_text_decoration_skip_spaces);

let text_decoration_skip_ink =
  variants(Property_parser.property_text_decoration_skip_ink, (~loc) =>
    [%expr CSS.textDecorationSkipInk]
  );

let text_emphasis_style =
  polymorphic(
    Property_parser.property_text_emphasis_style,
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
    Property_parser.property_text_emphasis_color,
    (~loc) => [%expr CSS.textEmphasisColor],
    render_color,
  );

let text_emphasis =
  unsupportedProperty(Property_parser.property_text_emphasis);

let text_emphasis_position =
  polymorphic(
    Property_parser.property_text_emphasis_position,
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

// let text_emphasis_skip = unsupportedProperty(Property_parser.property_text_emphasis_skip);

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
          |> Option.map(render_color_interp(~loc))
          |> Option.value(~default=[%expr `Color(`CurrentColor)]),
        ),
      ),
    ]
    |> List.filter_map(((label, value)) =>
         Option.map(value => (label, value), value)
       );

  Builder.pexp_apply(~loc, [%expr CSS.Shadow.text], args);
};

let text_shadow =
  polymorphic(Property_parser.property_text_shadow, (~loc) =>
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
    [%expr CSS.rotate([%e render_transform_functions(~loc, v)])]
  | `Function_rotate3d(x, (), y, (), z, (), a) =>
    [%expr
     CSS.rotate3d(
       [%e render_float(~loc, x)],
       [%e render_float(~loc, y)],
       [%e render_float(~loc, z)],
       [%e render_transform_functions(~loc, a)],
     )]
  | `Function_rotateX(v) =>
    [%expr CSS.rotateX([%e render_transform_functions(~loc, v)])]
  | `Function_rotateY(v) =>
    [%expr CSS.rotateY([%e render_transform_functions(~loc, v)])]
  | `Function_rotateZ(v) =>
    [%expr CSS.rotateZ([%e render_transform_functions(~loc, v)])]
  | `Function_skew(a1, a2) =>
    switch (a2) {
    | Some(((), v)) =>
      [%expr
       CSS.skew(
         [%e render_transform_functions(~loc, a1)],
         [%e render_transform_functions(~loc, v)],
       )]
    | None =>
      [%expr CSS.skew([%e render_transform_functions(~loc, a1)], `deg(0.))]
    }
  | `Function_skewX(v) =>
    [%expr CSS.skewX([%e render_transform_functions(~loc, v)])]
  | `Function_skewY(v) =>
    [%expr CSS.skewY([%e render_transform_functions(~loc, v)])]
  | `Function_translate(x, None) =>
    [%expr CSS.translate([%e render_length_percentage(~loc, x)], `zero)]
  | `Function_translate(x, Some(((), v))) =>
    [%expr
     CSS.translate(
       [%e render_length_percentage(~loc, x)],
       [%e render_length_percentage(~loc, v)],
     )]
  | `Function_translate3d(x, (), y, (), z) =>
    [%expr
     CSS.translate3d(
       [%e render_length_percentage(~loc, x)],
       [%e render_length_percentage(~loc, y)],
       [%e render_extended_length(~loc, z)],
     )]
  | `Function_translateX(x) =>
    [%expr CSS.translateX([%e render_length_percentage(~loc, x)])]
  | `Function_translateY(y) =>
    [%expr CSS.translateY([%e render_length_percentage(~loc, y)])]
  | `Function_translateZ(z) =>
    [%expr CSS.translateZ([%e render_extended_length(~loc, z)])]
  | `Function_scale(x, None) =>
    [%expr CSS.scale([%e render_float(~loc, x)], [%e render_float(~loc, x)])]
  | `Function_scale(x, Some(((), v))) =>
    [%expr CSS.scale([%e render_float(~loc, x)], [%e render_float(~loc, v)])]
  | `Function_scale3d(x, (), y, (), z) =>
    [%expr
     CSS.scale3d(
       [%e render_float(~loc, x)],
       [%e render_float(~loc, y)],
       [%e render_float(~loc, z)],
     )]
  | `Function_scaleX(x) => [%expr CSS.scaleX([%e render_float(~loc, x)])]
  | `Function_scaleY(y) => [%expr CSS.scaleY([%e render_float(~loc, y)])]
  | `Function_scaleZ(z) => [%expr CSS.scaleZ([%e render_float(~loc, z)])]
  };

// css-transforms-2
let transform =
  polymorphic(Property_parser.property_transform, (~loc) =>
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

let render_origin = (~loc) =>
  fun
  | `Center as x
  | `Left as x
  | `Right as x
  | `Top as x
  | `Bottom as x => variant_to_expression(~loc, x)
  | `Function_calc(fc) => render_function_calc(~loc, fc)
  | `Interpolation(v) => render_variable(~loc, v)
  | `Length(l) => render_length(~loc, l)
  | `Extended_length(l) => render_extended_length(~loc, l)
  | `Extended_percentage(p) => render_extended_percentage(~loc, p);

let transform_origin =
  polymorphic(Property_parser.property_transform_origin, (~loc) =>
    fun
    /* x, y are swapped on purpose */
    | `Static((y, x), None) => {
        [
          [%expr
            CSS.transformOrigin2(
              [%e render_origin(~loc, x)],
              [%e render_origin(~loc, y)],
            )
          ],
        ];
      }
    | `Center => [[%expr CSS.transformOrigin(`center)]]
    | `Left => [[%expr CSS.transformOrigin(`left)]]
    | `Right => [[%expr CSS.transformOrigin(`right)]]
    | `Bottom => [[%expr CSS.transformOrigin(`bottom)]]
    | `Top => [[%expr CSS.transformOrigin(`top)]]
    | `Extended_length(el) => [
        [%expr CSS.transformOrigin([%e render_extended_length(~loc, el)])],
      ]
    | `Extended_percentage(ep) => [
        [%expr
          CSS.transformOrigin([%e render_extended_percentage(~loc, ep)])
        ],
      ]
    | `Static(_, Some(_)) => raise(Unsupported_feature)
  );

let transform_box =
  variants(Property_parser.property_transform_box, (~loc) =>
    [%expr CSS.transformBox]
  );

let translate =
  unsupportedValue(Property_parser.property_translate, (~loc) =>
    [%expr CSS.translate]
  );

let rotate =
  unsupportedValue(Property_parser.property_rotate, (~loc) =>
    [%expr CSS.rotate]
  );

let scale =
  unsupportedValue(Property_parser.property_scale, (~loc) =>
    [%expr CSS.scale]
  );

let transform_style =
  monomorphic(
    Property_parser.property_transform_style,
    (~loc) => [%expr CSS.transformStyle],
    (~loc) =>
      fun
      | `Flat => variant_to_expression(~loc, `Flat)
      | `Preserve_3d => variant_to_expression(~loc, `Preserve_3d),
  );

let perspective = unsupportedProperty(Property_parser.property_perspective);

let perspective_origin =
  polymorphic(
    Property_parser.property_perspective_origin,
    (~loc, position) => {
      let (x, y) = render_position(~loc, position);
      [[%expr CSS.perspectiveOrigin2([%e x], [%e y])]];
    },
  );

let backface_visibility =
  variants(Property_parser.property_backface_visibility, (~loc) =>
    [%expr CSS.backfaceVisibility]
  );

let render_single_transition_property_no_interp = (~loc, value) => {
  switch (value) {
  | `All => render_string(~loc, "all")
  | `Custom_ident(v) => render_string(~loc, v)
  };
};

let render_single_transition_property = (~loc, value) => {
  switch (value) {
  | #Types.single_transition_property_no_interp as x =>
    render_single_transition_property_no_interp(~loc, x)
  | `Interpolation(v) => render_variable(~loc, v)
  };
};

// css-transition-1
let transition_property =
  monomorphic(
    Property_parser.property_transition_property,
    (~loc) => [%expr CSS.transitionProperty],
    (~loc) =>
      fun
      | `None => render_string(~loc, "none")
      | `Single_transition_property([transition]) =>
        render_single_transition_property(~loc, transition)
      /* bs-css unsupports multiple transition_properties,
         but should be easy to bypass with string concatenation */
      | `Single_transition_property(_) => raise(Unsupported_feature),
  );

let transition_duration =
  monomorphic(
    Property_parser.property_transition_duration,
    (~loc) => [%expr CSS.transitionDuration],
    (~loc) =>
      fun
      | [] => [%expr `none]
      | [one] => render_extended_time(~loc, one)
      | _ => raise(Unsupported_feature),
  );

let widows =
  monomorphic(
    Property_parser.property_widows,
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
  | #Types.timing_function_no_interp as x => render_timing_no_interp(~loc, x)
  | `Interpolation(v) => render_variable(~loc, v);

let transition_timing_function =
  monomorphic(
    Property_parser.property_transition_timing_function,
    (~loc) => [%expr CSS.transitionTimingFunction],
    (~loc) =>
      fun
      | [t] => render_timing(~loc, t)
      | _ => raise(Unsupported_feature),
  );

let transition_delay =
  monomorphic(
    Property_parser.property_transition_delay,
    (~loc) => [%expr CSS.transitionDelay],
    (~loc) =>
      fun
      | [`Time(t)] => render_time_as_int(~loc, t)
      | [`Interpolation(v)] => render_variable(~loc, v)
      | _ => raise(Unsupported_feature),
  );

let render_transition_property = (~loc) =>
  fun
  | `None => render_string(~loc, "none")
  | `Single_transition_property(x) =>
    render_single_transition_property(~loc, x);

let render_single_transition = (~loc) =>
  fun
  | `Static_0(property, duration) => {
      [%expr
       CSS.Transition.shorthand(
         ~duration=[%e render_extended_time(~loc, duration)],
         [%e render_transition_property(~loc, property)],
       )];
    }
  | `Static_1(property, duration, timingFunction) => {
      [%expr
       CSS.Transition.shorthand(
         ~duration=[%e render_extended_time(~loc, duration)],
         ~timingFunction=[%e render_timing(~loc, timingFunction)],
         [%e render_transition_property(~loc, property)],
       )];
    }
  | `Static_2(property, duration, timingFunction, delay) => {
      [%expr
       CSS.Transition.shorthand(
         ~duration=[%e render_extended_time(~loc, duration)],
         ~delay=[%e render_extended_time(~loc, delay)],
         ~timingFunction=[%e render_timing(~loc, timingFunction)],
         [%e render_transition_property(~loc, property)],
       )];
    };

let render_single_transition_no_interp =
    (
      ~loc,
      (property, delay, timingFunction, duration): Types.single_transition_no_interp,
    ) => {
  let property =
    switch (
      Option.value(
        property,
        ~default=`Single_transition_property_no_interp(`All),
      )
    ) {
    | `None => render_string(~loc, "none")
    | `Single_transition_property_no_interp(x) =>
      render_single_transition_property_no_interp(~loc, x)
    };

  [%expr
   CSS.Transition.shorthand(
     ~duration=?[%e
       render_option(~loc, render_extended_time_no_interp, duration)
     ],
     ~delay=?[%e render_option(~loc, render_extended_time_no_interp, delay)],
     ~timingFunction=?[%e
       render_option(~loc, render_timing_no_interp, timingFunction)
     ],
     [%e property],
   )];
};

let transition =
  monomorphic(
    Property_parser.property_transition,
    (~loc) => [%expr CSS.transitionList],
    (~loc) =>
      fun
      | `Interpolation(v) => render_variable(~loc, v)
      | `Xor(transitions) =>
        switch (transitions) {
        | [] => raise(Invalid_value("expected at least one argument"))
        | transitions =>
          transitions
          |> List.map(
               fun
               | `Single_transition(x) => render_single_transition(~loc, x)
               | `Single_transition_no_interp(x) =>
                 render_single_transition_no_interp(~loc, x),
             )
          |> Builder.pexp_array(~loc)
        },
  );

let render_keyframes_name = (~loc) =>
  fun
  | `Custom_ident(label) => render_string(~loc, label)
  | `String(label) => render_string(~loc, label);

let render_animation_name = (~loc) =>
  fun
  | `None => render_string(~loc, "none")
  | `Keyframes_name(name) => render_keyframes_name(~loc, name);

// css-animation-1
let animation_name =
  monomorphic(
    Property_parser.property_animation_name,
    (~loc) => [%expr CSS.animationName],
    (~loc) =>
      fun
      | [one] => render_animation_name(~loc, one)
      | _ => raise(Unsupported_feature),
  );

let animation_duration =
  monomorphic(
    Property_parser.property_animation_duration,
    (~loc) => [%expr CSS.animationDuration],
    (~loc) =>
      fun
      | [] => [%expr `ms(0)]
      | [one] => render_extended_time(~loc, one)
      | _ => raise(Unsupported_feature),
  );

let animation_timing_function =
  monomorphic(
    Property_parser.property_animation_timing_function,
    (~loc) => [%expr CSS.animationTimingFunction],
    (~loc) =>
      fun
      | [t] => render_timing(~loc, t)
      | _ => raise(Unsupported_feature),
  );

let render_animation_iteration_count = (~loc) =>
  fun
  | `Infinite => [%expr `infinite]
  | `Number(n) => [%expr `count([%e render_float(~loc, n)])];

let animation_iteration_count =
  monomorphic(
    Property_parser.property_animation_iteration_count,
    (~loc) => [%expr CSS.animationIterationCount],
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
  monomorphic(
    Property_parser.property_animation_direction,
    (~loc) => [%expr CSS.animationDirection],
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
  monomorphic(
    Property_parser.property_animation_play_state,
    (~loc) => [%expr CSS.animationPlayState],
    (~loc) =>
      fun
      | [one] => render_animation_play_state(~loc, one)
      | _ => raise(Unsupported_feature),
  );

let animation_delay =
  monomorphic(
    Property_parser.property_animation_delay,
    (~loc) => [%expr CSS.animationDelay],
    (~loc) =>
      fun
      | [one] => render_extended_time(~loc, one)
      | _ => raise(Unsupported_feature),
  );

let render_animation_fill_mode = (~loc) =>
  fun
  | `None => [%expr `none]
  | `Forwards => [%expr `forwards]
  | `Backwards => [%expr `backwards]
  | `Both => [%expr `both];

let animation_fill_mode =
  monomorphic(
    Property_parser.property_animation_fill_mode,
    (~loc) => [%expr CSS.animationFillMode],
    (~loc) =>
      fun
      | [one] => render_animation_fill_mode(~loc, one)
      | _ => raise(Unsupported_feature),
  );

let render_single_animation =
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
      ): Types.single_animation,
    ) => {
  [%expr
   CSS.animation(
     ~duration=?[%e render_option(~loc, render_extended_time, duration)],
     ~delay=?[%e render_option(~loc, render_extended_time, delay)],
     ~direction=?[%e
       render_option(~loc, render_animation_direction, direction)
     ],
     ~timingFunction=?[%e render_option(~loc, render_timing, timingFunction)],
     ~fillMode=?[%e
       render_option(~loc, render_animation_fill_mode, fillMode)
     ],
     ~playState=?[%e
       render_option(~loc, render_animation_play_state, playState)
     ],
     ~iterationCount=?[%e
       render_option(~loc, render_animation_iteration_count, iterationCount)
     ],
     ~name=[%e render_animation_name(~loc, Option.value(name, ~default=`None))],
     ()
   )];
};

let animation =
  polymorphic(Property_parser.property_animation, (~loc) =>
    fun
    | [one] => [render_single_animation(~loc, one)]
    | _ => raise(Unsupported_feature)
  );

let render_ratio = (~loc, value: Types.ratio) => {
  switch (value) {
  | `Number(n) => [%expr `num([%e render_float(~loc, n)])]
  | `Interpolation(v) => render_variable(~loc, v)
  | `Static(up, _, down) =>
    [%expr
     `ratio((
       [%e render_integer(~loc, up)],
       [%e render_integer(~loc, down)],
     ))]
  };
};

let aspect_ratio =
  monomorphic(
    Property_parser.property_aspect_ratio,
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
  variants(Property_parser.property_flex_direction, (~loc) =>
    [%expr CSS.flexDirection]
  );

let flex_wrap =
  variants(Property_parser.property_flex_wrap, (~loc) =>
    [%expr CSS.flexWrap]
  );

// shorthand - https://drafts.csswg.org/css-flexbox-1/#flex-flow-property
/* TODO: Avoid using `Value outside emit/emit_shorthand */
let flex_flow =
  polymorphic(
    Property_parser.property_flex_flow,
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
  monomorphic(
    Property_parser.property_order,
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
    Property_parser.property_flex_grow,
    (~loc) => [%expr CSS.flexGrow],
    render_float_interp,
  );

let flex_shrink =
  monomorphic(
    Property_parser.property_flex_shrink,
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
    Property_parser.property_flex_basis,
    (~loc) => [%expr CSS.flexBasis],
    render_flex_basis,
  );

let flex =
  polymorphic(Property_parser.property_flex, (~loc, value) =>
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

let render_content_position = (~loc, value: Types.content_position) => {
  switch (value) {
  | `Center => [%expr `center]
  | `Start => [%expr `start]
  | `End => [%expr `end_]
  | `Flex_start => [%expr `flexStart]
  | `Flex_end => [%expr `flexEnd]
  };
};

let render_self_position = (~loc, value: Types.self_position) => {
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
    Property_parser.property_justify_content,
    (~loc) => [%expr CSS.justifyContent],
    (~loc, value) => {
      switch (value) {
      | `Normal => [%expr `normal]
      | `Content_distribution(distribution) =>
        render_content_distribution(~loc, distribution)
      | `Static(None, position) =>
        [%expr [%e render_content_position_left_right(~loc, position)]]
      | `Static(Some(`Safe), position) =>
        [%expr `safe([%e render_content_position_left_right(~loc, position)])]
      | `Static(Some(`Unsafe), position) =>
        [%expr
         `unsafe([%e render_content_position_left_right(~loc, position)])]
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
    Property_parser.property_justify_items,
    (~loc) => [%expr CSS.justifyItems],
    (~loc, value) => {
      switch (value) {
      | `Normal => [%expr `normal]
      | `Stretch => [%expr `stretch]
      | `Legacy => [%expr `legacy]
      | `And(_, alignment) => render_legacy_alignment(~loc, alignment)
      | `Static(None, position) =>
        [%expr [%e render_self_position_left_right(~loc, position)]]
      | `Static(Some(`Safe), position) =>
        [%expr `safe([%e render_self_position_left_right(~loc, position)])]
      | `Static(Some(`Unsafe), position) =>
        [%expr `unsafe([%e render_self_position_left_right(~loc, position)])]
      | `Baseline_position(pos, ()) => render_baseline_position(~loc, pos)
      }
    },
  );

let justify_self =
  monomorphic(
    Property_parser.property_justify_self,
    (~loc) => [%expr CSS.justifySelf],
    (~loc, value) => {
      switch (value) {
      | `Auto => [%expr `auto]
      | `Normal => [%expr `normal]
      | `Stretch => [%expr `stretch]
      | `Static(None, position) =>
        [%expr [%e render_self_position_left_right(~loc, position)]]
      | `Static(Some(`Safe), position) =>
        [%expr `safe([%e render_self_position_left_right(~loc, position)])]
      | `Static(Some(`Unsafe), position) =>
        [%expr `unsafe([%e render_self_position_left_right(~loc, position)])]
      | `Baseline_position(pos, ()) => render_baseline_position(~loc, pos)
      }
    },
  );

let align_items =
  monomorphic(
    Property_parser.property_align_items,
    (~loc) => [%expr CSS.alignItems],
    (~loc, value) => {
      switch (value) {
      | `Normal => [%expr `normal]
      | `Stretch => [%expr `stretch]
      | `Baseline_position(pos, ()) => render_baseline_position(~loc, pos)
      | `Static(None, position) =>
        [%expr [%e render_self_position(~loc, position)]]
      | `Static(Some(`Safe), position) =>
        [%expr `safe([%e render_self_position(~loc, position)])]
      | `Static(Some(`Unsafe), position) =>
        [%expr `unsafe([%e render_self_position(~loc, position)])]
      | `Interpolation(v) => render_variable(~loc, v)
      }
    },
  );

let align_self =
  monomorphic(
    Property_parser.property_align_self,
    (~loc) => [%expr CSS.alignSelf],
    (~loc, value) => {
      switch (value) {
      | `Auto => [%expr `auto]
      | `Normal => [%expr `normal]
      | `Stretch => [%expr `stretch]
      | `Baseline_position(pos, ()) => render_baseline_position(~loc, pos)
      | `Static(None, position) =>
        [%expr [%e render_self_position(~loc, position)]]
      | `Static(Some(`Safe), position) =>
        [%expr `safe([%e render_self_position(~loc, position)])]
      | `Static(Some(`Unsafe), position) =>
        [%expr `unsafe([%e render_self_position(~loc, position)])]
      | `Interpolation(v) => render_variable(~loc, v)
      }
    },
  );

let align_content =
  monomorphic(
    Property_parser.property_align_content,
    (~loc) => [%expr CSS.alignContent],
    (~loc, value) => {
      switch (value) {
      | `Baseline_position(pos, ()) => render_baseline_position(~loc, pos)
      | `Normal => [%expr `normal]
      | `Content_distribution(distribution) =>
        render_content_distribution(~loc, distribution)
      | `Static(None, position) =>
        [%expr [%e render_content_position(~loc, position)]]
      | `Static(Some(`Safe), position) =>
        [%expr `safe([%e render_content_position(~loc, position)])]
      | `Static(Some(`Unsafe), position) =>
        [%expr `unsafe([%e render_content_position(~loc, position)])]
      }
    },
  );

let render_line_names = (~loc, value: Types.line_names) => {
  let ((), line_names, ()) = value;
  line_names
  |> String.concat(" ")
  |> Printf.sprintf("[%s]")
  |> (name => [[%expr `name([%e render_string(~loc, name)])]]);
};

let render_maybe_line_names = (~loc, value) => {
  switch (value) {
  | None => []
  | Some(names) => render_line_names(~loc, names)
  };
};

let render_inflexible_breadth = (~loc, value: Types.inflexible_breadth) => {
  switch (value) {
  | `Auto => [%expr `auto]
  | `Min_content => [%expr `minContent]
  | `Max_content => [%expr `maxContent]
  | `Extended_length(l) => render_extended_length(~loc, l)
  | `Extended_percentage(p) => render_extended_percentage(~loc, p)
  /* TODO: Maybe fit-content is also valid? */
  };
};

let render_fixed_breadth = (~loc, value: Types.fixed_breadth) => {
  switch (value) {
  | `Extended_length(l) => render_extended_length(~loc, l)
  | `Extended_percentage(p) => render_extended_percentage(~loc, p)
  };
};

let render_flex_value = (~loc, value: Types.flex_value) => {
  switch (value) {
  | `Fr(f) => [%expr `fr([%e render_float(~loc, f)])]
  };
};

let render_track_breadth = (~loc, value: Types.track_breadth) => {
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

let rec render_track_repeat = (~loc, repeat: Types.track_repeat) => {
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
   `repeat((`num([%e render_integer(~loc, positiveInteger)]), [%e items]))];
}
and render_track_size = (~loc, value: Types.track_size) => {
  switch (value) {
  | `Track_breadth(breadth) => render_track_breadth(~loc, breadth)
  | `Minmax(inflexible, (), breadth) =>
    [%expr
     `minmax((
       [%e render_inflexible_breadth(~loc, inflexible)],
       [%e render_track_breadth(~loc, breadth)],
     ))]
  | `Fit_content(`Extended_length(el)) =>
    [%expr `fitContent([%e render_extended_length(~loc, el)])]
  | `Fit_content(`Extended_percentage(ep)) =>
    [%expr `fitContent([%e render_extended_percentage(~loc, ep)])]
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

let render_fixed_size = (~loc, value: Types.fixed_size) => {
  switch (value) {
  | `Fixed_breadth(breadth) => render_fixed_breadth(~loc, breadth)
  | `Minmax_0(fixed, (), breadth) =>
    [%expr
     `minmax((
       [%e render_fixed_breadth(~loc, fixed)],
       [%e render_track_breadth(~loc, breadth)],
     ))]
  | `Minmax_1(inflexible, (), breadth) =>
    [%expr
     `minmax((
       [%e render_inflexible_breadth(~loc, inflexible)],
       [%e render_fixed_breadth(~loc, breadth)],
     ))]
  };
};

let render_fixed_repeat = (~loc, value: Types.fixed_repeat) => {
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

let render_auto_repeat = (~loc, value: Types.auto_repeat) => {
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

let render_auto_track_list = (~loc, value: Types.auto_track_list) => {
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

let render_name_repeat = (~loc, value: Types.name_repeat) => {
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

let render_subgrid = (~loc, line_name_list: Types.line_name_list) => {
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

// css-grid-1
let grid_template_columns =
  monomorphic(
    Property_parser.property_grid_template_columns,
    (~loc) => [%expr CSS.gridTemplateColumns],
    (~loc, value: Types.property_grid_template_columns) =>
      switch (value) {
      | `None => [%expr [|`none|]]
      | `Interpolation(v) => render_variable(~loc, v)
      | `Track_list(track_list, line_names) =>
        render_track_list(~loc, track_list, line_names)
      | `Auto_track_list(list) => render_auto_track_list(~loc, list)
      | `Static((), None) => [%expr [|`subgrid|]]
      | `Static((), Some(subgrid)) => render_subgrid(~loc, subgrid)
      },
  );

let grid_template_rows =
  monomorphic(
    Property_parser.property_grid_template_rows,
    (~loc) => [%expr CSS.gridTemplateRows],
    (~loc, value: Types.property_grid_template_rows) =>
      switch (value) {
      | `None => [%expr [|`none|]]
      | `Interpolation(v) => render_variable(~loc, v)
      | `Track_list(track_list, line_names) =>
        render_track_list(~loc, track_list, line_names)
      | `Auto_track_list(list) => render_auto_track_list(~loc, list)
      | `Static((), None) => [%expr [|`subgrid|]]
      | `Static((), Some(subgrid)) => render_subgrid(~loc, subgrid)
      },
  );

let grid_template_areas =
  unsupportedValue(Property_parser.property_grid_template_areas, (~loc) =>
    [%expr CSS.gridTemplateAreas]
  );

let grid_template =
  unsupportedProperty(Property_parser.property_grid_template);

let grid_auto_columns =
  unsupportedValue(Property_parser.property_grid_auto_columns, (~loc) =>
    [%expr CSS.gridAutoColumns]
  );

let grid_auto_rows =
  unsupportedValue(Property_parser.property_grid_auto_rows, (~loc) =>
    [%expr CSS.gridAutoRows]
  );

let grid_auto_flow =
  unsupportedValue(Property_parser.property_grid_auto_flow, (~loc) =>
    [%expr CSS.gridAutoFlow]
  );

let grid =
  unsupportedValue(Property_parser.property_grid, (~loc) => [%expr CSS.grid]);

let grid_row_start =
  unsupportedValue(Property_parser.property_grid_row_start, (~loc) =>
    [%expr CSS.gridRowStart]
  );

let grid_row_gap =
  monomorphic(
    Property_parser.property_grid_row_gap,
    (~loc) => [%expr CSS.gridRowGap],
    (~loc) =>
      fun
      | `Extended_length(el) => render_extended_length(~loc, el)
      | `Extended_percentage(ep) => render_extended_percentage(~loc, ep),
  );

let grid_column_gap =
  monomorphic(
    Property_parser.property_grid_column_gap,
    (~loc) => [%expr CSS.gridColumnGap],
    (~loc) =>
      fun
      | `Extended_length(el) => render_extended_length(~loc, el)
      | `Extended_percentage(ep) => render_extended_percentage(~loc, ep),
  );

let grid_column_start =
  unsupportedValue(Property_parser.property_grid_column_start, (~loc) =>
    [%expr CSS.gridColumnStart]
  );

let grid_row_end =
  unsupportedValue(Property_parser.property_grid_row_end, (~loc) =>
    [%expr CSS.gridRowEnd]
  );

let grid_column_end =
  unsupportedValue(Property_parser.property_grid_column_end, (~loc) =>
    [%expr CSS.gridColumnEnd]
  );

let grid_row =
  unsupportedValue(Property_parser.property_grid_row, (~loc) =>
    [%expr CSS.gridRow]
  );

let grid_column =
  unsupportedValue(Property_parser.property_grid_column, (~loc) =>
    [%expr CSS.gridColumn]
  );

let grid_area =
  unsupportedValue(Property_parser.property_grid_area, (~loc) =>
    [%expr CSS.gridArea]
  );

let grid_gap =
  monomorphic(
    Property_parser.property_grid_gap,
    (~loc) => [%expr CSS.gridGap],
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
  | (row, None) => [[%expr CSS.gap([%e render_gap(~loc, row)])]]
  | (row, Some(column)) => [
      [%expr
        CSS.gap2(
          ~rowGap=[%e render_gap(~loc, row)],
          ~columnGap=[%e render_gap(~loc, column)],
        )
      ],
    ]
  };
};

let gap = polymorphic(Property_parser.property_gap, render_property_gap);

let z_index =
  monomorphic(
    Property_parser.property_z_index,
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
    Property_parser.property_left,
    (~loc) => [%expr CSS.left],
    render_position_value,
  );

let top =
  monomorphic(
    Property_parser.property_top,
    (~loc) => [%expr CSS.top],
    render_position_value,
  );

let right =
  monomorphic(
    Property_parser.property_right,
    (~loc) => [%expr CSS.right],
    render_position_value,
  );

let bottom =
  monomorphic(
    Property_parser.property_bottom,
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
  | `_moz_box => [%expr `mozBox]
  | `_moz_inline_box => [%expr `mozInlineBox]
  | `_moz_inline_stack => [%expr `mozInlineStack]
  | `_ms_flexbox => [%expr `msFlexbox]
  | `_ms_grid => [%expr `msGrid]
  | `_ms_inline_flexbox => [%expr `msInlineFlexbox]
  | `_ms_inline_grid => [%expr `msInlineGrid]
  | `_webkit_box => [%expr `webkitBox]
  | `_webkit_flex => [%expr `webkitFlex]
  | `_webkit_inline_box => [%expr `webkitInlineBox]
  | `_webkit_inline_flex => [%expr `webkitInlineFlex];

let display =
  monomorphic(
    Property_parser.property_display,
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
    Property_parser.property_mask_image,
    (~loc) => [%expr CSS.maskImage],
    (~loc) =>
      fun
      | [one] => render_mask_image(~loc, one)
      | _ => raise(Unsupported_feature),
  );

let render_paint = (~loc, value: Types.paint) => {
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
    Property_parser.property_fill,
    (~loc) => [%expr CSS.SVG.fill],
    render_paint,
  );

let stroke =
  monomorphic(
    Property_parser.property_stroke,
    (~loc) => [%expr CSS.SVG.stroke],
    render_paint,
  );

let render_alpha_value = (~loc, value: Types.alpha_value) => {
  switch (value) {
  | `Number(n) => [%expr `num([%e render_float(~loc, n)])]
  | `Extended_percentage(pct) => render_extended_percentage(~loc, pct)
  };
};

let stroke_opacity =
  monomorphic(
    Property_parser.property_stroke_opacity,
    (~loc) => [%expr CSS.SVG.strokeOpacity],
    render_alpha_value,
  );

let line_break =
  monomorphic(
    Property_parser.property_line_break,
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

let found = ({ast_of_string, string_to_expr, _}) => {
  /* TODO: Why we have 'check_value' when we don't use it? */
  let check_value = string => {
    let.ok _ = ast_of_string(string);
    Ok();
  };
  (check_value, string_to_expr);
};

let caret_color = unsupportedProperty(Property_parser.property_caret_color);

let clear = unsupportedProperty(Property_parser.property_clear);

let clip = unsupportedProperty(Property_parser.property_clip);

let clip_path = unsupportedProperty(Property_parser.property_clip_path);

let column_count = unsupportedProperty(Property_parser.property_column_count);

let column_fill = unsupportedProperty(Property_parser.property_column_fill);

let column_gap =
  monomorphic(
    Property_parser.property_column_gap,
    (~loc) => [%expr CSS.columnGap],
    (~loc) => render_gap(~loc),
  );

let column_rule = unsupportedProperty(Property_parser.property_column_rule);

let column_rule_color =
  unsupportedProperty(Property_parser.property_column_rule_color);

let column_rule_style =
  unsupportedProperty(Property_parser.property_column_rule_style);

let column_rule_width =
  unsupportedProperty(Property_parser.property_column_rule_width);

let column_span = unsupportedProperty(Property_parser.property_column_span);

let columns = unsupportedProperty(Property_parser.property_columns);

let counter_increment =
  unsupportedProperty(Property_parser.property_counter_increment);

let counter_reset =
  unsupportedProperty(Property_parser.property_counter_reset);

let counter_set = unsupportedProperty(Property_parser.property_counter_set);

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
  | `_moz_grab => [%expr `_moz_grab]
  | `_moz_grabbing => [%expr `_moz_grabbing]
  | `_moz_zoom_in => [%expr `_moz_zoom_in]
  | `_moz_zoom_out => [%expr `_moz_zoom_out]
  | `_webkit_grab => [%expr `_webkit_grab]
  | `_webkit_grabbing => [%expr `_webkit_grabbing]
  | `_webkit_zoom_in => [%expr `_webkit_zoom_in]
  | `_webkit_zoom_out => [%expr `_webkit_zoom_out]
  };

let cursor =
  monomorphic(
    Property_parser.property_cursor,
    (~loc) => [%expr CSS.cursor],
    render_cursor,
  );

let direction = unsupportedProperty(Property_parser.property_direction);

let render_drop_shadow = (~loc, value: Types.function_drop_shadow) => {
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
   ))];
};

let render_float_percentage = (~loc, value: Types.number_percentage) => {
  switch (value) {
  | `Number(number) => [%expr `num([%e render_float(~loc, number)])]
  | `Extended_percentage(pct) => render_extended_percentage(~loc, pct)
  };
};

let render_filter_function = (~loc, value: Types.filter_function) => {
  switch (value) {
  | `Function_blur(v) => [%expr `blur([%e render_extended_length(~loc, v)])]
  | `Function_brightness(v) =>
    [%expr `brightness([%e render_float_percentage(~loc, v)])]
  | `Function_contrast(v) =>
    [%expr `contrast([%e render_float_percentage(~loc, v)])]
  | `Function_drop_shadow(v) => render_drop_shadow(~loc, v)
  | `Function_grayscale(v) =>
    [%expr `grayscale([%e render_float_percentage(~loc, v)])]
  | `Function_hue_rotate(v) =>
    [%expr `hueRotate([%e render_extended_angle(~loc, v)])]
  | `Function_invert(v) =>
    [%expr `invert([%e render_float_percentage(~loc, v)])]
  | `Function_opacity(v) =>
    [%expr `opacity([%e render_float_percentage(~loc, v)])]
  | `Function_saturate(v) =>
    [%expr `saturate([%e render_float_percentage(~loc, v)])]
  | `Function_sepia(v) =>
    [%expr `sepia([%e render_float_percentage(~loc, v)])]
  };
};

let render_filter_function_list = (~loc, value: Types.filter_function_list) => {
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
    Property_parser.property_filter,
    (~loc) => [%expr CSS.filter],
    (~loc, value) =>
      switch (value) {
      | `None => [%expr [|`none|]]
      | `Interpolation(v) => render_variable(~loc, v)
      | `Filter_function_list(ffl) => render_filter_function_list(~loc, ffl)
      | `_ms_filter_function_list(_) => raise(Unsupported_feature)
      },
  );

let backdrop_filter =
  monomorphic(
    Property_parser.property_backdrop_filter,
    (~loc) => [%expr CSS.backdropFilter],
    (~loc, value) =>
      switch (value) {
      | `None => [%expr [|`none|]]
      | `Interpolation(v) => render_variable(~loc, v)
      | `Filter_function_list(ffl) => render_filter_function_list(~loc, ffl)
      },
  );

let float = unsupportedProperty(Property_parser.property_float);

let font_language_override =
  unsupportedProperty(Property_parser.property_font_language_override);

let ime_mode = unsupportedProperty(Property_parser.property_ime_mode);

let isolation = unsupportedProperty(Property_parser.property_isolation);

let line_clamp = unsupportedProperty(Property_parser.property_line_clamp);

let list_style = unsupportedProperty(Property_parser.property_list_style);

let list_style_image =
  monomorphic(
    Property_parser.property_list_style_image,
    (~loc) => [%expr CSS.listStyleImage],
    (~loc, value: Types.property_list_style_image) => {
      switch (value) {
      | `None => [%expr `none]
      | `Image(i) => render_image(~loc, i)
      }
    },
  );

let list_style_position =
  unsupportedProperty(Property_parser.property_list_style_position);

let list_style_type =
  unsupportedProperty(Property_parser.property_list_style_type);

let mix_blend_mode =
  unsupportedProperty(Property_parser.property_mix_blend_mode);

let position = unsupportedProperty(Property_parser.property_position);

let resize = unsupportedProperty(Property_parser.property_resize);

let row_gap =
  monomorphic(
    Property_parser.property_row_gap,
    (~loc) => [%expr CSS.rowGap],
    (~loc) => render_gap(~loc),
  );

let scrollbar_3dlight_color =
  unsupportedProperty(Property_parser.property_scrollbar_3dlight_color);

let scrollbar_arrow_color =
  unsupportedProperty(Property_parser.property_scrollbar_arrow_color);

let scrollbar_base_color =
  unsupportedProperty(Property_parser.property_scrollbar_base_color);

let scrollbar_color =
  unsupportedProperty(Property_parser.property_scrollbar_color);

let scrollbar_darkshadow_color =
  unsupportedProperty(Property_parser.property_scrollbar_darkshadow_color);

let scrollbar_face_color =
  unsupportedProperty(Property_parser.property_scrollbar_face_color);

let scrollbar_highlight_color =
  unsupportedProperty(Property_parser.property_scrollbar_highlight_color);

let scrollbar_shadow_color =
  unsupportedProperty(Property_parser.property_scrollbar_shadow_color);

let scrollbar_track_color =
  unsupportedProperty(Property_parser.property_scrollbar_track_color);

let scrollbar_width =
  unsupportedProperty(Property_parser.property_scrollbar_width);

let stroke_dasharray =
  unsupportedProperty(Property_parser.property_stroke_dasharray);

let stroke_linecap =
  unsupportedProperty(Property_parser.property_stroke_linecap);

let stroke_linejoin =
  unsupportedProperty(Property_parser.property_stroke_linejoin);

let stroke_miterlimit =
  unsupportedProperty(Property_parser.property_stroke_miterlimit);

let stroke_width = unsupportedProperty(Property_parser.property_stroke_width);

let text_combine_upright =
  unsupportedProperty(Property_parser.property_text_combine_upright);

let all = unsupportedProperty(Property_parser.property_all);

let appearance = unsupportedProperty(Property_parser.property_appearance);

let background_blend_mode =
  unsupportedProperty(Property_parser.property_background_blend_mode);

let baseline_shift =
  unsupportedProperty(Property_parser.property_baseline_shift);

let block_size = unsupportedProperty(Property_parser.property_block_size);

let border_block_color =
  unsupportedProperty(Property_parser.property_border_block_color);

let border_block_end_color =
  unsupportedProperty(Property_parser.property_border_block_end_color);

let border_block_end_style =
  unsupportedProperty(Property_parser.property_border_block_end_style);

let border_block_end_width =
  unsupportedProperty(Property_parser.property_border_block_end_width);

let border_block_end =
  unsupportedProperty(Property_parser.property_border_block_end);

let border_block_start_color =
  unsupportedProperty(Property_parser.property_border_block_start_color);

let border_block_start_style =
  unsupportedProperty(Property_parser.property_border_block_start_style);

let border_block_start_width =
  unsupportedProperty(Property_parser.property_border_block_start_width);

let border_block_start =
  unsupportedProperty(Property_parser.property_border_block_start);

let border_block_style =
  unsupportedProperty(Property_parser.property_border_block_style);

let border_block_width =
  unsupportedProperty(Property_parser.property_border_block_width);

let border_block = unsupportedProperty(Property_parser.property_border_block);

let border_collapse =
  unsupportedProperty(Property_parser.property_border_collapse);

let border_end_end_radius =
  unsupportedProperty(Property_parser.property_border_end_end_radius);

let border_end_start_radius =
  unsupportedProperty(Property_parser.property_border_end_start_radius);

let border_inline_color =
  unsupportedProperty(Property_parser.property_border_inline_color);

let border_inline_end_color =
  unsupportedProperty(Property_parser.property_border_inline_end_color);

let border_inline_end_style =
  unsupportedProperty(Property_parser.property_border_inline_end_style);

let border_inline_end_width =
  unsupportedProperty(Property_parser.property_border_inline_end_width);

let border_inline_end =
  unsupportedProperty(Property_parser.property_border_inline_end);

let border_inline_start_color =
  unsupportedProperty(Property_parser.property_border_inline_start_color);

let border_inline_start_style =
  unsupportedProperty(Property_parser.property_border_inline_start_style);

let border_inline_start_width =
  unsupportedProperty(Property_parser.property_border_inline_start_width);

let border_inline_start =
  unsupportedProperty(Property_parser.property_border_inline_start);

let border_inline_style =
  unsupportedProperty(Property_parser.property_border_inline_style);

let border_inline_width =
  unsupportedProperty(Property_parser.property_border_inline_width);

let border_inline =
  unsupportedProperty(Property_parser.property_border_inline);

let border_spacing =
  unsupportedProperty(Property_parser.property_border_spacing);

let border_start_end_radius =
  unsupportedProperty(Property_parser.property_border_start_end_radius);

let border_start_start_radius =
  unsupportedProperty(Property_parser.property_border_start_start_radius);

let box_decoration_break =
  unsupportedProperty(Property_parser.property_box_decoration_break);

let break_after = unsupportedProperty(Property_parser.property_break_after);

let break_before = unsupportedProperty(Property_parser.property_break_before);

let break_inside = unsupportedProperty(Property_parser.property_break_inside);

let caption_side = unsupportedProperty(Property_parser.property_caption_side);

let clip_rule = unsupportedProperty(Property_parser.property_clip_rule);

let color_adjust = unsupportedProperty(Property_parser.property_color_adjust);

let color_interpolation_filters =
  unsupportedProperty(Property_parser.property_color_interpolation_filters);

let color_interpolation =
  unsupportedProperty(Property_parser.property_color_interpolation);

let color_scheme = unsupportedProperty(Property_parser.property_color_scheme);

let contain = unsupportedProperty(Property_parser.property_contain);

let content_visibility =
  unsupportedProperty(Property_parser.property_content_visibility);

let render_quote = (~loc, quote: Types.quote) => {
  switch (quote) {
  | `Close_quote => [%expr `closeQuote]
  | `No_close_quote => [%expr `noCloseQuote]
  | `No_open_quote => [%expr `noOpenQuote]
  | `Open_quote => [%expr `openQuote]
  };
};

let render_content_string = (~loc, str) => {
  let length = String.length(str);
  let str =
    if (length == 0) {
      [%expr {js|''|js}];
    } else if (length == 1 && str.[0] == '"') {
      [%expr {js|'"'|js}];
    } else if (length == 1 && str.[0] == ' ') {
      [%expr {js|' '|js}];
    } else if (length == 1 && str.[0] == '\'') {
      [%expr {js|"'"|js}];
    } else if (length == 2 && str.[0] == '"' && str.[1] == '"') {
      [%expr {js|""|js}];
    } else {
      let first = str.[0];
      let last = str.[length - 1];
      switch (first, last) {
      | ('\'', '\'') => [%expr [%e render_string(~loc, str)]]
      | ('"', '"') => [%expr [%e render_string(~loc, str)]]
      | _ => [%expr [%e render_string(~loc, str)]]
      };
    };
  [%expr `text([%e str])];
};

let render_content_list = (~loc, content_list: Types.content_list) => {
  content_list
  |> List.map(content_item =>
       switch (content_item) {
       | `Contents => [%expr `contents]
       | `Quote(quote) => render_quote(~loc, quote)
       | `String(str) => render_content_string(~loc, str)
       | `Url(u) => render_url(~loc, u)
       | `Counter(_label, _, _style) => raise(Unsupported_feature)
       | `Function_attr(_attr) => raise(Unsupported_feature)
       }
     )
  |> Builder.pexp_array(~loc);
};

let content =
  polymorphic(Property_parser.property_content, (~loc, value) => {
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

let empty_cells = unsupportedProperty(Property_parser.property_empty_cells);

let fill_opacity = unsupportedProperty(Property_parser.property_fill_opacity);

let fill_rule = unsupportedProperty(Property_parser.property_fill_rule);

let hyphenate_character =
  unsupportedProperty(Property_parser.property_hyphenate_character);

let hyphenate_limit_chars =
  unsupportedProperty(Property_parser.property_hyphenate_limit_chars);

let hyphenate_limit_lines =
  unsupportedProperty(Property_parser.property_hyphenate_limit_lines);

let hyphenate_limit_zone =
  unsupportedProperty(Property_parser.property_hyphenate_limit_zone);

let initial_letter_align =
  unsupportedProperty(Property_parser.property_initial_letter_align);

let initial_letter =
  unsupportedProperty(Property_parser.property_initial_letter);

let inline_size = unsupportedProperty(Property_parser.property_inline_size);

let inset_block_end =
  unsupportedProperty(Property_parser.property_inset_block_end);

let inset_block_start =
  unsupportedProperty(Property_parser.property_inset_block_start);

let inset_block = unsupportedProperty(Property_parser.property_inset_block);

let inset_inline_end =
  unsupportedProperty(Property_parser.property_inset_inline_end);

let inset_inline_start =
  unsupportedProperty(Property_parser.property_inset_inline_start);

let inset_inline = unsupportedProperty(Property_parser.property_inset_inline);

let inset = unsupportedProperty(Property_parser.property_inset);

let layout_grid_char =
  unsupportedProperty(Property_parser.property_layout_grid_char);

let layout_grid_line =
  unsupportedProperty(Property_parser.property_layout_grid_line);

let layout_grid_mode =
  unsupportedProperty(Property_parser.property_layout_grid_mode);

let layout_grid_type =
  unsupportedProperty(Property_parser.property_layout_grid_type);

let layout_grid = unsupportedProperty(Property_parser.property_layout_grid);

let mask_border_mode =
  unsupportedProperty(Property_parser.property_mask_border_mode);

let mask_border_outset =
  unsupportedProperty(Property_parser.property_mask_border_outset);

let mask_border_repeat =
  unsupportedProperty(Property_parser.property_mask_border_repeat);

let mask_border_slice =
  unsupportedProperty(Property_parser.property_mask_border_slice);

let mask_border_source =
  unsupportedProperty(Property_parser.property_mask_border_source);

let mask_border_width =
  unsupportedProperty(Property_parser.property_mask_border_width);

let mask_clip = unsupportedProperty(Property_parser.property_mask_clip);

let mask_composite =
  unsupportedProperty(Property_parser.property_mask_composite);

let mask_mode = unsupportedProperty(Property_parser.property_mask_mode);

let mask_origin = unsupportedProperty(Property_parser.property_mask_origin);

let mask_position =
  unsupportedProperty(Property_parser.property_mask_position);

let mask_repeat = unsupportedProperty(Property_parser.property_mask_repeat);

let mask_size = unsupportedProperty(Property_parser.property_mask_size);

let mask_type = unsupportedProperty(Property_parser.property_mask_type);

let max_block_size =
  unsupportedProperty(Property_parser.property_max_block_size);

let max_inline_size =
  unsupportedProperty(Property_parser.property_max_inline_size);

let min_block_size =
  unsupportedProperty(Property_parser.property_min_block_size);

let min_inline_size =
  unsupportedProperty(Property_parser.property_min_inline_size);

let nav_down = unsupportedProperty(Property_parser.property_nav_down);

let nav_left = unsupportedProperty(Property_parser.property_nav_left);

let nav_right = unsupportedProperty(Property_parser.property_nav_right);

let nav_up = unsupportedProperty(Property_parser.property_nav_up);

let offset_anchor =
  unsupportedProperty(Property_parser.property_offset_anchor);

let offset_distance =
  unsupportedProperty(Property_parser.property_offset_distance);

let offset_path = unsupportedProperty(Property_parser.property_offset_path);

let offset_position =
  unsupportedProperty(Property_parser.property_offset_position);

let offset_rotate =
  unsupportedProperty(Property_parser.property_offset_rotate);

let offset = unsupportedProperty(Property_parser.property_offset);

let orphans = unsupportedProperty(Property_parser.property_orphans);

let overflow_anchor =
  unsupportedProperty(Property_parser.property_overflow_anchor);

let overflow_clip_box =
  unsupportedProperty(Property_parser.property_overflow_clip_box);

let padding_block_end =
  unsupportedProperty(Property_parser.property_padding_block_end);

let padding_block_start =
  unsupportedProperty(Property_parser.property_padding_block_start);

let padding_block =
  unsupportedProperty(Property_parser.property_padding_block);

let padding_inline_end =
  unsupportedProperty(Property_parser.property_padding_inline_end);

let padding_inline_start =
  unsupportedProperty(Property_parser.property_padding_inline_start);

let padding_inline =
  unsupportedProperty(Property_parser.property_padding_inline);

let page_break_after =
  unsupportedProperty(Property_parser.property_page_break_after);

let page_break_before =
  unsupportedProperty(Property_parser.property_page_break_before);

let page_break_inside =
  unsupportedProperty(Property_parser.property_page_break_inside);

let table_layout = unsupportedProperty(Property_parser.property_table_layout);

/* let render_animatable_feature = (~loc) =>
   fun
   | `Scroll_position => [%expr `scrollPosition]
   | `Contents => [%expr `contents]
   | `Custom_ident(v) => render_string(~loc, v); */

let will_change =
  monomorphic(
    Property_parser.property_will_change,
    (~loc) => [%expr CSS.willChange],
    (~loc, value: Types.property_will_change) => {
      switch (value) {
      | `Auto => [%expr `auto]
      | _ => raise(Unsupported_feature)
      }
    },
  );

let writing_mode = unsupportedProperty(Property_parser.property_writing_mode);

let text_orientation =
  unsupportedProperty(Property_parser.property_text_orientation);

let touch_action = unsupportedProperty(Property_parser.property_touch_action);

let user_select =
  monomorphic(
    Property_parser.property_user_select,
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
    Property_parser.property_zoom,
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
    Property_parser.property_visibility,
    (~loc) => [%expr CSS.visibility],
    (~loc) =>
      fun
      | `Visible => [%expr `visible]
      | `Hidden => [%expr `hidden]
      | `Collapse => [%expr `collapse]
      | `Interpolation(v) => render_variable(~loc, v),
  );

let properties = [
  ("align-content", found(align_content)),
  ("align-items", found(align_items)),
  ("align-self", found(align_self)),
  ("all", found(all)),
  ("animation-delay", found(animation_delay)),
  ("animation-direction", found(animation_direction)),
  ("animation-duration", found(animation_duration)),
  ("animation-fill-mode", found(animation_fill_mode)),
  ("animation-iteration-count", found(animation_iteration_count)),
  ("animation-name", found(animation_name)),
  ("animation-play-state", found(animation_play_state)),
  ("animation-timing-function", found(animation_timing_function)),
  ("animation", found(animation)),
  ("appearance", found(appearance)),
  ("aspect-ratio", found(aspect_ratio)),
  ("backdrop-filter", found(backdrop_filter)),
  ("backface-visibility", found(backface_visibility)),
  ("background-attachment", found(background_attachment)),
  ("background-blend-mode", found(background_blend_mode)),
  ("background-clip", found(background_clip)),
  ("background-color", found(background_color)),
  ("background-image", found(background_image)),
  ("background-origin", found(background_origin)),
  ("background-position-x", found(background_position_x)),
  ("background-position-y", found(background_position_y)),
  ("background-position", found(background_position)),
  ("background-repeat", found(background_repeat)),
  ("background-size", found(background_size)),
  ("background", found(background)),
  ("baseline-shift", found(baseline_shift)),
  ("block-size", found(block_size)),
  ("border-block-color", found(border_block_color)),
  ("border-block-end-color", found(border_block_end_color)),
  ("border-block-end-style", found(border_block_end_style)),
  ("border-block-end-width", found(border_block_end_width)),
  ("border-block-end", found(border_block_end)),
  ("border-block-start-color", found(border_block_start_color)),
  ("border-block-start-style", found(border_block_start_style)),
  ("border-block-start-width", found(border_block_start_width)),
  ("border-block-start", found(border_block_start)),
  ("border-block-style", found(border_block_style)),
  ("border-block-width", found(border_block_width)),
  ("border-block", found(border_block)),
  ("border-bottom-color", found(border_bottom_color)),
  ("border-bottom-left-radius", found(border_bottom_left_radius)),
  ("border-bottom-right-radius", found(border_bottom_right_radius)),
  ("border-bottom-style", found(border_bottom_style)),
  ("border-bottom-width", found(border_bottom_width)),
  ("border-bottom", found(border_bottom)),
  ("border-collapse", found(border_collapse)),
  ("border-color", found(border_color)),
  ("border-end-end-radius", found(border_end_end_radius)),
  ("border-end-start-radius", found(border_end_start_radius)),
  ("border-image-outset", found(border_image_outset)),
  ("border-image-repeat", found(border_image_repeat)),
  ("border-image-slice", found(border_image_slice)),
  ("border-image-source", found(border_image_source)),
  ("border-image-width", found(border_image_width)),
  ("border-image", found(border_image)),
  ("border-inline-color", found(border_inline_color)),
  ("border-inline-end-color", found(border_inline_end_color)),
  ("border-inline-end-style", found(border_inline_end_style)),
  ("border-inline-end-width", found(border_inline_end_width)),
  ("border-inline-end", found(border_inline_end)),
  ("border-inline-start-color", found(border_inline_start_color)),
  ("border-inline-start-style", found(border_inline_start_style)),
  ("border-inline-start-width", found(border_inline_start_width)),
  ("border-inline-start", found(border_inline_start)),
  ("border-inline-style", found(border_inline_style)),
  ("border-inline-width", found(border_inline_width)),
  ("border-inline", found(border_inline)),
  ("border-left-color", found(border_left_color)),
  ("border-left-style", found(border_left_style)),
  ("border-left-width", found(border_left_width)),
  ("border-left", found(border_left)),
  ("border-radius", found(border_radius)),
  ("border-right-color", found(border_right_color)),
  ("border-right-style", found(border_right_style)),
  ("border-right-width", found(border_right_width)),
  ("border-right", found(border_right)),
  ("border-spacing", found(border_spacing)),
  ("border-start-end-radius", found(border_start_end_radius)),
  ("border-start-start-radius", found(border_start_start_radius)),
  ("border-style", found(border_style)),
  ("border-top-color", found(border_top_color)),
  ("border-top-left-radius", found(border_top_left_radius)),
  ("border-top-right-radius", found(border_top_right_radius)),
  ("border-top-style", found(border_top_style)),
  ("border-top-width", found(border_top_width)),
  ("border-top", found(border_top)),
  ("border-width", found(border_width)),
  ("border", found(border)),
  ("bottom", found(bottom)),
  ("box-decoration-break", found(box_decoration_break)),
  ("box-shadow", found(box_shadow)),
  ("box-sizing", found(box_sizing)),
  ("break-after", found(break_after)),
  ("break-before", found(break_before)),
  ("break-inside", found(break_inside)),
  ("caption-side", found(caption_side)),
  ("caret-color", found(caret_color)),
  ("clear", found(clear)),
  ("clip-path", found(clip_path)),
  ("clip-rule", found(clip_rule)),
  ("clip", found(clip)),
  ("content", found(content)),
  ("color-adjust", found(color_adjust)),
  ("color-interpolation-filters", found(color_interpolation_filters)),
  ("color-interpolation", found(color_interpolation)),
  ("color-scheme", found(color_scheme)),
  ("color", found(color)),
  ("column-count", found(column_count)),
  ("column-fill", found(column_fill)),
  ("column-gap", found(column_gap)),
  ("column-rule-color", found(column_rule_color)),
  ("column-rule-style", found(column_rule_style)),
  ("column-rule-width", found(column_rule_width)),
  ("column-rule", found(column_rule)),
  ("column-span", found(column_span)),
  ("column-width", found(column_width)),
  ("columns", found(columns)),
  ("contain", found(contain)),
  ("content-visibility", found(content_visibility)),
  ("content", found(content)),
  ("counter-increment", found(counter_increment)),
  ("counter-reset", found(counter_reset)),
  ("counter-set", found(counter_set)),
  ("cursor", found(cursor)),
  ("direction", found(direction)),
  ("display", found(display)),
  ("empty-cells", found(empty_cells)),
  ("fill-opacity", found(fill_opacity)),
  ("fill-rule", found(fill_rule)),
  ("fill", found(fill)),
  ("filter", found(filter)),
  ("flex", found(flex)),
  ("flex-basis", found(flex_basis)),
  ("flex-direction", found(flex_direction)),
  ("flex-flow", found(flex_flow)),
  ("flex-grow", found(flex_grow)),
  ("flex-shrink", found(flex_shrink)),
  ("flex-wrap", found(flex_wrap)),
  ("float", found(float)),
  ("font-family", found(font_family)),
  ("font-feature-settings", found(font_feature_settings)),
  ("font-kerning", found(font_kerning)),
  ("font-language-override", found(font_language_override)),
  ("font-optical-sizing", found(font_optical_sizing)),
  ("font-size-adjust", found(font_size_adjust)),
  ("font-size", found(font_size)),
  ("font-palette", found(font_palette)),
  ("font-stretch", found(font_stretch)),
  ("font-style", found(font_style)),
  ("font-synthesis-position", found(font_synthesis_position)),
  ("font-synthesis-small-caps", found(font_synthesis_small_caps)),
  ("font-synthesis-style", found(font_synthesis_style)),
  ("font-synthesis-weight", found(font_synthesis_weight)),
  ("font-synthesis", found(font_synthesis)),
  ("font-variant-alternates", found(font_variant_alternates)),
  ("font-variant-caps", found(font_variant_caps)),
  ("font-variant-east-asian", found(font_variant_east_asian)),
  ("font-variant-ligatures", found(font_variant_ligatures)),
  ("font-variant-numeric", found(font_variant_numeric)),
  ("font-variant-position", found(font_variant_position)),
  ("font-variant-emoji", found(font_variant_emoji)),
  ("font-variant", found(font_variant)),
  ("font-variation-settings", found(font_variation_settings)),
  ("font-weight", found(font_weight)),
  ("font", found(font)),
  ("gap", found(gap)),
  ("grid-area", found(grid_area)),
  ("grid-auto-columns", found(grid_auto_columns)),
  ("grid-auto-flow", found(grid_auto_flow)),
  ("grid-auto-rows", found(grid_auto_rows)),
  ("grid-column-end", found(grid_column_end)),
  ("grid-column-gap", found(grid_column_gap)),
  ("grid-column-start", found(grid_column_start)),
  ("grid-column", found(grid_column)),
  ("grid-gap", found(grid_gap)),
  ("grid-row-end", found(grid_row_end)),
  ("grid-row-gap", found(grid_row_gap)),
  ("grid-row-start", found(grid_row_start)),
  ("grid-row", found(grid_row)),
  ("grid-template-areas", found(grid_template_areas)),
  ("grid-template-columns", found(grid_template_columns)),
  ("grid-template-rows", found(grid_template_rows)),
  ("grid-template", found(grid_template)),
  ("grid", found(grid)),
  ("hanging-punctuation", found(hanging_punctuation)),
  ("height", found(height)),
  ("hyphenate-character", found(hyphenate_character)),
  ("hyphenate-limit-chars", found(hyphenate_limit_chars)),
  ("hyphenate-limit-lines", found(hyphenate_limit_lines)),
  ("hyphenate-limit-zone", found(hyphenate_limit_zone)),
  ("hyphens", found(hyphens)),
  ("image-orientation", found(image_orientation)),
  ("image-rendering", found(image_rendering)),
  ("image-resolution", found(image_resolution)),
  ("ime-mode", found(ime_mode)),
  ("initial-letter-align", found(initial_letter_align)),
  ("initial-letter", found(initial_letter)),
  ("inline-size", found(inline_size)),
  ("inset-block-end", found(inset_block_end)),
  ("inset-block-start", found(inset_block_start)),
  ("inset-block", found(inset_block)),
  ("inset-inline-end", found(inset_inline_end)),
  ("inset-inline-start", found(inset_inline_start)),
  ("inset-inline", found(inset_inline)),
  ("inset", found(inset)),
  ("isolation", found(isolation)),
  ("justify-content", found(justify_content)),
  ("justify-items", found(justify_items)),
  ("justify-self", found(justify_self)),
  ("layout-grid-char", found(layout_grid_char)),
  ("layout-grid-line", found(layout_grid_line)),
  ("layout-grid-mode", found(layout_grid_mode)),
  ("layout-grid-type", found(layout_grid_type)),
  ("layout-grid", found(layout_grid)),
  ("left", found(left)),
  ("letter-spacing", found(letter_spacing)),
  ("line-break", found(line_break)),
  ("line-clamp", found(line_clamp)),
  ("line-height-step", found(line_height_step)),
  ("line-height", found(line_height)),
  ("list-style-image", found(list_style_image)),
  ("list-style-position", found(list_style_position)),
  ("list-style-type", found(list_style_type)),
  ("list-style", found(list_style)),
  ("margin-bottom", found(margin_bottom)),
  ("margin-left", found(margin_left)),
  ("margin-right", found(margin_right)),
  ("margin-top", found(margin_top)),
  ("margin", found(margin)),
  ("mask-border-mode", found(mask_border_mode)),
  ("mask-border-outset", found(mask_border_outset)),
  ("mask-border-repeat", found(mask_border_repeat)),
  ("mask-border-slice", found(mask_border_slice)),
  ("mask-border-source", found(mask_border_source)),
  ("mask-border-width", found(mask_border_width)),
  ("mask-clip", found(mask_clip)),
  ("mask-composite", found(mask_composite)),
  ("mask-image", found(mask_image)),
  ("mask-mode", found(mask_mode)),
  ("mask-origin", found(mask_origin)),
  ("mask-position", found(mask_position)),
  ("mask-repeat", found(mask_repeat)),
  ("mask-size", found(mask_size)),
  ("mask-type", found(mask_type)),
  ("max-block-size", found(max_block_size)),
  ("max-height", found(max_height)),
  ("max-inline-size", found(max_inline_size)),
  ("max-lines", found(max_lines)),
  ("max-width", found(max_width)),
  ("min-block-size", found(min_block_size)),
  ("min-height", found(min_height)),
  ("min-inline-size", found(min_inline_size)),
  ("min-width", found(min_width)),
  ("mix-blend-mode", found(mix_blend_mode)),
  ("nav-down", found(nav_down)),
  ("nav-left", found(nav_left)),
  ("nav-right", found(nav_right)),
  ("nav-up", found(nav_up)),
  ("object-fit", found(object_fit)),
  ("object-position", found(object_position)),
  ("offset-anchor", found(offset_anchor)),
  ("offset-distance", found(offset_distance)),
  ("offset-path", found(offset_path)),
  ("offset-position", found(offset_position)),
  ("offset-rotate", found(offset_rotate)),
  ("offset", found(offset)),
  ("opacity", found(opacity)),
  ("order", found(order)),
  ("orphans", found(orphans)),
  ("outline", found(outline)),
  ("outline-color", found(outline_color)),
  ("outline-offset", found(outline_offset)),
  ("outline-style", found(outline_style)),
  ("outline-width", found(outline_width)),
  ("overflow-anchor", found(overflow_anchor)),
  ("overflow-block", found(overflow_block)),
  ("overflow-clip-box", found(overflow_clip_box)),
  ("overflow-inline", found(overflow_inline)),
  ("overflow-wrap", found(overflow_wrap)),
  ("overflow-x", found(overflow_x)),
  ("overflow-y", found(overflow_y)),
  ("overflow", found(overflow)),
  ("padding-block-end", found(padding_block_end)),
  ("padding-block-start", found(padding_block_start)),
  ("padding-block", found(padding_block)),
  ("padding-bottom", found(padding_bottom)),
  ("padding-inline-end", found(padding_inline_end)),
  ("padding-inline-start", found(padding_inline_start)),
  ("padding-inline", found(padding_inline)),
  ("padding-left", found(padding_left)),
  ("padding-right", found(padding_right)),
  ("padding-top", found(padding_top)),
  ("padding", found(padding)),
  ("page-break-after", found(page_break_after)),
  ("page-break-before", found(page_break_before)),
  ("page-break-inside", found(page_break_inside)),
  ("perspective-origin", found(perspective_origin)),
  ("perspective", found(perspective)),
  ("pointer-events", found(pointer_events)),
  ("position", found(position)),
  ("resize", found(resize)),
  ("right", found(right)),
  ("rotate", found(rotate)),
  ("row-gap", found(row_gap)),
  ("scale", found(scale)),
  ("scrollbar-3dlight-color", found(scrollbar_3dlight_color)),
  ("scrollbar-arrow-color", found(scrollbar_arrow_color)),
  ("scrollbar-base-color", found(scrollbar_base_color)),
  ("scrollbar-color", found(scrollbar_color)),
  ("scrollbar-darkshadow-color", found(scrollbar_darkshadow_color)),
  ("scrollbar-face-color", found(scrollbar_face_color)),
  ("scrollbar-highlight-color", found(scrollbar_highlight_color)),
  ("scrollbar-shadow-color", found(scrollbar_shadow_color)),
  ("scrollbar-track-color", found(scrollbar_track_color)),
  ("scrollbar-width", found(scrollbar_width)),
  ("stroke-opacity", found(stroke_opacity)),
  ("stroke-width", found(stroke_width)),
  ("stroke-dasharray", found(stroke_dasharray)),
  ("stroke-linecap", found(stroke_linecap)),
  ("stroke-linejoin", found(stroke_linejoin)),
  ("stroke-miterlimit", found(stroke_miterlimit)),
  ("stroke", found(stroke)),
  ("tab-size", found(tab_size)),
  ("table-layout", found(table_layout)),
  ("text-align-last", found(text_align_last)),
  ("text-align", found(text_align)),
  ("text-align-all", found(text_align_all)),
  ("text-combine-upright", found(text_combine_upright)),
  ("text-decoration-color", found(text_decoration_color)),
  ("text-decoration-line", found(text_decoration_line)),
  ("text-decoration-skip-ink", found(text_decoration_skip_ink)),
  ("text-decoration-skip", found(text_decoration_skip)),
  ("text-decoration-style", found(text_decoration_style)),
  ("text-decoration-thickness", found(text_decoration_thickness)),
  ("text-decoration", found(text_decoration)),
  ("text-decoration-skip-box", found(text_decoration_skip_box)),
  ("text-decoration-skip-inset", found(text_decoration_skip_inset)),
  ("text-decoration-skip-self", found(text_decoration_skip_self)),
  ("text-decoration-skip-spaces", found(text_decoration_skip_spaces)),
  ("text-emphasis-color", found(text_emphasis_color)),
  ("text-emphasis-position", found(text_emphasis_position)),
  ("text-emphasis-style", found(text_emphasis_style)),
  ("text-emphasis", found(text_emphasis)),
  ("text-indent", found(text_indent)),
  ("text-justify", found(text_justify)),
  ("text-orientation", found(text_orientation)),
  ("text-overflow", found(text_overflow)),
  ("text-shadow", found(text_shadow)),
  ("text-transform", found(text_transform)),
  ("text-underline-offset", found(text_underline_offset)),
  ("text-underline-position", found(text_underline_position)),
  ("top", found(top)),
  ("touch-action", found(touch_action)),
  ("transform-box", found(transform_box)),
  ("transform-origin", found(transform_origin)),
  ("transform-style", found(transform_style)),
  ("transform", found(transform)),
  ("transition-delay", found(transition_delay)),
  ("transition-duration", found(transition_duration)),
  ("transition-property", found(transition_property)),
  ("transition-timing-function", found(transition_timing_function)),
  ("transition", found(transition)),
  ("translate", found(translate)),
  ("user-select", found(user_select)),
  ("vertical-align", found(vertical_align)),
  ("visibility", found(visibility)),
  ("will-change", found(will_change)),
  ("white-space", found(white_space)),
  ("widows", found(widows)),
  ("width", found(width)),
  ("word-break", found(word_break)),
  ("word-spacing", found(word_spacing)),
  ("word-wrap", found(word_wrap)),
  ("writing-mode", found(writing_mode)),
  ("z-index", found(z_index)),
  ("zoom", found(zoom)),
];

let render_when_unsupported_features = (~loc, property, value) => {
  /* Transform property name to camelCase since we bind to emotion with the Object API */
  let propertyName = property |> to_camel_case |> render_string(~loc);
  let unsafeInterpolation =
    value
    |> Property_parser.parse(Standard.interpolation)
    |> Result.map(render_variable(~loc));
  let value =
    Result.value(unsafeInterpolation, ~default=render_string(~loc, value));

  [%expr CSS.unsafe([%e propertyName], [%e value])];
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
   )];
};

let render_to_expr = (~loc, property, value, important) => {
  let.ok expr_of_string =
    switch (findProperty(property)) {
    | Some((_, (_, expr_of_string))) => Ok(expr_of_string)
    | None => Error(`Property_not_found)
    };

  switch (expr_of_string(~loc, value)) {
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
    let.ok is_valid_string =
      Property_parser.check_property(~name=property, value)
      |> Result.map_error((`Unknown_value) => `Property_not_found);

    switch (render_css_global_values(~loc, property, value)) {
    | Ok(value) => Ok(value)
    | Error(_) =>
      switch (render_to_expr(~loc, property, value, important)) {
      | Ok(value) => Ok(value)
      | exception (Invalid_value(v)) =>
        Error(`Invalid_value(value ++ ". " ++ v))
      | Error(_)
      | exception Unsupported_feature =>
        let.ok () = is_valid_string ? Ok() : Error(`Invalid_value(value));
        Ok([render_when_unsupported_features(~loc, property, value)]);
      }
    };
  };
