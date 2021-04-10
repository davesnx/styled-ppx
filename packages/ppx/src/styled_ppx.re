open Ppxlib;
open Asttypes;
open Parsetree;
open Ast_helper;
open Longident;

module Ast_builder = Ppxlib.Ast_builder.Default;

let raiseWithLocation = (~loc, msg) => {
  raise(Location.raise_errorf(~loc, msg))
};

let isOptional = str =>
  switch (str) {
  | Optional(_) => true
  | _ => false
  };

let isLabelled = str =>
  switch (str) {
  | Labelled(_) => true
  | _ => false
  };

let getLabel = str =>
  switch (str) {
  | Optional(str)
  | Labelled(str) => str
  | Nolabel => ""
  };

let getTag = str => {
  switch (String.split_on_char('.', str)) {
  | ["styled"] => "div"
  | ["styled", tag] => tag
  | _ => "div"
  };
};

let getType = pattern =>
  switch (pattern) {
  | {ppat_desc: Ppat_constraint(_, type_), _} => Some(type_)
  | _ => None
  };

let getAlias = (pattern, label) =>
  switch (pattern) {
  | {ppat_desc: Ppat_alias(_, {txt, _}) | Ppat_var({txt, _}), _} => txt
  | {ppat_desc: Ppat_any, _} => "_"
  | _ => getLabel(label)
  };

/* let safeTypeFromValue = valueStr => {
  let valueStr = getLabel(valueStr);
  switch (String.sub(valueStr, 0, 1)) {
  | "_" => "T" ++ valueStr
  | _ => valueStr
  };
}; */


let rec getLabeledArgs = (mapper, expr, list) => {
  let expr = mapper.expr(mapper, expr);
  switch (expr.pexp_desc) {
  | Pexp_fun(arg, default, pattern, expression)
      when isOptional(arg) || isLabelled(arg) =>
    let alias = getAlias(pattern, arg);
    let type_ = getType(pattern);

    getLabeledArgs(
      mapper,
      expression,
      [(arg, default, pattern, alias, pattern.ppat_loc, type_), ...list],
    );
  | Pexp_fun(arg, _, pattern, _) when !isLabelled(arg) =>
    raiseWithLocation(
      ~loc=pattern.ppat_loc,
      "Dynamic components are defined with labeled arguments. If you want to know more check the documentation: https://reasonml.org/docs/manual/latest/function#labeled-arguments",
    )
  | _ => (expr, list, None)
  };
};

let styleVariableName = "styles";

let isStyledTag = str =>
  switch (String.split_on_char('.', str)) {
  | ["styled", ..._] => true
  | _ => false
  };

let match_exp_string_payload = (expr: Ppxlib.expression) => {
  open Ppxlib.Ast_pattern;
  let pattern =
    pexp_extension(
      extension(
        __,
        pstr(
          pstr_eval(pexp_constant(pconst_string(__', __, none)), nil) ^:: nil,
        ),
      ),
    );
  parse(
    pattern,
    expr.pexp_loc,
    ~on_error=_ => None,
    expr,
    (key, payload, delim) => Some((key, payload, delim)),
  );
};

let renderStringPayload = (
  kind,
  ~loc as _: location,
  ~path as _: label,
  ~arg as _,
  payload, _
) => {
  let {txt: string, loc} = payload;
  let loc_start = loc.Location.loc_start;

  let parse = parser =>
    Css_lexer.parse_string(
      ~container_lnum=loc_start.Lexing.pos_lnum,
      ~pos=loc_start,
      string,
      parser,
    );

  switch (kind) {
  | `Style =>
    let ast = parse(Css_parser.declaration_list);
    Css_to_emotion.render_emotion_css(ast);
  | `Declarations =>
    let ast = parse(Css_parser.declaration_list);
    Css_to_emotion.render_declaration_list(ast);
  | `Global =>
    let ast = parse(Css_parser.stylesheet);
    Css_to_emotion.render_global(ast);
  | `Keyframe =>
    let ast = parse(Css_parser.stylesheet);
    Css_to_emotion.render_emotion_keyframe(ast);
  };
};

/* let renderPayload = (kind, default_mapper, expr) => {
  // this mapper is used inside of [%styled.div expr]
  let mapper = {
    ...default_mapper,
    expr: (mapper, expr) => {
      let map = expr => mapper.Ast_mapper.expr(mapper, expr);
      let loc = expr.pexp_loc;
      switch (expr.pexp_desc) {
      | Pexp_constant(Pconst_string(payload, delim)) =>
        renderStringPayload(`Declarations, {txt: payload, loc}, delim)
      | Pexp_sequence(left, right) =>
        Ast_builder.eapply(~loc, [%expr (@)], [map(left), map(right)])
      | _ => default_mapper.expr(mapper, expr)
      };
    },
  };

  switch (expr.pexp_desc) {
  | Pexp_constant(Pconst_string(str, delim)) =>
    renderStringPayload(kind, {txt: str, loc: expr.pexp_loc}, delim)
  | _ =>
    Css_to_emotion.render_emotion_style(mapper.Ast_mapper.expr(mapper, expr))
  };
};
 */

let renderStyledDynamic = (~tag, ) => {
  /* Fix getLabeledArgs, to stop ignoring the first arg */
  let alias = getAlias(pattern, label);
  let type_ = getType(pattern);

  let firstArg = (label, args, pattern, alias, pattern.ppat_loc, type_);

  let (functionExpr, argList, _) =
    getLabeledArgs(mapper, expression, [firstArg]);

  if (!Html.isValidTag(tag)) {
    raiseWithLocation(
      ~loc=nameLoc,
      "Unexpected HTML tag in [%styled." ++ tag ++ "]",
    );
  };

  let loc = expression.pexp_loc;

  let propExpr = Exp.ident(~loc, {txt: Lident("props"), loc});
  let propToGetter = str => str ++ "Get";

  let args =
    List.map(
      ((arg, _, _, _, _, _)) => {
        let labelText = getLabel(arg);
        let value =
          Exp.ident(~loc, {txt: Lident(propToGetter(labelText)), loc});

        (arg, Exp.apply(~loc, value, [(Nolabel, propExpr)]));
      },
      argList,
    );

  let styledExpr =
    Exp.apply(
      ~loc,
      Exp.ident(~loc, {txt: Lident(styleVariableName), loc}),
      args,
    );

  let variableList =
    List.map(
      ((arg, _, _, _, loc, type_)) => {
        let label = getLabel(arg);
        let (kind, type_) =
          switch (type_) {
          | Some(type_) => (`Typed, type_)
          | None => (`Open, Create.typeVariable(~loc, label))
          };
        (label, kind, type_);
      },
      argList,
    );
  let variableParams =
    variableList
    |> List.filter_map(
          fun
          | (_, `Open, type_) => Some(type_)
          | _ => None,
        );
  let _variableProps =
    List.map(
      ((label, _, type_)) => Create.customPropLabel(~loc, label, type_),
      variableList,
    );
  let _css_expr = renderPayload(`Style, default_mapper, functionExpr);

  Ast_builder.pmod_structure(~loc, [[%stri let x = ()]]);

  /* Mod.mk(
    Pmod_structure([
      Create.makeProps(~loc, Some((variableParams, variableProps))),
      Create.externalCreateVariadicElement(~loc),
      Create.dynamicStyles(
        ~loc,
        ~name=styleVariableName,
        ~args=argList,
        ~exp=css_expr,
      ),
      Create.component(
        ~loc,
        ~tag,
        ~styledExpr,
        ~params=Some(variableParams),
      ),
    ]),
  ); */
};

let renderStyledStatic = (~tag as _, ~str, ~delim) => {
  let loc = str.loc;
  let _css_expr = renderStringPayload(`Style, str, delim);
  let _styledExpr =
    Exp.ident(~loc, {txt: Lident(styleVariableName), loc});

  /* Ast_builder.pmod_structure(~loc, [
    Create.makeProps(~loc, None),
    Create.externalCreateVariadicElement(~loc),
    Create.styles(~loc, ~name=styleVariableName, ~exp=css_expr),
    Create.component(~loc, ~tag, ~styledExpr, ~params=None)
  ]); */
  Ast_builder.pmod_structure(~loc, [[%stri let x = ()]]);
};

let string_payload =
  Ast_pattern.(
    pstr(
      pstr_eval(pexp_constant(pconst_string(__', __, none)), nil) ^:: nil,
    ),
);

let pattern =
  Ast_pattern.(
    pstr(
      pstr_eval(
        map(
          ~f=
            (f, lbl, def, param, body) =>
              f(`Fun((lbl, def, param, body))),
          pexp_fun(__, __, __, __),
        )
        ||| map(
              ~f=(f, payload, delim) => f(`String((payload, delim))),
              pexp_constant(pconst_string(__', __, none)),
            )
        ||| map(~f=(f, expr) => f(`Expr(expr)), __),
        nil,
      )
      ^:: nil
      ||| map(~f=f => f(`None), nil),
    )
  );

let renderStyledComponent = (~loc, ~payload, ~tag) =>
  switch (payload) {
  | `String((cssString, delimiter)) =>
    renderStyledStatic(~tag, ~str, ~delim)
  | `None =>
    renderStyledStatic(~tag="div", ~str={loc: Location.none, txt:""}, ~delim)
  | `Fun((label, defaultValue, param, body)) =>
    renderStyledDynamic(
      ~loc,
      ~tag,
      ~label,
      ~defaultValue,
      ~param,
      ~body,
    )
  };

let extensions = [
  Ppxlib.Extension.declare_with_path_arg(
    "css",
    Ppxlib.Extension.Context.Expression,
    string_payload,
    renderStringPayload(`Style),
  ),
  Ppxlib.Extension.declare_with_path_arg(
    "styled.global",
    Ppxlib.Extension.Context.Expression,
    string_payload,
    renderStringPayload(`Global)
  ),
  Ppxlib.Extension.declare_with_path_arg(
    "styled.keyframe",
    Ppxlib.Extension.Context.Expression,
    string_payload,
    renderStringPayload(`Keyframe)
  ),
  Ppxlib.Extension.declare_with_path_arg(
    "styled",
    Ppxlib.Extension.Context.Module_expr,
    pattern,
    (~loc as extensionLoc, ~path as _, ~arg, payload) => {
      switch (arg) {
      | Some({txt: Lident(tag), loc}) when Html.isValidTag(tag) =>
        renderStyledComponent(~loc, ~tag, ~payload)
      | None => renderStyledComponent(~loc=extensionLoc, ~tag="div", ~payload)
      | Some({loc, txt: _}) =>
        raiseWithLocation(
          ~loc,
          "Unknown HTML tag. Try something like styled.div",
          /* Longident.name(txt) */
        )
      }
    }
  )
];

let _ =
  Driver.register_transformation(~extensions, "styled-ppx");