open Ppxlib;

module Builder = Ast_builder.Default;
module Helper = Ast_helper;

let raiseError = (~loc, ~description, ~example, ~link) => {
  raise(
    Location.raise_errorf(
      ~loc,
      "%s\n\n%s\n\nMore info: %s", description, example, link
    )
  );
};

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
  | Ppat_alias(_, {txt, _}) | Ppat_var({txt, _}) => txt
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

  if (getNotLabelled(label)) {
    raiseError(
      ~loc=param.ppat_loc,
      ~description="Dynamic components are defined with labeled arguments.",
      ~example="[%styled.div (~a, ~b) => {}]",
      ~link="https://reasonml.org/docs/manual/latest/function#labeled-arguments",
    );
  }

  getArgs(expr, [firstArg]);
};

let styleVariableName = "styles";

/* TODO: Bring back "delimiter location conditional logic" */
let parsePayloadStyle = (
  ~loc as _: location,
  ~path as _: label,
  payload,
  loc,
) => {
  switch (loc) {
    | Some(d) => print_endline(d) |> ignore
    | None => ()
  };
  let loc_start = payload.loc.Location.loc_start;
  Css_lexer.parse_declaration_list(
    ~container_lnum=loc_start.Lexing.pos_lnum,
    ~pos=loc_start,
    payload.txt
  );
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

  let propExpr = Builder.pexp_ident(~loc, {txt: Lident("props"), loc});
  let propToGetter = str => str ++ "Get";

  /* (~arg1=arg1Get(props), ~arg2=arg2Get(props), ...) */
  let styledFunctionArguments =
    List.map(
      ((arg, _, _, _, _, _)) => {
        let label = arg |> getLabel |> propToGetter;
        let value =
          Builder.pexp_ident(~loc, {txt: Lident(label), loc});
        (arg, Builder.pexp_apply(~loc, value, [(Nolabel, propExpr)]));
      },
      labeledArguments,
    );

  /* let styles = styled(...) */
  let styledFunctionExpr =
    Builder.pexp_apply(
      ~loc,
      Builder.pexp_ident(~loc, {txt: Lident(styleVariableName), loc}),
      styledFunctionArguments,
    );

  let variableList =
    List.map(
      ((arg, optionalArg, _, _, loc, type_)) => {
        let label = getLabel(arg);
        let (kind, type_) =
          switch (type_) {
          | Some(type_) => (`Typed, type_)
          | None => (`Open, Create.typeVariable(~loc, label))
          };

        (arg, Option.is_some(optionalArg), kind, type_);
      },
      labeledArguments,
    );

  /* ('a, 'b) */
  let makePropsParameters: list(core_type) =
    variableList
    |> List.filter_map(
      fun
      | (_, _, `Open, type_) => Some(type_)
      | _ => None,
    );

  /* type makeProps('a) = { a: 'a } */
  let variableMakeProps =
    variableList
    |> List.map(((arg, optional, _, type_)) =>
        Create.customPropLabel(~loc, getLabel(arg), type_, optional)
    );

  let styles = switch (functionExpr.pexp_desc) {
    | Pexp_constant(Pconst_string(str, _, label)) =>
      parsePayloadStyle(
        ~loc=functionExpr.pexp_loc,
        ~path,
        {txt: str, loc: functionExpr.pexp_loc},
        label
      )
        |> Css_to_emotion.render_declarations
        |> Css_to_emotion.addLabel(~loc, "lola")
        |> Builder.pexp_array(~loc)
        |> Css_to_emotion.render_style_call;
    | Pexp_array(arr) =>
        arr
          |> List.rev
          |> Css_to_emotion.addLabel(~loc, "lola")
          |> Builder.pexp_array(~loc)
          |> Css_to_emotion.render_style_call;
    | Pexp_sequence(expr, sequence) => {
      /* Generate a new sequence where the last expression is
        wrapped in render_style_call and render the other expressions. */
      let styles = sequence |> getLastSequence |> Css_to_emotion.render_style_call;
      Builder.pexp_sequence(~loc, expr, styles);
    }
    /* TODO: With this default case we support all expressions here.
    Users might find this confusing, we could give some warnings before the type-checker does. */
    | _ => functionExpr
  };

  Builder.pmod_structure(~loc, [
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

let renderStyledComponent = (~loc, ~htmlTag, styles) => {
  let styledExpr =
    Builder.pexp_ident(~loc, {txt: Lident(styleVariableName), loc});

  Builder.pmod_structure(~loc, [
    Create.makeMakeProps(~loc, ~customProps=None),
    Create.bindingCreateVariadicElement(~loc),
    Create.styles(
      ~loc,
      ~name=styleVariableName,
      ~expr=styles
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

/* TODO: Throw better errors when this pattern doesn't match */
let static_pattern =
  Ast_pattern.(
    pstr(
      pstr_eval(
        map(~f=(f, payload, _, delim) =>
          f(`String((payload, delim))), pexp_constant(pconst_string(__', __, __)))
        ||| map(~f=(f, payload) =>
          f(`Array((payload))), pexp_array(__)), nil)
        ^:: nil
    )
  );

/* TODO: is there any way to throw better errors when this pattern doesn't match? */
let dynamic_pattern =
  Ast_pattern.(
    pstr(
      pstr_eval(
        map(~f=(f, payload, _, delim) =>
          f(`String((payload, delim))), pexp_constant(pconst_string(__', __, __)))
        ||| map(~f=(f, payload) =>
          f(`Array((payload))), pexp_array(__))
        ||| map(~f=(f, lbl, def, param, body) =>
          f(`Function((lbl, def, param, body))), pexp_fun(__, __, __, __)), nil)
        ^:: nil
    )
  );

/* Currently there's no way to define extensions with regex or globs like `lola.*` with Pplib.Extension, we generate one ppxlib.extension per html tag. Is possible to achive it with Ppxlib.Driver.register_transformation(~preprocess_impl). */
let styledDotAnyHtmlTagExtensions =
  Html.allTags |> List.map(htmlTag => {
    Ppxlib.Extension.declare(
      "styled." ++ htmlTag,
      Ppxlib.Extension.Context.Module_expr,
      dynamic_pattern,
      (~loc, ~path, payload) => {
        switch (payload) {
        | `String((str, delim)) =>
          let styles = parsePayloadStyle(~loc, ~path, str, delim)
            |> Css_to_emotion.render_declarations
            |> Css_to_emotion.addLabel(~loc, "lola")
            |> Builder.pexp_array(~loc)
            |> Css_to_emotion.render_style_call;
          renderStyledComponent(~loc, ~htmlTag, styles);
        | `Array(arr) =>
          let styles = arr
            |> Css_to_emotion.addLabel(~loc, "lola")
            |> Builder.pexp_array(~loc)
            |> Css_to_emotion.render_style_call;
          renderStyledComponent(~loc, ~htmlTag, styles);
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
  });

let extensions = [
  Ppxlib.Extension.declare(
    "cx",
    Ppxlib.Extension.Context.Expression,
    static_pattern,
    (~loc, ~path, payload) => {
      switch (payload) {
        | `String((str, delim)) =>
          parsePayloadStyle(~loc, ~path, str, delim)
            |> Css_to_emotion.render_declarations
            |> Builder.pexp_array(~loc)
            |> Css_to_emotion.render_style_call;
        | `Array(arr) => arr |> Builder.pexp_array(~loc) |> Css_to_emotion.render_style_call;
      }
    }
  ),
  Ppxlib.Extension.declare(
    "css",
    Ppxlib.Extension.Context.Expression,
    string_payload,
    (~loc as _, ~path as _, payload, _label, _) => {
      let loc_start = payload.loc.Location.loc_start;
      let declarationListValues = Css_lexer.parse_declaration(
        ~container_lnum=loc_start.Lexing.pos_lnum,
        ~pos=loc_start,
        payload.txt
      ) |> Css_to_emotion.render_declaration;
      /* TODO: Instead of getting the first element,
       fail when there's more than one declaration or
      make a mechanism to flatten all the properties */
      List.nth(declarationListValues, 0);
    }
  ),
  Ppxlib.Extension.declare(
    "styled.global",
    Ppxlib.Extension.Context.Expression,
    string_payload,
    (~loc as _, ~path as _, payload, _label, _) => {
      let loc_start = payload.loc.Location.loc_start;
      let stylesheet = Css_lexer.parse_stylesheet(
        ~container_lnum=loc_start.Lexing.pos_lnum,
        ~pos=loc_start,
        payload.txt
      );
     Css_to_emotion.render_global(stylesheet);
    }
  ),
  Ppxlib.Extension.declare(
    "styled.keyframe",
    Ppxlib.Extension.Context.Expression,
    string_payload,
    (~loc as _, ~path as _, payload, _label, _) => {
      let loc_start = payload.loc.Location.loc_start;
      let stylesheet = Css_lexer.parse_stylesheet(
        ~container_lnum=loc_start.Lexing.pos_lnum,
        ~pos=loc_start,
        payload.txt
      );
     Css_to_emotion.render_keyframes(stylesheet);
    }
  ),
  /* This extension just raises an error to educate users, since before 1.x this was valid */
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
  ...styledDotAnyHtmlTagExtensions,
];

/* Instrument is needed to run metaquote before styled-ppx, we rely on this order for the native tests */
let instrument = Driver.Instrument.make(Fun.id, ~position=Before);

Driver.register_transformation(~extensions, ~instrument, "styled-ppx");
