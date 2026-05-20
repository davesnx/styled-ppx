/** Runtime lowering for CSS custom property declarations (`--*`). */;

let is_name: string => bool;

let render_declaration:
  (~loc: Ppxlib.Location.t, ~property: string, ~raw_value_source: string) =>
  Ppxlib.Parsetree.expression;
