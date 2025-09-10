open Ppxlib;

module Helper = Ast_helper;
module Builder = Ppxlib.Ast_builder.Default;

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
    ~attrs=[Platform_attributes.uncurried(~loc)],
    Helper.Exp.ident(~loc, withLoc(Lident("deleteProp"), ~loc)),
    [
      (Nolabel, Helper.Exp.ident(~loc, withLoc(Lident("newProps"), ~loc))),
      (Nolabel, Helper.Exp.constant(~loc, Pconst_string(key, loc, None))),
    ],
  )
  |> applyIgnore(~loc);
};

let asAttribute = () =>
  switch (File.get()) {
  | Some(ReScript) =>
    MakeProps.Attribute({
      name: "as",
      type_: String,
      alias: None,
    })
  | _ =>
    MakeProps.Attribute({
      name: "as_",
      type_: String,
      alias: Some("as"),
    })
  };

/*
 let asTag = props.as_;
 deleteProp(newProps, "as") |> ignore;
 createVariadicElement(finalHtmlTag, newProps)
 */
let variadicElement = (~loc, ~htmlTag) => {
  let asAttributeName =
    switch (asAttribute()) {
    | MakeProps.Attribute({name, _}) => name
    | _ => assert(false)
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

let makeParam =
    (
      ~loc,
      ~default: option(expression)=?,
      ~isOptional=false,
      ~wrapOption=isOptional,
      ~discard=false,
      ~coreType=?,
      label,
    ) => {
  let labelPattern =
    Helper.Pat.mk(
      ~loc,
      discard ? Ppat_any : Ppat_var(withLoc(label, ~loc)),
    );

  (
    isOptional ? Optional(label) : Labelled(label),
    default,
    switch (coreType) {
    | Some(typ) =>
      Helper.Pat.mk(
        ~loc,
        Ppat_constraint(
          labelPattern,
          wrapOption ? [%type: option([%t typ])] : typ,
        ),
      )
    | None => labelPattern
    },
    label,
    loc,
    None,
  );
};

let domPropParam = (~loc, ~isOptional, domProp) => {
  switch (domProp) {
  | MakeProps.Event({name, type_}) =>
    makeParam(
      ~loc,
      ~isOptional,
      ~coreType=
        Helper.Typ.arrow(
          ~loc,
          Nolabel,
          Helper.Typ.constr(
            ~loc,
            withLoc(~loc, MakeProps.eventTypeToIdent(type_)),
            [],
          ),
          Helper.Typ.constr(~loc, withLoc(Lident("unit"), ~loc), []),
        ),
      name,
    )
  | MakeProps.Attribute({name, type_, _}) =>
    makeParam(
      ~loc,
      ~isOptional,
      ~coreType=
        Helper.Typ.constr(
          ~loc,
          withLoc(~loc, MakeProps.attributeTypeToIdent(type_)),
          [],
        ),
      name,
    )
  };
};

let serverCreateElement = (~loc, ~htmlTag, ~variableNames) => {
  let finalHtmlTag =
    switch%expr ([%e Helper.Exp.ident(~loc, withLoc(~loc, Lident("as_")))]) {
    | Some(v) => v
    | None => [%e Builder.estring(~loc, htmlTag)]
    };

  let params =
    MakeProps.get(["key", "ref", "className"] @ variableNames)
    |> List.map(value =>
         switch (value) {
         | MakeProps.Event({name, _}) => name
         | MakeProps.Attribute({name, _}) => name
         }
       )
    |> List.map(label =>
         (
           Optional(label),
           Helper.Exp.ident(~loc, withLoc(~loc, Lident(label))),
         )
       );

  let domProps =
    Helper.Exp.apply(
      [%expr ReactDOM.domProps],
      [
        (Labelled("className"), [%expr className]),
        (Optional("ref"), [%expr innerRef]),
      ]
      @ params
      @ [(Nolabel, [%expr ()])],
    );

  [%expr React.createElement([%e finalHtmlTag], [%e domProps], [children])];
};

/* let stylesObject = { "className": className, "ref": props.ref }; */
let stylesAndRefObject = (~loc) => {
  let className = (
    withLoc(~loc, Lident("className")),
    Helper.Exp.ident(~loc, withLoc(Lident("className"), ~loc)),
  );
  let refProp = (withLoc(~loc, Lident("ref")), propItem(~loc, "innerRef"));
  let record = Helper.Exp.record(~loc, [className, refProp], None);
  Helper.Vb.mk(
    ~loc,
    Helper.Pat.mk(~loc, Ppat_var(withLoc("stylesObject", ~loc))),
    Platform_attributes.obj(~loc, record),
  );
};

/* let stylesObject = { "className": className, "style": snd(styles), "ref": props.ref }; */
let stylesAndRefObjectWithStyle = (~loc) => {
  let className = (
    withLoc(~loc, Lident("className")),
    Helper.Exp.ident(~loc, withLoc(Lident("className"), ~loc)),
  );
  let styleField = (withLoc(~loc, Lident("style")), [%expr snd(styles)]);
  let refProp = (withLoc(~loc, Lident("ref")), propItem(~loc, "innerRef"));
  let record =
    Helper.Exp.record(~loc, [className, styleField, refProp], None);
  Helper.Vb.mk(
    ~loc,
    Helper.Pat.mk(~loc, Ppat_var(withLoc("stylesObject", ~loc))),
    Platform_attributes.obj(~loc, record),
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

/*
  let className = styles ++ props.className;
  let newProps = Js.Obj.assign(stylesObject, Obj.magic(props));
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
    [className(~loc, classNameValue)],
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

/* styled2: same as makeBody but includes style prop from snd(styles) and uses fst(styles) for className */
let makeBodyStyled2 =
    (~loc, ~htmlTag, ~className as classNameValue, ~variables) => {
  let attrs = Platform_attributes.preserveBraces(~loc);
  let sequence =
    [deleteProp(~loc, "innerRef"), variadicElement(~loc, ~htmlTag)]
    |> List.append(List.map(deleteProp(~loc), variables));

  Helper.Exp.let_(
    ~loc,
    Nonrecursive,
    [className(~loc, classNameValue)],
    Helper.Exp.let_(
      ~loc,
      ~attrs,
      Nonrecursive,
      [stylesAndRefObjectWithStyle(~loc)],
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
    [className(~loc, classNameValue)],
    serverCreateElement(~loc, ~htmlTag, ~variableNames),
  );
};

let typeVariable = (~loc, name) => Builder.ptyp_var(~loc, name);

let getIsOptional = str =>
  switch (str) {
  | Optional(_) => true
  | _ => false
  };

let makeStyleParams = (~labeledArguments) => {
  labeledArguments
  |> List.map(((arg, defaultExpr, _, _, loc, type_)) => {
       let (kind, type_) =
         switch (type_) {
         | Some(type_) => (`Typed, type_)
         | None => (`Open, typeVariable(~loc, getLabel(arg)))
         };

       (loc, arg, defaultExpr, kind, type_);
     })
  |> List.map(((loc, arg, _, kind, type_)) => {
       makeParam(
         ~loc,
         ~isOptional=getIsOptional(arg),
         ~wrapOption=false,
         ~coreType=?
           switch (kind) {
           | `Open => None
           | `Typed => Some(type_)
           },
         getLabel(arg),
       )
     });
};

/* let make = (~key, ~innerRef, ~as_, ~children, ...reactDomParams, ()) => + makeBody */
let makeFnJSXServer =
    (~loc, ~htmlTag, ~className, ~styleParams, ~variableNames) => {
  fnWithLabeledArgs(
    {
      let reactDomParams =
        MakeProps.get(["key"] @ variableNames)
        |> List.map(domPropParam(~loc, ~isOptional=true));
      [
        (Nolabel, None, Builder.ppat_any(~loc), "_", Location.none, None),
        makeParam(
          ~loc,
          ~isOptional=true,
          ~discard=true,
          ~coreType=[%type: string],
          "key",
        ),
        makeParam(~loc, ~isOptional=true, "innerRef"),
        makeParam(~loc, ~isOptional=true, "as_"),
        makeParam(
          ~loc,
          ~isOptional=true,
          ~default=[%expr React.null],
          "children",
        ),
      ]
      @ reactDomParams
      @ styleParams;
    },
    makeBodyServer(
      ~loc,
      ~htmlTag,
      ~className=[%expr [%e className] ++ getOrEmpty(className)],
      ~variableNames,
    ),
  );
};

/* let make = (props: makeProps) => + makeBody */
let makeFnJSX3 = (~loc, ~htmlTag, ~className, ~makePropTypes, ~variableNames) => {
  let className = [%expr [%e className] ++ getOrEmpty(classNameGet(props))];

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

/* let make = (props: props) => + makeBody */
let makeFnJSX4 = (~loc, ~htmlTag, ~className, ~makePropTypes, ~variableNames) => {
  let className = [%expr [%e className] ++ getOrEmpty(props.className)];
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
    makeBody(~loc, ~htmlTag, ~className, ~variables=variableNames),
  );
};

/* styled2 server: include style field in dom props */
let serverCreateElementStyled2 = (~loc, ~htmlTag, ~variableNames) => {
  let finalHtmlTag =
    switch%expr ([%e Helper.Exp.ident(~loc, withLoc(~loc, Lident("as_")))]) {
    | Some(v) => v
    | None => [%e Builder.estring(~loc, htmlTag)]
    };

  let params =
    MakeProps.get(["key", "ref", "className"] @ variableNames)
    |> List.map(value =>
         switch (value) {
         | MakeProps.Event({name, _}) => name
         | MakeProps.Attribute({name, _}) => name
         }
       )
    |> List.map(label =>
         (
           Optional(label),
           Helper.Exp.ident(~loc, withLoc(~loc, Lident(label))),
         )
       );

  let domProps =
    Helper.Exp.apply(
      [%expr ReactDOM.domProps],
      [
        (Labelled("className"), [%expr className]),
        (Labelled("style"), [%expr snd(styles)]),
        (Optional("ref"), [%expr innerRef]),
      ]
      @ params
      @ [(Nolabel, [%expr ()])],
    );

  [%expr React.createElement([%e finalHtmlTag], [%e domProps], [children])];
};

let makeFnJSXServerStyled2 = (~loc, ~htmlTag, ~styleParams, ~variableNames) => {
  fnWithLabeledArgs(
    {
      let reactDomParams =
        MakeProps.get(["key"] @ variableNames)
        |> List.map(domPropParam(~loc, ~isOptional=true));
      [
        (Nolabel, None, Builder.ppat_any(~loc), "_", Location.none, None),
        makeParam(
          ~loc,
          ~isOptional=true,
          ~discard=true,
          ~coreType=[%type: string],
          "key",
        ),
        makeParam(~loc, ~isOptional=true, "innerRef"),
        makeParam(~loc, ~isOptional=true, "as_"),
        makeParam(
          ~loc,
          ~isOptional=true,
          ~default=[%expr React.null],
          "children",
        ),
      ]
      @ reactDomParams
      @ styleParams;
    },
    serverCreateElementStyled2(~loc, ~htmlTag, ~variableNames),
  );
};

/* styled2: className uses fst(styles) and style is merged via stylesObjectWithStyle */
let makeFnJSX3Styled2 =
    (~loc, ~htmlTag, ~className, ~makePropTypes, ~variableNames) => {
  let className = [%expr [%e className] ++ getOrEmpty(classNameGet(props))];

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
    makeBodyStyled2(~loc, ~htmlTag, ~className, ~variables=variableNames),
  );
};

let makeFnJSX4Styled2 =
    (~loc, ~htmlTag, ~className, ~makePropTypes, ~variableNames) => {
  let className = [%expr [%e className] ++ getOrEmpty(props.className)];
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
    makeBodyStyled2(~loc, ~htmlTag, ~className, ~variables=variableNames),
  );
};

let componentStyled2 =
    (~loc, ~htmlTag, ~className, ~makePropTypes, ~labeledArguments) => {
  let variableNames =
    List.map(((arg, _, _, _, _, _)) => getLabel(arg), labeledArguments);

  let makeFn =
    switch (File.get()) {
    | Some(ReScript) when Settings.Get.jsxVersion() === 4 =>
      makeFnJSX4Styled2(
        ~loc,
        ~htmlTag,
        ~className,
        ~makePropTypes,
        ~variableNames,
      )
    | Some(Reason)
    | Some(OCaml) when Settings.Get.native() =>
      makeFnJSXServerStyled2(
        ~loc,
        ~htmlTag,
        ~styleParams=makeStyleParams(~labeledArguments),
        ~variableNames,
      )
    | _ =>
      makeFnJSX3Styled2(
        ~loc,
        ~htmlTag,
        ~className,
        ~makePropTypes,
        ~variableNames,
      )
    };

  [%stri let make = [%e makeFn]];
};

/* moved styled2 static codegen below after makeProps/styleVariableName definitions */

/* [@react.component] + makeFn */
let component =
    (~loc, ~htmlTag, ~className, ~makePropTypes, ~labeledArguments) => {
  let variableNames =
    List.map(((arg, _, _, _, _, _)) => getLabel(arg), labeledArguments);

  let makeFn =
    switch (File.get()) {
    | Some(ReScript) when Settings.Get.jsxVersion() === 4 =>
      makeFnJSX4(~loc, ~htmlTag, ~className, ~makePropTypes, ~variableNames)
    | Some(Reason)
    | Some(OCaml) when Settings.Get.native() =>
      makeFnJSXServer(
        ~loc,
        ~htmlTag,
        ~className,
        ~styleParams=makeStyleParams(~labeledArguments),
        ~variableNames,
      )
    | _ =>
      makeFnJSX3(~loc, ~htmlTag, ~className, ~makePropTypes, ~variableNames)
    };

  [%stri let make = [%e makeFn]];
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

/* onDragOver: ReactEvent.Mouse.t => unit */
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
  | MakeProps.Event({name, type_}) =>
    recordEventLabel(
      ~loc,
      ~isOptional,
      name,
      MakeProps.eventTypeToIdent(type_),
    )
  | MakeProps.Attribute({name, type_, alias}) =>
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

let makePropsWithParams = (~loc, params, dynamicProps) => {
  let dynamicPropNames = dynamicProps |> List.map(d => d.pld_name.txt);

  let makeProps =
    MakeProps.get(dynamicPropNames)
    |> List.map(domPropLabel(~loc, ~isOptional=false));

  /* List of `prop: type` */
  let reactProps =
    List.append(
      [
        domRefLabel(~loc, ~isOptional=false),
        childrenLabel(~loc, ~isOptional=false),
        asLabel(~loc, ~isOptional=false),
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
          /* ~attrs=[Platform_attributes.optional(~loc)], */
          ~kind=Ptype_record(reactProps),
          ~params,
          withLoc("props", ~loc),
        ),
      ],
    ),
  );
};

let makePropsJSX4ReScript = (~loc, customProps) => {
  switch (customProps) {
  | Some((params, dynamicProps)) =>
    makePropsWithParams(~loc, params, dynamicProps)
  /* We would like to use [%stri type props = JsxDOM.domProps], but since
     we use innerRef wrapper, we can't. */
  | None => makePropsWithParams(~loc, [], [])
  };
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
    |> List.map(domPropLabel(~loc, ~isOptional=areAllFieldsOptional));

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
          ~attrs=[Platform_attributes.derivingAbstract(~loc)],
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
    makePropsJSX4ReScript(~loc, customProps)
  | Some(ReScript) =>
    makeMakeProps(~loc, ~areAllFieldsOptional=false, customProps)
  | Some(Reason)
  | _ => makeMakeProps(~loc, ~areAllFieldsOptional=true, customProps)
  };
};

/* [%mel.raw payload] */
let rawExtension = (~loc, payload) => {
  let ext_name =
    switch (File.get()) {
    | Some(ReScript) => "raw"
    | _ => "mel.raw"
    };

  Helper.Exp.extension(
    ~loc,
    (
      withLoc(~loc, ext_name),
      PStr([Helper.Str.eval(~loc, Builder.estring(~loc, payload))]),
    ),
  );
};

let defineDeletePropFn = (~loc) => {
  [%stri
    let deleteProp = [%e
      rawExtension(~loc, "(newProps, key) => delete newProps[key]")
    ]
  ];
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
    Error.raise(
      ~loc=pattern.ppat_loc,
      ~examples=["[%styled.div (~a, ~b) => {}]"],
      ~link=
        "https://reasonml.org/docs/manual/latest/function#labeled-arguments",
      "Dynamic components are defined with labeled arguments.",
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

let styleVariableName = "styles";

let staticComponentCodegenSteps = (~loc, ~htmlTag, stylesExpr) => {
  (
    Settings.Get.native()
      ? [defineGetOrEmptyFn(~loc)]
      : [
        makeProps(~loc, None),
        bindingCreateVariadicElement(~loc),
        defineGetOrEmptyFn(~loc),
        defineDeletePropFn(~loc),
        defineAssign2(~loc),
      ]
  )
  @ [
    styles(~loc, ~name=styleVariableName, ~expr=stylesExpr),
    component(
      ~loc,
      ~htmlTag,
      ~className=[%expr styles],
      ~makePropTypes=[],
      ~labeledArguments=[],
    ),
  ];
};

let staticComponent = (~loc, ~htmlTag, styles) => {
  Builder.pmod_structure(
    ~loc,
    staticComponentCodegenSteps(~loc, ~htmlTag, styles),
  );
};

/* styled2 static codegen (after deps are defined) */
let staticComponentCodegenStepsStyled2 = (~loc, ~htmlTag, stylesExpr) => {
  (
    Settings.Get.native()
      ? [defineGetOrEmptyFn(~loc)]
      : [
        makeProps(~loc, None),
        bindingCreateVariadicElement(~loc),
        defineGetOrEmptyFn(~loc),
        defineDeletePropFn(~loc),
        defineAssign2(~loc),
      ]
  )
  @ [
    styles(~loc, ~name=styleVariableName, ~expr=stylesExpr),
    componentStyled2(
      ~loc,
      ~htmlTag,
      ~className=[%expr fst(styles)],
      ~makePropTypes=[],
      ~labeledArguments=[],
    ),
  ];
};

let staticComponentStyled2 = (~loc, ~htmlTag, styles) => {
  Builder.pmod_structure(
    ~loc,
    staticComponentCodegenStepsStyled2(~loc, ~htmlTag, styles),
  );
};

let dynamicStyles = (~loc, ~moduleName, ~functionExpr, ~labeledArguments) => {
  let styles =
    switch (functionExpr.pexp_desc) {
    /* styled.div () => "string" */
    | Pexp_constant(Pconst_string(str, loc, delimiter)) =>
      switch (
        Styled_ppx_css_parser.Driver.parse_declaration_list(
          ~loc,
          ~delimiter,
          str,
        )
      ) {
      | Ok(declarations) =>
        declarations
        |> Css_runtime.render_declarations(~loc)
        |> Css_runtime.add_label(~loc, moduleName)
        |> Builder.pexp_array(~loc)
        |> Css_runtime.render_style_call(~loc)
      | Error((loc, msg)) => Error.expr(~loc, msg)
      }

    /* styled.div () => "[||]" */
    | Pexp_array(arr) =>
      arr
      |> List.rev
      |> Css_runtime.add_label(~loc, moduleName)
      |> Builder.pexp_array(~loc)
      |> Css_runtime.render_style_call(~loc)

    /* styled.div () => {
         ...
         ...
         ...
       } */
    | Pexp_sequence(expr, sequence) =>
      /* Generate a new sequence where the last expression is
         wrapped in render_style_call and render the other expressions. */
      let styles =
        sequence |> getLastSequence |> Css_runtime.render_style_call(~loc);
      Builder.pexp_sequence(~loc, expr, styles);

    /* styled.div () => {
         let styles = sharedStyles
         styles
       } */
    | Pexp_let(Nonrecursive, value_binding, expression) =>
      /* Generate a new `let in` where the last expression is
         wrapped in render_style_call */
      let styles =
        expression |> getLastExpression |> Css_runtime.render_style_call(~loc);
      Builder.pexp_let(~loc, Nonrecursive, value_binding, styles);

    /* styled.div () => { styles } */
    | Pexp_ident(ident) =>
      Builder.pexp_ident(~loc, ident) |> Css_runtime.render_style_call(~loc)
    /* TODO: With this default case we support all expressions here.
       Users might find this confusing, we could give some warnings before the type-checker does. */
    | _ => functionExpr
    };

  dynamicStyles(
    ~loc,
    ~name=styleVariableName,
    ~args=labeledArguments,
    ~expr=styles,
  );
};

let stylesCall = (~loc, ~labeledArguments) => {
  /* native: (~arg1, ~arg2, ...) */
  /* client: (~arg1=props.arg1, ~arg2=props.arg2, ...) */
  let styledArguments =
    List.map(
      ((argumentName, _defaultValue, _, _, loc, _)) => {
        let value =
          Settings.Get.native()
            ? Builder.pexp_ident(
                ~loc,
                withLoc(Lident(getLabel(argumentName)), ~loc),
              )
            : propItem(~loc, getLabel(argumentName));
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

let dynamicComponentCodegenSteps =
    (~loc, ~htmlTag, ~moduleName, ~functionExpr, ~labeledArguments) =>
  if (Settings.Get.native()) {
    [
      defineGetOrEmptyFn(~loc),
      dynamicStyles(~loc, ~moduleName, ~functionExpr, ~labeledArguments),
      component(
        ~loc,
        ~htmlTag,
        ~className=stylesCall(~loc, ~labeledArguments),
        ~makePropTypes=[],
        ~labeledArguments,
      ),
    ];
  } else {
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

    [
      makeProps(~loc, Some((propsGenericParams, propGenericFields))),
      bindingCreateVariadicElement(~loc),
      defineDeletePropFn(~loc),
      defineGetOrEmptyFn(~loc),
      defineAssign2(~loc),
      dynamicStyles(~loc, ~moduleName, ~functionExpr, ~labeledArguments),
      component(
        ~loc,
        ~htmlTag,
        ~className=stylesCall(~loc, ~labeledArguments),
        ~makePropTypes=propsGenericParams,
        ~labeledArguments,
      ),
    ];
  };

let dynamicComponent =
    (~loc, ~htmlTag, ~label, ~moduleName, ~defaultValue, ~param, ~body) => {
  let (functionExpr, labeledArguments) =
    getLabeledArgs(label, defaultValue, param, body);

  Builder.pmod_structure(
    ~loc,
    dynamicComponentCodegenSteps(
      ~loc,
      ~htmlTag,
      ~moduleName,
      ~functionExpr,
      ~labeledArguments,
    ),
  );
};
