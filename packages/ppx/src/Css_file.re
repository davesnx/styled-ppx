type var_type =
  | Selector
  | MediaQuery
  /* Passthrough string interpolation for `--*: $(expr)` declarations in
     [%cx2] / [%styled.global2]. `expr` is required to be a [string] and is
     emitted verbatim in the value position - no `toString` wrap, no
     validation. This is the unsafe escape hatch for custom properties;
     when we later support typed custom properties (e.g. via
     `@property` / a codec registry) a new variant will sit next to this
     one and this one remains the "unknown / unsafe" fallback. */
  | CustomProperty
  | RuntimeModule(string);

let render_rule = Styled_ppx_css_parser.Render.rule;
let render_declaration = Styled_ppx_css_parser.Render.declaration;

/* Per-compilation-unit registry mapping each named [%cx2] expansion's lexical
   path to the list of atomized class names it minted. Selector interpolation in
   later [%cx2] blocks resolves `$(name)` against this registry so the literal
   placeholder never reaches the extracted CSS.

   The registry is keyed on (file_path, lexical_path); shadowing is handled by
   last-write-wins via Hashtbl.replace. Anonymous bindings (`let _ = ...`) are
   intentionally not registered. The registry is cleared whenever the
   accumulated CSS buffer is cleared (see `get` at the bottom of this file).

   This is intentionally a small PPX-time resolver, not a replacement for the
   compiler's typed environment. We model same-file module aliases, opens,
   includes, and literal string selectors seen earlier in the file; external
   opens/includes still require explicit module paths. */
module Class_registry = {
  let table: Hashtbl.t((string, string), list(string)) =
    Hashtbl.create(64);
  let local_modules: Hashtbl.t((string, string), unit) = Hashtbl.create(64);
  let aliases: Hashtbl.t((string, string), list(string)) =
    Hashtbl.create(32);

  let join_path = (segments: list(string)): string =>
    String.concat(".", segments);

  let prefixes = segments => {
    let rec loop = (current_rev, remaining, acc) =>
      switch (remaining) {
      | [] => List.rev(acc)
      | [segment, ...tail] =>
        let current = List.rev([segment, ...current_rev]);
        loop([segment, ...current_rev], tail, [current, ...acc]);
      };
    loop([], segments, []);
  };

  let register_module = (~file: string, ~path: list(string)) =>
    switch (path) {
    | [] => ()
    | _ => Hashtbl.replace(local_modules, (file, join_path(path)), ())
    };

  let register_alias =
      (
        ~file: string,
        ~scope: list(string),
        ~name: string,
        ~target: list(string),
      ) => {
    register_module(~file, ~path=scope @ [name]);
    Hashtbl.replace(aliases, (file, join_path(scope @ [name])), target);
  };

  let register =
      (
        ~file: string,
        ~scope: list(string),
        ~name: string,
        ~classNames: list(string),
      ) =>
    if (name != "_") {
      List.iter(path => register_module(~file, ~path), prefixes(scope));
      Hashtbl.replace(
        table,
        (file, join_path(scope @ [name])),
        classNames,
      );
    };

  let lookup = (~file: string, ~path: list(string)): option(list(string)) =>
    Hashtbl.find_opt(table, (file, join_path(path)));

  let module_exists = (~file: string, ~path: list(string)): bool =>
    Hashtbl.mem(local_modules, (file, join_path(path)));

  let alias_target =
      (~file: string, ~path: list(string)): option(list(string)) =>
    Hashtbl.find_opt(aliases, (file, join_path(path)));

  let include_module =
      (~file: string, ~scope: list(string), ~module_path: list(string)) => {
    let module_prefix = join_path(module_path);
    let module_prefix_with_dot = module_prefix ++ ".";
    let current_prefix = join_path(scope);
    let copied = ref([]);
    Hashtbl.iter(
      ((entry_file, entry_path), classNames) =>
        if (entry_file == file) {
          let suffix =
            if (entry_path == module_prefix) {
              Some("");
            } else if (String.length(entry_path)
                       > String.length(module_prefix_with_dot)
                       && String.sub(
                            entry_path,
                            0,
                            String.length(module_prefix_with_dot),
                          )
                       == module_prefix_with_dot) {
              Some(
                String.sub(
                  entry_path,
                  String.length(module_prefix_with_dot),
                  String.length(entry_path)
                  - String.length(module_prefix_with_dot),
                ),
              );
            } else {
              None;
            };
          switch (suffix) {
          | Some("") => ()
          | Some(suffix) =>
            let included_path =
              current_prefix == "" ? suffix : current_prefix ++ "." ++ suffix;
            copied := [(included_path, classNames), ...copied^];
          | None => ()
          };
        },
      table,
    );
    List.iter(
      ((included_path, classNames)) =>
        Hashtbl.replace(table, (file, included_path), classNames),
      copied^,
    );
  };

  let clear = () => {
    Hashtbl.clear(table);
    Hashtbl.clear(local_modules);
    Hashtbl.clear(aliases);
  };
};

module Buffer = {
  type rule = (string, string);
  let accumulated_rules: ref(list(rule)) = ref([]);
  let global_rules: ref(list(rule)) = ref([]);

  let add_to = (target, className, cssText) =>
    if (!List.exists(((existing, _)) => existing == className, target^)) {
      target := [(className, cssText), ...target^];
    };

  let add_rule = add_to(accumulated_rules);
  let add_global_rule = add_to(global_rules);

  let get_rules = () => {
    let dump = target => List.rev_map(((_, cssText)) => cssText, target^);
    dump(global_rules) @ dump(accumulated_rules);
  };

  let clear = () => {
    accumulated_rules := [];
    global_rules := [];
  };
};

module Css_transform = {
  open Styled_ppx_css_parser.Ast;

  let variable_to_css_var_name = (path_str: string) => {
    let hash = Murmur2.default(path_str);
    Printf.sprintf("var-%s", hash);
  };

  let variable_to_css_var_name_for_occurrence =
      (path_str: string, occurrence_index: int, total_occurrences: int) => {
    let var_name = variable_to_css_var_name(path_str);
    total_occurrences > 1
      ? Printf.sprintf("%s_%d", var_name, occurrence_index) : var_name;
  };

  /* Increment the count for [name] in an assoc list, returning the new
     count and the updated list. */
  let bump = (name, counts) => {
    let next = 1 + Option.value(List.assoc_opt(name, counts), ~default=0);
    (next, [(name, next), ...List.remove_assoc(name, counts)]);
  };

  let count_named_occurrences = names =>
    List.fold_left((counts, name) => snd(bump(name, counts)), [], names);

  let next_occurrence = (name, occurrences) => {
    let (next, updated) = bump(name, occurrences^);
    occurrences := updated;
    next;
  };

  let take_first_matching_name = (name, items) => {
    let rec loop = (before_rev, remaining) => {
      switch (remaining) {
      | [] => (None, List.rev(before_rev))
      | [(item_name, value) as item, ...tail] =>
        if (item_name == name) {
          (Some(value), List.rev_append(before_rev, tail));
        } else {
          loop([item, ...before_rev], tail);
        }
      };
    };

    loop([], items);
  };

  let add_dynamic_var = (dynamic_vars, dynamic_var) => {
    let (var_name, _, _) = dynamic_var;
    if (!
          List.exists(
            ((existing_var_name, _, _)) => existing_var_name == var_name,
            dynamic_vars^,
          )) {
      dynamic_vars := [dynamic_var, ...dynamic_vars^];
    };
  };

  let generate_class_from_content = (~label=?, content: string): string => {
    let hash = Murmur2.default(content);
    switch (label) {
    | Some(name) => Printf.sprintf("css-%s-%s", hash, name)
    | None => Printf.sprintf("css-%s", hash)
    };
  };

  let path_segments = (path_str: string): list(string) =>
    String.split_on_char('.', path_str);

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

  let module_path_of_ref = segments =>
    switch (List.rev(segments)) {
    | []
    | [_] => None
    | [_binding, ...module_rev] => Some(List.rev(module_rev))
    };

  let expand_alias = (~file, ~path) =>
    switch (Class_registry.alias_target(~file, ~path)) {
    | Some(target) => target
    | None => path
    };

  let is_self_module_ref = (~file, ~scope, ~base_scope, segments) =>
    switch (module_path_of_ref(segments)) {
    | None => false
    | Some(module_path) =>
      expand_alias(~file, ~path=base_scope @ module_path) == scope
    };

  let candidate_with_alias = (~file, path) =>
    switch (module_path_of_ref(path)) {
    | None => path
    | Some(module_path) =>
      switch (List.rev(path)) {
      | [] => path
      | [binding, ..._] =>
        expand_alias(~file, ~path=module_path) @ [binding]
      }
    };

  let local_candidates = (~file, ~scope, ~opens, segments) => {
    let lexical_candidates =
      enclosing_scopes(scope)
      |> List.filter_map(base_scope =>
           is_self_module_ref(~file, ~scope, ~base_scope, segments)
             ? None
             : Some(candidate_with_alias(~file, base_scope @ segments))
         );
    let open_candidates =
      opens
      |> List.map(open_path =>
           candidate_with_alias(
             ~file,
             expand_alias(~file, ~path=open_path) @ segments,
           )
         );
    lexical_candidates @ open_candidates;
  };

  let lookup_local_class_ref = (~file, ~scope, ~opens, path_str) => {
    let segments = path_segments(path_str);
    local_candidates(~file, ~scope, ~opens, segments)
    |> List.find_map(path => Class_registry.lookup(~file, ~path));
  };

  let ref_matches_local_module = (~file, ~scope, ~opens, path_str) => {
    let segments = path_segments(path_str);
    switch (module_path_of_ref(segments)) {
    | None => false
    | Some(module_path) =>
      let lexical_paths =
        enclosing_scopes(scope)
        |> List.map(base_scope =>
             expand_alias(~file, ~path=base_scope @ module_path)
           );
      let open_paths =
        opens
        |> List.map(open_path =>
             expand_alias(
               ~file,
               ~path=expand_alias(~file, ~path=open_path) @ module_path,
             )
           );
      lexical_paths
      @ open_paths
      |> List.exists(path =>
           path != scope && Class_registry.module_exists(~file, ~path)
         );
    };
  };

  /* Resolve a `$(name)` selector interpolation.

     Same-module references (`$(local)`) look up the per-file [%cx2] class
     registry and substitute actual class names directly into the CSS AST.
     No literal `$(...)` reaches extracted CSS and no phantom CSS custom
     property is emitted onto the runtime tuple.

     Dotted local references (`$(Css.marker)`) are resolved by walking the
     current lexical scope outward, matching the useful subset of OCaml's
     expression lookup that is available before typing.

     Cross-module references (`$(M.binding)`) cannot be resolved at PPX
     time â module M compiles separately. We record the reference
     in [Cross_module_refs] and substitute a NUL-delimited sentinel "class
     name" that survives CSS rendering verbatim. The post-build aggregator
     ([styled-ppx.generate]) scans rendered rules for these sentinels and
     replaces them with the real class chains it indexed from every
     module's post-PPX [.ml] file.

     Unresolved same-module refs still raise at PPX time. */
  let resolve_selector_class_ref =
      (
        ~file: string,
        ~scope: list(string),
        ~opens: list(list(string)),
        ~loc,
        path_str: string,
      ) => {
    switch (lookup_local_class_ref(~file, ~scope, ~opens, path_str)) {
    | Some(classNames) => classNames
    | None
        when
          String.contains(path_str, '.')
          && !ref_matches_local_module(~file, ~scope, ~opens, path_str) =>
      let segments = path_segments(path_str);
      let longident =
        switch (module_path_of_ref(segments), List.rev(segments)) {
        | (Some(module_path), [binding, ..._]) =>
          String.concat(
            ".",
            expand_alias(~file, ~path=module_path) @ [binding],
          )
        | _ => path_str
        };
      Cross_module_refs.record(~file, ~longident, ~loc);
      [Cross_module_refs.sentinel(longident)];
    | None =>
      Ppxlib.Location.raise_errorf(
        ~loc,
        "Selector interpolation `$(%s)` does not refer to a [%%cx2] binding or string literal earlier in this module.\n- If `%s` is bound to a [%%cx2] or string literal later in the file, reorder the bindings.\n- If `%s` is a computed string, inline the class name literally.\n- Otherwise, use [%%cx] for runtime substitution.",
        path_str,
        path_str,
        path_str,
      )
    };
  };

  let rec transform_component_value =
          (
            ~file: string,
            ~scope: list(string),
            ~opens: list(list(string)),
            cv: component_value,
            dynamic_vars: ref(list((string, string, var_type))),
            get_var_binding: string => (string, var_type),
          )
          : component_value => {
    let recurse = ((v, loc)) => (
      transform_component_value(
        ~file,
        ~scope,
        ~opens,
        v,
        dynamic_vars,
        get_var_binding,
      ),
      loc,
    );
    switch (cv) {
    | Variable(path_str, _loc) =>
      let (var_name, var_type) = get_var_binding(path_str);
      add_dynamic_var(dynamic_vars, (var_name, path_str, var_type));

      Function({
        name: ("var", Ppxlib.Location.none),
        kind: Function_kind_regular,
        body: (
          [(Ident("--" ++ var_name), Ppxlib.Location.none)],
          Ppxlib.Location.none,
        ),
      });
    | Function(
        { name: (fn_name, _), body: (body_values, body_loc), _ } as fn,
      )
        when fn_name == "url" =>
      /* CSS `url()` does not perform `var()` substitution: browsers consume
         the body as a literal token, so `url(var(--x))` resolves to the
         string "var(--x)" not the value the custom property holds. Allowing
         the recursive rewrite below would silently emit broken CSS (see
         documents/css-extraction.md). When the body contains an
         interpolation, reject with a clear error pointing the user at
         literal-string alternatives the static extractor can serialize
         correctly; otherwise fall through to the generic Function rewrite. */
      let interp_loc =
        List.find_map(
          ((inner: component_value, loc)) =>
            switch (inner) {
            | Variable(_, _) => Some(loc)
            | _ => None
            },
          body_values,
        );
      switch (interp_loc) {
      | Some(loc) =>
        Ppxlib.Location.raise_errorf(
          ~loc,
          "Interpolation inside `url(...)` is not supported: browsers don't substitute `var()` there.\n- Inline the URL: `url(\"/path/to/asset\")`.\n- Or interpolate the whole value: `src: $(font_src)`.",
        )
      | None =>
        Function({
          ...fn,
          body: (List.map(recurse, body_values), body_loc),
        })
      };
    | Function({ name, kind, body: (body_values, body_loc) }) =>
      Function({
        name,
        kind,
        body: (List.map(recurse, body_values), body_loc),
      })
    | Paren_block(values) => Paren_block(List.map(recurse, values))
    | Bracket_block(values) => Bracket_block(List.map(recurse, values))
    | Selector(selector_list) =>
      let recurse_sel = ((sel, loc)) => (
        transform_selector(~file, ~scope, ~opens, sel, dynamic_vars),
        loc,
      );
      Selector(List.map(recurse_sel, selector_list));
    | _ => cv
    };
  }

  and transform_selector =
      (~file, ~scope, ~opens, sel: selector, dynamic_vars) => {
    switch (sel) {
    | SimpleSelector(simple) =>
      transform_simple_selector_to_selector(
        ~file,
        ~scope,
        ~opens,
        simple,
        dynamic_vars,
      )
    | ComplexSelector(complex) =>
      ComplexSelector(
        transform_complex_selector(
          ~file,
          ~scope,
          ~opens,
          complex,
          dynamic_vars,
        ),
      )
    | CompoundSelector(compound) =>
      CompoundSelector(
        transform_compound_selector(
          ~file,
          ~scope,
          ~opens,
          compound,
          dynamic_vars,
        ),
      )
    | RelativeSelector(relative) =>
      RelativeSelector({
        ...relative,
        complex_selector:
          transform_complex_selector(
            ~file,
            ~scope,
            ~opens,
            relative.complex_selector,
            dynamic_vars,
          ),
      })
    };
  }

  and transform_complex_selector =
      (~file, ~scope, ~opens, complex: complex_selector, dynamic_vars) => {
    switch (complex) {
    | Selector(sel) =>
      Selector(transform_selector(~file, ~scope, ~opens, sel, dynamic_vars))
    | Combinator({ left, right }) =>
      Combinator({
        left: transform_selector(~file, ~scope, ~opens, left, dynamic_vars),
        right:
          List.map(
            ((combinator, sel)) =>
              (
                combinator,
                transform_selector(~file, ~scope, ~opens, sel, dynamic_vars),
              ),
            right,
          ),
      })
    };
  }

  /* Resolve `ClassVariable(name)` (i.e. `.$(name)`) by replacing it with
     the chain of `Class(c)` subclass selectors corresponding to the
     classNames the referenced [%cx2] binding minted. Multi-declaration
     bindings expand to a compound chain (`&.cssA.cssB`) which matches the
     "AND" semantics: every consumer of the referenced binding has all of
     its atomized classes applied to the same element. */
  and transform_compound_selector =
      (~file, ~scope, ~opens, compound: compound_selector, dynamic_vars) => {
    let transformed_type_selector =
      Option.map(
        simple =>
          transform_simple_selector(
            ~file,
            ~scope,
            ~opens,
            simple,
            dynamic_vars,
          ),
        compound.type_selector,
      );
    let transformed_subclasses =
      compound.subclass_selectors
      |> List.concat_map(subclass =>
           transform_subclass_selector_to_list(
             ~file,
             ~scope,
             ~opens,
             subclass,
             dynamic_vars,
           )
         );
    let transformed_pseudos =
      compound.pseudo_selectors
      |> List.map(pseudo =>
           transform_pseudo_selector(
             ~file,
             ~scope,
             ~opens,
             pseudo,
             dynamic_vars,
           )
         );
    {
      type_selector: transformed_type_selector,
      subclass_selectors: transformed_subclasses,
      pseudo_selectors: transformed_pseudos,
    };
  }

  /* Rewrite a `simple_selector` in compound-internal position (slotted
     into `type_selector`). The selector-wrapping variant below is
     `transform_simple_selector_to_selector`. */
  and transform_simple_selector =
      (~file, ~scope, ~opens, simple: simple_selector, _dynamic_vars)
      : simple_selector => {
    switch (simple) {
    | Variable(path_str, var_loc) =>
      /* Bare `$(name)` (no `.` prefix) in selector position. We treat it
         like an implicit class reference and resolve to the first minted
         className as a `Type` selector if there's exactly one; otherwise
         this case is ambiguous - fall through to error. We emit a
         `Type(..)` rather than `Class(..)` because the user wrote no `.`,
         so the resolved value must serve as the type-selector slot. The
         caller (`transform_compound_selector`) only places this in the
         `type_selector` slot, never in `subclass_selectors`. */
      let resolved =
        resolve_selector_class_ref(
          ~file,
          ~scope,
          ~opens,
          ~loc=var_loc,
          path_str,
        );
      switch (resolved) {
      | [single] => Type("." ++ single)
      | _ =>
        Ppxlib.Location.raise_errorf(
          ~loc=var_loc,
          "Bare `$(%s)` selector interpolation expanded to %d class names; this position only accepts a single class. Prefix with `.` to use a class chain instead: `.$(%s)`.",
          path_str,
          List.length(resolved),
          path_str,
        )
      };
    | _ => simple
    };
  }

  /* When a `simple_selector` appears outside a compound (i.e. as a
     `SimpleSelector(...)` whole-selector wrapping it), we still need to
     express the resolution. Same lookup, wraps the result. */
  and transform_simple_selector_to_selector =
      (~file, ~scope, ~opens, simple: simple_selector, dynamic_vars): selector => {
    switch (simple) {
    | Variable(_, _) =>
      SimpleSelector(
        transform_simple_selector(
          ~file,
          ~scope,
          ~opens,
          simple,
          dynamic_vars,
        ),
      )
    | _ => SimpleSelector(simple)
    };
  }

  /* `transform_subclass_selector_to_list` returns a *list* of subclass
     selectors so `ClassVariable` can fan out into a compound chain
     (`.cssA.cssB`) for multi-declaration source bindings. */
  and transform_subclass_selector_to_list =
      (~file, ~scope, ~opens, subclass: subclass_selector, dynamic_vars)
      : list(subclass_selector) => {
    switch (subclass) {
    | ClassVariable(path_str, var_loc) =>
      let classNames =
        resolve_selector_class_ref(
          ~file,
          ~scope,
          ~opens,
          ~loc=var_loc,
          path_str,
        );
      List.map(c => Class(c), classNames);
    | Pseudo_class(pseudo) => [
        Pseudo_class(
          transform_pseudo_selector(
            ~file,
            ~scope,
            ~opens,
            pseudo,
            dynamic_vars,
          ),
        ),
      ]
    | _ => [subclass]
    };
  }

  /* Pseudo-classes like `:not(...)`, `:is(...)`, `:where(...)`,
     `:has(...)`, `:nth-child(of ...)` etc. carry nested selector lists.
     Recurse into the payload so `:not(&.$(foo))` resolves the same way as
     a top-level `&.$(foo)`. */
  and transform_pseudo_selector =
      (~file, ~scope, ~opens, pseudo: pseudo_selector, dynamic_vars)
      : pseudo_selector => {
    switch (pseudo) {
    | Pseudoelement(_) => pseudo
    | Pseudoclass(kind) =>
      Pseudoclass(
        transform_pseudoclass_kind(~file, ~scope, ~opens, kind, dynamic_vars),
      )
    };
  }

  and transform_pseudoclass_kind =
      (~file, ~scope, ~opens, kind: pseudoclass_kind, dynamic_vars)
      : pseudoclass_kind => {
    switch (kind) {
    | PseudoIdent(_) => kind
    | Function({ name, payload: (selector_list, payload_loc) }) =>
      let transformed =
        List.map(
          ((sel, sel_loc)) =>
            (
              transform_selector(~file, ~scope, ~opens, sel, dynamic_vars),
              sel_loc,
            ),
          selector_list,
        );
      Function({
        name,
        payload: (transformed, payload_loc),
      });
    | NthFunction({ name, payload: (nth_payload, payload_loc) }) =>
      let transformed_payload =
        switch (nth_payload) {
        | Nth(_) => nth_payload
        | NthSelector(complex_selectors) =>
          NthSelector(
            List.map(
              c =>
                transform_complex_selector(
                  ~file,
                  ~scope,
                  ~opens,
                  c,
                  dynamic_vars,
                ),
              complex_selectors,
            ),
          )
        };
      NthFunction({
        name,
        payload: (transformed_payload, payload_loc),
      });
    };
  };

  let transform_declaration =
      (~file, ~scope, ~opens, decl: declaration, dynamic_vars) => {
    let (property_name, _) = decl.name;
    let (value_list, value_loc) = decl.value;

    let interpolation_types =
      Css_grammar.infer_interpolation_types(~name=property_name, value_list);

    let interpolation_occurrences =
      interpolation_types
      |> List.map(((name, _)) => name)
      |> count_named_occurrences;
    let seen_interpolations = ref([]);
    let remaining_interpolation_types = ref(interpolation_types);

    let get_var_binding = var_name => {
      let occurrence_index = next_occurrence(var_name, seen_interpolations);
      let total_occurrences =
        switch (List.assoc_opt(var_name, interpolation_occurrences)) {
        | Some(count) => count
        | None => 1
        };
      let css_var_name =
        variable_to_css_var_name_for_occurrence(
          var_name,
          occurrence_index,
          total_occurrences,
        );
      let (type_path, remaining_types) =
        switch (
          take_first_matching_name(var_name, remaining_interpolation_types^)
        ) {
        | (Some(type_path), remaining_types) => (type_path, remaining_types)
        | (None, remaining_types) => ("", remaining_types)
        };
      remaining_interpolation_types := remaining_types;

      let is_custom_property =
        String.length(property_name) >= 2
        && String.sub(property_name, 0, 2) == "--";

      let var_type =
        if (is_custom_property) {
          CustomProperty;
        } else {
          RuntimeModule(
            Property_to_types.resolve_module_name(~type_path, ~property_name),
          );
        };

      (css_var_name, var_type);
    };

    let transformed_values =
      List.map(
        ((cv, loc)) =>
          (
            transform_component_value(
              ~file,
              ~scope,
              ~opens,
              cv,
              dynamic_vars,
              get_var_binding,
            ),
            loc,
          ),
        value_list,
      );
    {
      ...decl,
      value: (transformed_values, value_loc),
    };
  };

  let rec transform_rule = (~file, ~scope, ~opens, rule: rule, dynamic_vars) => {
    switch (rule) {
    | Declaration(decl) =>
      Declaration(
        transform_declaration(~file, ~scope, ~opens, decl, dynamic_vars),
      )
    | Style_rule(style_rule) =>
      Style_rule(
        transform_style_rule(~file, ~scope, ~opens, style_rule, dynamic_vars),
      )
    | At_rule(at_rule) =>
      At_rule(
        transform_at_rule(~file, ~scope, ~opens, at_rule, dynamic_vars),
      )
    };
  }

  and transform_style_rule =
      (~file, ~scope, ~opens, style_rule: style_rule, dynamic_vars) => {
    let { prelude, block, loc } = style_rule;
    let (selector_list, selector_loc) = prelude;
    let transformed_selectors =
      List.map(
        ((sel, sel_loc)) =>
          (
            transform_selector(~file, ~scope, ~opens, sel, dynamic_vars),
            sel_loc,
          ),
        selector_list,
      );
    let (rule_list, rule_loc) = block;
    let transformed_rules =
      List.map(
        rule => transform_rule(~file, ~scope, ~opens, rule, dynamic_vars),
        rule_list,
      );
    {
      prelude: (transformed_selectors, selector_loc),
      block: (transformed_rules, rule_loc),
      loc,
    };
  }

  and transform_at_rule =
      (~file, ~scope, ~opens, at_rule: at_rule, dynamic_vars) => {
    let { name, prelude, block, loc } = at_rule;
    let (prelude_values, prelude_loc) = prelude;

    /* Detect any `$(name)` interpolation anywhere in the at-rule prelude.
       The naive check (top-level only) misses interpolations nested inside
       `Paren_block`, `Bracket_block`, or `Function` — e.g. the canonical
       `@media (max-width: $(bp))` form, where `$(bp)` lives inside a
       `Paren_block` of the `(max-width: $(bp))` group.

       Static extraction can't bind `var(--x)` into a media query (CSS
       custom properties are not valid in media-query conditions), so we
       reject the whole shape with a hard error and steer users at [%cx] /
       [%styled.global] for runtime media-query interpolation. */
    let rec component_has_interpolation = (cv: component_value) =>
      switch (cv) {
      | Variable(_, _) => true
      | Paren_block(values)
      | Bracket_block(values) => list_has_interpolation(values)
      | Function({ body: (values, _), _ }) => list_has_interpolation(values)
      | _ => false
      }
    and list_has_interpolation = values =>
      List.exists(((cv, _loc)) => component_has_interpolation(cv), values);

    let has_interpolation = list_has_interpolation(prelude_values);

    if (has_interpolation) {
      let (at_name, _) = name;
      Ppxlib.Location.raise_errorf(
        ~loc,
        "Interpolation in @%s preludes is not supported during static extraction. CSS custom properties (var()) are not valid in media query conditions. Inline the value directly, or use [%%cx] / [%%styled.global] (runtime) instead of [%%cx2] / [%%styled.global2] for runtime media query interpolation.",
        at_name,
      );
    };

    let map_payload = ((rules, rule_loc)) => (
      List.map(
        r => transform_rule(~file, ~scope, ~opens, r, dynamic_vars),
        rules,
      ),
      rule_loc,
    );
    let transformed_block =
      switch (block) {
      | Empty => Empty
      | Rule_list(payload) => Rule_list(map_payload(payload))
      | Stylesheet(payload) => Stylesheet(map_payload(payload))
      };
    {
      name,
      prelude: (prelude_values, prelude_loc),
      block: transformed_block,
      loc,
    };
  };

  /* Detect whether `selector` starts with a pseudo-only compound and
     contains no `&` anywhere. Such selectors are spec-correct (per
     CSS Nesting Level 1 §3.1 they descendant-join with the parent),
     but the descendant interpretation almost never matches author
     intent at the top of an atomization context: `.X :hover` matches
     descendants of `.X` when hovered, not `.X` itself when hovered.

     Walks past `ComplexSelector(Selector(_))` wrappers and the `left`
     of `Combinator`s to find the leading compound. Returns `true`
     iff the leading compound has `type_selector = None`, every
     subclass selector is a `Pseudo_class`, and the compound has at
     least one pseudo (subclass or pseudo-element). Mixed compounds
     like `:hover.foo` (which contain a `Class`) are not flagged
     because the author has clearly written a more specific selector.

     `&:hover`, `&[disabled]`, `& :hover`, etc. all contain `&` and
     so are accepted unchanged via the `replace_ampersand` path. */
  let rec leading_compound = sel =>
    switch (sel) {
    | CompoundSelector(c) => Some(c)
    | ComplexSelector(Selector(inner)) => leading_compound(inner)
    | ComplexSelector(Combinator({ left, _ })) => leading_compound(left)
    | _ => None
    };

  let is_bare_leading_pseudo = (sel: selector): bool =>
    if (Styled_ppx_css_parser.Selector_nesting.contains_ampersand(sel)) {
      false;
    } else {
      switch (leading_compound(sel)) {
      | Some({ type_selector: None, subclass_selectors, pseudo_selectors }) =>
        let all_pseudo_class =
          List.for_all(
            fun
            | Pseudo_class(_) => true
            | _ => false,
            subclass_selectors,
          );
        let has_some_pseudo =
          subclass_selectors != [] || pseudo_selectors != [];
        all_pseudo_class && has_some_pseudo;
      | _ => false
      };
    };

  let raise_bare_leading_pseudo_error = (~loc, sel) => {
    let rendered = Styled_ppx_css_parser.Render.selector(sel);
    Ppxlib.Location.raise_errorf(
      ~loc,
      "Bare leading pseudo selector `%s` is ambiguous in nested CSS. Per CSS Nesting Level 1 §3.1 it descendant-joins with the enclosing selector (producing `<parent> %s`), which matches descendants rather than the element itself. Write `&%s` for compound (`<parent>%s`, the usual intent), or `& %s` to opt into the explicit descendant form.",
      rendered,
      rendered,
      rendered,
      rendered,
      rendered,
    );
  };

  let atomize_rules = (~label=?, rules: list(rule)): list((string, rule)) => {
    /* Merge a child selector-list prelude under a parent selector-list prelude.
       For each (parent, child) pair, run `compute_new_prefix` so `&`,
       `::pseudo`, and descendant combinators all resolve correctly. The
       Cartesian product matches CSS-nesting semantics:
       `a, b { c, d { ... } }` desugars to `a c, a d, b c, b d`.

       Folded with prepend then reversed once at the end — equivalent
       output to the prior `concat_map`/`map` combination but avoids the
       per-parent intermediate list and the final concat pass. */
    let merge_preludes =
        (
          ~parent: list((selector, Ppxlib.Location.t)),
          ~child: list((selector, Ppxlib.Location.t)),
        ) => {
      List.fold_left(
        (acc, (parent_sel, _parent_loc)) =>
          List.fold_left(
            (acc, (child_sel, child_loc)) => {
              let merged =
                Styled_ppx_css_parser.Selector_nesting.compute_new_prefix(
                  ~prefix=Some(parent_sel),
                  child_sel,
                );
              [(merged, child_loc), ...acc];
            },
            acc,
            child,
          ),
        [],
        parent,
      )
      |> List.rev;
    };

    /* Wrap a `Declaration` atom under an accumulated selector chain. With no
       parent we leave it bare so `Transform.run` later attaches the binding's
       className. With a parent, we emit one atom per parent selector — each
       atom is a `Style_rule` carrying that single selector as its prelude.
       `Transform.run` will then prefix it with the className correctly, so
       the chain survives even through enclosing at-rules.

       Splitting one atom per parent selector matches CSS-nesting semantics
       (`a, b { c: d }` desugars to `a { c: d } b { c: d }`) and works
       around the fact that the downstream `Transform.unnest_selectors` /
       `Resolve.unnest_selectors` only consume the first selector of a
       prelude list. */
    let wrap_declaration_under_parent = (~parent_prelude=?, decl) => {
      switch (parent_prelude) {
      | None =>
        let decl_string = render_declaration(decl);
        let className = generate_class_from_content(~label?, decl_string);
        [(className, Declaration(decl))];
      | Some(parent_selectors) =>
        List.map(
          ((parent_sel, parent_loc)) => {
            let style_rule =
              Style_rule({
                prelude: ([(parent_sel, parent_loc)], parent_loc),
                block: ([Declaration(decl)], Ppxlib.Location.none),
                loc: Ppxlib.Location.none,
              });
            let rule_string = render_rule(style_rule);
            let className = generate_class_from_content(~label?, rule_string);
            (className, style_rule);
          },
          parent_selectors,
        )
      };
    };

    let rec extract_atomic_rules =
            (~parent_prelude=?, rule: rule): list((string, rule)) => {
      switch (rule) {
      | Declaration(decl) =>
        wrap_declaration_under_parent(~parent_prelude?, decl)

      | Style_rule({
          prelude: (child_selectors, _),
          block: (rules, _),
          loc: _,
        }) =>
        /* CSS Nesting Level 1 §3.1 desugars a bare leading pseudo
           selector via descendant combinator, so `:hover { ... }` and
           `::after { ... }` produce `<parent> :hover` / `<parent>
           ::after`. That's almost never what authors want; the typical
           intent is the compound form (`<parent>:hover` / `<parent>::after`).
           Reject these with a precise location and steer authors toward
           `&:hover` (compound) or `& :hover` (explicit descendant).

           The check runs at every nesting level (with or without a
           parent prelude) because the same footgun applies whether the
           parent is the implicit className or another selector. */
        List.iter(
          ((sel, sel_loc)) =>
            if (is_bare_leading_pseudo(sel)) {
              raise_bare_leading_pseudo_error(~loc=sel_loc, sel);
            },
          child_selectors,
        );
        /* Merge any accumulated parent prelude into this Style_rule's
           selector list. At the top level (no parent) this preserves the
           original prelude verbatim, including multi-selector lists. */
        let effective_selectors =
          switch (parent_prelude) {
          | None => child_selectors
          | Some(parent) => merge_preludes(~parent, ~child=child_selectors)
          };
        rules
        |> List.concat_map(
             extract_atomic_rules(~parent_prelude=effective_selectors),
           );

      | At_rule({ name, prelude, block, loc }) =>
        switch (block) {
        | Empty =>
          let at_string = render_rule(rule);
          let className = generate_class_from_content(~label?, at_string);
          [(className, rule)];

        /* Both Rule_list and Stylesheet payloads are atomized the same way:
           recurse into the inner rules, then re-wrap each atom in a fresh
           `At_rule(... Rule_list ...)`. We normalize Stylesheet → Rule_list
           on output because each atom carries exactly one inner rule.

           The accumulated parent prelude is threaded through so that any
           Style_rule (or bare Declaration) nested inside an at-rule still
           carries the full selector chain. The Declaration arm above turns
           a bare Declaration with a parent into a Style_rule, which is what
           lets `.a .b { @media (...) { color: red } }` render correctly as
           `@media (...) { .css-X .a .b { color:red } }`. */
        | Rule_list((rules, rule_loc))
        | Stylesheet((rules, rule_loc)) =>
          rules
          |> List.concat_map(extract_atomic_rules(~parent_prelude?))
          |> List.map(((_className, inner_rule)) => {
               let wrapped =
                 At_rule({
                   name,
                   prelude,
                   block: Rule_list(([inner_rule], rule_loc)),
                   loc,
                 });
               let wrapped_string = render_rule(wrapped);
               let new_className =
                 generate_class_from_content(~label?, wrapped_string);
               (new_className, wrapped);
             })
        }
      };
    };

    List.concat_map(extract_atomic_rules(~parent_prelude=?None), rules);
  };

  let transform_rule_list =
      (
        ~file,
        ~scope: list(string),
        ~opens: list(list(string)),
        ~label=?,
        rule_list: rule_list,
      ) => {
    let dynamic_vars = ref([]);
    let (rules, loc) = rule_list;

    let atomic_rules = atomize_rules(~label?, rules);

    let processed_rules =
      atomic_rules
      |> List.map(((className, rule)) => {
           let single_rule_list = ([rule], loc);

           let transformed =
             switch (rule) {
             | Declaration(decl) =>
               let wrapped =
                 Style_rule({
                   prelude: (
                     [
                       (
                         CompoundSelector({
                           type_selector: None,
                           subclass_selectors: [Class(className)],
                           pseudo_selectors: [],
                         }),
                         Ppxlib.Location.none,
                       ),
                     ],
                     Ppxlib.Location.none,
                   ),
                   block: ([Declaration(decl)], Ppxlib.Location.none),
                   loc: Ppxlib.Location.none,
                 });
               [wrapped];

             | Style_rule(_)
             | At_rule(_) =>
               Styled_ppx_css_parser.Transform.run(
                 ~className,
                 single_rule_list,
               )
             };

           transformed
           |> List.map(r =>
                transform_rule(~file, ~scope, ~opens, r, dynamic_vars)
              )
           |> List.map(r => (className, r));
         })
      |> List.concat;

    (processed_rules, List.rev(dynamic_vars^));
  };
};

/* Empty `[%cx2 {||}]` bound to a named `let` mints a deterministic
   class handle (`css-<hash-of-empty>-<label>`) so consumers can
   resolve `&.$(name)` against it. No `[@@@css ...]` is emitted —
   there's no rule to write. Anonymous (`_`) and statement-position
   bindings return `[]`, preserving the historical `CSS.make("", [])`
   shape. */
let mint_empty_class = (~label) =>
  switch (label) {
  | Some(name) when name != "_" => [
      Css_transform.generate_class_from_content(~label=name, ""),
    ]
  | _ => []
  };

let push =
    (
      ~file,
      ~scope: list(string),
      ~opens: list(list(string)),
      ~label=?,
      declarations: Styled_ppx_css_parser.Ast.rule_list,
    ) => {
  let (atomic_classnames, dynamic_vars) =
    Css_transform.transform_rule_list(
      ~file,
      ~scope,
      ~opens,
      ~label?,
      declarations,
    );

  let classNames =
    switch (atomic_classnames) {
    | [] => mint_empty_class(~label)
    | _ =>
      atomic_classnames
      |> List.map(((className, rule)) => {
           let rendered_css = render_rule(rule);
           Buffer.add_rule(className, rendered_css);
           className;
         })
    };

  (classNames, dynamic_vars);
};

let push_keyframe = (keyframe_rules: Styled_ppx_css_parser.Ast.rule_list) => {
  open Styled_ppx_css_parser.Ast;

  let (rules, _) = keyframe_rules;
  let rendered_body = rules |> List.map(render_rule) |> String.concat(" ");

  let keyframe_name =
    Printf.sprintf("keyframe-%s", Murmur2.default(rendered_body));

  let at_rule: at_rule = {
    name: ("keyframes", Ppxlib.Location.none),
    prelude: (
      [(Ident(keyframe_name), Ppxlib.Location.none)],
      Ppxlib.Location.none,
    ),
    block: Rule_list(keyframe_rules),
    loc: Ppxlib.Location.none,
  };

  let rendered_keyframe = render_rule(At_rule(at_rule));

  Buffer.add_rule(keyframe_name, rendered_keyframe);

  keyframe_name;
};

/* Walk every rule in a [%styled.global2] block, substitute
   `$(expr)` interpolations with `var(--var-<hash>)` on the static
   side, and accumulate the corresponding dynamic_vars.

   Each rule (whether or not it contains interpolation) is pushed to
   `Buffer.add_global_rule` so it ships through the existing
   `[@@@css ...]` channel. The returned dynamic_vars feeds the
   generated module's `to_string`, which emits a single
   `:root { --var-<hash>: <value>; ... }` block at runtime; one
   declaration per dynamic_var entry (already deduplicated by
   `Css_transform.add_dynamic_var`).

   Static-only blocks return an empty dynamic_vars list, which makes
   `to_string` emit `""`. */
let push_global =
    (
      ~file,
      ~scope: list(string),
      ~opens: list(list(string)),
      global_rules: Styled_ppx_css_parser.Ast.rule_list,
    )
    : list((string, string, var_type)) => {
  open Styled_ppx_css_parser.Ast;

  let (rules, _) = global_rules;
  let all_dynamic_vars = ref([]);

  /* Flatten CSS-nesting before rendering. `[%styled.global2]` previously
     emitted literal nesting (`body { .child { ... } }`), which only
     resolves correctly in modern browsers and is not always polyfilled
     by build chains. `Resolve.resolve_selectors` is the same pipeline
     `[%cx]` uses to lower nested rules into flat selectors
     (`body .child { ... }`) — strict superset of nesting's browser
     support, semantically identical for the shapes the parser admits.

     Multi-selector preludes Cartesian-product correctly (`a, b { c {...} }`
     -> `a c { ... } b c { ... }`) because `resolve_selectors` calls
     `split_multiple_selectors` before unnesting. */
  let flattened_rules =
    Styled_ppx_css_parser.Resolve.resolve_selectors(rules);

  /* transform_rule walks the rule, replacing every Variable(path) in
     declaration values with var(--hash) and appending (var_name, path,
     var_type) to all_dynamic_vars.

     The caller in [ppx.re] pre-checks the rule list for top-level
     Declaration nodes and bails before invoking this function, so the
     Declaration arm here is unreachable in practice. We keep it as a
     defensive no-op rather than partial-matching, so a future caller
     bypassing the pre-check still produces well-formed CSS instead of
     raising. */
  flattened_rules
  |> List.iter(rule =>
       switch (rule) {
       | Style_rule(_)
       | At_rule(_) =>
         let transformed =
           Css_transform.transform_rule(
             ~file,
             ~scope,
             ~opens,
             rule,
             all_dynamic_vars,
           );
         let rendered = render_rule(transformed);
         let key = Printf.sprintf("global-%s", Murmur2.default(rendered));
         Buffer.add_global_rule(key, rendered);
       | Declaration(_) => ()
       }
     );

  List.rev(all_dynamic_vars^);
};

let get = () => {
  let rules = Buffer.get_rules();
  Buffer.clear();
  Class_registry.clear();
  rules;
};
