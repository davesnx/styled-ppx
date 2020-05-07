open Migrate_parsetree;
open Ast_406;
open Ast_mapper;
open Asttypes;
open Parsetree;
open Ast_helper;
open Longident;
open React_props;

let raiseWithLocation = (~loc, msg) => {
  raise(Location.Error(Location.error(~loc, msg)));
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

let optionIdent = Lident("option");

let safeTypeFromValue = valueStr => {
  let valueStr = getLabel(valueStr);
  switch (String.sub(valueStr, 0, 1)) {
  | "_" => "T" ++ valueStr
  | _ => valueStr
  };
};

let getAlias = (pattern, label) =>
  switch (pattern) {
  | {ppat_desc: Ppat_alias(_, {txt, _}) | Ppat_var({txt, _}), _} => txt
  | {ppat_desc: Ppat_any, _} => "_"
  | _ => getLabel(label)
  };

let getTag = str => {
  switch (String.split_on_char('.', str)) {
  | ["styled"] => "div"
  | ["styled", tag] => tag
  | _ => "div"
  };
};

/* (~a, ~b, ~c, etc...) => args */
let rec createFnWithLabeledArgs = (list, args) =>
  switch (list) {
  | [(label, default, pattern, _alias, loc, _interiorType), ...rest] =>
    createFnWithLabeledArgs(
      rest,
      Exp.fun_(~loc, label, default, pattern, args),
    )
  | [] => args
  };

let getType = pattern =>
  switch (pattern) {
  | {ppat_desc: Ppat_constraint(_, type_), _} => Some(type_)
  | _ => None
  };

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
  | innerExpression => (innerExpression, list, None)
  };
};

let styleVariableName = "styles";

/* let styles = Emotion.(css(exp)) */
let createStyles = (~loc, ~name, ~exp) => {
  let variableName = Pat.mk(~loc, Ppat_var({txt: name, loc}));
  Str.mk(~loc, Pstr_value(Nonrecursive, [Vb.mk(~loc, variableName, exp)]));
};

/* let styles = (~arg1, ~arg2) => Emotion.(css(exp)) */
let createDynamicStyles = (~loc, ~name, ~args, ~exp) => {
  let variableName = Pat.mk(~loc, Ppat_var({txt: name, loc}));

  Str.mk(
    ~loc,
    Pstr_value(
      Nonrecursive,
      [Vb.mk(~loc, variableName, createFnWithLabeledArgs(args, exp))],
    ),
  );
};

/*
   [@bs.val] [@bs.module "react"] external createElement:
   (string, Js.t({ .. }), array(React.element)) => React.element =
   "createElement";
 */
let createReactBinding = (~loc) => {
  Str.primitive({
    pval_loc: loc,
    pval_name: {
      txt: "createElement",
      loc,
    },
    pval_type:
      Typ.arrow(
        ~loc,
        Nolabel,
        Typ.constr(~loc, {txt: Lident("string"), loc}, []),
        Typ.arrow(
          ~loc,
          Nolabel,
          Typ.constr(
            ~loc,
            {txt: Ldot(Lident("Js"), "t"), loc},
            [Typ.object_(~loc, [], Open)],
          ),
          Typ.arrow(
            ~loc,
            Nolabel,
            Typ.constr(
              ~loc,
              {txt: Lident("array"), loc},
              [
                Typ.constr(
                  ~loc,
                  {txt: Ldot(Lident("React"), "element"), loc},
                  [],
                ),
              ],
            ),
            Typ.constr(
              ~loc,
              {txt: Ldot(Lident("React"), "element"), loc},
              [],
            ),
          ),
        ),
      ),
    pval_prim: ["createElement"],
    pval_attributes: [
      ({txt: "bs.val", loc}, PStr([])),
      (
        {txt: "bs.module", loc},
        PStr([
          Str.mk(
            ~loc,
            Pstr_eval(
              Exp.constant(
                ~loc,
                ~attrs=[({txt: "reason.raw_literal", loc}, PStr([]))],
                Pconst_string("react", None),
              ),
              [],
            ),
          ),
        ]),
      ),
    ],
  });
};

/* switch (props->childrenGet) {
     | Some(child) => child
     | None => React.null
   } */
let createSwitchChildren = (~loc) => {
  let noneCase =
    Exp.case(
      Pat.mk(~loc, Ppat_construct({txt: Lident("None"), loc}, None)),
      Exp.ident(~loc, {txt: Ldot(Lident("React"), "null"), loc}),
    );

  let someChildCase =
    Exp.case(
      Pat.mk(
        ~loc,
        ~attrs=[({txt: "explicit_arity", loc}, PStr([]))], /* Add [@explicit_arity] */
        Ppat_construct(
          {txt: Lident("Some"), loc},
          Some(
            Pat.mk(
              ~loc,
              Ppat_tuple([Pat.mk(~loc, Ppat_var({txt: "chil", loc}))]),
            ),
          ),
        ),
      ),
      Exp.ident(~loc, {txt: Lident("chil"), loc}),
    );

  let matchingExp =
    Exp.apply(
      ~loc,
      Exp.ident(~loc, {txt: Lident("childrenGet"), loc}),
      [(Nolabel, Exp.ident(~loc, {txt: Lident("props"), loc}))],
    );

  Exp.match(~loc, matchingExp, [someChildCase, noneCase]);
};

/* div(~className=styles, ~children, ()) + createSwitchChildren */
let createElement = (~loc, ~tag) => {
  Exp.apply(
    ~loc,
    Exp.ident(~loc, {txt: Lident("createElement"), loc}),
    [
      (
        Nolabel,
        Exp.constant(
          ~loc,
          ~attrs=[
            (
              {txt: "reason.raw_literal", loc},
              PStr([
                Str.mk(
                  ~loc,
                  Pstr_eval(
                    Exp.constant(~loc, Pconst_string(tag, None)),
                    [],
                  ),
                ),
              ]),
            ),
          ],
          Pconst_string(tag, None),
        ),
      ),
      (Nolabel, Exp.ident(~loc, {txt: Lident("newProps"), loc})),
      (Nolabel, Exp.array(~loc, [createSwitchChildren(~loc)])),
    ],
  );
};

/* let stylesObject = {"className": styled}; */
let createStylesObject = (~loc, ~value) =>
  Vb.mk(
    ~loc,
    Pat.mk(~loc, Ppat_var({txt: "stylesObject", loc})),
    Exp.extension(
      ~loc,
      (
        {txt: "bs.obj", loc},
        PStr([
          Str.mk(
            ~loc,
            Pstr_eval(
              Exp.record(
                ~loc,
                [({txt: Lident("className"), loc}, value)],
                None,
              ),
              [],
            ),
          ),
        ]),
      ),
    ),
  );

/* Obj.magic(props) */
let objMagicProps = (~loc) =>
  Exp.apply(
    ~loc,
    Exp.ident(~loc, {txt: Ldot(Lident("Obj"), "magic"), loc}),
    [(Nolabel, Exp.ident(~loc, {txt: Lident("props"), loc}))],
  );

/* let newProps = Js.Obj.assign(stylesObject, Obj.magic(props)); */
let createNewProps = (~loc) =>
  Vb.mk(
    ~loc,
    Pat.mk(~loc, Ppat_var({txt: "newProps", loc})),
    Exp.apply(
      ~loc,
      Exp.ident(
        ~loc,
        {txt: Ldot(Ldot(Lident("Js"), "Obj"), "assign"), loc},
      ),
      [
        (Nolabel, Exp.ident(~loc, {txt: Lident("stylesObject"), loc})),
        (Nolabel, objMagicProps(~loc)),
      ],
    ),
  );

/*
   setClassName(props, styled);

   React.createElement("a", ~props,
     [|switch (children) {
     | Some(chil) => chil
     | None => React.null
   }|]);
 */
let createMakeBody = (~loc, ~tag, ~styledExpr) =>
  Exp.let_(
    ~loc,
    ~attrs=[({txt: "reason.preserve_braces", loc}, PStr([]))],
    Nonrecursive,
    [createStylesObject(~loc, ~value=styledExpr)],
    Exp.let_(
      ~loc,
      Nonrecursive,
      [createNewProps(~loc)],
      createElement(~loc, ~tag),
    ),
  );

/* props: makeProps */
let createMakeArguments = (~loc) => {
  Pat.constraint_(
    ~loc,
    Pat.mk(~loc, Ppat_var({txt: "props", loc})),
    Typ.constr(~loc, {txt: Lident("makeProps"), loc}, []),
  );
};

/* let make = (props: makeProps) => + createMakeBody */
let createMakeFn = (~loc, ~tag, ~styledExpr) =>
  Exp.fun_(
    ~loc,
    Nolabel,
    None,
    createMakeArguments(~loc),
    createMakeBody(~loc, ~tag, ~styledExpr),
  );

/* [@react.component] + createMakeFn */
let createComponent = (~loc, ~tag, ~styledExpr) =>
  Str.mk(
    ~loc,
    Pstr_value(
      Nonrecursive,
      [
        Vb.mk(
          ~loc,
          Pat.mk(~loc, Ppat_var({txt: "make", loc})),
          createMakeFn(~loc, ~tag, ~styledExpr),
        ),
      ],
    ),
  );

/* [@bs.optional] color: string */
let createCustomPropLabel = (~loc, name, kind) =>
  Type.field(
    ~loc,
    {txt: name, loc},
    Typ.constr(~loc, {txt: Lident(kind), loc}, []),
  );

/* [@bs.optional] ahref: string */
let createRecordLabel = (~loc, name, kind) =>
  Type.field(
    ~loc,
    ~attrs=[({txt: "bs.optional", loc}, PStr([]))],
    {txt: name, loc},
    Typ.constr(~loc, {txt: Lident(kind), loc}, []),
  );

/* [@bs.optional] ref: domRef */
let createDomRefLabel = (~loc) =>
  Type.field(
    ~loc,
    ~attrs=[({txt: "bs.optional", loc}, PStr([]))],
    {txt: "ref", loc},
    Typ.constr(~loc, {txt: Ldot(Lident("ReactDOMRe"), "domRef"), loc}, []),
  );

/* [@bs.optional] children: React.element */
let createChildrenLabel = (~loc) =>
  Type.field(
    ~loc,
    ~attrs=[({txt: "bs.optional", loc}, PStr([]))],
    {txt: "children", loc},
    Typ.constr(~loc, {txt: Ldot(Lident("React"), "element"), loc}, []),
  );

/* [@bs.optional] onDragOver: ReactEvent.Mouse.t => unit */
let createRecordEventLabel = (~loc, name, kind) => {
  Type.field(
    ~loc,
    ~attrs=[({txt: "bs.optional", loc}, PStr([]))],
    {txt: name, loc},
    Typ.arrow(
      ~loc,
      Nolabel,
      Typ.constr(
        ~loc,
        {txt: Ldot(Ldot(Lident("ReactEvent"), kind), "t"), loc},
        [],
      ),
      Typ.constr(~loc, {txt: Lident("unit"), loc}, []),
    ),
  );
};

let createMakeProps = (~loc, extraProps) => {
  /* [@bs.deriving abstract] */
  let bsDerivingAbstract = (
    {txt: "bs.deriving", loc},
    PStr([
      Str.mk(
        ~loc,
        Pstr_eval(Exp.ident(~loc, {txt: Lident("abstract"), loc}), []),
      ),
    ]),
  );

  let dynamicProps =
    switch (extraProps) {
    | None => []
    | Some(props) => props
    };
  /*
     List of
         prop: type
         [@bs.optional]

     ref: domRef
     [@bs.optional]
   */
  let reactProps =
    List.append(
      [
        createDomRefLabel(~loc),
        createChildrenLabel(~loc),
        ...List.map(
             ({name, type_, isEvent}) =>
               isEvent
                 ? createRecordEventLabel(~loc, name, type_)
                 : createRecordLabel(~loc, name, type_),
             domPropsList,
           ),
      ],
      dynamicProps,
    );

  Str.mk(
    ~loc,
    Pstr_type(
      Recursive,
      [
        Type.mk(
          ~loc,
          ~priv=Public,
          ~attrs=[bsDerivingAbstract],
          ~kind=Ptype_record(reactProps),
          {txt: "makeProps", loc},
        ),
      ],
    ),
  );
};

let styledPpxMapper = (_, _) => {
  ...default_mapper,
  /*
     This is what defines where the ppx should be hooked into, in this case
     we transform expr ("expressions").
   */
  expr: (mapper, expr) => {
    switch (expr) {
    | {
        pexp_desc:
          Pexp_extension((
            {txt: "css", _},
            PStr([
              {
                pstr_desc:
                  Pstr_eval(
                    {
                      pexp_loc: loc,
                      pexp_desc: Pexp_constant(Pconst_string(styles, delim)),
                      _,
                    },
                    _,
                  ),
                _,
              },
            ]),
          )),
        pexp_loc: _,
        pexp_attributes: _,
      } =>
      let loc_start =
        switch (delim) {
        | None => loc.Location.loc_start
        | Some(s) => {
            ...loc.Location.loc_start,
            Lexing.pos_cnum:
              loc.Location.loc_start.Lexing.pos_cnum + String.length(s) + 1,
          }
        };

      let ast =
        Css_lexer.parse_string(
          ~container_lnum=loc_start.Lexing.pos_lnum,
          ~pos=loc_start,
          styles,
          Css_parser.declaration_list,
        );

      Css_to_emotion.render_emotion_css(ast, None);
    | {
        pexp_desc:
          Pexp_extension((
            {txt: "styled.global", _},
            PStr([
              {
                pstr_desc:
                  Pstr_eval(
                    {
                      pexp_loc: loc,
                      pexp_desc: Pexp_constant(Pconst_string(styles, delim)),
                      _,
                    },
                    _,
                  ),
                _,
              },
            ]),
          )),
        pexp_loc: _,
        pexp_attributes: _,
      } =>
      let loc_start =
        switch (delim) {
        | None => loc.Location.loc_start
        | Some(s) => {
            ...loc.Location.loc_start,
            Lexing.pos_cnum:
              loc.Location.loc_start.Lexing.pos_cnum + String.length(s) + 1,
          }
        };

      let ast =
        Css_lexer.parse_string(
          ~container_lnum=loc_start.Lexing.pos_lnum,
          ~pos=loc_start,
          styles,
          Css_parser.stylesheet,
        );

      Css_to_emotion.render_global(ast);
    | _ => default_mapper.expr(mapper, expr)
    };
  },
  /***
    * This is what defines [%styled] as an extension point that hooks into module_expr,
    so all the modules pass into here and we patter-match the ones with [%styled.div () => {||}]
   */
  module_expr: (mapper, expr) =>
    switch (expr) {
    | {
        pmod_desc:
          Pmod_extension((
            {txt, loc: txtLoc},
            PStr([
              {
                pstr_desc:
                  Pstr_eval(
                    {
                      pexp_desc: Pexp_fun(label, args, pattern, expression),
                      _,
                    },
                    _,
                  ),
                _,
              },
            ]),
          )),
        _,
      } =>
      let tag = getTag(txt);

      /* Fix getLabeledArgs, to stop ignoring the first arg */
      let alias = getAlias(pattern, label);
      let type_ = getType(pattern);

      let firstArg =
        (label, args, pattern, alias, pattern.ppat_loc, type_);

      let (functionExpr, argList, _) =
        getLabeledArgs(mapper, expression, [firstArg]);

      if (!List.exists(t => t == tag, Html.tags)) {
        raiseWithLocation(
          ~loc=txtLoc,
          "Unexpected HTML tag in [%styled." ++ tag ++ "]",
        );
      };

      let (str, delim) =
        switch (functionExpr) {
        | Pexp_constant(Pconst_string(str, delim)) => (str, delim)
        | _ => raiseWithLocation(
          ~loc=pattern.ppat_loc, "Unexpected error happened.",
        );
      };

      let loc = expression.pexp_loc;
      let loc_start =
        switch (delim) {
        | None => loc.Location.loc_start
        | Some(s) => {
            ...loc.Location.loc_start,
            Lexing.pos_cnum:
              loc.Location.loc_start.Lexing.pos_cnum + String.length(s) + 1,
          }
        };

      let ast =
        Css_lexer.parse_string(
          ~container_lnum=loc_start.Lexing.pos_lnum,
          ~pos=loc_start,
          str,
          Css_parser.declaration_list,
        );

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
          ((arg, _, _, _, _, type_)) => {
            /* Gets the type of the argument from the fn definition
                 (~width: int, ~height: int) => {}
               */
            let typeName =
              switch (type_) {
              | Some(t) =>
                switch (t) {
                | {
                    ptyp_desc: Ptyp_constr({txt: Lident(t), _}, _),
                    ptyp_loc: _,
                    ptyp_attributes: _,
                  } => t
                | _ => "string"
                }
              | None => "string"
              };
            (getLabel(arg), typeName);
          },
          argList,
        );

      let variableProps =
        Some(
          List.map(
            ((label, typeName)) =>
              createCustomPropLabel(~loc, label, typeName),
            variableList,
          ),
        );

      Mod.mk(
        Pmod_structure([
          createMakeProps(~loc, variableProps),
          createReactBinding(~loc),
          createDynamicStyles(
            ~loc,
            ~name=styleVariableName,
            ~args=argList,
            ~exp=
              Css_to_emotion.render_emotion_css(
                ast,
                Some(variableList),
              ),
          ),
          createComponent(~loc, ~tag, ~styledExpr),
        ]),
      );
    | {
        pmod_desc:
          /* This case is [%styled.div] */
          Pmod_extension((
            {txt, loc: txtLoc},
            PStr([]),
          )),
	pmod_loc: pexp_loc,
        _,
      } =>
      let tag = getTag(txt);

      if (!List.exists(t => t == tag, Html.tags)) {
        raiseWithLocation(
          ~loc=txtLoc,
          "Unexpected HTML tag in [%styled." ++ tag ++ "]",
        );
      };

      let loc = pexp_loc;
      let loc_start = loc.Location.loc_start;

      let ast =
        Css_lexer.parse_string(
          ~container_lnum=loc_start.Lexing.pos_lnum,
          ~pos=loc_start,
          "",
          Css_parser.declaration_list,
        );

      let styledExpr =
        Exp.ident(~loc, {txt: Lident(styleVariableName), loc});

      Mod.mk(
        Pmod_structure([
          createMakeProps(~loc, None),
          createReactBinding(~loc),
          createStyles(
            ~loc,
            ~name=styleVariableName,
            ~exp=Css_to_emotion.render_emotion_css(ast, None),
          ),
          createComponent(~loc, ~tag, ~styledExpr),
        ]),
      );
    | {
        pmod_desc:
          /* This case is [%styled.div {||}] */
          Pmod_extension((
            {txt, loc: txtLoc},
            PStr([
              {
                pstr_desc:
                  Pstr_eval(
                    {
                      pexp_desc: Pexp_constant(Pconst_string(str, delim)),
                      pexp_loc,
                      _,
                    },
                    _,
                  ),
                _,
              },
            ]),
          )),
        _,
      } =>
      let tag = getTag(txt);

      if (!List.exists(t => t == tag, Html.tags)) {
        raiseWithLocation(
          ~loc=txtLoc,
          "Unexpected HTML tag in [%styled." ++ tag ++ "]",
        );
      };

      let loc = pexp_loc;
      let loc_start =
        switch (delim) {
        | None => loc.Location.loc_start
        | Some(s) => {
            ...loc.Location.loc_start,
            Lexing.pos_cnum:
              loc.Location.loc_start.Lexing.pos_cnum + String.length(s) + 1,
          }
        };

      let ast =
        Css_lexer.parse_string(
          ~container_lnum=loc_start.Lexing.pos_lnum,
          ~pos=loc_start,
          str,
          Css_parser.declaration_list,
        );

      let styledExpr =
        Exp.ident(~loc, {txt: Lident(styleVariableName), loc});

      Mod.mk(
        Pmod_structure([
          createMakeProps(~loc, None),
          createReactBinding(~loc),
          createStyles(
            ~loc,
            ~name=styleVariableName,
            ~exp=Css_to_emotion.render_emotion_css(ast, None),
          ),
          createComponent(~loc, ~tag, ~styledExpr),
        ]),
      );
    | _ => default_mapper.module_expr(mapper, expr)
    },
};

let () =
  Driver.register(~name="styled-ppx", Versions.ocaml_406, styledPpxMapper);
