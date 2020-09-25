open Migrate_parsetree;
open Ast_410;
open Ast_mapper;
open Asttypes;
open Parsetree;
open Ast_helper;
open Longident;
open React_props;

module Ast_builder = Ppxlib.Ast_builder.Default;

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

let isStyledTag = str =>
  switch (String.split_on_char('.', str)) {
  | ["styled", ..._] => true
  | _ => false
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
  | _ => (expr, list, None)
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
      Attr.mk({txt: "bs.val", loc}, PStr([])),
      Attr.mk(
        {txt: "bs.module", loc},
        PStr([
          Str.mk(
            ~loc,
            Pstr_eval(
              Exp.constant(
                ~loc,
                ~attrs=[
                  Attr.mk({txt: "reason.raw_literal", loc}, PStr([])),
                ],
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
        ~attrs=[Attr.mk({txt: "explicit_arity", loc}, PStr([]))], /* Add [@explicit_arity] */
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
            Attr.mk(
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
    ~attrs=[Attr.mk({txt: "reason.preserve_braces", loc}, PStr([]))],
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
let createCustomPropLabel = (~loc, name, type_) =>
  Type.field(~loc, {txt: name, loc}, type_);

/* [@bs.optional] ahref: string */
let createRecordLabel = (~loc, name, kind) =>
  Type.field(
    ~loc,
    ~attrs=[Attr.mk({txt: "bs.optional", loc}, PStr([]))],
    {txt: name, loc},
    Typ.constr(~loc, {txt: Lident(kind), loc}, []),
  );

/* [@bs.optional] ref: domRef */
let createDomRefLabel = (~loc) =>
  Type.field(
    ~loc,
    ~attrs=[Attr.mk({txt: "bs.optional", loc}, PStr([]))],
    {txt: "ref", loc},
    Typ.constr(~loc, {txt: Ldot(Lident("ReactDOMRe"), "domRef"), loc}, []),
  );

/* [@bs.optional] children: React.element */
let createChildrenLabel = (~loc) =>
  Type.field(
    ~loc,
    ~attrs=[Attr.mk({txt: "bs.optional", loc}, PStr([]))],
    {txt: "children", loc},
    Typ.constr(~loc, {txt: Ldot(Lident("React"), "element"), loc}, []),
  );

/* [@bs.optional] onDragOver: ReactEvent.Mouse.t => unit */
let createRecordEventLabel = (~loc, name, kind) => {
  Type.field(
    ~loc,
    ~attrs=[Attr.mk({txt: "bs.optional", loc}, PStr([]))],
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
  let bsDerivingAbstract =
    Attr.mk(
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
             domProp =>
               switch (domProp) {
               | Event({name, type_}) =>
                 createRecordEventLabel(~loc, name, type_)
               | Attribute({name, type_}) =>
                 createRecordLabel(~loc, name, type_)
               },
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

let match_exp_string_payload = expr => {
  open Ppxlib.Ast_pattern;
  let pattern =
    pexp_extension(
      extension(
        __,
        pstr(
          pstr_eval(pexp_constant(pconst_string(__', __)), nil) ^:: nil,
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

let match_mod_payload = mod_expr => {
  open Ppxlib.Ast_pattern;

  let pattern =
    pmod_extension(
      extension(
        __',
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
                  pexp_constant(pconst_string(__', __)),
                )
            ||| map(~f=(f, expr) => f(`Expr(expr)), __),
            nil,
          )
          ^:: nil
          ||| map(~f=f => f(`None), nil),
        ),
      ),
    );
  parse(
    pattern,
    mod_expr.pmod_loc,
    ~on_error=_ => None,
    mod_expr,
    (key, payload) => Some((key, payload)),
  );
};

let renderStringPayload = (kind, payload, delim) => {
  let {txt: string, loc} = payload;
  let loc_start =
    switch (delim) {
    | None => loc.Location.loc_start
    | Some(s) => {
        ...loc.Location.loc_start,
        Lexing.pos_cnum:
          loc.Location.loc_start.Lexing.pos_cnum + String.length(s) + 1,
      }
    };

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

let renderPayload = (kind, default_mapper, expr) => {
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

let styledPpxMapper = (_, _) => {
  ...default_mapper,
  /*
     This is what defines where the ppx should be hooked into, in this case
     we transform expr ("expressions").
   */
  expr: (mapper, expr) =>
    switch (match_exp_string_payload(expr)) {
    | Some(("css", payload, delim)) =>
      renderStringPayload(`Style, payload, delim)
    | Some(("styled.global", payload, delim)) =>
      renderStringPayload(`Global, payload, delim)
    | Some(("styled.keyframe", payload, delim)) =>
      renderStringPayload(`Keyframe, payload, delim)
    | exception _
    | _ => default_mapper.expr(mapper, expr)
    },
  /***
    * This is what defines [%styled] as an extension point that hooks into module_expr,
    so all the modules pass into here and we patter-match the ones with [%styled.div () => {||}]
   */
  module_expr: (mapper, expr) => {
    switch (match_mod_payload(expr)) {
    | Some((
        {txt: name, loc: nameLoc},
        `Fun(label, args, pattern, expression),
      ))
        when isStyledTag(name) =>
      let tag = getTag(name);

      /* Fix getLabeledArgs, to stop ignoring the first arg */
      let alias = getAlias(pattern, label);
      let type_ = getType(pattern);

      let firstArg = (label, args, pattern, alias, pattern.ppat_loc, type_);

      let (functionExpr, argList, _) =
        getLabeledArgs(mapper, expression, [firstArg]);

      if (!List.exists(t => t == tag, Html.tags)) {
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
            open Ast_builder; /* Gets the type of the argument from the fn definition
                      (~width: int, ~height: int) => {}
                    */

            let type_ =
              switch (type_) {
              | Some(type_) => type_
              | None =>
                ptyp_constr(~loc, Located.mk(~loc, Lident("string")), [])
              };
            (getLabel(arg), type_);
          },
          argList,
        );

      let variableProps =
        Some(
          List.map(
            ((label, type_)) => createCustomPropLabel(~loc, label, type_),
            variableList,
          ),
        );
      let css_expr = renderPayload(`Style, default_mapper, functionExpr);
      Mod.mk(
        Pmod_structure([
          createMakeProps(~loc, variableProps),
          createReactBinding(~loc),
          createDynamicStyles(
            ~loc,
            ~name=styleVariableName,
            ~args=argList,
            ~exp=css_expr,
          ),
          createComponent(~loc, ~tag, ~styledExpr),
        ]),
      );
    | Some(({txt: name, loc: nameLoc}, `String(str, delim)))
        when isStyledTag(name) =>
      let tag = getTag(name);

      if (!List.exists(t => t == tag, Html.tags)) {
        raiseWithLocation(
          ~loc=nameLoc,
          "Unexpected HTML tag in [%styled." ++ tag ++ "]",
        );
      };

      let loc = str.loc;
      let css_expr = renderStringPayload(`Style, str, delim);

      let styledExpr =
        Exp.ident(~loc, {txt: Lident(styleVariableName), loc});

      Mod.mk(
        Pmod_structure([
          createMakeProps(~loc, None),
          createReactBinding(~loc),
          createStyles(~loc, ~name=styleVariableName, ~exp=css_expr),
          createComponent(~loc, ~tag, ~styledExpr),
        ]),
      );
    | Some(({txt: name, loc: nameLoc}, `None)) when isStyledTag(name) =>
      let tag = getTag(name);

      if (!List.exists(t => t == tag, Html.tags)) {
        raiseWithLocation(
          ~loc=nameLoc,
          "Unexpected HTML tag in [%styled." ++ tag ++ "]",
        );
      };

      let loc = nameLoc;
      let css_expr = renderStringPayload(`Style, {txt: "", loc}, None);

      let styledExpr =
        Exp.ident(~loc, {txt: Lident(styleVariableName), loc});

      Mod.mk(
        Pmod_structure([
          createMakeProps(~loc, None),
          createReactBinding(~loc),
          createStyles(~loc, ~name=styleVariableName, ~exp=css_expr),
          createComponent(~loc, ~tag, ~styledExpr),
        ]),
      );
    // | Some(({txt: name, loc: nameLoc}, `Expr(expr))) => assert(false)
    | _ => default_mapper.module_expr(mapper, expr)
    };
  },
};

let () =
  Driver.register(
    ~name="styled-ppx",
    /* this is required to run before ppx_metaquot during tests */
    /* any change regarding this behavior not related to metaquot is a bug */
    ~position=-1,
    Versions.ocaml_410,
    styledPpxMapper,
  );
