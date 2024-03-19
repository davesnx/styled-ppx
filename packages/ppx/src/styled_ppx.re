module Builder = Ppxlib.Ast_builder.Default;

module Mapper = {
  open Ppxlib;
  let match = module_expr => {
    open Ast_pattern;

    let pattern =
      pmod_extension(
        extension(
          __',
          pstr(
            pstr_eval(
              map(
                ~f=
                  (catch, payload, _, delim) =>
                    catch(`String((payload, delim))),
                pexp_constant(pconst_string(__', __, __)),
              )
              ||| map(
                    ~f=(catch, payload) => catch(`Array(payload)),
                    pexp_array(__),
                  )
              ||| map(
                    ~f=
                      (catch, label, def, param, body) =>
                        catch(`Function((label, def, param, body))),
                    pexp_fun(__, __, __, __),
                  ),
              nil,
            )
            ^:: nil,
          ),
        ),
      );

    parse(
      pattern,
      module_expr.pmod_loc,
      /* TODO: Render a proper error here */
      ~on_error=_ => None,
      module_expr,
      (key, payload) => Some((key, payload)),
    );
  };

  let getHtmlTag = str => {
    switch (String.split_on_char('.', str)) {
    | ["styled", tag] => Some(tag)
    | _ => None
    };
  };

  let getHtmlTagUnsafe = (~loc, str) => {
    switch (getHtmlTag(str)) {
    | Some(tag) => tag
    | None =>
      Generate_lib.raiseError(
        ~loc,
        ~description=
          "This styled component is not valid. Doesn't have the right format.",
        ~example=Some("[%styled.div ...]"),
        ~link=
          "https://reasonml.org/docs/manual/latest/function#labeled-arguments",
      )
    };
  };

  let isStyled = name => {
    name |> getHtmlTag |> Option.is_some;
  };

  type contents =
    | Match(expression, list(case))
    | ListOf(expression)
    | EmptyList;

  let lid = name => {txt: Lident(name), loc: Location.none};

  let css = (className, contents) => {
    Ast_helper.(
      Exp.apply(
        Exp.ident(lid("style")),
        [
          (
            Nolabel,
            Exp.construct(
              lid("::"),
              Some(
                Exp.tuple([
                  Exp.apply(
                    Exp.ident(lid("label")),
                    [
                      (
                        Nolabel,
                        Exp.constant(
                          Pconst_string(className.txt, Location.none, None),
                        ),
                      ),
                    ],
                  ),
                  switch (contents) {
                  | Match(exp, cases) => Exp.match(exp, cases)
                  | ListOf(decls) => Exp.construct(lid("::"), Some(decls))
                  | EmptyList => Exp.construct(lid("[]"), None)
                  },
                ]),
              ),
            ),
          ),
        ],
      )
    );
  };

  let transform = expr => {
    switch (expr.pstr_desc) {
    /* module name = [%styled.div {||}] */
    | Pstr_module({
        pmb_name: {loc: _, txt: Some(moduleName)} as name,
        pmb_attributes: _pmb_attributes,
        pmb_loc: moduleLoc,
        pmb_expr:
          {
            pmod_desc:
              Pmod_extension((
                {txt: extensionName, loc: extensionLoc},
                PStr([
                  {
                    pstr_desc:
                      Pstr_eval(
                        {
                          pexp_loc: stringLoc,
                          pexp_desc:
                            Pexp_constant(Pconst_string(str, _loc, _label)),
                          _,
                        },
                        _attributes,
                      ),
                    pstr_loc: _,
                  },
                ]),
              )),
            _,
          },
      })
        when isStyled(extensionName) =>
      let htmlTag = getHtmlTagUnsafe(~loc=extensionLoc, extensionName);
      let styles =
        switch (
          Styled_ppx_css_parser.Driver.parse_declaration_list(
            ~loc=stringLoc,
            str,
          )
        ) {
        | Ok(declarations) =>
          declarations
          |> Css_to_emotion.render_declarations(~loc=stringLoc)
          |> Css_to_emotion.addLabel(~loc=stringLoc, moduleName)
          |> Builder.pexp_array(~loc=stringLoc)
          |> Css_to_emotion.render_style_call(~loc=stringLoc)
        | Error((loc, msg)) => Generate_lib.error(~loc, msg)
        };

      Builder.pstr_module(
        ~loc=moduleLoc,
        Builder.module_binding(
          ~loc=moduleLoc,
          ~name,
          ~expr=Generate.staticComponent(~loc=stringLoc, ~htmlTag, styles),
        ),
      );
    /* [%styled.div [||]] */
    | Pstr_module({
        pmb_name: {loc: _, txt: Some(moduleName)} as name,
        pmb_attributes: _pmb_attributes,
        pmb_loc: moduleLoc,
        pmb_expr:
          {
            pmod_desc:
              Pmod_extension((
                {txt: extensionName, loc: extensionLoc},
                PStr([
                  {
                    pstr_desc:
                      Pstr_eval(
                        {pexp_loc: arrayLoc, pexp_desc: Pexp_array(arr), _},
                        _,
                      ),
                    pstr_loc: _,
                  },
                ]),
              )),
            _,
          },
      })
        when isStyled(extensionName) =>
      let htmlTag = getHtmlTagUnsafe(~loc=extensionLoc, extensionName);
      let styles =
        arr
        |> Css_to_emotion.addLabel(~loc=arrayLoc, moduleName)
        |> Builder.pexp_array(~loc=arrayLoc)
        |> Css_to_emotion.render_style_call(~loc=arrayLoc);

      Builder.pstr_module(
        ~loc=moduleLoc,
        Builder.module_binding(
          ~loc=moduleLoc,
          ~name,
          ~expr=Generate.staticComponent(~loc=arrayLoc, ~htmlTag, styles),
        ),
      );
    /* [%styled.div () => {}] */
    | Pstr_module({
        pmb_name: {loc: _, txt: Some(moduleName)} as name,
        pmb_attributes: _pmb_attributes,
        pmb_loc: moduleLoc,
        pmb_expr:
          {
            pmod_desc:
              Pmod_extension((
                {txt: extensionName, loc: extensionLoc},
                PStr([
                  {
                    pstr_desc:
                      Pstr_eval(
                        {
                          pexp_loc: functionLoc,
                          pexp_desc:
                            Pexp_fun(
                              fnLabel,
                              defaultValue,
                              param,
                              expression,
                            ),
                          _,
                        },
                        _,
                      ),
                    pstr_loc: _,
                  },
                ]),
              )),
            _,
          },
      })
        when isStyled(extensionName) =>
      let htmlTag = getHtmlTagUnsafe(~loc=extensionLoc, extensionName);

      Builder.pstr_module(
        ~loc=moduleLoc,
        Builder.module_binding(
          ~loc=moduleLoc,
          ~name,
          ~expr=
            Generate.dynamicComponent(
              ~loc=functionLoc,
              ~htmlTag,
              ~label=fnLabel,
              ~moduleName,
              ~defaultValue,
              ~param,
              ~body=expression,
            ),
        ),
      );
    /* [%cx ""] */
    | Pstr_value(
        Nonrecursive,
        [
          {
            pvb_pat:
              {ppat_desc: Ppat_var({loc: patternLoc, txt: valueName}), _} as pat,
            pvb_expr:
              {
                pexp_desc:
                  Pexp_extension((
                    {txt: "cx", _},
                    PStr([
                      {
                        pstr_desc:
                          Pstr_eval(
                            {
                              pexp_loc: payloadLoc,
                              pexp_desc:
                                Pexp_constant(
                                  Pconst_string(styles, stringLoc, _),
                                ),
                              _,
                            },
                            _,
                          ),
                        _,
                      },
                    ]),
                  )),
                _,
              },
            pvb_loc: _,
            _,
          },
        ],
      ) =>
      let expr =
        switch (
          Styled_ppx_css_parser.Driver.parse_declaration_list(
            ~loc=stringLoc,
            styles,
          )
        ) {
        | Ok(declarations) =>
          declarations
          |> Css_to_emotion.render_declarations(~loc=stringLoc)
          |> Css_to_emotion.addLabel(~loc=stringLoc, valueName)
          |> Builder.pexp_array(~loc=payloadLoc)
          |> Css_to_emotion.render_style_call(~loc=stringLoc)
        | Error((loc, msg)) => Generate_lib.error(~loc, msg)
        };

      Builder.pstr_value(
        ~loc=expr.pexp_loc,
        Nonrecursive,
        [Builder.value_binding(~loc=patternLoc, ~pat, ~expr)],
      );
    /* [%cx [||]] */
    | Pstr_value(
        Nonrecursive,
        [
          {
            pvb_pat:
              {ppat_desc: Ppat_var({loc: patternLoc, txt: valueName}), _} as pat,
            pvb_expr:
              {
                pexp_desc:
                  Pexp_extension((
                    {txt: "cx", _},
                    PStr([
                      {
                        pstr_desc:
                          Pstr_eval(
                            {
                              pexp_loc: payloadLoc,
                              pexp_desc: Pexp_array(arr),
                              _,
                            },
                            _,
                          ),
                        _,
                      },
                    ]),
                  )),
                _,
              },
            pvb_loc: loc,
            _,
          },
        ],
      ) =>
      let expr =
        arr
        |> Css_to_emotion.addLabel(~loc=payloadLoc, valueName)
        |> Builder.pexp_array(~loc=payloadLoc)
        |> Css_to_emotion.render_style_call(~loc);

      Builder.pstr_value(
        ~loc,
        Nonrecursive,
        [Builder.value_binding(~loc=patternLoc, ~pat, ~expr)],
      );
    | Pstr_value(
        Nonrecursive,
        [
          {
            pvb_pat: {ppat_desc: Ppat_var(className)},
            pvb_expr:
              {
                pexp_desc:
                  Pexp_extension((
                    {txt: "style_label"},
                    PStr([
                      {
                        pstr_desc:
                          Pstr_eval(
                            {
                              pexp_desc:
                                Pexp_construct({txt: Lident("[]")}, None),
                            },
                            [],
                          ),
                      },
                    ]),
                  )),
              },
          },
        ],
      ) =>
      Ast_helper.(
        Str.value(
          Nonrecursive,
          [Vb.mk(Pat.var(className), css(className, EmptyList))],
        )
      )

    | Pstr_value(
        Nonrecursive,
        [
          {
            pvb_pat: {ppat_desc: Ppat_var(className)},
            pvb_expr:
              {
                pexp_desc:
                  Pexp_extension((
                    {txt: "style_label"},
                    PStr([
                      {
                        pstr_desc:
                          Pstr_eval(
                            {pexp_desc: Pexp_construct(_, Some(exp))},
                            [],
                          ),
                      },
                    ]),
                  )),
              },
          },
        ],
      ) =>
      Ast_helper.(
        Str.value(
          Nonrecursive,
          [Vb.mk(Pat.var(className), css(className, ListOf(exp)))],
        )
      )

    | Pstr_value(
        Nonrecursive,
        [
          {
            pvb_pat: {ppat_desc: Ppat_var(className)},
            pvb_expr:
              {
                pexp_desc:
                  Pexp_fun(
                    label,
                    optExp,
                    pat,
                    {
                      pexp_desc:
                        Pexp_extension((
                          {txt: "style_label"},
                          PStr([
                            {
                              pstr_desc:
                                Pstr_eval(
                                  {pexp_desc: Pexp_construct(_, Some(exp))},
                                  [],
                                ),
                            },
                          ]),
                        )),
                    },
                  ),
              },
          },
        ],
      ) =>
      Ast_helper.(
        Str.value(
          Nonrecursive,
          [
            Vb.mk(
              Pat.var(className),
              Exp.fun_(label, optExp, pat, css(className, ListOf(exp))),
            ),
          ],
        )
      )

    | Pstr_value(
        Nonrecursive,
        [
          {
            pvb_pat: {ppat_desc: Ppat_var(className)},
            pvb_expr:
              {
                pexp_desc:
                  Pexp_fun(
                    label1,
                    optExp1,
                    pat1,
                    {
                      pexp_desc:
                        Pexp_fun(
                          label2,
                          optExp2,
                          pat2,
                          {
                            pexp_desc:
                              Pexp_extension((
                                {txt: "style_label"},
                                PStr([
                                  {
                                    pstr_desc:
                                      Pstr_eval(
                                        {
                                          pexp_desc:
                                            Pexp_construct(_, Some(exp)),
                                        },
                                        [],
                                      ),
                                  },
                                ]),
                              )),
                          },
                        ),
                    },
                  ),
              },
          },
        ],
      ) =>
      Ast_helper.(
        Str.value(
          Nonrecursive,
          [
            Vb.mk(
              Pat.var(className),
              Exp.fun_(
                label1,
                optExp1,
                pat1,
                Exp.fun_(
                  label2,
                  optExp2,
                  pat2,
                  css(className, ListOf(exp)),
                ),
              ),
            ),
          ],
        )
      )

    | Pstr_value(
        Nonrecursive,
        [
          {
            pvb_pat: {ppat_desc: Ppat_var(className)},
            pvb_expr:
              {
                pexp_desc:
                  Pexp_fun(
                    label,
                    optExp,
                    pat,
                    {
                      pexp_desc:
                        Pexp_extension((
                          {txt: "style_label"},
                          PStr([
                            {
                              pstr_desc:
                                Pstr_eval(
                                  {pexp_desc: Pexp_match(exp, cases)},
                                  [],
                                ),
                            },
                          ]),
                        )),
                    },
                  ),
              },
          },
        ],
      ) =>
      Ast_helper.(
        Str.value(
          Nonrecursive,
          [
            Vb.mk(
              Pat.var(className),
              Exp.fun_(
                label,
                optExp,
                pat,
                css(className, Match(exp, cases)),
              ),
            ),
          ],
        )
      )

    | Pstr_value(
        Nonrecursive,
        [
          {
            pvb_pat: {ppat_desc: Ppat_var(className)},
            pvb_expr:
              {
                pexp_desc:
                  Pexp_fun(
                    label1,
                    optExp1,
                    pat1,
                    {
                      pexp_desc:
                        Pexp_fun(
                          label2,
                          optExp2,
                          pat2,
                          {
                            pexp_desc:
                              Pexp_extension((
                                {txt: "style_label"},
                                PStr([
                                  {
                                    pstr_desc:
                                      Pstr_eval(
                                        {pexp_desc: Pexp_match(exp, cases)},
                                        [],
                                      ),
                                  },
                                ]),
                              )),
                          },
                        ),
                    },
                  ),
              },
          },
        ],
      ) =>
      Ast_helper.(
        Str.value(
          Nonrecursive,
          [
            Vb.mk(
              Pat.var(className),
              Exp.fun_(
                label1,
                optExp1,
                pat1,
                Exp.fun_(
                  label2,
                  optExp2,
                  pat2,
                  css(className, Match(exp, cases)),
                ),
              ),
            ),
          ],
        )
      )

    | _ => expr
    };
  };
};

let traverser = {
  as _;
  inherit class Ppxlib.Ast_traverse.map as super;
  pub! structure_item = expr => {
    File.set(expr.pstr_loc.loc_start.pos_fname);
    let expr = super#structure_item(expr);
    Mapper.transform(expr);
  }
};

/* TODO: Throw better errors when this pattern doesn't match */
let static_pattern =
  Ppxlib.Ast_pattern.(
    pstr(
      pstr_eval(
        map(
          ~f=
            (capture, payload, _, delim) =>
              capture(`String((payload, delim))),
          pexp_constant(pconst_string(__', __, __)),
        )
        ||| map(
              ~f=(capture, payload) => capture(`Array(payload)),
              pexp_array(__),
            ),
        nil,
      )
      ^:: nil,
    )
  );

/* let _ =
   Styled_ppx_css_parser.Driver.add_arg(
     Settings.jsxVersion.flag,
     Arg.Int(Settings.Update.jsxVersion),
     ~doc=Settings.jsxVersion.doc,
   ); */

/* let _ =
   Styled_ppx_css_parser.Driver.add_arg(
     Settings.jsxMode.flag,
     Arg.String(value => Settings.Update.jsxMode(Some(value))),
     ~doc=Settings.jsxMode.doc,
   ); */

let (version, mode) = Bsconfig.getJSX();

switch (version) {
| Some(version) =>
  Settings.Update.jsxVersion(version);
  Settings.Update.jsxMode(mode);
| None => ()
};

let string_payload_pattern =
  Ppxlib.Ast_pattern.(single_expr_payload(estring(__)));

let any_payload_pattern = Ppxlib.Ast_pattern.(single_expr_payload(__));

let _ =
  Ppxlib.Driver.register_transformation(
    /* Instrument is needed to run styled-ppx after metaquote,
       we rely on this order in native tests */
    ~instrument=
      Ppxlib.Driver.Instrument.make(~position=Before, traverser#structure),
    ~rules=[
      /* %cx without let binding, it doesn't have CssJs.label
         %cx is defined in traverser#structure */
      Ppxlib.Context_free.Rule.extension(
        Ppxlib.Extension.declare(
          "cx",
          Ppxlib.Extension.Context.Expression,
          static_pattern,
          (~loc, ~path, payload) => {
            File.set(path);
            switch (payload) {
            | `String({loc, txt}, _delim) =>
              switch (
                Styled_ppx_css_parser.Driver.parse_declaration_list(~loc, txt)
              ) {
              | Ok(declarations) =>
                declarations
                |> Css_to_emotion.render_declarations(~loc)
                |> Builder.pexp_array(~loc)
                |> Css_to_emotion.render_style_call(~loc)
              | Error((loc, msg)) => Generate_lib.error(~loc, msg)
              }
            | `Array(arr) =>
              arr
              |> Builder.pexp_array(~loc)
              |> Css_to_emotion.render_style_call(~loc)
            };
          },
        ),
      ),
      Ppxlib.Context_free.Rule.extension(
        Ppxlib.Extension.declare(
          "css",
          Ppxlib.Extension.Context.Expression,
          string_payload_pattern,
          (~loc, ~path, payload) => {
            File.set(path);
            switch (
              Styled_ppx_css_parser.Driver.parse_declaration(~loc, payload)
            ) {
            | Ok(declarations) =>
              let declarationListValues =
                Css_to_emotion.render_declaration(~loc, declarations);
              List.nth(declarationListValues, 0);
            | Error((loc, msg)) => Generate_lib.error(~loc, msg)
            };
            /* TODO: Instead of getting the first element,
                 fail when there's more than one declaration or
               make a mechanism to flatten all the properties */
          },
        ),
      ),
      Ppxlib.Context_free.Rule.extension(
        Ppxlib.Extension.declare(
          "styled.global",
          Ppxlib.Extension.Context.Expression,
          string_payload_pattern,
          (~loc, ~path, payload) => {
            File.set(path);
            switch (
              Styled_ppx_css_parser.Driver.parse_stylesheet(~loc, payload)
            ) {
            | Ok(stylesheets) =>
              Css_to_emotion.render_global(~loc, stylesheets)
            | Error((loc, msg)) => Generate_lib.error(~loc, msg)
            };
          },
        ),
      ),
      Ppxlib.Context_free.Rule.extension(
        Ppxlib.Extension.declare(
          "keyframe",
          Ppxlib.Extension.Context.Expression,
          string_payload_pattern,
          (~loc, ~path, payload) => {
            File.set(path);
            switch (
              Styled_ppx_css_parser.Driver.parse_keyframes(~loc, payload)
            ) {
            | Ok(declarations) =>
              Css_to_emotion.render_keyframes(~loc, declarations)
            | Error((loc, msg)) => Generate_lib.error(~loc, msg)
            };
          },
        ),
      ),
      /* This extension just raises an error to educate, since before 0.20 this was valid */
      Ppxlib.Context_free.Rule.extension(
        Ppxlib.Extension.declare(
          "styled",
          Ppxlib.Extension.Context.Module_expr,
          any_payload_pattern,
          (~loc, ~path as _, payload) => {
          Generate_lib.raiseError(
            ~loc,
            ~description=
              "An styled component without a tag is not valid. You must define an HTML tag, like, `styled.div`",
            ~example=
              Some(
                "[%styled.div "
                ++ Ppxlib.Pprintast.string_of_expression(payload)
                ++ "]",
              ),
            ~link=
              "https://developer.mozilla.org/en-US/docs/Learn/Accessibility/HTML",
          )
        }),
      ),
    ],
    "styled-ppx",
  );
