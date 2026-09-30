open Types
open Support

module Property_field_sizing =
  [%spec_module
  "'content' | 'fixed'", (module Css_types.FieldSizing)]

let property_field_sizing : property_field_sizing Rule.rule =
  Property_field_sizing.rule

(* CSS Form Control Styling L1: https://drafts.csswg.org/css-forms-1/#propdef-input-security
   Reuses Css_types.ForcedColorAdjust (a safe superset: auto | none |
   preserveParentColor), same precedent -ms-high-contrast-adjust
   (packages/css-grammar/lib/Properties/ForcedColorAdjust.ml) already uses
   for the identical 'auto' | 'none' grammar. *)
module Property_input_security =
  [%spec_module
  "'auto' | 'none'", (module Css_types.ForcedColorAdjust)]

let property_input_security : property_input_security Rule.rule =
  Property_input_security.rule

(* CSS Form Control Styling L1: https://drafts.csswg.org/css-forms-1/#propdef-slider-orientation *)
module Property_slider_orientation =
  [%spec_module
  "'auto' | 'left-to-right' | 'right-to-left' | 'top-to-bottom' | \
   'bottom-to-top'",
  (module Css_types.SliderOrientation)]

let property_slider_orientation : property_slider_orientation Rule.rule =
  Property_slider_orientation.rule

let entries : (kind * packed_rule) list =
  [
    Property "field-sizing", pack_module (module Property_field_sizing);
    Property "input-security", pack_module (module Property_input_security);
    ( Property "slider-orientation",
      pack_module (module Property_slider_orientation) );
  ]
