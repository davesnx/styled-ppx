open Ast;

let loc_none = Ppxlib.Location.none;

let split_by_kind = Selector_nesting.split_by_kind;

let rec unnest_selectors = (~prefix, rules) => {
  List.partition_map(
    fun
    | Style_rule({ prelude: (prelude, _), block: (rules, _), _ }) => {
        let current_selector = prelude |> List.hd |> fst;
        let new_prefix =
          Selector_nesting.compute_new_prefix(~prefix, current_selector);
        let selector_rules = Selector_nesting.split_multiple_selectors(rules);
        let (selectors, rest_of_declarations) =
          unnest_selectors(~prefix=Some(new_prefix), selector_rules);
        let new_selector =
          Style_rule({
            prelude: ([(new_prefix, loc_none)], loc_none),
            block: (selectors, loc_none),
            loc: loc_none,
          });
        Right([new_selector, ...rest_of_declarations]);
      }
    | At_rule({
        name: ("keyframes" | "font-face", _) as name,
        prelude,
        block,
        loc,
      }) => {
        let processed_block =
          switch (block) {
          | Empty => Empty
          | Rule_list((rule_list, rule_list_loc)) =>
            let (processed_declarations, processed_selectors) =
              unnest_selectors(~prefix=None, rule_list);
            Rule_list((
              processed_declarations @ processed_selectors,
              rule_list_loc,
            ));
          | Stylesheet((stylesheet, stylesheet_loc)) =>
            let (processed_declarations, processed_selectors) =
              unnest_selectors(~prefix=None, stylesheet);
            Rule_list((
              processed_declarations @ processed_selectors,
              stylesheet_loc,
            ));
          };
        Left(
          At_rule({
            name,
            prelude,
            block: processed_block,
            loc,
          }),
        );
      }
    | At_rule({ name, prelude, block, loc }) => {
        let processed_block =
          switch (block) {
          | Empty => Empty
          | Rule_list((rule_list, rule_list_loc)) =>
            let (processed_declarations, processed_selectors) =
              unnest_selectors(~prefix, rule_list);
            let (pure_declarations, inner_at_rules) =
              List.partition(
                fun
                | Declaration(_) => true
                | _ => false,
                processed_declarations,
              );
            let final_rules =
              switch (prefix, pure_declarations) {
              | (Some(className), decls) when List.length(decls) > 0 =>
                let wrapped_decls =
                  Style_rule({
                    prelude: ([(className, loc_none)], loc_none),
                    block: (decls, loc_none),
                    loc: loc_none,
                  });
                [wrapped_decls] @ inner_at_rules @ processed_selectors;
              | _ => processed_declarations @ processed_selectors
              };
            Rule_list((final_rules, rule_list_loc));
          | Stylesheet((stylesheet, stylesheet_loc)) =>
            let (processed_declarations, processed_selectors) =
              unnest_selectors(~prefix, stylesheet);
            let (pure_declarations, inner_at_rules) =
              List.partition(
                fun
                | Declaration(_) => true
                | _ => false,
                processed_declarations,
              );
            let final_rules =
              switch (prefix, pure_declarations) {
              | (Some(className), decls) when List.length(decls) > 0 =>
                let wrapped_decls =
                  Style_rule({
                    prelude: ([(className, loc_none)], loc_none),
                    block: (decls, loc_none),
                    loc: loc_none,
                  });
                [wrapped_decls] @ inner_at_rules @ processed_selectors;
              | _ => processed_declarations @ processed_selectors
              };
            Rule_list((final_rules, stylesheet_loc));
          };
        Left(
          At_rule({
            name,
            prelude,
            block: processed_block,
            loc,
          }),
        );
      }
    | Declaration(_) as dec => Left(dec),
    rules,
  )
  |> (
    ((declarations, selectors)) => (declarations, List.flatten(selectors))
  );
};

let resolve_selectors = (~className, rules: list(rule)) => {
  let initial_prefix =
    Some(
      CompoundSelector({
        type_selector: None,
        subclass_selectors: [Class(className)],
        pseudo_selectors: [],
      }),
    );
  let (declarations, selectors) =
    rules
    |> Selector_nesting.move_media_at_top
    |> Selector_nesting.split_multiple_selectors
    |> unnest_selectors(~prefix=initial_prefix);
  Selector_nesting.move_media_at_top(selectors) @ declarations;
};

let run = (~className, (rule_list, _loc): rule_list) => {
  let (declarations, selectors) =
    rule_list |> resolve_selectors(~className) |> split_by_kind;

  let wrapped_declarations =
    if (List.length(declarations) > 0) {
      [
        Style_rule({
          prelude: (
            [
              (
                CompoundSelector({
                  type_selector: None,
                  subclass_selectors: [Class(className)],
                  pseudo_selectors: [],
                }),
                loc_none,
              ),
            ],
            loc_none,
          ),
          block: (declarations, loc_none),
          loc: loc_none,
        }),
      ];
    } else {
      [];
    };

  wrapped_declarations @ selectors;
};
