open Ppxlib;
module Build = Ast_builder.Default;

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

let getType = pattern =>
  switch (pattern.ppat_desc) {
  | Ppat_constraint(_, type_) => Some(type_)
  | _ => None
  };

let getAlias = (pattern, label) =>
  switch (pattern.ppat_desc) {
  | Ppat_alias(_, {txt, _}) | Ppat_var({txt, _}) => txt
  | Ppat_any => "_"
  | _ => getLabel(label)
  };

let rec getArgs = (expr, list) => {
  switch (expr.pexp_desc) {
  | Pexp_fun(arg, default, pattern, expression)
      when isOptional(arg) || isLabelled(arg) =>
    let alias = getAlias(pattern, arg);
    let type_ = getType(pattern);

    getArgs(
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

let getLabeledArgs = (label, defaultValue, param, expr) => {
  /* Get the first argument of the Pexp_fun, since it's a recursive type.
  getArgs gets all the function parameters from the first nested resursive node. */
  let alias = getAlias(param, label);
  let type_ = getType(param);
  let firstArg = (label, defaultValue, param, alias, param.ppat_loc, type_);

  getArgs(expr, [firstArg]);
};

let styleVariableName = "styles";

/* TODO: Bring back "delimiter location conditional logic" */
let renderStringPayload = (kind, {txt: string, loc}, _delim): Parsetree.expression => {
  let loc_start = loc.Location.loc_start;

  let makeParser = parser =>
    Css_lexer.parse_string(
      ~container_lnum=loc_start.Lexing.pos_lnum,
      ~pos=loc_start,
      parser
    );

  switch (kind) {
  | `Style =>
    let parser = makeParser(Css_parser.declaration_list);
    let ast = parser(string);
    Css_to_emotion.render_emotion_css(ast);
  | `Declarations =>
    let parser = makeParser(Css_parser.declaration_list);
    let ast = parser(string);
    Css_to_emotion.render_declaration_list(ast);
  | `Global =>
    let parser = makeParser(Css_parser.stylesheet);
    let ast = parser(string);
    Css_to_emotion.render_global(ast);
  | `Keyframe =>
    let parser = makeParser(Css_parser.stylesheet);
    let ast = parser(string);
    Css_to_emotion.render_emotion_keyframe(ast);
  };
};

let renderStyledDynamic = (~loc as _,
      ~htmlTag,
      ~label,
      ~defaultValue,
      ~param,
      ~body) => {
  /* TODO: What's the last arg here, None? */
  let (functionExpr, labeledArguments, _) =
    getLabeledArgs(label, defaultValue, param, body);

  let loc = body.pexp_loc;
  let propExpr = Build.pexp_ident(~loc, {txt: Lident("props"), loc});
  let propToGetter = str => str ++ "Get";

  let styledFunctionArguments =
    List.map(
      ((arg, _, _, _, _, _)) => {
        let labelText = getLabel(arg);
        let value =
          Build.pexp_ident(~loc, {txt: Lident(propToGetter(labelText)), loc});

        (arg, Build.pexp_apply(~loc, value, [(Nolabel, propExpr)]));
      },
      labeledArguments,
    );

  let styledFunctionExpr =
    Build.pexp_apply(
      ~loc,
      Build.pexp_ident(~loc, {txt: Lident(styleVariableName), loc}),
      styledFunctionArguments,
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
      labeledArguments,
    );

  let makePropsParameters =
    variableList
    |> List.filter_map(
          fun
          | (_, `Open, type_) => Some(type_)
          | _ => None,
        );

  let variableMakeProps =
    List.map(
      ((label, _, type_)) => Create.customPropLabel(~loc, label, type_),
      variableList,
    );

  let styles = switch (functionExpr.pexp_desc) {
  | Pexp_constant(Pconst_string(str, delim, _)) =>
    renderStringPayload(`Declarations, {txt: str, loc: functionExpr.pexp_loc}, delim)
  | _ => [%expr ""]
    /*
      This case is when `Fun doesn't contain a string, this is an attempt to support dynamic components with functions, such as:
      module Component = [%styled.section (~a, ~b) => switch () {}]

      The implementation below is the previous way to handle the nested transformation inside those functions, such as:

      module Component = [%styled.section (~a) => switch (a) {
        | Black => [%css ""]
        | White => [%css ""]
      }];

      Right now we don't support this syntax, the output is [%expr ""], we could raise an error if somebody relied on this (which is pretty unlikely).
    */
    /*
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
     */
  };

  Build.pmod_structure(~loc, [
    Create.makeMakeProps(
      ~loc,
      ~customProps=Some((makePropsParameters, variableMakeProps))
    ),
    /* We inline a createVariadicElement binding on each styled component, since styled-ppx doesn't come as a lib */
    Create.bindingCreateVariadicElement(~loc),
    Create.dynamicStyles(
      ~loc,
      ~name=styleVariableName,
      ~args=labeledArguments,
      ~exp=Css_to_emotion.render_emotion_style(styles),
    ),
    Create.component(
      ~loc,
      ~htmlTag,
      ~styledExpr=styledFunctionExpr,
      ~params=makePropsParameters,
    ),
  ]);
};

let renderStyledStatic = (~htmlTag, ~str, ~delim) => {
  let loc = str.loc;
  let css_expr = renderStringPayload(`Style, str, Some(delim));
  let styledExpr =
    Build.pexp_ident(~loc, {txt: Lident(styleVariableName), loc});

  Build.pmod_structure(~loc, [
    Create.makeMakeProps(~loc, ~customProps=None),
    /* We inline a createVariadicElement binding on each styled component, since styled-ppx doesn't come as a lib */
    Create.bindingCreateVariadicElement(~loc),
    Create.styles(~loc, ~name=styleVariableName, ~exp=css_expr),
    Create.component(~loc, ~htmlTag, ~styledExpr, ~params=[])
  ]);
};

let string_payload =
  Ast_pattern.(
    pstr(
      pstr_eval(
        pexp_constant(pconst_string(__', __, none)),
        nil
      ) ^:: nil,
    ),
);

/* TODO: Ensure we are capturing String and Fun properly */
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
              ~f=(f, payload, delim, m) => f(`String((payload, delim, m))),
              pexp_constant(pconst_string(__', __, __)),
            )
        ,
        nil,
      )
      ^:: nil
    )
  );

type payloadType = [
  | `Fun(arg_label, option(expression), pattern, expression)
  | `String(Ast_helper.with_loc(label), location, option(string))
];

let renderStyledComponent = (~loc, ~path as _, ~arg as _, htmlTag, payload: payloadType) => {
  switch (payload) {
  | `String((str, delim, _)) =>
    renderStyledStatic(~htmlTag, ~str, ~delim)
  | `Fun((label, defaultValue, param, body)) =>
    renderStyledDynamic(
      ~loc,
      ~htmlTag,
      ~label,
      ~defaultValue,
      ~param,
      ~body,
    )
  };
};

let extensions = [
  Ppxlib.Extension.declare_with_path_arg(
    "css",
    Ppxlib.Extension.Context.Expression,
    string_payload,
    (~loc as _: location, ~path as _: label, ~arg as _) => renderStringPayload(`Style),
  ),
  Ppxlib.Extension.declare_with_path_arg(
    "styled.global",
    Ppxlib.Extension.Context.Expression,
    string_payload,
    (~loc as _: location, ~path as _: label, ~arg as _) => renderStringPayload(`Global)
  ),
  Ppxlib.Extension.declare_with_path_arg(
    "styled.keyframe",
    Ppxlib.Extension.Context.Expression,
    string_payload,
    (~loc as _: location, ~path as _: label, ~arg as _) => renderStringPayload(`Keyframe)
  ),
  /* Currently there's no way to define extensions like `lola.x` with Pplib.Extension, we generate one ppxlib.extension per html tag. Is possible to achive it with Ppxlib.Driver.register_transformation(~preprocess_impl).  */
  ...List.map(htmlTag => {
    Ppxlib.Extension.declare_with_path_arg(
      "styled." ++ htmlTag,
      Ppxlib.Extension.Context.Module_expr,
      pattern,
      renderStyledComponent(htmlTag)
    )
  }, Html.allTags),
];

/* Instrument is needed to run metaquote before styled-ppx, we rely on this order for the native tests */
let instrument = Driver.Instrument.make(i => i, ~position=Before);

Driver.register_transformation(~extensions, ~instrument, "styled-ppx");