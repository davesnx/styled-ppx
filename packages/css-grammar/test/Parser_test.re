module Parser = Css_grammar;
module Rule = Parser.Rule;
module Driver = Styled_ppx_css_parser.Driver;
module Ast = Styled_ppx_css_parser.Ast;

let parse_declaration_value_component_values = (~name, value) =>
  switch (
    Driver.parse_declaration(
      ~source_position_start=
        Styled_ppx_css_parser.Parser_location.file_start(),
      name ++ ": " ++ value,
    )
  ) {
  | Ok({ Ast.value: (values, _), _ }) => values
  | Error((_, msg)) => Alcotest.fail("parser should succeed: " ++ msg)
  };

let parse_at_rule_prelude_values = css =>
  switch (
    Driver.parse_stylesheet(
      ~source_position_start=
        Styled_ppx_css_parser.Parser_location.file_start(),
      css,
    )
  ) {
  | Ok(([Ast.At_rule({ prelude: (values, _), _ })], _)) => values
  | Ok(_) => Alcotest.fail("expected a single at-rule")
  | Error((_, msg)) => Alcotest.fail("parser should succeed: " ++ msg)
  };

let infer_interpolation_types = (name, value) =>
  Parser.infer_interpolation_types(
    ~name,
    parse_declaration_value_component_values(~name, value),
  );

let validate_property = (name, value) =>
  switch (Parser.find_property_packed(name)) {
  | None => Alcotest.fail(name ++ " property should be registered")
  | Some(prop) =>
    switch (
      prop.validate(parse_declaration_value_component_values(~name, value))
    ) {
    | Ok () => Ok()
    | Error(info) => Error(Rule.format_error_info(info))
    }
  };

let test_flex_grow_with_interpolation = () =>
  switch (validate_property("flex-grow", "$(myVar)")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_flex_grow_without_interpolation = () =>
  switch (validate_property("flex-grow", "1.5")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_overflow_with_interpolation = () =>
  switch (validate_property("overflow", "$(x)")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_flex_basis_with_interpolation = () =>
  switch (validate_property("flex-basis", "$(basis)")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_unregistered_property = () =>
  switch (Parser.find_property_packed("unknown-property")) {
  | Some(_) => Alcotest.fail("unknown property should not be registered")
  | None => ()
  };

/* css-grammar-missing-properties (2026-09-25): valid and invalid values for
   the 7 properties added in that pass, one browser-implemented (Chrome/Edge
   or Safari, per MDN browser-compat-data) each. */

let test_border_shape_valid = () =>
  switch (validate_property("border-shape", "inset(10%) border-box")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_border_shape_invalid = () =>
  switch (validate_property("border-shape", "12px")) {
  | Ok () => Alcotest.fail("parsing '12px' should fail")
  | Error(_) => ()
  };

let test_flow_tolerance_valid = () =>
  switch (validate_property("flow-tolerance", "infinite")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_flow_tolerance_invalid = () =>
  switch (validate_property("flow-tolerance", "5")) {
  | Ok () => Alcotest.fail("parsing '5' should fail")
  | Error(_) => ()
  };

let test_frame_sizing_valid = () =>
  switch (validate_property("frame-sizing", "content-inline-size")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_frame_sizing_invalid = () =>
  switch (validate_property("frame-sizing", "cover")) {
  | Ok () => Alcotest.fail("parsing 'cover' should fail")
  | Error(_) => ()
  };

let test_scroll_axis_lock_valid = () =>
  switch (validate_property("scroll-axis-lock", "auto")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_scroll_axis_lock_invalid = () =>
  switch (validate_property("scroll-axis-lock", "smooth")) {
  | Ok () => Alcotest.fail("parsing 'smooth' should fail")
  | Error(_) => ()
  };

let test_view_transition_group_valid = () =>
  switch (validate_property("view-transition-group", "my-group")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_view_transition_group_invalid = () =>
  switch (validate_property("view-transition-group", "5px")) {
  | Ok () => Alcotest.fail("parsing '5px' should fail")
  | Error(_) => ()
  };

let test_view_transition_scope_valid = () =>
  switch (validate_property("view-transition-scope", "all")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_view_transition_scope_invalid = () =>
  /* 'contain' is valid for view-transition-group, not view-transition-scope. */
  switch (validate_property("view-transition-scope", "contain")) {
  | Ok () => Alcotest.fail("parsing 'contain' should fail")
  | Error(_) => ()
  };

let test_window_drag_valid = () =>
  switch (validate_property("window-drag", "move")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_window_drag_invalid = () =>
  switch (validate_property("window-drag", "grab")) {
  | Ok () => Alcotest.fail("parsing 'grab' should fail")
  | Error(_) => ()
  };

/* css-grammar-gaps (2026-09-25): valid and invalid values for the CSS Gaps
   Module Level 1 family (row-rule, column-rule additions, and rule) - one
   case per grammar shape this pass introduced. */

let test_column_rule_color_list_valid = () =>
  switch (validate_property("column-rule-color", "red, repeat(auto, blue)")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_column_rule_color_list_invalid = () =>
  switch (validate_property("column-rule-color", "repeat(2, 10px)")) {
  | Ok () => Alcotest.fail("parsing 'repeat(2, 10px)' should fail")
  | Error(_) => ()
  };

let test_row_rule_valid = () =>
  switch (validate_property("row-rule", "1px solid red, 2px dashed blue")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_row_rule_invalid = () =>
  switch (validate_property("row-rule", "not-a-rule")) {
  | Ok () => Alcotest.fail("parsing 'not-a-rule' should fail")
  | Error(_) => ()
  };

let test_rule_valid = () =>
  switch (validate_property("rule", "1px solid red")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_rule_invalid = () =>
  switch (validate_property("rule", "not-a-rule")) {
  | Ok () => Alcotest.fail("parsing 'not-a-rule' should fail")
  | Error(_) => ()
  };

let test_column_rule_break_valid = () =>
  switch (validate_property("column-rule-break", "intersection")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_column_rule_break_invalid = () =>
  switch (validate_property("column-rule-break", "always")) {
  | Ok () => Alcotest.fail("parsing 'always' should fail")
  | Error(_) => ()
  };

let test_column_rule_inset_cap_start_valid = () =>
  switch (validate_property("column-rule-inset-cap-start", "overlap-join")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_column_rule_inset_cap_start_invalid = () =>
  switch (validate_property("column-rule-inset-cap-start", "solid")) {
  | Ok () => Alcotest.fail("parsing 'solid' should fail")
  | Error(_) => ()
  };

let test_column_rule_inset_start_valid = () =>
  switch (validate_property("column-rule-inset-start", "8px")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_column_rule_inset_start_invalid = () =>
  switch (validate_property("column-rule-inset-start", "solid")) {
  | Ok () => Alcotest.fail("parsing 'solid' should fail")
  | Error(_) => ()
  };

let test_column_rule_inset_cap_valid = () =>
  switch (validate_property("column-rule-inset-cap", "0px 5px")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_column_rule_inset_valid = () =>
  switch (validate_property("column-rule-inset", "0px / -5px")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_rule_inset_start_valid = () =>
  switch (validate_property("rule-inset-start", "8px")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_column_rule_visibility_items_valid = () =>
  switch (validate_property("column-rule-visibility-items", "between")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_column_rule_visibility_items_invalid = () =>
  switch (validate_property("column-rule-visibility-items", "sometimes")) {
  | Ok () => Alcotest.fail("parsing 'sometimes' should fail")
  | Error(_) => ()
  };

let test_rule_overlap_valid = () =>
  switch (validate_property("rule-overlap", "column-over-row")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_rule_overlap_invalid = () =>
  switch (validate_property("rule-overlap", "row-over-row")) {
  | Ok () => Alcotest.fail("parsing 'row-over-row' should fail")
  | Error(_) => ()
  };

/* css-grammar-draft-properties (2026-09-25): valid and invalid values for
   this slice's 9 standards-track, unimplemented properties (CSS Text L4,
   CSS Text Decoration L4, CSS Lists and Counters L3). */

let test_line_padding_valid = () =>
  switch (validate_property("line-padding", "10px")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_line_padding_invalid = () =>
  switch (validate_property("line-padding", "solid")) {
  | Ok () => Alcotest.fail("parsing 'solid' should fail")
  | Error(_) => ()
  };

let test_text_group_align_valid = () =>
  switch (validate_property("text-group-align", "center")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_text_group_align_invalid = () =>
  switch (validate_property("text-group-align", "middle")) {
  | Ok () => Alcotest.fail("parsing 'middle' should fail")
  | Error(_) => ()
  };

let test_white_space_trim_valid = () =>
  switch (
    validate_property("white-space-trim", "discard-before discard-after")
  ) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_white_space_trim_invalid = () =>
  switch (validate_property("white-space-trim", "always")) {
  | Ok () => Alcotest.fail("parsing 'always' should fail")
  | Error(_) => ()
  };

let test_wrap_before_valid = () =>
  switch (validate_property("wrap-before", "avoid-flex")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_wrap_before_invalid = () =>
  switch (validate_property("wrap-before", "never")) {
  | Ok () => Alcotest.fail("parsing 'never' should fail")
  | Error(_) => ()
  };

let test_wrap_after_valid = () =>
  switch (validate_property("wrap-after", "line")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_wrap_inside_valid = () =>
  switch (validate_property("wrap-inside", "avoid")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_wrap_inside_invalid = () =>
  switch (validate_property("wrap-inside", "never")) {
  | Ok () => Alcotest.fail("parsing 'never' should fail")
  | Error(_) => ()
  };

let test_text_emphasis_skip_valid = () =>
  switch (validate_property("text-emphasis-skip", "spaces narrow")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_text_emphasis_skip_invalid = () =>
  switch (validate_property("text-emphasis-skip", "everything")) {
  | Ok () => Alcotest.fail("parsing 'everything' should fail")
  | Error(_) => ()
  };

let test_marker_side_valid = () =>
  switch (validate_property("marker-side", "match-parent")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_marker_side_invalid = () =>
  switch (validate_property("marker-side", "match-both")) {
  | Ok () => Alcotest.fail("parsing 'match-both' should fail")
  | Error(_) => ()
  };

/* css-grammar-draft-properties (task 2): valid and invalid values for the
   layout/sizing slice of the 140 standards-track/preview properties. */

let test_max_size_valid = () =>
  switch (validate_property("max-size", "100px 50px")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_max_size_invalid = () =>
  switch (validate_property("max-size", "solid")) {
  | Ok () => Alcotest.fail("parsing 'solid' should fail")
  | Error(_) => ()
  };

let test_min_intrinsic_sizing_valid = () =>
  switch (validate_property("min-intrinsic-sizing", "zero-if-scroll")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_min_intrinsic_sizing_invalid = () =>
  switch (validate_property("min-intrinsic-sizing", "always")) {
  | Ok () => Alcotest.fail("parsing 'always' should fail")
  | Error(_) => ()
  };

let test_wrap_flow_valid = () =>
  switch (validate_property("wrap-flow", "minimum")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_wrap_flow_invalid = () =>
  switch (validate_property("wrap-flow", "never")) {
  | Ok () => Alcotest.fail("parsing 'never' should fail")
  | Error(_) => ()
  };

let test_wrap_through_valid = () =>
  switch (validate_property("wrap-through", "wrap")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_margin_break_valid = () =>
  switch (validate_property("margin-break", "discard")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_margin_break_invalid = () =>
  switch (validate_property("margin-break", "avoid")) {
  | Ok () => Alcotest.fail("parsing 'avoid' should fail")
  | Error(_) => ()
  };

let test_block_step_valid = () =>
  switch (validate_property("block-step", "10px content-box center up")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_block_step_size_invalid = () =>
  switch (validate_property("block-step-size", "solid")) {
  | Ok () => Alcotest.fail("parsing 'solid' should fail")
  | Error(_) => ()
  };

let test_line_grid_valid = () =>
  switch (validate_property("line-grid", "create")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_line_grid_invalid = () =>
  switch (validate_property("line-grid", "always")) {
  | Ok () => Alcotest.fail("parsing 'always' should fail")
  | Error(_) => ()
  };

let test_line_snap_valid = () =>
  switch (validate_property("line-snap", "baseline")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_box_snap_valid = () =>
  switch (validate_property("box-snap", "last-baseline")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_box_snap_invalid = () =>
  switch (validate_property("box-snap", "always")) {
  | Ok () => Alcotest.fail("parsing 'always' should fail")
  | Error(_) => ()
  };

let test_shape_inside_valid = () =>
  switch (validate_property("shape-inside", "circle() border-box")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_shape_inside_invalid = () =>
  switch (validate_property("shape-inside", "solid")) {
  | Ok () => Alcotest.fail("parsing 'solid' should fail")
  | Error(_) => ()
  };

let test_border_boundary_valid = () =>
  switch (validate_property("border-boundary", "parent")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_border_boundary_invalid = () =>
  switch (validate_property("border-boundary", "child")) {
  | Ok () => Alcotest.fail("parsing 'child' should fail")
  | Error(_) => ()
  };

let test_initial_letter_wrap_valid = () =>
  switch (validate_property("initial-letter-wrap", "grid")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_initial_letter_wrap_invalid = () =>
  switch (validate_property("initial-letter-wrap", "solid")) {
  | Ok () => Alcotest.fail("parsing 'solid' should fail")
  | Error(_) => ()
  };

let test_inline_sizing_valid = () =>
  switch (validate_property("inline-sizing", "stretch")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_inline_sizing_invalid = () =>
  switch (validate_property("inline-sizing", "always")) {
  | Ok () => Alcotest.fail("parsing 'always' should fail")
  | Error(_) => ()
  };

let test_line_fit_edge_valid = () =>
  switch (validate_property("line-fit-edge", "cap")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

/* css-grammar-draft-properties (2026-09-25): valid and invalid values for
   the Backgrounds L4 / Overflow L4 slice of the 140 standards-track
   draft properties - one pair per grammar shape this slice introduced. */

let test_background_position_block_valid = () =>
  switch (
    validate_property("background-position-block", "start 10px, center")
  ) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_background_position_block_invalid = () =>
  switch (validate_property("background-position-block", "left")) {
  | Ok () => Alcotest.fail("parsing 'left' should fail")
  | Error(_) => ()
  };

let test_background_repeat_block_valid = () =>
  switch (validate_property("background-repeat-block", "space, round")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_background_repeat_block_invalid = () =>
  switch (validate_property("background-repeat-block", "repeat-x")) {
  | Ok () => Alcotest.fail("parsing 'repeat-x' should fail")
  | Error(_) => ()
  };

let test_overflow_clip_margin_top_valid = () =>
  switch (validate_property("overflow-clip-margin-top", "padding-box 5px")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_overflow_clip_margin_top_invalid = () =>
  switch (validate_property("overflow-clip-margin-top", "solid")) {
  | Ok () => Alcotest.fail("parsing 'solid' should fail")
  | Error(_) => ()
  };

let test_overflow_clip_margin_shorthand_valid = () =>
  switch (validate_property("overflow-clip-margin", "5px")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_overflow_clip_margin_block_valid = () =>
  switch (validate_property("overflow-clip-margin-block", "border-box")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_block_ellipsis_valid = () =>
  switch (validate_property("block-ellipsis", "\"...\"")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_block_ellipsis_invalid = () =>
  switch (validate_property("block-ellipsis", "none")) {
  | Ok () => Alcotest.fail("parsing 'none' should fail")
  | Error(_) => ()
  };

let test_continue_valid = () =>
  switch (validate_property("continue", "discard")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_continue_invalid = () =>
  switch (validate_property("continue", "always")) {
  | Ok () => Alcotest.fail("parsing 'always' should fail")
  | Error(_) => ()
  };

/* css-grammar-draft-properties (paged-media/content-flow/nav slice): valid
   and invalid values for the 19 properties this pass added. */

let test_bookmark_label_valid = () =>
  switch (validate_property("bookmark-label", "\"Chapter\"")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_bookmark_level_valid = () =>
  switch (validate_property("bookmark-level", "2")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_bookmark_level_invalid = () =>
  switch (validate_property("bookmark-level", "solid")) {
  | Ok () => Alcotest.fail("parsing 'solid' should fail")
  | Error(_) => ()
  };

let test_bookmark_state_valid = () =>
  switch (validate_property("bookmark-state", "closed")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_bookmark_state_invalid = () =>
  switch (validate_property("bookmark-state", "hidden")) {
  | Ok () => Alcotest.fail("parsing 'hidden' should fail")
  | Error(_) => ()
  };

let test_string_set_valid = () =>
  switch (validate_property("string-set", "header \"Chapter One\"")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_string_set_invalid = () =>
  switch (validate_property("string-set", "42")) {
  | Ok () => Alcotest.fail("parsing '42' should fail")
  | Error(_) => ()
  };

let test_running_valid = () =>
  switch (validate_property("running", "myHeader")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_footnote_display_valid = () =>
  switch (validate_property("footnote-display", "compact")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_footnote_display_invalid = () =>
  switch (validate_property("footnote-display", "flex")) {
  | Ok () => Alcotest.fail("parsing 'flex' should fail")
  | Error(_) => ()
  };

let test_footnote_policy_valid = () =>
  switch (validate_property("footnote-policy", "line")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_flow_into_valid = () =>
  switch (validate_property("flow-into", "myFlow content")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_flow_into_invalid = () =>
  switch (validate_property("flow-into", "myFlow other")) {
  | Ok () => Alcotest.fail("parsing 'myFlow other' should fail")
  | Error(_) => ()
  };

let test_flow_from_valid = () =>
  switch (validate_property("flow-from", "myFlow")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_region_fragment_valid = () =>
  switch (validate_property("region-fragment", "break")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_region_fragment_invalid = () =>
  switch (validate_property("region-fragment", "always")) {
  | Ok () => Alcotest.fail("parsing 'always' should fail")
  | Error(_) => ()
  };

let test_float_reference_valid = () =>
  switch (validate_property("float-reference", "column")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_float_reference_invalid = () =>
  switch (validate_property("float-reference", "block")) {
  | Ok () => Alcotest.fail("parsing 'block' should fail")
  | Error(_) => ()
  };

let test_float_defer_valid = () =>
  switch (validate_property("float-defer", "last")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_float_offset_valid = () =>
  switch (validate_property("float-offset", "10px")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_spatial_navigation_contain_valid = () =>
  switch (validate_property("spatial-navigation-contain", "contain")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_spatial_navigation_contain_invalid = () =>
  switch (validate_property("spatial-navigation-contain", "none")) {
  | Ok () => Alcotest.fail("parsing 'none' should fail")
  | Error(_) => ()
  };

let test_spatial_navigation_action_valid = () =>
  switch (validate_property("spatial-navigation-action", "scroll")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_spatial_navigation_function_valid = () =>
  switch (validate_property("spatial-navigation-function", "grid")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_input_security_valid = () =>
  switch (validate_property("input-security", "none")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_input_security_invalid = () =>
  switch (validate_property("input-security", "hidden")) {
  | Ok () => Alcotest.fail("parsing 'hidden' should fail")
  | Error(_) => ()
  };

let test_slider_orientation_valid = () =>
  switch (validate_property("slider-orientation", "top-to-bottom")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_slider_orientation_invalid = () =>
  switch (validate_property("slider-orientation", "vertical")) {
  | Ok () => Alcotest.fail("parsing 'vertical' should fail")
  | Error(_) => ()
  };

let test_image_animation_valid = () =>
  switch (validate_property("image-animation", "stopped")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_image_animation_invalid = () =>
  switch (validate_property("image-animation", "playing")) {
  | Ok () => Alcotest.fail("parsing 'playing' should fail")
  | Error(_) => ()
  };

/* css-grammar-draft-properties (CSS Fill and Stroke Module L3): valid and
   invalid values for the 16 fill- and stroke- properties this slice added. */

let test_fill_break_valid = () =>
  switch (validate_property("fill-break", "slice")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_fill_break_invalid = () =>
  switch (validate_property("fill-break", "always")) {
  | Ok () => Alcotest.fail("parsing 'always' should fail")
  | Error(_) => ()
  };

let test_fill_color_valid = () =>
  switch (validate_property("fill-color", "red")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_fill_image_valid = () =>
  switch (validate_property("fill-image", "none, none")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_fill_origin_valid = () =>
  switch (validate_property("fill-origin", "match-parent")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_fill_origin_invalid = () =>
  switch (validate_property("fill-origin", "view-box")) {
  | Ok () => Alcotest.fail("parsing 'view-box' should fail")
  | Error(_) => ()
  };

let test_fill_position_valid = () =>
  switch (validate_property("fill-position", "center, top left")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_fill_repeat_valid = () =>
  switch (validate_property("fill-repeat", "repeat-x, space")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_fill_size_valid = () =>
  switch (validate_property("fill-size", "cover, 10px 20px")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_stroke_align_valid = () =>
  switch (validate_property("stroke-align", "inset")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_stroke_align_invalid = () =>
  switch (validate_property("stroke-align", "middle")) {
  | Ok () => Alcotest.fail("parsing 'middle' should fail")
  | Error(_) => ()
  };

let test_stroke_break_valid = () =>
  switch (validate_property("stroke-break", "bounding-box")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_stroke_dash_corner_valid = () =>
  switch (validate_property("stroke-dash-corner", "5px")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_stroke_dash_corner_invalid = () =>
  switch (validate_property("stroke-dash-corner", "solid")) {
  | Ok () => Alcotest.fail("parsing 'solid' should fail")
  | Error(_) => ()
  };

let test_stroke_dash_justify_valid = () =>
  switch (validate_property("stroke-dash-justify", "stretch dashes")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_stroke_dash_justify_invalid = () =>
  switch (validate_property("stroke-dash-justify", "solid")) {
  | Ok () => Alcotest.fail("parsing 'solid' should fail")
  | Error(_) => ()
  };

let test_stroke_image_valid = () =>
  switch (validate_property("stroke-image", "none")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_stroke_origin_valid = () =>
  switch (validate_property("stroke-origin", "stroke-box")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_stroke_position_valid = () =>
  switch (validate_property("stroke-position", "50% 50%")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_stroke_repeat_valid = () =>
  switch (validate_property("stroke-repeat", "round")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_stroke_size_valid = () =>
  switch (validate_property("stroke-size", "contain")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

/* css-grammar-draft-properties (task 2): valid and invalid values for the
   CSS Borders and Box Decorations L4 additions - one case per grammar
   shape this slice introduced. */

let test_border_top_radius_valid = () =>
  switch (validate_property("border-top-radius", "10px 5px / 2px")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_border_top_radius_invalid = () =>
  switch (validate_property("border-top-radius", "solid")) {
  | Ok () => Alcotest.fail("parsing 'solid' should fail")
  | Error(_) => ()
  };

let test_border_limit_valid = () =>
  switch (validate_property("border-limit", "corners 10px")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_border_limit_invalid = () =>
  switch (validate_property("border-limit", "diagonal")) {
  | Ok () => Alcotest.fail("parsing 'diagonal' should fail")
  | Error(_) => ()
  };

let test_border_top_clip_valid = () =>
  switch (validate_property("border-top-clip", "10px 1fr 10px")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_border_top_clip_invalid = () =>
  switch (validate_property("border-top-clip", "solid")) {
  | Ok () => Alcotest.fail("parsing 'solid' should fail")
  | Error(_) => ()
  };

let test_border_clip_valid = () =>
  switch (validate_property("border-clip", "0 1fr")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_box_shadow_color_valid = () =>
  switch (validate_property("box-shadow-color", "red, blue")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_box_shadow_offset_valid = () =>
  switch (validate_property("box-shadow-offset", "none, 4px 4px")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_box_shadow_blur_valid = () =>
  switch (validate_property("box-shadow-blur", "12px, 0")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_box_shadow_spread_valid = () =>
  switch (validate_property("box-shadow-spread", "40px")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_box_shadow_position_valid = () =>
  switch (validate_property("box-shadow-position", "inset, outset")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_box_shadow_position_invalid = () =>
  switch (validate_property("box-shadow-position", "underset")) {
  | Ok () => Alcotest.fail("parsing 'underset' should fail")
  | Error(_) => ()
  };

let test_display_keywords = () => {
  let keywords = ["block", "inline", "flex", "grid", "none", "contents"];
  List.iter(
    keyword => {
      switch (validate_property("display", keyword)) {
      | Error(msg) =>
        Alcotest.fail("parsing '" ++ keyword ++ "' should succeed: " ++ msg)
      | Ok () =>
        let interps = infer_interpolation_types("display", keyword);
        Alcotest.check(
          Alcotest.int,
          "keyword " ++ keyword ++ " should have no interpolations",
          0,
          List.length(interps),
        );
      }
    },
    keywords,
  );
};

let test_flex_direction = () => {
  let keywords = ["row", "row-reverse", "column", "column-reverse"];
  List.iter(
    keyword =>
      switch (validate_property("flex-direction", keyword)) {
      | Error(msg) =>
        Alcotest.fail("parsing '" ++ keyword ++ "' should succeed: " ++ msg)
      | Ok () => ()
      },
    keywords,
  );
};

let test_align_items = () => {
  let keywords = [
    "center",
    "start",
    "end",
    "flex-start",
    "flex-end",
    "stretch",
  ];
  List.iter(
    keyword =>
      switch (validate_property("align-items", keyword)) {
      | Error(msg) =>
        Alcotest.fail("parsing '" ++ keyword ++ "' should succeed: " ++ msg)
      | Ok () => ()
      },
    keywords,
  );
};

let test_justify_content = () => {
  let keywords = [
    "flex-start",
    "flex-end",
    "center",
    "space-between",
    "space-around",
  ];
  List.iter(
    keyword =>
      switch (validate_property("justify-content", keyword)) {
      | Error(msg) =>
        Alcotest.fail("parsing '" ++ keyword ++ "' should succeed: " ++ msg)
      | Ok () => ()
      },
    keywords,
  );
};

let test_box_sizing = () => {
  switch (validate_property("box-sizing", "content-box")) {
  | Error(msg) => Alcotest.fail("parsing content-box should succeed: " ++ msg)
  | Ok () => ()
  };
  switch (validate_property("box-sizing", "border-box")) {
  | Error(msg) => Alcotest.fail("parsing border-box should succeed: " ++ msg)
  | Ok () => ()
  };
};

let test_white_space = () => {
  let keywords = [
    "normal",
    "pre",
    "nowrap",
    "pre-wrap",
    "pre-line",
    "break-spaces",
  ];
  List.iter(
    keyword =>
      switch (validate_property("white-space", keyword)) {
      | Error(msg) =>
        Alcotest.fail("parsing '" ++ keyword ++ "' should succeed: " ++ msg)
      | Ok () => ()
      },
    keywords,
  );
};

let test_width_with_interpolation = () =>
  switch (validate_property("width", "$(w)")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_color_with_interpolation = () =>
  switch (validate_property("color", "$(c)")) {
  | Error(msg) => Alcotest.fail("parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_width_with_component_values = () =>
  switch (validate_property("width", "calc(100vh + $(topMenuHeight))")) {
  | Error(msg) =>
    Alcotest.fail("component_value_list parsing should succeed: " ++ msg)
  | Ok () => ()
  };

let test_media_query_prelude_with_component_values = () =>
  switch (
    Parser.type_check(
      Parser.media_query_list,
      parse_at_rule_prelude_values("@media screen and (min-width: 33px) {}"),
    )
  ) {
  | Ok(_) => ()
  | Error(info) =>
    Alcotest.fail(
      "media query component_value_list parsing should succeed: "
      ++ Rule.format_error_info(info),
    )
  };

let test_container_query_prelude_with_component_values = () =>
  switch (
    Parser.type_check(
      Parser.container_condition_list,
      parse_at_rule_prelude_values("@container name (width >= 150px) {}"),
    )
  ) {
  | Ok(_) => ()
  | Error(info) =>
    Alcotest.fail(
      "container query component_value_list parsing should succeed: "
      ++ Rule.format_error_info(info),
    )
  };

let tests = [
  (
    "Parser",
    [
      Alcotest.test_case(
        "flex-grow with interpolation",
        `Quick,
        test_flex_grow_with_interpolation,
      ),
      Alcotest.test_case(
        "flex-grow without interpolation",
        `Quick,
        test_flex_grow_without_interpolation,
      ),
      Alcotest.test_case(
        "overflow with interpolation",
        `Quick,
        test_overflow_with_interpolation,
      ),
      Alcotest.test_case(
        "flex-basis with interpolation",
        `Quick,
        test_flex_basis_with_interpolation,
      ),
      Alcotest.test_case(
        "unregistered property",
        `Quick,
        test_unregistered_property,
      ),
      Alcotest.test_case(
        "border-shape valid",
        `Quick,
        test_border_shape_valid,
      ),
      Alcotest.test_case(
        "border-shape invalid",
        `Quick,
        test_border_shape_invalid,
      ),
      Alcotest.test_case(
        "flow-tolerance valid",
        `Quick,
        test_flow_tolerance_valid,
      ),
      Alcotest.test_case(
        "flow-tolerance invalid",
        `Quick,
        test_flow_tolerance_invalid,
      ),
      Alcotest.test_case(
        "frame-sizing valid",
        `Quick,
        test_frame_sizing_valid,
      ),
      Alcotest.test_case(
        "frame-sizing invalid",
        `Quick,
        test_frame_sizing_invalid,
      ),
      Alcotest.test_case(
        "scroll-axis-lock valid",
        `Quick,
        test_scroll_axis_lock_valid,
      ),
      Alcotest.test_case(
        "scroll-axis-lock invalid",
        `Quick,
        test_scroll_axis_lock_invalid,
      ),
      Alcotest.test_case(
        "view-transition-group valid",
        `Quick,
        test_view_transition_group_valid,
      ),
      Alcotest.test_case(
        "view-transition-group invalid",
        `Quick,
        test_view_transition_group_invalid,
      ),
      Alcotest.test_case(
        "view-transition-scope valid",
        `Quick,
        test_view_transition_scope_valid,
      ),
      Alcotest.test_case(
        "view-transition-scope invalid",
        `Quick,
        test_view_transition_scope_invalid,
      ),
      Alcotest.test_case("window-drag valid", `Quick, test_window_drag_valid),
      Alcotest.test_case(
        "window-drag invalid",
        `Quick,
        test_window_drag_invalid,
      ),
      Alcotest.test_case(
        "column-rule-color list valid",
        `Quick,
        test_column_rule_color_list_valid,
      ),
      Alcotest.test_case(
        "column-rule-color list invalid",
        `Quick,
        test_column_rule_color_list_invalid,
      ),
      Alcotest.test_case("row-rule valid", `Quick, test_row_rule_valid),
      Alcotest.test_case("row-rule invalid", `Quick, test_row_rule_invalid),
      Alcotest.test_case("rule valid", `Quick, test_rule_valid),
      Alcotest.test_case("rule invalid", `Quick, test_rule_invalid),
      Alcotest.test_case(
        "column-rule-break valid",
        `Quick,
        test_column_rule_break_valid,
      ),
      Alcotest.test_case(
        "column-rule-break invalid",
        `Quick,
        test_column_rule_break_invalid,
      ),
      Alcotest.test_case(
        "column-rule-inset-cap-start valid",
        `Quick,
        test_column_rule_inset_cap_start_valid,
      ),
      Alcotest.test_case(
        "column-rule-inset-cap-start invalid",
        `Quick,
        test_column_rule_inset_cap_start_invalid,
      ),
      Alcotest.test_case(
        "column-rule-inset-start valid",
        `Quick,
        test_column_rule_inset_start_valid,
      ),
      Alcotest.test_case(
        "column-rule-inset-start invalid",
        `Quick,
        test_column_rule_inset_start_invalid,
      ),
      Alcotest.test_case(
        "column-rule-inset-cap valid",
        `Quick,
        test_column_rule_inset_cap_valid,
      ),
      Alcotest.test_case(
        "column-rule-inset valid",
        `Quick,
        test_column_rule_inset_valid,
      ),
      Alcotest.test_case(
        "rule-inset-start valid",
        `Quick,
        test_rule_inset_start_valid,
      ),
      Alcotest.test_case(
        "column-rule-visibility-items valid",
        `Quick,
        test_column_rule_visibility_items_valid,
      ),
      Alcotest.test_case(
        "column-rule-visibility-items invalid",
        `Quick,
        test_column_rule_visibility_items_invalid,
      ),
      Alcotest.test_case(
        "rule-overlap valid",
        `Quick,
        test_rule_overlap_valid,
      ),
      Alcotest.test_case(
        "rule-overlap invalid",
        `Quick,
        test_rule_overlap_invalid,
      ),
      Alcotest.test_case(
        "line-padding valid",
        `Quick,
        test_line_padding_valid,
      ),
      Alcotest.test_case(
        "line-padding invalid",
        `Quick,
        test_line_padding_invalid,
      ),
      Alcotest.test_case(
        "text-group-align valid",
        `Quick,
        test_text_group_align_valid,
      ),
      Alcotest.test_case(
        "text-group-align invalid",
        `Quick,
        test_text_group_align_invalid,
      ),
      Alcotest.test_case(
        "white-space-trim valid",
        `Quick,
        test_white_space_trim_valid,
      ),
      Alcotest.test_case(
        "white-space-trim invalid",
        `Quick,
        test_white_space_trim_invalid,
      ),
      Alcotest.test_case("wrap-before valid", `Quick, test_wrap_before_valid),
      Alcotest.test_case(
        "wrap-before invalid",
        `Quick,
        test_wrap_before_invalid,
      ),
      Alcotest.test_case("wrap-after valid", `Quick, test_wrap_after_valid),
      Alcotest.test_case("wrap-inside valid", `Quick, test_wrap_inside_valid),
      Alcotest.test_case(
        "wrap-inside invalid",
        `Quick,
        test_wrap_inside_invalid,
      ),
      Alcotest.test_case(
        "text-emphasis-skip valid",
        `Quick,
        test_text_emphasis_skip_valid,
      ),
      Alcotest.test_case(
        "text-emphasis-skip invalid",
        `Quick,
        test_text_emphasis_skip_invalid,
      ),
      Alcotest.test_case("marker-side valid", `Quick, test_marker_side_valid),
      Alcotest.test_case(
        "marker-side invalid",
        `Quick,
        test_marker_side_invalid,
      ),
      Alcotest.test_case("max-size valid", `Quick, test_max_size_valid),
      Alcotest.test_case("max-size invalid", `Quick, test_max_size_invalid),
      Alcotest.test_case(
        "min-intrinsic-sizing valid",
        `Quick,
        test_min_intrinsic_sizing_valid,
      ),
      Alcotest.test_case(
        "min-intrinsic-sizing invalid",
        `Quick,
        test_min_intrinsic_sizing_invalid,
      ),
      Alcotest.test_case("wrap-flow valid", `Quick, test_wrap_flow_valid),
      Alcotest.test_case("wrap-flow invalid", `Quick, test_wrap_flow_invalid),
      Alcotest.test_case(
        "wrap-through valid",
        `Quick,
        test_wrap_through_valid,
      ),
      Alcotest.test_case(
        "margin-break valid",
        `Quick,
        test_margin_break_valid,
      ),
      Alcotest.test_case(
        "margin-break invalid",
        `Quick,
        test_margin_break_invalid,
      ),
      Alcotest.test_case("block-step valid", `Quick, test_block_step_valid),
      Alcotest.test_case(
        "block-step-size invalid",
        `Quick,
        test_block_step_size_invalid,
      ),
      Alcotest.test_case("line-grid valid", `Quick, test_line_grid_valid),
      Alcotest.test_case("line-grid invalid", `Quick, test_line_grid_invalid),
      Alcotest.test_case("line-snap valid", `Quick, test_line_snap_valid),
      Alcotest.test_case("box-snap valid", `Quick, test_box_snap_valid),
      Alcotest.test_case("box-snap invalid", `Quick, test_box_snap_invalid),
      Alcotest.test_case(
        "shape-inside valid",
        `Quick,
        test_shape_inside_valid,
      ),
      Alcotest.test_case(
        "shape-inside invalid",
        `Quick,
        test_shape_inside_invalid,
      ),
      Alcotest.test_case(
        "border-boundary valid",
        `Quick,
        test_border_boundary_valid,
      ),
      Alcotest.test_case(
        "border-boundary invalid",
        `Quick,
        test_border_boundary_invalid,
      ),
      Alcotest.test_case(
        "initial-letter-wrap valid",
        `Quick,
        test_initial_letter_wrap_valid,
      ),
      Alcotest.test_case(
        "initial-letter-wrap invalid",
        `Quick,
        test_initial_letter_wrap_invalid,
      ),
      Alcotest.test_case(
        "inline-sizing valid",
        `Quick,
        test_inline_sizing_valid,
      ),
      Alcotest.test_case(
        "inline-sizing invalid",
        `Quick,
        test_inline_sizing_invalid,
      ),
      Alcotest.test_case(
        "line-fit-edge valid",
        `Quick,
        test_line_fit_edge_valid,
      ),
      Alcotest.test_case(
        "background-position-block valid",
        `Quick,
        test_background_position_block_valid,
      ),
      Alcotest.test_case(
        "background-position-block invalid",
        `Quick,
        test_background_position_block_invalid,
      ),
      Alcotest.test_case(
        "background-repeat-block valid",
        `Quick,
        test_background_repeat_block_valid,
      ),
      Alcotest.test_case(
        "background-repeat-block invalid",
        `Quick,
        test_background_repeat_block_invalid,
      ),
      Alcotest.test_case(
        "overflow-clip-margin-top valid",
        `Quick,
        test_overflow_clip_margin_top_valid,
      ),
      Alcotest.test_case(
        "overflow-clip-margin-top invalid",
        `Quick,
        test_overflow_clip_margin_top_invalid,
      ),
      Alcotest.test_case(
        "overflow-clip-margin shorthand valid",
        `Quick,
        test_overflow_clip_margin_shorthand_valid,
      ),
      Alcotest.test_case(
        "overflow-clip-margin-block valid",
        `Quick,
        test_overflow_clip_margin_block_valid,
      ),
      Alcotest.test_case(
        "block-ellipsis valid",
        `Quick,
        test_block_ellipsis_valid,
      ),
      Alcotest.test_case(
        "block-ellipsis invalid",
        `Quick,
        test_block_ellipsis_invalid,
      ),
      Alcotest.test_case("continue valid", `Quick, test_continue_valid),
      Alcotest.test_case("continue invalid", `Quick, test_continue_invalid),
      Alcotest.test_case(
        "bookmark-label valid",
        `Quick,
        test_bookmark_label_valid,
      ),
      Alcotest.test_case(
        "bookmark-level valid",
        `Quick,
        test_bookmark_level_valid,
      ),
      Alcotest.test_case(
        "bookmark-level invalid",
        `Quick,
        test_bookmark_level_invalid,
      ),
      Alcotest.test_case(
        "bookmark-state valid",
        `Quick,
        test_bookmark_state_valid,
      ),
      Alcotest.test_case(
        "bookmark-state invalid",
        `Quick,
        test_bookmark_state_invalid,
      ),
      Alcotest.test_case("string-set valid", `Quick, test_string_set_valid),
      Alcotest.test_case(
        "string-set invalid",
        `Quick,
        test_string_set_invalid,
      ),
      Alcotest.test_case("running valid", `Quick, test_running_valid),
      Alcotest.test_case(
        "footnote-display valid",
        `Quick,
        test_footnote_display_valid,
      ),
      Alcotest.test_case(
        "footnote-display invalid",
        `Quick,
        test_footnote_display_invalid,
      ),
      Alcotest.test_case(
        "footnote-policy valid",
        `Quick,
        test_footnote_policy_valid,
      ),
      Alcotest.test_case("flow-into valid", `Quick, test_flow_into_valid),
      Alcotest.test_case("flow-into invalid", `Quick, test_flow_into_invalid),
      Alcotest.test_case("flow-from valid", `Quick, test_flow_from_valid),
      Alcotest.test_case(
        "region-fragment valid",
        `Quick,
        test_region_fragment_valid,
      ),
      Alcotest.test_case(
        "region-fragment invalid",
        `Quick,
        test_region_fragment_invalid,
      ),
      Alcotest.test_case(
        "float-reference valid",
        `Quick,
        test_float_reference_valid,
      ),
      Alcotest.test_case(
        "float-reference invalid",
        `Quick,
        test_float_reference_invalid,
      ),
      Alcotest.test_case("float-defer valid", `Quick, test_float_defer_valid),
      Alcotest.test_case(
        "float-offset valid",
        `Quick,
        test_float_offset_valid,
      ),
      Alcotest.test_case(
        "spatial-navigation-contain valid",
        `Quick,
        test_spatial_navigation_contain_valid,
      ),
      Alcotest.test_case(
        "spatial-navigation-contain invalid",
        `Quick,
        test_spatial_navigation_contain_invalid,
      ),
      Alcotest.test_case(
        "spatial-navigation-action valid",
        `Quick,
        test_spatial_navigation_action_valid,
      ),
      Alcotest.test_case(
        "spatial-navigation-function valid",
        `Quick,
        test_spatial_navigation_function_valid,
      ),
      Alcotest.test_case(
        "input-security valid",
        `Quick,
        test_input_security_valid,
      ),
      Alcotest.test_case(
        "input-security invalid",
        `Quick,
        test_input_security_invalid,
      ),
      Alcotest.test_case(
        "slider-orientation valid",
        `Quick,
        test_slider_orientation_valid,
      ),
      Alcotest.test_case(
        "slider-orientation invalid",
        `Quick,
        test_slider_orientation_invalid,
      ),
      Alcotest.test_case(
        "image-animation valid",
        `Quick,
        test_image_animation_valid,
      ),
      Alcotest.test_case(
        "image-animation invalid",
        `Quick,
        test_image_animation_invalid,
      ),
      Alcotest.test_case("fill-break valid", `Quick, test_fill_break_valid),
      Alcotest.test_case(
        "fill-break invalid",
        `Quick,
        test_fill_break_invalid,
      ),
      Alcotest.test_case("fill-color valid", `Quick, test_fill_color_valid),
      Alcotest.test_case("fill-image valid", `Quick, test_fill_image_valid),
      Alcotest.test_case("fill-origin valid", `Quick, test_fill_origin_valid),
      Alcotest.test_case(
        "fill-origin invalid",
        `Quick,
        test_fill_origin_invalid,
      ),
      Alcotest.test_case(
        "fill-position valid",
        `Quick,
        test_fill_position_valid,
      ),
      Alcotest.test_case("fill-repeat valid", `Quick, test_fill_repeat_valid),
      Alcotest.test_case("fill-size valid", `Quick, test_fill_size_valid),
      Alcotest.test_case(
        "stroke-align valid",
        `Quick,
        test_stroke_align_valid,
      ),
      Alcotest.test_case(
        "stroke-align invalid",
        `Quick,
        test_stroke_align_invalid,
      ),
      Alcotest.test_case(
        "stroke-break valid",
        `Quick,
        test_stroke_break_valid,
      ),
      Alcotest.test_case(
        "stroke-dash-corner valid",
        `Quick,
        test_stroke_dash_corner_valid,
      ),
      Alcotest.test_case(
        "stroke-dash-corner invalid",
        `Quick,
        test_stroke_dash_corner_invalid,
      ),
      Alcotest.test_case(
        "stroke-dash-justify valid",
        `Quick,
        test_stroke_dash_justify_valid,
      ),
      Alcotest.test_case(
        "stroke-dash-justify invalid",
        `Quick,
        test_stroke_dash_justify_invalid,
      ),
      Alcotest.test_case(
        "stroke-image valid",
        `Quick,
        test_stroke_image_valid,
      ),
      Alcotest.test_case(
        "stroke-origin valid",
        `Quick,
        test_stroke_origin_valid,
      ),
      Alcotest.test_case(
        "stroke-position valid",
        `Quick,
        test_stroke_position_valid,
      ),
      Alcotest.test_case(
        "stroke-repeat valid",
        `Quick,
        test_stroke_repeat_valid,
      ),
      Alcotest.test_case("stroke-size valid", `Quick, test_stroke_size_valid),
      Alcotest.test_case(
        "border-top-radius valid",
        `Quick,
        test_border_top_radius_valid,
      ),
      Alcotest.test_case(
        "border-top-radius invalid",
        `Quick,
        test_border_top_radius_invalid,
      ),
      Alcotest.test_case(
        "border-limit valid",
        `Quick,
        test_border_limit_valid,
      ),
      Alcotest.test_case(
        "border-limit invalid",
        `Quick,
        test_border_limit_invalid,
      ),
      Alcotest.test_case(
        "border-top-clip valid",
        `Quick,
        test_border_top_clip_valid,
      ),
      Alcotest.test_case(
        "border-top-clip invalid",
        `Quick,
        test_border_top_clip_invalid,
      ),
      Alcotest.test_case("border-clip valid", `Quick, test_border_clip_valid),
      Alcotest.test_case(
        "box-shadow-color valid",
        `Quick,
        test_box_shadow_color_valid,
      ),
      Alcotest.test_case(
        "box-shadow-offset valid",
        `Quick,
        test_box_shadow_offset_valid,
      ),
      Alcotest.test_case(
        "box-shadow-blur valid",
        `Quick,
        test_box_shadow_blur_valid,
      ),
      Alcotest.test_case(
        "box-shadow-spread valid",
        `Quick,
        test_box_shadow_spread_valid,
      ),
      Alcotest.test_case(
        "box-shadow-position valid",
        `Quick,
        test_box_shadow_position_valid,
      ),
      Alcotest.test_case(
        "box-shadow-position invalid",
        `Quick,
        test_box_shadow_position_invalid,
      ),
      Alcotest.test_case("display keywords", `Quick, test_display_keywords),
      Alcotest.test_case("flex-direction", `Quick, test_flex_direction),
      Alcotest.test_case("align-items", `Quick, test_align_items),
      Alcotest.test_case("justify-content", `Quick, test_justify_content),
      Alcotest.test_case("box-sizing", `Quick, test_box_sizing),
      Alcotest.test_case("white-space", `Quick, test_white_space),
      Alcotest.test_case(
        "width with interpolation",
        `Quick,
        test_width_with_interpolation,
      ),
      Alcotest.test_case(
        "color with interpolation",
        `Quick,
        test_color_with_interpolation,
      ),
      Alcotest.test_case(
        "width with component_value_list",
        `Quick,
        test_width_with_component_values,
      ),
      Alcotest.test_case(
        "media query prelude with component_value_list",
        `Quick,
        test_media_query_prelude_with_component_values,
      ),
      Alcotest.test_case(
        "container query prelude with component_value_list",
        `Quick,
        test_container_query_prelude_with_component_values,
      ),
    ],
  ),
];
