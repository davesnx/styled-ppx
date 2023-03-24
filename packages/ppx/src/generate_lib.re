open Ppxlib;

module Helper = Ast_helper;
module Builder = Ppxlib.Ast_builder.Default;

let withLoc = (~loc, txt) => {loc, txt};

module ReasonAttributes = {
  let preserveBraces = (~loc) =>
    Helper.Attr.mk(withLoc("reason.preserve_braces", ~loc), PStr([]));

  let rawLiteral = (~loc) =>
    Helper.Attr.mk(withLoc("reason.raw_literal", ~loc), PStr([]));
};

module ReScriptAttributes = {
  let optional = (~loc) =>
    Helper.Attr.mk(withLoc("ns.optional", ~loc), PStr([]));
  let template = (~loc) =>
    Helper.Attr.mk(withLoc("res.template", ~loc), PStr([]));
};

module BuckleScriptAttributes = {
  /* [@bs.optional] */
  let optional = (~loc) =>
    Helper.Attr.mk(withLoc("bs.optional", ~loc), PStr([]));

  /* fn(. ) */
  let uncurried = (~loc) => {
    Builder.attribute(~name=withLoc(~loc, "bs"), ~loc, ~payload=PStr([]));
  };

  /* [@bs.deriving abstract] */
  let derivingAbstract = (~loc) =>
    Helper.Attr.mk(
      withLoc("bs.deriving", ~loc),
      PStr([
        Helper.Str.mk(
          ~loc,
          Pstr_eval(
            Helper.Exp.ident(~loc, withLoc(Lident("abstract"), ~loc)),
            [],
          ),
        ),
      ]),
    );

  /* [bs.as ""] */
  let alias = (~loc, alias) =>
    Helper.Attr.mk(
      withLoc("bs.as", ~loc),
      PStr([
        Helper.Str.mk(
          ~loc,
          Pstr_eval(
            Helper.Exp.constant(
              ~loc,
              ~attrs=[],
              Pconst_string(alias, loc, None),
            ),
            [],
          ),
        ),
      ]),
    );

  let val_ = (~loc) => Helper.Attr.mk(withLoc("bs.val", ~loc), PStr([]));
};

let optionalAttribute = (~loc) => {
  switch (File.get()) {
  | Some(ReScript) when Settings.Get.jsxVersion() === 4 =>
    ReScriptAttributes.optional(~loc)
  | Some(Reason)
  | _ => BuckleScriptAttributes.optional(~loc)
  };
};

/* (~a, ~b, ~c, _) => args */
let rec fnWithLabeledArgs = (list, args) =>
  switch (list) {
  | [] => args
  | [(label, default, pattern, _alias, loc, _inner), ...rest] =>
    fnWithLabeledArgs(
      rest,
      Helper.Exp.fun_(~loc, label, default, pattern, args),
    )
  };

/* let styles = Emotion.(css(exp)) */
let styles = (~loc, ~name, ~expr) => {
  let variableName = Helper.Pat.mk(~loc, Ppat_var(withLoc(name, ~loc)));
  Helper.Str.mk(
    ~loc,
    Pstr_value(Nonrecursive, [Helper.Vb.mk(~loc, variableName, expr)]),
  );
};

/* let styles = (~arg1, ~arg2) => Emotion.(css(exp)) */
let dynamicStyles = (~loc, ~name, ~args, ~expr) => {
  let variableName = Helper.Pat.mk(~loc, Ppat_var(withLoc(name, ~loc)));
  let ppatAnyArg = (
    Nolabel,
    None,
    Builder.ppat_any(~loc),
    "_",
    Location.none,
    None,
  );
  /* Last argument needs to be ignored, since it's a unit to remove the warning of optional labelled arguments */
  let argsWithLastAny = [ppatAnyArg, ...args];

  Helper.Str.mk(
    ~loc,
    Pstr_value(
      Nonrecursive,
      [
        Helper.Vb.mk(
          ~loc,
          variableName,
          fnWithLabeledArgs(argsWithLastAny, expr),
        ),
      ],
    ),
  );
};

/*
  [@bs.val] [@bs.module "react"] external createVariadicElement:
  (string, Js.t({ .. })) => React.element =
  "createElement";
 */
let bindingCreateVariadicElement = (~loc) => {
  Helper.Str.primitive({
    pval_loc: loc,
    pval_name: withLoc("createVariadicElement", ~loc),
    pval_type:
      Helper.Typ.arrow(
        ~loc,
        Nolabel,
        Helper.Typ.constr(~loc, withLoc(Lident("string"), ~loc), []),
        Helper.Typ.arrow(
          ~loc,
          Nolabel,
          Helper.Typ.constr(
            ~loc,
            withLoc(Ldot(Lident("Js"), "t"), ~loc),
            [Helper.Typ.object_(~loc, [], Open)],
          ),
          Helper.Typ.constr(
            ~loc,
            withLoc(Ldot(Lident("React"), "element"), ~loc),
            [],
          ),
        ),
      ),
    pval_prim: ["createElement"],
    pval_attributes: [
      Helper.Attr.mk(withLoc("bs.val", ~loc), PStr([])),
      Helper.Attr.mk(
        withLoc("bs.module", ~loc),
        PStr([
          Helper.Str.mk(
            ~loc,
            Pstr_eval(
              Helper.Exp.constant(
                ~loc,
                ~attrs=[ReasonAttributes.rawLiteral(~loc)],
                Pconst_string("react", loc, None),
              ),
              [],
            ),
          ),
        ]),
      ),
    ],
  });
};

let defineGetOrEmptyFn = (~loc) => {
  [%stri
    let getOrEmpty = str => {
      switch (str) {
      | Some(str) => " " ++ str
      | None => ""
      };
    }
  ];
};

/* ignore() */
let applyIgnore = (~loc, expr) => {
  Helper.Exp.apply(
    ~loc,
    Helper.Exp.ident(~loc, withLoc(Lident("ignore"), ~loc)),
    [(Nolabel, expr)],
  );
};

/* createVariadicElement("div", newProps) */
let variadicElement = (~loc, ~htmlTag) => {
  Helper.Exp.apply(
    ~loc,
    Helper.Exp.ident(~loc, withLoc(Lident("createVariadicElement"), ~loc)),
    [
      (
        Nolabel,
        Helper.Exp.constant(
          ~loc,
          ~attrs=[
            Helper.Attr.mk(
              withLoc("reason.raw_literal", ~loc),
              PStr([
                Helper.Str.mk(
                  ~loc,
                  Pstr_eval(
                    Helper.Exp.constant(
                      ~loc,
                      Pconst_string(htmlTag, loc, None),
                    ),
                    [],
                  ),
                ),
              ]),
            ),
          ],
          Pconst_string(htmlTag, loc, None),
        ),
      ),
      (Nolabel, Helper.Exp.ident(~loc, withLoc(Lident("newProps"), ~loc))),
    ],
  );
};

let propRecordAccess = (~loc, name) => {
  Helper.Exp.field(
    ~loc,
    Helper.Exp.ident(~loc, withLoc(Lident("props"), ~loc)),
    withLoc(Lident(name), ~loc),
  );
};

/* propNameGet(props) */
let abstractGetProp = (~loc, name) => {
  Helper.Exp.apply(
    ~loc,
    Helper.Exp.ident(~loc, withLoc(Lident(name ++ "Get"), ~loc)),
    [(Nolabel, Helper.Exp.ident(~loc, withLoc(Lident("props"), ~loc)))],
  );
};

let propItem = (~loc, name) => {
  switch (File.get()) {
  | Some(ReScript) when Settings.Get.jsxVersion() === 4 =>
    propRecordAccess(~loc, name)
  | _ => abstractGetProp(~loc, name)
  };
};

/* let stylesObject = { "className": className, "ref": props.ref }; */
let stylesAndRefObject = (~loc) => {
  let className = (
    withLoc(~loc, Lident("className")),
    Helper.Exp.ident(~loc, withLoc(Lident("className"), ~loc)),
  );
  let refProp = (
    withLoc(~loc, Lident("innerRef")),
    propItem(~loc, "innerRef"),
  );
  let record = Helper.Exp.record(~loc, [className, refProp], None);
  Helper.Vb.mk(
    ~loc,
    Helper.Pat.mk(~loc, Ppat_var(withLoc("stylesObject", ~loc))),
    Helper.Exp.extension(
      ~loc,
      (
        withLoc("bs.obj", ~loc),
        PStr([Helper.Str.mk(~loc, Pstr_eval(record, []))]),
      ),
    ),
  );
};

/* let newProps = Js.Obj.assign(Obj.magic(props), stylesObject); */
let newProps = (~loc) => {
  let valueName = Helper.Pat.mk(~loc, Ppat_var(withLoc("newProps", ~loc)));
  let value = [%expr
    assign2(Js.Obj.empty(), Obj.magic(props), stylesObject)
  ];

  Helper.Vb.mk(~loc, valueName, value);
};

/* let className = styles ++ props.className; */
let className = (~loc, expr) => {
  let _classNameProp = propItem(~loc, "className");
  Helper.Vb.mk(
    ~loc,
    Helper.Pat.mk(~loc, Ppat_var(withLoc("className", ~loc))),
    [%expr [%e expr]],
    /* [%expr [%e expr] ++ getOrEmpty([%e classNameProp])], */
  );
};

/* deleteInnerRef(. newProps, "innerRef") |> ignore; */
let deleteProp = (~loc, key) => {
  Helper.Exp.apply(
    ~loc,
    Helper.Exp.ident(~loc, withLoc(Lident("deleteProp"), ~loc)),
    [
      (Nolabel, Helper.Exp.ident(~loc, withLoc(Lident("newProps"), ~loc))),
      (Nolabel, Helper.Exp.constant(~loc, Pconst_string(key, loc, None))),
    ],
  )
  |> applyIgnore(~loc);
};
let generateSequence = (~loc, fns) => {
  let rec generate = (~loc, fns) => {
    switch (fns) {
    | [] => failwith("sequence needs to contain at least one function")
    | [return] => return
    | [fn, return] => Helper.Exp.sequence(~loc, fn, return)
    | [fn, ...rest] => Helper.Exp.sequence(~loc, fn, generate(~loc, rest))
    };
  };
  generate(~loc, fns);
};

/*
  let stylesObject = {"className": styles};
  let newProps = Js.Obj.assign(stylesObject, Obj.magic(props));
  createVariadicElement("div", newProps);
 */
let makeBody = (~loc, ~htmlTag, ~styledExpr, ~variables) => {
  let attrs =
    switch (File.get()) {
    | Some(ReScript) => []
    | Some(Reason)
    | _ => [ReasonAttributes.preserveBraces(~loc)]
    };
  let sequence =
    [deleteProp(~loc, "innerRef"), variadicElement(~loc, ~htmlTag)]
    |> List.append(List.map(deleteProp(~loc), variables));

  Helper.Exp.let_(
    ~loc,
    Nonrecursive,
    [className(~loc, styledExpr)],
    Helper.Exp.let_(
      ~loc,
      ~attrs,
      Nonrecursive,
      [stylesAndRefObject(~loc)],
      Helper.Exp.let_(
        ~loc,
        Nonrecursive,
        [newProps(~loc)],
        generateSequence(~loc, sequence),
      ),
    ),
  );
};

let getLabel = str =>
  switch (str) {
  | Optional(str)
  | Labelled(str) => str
  | Nolabel => ""
  };

/* let make = (props: makeProps) => + makeBody */
let makeFnJSX3 = (~loc, ~htmlTag, ~styledExpr, ~makePropTypes, ~variableNames) => {
  Helper.Exp.fun_(
    ~loc,
    Nolabel,
    None,
    /* props: makeProps */
    Helper.Pat.constraint_(
      ~loc,
      Helper.Pat.mk(~loc, Ppat_var(withLoc("props", ~loc))),
      Helper.Typ.constr(
        ~loc,
        withLoc(Lident("makeProps"), ~loc),
        makePropTypes,
      ),
    ),
    makeBody(~loc, ~htmlTag, ~styledExpr, ~variables=variableNames),
  );
};

/* let make = (props: props) => + makeBody */
let makeFnJSX4 = (~loc, ~htmlTag, ~styledExpr, ~makePropTypes, ~variableNames) => {
  Helper.Exp.fun_(
    ~loc,
    Nolabel,
    None,
    /* props: props */
    Helper.Pat.constraint_(
      ~loc,
      Helper.Pat.mk(~loc, Ppat_var(withLoc("props", ~loc))),
      Helper.Typ.constr(
        ~loc,
        withLoc(Lident("props"), ~loc),
        makePropTypes,
      ),
    ),
    makeBody(~loc, ~htmlTag, ~styledExpr, ~variables=variableNames),
  );
};

/* [@react.component] + makeFn */
let component =
    (~loc, ~htmlTag, ~styledExpr, ~makePropTypes, ~labeledArguments) => {
  let variableNames =
    List.map(((arg, _, _, _, _, _)) => getLabel(arg), labeledArguments);

  let makeFn =
    switch (File.get()) {
    | Some(ReScript) when Settings.Get.jsxVersion() === 4 =>
      makeFnJSX4(~loc, ~htmlTag, ~styledExpr, ~makePropTypes, ~variableNames)
    | _ =>
      makeFnJSX3(~loc, ~htmlTag, ~styledExpr, ~makePropTypes, ~variableNames)
    };

  [%stri let make = [%e makeFn]];
};

/* color: string */
let customPropLabel = (~loc, ~optional, name, type_) => {
  Helper.Type.field(
    ~loc,
    ~attrs=optional ? [optionalAttribute(~loc)] : [],
    withLoc(name, ~loc),
    type_,
  );
};

let typeVariable = (~loc, name) => Builder.ptyp_var(~loc, name);

/* href: string */
let recordLabel = (~loc, name, kind, alias) => {
  let attrs =
    switch (alias) {
    | Some(alias) => [
        optionalAttribute(~loc),
        BuckleScriptAttributes.alias(~loc, alias),
      ]
    | None => [optionalAttribute(~loc)]
    };

  Helper.Type.field(
    ~loc,
    ~attrs,
    withLoc(name, ~loc),
    Helper.Typ.constr(~loc, withLoc(kind, ~loc), []),
  );
};

/* innerRef: domRef */
let domRefLabel = (~loc) => {
  /* TODO: is innerRef in JSX4? */
  Helper.Type.field(
    ~loc,
    ~attrs=[optionalAttribute(~loc)],
    withLoc("innerRef", ~loc),
    Helper.Typ.constr(
      ~loc,
      withLoc(Ldot(Lident("ReactDOM"), "domRef"), ~loc),
      [],
    ),
  );
};

/* children: React.element */
let childrenLabel = (~loc) =>
  Helper.Type.field(
    ~loc,
    ~attrs=[optionalAttribute(~loc)],
    withLoc("children", ~loc),
    Helper.Typ.constr(
      ~loc,
      withLoc(Ldot(Lident("React"), "element"), ~loc),
      [],
    ),
  );

/* onDragOver: ReactEvent.Mouse.t => unit */
let recordEventLabel = (~loc, name, kind) => {
  let type_ =
    Helper.Typ.arrow(
      ~loc,
      Nolabel,
      Helper.Typ.constr(~loc, withLoc(kind, ~loc), []),
      Helper.Typ.constr(~loc, withLoc(Lident("unit"), ~loc), []),
    );
  Helper.Type.field(
    ~loc,
    ~attrs=[optionalAttribute(~loc)],
    withLoc(name, ~loc),
    type_,
  );
};

let makePropsWithParams = (~loc, params, dynamicProps) => {
  let dynamicPropNames = dynamicProps |> List.map(d => d.pld_name.txt);

  let makeProps =
    MakeProps.get(dynamicPropNames)
    |> List.map(domProp =>
         switch (domProp) {
         | MakeProps.Event({name, type_}) =>
           recordEventLabel(~loc, name, MakeProps.eventTypeToIdent(type_))
         | MakeProps.Attribute({name, type_, alias}) =>
           recordLabel(
             ~loc,
             name,
             MakeProps.attributeTypeToIdent(type_),
             alias,
           )
         }
       );

  /* List of `prop: type` */
  let reactProps =
    List.append(
      [domRefLabel(~loc), childrenLabel(~loc), ...makeProps],
      dynamicProps,
    );

  let params =
    List.map(
      type_ => (type_, (Asttypes.NoVariance, Asttypes.NoInjectivity)),
      params,
    ); /* TODO: Made correct ast, not sure if it matter */

  Helper.Str.mk(
    ~loc,
    Pstr_type(
      Recursive,
      [
        Helper.Type.mk(
          ~loc,
          ~priv=Public,
          ~attrs=[ReScriptAttributes.optional(~loc)],
          ~kind=Ptype_record(reactProps),
          ~params,
          withLoc("props", ~loc),
        ),
      ],
    ),
  );
};

let makePropsJSX4 = (~loc, customProps) => {
  switch (customProps) {
  | Some((params, dynamicProps)) =>
    makePropsWithParams(~loc, params, dynamicProps)
  | None => [%stri type props = JsxDOM.domProps]
  };
};

/* type makeProps = { ... } */
/* type makeProps('a, 'b) = { ... } */
let makeMakeProps = (~loc, customProps) => {
  let (params, dynamicProps) =
    switch (customProps) {
    | None => ([], [])
    | Some((params, props)) => (params, props)
    };

  let dynamicPropNames = dynamicProps |> List.map(d => d.pld_name.txt);

  let makeProps =
    MakeProps.get(dynamicPropNames)
    |> List.map(domProp =>
         switch (domProp) {
         | MakeProps.Event({name, type_}) =>
           recordEventLabel(~loc, name, MakeProps.eventTypeToIdent(type_))
         | MakeProps.Attribute({name, type_, alias}) =>
           recordLabel(
             ~loc,
             name,
             MakeProps.attributeTypeToIdent(type_),
             alias,
           )
         }
       );

  /* List of [@bs.optional] prop: type */
  let reactProps =
    List.append(
      [domRefLabel(~loc), childrenLabel(~loc), ...makeProps],
      dynamicProps,
    );

  let params =
    List.map(
      type_ => (type_, (Asttypes.NoVariance, Asttypes.NoInjectivity)),
      params,
    ) /* TODO: Made correct ast, not sure if it matter */;

  Helper.Str.mk(
    ~loc,
    Pstr_type(
      Recursive,
      [
        Helper.Type.mk(
          ~loc,
          ~priv=Public,
          ~attrs=[BuckleScriptAttributes.derivingAbstract(~loc)],
          ~kind=Ptype_record(reactProps),
          ~params,
          withLoc("makeProps", ~loc),
        ),
      ],
    ),
  );
};

/* type props = { ... } */
/* type props('a, 'b) = { ... } */
let makeProps = (~loc, customProps) => {
  switch (File.get()) {
  | Some(ReScript) when Settings.Get.jsxVersion() === 4 =>
    makePropsJSX4(~loc, customProps)
  | Some(Reason)
  | _ => makeMakeProps(~loc, customProps)
  };
};

let defineDeletePropFn = (~loc) => {
  [%stri let deleteProp = [%raw "(newProps, key) => delete newProps[key]"]];
};

/* [%stri external assign2 : Js.t({ .. }) => Js.t({ .. }) => Js.t({ .. }) => Js.t({ .. }) = "Object.assign"] */
let defineAssign2 = (~loc) => {
  Helper.Str.primitive({
    pval_loc: loc,
    pval_name: withLoc("assign2", ~loc),
    pval_type:
      Helper.Typ.arrow(
        ~loc,
        Nolabel,
        [%type: Js.t({..})],
        Helper.Typ.arrow(
          ~loc,
          Nolabel,
          [%type: Js.t({..})],
          Helper.Typ.arrow(
            ~loc,
            Nolabel,
            [%type: Js.t({..})],
            [%type: Js.t({..})],
          ),
        ),
      ),
    pval_prim: ["Object.assign"],
    pval_attributes: [BuckleScriptAttributes.val_(~loc)],
  });
};

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
