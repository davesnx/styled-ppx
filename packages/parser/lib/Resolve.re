open Ast;

let split_by_kind = Selector_nesting.split_by_kind;

let resolve_selectors = (rules: list(rule)) => {
  /* `unnest_selectors` is always called on rules that have already been
     threaded through `split_multiple_selectors`, so every `Style_rule`
     prelude is a single-element list. The empty-prelude arm is
     defensive: if a future caller bypasses the splitter, the malformed
     rule is passed through on the declarations side rather than
     crashing on `List.hd`. The downstream pipeline may render it
     verbatim or filter it; either way no exception escapes. */
  let rec unnest_selectors = (~prefix, rules) => {
    List.partition_map(
      fun
      | Style_rule({ prelude: ([], _), _ }) as rule => Left(rule)
      | Style_rule({
          prelude: ([(current_selector, _), ..._], _),
          block: (rules, _),
          _,
        }) => {
          let new_prefix =
            Selector_nesting.compute_new_prefix(~prefix, current_selector);
          let selector_rules =
            Selector_nesting.split_multiple_selectors(rules);
          let (selectors, rest_of_declarations) =
            unnest_selectors(~prefix=Some(new_prefix), selector_rules);
          let new_selector =
            Style_rule({
              prelude: (
                [(new_prefix, Ppxlib.Location.none)],
                Ppxlib.Location.none,
              ),
              block: (selectors, Ppxlib.Location.none),
              loc: Ppxlib.Location.none,
            });
          Right([new_selector, ...rest_of_declarations]);
        }
      | At_rule(_) as at_rule => Left(at_rule)
      | Declaration(_) as dec => Left(dec),
      rules,
    )
    |> (
      ((declarations, selectors)) => (
        declarations,
        List.flatten(selectors),
      )
    );
  };
  let (declarations, selectors) =
    rules
    |> Selector_nesting.move_media_at_top
    |> Selector_nesting.split_multiple_selectors
    |> unnest_selectors(~prefix=None);
  Selector_nesting.move_media_at_top(selectors) @ declarations;
};
