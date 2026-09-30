let dynamicExtractedComponent:
  (
    ~loc: Ppxlib.location,
    ~file: string,
    ~main_module: string,
    ~scope: list(string),
    ~opens: list(list(string)),
    ~htmlTag: string,
    ~label: Ppxlib.arg_label,
    ~moduleName: string,
    ~defaultValue: option(Ppxlib.expression),
    ~param: Ppxlib.pattern,
    ~body: Ppxlib.expression,
    ~onClassNames: (~identity: option(string), list(string)) => unit
  ) =>
  Ppxlib.module_expr;

let staticComponent:
  (~loc: Ppxlib.location, ~htmlTag: string, Ppxlib.expression) =>
  Ppxlib.module_expr;
