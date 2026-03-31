let rec strip_leading_whitespace = (ast: Ast.component_value_list) =>
  switch (ast) {
  | [] => []
  | [(Whitespace, _), ...rest] => strip_leading_whitespace(rest)
  | xs => xs
  };

let rec stylesheet = (ast: Ast.stylesheet) => {
  ast |> fst |> List.map(rule) |> String.concat("");
}
and rule = (ast: Ast.rule) => {
  switch (ast) {
  | Declaration(d) => declaration(d)
  | Style_rule(sr) => style_rule(sr)
  | At_rule(ar) => at_rule(ar)
  };
}
and style_rule = ({ prelude, block, _ }: Ast.style_rule) => {
  Printf.sprintf(
    "%s{%s}",
    prelude |> fst |> selector_list,
    rule_list(block),
  );
}
and at_rule = ({ name, prelude, block, _ }: Ast.at_rule) => {
  Printf.sprintf(
    "@%s %s{%s}",
    name |> fst,
    prelude |> fst |> strip_leading_whitespace |> component_value_list,
    brace_block(block),
  );
}
and brace_block = ast => {
  switch ((ast: Ast.brace_block)) {
  | Empty => ""
  | Rule_list(rl) => rule_list(rl)
  | Stylesheet(s) => stylesheet(s)
  };
}
and rule_list = (rule_list: Ast.rule_list) => {
  rule_list
  |> fst
  |> List.filter(
       fun
       | Ast.Style_rule({ block: (block, _), _ })
           when List.length(block) == 0 =>
         false
       | _ => true,
     )
  |> List.map(rule)
  |> String.concat("");
}
and declaration = ({ name, value, important, _ }: Ast.declaration) => {
  Printf.sprintf(
    "%s:%s%s;",
    name |> fst,
    value |> fst |> strip_leading_whitespace |> component_value_list,
    important |> fst ? " !important" : "",
  );
}
and component_value_list = (ast: Ast.component_value_list) => {
  ast |> List.map(fst) |> List.map(component_value) |> String.concat("");
}

and variable = v => "$(" ++ v ++ ")"

and selector = (ast: Ast.selector) => {
  let rec render_simple_selector =
    fun
    | Ast.Universal => "*"
    | Ampersand => "&"
    | Type(v) => v
    | Subclass(v) => render_subclass_selector(v)
    | Variable(v, _) => variable(v)
    | Percentage(p) => Tokens.float_to_string(p) ++ "%"
  and render_subclass_selector: Ast.subclass_selector => string =
    fun
    | Ast.Id(v) => Printf.sprintf("#%s", v)
    | Class(v) => Printf.sprintf(".%s", v)
    | Attribute(attr) => Printf.sprintf("[%s]", render_attribute(attr))
    | Pseudo_class(psc) => render_pseudo_selector(psc)
    | ClassVariable(v, _) => "." ++ variable(v)
  and render_attr_matcher =
    fun
    | Ast.Attr_exact => "="
    | Attr_member => "~="
    | Attr_prefix_dash => "|="
    | Attr_prefix => "^="
    | Attr_suffix => "$="
    | Attr_substring => "*="
  and render_attribute =
    fun
    | Ast.Attr_value(v) => v
    | To_equal({ name, kind, value }) =>
      name ++ render_attr_matcher(kind) ++ render_attr_value(value)
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
    | ANB(a, op, b) => {
        let a_str =
          switch (a) {
          | 1 => "n"
          | (-1) => "-n"
          | _ => string_of_int(a) ++ "n"
          };
        let (actual_op, b_abs) =
          if (b < 0) {
            ("-", Int.abs(b));
          } else {
            (op, b);
          };
        a_str ++ actual_op ++ string_of_int(b_abs);
      }
  and render_nth_payload =
    fun
    | Ast.Nth(nth) => render_nth(nth)
    | NthSelector(v) =>
      v |> List.map(render_complex_selector) |> String.concat(", ")
  and render_pseudo_class =
    fun
    | Ast.PseudoIdent(i) => ":" ++ i
    | Function({ name, payload: (sl, _) }) =>
      ":" ++ name ++ "(" ++ selector_list(sl) ++ ")"
    | NthFunction({ name, payload: (selector, _) }) =>
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
    | Combinator({ left, right }) =>
      let left = selector(left);
      let right = render_right_combinator(right);
      left ++ right;
    | Selector(s) => selector(s)
    };
  }
  and render_selector_combinator = combinator => {
    switch (combinator: Ast.selector_combinator) {
    | Ast.Selector_descendant => " "
    | Selector_child => " > "
    | Selector_adjacent_sibling => " + "
    | Selector_general_sibling => " ~ "
    };
  }
  and render_relative_combinator = combinator => {
    switch (combinator: Ast.selector_combinator) {
    | Ast.Selector_descendant => ""
    | Selector_child => "> "
    | Selector_adjacent_sibling => "+ "
    | Selector_general_sibling => "~ "
    };
  }
  and render_right_combinator = right => {
    right
      |> List.map(((combinator, s)) => {
          render_selector_combinator(combinator)
          ++ selector(s)
        })
      |> String.concat("");
  }
  and render_relative_selector =
      ({ combinator, complex_selector }: Ast.relative_selector) => {
    Option.fold(~none="", ~some=render_relative_combinator, combinator)
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

and dimension = ({ value, unit, _ }: Ast.dimension) => {
  Tokens.float_to_string(value) ++ unit;
}

and delimiter = (ast: Ast.delimiter) => {
  switch (ast) {
  | Ast.Delimiter_colon => ":"
  | Delimiter_double_colon => "::"
  | Delimiter_comma => ","
  | Delimiter_dot => "."
  | Delimiter_asterisk => "*"
  | Delimiter_ampersand => "&"
  | Delimiter_plus => "+"
  | Delimiter_minus => "-"
  | Delimiter_tilde => "~"
  | Delimiter_greater_than => ">"
  | Delimiter_less_than => "<"
  | Delimiter_equals => "="
  | Delimiter_slash => "/"
  | Delimiter_exclamation => "!"
  | Delimiter_pipe => "|"
  | Delimiter_caret => "^"
  | Delimiter_dollar_sign => "$"
  | Delimiter_question_mark => "?"
  | Delimiter_hash => "#"
  | Delimiter_at => "@"
  | Delimiter_percent => "%"
  | Delimiter_underscore => "_"
  | Delimiter_gte => ">="
  | Delimiter_lte => "<="
  | Delimiter_other(value) => value
  };
}
and component_value = (ast: Ast.component_value) => {
  switch (ast) {
  | Whitespace => " "
  | Paren_block(block) => "(" ++ component_value_list(block) ++ ")"
  | Bracket_block(block) => "[" ++ component_value_list(block) ++ "]"
  | Percentage(value) => Tokens.float_to_string(value) ++ "%"
  | Ident(string) => string
  | String(string) => "\"" ++ string ++ "\""
  | Uri(string) => "url(\"" ++ string ++ "\")"
  | Delim(value) => delimiter(value)
  | Function({name: (name, _), body: (body, _), _}) =>
    Printf.sprintf("%s(%s)", name, component_value_list(body));
  | Hash((string, _)) => "#" ++ string
  | Number(n) => Tokens.float_to_string(n)
  | Unicode_range(string) => string
  | Dimension(value) => dimension(value)
  | Variable(v, _) => variable(v)
  | Selector(v) => selector_list(v)
  };
};
