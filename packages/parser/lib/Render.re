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

let split_multiple_selectors = ((rule_list, loc): rule_list) => {
  (
    List.fold_left(
      (acc, rule) => {
        switch (rule) {
        | Style_rule({prelude: (selector_list, prelude_loc), block, loc}) =>
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
          List.append(acc, new_rules);
        | _ => List.append(acc, [rule])
        }
      },
      [],
      rule_list,
    ),
    loc,
  );
};

let rec brace_block_contain_media = (bb: brace_block) => {
  switch (bb) {
  | Empty => false
  | Rule_list(rule_list) => rule_list_contain_media(rule_list)
  | Stylesheet(stylesheet) => stylesheet_contain_media(stylesheet)
  };
}
and stylesheet_contain_media = ((stylesheet, _): stylesheet) => {
  stylesheet |> List.exists(rule_contain_media);
}
and rule_list_contain_media = ((rule_list, _): rule_list) => {
  rule_list |> List.exists(rule_contain_media);
}
and rule_contain_media = (rule: rule) => {
  switch (rule) {
  | Declaration(_) => false
  | Style_rule(_) => false
  | At_rule({name: (name, _), _}) => name == "media"
  };
};

let rec move_media_at_top = ((rule_list, loc): rule_list) => {
  (
    List.fold_left(
      (acc, rule) => {
        switch (rule) {
        | At_rule({name: (name, _), block, _} as at_rule)
            when name == "media" && brace_block_contain_media(block) =>
          let new_rules = swap(at_rule);
          List.append(acc, new_rules);
        | Declaration(_) as x => List.append(acc, [x])
        | _ as x => List.append(acc, [x])
        }
      },
      [],
      rule_list,
    ),
    loc,
  );
}
and swap = ({prelude: _, block: _, loc: _, _}: at_rule) => {
  failwith("TODO");
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
  rule_list |> fst |> List.map(render_rule) |> String.concat("");
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
