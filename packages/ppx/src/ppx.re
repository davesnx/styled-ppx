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

let _ =
  Ppxlib.Driver.register_transformation(
    ~rules=
      styled_rules
      @ [
        /* %cx without let binding, it doesn't have CSS.label
           %cx is defined in traverser#structure */
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
