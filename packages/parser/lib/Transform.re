let split_by_kind = Selector_nesting.split_by_kind;

/* Resolve a `[%css]`/`[%cx]` rule list against the binding's className:
   prefix every rule, flatten nesting, hoist `@media`, all in source order. */
let resolve_selectors = (~className, rules: list(Ast.rule)) => {
  let initial_prefix =
    Ast.CompoundSelector({
      type_selector: None,
      subclass_selectors: [Class(className)],
      pseudo_selectors: [],
    });
  Resolve.flatten_rules(~prefix=Some(initial_prefix), ~media=None, rules);
};

let run = (~className, (rule_list, _loc): Ast.rule_list) =>
  resolve_selectors(~className, rule_list);
