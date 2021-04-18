open Ppxlib;
open Asttypes;
open Parsetree;
open Ast_helper;
open Longident;

module Ast_builder = Ppxlib.Ast_builder.Default;

/* (~a, ~b, ~c, etc...) => args */
let rec fnWithLabeledArgs = (list, args) =>
  switch (list) {
  | [(label, default, pattern, _alias, loc, _interiorType), ...rest] =>
    fnWithLabeledArgs(
      rest,
      Exp.fun_(~loc, label, default, pattern, args),
    )
  | [] => args
  };

/* let styles = Emotion.(css(exp)) */
let styles = (~loc, ~name, ~exp) => {
  let variableName = Pat.mk(~loc, Ppat_var({txt: name, loc}));
  Str.mk(~loc, Pstr_value(Nonrecursive, [Vb.mk(~loc, variableName, exp)]));
};

/* let styles = (~arg1, ~arg2) => Emotion.(css(exp)) */
let dynamicStyles = (~loc, ~name, ~args, ~exp) => {
  let variableName = Pat.mk(~loc, Ppat_var({txt: name, loc}));

  Str.mk(
    ~loc,
    Pstr_value(
      Nonrecursive,
      [Vb.mk(~loc, variableName, fnWithLabeledArgs(args, exp))],
    ),
  );
};

/*
   [@bs.val] [@bs.module "react"] external createVariadicElement:
   (string, Js.t({ .. })) => React.element =
   "createElement";
 */
let externalCreateVariadicElement = (~loc) => {
  Str.primitive({
    pval_loc: loc,
    pval_name: {
      txt: "createVariadicElement",
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
          Typ.constr(
              ~loc,
              {txt: Ldot(Lident("React"), "element"), loc},
              [],
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

/* div(~className=styles, ()) + switchChildren */
let variadicElement = (~loc, ~htmlTag) => {
  Exp.apply(
    ~loc,
    Exp.ident(~loc, {txt: Lident("createVariadicElement"), loc}),
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
                    Exp.constant(~loc, Pconst_string(htmlTag, loc, None)),
                    [],
                  ),
                ),
              ]),
            ),
          ],
          Pconst_string(htmlTag, loc, None),
        ),
      ),
      (Nolabel, Exp.ident(~loc, {txt: Lident("newProps"), loc})),
    ],
  );
};

/* let stylesObject = {"className": styled}; */
let stylesObject = (~loc, ~value) =>
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
  Exp.apply(
    ~loc,
    Exp.ident(~loc, {txt: Ldot(Lident("Obj"), "magic"), loc}),
    [(Nolabel, Exp.ident(~loc, {txt: Lident("props"), loc}))],
  );

/* let newProps = Js.Obj.assign(stylesObject, Obj.magic(props)); */
let newProps = (~loc) =>
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
let makeBody = (~loc, ~htmlTag, ~styledExpr) =>
  Exp.let_(
    ~loc,
    ~attrs=[Attr.mk({txt: "reason.preserve_braces", loc}, PStr([]))],
    Nonrecursive,
    [stylesObject(~loc, ~value=styledExpr)],
    Exp.let_(
      ~loc,
      Nonrecursive,
      [newProps(~loc)],
      variadicElement(~loc, ~htmlTag)
    ),
  );

/* props: makeProps */
let makeArguments = (~loc, ~params) => {
  Pat.constraint_(
    ~loc,
    Pat.mk(~loc, Ppat_var({txt: "props", loc})),
    Typ.constr(~loc, {txt: Lident("makeProps"), loc}, params),
  );
};

/* let make = (props: makeProps) => + makeBody */
let makeFn = (~loc, ~htmlTag, ~styledExpr, ~params) =>
  Exp.fun_(
    ~loc,
    Nolabel,
    None,
    makeArguments(~loc, ~params),
    makeBody(~loc, ~htmlTag, ~styledExpr),
  );

/* [@react.component] + makeFn */
let component = (~loc, ~htmlTag, ~styledExpr, ~params) => {
  let params = Option.value(~default=[], params);
  Str.mk(
    ~loc,
    Pstr_value(
      Nonrecursive,
      [
        Vb.mk(
          ~loc,
          Pat.mk(~loc, Ppat_var({txt: "make", loc})),
          makeFn(~loc, ~htmlTag, ~styledExpr, ~params),
        ),
      ],
    ),
  );
};

/* [@bs.optional] color: string */
let customPropLabel = (~loc, name, type_) =>
  Type.field(~loc, {txt: name, loc}, type_);

let typeVariable = (~loc, name) => Ast_builder.ptyp_var(~loc, name);

/* [@bs.optional] href: string */
let recordLabel = (~loc, name, kind, alias) =>
  {
    let bsOptional = Attr.mk({txt: "bs.optional", loc}, PStr([]));
    let bsAlias = (alias) => Attr.mk({txt: "bs.as", loc}, PStr([
        Str.mk(
          ~loc,
          Pstr_eval(
            Exp.constant(
              ~loc,
              ~attrs=[],
              Pconst_string(alias, loc, None),
            ),
            []
          ),
        ),
      ]));

    let attrs = switch (alias) {
      | Some(alias) => [bsOptional, bsAlias(alias)]
      | None => [bsOptional]
    };

    Type.field(
    ~loc,
    ~attrs,
    {txt: name, loc},
    Typ.constr(~loc, {txt: Lident(kind), loc}, []),
  )
  };

/* [@bs.optional] ref: domRef */
let domRefLabel = (~loc) =>
  Type.field(
    ~loc,
    ~attrs=[Attr.mk({txt: "bs.optional", loc}, PStr([]))],
    {txt: "ref", loc},
    Typ.constr(~loc, {txt: Ldot(Lident("ReactDOMRe"), "domRef"), loc}, []),
  );

/* [@bs.optional] children: React.element */
let childrenLabel = (~loc) =>
  Type.field(
    ~loc,
    ~attrs=[Attr.mk({txt: "bs.optional", loc}, PStr([]))],
    {txt: "children", loc},
    Typ.constr(~loc, {txt: Ldot(Lident("React"), "element"), loc}, []),
  );

/* [@bs.optional] onDragOver: ReactEvent.Mouse.t => unit */
let recordEventLabel = (~loc, name, kind) => {
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

let makeMakeProps = (~loc, ~customProps) => {
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
    (Ppxlib.Asttypes.NoVariance, Asttypes.NoInjectivity)) /* TODO: Made correct ast, not sure if it matter */
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
          ~params,
          {txt: "makeProps", loc},
        ),
      ],
    ),
  );
};