open Migrate_parsetree;
open Ast_406;
open Ast_mapper;
open Asttypes;
open Parsetree;
open Ast_helper;
open Longident;
open React_props;

let styleVariableName = "styles";

/* let styles = Emotion.(css(exp)) */
let createStyles = (loc, name, exp) => {
  let variableName = Pat.mk(~loc, Ppat_var({txt: name, loc}));
  Str.mk(~loc, Pstr_value(Nonrecursive, [Vb.mk(~loc, variableName, exp)]));
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
      [
        (Nolabel, Exp.ident(~loc, {txt: Lident("props"), loc}))
      ],
    );

  Exp.match(~loc, matchingExp, [someChildCase, noneCase]);
};

/* div(~className=styles, ~children, ()) + createSwitchChildren */
let createElement = (~loc, ~tag) => {
  Exp.apply(
    ~loc,
    Exp.ident(~loc, {txt: Lident("createElement"), loc}),
    /* Arguments */
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
      (
        Nolabel,
        Exp.apply(
          ~loc,
          Exp.ident(
            ~loc,
            {txt: Ldot(Ldot(Lident("Js"), "Obj"), "assign"), loc},
          ),
          [
            (Nolabel, Exp.ident(~loc, {txt: Lident("newProps"), loc})),
            (Nolabel, Exp.ident(~loc, {txt: Lident("stylesObject"), loc})),
          ],
        ),
      ),
      (
        Nolabel,
        Exp.array(
          ~loc,
          [
            createSwitchChildren(~loc),
            /* Exp.construct(~loc, {txt: Lident("[]"), loc}, None), */
          ],
        ),
      ),
    ],
  );
};

/* let stylesObject = {"className": styles}; */
let createStylesObject = (~loc, ~classNameValue) =>
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
              Exp.record(~loc, [
                ({ txt: Lident("className"), loc}, Exp.ident(~loc, {txt: Lident(classNameValue), loc})),
              ],
              None
              ),
              []
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

/* Js.Obj.empty() */
let jsObjEmpty = (~loc) =>
  Exp.apply(
    ~loc,
    Exp.ident(~loc, {txt: Ldot(Ldot(Lident("Js"), "Obj"), "empty"), loc}),
    [(Nolabel, Exp.construct(~loc, {txt: Lident("()"), loc}, None))],
  );

/* let newProps = Js.Obj.assign(Js.Obj.empty(), Obj.magic(props)); */
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
      [(Nolabel, jsObjEmpty(~loc)), (Nolabel, objMagicProps(~loc))],
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
let createMakeBody = (~loc, ~tag, ~classNameValue) =>
  /* Exp.sequence(
    ~loc,
    ~attrs=[({txt: "reason.preserve_braces", loc}, PStr([]))],
    createStylesObject(~loc, ~classNameValue),
    createNewProps(~loc),
    createElement(~loc, ~tag),
  ); */
  Exp.let_(
    ~loc,
    ~attrs=[({txt: "reason.preserve_braces", loc}, PStr([]))],
    Nonrecursive,
    [createStylesObject(~loc, ~classNameValue)],
    Exp.let_(~loc, Nonrecursive, [createNewProps(~loc)], createElement(~loc, ~tag))
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
let createMakeFn = (~loc, ~classNameValue, ~tag) =>
  Exp.fun_(
    ~loc,
    Nolabel,
    None,
    createMakeArguments(~loc),
    createMakeBody(~loc, ~tag, ~classNameValue),
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
          Pat.mk(~loc, Ppat_var({txt: "make", loc})),
          createMakeFn(~loc, ~classNameValue=styles, ~tag),
        ),
      ],
    ),
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

/*
   List of
      prop: type
      [@bs.optional]

   ref: domRef
   [@bs.optional]

   ...
 */
let createMakePropsLabels = (~loc) => {
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
  ];
};

let createMakeProps = (~loc) => {
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

  Str.mk(
    ~loc,
    Pstr_type(
      Recursive,
      [
        Type.mk(
          ~loc,
          ~priv=Public,
          ~attrs=[bsDerivingAbstract],
          ~kind=Ptype_record(createMakePropsLabels(~loc)),
          {txt: "makeProps", loc},
        ),
      ],
    ),
  );
};

/* module X = { createMakeProps + createReactBinding + createStyle + createReactComponent } */
let transformModule = (~loc, ~ast, ~tag) =>
  Mod.mk(
    Pmod_structure([
      createMakeProps(~loc),
      createReactBinding(~loc),
      createStyles(
        loc,
        styleVariableName,
        Css_to_emotion.render_declaration_list(ast),
      ),
      create(~loc, ~tag, ~styles=styleVariableName),
    ]),
  );

let moduleMapper = (_, _) => {
  ...default_mapper,
  /* We map all the modules */
  module_expr: (mapper, expr) =>
    switch (expr) {
    | {
        pmod_desc:
          /* that are defined with a ppx like [%txt] */
          Pmod_extension((
            {txt, _},
            PStr([
              {
                /* and contains a string as a payload */
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
      let tag =
        /* TODO: Improve splitting */
        switch (String.split_on_char('.', txt)) {
        | ["styled"] => "div"
        | ["styled", tag] => tag
        | _ => "div"
        };

      if (!List.exists(t => t === tag, HTML.tags)) {
        ();
          /* TODO: Add warning into an invalid html tag */
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

      transformModule(~loc, ~ast, ~tag);
    | _ => default_mapper.module_expr(mapper, expr)
    },
};

let () =
  Driver.register(~name="styled-ppx", Versions.ocaml_406, moduleMapper);
