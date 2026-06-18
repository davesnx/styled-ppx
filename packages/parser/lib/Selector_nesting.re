open Ast;

let loc_none = Ppxlib.Location.none;

let rec contains_ampersand = (selector: selector) => {
  switch (selector) {
  | SimpleSelector(Ampersand) => true
  | ComplexSelector(Selector(selector)) => contains_ampersand(selector)
  | ComplexSelector(Combinator({ left: selector_left, right })) =>
    contains_ampersand(selector_left)
    || right
    |> List.map(snd)
    |> List.exists(contains_ampersand)
  | CompoundSelector({ type_selector, pseudo_selectors, subclass_selectors }) =>
    type_selector
    |> Option.map(sel => contains_ampersand(SimpleSelector(sel)))
    |> Option.value(~default=false)
    || pseudo_selectors
    |> List.exists(pseudo_selector_contains_ampersand)
    || subclass_selectors
    |> List.exists(
         fun
         | Pseudo_class(pseudo_selector) =>
           pseudo_selector_contains_ampersand(pseudo_selector)
         | _ => false,
       )
  | RelativeSelector({ complex_selector, _ }) =>
    contains_ampersand(ComplexSelector(complex_selector))
  | _ => false
  };
}
and pseudo_selector_contains_ampersand =
  fun
  | Pseudoclass(Function({ payload: (selector_list, _), _ })) =>
    selector_list |> List.map(fst) |> List.exists(contains_ampersand)
  | Pseudoclass(NthFunction({ payload: (NthSelector(csl), _), _ })) =>
    csl |> List.exists(cs => contains_ampersand(ComplexSelector(cs)))
  | _ => false;

let is_sibling_combinator =
  fun
  | Selector_adjacent_sibling
  | Selector_general_sibling => true
  | Selector_descendant
  | Selector_child => false;

/* A segment denotes the styled element itself when it is a bare `&` or a
   compound whose type position is `&` (`&:hover`, `&:not(.x)`, `&.foo`). */
let rec selector_is_ampersand = (sel: selector) =>
  switch (sel) {
  | SimpleSelector(Ampersand) => true
  | CompoundSelector({ type_selector: Some(Ampersand), _ }) => true
  | ComplexSelector(Selector(inner)) => selector_is_ampersand(inner)
  | _ => false
  };

/* Flatten a complex selector into a left-to-right list of
   `(combinator_before, segment)` pairs; the head carries `None`. So
   `& + .a .b` becomes [(None, &), (Some(+), .a), (Some(descendant), .b)].
   A leading-combinator `RelativeSelector` (`+ .x`) has an implicit `&` on
   its left, which we synthesise as the head. */
let rec flatten_selector_chain =
        (sel: selector): list((option(selector_combinator), selector)) => {
  let with_lead = (combinator, chain) =>
    switch (chain) {
    | [] => []
    | [(_, head), ...rest] => [(Some(combinator), head), ...rest]
    };
  switch (sel) {
  | ComplexSelector(Selector(inner)) => flatten_selector_chain(inner)
  | ComplexSelector(Combinator({ left, right })) =>
    flatten_selector_chain(left)
    @ List.concat_map(
        ((combinator, segment)) =>
          with_lead(combinator, flatten_selector_chain(segment)),
        right,
      )
  | RelativeSelector({ combinator: Some(combinator), complex_selector }) =>
    let inner = flatten_selector_chain(ComplexSelector(complex_selector));
    [(None, SimpleSelector(Ampersand)), ...with_lead(combinator, inner)];
  | RelativeSelector({ combinator: None, complex_selector }) =>
    flatten_selector_chain(ComplexSelector(complex_selector))
  | other => [(None, other)]
  };
};

/* The subject (rightmost compound) is contained in `&`'s subtree when it
   is itself `&`, or when some `&` segment is immediately followed by a
   descendant/child step — once inside `&`, any later sibling stays inside. */
let rec subject_inside_ampersand = segments =>
  switch (segments) {
  | [] => false
  | [(_, subject)] => selector_is_ampersand(subject)
  | [(_, segment), (Some(combinator), _) as next, ...rest] =>
    selector_is_ampersand(segment)
    && !is_sibling_combinator(combinator)
    || subject_inside_ampersand([next, ...rest])
  | [_, ...rest] => subject_inside_ampersand(rest)
  };

/* Does the subject sit *outside* `&`'s subtree, reachable only through a
   sibling combinator (`+`/`~`)? `[%css]` lowers a value interpolation to a
   custom property set inline on `&` and read back with `var(--…)`; since
   custom properties inherit only down to `&` and its descendants, such a
   subject can't read it. Selectors with no `&` are never flagged: the
   className is prepended via a descendant combinator, keeping the chain
   inside the styled element. */
let subject_escapes_ampersand_subtree = (sel: selector): bool => {
  let segments = flatten_selector_chain(sel);
  let has_ampersand =
    List.exists(((_, segment)) => selector_is_ampersand(segment), segments);
  has_ampersand && !subject_inside_ampersand(segments);
};

let rec brace_block_contain_media =
  fun
  | Empty => false
  | Rule_list(rule_list) => rule_list_contain_media(rule_list)
  | Stylesheet(stylesheet) => stylesheet_contain_media(stylesheet)
and stylesheet_contain_media = ((stylesheet, _): stylesheet) => {
  List.exists(rule_contain_media, stylesheet);
}
and rule_list_contain_media = ((rule_list, _): rule_list) => {
  List.exists(rule_contain_media, rule_list);
}
and rule_contain_media =
  fun
  | Declaration(_) => false
  | Style_rule(_) => false
  | At_rule({ name: (name, _), _ }) => name == "media";

/* `pop_last_selector` peels the trailing combinator+selector pair off a
   `ComplexSelector(Combinator{...})`. The AST type admits `right: []`,
   so although the parser doesn't currently emit that shape, the
   explicit empty-right arm keeps the function total: an empty-right
   combinator is semantically the `left` selector alone, which is more
   informative than the catchall fallback (which would return the whole
   `ComplexSelector(Combinator)` wrapper).

   The non-empty arm reverses `right` exactly once and pattern-matches
   the head off, then reverses the tail back. The previous shape called
   `List.rev` three times for the same logical operation. */
let pop_last_selector =
  fun
  | ComplexSelector(Selector(sel)) => (sel, None, None)
  | ComplexSelector(Combinator({ left, right: [] })) => (left, None, None)
  | ComplexSelector(Combinator({ left, right })) =>
    switch (List.rev(right)) {
    | [] =>
      /* Unreachable: the `right: []` arm above shadows it. */
      (left, None, None)
    | [(ctor, last), ...rest_rev] => (
        last,
        Some(ctor),
        Some(
          ComplexSelector(
            Combinator({
              left,
              right: List.rev(rest_rev),
            }),
          ),
        ),
      )
    }
  | _ as sel => (sel, None, None);

let join_selector_with_combinator =
    (~combinator=Ast.Selector_descendant, a, b) => {
  ComplexSelector(
    Combinator({
      left: a,
      right: [(combinator, b)],
    }),
  );
};

/* Flatten a redundant `ComplexSelector(Selector(s))` wrapper that
   `pop_last_selector` may return when the `right` side of a `Combinator`
   carries the parser's identity form. Other selector shapes
   (`RelativeSelector`, raw `Combinator`) pass through unchanged — they
   are not expected from `pop_last_selector` and would still surface in
   the catch-all `assert(false)` of `join_compound_selector`.

   Non-recursive: the parser doesn't produce `Selector(Selector(...))`
   chains, so a single unwrap is sufficient. */
let unwrap_complex_selector =
  fun
  | ComplexSelector(Selector(s)) => s
  | s => s;

/* `join_compound_selector(selector, { subclass_selectors,
   pseudo_selectors, _ })` extends the last compound of `selector` with
   the given subclass/pseudo lists. Used by `replace_ampersand` when
   substituting a compound `&`-bearing rhs into the prefix.

   The four reachable shapes of `pop_last_selector` after
   `unwrap_complex_selector`:

   1. `(SimpleSelector(simple), None, None)` — prefix was bare
      `SimpleSelector` (e.g. top-level `&`). Promote `simple` to a
      `type_selector` in the new compound.
   2. `(SimpleSelector(simple), Some(ctor), Some(rest))` — prefix was a
      `Combinator` chain whose last segment is a SimpleSelector. Wrap.
   3-4. Same two arms for `CompoundSelector(_)` last segments.

   Any other shape (e.g. `RelativeSelector`,
   `ComplexSelector(Combinator(_))` slipping past the unwrap) means the
   caller passed a prefix this function isn't shaped to handle. Rather
   than crash, fall back to a descendant join: emit `<popped> <new
   compound>`. This preserves user CSS as something parseable and
   reasonable, and lets the higher layers report a clearer error if
   needed. The catch-all is intentionally permissive because
   `Selector_nesting` is in the parser layer with no access to
   `Ppxlib.Location.raise_errorf`. */
let join_compound_selector =
    (selector, { subclass_selectors, pseudo_selectors, _ }) => {
  let new_compound =
    CompoundSelector({
      type_selector: None,
      subclass_selectors,
      pseudo_selectors,
    });
  let (popped, ctor_opt, rest_opt) = pop_last_selector(selector);
  switch (unwrap_complex_selector(popped), ctor_opt, rest_opt) {
  | (SimpleSelector(simple), None, None) =>
    CompoundSelector({
      type_selector: Some(simple),
      subclass_selectors,
      pseudo_selectors,
    })
  | (SimpleSelector(simple), Some(ctor), Some(rest)) =>
    join_selector_with_combinator(
      ~combinator=ctor,
      rest,
      CompoundSelector({
        type_selector: Some(simple),
        subclass_selectors,
        pseudo_selectors,
      }),
    )
  | (
      CompoundSelector({
        type_selector: last_type_selector,
        subclass_selectors: last_subclass_selectors,
        pseudo_selectors: last_pseudo_selectors,
      }),
      None,
      None,
    ) =>
    CompoundSelector({
      type_selector: last_type_selector,
      subclass_selectors: last_subclass_selectors @ subclass_selectors,
      pseudo_selectors: last_pseudo_selectors @ pseudo_selectors,
    })
  | (
      CompoundSelector({
        type_selector: last_type_selector,
        subclass_selectors: last_subclass_selectors,
        pseudo_selectors: last_pseudo_selectors,
      }),
      Some(ctor),
      Some(rest),
    ) =>
    join_selector_with_combinator(
      ~combinator=ctor,
      rest,
      CompoundSelector({
        type_selector: last_type_selector,
        subclass_selectors: last_subclass_selectors @ subclass_selectors,
        pseudo_selectors: last_pseudo_selectors @ pseudo_selectors,
      }),
    )
  /* Defensive fallback — see comment above. */
  | (other, None, None) => join_selector_with_combinator(other, new_compound)
  | (other, Some(ctor), Some(rest)) =>
    join_selector_with_combinator(
      ~combinator=ctor,
      rest,
      join_selector_with_combinator(other, new_compound),
    )
  /* The other inconsistent (Some/None) mixes are unreachable by
     construction in `pop_last_selector`, but matching them keeps the
     compiler's exhaustiveness check happy without a wildcard. */
  | (_, Some(_), None)
  | (_, None, Some(_)) =>
    join_selector_with_combinator(selector, new_compound)
  };
};

let rec replace_ampersand = (replaced_with: selector, selector: selector) => {
  switch (selector) {
  | SimpleSelector(Ampersand) => replaced_with
  | ComplexSelector(Selector(sel)) =>
    ComplexSelector(Selector(replace_ampersand(replaced_with, sel)))
  | ComplexSelector(Combinator({ left, right })) =>
    ComplexSelector(
      Combinator({
        left: replace_ampersand(replaced_with, left),
        right:
          List.map(
            ((ctor, sel)) => (ctor, replace_ampersand(replaced_with, sel)),
            right,
          ),
      }),
    )
  | CompoundSelector({ type_selector, subclass_selectors, pseudo_selectors }) =>
    let pseudo_selectors =
      pseudo_selectors
      |> List.map(pseudo_selector_replace_ampersand(replaced_with));
    let subclass_selectors =
      subclass_selectors
      |> List.map(
           fun
           | Pseudo_class(pseudo_selector) =>
             Pseudo_class(
               pseudo_selector_replace_ampersand(
                 replaced_with,
                 pseudo_selector,
               ),
             )
           | v => v,
         );
    switch (type_selector) {
    | Some(Ampersand) =>
      join_compound_selector(
        replaced_with,
        {
          type_selector,
          subclass_selectors,
          pseudo_selectors,
        },
      )
    | _ =>
      CompoundSelector({
        type_selector,
        subclass_selectors,
        pseudo_selectors,
      })
    };
  | RelativeSelector({ combinator, complex_selector }) =>
    /* `replace_ampersand` preserves the outer `ComplexSelector` wrapper
       on every recursive arm that handles a `ComplexSelector` input,
       so the result is always `ComplexSelector(_)`. The fallback
       `Selector(_)` rewrap is defensive: if a future arm is added that
       returns a bare selector, we keep the `RelativeSelector`
       structure intact rather than crashing. */
    let complex_selector =
      switch (
        replace_ampersand(replaced_with, ComplexSelector(complex_selector))
      ) {
      | ComplexSelector(v) => v
      | other => Selector(other)
      };
    RelativeSelector({
      combinator,
      complex_selector,
    });
  | _ as sel => sel
  };
}
and pseudo_selector_replace_ampersand = (replaced_with: selector, selector) => {
  switch (selector) {
  | Pseudoclass(
      Function({ name, payload: (selector_list, selector_list_loc) }),
    ) =>
    let selector_list =
      selector_list
      |> List.map(((selector, loc)) =>
           (replace_ampersand(replaced_with, selector), loc)
         );
    Pseudoclass(
      Function({
        name,
        payload: (selector_list, selector_list_loc),
      }),
    );
  | Pseudoclass(
      NthFunction({
        name,
        payload: (NthSelector(complex_selector_list), payload_loc),
      }),
    ) =>
    /* See the parallel `RelativeSelector` arm above for why the result
       of `replace_ampersand` on a `ComplexSelector(_)` is always a
       `ComplexSelector(_)`. The `Selector(other)` rewrap is defensive
       against future arms that might return a bare selector. */
    let complex_selector_list =
      complex_selector_list
      |> List.map(complex_selector =>
           replace_ampersand(
             replaced_with,
             ComplexSelector(complex_selector),
           )
         )
      |> List.map(
           fun
           | ComplexSelector(complex_selector) => complex_selector
           | other => Selector(other),
         );
    Pseudoclass(
      NthFunction({
        name,
        payload: (NthSelector(complex_selector_list), payload_loc),
      }),
    );
  | sel => sel
  };
};

let split_multiple_selectors = (rules: list(rule)) => {
  List.fold_left(
    (acc, rule) => {
      switch (rule) {
      | Style_rule({ prelude: (selector_list, prelude_loc), block, loc }) =>
        let new_rules =
          List.map(
            selector =>
              Style_rule({
                prelude: ([selector], prelude_loc),
                block,
                loc,
              }),
            selector_list,
          );
        acc @ new_rules;
      | _ => acc @ [rule]
      }
    },
    [],
    rules,
  );
};

let trim_right = (vs: component_value_list) => {
  let rec go = (vs, acc) =>
    switch (vs) {
    | [(Whitespace, _)] => List.rev(acc)
    | [v, ...rest] => go(rest, [v, ...acc])
    | [] => List.rev(acc)
    };
  go(vs, []);
};

let join_media =
    (
      (left, left_loc): with_loc(component_value_list),
      (right, right_loc): with_loc(component_value_list),
    ) => {
  let new_loc = Parser_location.intersection(left_loc, right_loc);
  (
    trim_right(left)
    @ [
      (Whitespace, loc_none),
      (Ident("and"), loc_none),
      (Whitespace, loc_none),
    ]
    @ right,
    new_loc,
  );
};

let split_by_kind = (rules: list(rule)) => {
  List.partition(
    fun
    | Declaration(_) => true
    | _ => false,
    rules,
  );
};

let rec move_media_at_top = (rules: list(rule)) => {
  List.fold_left(
    (acc, rule) => {
      switch (rule) {
      | At_rule({ name: (name, _), block, _ } as at_rule)
          when name == "media" && brace_block_contain_media(block) =>
        let new_rules = swap(at_rule);
        acc @ new_rules;
      | Style_rule({ block: (block, _) as block_with_loc, prelude, loc })
          when rule_list_contain_media(block_with_loc) =>
        let (declarations, selectors) = split_by_kind(block);
        let (media_selectors, non_media_selectors) =
          List.partition(
            fun
            | At_rule({ name: (name, _), _ }) => name == "media"
            | _ => false,
            selectors,
          );
        let new_media_rules =
          List.map(
            fun
            | At_rule({
                name: ("media", _) as name_with_loc,
                prelude: nested_media_selector,
                block,
                _,
              }) => {
                let nested_media_rule_list =
                  switch (block) {
                  | Empty => []
                  | Rule_list((block, _)) => block
                  | Stylesheet((block, _)) => block
                  };
                [
                  At_rule({
                    name: name_with_loc,
                    prelude: nested_media_selector,
                    block:
                      Rule_list((
                        [
                          Style_rule({
                            prelude,
                            block: (nested_media_rule_list, loc_none),
                            loc,
                          }),
                        ],
                        loc_none,
                      )),
                    loc,
                  }),
                ];
              }
            | _ => [],
            media_selectors,
          )
          |> List.flatten;
        let selector_without_media = [
          Style_rule({
            prelude,
            block: (declarations @ non_media_selectors, loc_none),
            loc,
          }),
        ];
        acc @ selector_without_media @ new_media_rules;
      | Style_rule({ block: (block, _), _ }) when block != [] =>
        acc @ [rule]
      | At_rule({ block: Rule_list((block, _)), _ }) when block != [] =>
        acc @ [rule]
      | At_rule({ block: Stylesheet((block, _)), _ }) when block != [] =>
        acc @ [rule]
      | Declaration(_) => acc @ [rule]
      | _ => acc
      }
    },
    [],
    rules,
  );
}
and swap = ({ prelude: swap_prelude, block, loc, _ }: at_rule) => {
  let rules =
    switch (block) {
    | Empty => []
    | Rule_list((rule_list, _)) => rule_list
    | Stylesheet((stylesheet, _)) => stylesheet
    };
  let (media_declarations, media_rules_selectors) = split_by_kind(rules);
  let resolved_media_selectors =
    List.map(
      fun
      | At_rule({
          name: (name, _) as nested_name,
          prelude: nested_prelude,
          block: nested_block,
          _,
        })
          when name == "media" => [
          At_rule({
            name: nested_name,
            prelude: swap_prelude,
            block: Rule_list((media_declarations, loc_none)),
            loc,
          }),
          At_rule({
            name: nested_name,
            prelude: join_media(swap_prelude, nested_prelude),
            block: nested_block,
            loc,
          }),
        ]
      | _ => [],
      media_rules_selectors,
    )
    |> List.flatten;
  move_media_at_top(resolved_media_selectors);
};

/** Compute the merged prefix when nesting a selector under a parent.

    Per CSS Nesting Level 1 §3.1, a nested selector that does not
    contain the nesting selector (`&`) and does not start with a
    combinator desugars by descendant-combinator-joining with the
    parent. Selectors that do contain `&` resolve via literal
    substitution. The two arms below implement exactly those rules.

    Selectors that start with a combinator are accepted as relative
    (e.g. `> .child` desugars to `& > .child`) when the parser supports
    them in nested position. The current parser only accepts leading
    combinators inside pseudo-class payloads (`:has(> img)`); a leading
    `>` after `{` is rejected at parse time, so this function never
    sees that shape. Users must write `& > .child` until the parser
    grows nested-relative-selector support. */
let compute_new_prefix = (~prefix, current_selector) => {
  switch (prefix) {
  | None => current_selector
  | Some(prefix) =>
    if (contains_ampersand(current_selector)) {
      replace_ampersand(prefix, current_selector);
    } else {
      join_selector_with_combinator(prefix, current_selector);
    }
  };
};
