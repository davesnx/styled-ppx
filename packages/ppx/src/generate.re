open Ppxlib;

module Helper = Ast_helper;
module Builder = Ppxlib.Ast_builder.Default;

let map_tr = (f, l) => List.rev_map(f, l) |> List.rev;

let withLoc = (~loc, txt) => {
  loc,
  txt,
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
let dynamicStylesDecl = (~loc, ~name, ~args, ~expr) => {
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
  [@mel.module "react"] external createVariadicElement:
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
      Platform_attributes.module_(
        ~loc,
        Helper.Str.mk(
          ~loc,
          Pstr_eval(
            Helper.Exp.constant(
              ~loc,
              ~attrs=
                Platform_attributes.rawLiteral(
                  ~loc,
                  Helper.Str.mk(
                    ~loc,
                    Pstr_eval(
                      Helper.Exp.constant(
                        ~loc,
                        Pconst_string("react", loc, None),
                      ),
                      [],
                    ),
                  ),
                ),
              Pconst_string("react", loc, None),
            ),
            [],
          ),
        ),
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

let abstractGetProp = (~loc, name) =>
  if (Settings.Get.native()) {
    /* props.propName */
    Helper.Exp.field(
      ~loc,
      Helper.Exp.ident(~loc, withLoc(Lident("props"), ~loc)),
      withLoc(Lident(name), ~loc),
    );
  } else {
    /* propNameGet(props) */
    Helper.Exp.apply(
      ~loc,
      Helper.Exp.ident(~loc, withLoc(Lident(name ++ "Get"), ~loc)),
      [(Nolabel, Helper.Exp.ident(~loc, withLoc(Lident("props"), ~loc)))],
    );
  };

let propItem = (~loc, name) => {
  abstractGetProp(~loc, name);
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

/* deleteProp(newProps, key) |> ignore; */
/* TODO: Replace with Js.Dict.unsafeDeleteKey */
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

let asAttribute = () =>
  MakeProps.Attribute({
    name: "as_",
    type_: String,
    alias: Some("as"),
  });

/*
 let asTag = props.as_;
 deleteProp(newProps, "as") |> ignore;
 createVariadicElement(finalHtmlTag, newProps)
 */
let variadicElement = (~loc, ~htmlTag) => {
  let asAttributeName =
    switch (asAttribute()) {
    | MakeProps.Attribute({ name, _ }) => name
    | _ => failwith("unreachable")
    };

  let asTag = {
    Helper.Vb.mk(
      ~loc,
      Helper.Pat.mk(~loc, Ppat_var(withLoc("asTag", ~loc))),
      propItem(~loc, asAttributeName),
    );
  };

  let deletePropAs = deleteProp(~loc, "as");

  let finalHtmlTag =
    switch%expr (asTag) {
    | Some(as_) => as_
    | None => [%e Builder.estring(~loc, htmlTag)]
    };

  let createVariadicElement =
    Helper.Exp.apply(
      ~loc,
      Helper.Exp.ident(
        ~loc,
        withLoc(Lident("createVariadicElement"), ~loc),
      ),
      [
        (Nolabel, finalHtmlTag),
        (
          Nolabel,
          Helper.Exp.ident(~loc, withLoc(Lident("newProps"), ~loc)),
        ),
      ],
    );

  Helper.Exp.let_(
    ~loc,
    Nonrecursive,
    [asTag],
    generateSequence(~loc, [deletePropAs, createVariadicElement]),
  );
};

let getLabel = str =>
  switch (str) {
  | Optional(str)
  | Labelled(str) => str
  | Nolabel => ""
  };

let serverCreateElement = (~loc, ~htmlTag, ~variableNames) => {
  let finalHtmlTag =
    switch%expr ([%e propItem(~loc, "as_")]) {
    | Some(v) => v
    | None => [%e Builder.estring(~loc, htmlTag)]
    };

  let params =
    MakeProps.get(["key", "ref", "className", "style"] @ variableNames)
    |> map_tr(value =>
         switch (value) {
         | MakeProps.Event({ name, _ }) => name
         | MakeProps.Attribute({ name, _ }) => name
         }
       )
    |> map_tr(label => (Optional(label), propItem(~loc, label)));

  let domProps =
    Helper.Exp.apply(
      [%expr ReactDOM.domProps],
      [
        (Labelled("className"), [%expr className]),
        (Labelled("style"), [%expr style]),
        (Optional("ref"), propItem(~loc, "innerRef")),
      ]
      @ params
      @ [(Nolabel, [%expr ()])],
    );

  let childrenExpr = propItem(~loc, "children");
  let children =
    switch%expr ([%e childrenExpr]) {
    | Some(c) => c
    | None => React.null
    };
  [%expr
   React.createElement([%e finalHtmlTag], [%e domProps], [[%e children]])
  ];
};

let stylesAndRefObject = (~loc) => {
  Helper.Vb.mk(
    ~loc,
    Helper.Pat.mk(~loc, Ppat_var(withLoc("stylesObject", ~loc))),
    Helper.Exp.apply(
      ~loc,
      Helper.Exp.ident(~loc, withLoc(Lident("makeStylesObject"), ~loc)),
      [
        (
          Labelled("className"),
          Helper.Exp.ident(~loc, withLoc(Lident("className"), ~loc)),
        ),
        (
          Labelled("style"),
          Helper.Exp.ident(~loc, withLoc(Lident("style"), ~loc)),
        ),
        (Labelled("ref"), propItem(~loc, "innerRef")),
      ],
    ),
  );
};

/* let newProps = Object.assign({}, props, stylesObject); */
let newProps = (~loc) => {
  let valueName = Helper.Pat.mk(~loc, Ppat_var(withLoc("newProps", ~loc)));
  let value = [%expr assign2(Js.Obj.empty(), props, stylesObject)];

  Helper.Vb.mk(~loc, valueName, value);
};

/* let className = fst(styles) ++ props.className; */
let className = (~loc, expr) => {
  let classNameProp = propItem(~loc, "className");
  Helper.Vb.mk(
    ~loc,
    Helper.Pat.mk(~loc, Ppat_var(withLoc("className", ~loc))),
    [%expr fst([%e expr]) ++ getOrEmpty([%e classNameProp])],
  );
};

let style = (~loc, expr) =>
  Helper.Vb.mk(
    ~loc,
    Helper.Pat.mk(~loc, Ppat_var(withLoc("style", ~loc))),
    [%expr snd([%e expr])],
  );

/*
  let className = styles ++ props.className;
  let newProps = Object.assign({}, props, stylesObject);
  createVariadicElement(finalHtmlTag, newProps);
 */
let makeBody = (~loc, ~htmlTag, ~className as classNameValue, ~variables) => {
  let attrs = Platform_attributes.preserveBraces(~loc);
  let sequence =
    [deleteProp(~loc, "innerRef"), variadicElement(~loc, ~htmlTag)]
    |> List.append(List.map(deleteProp(~loc), variables));

  Helper.Exp.let_(
    ~loc,
    Nonrecursive,
    [className(~loc, classNameValue), style(~loc, classNameValue)],
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

let makeBodyServer =
    (~loc, ~htmlTag, ~className as classNameValue, ~variableNames) => {
  Helper.Exp.let_(
    ~loc,
    Nonrecursive,
    [className(~loc, classNameValue), style(~loc, classNameValue)],
    serverCreateElement(~loc, ~htmlTag, ~variableNames),
  );
};

let typeVariable = (~loc, name) => Builder.ptyp_var(~loc, name);

let getIsOptional = str =>
  switch (str) {
  | Optional(_) => true
  | _ => false
  };

/* let make = (props: makeProps) => + makeBodyServer */
let makeFnJSXServer =
    (~loc, ~htmlTag, ~className, ~makePropTypes, ~variableNames) => {
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
    makeBodyServer(~loc, ~htmlTag, ~className, ~variableNames),
  );
};

/* let make = (props: makeProps) => + makeBody */
let makeFnJSX3 = (~loc, ~htmlTag, ~className, ~makePropTypes, ~variableNames) => {
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
    makeBody(~loc, ~htmlTag, ~className, ~variables=variableNames),
  );
};

/* [@react.component] + makeFn */
let component =
    (~loc, ~htmlTag, ~className, ~makePropTypes, ~labeledArguments) => {
  let variableNames =
    List.map(((arg, _, _, _, _, _)) => getLabel(arg), labeledArguments);

  let makeFn =
    switch (File.get()) {
    | Some(Reason)
    | Some(OCaml) when Settings.Get.native() =>
      makeFnJSXServer(
        ~loc,
        ~htmlTag,
        ~className,
        ~makePropTypes,
        ~variableNames,
      )
    | _ =>
      makeFnJSX3(~loc, ~htmlTag, ~className, ~makePropTypes, ~variableNames)
    };

  [[%stri let make = [%e makeFn]]];
};

let optionalType = (~loc, type_) => {
  Helper.Typ.constr(~loc, withLoc(Lident("option"), ~loc), [type_]);
};

/* color: string */
let customPropLabel = (~loc, ~optional, name, type_) => {
  let attrs = optional ? [Platform_attributes.optional(~loc)] : [];
  Helper.Type.field(
    ~loc,
    ~attrs,
    withLoc(name, ~loc),
    /* when is melange, fields need to be annotated as option() when added [@mel.optional] */
    optional && File.get() == Some(Reason)
      ? optionalType(~loc, type_) : type_,
  );
};

/* href: string */
/* Melange expects record fields to be optional */
let recordLabel = (~loc, ~isOptional, name, kind, alias) => {
  /* optional attribute is always present (unrelated with isOptional flag), while the option(type_) changes the type and it's based on isOptional */
  let attrs =
    switch (alias) {
    | Some(alias) => [
        Platform_attributes.optional(~loc),
        Platform_attributes.alias(~loc, alias),
      ]
    | None => [Platform_attributes.optional(~loc)]
    };

  let type_ =
    isOptional
      ? optionalType(
          ~loc,
          Helper.Typ.constr(~loc, withLoc(kind, ~loc), []),
        )
      : Helper.Typ.constr(~loc, withLoc(kind, ~loc), []);

  Helper.Type.field(~loc, ~attrs, withLoc(name, ~loc), type_);
};

/* innerRef: domRef */
let domRefLabel = (~loc, ~isOptional) => {
  /* TODO: is innerRef in JSX4? */
  let reactDOM_domRef =
    Helper.Typ.constr(
      ~loc,
      withLoc(Ldot(Lident("ReactDOM"), "domRef"), ~loc),
      [],
    );
  let type_ =
    isOptional ? optionalType(~loc, reactDOM_domRef) : reactDOM_domRef;
  /* Attribute optional is always present */
  let attrs = [Platform_attributes.optional(~loc)];
  Helper.Type.field(~loc, ~attrs, withLoc("innerRef", ~loc), type_);
};

/* children: React.element */
let childrenLabel = (~loc, ~isOptional) => {
  let react_element =
    Helper.Typ.constr(
      ~loc,
      withLoc(Ldot(Lident("React"), "element"), ~loc),
      [],
    );
  isOptional
    ? Helper.Type.field(
        ~loc,
        ~attrs=[Platform_attributes.optional(~loc)],
        withLoc("children", ~loc),
        optionalType(~loc, react_element),
      )
    : Helper.Type.field(
        ~loc,
        ~attrs=[Platform_attributes.optional(~loc)],
        withLoc("children", ~loc),
        react_element,
      );
};

/* onDragOver: React.Event.Mouse.t => unit */
let recordEventLabel = (~loc, ~isOptional, name, kind) => {
  let arrow_type =
    Helper.Typ.arrow(
      ~loc,
      Nolabel,
      Helper.Typ.constr(~loc, withLoc(kind, ~loc), []),
      Helper.Typ.constr(~loc, withLoc(Lident("unit"), ~loc), []),
    );
  let type_ = isOptional ? optionalType(~loc, arrow_type) : arrow_type;
  /* Attribute optional is always present */
  let attrs = [Platform_attributes.optional(~loc)];
  Helper.Type.field(~loc, ~attrs, withLoc(name, ~loc), type_);
};

let domPropLabel = (~loc, ~isOptional, domProp) => {
  switch (domProp) {
  | MakeProps.Event({ name, type_ }) =>
    recordEventLabel(
      ~loc,
      ~isOptional,
      name,
      MakeProps.eventTypeToIdent(type_),
    )
  | MakeProps.Attribute({ name, type_, alias }) =>
    recordLabel(
      ~loc,
      ~isOptional,
      name,
      MakeProps.attributeTypeToIdent(type_),
      alias,
    )
  };
};

let asLabel = (~loc, ~isOptional) => {
  domPropLabel(~loc, ~isOptional, asAttribute());
};

/* type makeProps = { ... } */
/* type makeProps('a, 'b) = { ... } */
let makeMakeProps = (~loc, ~areAllFieldsOptional, customProps) => {
  let (params, dynamicProps) =
    switch (customProps) {
    | None => ([], [])
    | Some((params, props)) => (params, props)
    };

  let dynamicPropNames = dynamicProps |> List.map(d => d.pld_name.txt);

  let makeProps =
    MakeProps.get(dynamicPropNames)
    |> map_tr(domPropLabel(~loc, ~isOptional=areAllFieldsOptional));

  /* List of `prop: type` */
  let reactProps =
    List.append(
      [
        domRefLabel(~loc, ~isOptional=areAllFieldsOptional),
        childrenLabel(~loc, ~isOptional=areAllFieldsOptional),
        asLabel(~loc, ~isOptional=areAllFieldsOptional),
        ...makeProps,
      ],
      dynamicProps,
    );

  let params =
    List.map(
      type_ => (type_, (Asttypes.NoVariance, Asttypes.NoInjectivity)),
      params,
    );

  Helper.Str.mk(
    ~loc,
    Pstr_type(
      Recursive,
      [
        Helper.Type.mk(
          ~loc,
          ~priv=Public,
          ~attrs=[
            Platform_attributes.derivingAbstract(~loc),
            Builder.attribute(
              ~loc,
              ~name=withLoc(~loc, "warning"),
              ~payload=
                PStr([Helper.Str.eval(~loc, Builder.estring(~loc, "-69"))]),
            ),
          ],
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
  makeMakeProps(~loc, ~areAllFieldsOptional=true, customProps);
};

let defineDeletePropFn = (~loc) => {
  Helper.Str.primitive({
    pval_loc: loc,
    pval_name: withLoc("deleteProp", ~loc),
    pval_type:
      Helper.Typ.arrow(
        ~loc,
        Nolabel,
        [%type: Js.t({..})],
        Helper.Typ.arrow(~loc, Nolabel, [%type: string], [%type: bool]),
      ),
    pval_prim: ["Reflect.deleteProperty"],
    pval_attributes: Platform_attributes.val_(~loc),
  });
};

let defineMakeStylesObject = (~loc) => {
  Helper.Str.primitive({
    pval_loc: loc,
    pval_name: withLoc("makeStylesObject", ~loc),
    pval_type:
      Helper.Typ.arrow(
        ~loc,
        Labelled("className"),
        [%type: string],
        Helper.Typ.arrow(
          ~loc,
          Labelled("style"),
          [%type: ReactDOM.Style.t],
          Helper.Typ.arrow(
            ~loc,
            Labelled("ref"),
            [%type: option(ReactDOM.domRef)],
            [%type: Js.t({..})],
          ),
        ),
      ),
    pval_prim: [""],
    pval_attributes: [Platform_attributes.objExternal(~loc)],
  });
};

let makePropsType = (~loc, ~makePropTypes) =>
  Helper.Typ.constr(
    ~loc,
    withLoc(Lident("makeProps"), ~loc),
    List.map(_ => Builder.ptyp_any(~loc), makePropTypes),
  );

let optionInnerType = type_ =>
  switch (type_.ptyp_desc) {
  | Ptyp_constr({ txt: Lident("option"), _ }, [inner]) => Some(inner)
  | _ => None
  };

let makePropsArg = (~loc, field: label_declaration, returnType) => {
  let label = field.pld_name.txt;
  switch (optionInnerType(field.pld_type)) {
  | Some(inner) =>
    Helper.Typ.arrow(~loc, Optional(label), inner, returnType)
  | None =>
    Helper.Typ.arrow(~loc, Labelled(label), field.pld_type, returnType)
  };
};

let defineMakePropsFn = (~loc, ~makePropTypes, ~customProps) => {
  let propType = makePropsType(~loc, ~makePropTypes);
  let fields = [
    childrenLabel(~loc, ~isOptional=true),
    asLabel(~loc, ~isOptional=true),
    domRefLabel(~loc, ~isOptional=true),
    customPropLabel(~loc, ~optional=true, "className", [%type: string]),
    ...customProps,
  ];
  let functionType =
    fields
    |> List.rev
    |> List.fold_left(
         (returnType, field) => makePropsArg(~loc, field, returnType),
         Helper.Typ.arrow(~loc, Nolabel, [%type: unit], propType),
       );

  Helper.Str.primitive({
    pval_loc: loc,
    pval_name: withLoc("makeProps", ~loc),
    pval_type: functionType,
    pval_prim: [""],
    pval_attributes: [Platform_attributes.objExternal(~loc)],
  });
};

let defineGetterFn = (~loc, ~makePropTypes, ~name, ~property, ~type_) => {
  Helper.Str.primitive({
    pval_loc: loc,
    pval_name: withLoc(name ++ "Get", ~loc),
    pval_type:
      Helper.Typ.arrow(
        ~loc,
        Nolabel,
        makePropsType(~loc, ~makePropTypes),
        type_,
      ),
    pval_prim: [property],
    pval_attributes: [Platform_attributes.get(~loc)],
  });
};

let defineGetterFns = (~loc, ~makePropTypes, ~customProps) => {
  let coreGetters = [
    defineGetterFn(
      ~loc,
      ~makePropTypes,
      ~name="className",
      ~property="className",
      ~type_=[%type: option(string)],
    ),
    defineGetterFn(
      ~loc,
      ~makePropTypes,
      ~name="innerRef",
      ~property="innerRef",
      ~type_=[%type: option(ReactDOM.domRef)],
    ),
    defineGetterFn(
      ~loc,
      ~makePropTypes,
      ~name="as_",
      ~property="as",
      ~type_=[%type: option(string)],
    ),
  ];

  let customGetters =
    customProps
    |> List.map((field: label_declaration) =>
         defineGetterFn(
           ~loc,
           ~makePropTypes,
           ~name=field.pld_name.txt,
           ~property=field.pld_name.txt,
           ~type_=field.pld_type,
         )
       );

  coreGetters @ customGetters;
};

/* [%stri external assign2 : Js.t({ .. }) => makeProps => Js.t({ .. }) => Js.t({ .. }) = "Object.assign"] */
let defineAssign2 = (~loc, ~makePropTypes) => {
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
          makePropsType(~loc, ~makePropTypes),
          Helper.Typ.arrow(
            ~loc,
            Nolabel,
            [%type: Js.t({..})],
            [%type: Js.t({..})],
          ),
        ),
      ),
    pval_prim: ["Object.assign"],
    pval_attributes: Platform_attributes.val_(~loc),
  });
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
  | Ppat_alias(_, { txt, _ })
  | Ppat_var({ txt, _ }) => txt
  | Ppat_any => "_"
  | _ => getLabel(label)
  };

let rec getArgs = (expr, list) => {
  switch (expr.pexp_desc) {
  | Pexp_function(params, _, Pfunction_body(expression)) =>
    let args =
      params
      |> List.filter_map(param =>
           switch (param.pparam_desc) {
           | Pparam_val(arg, default, pattern)
               when getIsOptional(arg) || getIsLabelled(arg) =>
             let alias = getAlias(pattern, arg);
             let type_ = getType(pattern);
             Some((arg, default, pattern, alias, pattern.ppat_loc, type_));
           | Pparam_val(arg, _, pattern) when !getIsLabelled(arg) =>
             Error.raise(
               ~loc=pattern.ppat_loc,
               ~examples=["[%styled.div (~a, ~b) => {}]"],
               ~link=
                 "https://reasonml.org/docs/manual/latest/function#labeled-arguments",
               "Dynamic components are defined with labeled arguments.",
             )
           | _ => None
           }
         );
    getArgs(expression, args @ list);
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
    Error.raise(
      ~loc=param.ppat_loc,
      ~link="https://styled-ppx.vercel.app/usage/dynamic-components",
      "A dynamic component without props doesn't make much sense. This component should be static.",
    );
  };

  if (getNotLabelled(label)) {
    Error.raise(
      ~loc=param.ppat_loc,
      ~examples=["[%styled.div (~a, ~b) => {}]"],
      ~link=
        "https://reasonml.org/docs/manual/latest/function#labeled-arguments",
      "Dynamic components are defined with labeled arguments.",
    );
  };

  getArgs(expr, [firstArg]);
};

let styleVariableName = "styles";

let propsTypeDeclarations = (~loc, customProps) =>
  switch (makeProps(~loc, customProps).pstr_desc) {
  | Pstr_type(_, declarations) =>
    declarations
    |> List.map(declaration =>
         {
           ...declaration,
           ptype_kind: Ptype_abstract,
           ptype_manifest: None,
           ptype_attributes: [],
         }
       )
  | _ => failwith("makeProps must generate a type declaration")
  };

let reactElementType = (~loc) =>
  Helper.Typ.constr(
    ~loc,
    withLoc(Ldot(Lident("React"), "element"), ~loc),
    [],
  );

let typeDeclarationAsType = (~loc, declaration) => {
  let params =
    declaration.ptype_params |> List.map(_ => Builder.ptyp_any(~loc));
  Helper.Typ.constr(
    ~loc,
    withLoc(Lident(declaration.ptype_name.txt), ~loc),
    params,
  );
};

let makeValueDescription = (~loc, propsType) =>
  Helper.Sig.value({
    pval_name: withLoc("make", ~loc),
    pval_type:
      Helper.Typ.arrow(~loc, Nolabel, propsType, reactElementType(~loc)),
    pval_prim: [],
    pval_attributes: [],
    pval_loc: loc,
  });

let publicSignature = (~loc, customProps) => {
  let declarations = propsTypeDeclarations(~loc, customProps);
  let propsType =
    switch (declarations) {
    | [declaration, ..._] => typeDeclarationAsType(~loc, declaration)
    | [] => failwith("styled components always expose a props type")
    };

  Helper.Mty.signature(
    ~loc,
    [
      Helper.Sig.type_(~loc, Recursive, declarations),
      makeValueDescription(~loc, propsType),
    ],
  );
};

let constrainPublicApi = (~loc, ~customProps, moduleExpr) =>
  Settings.Get.native()
    ? Helper.Mod.constraint_(
        ~loc,
        moduleExpr,
        publicSignature(~loc, customProps),
      )
    : moduleExpr;

let staticComponentCodegenSteps = (~loc, ~htmlTag, stylesExpr) => {
  (
    Settings.Get.native()
      ? [makeProps(~loc, None), defineGetOrEmptyFn(~loc)]
      : [
          makeProps(~loc, None),
          defineMakePropsFn(~loc, ~makePropTypes=[], ~customProps=[]),
          bindingCreateVariadicElement(~loc),
          defineMakeStylesObject(~loc),
        ]
        @ defineGetterFns(~loc, ~makePropTypes=[], ~customProps=[])
        @ [
          defineGetOrEmptyFn(~loc),
          defineDeletePropFn(~loc),
          defineAssign2(~loc, ~makePropTypes=[]),
        ]
  )
  @ [styles(~loc, ~name=styleVariableName, ~expr=stylesExpr)]
  @ component(
      ~loc,
      ~htmlTag,
      ~className=[%expr styles],
      ~makePropTypes=[],
      ~labeledArguments=[],
    );
};

let staticComponent = (~loc, ~htmlTag, styles) => {
  Builder.pmod_structure(
    ~loc,
    staticComponentCodegenSteps(~loc, ~htmlTag, styles),
  )
  |> constrainPublicApi(~loc, ~customProps=None);
};

let validationErrorExpr = (~loc, ~source_position_start, ~description, errors) => {
  let error_messages =
    errors
    |> List.map(((error_loc, error)) => {
         let adjusted_loc =
           Styled_ppx_css_parser.Parser_location.to_file_location(
             ~source_position_start,
             error_loc,
           );
         (adjusted_loc, Css_validation.error_to_string(error));
       });
  switch (error_messages) {
  | [(loc, msg)] => Error.expr(~loc, msg)
  | _ => Error.expressions(~loc, ~description, error_messages)
  };
};

let stylesCall = (~loc, ~labeledArguments) => {
  /* native: (~arg1, ~arg2, ...) */
  /* client: (~arg1=props.arg1, ~arg2=props.arg2, ...) */
  let styledArguments =
    List.map(
      ((argumentName, _defaultValue, _, _, loc, _)) => {
        let value = propItem(~loc, getLabel(argumentName));
        (argumentName, value);
      },
      labeledArguments,
    );

  /* let styles = styles(...) */
  Builder.pexp_apply(
    ~loc,
    Builder.pexp_ident(
      ~loc,
      {
        txt: Lident(styleVariableName),
        loc,
      },
    ),
    /* Last argument is a unit to avoid the warning of optinal labeled args */
    styledArguments @ [(Nolabel, [%expr ()])],
  );
};

let customPropsFromLabeledArguments = (~loc, labeledArguments) => {
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

  (propsGenericParams, propGenericFields);
};

let hasUntypedDefault = labeledArguments =>
  labeledArguments
  |> List.exists(((_, defaultValue, _, _, _, type_)) =>
       Option.is_some(defaultValue) && Option.is_none(type_)
     );

let extractedDynamicStyles =
    (
      ~loc,
      ~file,
      ~scope,
      ~opens,
      ~moduleName,
      ~onClassNames,
      ~functionExpr,
      ~labeledArguments,
    ) => {
  let render_extracted_styles = (~loc, ~source_position_start, rule_list) => {
    switch (
      Css_validation.get_errors(
        Css_validation.type_check_rule_list(rule_list),
      )
    ) {
    | [] =>
      let (classNames, dynamic_vars) =
        Css_file.push(
          ~file,
          ~scope,
          ~opens,
          ~source_position_start,
          ~label=moduleName,
          rule_list,
        );
      onClassNames(classNames);
      Css_to_runtime.render_make_call(
        ~loc,
        ~marker=None,
        ~classNames,
        ~dynamic_vars,
      );
    | errors =>
      validationErrorExpr(
        ~loc,
        ~source_position_start,
        ~description="Multiple errors on styled component definition",
        errors,
      )
    };
  };

  let styles =
    switch (functionExpr.pexp_desc) {
    | Pexp_constant(Pconst_string(str, stringLoc, delimiter)) =>
      let source_position_start =
        Styled_ppx_css_parser.Parser_location.source_position_start(
          ~delimiter,
          stringLoc,
        );
      switch (
        Styled_ppx_css_parser.Driver.parse_declaration_list(
          ~source_position_start,
          str,
        )
      ) {
      | Ok(rule_list) =>
        render_extracted_styles(~loc=stringLoc, ~source_position_start, rule_list)
      | Error((loc, msg)) => Error.expr(~loc, msg)
      };
    | _ =>
      Error.raise(
        ~loc=functionExpr.pexp_loc,
        ~examples=["[%styled.div (~color) => \"color: $(color);\"]"],
        ~link="https://styled-ppx.vercel.app/reference/styled",
        "Extracted dynamic styled components require a CSS string body.",
      )
    };

  dynamicStylesDecl(
    ~loc,
    ~name=styleVariableName,
    ~args=labeledArguments,
    ~expr=styles,
  );
};

let dynamicExtractedComponent =
    (
      ~loc,
      ~file,
      ~scope,
      ~opens,
      ~htmlTag,
      ~label,
      ~moduleName,
      ~defaultValue,
      ~param,
      ~body,
      ~onClassNames,
    ) => {
  let (functionExpr, labeledArguments) =
    getLabeledArgs(label, defaultValue, param, body);
  let customProps =
    Some(customPropsFromLabeledArguments(~loc, labeledArguments));
  let (propsGenericParams, propGenericFields) =
    customPropsFromLabeledArguments(~loc, labeledArguments);
  let stylesDecl =
    extractedDynamicStyles(
      ~loc,
      ~file,
      ~scope,
      ~opens,
      ~moduleName,
      ~onClassNames,
      ~functionExpr,
      ~labeledArguments,
    );

  let implementation =
    Builder.pmod_structure(
      ~loc,
      (
        if (Settings.Get.native()) {
          [
            makeProps(~loc, customProps),
            defineGetOrEmptyFn(~loc),
            stylesDecl,
          ];
        } else {
          [
            makeProps(~loc, customProps),
            defineMakePropsFn(
              ~loc,
              ~makePropTypes=propsGenericParams,
              ~customProps=propGenericFields,
            ),
            bindingCreateVariadicElement(~loc),
            defineMakeStylesObject(~loc),
          ]
          @ defineGetterFns(
              ~loc,
              ~makePropTypes=propsGenericParams,
              ~customProps=propGenericFields,
            )
          @ [
            defineDeletePropFn(~loc),
            defineGetOrEmptyFn(~loc),
            defineAssign2(~loc, ~makePropTypes=propsGenericParams),
            stylesDecl,
          ];
        }
      )
      @ component(
          ~loc,
          ~htmlTag,
          ~className=stylesCall(~loc, ~labeledArguments),
          ~makePropTypes=propsGenericParams,
          ~labeledArguments,
        ),
    );

  hasUntypedDefault(labeledArguments)
    ? implementation : constrainPublicApi(~loc, ~customProps, implementation);
};
