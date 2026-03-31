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

let entries : (kind * packed_rule) list =
  [
    Property "corner-block-end-shape", pack_module (module Permissive_cascading);
    ( Property "corner-block-start-shape",
      pack_module (module Permissive_cascading) );
    ( Property "corner-bottom-left-shape",
      pack_module (module Permissive_cascading) );
    ( Property "corner-bottom-right-shape",
      pack_module (module Permissive_cascading) );
    Property "corner-bottom-shape", pack_module (module Permissive_cascading);
    Property "corner-end-end-shape", pack_module (module Permissive_cascading);
    Property "corner-end-start-shape", pack_module (module Permissive_cascading);
    ( Property "corner-inline-end-shape",
      pack_module (module Permissive_cascading) );
    ( Property "corner-inline-start-shape",
      pack_module (module Permissive_cascading) );
    Property "corner-left-shape", pack_module (module Permissive_cascading);
    Property "corner-right-shape", pack_module (module Permissive_cascading);
    Property "corner-shape", pack_module (module Permissive_cascading);
    Property "corner-start-end-shape", pack_module (module Permissive_cascading);
    ( Property "corner-start-start-shape",
      pack_module (module Permissive_cascading) );
    Property "corner-top-left-shape", pack_module (module Permissive_cascading);
    Property "corner-top-right-shape", pack_module (module Permissive_cascading);
    Property "corner-top-shape", pack_module (module Permissive_cascading);
  ]
