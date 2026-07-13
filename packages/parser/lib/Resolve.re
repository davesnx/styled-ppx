open Ast;

let loc_none = Ppxlib.Location.none;

let split_by_kind = Selector_nesting.split_by_kind;

/* Order-preserving CSS-nesting flattener: lowers nested CSS into flat,
   source-ordered rules (source order = cascade order). `@media` hoists
   to the top and combines when statically safe, otherwise stays
   literally nested. Empty rules are dropped; blockless at-rules are
   not. */

/* Blocks hold descriptors/keyframe selectors, not style rules:
   pass through verbatim. */
let is_descriptor_at_rule = name =>
  switch (String.lowercase_ascii(name)) {
  | "keyframes"
  | "font-face"
  | "property"
  | "counter-style"
  | "page"
  | "font-palette-values"
  | "font-feature-values" => true
  | _ => false
  };

let style_rule = (~prefix: selector, rules: list(rule)) =>
  Style_rule({
    prelude: ([(prefix, loc_none)], loc_none),
    block: (rules, loc_none),
    loc: loc_none,
  });

/* `loc: snd(prelude)` keeps diagnostics pointing into the user's CSS. */
let media_rule = (~prelude, rules: list(rule)) =>
  At_rule({
    name: ("media", loc_none),
    prelude,
    block: Rule_list((rules, loc_none)),
    loc: snd(prelude),
  });

/* Prelude equality by rendered form (ignores locations). */
let media_preludes_equal = ((left, _), (right, _)) =>
  Render.component_value_list(Render.strip_leading_whitespace(left))
  == Render.component_value_list(Render.strip_leading_whitespace(right));

let rec merge_adjacent_media = (rules: list(rule)) =>
  switch (rules) {
  | [
      At_rule(
        {
          name: ("media", _),
          prelude: left_prelude,
          block: Rule_list((left_rules, _)),
          _,
        } as left,
      ),
      At_rule({
        name: ("media", _),
        prelude: right_prelude,
        block: Rule_list((right_rules, _)),
        _,
      }),
      ...rest,
    ]
      when media_preludes_equal(left_prelude, right_prelude) =>
    merge_adjacent_media([
      At_rule({
        ...left,
        block: Rule_list((left_rules @ right_rules, loc_none)),
      }),
      ...rest,
    ])
  | [rule, ...rest] => [rule, ...merge_adjacent_media(rest)]
  | [] => []
  };

let rec flatten_rules =
        (
          ~prefix: option(selector),
          ~media: option(with_loc(component_value_list)),
          rules: list(rule),
        )
        : list(rule) => {
  /* Flush pending declarations at their source position, wrapped in
     prefix and media context. */
  let flush = (pending: list(rule)) =>
    switch (List.rev(pending)) {
    | [] => []
    | declarations =>
      let inner =
        switch (prefix) {
        | None => declarations
        | Some(prefix) => [style_rule(~prefix, declarations)]
        };
      switch (media) {
      | None => inner
      | Some(prelude) => [media_rule(~prelude, inner)]
      };
    };
  let (chunks_rev, pending) =
    List.fold_left(
      ((chunks_rev, pending), rule) =>
        switch (rule) {
        | Declaration(_) => (chunks_rev, [rule, ...pending])
        | Style_rule({ prelude: (selectors, _), block: (inner, _), _ }) =>
          let resolved =
            List.concat_map(
              ((current_selector, _)) => {
                let new_prefix =
                  Selector_nesting.compute_new_prefix(
                    ~prefix,
                    current_selector,
                  );
                flatten_rules(~prefix=Some(new_prefix), ~media, inner);
              },
              selectors,
            );
          ([resolved, flush(pending), ...chunks_rev], []);
        | At_rule(at_rule) =>
          let resolved = flatten_at_rule(~prefix, ~media, at_rule);
          ([resolved, flush(pending), ...chunks_rev], []);
        },
      ([], []),
      rules,
    );
  [flush(pending), ...chunks_rev]
  |> List.rev
  |> List.concat
  |> merge_adjacent_media;
}
and flatten_at_rule = (~prefix, ~media, at_rule: at_rule): list(rule) => {
  let { name: (name, _), prelude, block, _ } = at_rule;
  switch (block) {
  /* Statement at-rules (`@import`, `@charset`): pass through verbatim. */
  | Empty => [At_rule(at_rule)]
  | Rule_list((inner, _))
  | Stylesheet((inner, _)) =>
    let wrap_in_media = rules =>
      switch (rules, media) {
      | ([], _) => []
      | (rules, None) => rules
      | (rules, Some(prelude)) => [media_rule(~prelude, rules)]
      };
    if (String.lowercase_ascii(name) == "media") {
      let combined =
        switch (media) {
        | None => Some(prelude)
        | Some(outer)
            when
              Selector_nesting.media_prelude_is_combinable(outer)
              && Selector_nesting.media_prelude_is_condition_only(prelude) =>
          Some(Selector_nesting.join_media(outer, prelude))
        | Some(_) => None
        };
      switch (combined) {
      | Some(combined) =>
        flatten_rules(~prefix, ~media=Some(combined), inner)
      | None =>
        /* Not statically combinable: nest literally (nested media conjoin). */
        switch (flatten_rules(~prefix, ~media=None, inner)) {
        | [] => []
        | inner_rules => wrap_in_media([media_rule(~prelude, inner_rules)])
        }
      };
    } else if (is_descriptor_at_rule(name)) {
      wrap_in_media([At_rule(at_rule)]);
    } else {
      /* Group at-rule (`@supports`, `@container`, ...): flatten inside
         with a fresh media context (media must not hoist past it). */
      switch (flatten_rules(~prefix, ~media=None, inner)) {
      | [] => []
      | inner_rules =>
        wrap_in_media([
          At_rule({
            ...at_rule,
            block: Rule_list((inner_rules, loc_none)),
          }),
        ])
      };
    };
  };
};

/* `[%styled.global]` entry point: no implicit prefix or media context. */
let resolve_selectors = (rules: list(rule)) =>
  flatten_rules(~prefix=None, ~media=None, rules);
