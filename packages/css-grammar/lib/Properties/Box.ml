open Types
open Support

module Property_box_align =
  [%spec_module
  "'start' | 'center' | 'end' | 'baseline' | 'stretch'",
  (module Css_types.BoxAlign)]

let property_box_align : property_box_align Rule.rule = Property_box_align.rule

module Property_box_decoration_break =
  [%spec_module
  "'slice' | 'clone'", (module Css_types.BoxDecorationBreak)]

let property_box_decoration_break : property_box_decoration_break Rule.rule =
  Property_box_decoration_break.rule

module Property_box_direction =
  [%spec_module
  "'normal' | 'reverse' | 'inherit'", (module Css_types.BoxDirection)]

let property_box_direction : property_box_direction Rule.rule =
  Property_box_direction.rule

module Property_box_flex = [%spec_module "<number>", (module Css_types.BoxFlex)]

let property_box_flex : property_box_flex Rule.rule = Property_box_flex.rule

module Property_box_flex_group =
  [%spec_module
  "<integer>", (module Css_types.BoxFlexGroup)]

let property_box_flex_group : property_box_flex_group Rule.rule =
  Property_box_flex_group.rule

module Property_box_lines =
  [%spec_module
  "'single' | 'multiple'", (module Css_types.BoxLines)]

let property_box_lines : property_box_lines Rule.rule = Property_box_lines.rule

module Property_box_ordinal_group =
  [%spec_module
  "<integer>", (module Css_types.BoxOrdinalGroup)]

let property_box_ordinal_group : property_box_ordinal_group Rule.rule =
  Property_box_ordinal_group.rule

module Property_box_orient =
  [%spec_module
  "'horizontal' | 'vertical' | 'inline-axis' | 'block-axis' | 'inherit'",
  (module Css_types.BoxOrient)]

let property_box_orient : property_box_orient Rule.rule =
  Property_box_orient.rule

module Property_box_pack =
  [%spec_module
  "'start' | 'center' | 'end' | 'justify'", (module Css_types.BoxPack)]

let property_box_pack : property_box_pack Rule.rule = Property_box_pack.rule

module Property_box_shadow =
  [%spec_module
  "'none' | <interpolation> | [ <shadow> ]#", (module Css_types.BoxShadows)]

let property_box_shadow : property_box_shadow Rule.rule =
  Property_box_shadow.rule

(* CSS Borders and Box Decorations L4 § 6.1-6.5: https://drafts.csswg.org/css-borders-4/#propdef-box-shadow-color
   (and the 4 sibling propdefs). This draft redefines box-shadow itself as
   the shorthand resetting these 5 (<'box-shadow-color'>? && [ [ none |
   <length>{2} ] [ <'box-shadow-blur'> <'box-shadow-spread'>? ]? ] &&
   <'box-shadow-position'>? - a 3-way && with an offset sub-grammar that
   deliberately differs from box-shadow-offset's own, per the spec's own
   note). Registering that redefinition safely needs its own careful pass -
   left as-is for now (box-shadow keeps its existing simpler grammar and
   Property kind); these 5 are added standalone, not yet wired as its
   longhands. *)
module Property_box_shadow_color =
  [%spec_module
  "[ <color> ]#", (module Css_types.Color)]

let property_box_shadow_color : property_box_shadow_color Rule.rule =
  Property_box_shadow_color.rule

module Property_box_shadow_offset =
  [%spec_module
  "[ 'none' | [ <extended-length> ]{1,2} ]#", (module Css_types.Cascading)]

let property_box_shadow_offset : property_box_shadow_offset Rule.rule =
  Property_box_shadow_offset.rule

module Property_box_shadow_blur =
  [%spec_module
  "[ <extended-length> ]#", (module Css_types.Length)]

let property_box_shadow_blur : property_box_shadow_blur Rule.rule =
  Property_box_shadow_blur.rule

module Property_box_shadow_spread =
  [%spec_module
  "[ <extended-length> ]#", (module Css_types.Length)]

let property_box_shadow_spread : property_box_shadow_spread Rule.rule =
  Property_box_shadow_spread.rule

module Property_box_shadow_position =
  [%spec_module
  "[ 'outset' | 'inset' ]#", (module Css_types.BoxShadowPosition)]

let property_box_shadow_position : property_box_shadow_position Rule.rule =
  Property_box_shadow_position.rule

module Property_box_sizing =
  [%spec_module
  "'content-box' | 'border-box'", (module Css_types.BoxSizing)]

let property_box_sizing : property_box_sizing Rule.rule =
  Property_box_sizing.rule

(* CSS Box Sizing L4: https://drafts.csswg.org/css-sizing-4/#propdef-frame-sizing *)
module Property_frame_sizing =
  [%spec_module
  "'auto' | 'content-width' | 'content-height' | 'content-block-size' | \
   'content-inline-size'",
  (module Css_types.FrameSizing)]

let property_frame_sizing : property_frame_sizing Rule.rule =
  Property_frame_sizing.rule

let entries : (kind * packed_rule) list =
  [
    Property "box-sizing", pack_module (module Property_box_sizing);
    Property "frame-sizing", pack_module (module Property_frame_sizing);
    ( Property "box-decoration-break",
      pack_module (module Property_box_decoration_break) );
    Property "box-align", pack_module (module Property_box_align);
    Property "box-direction", pack_module (module Property_box_direction);
    Property "box-flex", pack_module (module Property_box_flex);
    Property "box-flex-group", pack_module (module Property_box_flex_group);
    Property "box-lines", pack_module (module Property_box_lines);
    ( Property "box-ordinal-group",
      pack_module (module Property_box_ordinal_group) );
    Property "box-orient", pack_module (module Property_box_orient);
    Property "box-pack", pack_module (module Property_box_pack);
    Property "box-shadow", pack_module (module Property_box_shadow);
    Property "box-shadow-color", pack_module (module Property_box_shadow_color);
    ( Property "box-shadow-offset",
      pack_module (module Property_box_shadow_offset) );
    Property "box-shadow-blur", pack_module (module Property_box_shadow_blur);
    ( Property "box-shadow-spread",
      pack_module (module Property_box_shadow_spread) );
    ( Property "box-shadow-position",
      pack_module (module Property_box_shadow_position) );
  ]
