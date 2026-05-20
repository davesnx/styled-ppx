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

let module_name_of_file = file =>
  file
  |> Filename.basename
  |> Filename.remove_extension
  |> String.capitalize_ascii;

let longident_segments = (lid: Ppxlib.Longident.t): list(string) => {
  let rec loop = lid =>
    switch (lid) {
    | Ppxlib.Longident.Lident(name) => [name]
    | Ppxlib.Longident.Ldot(parent, name) => loop(parent) @ [name]
    | Ppxlib.Longident.Lapply(_, _) => []
    };
  loop(lid);
};

let payload_expr = payload =>
  switch (payload) {
  | Ppxlib.PStr([{ pstr_desc: Pstr_eval(expr, _), _ }]) => Some(expr)
  | _ => None
  };

let cx2_error_expr = (~payload_loc) => {
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
    ~loc=payload_loc,
    ~examples?,
    ~link="https://styled-ppx.vercel.app/reference/cx",
    "[%cx2] expects either a string of CSS or an array of CSS rules.",
  );
};

let record_cx2_binding = (~file, ~main_module, ~scope, ~name, ~classNames) => {
  Css_file.Class_registry.register(~file, ~scope, ~name, ~classNames);
  let longident = String.concat(".", [main_module, ...scope] @ [name]);
  let class_string = String.concat(" ", classNames);
  Css_bindings.record(~longident, ~class_string);
};

let expand_cx2_expression =
    (
      ~file,
      ~main_module,
      ~scope,
      ~opens,
      ~label_name,
      ~registry_name,
      payload,
    ) => {
  open Ppxlib;
  File.set(file);
  let label = Settings.Get.minify() ? None : label_name;
  switch (payload.pexp_desc) {
  | Pexp_constant(Pconst_string(txt, stringLoc, delimiter)) =>
    let loc =
      Styled_ppx_css_parser.Parser_location.update_loc_with_delimiter(
        stringLoc,
        delimiter,
      );
    switch (Styled_ppx_css_parser.Driver.parse_declaration_list(~loc, txt)) {
    | Ok(rule_list) =>
      let validations = type_check_rule_list(rule_list);
      switch (get_errors(validations)) {
      | [] =>
        let (classNames, dynamic_vars) =
          Css_file.push(~file, ~scope, ~opens, ~label?, rule_list);
        switch (registry_name) {
        | Some(name) =>
          record_cx2_binding(~file, ~main_module, ~scope, ~name, ~classNames)
        | None => ()
        };
        let marker = Dev_mode.marker(label_name);
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
  | _ => cx2_error_expr(~payload_loc=payload.pexp_loc)
  };
};

let expand_global2_module = (~file, ~scope, ~opens, payload) => {
  open Ppxlib;
  File.set(file);
  switch (payload.pexp_desc) {
  | Pexp_constant(Pconst_string(txt, stringLoc, delimiter)) =>
    let loc =
      Styled_ppx_css_parser.Parser_location.update_loc_with_delimiter(
        stringLoc,
        delimiter,
      );
    switch (Styled_ppx_css_parser.Driver.parse_declaration_list(~loc, txt)) {
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
        let validations = type_check_rule_list(rule_list);
        switch (get_errors(validations)) {
        | [] =>
          let dynamic_vars =
            Css_file.push_global(~file, ~scope, ~opens, rule_list);
          let to_string_body =
            Css_global_to_string.render_root_block(
              ~loc=stringLoc,
              dynamic_vars,
            );
          let to_string_decl = [%stri
            let to_string = () => [%e to_string_body]
          ];
          let to_buffer_decl = [%stri
            let to_buffer = buf => Buffer.add_string(buf, to_string())
          ];
          let make_decl = [%stri
            let make = () => CSS.global_style_tag(to_string())
          ];
          Builder.pmod_structure(
            ~loc=stringLoc,
            [to_string_decl, to_buffer_decl, make_decl],
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
          | [(loc, msg)] =>
            Builder.pmod_extension(
              ~loc,
              Location.error_extensionf(~loc, "%s", msg),
            )
          | _ =>
            Builder.pmod_extension(
              ~loc=stringLoc,
              Ppxlib.Location.Error.to_extension(
                Ppxlib.Location.Error.make(
                  ~loc=stringLoc,
                  ~sub=error_messages,
                  "Multiple errors on styled.global2 definition",
                ),
              ),
            )
          };
        };
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
};

let expand_keyframe2_expression = (~file, payload: Ppxlib.expression) => {
  open Ppxlib;
  File.set(file);
  switch (payload.pexp_desc) {
  | Pexp_constant(Pconst_string(txt, stringLoc, delimiter)) =>
    let loc =
      Styled_ppx_css_parser.Parser_location.update_loc_with_delimiter(
        stringLoc,
        delimiter,
      );
    switch (Styled_ppx_css_parser.Driver.parse_keyframes(~loc, txt)) {
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
      ~examples=["[%keyframe2 \"0% { opacity: 0; } 100% { opacity: 1; }\"]"],
      ~link="https://styled-ppx.vercel.app/reference/keyframe",
      "[%keyframe2] expects a string of CSS with keyframe definitions.",
    )
  };
};

let binding_name_from_pat = (pat: Ppxlib.pattern): option(string) =>
  switch (pat.ppat_desc) {
  | Ppat_var({ txt: name, _ }) => Some(name)
  | _ => None
  };

let register_string_binding = (~file, ~scope, ~name, expr: Ppxlib.expression) =>
  switch (expr.pexp_desc) {
  | Pexp_constant(Pconst_string(value, _, _)) =>
    Css_file.Class_registry.register(
      ~file,
      ~scope,
      ~name,
      ~classNames=[value],
    )
  | _ => ()
  };

let map_cx2_expressions =
    (~file, ~main_module, ~scope, ~opens, ~top_binding, expr) => {
  let rec map_with_label = (~label_name, expr) => {
    let mapper = {
      as self;
      inherit class Ppxlib.Ast_traverse.map as super;
      pub! expression = expr =>
        switch (expr.Ppxlib.pexp_desc) {
        | Pexp_extension(({ txt: "cx2", _ }, payload)) =>
          switch (payload_expr(payload)) {
          | Some(payload) =>
            expand_cx2_expression(
              ~file,
              ~main_module,
              ~scope,
              ~opens,
              ~label_name,
              ~registry_name=top_binding,
              payload,
            )
          | None => cx2_error_expr(~payload_loc=expr.pexp_loc)
          }
        | Pexp_extension(({ txt: "keyframe2", _ }, payload)) =>
          switch (payload_expr(payload)) {
          | Some(payload) => expand_keyframe2_expression(~file, payload)
          | None =>
            Error.raise(
              ~loc=expr.pexp_loc,
              ~examples=[
                "[%keyframe2 \"0% { opacity: 0; } 100% { opacity: 1; }\"]",
              ],
              ~link="https://styled-ppx.vercel.app/reference/keyframe",
              "[%keyframe2] expects a string of CSS with keyframe definitions.",
            )
          }
        | Pexp_let(rec_flag, bindings, body) =>
          let bindings =
            List.map(
              (binding: Ppxlib.value_binding) => {
                let label_name = binding_name_from_pat(binding.pvb_pat);
                let expr =
                  switch (label_name) {
                  | Some(name) =>
                    map_with_label(~label_name=Some(name), binding.pvb_expr)
                  | None => self#expression(binding.pvb_expr)
                  };
                {
                  ...binding,
                  pvb_expr: expr,
                };
              },
              bindings,
            );
          {
            ...expr,
            pexp_desc: Pexp_let(rec_flag, bindings, self#expression(body)),
          };
        | _ => super#expression(expr)
        }
    };
    mapper#expression(expr);
  };
  map_with_label(~label_name=top_binding, expr);
};

let module_path_from_expr = (expr: Ppxlib.module_expr): option(list(string)) =>
  switch (expr.pmod_desc) {
  | Pmod_ident({ txt: lid, _ }) => Some(longident_segments(lid))
  | _ => None
  };

let enclosing_scopes = (scope: list(string)): list(list(string)) => {
  let rec loop = (current, acc) =>
    switch (current) {
    | [] => List.rev([[], ...acc])
    | _ =>
      let parent = List.rev(List.tl(List.rev(current)));
      loop(parent, [current, ...acc]);
    };
  loop(scope, []);
};

let canonical_local_absolute_module_path = (~file, path) =>
  switch (Css_file.Class_registry.alias_target(~file, ~path)) {
  | Some(target)
      when Css_file.Class_registry.module_exists(~file, ~path=target) =>
    Some(target)
  | Some(_) => None
  | None when Css_file.Class_registry.module_exists(~file, ~path) =>
    Some(path)
  | None => None
  };

let canonical_local_module_path = (~file, ~scope, path) =>
  enclosing_scopes(scope)
  |> List.find_map(base_scope =>
       canonical_local_absolute_module_path(~file, base_scope @ path)
     );

let module_alias_target = (~file, ~scope, path) =>
  switch (canonical_local_module_path(~file, ~scope, path)) {
  | Some(local_path) => local_path
  | None => path
  };

let rec map_ordered_module_expr =
        (~file, ~main_module, ~scope, ~opens, expr: Ppxlib.module_expr) => {
  switch (expr.pmod_desc) {
  | Pmod_structure(items) =>
    let items = map_ordered_structure(~file, ~main_module, ~scope, items);
    {
      ...expr,
      pmod_desc: Pmod_structure(items),
    };
  | Pmod_constraint(inner, module_type) =>
    let inner =
      map_ordered_module_expr(~file, ~main_module, ~scope, ~opens, inner);
    {
      ...expr,
      pmod_desc: Pmod_constraint(inner, module_type),
    };
  | Pmod_functor(param, body) =>
    let body =
      map_ordered_module_expr(~file, ~main_module, ~scope, ~opens, body);
    {
      ...expr,
      pmod_desc: Pmod_functor(param, body),
    };
  | Pmod_extension(({ txt: "styled.global2", _ }, payload)) =>
    switch (payload_expr(payload)) {
    | Some(payload) => expand_global2_module(~file, ~scope, ~opens, payload)
    | None =>
      Builder.pmod_extension(
        ~loc=expr.pmod_loc,
        Ppxlib.Location.error_extensionf(
          ~loc=expr.pmod_loc,
          "[%%styled.global2] expects a string of CSS with selectors that apply to the whole document.\n\nExample:\n  module Reset = [%%styled.global2 \"body { margin: 0; }\"]",
        ),
      )
    }
  | _ => expr
  };
}

and map_ordered_structure = (~file, ~main_module, ~scope, items) => {
  let opens = ref([]);
  let map_item = (item: Ppxlib.structure_item) =>
    switch (item.pstr_desc) {
    | Pstr_value(rec_flag, bindings) =>
      let bindings =
        List.map(
          (binding: Ppxlib.value_binding) => {
            let name = binding_name_from_pat(binding.pvb_pat);
            let expr =
              map_cx2_expressions(
                ~file,
                ~main_module,
                ~scope,
                ~opens=opens^,
                ~top_binding=name,
                binding.pvb_expr,
              );
            switch (name) {
            | Some(name) =>
              register_string_binding(~file, ~scope, ~name, binding.pvb_expr)
            | None => ()
            };
            {
              ...binding,
              pvb_expr: expr,
            };
          },
          bindings,
        );
      {
        ...item,
        pstr_desc: Pstr_value(rec_flag, bindings),
      };
    | Pstr_module(binding) =>
      switch (binding.pmb_name.txt) {
      | Some(name) =>
        let module_scope = scope @ [name];
        switch (module_path_from_expr(binding.pmb_expr)) {
        | Some(target) =>
          Css_file.Class_registry.register_alias(
            ~file,
            ~scope,
            ~name,
            ~target=module_alias_target(~file, ~scope, target),
          )
        | None =>
          Css_file.Class_registry.register_module(~file, ~path=module_scope)
        };
        let expr =
          map_ordered_module_expr(
            ~file,
            ~main_module,
            ~scope=module_scope,
            ~opens=[],
            binding.pmb_expr,
          );
        {
          ...item,
          pstr_desc:
            Pstr_module({
              ...binding,
              pmb_expr: expr,
            }),
        };
      | None => item
      }
    | Pstr_open(open_decl) =>
      switch (module_path_from_expr(open_decl.popen_expr)) {
      | Some(path) =>
        switch (canonical_local_module_path(~file, ~scope, path)) {
        | Some(path) => opens := [path, ...opens^]
        | None => ()
        }
      | None => ()
      };
      item;
    | Pstr_include(include_decl) =>
      switch (module_path_from_expr(include_decl.pincl_mod)) {
      | Some(path) =>
        switch (canonical_local_module_path(~file, ~scope, path)) {
        | Some(path) =>
          Css_file.Class_registry.include_module(
            ~file,
            ~scope,
            ~module_path=path,
          )
        | None => ()
        }
      | None => ()
      };
      item;
    | Pstr_recmodule(bindings) =>
      let bindings =
        List.map(
          (binding: Ppxlib.module_binding) => {
            switch (binding.pmb_name.txt) {
            | Some(name) =>
              let module_scope = scope @ [name];
              Css_file.Class_registry.register_module(
                ~file,
                ~path=module_scope,
              );
              let expr =
                map_ordered_module_expr(
                  ~file,
                  ~main_module,
                  ~scope=module_scope,
                  ~opens=[],
                  binding.pmb_expr,
                );
              {
                ...binding,
                pmb_expr: expr,
              };
            | None => binding
            }
          },
          bindings,
        );
      {
        ...item,
        pstr_desc: Pstr_recmodule(bindings),
      };
    | Pstr_eval(expr, attrs) =>
      let expr =
        map_cx2_expressions(
          ~file,
          ~main_module,
          ~scope,
          ~opens=opens^,
          ~top_binding=None,
          expr,
        );
      {
        ...item,
        pstr_desc: Pstr_eval(expr, attrs),
      };
    | _ => item
    };
  List.map(map_item, items);
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
    let file =
      switch (str) {
      | [first, ..._] => first.pstr_loc.loc_start.pos_fname
      | [] => ""
      };
    let main_module = module_name_of_file(file);
    let str = map_ordered_structure(~file, ~main_module, ~scope=[], str);
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
