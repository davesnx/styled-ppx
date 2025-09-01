module Builder = Ppxlib.Ast_builder.Default;
module Css_gen = Css_file_generator;

/* Transform CSS AST to replace Variables with CSS custom properties */
module Css_transform = {
  open Styled_ppx_css_parser.Ast;

  /* Convert variable path to CSS custom property name */
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
          (cv: component_value, dynamic_vars: ref(list((string, string))))
          : component_value => {
    switch (cv) {
    | Variable(path) =>
      let var_name = variable_to_css_var_name(path);
      let original_path = String.concat(".", path);

      /* Track dynamic variable */
      if (!List.mem_assoc(var_name, dynamic_vars^)) {
        dynamic_vars := [(var_name, original_path), ...dynamic_vars^];
      };

      /* Return CSS custom property reference */
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
            (transform_component_value(value, dynamic_vars), loc),
          body_values,
        );
      Function(name, (transformed_body, body_loc));
    | Paren_block(values) =>
      let transformed =
        List.map(
          ((value, loc)) =>
            (transform_component_value(value, dynamic_vars), loc),
          values,
        );
      Paren_block(transformed);
    | Bracket_block(values) =>
      let transformed =
        List.map(
          ((value, loc)) =>
            (transform_component_value(value, dynamic_vars), loc),
          values,
        );
      Bracket_block(transformed);
    | _ => cv
    };
  };

  /* Transform declarations */
  let transform_declaration = (decl: declaration, dynamic_vars) => {
    let (value_list, value_loc) = decl.value;
    let transformed_values =
      List.map(
        ((cv, loc)) => (transform_component_value(cv, dynamic_vars), loc),
        value_list,
      );
    {
      ...decl,
      value: (transformed_values, value_loc),
    };
  };

  /* Transform rules */
  let transform_rule = (rule: rule, dynamic_vars) => {
    switch (rule) {
    | Declaration(decl) =>
      Declaration(transform_declaration(decl, dynamic_vars))
    | _ => rule
    };
  };

  /* Transform rule list and extract dynamic variables */
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
              ((var_name, original)) =>
                Printf.printf(
                  "[styled-ppx]   --%s => %s\n",
                  var_name,
                  original,
                ),
              dynamic_vars,
            );
          };

          let css_content =
            Settings.Get.debug()
              ? Printf.sprintf(
                  "  /* Generated from [%%cx] in %s at line %d */\n%s",
                  loc.loc_start.pos_fname,
                  loc.loc_start.pos_lnum,
                  css_string,
                )
              : css_string;
          Css_gen.add_css(~className, ~css=css_content);
          Css_to_runtime.render_make_call(~loc, ~className, ~dynamic_vars);
        | Error((loc, msg)) => Error.expr(~loc, msg)
        };

      Builder.pstr_value(
        ~loc=expr.pexp_loc,
        Nonrecursive,
        [Builder.value_binding(~loc=patternLoc, ~pat, ~expr)],
      );
    /* [%cx ""] - OLD VERSION (KEEP FOR COMPATIBILITY) */
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
    /* [%cx2 [||]] - NEW VERSION */
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
                    {txt: "cx2", loc: _cxLoc},
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
      /* For now, cx2 with array fallback to old behavior - can be enhanced later */
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
        |> Css_to_runtime.addLabel(~loc=payloadLoc, valueName)
        |> Builder.pexp_array(~loc=payloadLoc)
        |> Css_to_runtime.render_style_call(~loc);

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

let traverser = {
  as _;
  inherit class Ppxlib.Ast_traverse.map as super;
  pub! structure_item = expr => {
    File.set(expr.pstr_loc.loc_start.pos_fname);
    let expr = super#structure_item(expr);
    Mapper.transform(expr);
  }
};

let declaration_is_dynamic =
    (declaration: Styled_ppx_css_parser.Ast.declaration) => {
  let (_component_value_list, _) = declaration.value;
  /* TODO: implement logic to detect dynamic declarations */
  false;
};

let rule_is_dynamic = (rule: Styled_ppx_css_parser.Ast.rule) => {
  switch (rule) {
  | Declaration(declaration) => declaration_is_dynamic(declaration)
  | Style_rule(_style_rule) => false
  | At_rule(_at_rule) => false
  };
};

let split_declarations = (declarations: Styled_ppx_css_parser.Ast.rule_list) => {
  let (rule_list, _) = declarations;
  List.partition(
    (_declaration: Styled_ppx_css_parser.Ast.rule) => false,
    rule_list,
  );
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

let _ =
  Ppxlib.Driver.add_arg(
    Settings.debug.flag,
    Arg.Unit(_ => Settings.Update.debug(true)),
    ~doc=Settings.debug.doc,
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
         %cx is defined in traverser#structure
         RESTORED TO OLD BEHAVIOR - use cx2 for new CSS file generation */
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
                /* OLD BEHAVIOR: Just render declarations without CSS file generation */
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
      /* cx2 extension - NEW VERSION WITH CSS FILE GENERATION */
      Ppxlib.Context_free.Rule.extension(
        Ppxlib.Extension.declare(
          "cx2",
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
                    ((var_name, original)) =>
                      Printf.printf(
                        "[styled-ppx] cx2   --%s => %s\n",
                        var_name,
                        original,
                      ),
                    dynamic_vars,
                  );
                };

                let css_content =
                  Settings.Get.debug()
                    ? Printf.sprintf(
                        "  /* Generated from [%%cx2] in %s at line %d */\n%s",
                        loc.loc_start.pos_fname,
                        loc.loc_start.pos_lnum,
                        css_string,
                      )
                    : css_string;
                Css_gen.add_css(~className, ~css=css_content);

                /* Generate runtime code */
                let (_static, _dynamic) = split_declarations(declarations);
                if (List.length(dynamic_vars) > 0) {
                  /* Use CSS.make when there are dynamic variables */
                  Css_to_runtime.render_make_call(
                    ~loc,
                    ~className,
                    ~dynamic_vars,
                  );
                } else {
                  /* Use traditional CSS.style for static styles */
                  declarations
                  |> Css_to_runtime.render_declarations(~loc)
                  |> Builder.pexp_array(~loc)
                  |> Css_to_runtime.render_style_call(~loc);
                };
              | Error((loc, msg)) => Error.expr(~loc, msg)
              };
            | Pexp_array(arr) =>
              /* Valid: [%cx2 [|...|]] */
              arr
              |> Builder.pexp_array(~loc=payload.pexp_loc)
              |> Css_to_runtime.render_style_call(~loc=payload.pexp_loc)
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
