open Types
open Support

(* CSS Spatial Navigation L1: https://drafts.csswg.org/css-spatial-nav-1/#propdef-spatial-navigation-contain *)
module Property_spatial_navigation_contain =
  [%spec_module
  "'auto' | 'contain'", (module Css_types.SpatialNavigationContain)]

let property_spatial_navigation_contain :
  property_spatial_navigation_contain Rule.rule =
  Property_spatial_navigation_contain.rule

(* CSS Spatial Navigation L1: https://drafts.csswg.org/css-spatial-nav-1/#propdef-spatial-navigation-action *)
module Property_spatial_navigation_action =
  [%spec_module
  "'auto' | 'focus' | 'scroll'", (module Css_types.SpatialNavigationAction)]

let property_spatial_navigation_action :
  property_spatial_navigation_action Rule.rule =
  Property_spatial_navigation_action.rule

(* CSS Spatial Navigation L1: https://drafts.csswg.org/css-spatial-nav-1/#propdef-spatial-navigation-function *)
module Property_spatial_navigation_function =
  [%spec_module
  "'normal' | 'grid'", (module Css_types.SpatialNavigationFunction)]

let property_spatial_navigation_function :
  property_spatial_navigation_function Rule.rule =
  Property_spatial_navigation_function.rule

let entries : (kind * packed_rule) list =
  [
    ( Property "spatial-navigation-contain",
      pack_module (module Property_spatial_navigation_contain) );
    ( Property "spatial-navigation-action",
      pack_module (module Property_spatial_navigation_action) );
    ( Property "spatial-navigation-function",
      pack_module (module Property_spatial_navigation_function) );
  ]
