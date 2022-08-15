type with_loc('a) = ('a, Location.t);

module rec Component_value: {
  type t =
    | Paren_block(list(with_loc(t)))
    | Bracket_block(list(with_loc(t)))
    | Percentage(string)
    | Ident(string)
    | String(string)
    | Selector(with_loc(Selector.t))
    | Uri(string)
    | Operator(string)
    | Combinator(string)
    | Delim(string)
    | Function(with_loc(string), with_loc(list(with_loc(t))))
    | Hash(string)
    | Number(string)
    | Unicode_range(string)
    | Float_dimension((string, string))
    | Dimension((string, string))
    | Variable(list(string));
} = Component_value
and Brace_block: {
  type t =
    | Empty
    | Rule_list(Rule_list.t)
    | Stylesheet(Stylesheet.t);
} = Brace_block
and At_rule: {
  type t = {
    name: with_loc(string),
    prelude: with_loc(list(with_loc(Component_value.t))),
    block: Brace_block.t,
    loc: Location.t,
  };
} = At_rule
and Declaration: {
  type t = {
    name: with_loc(string),
    value: with_loc(list(with_loc(Component_value.t))),
    important: with_loc(bool),
    loc: Location.t,
  };
} = Declaration
and Rule_list: {
  type t = with_loc(list(Rule.t));
} = Rule_list
and Style_rule: {
  type t = {
    prelude: with_loc(Selector.t),
    block: Rule_list.t,
    loc: Location.t,
  };
} = Style_rule
and Rule: {
  type t =
    | Declaration(Declaration.t)
    | Style_rule(Style_rule.t)
    | At_rule(At_rule.t);
} = Rule
and Stylesheet: {
  type t = with_loc(list(Rule.t));
} = Stylesheet
and Selector: {
  type t =
    | SimpleSelector(list(simple_selector))
    | ComplexSelector(list(complex_selector))
    | CompoundSelector(list(compound_selector))
  and complex_selector =
    | Selector(compound_selector)
    | Combinator({
        left: compound_selector,
        right: list((option(string), compound_selector)),
      })
  and compound_selector = {
    type_selector: option(simple_selector),
    subclass_selectors: list(subclass_selector),
    pseudo_selectors: list(pseudo_selector),
  }
  and simple_selector =
    | Universal
    | Ampersand
    | Type(string)
    | Subclass(subclass_selector)
    | Variable(list(string))
    | Percentage(string)
  and subclass_selector =
    | Id(string)
    | Class(string)
    | ClassVariable(list(string))
    | Attribute(attribute_selector)
    | Pseudo_class(pseudo_selector)
  and attribute_selector =
    | Attr_value(string)
    | To_equal({
        name: string,
        kind: string,
        value: attr_value,
      })
  and attr_value =
    | Attr_ident(string)
    | Attr_string(string)
  and pseudo_selector =
    | Pseudoelement(string)
    | Pseudoclass(pseudoclass_kind)
  and pseudoclass_kind =
    | Ident(string)
    | Function({
        name: string,
        payload: with_loc(t),
      })
    | NthFunction({
        name: string,
        payload: with_loc(nth_payload),
      })
  and nth_payload =
    | Nth(nth)
    | NthSelector(list(complex_selector))
  and nth =
    | NthIdent(string)
    | A(string)
    | AN(string)
    | ANB(string, string, string)
} = Selector;

module Debug = {
  let render_field = ((key, value)) => Printf.sprintf("  %s: %s", key, value);

  let render_record = record =>
    record
    |> List.map(render_field)
    |> String.concat(",\n")
    |> Printf.sprintf("{\n%s\n}");

  let rec render_stylesheet = (ast: Stylesheet.t) => {
    let inner = ast |> fst |> List.map(render_rule) |> String.concat(", ");
    "Stylesheet(" ++ inner ++ ")";
  }
  and render_rule = (ast: Rule.t) => {
    switch (ast) {
    | Declaration(declaration) => "Declaration(" ++ render_declaration(declaration) ++ ")"
    | Style_rule(style_rule) =>
      "Style_rule(" ++ render_style_rule(style_rule) ++ ")"
    | At_rule(at_rule) => "At_rule(" ++ render_at_rule(at_rule) ++ ")"
    };
  }
  and render_style_rule = (ast: Style_rule.t) => {
    render_record([
      ("prelude", ast.prelude |> fst |> render_selector),
      ("block", render_rule_list(ast.block)),
    ]);
  }
  and render_at_rule = (ast: At_rule.t) => {
    render_record([
      ("prelude", ast.prelude |> render_declaration_value),
      ("block", render_brace_block(ast.block)),
    ]);
  }
  and render_brace_block = ast => {
    switch ((ast: Brace_block.t)) {
    | Empty => "Empty"
    | Rule_list(rule_list) => render_rule_list(rule_list)
    | Stylesheet(stylesheet) => render_stylesheet(stylesheet)
    };
  }
  and render_rule_list = (ast: Rule_list.t) => {
    let inner =
      ast |> fst |> List.map(render_rule) |> String.concat(", ");
    "Declaration([" ++ inner ++ "])";
  }
  and render_declaration = (ast: Declaration.t) => {
    render_record([
      ("name", ast.name |> fst),
      ("value", ast.value |> render_declaration_value),
      ("important", ast.important |> fst |> string_of_bool),
    ]);
  }
  and render_declaration_value =
      (ast: with_loc(list(with_loc(Component_value.t)))) => {
    let inner =
      ast |> fst |> List.map(render_component_value) |> String.concat(", ");
    "[" ++ inner ++ "]";
  }

  and render_selector = (ast: Selector.t) => {
    open Selector;

    let rec render_simple_selector =
      fun
      | Universal => "Universal"
      | Ampersand => "Ampersand"
      | Type(v) => "Type(" ++ v ++ ")"
      | Subclass(v) => "Subclass(" ++ render_subclass_selector(v) ++ ")"
      | Variable(v) => "Variable(" ++ render_variable(v) ++ ")"
      | Percentage(p) => "Percentage(" ++ p ++ ")"
    and render_subclass_selector: subclass_selector => string =
      fun
      | Id(v) => "Id(" ++ v ++ ")"
      | Class(v) => "Class(" ++ v ++ ")"
      | Attribute(attr) => "Attribute(" ++ render_attribute(attr) ++ ")"
      | Pseudo_class(psc) => "Pseudo_class(" ++ render_pseudo_selector(psc) ++ ")"
      | ClassVariable(v) => "ClassVariable(" ++ render_variable(v) ++ ")"
    and render_attribute =
      fun
      | Attr_value(v) => "Attr_value(" ++ v ++ ")"
      | To_equal({name, kind, value}) =>
        "To_equal("
        ++ name
        ++ ", "
        ++ kind
        ++ ", "
        ++ render_attr_(value)
        ++ ")"
    and render_attr_ =
      fun
      | Attr_ident(i) => i
      | Attr_string(str) => "\"" ++ str ++ "\""
    and render_nth =
      fun
        | NthIdent(i) => "NthIdent(" ++ i ++ ")"
        | A(a) => "A(" ++ a ++ ")"
        | AN(a) => "AN(" ++ a ++ ")"
        | ANB(left, op, right) =>
          "ANB(" ++ left
            ++ ", " ++ op ++ ", "
            ++ right
          ++ ")"
    and render_nth_payload =
      fun
      | Nth(nth) => render_nth(nth)
      | NthSelector(v) => "NthSelector(ComplexSelector(["
      ++ (v |> List.map(render_complex_selector) |> String.concat(", "))
      ++ "]))"
    and render_pseudo_class =
      fun
        | Ident(i) => "Pseudoclass(Ident(" ++ i ++ "))"
        | Function({name, payload: (selector, _)}) =>
          "Function("
          ++ name
          ++ ", "
          ++ render_selector(selector)
          ++ ")"
        | NthFunction({name, payload: (selector, _)}) =>
          "Function("
          ++ name
          ++ ", "
          ++ render_nth_payload(selector)
          ++ ")"
    and render_pseudo_selector =
      fun
      | Pseudoelement(v) => "Pseudoelement(" ++ v ++ ")"
      | Pseudoclass(pc) => "Pseudoclass(" ++ render_pseudo_class(pc) ++ ")"
    and render_variable = v => String.concat(".", v)
    and render_compound_selector = (compound_selector: compound_selector) => {
      let simple_selector =
        compound_selector.type_selector
        |> Option.fold(~none="", ~some=render_simple_selector);
      let subclass_selectors =
        List.map(render_subclass_selector, compound_selector.subclass_selectors)
        |> String.concat("");
      let pseudo_selectors =
        List.map(render_pseudo_selector, compound_selector.pseudo_selectors)
        |> String.concat("");

      let is_not_empty = s => String.length(s |> String.trim) != 0;
      let compound = String.concat(", ", [simple_selector, subclass_selectors, pseudo_selectors] |> List.filter(is_not_empty));
      "Compound(" ++ compound ++ ")"
    }
    and render_complex_selector: complex_selector => string =
      fun
      | Selector(compound) => render_compound_selector(compound)
      | Combinator({left, right}) =>
        "Left(" ++ render_compound_selector(left) ++ "), Right(" ++ render_right_combinator(right) ++ ")"
    and render_right_combinator = right => {
      right
      |> List.map(((combinator, compound_selector)) => {
          String.concat(", ", [Option.fold(
            ~none="Whitespace",
            ~some=o => "Combinator(" ++ o ++ ")",
            combinator,
          ), render_compound_selector(compound_selector)])
        })
      |> String.concat(", ");
    };

    switch (ast) {
    | SimpleSelector(v) =>
      "SimpleSelector(["
      ++ (v |> List.map(render_simple_selector) |> String.concat(", "))
      ++ "])"
    | ComplexSelector(v) =>
      "ComplexSelector(["
      ++ (v |> List.map(render_complex_selector) |> String.concat(", "))
      ++ "])"
    | CompoundSelector(v) =>
      "CompoundSelector(["
      ++ (v |> List.map(render_compound_selector) |> String.concat(", "))
      ++ "])"
    };
  }
  and render_component_value = (ast: with_loc(Component_value.t)) => {
    let value = ast |> fst;
    switch (value) {
    | Paren_block(block) =>
      let block =
        block |> List.map(render_component_value) |> String.concat(", ");
      "Paren_block(" ++ block ++ ")";
    | Bracket_block(block) =>
      let block =
        block |> List.map(render_component_value) |> String.concat(", ");
      "Bracket_block(" ++ block ++ ")";
    | Percentage(string) => "Percentage(" ++ string ++ ")"
    | Ident(string) => "Ident(" ++ string ++ ")"
    | String(string) => "String(" ++ string ++ ")"
    | Uri(string) => "Uri(" ++ string ++ ")"
    | Operator(string) => "Operator(" ++ string ++ ")"
    | Combinator(string) => "Combinator(" ++ string ++ ")"
    | Delim(string) => "Delim(" ++ string ++ ")"
    | Function(name, body) =>
      let body =
        body |> fst |> List.map(render_component_value) |> String.concat(", ");
      "Function(" ++ fst(name) ++ ", [" ++ body ++ "])";
    | Hash(string) => "Hash(" ++ string ++ ")"
    | Number(n) => "Number(" ++ n ++ ")"
    | Unicode_range(string) => "Unicode_range(" ++ string ++ ")"
    | Float_dimension((a, b)) => "Float_dimension(" ++ a ++ ", " ++ b ++ ")"
    | Dimension((a, b)) => "Dimension(" ++ a ++ ", " ++ b ++ ")"
    | Variable(variable) =>
      "Variable(" ++ (variable |> String.concat(".")) ++ ")"
    | Selector(v) =>
      let value = v |> fst |> render_selector;
      "Selector(" ++ value ++ ")";
    };
  };
}

module DebugWithLoc = {
  let render_positions = (pos1: Lexing.position, pos2: Lexing.position) => {
    let line = pos1.pos_lnum;
    Printf.sprintf(". (line %d, characters %d %d : %d %d)", line, pos1.pos_cnum + 1, pos1.pos_bol, pos2.pos_cnum + 1, pos2.pos_bol);
  };

  let get_pos_info = (pos: Lexing.position) => (
    pos.pos_fname,
    pos.pos_lnum,
    pos.pos_cnum - pos.pos_bol,
  );

  let print_loc = (loc: Location.t) => {
    let (_file, _line, startchar) = get_pos_info(loc.loc_start);
    let (_, _endline, endchar) = get_pos_info(loc.loc_end);
    /*let endchar = loc.loc_end.pos_cnum - loc.loc_start.pos_cnum + startchar in*/
    Printf.sprintf(" [%d:%d]", startchar, endchar);
  };

  let render_location = (loc: Location.t) => print_loc(loc);

  let render_field = ((key, value)) => Printf.sprintf("  %s: %s", key, value);

  let render_record = record =>
    record
    |> List.map(render_field)
    |> String.concat(",\n")
    |> Printf.sprintf("{\n%s\n}");

  let rec render_stylesheet = (ast: Stylesheet.t) => {
    let inner = ast |> fst |> List.map(render_rule) |> String.concat(", ");
    "Stylesheet(" ++ inner ++ ")" ++ render_location(ast |> snd);
  }
  and render_rule = (ast: Rule.t) => {
    switch (ast) {
    | Declaration(declaration) => "Declaration(" ++ render_declaration(declaration) ++ ")"
    | Style_rule(style_rule) =>
      "Style_rule(" ++ render_style_rule(style_rule) ++ ")"
    | At_rule(at_rule) => "At_rule(" ++ render_at_rule(at_rule) ++ ")"
    };
  }
  and render_style_rule = (ast: Style_rule.t) => {
    render_record([
      ("prelude", ast.prelude |> fst |> render_selector),
      ("block", render_rule_list(ast.block)),
    ]) ++ render_location(ast.loc);
  }
  and render_at_rule = (ast: At_rule.t) => {
    render_record([
      ("prelude", ast.prelude |> render_declaration_value),
      ("block", render_brace_block(ast.block)),
    ]);
  }
  and render_brace_block = ast => {
    switch ((ast: Brace_block.t)) {
    | Empty => "Empty"
    | Rule_list(rule_list) => render_rule_list(rule_list)
    | Stylesheet(stylesheet) => render_stylesheet(stylesheet)
    };
  }
  and render_rule_list = (ast: Rule_list.t) => {
    let inner =
      ast |> fst |> List.map(render_rule) |> String.concat(", ");
    "Declaration([" ++ inner ++ "])" ++ render_location(ast |> snd);
  }
  and render_declaration = (ast: Declaration.t) => {
    render_record([
      ("name", (ast.name |> fst) ++ (ast.name |> snd |> render_location)),
      ("value", ast.value |> render_declaration_value),
      // ("important", ast.important |> fst |> string_of_bool),
    ]) ++ render_location(ast.loc);
  }
  and render_declaration_value =
      (ast: with_loc(list(with_loc(Component_value.t)))) => {
    let inner =
      ast |> fst |> List.map(render_component_value) |> String.concat(", ");
    "[" ++ inner ++ "] ";
  }

  and render_selector = (ast: Selector.t) => {
    open Selector;

    let rec render_simple_selector =
      fun
      | Universal => "Universal"
      | Ampersand => "Ampersand"
      | Type(v) => "Type(" ++ v ++ ")"
      | Subclass(v) => "Subclass(" ++ render_subclass_selector(v) ++ ")"
      | Variable(v) => "Variable(" ++ render_variable(v) ++ ")"
      | Percentage(p) => "Percentage(" ++ p ++ ")"
    and render_subclass_selector: subclass_selector => string =
      fun
      | Id(v) => "Id(" ++ v ++ ")"
      | Class(v) => "Class(" ++ v ++ ")"
      | Attribute(attr) => "Attribute(" ++ render_attribute(attr) ++ ")"
      | Pseudo_class(psc) => "Pseudo_class(" ++ render_pseudo_selector(psc) ++ ")"
      | ClassVariable(v) => "ClassVariable(" ++ render_variable(v) ++ ")"
    and render_attribute =
      fun
      | Attr_value(v) => "Attr_value(" ++ v ++ ")"
      | To_equal({name, kind, value}) =>
        "To_equal("
        ++ name
        ++ ", "
        ++ kind
        ++ ", "
        ++ render_attr_(value)
        ++ ")"
    and render_attr_ =
      fun
      | Attr_ident(i) => i
      | Attr_string(str) => "\"" ++ str ++ "\""
    and render_nth =
      fun
        | NthIdent(i) => "NthIdent(" ++ i ++ ")"
        | A(a) => "A(" ++ a ++ ")"
        | AN(a) => "AN(" ++ a ++ ")"
        | ANB(left, op, right) =>
          "ANB(" ++ left
            ++ ", " ++ op ++ ", "
            ++ right
          ++ ")"
    and render_nth_payload =
      fun
      | Nth(nth) => render_nth(nth)
      | NthSelector(v) => "NthSelector(ComplexSelector(["
      ++ (v |> List.map(render_complex_selector) |> String.concat(", "))
      ++ "]))"
    and render_pseudo_class =
      fun
        | Ident(i) => "Pseudoclass(Ident(" ++ i ++ "))"
        | Function({name, payload: (selector, _)}) =>
          "Function("
          ++ name
          ++ ", "
          ++ render_selector(selector)
          ++ ")"
        | NthFunction({name, payload: (selector, _)}) =>
          "Function("
          ++ name
          ++ ", "
          ++ render_nth_payload(selector)
          ++ ")"
    and render_pseudo_selector =
      fun
      | Pseudoelement(v) => "Pseudoelement(" ++ v ++ ")"
      | Pseudoclass(pc) => "Pseudoclass(" ++ render_pseudo_class(pc) ++ ")"
    and render_variable = v => String.concat(".", v)
    and render_compound_selector = (compound_selector: compound_selector) => {
      let simple_selector =
        compound_selector.type_selector
        |> Option.fold(~none="", ~some=render_simple_selector);
      let subclass_selectors =
        List.map(render_subclass_selector, compound_selector.subclass_selectors)
        |> String.concat("");
      let pseudo_selectors =
        List.map(render_pseudo_selector, compound_selector.pseudo_selectors)
        |> String.concat("");

      let is_not_empty = s => String.length(s |> String.trim) != 0;
      let compound = String.concat(", ", [simple_selector, subclass_selectors, pseudo_selectors] |> List.filter(is_not_empty));
      "Compound(" ++ compound ++ ")"
    }
    and render_complex_selector: complex_selector => string =
      fun
      | Selector(compound) => render_compound_selector(compound)
      | Combinator({left, right}) =>
        "Left(" ++ render_compound_selector(left) ++ "), Right(" ++ render_right_combinator(right) ++ ")"
    and render_right_combinator = right => {
      right
      |> List.map(((combinator, compound_selector)) => {
          String.concat(", ", [Option.fold(
            ~none="Whitespace",
            ~some=o => "Combinator(" ++ o ++ ")",
            combinator,
          ), render_compound_selector(compound_selector)])
        })
      |> String.concat(", ");
    };

    switch (ast) {
    | SimpleSelector(v) =>
      "SimpleSelector(["
      ++ (v |> List.map(render_simple_selector) |> String.concat(", "))
      ++ "])"
    | ComplexSelector(v) =>
      "ComplexSelector(["
      ++ (v |> List.map(render_complex_selector) |> String.concat(", "))
      ++ "])"
    | CompoundSelector(v) =>
      "CompoundSelector(["
      ++ (v |> List.map(render_compound_selector) |> String.concat(", "))
      ++ "])"
    };
  }
  and render_component_value = (ast: with_loc(Component_value.t)) => {
    let value = switch (ast |> fst) {
      | Paren_block(block) =>
        let block =
          block |> List.map(render_component_value) |> String.concat(", ");
        "Paren_block(" ++ block ++ ")";
      | Bracket_block(block) =>
        let block =
          block |> List.map(render_component_value) |> String.concat(", ");
        "Bracket_block(" ++ block ++ ")";
      | Percentage(string) => "Percentage(" ++ string ++ ")"
      | Ident(string) => "Ident(" ++ string ++ ")"
      | String(string) => "String(" ++ string ++ ")"
      | Uri(string) => "Uri(" ++ string ++ ")"
      | Operator(string) => "Operator(" ++ string ++ ")"
      | Combinator(string) => "Combinator(" ++ string ++ ")"
      | Delim(string) => "Delim(" ++ string ++ ")"
      | Function(name, body) =>
        let body =
          body |> fst |> List.map(render_component_value) |> String.concat(", ");
        "Function(" ++ fst(name) ++ ", [" ++ body ++ "])";
      | Hash(string) => "Hash(" ++ string ++ ")"
      | Number(n) => "Number(" ++ n ++ ")"
      | Unicode_range(string) => "Unicode_range(" ++ string ++ ")"
      | Float_dimension((a, b)) => "Float_dimension(" ++ a ++ ", " ++ b ++ ")"
      | Dimension((a, b)) => "Dimension(" ++ a ++ ", " ++ b ++ ")"
      | Variable(variable) =>
        "Variable(" ++ (variable |> String.concat(".")) ++ ")"
      | Selector(v) => {
        let value = v |> fst |> render_selector;
        "Selector(" ++ value ++ ")";
      }}

    let loc = ast |> snd |> render_location;

    value ++ loc;
  };
}
