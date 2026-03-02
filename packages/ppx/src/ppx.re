module Builder = Ppxlib.Ast_builder.Default;

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

let is_css_keyword = (value: Styled_ppx_css_parser.Ast.component_value) => {
  switch (value) {
  | Ident("inherit")
  | Ident("unset")
  | Ident("initial")
  | Ident("revert")
  | Ident("revert-layer") => true
  | _ => false
  };
};

let rec type_check_rule = (rule: Styled_ppx_css_parser.Ast.rule) => {
  switch (rule) {
  | Declaration({ name: _, value: ([(value, _)], _), _ })
      when is_css_keyword(value) => [
      Ok(),
    ]
  | Declaration({ name: (name, _), value: (value, _), loc, _ }) =>
    let value = Styled_ppx_css_parser.Render.component_value_list(value);
    switch (Css_grammar.Parser.check_property(~loc, ~name, value)) {
    | Ok () => [Ok()]
    | Error((loc, `Invalid_value(raw_error))) =>
      let msg =
        raw_error == ""
          ? Format.sprintf(
              "Property '%s' has an invalid value: '%s'",
              name,
              value,
            )
          : raw_error;
      [Error((loc, `Invalid_value(msg)))];
    | Error((loc, `Property_not_found)) =>
      let msg =
        switch (Css_grammar.Parser.suggest_property_name(name)) {
        | Some(suggestion) =>
          "Unknown property '"
          ++ name
          ++ "'. Did you mean '"
          ++ suggestion
          ++ "'?"
        | None => "Unknown property '" ++ name ++ "'"
        };
      [Error((loc, `Invalid_value(msg)))];
    };
  | Style_rule(style_rule) =>
    let rule_list = style_rule.block;
    type_check_rule_list(rule_list);
  | At_rule(at_rule) =>
    switch (at_rule.block) {
    | Empty => [Ok()]
    | Rule_list(rule_list) => type_check_rule_list(rule_list)
    | Stylesheet(rule_list) => type_check_rule_list(rule_list)
    }
  };
}

and type_check_rule_list =
    ((rule_list, _): Styled_ppx_css_parser.Ast.rule_list) => {
  rule_list |> List.concat_map(rule => type_check_rule(rule));
};

let get_errors = validations => {
  validations
  |> List.filter_map(result =>
       switch (result) {
       | Error((loc, error)) => Some((loc, error))
       | Ok(_) => None
       }
     );
};

let error_to_string = error => {
  switch (error) {
  | `Invalid_value(string) => string
  | `Property_not_found => "Property not found"
  };
};

let any_payload_pattern = Ppxlib.Ast_pattern.(single_expr_payload(__));

let any_module_payload_pattern =
  Ppxlib.Ast_pattern.(pstr(pstr_eval(__, nil) ^:: nil));

let html_tags = [
  "a",
  "abbr",
  "address",
  "article",
  "aside",
  "audio",
  "b",
  "blockquote",
  "body",
  "br",
  "button",
  "canvas",
  "caption",
  "cite",
  "code",
  "col",
  "colgroup",
  "data",
  "datalist",
  "dd",
  "details",
  "dfn",
  "dialog",
  "div",
  "dl",
  "dt",
  "em",
  "embed",
  "fieldset",
  "figcaption",
  "figure",
  "footer",
  "form",
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
  "kbd",
  "label",
  "legend",
  "li",
  "link",
  "main",
  "map",
  "mark",
  "menu",
  "meta",
  "meter",
  "nav",
  "noscript",
  "object",
  "ol",
  "optgroup",
  "option",
  "output",
  "p",
  "picture",
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
  "slot",
  "small",
  "source",
  "span",
  "strong",
  "style",
  "sub",
  "summary",
  "sup",
  "svg",
  "table",
  "tbody",
  "td",
  "template",
  "textarea",
  "tfoot",
  "th",
  "thead",
  "time",
  "title",
  "tr",
  "track",
  "u",
  "ul",
  "var",
  "video",
  "wbr",
];

let make_styled_extension = htmlTag => {
  Ppxlib.(
    Context_free.Rule.extension(
      Extension.V3.declare(
        "styled." ++ htmlTag,
        Extension.Context.Module_expr,
        Ppxlib.Ast_pattern.(single_expr_payload(__)),
        (~ctxt, payload) => {
          let code_path = Expansion_context.Extension.code_path(ctxt);
          let moduleName = Code_path.enclosing_module(code_path);
          File.set(Code_path.file_path(code_path));

          switch (payload.pexp_desc) {
          | Pexp_constant(Pconst_string(str, stringLoc, delimiter)) =>
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
            Generate.staticComponent(~loc, ~htmlTag, styles);

          | Pexp_array(arr) =>
            let styles =
              arr
              |> Css_to_runtime.addLabel(~loc=payload.pexp_loc, moduleName)
              |> Builder.pexp_array(~loc=payload.pexp_loc)
              |> Css_to_runtime.render_style_call(~loc=payload.pexp_loc);
            Generate.staticComponent(~loc=payload.pexp_loc, ~htmlTag, styles);

          | Pexp_function(
              [
                { pparam_desc: Pparam_val(fnLabel, defaultValue, param), _ },
              ],
              _,
              Pfunction_body(expression),
            ) =>
            Generate.dynamicComponent(
              ~loc=payload.pexp_loc,
              ~htmlTag,
              ~label=fnLabel,
              ~moduleName,
              ~defaultValue,
              ~param,
              ~body=expression,
            )

          | _ =>
            Error.raise(
              ~loc=payload.pexp_loc,
              ~examples=["[%styled." ++ htmlTag ++ " \"color: red\"]"],
              ~link="https://styled-ppx.vercel.app/reference/styled",
              "[%styled."
              ++ htmlTag
              ++ "] expects a string of CSS, an array of CSS rules, or a function returning CSS.",
            )
          };
        },
      ),
    )
  );
};

let styled_rules = List.map(make_styled_extension, html_tags);

let () = {
  Ppxlib.Driver.add_arg(
    ~doc=Settings.debug.doc,
    Settings.debug.flag,
    Arg.Unit(_ => Settings.Update.debug(true)),
  );

  Ppxlib.Driver.add_arg(
    ~doc=Settings.minify.doc,
    Settings.minify.flag,
    Arg.Unit(_ => Settings.Update.minify(true)),
  );

  let impl = (_ctx, str: Ppxlib.structure) => {
    let loc = Ppxlib.Location.none;
    switch (Css_file.get()) {
    | "" => str
    | css => [[%stri [@css [%e Builder.estring(~loc, css)]]], ...str]
    };
  };

  Ppxlib.Driver.V2.register_transformation(
    ~impl,
    ~rules=
      styled_rules
      @ [
        Ppxlib.Context_free.Rule.extension(
          Ppxlib.Extension.V3.declare(
            "cx",
            Ppxlib.Extension.Context.Expression,
            Ppxlib.Ast_pattern.(single_expr_payload(__)),
            (~ctxt, payload) => {
              open Ppxlib;
              let code_path = Expansion_context.Extension.code_path(ctxt);
              let label = Code_path.enclosing_value(code_path);
              File.set(Code_path.file_path(code_path));

              let maybe_add_label = (~loc, declarations) =>
                switch (label) {
                | Some(name) =>
                  Css_to_runtime.addLabel(~loc, name, declarations)
                | None => declarations
                };

              switch (payload.pexp_desc) {
              | Pexp_constant(Pconst_string(txt, stringLoc, delimiter)) =>
                let loc =
                  Styled_ppx_css_parser.Parser_location.update_loc_with_delimiter(
                    stringLoc,
                    delimiter,
                  );
                switch (
                  Styled_ppx_css_parser.Driver.parse_declaration_list(
                    ~loc,
                    txt,
                  )
                ) {
                | Ok(declarations) =>
                  declarations
                  |> Css_to_runtime.render_declarations(~loc)
                  |> maybe_add_label(~loc)
                  |> Builder.pexp_array(~loc)
                  |> Css_to_runtime.render_style_call(~loc)
                | Error((loc, msg)) => Error.expr(~loc, msg)
                };
              | Pexp_array(arr) =>
                arr
                |> maybe_add_label(~loc=payload.pexp_loc)
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
                  Styled_ppx_css_parser.Driver.parse_declaration_list(
                    ~loc,
                    txt,
                  )
                ) {
                | Ok(rule_list) =>
                  let validations = type_check_rule_list(rule_list);
                  switch (get_errors(validations)) {
                  | [] =>
                    let (classNames, dynamic_vars) =
                      Css_file.push(rule_list);
                    Css_to_runtime.render_make_call(
                      ~loc=stringLoc,
                      ~classNames,
                      ~dynamic_vars,
                    );
                  | errors =>
                    let error_messages =
                      errors
                      |> List.map(((loc, error)) => {
                           (loc, error_to_string(error))
                         });
                    switch (error_messages) {
                    | [(loc, msg)] => Error.expr(~loc, msg)
                    | _ =>
                      Error.expressions(
                        ~loc=stringLoc,
                        ~description="Multiple errors on cx2 definition",
                        error_messages,
                      )
                    };
                  };
                | Error((loc, msg)) => Error.expr(~loc, msg)
                };
              | Pexp_array(arr) =>
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
            "styled.global2",
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
                  Styled_ppx_css_parser.Driver.parse_declaration_list(
                    ~loc,
                    txt,
                  )
                ) {
                | Ok(rule_list) =>
                  let (rules, rule_loc) = rule_list;
                  let has_invalid_rules =
                    List.exists(
                      fun
                      | Styled_ppx_css_parser.Ast.Declaration(_) => true
                      | _ => false,
                      rules,
                    );
                  if (has_invalid_rules) {
                    Error.expr(
                      ~loc=rule_loc,
                      {|Declarations does not make sense in global styles. Global should consists of style rules or at-rules (e.g @media, @print, etc.)

If your intent is to apply the declaration to all elements, use the universal selector
* {
  /* Your declarations here */
}|},
                    );
                  } else {
                    Css_file.push_global(rule_list);
                    Builder.eunit(~loc=stringLoc);
                  };
                | Error((loc, msg)) => Error.expr(~loc, msg)
                };
              | _ =>
                Error.expr(
                  ~loc=payload.pexp_loc,
                  ~examples=[
                    "[%styled.global2 \"body { margin: 0; } .container { padding: 20px; }\"]",
                  ],
                  ~link="https://styled-ppx.vercel.app/reference/global",
                  "[%styled.global2] expects a string of CSS with selectors that apply to the whole document.",
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
                switch (
                  Styled_ppx_css_parser.Driver.parse_keyframes(~loc, txt)
                ) {
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
        Ppxlib.Context_free.Rule.extension(
          Ppxlib.Extension.declare(
            "keyframe2",
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
                  Styled_ppx_css_parser.Driver.parse_keyframes(~loc, txt)
                ) {
                | Ok(declarations) =>
                  let keyframe_name = Css_file.push_keyframe(declarations);
                  let loc = stringLoc;
                  [%expr
                   CSS.Types.AnimationName.make(
                     [%e Builder.estring(~loc, keyframe_name)],
                   )
                  ];
                | Error((loc, msg)) => Error.expr(~loc, msg)
                };
              | _ =>
                Error.raise(
                  ~loc=payload.pexp_loc,
                  ~examples=[
                    "[%keyframe2 \"0% { opacity: 0; } 100% { opacity: 1; }\"]",
                  ],
                  ~link="https://styled-ppx.vercel.app/reference/keyframe",
                  "[%keyframe2] expects a string of CSS with keyframe definitions.",
                )
              };
            },
          ),
        ),
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
};
