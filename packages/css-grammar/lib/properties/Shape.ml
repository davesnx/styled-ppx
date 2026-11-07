open Types
open Support

module Property_shape_image_threshold =
  [%spec_module
  "<alpha-value>", (module Css_types.ShapeImageThreshold)]

let property_shape_image_threshold : property_shape_image_threshold Rule.rule =
  Property_shape_image_threshold.rule

module Property_shape_margin =
  [%spec_module
  "<extended-length> | <extended-percentage>", (module Css_types.Length)]

let property_shape_margin : property_shape_margin Rule.rule =
  Property_shape_margin.rule

module Property_shape_outside =
  [%spec_module
  "'none' | <shape-box> || <basic-shape> | <image>",
  (module Css_types.ShapeOutside)]

let property_shape_outside : property_shape_outside Rule.rule =
  Property_shape_outside.rule

module Property_shape_rendering =
  [%spec_module
  "'auto' | 'optimizeSpeed' | 'crispEdges' | 'geometricPrecision'",
  (module Css_types.ShapeRendering)]

let property_shape_rendering : property_shape_rendering Rule.rule =
  Property_shape_rendering.rule

let entries : (kind * packed_rule) list =
  [
    ( Property "shape-image-threshold",
      pack_module (module Property_shape_image_threshold) );
    Property "shape-margin", pack_module (module Property_shape_margin);
    Property "shape-outside", pack_module (module Property_shape_outside);
    Property "shape-rendering", pack_module (module Property_shape_rendering);
  ]
