open Types
open Support

module Property_vector_effect =
  [%spec_module
  "'none' | 'non-scaling-stroke'", (module Css_types.VectorEffect)]

let property_vector_effect : property_vector_effect Rule.rule =
  Property_vector_effect.rule

(* SVG geometry properties *)

let entries : (kind * packed_rule) list =
  [ Property "vector-effect", pack_module (module Property_vector_effect) ]
