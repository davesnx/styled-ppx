open Types
open Support

module Property_text_autospace =
  [%spec_module
  "'none' | 'ideograph-alpha' | 'ideograph-numeric' | 'ideograph-parenthesis' \
   | 'ideograph-space'",
  (module Css_types.TextAutospace)]

let property_text_autospace : property_text_autospace Rule.rule =
  Property_text_autospace.rule

module Property__ms_text_autospace =
  [%spec_module
  "'none' | 'ideograph-alpha' | 'ideograph-numeric' | 'ideograph-parenthesis' \
   | 'ideograph-space'",
  (module Css_types.TextAutospace)]

let property__ms_text_autospace = Property__ms_text_autospace.rule

module Property_text_blink =
  [%spec_module
  "'none' | 'blink' | 'blink-anywhere'", (module Css_types.TextBlink)]

let property_text_blink : property_text_blink Rule.rule =
  Property_text_blink.rule

module Property_text_align =
  [%spec_module
  "'start' | 'end' | 'left' | 'right' | 'center' | 'justify' | 'match-parent' \
   | 'justify-all'",
  (module Css_types.TextAlign)]

let property_text_align : property_text_align Rule.rule =
  Property_text_align.rule

module Property_text_align_all =
  [%spec_module
  "'start' | 'end' | 'left' | 'right' | 'center' | 'justify' | 'match-parent'",
  (module Css_types.TextAlignAll)]

let property_text_align_all : property_text_align_all Rule.rule =
  Property_text_align_all.rule

module Property_text_align_last =
  [%spec_module
  "'auto' | 'start' | 'end' | 'left' | 'right' | 'center' | 'justify' | \
   'match-parent'",
  (module Css_types.TextAlignLast)]

let property_text_align_last : property_text_align_last Rule.rule =
  Property_text_align_last.rule

module Property_text_anchor =
  [%spec_module
  "'start' | 'middle' | 'end'", (module Css_types.TextAnchor)]

let property_text_anchor : property_text_anchor Rule.rule =
  Property_text_anchor.rule

module Property_text_combine_upright =
  [%spec_module
  "'none' | 'all' | 'digits' [ <integer> ]?",
  (module Css_types.TextCombineUpright)]

let property_text_combine_upright : property_text_combine_upright Rule.rule =
  Property_text_combine_upright.rule

module Property_text_decoration =
  [%spec_module
  "<'text-decoration-color'> || <'text-decoration-style'> || \
   <'text-decoration-thickness'> || <'text-decoration-line'>",
  (module Css_types.TextDecoration)]

let property_text_decoration : property_text_decoration Rule.rule =
  Property_text_decoration.rule

module Property_text_justify_trim =
  [%spec_module
  "'none' | 'all' | 'auto'", (module Css_types.TextJustifyTrim)]

let property_text_justify_trim : property_text_justify_trim Rule.rule =
  Property_text_justify_trim.rule

module Property_text_kashida =
  [%spec_module
  "'none' | 'horizontal' | 'vertical' | 'both'", (module Css_types.TextKashida)]

let property_text_kashida : property_text_kashida Rule.rule =
  Property_text_kashida.rule

module Property_text_kashida_space =
  [%spec_module
  "'normal' | 'pre' | 'post'", (module Css_types.TextKashidaSpace)]

let property_text_kashida_space : property_text_kashida_space Rule.rule =
  Property_text_kashida_space.rule

module Property_text_decoration_color =
  [%spec_module
  "<color>", (module Css_types.Color)]

let property_text_decoration_color : property_text_decoration_color Rule.rule =
  Property_text_decoration_color.rule

(* Spec doesn't contain spelling-error module grammar-error: https://developer.mozilla.org/en-US/docs/Web/CSS/text-decoration-line but this list used to have them | 'spelling-error' | 'grammar-error'. Leaving this comment here for reference *)
(* module this definition has changed from the origianl, it might be a bug on the spec or our Generator,
   but simplifying to "|" simplifies it module solves the bug *)

module Property_text_decoration_line =
  [%spec_module
  "'none' | <interpolation> | [ 'underline' || 'overline' || 'line-through' || \
   'blink' ]",
  (module Css_types.TextDecorationLine)]

let property_text_decoration_line : property_text_decoration_line Rule.rule =
  Property_text_decoration_line.rule

module Property_text_decoration_skip =
  [%spec_module
  "'none' | 'objects' || [ 'spaces' | 'leading-spaces' || 'trailing-spaces' ] \
   || 'edges' || 'box-decoration'",
  (module Css_types.TextDecorationSkip)]

let property_text_decoration_skip : property_text_decoration_skip Rule.rule =
  Property_text_decoration_skip.rule

module Property_text_decoration_skip_self =
  [%spec_module
  "'none' | 'objects' || [ 'spaces' | 'leading-spaces' || 'trailing-spaces' ] \
   || 'edges' || 'box-decoration'",
  (module Css_types.TextDecorationSkipSelf)]

let property_text_decoration_skip_self :
  property_text_decoration_skip_self Rule.rule =
  Property_text_decoration_skip_self.rule

module Property_text_decoration_skip_ink =
  [%spec_module
  "'auto' | 'all' | 'none'", (module Css_types.TextDecorationSkipInk)]

let property_text_decoration_skip_ink :
  property_text_decoration_skip_ink Rule.rule =
  Property_text_decoration_skip_ink.rule

module Property_text_decoration_skip_box =
  [%spec_module
  "'none' | 'all'", (module Css_types.TextDecorationSkipBox)]

let property_text_decoration_skip_box :
  property_text_decoration_skip_box Rule.rule =
  Property_text_decoration_skip_box.rule

module Property_text_decoration_skip_spaces =
  [%spec_module
  "'none' | 'objects' || [ 'spaces' | 'leading-spaces' || 'trailing-spaces' ] \
   || 'edges' || 'box-decoration'",
  (module Css_types.TextDecorationSkipSpaces)]

let property_text_decoration_skip_spaces :
  property_text_decoration_skip_spaces Rule.rule =
  Property_text_decoration_skip_spaces.rule

module Property_text_decoration_skip_inset =
  [%spec_module
  "'none' | 'auto'", (module Css_types.TextDecorationSkipInset)]

let property_text_decoration_skip_inset :
  property_text_decoration_skip_inset Rule.rule =
  Property_text_decoration_skip_inset.rule

module Property_text_decoration_style =
  [%spec_module
  "'solid' | 'double' | 'dotted' | 'dashed' | 'wavy'",
  (module Css_types.TextDecorationStyle)]

let property_text_decoration_style : property_text_decoration_style Rule.rule =
  Property_text_decoration_style.rule

module Property_text_decoration_thickness =
  [%spec_module
  "'auto' | 'from-font' | <extended-length> | <extended-percentage>",
  (module Css_types.TextDecorationThickness)]

let property_text_decoration_thickness :
  property_text_decoration_thickness Rule.rule =
  Property_text_decoration_thickness.rule

module Property_text_emphasis =
  [%spec_module
  "<'text-emphasis-style'> || <'text-emphasis-color'>",
  (module Css_types.TextEmphasis)]

let property_text_emphasis : property_text_emphasis Rule.rule =
  Property_text_emphasis.rule

module Property_text_emphasis_color =
  [%spec_module
  "<color>", (module Css_types.Color)]

let property_text_emphasis_color : property_text_emphasis_color Rule.rule =
  Property_text_emphasis_color.rule

module Property_text_emphasis_position =
  [%spec_module
  "[ 'over' | 'under' ] && [ 'right' | 'left' ]?",
  (module Css_types.TextEmphasisPosition)]

let property_text_emphasis_position : property_text_emphasis_position Rule.rule
    =
  Property_text_emphasis_position.rule

module Property_text_emphasis_style =
  [%spec_module
  "'none' | [ 'filled' | 'open' ] || [ 'dot' | 'circle' | 'double-circle' | \
   'triangle' | 'sesame' ] | <string>",
  (module Css_types.TextEmphasisStyle)]

let property_text_emphasis_style : property_text_emphasis_style Rule.rule =
  Property_text_emphasis_style.rule

module Property_text_indent =
  [%spec_module
  "[<extended-length> | <extended-percentage>] && [ 'hanging' ]? && [ \
   'each-line' ]?",
  (module Css_types.TextIndent)]

let property_text_indent : property_text_indent Rule.rule =
  Property_text_indent.rule

module Property_text_justify =
  [%spec_module
  "'auto' | 'inter-character' | 'inter-word' | 'none'",
  (module Css_types.TextJustify)]

let property_text_justify : property_text_justify Rule.rule =
  Property_text_justify.rule

module Property_text_orientation =
  [%spec_module
  "'mixed' | 'upright' | 'sideways'", (module Css_types.TextOrientation)]

let property_text_orientation : property_text_orientation Rule.rule =
  Property_text_orientation.rule

module Property_text_overflow =
  [%spec_module
  "[ 'clip' | 'ellipsis' | <string> ]{1,2}", (module Css_types.TextOverflow)]

let property_text_overflow : property_text_overflow Rule.rule =
  Property_text_overflow.rule

module Property_text_rendering =
  [%spec_module
  "'auto' | 'optimizeSpeed' | 'optimizeLegibility' | 'geometricPrecision'",
  (module Css_types.TextRendering)]

let property_text_rendering : property_text_rendering Rule.rule =
  Property_text_rendering.rule

module Property_text_shadow =
  [%spec_module
  "'none' | <interpolation> | [ <shadow-t> ]#", (module Css_types.TextShadows)]

let property_text_shadow : property_text_shadow Rule.rule =
  Property_text_shadow.rule

module Property_text_size_adjust =
  [%spec_module
  "'none' | 'auto' | <extended-percentage>", (module Css_types.TextSizeAdjust)]

let property_text_size_adjust : property_text_size_adjust Rule.rule =
  Property_text_size_adjust.rule

module Property_text_transform =
  [%spec_module
  "'none' | 'capitalize' | 'uppercase' | 'lowercase' | 'full-width' | \
   'full-size-kana'",
  (module Css_types.TextTransform)]

let property_text_transform : property_text_transform Rule.rule =
  Property_text_transform.rule

module Property_text_underline_offset =
  [%spec_module
  "'auto' | <extended-length> | <extended-percentage>",
  (module Css_types.TextUnderlineOffset)]

let property_text_underline_offset : property_text_underline_offset Rule.rule =
  Property_text_underline_offset.rule

module Property_text_underline_position =
  [%spec_module
  "'auto' | 'from-font' | 'under' || [ 'left' | 'right' ]",
  (module Css_types.TextUnderlinePosition)]

let property_text_underline_position :
  property_text_underline_position Rule.rule =
  Property_text_underline_position.rule

module Property_text_wrap =
  [%spec_module
  "'wrap' | 'nowrap' | 'balance' | 'stable' | 'pretty'",
  (module Css_types.TextWrap)]

let property_text_wrap : property_text_wrap Rule.rule = Property_text_wrap.rule

module Property_text_spacing_trim =
  [%spec_module
  "'normal' | 'space-all' | 'space-first' | 'trim-start'",
  (module Css_types.TextSpacingTrim)]

let property_text_spacing_trim : property_text_spacing_trim Rule.rule =
  Property_text_spacing_trim.rule

module Property_text_wrap_mode =
  [%spec_module
  "'wrap' | 'nowrap'", (module Css_types.TextWrapMode)]

let property_text_wrap_mode : property_text_wrap_mode Rule.rule =
  Property_text_wrap_mode.rule

module Property_text_wrap_style =
  [%spec_module
  "'auto' | 'balance' | 'stable' | 'pretty'", (module Css_types.TextWrapStyle)]

let property_text_wrap_style : property_text_wrap_style Rule.rule =
  Property_text_wrap_style.rule

module Property_text_box_trim =
  [%spec_module
  "'none' | 'trim-start' | 'trim-end' | 'trim-both'",
  (module Css_types.TextBoxTrim)]

let property_text_box_trim : property_text_box_trim Rule.rule =
  Property_text_box_trim.rule

module Property_text_box_edge =
  [%spec_module
  "'leading' | 'text' | 'cap' | 'ex' | 'alphabetic'",
  (module Css_types.TextBoxEdge)]

let property_text_box_edge : property_text_box_edge Rule.rule =
  Property_text_box_edge.rule

module Property_text_box =
  [%spec_module
  "'normal' | [ 'none' | 'trim-start' | 'trim-end' | 'trim-both' ] || [ 'auto' \
   | [ 'text' | 'ideographic' | 'ideographic-ink' ] | [ 'text' | 'ideographic' \
   | 'ideographic-ink' | 'cap' | 'ex' ] [ 'text' | 'ideographic' | \
   'ideographic-ink' | 'alphabetic' ] ]",
  (module Css_types.Cascading)]

let property_text_box = Property_text_box.rule

module Property_text_decoration_inset =
  [%spec_module
  "[ <extended-length> ]{1,2} | 'auto'", (module Css_types.Cascading)]

let property_text_decoration_inset = Property_text_decoration_inset.rule

(* Print module paged media properties *)

module Property_text_edge =
  [%spec_module
  "[ 'leading' | <'text-box-edge'> ]{1,2}", (module Css_types.TextEdge)]

let property_text_edge : property_text_edge Rule.rule = Property_text_edge.rule

let entries : (kind * packed_rule) list =
  [
    ( Property "-ms-text-autospace",
      pack_module (module Property__ms_text_autospace) );
    Property "text-rendering", pack_module (module Property_text_rendering);
    Property "text-orientation", pack_module (module Property_text_orientation);
    Property "text-transform", pack_module (module Property_text_transform);
    Property "text-align", pack_module (module Property_text_align);
    Property "text-align-last", pack_module (module Property_text_align_last);
    Property "text-justify", pack_module (module Property_text_justify);
    ( Property "text-decoration-line",
      pack_module (module Property_text_decoration_line) );
    ( Property "text-decoration-style",
      pack_module (module Property_text_decoration_style) );
    ( Property "text-decoration-skip-ink",
      pack_module (module Property_text_decoration_skip_ink) );
    ( Property "text-decoration-thickness",
      pack_module (module Property_text_decoration_thickness) );
    ( Property "text-underline-position",
      pack_module (module Property_text_underline_position) );
    Property "text-align-all", pack_module (module Property_text_align_all);
    Property "text-anchor", pack_module (module Property_text_anchor);
    Property "text-autospace", pack_module (module Property_text_autospace);
    Property "text-blink", pack_module (module Property_text_blink);
    Property "text-box", pack_module (module Property_text_box);
    Property "text-box-edge", pack_module (module Property_text_box_edge);
    Property "text-box-trim", pack_module (module Property_text_box_trim);
    ( Property "text-combine-upright",
      pack_module (module Property_text_combine_upright) );
    Property "text-decoration", pack_module (module Property_text_decoration);
    ( Property "text-decoration-color",
      pack_module (module Property_text_decoration_color) );
    ( Property "text-decoration-inset",
      pack_module (module Property_text_decoration_inset) );
    ( Property "text-decoration-skip",
      pack_module (module Property_text_decoration_skip) );
    ( Property "text-decoration-skip-box",
      pack_module (module Property_text_decoration_skip_box) );
    ( Property "text-decoration-skip-inset",
      pack_module (module Property_text_decoration_skip_inset) );
    ( Property "text-decoration-skip-self",
      pack_module (module Property_text_decoration_skip_self) );
    ( Property "text-decoration-skip-spaces",
      pack_module (module Property_text_decoration_skip_spaces) );
    Property "text-edge", pack_module (module Property_text_edge);
    Property "text-emphasis", pack_module (module Property_text_emphasis);
    ( Property "text-emphasis-color",
      pack_module (module Property_text_emphasis_color) );
    ( Property "text-emphasis-position",
      pack_module (module Property_text_emphasis_position) );
    ( Property "text-emphasis-style",
      pack_module (module Property_text_emphasis_style) );
    Property "text-indent", pack_module (module Property_text_indent);
    ( Property "text-justify-trim",
      pack_module (module Property_text_justify_trim) );
    Property "text-kashida", pack_module (module Property_text_kashida);
    ( Property "text-kashida-space",
      pack_module (module Property_text_kashida_space) );
    Property "text-overflow", pack_module (module Property_text_overflow);
    Property "text-shadow", pack_module (module Property_text_shadow);
    Property "text-size-adjust", pack_module (module Property_text_size_adjust);
    ( Property "text-spacing-trim",
      pack_module (module Property_text_spacing_trim) );
    ( Property "text-underline-offset",
      pack_module (module Property_text_underline_offset) );
    Property "text-wrap", pack_module (module Property_text_wrap);
    Property "text-wrap-mode", pack_module (module Property_text_wrap_mode);
    Property "text-wrap-style", pack_module (module Property_text_wrap_style);
  ]
