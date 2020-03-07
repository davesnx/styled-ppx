open Migrate_parsetree;
open Ast_406;
open Ast_mapper;
open Asttypes;
open Parsetree;
open Ast_helper;
open Longident;

let styleVariableName = "styled";

/* let styles = Emotion.(css(exp)) */
let createStyles = (loc, name, exp) => {
  let variableName = {
    ppat_desc: Ppat_var({txt: name, loc}),
    ppat_loc: loc,
    ppat_attributes: [],
  };

  Str.mk(~loc, Pstr_value(Nonrecursive, [Vb.mk(~loc, variableName, exp)]));
};

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
        ~attrs=[({txt: "explicit_arity", loc}, PStr([]))], /* Add [@explicit_arity]*/
        Ppat_construct(
          {txt: Lident("Some"), loc},
          Some(
            Pat.mk(
              ~loc,
              Ppat_tuple(
                [
                  Pat.mk(~loc, Ppat_var({txt: "chil", loc}))
                ],
              ),
            ),
          ),
        ),
      ),
      Exp.ident(~loc, {txt: Lident("chil"), loc}),
    );

  let matchingExp = Exp.ident(~loc, { txt: Lident("children"), loc });

  Exp.match(~loc, matchingExp, [someChildCase, noneCase]);
};

/* let make = (~children) => <div className=classNameValue> */
let createMakeFn = (~loc, ~classNameValue) =>
  Exp.fun_(
    ~loc,
    Optional("children"),
    None,
    Pat.mk(~loc, Ppat_var({txt: "children", loc})),
    Exp.apply(
      /* Create a function div() */
      ~loc,
      ~attrs=[({txt: "JSX", loc}, PStr([]))], /* Add [@JSX]*/
      Exp.ident({txt: Lident("div"), loc}),
      [
        /* Arguments */
        (
          Labelled("className"),
          Exp.ident({txt: Lident(classNameValue), loc}),
        ),
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
      ],
    ),
  );

/* [@react.component] + createMakeFn */
let createReactComponent = (~loc) =>
  Str.mk(
    ~loc,
    Pstr_value(
      Nonrecursive,
      [
        Vb.mk(
          ~loc,
          ~attrs=[({txt: "react.component", loc}, PStr([]))],
          Pat.mk(~loc, Ppat_var({txt: "make", loc})),
          createMakeFn(~loc, ~classNameValue=styleVariableName),
        ),
      ],
    ),
  );

/* module X = { createStyle + createReactComponent } */
let createModule = (~loc, ~ast) =>
  Mod.mk(
    Pmod_structure([
      createStyles(
        loc,
        styleVariableName,
        Css_to_emotion.render_declaration_list(ast),
      ),
      createReactComponent(~loc),
    ]),
  );

let moduleMapper = (_, _) => {
  ...default_mapper,
  /* We map all the modules */
  module_expr: (mapper, expr) =>
    switch (expr) {
    | {
        pmod_desc:
          /* that are defined with the ppx [%styled] */
          Pmod_extension((
            {txt: "styled", _},
            PStr([
              {
                /* and contains a string */
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

      createModule(~loc, ~ast);
    | _ => default_mapper.module_expr(mapper, expr)
    },
};

let () =
  Driver.register(~name="styled-ppx", Versions.ocaml_406, moduleMapper);
