module Builder = Ppxlib.Ast_builder.Default;

module Mapper = {
  open Ppxlib;

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
      Error.raise(
        ~loc,
        ~examples=["[%styled.div ...]"],
        ~link=
          "https://reasonml.org/docs/manual/latest/function#labeled-arguments",
        "This styled component is not valid. Doesn't have the right format.",
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

  let lid = name => {
    txt: Lident(name),
    loc: Location.none,
  };

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
        pmb_name: { loc: _, txt: Some(moduleName) } as name,
        pmb_attributes: _pmb_attributes,
        pmb_loc: moduleLoc,
        pmb_expr:
          {
            pmod_desc:
              Pmod_extension((
                { txt: extensionName, loc: extensionLoc },
                PStr([
                  {
                    pstr_desc:
                      Pstr_eval(
                        {
                          pexp_loc: _stringLoc,
                          pexp_desc:
                            Pexp_constant(
                              Pconst_string(str, stringLoc, delimiter),
                            ),
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
      let loc =
        Styled_ppx_css_parser.Parser_location.update_loc_with_delimiter(
          stringLoc,
          delimiter,
        );
      let styles =
        switch (
          Styled_ppx_css_parser.Driver.parse_declaration_list(~loc, str)
        ) {
        | Ok(declarations) =>
          declarations
          |> Css_to_runtime.render_declarations(~loc)
          |> Css_to_runtime.addLabel(~loc, moduleName)
          |> Builder.pexp_array(~loc)
          |> Css_to_runtime.render_style_call(~loc)
        | Error((loc, msg)) => Error.expr(~loc, msg)
        };

      Builder.pstr_module(
        ~loc=moduleLoc,
        Builder.module_binding(
          ~loc=moduleLoc,
          ~name,
          ~expr=Generate.staticComponent(~loc, ~htmlTag, styles),
        ),
      );
    /* [%styled.div [||]] */
    | Pstr_module({
        pmb_name: { loc: _, txt: Some(moduleName) } as name,
        pmb_attributes: _pmb_attributes,
        pmb_loc: moduleLoc,
        pmb_expr:
          {
            pmod_desc:
              Pmod_extension((
                { txt: extensionName, loc: extensionLoc },
                PStr([
                  {
                    pstr_desc:
                      Pstr_eval(
                        { pexp_loc: arrayLoc, pexp_desc: Pexp_array(arr), _ },
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
        |> Css_to_runtime.addLabel(~loc=arrayLoc, moduleName)
        |> Builder.pexp_array(~loc=arrayLoc)
        |> Css_to_runtime.render_style_call(~loc=arrayLoc);

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
        pmb_name: { loc: _, txt: Some(moduleName) } as name,
        pmb_attributes: _pmb_attributes,
        pmb_loc: moduleLoc,
        pmb_expr:
          {
            pmod_desc:
              Pmod_extension((
                { txt: extensionName, loc: extensionLoc },
                PStr([
                  {
                    pstr_desc:
                      Pstr_eval(
                        {
                          pexp_loc: functionLoc,
                          pexp_desc:
                            Pexp_function(
                              [
                                {
                                  pparam_desc:
                                    Pparam_val(fnLabel, defaultValue, param),
                                  _,
                                },
                              ],
                              _,
                              Pfunction_body(expression),
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
              { ppat_desc: Ppat_var({ loc: patternLoc, txt: valueName }), _ } as pat,
            pvb_expr:
              {
                pexp_desc:
                  Pexp_extension((
                    { txt: "cx", loc: _cxLoc },
                    PStr([
                      {
                        pstr_desc:
                          Pstr_eval(
                            {
                              pexp_loc: _payloadLoc,
                              pexp_desc:
                                Pexp_constant(
                                  Pconst_string(styles, stringLoc, delim),
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
      let loc =
        Styled_ppx_css_parser.Parser_location.update_loc_with_delimiter(
          stringLoc,
          delim,
        );
      let expr =
        switch (
          Styled_ppx_css_parser.Driver.parse_declaration_list(~loc, styles)
        ) {
        | Ok(declarations) =>
          declarations
          |> Css_to_runtime.render_declarations(~loc)
          |> Css_to_runtime.addLabel(~loc, valueName)
          |> Builder.pexp_array(~loc)
          |> Css_to_runtime.render_style_call(~loc)
        | Error((loc, msg)) => Error.expr(~loc, msg)
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
              { ppat_desc: Ppat_var({ loc: patternLoc, txt: valueName }), _ } as pat,
            pvb_expr:
              {
                pexp_desc:
                  Pexp_extension((
                    { txt: "cx", loc: _cxLoc },
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
        |> Css_to_runtime.addLabel(~loc=payloadLoc, valueName)
        |> Builder.pexp_array(~loc=payloadLoc)
        |> Css_to_runtime.render_style_call(~loc);

      Builder.pstr_value(
        ~loc,
        Nonrecursive,
        [Builder.value_binding(~loc=patternLoc, ~pat, ~expr)],
      );
    /* [%cx [] */
    | Pstr_value(
        Nonrecursive,
        [
          {
            pvb_pat: _pat,
            pvb_expr:
              {
                pexp_desc:
                  Pexp_extension((
                    { txt: "cx", loc: _cxLoc },
                    PStr([{ pstr_desc: Pstr_eval(payload, _), _ }]),
                  )),
                _,
              },
            pvb_loc: _,
            _,
          },
        ],
      ) =>
      let examples =
        switch (File.get()) {
        | Some(Reason) => [
            "[%cx \"display: block\"]",
            "[%cx [|CSS.display(`block)|]]",
          ]
        | Some(ReScript) => [
            "[%cx \"display: block\"]",
            "[%cx [CSS.display(#block)]]",
          ]
        | Some(OCaml) => [
            "[%cx \"display: block\"]",
            "[%cx [|CSS.display `block |]]",
          ]
        | None => [
            "[%cx \"display: block\"]",
            "[%cx [|CSS.display(`block)|]]",
          ]
        };
      Error.raise(
        ~loc=payload.pexp_loc,
        ~examples,
        ~link="https://styled-ppx.vercel.app/reference/cx",
        "[%cx] expects either a string of CSS or an array of CSS rules. ",
      );
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

/* let _ =
   Styled_ppx_css_parser.Driver.add_arg(
     Settings.jsxVersion.flag,
     Arg.Int(Settings.Update.jsxVersion),
     ~doc=Settings.jsxVersion.doc,
   ); */

let _ =
  Ppxlib.Driver.add_arg(
    Settings.native.flag,
    Arg.Unit(_ => Settings.Update.native(true)),
    ~doc=Settings.native.doc,
  );

let (version, mode) = Bsconfig.getJSX();

switch (version) {
| Some(version) =>
  Settings.Update.jsxVersion(version);
  Settings.Update.jsxMode(mode);
| None => ()
};

let any_payload_pattern = Ppxlib.Ast_pattern.(single_expr_payload(__));

let any_module_payload_pattern =
  Ppxlib.Ast_pattern.(pstr(pstr_eval(__, nil) ^:: nil));

let _ =
  Ppxlib.Driver.register_transformation(
    /* Instrument is needed to run styled-ppx after metaquote,
       we rely on this order in native tests */
    ~instrument=
      Ppxlib.Driver.Instrument.make(~position=Before, traverser#structure),
    ~rules=[
      /* %cx without let binding, it doesn't have CSS.label
         %cx is defined in traverser#structure */
      Ppxlib.Context_free.Rule.extension(
        Ppxlib.Extension.declare(
          "cx",
          Ppxlib.Extension.Context.Expression,
          any_payload_pattern,
          (~loc as _, ~path, payload) => {
            File.set(path);
            switch (payload.pexp_desc) {
            | Pexp_constant(Pconst_string(txt, stringLoc, delimiter)) =>
              let loc =
                Styled_ppx_css_parser.Parser_location.update_loc_with_delimiter(
                  stringLoc,
                  delimiter,
                );
              switch (
                Styled_ppx_css_parser.Driver.parse_declaration_list(~loc, txt)
              ) {
              | Ok(declarations) =>
                declarations
                |> Css_to_runtime.render_declarations(~loc)
                |> Builder.pexp_array(~loc)
                |> Css_to_runtime.render_style_call(~loc)
              | Error((loc, msg)) => Error.expr(~loc, msg)
              };
            | Pexp_array(arr) =>
              /* Valid: [%cx [|...|]] */
              arr
              |> Builder.pexp_array(~loc=payload.pexp_loc)
              |> Css_to_runtime.render_style_call(~loc=payload.pexp_loc)
            | _ =>
              let examples =
                switch (File.get()) {
                | Some(Reason) =>
                  Some([
                    "[%cx \"display: block; color: red\"]",
                    "[%cx [|CSS.display(`block), CSS.color(CSS.red)|]]",
                  ])
                | Some(ReScript) =>
                  Some([
                    "[%cx \"display: block; color: red\"]",
                    "[%cx [CSS.display(#block), CSS.color(#red)]]",
                  ])
                | Some(OCaml) =>
                  Some([
                    "[%cx \"display: block; color: red\"]",
                    "[%cx [|CSS.display `block, CSS.color CSS.red |]]",
                  ])
                | None => None
                };
              Error.raise(
                ~loc=payload.pexp_loc,
                ~examples?,
                ~link="https://styled-ppx.vercel.app/reference/cx",
                "[%cx] expects either a string of CSS or an array of CSS rules.",
              );
            };
          },
        ),
      ),
      Ppxlib.Context_free.Rule.extension(
        Ppxlib.Extension.declare(
          "css",
          Ppxlib.Extension.Context.Expression,
          any_payload_pattern,
          (~loc as _, ~path, payload) => {
            File.set(path);
            switch (payload.pexp_desc) {
            | Pexp_constant(Pconst_string(txt, stringLoc, delimiter)) =>
              let loc =
                Styled_ppx_css_parser.Parser_location.update_loc_with_delimiter(
                  stringLoc,
                  delimiter,
                );
              switch (
                Styled_ppx_css_parser.Driver.parse_declaration(~loc, txt)
              ) {
              | Ok(declarations) =>
                let declarationListValues =
                  Css_to_runtime.render_declaration(~loc, declarations);
                List.nth(declarationListValues, 0);
              | Error((loc, msg)) => Error.expr(~loc, msg)
              };
            /* TODO: Instead of getting the first element,
                 fail when there's more than one declaration or
               make a mechanism to flatten all the properties */
            | _ =>
              Error.expr(
                ~loc=payload.pexp_loc,
                ~examples=[
                  "[%css \"color: red\"]",
                  "[%css \"display: block\"]",
                ],
                ~link="https://styled-ppx.vercel.app/reference/css",
                "[%css] expects a string of CSS with a single rule (a property-value pair).",
              )
            };
          },
        ),
      ),
      Ppxlib.Context_free.Rule.extension(
        Ppxlib.Extension.declare(
          "styled.global",
          Ppxlib.Extension.Context.Expression,
          any_payload_pattern,
          (~loc as _, ~path, payload) => {
            File.set(path);
            switch (payload.pexp_desc) {
            | Pexp_constant(Pconst_string(txt, stringLoc, delimiter)) =>
              let loc =
                Styled_ppx_css_parser.Parser_location.update_loc_with_delimiter(
                  stringLoc,
                  delimiter,
                );
              switch (
                Styled_ppx_css_parser.Driver.parse_stylesheet(~loc, txt)
              ) {
              | Ok(stylesheets) =>
                Css_to_runtime.render_global(~loc, stylesheets)
              | Error((loc, msg)) => Error.expr(~loc, msg)
              };
            | _ =>
              Error.expr(
                ~loc=payload.pexp_loc,
                ~examples=[
                  "[%styled.global \"body { margin: 0; } .container { padding: 20px; }\"]",
                ],
                ~link="https://styled-ppx.vercel.app/reference/global",
                "[%styled.global] expects a string of CSS with selectors that apply to the whole document.",
              )
            };
          },
        ),
      ),
      Ppxlib.Context_free.Rule.extension(
        Ppxlib.Extension.declare(
          "keyframe",
          Ppxlib.Extension.Context.Expression,
          any_payload_pattern,
          (~loc as _, ~path, payload) => {
            File.set(path);
            switch (payload.pexp_desc) {
            | Pexp_constant(Pconst_string(txt, stringLoc, delimiter)) =>
              let loc =
                Styled_ppx_css_parser.Parser_location.update_loc_with_delimiter(
                  stringLoc,
                  delimiter,
                );
              switch (Styled_ppx_css_parser.Driver.parse_keyframes(~loc, txt)) {
              | Ok(declarations) =>
                Css_to_runtime.render_keyframes(~loc, declarations)
              | Error((loc, msg)) => Error.expr(~loc, msg)
              };
            | _ =>
              Error.raise(
                ~loc=payload.pexp_loc,
                ~examples=[
                  "[%keyframe \"0% { opacity: 0; } 100% { opacity: 1; }\"]",
                ],
                ~link="https://styled-ppx.vercel.app/reference/keyframe",
                "[%keyframe] expects a string of CSS with keyframe definitions.",
              )
            };
          },
        ),
      ),
      /* This extension just raises an error to educate, since before 0.20 this was valid */
      Ppxlib.Context_free.Rule.extension(
        Ppxlib.Extension.declare(
          "styled",
          Ppxlib.Extension.Context.Module_expr,
          any_module_payload_pattern,
          (~loc, ~path as _, _payload) => {
          Error.raise(
            ~loc,
            ~examples=["[%styled.div \"color: red\"]"],
            ~link=
              "https://developer.mozilla.org/en-US/docs/Learn/Accessibility/HTML",
            "An styled component without a tag is not valid. You must define an HTML tag, like, `styled.div`",
          )
        }),
      ),
    ],
    "styled-ppx",
  );
