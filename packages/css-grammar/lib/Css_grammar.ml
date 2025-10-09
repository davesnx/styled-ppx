module Parser = Parser
module Rule = Rule
module Standard = Standard
module Combinators = Combinators
module Modifier = Modifier

open Parser
open Styled_ppx_css_parser

let ( let+ ) = Result.bind

let apply_parser (parser, tokens_with_loc) =
  let open Lexer in
  let tokens =
    tokens_with_loc
    |> List.map (fun { txt; _ } ->
         match txt with Ok token -> token | Error (token, _) -> token)
  in

  let tokens_without_ws =
    tokens |> List.filter (( != ) Parser.WS)
  in

  let output, remaining_tokens = parser tokens_without_ws in
  let+ output =
    match output with
    | Ok data -> Ok data
    (* TODO: Don't ignore the rest of messages *)
    | Error (message :: _) -> Error message
    | Error [] -> Error "weird"
  in
  let+ () =
    match remaining_tokens with
    | [] | [ Parser.EOF ] -> Ok ()
    | tokens ->
      let tokens = tokens |> List.map Tokens.show_token |> String.concat ", " in
      Error ("tokens remaining: " ^ tokens)
  in
  Ok output

let parse (rule_parser : 'a Rule.rule) input =
  let tokens_with_loc = Lexer.from_string input in
  apply_parser (rule_parser, tokens_with_loc)

let check (prop : 'a Rule.rule) value = parse prop value |> Result.is_ok

(*
  Heterogeneous rule storage using first-class modules

  This solution uses existential types to store CSS property, media query, rules, values and functions that return different CSS parsed types in a single collection.
 *)

type kind =
  | Value of string
    (* CSS Value types: color, length, angle, etc. - the primitive vocabulary *)
  | Property of
      string (* CSS Properties: width, flex-basis, etc. - compose values *)
  | Media_query of string (* Media query rules *)
  | Function of string (* CSS Functions: rgb(), calc(), etc. *)

module type PARSER = sig
  type t
  val parser : t Rule.rule
  val toString : t -> string
end

module type RULE = sig
  type result

  val rule : result Rule.rule
  val name : kind
  val to_string : result -> string
end

(* CSS Properties *)
let prop (type a) (name : string) (module M : PARSER with type t = a) : (module RULE) =
  (module struct
    type result = a

    let rule = M.parser
    let name = Property name
    let to_string = M.toString
  end)

(* CSS Media Queries *)
let mq (type a) (name : string) (module M : PARSER with type t = a) : (module RULE) =
  (module struct
    type result = a

    let rule = M.parser
    let name = Media_query name
    let to_string = M.toString
  end)

(* https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Values_and_Units *)
let value (type a) (name : string) (module M : PARSER with type t = a) : (module RULE) =
  (module struct
    type result = a

    let rule = M.parser
    let name = Value name
    let to_string = M.toString
  end)

(* CSS Functions *)
let fn (type a) (name : string) (module M : PARSER with type t = a) : (module RULE) =
  (module struct
    type result = a

    let rule = M.parser
    let name = Function name
    let to_string = M.toString
  end)

let packed_rules : (module RULE) list =
  [
  value "-legacy-gradient" (module Legacy_gradient);
  value "-legacy-linear-gradient" (module Legacy_linear_gradient);
  value "-legacy-linear-gradient-arguments" (module Legacy_linear_gradient_arguments);
  value "-legacy-radial-gradient" (module Legacy_radial_gradient);
  value "-legacy-radial-gradient-arguments" (module Legacy_radial_gradient_arguments);
  value "-legacy-radial-gradient-shape" (module Legacy_radial_gradient_shape);
  value "-legacy-radial-gradient-size" (module Legacy_radial_gradient_size);
  value "-legacy-repeating-linear-gradient" (module Legacy_repeating_linear_gradient);
  value "-legacy-repeating-radial-gradient" (module Legacy_repeating_radial_gradient);
  value "-non-standard-color" (module Non_standard_color);
  value "-non-standard-font" (module Non_standard_font);
  value "-non-standard-image-rendering" (module Non_standard_image_rendering);
  value "-non-standard-overflow" (module Non_standard_overflow);
  value "-non-standard-width" (module Non_standard_width);
  value "-webkit-gradient-color-stop" (module Webkit_gradient_color_stop);
  value "-webkit-gradient-point" (module Webkit_gradient_point);
  value "-webkit-gradient-radius" (module Webkit_gradient_radius);
  value "-webkit-gradient-type" (module Webkit_gradient_type);
  value "-webkit-mask-box-repeat" (module Webkit_mask_box_repeat);
  value "-webkit-mask-clip-style" (module Webkit_mask_clip_style);
  value "absolute-size" (module Absolute_size);
  value "attr-name" (module Attr_name);
  value "attr-type" (module Attr_type);
  value "attr-unit" (module Attr_unit);
  value "syntax" (module Syntax);
  value "syntax-combinator" (module Syntax_combinator);
  value "syntax-component" (module Syntax_component);
  value "syntax-multiplier" (module Syntax_multiplier);
  value "syntax-single-component" (module Syntax_single_component);
  value "syntax-string" (module Syntax_string);
  value "syntax-type-name" (module Syntax_type_name);
  value "age" (module Age);
  value "alpha-value" (module Alpha_value);
  value "angular-color-hint" (module Angular_color_hint);
  value "angular-color-stop" (module Angular_color_stop);
  value "angular-color-stop-list" (module Angular_color_stop_list);
  value "hue-interpolation-method" (module Hue_interpolation_method);
  value "polar-color-space" (module Polar_color_space);
  value "rectangular-color-space" (module Rectangular_color_space);
  value "color-interpolation-method" (module Color_interpolation_method);
  value "animateable-feature" (module Animateable_feature);
  value "attachment" (module Attachment);
  value "attr-fallback" (module Attr_fallback);
  value "attr-matcher" (module Attr_matcher);
  value "attr-modifier" (module Attr_modifier);
  value "attr-name" (module Attr_name);
  value "attribute-selector" (module Attribute_selector);
  value "auto-repeat" (module Auto_repeat);
  value "auto-track-list" (module Auto_track_list);
  value "baseline-position" (module Baseline_position);
  value "basic-shape" (module Basic_shape);
  value "bg-image" (module Bg_image);
  value "bg-layer" (module Bg_layer);
  value "bg-position" (module Bg_position);
  value "bg-size" (module Bg_size);
  value "blend-mode" (module Blend_mode);
  value "border-radius" (module Border_radius);
  value "bottom" (module Bottom);
  value "box" (module Box);
  value "calc-product" (module Calc_product);
  value "calc-sum" (module Calc_sum);
  value "calc-value" (module Calc_value);
  value "cf-final-image" (module Cf_final_image);
  value "cf-mixing-image" (module Cf_mixing_image);
  value "class-selector" (module Class_selector);
  value "clip-source" (module Clip_source);
  value "color" (module Color);
  value "color-stop" (module Color_stop);
  value "color-stop-angle" (module Color_stop_angle);
  value "color-stop-length" (module Color_stop_length);
  value "color-stop-list" (module Color_stop_list);
  value "combinator" (module Combinator);
  value "common-lig-values" (module Common_lig_values);
  value "compat-auto" (module Compat_auto);
  value "complex-selector" (module Complex_selector);
  value "complex-selector-list" (module Complex_selector_list);
  value "composite-style" (module Composite_style);
  value "compositing-operator" (module Compositing_operator);
  value "compound-selector" (module Compound_selector);
  value "compound-selector-list" (module Compound_selector_list);
  value "content-distribution" (module Content_distribution);
  value "content-list" (module Content_list);
  value "content-position" (module Content_position);
  value "content-replacement" (module Content_replacement);
  value "contextual-alt-values" (module Contextual_alt_values);
  value "counter-style" (module Counter_style);
  value "counter-style-name" (module Counter_style_name);
  value "cubic-bezier-timing-function" (module Cubic_bezier_timing_function);
  value "declaration" (module Declaration);
  value "declaration-list" (module Declaration_list);
  value "deprecated-system-color" (module Deprecated_system_color);
  value "discretionary-lig-values" (module Discretionary_lig_values);
  value "display-box" (module Display_box);
  value "display-inside" (module Display_inside);
  value "display-internal" (module Display_internal);
  value "display-legacy" (module Display_legacy);
  value "display-listitem" (module Display_listitem);
  value "display-outside" (module Display_outside);
  value "east-asian-variant-values" (module East_asian_variant_values);
  value "east-asian-width-values" (module East_asian_width_values);
  value "ending-shape" (module Ending_shape);
  value "explicit-track-list" (module Explicit_track_list);
  value "family-name" (module Family_name);
  value "feature-tag-value" (module Feature_tag_value);
  value "feature-type" (module Feature_type);
  value "feature-value-block" (module Feature_value_block);
  value "feature-value-block-list" (module Feature_value_block_list);
  value "feature-value-declaration" (module Feature_value_declaration);
  value "feature-value-declaration-list" (module Feature_value_declaration_list);
  value "feature-value-name" (module Feature_value_name);
  value "fill-rule" (module Fill_rule);
  value "filter-function" (module Filter_function);
  value "filter-function-list" (module Filter_function_list);
  value "final-bg-layer" (module Final_bg_layer);
  value "fixed-breadth" (module Fixed_breadth);
  value "fixed-repeat" (module Fixed_repeat);
  value "fixed-size" (module Fixed_size);
  value "font-stretch-absolute" (module Font_stretch_absolute);
  value "font-variant-css21" (module Font_variant_css21);
  value "font-weight-absolute" (module Font_weight_absolute);
  fn "-webkit-gradient" (module Function__webkit_gradient);
  fn "attr" (module Function_attr);
  fn "blur" (module Function_blur);
  fn "brightness" (module Function_brightness);
  fn "calc" (module Function_calc);
  fn "circle" (module Function_circle);
  fn "clamp" (module Function_clamp);
  fn "conic-gradient" (module Function_conic_gradient);
  fn "contrast" (module Function_contrast);
  fn "counter" (module Function_counter);
  fn "counters" (module Function_counters);
  fn "cross-fade" (module Function_cross_fade);
  fn "drop-shadow" (module Function_drop_shadow);
  fn "element" (module Function_element);
  fn "ellipse" (module Function_ellipse);
  fn "env" (module Function_env);
  fn "fit-content" (module Function_fit_content);
  fn "grayscale" (module Function_grayscale);
  fn "hsl" (module Function_hsl);
  fn "hsla" (module Function_hsla);
  fn "hue-rotate" (module Function_hue_rotate);
  fn "image" (module Function_image);
  fn "image-set" (module Function_image_set);
  fn "inset" (module Function_inset);
  fn "invert" (module Function_invert);
  fn "leader" (module Function_leader);
  fn "linear-gradient" (module Function_linear_gradient);
  fn "matrix" (module Function_matrix);
  fn "matrix3d" (module Function_matrix3d);
  fn "max" (module Function_max);
  fn "min" (module Function_min);
  fn "minmax" (module Function_minmax);
  fn "opacity" (module Function_opacity);
  fn "paint" (module Function_paint);
  fn "path" (module Function_path);
  fn "perspective" (module Function_perspective);
  fn "polygon" (module Function_polygon);
  fn "radial-gradient" (module Function_radial_gradient);
  fn "repeating-linear-gradient" (module Function_repeating_linear_gradient);
  fn "repeating-radial-gradient" (module Function_repeating_radial_gradient);
  fn "rgb" (module Function_rgb);
  fn "rgba" (module Function_rgba);
  fn "rotate" (module Function_rotate);
  fn "rotate3d" (module Function_rotate3d);
  fn "rotateX" (module Function_rotateX);
  fn "rotateY" (module Function_rotateY);
  fn "rotateZ" (module Function_rotateZ);
  fn "saturate" (module Function_saturate);
  fn "scale" (module Function_scale);
  fn "scale3d" (module Function_scale3d);
  fn "scaleX" (module Function_scaleX);
  fn "scaleY" (module Function_scaleY);
  fn "scaleZ" (module Function_scaleZ);
  fn "sepia" (module Function_sepia);
  fn "skew" (module Function_skew);
  fn "skewX" (module Function_skewX);
  fn "skewY" (module Function_skewY);
  fn "symbols" (module Function_symbols);
  fn "target-counter" (module Function_target_counter);
  fn "target-counters" (module Function_target_counters);
  fn "target-text" (module Function_target_text);
  fn "translate" (module Function_translate);
  fn "translate3d" (module Function_translate3d);
  fn "translateX" (module Function_translateX);
  fn "translateY" (module Function_translateY);
  fn "translateZ" (module Function_translateZ);
  fn "var" (module Function_var);
  value "gender" (module Gender);
  value "general-enclosed" (module General_enclosed);
  value "generic-family" (module Generic_family);
  value "generic-name" (module Generic_name);
  value "generic-voice" (module Generic_voice);
  value "geometry-box" (module Geometry_box);
  value "gradient" (module Gradient);
  value "grid-line" (module Grid_line);
  value "historical-lig-values" (module Historical_lig_values);
  value "hue" (module Hue);
  value "id-selector" (module Id_selector);
  value "image" (module Image);
  value "image-set-option" (module Image_set_option);
  value "image-src" (module Image_src);
  value "image-tags" (module Image_tags);
  value "inflexible-breadth" (module Inflexible_breadth);
  value "keyframe-block" (module Keyframe_block);
  value "keyframe-block-list" (module Keyframe_block_list);
  value "keyframe-selector" (module Keyframe_selector);
  value "keyframes-name" (module Keyframes_name);
  value "leader-type" (module Leader_type);
  value "left" (module Left);
  value "line-name-list" (module Line_name_list);
  value "line-names" (module Line_names);
  value "line-style" (module Line_style);
  value "line-width" (module Line_width);
  value "linear-color-hint" (module Linear_color_hint);
  value "linear-color-stop" (module Linear_color_stop);
  value "mask-image" (module Mask_image);
  value "mask-layer" (module Mask_layer);
  value "mask-position" (module Mask_position);
  value "mask-reference" (module Mask_reference);
  value "mask-source" (module Mask_source);
  value "masking-mode" (module Masking_mode);
  mq "and" (module Media_and);
  mq "condition" (module Media_condition);
  mq "condition-without-or" (module Media_condition_without_or);
  mq "feature" (module Media_feature);
  mq "in-parens" (module Media_in_parens);
  mq "not" (module Media_not);
  mq "or" (module Media_or);
  mq "query" (module Media_query);
  mq "query-list" (module Media_query_list);
  (* mq "type" (module Media_type); *) (* Module doesn't exist in Parser.ml *)
  value "mf-boolean" (module Mf_boolean);
  value "mf-name" (module Mf_name);
  value "mf-plain" (module Mf_plain);
  value "mf-range" (module Mf_range);
  value "mf-value" (module Mf_value);
  value "name-repeat" (module Name_repeat);
  value "named-color" (module Named_color);
  value "namespace-prefix" (module Namespace_prefix);
  value "ns-prefix" (module Ns_prefix);
  value "nth" (module Nth);
  value "number-one-or-greater" (module Number_one_or_greater);
  value "number-percentage" (module Number_percentage);
  value "alpha-value" (module Number_zero_one);
  value "numeric-figure-values" (module Numeric_figure_values);
  value "numeric-fraction-values" (module Numeric_fraction_values);
  value "numeric-spacing-values" (module Numeric_spacing_values);
  value "outline-radius" (module Outline_radius);
  value "overflow-position" (module Overflow_position);
  value "page-body" (module Page_body);
  value "page-margin-box" (module Page_margin_box);
  value "page-margin-box-type" (module Page_margin_box_type);
  value "page-selector" (module Page_selector);
  value "page-selector-list" (module Page_selector_list);
  value "paint" (module Paint);
  value "position" (module Position);
  value "positive-integer" (module Positive_integer);
  prop "-moz-appearance" (module Property__moz_appearance);
  prop "-moz-background-clip" (module Property__moz_background_clip);
  prop "-moz-binding" (module Property__moz_binding);
  prop "-moz-border-bottom-colors" (module Property__moz_border_bottom_colors);
  prop "-moz-border-left-colors" (module Property__moz_border_left_colors);
  prop "-moz-border-radius-bottomleft" (module Property__moz_border_radius_bottomleft);
  prop "-moz-border-radius-bottomright" (module Property__moz_border_radius_bottomright);
  prop "-moz-border-radius-topleft" (module Property__moz_border_radius_topleft);
  prop "-moz-border-radius-topright" (module Property__moz_border_radius_topright);
  prop "-moz-border-right-colors" (module Property__moz_border_right_colors);
  prop "-moz-border-top-colors" (module Property__moz_border_top_colors);
  prop "-moz-context-properties" (module Property__moz_context_properties);
  prop "-moz-control-character-visibility" (module Property__moz_control_character_visibility);
  prop "-moz-float-edge" (module Property__moz_float_edge);
  prop "-moz-force-broken-image-icon" (module Property__moz_force_broken_image_icon);
  prop "-moz-image-region" (module Property__moz_image_region);
  prop "-moz-orient" (module Property__moz_orient);
  prop "-moz-osx-font-smoothing" (module Property__moz_osx_font_smoothing);
  prop "-moz-outline-radius" (module Property__moz_outline_radius);
  prop "-moz-outline-radius-bottomleft" (module Property__moz_outline_radius_bottomleft);
  prop "-moz-outline-radius-bottomright" (module Property__moz_outline_radius_bottomright);
  prop "-moz-outline-radius-topleft" (module Property__moz_outline_radius_topleft);
  prop "-moz-outline-radius-topright" (module Property__moz_outline_radius_topright);
  prop "-moz-stack-sizing" (module Property__moz_stack_sizing);
  prop "-moz-text-blink" (module Property__moz_text_blink);
  prop "-moz-user-focus" (module Property__moz_user_focus);
  prop "-moz-user-input" (module Property__moz_user_input);
  prop "-moz-user-modify" (module Property__moz_user_modify);
  prop "-moz-user-select" (module Property__moz_user_select);
  prop "-moz-window-dragging" (module Property__moz_window_dragging);
  prop "-moz-window-shadow" (module Property__moz_window_shadow);
  prop "-webkit-appearance" (module Property__webkit_appearance);
  prop "-webkit-background-clip" (module Property__webkit_background_clip);
  prop "-webkit-border-before" (module Property__webkit_border_before);
  prop "-webkit-border-before-color" (module Property__webkit_border_before_color);
  prop "-webkit-border-before-style" (module Property__webkit_border_before_style);
  prop "-webkit-border-before-width" (module Property__webkit_border_before_width);
  prop "-webkit-box-reflect" (module Property__webkit_box_reflect);
  prop "-webkit-box-shadow" (module Property_box_shadow);
  prop "-webkit-box-orient" (module Property_box_orient);
  prop "-webkit-column-break-after" (module Property__webkit_column_break_after);
  prop "-webkit-column-break-before" (module Property__webkit_column_break_before);
  prop "-webkit-column-break-inside" (module Property__webkit_column_break_inside);
  prop "-webkit-font-smoothing" (module Property__webkit_font_smoothing);
  prop "-webkit-line-clamp" (module Property__webkit_line_clamp);
  prop "-webkit-mask" (module Property__webkit_mask);
  prop "-webkit-mask-attachment" (module Property__webkit_mask_attachment);
  prop "-webkit-mask-box-image" (module Property__webkit_mask_box_image);
  prop "-webkit-mask-clip" (module Property__webkit_mask_clip);
  prop "-webkit-mask-composite" (module Property__webkit_mask_composite);
  prop "-webkit-mask-image" (module Property__webkit_mask_image);
  prop "-webkit-mask-origin" (module Property__webkit_mask_origin);
  prop "-webkit-mask-position" (module Property__webkit_mask_position);
  prop "-webkit-mask-position-x" (module Property__webkit_mask_position_x);
  prop "-webkit-mask-position-y" (module Property__webkit_mask_position_y);
  prop "-webkit-mask-repeat" (module Property__webkit_mask_repeat);
  prop "-webkit-mask-repeat-x" (module Property__webkit_mask_repeat_x);
  prop "-webkit-mask-repeat-y" (module Property__webkit_mask_repeat_y);
  prop "-webkit-mask-size" (module Property__webkit_mask_size);
  prop "-webkit-overflow-scrolling" (module Property__webkit_overflow_scrolling);
  prop "-webkit-print-color-adjust" (module Property__webkit_print_color_adjust);
  prop "-webkit-tap-highlight-color" (module Property__webkit_tap_highlight_color);
  prop "-webkit-text-fill-color" (module Property__webkit_text_fill_color);
  prop "-webkit-text-security" (module Property__webkit_text_security);
  prop "-webkit-text-stroke" (module Property__webkit_text_stroke);
  prop "-webkit-text-stroke-color" (module Property__webkit_text_stroke_color);
  prop "-webkit-text-stroke-width" (module Property__webkit_text_stroke_width);
  prop "-webkit-touch-callout" (module Property__webkit_touch_callout);
  prop "-webkit-user-drag" (module Property__webkit_user_drag);
  prop "-webkit-user-modify" (module Property__webkit_user_modify);
  prop "-webkit-user-select" (module Property__webkit_user_select);
  prop "align-content" (module Property_align_content);
  prop "align-items" (module Property_align_items);
  prop "align-self" (module Property_align_self);
  prop "alignment-baseline" (module Property_alignment_baseline);
  prop "all" (module Property_all);
  prop "animation" (module Property_animation);
  prop "animation-delay" (module Property_animation_delay);
  prop "animation-direction" (module Property_animation_direction);
  prop "animation-duration" (module Property_animation_duration);
  prop "animation-fill-mode" (module Property_animation_fill_mode);
  prop "animation-iteration-count" (module Property_animation_iteration_count);
  prop "animation-name" (module Property_animation_name);
  prop "animation-play-state" (module Property_animation_play_state);
  prop "animation-timing-function" (module Property_animation_timing_function);
  prop "appearance" (module Property_appearance);
  prop "aspect-ratio" (module Property_aspect_ratio);
  prop "azimuth" (module Property_azimuth);
  prop "backdrop-filter" (module Property_backdrop_filter);
  prop "backface-visibility" (module Property_backface_visibility);
  prop "background" (module Property_background);
  prop "background-attachment" (module Property_background_attachment);
  prop "background-blend-mode" (module Property_background_blend_mode);
  prop "background-clip" (module Property_background_clip);
  prop "background-color" (module Property_background_color);
  prop "background-image" (module Property_background_image);
  prop "background-origin" (module Property_background_origin);
  prop "background-position" (module Property_background_position);
  prop "background-position-x" (module Property_background_position_x);
  prop "background-position-y" (module Property_background_position_y);
  prop "background-repeat" (module Property_background_repeat);
  prop "background-size" (module Property_background_size);
  prop "baseline-shift" (module Property_baseline_shift);
  prop "behavior" (module Property_behavior);
  prop "block-overflow" (module Property_block_overflow);
  prop "block-size" (module Property_block_size);
  prop "border" (module Property_border);
  prop "border-block" (module Property_border_block);
  prop "border-block-color" (module Property_border_block_color);
  prop "border-block-end" (module Property_border_block_end);
  prop "border-block-end-color" (module Property_border_block_end_color);
  prop "border-block-end-style" (module Property_border_block_end_style);
  prop "border-block-end-width" (module Property_border_block_end_width);
  prop "border-block-start" (module Property_border_block_start);
  prop "border-block-start-color" (module Property_border_block_start_color);
  prop "border-block-start-style" (module Property_border_block_start_style);
  prop "border-block-start-width" (module Property_border_block_start_width);
  prop "border-block-style" (module Property_border_block_style);
  prop "border-block-width" (module Property_border_block_width);
  prop "border-bottom" (module Property_border_bottom);
  prop "border-bottom-color" (module Property_border_bottom_color);
  prop "border-bottom-left-radius" (module Property_border_bottom_left_radius);
  prop "border-bottom-right-radius" (module Property_border_bottom_right_radius);
  prop "border-bottom-style" (module Property_border_bottom_style);
  prop "border-bottom-width" (module Property_border_bottom_width);
  prop "border-collapse" (module Property_border_collapse);
  prop "border-color" (module Property_border_color);
  prop "border-end-end-radius" (module Property_border_end_end_radius);
  prop "border-end-start-radius" (module Property_border_end_start_radius);
  prop "border-image" (module Property_border_image);
  prop "border-image-outset" (module Property_border_image_outset);
  prop "border-image-repeat" (module Property_border_image_repeat);
  prop "border-image-slice" (module Property_border_image_slice);
  prop "border-image-source" (module Property_border_image_source);
  prop "border-image-width" (module Property_border_image_width);
  prop "border-inline" (module Property_border_inline);
  prop "border-inline-color" (module Property_border_inline_color);
  prop "border-inline-end" (module Property_border_inline_end);
  prop "border-inline-end-color" (module Property_border_inline_end_color);
  prop "border-inline-end-style" (module Property_border_inline_end_style);
  prop "border-inline-end-width" (module Property_border_inline_end_width);
  prop "border-inline-start" (module Property_border_inline_start);
  prop "border-inline-start-color" (module Property_border_inline_start_color);
  prop "border-inline-start-style" (module Property_border_inline_start_style);
  prop "border-inline-start-width" (module Property_border_inline_start_width);
  prop "border-inline-style" (module Property_border_inline_style);
  prop "border-inline-width" (module Property_border_inline_width);
  prop "border-left" (module Property_border_left);
  prop "border-left-color" (module Property_border_left_color);
  prop "border-left-style" (module Property_border_left_style);
  prop "border-left-width" (module Property_border_left_width);
  prop "border-radius" (module Property_border_radius);
  prop "border-right" (module Property_border_right);
  prop "border-right-color" (module Property_border_right_color);
  prop "border-right-style" (module Property_border_right_style);
  prop "border-right-width" (module Property_border_right_width);
  prop "border-spacing" (module Property_border_spacing);
  prop "border-start-end-radius" (module Property_border_start_end_radius);
  prop "border-start-start-radius" (module Property_border_start_start_radius);
  prop "border-style" (module Property_border_style);
  prop "border-top" (module Property_border_top);
  prop "border-top-color" (module Property_border_top_color);
  prop "border-top-left-radius" (module Property_border_top_left_radius);
  prop "border-top-right-radius" (module Property_border_top_right_radius);
  prop "border-top-style" (module Property_border_top_style);
  prop "border-top-width" (module Property_border_top_width);
  prop "border-width" (module Property_border_width);
  prop "bottom" (module Property_bottom);
  prop "box-align" (module Property_box_align);
  prop "box-decoration-break" (module Property_box_decoration_break);
  prop "box-direction" (module Property_box_direction);
  prop "box-flex" (module Property_box_flex);
  prop "box-flex-group" (module Property_box_flex_group);
  prop "box-lines" (module Property_box_lines);
  prop "box-ordinal-group" (module Property_box_ordinal_group);
  prop "box-orient" (module Property_box_orient);
  prop "box-pack" (module Property_box_pack);
  prop "box-shadow" (module Property_box_shadow);
  prop "box-sizing" (module Property_box_sizing);
  prop "break-after" (module Property_break_after);
  prop "break-before" (module Property_break_before);
  prop "break-inside" (module Property_break_inside);
  prop "caption-side" (module Property_caption_side);
  prop "caret-color" (module Property_caret_color);
  prop "clear" (module Property_clear);
  prop "clip" (module Property_clip);
  prop "clip-path" (module Property_clip_path);
  prop "clip-rule" (module Property_clip_rule);
  prop "color" (module Property_color);
  prop "color-adjust" (module Property_color_adjust);
  prop "color-scheme" (module Property_color_scheme);
  prop "column-count" (module Property_column_count);
  prop "column-fill" (module Property_column_fill);
  prop "column-gap" (module Property_column_gap);
  prop "column-rule" (module Property_column_rule);
  prop "column-rule-color" (module Property_column_rule_color);
  prop "column-rule-style" (module Property_column_rule_style);
  prop "column-rule-width" (module Property_column_rule_width);
  prop "column-span" (module Property_column_span);
  prop "column-width" (module Property_column_width);
  prop "columns" (module Property_columns);
  prop "contain" (module Property_contain);
  prop "content" (module Property_content);
  prop "counter-increment" (module Property_counter_increment);
  prop "counter-reset" (module Property_counter_reset);
  prop "counter-set" (module Property_counter_set);
  prop "cue" (module Property_cue);
  prop "cue-after" (module Property_cue_after);
  prop "cue-before" (module Property_cue_before);
  prop "cursor" (module Property_cursor);
  prop "direction" (module Property_direction);
  prop "display" (module Property_display);
  prop "dominant-baseline" (module Property_dominant_baseline);
  prop "empty-cells" (module Property_empty_cells);
  prop "fill" (module Property_fill);
  prop "fill-opacity" (module Property_fill_opacity);
  prop "fill-rule" (module Property_fill_rule);
  prop "filter" (module Property_filter);
  prop "flex" (module Property_flex);
  prop "flex-basis" (module Property_flex_basis);
  prop "flex-direction" (module Property_flex_direction);
  prop "flex-flow" (module Property_flex_flow);
  prop "flex-grow" (module Property_flex_grow);
  prop "flex-shrink" (module Property_flex_shrink);
  prop "flex-wrap" (module Property_flex_wrap);
  prop "float" (module Property_float);
  prop "font" (module Property_font);
  prop "font-family" (module Property_font_family);
  prop "font-feature-settings" (module Property_font_feature_settings);
  prop "font-kerning" (module Property_font_kerning);
  prop "font-language-override" (module Property_font_language_override);
  prop "font-optical-sizing" (module Property_font_optical_sizing);
  prop "font-palette" (module Property_font_palette);
  prop "font-variant-emoji" (module Property_font_variant_emoji);
  prop "font-size" (module Property_font_size);
  prop "font-size-adjust" (module Property_font_size_adjust);
  prop "font-smooth" (module Property_font_smooth);
  prop "font-stretch" (module Property_font_stretch);
  prop "font-style" (module Property_font_style);
  prop "font-synthesis" (module Property_font_synthesis);
  prop "font-synthesis-weight" (module Property_font_synthesis_weight);
  prop "font-synthesis-style" (module Property_font_synthesis_style);
  prop "font-synthesis-small-caps" (module Property_font_synthesis_small_caps);
  prop "font-synthesis-position" (module Property_font_synthesis_position);
  prop "font-variant" (module Property_font_variant);
  prop "font-variant-alternates" (module Property_font_variant_alternates);
  prop "font-variant-caps" (module Property_font_variant_caps);
  prop "font-variant-east-asian" (module Property_font_variant_east_asian);
  prop "font-variant-ligatures" (module Property_font_variant_ligatures);
  prop "font-variant-numeric" (module Property_font_variant_numeric);
  prop "font-variant-position" (module Property_font_variant_position);
  prop "font-variation-settings" (module Property_font_variation_settings);
  prop "font-weight" (module Property_font_weight);
  prop "gap" (module Property_gap);
  prop "glyph-orientation-horizontal" (module Property_glyph_orientation_horizontal);
  prop "glyph-orientation-vertical" (module Property_glyph_orientation_vertical);
  prop "grid" (module Property_grid);
  prop "grid-area" (module Property_grid_area);
  prop "grid-auto-columns" (module Property_grid_auto_columns);
  prop "grid-auto-flow" (module Property_grid_auto_flow);
  prop "grid-auto-rows" (module Property_grid_auto_rows);
  prop "grid-column" (module Property_grid_column);
  prop "grid-column-end" (module Property_grid_column_end);
  prop "grid-column-gap" (module Property_grid_column_gap);
  prop "grid-column-start" (module Property_grid_column_start);
  prop "grid-gap" (module Property_grid_gap);
  prop "grid-row" (module Property_grid_row);
  prop "grid-row-end" (module Property_grid_row_end);
  prop "grid-row-gap" (module Property_grid_row_gap);
  prop "grid-row-start" (module Property_grid_row_start);
  prop "grid-template" (module Property_grid_template);
  prop "grid-template-areas" (module Property_grid_template_areas);
  prop "grid-template-columns" (module Property_grid_template_columns);
  prop "grid-template-rows" (module Property_grid_template_rows);
  prop "hanging-punctuation" (module Property_hanging_punctuation);
  prop "height" (module Property_height);
  prop "hyphens" (module Property_hyphens);
  prop "image-orientation" (module Property_image_orientation);
  prop "image-rendering" (module Property_image_rendering);
  prop "image-resolution" (module Property_image_resolution);
  prop "ime-mode" (module Property_ime_mode);
  prop "initial-letter" (module Property_initial_letter);
  prop "initial-letter-align" (module Property_initial_letter_align);
  prop "inline-size" (module Property_inline_size);
  prop "inset" (module Property_inset);
  prop "inset-block" (module Property_inset_block);
  prop "inset-block-end" (module Property_inset_block_end);
  prop "inset-block-start" (module Property_inset_block_start);
  prop "inset-inline" (module Property_inset_inline);
  prop "inset-inline-end" (module Property_inset_inline_end);
  prop "inset-inline-start" (module Property_inset_inline_start);
  prop "isolation" (module Property_isolation);
  prop "justify-content" (module Property_justify_content);
  prop "justify-items" (module Property_justify_items);
  prop "justify-self" (module Property_justify_self);
  prop "kerning" (module Property_kerning);
  prop "left" (module Property_left);
  prop "letter-spacing" (module Property_letter_spacing);
  prop "line-break" (module Property_line_break);
  prop "line-clamp" (module Property_line_clamp);
  prop "line-height" (module Property_line_height);
  prop "line-height-step" (module Property_line_height_step);
  prop "list-style" (module Property_list_style);
  prop "list-style-image" (module Property_list_style_image);
  prop "list-style-position" (module Property_list_style_position);
  prop "list-style-type" (module Property_list_style_type);
  prop "margin" (module Property_margin);
  prop "margin-block" (module Property_margin_block);
  prop "margin-block-end" (module Property_margin_block_end);
  prop "margin-block-start" (module Property_margin_block_start);
  prop "margin-bottom" (module Property_margin_bottom);
  prop "margin-inline" (module Property_margin_inline);
  prop "margin-inline-end" (module Property_margin_inline_end);
  prop "margin-inline-start" (module Property_margin_inline_start);
  prop "margin-left" (module Property_margin_left);
  prop "margin-right" (module Property_margin_right);
  prop "margin-top" (module Property_margin_top);
  prop "margin-trim" (module Property_margin_trim);
  prop "marker" (module Property_marker);
  prop "marker-end" (module Property_marker_end);
  prop "marker-mid" (module Property_marker_mid);
  prop "marker-start" (module Property_marker_start);
  prop "mask" (module Property_mask);
  prop "mask-border" (module Property_mask_border);
  prop "mask-border-mode" (module Property_mask_border_mode);
  prop "mask-border-outset" (module Property_mask_border_outset);
  prop "mask-border-repeat" (module Property_mask_border_repeat);
  prop "mask-border-slice" (module Property_mask_border_slice);
  prop "mask-border-source" (module Property_mask_border_source);
  prop "mask-border-width" (module Property_mask_border_width);
  prop "mask-clip" (module Property_mask_clip);
  prop "mask-composite" (module Property_mask_composite);
  prop "mask-image" (module Property_mask_image);
  prop "mask-mode" (module Property_mask_mode);
  prop "mask-origin" (module Property_mask_origin);
  prop "mask-position" (module Property_mask_position);
  prop "mask-repeat" (module Property_mask_repeat);
  prop "mask-size" (module Property_mask_size);
  prop "mask-type" (module Property_mask_type);
  prop "masonry-auto-flow" (module Property_masonry_auto_flow);
  prop "max-block-size" (module Property_max_block_size);
  prop "max-height" (module Property_max_height);
  prop "max-inline-size" (module Property_max_inline_size);
  prop "max-lines" (module Property_max_lines);
  prop "max-width" (module Property_max_width);
  prop "min-block-size" (module Property_min_block_size);
  prop "min-height" (module Property_min_height);
  prop "min-inline-size" (module Property_min_inline_size);
  prop "min-width" (module Property_min_width);
  prop "mix-blend-mode" (module Property_mix_blend_mode);
  prop "object-fit" (module Property_object_fit);
  prop "object-position" (module Property_object_position);
  prop "offset" (module Property_offset);
  prop "offset-anchor" (module Property_offset_anchor);
  prop "offset-distance" (module Property_offset_distance);
  prop "offset-path" (module Property_offset_path);
  prop "offset-position" (module Property_offset_position);
  prop "offset-rotate" (module Property_offset_rotate);
  prop "opacity" (module Property_opacity);
  prop "order" (module Property_order);
  prop "orphans" (module Property_orphans);
  prop "outline" (module Property_outline);
  prop "outline-color" (module Property_outline_color);
  prop "outline-offset" (module Property_outline_offset);
  prop "outline-style" (module Property_outline_style);
  prop "outline-width" (module Property_outline_width);
  prop "overflow" (module Property_overflow);
  prop "overflow-anchor" (module Property_overflow_anchor);
  prop "overflow-block" (module Property_overflow_block);
  prop "overflow-clip-margin" (module Property_overflow_clip_margin);
  prop "overflow-inline" (module Property_overflow_inline);
  prop "overflow-wrap" (module Property_overflow_wrap);
  prop "overflow-x" (module Property_overflow_x);
  prop "overflow-y" (module Property_overflow_y);
  prop "overscroll-behavior" (module Property_overscroll_behavior);
  prop "overscroll-behavior-block" (module Property_overscroll_behavior_block);
  prop "overscroll-behavior-inline" (module Property_overscroll_behavior_inline);
  prop "overscroll-behavior-x" (module Property_overscroll_behavior_x);
  prop "overscroll-behavior-y" (module Property_overscroll_behavior_y);
  prop "any-hover" (module Property_media_any_hover);
  prop "any-pointer" (module Property_media_any_pointer);
  prop "pointer" (module Property_media_pointer);
  prop "max-aspect-ratio" (module Property_media_max_aspect_ratio);
  prop "min-aspect-ratio" (module Property_media_min_aspect_ratio);
  prop "min-color" (module Property_media_min_color);
  prop "color-gamut" (module Property_media_color_gamut);
  prop "color-index" (module Property_media_color_index);
  prop "min-color-index" (module Property_media_min_color_index);
  prop "display-mode" (module Property_media_display_mode);
  prop "forced-colors" (module Property_media_forced_colors);
  prop "forced-color-adjust" (module Property_forced_color_adjust);
  prop "grid" (module Property_media_grid);
  prop "hover" (module Property_media_hover);
  prop "inverted-colors" (module Property_media_inverted_colors);
  prop "monochrome" (module Property_media_monochrome);
  prop "prefers-color-scheme" (module Property_media_prefers_color_scheme);
  prop "prefers-contrast" (module Property_media_prefers_contrast);
  prop "prefers-reduced-motion" (module Property_media_prefers_reduced_motion);
  prop "resolution" (module Property_media_resolution);
  prop "min-resolution" (module Property_media_min_resolution);
  prop "max-resolution" (module Property_media_max_resolution);
  prop "scripting" (module Property_media_scripting);
  prop "update" (module Property_media_update);
  prop "orientation" (module Property_media_orientation);
  prop "padding" (module Property_padding);
  prop "padding-block" (module Property_padding_block);
  prop "padding-block-end" (module Property_padding_block_end);
  prop "padding-block-start" (module Property_padding_block_start);
  prop "padding-bottom" (module Property_padding_bottom);
  prop "padding-inline" (module Property_padding_inline);
  prop "padding-inline-end" (module Property_padding_inline_end);
  prop "padding-inline-start" (module Property_padding_inline_start);
  prop "padding-left" (module Property_padding_left);
  prop "padding-right" (module Property_padding_right);
  prop "padding-top" (module Property_padding_top);
  prop "page-break-after" (module Property_page_break_after);
  prop "page-break-before" (module Property_page_break_before);
  prop "page-break-inside" (module Property_page_break_inside);
  prop "paint-order" (module Property_paint_order);
  prop "pause" (module Property_pause);
  prop "pause-after" (module Property_pause_after);
  prop "pause-before" (module Property_pause_before);
  prop "perspective" (module Property_perspective);
  prop "perspective-origin" (module Property_perspective_origin);
  prop "place-content" (module Property_place_content);
  prop "place-items" (module Property_place_items);
  prop "place-self" (module Property_place_self);
  prop "pointer-events" (module Property_pointer_events);
  prop "position" (module Property_position);
  prop "quotes" (module Property_quotes);
  prop "resize" (module Property_resize);
  prop "rest" (module Property_rest);
  prop "rest-after" (module Property_rest_after);
  prop "rest-before" (module Property_rest_before);
  prop "right" (module Property_right);
  prop "rotate" (module Property_rotate);
  prop "row-gap" (module Property_row_gap);
  prop "ruby-align" (module Property_ruby_align);
  prop "ruby-merge" (module Property_ruby_merge);
  prop "ruby-position" (module Property_ruby_position);
  prop "scale" (module Property_scale);
  prop "scroll-behavior" (module Property_scroll_behavior);
  prop "scroll-margin" (module Property_scroll_margin);
  prop "scroll-margin-block" (module Property_scroll_margin_block);
  prop "scroll-margin-block-end" (module Property_scroll_margin_block_end);
  prop "scroll-margin-block-start" (module Property_scroll_margin_block_start);
  prop "scroll-margin-bottom" (module Property_scroll_margin_bottom);
  prop "scroll-margin-inline" (module Property_scroll_margin_inline);
  prop "scroll-margin-inline-end" (module Property_scroll_margin_inline_end);
  prop "scroll-margin-inline-start" (module Property_scroll_margin_inline_start);
  prop "scroll-margin-left" (module Property_scroll_margin_left);
  prop "scroll-margin-right" (module Property_scroll_margin_right);
  prop "scroll-margin-top" (module Property_scroll_margin_top);
  prop "scroll-padding" (module Property_scroll_padding);
  prop "scroll-padding-block" (module Property_scroll_padding_block);
  prop "scroll-padding-block-end" (module Property_scroll_padding_block_end);
  prop "scroll-padding-block-start" (module Property_scroll_padding_block_start);
  prop "scroll-padding-bottom" (module Property_scroll_padding_bottom);
  prop "scroll-padding-inline" (module Property_scroll_padding_inline);
  prop "scroll-padding-inline-end" (module Property_scroll_padding_inline_end);
  prop "scroll-padding-inline-start" (module Property_scroll_padding_inline_start);
  prop "scroll-padding-left" (module Property_scroll_padding_left);
  prop "scroll-padding-right" (module Property_scroll_padding_right);
  prop "scroll-padding-top" (module Property_scroll_padding_top);
  prop "scroll-snap-align" (module Property_scroll_snap_align);
  prop "scroll-snap-coordinate" (module Property_scroll_snap_coordinate);
  prop "scroll-snap-destination" (module Property_scroll_snap_destination);
  prop "scroll-snap-points-x" (module Property_scroll_snap_points_x);
  prop "scroll-snap-points-y" (module Property_scroll_snap_points_y);
  prop "scroll-snap-stop" (module Property_scroll_snap_stop);
  prop "scroll-snap-type" (module Property_scroll_snap_type);
  prop "scroll-snap-type-x" (module Property_scroll_snap_type_x);
  prop "scroll-snap-type-y" (module Property_scroll_snap_type_y);
  prop "scrollbar-color" (module Property_scrollbar_color);
  prop "scrollbar-width" (module Property_scrollbar_width);
  prop "scrollbar-gutter" (module Property_scrollbar_gutter);
  prop "shape-image-threshold" (module Property_shape_image_threshold);
  prop "shape-margin" (module Property_shape_margin);
  prop "shape-outside" (module Property_shape_outside);
  prop "shape-rendering" (module Property_shape_rendering);
  prop "speak" (module Property_speak);
  prop "speak-as" (module Property_speak_as);
  prop "src" (module Property_src);
  prop "stroke" (module Property_stroke);
  prop "stroke-dasharray" (module Property_stroke_dasharray);
  prop "stroke-dashoffset" (module Property_stroke_dashoffset);
  prop "stroke-linecap" (module Property_stroke_linecap);
  prop "stroke-linejoin" (module Property_stroke_linejoin);
  prop "stroke-miterlimit" (module Property_stroke_miterlimit);
  prop "stroke-opacity" (module Property_stroke_opacity);
  prop "stroke-width" (module Property_stroke_width);
  prop "tab-size" (module Property_tab_size);
  prop "table-layout" (module Property_table_layout);
  prop "text-align" (module Property_text_align);
  prop "text-align-all" (module Property_text_align_all);
  prop "text-align-last" (module Property_text_align_last);
  prop "text-anchor" (module Property_text_anchor);
  prop "text-combine-upright" (module Property_text_combine_upright);
  prop "text-decoration" (module Property_text_decoration);
  prop "text-decoration-color" (module Property_text_decoration_color);
  prop "text-decoration-line" (module Property_text_decoration_line);
  prop "text-decoration-skip" (module Property_text_decoration_skip);
  prop "text-decoration-skip-ink" (module Property_text_decoration_skip_ink);
  prop "text-decoration-skip-box" (module Property_text_decoration_skip_box);
  prop "text-decoration-skip-inset" (module Property_text_decoration_skip_inset);
  prop "text-decoration-style" (module Property_text_decoration_style);
  prop "text-decoration-thickness" (module Property_text_decoration_thickness);
  prop "text-emphasis" (module Property_text_emphasis);
  prop "text-emphasis-color" (module Property_text_emphasis_color);
  prop "text-emphasis-position" (module Property_text_emphasis_position);
  prop "text-emphasis-style" (module Property_text_emphasis_style);
  prop "text-indent" (module Property_text_indent);
  prop "text-justify" (module Property_text_justify);
  prop "text-orientation" (module Property_text_orientation);
  prop "text-overflow" (module Property_text_overflow);
  prop "text-rendering" (module Property_text_rendering);
  prop "text-shadow" (module Property_text_shadow);
  prop "text-size-adjust" (module Property_text_size_adjust);
  prop "text-transform" (module Property_text_transform);
  prop "text-underline-offset" (module Property_text_underline_offset);
  prop "text-underline-position" (module Property_text_underline_position);
  prop "top" (module Property_top);
  prop "touch-action" (module Property_touch_action);
  prop "transform" (module Property_transform);
  prop "transform-box" (module Property_transform_box);
  prop "transform-origin" (module Property_transform_origin);
  prop "transform-style" (module Property_transform_style);
  prop "transition" (module Property_transition);
  prop "transition-behavior" (module Property_transition_behavior);
  prop "transition-delay" (module Property_transition_delay);
  prop "transition-duration" (module Property_transition_duration);
  prop "transition-property" (module Property_transition_property);
  prop "transition-timing-function" (module Property_transition_timing_function);
  prop "translate" (module Property_translate);
  prop "unicode-bidi" (module Property_unicode_bidi);
  prop "unicode-range" (module Property_unicode_range);
  prop "user-select" (module Property_user_select);
  prop "vertical-align" (module Property_vertical_align);
  prop "visibility" (module Property_visibility);
  prop "voice-balance" (module Property_voice_balance);
  prop "voice-duration" (module Property_voice_duration);
  prop "voice-family" (module Property_voice_family);
  prop "voice-pitch" (module Property_voice_pitch);
  prop "voice-range" (module Property_voice_range);
  prop "voice-rate" (module Property_voice_rate);
  prop "voice-stress" (module Property_voice_stress);
  prop "voice-volume" (module Property_voice_volume);
  prop "white-space" (module Property_white_space);
  prop "widows" (module Property_widows);
  prop "width" (module Property_width);
  prop "will-change" (module Property_will_change);
  prop "word-break" (module Property_word_break);
  prop "word-spacing" (module Property_word_spacing);
  prop "word-wrap" (module Property_word_wrap);
  prop "writing-mode" (module Property_writing_mode);
  prop "z-index" (module Property_z_index);
  prop "zoom" (module Property_zoom);
  prop "container" (module Property_container);
  prop "container-name" (module Property_container_name);
  prop "container-type" (module Property_container_type);
  value "pseudo-class-selector" (module Pseudo_class_selector);
  value "pseudo-element-selector" (module Pseudo_element_selector);
  value "pseudo-page" (module Pseudo_page);
  value "quote" (module Quote);
  value "ratio" (module Ratio);
  value "relative-selector" (module Relative_selector);
  value "relative-selector-list" (module Relative_selector_list);
  value "relative-size" (module Relative_size);
  value "repeat-style" (module Repeat_style);
  value "right" (module Right);
  value "self-position" (module Self_position);
  value "shadow" (module Shadow);
  value "shadow-t" (module Shadow_t);
  value "shape" (module Shape);
  value "shape-box" (module Shape_box);
  value "shape-radius" (module Shape_radius);
  value "side-or-corner" (module Side_or_corner);
  value "single-animation" (module Single_animation);
  value "font-families" (module Font_families);
  value "single-animation-direction" (module Single_animation_direction);
  value "single-animation-fill-mode" (module Single_animation_fill_mode);
  value "single-animation-iteration-count" (module Single_animation_iteration_count);
  value "single-animation-play-state" (module Single_animation_play_state);
  value "single-transition" (module Single_transition);
  value "single-transition-property" (module Single_transition_property);
  value "size" (module Size);
  value "ray-size" (module Ray_size);
  value "radial-size" (module Radial_size);
  value "step-position" (module Step_position);
  value "step-timing-function" (module Step_timing_function);
  value "subclass-selector" (module Subclass_selector);
  value "supports-condition" (module Supports_condition);
  value "supports-decl" (module Supports_decl);
  value "supports-feature" (module Supports_feature);
  value "supports-in-parens" (module Supports_in_parens);
  value "supports-selector-fn" (module Supports_selector_fn);
  value "svg-length" (module Svg_length);
  value "svg-writing-mode" (module Svg_writing_mode);
  value "symbol" (module Symbol);
  value "symbols-type" (module Symbols_type);
  value "target" (module Target);
  value "timing-function" (module Timing_function);
  value "top" (module Top);
  value "track-breadth" (module Track_breadth);
  value "track-group" (module Track_group);
  value "track-list" (module Track_list);
  value "track-list-v0" (module Track_list_v0);
  value "track-minmax" (module Track_minmax);
  value "track-repeat" (module Track_repeat);
  value "track-size" (module Track_size);
  value "transform-function" (module Transform_function);
  value "transform-list" (module Transform_list);
  value "type-or-unit" (module Type_or_unit);
  value "type-selector" (module Type_selector);
  value "viewport-length" (module Viewport_length);
  value "wq-name" (module Wq_name);
  value "x" (module X);
  value "y" (module Y);
  (* TODO: calc needs to be available in length *)
  value "extended-length" (module Extended_length);
  value "extended-frequency" (module Extended_frequency);
  value "extended-angle" (module Extended_angle);
  value "extended-time" (module Extended_time);
  value "extended-percentage" (module Extended_percentage);
]

(* Apply a packed rule to tokens and check if it's valid *)
let apply_packed_rule packed_rule tokens =
  let module R = (val packed_rule : RULE) in
  let result, remaining = R.rule tokens in
  R.name, Result.is_ok result, remaining

let find_rule (property : string) =
  packed_rules
  |> List.find_opt (fun packed_rule ->
       let module R = (val packed_rule : RULE) in
       match R.name with Property name -> property = name | _ -> false)

(* let apply_rule_by_name (name, tokens) =
     find_rule_by_name(name)
     |> Option.map(fun rule -> apply_packed_rule(rule, tokens))
   *)

let check_rule (rule, value) =
  let module R = (val rule : RULE) in
  parse R.rule value |> Result.is_ok

let check_property ~loc ~name value :
  ( unit,
    Styled_ppx_css_parser.Ast.loc
    * [> `Invalid_value of string | `Property_not_found ] )
  result =
  match find_rule name with
  | Some rule ->
    let module R = (val rule : RULE) in
    (match parse R.rule value with
    | Ok _ -> Ok ()
    | Error message -> Error (loc, `Invalid_value message))
  | None -> Error (loc, `Property_not_found)

(* Parse and get the string representation of the result *)
let parse_to_string (rule : (module RULE)) (value : string) : (string, string) result =
  let module R = (val rule : RULE) in
  match parse R.rule value with
  | Ok result -> Ok (R.to_string result)
  | Error message -> Error message

(* Parse a property value and get its string representation *)
let parse_property_to_string (property : string) (value : string) : (string, string) result =
  match find_rule property with
  | Some rule -> parse_to_string rule value
  | None -> Error ("Property not found: " ^ property)
