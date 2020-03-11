open Migrate_parsetree;
open Ast_406;
open Ast_mapper;
open Asttypes;
open Parsetree;
open Ast_helper;
open Longident;

let htmlTags = [
  "a",
  "abbr",
  "acronym",
  "address",
  "applet",
  "area",
  "article",
  "aside",
  "audio",
  "b",
  "base",
  "basefont",
  "bb",
  "bdo",
  "big",
  "blockquote",
  "body",
  "br",
  "button",
  "canvas",
  "caption",
  "center",
  "cite",
  "code",
  "col",
  "colgroup",
  "command",
  "datagrid",
  "datalist",
  "dd",
  "del",
  "details",
  "dfn",
  "dialog",
  "dir",
  "div",
  "dl",
  "dt",
  "em",
  "embed",
  "eventsource",
  "fieldset",
  "figcaption",
  "figure",
  "font",
  "footer",
  "form",
  "frame",
  "frameset",
  "h1",
  "h2",
  "h3",
  "h4",
  "h5",
  "h6",
  "head",
  "header",
  "hgroup",
  "hr",
  "html",
  "i",
  "iframe",
  "img",
  "input",
  "ins",
  "isindex",
  "kbd",
  "keygen",
  "label",
  "legend",
  "li",
  "link",
  "map",
  "mark",
  "menu",
  "meta",
  "meter",
  "nav",
  "noframes",
  "noscript",
  "object",
  "ol",
  "optgroup",
  "option",
  "output",
  "p",
  "param",
  "pre",
  "progress",
  "q",
  "rp",
  "rt",
  "ruby",
  "s",
  "samp",
  "script",
  "section",
  "select",
  "small",
  "source",
  "span",
  "strike",
  "strong",
  "style",
  "sub",
  "sup",
  "table",
  "tbody",
  "td",
  "textarea",
  "tfoot",
  "th",
  "thead",
  "time",
  "title",
  "tr",
  "track",
  "tt",
  "u",
  "ul",
  "var",
  "video",
  "wbr",
];

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

/* let make = (~children) => <div className=classNameValue> */
let createMakeFn = (~loc, ~classNameValue, ~tag) =>
  Exp.fun_(
    ~loc,
    Optional("children"),
    None,
    Pat.mk(~loc, Ppat_var({txt: "children", loc})),
    Exp.apply(
      /* Create a function div() */
      ~loc,
      ~attrs=[({txt: "JSX", loc}, PStr([]))], /* Add [@JSX]*/
      Exp.ident({txt: Lident(tag), loc}),
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
let createReactComponent = (~loc, ~tag) =>
  Str.mk(
    ~loc,
    Pstr_value(
      Nonrecursive,
      [
        Vb.mk(
          ~loc,
          ~attrs=[({txt: "react.component", loc}, PStr([]))],
          Pat.mk(~loc, Ppat_var({txt: "make", loc})),
          createMakeFn(~loc, ~classNameValue=styleVariableName, ~tag),
        ),
      ],
    ),
  );

/* module X = { createStyle + createReactComponent } */
let transformModule = (~loc, ~ast, ~tag) =>
  Mod.mk(
    Pmod_structure([
      createStyles(
        loc,
        styleVariableName,
        Css_to_emotion.render_declaration_list(ast),
      ),
      createReactComponent(~loc, ~tag),
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

      transformModule(~loc, ~ast, ~tag="div");
    | {
        pmod_desc:
          /* that are defined with the ppx [%styled] */
          Pmod_extension((
            {txt: "styled.div", _},
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

      transformModule(~loc, ~ast, ~tag="div");
    | _ => default_mapper.module_expr(mapper, expr)
    },
};

let () =
  Driver.register(~name="styled-ppx", Versions.ocaml_406, moduleMapper);
