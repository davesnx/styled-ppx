open Reason_css_parser;
open Reason_css_lexer;
open Modifier;
open Rule;
open Rule.Let;
open Rule.Pattern;
open Combinator;
open Standard;

[@deriving show]
type complex_selector =
  | Selector(compound_selector)
  | Combinator({
      left: complex_selector,
      combinator,
      right: compound_selector,
    })
and compound_selector = {
  type_selector: option(string),
  subclass_selectors: list(subclass_selector),
  pseudo_selectors: list(pseudo_selector),
}
and subclass_selector =
  | Id(string)
  | Class(string)
  | Attribute(attribute_selector)
and attribute_selector =
  | Exists(string)
  | To_equal({
      name: string,
      kind: option([ | `Asterisk | `Caret | `Dollar | `Pipe | `Tilde]),
      value: string,
      modifier: option([ | `i | `s]),
    })
and pseudo_selector =
  | Pseudo_class(pseudo_selector_kind)
  | Pseudo_element(pseudo_selector_kind)
and pseudo_selector_kind =
  | Ident(string)
  | Function({
      name: string,
      payload: list(token),
    })
and combinator =
  | Juxtaposition
  | Greater
  | Plus
  | Tilde;

let whitespace = expect(WHITESPACE);
let rec selector_list = tokens => complex_selector_list(tokens)
and complex_selector_list = tokens =>
  repeat_by_comma(
    (1, None),
    {
      let.bind_match _ = optional(whitespace);
      let.bind_match selector = complex_selector;
      let.map_match _ = optional(whitespace);
      selector;
    },
    tokens,
  )
and compound_selector_list = tokens =>
  repeat_by_comma((1, None), compound_selector, tokens)
and simple_selector_list = tokens =>
  repeat_by_comma((1, None), simple_selector, tokens)
and relative_selector_list = tokens =>
  repeat_by_comma((1, None), relative_selector, tokens)

and complex_selector = tokens =>
  {
    let.bind_match first = compound_selector;
    let.map_match rest =
      zero_or_more(
        {
          let.bind_match combinator = combinator;
          let.map_match selector = compound_selector;
          (combinator, selector);
        },
      );
    rest
    |> List.fold_left(
         (left, (combinator, right)) =>
           Combinator({left, combinator, right}),
         Selector(first),
       );
  }(
    tokens,
  )
and relative_selector = tokens =>
  {
    let.bind_match combinator = optional(combinator);
    let.map_match selector = complex_selector;
    (combinator, selector);
  }(
    tokens,
  )
and compound_selector = tokens =>
  {
    let.bind_match type_selector = optional(type_selector);
    let.bind_match subclass_selectors = zero_or_more(subclass_selector);
    let.bind_match pseudo_selectors =
      zero_or_more(
        // TODO: this isn't how the spec excepts
        // TODO: it accepts ::before:active
        // https://drafts.csswg.org/selectors-4/#typedef-compound-selector
        combine_xor([
          Match.map(pseudo_element_selector, v => Pseudo_element(v)),
          Match.map(pseudo_class_selector, v => Pseudo_class(v)),
        ]),
      );
    switch (type_selector, subclass_selectors, pseudo_selectors) {
    | (None, [], []) => Data.return(Error(["expected a selector"]))
    | _ => Match.return({type_selector, subclass_selectors, pseudo_selectors})
    };
  }(
    tokens,
  )
and simple_selector = tokens =>
  combine_xor(
    [
      Match.map(type_selector, v => `Type(v)),
      Match.map(subclass_selector, v => `Subclass(v)),
    ],
    tokens,
  )
and combinator = tokens =>
  {
    let match_combinator =
      token(
        // TODO: incomplete '>' | '+' | '~' | [ '|' '|' ]
        fun
        | WHITESPACE => Ok(Juxtaposition)
        | DELIM(">") => Ok(Greater)
        | DELIM("+") => Ok(Plus)
        | DELIM("~") => Ok(Tilde)
        | _ => Error([">", "+", "~"]),
      );
    let match_combinator_prefixed_by_whitespace = {
      let.bind_match _ = whitespace;
      match_combinator;
    };
    let.bind_match data =
      combine_xor([
        match_combinator_prefixed_by_whitespace,
        match_combinator,
      ]);
    let.map_match _ = optional(whitespace);
    data;
  }(
    tokens,
  )
// TODO: ns-prefix and wq_name
and type_selector = tokens => wq_name(tokens)
and wq_name = ident
and subclass_selector = tokens =>
  combine_xor(
    [
      Match.map(id_selector, v => Id(v)),
      Match.map(class_selector, v => Class(v)),
      Match.map(attribute_selector, v => Attribute(v)),
    ],
    tokens,
  )
and id_selector =
  token(
    fun
    // TODO: should use the second parameter of hash?
    | HASH(id, _) => Ok(id)
    | _ => Error(["#"]),
  )
and class_selector = {
  let.bind_match () = expect(DELIM("."));
  ident;
}
and attribute_selector = tokens =>
  combine_xor(
    [
      {
        let.bind_match () = expect(LEFT_SQUARE);
        let.bind_match name = wq_name;
        let.map_match () = expect(RIGHT_SQUARE);
        Exists(name);
      },
      {
        let.bind_match () = expect(LEFT_SQUARE);
        let.bind_match name = wq_name;
        let.bind_match kind = attr_matcher;
        let.bind_match value =
          token(
            fun
            | IDENT(id) => Ok(id)
            | STRING(str) => Ok(str)
            | _ => Error(["<string-token>", "<ident-token>"]),
          );
        let.bind_match _ = optional(whitespace);
        let.bind_match modifier = optional(attr_modifier);
        let.map_match () = expect(RIGHT_SQUARE);
        To_equal({name, kind, value, modifier});
      },
    ],
    tokens,
  )
and attr_matcher = {
  let.bind_match kind =
    token(
      fun
      | DELIM("~") => Ok(`Tilde)
      | DELIM("|") => Ok(`Pipe)
      | DELIM("^") => Ok(`Caret)
      | DELIM("$") => Ok(`Dollar)
      | DELIM("*") => Ok(`Asterisk)
      | _ => Error(["~", "|", "^", "$", "*"]),
    )
    |> optional;
  let.map_match () = expect(DELIM("="));
  kind;
}
and attr_modifier =
  token(
    fun
    | STRING("i") => Ok(`i)
    | STRING("s") => Ok(`s)
    | _ => Error(["i", "s"]),
  )
and pseudo_class_selector = {
  let.bind_match () = expect(COLON);
  combine_xor([
    Match.map(ident, id => Ident(id)),
    {
      let.bind_match name =
        token(
          fun
          | FUNCTION(name) => Ok(name)
          | _ => Error(["fn("]),
        );
      // TODO: is whitespace here okay?
      let.bind_match tokens = {
        let rec match_until_parens = (acc, tokens) =>
          switch (tokens) {
          | [RIGHT_PARENS, ..._]
          | [] => Match.return(acc, tokens)
          | [token, ...tokens] =>
            match_until_parens([token, ...acc], tokens)
          };
        let.map_match tokens = match_until_parens([]);
        tokens |> List.rev;
      };
      let.map_match () = expect(RIGHT_PARENS);
      Function({name, payload: tokens});
    },
  ]);
}
and pseudo_element_selector = tokens =>
  {
    let.bind_match () = expect(COLON);
    pseudo_class_selector;
  }(tokens);
