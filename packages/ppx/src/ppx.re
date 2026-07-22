module Builder = Ppxlib.Ast_builder.Default;

let _ =
  Ppxlib.Driver.add_arg(
    Settings.native.flag,
    Arg.Unit(_ => Settings.Update.native(true)),
    ~doc=Settings.native.doc,
  );

let type_check_rule_list = Css_validation.type_check_rule_list;
let get_errors = Css_validation.get_errors;
let error_to_string = Css_validation.error_to_string;

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

let make_refs_attribute = (entries: list(Cross_module_refs.entry)) =>
  entries
  |> List.map((entry: Cross_module_refs.entry) =>
       Css_extraction.ref_loc_of_location(
         ~longident=entry.longident,
         entry.loc,
       )
     )
  |> Css_extraction.refs_attribute;

let make_bindings_attribute = (entries: list(Css_bindings.entry)) =>
  entries
  |> List.map((entry: Css_bindings.entry) =>
       Css_extraction.binding(
         ~longident=entry.longident,
         ~class_string=entry.class_string,
       )
     )
  |> Css_extraction.bindings_attribute;

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
     Carrying the original [%css] location through here means
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

let css_error_expr = (~payload_loc) => {
  let examples =
    switch (File.get()) {
    | Some(Reason) => Some(["[%css \"display: block; color: red\"]"])
    | Some(OCaml) => Some(["[%css \"display: block; color: red\"]"])
    | None => None
    };
  Error.raise(
    ~loc=payload_loc,
    ~examples?,
    ~link="https://styled-ppx.vercel.app/reference/css",
    "[%css] expects a string of CSS for static extraction.",
  );
};

let record_css_binding = (~file, ~main_module, ~scope, ~name, ~classNames) => {
  Local_selector_environment.register(~file, ~scope, ~name, ~classNames);
  let longident = String.concat(".", [main_module, ...scope] @ [name]);
  let class_string = String.concat(" ", classNames);
  Css_bindings.record(~longident, ~class_string);
};

let expand_css_expression =
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
    let source_position_start =
      Styled_ppx_css_parser.Parser_location.source_position_start(
        ~delimiter,
        stringLoc,
      );
    switch (
      Styled_ppx_css_parser.Driver.parse_declaration_list(
        ~source_position_start,
        txt,
      )
    ) {
    | Ok(rule_list) =>
      let validations = type_check_rule_list(rule_list);
      switch (get_errors(validations)) {
      | [] =>
        let (classNames, dynamic_vars) =
          Css_file.push(
            ~file,
            ~scope,
            ~opens,
            ~source_position_start,
            ~label?,
            rule_list,
          );
        switch (registry_name) {
        | Some(name) =>
          record_css_binding(~file, ~main_module, ~scope, ~name, ~classNames)
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
                 Styled_ppx_css_parser.Parser_location.to_file_location(
                   ~source_position_start,
                   error_loc,
                 );
               (adjusted_loc, error_to_string(error));
             });
        switch (error_messages) {
        | [(loc, msg)] => Error.expr(~loc, msg)
        | _ =>
          Error.expressions(
            ~loc=stringLoc,
            ~description="Multiple errors on css definition",
            error_messages,
          )
        };
      };
    | Error((loc, msg)) => Error.expr(~loc, msg)
    };
  | _ => css_error_expr(~payload_loc=payload.pexp_loc)
  };
};

let expand_global_module = (~file, ~main_module, ~scope, ~opens, payload) => {
  open Ppxlib;
  File.set(file);
  switch (payload.pexp_desc) {
  | Pexp_constant(Pconst_string(txt, stringLoc, delimiter)) =>
    let source_position_start =
      Styled_ppx_css_parser.Parser_location.source_position_start(
        ~delimiter,
        stringLoc,
      );
    switch (
      Styled_ppx_css_parser.Driver.parse_declaration_list(
        ~source_position_start,
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
        let validations = type_check_rule_list(rule_list);
        switch (get_errors(validations)) {
        | [] =>
          let dynamic_vars =
            Css_file.push_global(
              ~file,
              ~main_module,
              ~scope,
              ~opens,
              ~source_position_start,
              rule_list,
            );
          let loc = stringLoc;
          let to_string_body =
            Css_global_to_string.render_root_block(~loc, dynamic_vars);
          let to_string_decl = [%stri
            let to_string = () => [%e to_string_body]
          ];
          let make_props_decl = [%stri
            [@warning "-27-32"]
            let makeProps = (~key=?, ()) => Js.Obj.empty()
          ];
          let make_decl = [%stri
            let make = _props => CSS.global_style_tag(to_string())
          ];
          Builder.pmod_structure(
            ~loc=stringLoc,
            [to_string_decl, make_props_decl, make_decl],
          );
        | errors =>
          let error_messages =
            errors
            |> List.map(((error_loc, error)) => {
                 let adjusted_loc =
                   Styled_ppx_css_parser.Parser_location.to_file_location(
                     ~source_position_start,
                     error_loc,
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
                  "Multiple errors on styled.global definition",
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
        "[%%styled.global] expects a string of CSS with selectors that apply to the whole document.\n\nExample:\n  module Reset = [%%styled.global \"body { margin: 0; }\"]",
      ),
    )
  };
};

let expand_keyframe_expression =
    (~file, ~main_module, ~scope, ~opens, payload: Ppxlib.expression) => {
  open Ppxlib;
  File.set(file);
  switch (payload.pexp_desc) {
  | Pexp_constant(Pconst_string(txt, stringLoc, delimiter)) =>
    let source_position_start =
      Styled_ppx_css_parser.Parser_location.source_position_start(
        ~delimiter,
        stringLoc,
      );
    switch (
      Styled_ppx_css_parser.Driver.parse_keyframes(
        ~source_position_start,
        txt,
      )
    ) {
    | Ok(declarations) =>
      let (keyframe_name, dynamic_vars) =
        Css_file.push_keyframe(
          ~file,
          ~main_module,
          ~scope,
          ~opens,
          ~source_position_start,
          declarations,
        );
      let loc = stringLoc;
      let keyframe_name_expr = Builder.estring(~loc, keyframe_name);
      switch (dynamic_vars) {
      | [] => [%expr CSS.Types.AnimationName.make([%e keyframe_name_expr])]
      | _ =>
        let var_list =
          Css_to_runtime.render_dynamic_var_list(~loc, dynamic_vars);
        [%expr
         CSS.Types.AnimationName.make(
           ~vars=[%e var_list],
           [%e keyframe_name_expr],
         )
        ];
      };
    | Error((loc, msg)) => Error.expr(~loc, msg)
    };
  | _ =>
    Error.raise(
      ~loc=payload.pexp_loc,
      ~examples=["[%keyframe \"0% { opacity: 0; } 100% { opacity: 1; }\"]"],
      ~link="https://styled-ppx.vercel.app/reference/keyframe",
      "[%keyframe] expects a string of CSS with keyframe definitions.",
    )
  };
};

let styled_tag = name => {
  let prefix = "styled.";
  let prefix_len = String.length(prefix);
  let name_len = String.length(name);

  if (name_len > prefix_len
      && String.sub(name, 0, prefix_len) == prefix
      && name != "styled.global") {
    let htmlTag = String.sub(name, prefix_len, name_len - prefix_len);
    List.mem(htmlTag, html_tags) ? Some(htmlTag) : None;
  } else {
    None;
  };
};

let styled_payload = (expr: Ppxlib.module_expr) =>
  switch (expr.pmod_desc) {
  | Pmod_extension(({ txt: extension_name, _ }, payload)) =>
    switch (styled_tag(extension_name), payload_expr(payload)) {
    | (Some(htmlTag), Some(payload)) => Some((htmlTag, payload))
    | _ => None
    }
  | _ => None
  };

let styled_error_module = (~loc, ~htmlTag) =>
  Builder.pmod_extension(
    ~loc,
    Ppxlib.Location.error_extensionf(
      ~loc,
      "[%%styled.%s] expects a string of CSS or a function returning a CSS string for static extraction.",
      htmlTag,
    ),
  );

let expand_styled_module =
    (~file, ~main_module, ~scope, ~opens, ~name, ~htmlTag, payload) => {
  open Ppxlib;
  File.set(file);
  let record_component_binding = classNames =>
    record_css_binding(~file, ~main_module, ~scope, ~name, ~classNames);

  switch (payload.pexp_desc) {
  | Pexp_constant(Pconst_string(txt, stringLoc, delimiter)) =>
    let source_position_start =
      Styled_ppx_css_parser.Parser_location.source_position_start(
        ~delimiter,
        stringLoc,
      );
    switch (
      Styled_ppx_css_parser.Driver.parse_declaration_list(
        ~source_position_start,
        txt,
      )
    ) {
    | Ok(rule_list) =>
      switch (get_errors(type_check_rule_list(rule_list))) {
      | [] =>
        let (classNames, dynamic_vars) =
          Css_file.push(
            ~file,
            ~scope,
            ~opens,
            ~source_position_start,
            /* Same gate as [%css]: the -<label> suffix is dev-only sugar.
               Keeping it in minify/production would fork atoms per binding
               name and break cross-binding dedup. */
            ~label=?{Settings.Get.minify() ? None : Some(name)},
            rule_list,
          );
        record_component_binding(classNames);
        let styles =
          Css_to_runtime.render_make_call(
            ~loc=stringLoc,
            ~marker=None,
            ~classNames,
            ~dynamic_vars,
          );
        Generate.staticComponent(~loc=stringLoc, ~htmlTag, styles);
      | errors =>
        let error_messages =
          errors
          |> List.map(((error_loc, error)) => {
               let adjusted_loc =
                 Styled_ppx_css_parser.Parser_location.to_file_location(
                   ~source_position_start,
                   error_loc,
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
                "Multiple errors on styled component definition",
              ),
            ),
          )
        };
      }
    | Error((loc, msg)) =>
      Builder.pmod_extension(
        ~loc,
        Location.error_extensionf(~loc, "%s", msg),
      )
    };
  | Pexp_function(
      [{ pparam_desc: Pparam_val(fnLabel, defaultValue, param), _ }],
      _,
      Pfunction_body(expression),
    ) =>
    Generate.dynamicExtractedComponent(
      ~loc=payload.pexp_loc,
      ~file,
      ~scope,
      ~opens,
      ~htmlTag,
      ~label=fnLabel,
      ~moduleName=name,
      ~defaultValue,
      ~param,
      ~body=expression,
      ~onClassNames=record_component_binding,
    )
  | _ => styled_error_module(~loc=payload.pexp_loc, ~htmlTag)
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
    Local_selector_environment.register(
      ~file,
      ~scope,
      ~name,
      ~classNames=[value],
    )
  | _ => ()
  };

let map_css_expressions =
    (~file, ~main_module, ~scope, ~opens, ~top_binding, expr) => {
  let rec map_with_label = (~label_name, expr) => {
    let mapper = {
      as self;
      inherit class Ppxlib.Ast_traverse.map as super;
      pub! expression = expr =>
        switch (expr.Ppxlib.pexp_desc) {
        | Pexp_apply(fn, args) =>
          let fn = self#expression(fn);
          let args =
            args
            |> List.map(((label, arg)) => (label, self#expression(arg)));
          Styles_attribute.expand({
            ...expr,
            pexp_desc: Pexp_apply(fn, args),
          });
        | Pexp_extension(({ txt: "css", _ }, payload)) =>
          switch (payload_expr(payload)) {
          | Some(payload) =>
            expand_css_expression(
              ~file,
              ~main_module,
              ~scope,
              ~opens,
              ~label_name,
              ~registry_name=top_binding,
              payload,
            )
          | None => css_error_expr(~payload_loc=expr.pexp_loc)
          }
        | Pexp_extension(({ txt: "keyframe", _ }, payload)) =>
          switch (payload_expr(payload)) {
          | Some(payload) =>
            expand_keyframe_expression(
              ~file,
              ~main_module,
              ~scope,
              ~opens,
              payload,
            )
          | None =>
            Error.raise(
              ~loc=expr.pexp_loc,
              ~examples=[
                "[%keyframe \"0% { opacity: 0; } 100% { opacity: 1; }\"]",
              ],
              ~link="https://styled-ppx.vercel.app/reference/keyframe",
              "[%keyframe] expects a string of CSS with keyframe definitions.",
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
  | Pmod_extension(({ txt: "styled.global", _ }, payload)) =>
    switch (payload_expr(payload)) {
    | Some(payload) =>
      expand_global_module(~file, ~main_module, ~scope, ~opens, payload)
    | None =>
      Builder.pmod_extension(
        ~loc=expr.pmod_loc,
        Ppxlib.Location.error_extensionf(
          ~loc=expr.pmod_loc,
          "[%%styled.global] expects a string of CSS with selectors that apply to the whole document.\n\nExample:\n  module Reset = [%%styled.global \"body { margin: 0; }\"]",
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
              map_css_expressions(
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
        let expr =
          switch (styled_payload(binding.pmb_expr)) {
          | Some((htmlTag, payload)) =>
            expand_styled_module(
              ~file,
              ~main_module,
              ~scope,
              ~opens=opens^,
              ~name,
              ~htmlTag,
              payload,
            )
          | None =>
            switch (module_path_from_expr(binding.pmb_expr)) {
            | Some(target) =>
              Local_selector_environment.register_alias(
                ~file,
                ~scope,
                ~name,
                ~target=
                  Local_selector_environment.module_alias_target(
                    ~file,
                    ~scope,
                    target,
                  ),
              )
            | None =>
              Local_selector_environment.register_module(
                ~file,
                ~path=module_scope,
              )
            };
            map_ordered_module_expr(
              ~file,
              ~main_module,
              ~scope=module_scope,
              ~opens=[],
              binding.pmb_expr,
            );
          };
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
        switch (
          Local_selector_environment.resolve_local_module_path(
            ~file,
            ~scope,
            path,
          )
        ) {
        | Some(path) => opens := [path, ...opens^]
        | None => ()
        }
      | None => ()
      };
      item;
    | Pstr_include(include_decl) =>
      switch (module_path_from_expr(include_decl.pincl_mod)) {
      | Some(path) =>
        switch (
          Local_selector_environment.resolve_local_module_path(
            ~file,
            ~scope,
            path,
          )
        ) {
        | Some(path) =>
          Local_selector_environment.include_module(
            ~file,
            ~scope,
            ~module_path=path,
          )
        | None => ()
        }
      | None => ()
      };
      let incl_mod =
        map_ordered_module_expr(
          ~file,
          ~main_module,
          ~scope,
          ~opens=[],
          include_decl.pincl_mod,
        );
      {
        ...item,
        pstr_desc:
          Pstr_include({
            ...include_decl,
            pincl_mod: incl_mod,
          }),
      };
    | Pstr_recmodule(bindings) =>
      let bindings =
        List.map(
          (binding: Ppxlib.module_binding) => {
            switch (binding.pmb_name.txt) {
            | Some(name) =>
              let module_scope = scope @ [name];
              Local_selector_environment.register_module(
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
        map_css_expressions(
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

  Ppxlib.Driver.add_arg(
    ~doc=Settings.env.doc,
    Settings.env.flag,
    Arg.Symbol(
      ["development", "production"],
      fun
      | "production" => Settings.Update.env(`Production)
      | _ => Settings.Update.env(`Development),
    ),
  );

  let impl = (_ctx, str: Ppxlib.structure) => {
    let file =
      switch (str) {
      | [first, ..._] => first.pstr_loc.loc_start.pos_fname
      | [] => ""
      };
    let main_module = module_name_of_file(file);
    let str = map_ordered_structure(~file, ~main_module, ~scope=[], str);
    let rules = Css_file.get();
    let rule_items = List.map(Css_extraction.css_attribute, rules);
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
    /* Declares production mode in the wire protocol so the aggregator can
       minify without a flag of its own; absence means development. */
    let config_items =
      switch (rule_items, bindings_items) {
      | ([], []) => []
      | _ when Settings.Get.minify() => [
          Css_extraction.config_attribute([("env", "production")]),
        ]
      | _ => []
      };
    /* Order:
       - extraction config (production marker)
       - extracted CSS rules
       - binding exports
       - cross-module refs descriptor
       - dep-tracking synthetic lets
       - user's source. */
    config_items @ rule_items @ bindings_items @ refs_items @ dep_items @ str;
  };

  Ppxlib.Driver.V2.register_transformation(
    ~impl,
    ~rules=[
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
