open Migrate_parsetree;
open Ast_406;
open Asttypes;
open Parsetree;
open Ast_helper;

/*
/* Build an AST node representing all named args for the `external` definition for a component's props */
let rec recursivelyMakeNamedArgsForExternal = (list, args) =>
  switch (list) {
  | [(label, default, loc, interiorType), ...tl] =>
    recursivelyMakeNamedArgsForExternal(
      tl,
      Typ.arrow(
        ~loc,
        label,
        switch (label, interiorType, default) {
        /* ~foo=1 */
        | (label, None, Some(_)) => {
            ptyp_desc: Ptyp_var(safeTypeFromValue(label)),
            ptyp_loc: loc,
            ptyp_attributes: [],
          }
        /* ~foo: int=1 */
        | (label, Some(type_), Some(_)) => type_

        /* ~foo: option(int)=? */
        | (
            label,
            Some({
              ptyp_desc:
                [@implicit_arity]
                Ptyp_constr({txt: Lident("option")}, [type_]),
            }),
            _,
          )
        | (
            label,
            Some({
              ptyp_desc:
                [@implicit_arity]
                Ptyp_constr(
                  {
                    txt: [@implicit_arity] Ldot(Lident("*predef*"), "option"),
                  },
                  [type_],
                ),
            }),
            _,
          )
        /* ~foo: int=? - note this isnt valid. but we want to get a type error */
        | (label, Some(type_), _) when isOptional(label) => type_
        /* ~foo=? */
        | (label, None, _) when isOptional(label) => {
            ptyp_desc: Ptyp_var(safeTypeFromValue(label)),
            ptyp_loc: loc,
            ptyp_attributes: [],
          }

        /* ~foo */
        | (label, None, _) => {
            ptyp_desc: Ptyp_var(safeTypeFromValue(label)),
            ptyp_loc: loc,
            ptyp_attributes: [],
          }
        | (label, Some(type_), _) => type_
        },
        args,
      ),
    )
  | [] => args
  };

/* Build an AST node for the [@bs.obj] representing props for a component */
let makePropsValue = (fnName, loc, namedArgListWithKeyAndRef, propsType) => {
  let propsName = fnName ++ "Props";
  {
    pval_name: {
      txt: propsName,
      loc,
    },
    pval_type:
      recursivelyMakeNamedArgsForExternal(
        namedArgListWithKeyAndRef,
        Typ.arrow(
          nolabel,
          {
            ptyp_desc:
              [@implicit_arity] Ptyp_constr({txt: Lident("unit"), loc}, []),
            ptyp_loc: loc,
            ptyp_attributes: [],
          },
          propsType,
        ),
      ),
    pval_prim: [""],
    pval_attributes: [({txt: "bs.obj", loc}, PStr([]))],
    pval_loc: loc,
  };
};

/* Build an AST node representing an `external` with the definition of the [@bs.obj] */
let makePropsExternal = (fnName, loc, namedArgListWithKeyAndRef, propsType) => {
  pstr_loc: loc,
  pstr_desc:
    Pstr_primitive(
      makePropsValue(fnName, loc, namedArgListWithKeyAndRef, propsType),
    ),
};

/* Build an AST node for the signature of the `external` definition */
let makePropsExternalSig = (fnName, loc, namedArgListWithKeyAndRef, propsType) => {
  psig_loc: loc,
  psig_desc:
    Psig_value(
      makePropsValue(fnName, loc, namedArgListWithKeyAndRef, propsType),
    ),
};

/* Build an AST node for the props name when converted to a Js.t inside the function signature  */
let makePropsName = (~loc, name) => {
  ppat_desc: Ppat_var({txt: name, loc}),
  ppat_loc: loc,
  ppat_attributes: [],
};

let makeObjectField = (loc, (str, attrs, type_)) =>
  [@implicit_arity] Otag({loc, txt: str}, attrs, type_);

/* Build an AST node representing a "closed" Js.t object representing a component's props */
let makePropsType = (~loc, namedTypeList) =>
  Typ.mk(
    ~loc,
    [@implicit_arity]
    Ptyp_constr(
      {txt: [@implicit_arity] Ldot(Lident("Js"), "t"), loc},
      [
        {
          ptyp_desc:
            [@implicit_arity]
            Ptyp_object(
              List.map(makeObjectField(loc), namedTypeList),
              Closed,
            ),
          ptyp_loc: loc,
          ptyp_attributes: [],
        },
      ],
    ),
  );

/* Builds an AST node for the entire `external` definition of props */
let makeExternalDecl = (fnName, loc, namedArgListWithKeyAndRef, namedTypeList) =>
  makePropsExternal(
    fnName,
    loc,
    List.map(pluckLabelDefaultLocType, namedArgListWithKeyAndRef),
    makePropsType(~loc, namedTypeList),
  );












*/

/* switch (chidren) {
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

  let matchingExp = Exp.ident(~loc, {txt: Lident("children"), loc});

  Exp.match(~loc, matchingExp, [someChildCase, noneCase]);
};

let createJSX = (~loc, ~tag, args) => {
  Exp.apply(
    /* Create a function div() */
    ~loc,
    ~attrs=[({txt: "JSX", loc}, PStr([]))], /* Add [@JSX]*/
    Exp.ident({txt: Lident(tag), loc}),
    /* Arguments */
    [
      (
        Labelled("children"),
        Exp.construct(
          ~loc,
          {txt: Lident("::"), loc},
          Some(
            Exp.tuple(
              ~loc,
              [
                createSwitchChildren(~loc),
                Exp.construct(~loc, {txt: Lident("[]"), loc}, None),
              ],
            ),
          ),
        ),
      ),
      (
        /* Last arg is a unit */
        Nolabel,
        Exp.construct(~loc, {txt: Lident("()"), loc}, None),
      ),
      ...args,
    ],
  );
};

/* let make = (~children) => <div className=classNameValue> */
let createMakeFn = (~loc, ~styles, ~tag) =>
  Exp.fun_(
    ~loc,
    Optional("children"),
    None,
    Pat.mk(~loc, Ppat_var({txt: "children", loc})),
      createJSX(
        ~loc,
        ~tag,
        [
          (
            Labelled("className"),
            Exp.ident({txt: Lident(styles), loc}),
          ),
        ]
      )
    );


/* [@react.component] + createMakeFn */
let create = (~loc, ~tag, ~styles) =>
  Str.mk(
    ~loc,
    Pstr_value(
      Nonrecursive,
      [
        Vb.mk(
          ~loc,
          ~attrs=[({txt: "react.component", loc}, PStr([]))],
          Pat.mk(~loc, Ppat_var({txt: "make", loc})),
          createMakeFn(~loc, ~styles, ~tag),
        ),
      ],
    ),
  );
