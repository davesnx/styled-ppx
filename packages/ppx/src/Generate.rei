let dynamicComponent:
  (
    ~loc: Ppxlib.location,
    ~htmlTag: string,
    ~label: Ppxlib.arg_label,
    ~moduleName: string,
    ~defaultValue: option(Ppxlib.expression),
    ~param: Ppxlib.pattern,
    ~body: Ppxlib.expression
  ) =>
  Ppxlib.module_expr;

let staticComponent:
  (~loc: Ppxlib.location, ~htmlTag: string, Ppxlib.expression) =>
  Ppxlib.module_expr;
