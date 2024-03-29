open Ppxlib;

module Builder = Generate_lib.Builder;

let styleVariableName = "styles";

let staticComponentServer = (~loc, ~htmlTag, styles) => {
  let styleReference = [%expr styles];

  Builder.pmod_structure(
    ~loc,
    [
      Generate_lib.defineGetOrEmptyFn(~loc),
      Generate_lib.styles(~loc, ~name=styleVariableName, ~expr=styles),
      Generate_lib.component(
        ~loc,
        ~htmlTag,
        ~className=styleReference,
        ~makePropTypes=[],
        ~labeledArguments=[],
      ),
    ],
  );
};

let staticComponentClient = (~loc, ~htmlTag, styles) => {
  let styleReference = [%expr styles];

  Builder.pmod_structure(
    ~loc,
    [
      Generate_lib.makeProps(~loc, None),
      Generate_lib.bindingCreateVariadicElement(~loc),
      Generate_lib.defineGetOrEmptyFn(~loc),
      Generate_lib.defineDeletePropFn(~loc),
      Generate_lib.defineAssign2(~loc),
      Generate_lib.styles(~loc, ~name=styleVariableName, ~expr=styles),
      Generate_lib.component(
        ~loc,
        ~htmlTag,
        ~className=styleReference,
        ~makePropTypes=[],
        ~labeledArguments=[],
      ),
    ],
  );
};

let staticComponent = (~loc, ~htmlTag, styles) => {
  Settings.Get.native()
    ? staticComponentServer(~loc, ~htmlTag, styles)
    : staticComponentClient(~loc, ~htmlTag, styles);
};

let dynamicComponent =
    (~loc, ~htmlTag, ~label, ~moduleName, ~defaultValue, ~param, ~body) => {
  let (functionExpr, labeledArguments) =
    Generate_lib.getLabeledArgs(label, defaultValue, param, body);

  let variableList =
    labeledArguments
    |> List.map(((arg, defaultExpr, _, _, loc, type_)) => {
         let (kind, type_) =
           switch (type_) {
           | Some(type_) => (`Typed, type_)
           | None => (
               `Open,
               Generate_lib.typeVariable(~loc, Generate_lib.getLabel(arg)),
             )
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
         Generate_lib.customPropLabel(
           ~loc,
           ~optional=Option.is_some(defaultValue),
           Generate_lib.getLabel(arg),
           type_,
         )
       );

  /* (~arg1=props.arg1, ~arg2=props.arg2, ...) */
  let styledArguments =
    List.map(
      ((argumentName, _defaultValue, _, _, loc, _)) => {
        let value =
          Generate_lib.propItem(~loc, Generate_lib.getLabel(argumentName));
        (argumentName, value);
      },
      labeledArguments,
    );

  /* let styles = styles(...) */
  let stylesFunctionCall =
    Builder.pexp_apply(
      ~loc,
      Builder.pexp_ident(~loc, {txt: Lident(styleVariableName), loc}),
      /* Last argument is a unit to avoid the warning of optinal labeled args */
      styledArguments @ [(Nolabel, [%expr ()])],
    );

  let styles =
    switch (functionExpr.pexp_desc) {
    /* styled.div () => "string" */
    | Pexp_constant(Pconst_string(str, loc, _label)) =>
      switch (Styled_ppx_css_parser.Driver.parse_declaration_list(~loc, str)) {
      | Ok(declarations) =>
        declarations
        |> Css_to_emotion.render_declarations(~loc)
        |> Css_to_emotion.addLabel(~loc, moduleName)
        |> Builder.pexp_array(~loc)
        |> Css_to_emotion.render_style_call(~loc)
      | Error((loc, msg)) => Generate_lib.error(~loc, msg)
      }

    /* styled.div () => "[||]" */
    | Pexp_array(arr) =>
      arr
      |> List.rev
      |> Css_to_emotion.addLabel(~loc, moduleName)
      |> Builder.pexp_array(~loc)
      |> Css_to_emotion.render_style_call(~loc)

    /* styled.div () => {
         ...
         ...
         ...
       } */
    | Pexp_sequence(expr, sequence) =>
      /* Generate a new sequence where the last expression is
         wrapped in render_style_call and render the other expressions. */
      let styles =
        sequence
        |> Generate_lib.getLastSequence
        |> Css_to_emotion.render_style_call(~loc);
      Builder.pexp_sequence(~loc, expr, styles);

    /* styled.div () => {
         let styles = sharedStyles
         styles
       } */
    | Pexp_let(Nonrecursive, value_binding, expression) =>
      /* Generate a new `let in` where the last expression is
         wrapped in render_style_call */
      let styles =
        expression
        |> Generate_lib.getLastExpression
        |> Css_to_emotion.render_style_call(~loc);
      Builder.pexp_let(~loc, Nonrecursive, value_binding, styles);

    /* styled.div () => { styles } */
    | Pexp_ident(ident) =>
      Builder.pexp_ident(~loc, ident)
      |> Css_to_emotion.render_style_call(~loc)
    /* TODO: With this default case we support all expressions here.
       Users might find this confusing, we could give some warnings before the type-checker does. */
    | _ => functionExpr
    };

  Builder.pmod_structure(
    ~loc,
    [
      Generate_lib.makeProps(
        ~loc,
        Some((propsGenericParams, propGenericFields)),
      ),
      Generate_lib.bindingCreateVariadicElement(~loc),
      Generate_lib.defineDeletePropFn(~loc),
      Generate_lib.defineGetOrEmptyFn(~loc),
      Generate_lib.defineAssign2(~loc),
      Generate_lib.dynamicStyles(
        ~loc,
        ~name=styleVariableName,
        ~args=labeledArguments,
        ~expr=styles,
      ),
      Generate_lib.component(
        ~loc,
        ~htmlTag,
        ~className=stylesFunctionCall,
        ~makePropTypes=propsGenericParams,
        ~labeledArguments,
      ),
    ],
  );
};
