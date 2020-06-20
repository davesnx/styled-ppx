open Migrate_parsetree;
open Ast_410;
open Ast_helper;
open Css_types;
open Component_value;
open Reason_css_parser;
open Parser;

let id = Fun.id;

type transform('ast, 'value) = {
  ast_of_string: string => result('ast, string),
  value_of_ast: 'ast => 'value,
  value_to_expr: 'value => list(Parsetree.expression),
  ast_to_expr: 'ast => list(Parsetree.expression),
  string_to_expr: string => result(list(Parsetree.expression), string),
};

let transform = (parser, value_of_ast, value_to_expr) => {
  let ast_of_string = Parser.parse(parser);
  let ast_to_expr = ast => value_of_ast(ast) |> value_to_expr;
  let string_to_expr = string =>
    ast_of_string(string) |> Result.map(ast_to_expr);
  {ast_of_string, value_of_ast, value_to_expr, ast_to_expr, string_to_expr};
};

let render_integer = integer => Const.int(integer) |> Exp.constant;
let render_number = number =>
  Const.float(number |> string_of_float) |> Exp.constant;

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
  | `Auto => id([%expr `auto]);

let apply = (parser, map, id) =>
  transform(parser, map, arg => [[%expr [%e id]([%e arg])]]);
let variants = (parser, identifier) =>
  apply(parser, variants_to_expression, identifier);

let width = _x => [%expr `cm(1.0)];

// using id() because refmt
let flex_direction =
  variants(property_flex_direction, [%expr Css.flexDirection]);
let flex_wrap = variants(property_flex_wrap, [%expr Css.flexWrap]);
// shorthand - https://drafts.csswg.org/css-flexbox-1/#flex-flow-property
let flex_flow =
  transform(
    property_flex_flow,
    id,
    ((direction_ast, wrap_ast)) => {
      let direction = Option.map(flex_direction.ast_to_expr, direction_ast);
      let wrap = Option.map(flex_wrap.ast_to_expr, wrap_ast);
      [direction, wrap] |> List.concat_map(Option.value(~default=[]));
    },
  );
// TODO: this is safe?
let order = apply(property_order, render_integer, [%expr Css.order]);
let flex_grow =
  apply(property_flex_grow, render_number, [%expr Css.flexGrow]);
let flex_shrink =
  apply(property_flex_shrink, render_number, [%expr Css.flexShrink]);
// TODO: is safe to just return Css.width when flex_basis?
let flex_basis =
  apply(
    property_flex_basis,
    fun
    | `Content => variants_to_expression(`Content)
    | `Property_width(value_width) => width(value_width),
    [%expr Css.flexBasis],
  );
// TODO: this is incomplete
let flex =
  transform(
    property_flex,
    id,
    fun
    | `None => [[%expr Css.flex(`none)]]
    | `Or(grow_shrink, basis) => {
        let grow_shrink =
          switch (grow_shrink) {
          | None => []
          | Some((grow, shrink)) =>
            List.concat([
              flex_grow.ast_to_expr(grow),
              Option.map(flex_shrink.ast_to_expr, shrink)
              |> Option.value(~default=[]),
            ])
          };
        let basis =
          switch (basis) {
          | None => []
          | Some(basis) => flex_basis.ast_to_expr(basis)
          };
        List.concat([grow_shrink, basis]);
      },
  );
// TODO: justify_content, align_items, align_self, align_content are only for flex, missing the css-align-3 at parser
let justify_content =
  variants(property_justify_content, [%expr Css.justifyContent]);
let align_items = variants(property_align_items, [%expr Css.alignItems]);
let align_self = variants(property_align_self, [%expr Css.alignSelf]);
let align_content =
  variants(property_align_content, [%expr Css.alignContent]);

let found = ({string_to_expr, _}) => string_to_expr;
let properties = [
  ("flex-direction", found(flex_direction)),
  ("flex-wrap", found(flex_wrap)),
  ("flex-flow", found(flex_flow)),
  ("order", found(order)),
  ("flex-grow", found(flex_grow)),
  ("flex-shrink", found(flex_shrink)),
  ("flex-basis", found(flex_basis)),
  // TODO: missing a proper implementation
  ("flex", found(flex)),
  ("justify-content", found(justify_content)),
  ("align-items", found(align_items)),
  ("align-self", found(align_self)),
  ("align-content", found(align_content)),
];

// TODO: this is a terrible workaround
let rec string_of_values = values => {
  let string_of_value =
    fun
    | Percentage(s) => s ++ "%"
    | String(s) => "'" ++ s ++ "'"
    | Uri(s) => "url(" ++ s ++ ")"
    | Function((name, _), (values, _)) =>
      name ++ "(" ++ string_of_values(values) ++ ")"
    | Hash(s) => "#" ++ s
    | Float_dimension((n, s, _))
    | Dimension((n, s)) => n ++ s
    | Ident(s)
    | Selector(s)
    | Operator(s)
    | Delim(s)
    | Number(s) => s
    | Variable(_)
    | Paren_block(_)
    | Bracket_block(_)
    | TypedVariable(_)
    | Unicode_range(_) => failwith("unsupported right know");
  values
  |> List.map(((value, _)) => string_of_value(value))
  |> String.concat(" ");
};

let support_property = name =>
  properties |> List.exists(((key, _)) => key == name);
let parse_declarations = ((name, value)) => {
  let (let.ok) = Result.bind;
  let value = string_of_values(value);
  let.ok (_, string_to_expr) =
    properties
    |> List.find_opt(((key, _)) => key == name)
    |> Option.to_result(~none=`Not_found);
  string_to_expr(value) |> Result.map_error(str => `Invalid_value(str));
};
