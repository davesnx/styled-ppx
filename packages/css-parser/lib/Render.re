let rec rule = (ast: Ast.rule) => {
  switch (ast) {
  | Declaration(d) => declaration(d)
  | Style_rule(sr) => style_rule(sr)
  | At_rule(ar) => at_rule(ar)
  };
}
and style_rule = ({prelude, block, _}: Ast.style_rule) => {
  Printf.sprintf(
    "%s { %s }",
    prelude |> fst |> selector_list,
    rule_list(block),
  );
}
and at_rule = ({name, prelude, block, _}: Ast.at_rule) => {
  let rendered_prelude = prelude |> fst |> component_value_list |> String.trim;
  Printf.sprintf(
    "@%s %s { %s }",
    name |> fst,
    rendered_prelude,
    brace_block(block),
  );
}
and brace_block = ast => {
  switch ((ast: Ast.brace_block)) {
  | Empty => ""
  | Rule_list(rl) => rule_list(rl)
  };
}
and rule_list = (rule_list: Ast.rule_list) => {
  let (rule_list, _) = rule_list;
  rule_list
  |> List.filter(
       fun
       | Ast.Style_rule({block: (block, _), _}) when List.length(block) == 0 =>
         false
       | _ => true,
     )
  |> List.map(rule)
  |> String.concat(" ");
}
and declaration = ({name, value, important, _}: Ast.declaration) => {
  Printf.sprintf(
    "%s: %s%s;",
    name |> fst,
    value |> fst |> component_value_list,
    important |> fst ? " !important" : "",
  );
}
and component_value_list = (ast: Ast.component_value_list) => {
  ast |> List.map(fst) |> List.map(component_value) |> String.concat("");
}

and variable = v => "$(" ++ String.concat(".", v) ++ ")"

and selector = (ast: Ast.selector) => {
  let rec render_simple_selector =
    fun
    | Ast.Universal => "*"
    | Ampersand => "&"
    | Type(v) => v
    | Subclass(v) => render_subclass_selector(v)
    | Variable(v) => variable(v)
    | Percentage(p) => Printf.sprintf("%s%%", p)
  and render_subclass_selector: Ast.subclass_selector => string =
    fun
    | Ast.Id(v) => Printf.sprintf("#%s", v)
    | Class(v) => Printf.sprintf(".%s", v)
    | Attribute(attr) => Printf.sprintf("[%s]", render_attribute(attr))
    | Pseudo_class(psc) => render_pseudo_selector(psc)
    | ClassVariable(v) => "." ++ variable(v)
  and render_attribute =
    fun
    | Ast.Attr_value(v) => v
    | To_equal({name, kind, value}) =>
      name ++ kind ++ render_attr_value(value)
  and render_attr_value =
    fun
    | Ast.Attr_ident(i) => i
    | Attr_string(str) => "\"" ++ str ++ "\""
  and render_nth =
    fun
    | Ast.Even => "even"
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
    | Ast.Nth(nth) => render_nth(nth)
    | NthSelector(v) =>
      v |> List.map(render_complex_selector) |> String.concat(", ")
  and render_pseudo_class =
    fun
    | Ast.PseudoIdent(i) => ":" ++ i
    | PseudoFunction({name, payload: (sl, _)}) =>
      ":" ++ name ++ "(" ++ selector_list(sl) ++ ")"
    | NthFunction({name, payload: (selector, _)}) =>
      ":" ++ name ++ "(" ++ render_nth_payload(selector) ++ ")"
  and render_pseudo_selector =
    fun
    | Ast.Pseudoelement(v) => "::" ++ v
    | Pseudoclass(pc) => render_pseudo_class(pc)
  and render_compound_selector = (compound_selector: Ast.compound_selector) => {
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
      let is_class_selector = s => {
        switch (s) {
        | Ast.CompoundSelector({
            type_selector: None,
            subclass_selectors: [Ast.Class(_), ..._],
            _,
          }) =>
          true
        | _ => false
        };
      };

      let right_str =
        right
        |> List.map(((combinator, s)) => {
             switch (
               combinator,
               is_class_selector(left),
               is_class_selector(s),
             ) {
             | (None, true, true) => selector(s)
             | (None, _, _) => " " ++ selector(s)
             | (Some(comb), _, _) => " " ++ comb ++ " " ++ selector(s)
             }
           })
        |> String.concat("");
      selector(left) ++ right_str;
    | Selector(s) => selector(s)
    };
  }
  and render_relative_selector =
      ({combinator, complex_selector}: Ast.relative_selector) => {
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
and selector_list = (ast: Ast.selector_list) => {
  ast |> List.map(fst) |> List.map(selector) |> String.concat(",");
}
/* CSS identifiers that start with a digit or hyphen-digit need escaping.
   When an escape sequence like \32 is parsed, it becomes "2" in the AST.
   When rendering back, we need to escape it to maintain validity.
   Format: \XX where XX is the hex code, followed by a space to terminate. */
and escape_ident_if_needed = (ident: string) =>
  if (String.length(ident) == 0) {
    ident;
  } else {
    let first_char = ident.[0];
    let needs_escape =
      /* Starts with a digit (0-9) */
      first_char >= '0'
      && first_char <= '9'
      /* Or starts with hyphen followed by digit */
      || first_char == '-'
      && String.length(ident) > 1
      && ident.[1] >= '0'
      && ident.[1] <= '9';
    if (needs_escape) {
      /* Escape the first character as \HH followed by space */
      let hex = Printf.sprintf("\\%X ", Char.code(first_char));
      hex ++ String.sub(ident, 1, String.length(ident) - 1);
    } else {
      ident;
    };
  }

and component_value = (ast: Ast.component_value) => {
  switch (ast) {
  | Whitespace => " "
  | Paren_block(block) => "(" ++ component_value_list(block) ++ ")"
  | Bracket_block(block) => "[" ++ component_value_list(block) ++ "]"
  | Percentage(string) => string ++ "%"
  | Ident(string) => escape_ident_if_needed(string)
  | String(string) => "\"" ++ string ++ "\""
  | Uri(string) => "url(\"" ++ string ++ "\")"
  | Operator(string) => string
  | Combinator(string) => string
  | Delim(string) => string
  | Function(name, body) =>
    let body = body |> fst |> component_value_list;
    Printf.sprintf("%s(%s)", fst(name), body);
  | Hash(string) => "#" ++ string
  | Number(n) => n
  | Unicode_range(string) => string
  | Float_dimension((a, b)) => Printf.sprintf("%s%s", a, b)
  | Dimension((a, b)) => Printf.sprintf("%s%s", a, b)
  | Variable(v) => variable(v)
  | Selector(v) => selector_list(v)
  };
};
