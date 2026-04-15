open Types
open Support

module Property_position =
  [%spec_module
  "'static' | 'relative' | 'absolute' | 'sticky' | 'fixed' | '-webkit-sticky'",
  (module Css_types.Position)]

let property_position : property_position Rule.rule = Property_position.rule

module Property_position_anchor =
  [%spec_module
  "'auto' | <dashed-ident>", (module Css_types.PositionAnchor)]

let property_position_anchor : property_position_anchor Rule.rule =
  Property_position_anchor.rule

module Property_position_area =
  [%spec_module
  "'none' | [ 'top' | 'bottom' | 'left' | 'right' | 'center' | 'self-start' | \
   'self-end' | 'start' | 'end' ]",
  (module Css_types.PositionArea)]

let property_position_area : property_position_area Rule.rule =
  Property_position_area.rule

module Property_position_try =
  [%spec_module
  "'none' | [ <dashed-ident> | <try-tactic> ]#", (module Css_types.PositionTry)]

let property_position_try : property_position_try Rule.rule =
  Property_position_try.rule

module Property_position_try_fallbacks =
  [%spec_module
  "'none' | [ <dashed-ident> | <try-tactic> ]#",
  (module Css_types.PositionTryFallbacks)]

let property_position_try_fallbacks : property_position_try_fallbacks Rule.rule
    =
  Property_position_try_fallbacks.rule

module Property_position_try_options =
  [%spec_module
  "'none' | [ 'flip-block' || 'flip-inline' || 'flip-start' ]",
  (module Css_types.PositionTryOptions)]

let property_position_try_options : property_position_try_options Rule.rule =
  Property_position_try_options.rule

module Property_position_try_order =
  [%spec_module
  "'normal' | 'most-width' | 'most-height' | 'most-block-size' | \
   'most-inline-size'",
  (module Css_types.Cascading)]

module Property_position_visibility =
  [%spec_module
  "'always' | 'anchors-valid' | 'anchors-visible' | 'no-overflow'",
  (module Css_types.PositionVisibility)]

let property_position_visibility : property_position_visibility Rule.rule =
  Property_position_visibility.rule

let entries : (kind * packed_rule) list =
  [
    Property "position-anchor", pack_module (module Property_position_anchor);
    Property "position-area", pack_module (module Property_position_area);
    Property "position-try", pack_module (module Property_position_try);
    ( Property "position-try-fallbacks",
      pack_module (module Property_position_try_fallbacks) );
    ( Property "position-try-order",
      pack_module (module Property_position_try_order) );
    ( Property "position-try-options",
      pack_module (module Property_position_try_options) );
    ( Property "position-visibility",
      pack_module (module Property_position_visibility) );
    Property "position", pack_module (module Property_position);
  ]
