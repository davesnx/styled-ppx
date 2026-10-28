open Styled_ppx_css_parser.Ast;
module Render = Styled_ppx_css_parser.Render;
module Selector_nesting = Styled_ppx_css_parser.Selector_nesting;

let zero = (0, 0, 0);
let add = ((a, b, c), (x, y, z)) => (a + x, b + y, c + z);
let max_of =
  List.fold_left((acc, s) => compare(s, acc) > 0 ? s : acc, zero);

let is_legacy_pseudo_element = name =>
  switch (String.lowercase_ascii(name)) {
  | "before"
  | "after"
  | "first-line"
  | "first-letter" => true
  | _ => false
  };

/* Selectors 4 specificity: `:where()` counts nothing, `:is()`, `:not()`,
   `:has()` count their most specific argument, `:nth-child(An+B of S)`
   counts one class plus S. */
let rec specificity = (sel: selector) =>
  switch (sel) {
  | SimpleSelector(simple) => simple_specificity(simple)
  | CompoundSelector(compound) => compound_specificity(compound)
  | ComplexSelector(complex) => complex_specificity(complex)
  | RelativeSelector({ complex_selector, _ }) =>
    complex_specificity(complex_selector)
  }
and complex_specificity =
  fun
  | Selector(sel) => specificity(sel)
  | Combinator({ left, right }) =>
    List.fold_left(
      (acc, (_, sel)) => add(acc, specificity(sel)),
      specificity(left),
      right,
    )
and simple_specificity =
  fun
  | Universal
  | Ampersand
  | Percentage(_) => zero
  | Type(_) => (0, 0, 1)
  | Subclass(subclass) => subclass_specificity(subclass)
  | Variable(_) => (0, 1, 0)
and subclass_specificity =
  fun
  | Id(_) => (1, 0, 0)
  | Class(_)
  | ClassVariable(_)
  | Attribute(_) => (0, 1, 0)
  | Pseudo_class(pseudo) => pseudo_specificity(pseudo)
and pseudo_specificity =
  fun
  | Pseudoelement(_)
  | PseudoelementFunction(_) => (0, 0, 1)
  | Pseudoclass(PseudoIdent(name)) =>
    is_legacy_pseudo_element(name) ? (0, 0, 1) : (0, 1, 0)
  | Pseudoclass(Function({ name, payload: (selectors, _) })) =>
    switch (String.lowercase_ascii(name)) {
    | "where" => zero
    | "is"
    | "not"
    | "has"
    | "matches"
    | "-webkit-any"
    | "-moz-any" => list_specificity(selectors)
    | _ => (0, 1, 0)
    }
  | Pseudoclass(NthFunction({ payload: (Nth(_), _), _ })) => (0, 1, 0)
  | Pseudoclass(
      NthFunction({ payload: (NthSelector({ selectors, _ }), _), _ }),
    ) =>
    add((0, 1, 0), max_of(List.map(complex_specificity, selectors)))
and list_specificity = selectors =>
  max_of(List.map(((sel, _)) => specificity(sel), selectors))
and compound_specificity =
    ({ type_selector, subclass_selectors, pseudo_selectors }) =>
  List.fold_left(
    (acc, pseudo) => add(acc, pseudo_specificity(pseudo)),
    List.fold_left(
      (acc, subclass) => add(acc, subclass_specificity(subclass)),
      Option.fold(~none=zero, ~some=simple_specificity, type_selector),
      subclass_selectors,
    ),
    pseudo_selectors,
  );

let segment_subclasses = (segment: selector) =>
  switch (segment) {
  | CompoundSelector({ type_selector, subclass_selectors, _ }) =>
    switch (type_selector) {
    | Some(Subclass(subclass)) => [subclass, ...subclass_selectors]
    | _ => subclass_selectors
    }
  | SimpleSelector(Subclass(subclass)) => [subclass]
  | _ => []
  };

let has_class = (~name, segment) =>
  List.exists(
    fun
    | Class(c) => c == name
    | _ => false,
    segment_subclasses(segment),
  );

let has_any_class = segment =>
  List.exists(
    fun
    | Class(_) => true
    | _ => false,
    segment_subclasses(segment),
  );

let pseudo_element_name =
  fun
  | Pseudoelement(name) => Some("::" ++ String.lowercase_ascii(name))
  | PseudoelementFunction(_) as pseudo =>
    Some(
      Render.selector(
        CompoundSelector({
          type_selector: None,
          subclass_selectors: [],
          pseudo_selectors: [pseudo],
        }),
      ),
    )
  | Pseudoclass(PseudoIdent(name)) when is_legacy_pseudo_element(name) =>
    Some("::" ++ String.lowercase_ascii(name))
  | Pseudoclass(_) => None;

let pseudo_elements = (segment: selector) =>
  switch (segment) {
  | CompoundSelector({ subclass_selectors, pseudo_selectors, _ }) =>
    List.filter_map(
      fun
      | Pseudo_class(pseudo) => pseudo_element_name(pseudo)
      | _ => None,
      subclass_selectors,
    )
    @ List.filter_map(pseudo_element_name, pseudo_selectors)
  | _ => []
  };

/* The selector with the atom's own class written `&`, so two atoms that
   reach the same element through the same selector get the same key. */
let rec mask_selector = (~name, sel: selector) =>
  switch (sel) {
  | SimpleSelector(Subclass(Class(c))) when c == name =>
    SimpleSelector(Ampersand)
  | SimpleSelector(Subclass(subclass)) =>
    SimpleSelector(Subclass(mask_subclass(~name, subclass)))
  | SimpleSelector(_) => sel
  | CompoundSelector(compound) =>
    CompoundSelector(mask_compound(~name, compound))
  | ComplexSelector(complex) =>
    ComplexSelector(mask_complex(~name, complex))
  | RelativeSelector(relative) =>
    RelativeSelector({
      ...relative,
      complex_selector: mask_complex(~name, relative.complex_selector),
    })
  }
and mask_complex = (~name) =>
  fun
  | Selector(sel) => Selector(mask_selector(~name, sel))
  | Combinator({ left, right }) =>
    Combinator({
      left: mask_selector(~name, left),
      right:
        List.map(
          ((combinator, sel)) => (combinator, mask_selector(~name, sel)),
          right,
        ),
    })
and mask_compound = (~name, compound: compound_selector) => {
  let is_own =
    fun
    | Class(c) => c == name
    | _ => false;
  let others =
    compound.subclass_selectors
    |> List.filter(subclass => !is_own(subclass))
    |> List.map(mask_subclass(~name));
  let (type_selector, subclass_selectors) =
    switch (
      List.exists(is_own, compound.subclass_selectors),
      compound.type_selector,
    ) {
    | (true, None) => (Some(Ampersand), others)
    | (true, Some(_)) => (compound.type_selector, [Class("&"), ...others])
    | (false, _) => (compound.type_selector, others)
    };
  {
    type_selector,
    subclass_selectors,
    pseudo_selectors:
      List.map(mask_pseudo(~name), compound.pseudo_selectors),
  };
}
and mask_subclass = (~name) =>
  fun
  | Pseudo_class(pseudo) => Pseudo_class(mask_pseudo(~name, pseudo))
  | subclass => subclass
and mask_list = (~name, selectors) =>
  List.map(((sel, loc)) => (mask_selector(~name, sel), loc), selectors)
and mask_pseudo = (~name) =>
  fun
  | PseudoelementFunction({ name: pseudo_name, payload: (selectors, loc) }) =>
    PseudoelementFunction({
      name: pseudo_name,
      payload: (mask_list(~name, selectors), loc),
    })
  | Pseudoclass(Function({ name: pseudo_name, payload: (selectors, loc) })) =>
    Pseudoclass(
      Function({
        name: pseudo_name,
        payload: (mask_list(~name, selectors), loc),
      }),
    )
  | Pseudoclass(
      NthFunction({
        name: pseudo_name,
        payload: (NthSelector({ nth, selectors }), loc),
      }),
    ) =>
    Pseudoclass(
      NthFunction({
        name: pseudo_name,
        payload: (
          NthSelector({
            nth,
            selectors: List.map(mask_complex(~name), selectors),
          }),
          loc,
        ),
      }),
    )
  | pseudo => pseudo;

/* The element one selector styles, and whether it is descendant-shaped:
   ["own"] plus its pseudo-elements when the rightmost compound carries the
   atom's class, or the whole selector (atom class written `&`) when a
   combinator reaches another element. */
let subject = (~class_name, sel: selector) => {
  let chain = Selector_nesting.flatten_selector_chain(sel);
  switch (List.rev(chain)) {
  | [(_, last), ..._] when has_class(~name=class_name, last) => (
      "own" ++ String.concat("", pseudo_elements(last)),
      false,
    )
  | [(_, last), ..._] => (
      Render.selector(mask_selector(~name=class_name, sel)),
      List.length(chain) > 1 && !has_any_class(last),
    )
  | [] => ("own", false)
  };
};

let rec style_rule_of = (rule: rule) =>
  switch (rule) {
  | Style_rule(style_rule) => Some(style_rule)
  | At_rule({
      block: Rule_list(([inner], _)) | Stylesheet(([inner], _)),
      _,
    }) =>
    style_rule_of(inner)
  | At_rule(_)
  | Declaration(_) => None
  };

let family_string = (family: Slot_key.family_id) =>
  switch (family) {
  | Slot_key.Registered(i) => string_of_int(i)
  | Slot_key.Unregistered(h) => "u" ++ string_of_int(h)
  | Slot_key.UnregisteredCustom(h) => "c" ++ string_of_int(h)
  | Slot_key.All => Css_extraction.all_family
  };

/* [rule] is one lowered atom rule: a style rule on the atom's class,
   possibly under at-rules. Read from the AST before the autoprefixer, so a
   vendor-prefixed copy of a declaration never reaches the key. */
let of_rule = (~class_name, rule: rule): option(Css_extraction.atom_key) =>
  switch (style_rule_of(rule), Slot_key.of_atom(rule)) {
  | (Some({ prelude: (selectors, _), block: (rules, _), _ }), Some(slot)) =>
    let properties =
      List.filter_map(
        fun
        | Declaration({ name: (name, _), _ }) =>
          Some(Slot_key.resolve_alias(Slot_key.normalize_property(name)))
        | _ => None,
        rules,
      );
    let subjects =
      List.map(((sel, _)) => subject(~class_name, sel), selectors);
    let (a, b, c) = list_specificity(selectors);
    let scope =
      Printf.sprintf(
        "%s%d,%d,%d %s",
        slot.Slot_key.context.important ? "!" : "",
        a,
        b,
        c,
        String.concat(", ", List.map(fst, subjects)),
      );
    let family =
      switch (slot.family) {
      | Slot_key.All => Css_extraction.all_family
      | family when List.for_all(Slot_key.excluded_from_all, properties) =>
        "-" ++ family_string(family)
      | family => family_string(family)
      };
    let mask =
      switch (slot.family, slot.mask, properties) {
      | (Slot_key.All, _, _) => 0
      | (_, Some(mask), _) => mask
      | (_, None, [property, ..._]) =>
        Slot_key.Family.full_mask_of(property)
      | (_, None, []) => 0
      };
    Some(
      Css_extraction.atom_key(
        ~class_name,
        ~scope,
        ~family,
        ~mask,
        ~descendant=subjects != [] && List.for_all(snd, subjects),
      ),
    );
  | _ => None
  };
