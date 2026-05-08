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
  | Declaration({ name: (name, _), value: (value, value_loc), loc: _, _ }) =>
    switch (Css_grammar.validate_property(~loc=value_loc, ~name, value)) {
    | Ok () => [Ok()]
    | Error((loc, `Invalid_value(detail))) =>
      let value_source =
        Styled_ppx_css_parser.Render.component_value_list(value)
        |> String.trim;
      let msg =
        Format.sprintf(
          "@[Property@ '%s'@ has@ an@ invalid@ value:@ '%s',@ %s@]",
          name,
          value_source,
          Css_grammar.Rule.format_error_info(detail),
        );
      [Error((loc, `Invalid_value(msg)))];
    | Error((loc, `Property_not_found)) =>
      let msg =
        switch (Css_grammar.suggest_property_name(name)) {
        | Some(suggestion) =>
          "Unknown property '"
          ++ name
          ++ "'. Did you mean '"
          ++ suggestion
          ++ "'?"
        | None => "Unknown property '" ++ name ++ "'"
        };
      [Error((loc, `Invalid_value(msg)))];
    }
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
                |> Css_to_runtime.render_declarations(~loc, ~source=str)
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

/* Build a top-level floating attribute `[@@@<name> <expr>]`. The
   metaquot dialect around floating attributes is awkward in Reason
   syntax, so we go via the explicit Ast_builder constructors. */
let make_list_attribute = (~name: string, expr: Ppxlib.expression) => {
  let loc = Ppxlib.Location.none;
  let payload = Ppxlib.PStr([Builder.pstr_eval(~loc, expr, [])]);
  let attr =
    Builder.attribute(
      ~loc,
      ~name={
        Ppxlib.Location.txt: name,
        loc,
      },
      ~payload,
    );
  Builder.pstr_attribute(~loc, attr);
};

/* Build [@@@css.refs [(longident, file, line, scol, ecol); ...]]. The
   aggregator uses this list to format errors with original source
   locations when cross-module sentinels cannot be resolved. */
let make_refs_attribute = (entries: list(Cross_module_refs.entry)) => {
  let loc = Ppxlib.Location.none;
  let entry_to_expr = (entry: Cross_module_refs.entry) => {
    let pos_start = entry.loc.loc_start;
    let pos_end = entry.loc.loc_end;
    let col = (pos: Lexing.position) =>
      Builder.eint(~loc, pos.pos_cnum - pos.pos_bol);
    Builder.pexp_tuple(
      ~loc,
      [
        Builder.estring(~loc, entry.longident),
        Builder.estring(~loc, pos_start.pos_fname),
        Builder.eint(~loc, pos_start.pos_lnum),
        col(pos_start),
        col(pos_end),
      ],
    );
  };
  let list_expr = Builder.elist(~loc, List.map(entry_to_expr, entries));
  make_list_attribute(~name="css.refs", list_expr);
};

/* Build [@@@css.bindings [(longident, class_string); ...]]. Every named
   [%cx2] binding contributes one pair so the aggregator can index it
   directly without re-parsing CSS.make calls out of the post-PPX AST. */
let make_bindings_attribute = (entries: list(Css_bindings.entry)) => {
  let loc = Ppxlib.Location.none;
  let entry_to_expr = (entry: Css_bindings.entry) =>
    Builder.pexp_tuple(
      ~loc,
      [
        Builder.estring(~loc, entry.longident),
        Builder.estring(~loc, entry.class_string),
      ],
    );
  let list_expr = Builder.elist(~loc, List.map(entry_to_expr, entries));
  make_list_attribute(~name="css.bindings", list_expr);
};

let make_synthetic_dep = ((longident_str: string, loc: Ppxlib.Location.t)) => {
  let lid = Ppxlib.Longident.parse(longident_str);
  let ident_expr =
    Builder.pexp_ident(
      ~loc,
      {
        Ppxlib.Location.txt: lid,
        loc,
      },
    );
  /* `let _ = M.Css.marker` â purely for ocamldep + early type errors.
     Carrying the original [%cx2] location through here means
     "Unbound module" / "Unbound value" errors point at the user's
     selector ref rather than at [_none_]. */
  Builder.pstr_value(
    ~loc,
    Nonrecursive,
    [
      Builder.value_binding(
        ~loc,
        ~pat=Builder.ppat_any(~loc),
        ~expr=ident_expr,
      ),
    ],
  );
};

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

  Ppxlib.Driver.add_arg(
    ~doc=Settings.dev.doc,
    Settings.dev.flag,
    Arg.Unit(_ => Settings.Update.dev(true)),
  );

  let impl = (_ctx, str: Ppxlib.structure) => {
    let loc = Ppxlib.Location.none;
    let rules = Css_file.get();
    let rule_items =
      List.map(
        rule => [%stri [@css [%e Builder.estring(~loc, rule)]]],
        rules,
      );
    let binding_entries = Css_bindings.drain();
    let bindings_items =
      switch (binding_entries) {
      | [] => []
      | _ => [make_bindings_attribute(binding_entries)]
      };
    let (cross_module_entries, cross_module_longidents) =
      Cross_module_refs.drain();
    let refs_items =
      switch (cross_module_entries) {
      | [] => []
      | _ => [make_refs_attribute(cross_module_entries)]
      };
    let dep_items = List.map(make_synthetic_dep, cross_module_longidents);
    /* Order:
       - extracted CSS rules
       - binding exports
       - cross-module refs descriptor
       - dep-tracking synthetic lets
       - user's source. */
    rule_items @ bindings_items @ refs_items @ dep_items @ str;
  };

  Ppxlib.Driver.V2.register_transformation(
    ~impl,
    ~rules=
      List.map(make_styled_extension, html_tags)
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
                  |> Css_to_runtime.render_declarations(~loc, ~source=txt)
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
          Ppxlib.Extension.V3.declare(
            "cx2",
            Ppxlib.Extension.Context.Expression,
            Ppxlib.Ast_pattern.(single_expr_payload(__)),
            (~ctxt, payload) => {
              open Ppxlib;
              let code_path = Expansion_context.Extension.code_path(ctxt);
              let file = Code_path.file_path(code_path);
              let binding_name = Code_path.enclosing_value(code_path);
              /* `Code_path.value` is the strict top-level form: it returns
                 `Some(name)` only when the [%cx2] is the direct rhs of a
                 module-level `let name = ...`, and `None` for any nested
                 expression (a `let inner = ...` body, an `if ... then`
                 branch, a function arg, etc.). We register the cross-module
                 bindings index off this — never off `enclosing_value` —
                 so a local `let inner = [%cx2 ...] in inner` doesn't leak
                 `inner` into the index. The looser `enclosing_value` is
                 still used for the label suffix and DOM marker, which are
                 only observed within the expansion site. */
              let toplevel_binding_name = Code_path.value(code_path);
              /* Under --minify, suppress the label-suffix that personalizes
                 atom hashes (`css-<hash>-<binding>`); plain hashes still
                 dedupe correctly. */
              let label = Settings.Get.minify() ? None : binding_name;
              File.set(file);
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
                      Css_file.push(~file, ~label?, rule_list);
                    /* Register this binding so that later [%cx2] blocks in
                       the same file can resolve `$(name)` selector interps
                       to the classNames we just minted. Anonymous bindings
                       (`let _ = ...`) are skipped inside `register`.

                       We also record the fully-qualified longident in
                       [Css_bindings] so the impl transformer can emit it as
                       a [@@@css.bindings ...] attribute for the aggregator's
                       cross-module index.

                       Both registrations use `toplevel_binding_name`, not
                       the looser `binding_name`. Nested `let inner = ...`
                       inside a function body, branches of `if/match`, etc.
                       still emit CSS, but they don't pollute the cross-
                       module index with names that aren't part of the
                       module's surface API. */
                    switch (toplevel_binding_name) {
                    | Some(name) =>
                      Css_file.Class_registry.register(
                        ~file,
                        ~name,
                        ~classNames,
                      );
                      let main_module = Code_path.main_module_name(code_path);
                      let submodule_path =
                        Code_path.submodule_path(code_path);
                      let longident =
                        String.concat(
                          ".",
                          [main_module, ...submodule_path] @ [name],
                        );
                      let class_string = String.concat(" ", classNames);
                      Css_bindings.record(~longident, ~class_string);
                    | None => ()
                    };
                    /* The DOM marker uses the looser `binding_name`
                       (i.e. `Code_path.enclosing_value`) so a [%cx2] inside
                       a nested `let` body still gets a `cx-<name>` marker
                       reflecting its immediate binding. The cross-module
                       registry above intentionally uses the stricter
                       `toplevel_binding_name`; the two are only divergent
                       for nested-expression cx2 sites. */
                    let marker = Dev_mode.marker(binding_name);
                    Css_to_runtime.render_make_call(
                      ~loc=stringLoc,
                      ~marker,
                      ~classNames,
                      ~dynamic_vars,
                    );
                  | errors =>
                    let error_messages =
                      errors
                      |> List.map(((error_loc, error)) => {
                           let adjusted_loc =
                             Styled_ppx_css_parser.Parser_location.adjust_to_file(
                               ~relative_loc=error_loc,
                               ~base_loc=loc,
                             );
                           (adjusted_loc, error_to_string(error));
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
                    Css_to_runtime.render_declaration(
                      ~loc,
                      ~source=txt,
                      declarations,
                    );
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
                  Css_to_runtime.render_global(~loc, ~source=txt, stylesheets)
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
        /* New shape: `module ThemeVars = [%styled.global2 {| ... |}]`.
           Expands to a module structure with `to_string`, `to_buffer`,
           and `make` members. Static parts of the rule list extract to
           the aggregated stylesheet via the existing [@@@css ...] path;
           rules that contain $(expr) interpolations also produce a
           `var(--hash)` declaration on the static side AND a runtime
           string-builder that emits the actual value at evaluation
           time (see documents/global2-interpolation.md). */
        Ppxlib.Context_free.Rule.extension(
          Ppxlib.Extension.V3.declare(
            "styled.global2",
            Ppxlib.Extension.Context.Module_expr,
            Ppxlib.Ast_pattern.(single_expr_payload(__)),
            (~ctxt, payload) => {
              open Ppxlib;
              let code_path = Expansion_context.Extension.code_path(ctxt);
              let file = Code_path.file_path(code_path);
              File.set(file);
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
                    Builder.pmod_extension(
                      ~loc=rule_loc,
                      Location.error_extensionf(
                        ~loc=rule_loc,
                        "Declarations does not make sense in global styles. Global should consists of style rules or at-rules (e.g @media, @print, etc.)\n\nIf your intent is to apply the declaration to all elements, use the universal selector\n* {\n  /* Your declarations here */\n}",
                      ),
                    );
                  } else {
                    let dynamic_vars =
                      Css_file.push_global(~file, rule_list);
                    /* Build the structure of the generated module.

                       The runtime's contract here is narrow: supply
                       values for the custom properties the static rule
                       (already extracted via [@@@css ...]) references
                       through `var()`. So `to_string` is a single
                       `:root { --var-h: <value>; ... }` block, one
                       declaration per dynamic_var. The user's
                       selectors and non-interpolated declarations are
                       NOT re-emitted at runtime. */
                    let to_string_body =
                      Css_global_to_string.render_root_block(
                        ~loc=stringLoc,
                        dynamic_vars,
                      );
                    let to_string_decl = [%stri
                      let to_string = () => [%e to_string_body]
                    ];
                    let to_buffer_decl = [%stri
                      let to_buffer = buf =>
                        Buffer.add_string(buf, to_string())
                    ];
                    let make_decl = [%stri
                      let make = () => CSS.global_style_tag(to_string())
                    ];
                    Builder.pmod_structure(
                      ~loc=stringLoc,
                      [to_string_decl, to_buffer_decl, make_decl],
                    );
                  };
                | Error((loc, msg)) =>
                  Builder.pmod_extension(
                    ~loc,
                    Location.error_extensionf(~loc, "%s", msg),
                  )
                };
              | _ =>
                Builder.pmod_extension(
                  ~loc=payload.pexp_loc,
                  Location.error_extensionf(
                    ~loc=payload.pexp_loc,
                    "[%%styled.global2] expects a string of CSS with selectors that apply to the whole document.\n\nExample:\n  module Reset = [%%styled.global2 \"body { margin: 0; }\"]",
                  ),
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
                  Css_to_runtime.render_keyframes(
                    ~loc,
                    ~source=txt,
                    declarations,
                  )
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
