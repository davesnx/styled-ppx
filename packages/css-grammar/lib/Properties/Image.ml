open Types
open Support

module Property_image_orientation =
  [%spec_module
  "'from-image' | <extended-angle> | [ <extended-angle> ]? 'flip'",
  (module Css_types.ImageOrientation)]

let property_image_orientation : property_image_orientation Rule.rule =
  Property_image_orientation.rule

module Property_image_rendering =
  [%spec_module
  "'auto' |'smooth' | 'high-quality' | 'crisp-edges' | 'pixelated'",
  (module Css_types.ImageRendering)]

let property_image_rendering : property_image_rendering Rule.rule =
  Property_image_rendering.rule

module Property_image_resolution =
  [%spec_module
  "[ 'from-image' || <resolution> ] && [ 'snap' ]?",
  (module Css_types.ImageResolution)]

let property_image_resolution : property_image_resolution Rule.rule =
  Property_image_resolution.rule

let entries : (kind * packed_rule) list =
  [
    Property "image-orientation", pack_module (module Property_image_orientation);
    Property "image-resolution", pack_module (module Property_image_resolution);
    Property "image-rendering", pack_module (module Property_image_rendering);
  ]
