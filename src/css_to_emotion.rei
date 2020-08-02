open Css_types;
let render_emotion_css:
  (
    (list(Declaration_list.kind), Warnings.loc),
    option(list((string, string)))
  ) =>
  Parsetree.expression;
let render_global: Stylesheet.t => Parsetree.expression;
