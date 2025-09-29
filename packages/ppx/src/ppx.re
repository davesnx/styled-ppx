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

  let getHtmlTag2 = str => {
    switch (String.split_on_char('.', str)) {
    | ["styled2", tag] => Some(tag)
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
        ~link="https://styled-ppx.vercel.app/reference/styled-components",
        "This styled component is not valid. Doesn't have the right format.",
      )
    };
  };

  let isStyled = name => {
    name |> getHtmlTag |> Option.is_some;
  };

  let isStyled2 = name => {
    name |> getHtmlTag2 |> Option.is_some;
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
    /* module Name = [%styled.div {||}] */
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
      let styles =
        switch (Styled_ppx_css_parser.Driver.parse_declaration_list(str)) {
        | Ok(declarations) =>
          declarations
          |> Css_runtime.render_declarations(~loc=stringLoc)
          |> Css_runtime.add_label(~loc=stringLoc, moduleName)
          |> Builder.pexp_array(~loc=stringLoc)
          |> Css_runtime.render_style_call(~loc=stringLoc)
        | Error((start_pos, end_pos, msg)) =>
          let loc =
            Styled_ppx_css_parser.Parser_location.make_loc_from_pos(
              ~loc=stringLoc,
              ~delimiter,
              start_pos,
              end_pos,
            );
          Error.expr(~loc, msg);
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
        |> Css_runtime.add_label(~loc=arrayLoc, moduleName)
        |> Builder.pexp_array(~loc=arrayLoc)
        |> Css_runtime.render_style_call(~loc=arrayLoc);

      Builder.pstr_module(
        ~loc=moduleLoc,
        Builder.module_binding(
          ~loc=moduleLoc,
          ~name,
          ~expr=Generate.staticComponent(~loc=arrayLoc, ~htmlTag, styles),
        ),
      );
    /* module Name = [%styled2.div {||}] */
    | Pstr_module({
        pmb_name: {loc: _, txt: Some(_moduleName)} as name,
        pmb_attributes: _pmb_attributes,
        pmb_loc: moduleLoc,
        pmb_expr:
          {
            pmod_desc:
              Pmod_extension((
                {txt: extensionName, loc: _extensionLoc},
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
        when isStyled2(extensionName) =>
      let htmlTag =
        switch (getHtmlTag2(extensionName)) {
        | Some(tag) => tag
        | None => "div"
        };
      let stylesExpr =
        switch (Styled_ppx_css_parser.Driver.parse_declaration_list(str)) {
        | Ok(rule_list) =>
          let (classNames, dynamic_vars) = Css_file.push(rule_list);
          Css_runtime.render_make_call(
            ~loc=stringLoc,
            ~classNames,
            ~dynamic_vars,
          );
        | Error((start_pos, end_pos, msg)) =>
          let loc =
            Styled_ppx_css_parser.Parser_location.make_loc_from_pos(
              ~loc=stringLoc,
              ~delimiter,
              start_pos,
              end_pos,
            );
          Error.expr(~loc, msg);
        };

      Builder.pstr_module(
        ~loc=moduleLoc,
        Builder.module_binding(
          ~loc=moduleLoc,
          ~name,
          ~expr=
            Generate.staticComponentStyled2(
              ~loc=stringLoc,
              ~htmlTag,
              stylesExpr,
            ),
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
                    {txt: "cx", loc: _cxLoc},
                    PStr([
                      {
                        pstr_desc:
                          Pstr_eval(
                            {
                              pexp_loc: _payloadLoc,
                              pexp_desc:
                                Pexp_constant(
                                  Pconst_string(styles, stringLoc, delimiter),
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
        switch (Styled_ppx_css_parser.Driver.parse_declaration_list(styles)) {
        | Ok(rule_list) =>
          rule_list
          |> Css_runtime.render_declarations(~loc=stringLoc)
          |> Css_runtime.add_label(~loc=stringLoc, valueName)
          |> Builder.pexp_array(~loc=stringLoc)
          |> Css_runtime.render_style_call(~loc=stringLoc)
        | Error((start_pos, end_pos, msg)) =>
          let loc =
            Styled_ppx_css_parser.Parser_location.make_loc_from_pos(
              ~loc=stringLoc,
              ~delimiter,
              start_pos,
              end_pos,
            );
          Error.expr(~loc, msg);
        };

      Builder.pstr_value(
        ~loc=expr.pexp_loc,
        Nonrecursive,
        [Builder.value_binding(~loc=patternLoc, ~pat, ~expr)],
      );
    /* [%cx [||]] - OLD VERSION (KEEP FOR COMPATIBILITY) */
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
                    {txt: "cx", loc: _cxLoc},
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
        |> Css_runtime.add_label(~loc=payloadLoc, valueName)
        |> Builder.pexp_array(~loc=payloadLoc)
        |> Css_runtime.render_style_call(~loc);

      Builder.pstr_value(
        ~loc,
        Nonrecursive,
        [Builder.value_binding(~loc=patternLoc, ~pat, ~expr)],
      );
    /* /* [%cx [] or [%cx2 []] - INVALID SYNTAX */
       | Pstr_value(
           Nonrecursive,
           [
             {
               pvb_pat: _pat,
               pvb_expr:
                 {
                   pexp_desc:
                     Pexp_extension((
                       {txt: ("cx" | "cx2") as ext_name, loc: _cxLoc},
                       PStr([{pstr_desc: Pstr_eval(payload, _), _}]),
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
         let m = Format.asprintf("%a", Ppxlib.Pprintast.expression, payload);
         failwith(m) |> ignore;
         Error.raise(
           ~loc=payload.pexp_loc,
           ~examples,
           ~link="https://styled-ppx.vercel.app/reference/cx",
           "[%"
           ++ ext_name
           ++ "] expects either a string of CSS or an array of CSS rules. ",
         ); */
    | _ => expr
    };
  };
};

/* let createAttribute = (~loc, ~name, value) => {
     let attrName: Ppxlib.loc(string) = {
       Ppxlib.txt: name,
       loc,
     };
     let attrPayload =
       Ppxlib.PStr([
         Builder.pstr_eval(~loc, Builder.estring(~loc, value), []),
       ]);

     let attribute: Ppxlib.attribute = {
       attr_loc: loc,
       attr_name: attrName,
       attr_payload: attrPayload,
     };

     Builder.pstr_attribute(~loc, attribute);
   }; */

let is_jsx = expr => {
  switch (expr.Ppxlib.pexp_desc) {
  | Pexp_apply(tag, _args) =>
    switch (tag.pexp_desc) {
    | Pexp_ident({txt: Lident(name), _}) =>
      Html.is_tag(name)
      || String.length(name) > 0
      && Char.uppercase_ascii(name.[0]) == name.[0]
    | _ => false
    }
  | _ => false
  };
};

let any_payload_pattern = Ppxlib.Ast_pattern.(single_expr_payload(__));

let any_module_payload_pattern =
  Ppxlib.Ast_pattern.(pstr(pstr_eval(__, nil) ^:: nil));

let cx_extension_without_let_binding =
  /* %cx under a let binding is defined in traverser#structure. The difference is that it doesn't have CSS.label */
  Ppxlib.Context_free.Rule.extension(
    Ppxlib.Extension.declare(
      "cx",
      Ppxlib.Extension.Context.Expression,
      any_payload_pattern,
      (~loc as _, ~path, payload) => {
        File.set(path);
        switch (payload.pexp_desc) {
        | Pexp_constant(Pconst_string(txt, stringLoc, delimiter)) =>
          switch (Styled_ppx_css_parser.Driver.parse_declaration_list(txt)) {
          | Ok(rule_list) =>
            rule_list
            |> Css_runtime.render_declarations(~loc=stringLoc)
            |> Builder.pexp_array(~loc=stringLoc)
            |> Css_runtime.render_style_call(~loc=stringLoc)
          | Error((start_pos, end_pos, msg)) =>
            let loc =
              Styled_ppx_css_parser.Parser_location.make_loc_from_pos(
                ~loc=stringLoc,
                ~delimiter,
                start_pos,
                end_pos,
              );
            Error.expr(~loc, msg);
          }
        | Pexp_array(arr) =>
          /* Valid: [%cx [|...|]] */
          arr
          |> Builder.pexp_array(~loc=payload.pexp_loc)
          |> Css_runtime.render_style_call(~loc=payload.pexp_loc)
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
  );

let rec type_check_rule = (rule: Styled_ppx_css_parser.Ast.rule) => {
  switch (rule) {
  | Declaration({name: (name, _), value: (value, _), loc, _}) =>
    let value = Styled_ppx_css_parser.Render.component_value_list(value);
    [Css_property_parser.Parser.check_property(~loc, ~name, value)];
  | Style_rule(style_rule) =>
    let rule_list = style_rule.block;
    /* TODO: we don't typecheck prelude selectors */
    type_check_rule_list(rule_list);
  | At_rule(at_rule) =>
    /* TODO: we don't typecheck at_rules */
    switch (at_rule.block) {
    | Empty =>
      /* TODO: We don't type-check empty at-rules */
      [Ok()]
    | Rule_list(rule_list) => type_check_rule_list(rule_list)
    }
  };
}

and type_check_rule_list =
    ((rule_list, _): Styled_ppx_css_parser.Ast.rule_list) => {
  rule_list |> List.concat_map(rule => type_check_rule(rule));
};

let get_errors =
    (
      validations:
        list(
          result(
            unit,
            (
              Styled_ppx_css_parser.Ast.loc,
              [>
                | `Invalid_value(string)
                | `Property_not_found
              ],
            ),
          ),
        ),
    ) => {
  validations
  |> List.filter_map(result =>
       switch (result) {
       | Error((loc, error)) => Some((loc, error))
       | Ok(_) => None
       }
     );
};

let error_to_string =
    (
      error: [>
        | `Invalid_value(string)
        | `Property_not_found
      ],
    ) => {
  switch (error) {
  | `Invalid_value(string) => string
  | `Property_not_found => "Property not found"
  };
};

let cx2_extension =
  Ppxlib.Context_free.Rule.extension(
    Ppxlib.Extension.declare(
      "cx2",
      Ppxlib.Extension.Context.Expression,
      any_payload_pattern,
      (~loc as _, ~path, payload) => {
        File.set(path);
        switch (payload.pexp_desc) {
        | Pexp_constant(Pconst_string(txt, stringLoc, delimiter)) =>
          switch (Styled_ppx_css_parser.Driver.parse_declaration_list(txt)) {
          | Ok(rule_list) =>
            let validations = type_check_rule_list(rule_list);
            switch (get_errors(validations)) {
            | [] =>
              let (classNames, dynamic_vars) = Css_file.push(rule_list);
              Css_runtime.render_make_call(
                ~loc=stringLoc,
                ~classNames,
                ~dynamic_vars,
              );
            | errors =>
              let error_messages =
                errors
                |> List.map(((loc, error)) => {
                     (
                       Styled_ppx_css_parser.Parser_location.update_loc_with_delimiter(
                         Styled_ppx_css_parser.Parser_location.intersection(
                           stringLoc,
                           loc,
                         ),
                         delimiter,
                       ),
                       error_to_string(error),
                     )
                   });
              Error.expressions(
                ~loc=stringLoc,
                ~description="Type error on cx2 definition",
                error_messages,
              );
            };
          | Error((start_pos, end_pos, msg)) =>
            let loc =
              Styled_ppx_css_parser.Parser_location.make_loc_from_pos(
                ~loc=stringLoc,
                ~delimiter,
                start_pos,
                end_pos,
              );
            Error.expressions(
              ~loc=stringLoc,
              ~description="Parsing error on cx2 definition",
              [(loc, msg)],
            );
          }
        | Pexp_array(arr) =>
          /* Valid: [%cx2 [|...|]] */
          arr
          |> Builder.pexp_array(~loc=payload.pexp_loc)
          |> Css_runtime.render_style_call(~loc=payload.pexp_loc)
        | _ =>
          let examples =
            switch (File.get()) {
            | Some(Reason) =>
              Some([
                "[%cx2 \"display: block; color: red\"]",
                "[%cx2 [|CSS.display(`block), CSS.color(CSS.red)|]]",
              ])
            | Some(ReScript) =>
              Some([
                "[%cx2 \"display: block; color: red\"]",
                "[%cx2 [CSS.display(#block), CSS.color(#red)]]",
              ])
            | Some(OCaml) =>
              Some([
                "[%cx2 \"display: block; color: red\"]",
                "[%cx2 [|CSS.display `block, CSS.color CSS.red |]]",
              ])
            | None => None
            };
          Error.raise(
            ~loc=payload.pexp_loc,
            ~examples?,
            ~link="https://styled-ppx.vercel.app/reference/cx",
            "[%cx2] expects either a string of CSS or an array of CSS rules.",
          );
        };
      },
    ),
  );

let keyframe_extension =
  Ppxlib.Context_free.Rule.extension(
    Ppxlib.Extension.declare(
      "keyframe",
      Ppxlib.Extension.Context.Expression,
      any_payload_pattern,
      (~loc as _, ~path, payload) => {
        File.set(path);
        switch (payload.pexp_desc) {
        | Pexp_constant(Pconst_string(txt, stringLoc, delimiter)) =>
          switch (Styled_ppx_css_parser.Driver.parse_keyframes(txt)) {
          | Ok(declarations) =>
            Css_runtime.render_keyframes(~loc=stringLoc, declarations)
          | Error((start_pos, end_pos, msg)) =>
            let loc =
              Styled_ppx_css_parser.Parser_location.make_loc_from_pos(
                ~loc=stringLoc,
                ~delimiter,
                start_pos,
                end_pos,
              );
            Error.expr(~loc, msg);
          }
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
  );

let css_extension =
  Ppxlib.Context_free.Rule.extension(
    Ppxlib.Extension.declare(
      "css",
      Ppxlib.Extension.Context.Expression,
      any_payload_pattern,
      (~loc as _, ~path, payload) => {
        File.set(path);
        switch (payload.pexp_desc) {
        | Pexp_constant(Pconst_string(txt, stringLoc, delimiter)) =>
          switch (Styled_ppx_css_parser.Driver.parse_declaration(txt)) {
          | Ok(declarations) =>
            let declarationListValues =
              Css_runtime.render_declaration(~loc=stringLoc, declarations);
            List.nth(declarationListValues, 0);
          | Error((start_pos, end_pos, msg)) =>
            let loc =
              Styled_ppx_css_parser.Parser_location.make_loc_from_pos(
                ~loc=stringLoc,
                ~delimiter,
                start_pos,
                end_pos,
              );
            Error.expr(~loc, msg);
          }
        /* TODO: Instead of getting the first element,
             fail when there's more than one declaration or
           make a mechanism to flatten all the properties */
        | _ =>
          Error.expr(
            ~loc=payload.pexp_loc,
            ~examples=["[%css \"color: red\"]", "[%css \"display: block\"]"],
            ~link="https://styled-ppx.vercel.app/reference/css",
            "[%css] expects a string of CSS with a single rule (a property-value pair).",
          )
        };
      },
    ),
  );

let styled_global_extension =
  Ppxlib.Context_free.Rule.extension(
    Ppxlib.Extension.declare(
      "styled.global",
      Ppxlib.Extension.Context.Expression,
      any_payload_pattern,
      (~loc as _, ~path, payload) => {
        File.set(path);
        switch (payload.pexp_desc) {
        | Pexp_constant(Pconst_string(txt, stringLoc, delimiter)) =>
          switch (Styled_ppx_css_parser.Driver.parse_declaration_list(txt)) {
          | Ok(rule_list) =>
            Css_runtime.render_global(~loc=stringLoc, rule_list)
          | Error((start_pos, end_pos, msg)) =>
            let loc =
              Styled_ppx_css_parser.Parser_location.make_loc_from_pos(
                ~loc=stringLoc,
                ~delimiter,
                start_pos,
                end_pos,
              );
            Error.expr(~loc, msg);
          }
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
  );

let legacy_styled_extension =
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
  );

let expands_styles_prop = (~traverse, expr: Ppxlib.expression) => {
  /* This transformation expands a styles prop into className and style. The same transformation lives on server-reason-react due to ppxlib/dune order issues. It's also implemented here in case of not using server-reason-react.ppx and just using reason-react-ppx, or only using styled-ppx. */
  let loc = expr.pexp_loc;
  let attributes = expr.pexp_attributes;
  switch (expr.pexp_desc) {
  | Pexp_apply(tag, args) when is_jsx(expr) =>
    let new_args =
      List.concat_map(
        ((arg_label, arg)) => {
          switch (arg_label) {
          | Ppxlib.Labelled("styles") => [
              (Ppxlib.Labelled("className"), [%expr fst([%e arg])]),
              (Ppxlib.Labelled("style"), [%expr snd([%e arg])]),
            ]
          | Ppxlib.Optional("styles") => [
              (Ppxlib.Optional("className"), [%expr fst([%e arg])]),
              (Ppxlib.Optional("style"), [%expr snd([%e arg])]),
            ]
          | _ => [(arg_label, traverse(arg))]
          }
        },
        args,
      );

    {
      ...Builder.pexp_apply(~loc, traverse(tag), new_args),
      pexp_attributes: attributes,
    };
  | _ => {
      ...traverse(expr),
      pexp_attributes: attributes,
    }
  };
};

let () = {
  Ppxlib.Driver.add_arg(
    ~doc=Settings.native.doc,
    Settings.native.flag,
    Arg.Unit(_ => Settings.Update.native(true)),
  );

  Ppxlib.Driver.add_arg(
    ~doc=Settings.debug.doc,
    Settings.debug.flag,
    Arg.Unit(_ => Settings.Update.debug(true)),
  );

  let (version, mode) = Bsconfig.getJSX();

  switch (version) {
  | Some(version) =>
    Settings.Update.jsxVersion(version);
    Settings.Update.jsxMode(mode);
  | None => ()
  };

  let traverser = {
    as _;
    inherit class Ppxlib.Ast_traverse.map as super;
    pub! structure_item = item => {
      File.set(item.pstr_loc.loc_start.pos_fname);
      Mapper.transform(super#structure_item(item));
    };
    pub! expression = expr => {
      expands_styles_prop(~traverse=super#expression, expr);
    }
  };

  let impl = (_ctx, str: Ppxlib.structure) => {
    let loc = Ppxlib.Location.none;
    switch (Css_file.get()) {
    | "" => str
    | css => [[%stri [@css [%e Builder.estring(~loc, css)]]], ...str]
    };
  };

  Ppxlib.Driver.V2.register_transformation(
    ~impl,
    ~instrument=
      Ppxlib.Driver.Instrument.make(~position=Before, traverser#structure),
    ~rules=[
      cx_extension_without_let_binding,
      css_extension,
      styled_global_extension,
      keyframe_extension,
      legacy_styled_extension,
      cx2_extension,
    ],
    "styled-ppx",
  );
};
