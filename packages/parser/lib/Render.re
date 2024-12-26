open Ast;

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

let pop_last_selector =
  fun
  | ComplexSelector(Selector(sel)) => (sel, None, None)
  | ComplexSelector(Combinator({left, right})) => {
      let (ctor, last) = right |> List.rev |> List.hd;
      let rest = right |> List.rev |> List.tl |> List.rev;
      (last, ctor, Some(ComplexSelector(Combinator({left, right: rest}))));
    }
  | _ as sel => (sel, None, None);

let rec replace_ampersand = (selector: selector, replaced_with: selector) => {
  switch (selector) {
  | SimpleSelector(Ampersand) => replaced_with
  | ComplexSelector(Selector(sel)) =>
    ComplexSelector(Selector(replace_ampersand(sel, replaced_with)))
  | ComplexSelector(Combinator({left, right})) =>
    ComplexSelector(
      Combinator({
        left: replace_ampersand(left, replaced_with),
        right:
          List.map(
            ((ctor, sel)) => (ctor, replace_ampersand(sel, replaced_with)),
            right,
          ),
      }),
    )
  | RelativeSelector({combinator, complex_selector}) =>
    let csel =
      switch (
        replace_ampersand(ComplexSelector(complex_selector), replaced_with)
      ) {
      | ComplexSelector(v) => v
      | _ => failwith("invalid state")
      };
    RelativeSelector({combinator, complex_selector: csel});
  | CompoundSelector({
      type_selector: Some(Ampersand),
      subclass_selectors,
      pseudo_selectors,
    }) =>
    switch (pop_last_selector(replaced_with)) {
    | (SimpleSelector(simple), None, None) =>
      CompoundSelector({
        type_selector: Some(simple),
        subclass_selectors,
        pseudo_selectors,
      })
    | (SimpleSelector(simple), ctor, Some(rest)) =>
      ComplexSelector(
        Combinator({
          left: rest,
          right: [
            (
              ctor,
              CompoundSelector({
                type_selector: Some(simple),
                subclass_selectors,
                pseudo_selectors,
              }),
            ),
          ],
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
        ctor,
        Some(rest),
      ) =>
      ComplexSelector(
        Combinator({
          left: rest,
          right: [
            (
              ctor,
              CompoundSelector({
                type_selector: last_type_selector,
                subclass_selectors:
                  last_subclass_selectors @ subclass_selectors,
                pseudo_selectors: last_pseudo_selectors @ pseudo_selectors,
              }),
            ),
          ],
        }),
      )
    | _ => failwith("invalid state")
    }
  | _ as sel => sel
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

let rec starts_with_double_dot =
  fun
  | CompoundSelector({
      type_selector: None,
      subclass_selectors: [],
      pseudo_selectors,
    })
      when List.length(pseudo_selectors) > 1 =>
    true
  | ComplexSelector(Selector(selector)) => starts_with_double_dot(selector)
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
                replace_ampersand(current_selector, prefix);
              } else {
                ComplexSelector(
                  Combinator({
                    left: prefix,
                    right: [(None, current_selector)],
                  }),
                );
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
      | At_rule(_) as at_rule => Right([at_rule])
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
  declarations @ selectors;
};

let rec render_stylesheet = (ast: stylesheet) => {
  ast |> fst |> List.map(render_rule) |> String.concat("");
}
and render_rule = (ast: rule) => {
  switch (ast) {
  | Declaration(declaration) => render_declaration(declaration)
  | Style_rule(style_rule) => render_style_rule(style_rule)
  | At_rule(at_rule) => render_at_rule(at_rule)
  };
}
and render_style_rule = ({prelude, block, _}: style_rule) => {
  Printf.sprintf(
    "%s{%s}",
    prelude |> fst |> render_selector_list,
    render_rule_list(block),
  );
}
and render_at_rule = ({name, prelude, block, _}: at_rule) => {
  Printf.sprintf(
    "@%s %s{%s}",
    name |> fst,
    prelude |> fst |> render_component_value_list,
    render_brace_block(block),
  );
}
and render_brace_block = ast => {
  switch ((ast: brace_block)) {
  | Empty => ""
  | Rule_list(rule_list) => render_rule_list(rule_list)
  | Stylesheet(stylesheet) => render_stylesheet(stylesheet)
  };
}
and render_rule_list = (rule_list: rule_list) => {
  let resolved_rule_list = {
    let (declarations, selectors) =
      rule_list |> fst |> resolve_selectors |> split_by_kind;
    declarations @ selectors;
  };
  resolved_rule_list |> List.map(render_rule) |> String.concat("");
}
and render_declaration = ({name, value, important, _}: declaration) => {
  Printf.sprintf(
    "%s:%s%s;",
    name |> fst,
    value |> fst |> render_component_value_list,
    important |> fst ? " !important" : "",
  );
}
and render_component_value_list = (ast: component_value_list) => {
  ast
  |> List.map(fst)
  |> List.map(render_component_value)
  |> String.concat("");
}

and render_variable = v => "$(" ++ String.concat(".", v) ++ ")"

and render_selector = (ast: selector) => {
  let rec render_simple_selector =
    fun
    | Universal => "*"
    | Ampersand => "&"
    | Type(v) => v
    | Subclass(v) => render_subclass_selector(v)
    | Variable(v) => render_variable(v)
    | Percentage(p) => Printf.sprintf("%s%%", p)
  and render_subclass_selector: subclass_selector => string =
    fun
    | Id(v) => Printf.sprintf("#%s", v)
    | Class(v) => Printf.sprintf(".%s", v)
    | Attribute(attr) => Printf.sprintf("[%s]", render_attribute(attr))
    | Pseudo_class(psc) => render_pseudo_selector(psc)
    | ClassVariable(v) => "." ++ render_variable(v)
  and render_attribute =
    fun
    | Attr_value(v) => v
    | To_equal({name, kind, value}) =>
      name ++ kind ++ render_attr_value(value)
  and render_attr_value =
    fun
    | Attr_ident(i) => i
    | Attr_string(str) => "\"" ++ str ++ "\""
  and render_nth =
    fun
    | Even => "even"
    | Odd => "odd"
    | A(a) => string_of_int(a)
    | AN(an) when an == 1 => "n"
    | AN(an) when an == (-1) => "-n"
    | AN(an) => string_of_int(an) ++ "n"
    | ANB(a, op, b) when a == 1 => "n" ++ op ++ string_of_int(b)
    | ANB(a, op, b) when a == (-1) => "-n" ++ op ++ string_of_int(b)
    | ANB(a, op, b) => string_of_int(a) ++ "n" ++ op ++ string_of_int(b)
  and render_nth_payload =
    fun
    | Nth(nth) => render_nth(nth)
    | NthSelector(v) =>
      v |> List.map(render_complex_selector) |> String.concat(", ")
  and render_pseudo_class =
    fun
    | PseudoIdent(i) => ":" ++ i
    | Function({name, payload: (selector_list, _)}) =>
      ":" ++ name ++ "(" ++ render_selector_list(selector_list) ++ ")"
    | NthFunction({name, payload: (selector, _)}) =>
      ":" ++ name ++ "(" ++ render_nth_payload(selector) ++ ")"
  and render_pseudo_selector =
    fun
    | Pseudoelement(v) => "::" ++ v
    | Pseudoclass(pc) => render_pseudo_class(pc)
  and render_compound_selector = (compound_selector: compound_selector) => {
    let simple_selector =
      Option.fold(
        ~none="",
        ~some=render_simple_selector,
        compound_selector.type_selector,
      );
    let subclass_selectors =
      List.map(render_subclass_selector, compound_selector.subclass_selectors)
      |> String.concat("");
    let pseudo_selectors =
      List.map(render_pseudo_selector, compound_selector.pseudo_selectors)
      |> String.concat("");
    simple_selector ++ subclass_selectors ++ pseudo_selectors;
  }
  and render_complex_selector = complex => {
    switch (complex) {
    | Combinator({left, right}) =>
      let left = render_selector(left);
      let right = render_right_combinator(right);
      left ++ right;
    | Selector(selector) => render_selector(selector)
    };
  }
  and render_right_combinator = right => {
    right
    |> List.map(((combinator, selector)) => {
         Option.fold(~none=" ", ~some=o => " " ++ o ++ " ", combinator)
         ++ render_selector(selector)
       })
    |> String.concat("");
  }
  and render_relative_selector = ({combinator, complex_selector}) => {
    Option.fold(~none="", ~some=o => o ++ " ", combinator)
    ++ render_complex_selector(complex_selector);
  };

  switch (ast) {
  | SimpleSelector(simple) => simple |> render_simple_selector
  | ComplexSelector(complex) => complex |> render_complex_selector
  | CompoundSelector(compound) => compound |> render_compound_selector
  | RelativeSelector(relative) => relative |> render_relative_selector
  };
}
and render_selector_list = (ast: selector_list) => {
  ast |> List.map(fst) |> List.map(render_selector) |> String.concat(",");
}
and render_component_value = (ast: component_value) => {
  switch (ast) {
  | Whitespace => " "
  | Paren_block(block) => "(" ++ render_component_value_list(block) ++ ")"
  | Bracket_block(block) => "[" ++ render_component_value_list(block) ++ "]"
  | Percentage(string) => string ++ "%"
  | Ident(string) => string
  | String(string) => "\"" ++ string ++ "\""
  | Uri(string) => "url(\"" ++ string ++ "\")"
  | Operator(string) => string
  | Combinator(string) => string
  | Delim(string) => string
  | Function(name, body) =>
    let body = body |> fst |> render_component_value_list;
    Printf.sprintf("%s(%s)", fst(name), body);
  | Hash(string) => "#" ++ string
  | Number(n) => n
  | Unicode_range(string) => string
  | Float_dimension((a, b)) => Printf.sprintf("%s%s", a, b)
  | Dimension((a, b)) => Printf.sprintf("%s%s", a, b)
  | Variable(variable) => render_variable(variable)
  | Selector(v) => render_selector_list(v)
  };
};
