open Ppxlib;
open Generate_lib;

let getIsOptional = str =>
  switch (str) {
  | Optional(_) => true
  | _ => false
  };

let getIsLabelled = str =>
  switch (str) {
  | Labelled(_) => true
  | _ => false
  };

let getNotLabelled = str =>
  switch (str) {
  | Nolabel => true
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
  | Ppat_alias(_, {txt, _})
  | Ppat_var({txt, _}) => txt
  | Ppat_any => "_"
  | _ => getLabel(label)
  };

let rec getArgs = (expr, list) => {
  switch (expr.pexp_desc) {
  | Pexp_fun(arg, default, pattern, expression)
      when getIsOptional(arg) || getIsLabelled(arg) =>
    let alias = getAlias(pattern, arg);
    let type_ = getType(pattern);

    getArgs(
      expression,
      [(arg, default, pattern, alias, pattern.ppat_loc, type_), ...list],
    );
  | Pexp_fun(arg, _, pattern, _) when !getIsLabelled(arg) =>
    Generate_lib.raiseError(
      ~loc=pattern.ppat_loc,
      ~description="Dynamic components are defined with labeled arguments.",
      ~example=Some("[%styled.div (~a, ~b) => {}]"),
      ~link=
        "https://reasonml.org/docs/manual/latest/function#labeled-arguments",
    )
  | _ => (expr, list)
  };
};

let getIsEmpty = param => {
  switch (param.ppat_desc) {
  /* Not completly sure if this checks emptyness */
  | Ppat_construct(_, _) => true
  | _ => false
  };
};

let getLabeledArgs = (label, defaultValue, param, expr) => {
  /* Get the first argument of the Pexp_fun, since it's a recursive type.
     getArgs gets all the function parameters from the next parsetree */
  let alias = getAlias(param, label);
  let type_ = getType(param);
  let firstArg = (label, defaultValue, param, alias, param.ppat_loc, type_);

  if (getIsEmpty(param)) {
    Generate_lib.raiseError(
      ~loc=param.ppat_loc,
      ~description=
        "A dynamic component without props doesn't make much sense. Try to translate into static.",
      ~example=None,
      ~link="https://styled-ppx.vercel.app/usage/dynamic-components",
    );
  };

  if (getNotLabelled(label)) {
    Generate_lib.raiseError(
      ~loc=param.ppat_loc,
      ~description="Dynamic components are defined with labeled arguments.",
      ~example=Some("[%styled.div (~a, ~b) => {}]"),
      ~link=
        "https://reasonml.org/docs/manual/latest/function#labeled-arguments",
    );
  };

  getArgs(expr, [firstArg]);
};

let styleVariableName = "styles";

let getLastSequence = expr => {
  let rec inner = expr =>
    switch (expr.pexp_desc) {
    | Pexp_sequence(_, sequence) => inner(sequence)
    | _ => expr
    };

  inner(expr);
};

let getLastExpression = expr => {
  let rec inner = expr =>
    switch (expr.pexp_desc) {
    | Pexp_let(_, _, expression) => inner(expression)
    | _ => expr
    };

  inner(expr);
};

let styledDynamic =
    (~loc, ~htmlTag, ~label, ~moduleName, ~defaultValue, ~param, ~body) => {
  let (functionExpr, labeledArguments) =
    getLabeledArgs(label, defaultValue, param, body);

  let variableList =
    labeledArguments
    |> List.map(((arg, defaultExpr, _, _, loc, type_)) => {
         let (kind, type_) =
           switch (type_) {
           | Some(type_) => (`Typed, type_)
           | None => (`Open, typeVariable(~loc, getLabel(arg)))
           };

         (arg, defaultExpr, kind, type_);
       });

  /* ('a, 'b) */
  let propsGenericParams: list(core_type) =
    variableList
    |> List.filter_map(
         fun
         | (_, _, `Open, type_) => Some(type_)
         | _ => None,
       );

  /* type makeProps('a) = { a: 'a } */
  let propGenericFields =
    variableList
    |> List.map(((arg, defaultValue, _, type_)) =>
         customPropLabel(
           ~loc,
           ~optional=Option.is_some(defaultValue),
           getLabel(arg),
           type_,
         )
       );

  /* (~arg1=props.arg1, ~arg2=props.arg2, ...) */
  let styledArguments =
    List.map(
      ((argumentName, _defaultValue, _, _, loc, _)) => {
        let value = Generate_lib.propItem(~loc, getLabel(argumentName));
        (argumentName, value);
      },
      labeledArguments,
    );

  let unit = (
    Nolabel,
    Builder.pexp_construct(~loc, {txt: Lident("()"), loc}, None),
  );

  /* let styles = styles(...) */
  let stylesFunctionCall =
    Builder.pexp_apply(
      ~loc,
      Builder.pexp_ident(~loc, {txt: Lident(styleVariableName), loc}),
      /* Last argument is a unit to avoid the warning of optinal labeled args */
      styledArguments @ [unit],
    );

  let styles =
    switch (functionExpr.pexp_desc) {
    /* styled.div () => "string" */
    | Pexp_constant(Pconst_string(str, loc, _label)) =>
      Payload.parse(str, loc)
      |> Css_to_emotion.render_declarations
      |> Css_to_emotion.addLabel(~loc, moduleName)
      |> Builder.pexp_array(~loc)
      |> Css_to_emotion.render_style_call

    /* styled.div () => "[||]" */
    | Pexp_array(arr) =>
      arr
      |> List.rev
      |> Css_to_emotion.addLabel(~loc, moduleName)
      |> Builder.pexp_array(~loc)
      |> Css_to_emotion.render_style_call

    /* styled.div () => {
         ...
         ...
         ...
       } */
    | Pexp_sequence(expr, sequence) =>
      /* Generate a new sequence where the last expression is
         wrapped in render_style_call and render the other expressions. */
      let styles =
        sequence |> getLastSequence |> Css_to_emotion.render_style_call;
      Builder.pexp_sequence(~loc, expr, styles);

    /* styled.div () => {
         let styles = sharedStyles
         styles
       } */
    | Pexp_let(Nonrecursive, value_binding, expression) =>
      /* Generate a new `let in` where the last expression is
         wrapped in render_style_call */
      let styles =
        expression |> getLastExpression |> Css_to_emotion.render_style_call;
      Builder.pexp_let(~loc, Nonrecursive, value_binding, styles);

    /* styled.div () => { styles } */
    | Pexp_ident(ident) =>
      Builder.pexp_ident(~loc, ident) |> Css_to_emotion.render_style_call
    /* TODO: With this default case we support all expressions here.
       Users might find this confusing, we could give some warnings before the type-checker does. */
    | _ => functionExpr
    };

  Builder.pmod_structure(
    ~loc,
    [
      makeProps(~loc, Some((propsGenericParams, propGenericFields))),
      bindingCreateVariadicElement(~loc),
      defineDeletePropFn(~loc),
      defineAssign2(~loc),
      defineGetOrEmptyFn(~loc),
      dynamicStyles(
        ~loc,
        ~name=styleVariableName,
        ~args=labeledArguments,
        ~expr=styles,
      ),
      component(
        ~loc,
        ~htmlTag,
        ~styledExpr=stylesFunctionCall,
        ~makePropTypes=propsGenericParams,
        ~labeledArguments,
      ),
    ],
  );
};

let styledComponent = (~loc, ~htmlTag, styles) => {
  let styleReference =
    Builder.pexp_ident(~loc, {txt: Lident(styleVariableName), loc});

  Builder.pmod_structure(
    ~loc,
    [
      makeProps(~loc, None),
      bindingCreateVariadicElement(~loc),
      defineDeletePropFn(~loc),
      defineAssign2(~loc),
      defineGetOrEmptyFn(~loc),
      Generate_lib.styles(~loc, ~name=styleVariableName, ~expr=styles),
      component(
        ~loc,
        ~htmlTag,
        ~styledExpr=styleReference,
        ~makePropTypes=[],
        ~labeledArguments=[],
      ),
    ],
  );
};
