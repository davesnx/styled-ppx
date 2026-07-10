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

/* Pseudo-elements are separate boxes that receive custom properties
   from their originating element via *inheritance* — a
   `@property{inherits:false}` var set inline on `&` is invisible to
   `&::before`/`&::placeholder`. Both `::x` and the CSS2 legacy
   single-colon spellings (`:before`, `:after`, `:first-line`,
   `:first-letter`, parsed as pseudo-classes) count. */
let pseudo_selector_is_element =
  fun
  | Pseudoelement(_) => true
  | Pseudoclass(PseudoIdent(name)) =>
    switch (String.lowercase_ascii(name)) {
    | "before"
    | "after"
    | "first-line"
    | "first-letter" => true
    | _ => false
    }
  | Pseudoclass(_) => false;

/* Segment matches the styled element's OWN box and nothing else: a bare
   `&` or a compound whose type position is `&`, restricted only by
   pseudo-classes/subclasses (`&:hover`, `&.foo`) — never by a
   pseudo-element (`&::before` styles a separate box that reads vars via
   inheritance). Strictly stronger than `subject_within_ampersand`
   below, which also accepts elements merely *inside* `&`'s subtree
   (e.g. `:is(& .child)`) — those too read inline custom properties via
   inheritance. Callers deciding whether a var may register
   `@property{inherits:false}` must use this strict form. `:is(&)`-style
   proofs are conservatively rejected (false only misses an
   optimization, never breaks a style). */
let rec selector_is_ampersand_own_box = (sel: selector) =>
  switch (sel) {
  | SimpleSelector(Ampersand) => true
  | CompoundSelector({
      type_selector: Some(Ampersand),
      subclass_selectors,
      pseudo_selectors,
    }) =>
    !List.exists(pseudo_selector_is_element, pseudo_selectors)
    && !List.exists(
         fun
         | Pseudo_class(pseudo) => pseudo_selector_is_element(pseudo)
         | _ => false,
         subclass_selectors,
       )
  | ComplexSelector(Selector(inner)) => selector_is_ampersand_own_box(inner)
  | _ => false
  };

/* Segment provably denotes an element inside `&`'s subtree: `&`,
   `&`-typed compounds, or `:is()`/`:where()` whose every branch stays
   inside. `:not()`/`:has()` prove nothing — conservatively ignored. */
let rec subject_within_ampersand = (sel: selector) =>
  switch (sel) {
  | SimpleSelector(Ampersand) => true
  | ComplexSelector(Selector(inner)) => subject_within_ampersand(inner)
  | CompoundSelector({ type_selector: Some(Ampersand), _ }) => true
  | CompoundSelector({ subclass_selectors, pseudo_selectors, _ }) =>
    List.exists(
      fun
      | Pseudo_class(pseudo) => pseudo_proves_within_ampersand(pseudo)
      | _ => false,
      subclass_selectors,
    )
    || List.exists(pseudo_proves_within_ampersand, pseudo_selectors)
  | _ => false
  }
and pseudo_proves_within_ampersand = pseudo =>
  switch (pseudo) {
  | Pseudoclass(Function({ name, payload: (selector_list, _) }))
      when
        String.lowercase_ascii(name) == "is"
        || String.lowercase_ascii(name) == "where" =>
    selector_list != []
    && List.for_all(
         ((branch, _)) =>
           subject_inside_ampersand(flatten_selector_chain(branch)),
         selector_list,
       )
  | _ => false
  }
/* Subject is inside `&`'s subtree when itself within `&`, or after a
   within-`&` segment followed by a descendant/child step. */
and subject_inside_ampersand = segments =>
  switch (segments) {
  | [] => false
  | [(_, subject)] => subject_within_ampersand(subject)
  | [(_, segment), (Some(combinator), _) as next, ...rest] =>
    subject_within_ampersand(segment)
    && !is_sibling_combinator(combinator)
    || subject_inside_ampersand([next, ...rest])
  | [_, ...rest] => subject_inside_ampersand(rest)
  };

/* Subject sits outside `&`'s subtree (sibling combinator, `div:not(&)`,
   `:has(& + div)`, ...) — it can't read the custom property `[%css]`
   sets inline on `&`. `contains_ampersand` sees inside pseudo payloads,
   so payload-only `&` is analyzed, not silently accepted. */
let subject_escapes_ampersand_subtree = (sel: selector): bool => {
  contains_ampersand(sel)
  && !subject_inside_ampersand(flatten_selector_chain(sel));
};

/* Flatten nested combinator trees into head + flat segment steps.
   Purely structural (no `&` synthesis, unlike `flatten_selector_chain`);
   nested trees arise from joins/substitutions of complex selectors. */
let rec flatten_combinator_tree =
        (sel: selector): (selector, list((selector_combinator, selector))) =>
  switch (sel) {
  | ComplexSelector(Selector(inner)) => flatten_combinator_tree(inner)
  | ComplexSelector(Combinator({ left, right })) =>
    let (head, left_tail) = flatten_combinator_tree(left);
    let right_tail =
      List.concat_map(
        ((combinator, segment)) => {
          let (segment_head, segment_tail) = flatten_combinator_tree(segment);
          [(combinator, segment_head), ...segment_tail];
        },
        right,
      );
    (head, left_tail @ right_tail);
  | other => (other, [])
  };

/* Pop the rightmost compound off a complex selector (flattens first so
   the popped segment is never a whole subtree). Returns
   `(last, combinator_before_last, rest)`. */
let pop_last_selector = (selector: selector) => {
  let (head, segments) = flatten_combinator_tree(selector);
  switch (List.rev(segments)) {
  | [] => (head, None, None)
  | [(ctor, last)] => (last, Some(ctor), Some(head))
  | [(ctor, last), ...rest_rev] => (
      last,
      Some(ctor),
      Some(
        ComplexSelector(
          Combinator({
            left: head,
            right: List.rev(rest_rev),
          }),
        ),
      ),
    )
  };
};

let join_selector_with_combinator =
    (~combinator=Ast.Selector_descendant, a, b) => {
  ComplexSelector(
    Combinator({
      left: a,
      right: [(combinator, b)],
    }),
  );
};

/* Extend a prefix compound preserving literal-substitution order: the
   nested compound renders *after* the prefix. When the prefix ends in
   pseudo selectors, nested pseudo-classes append to the pseudo chain
   (`.a::before { &:hover }` -> `.a::before:hover`, not
   `.a:hover::before`). Non-pseudo subclasses stay in subclass position
   (`::before.foo` is invalid and unrepresentable). */
let merge_compound_selectors =
    (
      ~last_type_selector,
      ~last_subclass_selectors,
      ~last_pseudo_selectors,
      { subclass_selectors, pseudo_selectors, _ },
    ) =>
  switch (last_pseudo_selectors) {
  | [] =>
    CompoundSelector({
      type_selector: last_type_selector,
      subclass_selectors: last_subclass_selectors @ subclass_selectors,
      pseudo_selectors,
    })
  | last_pseudo_selectors =>
    let (plain_subclasses, pseudo_class_subclasses) =
      List.partition_map(
        fun
        | Pseudo_class(pseudo) => Either.Right(pseudo)
        | subclass => Either.Left(subclass),
        subclass_selectors,
      );
    CompoundSelector({
      type_selector: last_type_selector,
      subclass_selectors: last_subclass_selectors @ plain_subclasses,
      pseudo_selectors:
        last_pseudo_selectors @ pseudo_class_subclasses @ pseudo_selectors,
    });
  };

/* Extend the last compound of `selector` with `compound`'s
   subclass/pseudo lists (used by `replace_ampersand` for `&:hover`-style
   substitution). Unhandled shapes (e.g. `RelativeSelector`) fall back to
   a descendant join rather than crashing — the parser layer can't
   raise. */
let join_compound_selector =
    (selector, { subclass_selectors, pseudo_selectors, _ } as compound) => {
  let new_compound =
    CompoundSelector({
      type_selector: None,
      subclass_selectors,
      pseudo_selectors,
    });
  switch (pop_last_selector(selector)) {
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
    merge_compound_selectors(
      ~last_type_selector,
      ~last_subclass_selectors,
      ~last_pseudo_selectors,
      compound,
    )
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
      merge_compound_selectors(
        ~last_type_selector,
        ~last_subclass_selectors,
        ~last_pseudo_selectors,
        compound,
      ),
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

let trim_right = (vs: component_value_list) => {
  let rec go = (vs, acc) =>
    switch (vs) {
    | [(Whitespace, _)] => List.rev(acc)
    | [v, ...rest] => go(rest, [v, ...acc])
    | [] => List.rev(acc)
    };
  go(vs, []);
};

let rec trim_left = (vs: component_value_list) =>
  switch (vs) {
  | [(Whitespace, _), ...rest] => trim_left(rest)
  | vs => vs
  };

let join_media =
    (
      (left, left_loc): with_loc(component_value_list),
      (right, right_loc): with_loc(component_value_list),
    ) => {
  let new_loc = Parser_location.span(left_loc, right_loc);
  (
    trim_right(left)
    @ [
      (Whitespace, loc_none),
      (Ident("and"), loc_none),
      (Whitespace, loc_none),
    ]
    @ trim_left(right),
    new_loc,
  );
};

/* `join_media` builds `LEFT and RIGHT`, only sound for single
   conjunctive queries: top-level comma/`or`/`not`/`$()` (and, on the
   right, media types like `screen`) would change meaning or fail the
   media-query grammar. Rejected preludes nest literally instead. */
let media_prelude_meaningful_values =
    ((values, _loc): with_loc(component_value_list)) =>
  List.filter_map(
    ((value, _)) => value == Whitespace ? None : Some(value),
    values,
  );

/* LEFT operand: single conjunctive query (media-type head is fine). */
let media_prelude_is_combinable = prelude => {
  let meaningful = media_prelude_meaningful_values(prelude);
  let conjunctive_only =
    List.for_all(
      value =>
        switch (value) {
        | Delim(Delimiter_comma)
        | Variable(_) => false
        | Ident(ident) => String.lowercase_ascii(ident) != "or"
        | _ => true
        },
      meaningful,
    );
  switch (meaningful) {
  | [] => false
  | [Ident(first), ..._] when String.lowercase_ascii(first) == "not" => false
  | _ => conjunctive_only
  };
};

/* RIGHT operand: pure `(...)` condition chain — it follows an `and`. */
let media_prelude_is_condition_only = prelude => {
  let meaningful = media_prelude_meaningful_values(prelude);
  let condition_chain =
    List.for_all(
      value =>
        switch (value) {
        | Paren_block(_) => true
        | Ident(ident) => String.lowercase_ascii(ident) == "and"
        | _ => false
        },
      meaningful,
    );
  switch (meaningful) {
  | [Paren_block(_), ..._] => condition_chain
  | _ => false
  };
};

let split_by_kind = (rules: list(rule)) => {
  List.partition(
    fun
    | Declaration(_) => true
    | _ => false,
    rules,
  );
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
