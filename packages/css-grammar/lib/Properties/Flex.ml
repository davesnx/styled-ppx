open Types
open Support

module Property_flex =
  [%spec_module
  "'none' | [<'flex-grow'> [ <'flex-shrink'> ]? || <'flex-basis'>] | \
   <interpolation>",
  (module Css_types.Flex)]

let property_flex : property_flex Rule.rule = Property_flex.rule

module Property_flex_basis =
  [%spec_module
  "'content' | <'width'> | <interpolation>", (module Css_types.FlexBasis)]

let property_flex_basis : property_flex_basis Rule.rule =
  Property_flex_basis.rule

module Property_flex_direction =
  [%spec_module
  "'row' | 'row-reverse' | 'column' | 'column-reverse'",
  (module Css_types.FlexDirection)]

let property_flex_direction : property_flex_direction Rule.rule =
  Property_flex_direction.rule

module Property_flex_flow =
  [%spec_module
  "<'flex-direction'> || <'flex-wrap'>", (module Css_types.FlexFlow)]

let property_flex_flow : property_flex_flow Rule.rule = Property_flex_flow.rule

module Property_flex_grow =
  [%spec_module
  "<number> | <interpolation>", (module Css_types.FlexGrow)]

let property_flex_grow : property_flex_grow Rule.rule = Property_flex_grow.rule

module Property_flex_shrink =
  [%spec_module
  "<number> | <interpolation>", (module Css_types.FlexShrink)]

let property_flex_shrink : property_flex_shrink Rule.rule =
  Property_flex_shrink.rule

module Property_flex_wrap =
  [%spec_module
  "'nowrap' | 'wrap' | 'wrap-reverse'", (module Css_types.FlexWrap)]

let property_flex_wrap : property_flex_wrap Rule.rule = Property_flex_wrap.rule

let entries : (kind * packed_rule) list =
  [
    Property "flex-direction", pack_module (module Property_flex_direction);
    Property "flex-wrap", pack_module (module Property_flex_wrap);
    Property "flex-grow", pack_module (module Property_flex_grow);
    Property "flex-shrink", pack_module (module Property_flex_shrink);
    Property "flex-basis", pack_module (module Property_flex_basis);
    Property "flex", pack_module (module Property_flex);
    Property "flex-flow", pack_module (module Property_flex_flow);
  ]
