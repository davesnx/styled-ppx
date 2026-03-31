open Types
open Support

module Permissive_cascading = struct
  type t = Styled_ppx_css_parser.Ast.component_value_list

  let rule : t Rule.rule = fun input -> Ok input, []
  let type_check input = Ok input
  let to_string = Styled_ppx_css_parser.Render.component_value_list
  let runtime_module_path = Some "Css_types.Cascading"

  let infer_interpolation_types =
    detect_whole_value_interpolation ~runtime_module_path

  let infer_interpolation_types_with_context _ = infer_interpolation_types
end

module Property_object_fit =
  [%spec_module
  "'fill' | 'contain' | 'cover' | 'none' | 'scale-down'",
  (module Css_types.ObjectFit)]

let property_object_fit : property_object_fit Rule.rule =
  Property_object_fit.rule

module Property_object_position =
  [%spec_module
  "<position>", (module Css_types.ObjectPosition)]

let property_object_position : property_object_position Rule.rule =
  Property_object_position.rule

let entries : (kind * packed_rule) list =
  [
    Property "object-fit", pack_module (module Property_object_fit);
    Property "object-position", pack_module (module Property_object_position);
    Property "object-view-box", pack_module (module Permissive_cascading);
  ]
