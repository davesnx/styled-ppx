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
  let resolved_rule_list = {
    let (declarations, selectors) =
      rule_list |> fst |> Resolve.resolve_selectors |> Resolve.split_by_kind;
    declarations @ selectors;
  };
  resolved_rule_list
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

and variable = v => "$(" ++ String.concat(".", v) ++ ")"

and selector = (ast: Ast.selector) => {
  let rec render_simple_selector =
    fun
    | Ast.Universal => "*"
    | Ampersand => "&"
    | Type(v) => v
    | Subclass(v) => render_subclass_selector(v)
    | Variable(v) => variable(v)
    | Percentage(p) => Tokens.float_to_string(p) ++ "%"
  and render_subclass_selector: Ast.subclass_selector => string =
    fun
    | Ast.Id(v) => Printf.sprintf("#%s", v)
    | Class(v) => Printf.sprintf(".%s", v)
    | Attribute(attr) => Printf.sprintf("[%s]", render_attribute(attr))
    | Pseudo_class(psc) => render_pseudo_selector(psc)
    | ClassVariable(v) => "." ++ variable(v)
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
  and render_right_combinator = right => {
    right
    |> List.map(((combinator, s)) => {
         Option.fold(~none=" ", ~some=o => " " ++ o ++ " ", combinator)
         ++ selector(s)
       })
    |> String.concat("");
  }
  and render_relative_selector =
      ({ combinator, complex_selector }: Ast.relative_selector) => {
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
and component_value = (ast: Ast.component_value) => {
  switch (ast) {
  | Whitespace => " "
  | Paren_block(block) => "(" ++ component_value_list(block) ++ ")"
  | Bracket_block(block) => "[" ++ component_value_list(block) ++ "]"
  | Percentage(value) => Tokens.float_to_string(value) ++ "%"
  | Ident(string) => string
  | String(string) => "\"" ++ string ++ "\""
  | Uri(string) => "url(\"" ++ string ++ "\")"
  | Delim(string) => string
  | Function(name, body) =>
    let body = body |> fst |> component_value_list;
    Printf.sprintf("%s(%s)", fst(name), body);
  | Hash(string) => "#" ++ string
  | Number(n) => Tokens.float_to_string(n)
  | Unicode_range(string) => string
  | Dimension((a, b)) => Tokens.float_to_string(a) ++ b
  | Variable(v) => variable(v)
  | Selector(v) => selector_list(v)
  };
};
