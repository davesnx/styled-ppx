module Builder = Ppxlib.Ast_builder.Default;
module Css_gen = Css_file_generator;

module Css_transform = {
  open Styled_ppx_css_parser.Ast;

  let variable_to_css_var_name = (path: list(string)) => {
    path
    |> String.concat("-")
    |> String.lowercase_ascii
    |> String.map(c =>
         if (c == '.') {
           '-';
         } else {
           c;
         }
       );
  };

  /* Transform component values, replacing Variables with CSS custom properties */
  let rec transform_component_value =
          (
            cv: component_value,
            dynamic_vars: ref(list((string, string, string))),
            property_name: option(string),
          )
          : component_value => {
    switch (cv) {
    | Variable(path) =>
      let var_name = variable_to_css_var_name(path);
      let original_path = String.concat(".", path);

      let property = Option.value(property_name, ~default="");
      if (!List.exists(((vn, _, _)) => vn == var_name, dynamic_vars^)) {
        dynamic_vars :=
          [(var_name, original_path, property), ...dynamic_vars^];
      };

      Function(
        ("var", Ppxlib.Location.none),
        (
          [(Ident("--" ++ var_name), Ppxlib.Location.none)],
          Ppxlib.Location.none,
        ),
      );
    | Function(name, body) =>
      let (body_values, body_loc) = body;
      let transformed_body =
        List.map(
          ((value, loc)) =>
            (
              transform_component_value(value, dynamic_vars, property_name),
              loc,
            ),
          body_values,
        );
      Function(name, (transformed_body, body_loc));
    | Paren_block(values) =>
      let transformed =
        List.map(
          ((value, loc)) =>
            (
              transform_component_value(value, dynamic_vars, property_name),
              loc,
            ),
          values,
        );
      Paren_block(transformed);
    | Bracket_block(values) =>
      let transformed =
        List.map(
          ((value, loc)) =>
            (
              transform_component_value(value, dynamic_vars, property_name),
              loc,
            ),
          values,
        );
      Bracket_block(transformed);
    | _ => cv
    };
  };

  let transform_declaration = (decl: declaration, dynamic_vars) => {
    let (property_name, _) = decl.name;
    let (value_list, value_loc) = decl.value;
    let transformed_values =
      List.map(
        ((cv, loc)) =>
          (
            transform_component_value(cv, dynamic_vars, Some(property_name)),
            loc,
          ),
        value_list,
      );
    {
      ...decl,
      value: (transformed_values, value_loc),
    };
  };

  let transform_rule = (rule: rule, dynamic_vars) => {
    switch (rule) {
    | Declaration(decl) =>
      Declaration(transform_declaration(decl, dynamic_vars))
    | _ => rule
    };
  };

  let transform_rule_list = (declarations: rule_list) => {
    let dynamic_vars = ref([]);
    let (rule_list, rule_loc) = declarations;
    let transformed_rules =
      List.map(rule => transform_rule(rule, dynamic_vars), rule_list);
    let transformed_declarations = (transformed_rules, rule_loc);
    (transformed_declarations, List.rev(dynamic_vars^));
  };
};

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
        switch (
          Styled_ppx_css_parser.Driver.parse_declaration_list(
            ~loc=stringLoc,
            ~delimiter,
            str,
          )
        ) {
        | Ok(declarations) =>
          declarations
          |> Css_runtime.render_declarations(~loc=stringLoc)
          |> Css_runtime.add_label(~loc=stringLoc, moduleName)
          |> Builder.pexp_array(~loc=stringLoc)
          |> Css_runtime.render_style_call(~loc=stringLoc)
        | Error((loc, msg)) => Error.expr(~loc, msg)
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
        switch (
          Styled_ppx_css_parser.Driver.parse_declaration_list(
            ~loc=stringLoc,
            ~delimiter,
            str,
          )
        ) {
        | Ok(declarations) =>
          let (transformed_declarations, dynamic_vars) =
            Css_transform.transform_rule_list(declarations);

          let className = {
            let hash = Murmur2.default(str);
            Printf.sprintf("css-%s", hash);
          };

          let css_string =
            Styled_ppx_css_parser.Render.rule_list(transformed_declarations);

          let css_content = css_string;
          Css_gen.add_css(~className, ~css=css_content);
          Css_runtime.render_make_call(
            ~loc=stringLoc,
            ~className,
            ~dynamic_vars,
          );
        | Error((loc, msg)) => Error.expr(~loc, msg)
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
    /* [%cx2 ""] - NEW VERSION WITH CSS FILE GENERATION */
    | Pstr_value(
        Nonrecursive,
        [
          {
            pvb_pat:
              {ppat_desc: Ppat_var({loc: patternLoc, txt: _valueName}), _} as pat,
            pvb_expr:
              {
                pexp_desc:
                  Pexp_extension((
                    {txt: "cx2", loc: _cxLoc},
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
        switch (
          Styled_ppx_css_parser.Driver.parse_declaration_list(
            ~loc=stringLoc,
            ~delimiter,
            styles,
          )
        ) {
        | Ok(declarations) =>
          /* Transform CSS and extract dynamic variables */
          let (transformed_declarations, dynamic_vars) =
            Css_transform.transform_rule_list(declarations);

          /* Generate class name based on original styles */
          let className = {
            let hash = Murmur2.default(styles);
            Printf.sprintf("css-%s", hash);
          };

          /* Render transformed CSS to string and add to CSS file */
          let css_string =
            Styled_ppx_css_parser.Render.rule_list(transformed_declarations);

          /* Debug: Log the transformed CSS */
          if (Settings.Get.debug()) {
            Printf.printf("[styled-ppx] Transformed CSS: %s\n", css_string);
            Printf.printf(
              "[styled-ppx] Dynamic vars: %d\n",
              List.length(dynamic_vars),
            );
            List.iter(
              ((var_name, original, property)) =>
                Printf.printf(
                  "[styled-ppx]   --%s => %s (property: %s)\n",
                  var_name,
                  original,
                  property,
                ),
              dynamic_vars,
            );
          };

          let css_content =
            Settings.Get.debug()
              ? Printf.sprintf(
                  "  /* Generated from [%%cx] in %s at line %d */\n%s",
                  stringLoc.loc_start.pos_fname,
                  stringLoc.loc_start.pos_lnum,
                  css_string,
                )
              : css_string;
          Css_gen.add_css(~className, ~css=css_content);
          Css_runtime.render_make_call(
            ~loc=stringLoc,
            ~className,
            ~dynamic_vars,
          );
        | Error((loc, msg)) => Error.expr(~loc, msg)
        };

      Builder.pstr_value(
        ~loc=expr.pexp_loc,
        Nonrecursive,
        [Builder.value_binding(~loc=patternLoc, ~pat, ~expr)],
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
        switch (
          Styled_ppx_css_parser.Driver.parse_declaration_list(
            ~loc=stringLoc,
            ~delimiter,
            styles,
          )
        ) {
        | Ok(declarations) =>
          declarations
          |> Css_runtime.render_declarations(~loc=stringLoc)
          |> Css_runtime.add_label(~loc=stringLoc, valueName)
          |> Builder.pexp_array(~loc=stringLoc)
          |> Css_runtime.render_style_call(~loc=stringLoc)
        | Error((loc, msg)) => Error.expr(~loc, msg)
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
    /* [%cx [] or [%cx2 []] - INVALID SYNTAX */
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
      Error.raise(
        ~loc=payload.pexp_loc,
        ~examples,
        ~link="https://styled-ppx.vercel.app/reference/cx",
        "[%"
        ++ ext_name
        ++ "] expects either a string of CSS or an array of CSS rules. ",
      );
    | _ => expr
    };
  };
};

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

let traverser = {
  as _;
  inherit class Ppxlib.Ast_traverse.map as super;
  pub! structure_item = expr => {
    File.set(expr.pstr_loc.loc_start.pos_fname);
    let expr = super#structure_item(expr);
    Mapper.transform(expr);
  };
  /* This transformation expands a styles prop into className and style. The same transformation lives on server-reason-react due to ppxlib/dune order issues. It's also implemented here in case of not using server-reason-react.ppx and just using reason-react-ppx. */
  pub! expression = expr => {
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
            | _ => [(arg_label, super#expression(arg))]
            }
          },
          args,
        );

      {
        ...Builder.pexp_apply(~loc, super#expression(tag), new_args),
        pexp_attributes: attributes,
      };
    | _ => {
        ...super#expression(expr),
        pexp_attributes: attributes,
      }
    };
  }
};

let () =
  Ppxlib.Driver.add_arg(
    Settings.native.flag,
    Arg.Unit(_ => Settings.Update.native(true)),
    ~doc=Settings.native.doc,
  );

let () =
  Ppxlib.Driver.add_arg(
    Settings.debug.flag,
    Arg.Unit(_ => Settings.Update.debug(true)),
    ~doc=Settings.debug.doc,
  );

let () =
  Ppxlib.Driver.add_arg(
    Settings.output.flag,
    Arg.String(path => Settings.Update.output(path)),
    ~doc=Settings.output.doc,
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
          switch (
            Styled_ppx_css_parser.Driver.parse_declaration_list(
              ~loc=stringLoc,
              ~delimiter,
              txt,
            )
          ) {
          | Ok(declarations) =>
            declarations
            |> Css_runtime.render_declarations(~loc=stringLoc)
            |> Builder.pexp_array(~loc=stringLoc)
            |> Css_runtime.render_style_call(~loc=stringLoc)
          | Error((loc, msg)) => Error.expr(~loc, msg)
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
          switch (
            Styled_ppx_css_parser.Driver.parse_declaration_list(
              ~loc=stringLoc,
              ~delimiter,
              txt,
            )
          ) {
          | Ok(declarations) =>
            /* Transform CSS and extract dynamic variables */
            let (transformed_declarations, dynamic_vars) =
              Css_transform.transform_rule_list(declarations);

            /* Generate class name based on original styles */
            let className = {
              let hash = Murmur2.default(txt);
              Printf.sprintf("css-%s", hash);
            };

            /* Render transformed CSS to string and add to CSS file */
            let css_string =
              Styled_ppx_css_parser.Render.rule_list(
                transformed_declarations,
              );

            /* Debug: Log the transformed CSS */
            if (Settings.Get.debug()) {
              Printf.printf(
                "[styled-ppx] cx2 Transformed CSS: %s\n",
                css_string,
              );
              Printf.printf(
                "[styled-ppx] cx2 Dynamic vars: %d\n",
                List.length(dynamic_vars),
              );
              List.iter(
                ((var_name, original, property)) =>
                  Printf.printf(
                    "[styled-ppx] cx2   --%s => %s (property: %s)\n",
                    var_name,
                    original,
                    property,
                  ),
                dynamic_vars,
              );
            };

            let css_content =
              Settings.Get.debug()
                ? Printf.sprintf(
                    "  /* Generated from [%%cx2] in %s at line %d */\n%s",
                    stringLoc.loc_start.pos_fname,
                    stringLoc.loc_start.pos_lnum,
                    css_string,
                  )
                : css_string;
            Css_gen.add_css(~className, ~css=css_content);
            Css_runtime.render_make_call(
              ~loc=stringLoc,
              ~className,
              ~dynamic_vars,
            );
          | Error((loc, msg)) => Error.expr(~loc, msg)
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
          switch (
            Styled_ppx_css_parser.Driver.parse_keyframes(
              ~loc=stringLoc,
              ~delimiter,
              txt,
            )
          ) {
          | Ok(declarations) =>
            Css_runtime.render_keyframes(~loc=stringLoc, declarations)
          | Error((loc, msg)) => Error.expr(~loc, msg)
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
          switch (
            Styled_ppx_css_parser.Driver.parse_declaration(
              ~loc=stringLoc,
              ~delimiter,
              txt,
            )
          ) {
          | Ok(declarations) =>
            let declarationListValues =
              Css_runtime.render_declaration(~loc=stringLoc, declarations);
            List.nth(declarationListValues, 0);
          | Error((loc, msg)) => Error.expr(~loc, msg)
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
          switch (
            Styled_ppx_css_parser.Driver.parse_stylesheet(
              ~loc=stringLoc,
              ~delimiter,
              txt,
            )
          ) {
          | Ok(stylesheets) =>
            Css_runtime.render_global(~loc=stringLoc, stylesheets)
          | Error((loc, msg)) => Error.expr(~loc, msg)
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

Ppxlib.Driver.V2.register_transformation(
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
