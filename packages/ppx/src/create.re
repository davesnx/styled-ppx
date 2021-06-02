open Ppxlib;

module Helper = Ast_helper;
module Builder = Ppxlib.Ast_builder.Default;

let withLoc = (~loc, txt) => {
  { loc, txt }
};

/* fn(. ) */
let uncurried = (~loc) => {
  Builder.attribute(~name=withLoc(~loc, "bs"), ~loc, ~payload=PStr([]))
};

/* (~a, ~b, ~c, etc...) => args */
let rec fnWithLabeledArgs = (list, args) =>
  switch (list) {
  | [(label, default, pattern, _alias, loc, _inner), ...rest] =>
    fnWithLabeledArgs(
      rest,
      Helper.Exp.fun_(~loc, label, default, pattern, args),
    )
  | [] => args
  };

/* let styles = Emotion.(css(exp)) */
let styles = (~loc, ~name, ~expr) => {
  let variableName = Helper.Pat.mk(~loc, Ppat_var({txt: name, loc}));
  Helper.Str.mk(~loc, Pstr_value(Nonrecursive, [Helper.Vb.mk(~loc, variableName, expr)]));
};

/* let styles = (~arg1, ~arg2) => Emotion.(css(exp)) */
let dynamicStyles = (~loc, ~name, ~args, ~expr) => {
  let variableName = Helper.Pat.mk(~loc, Ppat_var({txt: name, loc}));

  Helper.Str.mk(
    ~loc,
    Pstr_value(
      Nonrecursive,
      [Helper.Vb.mk(~loc, variableName, fnWithLabeledArgs(args, expr))],
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
    pval_name: {
      txt: "createVariadicElement",
      loc,
    },
    pval_type:
      Helper.Typ.arrow(
        ~loc,
        Nolabel,
        Helper.Typ.constr(~loc, {txt: Lident("string"), loc}, []),
        Helper.Typ.arrow(
          ~loc,
          Nolabel,
          Helper.Typ.constr(
            ~loc,
            {txt: Ldot(Lident("Js"), "t"), loc},
            [Helper.Typ.object_(~loc, [], Open)],
          ),
          Helper.Typ.constr(
              ~loc,
              {txt: Ldot(Lident("React"), "element"), loc},
              [],
            ),
        ),
      ),
    pval_prim: ["createElement"],
    pval_attributes: [
      Helper.Attr.mk({txt: "bs.val", loc}, PStr([])),
      Helper.Attr.mk(
        {txt: "bs.module", loc},
        PStr([
          Helper.Str.mk(
            ~loc,
            Pstr_eval(
              Helper.Exp.constant(
                ~loc,
                ~attrs=[
                  Helper.Attr.mk({txt: "reason.raw_literal", loc}, PStr([])),
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

let applyIgnore = (~loc, expr) => {
  Helper.Exp.apply(
    ~loc,
    Helper.Exp.ident(~loc, {txt: Lident("ignore"), loc}),
    [(Nolabel, expr)]
  );
};

/* createVariadicElement("div", newProps) */
let variadicElement = (~loc, ~htmlTag) => {
  Helper.Exp.apply(
    ~loc,
    Helper.Exp.ident(~loc, {txt: Lident("createVariadicElement"), loc}),
    [
      (
        Nolabel,
        Helper.Exp.constant(
          ~loc,
          ~attrs=[
            Helper.Attr.mk(
              {txt: "reason.raw_literal", loc},
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
      (Nolabel, Helper.Exp.ident(~loc, {txt: Lident("newProps"), loc})),
    ],
  );
};

/* let stylesObject = {"className": styled}; */
let stylesObject = (~loc, ~value) =>
  Helper.Vb.mk(
    ~loc,
    Helper.Pat.mk(~loc, Ppat_var({txt: "stylesObject", loc})),
    Helper.Exp.extension(
      ~loc,
      (
        {txt: "bs.obj", loc},
        PStr([
          Helper.Str.mk(
            ~loc,
            Pstr_eval(
              Helper.Exp.record(
                ~loc,
                [ ({txt: Lident("className"), loc}, value) ],
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
  Helper.Exp.apply(
    ~loc,
    Helper.Exp.ident(~loc, {txt: Ldot(Lident("Obj"), "magic"), loc}),
    [(Nolabel, Helper.Exp.ident(~loc, {txt: Lident("props"), loc}))],
  );

/* let newProps = Js.Obj.assign(stylesObject, Obj.magic(props)); */
let newProps = (~loc) =>
  Helper.Vb.mk(
    ~loc,
    Helper.Pat.mk(~loc, Ppat_var({txt: "newProps", loc})),
    Helper.Exp.apply(
      ~loc,
      Helper.Exp.ident(
        ~loc,
        {txt: Ldot(Ldot(Lident("Js"), "Obj"), "assign"), loc},
      ),
      [
        (Nolabel, Helper.Exp.ident(~loc, {txt: Lident("stylesObject"), loc})),
        (Nolabel, objMagicProps(~loc)),
      ],
    ),
  );

/*
  let stylesObject = {"className": styles};
  let newProps = Js.Obj.assign(stylesObject, Obj.magic(props));
  createVariadicElement("div", newProps);
 */
let makeBody = (~loc, ~htmlTag, ~styledExpr) =>
  Helper.Exp.let_(
    ~loc,
    ~attrs=[Helper.Attr.mk({txt: "reason.preserve_braces", loc}, PStr([]))],
    Nonrecursive,
    [stylesObject(~loc, ~value=styledExpr)],
    Helper.Exp.let_(
      ~loc,
      Nonrecursive,
      [newProps(~loc)],
      variadicElement(~loc, ~htmlTag)
    ),
  );

/* props: makeProps */
let makeArguments = (~loc, ~params) => {
  Helper.Pat.constraint_(
    ~loc,
    Helper.Pat.mk(~loc, Ppat_var({txt: "props", loc})),
    Helper.Typ.constr(~loc, {txt: Lident("makeProps"), loc}, params),
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
          Helper.Pat.mk(~loc, Ppat_var({txt: "make", loc})),
          makeFn(~loc, ~htmlTag, ~styledExpr, ~params),
        ),
      ],
    ),
  );
};

/* [@bs.optional] */
let bsOptional = (~loc) => Helper.Attr.mk({txt: "bs.optional", loc}, PStr([]));

/* [@bs.optional] color: string */
let customPropLabel = (~loc, name, type_, isOptional) => {
  Helper.Type.field(~loc, ~attrs=(isOptional ? [bsOptional(~loc)] : []), {txt: name, loc}, type_);
}

let typeVariable = (~loc, name) => Builder.ptyp_var(~loc, name);

/* [@bs.optional] href: string */
let recordLabel = (~loc, name, kind, alias) =>
  {
    let bsAlias = (alias) => Helper.Attr.mk({txt: "bs.as", loc}, PStr([
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
      {txt: name, loc},
      Helper.Typ.constr(~loc, {txt: Lident(kind), loc}, []),
    )
  };

/* [@bs.optional] ref: domRef */
let domRefLabel = (~loc) =>
  Helper.Type.field(
    ~loc,
    ~attrs=[Helper.Attr.mk({txt: "bs.optional", loc}, PStr([]))],
    {txt: "ref", loc},
    Helper.Typ.constr(~loc, {txt: Ldot(Lident("ReactDOM"), "domRef"), loc}, []),
  );

/* [@bs.optional] children: React.element */
let childrenLabel = (~loc) =>
  Helper.Type.field(
    ~loc,
    ~attrs=[Helper.Attr.mk({txt: "bs.optional", loc}, PStr([]))],
    {txt: "children", loc},
    Helper.Typ.constr(~loc, {txt: Ldot(Lident("React"), "element"), loc}, []),
  );

/* [@bs.optional] onDragOver: ReactEvent.Mouse.t => unit */
let recordEventLabel = (~loc, name, kind) => {
  Helper.Type.field(
    ~loc,
    ~attrs=[Helper.Attr.mk({txt: "bs.optional", loc}, PStr([]))],
    {txt: name, loc},
    Helper.Typ.arrow(
      ~loc,
      Nolabel,
      Helper.Typ.constr(
        ~loc,
        {txt: Ldot(Ldot(Lident("ReactEvent"), kind), "t"), loc},
        [],
      ),
      Helper.Typ.constr(~loc, {txt: Lident("unit"), loc}, []),
    ),
  );
};

/* [@bs.deriving abstract] */
let bsDerivingAbstract = (~loc) =>
  Helper.Attr.mk(
    {txt: "bs.deriving", loc},
    PStr([
      Helper.Str.mk(
        ~loc,
        Pstr_eval(Helper.Exp.ident(~loc, {txt: Lident("abstract"), loc}), []),
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
        domRefLabel(~loc),
        childrenLabel(~loc),
        ...List.map(
             domProp =>
               switch (domProp) {
               | React.Event({name, type_}) =>
                 recordEventLabel(~loc, name, type_)
               | React.Attribute({name, type_, alias}) =>
                 recordLabel(~loc, name, type_, alias)
               },
             React.makePropList,
           ),
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
          {txt: "makeProps", loc},
        ),
      ],
    ),
  );
};
