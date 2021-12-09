open Ppxlib;

module Helper = Ast_helper;
module Builder = Ppxlib.Ast_builder.Default;

let withLoc = (~loc, txt) => { loc, txt };

/* fn(. ) */
let uncurried = (~loc) => {
  Builder.attribute(~name=withLoc(~loc, "bs"), ~loc, ~payload=PStr([]))
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
  Helper.Str.mk(~loc, Pstr_value(Nonrecursive, [Helper.Vb.mk(~loc, variableName, expr)]));
};

/* let styles = (~arg1, ~arg2) => Emotion.(css(exp)) */
let dynamicStyles = (~loc, ~name, ~args, ~expr) => {
  let variableName = Helper.Pat.mk(~loc, Ppat_var(withLoc(name, ~loc)));
  let ppatAnyArg = (Nolabel, None, Builder.ppat_any(~loc), "_", Location.none, None);
  /* Last argument needs to be ignored, since it's a unit to remove the warning of optional labelled arguments */
  let argsWithLastAny = [ppatAnyArg, ...args];

  Helper.Str.mk(
    ~loc,
    Pstr_value(
      Nonrecursive,
      [Helper.Vb.mk(~loc, variableName, fnWithLabeledArgs(argsWithLastAny, expr))],
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
                ~attrs=[
                  Helper.Attr.mk(withLoc("reason.raw_literal", ~loc), PStr([])),
                ],
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

/* ignore() */
let applyIgnore = (~loc, expr) => {
  Helper.Exp.apply(
    ~loc,
    Helper.Exp.ident(~loc, withLoc(Lident("ignore"), ~loc)),
    [(Nolabel, expr)]
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
                    Helper.Exp.constant(~loc, Pconst_string(htmlTag, loc, None)),
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

/* let stylesObject = {"className": styled}; */
let stylesAndRefObject = (~loc, ~value) =>
  {
    let className = (withLoc(~loc, Lident("className")), value);
    let refProp = (
      withLoc(~loc, Lident("ref")),
      Helper.Exp.apply(
        ~loc,
        Helper.Exp.ident(~loc, withLoc(Lident("innerRefGet"), ~loc)),
        [(Nolabel, Helper.Exp.ident(~loc, withLoc(Lident("props"), ~loc)))],
      )
      /* Helper.Exp.field(~loc,
        Helper.Exp.ident(~loc, withLoc(~loc, Lident("props"))),
        withLoc(~loc, Lident("innerRef"))
      ) */
    );
    let record = Helper.Exp.record(
      ~loc,
      [ className, refProp],
      None,
    );
    Helper.Vb.mk(
    ~loc,
    Helper.Pat.mk(~loc, Ppat_var(withLoc("stylesObject", ~loc))),
    Helper.Exp.extension(
      ~loc,
      (
        withLoc("bs.obj", ~loc),
        PStr([
          Helper.Str.mk(
            ~loc,
            Pstr_eval(
              record,
              [],
            ),
          ),
        ]),
      ),
    ),
  )};

/* Obj.magic(props) */
let objMagicProps = (~loc) =>
  Helper.Exp.apply(
    ~loc,
    Helper.Exp.ident(~loc, withLoc(Ldot(Lident("Obj"), "magic"), ~loc)),
    [(Nolabel, Helper.Exp.ident(~loc, withLoc(Lident("props"), ~loc)))],
  );

/* let newProps = Js.Obj.assign(stylesObject, Obj.magic(props)); */
let newProps = (~loc) =>
  Helper.Vb.mk(
    ~loc,
    Helper.Pat.mk(~loc, Ppat_var(withLoc("newProps", ~loc))),
    Helper.Exp.apply(
      ~loc,
      Helper.Exp.ident(
        ~loc,
        withLoc(Ldot(Ldot(Lident("Js"), "Obj"), "assign"), ~loc),
      ),
      [
        (Nolabel, Helper.Exp.ident(~loc, withLoc(Lident("stylesObject"), ~loc))),
        (Nolabel, objMagicProps(~loc)),
      ],
    ),
  );

/* deleteInnerRef(. newProps); */
let deleteInnerRefProp = (~loc) => {
  Helper.Exp.apply(
    ~loc,
    Helper.Exp.ident(~loc, withLoc(Lident("deleteInnerRef"), ~loc)),
    [(Nolabel, Helper.Exp.ident(~loc, withLoc(Lident("newProps"), ~loc)))]
  );
}

/*
  let stylesObject = {"className": styles};
  let newProps = Js.Obj.assign(stylesObject, Obj.magic(props));
  createVariadicElement("div", newProps);
 */
let makeBody = (~loc, ~htmlTag, ~styledExpr) =>
  Helper.Exp.let_(
    ~loc,
    ~attrs=[Helper.Attr.mk(withLoc("reason.preserve_braces", ~loc), PStr([]))],
    Nonrecursive,
    [stylesAndRefObject(~loc, ~value=styledExpr)],
    Helper.Exp.let_(
        ~loc,
        Nonrecursive,
        [newProps(~loc)],
        Helper.Exp.sequence(~loc, applyIgnore(~loc, deleteInnerRefProp(~loc)), variadicElement(~loc, ~htmlTag))
      ),
  );

/* props: makeProps */
let makeArguments = (~loc, ~params) => {
  Helper.Pat.constraint_(
    ~loc,
    Helper.Pat.mk(~loc, Ppat_var(withLoc("props", ~loc))),
    Helper.Typ.constr(~loc, withLoc(Lident("makeProps"), ~loc), params),
  );
};

/* let make = (props: makeProps) => + makeBody */
let makeFn = (~loc, ~htmlTag, ~styledExpr, ~params) =>
  Helper.Exp.fun_(
    ~loc,
    Nolabel,
    None,
    makeArguments(~loc, ~params),
    makeBody(~loc, ~htmlTag, ~styledExpr),
  );

/* [@react.component] + makeFn */
let component = (~loc, ~htmlTag, ~styledExpr, ~params) => {
  Helper.Str.mk(
    ~loc,
    Pstr_value(
      Nonrecursive,
      [
        Helper.Vb.mk(
          ~loc,
          Helper.Pat.mk(~loc, Ppat_var(withLoc("make", ~loc))),
          makeFn(~loc, ~htmlTag, ~styledExpr, ~params),
        ),
      ],
    ),
  );
};

/* [@bs.optional] */
let bsOptional = (~loc) => Helper.Attr.mk(withLoc("bs.optional", ~loc), PStr([]));

/* [@bs.optional] color: string */
let customPropLabel = (~loc, name, type_, isOptional) => {
  Helper.Type.field(~loc, ~attrs=(isOptional ? [bsOptional(~loc)] : []), withLoc(name, ~loc), type_);
};

let typeVariable = (~loc, name) => Builder.ptyp_var(~loc, name);

/* [@bs.optional] href: string */
let recordLabel = (~loc, name, kind, alias) =>
  {
    let bsAlias = (alias) => Helper.Attr.mk(withLoc("bs.as", ~loc), PStr([
        Helper.Str.mk(
          ~loc,
          Pstr_eval(
            Helper.Exp.constant(
              ~loc,
              ~attrs=[],
              Pconst_string(alias, loc, None),
            ),
            []
          ),
        ),
      ]));

    let attrs = switch (alias) {
      | Some(alias) => [bsOptional(~loc), bsAlias(alias)]
      | None => [bsOptional(~loc)]
    };

    Helper.Type.field(
      ~loc,
      ~attrs,
      withLoc(name, ~loc),
      Helper.Typ.constr(~loc, withLoc(kind, ~loc), []),
    )
  };

/* [@bs.optional] innerRef: domRef */
let domRefLabel = (~loc) =>
  Helper.Type.field(
    ~loc,
    ~attrs=[Helper.Attr.mk(withLoc("bs.optional", ~loc), PStr([]))],
    withLoc("innerRef", ~loc),
    Helper.Typ.constr(~loc, withLoc(Ldot(Lident("ReactDOM"), "domRef"), ~loc), []),
  );

/* [@bs.optional] children: React.element */
let childrenLabel = (~loc) =>
  Helper.Type.field(
    ~loc,
    ~attrs=[Helper.Attr.mk(withLoc("bs.optional", ~loc), PStr([]))],
    withLoc("children", ~loc),
    Helper.Typ.constr(~loc, withLoc(Ldot(Lident("React"), "element"), ~loc), []),
  );

/* [@bs.optional] onDragOver: ReactEvent.Mouse.t => unit */
let recordEventLabel = (~loc, name, kind) => {
  Helper.Type.field(
    ~loc,
    ~attrs=[Helper.Attr.mk(withLoc("bs.optional", ~loc), PStr([]))],
    withLoc(name, ~loc),
    Helper.Typ.arrow(
      ~loc,
      Nolabel,
      Helper.Typ.constr(
        ~loc,
        withLoc(kind, ~loc),
        [],
      ),
      Helper.Typ.constr(~loc, withLoc(Lident("unit"), ~loc), []),
    ),
  );
};

/* [@bs.deriving abstract] */
let bsDerivingAbstract = (~loc) =>
  Helper.Attr.mk(
    withLoc("bs.deriving", ~loc),
    PStr([
      Helper.Str.mk(
        ~loc,
        Pstr_eval(Helper.Exp.ident(~loc, withLoc(Lident("abstract"), ~loc)), []),
      ),
    ]),
  );

/* type makeProps = { ... } */
/* type makeProps('a, 'b) = { ... } */
let makeMakeProps = (~loc, ~customProps) => {
  let (params, dynamicProps) =
    switch (customProps) {
    | None => ([], [])
    | Some((params, props)) => (params, props)
    };

  let dynamicPropNames = dynamicProps |> List.map(d => d.pld_name.txt);

  let makeProps = MakeProps.get(dynamicPropNames)
    |> List.map(
      domProp =>
        switch (domProp) {
        | MakeProps.Event({name, type_}) =>
          recordEventLabel(~loc, name, MakeProps.eventTypeToIdent(type_))
        | MakeProps.Attribute({name, type_, alias}) =>
          recordLabel(~loc, name, MakeProps.attributeTypeToIdent(type_), alias)
        },
    );

  /*
     List of
        prop: type
        [@bs.optional]
   */
  let reactProps =
    List.append(
      [
        domRefLabel(~loc),
        childrenLabel(~loc),
        ...makeProps,
      ],
      dynamicProps,
    );

  let params = params |> List.map(type_ => (
    type_,
    (Asttypes.NoVariance, Asttypes.NoInjectivity))
    /* TODO: Made correct ast, not sure if it matter */
  );

  Helper.Str.mk(
    ~loc,
    Pstr_type(
      Recursive,
      [
        Helper.Type.mk(
          ~loc,
          ~priv=Public,
          ~attrs=[bsDerivingAbstract(~loc)],
          ~kind=Ptype_record(reactProps),
          ~params,
          withLoc("makeProps", ~loc),
        ),
      ],
    ),
  );
};

/* let deleteInnerRef = [%raw "(newProps) => delete newProps.innerRef"] */
let defineDeleteInnerRefFn = (~loc) => {
  let fnName = Helper.Pat.mk(~loc, Ppat_var(withLoc("deleteInnerRef", ~loc)));
  let rawDeleteKeyword = Helper.Exp.extension(
      ~loc,
      (
        withLoc("raw", ~loc),
        PStr([
          Helper.Str.mk(
            ~loc,
            Pstr_eval(
              Helper.Exp.constant(~loc, Pconst_string("(newProps) => delete newProps.innerRef", loc, None)),
              [],
            ),
          ),
        ]),
      ),
    );

  Helper.Str.mk(
    ~loc,
    Pstr_value(
      Nonrecursive,
      [Helper.Vb.mk(~loc, fnName, rawDeleteKeyword)],
    ),
  );
};
