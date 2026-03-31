open Types
open Support

module Property_timeline_scope =
  [%spec_module
  "[ 'none' | <custom-ident> | <dashed-ident> ]#",
  (module Css_types.TimelineScope)]

let property_timeline_scope : property_timeline_scope Rule.rule =
  Property_timeline_scope.rule

module Property_timeline_trigger_name =
  [%spec_module
  "'none' | [ <dashed-ident> ]#", (module Css_types.Cascading)]

module Property_trigger_scope =
  [%spec_module
  "'none' | 'all' | [ <dashed-ident> ]#", (module Css_types.Cascading)]

module Permissive_timeline_trigger = struct
  type t = unit

  let rule : t Rule.rule = fun _ -> Ok (), []
  let type_check (_ : Styled_ppx_css_parser.Ast.component_value_list) = Ok ()
  let to_string () = ""
  let runtime_module_path = Some "Css_types.Cascading"
  let infer_interpolation_types () = []
  let infer_interpolation_types_with_context (_ : string) (_ : t) = []
end

(* Scroll driven animations *)

let entries : (kind * packed_rule) list =
  [
    Property "timeline-scope", pack_module (module Property_timeline_scope);
    ( Property "timeline-trigger",
      pack_module (module Permissive_timeline_trigger) );
    ( Property "timeline-trigger-activation-range",
      pack_module (module Permissive_timeline_trigger) );
    ( Property "timeline-trigger-activation-range-end",
      pack_module (module Permissive_timeline_trigger) );
    ( Property "timeline-trigger-activation-range-start",
      pack_module (module Permissive_timeline_trigger) );
    ( Property "timeline-trigger-active-range",
      pack_module (module Permissive_timeline_trigger) );
    ( Property "timeline-trigger-active-range-end",
      pack_module (module Permissive_timeline_trigger) );
    ( Property "timeline-trigger-active-range-start",
      pack_module (module Permissive_timeline_trigger) );
    ( Property "timeline-trigger-name",
      pack_module (module Property_timeline_trigger_name) );
    ( Property "timeline-trigger-source",
      pack_module (module Permissive_timeline_trigger) );
    Property "trigger-scope", pack_module (module Property_trigger_scope);
  ]
