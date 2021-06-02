open Ppxlib;

module Build = Ast_builder.Default;
module Helper = Ast_helper;

let raiseError = (~loc, ~description, ~example, ~link) => {
  raise(
    Location.raise_errorf(
      ~loc,
      "%s\n\n  %s\n\n  More info: %s", description, example, link
    )
  );
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
    raiseError(
      ~loc=pattern.ppat_loc,
      ~description="Dynamic components are defined with labeled arguments.",
      ~example="[%styled.div (~a, ~b) => {}]",
      ~link="https://reasonml.org/docs/manual/latest/function#labeled-arguments",
    );
  | _ => (expr, list)
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
let renderStringPayload = (
  ~loc as _: location,
  ~path as _: label,
  kind,
  {txt: string, loc},
  _delim,
_): Parsetree.expression => {
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
    Css_to_emotion.render_style_call(
      Css_to_emotion.render_declaration_list(ast)
    );
  | `Rule =>
    let parser = makeParser(Css_parser.declaration);
    let ast = parser(string);
    let declarationListValues = Css_to_emotion.render_declaration(ast, ast.loc);
    /* TODO: Instead of getting the first element, fail when there's more than one declaration or make a mechanism to flatten all the properties */
    List.nth(declarationListValues, 0);
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

let getLastSequence = (expr) => {
  let rec inner = (expr) =>
    switch (expr.pexp_desc) {
      | Pexp_sequence(_, sequence) => inner(sequence)
      | _ => expr
  };

  inner(expr);
};

let renderStyledDynamic = (
  ~loc,
  ~path,
  ~htmlTag,
  ~label,
  ~defaultValue,
  ~param,
  ~body
) => {
  let (functionExpr, labeledArguments) =
    getLabeledArgs(label, defaultValue, param, body);

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
    | Pexp_constant(Pconst_string(str, delim, label)) =>
      renderStringPayload(
        ~loc,
        ~path,
        `Declarations,
        {txt: str, loc: functionExpr.pexp_loc},
        delim,
        label
      ) |> Css_to_emotion.render_style_call
    | Pexp_array(arr) => Build.pexp_array(~loc, List.rev(arr)) |> Css_to_emotion.render_style_call
    | Pexp_sequence(expr, sequence) => {
      /* Generate a new sequence where the last expression is
        wrapped in render_style_call and render the other expressions. */
      let styles = sequence |> getLastSequence |> Css_to_emotion.render_style_call;
      Build.pexp_sequence(~loc, expr, styles);
    }
    /* TODO: With this default case we support all expressions here.
    Users might find this confusing, we could give some warnings before the type-checker does. */
    | _ => functionExpr
  };

  Build.pmod_structure(~loc, [
    Create.makeMakeProps(
      ~loc,
      ~customProps=Some((makePropsParameters, variableMakeProps))
    ),
    Create.bindingCreateVariadicElement(~loc),
    Create.dynamicStyles(
      ~loc,
      ~name=styleVariableName,
      ~args=labeledArguments,
      ~expr=styles,
    ),
    Create.component(
      ~loc,
      ~htmlTag,
      ~styledExpr=styledFunctionExpr,
      ~params=makePropsParameters,
    ),
  ]);
};

let renderStyledStaticString = (~loc, ~path, ~htmlTag, ~str, ~delim, ~label) => {
  let styledExpr =
    Build.pexp_ident(~loc, {txt: Lident(styleVariableName), loc});
  let cssExpr = renderStringPayload(~loc, ~path, `Style, str, Some(delim), label);

  Build.pmod_structure(~loc, [
    Create.makeMakeProps(~loc, ~customProps=None),
    Create.bindingCreateVariadicElement(~loc),
    Create.styles(~loc, ~name=styleVariableName, ~expr=cssExpr),
    Create.component(~loc, ~htmlTag, ~styledExpr, ~params=[])
  ]);
};

let renderStyledStaticList = (~loc, ~path as _, ~htmlTag, list) => {
  let styledExpr =
    Build.pexp_ident(~loc, {txt: Lident(styleVariableName), loc});
  let cssExpr = Css_to_emotion.render_style_call(
    Build.pexp_array(~loc, List.rev(list))
  );

  Build.pmod_structure(~loc, [
    Create.makeMakeProps(~loc, ~customProps=None),
    Create.bindingCreateVariadicElement(~loc),
    Create.styles(~loc,
      ~name=styleVariableName,
      ~expr=cssExpr
    ),
    Create.component(~loc, ~htmlTag, ~styledExpr, ~params=[])
  ]);
};

let string_payload =
  Ast_pattern.(
    pstr(
      pstr_eval(
        pexp_constant(pconst_string(__', __, __)),
        nil
      ) ^:: nil,
    ),
);

let any_payload =
  Ast_pattern.(
    pstr(
      pstr_eval(
        __,
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
              f(`Function((lbl, def, param, body))),
          pexp_fun(__, __, __, __),
        )
        ||| map(
              ~f=(f, payload, delim, m) => f(`String((payload, delim, m))),
              pexp_constant(pconst_string(__', __, __)),
            )
        ||| map(
              ~f=(f, payload) => f(`Array((payload))),
              pexp_array(__),
            )
        ,
        nil,
      )
      ^:: nil
    )
  );



let extensions = [
  Ppxlib.Extension.declare(
    "cx",
    Ppxlib.Extension.Context.Expression,
    string_payload,
    renderStringPayload(`Style)
  ),
  Ppxlib.Extension.declare(
    "css",
    Ppxlib.Extension.Context.Expression,
    string_payload,
    renderStringPayload(`Rule)
  ),
  Ppxlib.Extension.declare(
    "styled.global",
    Ppxlib.Extension.Context.Expression,
    string_payload,
    renderStringPayload(`Global)
  ),
  Ppxlib.Extension.declare(
    "styled.keyframe",
    Ppxlib.Extension.Context.Expression,
    string_payload,
    renderStringPayload(`Keyframe)
  ),
  /* This extension just raises an error to educate users in case of wrong payload or missing html tag. */
  Ppxlib.Extension.declare(
    "styled",
    Ppxlib.Extension.Context.Module_expr,
    any_payload,
    (~loc, ~path as _, payload) => {
      raiseError(~loc,
        ~description="An styled component without a tag is not valid. You must define an HTML tag, like, `styled.div`",
        ~example="[%styled.div " ++ Pprintast.string_of_expression(payload) ++ "]",
        ~link="https://developer.mozilla.org/en-US/docs/Learn/Accessibility/HTML"
      )
    }
  ),
  /* Currently there's no way to define extensions like `lola.x` with Pplib.Extension, we generate one ppxlib.extension per html tag. Is possible to achive it with Ppxlib.Driver.register_transformation(~preprocess_impl). */
  ...List.map(htmlTag => {
    Ppxlib.Extension.declare(
      "styled." ++ htmlTag,
      Ppxlib.Extension.Context.Module_expr,
      pattern,
      (~loc, ~path, payload) => {
        switch (payload) {
        | `String((str, delim, label)) =>
          renderStyledStaticString(~loc, ~path, ~htmlTag, ~str, ~delim, ~label)
        | `Array(arr) =>
          renderStyledStaticList(~loc, ~path, ~htmlTag, arr)
        | `Function((label, defaultValue, param, body)) =>
          renderStyledDynamic(
            ~loc,
            ~path,
            ~htmlTag,
            ~label,
            ~defaultValue,
            ~param,
            ~body,
          )
        };
      }
    )
  }, Html.allTags),
];

/* Instrument is needed to run metaquote before styled-ppx, we rely on this order for the native tests */
let instrument = Driver.Instrument.make(Fun.id, ~position=Before);

Driver.register_transformation(~extensions, ~instrument, "styled-ppx");
