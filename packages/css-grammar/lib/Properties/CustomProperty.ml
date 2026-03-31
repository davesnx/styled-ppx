open Types
open Support

module Property_custom_property = struct
  type t = Styled_ppx_css_parser.Ast.component_value_list

  let rule : t Rule.rule = fun input -> Ok input, []
  let type_check input = Ok input
  let to_string = Styled_ppx_css_parser.Render.component_value_list
  let runtime_module_path = Some "Css_types.Cascading"

  let infer_interpolation_types input =
    detect_whole_value_interpolation ~runtime_module_path input

  let infer_interpolation_types_with_context type_context input =
    let interp_rule =
      Rule.Match.map Css_value_types.interpolation (fun data -> data)
    in
    match Rule.run interp_rule input with
    | Ok parts ->
      let type_path =
        if type_context = "" then Option.value ~default:"" runtime_module_path
        else type_context
      in
      [ String.concat "." parts, type_path ]
    | Error _ -> []
end

let property_custom_property :
  Styled_ppx_css_parser.Ast.component_value_list Rule.rule =
  Property_custom_property.rule

let entries : (kind * packed_rule) list =
  [ Property "--*", pack_module (module Property_custom_property) ]
