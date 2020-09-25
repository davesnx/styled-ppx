open Css_types;
let render_declaration_list:
  ((list(Declaration_list.kind), Warnings.loc)) => Parsetree.expression;
let render_emotion_style: Parsetree.expression => Parsetree.expression;
let render_emotion_css:
  ((list(Declaration_list.kind), Warnings.loc)) => Parsetree.expression;
let render_emotion_keyframe: Stylesheet.t => Parsetree.expression;
let render_global: Stylesheet.t => Parsetree.expression;
