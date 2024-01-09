let is_nested = ref(false);

let resolve_subclass_selector = (subclass: Css_types.subclass_selector) => {
  Css_types.(
    switch (subclass) {
    | Id(id) when ! is_nested^ => Id(" #" ++ id)
    | Class(c) when ! is_nested^ => Class(" ." ++ c)
    | ClassVariable(vars) when ! is_nested^ =>
      ClassVariable(vars |> List.map(var => " ." ++ var))
    | _ => subclass
    }
  );
};

let resolve_simple_selector =
    (selector: Css_types.simple_selector): Css_types.selector => {
  Css_types.(
    switch (selector) {
    | Subclass(subclass) =>
      SimpleSelector(Subclass(resolve_subclass_selector(subclass)))
    | _ => SimpleSelector(selector)
    }
  );
};

let resolve_compound_selector = (selector: Css_types.compound_selector) => {
  open Css_types;

  let {subclass_selectors, _} = selector;
  let subclass_selectors =
    subclass_selectors
    |> List.map(subclass => resolve_subclass_selector(subclass));
  is_nested := true;
  CompoundSelector({
    type_selector: None,
    subclass_selectors,
    pseudo_selectors: [],
  });
};

let rec resolve_complex_selector = (selector: Css_types.complex_selector) => {
  Css_types.(
    switch (selector) {
    | Selector(selector) => resolve_selector(selector)
    | Combinator({left, right}) =>
      let resolve_right =
        right |> List.map(((opt_str, selector)) => {(opt_str, selector)});

      ComplexSelector(
        Combinator({left: resolve_selector(left), right: resolve_right}),
      );
    }
  );
}
and resolve_selector = (selector: Css_types.selector) => {
  is_nested := false;

  switch (selector) {
  | ComplexSelector(selector) => resolve_complex_selector(selector)
  | CompoundSelector(compound_selector) =>
    resolve_compound_selector(compound_selector)
  | SimpleSelector(selector) => resolve_simple_selector(selector)
  };
};

let resolve_selectors = (selectors: Css_types.selector_list) => {
  selectors
  |> List.map(((selector, loc)) => (resolve_selector(selector), loc));
};

let rec resolve_component_values =
        (component_values: Css_types.component_value_list) => {
  component_values
  |> List.map(((value, loc)) => {
       let component_value =
         Css_types.(
           switch (value) {
           | Paren_block(paren_block) =>
             Paren_block(resolve_component_values(paren_block))
           | Bracket_block(brac_block) =>
             Bracket_block(resolve_component_values(brac_block))
           | Selector(selectors) => Selector(resolve_selectors(selectors))
           | Function(str, values) =>
             Function(str, resolve_component_values_with_loc(values))
           | _ => value
           }
         );
       (component_value, loc);
     });
}

and resolve_component_values_with_loc =
    (
      component_values_with_loc:
        Css_types.with_loc(Css_types.component_value_list),
    ) => {
  let (values, loc) = component_values_with_loc;
  (resolve_component_values(values), loc);
};

let resolve_declaration = (declaration: Css_types.declaration) => {
  open Css_types;

  let {name, value: values, important, loc} = declaration;

  Declaration({
    name,
    value: resolve_component_values_with_loc(values),
    important,
    loc,
  });
};

let rec resolve_style_rule = (style_rule: Css_types.style_rule) => {
  open Css_types;

  let resolve_selectors_with_loc =
      (selectors_with_loc: Css_types.with_loc(Css_types.selector_list)) => {
    let (selectors, _loc) = selectors_with_loc;
    resolve_selectors(selectors);
  };

  let {prelude: selectors_with_loc, block: declarations, loc} = style_rule;

  Style_rule({
    prelude: (resolve_selectors_with_loc(selectors_with_loc), loc),
    block: resolve_nested_selector(declarations),
    loc,
  });
}

and resolve_at_rule = (at_rule: Css_types.at_rule) => {
  open Css_types;

  let {name, prelude: values, block: brace_block, loc} = at_rule;
  let resolve_brace_block =
    switch (brace_block) {
    | Empty => brace_block
    | Rule_list(rules) => Rule_list(resolve_nested_selector(rules))
    | Stylesheet(stylesheet) =>
      Stylesheet(resolve_nested_selector(stylesheet))
    };
  At_rule({
    name,
    prelude: resolve_component_values_with_loc(values),
    block: resolve_brace_block,
    loc,
  });
}

and resolve_nested_selector = (declarations: Css_types.rule_list) => {
  let (rules, loc) = declarations;
  let rules =
    rules
    |> List.map(rule =>
         switch (rule) {
         | Css_types.Declaration(declaration) =>
           resolve_declaration(declaration)
         | Style_rule(style_rule) => resolve_style_rule(style_rule)
         | At_rule(at_rule) => resolve_at_rule(at_rule)
         }
       );
  (rules, loc);
};
