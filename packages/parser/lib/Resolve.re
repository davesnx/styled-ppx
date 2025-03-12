open Ast;

module List = {
  include List;
  /* To be compatible with OCaml 4.14 Stdlib */
  let is_empty =
    fun
    | [] => true
    | [_, ..._] => false;
};

let rec contains_ampersand = (selector: selector) => {
  switch (selector) {
  | SimpleSelector(Ampersand) => true
  | ComplexSelector(Selector(selector)) => contains_ampersand(selector)
  | ComplexSelector(Combinator({left: selector_left, right})) =>
    contains_ampersand(selector_left)
    || right
    |> List.map(snd)
    |> List.exists(contains_ampersand)
  | CompoundSelector({type_selector, pseudo_selectors, subclass_selectors}) =>
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
  | RelativeSelector({complex_selector, _}) =>
    contains_ampersand(ComplexSelector(complex_selector))
  | _ => false
  };
}
and pseudo_selector_contains_ampersand =
  fun
  | Pseudoclass(Function({payload: (selector_list, _), _})) =>
    selector_list |> List.map(fst) |> List.exists(contains_ampersand)
  | Pseudoclass(NthFunction({payload: (NthSelector(csl), _), _})) =>
    csl |> List.exists(cs => contains_ampersand(ComplexSelector(cs)))
  | _ => false;

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
  | At_rule({name: (name, _), _}) => name == "media";

let pop_last_selector =
  fun
  | ComplexSelector(Selector(sel)) => (sel, None, None)
  | ComplexSelector(Combinator({left, right})) => {
      let (ctor, last) = right |> List.rev |> List.hd;
      let rest = right |> List.rev |> List.tl |> List.rev;
      (last, ctor, Some(ComplexSelector(Combinator({left, right: rest}))));
    }
  | _ as sel => (sel, None, None);

let join_selector_with_combinator = (~combinator=None, a, b) => {
  ComplexSelector(Combinator({left: a, right: [(combinator, b)]}));
};
let join_compound_selector =
    (selector, {subclass_selectors, pseudo_selectors, _}) => {
  switch (pop_last_selector(selector)) {
  // prefix is a simple selector, can just replace the type_selector
  | (SimpleSelector(simple), None, None) =>
    CompoundSelector({
      type_selector: Some(simple),
      subclass_selectors,
      pseudo_selectors,
    })
  // prefix is a complex selector with the last selector being a simple selector
  | (SimpleSelector(simple), ctor, Some(rest)) =>
    join_selector_with_combinator(
      ~combinator=ctor,
      rest,
      CompoundSelector({
        type_selector: Some(simple),
        subclass_selectors,
        pseudo_selectors,
      }),
    )

  // prefix is a compound selector, we merge subclass and pseudo
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
  // prefix is a complex selector with the last selector being compound, we merge subclass and pseudo don't forgot to handle the combinator
  | (
      CompoundSelector({
        type_selector: last_type_selector,
        subclass_selectors: last_subclass_selectors,
        pseudo_selectors: last_pseudo_selectors,
      }),
      ctor,
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
  | _ => failwith("invalid state")
  };
};
// this mimics the structure of contains_ampersand
let rec replace_ampersand = (replaced_with: selector, selector: selector) => {
  switch (selector) {
  | SimpleSelector(Ampersand) => replaced_with
  | ComplexSelector(Selector(sel)) =>
    ComplexSelector(Selector(replace_ampersand(replaced_with, sel)))
  | ComplexSelector(Combinator({left, right})) =>
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
  | CompoundSelector({type_selector, subclass_selectors, pseudo_selectors}) =>
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
        {type_selector, subclass_selectors, pseudo_selectors},
      )
    | _ =>
      CompoundSelector({type_selector, subclass_selectors, pseudo_selectors})
    };
  | RelativeSelector({combinator, complex_selector}) =>
    let csel =
      switch (
        replace_ampersand(replaced_with, ComplexSelector(complex_selector))
      ) {
      | ComplexSelector(v) => v
      | _ => failwith("invalid state")
      };
    RelativeSelector({combinator, complex_selector: csel});
  | _ as sel => sel
  };
}
and pseudo_selector_replace_ampersand = (replaced_with: selector, selector) => {
  switch (selector) {
  | Pseudoclass(
      Function({name, payload: (selector_list, selector_list_loc)}),
    ) =>
    let selector_list =
      selector_list
      |> List.map(((selector, loc)) =>
           (replace_ampersand(replaced_with, selector), loc)
         );
    Pseudoclass(
      Function({name, payload: (selector_list, selector_list_loc)}),
    );
  | Pseudoclass(
      NthFunction({
        name,
        payload: (NthSelector(complex_selector_list), payload_loc),
      }),
    ) =>
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
           | _ => failwith("invalid state"),
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
      | Style_rule({prelude: (selector_list, prelude_loc), block, loc}) =>
        let new_rules =
          List.map(
            selector =>
              Style_rule({prelude: ([selector], prelude_loc), block, loc}),
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

let rec starts_with_double_dot =
  fun
  | CompoundSelector({type_selector: None, subclass_selectors, _}) => {
      List.for_all(
        fun
        | Pseudo_class(_) => true
        | _ => false,
        subclass_selectors,
      );
    }
  // :hover {}
  | ComplexSelector(Selector(selector)) => starts_with_double_dot(selector)
  // :hover h1 ... {}
  // :hover + h1 ... {}
  | ComplexSelector(Combinator({left, _})) => starts_with_double_dot(left)
  | _ => false;

let trim_right = (vs: component_value_list) => {
  let rec go = (vs, acc) =>
    switch (vs) {
    | [(Whitespace, _)] => acc
    | [v, ...rest] => go(rest, [v, ...acc])
    | [] => acc
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
      (Whitespace, Ppxlib.Location.none),
      (Ident("and"), Ppxlib.Location.none),
      (Whitespace, Ppxlib.Location.none),
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
      | At_rule({name: (name, _), block, _} as at_rule)
          when name == "media" && brace_block_contain_media(block) =>
        let new_rules = swap(at_rule);
        acc @ new_rules;
      | Style_rule({block: (block, _) as block_with_loc, prelude, loc})
          when rule_list_contain_media(block_with_loc) =>
        let (declarations, selectors) = split_by_kind(block);
        let (media_selectors, non_media_selectors) =
          List.partition(
            fun
            | At_rule({name: (name, _), _}) => name == "media"
            | _ => false,
            selectors,
          );
        let new_media_rules =
          List.map(
            fun
            | At_rule({
                name: (name, _) as name_with_loc,
                prelude: nested_media_selector,
                block,
                _,
              })
                when name == "media" => {
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
                            block: (
                              nested_media_rule_list,
                              Ppxlib.Location.none,
                            ),
                            loc,
                          }),
                        ],
                        Ppxlib.Location.none,
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
            block: (declarations @ non_media_selectors, Ppxlib.Location.none),
            loc,
          }),
        ];
        acc @ selector_without_media @ new_media_rules;
      | Style_rule({block: (block, _), _}) when !List.is_empty(block) =>
        acc @ [rule]
      | At_rule({block: Rule_list((block, _)), _})
          when !List.is_empty(block) =>
        acc @ [rule]
      | At_rule({block: Stylesheet((block, _)), _})
          when !List.is_empty(block) =>
        acc @ [rule]
      | Declaration(_) => acc @ [rule]
      | _ => acc
      }
    },
    [],
    rules,
  );
}
and swap = ({prelude: swap_prelude, block, loc, _}: at_rule) => {
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
            block: Rule_list((media_declarations, Ppxlib.Location.none)),
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

let resolve_selectors = (rules: list(rule)) => {
  let rec unnest_selectors = (~prefix, rules) => {
    List.partition_map(
      fun
      | Style_rule({prelude: (prelude, _), block: (rules, _), _}) => {
          let current_selector = prelude |> List.hd |> fst;
          let new_prefix =
            switch (prefix) {
            | None => current_selector
            | Some(prefix) =>
              if (contains_ampersand(current_selector)) {
                replace_ampersand(prefix, current_selector);
              } else if (starts_with_double_dot(current_selector)) {
                switch (current_selector) {
                | ComplexSelector(Selector(CompoundSelector(selector))) =>
                  ComplexSelector(
                    Selector(join_compound_selector(prefix, selector)),
                  )
                | ComplexSelector(
                    Combinator({left: CompoundSelector(selector), right}),
                  ) =>
                  ComplexSelector(
                    Combinator({
                      left: join_compound_selector(prefix, selector),
                      right,
                    }),
                  )
                | _ => failwith("invalid state")
                };
              } else {
                join_selector_with_combinator(prefix, current_selector);
              }
            };
          let selector_rules = split_multiple_selectors(rules);
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
    |> move_media_at_top
    |> split_multiple_selectors
    |> unnest_selectors(~prefix=None);
  move_media_at_top(selectors) @ declarations;
};
