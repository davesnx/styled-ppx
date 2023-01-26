open Ppxlib;

module Builder = Ast_builder.Default;
module Helper = Ast_helper;
module Config = Ppx_config;

let raiseError = (~loc, ~description, ~example, ~link) => {
  let error =
    switch (example) {
    | Some(e) =>
      Location.raise_errorf(
        ~loc,
        "%s\n\n%s\n\nMore info: %s",
        description,
        e,
        link,
      )
    | None =>
      Location.raise_errorf(~loc, "%s\n\nMore info: %s", description, link)
    };

  raise(error);
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
    raiseError(
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
    raiseError(
      ~loc=param.ppat_loc,
      ~description=
        "A dynamic component without props doesn't make much sense. Try to translate into static.",
      ~example=None,
      ~link="https://styled-ppx.vercel.app/usage/dynamic-components",
    );
  };

  if (getNotLabelled(label)) {
    raiseError(
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

let parsePayloadStyle = (payload, loc) => {
  let loc_start = loc.loc_start;
  /* TODO: Bring back "delimiter location conditional logic" */
  /* let loc_start =
     switch (delim) {
     | None => payload.loc.loc_start
     | Some(s) => {
         ...payload.loc.loc_start,
         Lexing.pos_cnum:
           payload.loc.loc_start.Lexing.pos_cnum + String.length(s) + 1,
       }
     }; */

  Css_lexer.parse_declaration_list(
    ~container_lnum=loc_start.pos_lnum,
    ~pos=loc_start,
    payload,
  );
};

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

let renderStyledDynamic =
    (~loc, ~htmlTag, ~label, ~moduleName, ~defaultValue, ~param, ~body) => {
  let (functionExpr, labeledArguments) =
    getLabeledArgs(label, defaultValue, param, body);

  let variableList =
    labeledArguments
    |> List.map(((arg, optionalArg, _, _, loc, type_)) => {
         let label = getLabel(arg);
         let (kind, type_) =
           switch (type_) {
           | Some(type_) => (`Typed, type_)
           | None => (`Open, Create.typeVariable(~loc, label))
           };

         (arg, Option.is_some(optionalArg), kind, type_);
       });

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

  let propsExpr = Builder.pexp_ident(~loc, {txt: Lident("props"), loc});
  let propToGetter = str => str ++ "Get";

  /* (~arg1=arg1Get(props), ~arg2=arg2Get(props), ...) */
  let styledArguments =
    List.map(
      ((arg, _, _, _, _, _)) => {
        let label = arg |> getLabel |> propToGetter;
        let value = Builder.pexp_ident(~loc, {txt: Lident(label), loc});
        (arg, Builder.pexp_apply(~loc, value, [(Nolabel, propsExpr)]));
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
      parsePayloadStyle(str, loc)
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
      Create.makeMakeProps(
        ~loc,
        ~customProps=Some((makePropsParameters, variableMakeProps)),
      ),
      Create.bindingCreateVariadicElement(~loc),
      Create.defineDeletePropFn(~loc),
      Create.defineAssign2(~loc),
      Create.defineGetOrEmptyFn(~loc),
      Create.dynamicStyles(
        ~loc,
        ~name=styleVariableName,
        ~args=labeledArguments,
        ~expr=styles,
      ),
      Create.component(
        ~loc,
        ~htmlTag,
        ~styledExpr=stylesFunctionCall,
        ~makePropTypes=makePropsParameters,
        ~labeledArguments,
      ),
    ],
  );
};

let renderStyledComponent = (~loc, ~htmlTag, styles) => {
  let styleReference =
    Builder.pexp_ident(~loc, {txt: Lident(styleVariableName), loc});

  Builder.pmod_structure(
    ~loc,
    [
      Create.makeMakeProps(~loc, ~customProps=None),
      Create.bindingCreateVariadicElement(~loc),
      Create.defineDeletePropFn(~loc),
      Create.defineAssign2(~loc),
      Create.defineGetOrEmptyFn(~loc),
      Create.styles(~loc, ~name=styleVariableName, ~expr=styles),
      Create.component(
        ~loc,
        ~htmlTag,
        ~styledExpr=styleReference,
        ~makePropTypes=[],
        ~labeledArguments=[],
      ),
    ],
  );
};

let string_payload =
  Ast_pattern.(
    pstr(pstr_eval(pexp_constant(pconst_string(__', __, __)), nil) ^:: nil)
  );

let any_payload = Ast_pattern.(single_expr_payload(__));

/* TODO: Throw better errors when this pattern doesn't match */
let static_pattern =
  Ast_pattern.(
    pstr(
      pstr_eval(
        map(
          ~f=(catch, payload, _, delim) => catch(`String((payload, delim))),
          pexp_constant(pconst_string(__', __, __)),
        )
        ||| map(
              ~f=(catch, payload) => catch(`Array(payload)),
              pexp_array(__),
            ),
        nil,
      )
      ^:: nil,
    )
  );

module Mapper = {
  let match = module_expr => {
    open Ast_pattern;

    let pattern =
      pmod_extension(
        extension(
          __',
          pstr(
            pstr_eval(
              map(
                ~f=
                  (catch, payload, _, delim) =>
                    catch(`String((payload, delim))),
                pexp_constant(pconst_string(__', __, __)),
              )
              ||| map(
                    ~f=(catch, payload) => catch(`Array(payload)),
                    pexp_array(__),
                  )
              ||| map(
                    ~f=
                      (catch, lbl, def, param, body) =>
                        catch(`Function((lbl, def, param, body))),
                    pexp_fun(__, __, __, __),
                  ),
              nil,
            )
            ^:: nil,
          ),
        ),
      );

    parse(
      pattern,
      module_expr.pmod_loc,
      /* TODO: Render a proper error here */
      ~on_error=_ => None,
      module_expr,
      (key, payload) => Some((key, payload)),
    );
  };

  let getHtmlTag = str => {
    switch (String.split_on_char('.', str)) {
    | ["styled", tag] => Some(tag)
    | _ => None
    };
  };

  let getHtmlTagUnsafe = (~loc, str) => {
    switch (String.split_on_char('.', str)) {
    | ["styled", tag] => tag
    | _ =>
      raiseError(
        ~loc,
        ~description=
          "This styled component is not valid. Doesn't have the right format.",
        ~example=Some("[%styled.div ..."),
        ~link=
          "https://reasonml.org/docs/manual/latest/function#labeled-arguments",
      )
    };
  };

  let isStyled = name => {
    name |> getHtmlTag |> Option.is_some;
  };

  let transform = expr => {
    switch (expr.pstr_desc) {
    /* module name = [%styled.div {||}] */
    | Pstr_module({
        pmb_name: {loc: _, txt: Some(moduleName)} as name,
        pmb_attributes: _pmb_attributes,
        pmb_loc: moduleLoc,
        pmb_expr: {
          pmod_desc:
            Pmod_extension((
              {txt: extensionName, loc: extensionLoc},
              PStr([
                {
                  pstr_desc:
                    Pstr_eval(
                      {
                        pexp_loc: stringLoc,
                        pexp_desc:
                          Pexp_constant(Pconst_string(str, _loc, _label)),
                        _,
                      },
                      _attributes,
                    ),
                  pstr_loc: _,
                },
              ]),
            )),
          _,
        },
      })
        when isStyled(extensionName) =>
      let htmlTag = getHtmlTagUnsafe(~loc=extensionLoc, extensionName);
      let styles =
        parsePayloadStyle(str, stringLoc)
        |> Css_to_emotion.render_declarations
        |> Css_to_emotion.addLabel(~loc=stringLoc, moduleName)
        |> Builder.pexp_array(~loc=stringLoc)
        |> Css_to_emotion.render_style_call;

      Builder.pstr_module(
        ~loc=moduleLoc,
        Builder.module_binding(
          ~loc=moduleLoc,
          ~name,
          ~expr=renderStyledComponent(~loc=stringLoc, ~htmlTag, styles),
        ),
      );
    /* [%styled.div [||]] */
    | Pstr_module({
        pmb_name: {loc: _, txt: Some(moduleName)} as name,
        pmb_attributes: _pmb_attributes,
        pmb_loc: moduleLoc,
        pmb_expr: {
          pmod_desc:
            Pmod_extension((
              {txt: extensionName, loc: extensionLoc},
              PStr([
                {
                  pstr_desc:
                    Pstr_eval(
                      {pexp_loc: arrayLoc, pexp_desc: Pexp_array(arr), _},
                      _,
                    ),
                  pstr_loc: _,
                },
              ]),
            )),
          _,
        },
      })
        when isStyled(extensionName) =>
      let htmlTag = getHtmlTagUnsafe(~loc=extensionLoc, extensionName);
      let styles =
        arr
        |> Css_to_emotion.addLabel(~loc=arrayLoc, moduleName)
        |> Builder.pexp_array(~loc=arrayLoc)
        |> Css_to_emotion.render_style_call;

      Builder.pstr_module(
        ~loc=moduleLoc,
        Builder.module_binding(
          ~loc=moduleLoc,
          ~name,
          ~expr=renderStyledComponent(~loc=arrayLoc, ~htmlTag, styles),
        ),
      );
    /* [%styled.div () => {}] */
    | Pstr_module({
        pmb_name: {loc: _, txt: Some(moduleName)} as name,
        pmb_attributes: _pmb_attributes,
        pmb_loc: moduleLoc,
        pmb_expr: {
          pmod_desc:
            Pmod_extension((
              {txt: extensionName, loc: extensionLoc},
              PStr([
                {
                  pstr_desc:
                    Pstr_eval(
                      {
                        pexp_loc: functionLoc,
                        pexp_desc:
                          Pexp_fun(fnLabel, defaultValue, param, expression),
                        _,
                      },
                      _,
                    ),
                  pstr_loc: _,
                },
              ]),
            )),
          _,
        },
      })
        when isStyled(extensionName) =>
      let htmlTag = getHtmlTagUnsafe(~loc=extensionLoc, extensionName);

      Builder.pstr_module(
        ~loc=moduleLoc,
        Builder.module_binding(
          ~loc=moduleLoc,
          ~name,
          ~expr=
            renderStyledDynamic(
              ~loc=functionLoc,
              ~htmlTag,
              ~label=fnLabel,
              ~moduleName,
              ~defaultValue,
              ~param,
              ~body=expression,
            ),
        ),
      );
    /* [%cx ""] */
    | Pstr_value(
        Nonrecursive,
        [
          {
            pvb_pat:
              {ppat_desc: Ppat_var({loc: patternLoc, txt: valueName}), _} as pat,
            pvb_expr: {
              pexp_desc:
                Pexp_extension((
                  {txt: "cx", _},
                  PStr([
                    {
                      pstr_desc:
                        Pstr_eval(
                          {
                            pexp_loc: payloadLoc,
                            pexp_desc:
                              Pexp_constant(Pconst_string(styles, _, _)),
                            _,
                          },
                          _,
                        ),
                      _,
                    },
                  ]),
                )),
              _,
            },
            pvb_loc: loc,
            _,
          },
        ],
      ) =>
      let expr =
        parsePayloadStyle(styles, loc)
        |> Css_to_emotion.render_declarations
        |> Css_to_emotion.addLabel(~loc, valueName)
        |> Builder.pexp_array(~loc=payloadLoc)
        |> Css_to_emotion.render_style_call;

      Builder.pstr_value(
        ~loc,
        Nonrecursive,
        [Builder.value_binding(~loc=patternLoc, ~pat, ~expr)],
      );
    /* [%cx [||]] */
    | Pstr_value(
        Nonrecursive,
        [
          {
            pvb_pat:
              {ppat_desc: Ppat_var({loc: patternLoc, txt: valueName}), _} as pat,
            pvb_expr: {
              pexp_desc:
                Pexp_extension((
                  {txt: "cx", _},
                  PStr([
                    {
                      pstr_desc:
                        Pstr_eval(
                          {
                            pexp_loc: payloadLoc,
                            pexp_desc: Pexp_array(arr),
                            _,
                          },
                          _,
                        ),
                      _,
                    },
                  ]),
                )),
              _,
            },
            pvb_loc: loc,
            _,
          },
        ],
      ) =>
      let expr =
        arr
        |> Css_to_emotion.addLabel(~loc=payloadLoc, valueName)
        |> Builder.pexp_array(~loc=payloadLoc)
        |> Css_to_emotion.render_style_call;

      Builder.pstr_value(
        ~loc,
        Nonrecursive,
        [Builder.value_binding(~loc=patternLoc, ~pat, ~expr)],
      );
    | _ => expr
    };
  };
};

let traverser = {
  as _;
  inherit class Ast_traverse.map as super;
  pub! structure_item = expr => {
    let expr = super#structure_item(expr);
    Mapper.transform(expr);
  }
};

Config.setDefault();

Driver.add_arg(
  "compat-with-bs-emotion-ppx",
  Arg.Bool(Config.updateCompatibleModeWithBsEmotionPpx),
  ~doc=
    "Changes the extension name from css to css_ to avoid breakage with bs-emotion-ppx",
);

  /*
  let delimLength =
    match delim with Some s -> 2 + String.length s | None -> 1
  in
  */

  /*
  let add_loc delimLength base span =
  let _, _, col = Ocaml_common.Location.get_pos_info base.loc_start in
  let pos_bol_start =
    base.loc_start.pos_bol + col + delimLength + (fst span).index
    - (fst span).col
  in
  let pos_bol_end =
    base.loc_start.pos_bol + col + delimLength + (snd span).index
    - (snd span).col
  in
  let start = pos_bol_start + (fst span).col in
  let end_ = pos_bol_end + (snd span).col in
  {
    loc_start =
      {
        pos_fname = base.loc_start.pos_fname;
        pos_lnum = base.loc_start.pos_lnum + (fst span).line;
        pos_bol = pos_bol_start;
        pos_cnum = start;
      };
    loc_end =
      {
        pos_fname = base.loc_start.pos_fname;
        pos_lnum = base.loc_start.pos_lnum + (snd span).line;
        pos_bol = pos_bol_end;
        pos_cnum = end_;
      };
    loc_ghost = false;
  }
   */

Driver.register_transformation(
  ~impl=traverser#structure,
  /* Instrument is needed to run styled-ppx after metaquote,
     we rely on this order in native tests */
  ~instrument=Driver.Instrument.make(~position=Before, traverser#structure),
  ~rules=[
    /* %cx without let binding */
    /* which doesn't have CssJs.label */
    Context_free.Rule.extension(
      Extension.declare(
        "cx",
        Extension.Context.Expression,
        static_pattern,
        (~loc, ~path as _, payload) => {
        switch (payload) {
        | `String({loc, txt}, _delim) =>
          parsePayloadStyle(txt, loc)
          |> Css_to_emotion.render_declarations
          |> Builder.pexp_array(~loc)
          |> Css_to_emotion.render_style_call
        | `Array(arr) =>
          arr |> Builder.pexp_array(~loc) |> Css_to_emotion.render_style_call
        }
      }),
    ),
    Context_free.Rule.extension(
      Extension.declare(
        Config.compatibleModeWithBsEmotionPpx() ? "css_" : "css",
        Extension.Context.Expression,
        string_payload,
        (~loc as _, ~path as _, payload, _label, _) => {
          let pos = payload.loc.loc_start;
          let container_lnum = pos.pos_lnum;
          let declarationListValues =
            Css_lexer.parse_declaration(
              ~container_lnum,
              ~pos,
              payload.txt,
            )
            |> Css_to_emotion.render_declaration;
          /* TODO: Instead of getting the first element,
              fail when there's more than one declaration or
             make a mechanism to flatten all the properties */
          List.nth(declarationListValues, 0);
        },
      ),
    ),
    Context_free.Rule.extension(
      Extension.declare(
        "styled.global",
        Extension.Context.Expression,
        string_payload,
        (~loc as _, ~path as _, payload, _label, _) => {
          let pos = payload.loc.loc_start;
          let container_lnum = pos.pos_lnum;
          let stylesheet =
            Css_lexer.parse_stylesheet(
              ~container_lnum,
              ~pos,
              payload.txt,
            );
          Css_to_emotion.render_global(stylesheet);
        },
      ),
    ),
    Context_free.Rule.extension(
      Extension.declare(
        "keyframe",
        Extension.Context.Expression,
        string_payload,
        (~loc as _, ~path as _, payload, _label, _) => {
          let pos = payload.loc.loc_start;
          let container_lnum = pos.pos_lnum;
          let declarations =
            Css_lexer.parse_keyframes(
              ~container_lnum,
              ~pos,
              payload.txt,
            );
          Css_to_emotion.render_keyframes(declarations);
        },
      ),
    ),
    /* This extension just raises an error to educate, since before 0.20 this was valid */
    Context_free.Rule.extension(
      Extension.declare(
        "styled",
        Extension.Context.Module_expr,
        any_payload,
        (~loc, ~path as _, payload) => {
        raiseError(
          ~loc,
          ~description=
            "An styled component without a tag is not valid. You must define an HTML tag, like, `styled.div`",
          ~example=
            Some(
              "[%styled.div "
              ++ Pprintast.string_of_expression(payload)
              ++ "]",
            ),
          ~link=
            "https://developer.mozilla.org/en-US/docs/Learn/Accessibility/HTML",
        )
      }),
    ),
  ],
  "styled-ppx",
);
