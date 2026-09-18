let rec strip_leading_whitespace = (ast: Ast.component_value_list) =>
  switch (ast) {
  | [] => []
  | [(Whitespace, _), ...rest] => strip_leading_whitespace(rest)
  | xs => xs
  };

let strip_trailing_whitespace = (ast: Ast.component_value_list) =>
  ast |> List.rev |> strip_leading_whitespace |> List.rev;

let strip_whitespace = (ast: Ast.component_value_list) =>
  ast |> strip_leading_whitespace |> strip_trailing_whitespace;

/* Only whitespace next to `,` or `:` is dropped; elsewhere it can be
   semantic (`calc(1px + 2px)`, `1px 2px`). */
let is_comma_or_colon = (value: Ast.component_value) =>
  switch (value) {
  | Delim(Delimiter_comma)
  | Delim(Delimiter_colon) => true
  | _ => false
  };

let rec drop_whitespace_around_commas = (ast: Ast.component_value_list) =>
  switch (ast) {
  | [] => []
  | [(Whitespace, _), (next, next_loc), ...rest]
      when is_comma_or_colon(next) =>
    drop_whitespace_around_commas([(next, next_loc), ...rest])
  | [(value, loc), (Whitespace, _), ...rest] when is_comma_or_colon(value) => [
      (value, loc),
      ...drop_whitespace_around_commas(rest),
    ]
  | [value, ...rest] => [value, ...drop_whitespace_around_commas(rest)]
  };

/* Minification is a pure AST pass, applied before the (always verbatim)
   renderer: edge whitespace is stripped and comma/colon-adjacent whitespace
   dropped, recursively through block and function bodies. Custom property
   values skip this pass entirely (see `declaration`). */
let rec minify_component_values = (ast: Ast.component_value_list) =>
  ast
  |> strip_whitespace
  |> drop_whitespace_around_commas
  |> List.map(((value, loc): Ast.with_loc(Ast.component_value)) =>
       (minify_component_value(value), loc)
     )
and minify_component_value = (value: Ast.component_value) =>
  switch (value) {
  | Ast.Paren_block(block) =>
    Ast.Paren_block(minify_component_values(block))
  | Ast.Bracket_block(block) =>
    Ast.Bracket_block(minify_component_values(block))
  | Ast.Function({ name, kind, body: (body, body_loc) }) =>
    Ast.Function({
      name,
      kind,
      body: (minify_component_values(body), body_loc),
    })
  | other => other
  };

let rec stylesheet = (ast: Ast.stylesheet) => {
  ast |> fst |> rules;
}
/* The semicolon after the last declaration of a block is a separator, not a
   terminator: `.a{color:red}` is valid, so the minified output drops it.
   Statement at-rules keep theirs -- our parser requires it on re-parse. */
and rules = items => {
  let rec render_all =
    fun
    | [] => []
    | [Ast.Declaration(d)] => [declaration(~last=true, d)]
    | [r, ...rest] => [rule(r), ...render_all(rest)];
  items |> render_all |> String.concat("");
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
  let name = name |> fst |> Tokens.serialize_identifier;
  let prelude =
    prelude |> fst |> minify_component_values |> component_value_list;
  /* The separating space can be dropped when the prelude starts with a code
     point that cannot continue the at-keyword (`@page:left`). */
  let header =
    if (prelude == "") {
      "@" ++ name;
    } else if (prelude.[0] == ':') {
      "@" ++ name ++ prelude;
    } else {
      "@" ++ name ++ " " ++ prelude;
    };
  switch (block) {
  /* Statement at-rules (`@import`, `@charset`, `@layer a, b;`) have no
     block and terminate with a semicolon; `{}` would be invalid CSS. */
  | Empty => header ++ ";"
  | Rule_list(_)
  | Stylesheet(_) => Printf.sprintf("%s{%s}", header, brace_block(block))
  };
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
       | Ast.Style_rule({ block: ([], _), _ }) => false
       | _ => true,
     )
  |> rules;
}
and declaration =
    (~last=false, { name, value, important, _ }: Ast.declaration) => {
  let name = fst(name);
  /* A custom property's value is an observable token stream
     (css-variables: `getPropertyValue`, non-CSS `var()` consumers), so it
     only gets edge-trimmed, never minified. */
  let is_custom_property =
    String.length(name) >= 2 && name.[0] == '-' && name.[1] == '-';
  let rendered_value =
    is_custom_property
      ? value |> fst |> strip_whitespace |> component_value_list
      : value |> fst |> minify_component_values |> component_value_list;
  Printf.sprintf(
    "%s:%s%s%s",
    Tokens.serialize_identifier(name),
    rendered_value,
    important |> fst ? "!important" : "",
    last ? "" : ";",
  );
}
and component_value_list = (ast: Ast.component_value_list) => {
  ast |> List.map(fst) |> List.map(component_value) |> String.concat("");
}

and variable = v => "$(" ++ v ++ ")"

and selector = (ast: Ast.selector) => {
  /* Type selectors may carry a namespace prefix (`svg|circle`, `*|circle`,
     `|circle`); each segment around the `|` separator is escaped on its
     own so the separator itself survives. Known limitation: the prefix is
     stored flat in the `Type` string, so an element name containing an
     escaped pipe (`foo\|bar`) is indistinguishable from a namespaced one
     and re-renders as namespace syntax. */
  let render_type_selector = v =>
    v
    |> String.split_on_char('|')
    |> List.map(segment =>
         segment == "*" ? "*" : Tokens.serialize_identifier(segment)
       )
    |> String.concat("|");
  /* Cross-module selector references travel through rendered CSS as
     NUL-delimited sentinels (`\x00LONGIDENT\x00`, see
     documents/css-extraction.md). The aggregator substitutes them with
     already-minted class names, so they must survive rendering verbatim:
     escaping would corrupt the wire protocol and break resolution. */
  let render_class_name = v =>
    String.contains(v, '\000') ? v : Tokens.serialize_identifier(v);
  let rec render_simple_selector =
    fun
    | Ast.Universal => "*"
    | Ampersand => "&"
    | Type(v) => render_type_selector(v)
    | Subclass(v) => render_subclass_selector(v)
    | Variable(v, _) => variable(v)
    | Percentage(p) => Tokens.float_to_string(p) ++ "%"
  and render_subclass_selector: Ast.subclass_selector => string =
    fun
    | Ast.Id(v) => "#" ++ Tokens.serialize_identifier(v)
    | Class(v) => "." ++ render_class_name(v)
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
    | Ast.Attr_value(v) => render_type_selector(v)
    | To_equal({ name, kind, value, case_sensitivity }) =>
      render_type_selector(name)
      ++ render_attr_matcher(kind)
      ++ render_attr_value(value)
      ++ render_attr_case(case_sensitivity)
  and render_attr_case =
    fun
    | None => ""
    | Some(Ast.Attr_case_insensitive) => " i"
    | Some(Ast.Attr_case_sensitive) => " s"
  and render_attr_value =
    fun
    | Ast.Attr_ident(i) => Tokens.serialize_identifier(i)
    /* `[type="text"]` and `[type=text]` match the same. */
    | Attr_string(str)
        when str != "" && !Tokens.needs_ident_serialization(str) => str
    | Attr_string(str) => Tokens.serialize_string(str)
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
      v |> List.map(render_complex_selector) |> String.concat(",")
    | NthOf(nth, v) =>
      render_nth(nth)
      ++ " of "
      ++ (v |> List.map(render_complex_selector) |> String.concat(","))
  and render_pseudo_class =
    fun
    | Ast.PseudoIdent(i) => ":" ++ Tokens.serialize_identifier(i)
    | Function({ name, payload: (sl, _) }) =>
      ":"
      ++ Tokens.serialize_identifier(name)
      ++ "("
      ++ selector_list(sl)
      ++ ")"
    | NthFunction({ name, payload: (selector, _) }) =>
      ":"
      ++ Tokens.serialize_identifier(name)
      ++ "("
      ++ render_nth_payload(selector)
      ++ ")"
  and render_pseudo_selector =
    fun
    | Ast.Pseudoelement(v) => "::" ++ Tokens.serialize_identifier(v)
    | PseudoelementFunction({ name, payload: (sl, _) }) =>
      "::"
      ++ Tokens.serialize_identifier(name)
      ++ "("
      ++ selector_list(sl)
      ++ ")"
    | Pseudoclass(pc) => render_pseudo_class(pc)
  and render_compound_selector = (compound_selector: Ast.compound_selector) => {
    /* Selectors 4 (SS 3.5): `*` in a compound with other simple selectors
       is redundant -- `*[href]` is `[href]`. */
    let type_selector =
      switch (compound_selector.type_selector) {
      | Some(Ast.Universal)
          when
            compound_selector.subclass_selectors != []
            || compound_selector.pseudo_selectors != [] =>
        None
      | other => other
      };
    let simple_selector =
      Option.fold(~none="", ~some=render_simple_selector, type_selector);
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
    switch ((combinator: Ast.selector_combinator)) {
    | Ast.Selector_descendant => " "
    | Selector_child => ">"
    | Selector_adjacent_sibling => "+"
    | Selector_general_sibling => "~"
    | Selector_column => "||"
    };
  }
  and render_relative_combinator = combinator => {
    switch ((combinator: Ast.selector_combinator)) {
    | Ast.Selector_descendant => ""
    | Selector_child => ">"
    | Selector_adjacent_sibling => "+"
    | Selector_general_sibling => "~"
    | Selector_column => "||"
    };
  }
  and render_right_combinator = right => {
    right
    |> List.map(((combinator, s)) => {
         render_selector_combinator(combinator) ++ selector(s)
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
  Tokens.float_to_string(value) ++ Tokens.serialize_identifier(unit);
}

and delimiter = (ast: Ast.delimiter) => Ast.string_of_delimiter(ast)
and component_value = (ast: Ast.component_value) => {
  switch (ast) {
  | Whitespace => " "
  | Paren_block(block) => "(" ++ component_value_list(block) ++ ")"
  | Bracket_block(block) => "[" ++ component_value_list(block) ++ "]"
  | Percentage(value) => Tokens.float_to_string(value) ++ "%"
  | Ident(string) => Tokens.serialize_identifier(string)
  | String(string) => Tokens.serialize_string(string)
  | Uri(string) => Tokens.serialize_uri(string)
  | Delim(value) => delimiter(value)
  | Function({ name: (name, _), body: (body, _), _ }) =>
    Printf.sprintf(
      "%s(%s)",
      Tokens.serialize_identifier(name),
      component_value_list(body),
    )
  /* Hash tokens are not identifiers: `#0f0` must stay untouched. */
  | Hash((string, _)) => "#" ++ string
  | Number(n) => Tokens.float_to_string(n)
  | Unicode_range(string) => string
  | Dimension(value) => dimension(value)
  | Variable(v, _) => variable(v)
  | Selector(v) => selector_list(v)
  | At_keyword(name) => "@" ++ Tokens.serialize_identifier(name)
  | Cdo => "<!--"
  | Cdc => "-->"
  };
};
