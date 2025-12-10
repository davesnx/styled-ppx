module type RUNTIME_TYPE = sig
  type t

  val toString : t -> string
end

module type RULE = sig
  type t

  val rule : t Rule.rule
  val parse : string -> (t, string) result
  val to_string : t -> string
  val runtime_module : (module RUNTIME_TYPE) option
  val runtime_module_path : string option
  val extract_interpolations : t -> (string * string) list
end

type length =
  [ `Cap of float
  | `Ch of float
  | `Em of float
  | `Ex of float
  | `Ic of float
  | `Lh of float
  | `Rcap of float
  | `Rch of float
  | `Rem of float
  | `Rex of float
  | `Ric of float
  | `Rlh of float
  | `Vh of float
  | `Vw of float
  | `Vmax of float
  | `Vmin of float
  | `Vb of float
  | `Vi of float
  | `Cqw of float
  | `Cqh of float
  | `Cqi of float
  | `Cqb of float
  | `Cqmin of float
  | `Cqmax of float
  | `Px of float
  | `Cm of float
  | `Mm of float
  | `Q of float
  | `In of float
  | `Pc of float
  | `Pt of float
  | `Zero
  ]

and angle =
  [ `Deg of float
  | `Grad of float
  | `Rad of float
  | `Turn of float
  ]

and time =
  [ `S of float
  | `Ms of float
  ]

and frequency =
  [ `Hz of float
  | `KHz of float
  ]

and resolution =
  [ `Dpi of float
  | `Dppx of float
  | `Dpcm of float
  ]

and flex_value = [ `Fr of float ]

and css_wide_keywords =
  [ `Initial
  | `Inherit
  | `Unset
  | `Revert
  | `RevertLayer
  ]

and extended_frequency =
  [ `Frequency of frequency
  | `Function_calc of calc_sum
  | `Interpolation of string list
  | `Function_min of calc_sum list
  | `Function_max of calc_sum list
  ]

and extended_time =
  [ `Time of time
  | `Function_calc of calc_sum
  | `Interpolation of string list
  | `Function_min of calc_sum list
  | `Function_max of calc_sum list
  ]

and extended_percentage =
  [ `Percentage of float
  | `Function_calc of calc_sum
  | `Interpolation of string list
  | `Function_min of calc_sum list
  | `Function_max of calc_sum list
  ]

and extended_angle =
  [ `Angle of angle
  | `Function_calc of calc_sum
  | `Interpolation of string list
  | `Function_min of calc_sum list
  | `Function_max of calc_sum list
  ]

and extended_length =
  [ `Length of length
  | `Function_calc of calc_sum
  | `Interpolation of string list
  | `Function_min of calc_sum list
  | `Function_max of calc_sum list
  ]

and calc_sum =
  calc_product * ([ `Cross of unit | `Dash of unit ] * calc_product) list

and calc_product =
  calc_value
  * [ `Static_0 of unit * calc_value | `Static_1 of unit * float ] list

and calc_value =
  [ `Number of float
  | `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  | `Extended_angle of extended_angle
  | `Extended_time of extended_time
  | `Static of unit * calc_sum * unit
  ]

and extended_time_no_interp =
  [ `Time of time
  | `Function_calc of calc_sum
  | `Function_min of calc_sum list
  | `Function_max of calc_sum list
  ]

and one_bg_size =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  | `Auto
  ]
  * [ `Extended_length of extended_length
    | `Extended_percentage of extended_percentage
    | `Auto
    ]
    option

and ratio =
  [ `Static of int * unit * int
  | `Number of float
  | `Interpolation of string list
  ]

and legacy_linear_gradient_arguments =
  [ `Extended_angle of extended_angle | `Side_or_corner of side_or_corner ]
  option
  * unit
  * color_stop_list

and legacy_radial_gradient_shape =
  [ `Circle
  | `Ellipse
  ]

and legacy_radial_gradient_size =
  [ `Closest_side
  | `Closest_corner
  | `Farthest_side
  | `Farthest_corner
  | `Contain
  | `Cover
  ]

and legacy_radial_gradient_arguments =
  (position * unit) option
  * ([ `Or of
       legacy_radial_gradient_shape option * legacy_radial_gradient_size option
     | `Xor of
       [ `Extended_length of extended_length
       | `Extended_percentage of extended_percentage
       ]
       list
     ]
    * unit)
    option
  * color_stop_list

and legacy_linear_gradient =
  [ `Moz_linear_gradient of legacy_linear_gradient_arguments
  | `Webkit_linear_gradient of legacy_linear_gradient_arguments
  | `O_linear_gradient of legacy_linear_gradient_arguments
  ]

and legacy_radial_gradient =
  [ `Moz_radial_gradient of legacy_radial_gradient_arguments
  | `Webkit_radial_gradient of legacy_radial_gradient_arguments
  | `O_radial_gradient of legacy_radial_gradient_arguments
  ]

and legacy_repeating_linear_gradient =
  [ `Moz_repeating_linear_gradient of legacy_linear_gradient_arguments
  | `Webkit_repeating_linear_gradient of legacy_linear_gradient_arguments
  | `O_repeating_linear_gradient of legacy_linear_gradient_arguments
  ]

and legacy_repeating_radial_gradient =
  [ `Moz_repeating_radial_gradient of legacy_radial_gradient_arguments
  | `Webkit_repeating_radial_gradient of legacy_radial_gradient_arguments
  | `O_repeating_radial_gradient of legacy_radial_gradient_arguments
  ]

and legacy_gradient =
  [ `Function__webkit_gradient of function__webkit_gradient
  | `Legacy_linear_gradient of legacy_linear_gradient
  | `Legacy_repeating_linear_gradient of legacy_repeating_linear_gradient
  | `Legacy_radial_gradient of legacy_radial_gradient
  | `Legacy_repeating_radial_gradient of legacy_repeating_radial_gradient
  ]

and non_standard_color =
  [ `Moz_ButtonDefault
  | `Moz_ButtonHoverFace
  | `Moz_ButtonHoverText
  | `Moz_CellHighlight
  | `Moz_CellHighlightText
  | `Moz_Combobox
  | `Moz_ComboboxText
  | `Moz_Dialog
  | `Moz_DialogText
  | `Moz_dragtargetzone
  | `Moz_EvenTreeRow
  | `Moz_Field
  | `Moz_FieldText
  | `Moz_html_CellHighlight
  | `Moz_html_CellHighlightText
  | `Moz_mac_accentdarkestshadow
  | `Moz_mac_accentdarkshadow
  | `Moz_mac_accentface
  | `Moz_mac_accentlightesthighlight
  | `Moz_mac_accentlightshadow
  | `Moz_mac_accentregularhighlight
  | `Moz_mac_accentregularshadow
  | `Moz_mac_chrome_active
  | `Moz_mac_chrome_inactive
  | `Moz_mac_focusring
  | `Moz_mac_menuselect
  | `Moz_mac_menushadow
  | `Moz_mac_menutextselect
  | `Moz_MenuHover
  | `Moz_MenuHoverText
  | `Moz_MenuBarText
  | `Moz_MenuBarHoverText
  | `Moz_nativehyperlinktext
  | `Moz_OddTreeRow
  | `Moz_win_communicationstext
  | `Moz_win_mediatext
  | `Moz_activehyperlinktext
  | `Moz_default_background_color
  | `Moz_default_color
  | `Moz_hyperlinktext
  | `Moz_visitedhyperlinktext
  | `Webkit_activelink
  | `Webkit_focus_ring_color
  | `Webkit_link
  | `Webkit_text
  ]

and non_standard_font =
  [ `Apple_system_body
  | `Apple_system_headline
  | `Apple_system_subheadline
  | `Apple_system_caption1
  | `Apple_system_caption2
  | `Apple_system_footnote
  | `Apple_system_short_body
  | `Apple_system_short_headline
  | `Apple_system_short_subheadline
  | `Apple_system_short_caption1
  | `Apple_system_short_footnote
  | `Apple_system_tall_body
  ]

and non_standard_image_rendering =
  [ `Optimize_contrast
  | `Moz_crisp_edges
  | `O_crisp_edges
  | `Webkit_optimize_contrast
  ]

and non_standard_overflow =
  [ `Moz_scrollbars_none
  | `Moz_scrollbars_horizontal
  | `Moz_scrollbars_vertical
  | `Moz_hidden_unscrollable
  ]

and non_standard_width =
  [ `Min_intrinsic
  | `Intrinsic
  | `Moz_min_content
  | `Moz_max_content
  | `Webkit_min_content
  | `Webkit_max_content
  ]

and webkit_gradient_color_stop =
  [ `From of color
  | `Color_stop of
    [ `Alpha_value of alpha_value
    | `Extended_percentage of extended_percentage
    ]
    * unit
    * color
  | `To of color
  ]

and webkit_gradient_point =
  [ `Left
  | `Center
  | `Right
  | `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]
  * [ `Top
    | `Center
    | `Bottom
    | `Extended_length of extended_length
    | `Extended_percentage of extended_percentage
    ]

and webkit_gradient_radius =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and webkit_gradient_type =
  [ `Linear
  | `Radial
  ]

and webkit_mask_box_repeat =
  [ `Repeat
  | `Stretch
  | `Round
  ]

and webkit_mask_clip_style =
  [ `Border
  | `Border_box
  | `Padding
  | `Padding_box
  | `Content
  | `Content_box
  | `Text
  ]

and absolute_size =
  [ `Xx_small
  | `X_small
  | `Small
  | `Medium
  | `Large
  | `X_large
  | `Xx_large
  | `Xxx_large
  ]

and age =
  [ `Child
  | `Young
  | `Old
  ]

and alpha_value =
  [ `Number of float
  | `Extended_percentage of extended_percentage
  ]

and angular_color_hint =
  [ `Extended_angle of extended_angle
  | `Extended_percentage of extended_percentage
  ]

and angular_color_stop = color * color_stop_angle option

and angular_color_stop_list =
  (angular_color_stop * (unit * angular_color_hint) option) list
  * unit
  * angular_color_stop

and animateable_feature =
  [ `Scroll_position
  | `Contents
  | `Custom_ident of string
  ]

and attachment =
  [ `Scroll
  | `Fixed
  | `Local
  ]

and attr_fallback = unit

and attr_matcher =
  [ `Tilde of unit
  | `Vbar of unit
  | `Caret of unit
  | `Dollar of unit
  | `Asterisk of unit
  ]
  option
  * unit

and attr_modifier =
  [ `I
  | `S
  ]

and attribute_selector =
  [ `Static_0 of unit * wq_name * unit
  | `Static_1 of
    unit
    * wq_name
    * attr_matcher
    * [ `String_token of string | `Ident_token of string ]
    * attr_modifier option
    * unit
  ]

and auto_repeat =
  [ `Auto_fill | `Auto_fit ]
  * unit
  * (line_names option * fixed_size) list
  * line_names option

and auto_track_list =
  (line_names option
  * [ `Fixed_size of fixed_size | `Fixed_repeat of fixed_repeat ])
  list
  * line_names option
  * auto_repeat
  * (line_names option
    * [ `Fixed_size of fixed_size | `Fixed_repeat of fixed_repeat ])
    list
  * line_names option

and baseline_position = [ `First | `Last ] option * unit

and basic_shape =
  [ `Function_inset of function_inset
  | `Function_circle of function_circle
  | `Function_ellipse of function_ellipse
  | `Function_polygon of function_polygon
  | `Function_path of function_path
  ]

and bg_image =
  [ `None
  | `Image of image
  ]

and bg_layer =
  bg_image option
  * (bg_position * (unit * bg_size) option) option
  * repeat_style option
  * attachment option
  * box option
  * box option

and bg_position =
  [ `Xor of
    [ `Left
    | `Center
    | `Right
    | `Top
    | `Bottom
    | `Length_percentage of length_percentage
    ]
  | `Static of
    [ `Left | `Center | `Right | `Length_percentage of length_percentage ]
    * [ `Top | `Center | `Bottom | `Length_percentage of length_percentage ]
  | `And of
    [ `Center | `Static of [ `Left | `Right ] * length_percentage option ]
    * [ `Center | `Static of [ `Top | `Bottom ] * length_percentage option ]
  ]

and bg_size =
  [ `One_bg_size of one_bg_size
  | `Cover
  | `Contain
  ]

and blend_mode =
  [ `Normal
  | `Multiply
  | `Screen
  | `Overlay
  | `Darken
  | `Lighten
  | `Color_dodge
  | `Color_burn
  | `Hard_light
  | `Soft_light
  | `Difference
  | `Exclusion
  | `Hue
  | `Saturation
  | `Color
  | `Luminosity
  ]

and border_radius =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]
  list
  * (unit
    * [ `Extended_length of extended_length
      | `Extended_percentage of extended_percentage
      ]
      list)
    option

and bottom =
  [ `Extended_length of extended_length
  | `Auto
  ]

and box =
  [ `Border_box
  | `Padding_box
  | `Content_box
  ]

and dimension =
  [ `Extended_length of extended_length
  | `Extended_time of extended_time
  | `Extended_frequency of extended_frequency
  | `Resolution of resolution
  ]

and cf_final_image =
  [ `Image of image
  | `Color of color
  ]

and cf_mixing_image = extended_percentage option * image
and class_selector = unit * string
and clip_source = url

and color =
  [ `Function_rgb of function_rgb
  | `Function_rgba of function_rgba
  | `Function_hsl of function_hsl
  | `Function_hsla of function_hsla
  | `Hex_color of string
  | `Named_color of named_color
  | `CurrentColor
  | `Deprecated_system_color of deprecated_system_color
  | `Interpolation of string list
  | `Function_var of function_var
  | `Function_color_mix of function_color_mix
  ]

and color_stop =
  [ `Color_stop_length of color_stop_length
  | `Color_stop_angle of color_stop_angle
  ]

and color_stop_angle = extended_angle list

and color_stop_length =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and color_stop_list =
  [ `Static_0 of color option * length_percentage
  | `Static_1 of color * length_percentage option
  ]
  list

and hue_interpolation_method =
  [ `Shorter | `Longer | `Increasing | `Decreasing ] * unit

and polar_color_space =
  [ `Hsl
  | `Hwb
  | `Lch
  | `Oklch
  ]

and rectangular_color_space =
  [ `Srgb
  | `Srgb_linear
  | `Display_p3
  | `A98_rgb
  | `Prophoto_rgb
  | `Rec2020
  | `Lab
  | `Oklab
  | `Xyz
  | `Xyz_d50
  | `Xyz_d65
  ]

and color_interpolation_method =
  unit
  * [ `Rectangular_color_space of rectangular_color_space
    | `Static of polar_color_space * hue_interpolation_method option
    ]

and function_color_mix =
  color_interpolation_method
  * unit
  * (color * float option)
  * unit
  * (color * float option)

and combinator =
  [ `Biggerthan of unit
  | `Cross of unit
  | `Tilde of unit
  | `Doublevbar
  ]

and common_lig_values =
  [ `Common_ligatures
  | `No_common_ligatures
  ]

and compat_auto =
  [ `Searchfield
  | `Textarea
  | `Push_button
  | `Slider_horizontal
  | `Checkbox
  | `Radio
  | `Square_button
  | `Menulist
  | `Listbox
  | `Meter
  | `Progress_bar
  ]

and complex_selector =
  compound_selector * (combinator option * compound_selector) list

and complex_selector_list = complex_selector list

and composite_style =
  [ `Clear
  | `Copy
  | `Source_over
  | `Source_in
  | `Source_out
  | `Source_atop
  | `Destination_over
  | `Destination_in
  | `Destination_out
  | `Destination_atop
  | `Xor
  ]

and compositing_operator =
  [ `Add
  | `Subtract
  | `Intersect
  | `Exclude
  ]

and compound_selector =
  type_selector option
  * subclass_selector list
  * (pseudo_element_selector * pseudo_class_selector list) list

and compound_selector_list = compound_selector list

and content_distribution =
  [ `Space_between
  | `Space_around
  | `Space_evenly
  | `Stretch
  ]

and content_list =
  [ `String of string
  | `Contents
  | `Url of url
  | `Quote of quote
  | `Function_attr of function_attr
  | `Counter of string * unit * property_list_style_type option
  ]
  list

and content_position =
  [ `Center
  | `Start
  | `End
  | `Flex_start
  | `Flex_end
  ]

and content_replacement = image

and contextual_alt_values =
  [ `Contextual
  | `No_contextual
  ]

and counter_style =
  [ `Counter_style_name of counter_style_name
  | `Function_symbols of function_symbols
  ]

and counter_style_name = string
and counter_name = string

and cubic_bezier_timing_function =
  [ `Ease
  | `Ease_in
  | `Ease_out
  | `Ease_in_out
  | `Cubic_bezier of float * unit * float * unit * float * unit * float
  ]

and declaration = string * unit * unit option * (unit * unit) option
and declaration_list = (declaration option * unit) list * declaration option

and deprecated_system_color =
  [ `ActiveBorder
  | `ActiveCaption
  | `AppWorkspace
  | `Background
  | `ButtonFace
  | `ButtonHighlight
  | `ButtonShadow
  | `ButtonText
  | `CaptionText
  | `GrayText
  | `Highlight
  | `HighlightText
  | `InactiveBorder
  | `InactiveCaption
  | `InactiveCaptionText
  | `InfoBackground
  | `InfoText
  | `Menu
  | `MenuText
  | `Scrollbar
  | `ThreeDDarkShadow
  | `ThreeDFace
  | `ThreeDHighlight
  | `ThreeDLightShadow
  | `ThreeDShadow
  | `Window
  | `WindowFrame
  | `WindowText
  ]

and discretionary_lig_values =
  [ `Discretionary_ligatures
  | `No_discretionary_ligatures
  ]

and display_box =
  [ `Contents
  | `None
  ]

and display_inside =
  [ `Flow
  | `Flow_root
  | `Table
  | `Flex
  | `Grid
  | `Ruby
  ]

and display_internal =
  [ `Table_row_group
  | `Table_header_group
  | `Table_footer_group
  | `Table_row
  | `Table_cell
  | `Table_column_group
  | `Table_column
  | `Table_caption
  | `Ruby_base
  | `Ruby_text
  | `Ruby_base_container
  | `Ruby_text_container
  ]

and display_legacy =
  [ `Inline_block
  | `Inline_list_item
  | `Inline_table
  | `Inline_flex
  | `Inline_grid
  ]

and display_listitem =
  display_outside option * [ `Flow | `Flow_root ] option * unit

and display_outside =
  [ `Block
  | `Inline
  | `Run_in
  ]

and east_asian_variant_values =
  [ `Jis78
  | `Jis83
  | `Jis90
  | `Jis04
  | `Simplified
  | `Traditional
  ]

and east_asian_width_values =
  [ `Full_width
  | `Proportional_width
  ]

and ending_shape =
  [ `Circle
  | `Ellipse
  ]

and explicit_track_list =
  (line_names option * track_size) list * line_names option

and family_name =
  [ `String of string
  | `Custom_ident of string
  ]

and feature_tag_value = string * [ `Integer of int | `On | `Off ] option

and feature_type =
  [ `At_stylistic
  | `At_historical_forms
  | `At_styleset
  | `At_character_variant
  | `At_swash
  | `At_ornaments
  | `At_annotation
  ]

and feature_value_block =
  feature_type * unit * feature_value_declaration_list * unit

and feature_value_block_list = feature_value_block list
and feature_value_declaration = string * unit * int list * unit
and feature_value_declaration_list = feature_value_declaration
and feature_value_name = string
and zero = unit

and fill_rule =
  [ `Nonzero
  | `Evenodd
  ]

and filter_function =
  [ `Function_blur of function_blur
  | `Function_brightness of function_brightness
  | `Function_contrast of function_contrast
  | `Function_drop_shadow of function_drop_shadow
  | `Function_grayscale of function_grayscale
  | `Function_hue_rotate of function_hue_rotate
  | `Function_invert of function_invert
  | `Function_opacity of function_opacity
  | `Function_saturate of function_saturate
  | `Function_sepia of function_sepia
  ]

and filter_function_list =
  [ `Filter_function of filter_function | `Url of url ] list

and final_bg_layer =
  property_background_color option
  * bg_image option
  * (bg_position * (unit * bg_size) option) option
  * repeat_style option
  * attachment option
  * box option
  * box option

and line_names = unit * string list * unit

and fixed_breadth =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and fixed_repeat =
  positive_integer
  * unit
  * (line_names option * fixed_size) list
  * line_names option

and fixed_size =
  [ `Fixed_breadth of fixed_breadth
  | `Minmax_0 of fixed_breadth * unit * track_breadth
  | `Minmax_1 of inflexible_breadth * unit * fixed_breadth
  ]

and font_stretch_absolute =
  [ `Normal
  | `Ultra_condensed
  | `Extra_condensed
  | `Condensed
  | `Semi_condensed
  | `Semi_expanded
  | `Expanded
  | `Extra_expanded
  | `Ultra_expanded
  | `Extended_percentage of extended_percentage
  ]

and font_variant_css21 =
  [ `Normal
  | `Small_caps
  ]

and font_weight_absolute =
  [ `Normal
  | `Bold
  | `Integer of int
  ]

and function__webkit_gradient =
  webkit_gradient_type
  * unit
  * webkit_gradient_point
  * [ `Static_0 of unit * webkit_gradient_point
    | `Static_1 of unit * webkit_gradient_radius * unit * webkit_gradient_point
    ]
  * (unit * webkit_gradient_radius) option
  * (unit * webkit_gradient_color_stop) list

and function_attr = attr_name * attr_type option
and function_blur = extended_length
and function_brightness = number_percentage
and function_calc = calc_sum
and function_circle = shape_radius option * (unit * position) option
and function_clamp = calc_sum list

and function_conic_gradient =
  (unit * extended_angle) option
  * (unit * position) option
  * unit
  * angular_color_stop_list

and function_contrast = number_percentage
and function_counter = counter_name * unit * counter_style option
and function_counters = string * unit * string * unit * counter_style option
and function_cross_fade = cf_mixing_image * unit * cf_final_image option

and function_drop_shadow =
  extended_length * extended_length * extended_length * color option

and function_element = id_selector
and function_ellipse = shape_radius list option * (unit * position) option
and function_env = string * unit * unit option

and function_fit_content =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and function_grayscale = number_percentage

and function_hsl =
  [ `Hsl_0 of
    hue
    * extended_percentage
    * extended_percentage
    * (unit * alpha_value) option
  | `Hsl_1 of
    hue
    * unit
    * extended_percentage
    * unit
    * extended_percentage
    * (unit * alpha_value) option
  ]

and function_hsla =
  [ `Hsla_0 of
    hue
    * extended_percentage
    * extended_percentage
    * (unit * alpha_value) option
  | `Hsla_1 of
    hue
    * unit
    * extended_percentage
    * unit
    * extended_percentage
    * unit
    * alpha_value option
  ]

and function_hue_rotate = extended_angle
and function_image = image_tags option * image_src option * unit * color option
and function_image_set = image_set_option list

and function_inset =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]
  list
  * (unit * property_border_radius) option

and function_invert = number_percentage
and function_leader = leader_type

and function_linear_gradient =
  [ `Static_0 of extended_angle * unit
  | `Static_1 of unit * side_or_corner * unit
  ]
  option
  * color_stop_list

and function_matrix = float list
and function_matrix3d = float list
and function_max = calc_sum list
and function_min = calc_sum list

and function_minmax =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  | `Min_content
  | `Max_content
  | `Auto
  ]
  * unit
  * [ `Extended_length of extended_length
    | `Extended_percentage of extended_percentage
    | `Flex_value of flex_value
    | `Min_content
    | `Max_content
    | `Auto
    ]

and function_opacity = number_percentage
and function_paint = string * unit * unit option
and function_path = string
and function_perspective = property_perspective

and function_polygon =
  (fill_rule * unit) option * (length_percentage * length_percentage) list

and function_radial_gradient =
  ending_shape option
  * radial_size option
  * (unit * position) option
  * unit option
  * color_stop_list

and function_repeating_linear_gradient =
  [ `Extended_angle of extended_angle | `Static of unit * side_or_corner ]
  option
  * unit
  * color_stop_list

and function_repeating_radial_gradient =
  (ending_shape option * size option) option
  * (unit * position) option
  * unit
  * color_stop_list

and function_rgb =
  [ `Rgb_0 of extended_percentage list * (unit * alpha_value) option
  | `Rgb_1 of float list * (unit * alpha_value) option
  | `Rgb_2 of extended_percentage list * (unit * alpha_value) option
  | `Rgb_3 of float list * (unit * alpha_value) option
  ]

and function_rgba =
  [ `Rgba_0 of extended_percentage list * (unit * alpha_value) option
  | `Rgba_1 of float list * (unit * alpha_value) option
  | `Rgba_2 of extended_percentage list * (unit * alpha_value) option
  | `Rgba_3 of float list * (unit * alpha_value) option
  ]

and function_rotate =
  [ `Extended_angle of extended_angle
  | `Zero of zero
  ]

and function_rotate3d =
  float
  * unit
  * float
  * unit
  * float
  * unit
  * [ `Extended_angle of extended_angle | `Zero of zero ]

and function_rotateX =
  [ `Extended_angle of extended_angle
  | `Zero of zero
  ]

and function_rotateY =
  [ `Extended_angle of extended_angle
  | `Zero of zero
  ]

and function_rotateZ =
  [ `Extended_angle of extended_angle
  | `Zero of zero
  ]

and function_saturate = number_percentage
and function_scale = float * (unit * float) option
and function_scale3d = float * unit * float * unit * float
and function_scaleX = float
and function_scaleY = float
and function_scaleZ = float
and function_sepia = number_percentage

and function_skew =
  [ `Extended_angle of extended_angle | `Zero of zero ]
  * (unit * [ `Extended_angle of extended_angle | `Zero of zero ]) option

and function_skewX =
  [ `Extended_angle of extended_angle
  | `Zero of zero
  ]

and function_skewY =
  [ `Extended_angle of extended_angle
  | `Zero of zero
  ]

and function_symbols =
  symbols_type option * [ `String of string | `Image of image ] list

and function_target_counter =
  [ `String of string | `Url of url ]
  * unit
  * string
  * unit
  * counter_style option

and function_target_counters =
  [ `String of string | `Url of url ]
  * unit
  * string
  * unit
  * string
  * unit
  * counter_style option

and function_target_text =
  [ `String of string | `Url of url ]
  * unit
  * [ `Content | `Before | `After | `First_letter ] option

and function_translate =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]
  * (unit
    * [ `Extended_length of extended_length
      | `Extended_percentage of extended_percentage
      ])
    option

and function_translate3d =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]
  * unit
  * [ `Extended_length of extended_length
    | `Extended_percentage of extended_percentage
    ]
  * unit
  * extended_length

and function_translateX =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and function_translateY =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and function_translateZ = extended_length
and function_var = string

and gender =
  [ `Male
  | `Female
  | `Neutral
  ]

and general_enclosed =
  [ `Static_0 of unit * unit * unit
  | `Static_1 of unit * string * unit * unit
  ]

and generic_family =
  [ `Serif
  | `Sans_serif
  | `Cursive
  | `Fantasy
  | `Monospace
  | `Apple_system
  ]

and generic_name =
  [ `Serif
  | `Sans_serif
  | `Cursive
  | `Fantasy
  | `Monospace
  ]

and generic_voice = age option * gender * int option

and geometry_box =
  [ `Shape_box of shape_box
  | `Fill_box
  | `Stroke_box
  | `View_box
  ]

and gradient =
  [ `Function_linear_gradient of function_linear_gradient
  | `Function_repeating_linear_gradient of function_repeating_linear_gradient
  | `Function_radial_gradient of function_radial_gradient
  | `Function_repeating_radial_gradient of function_repeating_radial_gradient
  | `Function_conic_gradient of function_conic_gradient
  | `Legacy_gradient of legacy_gradient
  ]

and grid_line =
  [ `Custom_ident_without_span_or_auto of string
  | `And_0 of int * string option
  | `And_1 of unit * (int option * string option)
  | `Auto
  | `Interpolation of string list
  ]

and historical_lig_values =
  [ `Historical_ligatures
  | `No_historical_ligatures
  ]

and hue =
  [ `Number of float
  | `Extended_angle of extended_angle
  ]

and id_selector = unit

and image =
  [ `Url of url
  | `Function_image of function_image
  | `Function_image_set of function_image_set
  | `Function_element of function_element
  | `Function_paint of function_paint
  | `Function_cross_fade of function_cross_fade
  | `Gradient of gradient
  | `Interpolation of string list
  ]

and image_set_option = [ `Image of image | `String of string ] * resolution

and image_src =
  [ `Url of url
  | `String of string
  ]

and image_tags =
  [ `Ltr
  | `Rtl
  ]

and inflexible_breadth =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  | `Min_content
  | `Max_content
  | `Auto
  ]

and keyframe_block = keyframe_selector list * unit * declaration_list * unit
and keyframe_block_list = keyframe_block list

and keyframe_selector =
  [ `From
  | `To
  | `Extended_percentage of extended_percentage
  ]

and keyframes_name =
  [ `Custom_ident of string
  | `String of string
  ]

and leader_type =
  [ `Dotted
  | `Solid
  | `Space
  | `String of string
  ]

and left =
  [ `Extended_length of extended_length
  | `Auto
  ]

and line_name_list =
  [ `Line_names of line_names | `Name_repeat of name_repeat ] list

and line_style =
  [ `None
  | `Hidden
  | `Dotted
  | `Dashed
  | `Solid
  | `Double
  | `Groove
  | `Ridge
  | `Inset
  | `Outset
  ]

and line_width =
  [ `Extended_length of extended_length
  | `Thin
  | `Medium
  | `Thick
  ]

and linear_color_hint =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and linear_color_stop = color * length_percentage option
and mask_image = mask_reference list

and mask_layer =
  mask_reference option
  * (position * (unit * bg_size) option) option
  * repeat_style option
  * geometry_box option
  * [ `Geometry_box of geometry_box | `No_clip ] option
  * compositing_operator option
  * masking_mode option

and mask_position =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  | `Left
  | `Center
  | `Right
  ]
  * [ `Extended_length of extended_length
    | `Extended_percentage of extended_percentage
    | `Top
    | `Center
    | `Bottom
    ]
    option

and mask_reference =
  [ `None
  | `Image of image
  | `Mask_source of mask_source
  ]

and mask_source = url

and masking_mode =
  [ `Alpha
  | `Luminance
  | `Match_source
  ]

and mf_comparison =
  [ `Mf_lt of mf_lt
  | `Mf_gt of mf_gt
  | `Mf_eq of mf_eq
  ]

and mf_eq = unit

and mf_gt =
  [ `Biggerthan_equal
  | `Biggerthan of unit
  ]

and mf_lt =
  [ `Lessthan_equal
  | `Lessthan of unit
  ]

and mf_value =
  [ `Number of float
  | `Dimension of dimension
  | `Ident of string
  | `Ratio of ratio
  | `Interpolation of string list
  | `Function_calc of function_calc
  ]

and mf_name = string

and mf_range =
  [ `Static_0 of mf_name * mf_comparison * mf_value
  | `Static_1 of mf_value * mf_comparison * mf_name
  | `Static_2 of mf_value * mf_lt * mf_name * mf_lt * mf_value
  | `Static_3 of mf_value * mf_gt * mf_name * mf_gt * mf_value
  ]

and mf_boolean = mf_name
and mf_plain = mf_name * unit * mf_value

and media_feature =
  unit
  * [ `Mf_plain of mf_plain
    | `Mf_boolean of mf_boolean
    | `Mf_range of mf_range
    ]
  * unit

and media_in_parens =
  [ `Static of unit * media_condition * unit
  | `Media_feature of media_feature
  | `Interpolation of string list
  ]

and media_and = unit * media_in_parens
and media_or = unit * media_in_parens
and media_not = unit * media_in_parens

and media_condition_without_or =
  [ `Media_not of media_not
  | `Static of media_in_parens * media_and list
  ]

and media_condition =
  [ `Media_not of media_not
  | `Static of
    media_in_parens
    * [ `Media_and of media_and list | `Media_or of media_or list ]
  ]

and media_query =
  [ `Media_condition of media_condition
  | `Static of
    [ `Not | `Only ] option
    * string
    * (unit * media_condition_without_or) option
  ]

and media_query_list =
  [ `Media_query of media_query list
  | `Interpolation of string list
  ]

and container_condition_list = container_condition list
and container_condition = string option * container_query

and container_query =
  [ `Static_0 of unit * query_in_parens
  | `Static_1 of
    query_in_parens
    * [ `Static_0 of (unit * query_in_parens) list
      | `Static_1 of (unit * query_in_parens) list
      ]
  ]

and query_in_parens =
  [ `Static_0 of unit * container_query * unit
  | `Static_1 of unit * size_feature * unit
  | `Style of style_query
  ]

and size_feature =
  [ `Mf_plain of mf_plain
  | `Mf_boolean of mf_boolean
  | `Mf_range of mf_range
  ]

and style_query =
  [ `Static_0 of unit * style_in_parens
  | `Static_1 of
    style_in_parens
    * [ `Static_0 of (unit * style_in_parens) list
      | `Static_1 of (unit * style_in_parens) list
      ]
  | `Style_feature of style_feature
  ]

and style_feature = string * unit * mf_value

and style_in_parens =
  [ `Static_0 of unit * style_query * unit
  | `Static_1 of unit * style_feature * unit
  ]

and name_repeat =
  [ `Positive_integer of positive_integer | `Auto_fill ]
  * unit
  * line_names list

and named_color =
  [ `Transparent
  | `Aliceblue
  | `Antiquewhite
  | `Aqua
  | `Aquamarine
  | `Azure
  | `Beige
  | `Bisque
  | `Black
  | `Blanchedalmond
  | `Blue
  | `Blueviolet
  | `Brown
  | `Burlywood
  | `Cadetblue
  | `Chartreuse
  | `Chocolate
  | `Coral
  | `Cornflowerblue
  | `Cornsilk
  | `Crimson
  | `Cyan
  | `Darkblue
  | `Darkcyan
  | `Darkgoldenrod
  | `Darkgray
  | `Darkgreen
  | `Darkgrey
  | `Darkkhaki
  | `Darkmagenta
  | `Darkolivegreen
  | `Darkorange
  | `Darkorchid
  | `Darkred
  | `Darksalmon
  | `Darkseagreen
  | `Darkslateblue
  | `Darkslategray
  | `Darkslategrey
  | `Darkturquoise
  | `Darkviolet
  | `Deeppink
  | `Deepskyblue
  | `Dimgray
  | `Dimgrey
  | `Dodgerblue
  | `Firebrick
  | `Floralwhite
  | `Forestgreen
  | `Fuchsia
  | `Gainsboro
  | `Ghostwhite
  | `Gold
  | `Goldenrod
  | `Gray
  | `Green
  | `Greenyellow
  | `Grey
  | `Honeydew
  | `Hotpink
  | `Indianred
  | `Indigo
  | `Ivory
  | `Khaki
  | `Lavender
  | `Lavenderblush
  | `Lawngreen
  | `Lemonchiffon
  | `Lightblue
  | `Lightcoral
  | `Lightcyan
  | `Lightgoldenrodyellow
  | `Lightgray
  | `Lightgreen
  | `Lightgrey
  | `Lightpink
  | `Lightsalmon
  | `Lightseagreen
  | `Lightskyblue
  | `Lightslategray
  | `Lightslategrey
  | `Lightsteelblue
  | `Lightyellow
  | `Lime
  | `Limegreen
  | `Linen
  | `Magenta
  | `Maroon
  | `Mediumaquamarine
  | `Mediumblue
  | `Mediumorchid
  | `Mediumpurple
  | `Mediumseagreen
  | `Mediumslateblue
  | `Mediumspringgreen
  | `Mediumturquoise
  | `Mediumvioletred
  | `Midnightblue
  | `Mintcream
  | `Mistyrose
  | `Moccasin
  | `Navajowhite
  | `Navy
  | `Oldlace
  | `Olive
  | `Olivedrab
  | `Orange
  | `Orangered
  | `Orchid
  | `Palegoldenrod
  | `Palegreen
  | `Paleturquoise
  | `Palevioletred
  | `Papayawhip
  | `Peachpuff
  | `Peru
  | `Pink
  | `Plum
  | `Powderblue
  | `Purple
  | `Rebeccapurple
  | `Red
  | `Rosybrown
  | `Royalblue
  | `Saddlebrown
  | `Salmon
  | `Sandybrown
  | `Seagreen
  | `Seashell
  | `Sienna
  | `Silver
  | `Skyblue
  | `Slateblue
  | `Slategray
  | `Slategrey
  | `Snow
  | `Springgreen
  | `Steelblue
  | `Tan
  | `Teal
  | `Thistle
  | `Tomato
  | `Turquoise
  | `Violet
  | `Wheat
  | `White
  | `Whitesmoke
  | `Yellow
  | `Yellowgreen
  | `Non_standard_color of non_standard_color
  ]

and namespace_prefix = string
and ns_prefix = [ `Ident_token of string | `Asterisk of unit ] option * unit

and nth =
  [ `An_plus_b of unit
  | `Even
  | `Odd
  ]

and number_one_or_greater = float

and number_percentage =
  [ `Number of float
  | `Extended_percentage of extended_percentage
  ]

and number_zero_one = float

and numeric_figure_values =
  [ `Lining_nums
  | `Oldstyle_nums
  ]

and numeric_fraction_values =
  [ `Diagonal_fractions
  | `Stacked_fractions
  ]

and numeric_spacing_values =
  [ `Proportional_nums
  | `Tabular_nums
  ]

and outline_radius =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and overflow_position =
  [ `Unsafe
  | `Safe
  ]

and page_body =
  [ `Static_0 of declaration option * (unit * page_body) option
  | `Static_1 of page_margin_box * page_body
  ]

and page_margin_box = page_margin_box_type * unit * declaration_list * unit

and page_margin_box_type =
  [ `At_top_left_corner
  | `At_top_left
  | `At_top_center
  | `At_top_right
  | `At_top_right_corner
  | `At_bottom_left_corner
  | `At_bottom_left
  | `At_bottom_center
  | `At_bottom_right
  | `At_bottom_right_corner
  | `At_left_top
  | `At_left_middle
  | `At_left_bottom
  | `At_right_top
  | `At_right_middle
  | `At_right_bottom
  ]

and page_selector =
  [ `Pseudo_page of pseudo_page list
  | `Static of string * pseudo_page list
  ]

and page_selector_list = page_selector list option

and paint =
  [ `None
  | `Color of color
  | `Static of url * [ `None | `Color of color ] option
  | `Context_fill
  | `Context_stroke
  | `Interpolation of string list
  ]

and position =
  [ `Xor of
    [ `Left
    | `Center
    | `Right
    | `Top
    | `Bottom
    | `Length_percentage of length_percentage
    ]
  | `And_0 of [ `Left | `Center | `Right ] * [ `Top | `Center | `Bottom ]
  | `Static of
    [ `Left | `Center | `Right | `Length_percentage of length_percentage ]
    * [ `Top | `Center | `Bottom | `Length_percentage of length_percentage ]
  | `And_1 of
    ([ `Left | `Right ] * length_percentage)
    * ([ `Top | `Bottom ] * length_percentage)
  ]

and positive_integer = int

and property__moz_appearance =
  [ `None
  | `Button
  | `Button_arrow_down
  | `Button_arrow_next
  | `Button_arrow_previous
  | `Button_arrow_up
  | `Button_bevel
  | `Button_focus
  | `Caret
  | `Checkbox
  | `Checkbox_container
  | `Checkbox_label
  | `Checkmenuitem
  | `Dualbutton
  | `Groupbox
  | `Listbox
  | `Listitem
  | `Menuarrow
  | `Menubar
  | `Menucheckbox
  | `Menuimage
  | `Menuitem
  | `Menuitemtext
  | `Menulist
  | `Menulist_button
  | `Menulist_text
  | `Menulist_textfield
  | `Menupopup
  | `Menuradio
  | `Menuseparator
  | `Meterbar
  | `Meterchunk
  | `Progressbar
  | `Progressbar_vertical
  | `Progresschunk
  | `Progresschunk_vertical
  | `Radio
  | `Radio_container
  | `Radio_label
  | `Radiomenuitem
  | `Range
  | `Range_thumb
  | `Resizer
  | `Resizerpanel
  | `Scale_horizontal
  | `Scalethumbend
  | `Scalethumb_horizontal
  | `Scalethumbstart
  | `Scalethumbtick
  | `Scalethumb_vertical
  | `Scale_vertical
  | `Scrollbarbutton_down
  | `Scrollbarbutton_left
  | `Scrollbarbutton_right
  | `Scrollbarbutton_up
  | `Scrollbarthumb_horizontal
  | `Scrollbarthumb_vertical
  | `Scrollbartrack_horizontal
  | `Scrollbartrack_vertical
  | `Searchfield
  | `Separator
  | `Sheet
  | `Spinner
  | `Spinner_downbutton
  | `Spinner_textfield
  | `Spinner_upbutton
  | `Splitter
  | `Statusbar
  | `Statusbarpanel
  | `Tab
  | `Tabpanel
  | `Tabpanels
  | `Tab_scroll_arrow_back
  | `Tab_scroll_arrow_forward
  | `Textfield
  | `Textfield_multiline
  | `Toolbar
  | `Toolbarbutton
  | `Toolbarbutton_dropdown
  | `Toolbargripper
  | `Toolbox
  | `Tooltip
  | `Treeheader
  | `Treeheadercell
  | `Treeheadersortarrow
  | `Treeitem
  | `Treeline
  | `Treetwisty
  | `Treetwistyopen
  | `Treeview
  | `Moz_mac_unified_toolbar
  | `Moz_win_borderless_glass
  | `Moz_win_browsertabbar_toolbox
  | `Moz_win_communicationstext
  | `Moz_win_communications_toolbox
  | `Moz_win_exclude_glass
  | `Moz_win_glass
  | `Moz_win_mediatext
  | `Moz_win_media_toolbox
  | `Moz_window_button_box
  | `Moz_window_button_box_maximized
  | `Moz_window_button_close
  | `Moz_window_button_maximize
  | `Moz_window_button_minimize
  | `Moz_window_button_restore
  | `Moz_window_frame_bottom
  | `Moz_window_frame_left
  | `Moz_window_frame_right
  | `Moz_window_titlebar
  | `Moz_window_titlebar_maximized
  ]

and property__moz_background_clip =
  [ `Padding
  | `Border
  ]

and property__moz_binding =
  [ `Url of url
  | `None
  ]

and property__moz_border_bottom_colors =
  [ `Color of color list
  | `None
  ]

and property__moz_border_left_colors =
  [ `Color of color list
  | `None
  ]

and property__moz_border_radius_bottomleft = property_border_bottom_left_radius

and property__moz_border_radius_bottomright =
  property_border_bottom_right_radius

and property__moz_border_radius_topleft = property_border_top_left_radius
and property__moz_border_radius_topright = property_border_bottom_right_radius

and property__moz_border_right_colors =
  [ `Color of color list
  | `None
  ]

and property__moz_border_top_colors =
  [ `Color of color list
  | `None
  ]

and property__moz_context_properties =
  [ `None
  | `Xor of [ `Fill | `Fill_opacity | `Stroke | `Stroke_opacity ] list
  ]

and property__moz_control_character_visibility =
  [ `Visible
  | `Hidden
  ]

and property__moz_float_edge =
  [ `Border_box
  | `Content_box
  | `Margin_box
  | `Padding_box
  ]

and property__moz_force_broken_image_icon = int

and property__moz_image_region =
  [ `Shape of shape
  | `Auto
  ]

and property__moz_orient =
  [ `Inline
  | `Block
  | `Horizontal
  | `Vertical
  ]

and property__moz_osx_font_smoothing =
  [ `Auto
  | `Grayscale
  ]

and property__moz_outline_radius =
  outline_radius list * (unit * outline_radius list) option

and property__moz_outline_radius_bottomleft = outline_radius
and property__moz_outline_radius_bottomright = outline_radius
and property__moz_outline_radius_topleft = outline_radius
and property__moz_outline_radius_topright = outline_radius

and property__moz_stack_sizing =
  [ `Ignore
  | `Stretch_to_fit
  ]

and property__moz_text_blink =
  [ `None
  | `Blink
  ]

and property__moz_user_focus =
  [ `Ignore
  | `Normal
  | `Select_after
  | `Select_before
  | `Select_menu
  | `Select_same
  | `Select_all
  | `None
  ]

and property__moz_user_input =
  [ `Auto
  | `None
  | `Enabled
  | `Disabled
  ]

and property__moz_user_modify =
  [ `Read_only
  | `Read_write
  | `Write_only
  ]

and property__moz_user_select =
  [ `None
  | `Text
  | `All
  | `Moz_none
  ]

and property__moz_window_dragging =
  [ `Drag
  | `No_drag
  ]

and property__moz_window_shadow =
  [ `Default
  | `Menu
  | `Tooltip
  | `Sheet
  | `None
  ]

and property__webkit_appearance =
  [ `None
  | `Button
  | `Button_bevel
  | `Caps_lock_indicator
  | `Caret
  | `Checkbox
  | `Default_button
  | `Listbox
  | `Listitem
  | `Media_fullscreen_button
  | `Media_mute_button
  | `Media_play_button
  | `Media_seek_back_button
  | `Media_seek_forward_button
  | `Media_slider
  | `Media_sliderthumb
  | `Menulist
  | `Menulist_button
  | `Menulist_text
  | `Menulist_textfield
  | `Push_button
  | `Radio
  | `Scrollbarbutton_down
  | `Scrollbarbutton_left
  | `Scrollbarbutton_right
  | `Scrollbarbutton_up
  | `Scrollbargripper_horizontal
  | `Scrollbargripper_vertical
  | `Scrollbarthumb_horizontal
  | `Scrollbarthumb_vertical
  | `Scrollbartrack_horizontal
  | `Scrollbartrack_vertical
  | `Searchfield
  | `Searchfield_cancel_button
  | `Searchfield_decoration
  | `Searchfield_results_button
  | `Searchfield_results_decoration
  | `Slider_horizontal
  | `Slider_vertical
  | `Sliderthumb_horizontal
  | `Sliderthumb_vertical
  | `Square_button
  | `Textarea
  | `Textfield
  ]

and property__webkit_background_clip =
  [ `Box of box | `Border | `Padding | `Content | `Text ] list

and property__webkit_border_before =
  property_border_width option
  * property_border_style option
  * property_color option

and property__webkit_border_before_color = property_color
and property__webkit_border_before_style = property_border_style
and property__webkit_border_before_width = property_border_width

and property__webkit_box_reflect =
  [ `Above | `Below | `Right | `Left ] option
  * extended_length option
  * image option

and property__webkit_column_break_after =
  [ `Always
  | `Auto
  | `Avoid
  ]

and property__webkit_column_break_before =
  [ `Always
  | `Auto
  | `Avoid
  ]

and property__webkit_column_break_inside =
  [ `Always
  | `Auto
  | `Avoid
  ]

and property__webkit_font_smoothing =
  [ `Auto
  | `None
  | `Antialiased
  | `Subpixel_antialiased
  ]

and property__webkit_line_clamp =
  [ `None
  | `Integer of int
  ]

and property__webkit_mask =
  (mask_reference option
  * (position * (unit * bg_size) option) option
  * repeat_style option
  * [ `Box of box | `Border | `Padding | `Content | `Text ] option
  * [ `Box of box | `Border | `Padding | `Content ] option)
  list

and property__webkit_mask_attachment = attachment list

and property__webkit_mask_box_image =
  [ `Url of url | `Gradient of gradient | `None ]
  * ([ `Extended_length of extended_length
     | `Extended_percentage of extended_percentage
     ]
     list
    * webkit_mask_box_repeat list)
    option

and property__webkit_mask_clip =
  [ `Box of box | `Border | `Padding | `Content | `Text ] list

and property__webkit_mask_composite = composite_style list
and property__webkit_mask_image = mask_reference list

and property__webkit_mask_origin =
  [ `Box of box | `Border | `Padding | `Content ] list

and property__webkit_mask_position = position list

and property__webkit_mask_position_x =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  | `Left
  | `Center
  | `Right
  ]
  list

and property__webkit_mask_position_y =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  | `Top
  | `Center
  | `Bottom
  ]
  list

and property__webkit_mask_repeat = repeat_style list

and property__webkit_mask_repeat_x =
  [ `Repeat
  | `No_repeat
  | `Space
  | `Round
  ]

and property__webkit_mask_repeat_y =
  [ `Repeat
  | `No_repeat
  | `Space
  | `Round
  ]

and property__webkit_mask_size = bg_size list

and property__webkit_overflow_scrolling =
  [ `Auto
  | `Touch
  ]

and property__webkit_print_color_adjust =
  [ `Economy
  | `Exact
  ]

and property__webkit_tap_highlight_color = color
and property__webkit_text_fill_color = color

and property__webkit_text_security =
  [ `None
  | `Circle
  | `Disc
  | `Square
  ]

and property__webkit_text_stroke = extended_length option * color option
and property__webkit_text_stroke_color = color
and property__webkit_text_stroke_width = extended_length

and property__webkit_touch_callout =
  [ `Default
  | `None
  ]

and property__webkit_user_drag =
  [ `None
  | `Element
  | `Auto
  ]

and property__webkit_user_modify =
  [ `Read_only
  | `Read_write
  | `Read_write_plaintext_only
  ]

and property__webkit_user_select =
  [ `Auto
  | `None
  | `Text
  | `All
  ]

and property_align_content =
  [ `Normal
  | `Baseline_position of baseline_position
  | `Content_distribution of content_distribution
  | `Static of overflow_position option * content_position
  ]

and property_align_items =
  [ `Normal
  | `Stretch
  | `Baseline_position of baseline_position
  | `Static of overflow_position option * self_position
  | `Interpolation of string list
  ]

and property_align_self =
  [ `Auto
  | `Normal
  | `Stretch
  | `Baseline_position of baseline_position
  | `Static of overflow_position option * self_position
  | `Interpolation of string list
  ]

and property_alignment_baseline =
  [ `Auto
  | `Baseline
  | `Before_edge
  | `Text_before_edge
  | `Middle
  | `Central
  | `After_edge
  | `Text_after_edge
  | `Ideographic
  | `Alphabetic
  | `Hanging
  | `Mathematical
  ]

and property_all =
  [ `Initial
  | `Inherit
  | `Unset
  | `Revert
  ]

and property_animation =
  [ `Single_animation of single_animation
  | `Single_animation_no_interp of single_animation_no_interp
  ]
  list

and property_animation_delay = extended_time list
and property_animation_direction = single_animation_direction list
and property_animation_duration = extended_time list
and property_animation_fill_mode = single_animation_fill_mode list
and property_animation_iteration_count = single_animation_iteration_count list

and property_animation_name =
  [ `Keyframes_name of keyframes_name | `None | `Interpolation of string list ]
  list

and property_animation_play_state = single_animation_play_state list
and property_animation_timing_function = timing_function list

and property_appearance =
  [ `None
  | `Auto
  | `Button
  | `Textfield
  | `Menulist_button
  | `Compat_auto of compat_auto
  ]

and property_aspect_ratio =
  [ `Auto
  | `Ratio of ratio
  ]

and property_azimuth =
  [ `Extended_angle of extended_angle
  | `Or of
    [ `Left_side
    | `Far_left
    | `Left
    | `Center_left
    | `Center
    | `Center_right
    | `Right
    | `Far_right
    | `Right_side
    ]
    option
    * unit option
  | `Leftwards
  | `Rightwards
  ]

and property_backdrop_filter =
  [ `None
  | `Interpolation of string list
  | `Filter_function_list of filter_function_list
  ]

and property_backface_visibility =
  [ `Visible
  | `Hidden
  ]

and property_background = (bg_layer * unit) list * final_bg_layer
and property_background_attachment = attachment list
and property_background_blend_mode = blend_mode list
and property_background_clip = [ `Box of box | `Text | `Border_area ] list
and property_background_color = color
and property_background_image = bg_image list
and property_background_origin = box list
and property_background_position = bg_position list

and property_background_position_x =
  [ `Center
  | `Static of
    [ `Left | `Right | `X_start | `X_end ] option
    * [ `Extended_length of extended_length
      | `Extended_percentage of extended_percentage
      ]
      option
  ]
  list

and property_background_position_y =
  [ `Center
  | `Static of
    [ `Top | `Bottom | `Y_start | `Y_end ] option
    * [ `Extended_length of extended_length
      | `Extended_percentage of extended_percentage
      ]
      option
  ]
  list

and property_background_repeat = repeat_style list
and property_background_size = bg_size list

and property_baseline_shift =
  [ `Baseline
  | `Sub
  | `Super
  | `Svg_length of svg_length
  ]

and property_behavior = url list

and property_block_overflow =
  [ `Clip
  | `Ellipsis
  | `String of string
  ]

and property_block_size = property_width

and property_border =
  [ `None
  | `Xor of [ `Line_width of line_width | `Interpolation of string list ]
  | `Static_0 of
    [ `Line_width of line_width | `Interpolation of string list ]
    * [ `Line_style of line_style | `Interpolation of string list ]
  | `Static_1 of
    [ `Line_width of line_width | `Interpolation of string list ]
    * [ `Line_style of line_style | `Interpolation of string list ]
    * [ `Color of color | `Interpolation of string list ]
  ]

and property_border_block = property_border
and property_border_block_color = property_border_top_color list
and property_border_block_end = property_border
and property_border_block_end_color = property_border_top_color
and property_border_block_end_style = property_border_top_style
and property_border_block_end_width = property_border_top_width
and property_border_block_start = property_border
and property_border_block_start_color = property_border_top_color
and property_border_block_start_style = property_border_top_style
and property_border_block_start_width = property_border_top_width
and property_border_block_style = property_border_top_style
and property_border_block_width = property_border_top_width
and property_border_bottom = property_border
and property_border_bottom_color = property_border_top_color

and property_border_bottom_left_radius =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]
  list

and property_border_bottom_right_radius =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]
  list

and property_border_bottom_style = line_style
and property_border_bottom_width = line_width

and property_border_collapse =
  [ `Collapse
  | `Separate
  ]

and property_border_color = color list

and property_border_end_end_radius =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]
  list

and property_border_end_start_radius =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]
  list

and property_border_image =
  property_border_image_source option
  * (property_border_image_slice
    * [ `Static_0 of unit * property_border_image_width
      | `Static_1 of
        unit
        * property_border_image_width option
        * unit
        * property_border_image_outset
      ]
      option)
    option
  * property_border_image_repeat option

and property_border_image_outset =
  [ `Extended_length of extended_length | `Number of float ] list

and property_border_image_repeat = [ `Stretch | `Repeat | `Round | `Space ] list
and property_border_image_slice = number_percentage list * unit option

and property_border_image_source =
  [ `None
  | `Image of image
  ]

and property_border_image_width =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  | `Number of float
  | `Auto
  ]
  list

and property_border_inline = property_border
and property_border_inline_color = property_border_top_color list
and property_border_inline_end = property_border
and property_border_inline_end_color = property_border_top_color
and property_border_inline_end_style = property_border_top_style
and property_border_inline_end_width = property_border_top_width
and property_border_inline_start = property_border
and property_border_inline_start_color = property_border_top_color
and property_border_inline_start_style = property_border_top_style
and property_border_inline_start_width = property_border_top_width
and property_border_inline_style = property_border_top_style
and property_border_inline_width = property_border_top_width
and property_border_left = property_border
and property_border_left_color = color
and property_border_left_style = line_style
and property_border_left_width = line_width

and property_border_radius =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]
  list
  * (unit
    * [ `Extended_length of extended_length
      | `Extended_percentage of extended_percentage
      ]
      list)
    option

and property_border_right = property_border
and property_border_right_color = color
and property_border_right_style = line_style
and property_border_right_width = line_width
and property_border_spacing = extended_length * extended_length option

and property_border_start_end_radius =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]
  list

and property_border_start_start_radius =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]
  list

and property_border_style = line_style
and property_border_top = property_border
and property_border_top_color = color

and property_border_top_left_radius =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]
  list

and property_border_top_right_radius =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]
  list

and property_border_top_style = line_style
and property_border_top_width = line_width
and property_border_width = line_width list

and property_bottom =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  | `Auto
  ]

and property_box_align =
  [ `Start
  | `Center
  | `End
  | `Baseline
  | `Stretch
  ]

and property_box_decoration_break =
  [ `Slice
  | `Clone
  ]

and property_box_direction =
  [ `Normal
  | `Reverse
  | `Inherit
  ]

and property_box_flex = float
and property_box_flex_group = int

and property_box_lines =
  [ `Single
  | `Multiple
  ]

and property_box_ordinal_group = int

and property_box_orient =
  [ `Horizontal
  | `Vertical
  | `Inline_axis
  | `Block_axis
  | `Inherit
  ]

and property_box_pack =
  [ `Start
  | `Center
  | `End
  | `Justify
  ]

and property_box_shadow =
  [ `None
  | `Interpolation of string list
  | `Shadow of shadow list
  ]

and property_box_sizing =
  [ `Content_box
  | `Border_box
  ]

and property_break_after =
  [ `Auto
  | `Avoid
  | `Always
  | `All
  | `Avoid_page
  | `Page
  | `Left
  | `Right
  | `Recto
  | `Verso
  | `Avoid_column
  | `Column
  | `Avoid_region
  | `Region
  ]

and property_break_before =
  [ `Auto
  | `Avoid
  | `Always
  | `All
  | `Avoid_page
  | `Page
  | `Left
  | `Right
  | `Recto
  | `Verso
  | `Avoid_column
  | `Column
  | `Avoid_region
  | `Region
  ]

and property_break_inside =
  [ `Auto
  | `Avoid
  | `Avoid_page
  | `Avoid_column
  | `Avoid_region
  ]

and property_caption_side =
  [ `Top
  | `Bottom
  | `Block_start
  | `Block_end
  | `Inline_start
  | `Inline_end
  ]

and property_caret_color =
  [ `Auto
  | `Color of color
  ]

and property_clear =
  [ `None
  | `Left
  | `Right
  | `Both
  | `Inline_start
  | `Inline_end
  ]

and property_clip =
  [ `Shape of shape
  | `Auto
  ]

and property_clip_path =
  [ `Clip_source of clip_source
  | `Or of basic_shape option * geometry_box option
  | `None
  ]

and property_clip_rule =
  [ `Nonzero
  | `Evenodd
  ]

and property_color = color

and property_color_interpolation_filters =
  [ `Auto
  | `SRGB
  | `LinearRGB
  ]

and property_color_interpolation =
  [ `Auto
  | `SRGB
  | `LinearRGB
  ]

and property_color_adjust =
  [ `Economy
  | `Exact
  ]

and property_column_count =
  [ `Integer of int
  | `Auto
  ]

and property_column_fill =
  [ `Auto
  | `Balance
  | `Balance_all
  ]

and property_column_gap =
  [ `Normal
  | `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and property_column_rule =
  property_column_rule_width option
  * property_column_rule_style option
  * property_column_rule_color option

and property_column_rule_color = color
and property_column_rule_style = property_border_style
and property_column_rule_width = property_border_width

and property_column_span =
  [ `None
  | `All
  ]

and property_column_width =
  [ `Extended_length of extended_length
  | `Auto
  ]

and property_columns =
  property_column_width option * property_column_count option

and property_contain =
  [ `None
  | `Strict
  | `Content
  | `Or of unit option * unit option * unit option * unit option
  ]

and property_content =
  [ `Normal
  | `None
  | `String of string
  | `Interpolation of string list
  | `Static of
    [ `Content_replacement of content_replacement
    | `Content_list of content_list
    ]
    * (unit * string) option
  ]

and property_content_visibility =
  [ `Visible
  | `Hidden
  | `Auto
  ]

and property_counter_increment =
  [ `Static of (string * int option) list
  | `None
  ]

and property_counter_reset =
  [ `Static of (string * int option) list
  | `None
  ]

and property_counter_set =
  [ `Static of (string * int option) list
  | `None
  ]

and property_cue = property_cue_before * property_cue_after option

and property_cue_after =
  [ `Static of url * unit option
  | `None
  ]

and property_cue_before =
  [ `Static of url * unit option
  | `None
  ]

and property_cursor =
  [ `Auto
  | `Default
  | `None
  | `Context_menu
  | `Help
  | `Pointer
  | `Progress
  | `Wait
  | `Cell
  | `Crosshair
  | `Text
  | `Vertical_text
  | `Alias
  | `Copy
  | `Move
  | `No_drop
  | `Not_allowed
  | `E_resize
  | `N_resize
  | `Ne_resize
  | `Nw_resize
  | `S_resize
  | `Se_resize
  | `Sw_resize
  | `W_resize
  | `Ew_resize
  | `Ns_resize
  | `Nesw_resize
  | `Nwse_resize
  | `Col_resize
  | `Row_resize
  | `All_scroll
  | `Zoom_in
  | `Zoom_out
  | `Grab
  | `Grabbing
  | `Hand
  | `Webkit_grab
  | `Webkit_grabbing
  | `Webkit_zoom_in
  | `Webkit_zoom_out
  | `Moz_grab
  | `Moz_grabbing
  | `Moz_zoom_in
  | `Moz_zoom_out
  | `Interpolation of string list
  ]

and property_direction =
  [ `Ltr
  | `Rtl
  ]

and property_display =
  [ `Block
  | `Contents
  | `Flex
  | `Flow
  | `Flow_root
  | `Grid
  | `Inline
  | `Inline_block
  | `Inline_flex
  | `Inline_grid
  | `Inline_list_item
  | `Inline_table
  | `List_item
  | `None
  | `Ruby
  | `Ruby_base
  | `Ruby_base_container
  | `Ruby_text
  | `Ruby_text_container
  | `Run_in
  | `Table
  | `Table_caption
  | `Table_cell
  | `Table_column
  | `Table_column_group
  | `Table_footer_group
  | `Table_header_group
  | `Table_row
  | `Table_row_group
  | `Webkit_flex
  | `Webkit_inline_flex
  | `Webkit_box
  | `Webkit_inline_box
  | `Moz_inline_stack
  | `Moz_box
  | `Moz_inline_box
  ]

and property_dominant_baseline =
  [ `Auto
  | `Use_script
  | `No_change
  | `Reset_size
  | `Ideographic
  | `Alphabetic
  | `Hanging
  | `Mathematical
  | `Central
  | `Middle
  | `Text_after_edge
  | `Text_before_edge
  ]

and property_empty_cells =
  [ `Show
  | `Hide
  ]

and property_fill = paint
and property_fill_opacity = alpha_value

and property_fill_rule =
  [ `Nonzero
  | `Evenodd
  ]

and property_filter =
  [ `None
  | `Interpolation of string list
  | `Filter_function_list of filter_function_list
  ]

and property_flex =
  [ `None
  | `Or of
    (property_flex_grow * property_flex_shrink option) option
    * property_flex_basis option
  | `Interpolation of string list
  ]

and property_flex_basis =
  [ `Content
  | `Property_width of property_width
  | `Interpolation of string list
  ]

and property_flex_direction =
  [ `Row
  | `Row_reverse
  | `Column
  | `Column_reverse
  ]

and property_flex_flow =
  property_flex_direction option * property_flex_wrap option

and property_flex_grow =
  [ `Number of float
  | `Interpolation of string list
  ]

and property_flex_shrink =
  [ `Number of float
  | `Interpolation of string list
  ]

and property_flex_wrap =
  [ `Nowrap
  | `Wrap
  | `Wrap_reverse
  ]

and property_float =
  [ `Left
  | `Right
  | `None
  | `Inline_start
  | `Inline_end
  ]

and property_font =
  [ `Static of
    (property_font_style option
    * font_variant_css21 option
    * property_font_weight option
    * property_font_stretch option)
    option
    * property_font_size
    * (unit * property_line_height) option
    * property_font_family
  | `Caption
  | `Icon
  | `Menu
  | `Message_box
  | `Small_caption
  | `Status_bar
  ]

and font_families =
  [ `Family_name of family_name
  | `Generic_family of generic_family
  | `Interpolation of string list
  ]
  list

and property_font_family =
  [ `Font_families of font_families
  | `Interpolation of string list
  ]

and property_font_feature_settings =
  [ `Normal
  | `Feature_tag_value of feature_tag_value list
  ]

and property_font_display =
  [ `Auto
  | `Block
  | `Swap
  | `Fallback
  | `Optional
  ]

and property_font_kerning =
  [ `Auto
  | `Normal
  | `None
  ]

and property_font_language_override =
  [ `Normal
  | `String of string
  ]

and property_font_optical_sizing =
  [ `Auto
  | `None
  ]

and property_font_palette =
  [ `Normal
  | `Light
  | `Dark
  ]

and property_font_size =
  [ `Absolute_size of absolute_size
  | `Relative_size of relative_size
  | `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and property_font_size_adjust =
  [ `None
  | `Number of float
  ]

and property_font_smooth =
  [ `Auto
  | `Never
  | `Always
  | `Absolute_size of absolute_size
  | `Extended_length of extended_length
  ]

and property_font_stretch = font_stretch_absolute

and property_font_style =
  [ `Normal
  | `Italic
  | `Oblique
  | `Interpolation of string list
  | `Static of (unit * extended_angle) option
  ]

and property_font_synthesis =
  [ `None
  | `Or of unit option * unit option * unit option * unit option
  ]

and property_font_synthesis_weight =
  [ `Auto
  | `None
  ]

and property_font_synthesis_style =
  [ `Auto
  | `None
  ]

and property_font_synthesis_small_caps =
  [ `Auto
  | `None
  ]

and property_font_synthesis_position =
  [ `Auto
  | `None
  ]

and property_font_variant =
  [ `Normal
  | `None
  | `Small_caps
  | `Or of
    common_lig_values option
    * discretionary_lig_values option
    * historical_lig_values option
    * contextual_alt_values option
    * feature_value_name option
    * unit option
    * feature_value_name list option
    * feature_value_name list option
    * feature_value_name option
    * feature_value_name option
    * feature_value_name option
    * [ `Small_caps
      | `All_small_caps
      | `Petite_caps
      | `All_petite_caps
      | `Unicase
      | `Titling_caps
      ]
      option
    * numeric_figure_values option
    * numeric_spacing_values option
    * numeric_fraction_values option
    * unit option
    * unit option
    * east_asian_variant_values option
    * east_asian_width_values option
    * unit option
    * unit option
    * unit option
    * unit option
    * unit option
    * unit option
  ]

and property_font_variant_alternates =
  [ `Normal
  | `Or of
    feature_value_name option
    * unit option
    * feature_value_name list option
    * feature_value_name list option
    * feature_value_name option
    * feature_value_name option
    * feature_value_name option
  ]

and property_font_variant_caps =
  [ `Normal
  | `Small_caps
  | `All_small_caps
  | `Petite_caps
  | `All_petite_caps
  | `Unicase
  | `Titling_caps
  ]

and property_font_variant_east_asian =
  [ `Normal
  | `Or of
    east_asian_variant_values option
    * east_asian_width_values option
    * unit option
  ]

and property_font_variant_ligatures =
  [ `Normal
  | `None
  | `Or of
    common_lig_values option
    * discretionary_lig_values option
    * historical_lig_values option
    * contextual_alt_values option
  ]

and property_font_variant_numeric =
  [ `Normal
  | `Or of
    numeric_figure_values option
    * numeric_spacing_values option
    * numeric_fraction_values option
    * unit option
    * unit option
  ]

and property_font_variant_position =
  [ `Normal
  | `Sub
  | `Super
  ]

and property_font_variation_settings =
  [ `Normal
  | `Static of (string * float) list
  ]

and property_font_variant_emoji =
  [ `Normal
  | `Text
  | `Emoji
  | `Unicode
  ]

and property_font_weight =
  [ `Font_weight_absolute of font_weight_absolute
  | `Bolder
  | `Lighter
  | `Interpolation of string list
  ]

and property_gap = property_row_gap * property_column_gap option
and property_glyph_orientation_horizontal = extended_angle
and property_glyph_orientation_vertical = extended_angle

and property_grid =
  [ `Property_grid_template of property_grid_template
  | `Static_0 of
    property_grid_template_rows
    * unit
    * (unit * unit option)
    * property_grid_auto_columns option
  | `Static_1 of
    (unit * unit option)
    * property_grid_auto_rows option
    * unit
    * property_grid_template_columns
  ]

and property_grid_area = grid_line * (unit * grid_line) list
and property_grid_auto_columns = track_size list

and property_grid_auto_flow =
  [ `Or of [ `Row | `Column ] option * unit option
  | `Interpolation of string list
  ]

and property_grid_auto_rows = track_size list
and property_grid_column = grid_line * (unit * grid_line) option
and property_grid_column_end = grid_line

and property_grid_column_gap =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and property_grid_column_start = grid_line
and property_grid_gap = property_grid_row_gap * property_grid_column_gap option
and property_grid_row = grid_line * (unit * grid_line) option
and property_grid_row_end = grid_line

and property_grid_row_gap =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and property_grid_row_start = grid_line

and property_grid_template =
  [ `None
  | `Static_0 of
    property_grid_template_rows * unit * property_grid_template_columns
  | `Static_1 of
    (line_names option * string * track_size option * line_names option) list
    * (unit * explicit_track_list) option
  ]

and property_grid_template_areas =
  [ `None
  | `Xor of [ `String of string | `Interpolation of string list ] list
  ]

and property_grid_template_columns =
  [ `None
  | `Track_list of track_list
  | `Auto_track_list of auto_track_list
  | `Static of unit * line_name_list option
  | `Masonry
  | `Interpolation of string list
  ]

and property_grid_template_rows =
  [ `None
  | `Track_list of track_list
  | `Auto_track_list of auto_track_list
  | `Static of unit * line_name_list option
  | `Masonry
  | `Interpolation of string list
  ]

and property_hanging_punctuation =
  [ `None
  | `Or of unit option * [ `Force_end | `Allow_end ] option * unit option
  ]

and property_height =
  [ `Auto
  | `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  | `Min_content
  | `Max_content
  | `Fit_content_0
  | `Fit_content_1 of
    [ `Extended_length of extended_length
    | `Extended_percentage of extended_percentage
    ]
  ]

and property_hyphens =
  [ `None
  | `Manual
  | `Auto
  ]

and property_hyphenate_character =
  [ `Auto
  | `String_token of string
  ]

and property_hyphenate_limit_chars =
  [ `Auto
  | `Integer of int
  ]

and property_hyphenate_limit_lines =
  [ `No_limit
  | `Integer of int
  ]

and property_hyphenate_limit_zone =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and property_image_orientation =
  [ `From_image
  | `Extended_angle of extended_angle
  | `Static of extended_angle option * unit
  ]

and property_image_rendering =
  [ `Auto
  | `Smooth
  | `High_quality
  | `Crisp_edges
  | `Pixelated
  ]

and property_image_resolution = (unit option * resolution option) * unit option

and property_ime_mode =
  [ `Auto
  | `Normal
  | `Active
  | `Inactive
  | `Disabled
  ]

and property_initial_letter =
  [ `Normal
  | `Static of float * int option
  ]

and property_initial_letter_align =
  [ `Auto
  | `Alphabetic
  | `Hanging
  | `Ideographic
  ]

and property_inline_size = property_width
and property_inset = property_top list
and property_inset_block = property_top list
and property_inset_block_end = property_top
and property_inset_block_start = property_top
and property_inset_inline = property_top list
and property_inset_inline_end = property_top
and property_inset_inline_start = property_top

and property_isolation =
  [ `Auto
  | `Isolate
  ]

and property_justify_content =
  [ `Normal
  | `Content_distribution of content_distribution
  | `Static of
    overflow_position option
    * [ `Content_position of content_position | `Left | `Right ]
  ]

and property_justify_items =
  [ `Normal
  | `Stretch
  | `Baseline_position of baseline_position
  | `Static of
    overflow_position option
    * [ `Self_position of self_position | `Left | `Right ]
  | `Legacy
  | `And of unit * [ `Left | `Right | `Center ]
  ]

and property_justify_self =
  [ `Auto
  | `Normal
  | `Stretch
  | `Baseline_position of baseline_position
  | `Static of
    overflow_position option
    * [ `Self_position of self_position | `Left | `Right ]
  ]

and property_kerning =
  [ `Auto
  | `Svg_length of svg_length
  ]

and property_layout_grid =
  [ `Auto
  | `Custom_ident of string
  | `And of int * string option
  ]

and property_layout_grid_char =
  [ `Auto
  | `Custom_ident of string
  | `String of string
  ]

and property_layout_grid_line =
  [ `Auto
  | `Custom_ident of string
  | `String of string
  ]

and property_layout_grid_mode =
  [ `Auto
  | `Custom_ident of string
  | `String of string
  ]

and property_layout_grid_type =
  [ `Auto
  | `Custom_ident of string
  | `String of string
  ]

and property_left =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  | `Auto
  ]

and property_letter_spacing =
  [ `Normal
  | `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and property_line_break =
  [ `Auto
  | `Loose
  | `Normal
  | `Strict
  | `Anywhere
  | `Interpolation of string list
  ]

and property_line_clamp =
  [ `None
  | `Integer of int
  ]

and property_line_height =
  [ `Normal
  | `Number of float
  | `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and property_line_height_step = extended_length

and property_list_style =
  property_list_style_type option
  * property_list_style_position option
  * property_list_style_image option

and property_list_style_image =
  [ `None
  | `Image of image
  ]

and property_list_style_position =
  [ `Inside
  | `Outside
  ]

and property_list_style_type =
  [ `Counter_style of counter_style
  | `String of string
  | `None
  ]

and property_margin =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  | `Auto
  | `Interpolation of string list
  ]
  list

and property_margin_block = property_margin_left list
and property_margin_block_end = property_margin_left
and property_margin_block_start = property_margin_left

and property_margin_bottom =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  | `Auto
  ]

and property_margin_inline = property_margin_left list
and property_margin_inline_end = property_margin_left
and property_margin_inline_start = property_margin_left

and property_margin_left =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  | `Auto
  ]

and property_margin_right =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  | `Auto
  ]

and property_margin_top =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  | `Auto
  ]

and property_margin_trim =
  [ `None
  | `In_flow
  | `All
  ]

and property_marker =
  [ `None
  | `Url of url
  ]

and property_marker_end =
  [ `None
  | `Url of url
  ]

and property_marker_mid =
  [ `None
  | `Url of url
  ]

and property_marker_start =
  [ `None
  | `Url of url
  ]

and property_mask = mask_layer list

and property_mask_border =
  property_mask_border_source option
  * (property_mask_border_slice
    * (unit
      * property_mask_border_width option
      * (unit * property_mask_border_outset) option)
      option)
    option
  * property_mask_border_repeat option
  * property_mask_border_mode option

and property_mask_border_mode =
  [ `Luminance
  | `Alpha
  ]

and property_mask_border_outset =
  [ `Extended_length of extended_length | `Number of float ] list

and property_mask_border_repeat = [ `Stretch | `Repeat | `Round | `Space ] list
and property_mask_border_slice = number_percentage list * unit option

and property_mask_border_source =
  [ `None
  | `Image of image
  ]

and property_mask_border_width =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  | `Number of float
  | `Auto
  ]
  list

and property_mask_clip = [ `Geometry_box of geometry_box | `No_clip ] list
and property_mask_composite = compositing_operator list
and property_mask_image = mask_reference list
and property_mask_mode = masking_mode list
and property_mask_origin = geometry_box list
and property_mask_position = position list
and property_mask_repeat = repeat_style list
and property_mask_size = bg_size list

and property_mask_type =
  [ `Luminance
  | `Alpha
  ]

and property_masonry_auto_flow =
  [ `Pack | `Next ] option * [ `Definite_first | `Ordered ] option

and property_max_block_size = property_max_width

and property_max_height =
  [ `Auto
  | `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  | `Min_content
  | `Max_content
  | `Fit_content_0
  | `Fit_content_1 of
    [ `Extended_length of extended_length
    | `Extended_percentage of extended_percentage
    ]
  ]

and property_max_inline_size = property_max_width

and property_max_lines =
  [ `None
  | `Integer of int
  ]

and property_max_width =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  | `None
  | `Max_content
  | `Min_content
  | `Fit_content_0
  | `Fit_content_1 of
    [ `Extended_length of extended_length
    | `Extended_percentage of extended_percentage
    ]
  | `Fill_available
  | `Non_standard_width of non_standard_width
  ]

and property_min_block_size = property_min_width

and property_min_height =
  [ `Auto
  | `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  | `Min_content
  | `Max_content
  | `Fit_content_0
  | `Fit_content_1 of
    [ `Extended_length of extended_length
    | `Extended_percentage of extended_percentage
    ]
  ]

and property_min_inline_size = property_min_width

and property_min_width =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  | `Auto
  | `Max_content
  | `Min_content
  | `Fit_content_0
  | `Fit_content_1 of
    [ `Extended_length of extended_length
    | `Extended_percentage of extended_percentage
    ]
  | `Fill_available
  | `Non_standard_width of non_standard_width
  ]

and property_mix_blend_mode = blend_mode

and property_media_any_hover =
  [ `None
  | `Hover
  ]

and property_media_any_pointer =
  [ `None
  | `Coarse
  | `Fine
  ]

and property_media_pointer =
  [ `None
  | `Coarse
  | `Fine
  ]

and property_media_max_aspect_ratio = ratio
and property_media_min_aspect_ratio = ratio
and property_media_min_color = int

and property_media_color_gamut =
  [ `Srgb
  | `P3
  | `Rec2020
  ]

and property_media_color_index = int
and property_media_min_color_index = int

and property_media_display_mode =
  [ `Fullscreen
  | `Standalone
  | `Minimal_ui
  | `Browser
  ]

and property_media_forced_colors =
  [ `None
  | `Active
  ]

and property_forced_color_adjust =
  [ `Auto
  | `None
  | `Preserve_parent_color
  ]

and property_media_grid = int

and property_media_hover =
  [ `Hover
  | `None
  ]

and property_media_inverted_colors =
  [ `Inverted
  | `None
  ]

and property_media_monochrome = int

and property_media_prefers_color_scheme =
  [ `Dark
  | `Light
  ]

and property_color_scheme =
  [ `Normal
  | `And of [ `Dark | `Light | `Custom_ident of string ] list * unit option
  ]

and property_media_prefers_contrast =
  [ `No_preference
  | `More
  | `Less
  ]

and property_media_prefers_reduced_motion =
  [ `No_preference
  | `Reduce
  ]

and property_media_resolution = resolution
and property_media_min_resolution = resolution
and property_media_max_resolution = resolution

and property_media_scripting =
  [ `None
  | `Initial_only
  | `Enabled
  ]

and property_media_update =
  [ `None
  | `Slow
  | `Fast
  ]

and property_media_orientation =
  [ `Portrait
  | `Landscape
  ]

and property_object_fit =
  [ `Fill
  | `Contain
  | `Cover
  | `None
  | `Scale_down
  ]

and property_object_position =
  [ `Position of position
  | `Inherit
  | `Initial
  | `Unset
  | `Revert
  | `Revert_layer
  ]

and property_offset =
  (property_offset_position option
  * (property_offset_path
    * (property_offset_distance option * property_offset_rotate option) option)
    option)
  option
  * (unit * property_offset_anchor) option

and property_offset_anchor =
  [ `Auto
  | `Position of position
  ]

and property_offset_distance =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and property_offset_path =
  [ `None
  | `Ray of extended_angle * ray_size option * unit option
  | `Function_path of function_path
  | `Url of url
  | `Or of basic_shape option * geometry_box option
  ]

and property_offset_position =
  [ `Auto
  | `Position of position
  ]

and property_offset_rotate = [ `Auto | `Reverse ] option * extended_angle option
and property_opacity = alpha_value
and property_order = int
and property_orphans = int

and property_outline =
  [ `None
  | `Property_outline_width of property_outline_width
  | `Static_0 of property_outline_width * property_outline_style
  | `Static_1 of
    property_outline_width
    * property_outline_style
    * [ `Color of color | `Interpolation of string list ]
  ]

and property_outline_color = color
and property_outline_offset = extended_length

and property_outline_style =
  [ `Auto
  | `Line_style of line_style
  | `Interpolation of string list
  ]

and property_outline_width =
  [ `Line_width of line_width
  | `Interpolation of string list
  ]

and property_overflow =
  [ `Xor of [ `Visible | `Hidden | `Clip | `Scroll | `Auto ] list
  | `Non_standard_overflow of non_standard_overflow
  | `Interpolation of string list
  ]

and property_overflow_anchor =
  [ `Auto
  | `None
  ]

and property_overflow_block =
  [ `Visible
  | `Hidden
  | `Clip
  | `Scroll
  | `Auto
  | `Interpolation of string list
  ]

and property_overflow_clip_margin = visual_box option * extended_length option

and property_overflow_inline =
  [ `Visible
  | `Hidden
  | `Clip
  | `Scroll
  | `Auto
  | `Interpolation of string list
  ]

and property_overflow_wrap =
  [ `Normal
  | `Break_word
  | `Anywhere
  ]

and property_overflow_x =
  [ `Visible
  | `Hidden
  | `Clip
  | `Scroll
  | `Auto
  | `Interpolation of string list
  ]

and property_overflow_y =
  [ `Visible
  | `Hidden
  | `Clip
  | `Scroll
  | `Auto
  | `Interpolation of string list
  ]

and property_overscroll_behavior = [ `Contain | `None | `Auto ] list

and property_overscroll_behavior_block =
  [ `Contain
  | `None
  | `Auto
  ]

and property_overscroll_behavior_inline =
  [ `Contain
  | `None
  | `Auto
  ]

and property_overscroll_behavior_x =
  [ `Contain
  | `None
  | `Auto
  ]

and property_overscroll_behavior_y =
  [ `Contain
  | `None
  | `Auto
  ]

and property_padding =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  | `Interpolation of string list
  ]
  list

and property_padding_block = property_padding_left list
and property_padding_block_end = property_padding_left
and property_padding_block_start = property_padding_left

and property_padding_bottom =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and property_padding_inline = property_padding_left list
and property_padding_inline_end = property_padding_left
and property_padding_inline_start = property_padding_left

and property_padding_left =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and property_padding_right =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and property_padding_top =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and property_page_break_after =
  [ `Auto
  | `Always
  | `Avoid
  | `Left
  | `Right
  | `Recto
  | `Verso
  ]

and property_page_break_before =
  [ `Auto
  | `Always
  | `Avoid
  | `Left
  | `Right
  | `Recto
  | `Verso
  ]

and property_page_break_inside =
  [ `Auto
  | `Avoid
  ]

and property_paint_order =
  [ `Normal
  | `Or of unit option * unit option * unit option
  ]

and property_pause = property_pause_before * property_pause_after option

and property_pause_after =
  [ `Extended_time of extended_time
  | `None
  | `X_weak
  | `Weak
  | `Medium
  | `Strong
  | `X_strong
  ]

and property_pause_before =
  [ `Extended_time of extended_time
  | `None
  | `X_weak
  | `Weak
  | `Medium
  | `Strong
  | `X_strong
  ]

and property_perspective =
  [ `None
  | `Extended_length of extended_length
  ]

and property_perspective_origin = position

and property_place_content =
  property_align_content * property_justify_content option

and property_place_items = property_align_items * property_justify_items option
and property_place_self = property_align_self * property_justify_self option

and property_pointer_events =
  [ `Auto
  | `None
  | `VisiblePainted
  | `VisibleFill
  | `VisibleStroke
  | `Visible
  | `Painted
  | `Fill
  | `Stroke
  | `All
  | `Inherit
  ]

and property_position =
  [ `Static
  | `Relative
  | `Absolute
  | `Sticky
  | `Fixed
  | `Webkit_sticky
  ]

and property_quotes =
  [ `None
  | `Auto
  | `Static of (string * string) list
  ]

and property_resize =
  [ `None
  | `Both
  | `Horizontal
  | `Vertical
  | `Block
  | `Inline
  ]

and property_rest = property_rest_before * property_rest_after option

and property_rest_after =
  [ `Extended_time of extended_time
  | `None
  | `X_weak
  | `Weak
  | `Medium
  | `Strong
  | `X_strong
  ]

and property_rest_before =
  [ `Extended_time of extended_time
  | `None
  | `X_weak
  | `Weak
  | `Medium
  | `Strong
  | `X_strong
  ]

and property_right =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  | `Auto
  ]

and property_rotate =
  [ `None
  | `Extended_angle of extended_angle
  | `And of [ `X | `Y | `Z | `Number of float list ] * extended_angle
  ]

and property_row_gap =
  [ `Normal
  | `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and property_ruby_align =
  [ `Start
  | `Center
  | `Space_between
  | `Space_around
  ]

and property_ruby_merge =
  [ `Separate
  | `Collapse
  | `Auto
  ]

and property_ruby_position =
  [ `Over
  | `Under
  | `Inter_character
  ]

and property_scale =
  [ `None
  | `Number_percentage of number_percentage list
  ]

and property_scroll_behavior =
  [ `Auto
  | `Smooth
  ]

and property_scroll_margin = extended_length list
and property_scroll_margin_block = extended_length list
and property_scroll_margin_block_end = extended_length
and property_scroll_margin_block_start = extended_length
and property_scroll_margin_bottom = extended_length
and property_scroll_margin_inline = extended_length list
and property_scroll_margin_inline_end = extended_length
and property_scroll_margin_inline_start = extended_length
and property_scroll_margin_left = extended_length
and property_scroll_margin_right = extended_length
and property_scroll_margin_top = extended_length

and property_scroll_padding =
  [ `Auto
  | `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]
  list

and property_scroll_padding_block =
  [ `Auto
  | `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]
  list

and property_scroll_padding_block_end =
  [ `Auto
  | `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and property_scroll_padding_block_start =
  [ `Auto
  | `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and property_scroll_padding_bottom =
  [ `Auto
  | `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and property_scroll_padding_inline =
  [ `Auto
  | `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]
  list

and property_scroll_padding_inline_end =
  [ `Auto
  | `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and property_scroll_padding_inline_start =
  [ `Auto
  | `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and property_scroll_padding_left =
  [ `Auto
  | `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and property_scroll_padding_right =
  [ `Auto
  | `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and property_scroll_padding_top =
  [ `Auto
  | `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and property_scroll_snap_align = [ `None | `Start | `End | `Center ] list

and property_scroll_snap_coordinate =
  [ `None
  | `Position of position list
  ]

and property_scroll_snap_destination = position

and property_scroll_snap_points_x =
  [ `None
  | `Repeat of
    [ `Extended_length of extended_length
    | `Extended_percentage of extended_percentage
    ]
  ]

and property_scroll_snap_points_y =
  [ `None
  | `Repeat of
    [ `Extended_length of extended_length
    | `Extended_percentage of extended_percentage
    ]
  ]

and property_scroll_snap_stop =
  [ `Normal
  | `Always
  ]

and property_scroll_snap_type =
  [ `None
  | `Static of
    [ `X | `Y | `Block | `Inline | `Both ] * [ `Mandatory | `Proximity ] option
  ]

and property_scroll_snap_type_x =
  [ `None
  | `Mandatory
  | `Proximity
  ]

and property_scroll_snap_type_y =
  [ `None
  | `Mandatory
  | `Proximity
  ]

and property_scrollbar_color =
  [ `Auto
  | `Static of color * color
  ]

and property_scrollbar_width =
  [ `Auto
  | `Thin
  | `None
  ]

and property_scrollbar_gutter =
  [ `Auto
  | `And of unit * unit option
  ]

and property_scrollbar_3dlight_color = color
and property_scrollbar_arrow_color = color
and property_scrollbar_base_color = color
and property_scrollbar_darkshadow_color = color
and property_scrollbar_face_color = color
and property_scrollbar_highlight_color = color
and property_scrollbar_shadow_color = color
and property_scrollbar_track_color = color
and property_shape_image_threshold = alpha_value

and property_shape_margin =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and property_shape_outside =
  [ `None
  | `Or of shape_box option * basic_shape option
  | `Image of image
  ]

and property_shape_rendering =
  [ `Auto
  | `OptimizeSpeed
  | `CrispEdges
  | `GeometricPrecision
  ]

and property_speak =
  [ `Auto
  | `None
  | `Normal
  ]

and property_speak_as =
  [ `Normal
  | `Or of
    unit option
    * unit option
    * [ `Literal_punctuation | `No_punctuation ] option
  ]

and property_src =
  [ `Static of url * string list option | `Local of family_name ] list

and property_stroke = paint

and property_stroke_dasharray =
  [ `None
  | `Svg_length of svg_length list list
  ]

and property_stroke_dashoffset = svg_length

and property_stroke_linecap =
  [ `Butt
  | `Round
  | `Square
  ]

and property_stroke_linejoin =
  [ `Miter
  | `Round
  | `Bevel
  ]

and property_stroke_miterlimit = number_one_or_greater
and property_stroke_opacity = alpha_value
and property_stroke_width = svg_length

and property_tab_size =
  [ `Number of float
  | `Extended_length of extended_length
  ]

and property_table_layout =
  [ `Auto
  | `Fixed
  ]

and property_text_autospace =
  [ `None
  | `Ideograph_alpha
  | `Ideograph_numeric
  | `Ideograph_parenthesis
  | `Ideograph_space
  ]

and property_text_blink =
  [ `None
  | `Blink
  | `Blink_anywhere
  ]

and property_text_align =
  [ `Start
  | `End
  | `Left
  | `Right
  | `Center
  | `Justify
  | `Match_parent
  | `Justify_all
  ]

and property_text_align_all =
  [ `Start
  | `End
  | `Left
  | `Right
  | `Center
  | `Justify
  | `Match_parent
  ]

and property_text_align_last =
  [ `Auto
  | `Start
  | `End
  | `Left
  | `Right
  | `Center
  | `Justify
  | `Match_parent
  ]

and property_text_anchor =
  [ `Start
  | `Middle
  | `End
  ]

and property_text_combine_upright =
  [ `None
  | `All
  | `Static of unit * int option
  ]

and property_text_decoration =
  property_text_decoration_color option
  * property_text_decoration_style option
  * property_text_decoration_thickness option
  * property_text_decoration_line option

and property_text_justify_trim =
  [ `None
  | `All
  | `Auto
  ]

and property_text_kashida =
  [ `None
  | `Horizontal
  | `Vertical
  | `Both
  ]

and property_text_kashida_space =
  [ `Normal
  | `Pre
  | `Post
  ]

and property_text_decoration_color = color

and property_text_decoration_line =
  [ `None
  | `Interpolation of string list
  | `Or of unit option * unit option * unit option * unit option
  ]

and property_text_decoration_skip =
  [ `None
  | `Or of
    unit option
    * [ `Spaces | `Or of unit option * unit option ] option
    * unit option
    * unit option
  ]

and property_text_decoration_skip_self =
  [ `None
  | `Or of
    unit option
    * [ `Spaces | `Or of unit option * unit option ] option
    * unit option
    * unit option
  ]

and property_text_decoration_skip_ink =
  [ `Auto
  | `All
  | `None
  ]

and property_text_decoration_skip_box =
  [ `None
  | `All
  ]

and property_text_decoration_skip_spaces =
  [ `None
  | `Or of
    unit option
    * [ `Spaces | `Or of unit option * unit option ] option
    * unit option
    * unit option
  ]

and property_text_decoration_skip_inset =
  [ `None
  | `Auto
  ]

and property_text_decoration_style =
  [ `Solid
  | `Double
  | `Dotted
  | `Dashed
  | `Wavy
  ]

and property_text_decoration_thickness =
  [ `Auto
  | `From_font
  | `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and property_text_emphasis =
  property_text_emphasis_style option * property_text_emphasis_color option

and property_text_emphasis_color = color

and property_text_emphasis_position =
  [ `Over | `Under ] * [ `Right | `Left ] option

and property_text_emphasis_style =
  [ `None
  | `Or of
    [ `Filled | `Open ] option
    * [ `Dot | `Circle | `Double_circle | `Triangle | `Sesame ] option
  | `String of string
  ]

and property_text_indent =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]
  * unit option
  * unit option

and property_text_justify =
  [ `Auto
  | `Inter_character
  | `Inter_word
  | `None
  ]

and property_text_orientation =
  [ `Mixed
  | `Upright
  | `Sideways
  ]

and property_text_overflow = [ `Clip | `Ellipsis | `String of string ] list

and property_text_rendering =
  [ `Auto
  | `OptimizeSpeed
  | `OptimizeLegibility
  | `GeometricPrecision
  ]

and property_text_shadow =
  [ `None
  | `Interpolation of string list
  | `Shadow_t of shadow_t list
  ]

and property_text_size_adjust =
  [ `None
  | `Auto
  | `Extended_percentage of extended_percentage
  ]

and property_text_transform =
  [ `None
  | `Capitalize
  | `Uppercase
  | `Lowercase
  | `Full_width
  | `Full_size_kana
  ]

and property_text_underline_offset =
  [ `Auto
  | `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and property_text_underline_position =
  [ `Auto
  | `From_font
  | `Or of unit option * [ `Left | `Right ] option
  ]

and property_top =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  | `Auto
  ]

and property_touch_action =
  [ `Auto
  | `None
  | `Or of
    [ `Pan_x | `Pan_left | `Pan_right ] option
    * [ `Pan_y | `Pan_up | `Pan_down ] option
    * unit option
  | `Manipulation
  ]

and property_transform =
  [ `None
  | `Transform_list of transform_list
  ]

and property_transform_box =
  [ `Content_box
  | `Border_box
  | `Fill_box
  | `Stroke_box
  | `View_box
  ]

and property_transform_origin =
  [ `Xor of
    [ `Left
    | `Center
    | `Right
    | `Top
    | `Bottom
    | `Length_percentage of length_percentage
    ]
  | `Static_0 of
    [ `Left | `Center | `Right | `Length_percentage of length_percentage ]
    * [ `Top | `Center | `Bottom | `Length_percentage of length_percentage ]
    * length option
  | `Static_1 of
    ([ `Center | `Left | `Right ] * [ `Center | `Top | `Bottom ])
    * length option
  ]

and property_transform_style =
  [ `Flat
  | `Preserve_3d
  ]

and property_transition =
  [ `Single_transition of single_transition
  | `Single_transition_no_interp of single_transition_no_interp
  ]
  list

and property_transition_behavior = transition_behavior_value list
and property_transition_delay = extended_time list
and property_transition_duration = extended_time list

and property_transition_property =
  [ `Single_transition_property of single_transition_property list
  | `None
  ]

and property_transition_timing_function = timing_function list

and property_translate =
  [ `None
  | `Static of length_percentage * (length_percentage * length option) option
  ]

and property_unicode_bidi =
  [ `Normal
  | `Embed
  | `Isolate
  | `Bidi_override
  | `Isolate_override
  | `Plaintext
  | `Moz_isolate
  | `Moz_isolate_override
  | `Moz_plaintext
  | `Webkit_isolate
  ]

and property_unicode_range = unit list

and property_user_select =
  [ `Auto
  | `Text
  | `None
  | `Contain
  | `All
  | `Interpolation of string list
  ]

and property_vertical_align =
  [ `Baseline
  | `Sub
  | `Super
  | `Text_top
  | `Text_bottom
  | `Middle
  | `Top
  | `Bottom
  | `Extended_percentage of extended_percentage
  | `Extended_length of extended_length
  ]

and property_visibility =
  [ `Visible
  | `Hidden
  | `Collapse
  | `Interpolation of string list
  ]

and property_voice_balance =
  [ `Number of float
  | `Left
  | `Center
  | `Right
  | `Leftwards
  | `Rightwards
  ]

and property_voice_duration =
  [ `Auto
  | `Extended_time of extended_time
  ]

and property_voice_family =
  [ `Static of
    ([ `Family_name of family_name | `Generic_voice of generic_voice ] * unit)
    list
    * [ `Family_name of family_name | `Generic_voice of generic_voice ]
  | `Preserve
  ]

and property_voice_pitch =
  [ `And of extended_frequency * unit
  | `Or of
    [ `X_low | `Low | `Medium | `High | `X_high ] option
    * [ `Extended_frequency of extended_frequency
      | `Semitones of unit
      | `Extended_percentage of extended_percentage
      ]
      option
  ]

and property_voice_range =
  [ `And of extended_frequency * unit
  | `Or of
    [ `X_low | `Low | `Medium | `High | `X_high ] option
    * [ `Extended_frequency of extended_frequency
      | `Semitones of unit
      | `Extended_percentage of extended_percentage
      ]
      option
  ]

and property_voice_rate =
  [ `Normal | `X_slow | `Slow | `Medium | `Fast | `X_fast ] option
  * extended_percentage option

and property_voice_stress =
  [ `Normal
  | `Strong
  | `Moderate
  | `None
  | `Reduced
  ]

and property_voice_volume =
  [ `Silent
  | `Or of [ `X_soft | `Soft | `Medium | `Loud | `X_loud ] option * unit option
  ]

and property_white_space =
  [ `Normal
  | `Pre
  | `Nowrap
  | `Pre_wrap
  | `Pre_line
  | `Break_spaces
  ]

and property_widows = int

and property_width =
  [ `Auto
  | `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  | `Min_content
  | `Max_content
  | `Fit_content_0
  | `Fit_content_1 of
    [ `Extended_length of extended_length
    | `Extended_percentage of extended_percentage
    ]
  ]

and property_will_change =
  [ `Auto
  | `Animateable_feature of animateable_feature list
  ]

and property_word_break =
  [ `Normal
  | `Break_all
  | `Keep_all
  | `Break_word
  ]

and property_word_spacing =
  [ `Normal
  | `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and property_word_wrap =
  [ `Normal
  | `Break_word
  | `Anywhere
  ]

and property_writing_mode =
  [ `Horizontal_tb
  | `Vertical_rl
  | `Vertical_lr
  | `Sideways_rl
  | `Sideways_lr
  | `Svg_writing_mode of svg_writing_mode
  ]

and property_z_index =
  [ `Auto
  | `Integer of int
  | `Interpolation of string list
  ]

and property_zoom =
  [ `Normal
  | `Reset
  | `Number of float
  | `Extended_percentage of extended_percentage
  ]

and property_container =
  property_container_name * (unit * property_container_type) option

and property_container_name =
  [ `Custom_ident of string list
  | `None
  ]

and property_container_type =
  [ `Normal
  | `Size
  | `Inline_size
  ]

and property_nav_down =
  [ `Auto
  | `Integer of int
  | `Interpolation of string list
  ]

and property_nav_left =
  [ `Auto
  | `Integer of int
  | `Interpolation of string list
  ]

and property_nav_right =
  [ `Auto
  | `Integer of int
  | `Interpolation of string list
  ]

and property_nav_up =
  [ `Auto
  | `Integer of int
  | `Interpolation of string list
  ]

and property_accent_color =
  [ `Auto
  | `Color of color
  ]

and property_animation_composition = [ `Replace | `Add | `Accumulate ] list

and property_animation_range =
  [ `Normal
  | `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]
  list

and property_animation_range_end =
  [ `Normal
  | `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and property_animation_range_start =
  [ `Normal
  | `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and property_animation_timeline = [ `None | `Custom_ident of string ] list

and property_field_sizing =
  [ `Content
  | `Fixed
  ]

and property_interpolate_size =
  [ `Numeric_only
  | `Allow_keywords
  ]

and property_media_type = string

and property_overlay =
  [ `None
  | `Auto
  ]

and property_scroll_timeline =
  [ `None | `Custom_ident of string ] list * [ `Block | `Inline | `X | `Y ] list

and property_scroll_timeline_axis = [ `Block | `Inline | `X | `Y ] list
and property_scroll_timeline_name = [ `None | `Custom_ident of string ] list

and property_text_wrap =
  [ `Wrap
  | `Nowrap
  | `Balance
  | `Stable
  | `Pretty
  ]

and property_view_timeline =
  [ `None | `Custom_ident of string ] list * [ `Block | `Inline | `X | `Y ] list

and property_view_timeline_axis = [ `Block | `Inline | `X | `Y ] list

and property_view_timeline_inset =
  [ `Auto
  | `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]
  list

and property_view_timeline_name = [ `None | `Custom_ident of string ] list

and property_view_transition_name =
  [ `None
  | `Custom_ident of string
  ]

and property_anchor_name =
  [ `None
  | `Dashed_ident of string list
  ]

and property_anchor_scope =
  [ `None
  | `All
  | `Dashed_ident of string list
  ]

and property_position_anchor =
  [ `Auto
  | `Dashed_ident of string
  ]

and property_position_area =
  [ `None
  | `Xor of
    [ `Top
    | `Bottom
    | `Left
    | `Right
    | `Center
    | `Self_start
    | `Self_end
    | `Start
    | `End
    ]
  ]

and property_position_try =
  [ `None
  | `Xor of [ `Dashed_ident of string | `Try_tactic of try_tactic ] list
  ]

and property_position_try_fallbacks =
  [ `None
  | `Xor of [ `Dashed_ident of string | `Try_tactic of try_tactic ] list
  ]

and property_position_try_options =
  [ `None
  | `Or of unit option * unit option * unit option
  ]

and property_position_visibility =
  [ `Always
  | `Anchors_valid
  | `Anchors_visible
  | `No_overflow
  ]

and property_inset_area =
  [ `None
  | `Xor of
    [ `Top
    | `Bottom
    | `Left
    | `Right
    | `Center
    | `Self_start
    | `Self_end
    | `Start
    | `End
    ]
    list
  ]

and property_scroll_start =
  [ `Auto
  | `Start
  | `End
  | `Center
  | `Top
  | `Bottom
  | `Left
  | `Right
  | `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and property_scroll_start_block =
  [ `Auto
  | `Start
  | `End
  | `Center
  | `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and property_scroll_start_inline =
  [ `Auto
  | `Start
  | `End
  | `Center
  | `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and property_scroll_start_x =
  [ `Auto
  | `Start
  | `End
  | `Center
  | `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and property_scroll_start_y =
  [ `Auto
  | `Start
  | `End
  | `Center
  | `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and property_scroll_start_target =
  [ `None
  | `Auto
  ]

and property_scroll_start_target_block =
  [ `None
  | `Auto
  ]

and property_scroll_start_target_inline =
  [ `None
  | `Auto
  ]

and property_scroll_start_target_x =
  [ `None
  | `Auto
  ]

and property_scroll_start_target_y =
  [ `None
  | `Auto
  ]

and property_text_spacing_trim =
  [ `Normal
  | `Space_all
  | `Space_first
  | `Trim_start
  ]

and property_word_space_transform =
  [ `None
  | `Auto
  | `Ideograph_alpha
  | `Ideograph_numeric
  ]

and property_reading_flow =
  [ `Normal
  | `Flex_visual
  | `Flex_flow
  | `Grid_rows
  | `Grid_columns
  | `Grid_order
  ]

and property_math_depth =
  [ `Auto_add
  | `Static of unit * int * unit
  | `Integer of int
  ]

and property_math_shift =
  [ `Normal
  | `Compact
  ]

and property_math_style =
  [ `Normal
  | `Compact
  ]

and property_text_wrap_mode =
  [ `Wrap
  | `Nowrap
  ]

and property_text_wrap_style =
  [ `Auto
  | `Balance
  | `Stable
  | `Pretty
  ]

and property_white_space_collapse =
  [ `Collapse
  | `Preserve
  | `Preserve_breaks
  | `Preserve_spaces
  | `Break_spaces
  ]

and property_text_box_trim =
  [ `None
  | `Trim_start
  | `Trim_end
  | `Trim_both
  ]

and property_text_box_edge =
  [ `Leading
  | `Text
  | `Cap
  | `Ex
  | `Alphabetic
  ]

and property_page =
  [ `Auto
  | `Custom_ident of string
  ]

and property_size =
  [ `Extended_length of extended_length list
  | `Auto
  | `Static of
    [ `A5
    | `A4
    | `A3
    | `B5
    | `B4
    | `JIS_B5
    | `JIS_B4
    | `Letter
    | `Legal
    | `Ledger
    ]
    * [ `Portrait | `Landscape ] option
  ]

and property_marks =
  [ `None
  | `Or of unit option * unit option
  ]

and property_bleed =
  [ `Auto
  | `Extended_length of extended_length
  ]

and property_backdrop_blur = extended_length
and property_scrollbar_color_legacy = color
and property_stop_color = color
and property_stop_opacity = alpha_value
and property_flood_color = color
and property_flood_opacity = alpha_value
and property_lighting_color = color

and property_color_rendering =
  [ `Auto
  | `OptimizeSpeed
  | `OptimizeQuality
  ]

and property_vector_effect =
  [ `None
  | `Non_scaling_stroke
  ]

and property_cx =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and property_cy =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and property_d =
  [ `None
  | `String of string
  ]

and property_r =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and property_rx =
  [ `Auto
  | `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and property_ry =
  [ `Auto
  | `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and property_x =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and property_y =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and property_contain_intrinsic_size =
  [ `None
  | `Static of unit option * extended_length list
  ]

and property_contain_intrinsic_width =
  [ `None
  | `Static of unit * extended_length
  | `Extended_length of extended_length
  ]

and property_contain_intrinsic_height =
  [ `None
  | `Static of unit * extended_length
  | `Extended_length of extended_length
  ]

and property_contain_intrinsic_block_size =
  [ `None
  | `Static of unit * extended_length
  | `Extended_length of extended_length
  ]

and property_contain_intrinsic_inline_size =
  [ `None
  | `Static of unit * extended_length
  | `Extended_length of extended_length
  ]

and property_print_color_adjust =
  [ `Economy
  | `Exact
  ]

and property_ruby_overhang =
  [ `Auto
  | `None
  ]

and property_timeline_scope =
  [ `None | `Custom_ident of string | `Dashed_ident of string ] list

and property_animation_delay_end = extended_time list
and property_animation_delay_start = extended_time list
and property_syntax = string

and property_inherits =
  [ `True
  | `False
  ]

and property_initial_value = string

and property_scroll_marker_group =
  [ `None
  | `Before
  | `After
  ]

and property_container_name_computed =
  [ `None
  | `Custom_ident of string list
  ]

and property_text_edge =
  [ `Leading | `Property_text_box_edge of property_text_box_edge ] list

and property_hyphenate_limit_last =
  [ `None
  | `Always
  | `Column
  | `Page
  | `Spread
  ]

and pseudo_class_selector =
  [ `Static_0 of unit * string
  | `Static_1 of unit * unit * unit * unit
  ]

and pseudo_element_selector = unit * pseudo_class_selector
and pseudo_page = unit * [ `Left | `Right | `First | `Blank ]

and quote =
  [ `Open_quote
  | `Close_quote
  | `No_open_quote
  | `No_close_quote
  ]

and relative_selector = combinator option * complex_selector
and relative_selector_list = relative_selector list

and relative_size =
  [ `Larger
  | `Smaller
  ]

and repeat_style =
  [ `Repeat_x
  | `Repeat_y
  | `Static of
    [ `Repeat | `Space | `Round | `No_repeat ]
    * [ `Repeat | `Space | `Round | `No_repeat ] option
  ]

and right =
  [ `Extended_length of extended_length
  | `Auto
  ]

and self_position =
  [ `Center
  | `Start
  | `End
  | `Self_start
  | `Self_end
  | `Flex_start
  | `Flex_end
  ]

and shadow =
  unit option
  * [ `Extended_length of extended_length | `Interpolation of string list ] list
  * [ `Color of color | `Interpolation of string list ] option

and shadow_t =
  [ `Extended_length of extended_length | `Interpolation of string list ] list
  * [ `Color of color | `Interpolation of string list ] option

and shape =
  [ `Rect_0 of top * unit * right * unit * bottom * unit * left
  | `Rect_1 of top * right * bottom * left
  ]

and shape_box =
  [ `Box of box
  | `Margin_box
  ]

and shape_radius =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  | `Closest_side
  | `Farthest_side
  ]

and side_or_corner = [ `Left | `Right ] option * [ `Top | `Bottom ] option

and single_animation =
  [ `Xor of
    [ `Keyframes_name of keyframes_name
    | `None
    | `Interpolation of string list
    ]
  | `Static_0 of
    [ `Keyframes_name of keyframes_name
    | `None
    | `Interpolation of string list
    ]
    * extended_time
  | `Static_1 of
    [ `Keyframes_name of keyframes_name
    | `None
    | `Interpolation of string list
    ]
    * extended_time
    * timing_function
  | `Static_2 of
    [ `Keyframes_name of keyframes_name
    | `None
    | `Interpolation of string list
    ]
    * extended_time
    * timing_function
    * extended_time
  | `Static_3 of
    [ `Keyframes_name of keyframes_name
    | `None
    | `Interpolation of string list
    ]
    * extended_time
    * timing_function
    * extended_time
    * single_animation_iteration_count
  | `Static_4 of
    [ `Keyframes_name of keyframes_name
    | `None
    | `Interpolation of string list
    ]
    * extended_time
    * timing_function
    * extended_time
    * single_animation_iteration_count
    * single_animation_direction
  | `Static_5 of
    [ `Keyframes_name of keyframes_name
    | `None
    | `Interpolation of string list
    ]
    * extended_time
    * timing_function
    * extended_time
    * single_animation_iteration_count
    * single_animation_direction
    * single_animation_fill_mode
  | `Static_6 of
    [ `Keyframes_name of keyframes_name
    | `None
    | `Interpolation of string list
    ]
    * extended_time
    * timing_function
    * extended_time
    * single_animation_iteration_count
    * single_animation_direction
    * single_animation_fill_mode
    * single_animation_play_state
  ]

and single_animation_no_interp =
  [ `Keyframes_name of keyframes_name | `None ] option
  * extended_time_no_interp option
  * timing_function_no_interp option
  * extended_time_no_interp option
  * single_animation_iteration_count_no_interp option
  * single_animation_direction_no_interp option
  * single_animation_fill_mode_no_interp option
  * single_animation_play_state_no_interp option

and single_animation_direction =
  [ `Normal
  | `Reverse
  | `Alternate
  | `Alternate_reverse
  | `Interpolation of string list
  ]

and single_animation_direction_no_interp =
  [ `Normal
  | `Reverse
  | `Alternate
  | `Alternate_reverse
  ]

and single_animation_fill_mode =
  [ `None
  | `Forwards
  | `Backwards
  | `Both
  | `Interpolation of string list
  ]

and single_animation_fill_mode_no_interp =
  [ `None
  | `Forwards
  | `Backwards
  | `Both
  ]

and single_animation_iteration_count =
  [ `Infinite
  | `Number of float
  | `Interpolation of string list
  ]

and single_animation_iteration_count_no_interp =
  [ `Infinite
  | `Number of float
  ]

and single_animation_play_state =
  [ `Running
  | `Paused
  | `Interpolation of string list
  ]

and single_animation_play_state_no_interp =
  [ `Running
  | `Paused
  ]

and single_transition_no_interp =
  [ `Single_transition_property_no_interp of
    single_transition_property_no_interp
  | `None
  ]
  option
  * extended_time_no_interp option
  * timing_function_no_interp option
  * extended_time_no_interp option
  * transition_behavior_value_no_interp option

and single_transition =
  [ `Xor of
    [ `Single_transition_property of single_transition_property | `None ]
  | `Static_0 of
    [ `Single_transition_property of single_transition_property | `None ]
    * extended_time
  | `Static_1 of
    [ `Single_transition_property of single_transition_property | `None ]
    * extended_time
    * timing_function
  | `Static_2 of
    [ `Single_transition_property of single_transition_property | `None ]
    * extended_time
    * timing_function
    * extended_time
  | `Static_3 of
    [ `Single_transition_property of single_transition_property | `None ]
    * extended_time
    * timing_function
    * extended_time
    * transition_behavior_value
  ]

and single_transition_property =
  [ `Custom_ident of string
  | `Interpolation of string list
  | `All
  ]

and single_transition_property_no_interp =
  [ `Custom_ident of string
  | `All
  ]

and size =
  [ `Closest_side
  | `Farthest_side
  | `Closest_corner
  | `Farthest_corner
  | `Extended_length of extended_length
  | `Xor of
    [ `Extended_length of extended_length
    | `Extended_percentage of extended_percentage
    ]
    list
  ]

and ray_size =
  [ `Closest_side
  | `Farthest_side
  | `Closest_corner
  | `Farthest_corner
  | `Sides
  ]

and radial_size =
  [ `Closest_side
  | `Farthest_side
  | `Closest_corner
  | `Farthest_corner
  | `Extended_length of extended_length
  | `Xor of
    [ `Extended_length of extended_length
    | `Extended_percentage of extended_percentage
    ]
    list
  ]

and step_position =
  [ `Jump_start
  | `Jump_end
  | `Jump_none
  | `Jump_both
  | `Start
  | `End
  ]

and step_timing_function =
  [ `Step_start
  | `Step_end
  | `Steps of int * (unit * step_position) option
  ]

and subclass_selector =
  [ `Id_selector of id_selector
  | `Class_selector of class_selector
  | `Attribute_selector of attribute_selector
  | `Pseudo_class_selector of pseudo_class_selector
  ]

and supports_condition =
  [ `Static_0 of unit * supports_in_parens
  | `Static_1 of supports_in_parens * (unit * supports_in_parens) list
  | `Static_2 of supports_in_parens * (unit * supports_in_parens) list
  ]

and supports_decl = unit * declaration * unit

and supports_feature =
  [ `Supports_decl of supports_decl
  | `Supports_selector_fn of supports_selector_fn
  ]

and supports_in_parens =
  [ `Static of unit * supports_condition * unit
  | `Supports_feature of supports_feature
  ]

and supports_selector_fn = complex_selector

and svg_length =
  [ `Extended_percentage of extended_percentage
  | `Extended_length of extended_length
  | `Number of float
  ]

and svg_writing_mode =
  [ `Lr_tb
  | `Rl_tb
  | `Tb_rl
  | `Lr
  | `Rl
  | `Tb
  ]

and symbol =
  [ `String of string
  | `Image of image
  | `Custom_ident of string
  ]

and symbols_type =
  [ `Cyclic
  | `Numeric
  | `Alphabetic
  | `Symbolic
  | `Fixed
  ]

and target =
  [ `Function_target_counter of function_target_counter
  | `Function_target_counters of function_target_counters
  | `Function_target_text of function_target_text
  ]

and url =
  [ `Url_no_interp of string
  | `Url of string list
  ]

and length_percentage =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and timing_function =
  [ `Linear
  | `Cubic_bezier_timing_function of cubic_bezier_timing_function
  | `Step_timing_function of step_timing_function
  | `Interpolation of string list
  ]

and timing_function_no_interp =
  [ `Linear
  | `Cubic_bezier_timing_function of cubic_bezier_timing_function
  | `Step_timing_function of step_timing_function
  ]

and top =
  [ `Extended_length of extended_length
  | `Auto
  ]

and try_tactic =
  [ `Flip_block
  | `Flip_inline
  | `Flip_start
  ]

and track_breadth =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  | `Flex_value of flex_value
  | `Min_content
  | `Max_content
  | `Auto
  ]

and track_group =
  [ `Static of
    unit
    * (string list * track_minmax * string list) list
    * unit
    * (unit * positive_integer * unit) option
  | `Track_minmax of track_minmax
  ]

and track_list =
  (line_names option
  * [ `Track_size of track_size | `Track_repeat of track_repeat ])
  list
  * line_names option

and track_list_v0 =
  [ `Static of (string list * track_group * string list) list
  | `None
  ]

and track_minmax =
  [ `Minmax of track_breadth * unit * track_breadth
  | `Auto
  | `Track_breadth of track_breadth
  | `Fit_content of
    [ `Extended_length of extended_length
    | `Extended_percentage of extended_percentage
    ]
  ]

and track_repeat =
  positive_integer
  * unit
  * (line_names option * track_size) list
  * line_names option

and track_size =
  [ `Track_breadth of track_breadth
  | `Minmax of inflexible_breadth * unit * track_breadth
  | `Fit_content of
    [ `Extended_length of extended_length
    | `Extended_percentage of extended_percentage
    ]
  ]

and transform_function =
  [ `Function_matrix of function_matrix
  | `Function_translate of function_translate
  | `Function_translateX of function_translateX
  | `Function_translateY of function_translateY
  | `Function_scale of function_scale
  | `Function_scaleX of function_scaleX
  | `Function_scaleY of function_scaleY
  | `Function_rotate of function_rotate
  | `Function_skew of function_skew
  | `Function_skewX of function_skewX
  | `Function_skewY of function_skewY
  | `Function_matrix3d of function_matrix3d
  | `Function_translate3d of function_translate3d
  | `Function_translateZ of function_translateZ
  | `Function_scale3d of function_scale3d
  | `Function_scaleZ of function_scaleZ
  | `Function_rotate3d of function_rotate3d
  | `Function_rotateX of function_rotateX
  | `Function_rotateY of function_rotateY
  | `Function_rotateZ of function_rotateZ
  | `Function_perspective of function_perspective
  ]

and transform_list = transform_function list

and transition_behavior_value =
  [ `Normal
  | `Allow_discrete
  | `Interpolation of string list
  ]

and transition_behavior_value_no_interp =
  [ `Normal
  | `Allow_discrete
  ]

and type_or_unit =
  [ `String
  | `Color
  | `Url
  | `Integer
  | `Number
  | `Length
  | `Angle
  | `Time
  | `Frequency
  | `Cap
  | `Ch
  | `Em
  | `Ex
  | `Ic
  | `Lh
  | `Rlh
  | `Rem
  | `Vb
  | `Vi
  | `Vw
  | `Vh
  | `Vmin
  | `Vmax
  | `Mm
  | `Q
  | `Cm
  | `In
  | `Pt
  | `Pc
  | `Px
  | `Deg
  | `Grad
  | `Rad
  | `Turn
  | `Ms
  | `S
  | `Hz
  | `KHz
  | `Percent
  ]

and type_selector =
  [ `Wq_name of wq_name
  | `Static of ns_prefix option * unit
  ]

and viewport_length =
  [ `Auto
  | `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  ]

and visual_box =
  [ `Content_box
  | `Padding_box
  | `Border_box
  ]

and wq_name = ns_prefix option * string
and attr_name = (string option * unit) option * string

and attr_unit =
  [ `Percent
  | `Em
  | `Ex
  | `Ch
  | `Rem
  | `Vw
  | `Vh
  | `Vmin
  | `Vmax
  | `Cm
  | `Mm
  | `In
  | `Px
  | `Pt
  | `Pc
  | `Deg
  | `Grad
  | `Rad
  | `Turn
  | `Ms
  | `S
  | `Hz
  | `KHz
  ]

and syntax_type_name =
  [ `Angle
  | `Color
  | `Custom_ident
  | `Image
  | `Integer
  | `Length
  | `Length_percentage
  | `Number
  | `Percentage
  | `Resolution
  | `String
  | `Time
  | `Url
  | `Transform_function
  ]

and syntax_multiplier =
  [ `Hash
  | `Cross of unit
  ]

and syntax_single_component =
  [ `Static of unit * syntax_type_name * unit
  | `Ident of string
  ]

and syntax_string = string
and syntax_combinator = unit

and syntax_component =
  [ `Static_0 of syntax_single_component * syntax_multiplier option
  | `Static_1 of unit * unit * unit
  ]

and syntax =
  [ `Asterisk of unit
  | `Static of syntax_component * (syntax_combinator * syntax_component) list
  | `Syntax_string of syntax_string
  ]

and attr_type =
  [ `Raw_string
  | `Attr_unit of attr_unit
  ]

and x = float
and y = float

type kind =
  | Property of string
  | Value of string
  | Function of string
  | Media_query of string

(* Packed rule type - stores a rule with its metadata *)
type packed_rule =
  | PackRule : {
      rule : 'a Rule.rule;
      validate : string -> (unit, string) result;
      runtime_module_path : string option;
    } -> packed_rule

(* Unified registry hashtable - stores all rules by name with their kind. *)
let registry_tbl : (string, kind * packed_rule) Hashtbl.t = Hashtbl.create 1000

(* Lazy lookup function for cross-rule references.
   Returns a rule that defers registry lookup to parse time.
   This avoids initialization order issues - rules can reference
   each other even if defined later in the file. *)
let lookup (name : string) : _ Rule.rule =
  fun tokens ->
    match Hashtbl.find_opt registry_tbl name with
    | Some (_, PackRule { rule; _ }) ->
      (* Cast is safe - we control type registration *)
      (Obj.magic rule : _ Rule.rule) tokens
    | None -> failwith ("Rule not found in registry: " ^ name)

(* Helper to pack a rule with its metadata *)
let pack_rule (type a) (rule : a Rule.rule) ?(runtime_module_path : string option) () : packed_rule =
  let validate input =
    match Rule.parse_string rule input with
    | Ok _ -> Ok ()
    | Error msg -> Error msg
  in
  PackRule { rule; validate; runtime_module_path }

let legacy_linear_gradient_arguments : legacy_linear_gradient_arguments Rule.rule = [%spec "[ <extended-angle> | <side-or-corner> ]? ',' <color-stop-list>"]
let legacy_linear_gradient_arguments_runtime_module_path = Some "Css_types.LegacyLinearGradientArguments"

let legacy_radial_gradient_shape : legacy_radial_gradient_shape Rule.rule = [%spec "'circle' | 'ellipse'"]
let legacy_radial_gradient_shape_runtime_module_path = Some "Css_types.LegacyRadialGradientShape"

let legacy_radial_gradient_size : legacy_radial_gradient_size Rule.rule = [%spec "'closest-side' | 'closest-corner' | 'farthest-side' | 'farthest-corner' | \
   'contain' | 'cover'"]
let legacy_radial_gradient_size_runtime_module_path = Some "Css_types.LegacyRadialGradientSize"

let legacy_radial_gradient_arguments : legacy_radial_gradient_arguments Rule.rule = [%spec "[ <position> ',' ]? [ [ <legacy-radial-gradient-shape> || \
   <legacy-radial-gradient-size> | [ <extended-length> | <extended-percentage> \
   ]{2} ] ',' ]? <color-stop-list>"]
let legacy_radial_gradient_arguments_runtime_module_path = Some "Css_types.LegacyRadialGradientArguments"

let legacy_linear_gradient : legacy_linear_gradient Rule.rule = [%spec "-moz-linear-gradient( <legacy-linear-gradient-arguments> ) | \
   -webkit-linear-gradient( <legacy-linear-gradient-arguments> ) | \
   -o-linear-gradient( <legacy-linear-gradient-arguments> )"]
let legacy_linear_gradient_runtime_module_path = Some "Css_types.LegacyLinearGradient"

let legacy_radial_gradient : legacy_radial_gradient Rule.rule = [%spec "-moz-radial-gradient( <legacy-radial-gradient-arguments> ) | \
   -webkit-radial-gradient( <legacy-radial-gradient-arguments> ) | \
   -o-radial-gradient( <legacy-radial-gradient-arguments> )"]
let legacy_radial_gradient_runtime_module_path = Some "Css_types.LegacyRadialGradient"

let legacy_repeating_linear_gradient : legacy_repeating_linear_gradient Rule.rule = [%spec "-moz-repeating-linear-gradient( <legacy-linear-gradient-arguments> ) | \
   -webkit-repeating-linear-gradient( <legacy-linear-gradient-arguments> ) | \
   -o-repeating-linear-gradient( <legacy-linear-gradient-arguments> )"]
let legacy_repeating_linear_gradient_runtime_module_path = Some "Css_types.LegacyRepeatingLinearGradient"

let legacy_repeating_radial_gradient : legacy_repeating_radial_gradient Rule.rule = [%spec "-moz-repeating-radial-gradient( <legacy-radial-gradient-arguments> ) | \
   -webkit-repeating-radial-gradient( <legacy-radial-gradient-arguments> ) | \
   -o-repeating-radial-gradient( <legacy-radial-gradient-arguments> )"]
let legacy_repeating_radial_gradient_runtime_module_path = Some "Css_types.LegacyRepeatingRadialGradient"

(* Legacy_gradient depends on all the above, so it must come last *)
let legacy_gradient : legacy_gradient Rule.rule = [%spec "<-webkit-gradient()> | <legacy-linear-gradient> | \
   <legacy-repeating-linear-gradient> | <legacy-radial-gradient> | \
   <legacy-repeating-radial-gradient>"]
let legacy_gradient_runtime_module_path = Some "Css_types.LegacyGradient"

let non_standard_color : non_standard_color Rule.rule = [%spec "'-moz-ButtonDefault' | '-moz-ButtonHoverFace' | '-moz-ButtonHoverText' | \
   '-moz-CellHighlight' | '-moz-CellHighlightText' | '-moz-Combobox' | \
   '-moz-ComboboxText' | '-moz-Dialog' | '-moz-DialogText' | \
   '-moz-dragtargetzone' | '-moz-EvenTreeRow' | '-moz-Field' | \
   '-moz-FieldText' | '-moz-html-CellHighlight' | \
   '-moz-html-CellHighlightText' | '-moz-mac-accentdarkestshadow' | \
   '-moz-mac-accentdarkshadow' | '-moz-mac-accentface' | \
   '-moz-mac-accentlightesthighlight' | '-moz-mac-accentlightshadow' | \
   '-moz-mac-accentregularhighlight' | '-moz-mac-accentregularshadow' | \
   '-moz-mac-chrome-active' | '-moz-mac-chrome-inactive' | \
   '-moz-mac-focusring' | '-moz-mac-menuselect' | '-moz-mac-menushadow' | \
   '-moz-mac-menutextselect' | '-moz-MenuHover' | '-moz-MenuHoverText' | \
   '-moz-MenuBarText' | '-moz-MenuBarHoverText' | '-moz-nativehyperlinktext' | \
   '-moz-OddTreeRow' | '-moz-win-communicationstext' | '-moz-win-mediatext' | \
   '-moz-activehyperlinktext' | '-moz-default-background-color' | \
   '-moz-default-color' | '-moz-hyperlinktext' | '-moz-visitedhyperlinktext' | \
   '-webkit-activelink' | '-webkit-focus-ring-color' | '-webkit-link' | \
   '-webkit-text'"]
let non_standard_color_runtime_module_path = Some "Css_types.NonStandardColor"

let non_standard_font : non_standard_font Rule.rule = [%spec "'-apple-system-body' | '-apple-system-headline' | \
   '-apple-system-subheadline' | '-apple-system-caption1' | \
   '-apple-system-caption2' | '-apple-system-footnote' | \
   '-apple-system-short-body' | '-apple-system-short-headline' | \
   '-apple-system-short-subheadline' | '-apple-system-short-caption1' | \
   '-apple-system-short-footnote' | '-apple-system-tall-body'"]
let non_standard_font_runtime_module_path = Some "Css_types.NonStandardFont"

let non_standard_image_rendering : non_standard_image_rendering Rule.rule = [%spec "'optimize-contrast' | '-moz-crisp-edges' | '-o-crisp-edges' | \
   '-webkit-optimize-contrast'"]
let non_standard_image_rendering_runtime_module_path = Some "Css_types.NonStandardImageRendering"

let non_standard_overflow : non_standard_overflow Rule.rule = [%spec "'-moz-scrollbars-none' | '-moz-scrollbars-horizontal' | \
   '-moz-scrollbars-vertical' | '-moz-hidden-unscrollable'"]
let non_standard_overflow_runtime_module_path = Some "Css_types.NonStandardOverflow"

let non_standard_width : non_standard_width Rule.rule = [%spec "'min-intrinsic' | 'intrinsic' | '-moz-min-content' | '-moz-max-content' | \
   '-webkit-min-content' | '-webkit-max-content'"]
let non_standard_width_runtime_module_path = Some "Css_types.NonStandardWidth"

let webkit_gradient_color_stop : webkit_gradient_color_stop Rule.rule = [%spec "from( <color> ) | color-stop( [ <alpha-value> | <extended-percentage> ] ',' \
   <color> ) | to( <color> )"]
let webkit_gradient_color_stop_runtime_module_path = Some "Css_types.WebkitGradientColorStop"

let webkit_gradient_point : webkit_gradient_point Rule.rule = [%spec "[ 'left' | 'center' | 'right' | <extended-length> | <extended-percentage> ] \
   [ 'top' | 'center' | 'bottom' | <extended-length> | <extended-percentage> ]"]
let webkit_gradient_point_runtime_module_path = Some "Css_types.WebkitGradientPoint"

let webkit_gradient_radius : webkit_gradient_radius Rule.rule = [%spec "<extended-length> | <extended-percentage>"]
let webkit_gradient_radius_runtime_module_path = Some "Css_types.WebkitGradientRadius"

let webkit_gradient_type : webkit_gradient_type Rule.rule = [%spec "'linear' | 'radial'"]
let webkit_gradient_type_runtime_module_path = Some "Css_types.WebkitGradientType"

let webkit_mask_box_repeat : webkit_mask_box_repeat Rule.rule = [%spec "'repeat' | 'stretch' | 'round'"]
let webkit_mask_box_repeat_runtime_module_path = Some "Css_types.WebkitMaskBoxRepeat"

let webkit_mask_clip_style : webkit_mask_clip_style Rule.rule = [%spec "'border' | 'border-box' | 'padding' | 'padding-box' | 'content' | \
   'content-box' | 'text'"]
let webkit_mask_clip_style_runtime_module_path = Some "Css_types.WebkitMaskClipStyle"

let absolute_size : absolute_size Rule.rule = [%spec "'xx-small' | 'x-small' | 'small' | 'medium' | 'large' | 'x-large' | \
   'xx-large' | 'xxx-large'"]
let absolute_size_runtime_module_path = Some "Css_types.AbsoluteSize"

let age : age Rule.rule = [%spec "'child' | 'young' | 'old'"]
let age_runtime_module_path = Some "Css_types.Age"

let alpha_value : alpha_value Rule.rule = [%spec "<number> | <extended-percentage>"]
let alpha_value_runtime_module_path = Some "Css_types.AlphaValue"

let angular_color_hint : angular_color_hint Rule.rule = [%spec "<extended-angle> | <extended-percentage>"]
let angular_color_hint_runtime_module_path = Some "Css_types.AngularColorHint"

let angular_color_stop : angular_color_stop Rule.rule = [%spec "<color> && [ <color-stop-angle> ]?"]
let angular_color_stop_runtime_module_path = Some "Css_types.AngularColorStop"

let angular_color_stop_list : angular_color_stop_list Rule.rule = [%spec "[ <angular-color-stop> [ ',' <angular-color-hint> ]? ]# ',' \
   <angular-color-stop>"]
let angular_color_stop_list_runtime_module_path = Some "Css_types.AngularColorStopList"

let animateable_feature : animateable_feature Rule.rule = [%spec "'scroll-position' | 'contents' | <custom-ident>"]
let animateable_feature_runtime_module_path = Some "Css_types.AnimateableFeature"

let attachment : attachment Rule.rule = [%spec "'scroll' | 'fixed' | 'local'"]
let attachment_runtime_module_path = Some "Css_types.Attachment"

let attr_fallback : attr_fallback Rule.rule = [%spec "<any-value>"]
let attr_fallback_runtime_module_path = Some "Css_types.AttrFallback"

let attr_matcher : attr_matcher Rule.rule = [%spec "[ '~' | '|' | '^' | '$' | '*' ]? '='"]
let attr_matcher_runtime_module_path = Some "Css_types.AttrMatcher"

let attr_modifier : attr_modifier Rule.rule = [%spec "'i' | 's'"]
let attr_modifier_runtime_module_path = Some "Css_types.AttrModifier"

let attribute_selector : attribute_selector Rule.rule = [%spec "'[' <wq-name> ']' | '[' <wq-name> <attr-matcher> [ <string-token> | \
   <ident-token> ] [ <attr-modifier> ]? ']'"]
let attribute_selector_runtime_module_path = Some "Css_types.AttributeSelector"

let auto_repeat : auto_repeat Rule.rule = [%spec "repeat( [ 'auto-fill' | 'auto-fit' ] ',' [ [ <line-names> ]? <fixed-size> \
   ]+ [ <line-names> ]? )"]
let auto_repeat_runtime_module_path = Some "Css_types.AutoRepeat"

let auto_track_list : auto_track_list Rule.rule = [%spec "[ [ <line-names> ]? [ <fixed-size> | <fixed-repeat> ] ]* [ <line-names> ]? \
   <auto-repeat> [ [ <line-names> ]? [ <fixed-size> | <fixed-repeat> ] ]* [ \
   <line-names> ]?"]
let auto_track_list_runtime_module_path = Some "Css_types.AutoTrackList"

let baseline_position : baseline_position Rule.rule = [%spec "[ 'first' | 'last' ]? 'baseline'"]
let baseline_position_runtime_module_path = Some "Css_types.BaselinePosition"

let basic_shape : basic_shape Rule.rule = [%spec "<inset()> | <circle()> | <ellipse()> | <polygon()> | <path()>"]
let basic_shape_runtime_module_path = Some "Css_types.BasicShape"

let bg_image : bg_image Rule.rule = [%spec "'none' | <image>"]
let bg_image_runtime_module_path = Some "Css_types.BgImage"

let bg_layer : bg_layer Rule.rule = [%spec "<bg-image> || <bg-position> [ '/' <bg-size> ]? || <repeat-style> || \
   <attachment> || <box> || <box>"]
let bg_layer_runtime_module_path = Some "Css_types.BgLayer"

let bg_position : bg_position Rule.rule = [%spec "[ 'left' | 'center' | 'right' | 'top' | 'bottom' | <length-percentage> ] | \
   [ 'left' | 'center' | 'right' | <length-percentage> ] [ 'top' | 'center' | \
   'bottom' | <length-percentage> ] | [ 'center' | [ 'left' | 'right' ] \
   <length-percentage>? ] && [ 'center' | [ 'top' | 'bottom' ] \
   <length-percentage>? ]"]
let bg_position_runtime_module_path = Some "Css_types.BgPosition"

(* one_bg_size isn't part of the spec, helps us with Type generation *)
let one_bg_size : one_bg_size Rule.rule = [%spec "[ <extended-length> | <extended-percentage> | 'auto' ] [ <extended-length> \
   | <extended-percentage> | 'auto' ]?"]
let one_bg_size_runtime_module_path = Some "Css_types.OneBgSize"

let bg_size : bg_size Rule.rule = [%spec "<one-bg-size> | 'cover' | 'contain'"]
let bg_size_runtime_module_path = Some "Css_types.BgSize"

let blend_mode : blend_mode Rule.rule = [%spec "'normal' | 'multiply' | 'screen' | 'overlay' | 'darken' | 'lighten' | \
   'color-dodge' | 'color-burn' | 'hard-light' | 'soft-light' | 'difference' | \
   'exclusion' | 'hue' | 'saturation' | 'color' | 'luminosity'"]
let blend_mode_runtime_module_path = Some "Css_types.BlendMode"

(* border_radius value supports 1-4 values with optional "/" for horizontal/vertical *)
let border_radius : border_radius Rule.rule = [%spec "[ <extended-length> | <extended-percentage> ]{1,4} [ '/' [ \
   <extended-length> | <extended-percentage> ]{1,4} ]?"]
let border_radius_runtime_module_path = Some "Css_types.BorderRadius"

let bottom : bottom Rule.rule = [%spec "<extended-length> | 'auto'"]
let bottom_runtime_module_path = Some "Css_types.Bottom"

let box : box Rule.rule = [%spec "'border-box' | 'padding-box' | 'content-box'"]
let box_runtime_module_path = Some "Css_types.Box"

let calc_product : calc_product Rule.rule = [%spec "<calc-value> [ '*' <calc-value> | '/' <number> ]*"]
let calc_product_runtime_module_path = Some "Css_types.CalcProduct"

let dimension : dimension Rule.rule = [%spec "<extended-length> | <extended-time> | <extended-frequency> | <resolution>"]
let dimension_runtime_module_path = Some "Css_types.Dimension"

let calc_sum : calc_sum Rule.rule = [%spec "<calc-product> [ [ '+' | '-' ] <calc-product> ]*"]
let calc_sum_runtime_module_path = Some "Css_types.CalcSum"

(* type calc_value = [%spec_t "<number> | <dimension> | <extended-percentage> | <calc>"]
let calc_value : calc_value Rule.rule = [%spec "<number> | <dimension> | <extended-percentage> | <calc>"]
let calc_value_runtime_module_path = Some "Css_types.CalcValue" *)
let calc_value : calc_value Rule.rule = [%spec "<number> | <extended-length> | <extended-percentage> | <extended-angle> | \
   <extended-time> | '(' <calc-sum> ')'"]
let calc_value_runtime_module_path = Some "Css_types.CalcValue"

let cf_final_image : cf_final_image Rule.rule = [%spec "<image> | <color>"]
let cf_final_image_runtime_module_path = Some "Css_types.CfFinalImage"

let cf_mixing_image : cf_mixing_image Rule.rule = [%spec "[ <extended-percentage> ]? && <image>"]
let cf_mixing_image_runtime_module_path = Some "Css_types.CfMixingImage"

let class_selector : class_selector Rule.rule = [%spec "'.' <ident-token>"]
let class_selector_runtime_module_path = Some "Css_types.ClassSelector"

let clip_source : clip_source Rule.rule = [%spec "<url>"]
let clip_source_runtime_module_path = Some "Css_types.ClipSource"

let color : color Rule.rule = [%spec "<rgb()> | <rgba()> | <hsl()> | <hsla()> | <hex-color> | <named-color> | \
   'currentColor' | <deprecated-system-color> | <interpolation> | <var()> | \
   <color-mix()>"]
let color_runtime_module_path = Some "Css_types.Color"

let color_stop : color_stop Rule.rule = [%spec "<color-stop-length> | <color-stop-angle>"]
let color_stop_runtime_module_path = Some "Css_types.ColorStop"

let color_stop_angle : color_stop_angle Rule.rule = [%spec "[ <extended-angle> ]{1,2}"]
let color_stop_angle_runtime_module_path = Some "Css_types.ColorStopAngle"

(* type color_stop_length = [%spec_t "[ <extended-length> | <extended-percentage> ]{1,2}"]
let color_stop_length : color_stop_length Rule.rule = [%spec "[ <extended-length> | <extended-percentage> ]{1,2}"]
let color_stop_length_runtime_module_path = Some "Css_types.ColorStopLength" *)
let color_stop_length : color_stop_length Rule.rule = [%spec "<extended-length> | <extended-percentage>"]
let color_stop_length_runtime_module_path = Some "Css_types.ColorStopLength"

(* color_stop_list is modified from the original spec, here is a simplified version where it tries to be fully compatible but easier for code-gen:

   The current impl allows values that aren't really supported such as: `linear-gradient(0deg, 10%, blue)` which is invalid, but we allow it for now to make it easier to generate the types. The correct value would require always a color to be in the first position `linear-gradient(0deg, red, 10%, blue);`

   The original spec is `color_stop_list = [%spec_module "[ <linear-color-stop> [ ',' <linear-color-hint> ]? ]# ',' <linear-color-stop>"]`
   *)
let color_stop_list : color_stop_list Rule.rule = [%spec "[ [<color>? <length-percentage>] | [<color> <length-percentage>?] ]#"]
let color_stop_list_runtime_module_path = Some "Css_types.ColorStopList"

let hue_interpolation_method : hue_interpolation_method Rule.rule = [%spec " [ 'shorter' | 'longer' | 'increasing' | 'decreasing' ] && 'hue' "]
let hue_interpolation_method_runtime_module_path = Some "Css_types.HueInterpolationMethod"

let polar_color_space : polar_color_space Rule.rule = [%spec " 'hsl' | 'hwb' | 'lch' | 'oklch' "]
let polar_color_space_runtime_module_path = Some "Css_types.PolarColorSpace"

let rectangular_color_space : rectangular_color_space Rule.rule = [%spec " 'srgb' | 'srgb-linear' | 'display-p3' | 'a98-rgb' | 'prophoto-rgb' | \
   'rec2020' | 'lab' | 'oklab' | 'xyz' | 'xyz-d50' | 'xyz-d65' "]
let rectangular_color_space_runtime_module_path = Some "Css_types.RectangularColorSpace"

let color_interpolation_method : color_interpolation_method Rule.rule = [%spec " 'in' && [<rectangular-color-space> | <polar-color-space> \
   <hue-interpolation-method>?] "]
let color_interpolation_method_runtime_module_path = Some "Css_types.ColorInterpolationMethod"

(* TODO: Use <extended-percentage> *)
let function_color_mix : function_color_mix Rule.rule = [%spec "color-mix(<color-interpolation-method> ',' [ <color> && <percentage>? ] ',' [ <color> && <percentage>? ])"]

let combinator : combinator Rule.rule = [%spec "'>' | '+' | '~' | '||'"]
let combinator_runtime_module_path = Some "Css_types.Combinator"

let common_lig_values : common_lig_values Rule.rule = [%spec "'common-ligatures' | 'no-common-ligatures'"]
let common_lig_values_runtime_module_path = Some "Css_types.CommonLigValues"

let compat_auto : compat_auto Rule.rule = [%spec "'searchfield' | 'textarea' | 'push-button' | 'slider-horizontal' | \
   'checkbox' | 'radio' | 'square-button' | 'menulist' | 'listbox' | 'meter' | \
   'progress-bar'"]
let compat_auto_runtime_module_path = Some "Css_types.CompatAuto"

let complex_selector : complex_selector Rule.rule = [%spec "<compound-selector> [ [ <combinator> ]? <compound-selector> ]*"]
let complex_selector_runtime_module_path = Some "Css_types.ComplexSelector"

let complex_selector_list : complex_selector_list Rule.rule = [%spec "[ <complex-selector> ]#"]
let complex_selector_list_runtime_module_path = Some "Css_types.ComplexSelectorList"

let composite_style : composite_style Rule.rule = [%spec "'clear' | 'copy' | 'source-over' | 'source-in' | 'source-out' | \
   'source-atop' | 'destination-over' | 'destination-in' | 'destination-out' | \
   'destination-atop' | 'xor'"]
let composite_style_runtime_module_path = Some "Css_types.CompositeStyle"

let compositing_operator : compositing_operator Rule.rule = [%spec "'add' | 'subtract' | 'intersect' | 'exclude'"]
let compositing_operator_runtime_module_path = Some "Css_types.CompositingOperator"

let compound_selector : compound_selector Rule.rule = [%spec "[ <type-selector> ]? [ <subclass-selector> ]* [ <pseudo-element-selector> [ \
   <pseudo-class-selector> ]* ]*"]
let compound_selector_runtime_module_path = Some "Css_types.CompoundSelector"

let compound_selector_list : compound_selector_list Rule.rule = [%spec "[ <compound-selector> ]#"]
let compound_selector_list_runtime_module_path = Some "Css_types.CompoundSelectorList"

let content_distribution : content_distribution Rule.rule = [%spec "'space-between' | 'space-around' | 'space-evenly' | 'stretch'"]
let content_distribution_runtime_module_path = Some "Css_types.ContentDistribution"

let content_list : content_list Rule.rule = [%spec "[ <string> | 'contents' | <url> | <quote> | <attr()> | counter( <ident> ',' \
   [ <'list-style-type'> ]? ) ]+"]
let content_list_runtime_module_path = Some "Css_types.ContentList"

let content_position : content_position Rule.rule = [%spec "'center' | 'start' | 'end' | 'flex-start' | 'flex-end'"]
let content_position_runtime_module_path = Some "Css_types.ContentPosition"

let content_replacement : content_replacement Rule.rule = [%spec "<image>"]
let content_replacement_runtime_module_path = Some "Css_types.ContentReplacement"

let contextual_alt_values : contextual_alt_values Rule.rule = [%spec "'contextual' | 'no-contextual'"]
let contextual_alt_values_runtime_module_path = Some "Css_types.ContextualAltValues"

let counter_style : counter_style Rule.rule = [%spec "<counter-style-name> | <symbols()>"]
let counter_style_runtime_module_path = Some "Css_types.CounterStyle"

let counter_style_name : counter_style_name Rule.rule = [%spec "<custom-ident>"]
let counter_style_name_runtime_module_path = Some "Css_types.CounterStyleName"

let counter_name : counter_name Rule.rule = [%spec "<custom-ident>"]
let counter_name_runtime_module_path = Some "Css_types.CounterName"

let cubic_bezier_timing_function : cubic_bezier_timing_function Rule.rule = [%spec "'ease' | 'ease-in' | 'ease-out' | 'ease-in-out' | cubic-bezier( <number> \
   ',' <number> ',' <number> ',' <number> )"]
let cubic_bezier_timing_function_runtime_module_path = Some "Css_types.CubicBezierTimingFunction"

let declaration : declaration Rule.rule = [%spec "<ident-token> ':' [ <declaration-value> ]? [ '!' 'important' ]?"]
let declaration_runtime_module_path = Some "Css_types.Declaration"

let declaration_list : declaration_list Rule.rule = [%spec "[ [ <declaration> ]? ';' ]* [ <declaration> ]?"]
let declaration_list_runtime_module_path = Some "Css_types.DeclarationList"

let deprecated_system_color : deprecated_system_color Rule.rule = [%spec "'ActiveBorder' | 'ActiveCaption' | 'AppWorkspace' | 'Background' | \
   'ButtonFace' | 'ButtonHighlight' | 'ButtonShadow' | 'ButtonText' | \
   'CaptionText' | 'GrayText' | 'Highlight' | 'HighlightText' | \
   'InactiveBorder' | 'InactiveCaption' | 'InactiveCaptionText' | \
   'InfoBackground' | 'InfoText' | 'Menu' | 'MenuText' | 'Scrollbar' | \
   'ThreeDDarkShadow' | 'ThreeDFace' | 'ThreeDHighlight' | 'ThreeDLightShadow' \
   | 'ThreeDShadow' | 'Window' | 'WindowFrame' | 'WindowText'"]
let deprecated_system_color_runtime_module_path = Some "Css_types.DeprecatedSystemColor"

let discretionary_lig_values : discretionary_lig_values Rule.rule = [%spec "'discretionary-ligatures' | 'no-discretionary-ligatures'"]
let discretionary_lig_values_runtime_module_path = Some "Css_types.DiscretionaryLigValues"

let display_box : display_box Rule.rule = [%spec "'contents' | 'none'"]
let display_box_runtime_module_path = Some "Css_types.DisplayBox"

let display_inside : display_inside Rule.rule = [%spec "'flow' | 'flow-root' | 'table' | 'flex' | 'grid' | 'ruby'"]
let display_inside_runtime_module_path = Some "Css_types.DisplayInside"

let display_internal : display_internal Rule.rule = [%spec "'table-row-group' | 'table-header-group' | 'table-footer-group' | \
   'table-row' | 'table-cell' | 'table-column-group' | 'table-column' | \
   'table-caption' | 'ruby-base' | 'ruby-text' | 'ruby-base-container' | \
   'ruby-text-container'"]
let display_internal_runtime_module_path = Some "Css_types.DisplayInternal"

let display_legacy : display_legacy Rule.rule = [%spec "'inline-block' | 'inline-list-item' | 'inline-table' | 'inline-flex' | \
   'inline-grid'"]
let display_legacy_runtime_module_path = Some "Css_types.DisplayLegacy"

let display_listitem : display_listitem Rule.rule = [%spec "[ <display-outside> ]? && [ 'flow' | 'flow-root' ]? && 'list-item'"]
let display_listitem_runtime_module_path = Some "Css_types.DisplayListitem"

let display_outside : display_outside Rule.rule = [%spec "'block' | 'inline' | 'run-in'"]
let display_outside_runtime_module_path = Some "Css_types.DisplayOutside"

let east_asian_variant_values : east_asian_variant_values Rule.rule = [%spec "'jis78' | 'jis83' | 'jis90' | 'jis04' | 'simplified' | 'traditional'"]
let east_asian_variant_values_runtime_module_path = Some "Css_types.EastAsianVariantValues"

let east_asian_width_values : east_asian_width_values Rule.rule = [%spec "'full-width' | 'proportional-width'"]
let east_asian_width_values_runtime_module_path = Some "Css_types.EastAsianWidthValues"

let ending_shape : ending_shape Rule.rule = [%spec "'circle' | 'ellipse'"]
let ending_shape_runtime_module_path = Some "Css_types.EndingShape"

let explicit_track_list : explicit_track_list Rule.rule = [%spec "[ [ <line-names> ]? <track-size> ]+ [ <line-names> ]?"]
let explicit_track_list_runtime_module_path = Some "Css_types.ExplicitTrackList"

let family_name : family_name Rule.rule = [%spec "<string> | <custom-ident>"]
let family_name_runtime_module_path = Some "Css_types.FamilyName"

let feature_tag_value : feature_tag_value Rule.rule = [%spec "<string> [ <integer> | 'on' | 'off' ]?"]
let feature_tag_value_runtime_module_path = Some "Css_types.FeatureTagValue"

let feature_type : feature_type Rule.rule = [%spec "'@stylistic' | '@historical-forms' | '@styleset' | '@character-variant' | \
   '@swash' | '@ornaments' | '@annotation'"]
let feature_type_runtime_module_path = Some "Css_types.FeatureType"

let feature_value_block : feature_value_block Rule.rule = [%spec "<feature-type> '{' <feature-value-declaration-list> '}'"]
let feature_value_block_runtime_module_path = Some "Css_types.FeatureValueBlock"

let feature_value_block_list : feature_value_block_list Rule.rule = [%spec "[ <feature-value-block> ]+"]
let feature_value_block_list_runtime_module_path = Some "Css_types.FeatureValueBlockList"

let feature_value_declaration : feature_value_declaration Rule.rule = [%spec "<custom-ident> ':' [ <integer> ]+ ';'"]
let feature_value_declaration_runtime_module_path = Some "Css_types.FeatureValueDeclaration"

let feature_value_declaration_list : feature_value_declaration_list Rule.rule = [%spec "<feature-value-declaration>"]
let feature_value_declaration_list_runtime_module_path = Some "Css_types.FeatureValueDeclarationList"

let feature_value_name : feature_value_name Rule.rule = [%spec "<custom-ident>"]
let feature_value_name_runtime_module_path = Some "Css_types.FeatureValueName"

(* <zero> represents the literal value 0, used in contexts like rotate(0) *)
let zero : zero Rule.rule = [%spec "'0'"]

let fill_rule : fill_rule Rule.rule = [%spec "'nonzero' | 'evenodd'"]
let fill_rule_runtime_module_path = Some "Css_types.FillRule"

let filter_function : filter_function Rule.rule = [%spec "<blur()> | <brightness()> | <contrast()> | <drop-shadow()> | <grayscale()> \
   | <hue-rotate()> | <invert()> | <opacity()> | <saturate()> | <sepia()>"]
let filter_function_runtime_module_path = Some "Css_types.FilterFunction"

let filter_function_list : filter_function_list Rule.rule = [%spec "[ <filter-function> | <url> ]+"]
let filter_function_list_runtime_module_path = Some "Css_types.FilterFunctionList"

let final_bg_layer : final_bg_layer Rule.rule = [%spec "<'background-color'> || <bg-image> || <bg-position> [ '/' <bg-size> ]? || \
   <repeat-style> || <attachment> || <box> || <box>"]
let final_bg_layer_runtime_module_path = Some "Css_types.FinalBgLayer"

let line_names : line_names Rule.rule = [%spec "'[' <custom-ident>* ']'"]
let line_names_runtime_module_path = Some "Css_types.LineNames"

let fixed_breadth : fixed_breadth Rule.rule = [%spec "<extended-length> | <extended-percentage>"]
let fixed_breadth_runtime_module_path = Some "Css_types.FixedBreadth"

let fixed_repeat : fixed_repeat Rule.rule = [%spec "repeat( <positive-integer> ',' [ [ <line-names> ]? <fixed-size> ]+ [ \
   <line-names> ]? )"]
let fixed_repeat_runtime_module_path = Some "Css_types.FixedRepeat"

let fixed_size : fixed_size Rule.rule = [%spec "<fixed-breadth> | minmax( <fixed-breadth> ',' <track-breadth> ) | minmax( \
   <inflexible-breadth> ',' <fixed-breadth> )"]
let fixed_size_runtime_module_path = Some "Css_types.FixedSize"

let font_stretch_absolute : font_stretch_absolute Rule.rule = [%spec "'normal' | 'ultra-condensed' | 'extra-condensed' | 'condensed' | \
   'semi-condensed' | 'semi-expanded' | 'expanded' | 'extra-expanded' | \
   'ultra-expanded' | <extended-percentage>"]
let font_stretch_absolute_runtime_module_path = Some "Css_types.FontStretchAbsolute"

let font_variant_css21 : font_variant_css21 Rule.rule = [%spec "'normal' | 'small-caps'"]
let font_variant_css21_runtime_module_path = Some "Css_types.FontVariantCss21"

let font_weight_absolute : font_weight_absolute Rule.rule = [%spec "'normal' | 'bold' | <integer>"]
let font_weight_absolute_runtime_module_path = Some "Css_types.FontWeightAbsolute"

let function__webkit_gradient : function__webkit_gradient Rule.rule = [%spec "-webkit-gradient( <webkit-gradient-type> ',' <webkit-gradient-point> [ ',' \
   <webkit-gradient-point> | ',' <webkit-gradient-radius> ',' \
   <webkit-gradient-point> ] [ ',' <webkit-gradient-radius> ]? [ ',' \
   <webkit-gradient-color-stop> ]* )"]

(* We don't support attr() with fallback value (since it's a declaration value) yet, original spec is: "attr(<attr-name> <attr-type>? , <declaration-value>?)" *)
let function_attr : function_attr Rule.rule = [%spec "attr(<attr-name> <attr-type>?)"]

(* type function_attr = [%spec_t "attr(<attr-name> <attr-type>? , <declaration-value>?)"]
let function_attr : function_attr Rule.rule = [%spec "attr(<attr-name> <attr-type>? , <declaration-value>?)"] *)
let function_blur : function_blur Rule.rule = [%spec "blur( <extended-length> )"]

let function_brightness : function_brightness Rule.rule = [%spec "brightness( <number-percentage> )"]

let function_calc : function_calc Rule.rule = [%spec "calc( <calc-sum> )"]

let function_circle : function_circle Rule.rule = [%spec "circle( [ <shape-radius> ]? [ 'at' <position> ]? )"]

let function_clamp : function_clamp Rule.rule = [%spec "clamp( [ <calc-sum> ]#{3} )"]

let function_conic_gradient : function_conic_gradient Rule.rule = [%spec "conic-gradient( [ 'from' <extended-angle> ]? [ 'at' <position> ]? ',' \
   <angular-color-stop-list> )"]

let function_contrast : function_contrast Rule.rule = [%spec "contrast( <number-percentage> )"]

let function_counter : function_counter Rule.rule = [%spec "counter( <counter-name> , <counter-style>? )"]
let function_counter_runtime_module_path = Some "Css_types.Counter"

let function_counters : function_counters Rule.rule = [%spec "counters( <custom-ident> ',' <string> ',' [ <counter-style> ]? )"]
let function_counters_runtime_module_path = Some "Css_types.Counters"

let function_cross_fade : function_cross_fade Rule.rule = [%spec "cross-fade( <cf-mixing-image> ',' [ <cf-final-image> ]? )"]

(* drop-shadow can have 2 length module order doesn't matter, we changed to be more restrict module always expect 3 *)
let function_drop_shadow : function_drop_shadow Rule.rule = [%spec "drop-shadow(<extended-length> <extended-length> <extended-length> [ <color> \
   ]?)"]

let function_element : function_element Rule.rule = [%spec "element( <id-selector> )"]

let function_ellipse : function_ellipse Rule.rule = [%spec "ellipse( [ [ <shape-radius> ]{2} ]? [ 'at' <position> ]? )"]

let function_env : function_env Rule.rule = [%spec "env( <custom-ident> ',' [ <declaration-value> ]? )"]

let function_fit_content : function_fit_content Rule.rule = [%spec "fit-content( <extended-length> | <extended-percentage> )"]

let function_grayscale : function_grayscale Rule.rule = [%spec "grayscale( <number-percentage> )"]

let function_hsl : function_hsl Rule.rule = [%spec " hsl( <hue> <extended-percentage> <extended-percentage> [ '/' <alpha-value> \
   ]? ) | hsl( <hue> ',' <extended-percentage> ',' <extended-percentage> [ ',' \
   <alpha-value> ]? )"]

let function_hsla : function_hsla Rule.rule = [%spec " hsla( <hue> <extended-percentage> <extended-percentage> [ '/' \
   <alpha-value> ]? ) | hsla( <hue> ',' <extended-percentage> ',' \
   <extended-percentage> ',' [ <alpha-value> ]? )"]

let function_hue_rotate : function_hue_rotate Rule.rule = [%spec "hue-rotate( <extended-angle> )"]

let function_image : function_image Rule.rule = [%spec "image( [ <image-tags> ]? [ <image-src> ]? ',' [ <color> ]? )"]
let function_image_runtime_module_path = Some "Css_types.Image"

let function_image_set : function_image_set Rule.rule = [%spec "image-set( [ <image-set-option> ]# )"]

let function_inset : function_inset Rule.rule = [%spec "inset( [ <extended-length> | <extended-percentage> ]{1,4} [ 'round' \
   <'border-radius'> ]? )"]
let function_inset_runtime_module_path = Some "Css_types.Inset"

let function_invert : function_invert Rule.rule = [%spec "invert( <number-percentage> )"]

let function_leader : function_leader Rule.rule = [%spec "leader( <leader-type> )"]

let function_linear_gradient : function_linear_gradient Rule.rule = [%spec "linear-gradient( [ [<extended-angle> ','] | ['to' <side-or-corner> ','] ]? \
   <color-stop-list> )"]

(* type function_linear_gradient = [%spec_t "linear-gradient( [ <extended-angle> | 'to' <side-or-corner> ]? ',' <color-stop-list> )"]
let function_linear_gradient : function_linear_gradient Rule.rule = [%spec "linear-gradient( [ <extended-angle> | 'to' <side-or-corner> ]? ',' <color-stop-list> )"] *)
let function_matrix : function_matrix Rule.rule = [%spec "matrix( [ <number> ]#{6} )"]

let function_matrix3d : function_matrix3d Rule.rule = [%spec "matrix3d( [ <number> ]#{16} )"]

let function_max : function_max Rule.rule = [%spec "max( [ <calc-sum> ]# )"]
let function_min : function_min Rule.rule = [%spec "min( [ <calc-sum> ]# )"]

let function_minmax : function_minmax Rule.rule = [%spec "minmax( [ <extended-length> | <extended-percentage> | 'min-content' | \
   'max-content' | 'auto' ] ',' [ <extended-length> | <extended-percentage> | \
   <flex-value> | 'min-content' | 'max-content' | 'auto' ] )"]

let function_opacity : function_opacity Rule.rule = [%spec "opacity( <number-percentage> )"]

let function_paint : function_paint Rule.rule = [%spec "paint( <ident> ',' [ <declaration-value> ]? )"]
let function_paint_runtime_module_path = Some "Css_types.Paint"

let function_path : function_path Rule.rule = [%spec "path( <string> )"]

let function_perspective : function_perspective Rule.rule = [%spec "perspective( <'perspective'> )"]
let function_perspective_runtime_module_path = Some "Css_types.Perspective"

let function_polygon : function_polygon Rule.rule = [%spec "polygon( [ <fill-rule> ',' ]? [ <length-percentage> <length-percentage> ]# )"]

let function_radial_gradient : function_radial_gradient Rule.rule = [%spec "radial-gradient( <ending-shape>? <radial-size>? ['at' <position> ]? ','? \
   <color-stop-list> )"]

let function_repeating_linear_gradient : function_repeating_linear_gradient Rule.rule = [%spec "repeating-linear-gradient( [ <extended-angle> | 'to' <side-or-corner> ]? \
   ',' <color-stop-list> )"]

let function_repeating_radial_gradient : function_repeating_radial_gradient Rule.rule = [%spec "repeating-radial-gradient( [ <ending-shape> || <size> ]? [ 'at' <position> \
   ]? ',' <color-stop-list> )"]

let function_rgb : function_rgb Rule.rule = [%spec "rgb( [ <extended-percentage> ]{3} [ '/' <alpha-value> ]? ) | rgb( [ \
   <number> ]{3} [ '/' <alpha-value> ]? ) | rgb( [ <extended-percentage> ]#{3} \
   [ ',' <alpha-value> ]? ) | rgb( [ <number> ]#{3} [ ',' <alpha-value> ]? )"]

let function_rgba : function_rgba Rule.rule = [%spec "rgba( [ <extended-percentage> ]{3} [ '/' <alpha-value> ]? ) | rgba( [ \
   <number> ]{3} [ '/' <alpha-value> ]? ) | rgba( [ <extended-percentage> \
   ]#{3} [ ',' <alpha-value> ]? ) | rgba( [ <number> ]#{3} [ ',' <alpha-value> \
   ]? )"]

let function_rotate : function_rotate Rule.rule = [%spec "rotate( <extended-angle> | <zero> )"]
let function_rotate_runtime_module_path = Some "Css_types.Rotate"

let function_rotate3d : function_rotate3d Rule.rule = [%spec "rotate3d( <number> ',' <number> ',' <number> ',' [ <extended-angle> | \
   <zero> ] )"]

let function_rotateX : function_rotateX Rule.rule = [%spec "rotateX( <extended-angle> | <zero> )"]

let function_rotateY : function_rotateY Rule.rule = [%spec "rotateY( <extended-angle> | <zero> )"]

let function_rotateZ : function_rotateZ Rule.rule = [%spec "rotateZ( <extended-angle> | <zero> )"]

let function_saturate : function_saturate Rule.rule = [%spec "saturate( <number-percentage> )"]

let function_scale : function_scale Rule.rule = [%spec "scale( <number> [',' [ <number> ]]? )"]
let function_scale_runtime_module_path = Some "Css_types.Scale"

let function_scale3d : function_scale3d Rule.rule = [%spec "scale3d( <number> ',' <number> ',' <number> )"]

let function_scaleX : function_scaleX Rule.rule = [%spec "scaleX( <number> )"]
let function_scaleY : function_scaleY Rule.rule = [%spec "scaleY( <number> )"]
let function_scaleZ : function_scaleZ Rule.rule = [%spec "scaleZ( <number> )"]

let function_sepia : function_sepia Rule.rule = [%spec "sepia( <number-percentage> )"]

let function_skew : function_skew Rule.rule = [%spec "skew( [ <extended-angle> | <zero> ] [',' [ <extended-angle> | <zero> ]]? )"]

let function_skewX : function_skewX Rule.rule = [%spec "skewX( <extended-angle> | <zero> )"]

let function_skewY : function_skewY Rule.rule = [%spec "skewY( <extended-angle> | <zero> )"]

let function_symbols : function_symbols Rule.rule = [%spec "symbols( [ <symbols-type> ]? [ <string> | <image> ]+ )"]
let function_symbols_runtime_module_path = Some "Css_types.Symbols"

let function_target_counter : function_target_counter Rule.rule = [%spec "target-counter( [ <string> | <url> ] ',' <custom-ident> ',' [ \
   <counter-style> ]? )"]

let function_target_counters : function_target_counters Rule.rule = [%spec "target-counters( [ <string> | <url> ] ',' <custom-ident> ',' <string> ',' [ \
   <counter-style> ]? )"]

let function_target_text : function_target_text Rule.rule = [%spec "target-text( [ <string> | <url> ] ',' [ 'content' | 'before' | 'after' | \
   'first-letter' ]? )"]

let function_translate : function_translate Rule.rule = [%spec "translate( [<extended-length> | <extended-percentage>] [',' [ \
   <extended-length> | <extended-percentage> ]]? )"]
let function_translate_runtime_module_path = Some "Css_types.Translate"

let function_translate3d : function_translate3d Rule.rule = [%spec "translate3d( [<extended-length> | <extended-percentage>] ',' \
   [<extended-length> | <extended-percentage>] ',' <extended-length> )"]

let function_translateX : function_translateX Rule.rule = [%spec "translateX( [<extended-length> | <extended-percentage>] )"]

let function_translateY : function_translateY Rule.rule = [%spec "translateY( [<extended-length> | <extended-percentage>] )"]

let function_translateZ : function_translateZ Rule.rule = [%spec "translateZ( <extended-length> )"]

(* type function_var = [%spec_t "var( <ident> ',' [ <declaration-value> ]? )"]
let function_var : function_var Rule.rule = [%spec "var( <ident> ',' [ <declaration-value> ]? )"]
let function_var_runtime_module_path = Some "Css_types.Var" *)
let function_var : function_var Rule.rule = [%spec "var( <ident> )"]
let function_var_runtime_module_path = Some "Css_types.Var"

let gender : gender Rule.rule = [%spec "'male' | 'female' | 'neutral'"]
let gender_runtime_module_path = Some "Css_types.Gender"

let general_enclosed : general_enclosed Rule.rule = [%spec "<function-token> <any-value> ')' | '(' <ident> <any-value> ')'"]
let general_enclosed_runtime_module_path = Some "Css_types.GeneralEnclosed"

let generic_family : generic_family Rule.rule = [%spec "'serif' | 'sans-serif' | 'cursive' | 'fantasy' | 'monospace' | \
   '-apple-system'"]
let generic_family_runtime_module_path = Some "Css_types.GenericFamily"

let generic_name : generic_name Rule.rule = [%spec "'serif' | 'sans-serif' | 'cursive' | 'fantasy' | 'monospace'"]
let generic_name_runtime_module_path = Some "Css_types.GenericName"

let generic_voice : generic_voice Rule.rule = [%spec "[ <age> ]? <gender> [ <integer> ]?"]
let generic_voice_runtime_module_path = Some "Css_types.GenericVoice"

let geometry_box : geometry_box Rule.rule = [%spec "<shape-box> | 'fill-box' | 'stroke-box' | 'view-box'"]
let geometry_box_runtime_module_path = Some "Css_types.GeometryBox"

let gradient : gradient Rule.rule = [%spec "<linear-gradient()> | <repeating-linear-gradient()> | <radial-gradient()> | \
   <repeating-radial-gradient()> | <conic-gradient()> | <legacy-gradient>"]
let gradient_runtime_module_path = Some "Css_types.Gradient"

let grid_line : grid_line Rule.rule = [%spec "<custom-ident-without-span-or-auto> | <integer> && [ \
   <custom-ident-without-span-or-auto> ]? | 'span' && [ <integer> || \
   <custom-ident-without-span-or-auto> ] | 'auto' | <interpolation>"]
let grid_line_runtime_module_path = Some "Css_types.GridLine"

let historical_lig_values : historical_lig_values Rule.rule = [%spec "'historical-ligatures' | 'no-historical-ligatures'"]
let historical_lig_values_runtime_module_path = Some "Css_types.HistoricalLigValues"

let hue : hue Rule.rule = [%spec "<number> | <extended-angle>"]
let hue_runtime_module_path = Some "Css_types.Hue"

let id_selector : id_selector Rule.rule = [%spec "<hash-token>"]
let id_selector_runtime_module_path = Some "Css_types.IdSelector"

let image : image Rule.rule = [%spec "<url> | <image()> | <image-set()> | <element()> | <paint()> | \
   <cross-fade()> | <gradient> | <interpolation>"]
let image_runtime_module_path = Some "Css_types.Image"

let image_set_option : image_set_option Rule.rule = [%spec "[ <image> | <string> ] <resolution>"]
let image_set_option_runtime_module_path = Some "Css_types.ImageSetOption"

let image_src : image_src Rule.rule = [%spec "<url> | <string>"]
let image_src_runtime_module_path = Some "Css_types.ImageSrc"

let image_tags : image_tags Rule.rule = [%spec "'ltr' | 'rtl'"]
let image_tags_runtime_module_path = Some "Css_types.ImageTags"

let inflexible_breadth : inflexible_breadth Rule.rule = [%spec "<extended-length> | <extended-percentage> | 'min-content' | 'max-content' | \
   'auto'"]
let inflexible_breadth_runtime_module_path = Some "Css_types.InflexibleBreadth"

let keyframe_block : keyframe_block Rule.rule = [%spec "[ <keyframe-selector> ]# '{' <declaration-list> '}'"]
let keyframe_block_runtime_module_path = Some "Css_types.KeyframeBlock"

let keyframe_block_list : keyframe_block_list Rule.rule = [%spec "[ <keyframe-block> ]+"]
let keyframe_block_list_runtime_module_path = Some "Css_types.KeyframeBlockList"

let keyframe_selector : keyframe_selector Rule.rule = [%spec "'from' | 'to' | <extended-percentage>"]
let keyframe_selector_runtime_module_path = Some "Css_types.KeyframeSelector"

let keyframes_name : keyframes_name Rule.rule = [%spec "<custom-ident> | <string>"]
let keyframes_name_runtime_module_path = Some "Css_types.KeyframesName"

let leader_type : leader_type Rule.rule = [%spec "'dotted' | 'solid' | 'space' | <string>"]
let leader_type_runtime_module_path = Some "Css_types.LeaderType"

let left : left Rule.rule = [%spec "<extended-length> | 'auto'"]
let left_runtime_module_path = Some "Css_types.Left"

let line_name_list : line_name_list Rule.rule = [%spec "[ <line-names> | <name-repeat> ]+"]
let line_name_list_runtime_module_path = Some "Css_types.LineNameList"

let line_style : line_style Rule.rule = [%spec "'none' | 'hidden' | 'dotted' | 'dashed' | 'solid' | 'double' | 'groove' | \
   'ridge' | 'inset' | 'outset'"]
let line_style_runtime_module_path = Some "Css_types.LineStyle"

let line_width : line_width Rule.rule = [%spec "<extended-length> | 'thin' | 'medium' | 'thick'"]
let line_width_runtime_module_path = Some "Css_types.LineWidth"

let linear_color_hint : linear_color_hint Rule.rule = [%spec "<extended-length> | <extended-percentage>"]
let linear_color_hint_runtime_module_path = Some "Css_types.LinearColorHint"

let linear_color_stop : linear_color_stop Rule.rule = [%spec "<color> <length-percentage>?"]
let linear_color_stop_runtime_module_path = Some "Css_types.LinearColorStop"

let mask_image : mask_image Rule.rule = [%spec "[ <mask-reference> ]#"]
let mask_image_runtime_module_path = Some "Css_types.MaskImage"

let mask_layer : mask_layer Rule.rule = [%spec "<mask-reference> || <position> [ '/' <bg-size> ]? || <repeat-style> || \
   <geometry-box> || [ <geometry-box> | 'no-clip' ] || <compositing-operator> \
   || <masking-mode>"]
let mask_layer_runtime_module_path = Some "Css_types.MaskLayer"

let mask_position : mask_position Rule.rule = [%spec "[ <extended-length> | <extended-percentage> | 'left' | 'center' | 'right' ] \
   [ <extended-length> | <extended-percentage> | 'top' | 'center' | 'bottom' \
   ]?"]
let mask_position_runtime_module_path = Some "Css_types.MaskPosition"

let mask_reference : mask_reference Rule.rule = [%spec "'none' | <image> | <mask-source>"]
let mask_reference_runtime_module_path = Some "Css_types.MaskReference"

let mask_source : mask_source Rule.rule = [%spec "<url>"]
let mask_source_runtime_module_path = Some "Css_types.MaskSource"

let masking_mode : masking_mode Rule.rule = [%spec "'alpha' | 'luminance' | 'match-source'"]
let masking_mode_runtime_module_path = Some "Css_types.MaskingMode"

let mf_comparison : mf_comparison Rule.rule = [%spec "<mf-lt> | <mf-gt> | <mf-eq>"]
let mf_comparison_runtime_module_path = Some "Css_types.MfComparison"

let mf_eq : mf_eq Rule.rule = [%spec "'='"]
let mf_eq_runtime_module_path = Some "Css_types.MfEq"

let mf_gt : mf_gt Rule.rule = [%spec "'>=' | '>'"]
let mf_gt_runtime_module_path = Some "Css_types.MfGt"

let mf_lt : mf_lt Rule.rule = [%spec "'<=' | '<'"]
let mf_lt_runtime_module_path = Some "Css_types.MfLt"

let mf_value : mf_value Rule.rule = [%spec "<number> | <dimension> | <ident> | <ratio> | <interpolation> | <calc()>"]
let mf_value_runtime_module_path = Some "Css_types.MfValue"

let mf_name : mf_name Rule.rule = [%spec "<ident>"]
let mf_name_runtime_module_path = Some "Css_types.MfName"

let mf_range : mf_range Rule.rule = [%spec "<mf-name> <mf-comparison> <mf-value> | <mf-value> <mf-comparison> <mf-name> \
   | <mf-value> <mf-lt> <mf-name> <mf-lt> <mf-value> | <mf-value> <mf-gt> \
   <mf-name> <mf-gt> <mf-value>"]
let mf_range_runtime_module_path = Some "Css_types.MfRange"

let mf_boolean : mf_boolean Rule.rule = [%spec "<mf-name>"]
let mf_boolean_runtime_module_path = Some "Css_types.MfBoolean"

let mf_plain : mf_plain Rule.rule = [%spec "<mf-name> ':' <mf-value>"]
let mf_plain_runtime_module_path = Some "Css_types.MfPlain"

let media_feature : media_feature Rule.rule = [%spec "'(' [ <mf-plain> | <mf-boolean> | <mf-range> ] ')'"]
let media_feature_runtime_module_path = Some "Css_types.MediaFeature"

let media_in_parens : media_in_parens Rule.rule = [%spec "'(' <media-condition> ')' | <media-feature> | <interpolation>"]
let media_in_parens_runtime_module_path = Some "Css_types.MediaInParens"

let media_and : media_and Rule.rule = [%spec "'and' <media-in-parens>"]
let media_and_runtime_module_path = Some "Css_types.MediaAnd"

let media_or : media_or Rule.rule = [%spec "'or' <media-in-parens>"]
let media_or_runtime_module_path = Some "Css_types.MediaOr"

let media_not : media_not Rule.rule = [%spec "'not' <media-in-parens>"]
let media_not_runtime_module_path = Some "Css_types.MediaNot"

let media_condition_without_or : media_condition_without_or Rule.rule = [%spec "<media-not> | <media-in-parens> <media-and>*"]
let media_condition_without_or_runtime_module_path = Some "Css_types.MediaConditionWithoutOr"

let media_condition : media_condition Rule.rule = [%spec "<media-not> | <media-in-parens> [ <media-and>* | <media-or>* ]"]
let media_condition_runtime_module_path = Some "Css_types.MediaCondition"

let media_query : media_query Rule.rule = [%spec "<media-condition> | [ 'not' | 'only' ]? <media-type> [ 'and' \
   <media-condition-without-or> ]?"]
let media_query_runtime_module_path = Some "Css_types.MediaQuery"

let media_query_list : media_query_list Rule.rule = [%spec "[ <media-query> ]# | <interpolation>"]
let media_query_list_runtime_module_path = Some "Css_types.MediaQueryList"

let container_condition_list : container_condition_list Rule.rule = [%spec "<container-condition>#"]
let container_condition_list_runtime_module_path = Some "Css_types.ContainerConditionList"

let container_condition : container_condition Rule.rule = [%spec "[ <container-name> ]? <container-query>"]
let container_condition_runtime_module_path = Some "Css_types.ContainerCondition"

let container_query : container_query Rule.rule = [%spec "'not' <query-in-parens> | <query-in-parens> [ [ 'and' <query-in-parens> ]* \
   | [ 'or' <query-in-parens> ]* ]"]
let container_query_runtime_module_path = Some "Css_types.ContainerQuery"

let query_in_parens : query_in_parens Rule.rule = [%spec "'(' <container-query> ')' | '(' <size-feature> ')' | style( <style-query> )"]
let query_in_parens_runtime_module_path = Some "Css_types.QueryInParens"

let size_feature : size_feature Rule.rule = [%spec "<mf-plain> | <mf-boolean> | <mf-range>"]
let size_feature_runtime_module_path = Some "Css_types.SizeFeature"

let style_query : style_query Rule.rule = [%spec "'not' <style-in-parens> | <style-in-parens> [ [ module <style-in-parens> ]* \
   | [ or <style-in-parens> ]* ] | <style-feature>"]
let style_query_runtime_module_path = Some "Css_types.StyleQuery"

let style_feature : style_feature Rule.rule = [%spec "<dashed_ident> ':' <mf-value>"]
let style_feature_runtime_module_path = Some "Css_types.StyleFeature"

let style_in_parens : style_in_parens Rule.rule = [%spec "'(' <style-query> ')' | '(' <style-feature> ')'"]
let style_in_parens_runtime_module_path = Some "Css_types.StyleInParens"

let name_repeat : name_repeat Rule.rule = [%spec "repeat( [ <positive-integer> | 'auto-fill' ] ',' [ <line-names> ]+ )"]
let name_repeat_runtime_module_path = Some "Css_types.NameRepeat"

let named_color : named_color Rule.rule = [%spec "'transparent' | 'aliceblue' | 'antiquewhite' | 'aqua' | 'aquamarine' | \
   'azure' | 'beige' | 'bisque' | 'black' | 'blanchedalmond' | 'blue' | \
   'blueviolet' | 'brown' | 'burlywood' | 'cadetblue' | 'chartreuse' | \
   'chocolate' | 'coral' | 'cornflowerblue' | 'cornsilk' | 'crimson' | 'cyan' \
   | 'darkblue' | 'darkcyan' | 'darkgoldenrod' | 'darkgray' | 'darkgreen' | \
   'darkgrey' | 'darkkhaki' | 'darkmagenta' | 'darkolivegreen' | 'darkorange' \
   | 'darkorchid' | 'darkred' | 'darksalmon' | 'darkseagreen' | \
   'darkslateblue' | 'darkslategray' | 'darkslategrey' | 'darkturquoise' | \
   'darkviolet' | 'deeppink' | 'deepskyblue' | 'dimgray' | 'dimgrey' | \
   'dodgerblue' | 'firebrick' | 'floralwhite' | 'forestgreen' | 'fuchsia' | \
   'gainsboro' | 'ghostwhite' | 'gold' | 'goldenrod' | 'gray' | 'green' | \
   'greenyellow' | 'grey' | 'honeydew' | 'hotpink' | 'indianred' | 'indigo' | \
   'ivory' | 'khaki' | 'lavender' | 'lavenderblush' | 'lawngreen' | \
   'lemonchiffon' | 'lightblue' | 'lightcoral' | 'lightcyan' | \
   'lightgoldenrodyellow' | 'lightgray' | 'lightgreen' | 'lightgrey' | \
   'lightpink' | 'lightsalmon' | 'lightseagreen' | 'lightskyblue' | \
   'lightslategray' | 'lightslategrey' | 'lightsteelblue' | 'lightyellow' | \
   'lime' | 'limegreen' | 'linen' | 'magenta' | 'maroon' | 'mediumaquamarine' \
   | 'mediumblue' | 'mediumorchid' | 'mediumpurple' | 'mediumseagreen' | \
   'mediumslateblue' | 'mediumspringgreen' | 'mediumturquoise' | \
   'mediumvioletred' | 'midnightblue' | 'mintcream' | 'mistyrose' | 'moccasin' \
   | 'navajowhite' | 'navy' | 'oldlace' | 'olive' | 'olivedrab' | 'orange' | \
   'orangered' | 'orchid' | 'palegoldenrod' | 'palegreen' | 'paleturquoise' | \
   'palevioletred' | 'papayawhip' | 'peachpuff' | 'peru' | 'pink' | 'plum' | \
   'powderblue' | 'purple' | 'rebeccapurple' | 'red' | 'rosybrown' | \
   'royalblue' | 'saddlebrown' | 'salmon' | 'sandybrown' | 'seagreen' | \
   'seashell' | 'sienna' | 'silver' | 'skyblue' | 'slateblue' | 'slategray' | \
   'slategrey' | 'snow' | 'springgreen' | 'steelblue' | 'tan' | 'teal' | \
   'thistle' | 'tomato' | 'turquoise' | 'violet' | 'wheat' | 'white' | \
   'whitesmoke' | 'yellow' | 'yellowgreen' | <-non-standard-color>"]
let named_color_runtime_module_path = Some "Css_types.NamedColor"

let namespace_prefix : namespace_prefix Rule.rule = [%spec "<ident>"]
let namespace_prefix_runtime_module_path = Some "Css_types.NamespacePrefix"

let ns_prefix : ns_prefix Rule.rule = [%spec "[ <ident-token> | '*' ]? '|'"]
let ns_prefix_runtime_module_path = Some "Css_types.NsPrefix"

let nth : nth Rule.rule = [%spec "<an-plus-b> | 'even' | 'odd'"]
let nth_runtime_module_path = Some "Css_types.Nth"

let number_one_or_greater : number_one_or_greater Rule.rule = [%spec "<number>"]
let number_one_or_greater_runtime_module_path = Some "Css_types.NumberOneOrGreater"

let number_percentage : number_percentage Rule.rule = [%spec "<number> | <extended-percentage>"]
let number_percentage_runtime_module_path = Some "Css_types.NumberPercentage"

let number_zero_one : number_zero_one Rule.rule = [%spec "<number>"]
let number_zero_one_runtime_module_path = Some "Css_types.NumberZeroOne"

let numeric_figure_values : numeric_figure_values Rule.rule = [%spec "'lining-nums' | 'oldstyle-nums'"]
let numeric_figure_values_runtime_module_path = Some "Css_types.NumericFigureValues"

let numeric_fraction_values : numeric_fraction_values Rule.rule = [%spec "'diagonal-fractions' | 'stacked-fractions'"]
let numeric_fraction_values_runtime_module_path = Some "Css_types.NumericFractionValues"

let numeric_spacing_values : numeric_spacing_values Rule.rule = [%spec "'proportional-nums' | 'tabular-nums'"]
let numeric_spacing_values_runtime_module_path = Some "Css_types.NumericSpacingValues"

let outline_radius : outline_radius Rule.rule = [%spec "<extended-length> | <extended-percentage>"]
let outline_radius_runtime_module_path = Some "Css_types.OutlineRadius"

let overflow_position : overflow_position Rule.rule = [%spec "'unsafe' | 'safe'"]
let overflow_position_runtime_module_path = Some "Css_types.OverflowPosition"

let page_body : page_body Rule.rule = [%spec "[ <declaration> ]? [ ';' <page-body> ]? | <page-margin-box> <page-body>"]
let page_body_runtime_module_path = Some "Css_types.PageBody"

let page_margin_box : page_margin_box Rule.rule = [%spec "<page-margin-box-type> '{' <declaration-list> '}'"]
let page_margin_box_runtime_module_path = Some "Css_types.PageMarginBox"

let page_margin_box_type : page_margin_box_type Rule.rule = [%spec "'@top-left-corner' | '@top-left' | '@top-center' | '@top-right' | \
   '@top-right-corner' | '@bottom-left-corner' | '@bottom-left' | \
   '@bottom-center' | '@bottom-right' | '@bottom-right-corner' | '@left-top' | \
   '@left-middle' | '@left-bottom' | '@right-top' | '@right-middle' | \
   '@right-bottom'"]
let page_margin_box_type_runtime_module_path = Some "Css_types.PageMarginBoxType"

let page_selector : page_selector Rule.rule = [%spec "[ <pseudo-page> ]+ | <ident> [ <pseudo-page> ]*"]
let page_selector_runtime_module_path = Some "Css_types.PageSelector"

let page_selector_list : page_selector_list Rule.rule = [%spec "[ [ <page-selector> ]# ]?"]
let page_selector_list_runtime_module_path = Some "Css_types.PageSelectorList"

let paint : paint Rule.rule = [%spec "'none' | <color> | <url> [ 'none' | <color> ]? | 'context-fill' | \
   'context-stroke' | <interpolation>"]
let paint_runtime_module_path = Some "Css_types.Paint"

let position : position Rule.rule = [%spec "[ 'left' | 'center' | 'right' | 'top' | 'bottom' | <length-percentage> ] | \
   [ 'left' | 'center' | 'right' ] && [ 'top' | 'center' | 'bottom' ] | [ \
   'left' | 'center' | 'right' | <length-percentage> ] [ 'top' | 'center' | \
   'bottom' | <length-percentage> ] | [ [ 'left' | 'right' ] \
   <length-percentage> ] && [ [ 'top' | 'bottom' ] <length-percentage> ]"]
let position_runtime_module_path = Some "Css_types.Position"

let positive_integer : positive_integer Rule.rule = [%spec "<integer>"]
let positive_integer_runtime_module_path = Some "Css_types.PositiveInteger"

let property__moz_appearance : property__moz_appearance Rule.rule = [%spec "'none' | 'button' | 'button-arrow-down' | 'button-arrow-next' | \
   'button-arrow-previous' | 'button-arrow-up' | 'button-bevel' | \
   'button-focus' | 'caret' | 'checkbox' | 'checkbox-container' | \
   'checkbox-label' | 'checkmenuitem' | 'dualbutton' | 'groupbox' | 'listbox' \
   | 'listitem' | 'menuarrow' | 'menubar' | 'menucheckbox' | 'menuimage' | \
   'menuitem' | 'menuitemtext' | 'menulist' | 'menulist-button' | \
   'menulist-text' | 'menulist-textfield' | 'menupopup' | 'menuradio' | \
   'menuseparator' | 'meterbar' | 'meterchunk' | 'progressbar' | \
   'progressbar-vertical' | 'progresschunk' | 'progresschunk-vertical' | \
   'radio' | 'radio-container' | 'radio-label' | 'radiomenuitem' | 'range' | \
   'range-thumb' | 'resizer' | 'resizerpanel' | 'scale-horizontal' | \
   'scalethumbend' | 'scalethumb-horizontal' | 'scalethumbstart' | \
   'scalethumbtick' | 'scalethumb-vertical' | 'scale-vertical' | \
   'scrollbarbutton-down' | 'scrollbarbutton-left' | 'scrollbarbutton-right' | \
   'scrollbarbutton-up' | 'scrollbarthumb-horizontal' | \
   'scrollbarthumb-vertical' | 'scrollbartrack-horizontal' | \
   'scrollbartrack-vertical' | 'searchfield' | 'separator' | 'sheet' | \
   'spinner' | 'spinner-downbutton' | 'spinner-textfield' | 'spinner-upbutton' \
   | 'splitter' | 'statusbar' | 'statusbarpanel' | 'tab' | 'tabpanel' | \
   'tabpanels' | 'tab-scroll-arrow-back' | 'tab-scroll-arrow-forward' | \
   'textfield' | 'textfield-multiline' | 'toolbar' | 'toolbarbutton' | \
   'toolbarbutton-dropdown' | 'toolbargripper' | 'toolbox' | 'tooltip' | \
   'treeheader' | 'treeheadercell' | 'treeheadersortarrow' | 'treeitem' | \
   'treeline' | 'treetwisty' | 'treetwistyopen' | 'treeview' | \
   '-moz-mac-unified-toolbar' | '-moz-win-borderless-glass' | \
   '-moz-win-browsertabbar-toolbox' | '-moz-win-communicationstext' | \
   '-moz-win-communications-toolbox' | '-moz-win-exclude-glass' | \
   '-moz-win-glass' | '-moz-win-mediatext' | '-moz-win-media-toolbox' | \
   '-moz-window-button-box' | '-moz-window-button-box-maximized' | \
   '-moz-window-button-close' | '-moz-window-button-maximize' | \
   '-moz-window-button-minimize' | '-moz-window-button-restore' | \
   '-moz-window-frame-bottom' | '-moz-window-frame-left' | \
   '-moz-window-frame-right' | '-moz-window-titlebar' | \
   '-moz-window-titlebar-maximized'"]
let property__moz_appearance_runtime_module_path = Some "Css_types.MozAppearance"

let property__moz_background_clip : property__moz_background_clip Rule.rule = [%spec "'padding' | 'border'"]
let property__moz_background_clip_runtime_module_path = Some "Css_types.MozBackgroundClip"

let property__moz_binding : property__moz_binding Rule.rule = [%spec "<url> | 'none'"]
let property__moz_binding_runtime_module_path = Some "Css_types.MozBinding"

let property__moz_border_bottom_colors : property__moz_border_bottom_colors Rule.rule = [%spec "[ <color> ]+ | 'none'"]
let property__moz_border_bottom_colors_runtime_module_path = Some "Css_types.MozBorderBottomColors"

let property__moz_border_left_colors : property__moz_border_left_colors Rule.rule = [%spec "[ <color> ]+ | 'none'"]
let property__moz_border_left_colors_runtime_module_path = Some "Css_types.MozBorderLeftColors"

let property__moz_border_radius_bottomleft : property__moz_border_radius_bottomleft Rule.rule = [%spec "<'border-bottom-left-radius'>"]
let property__moz_border_radius_bottomleft_runtime_module_path = Some "Css_types.MozBorderRadiusBottomleft"

let property__moz_border_radius_bottomright : property__moz_border_radius_bottomright Rule.rule = [%spec "<'border-bottom-right-radius'>"]
let property__moz_border_radius_bottomright_runtime_module_path = Some "Css_types.MozBorderRadiusBottomright"

let property__moz_border_radius_topleft : property__moz_border_radius_topleft Rule.rule = [%spec "<'border-top-left-radius'>"]
let property__moz_border_radius_topleft_runtime_module_path = Some "Css_types.MozBorderRadiusTopleft"

let property__moz_border_radius_topright : property__moz_border_radius_topright Rule.rule = [%spec "<'border-bottom-right-radius'>"]
let property__moz_border_radius_topright_runtime_module_path = Some "Css_types.MozBorderRadiusTopright"

let property__moz_border_right_colors : property__moz_border_right_colors Rule.rule = [%spec "[ <color> ]+ | 'none'"]
let property__moz_border_right_colors_runtime_module_path = Some "Css_types.MozBorderRightColors"

let property__moz_border_top_colors : property__moz_border_top_colors Rule.rule = [%spec "[ <color> ]+ | 'none'"]
let property__moz_border_top_colors_runtime_module_path = Some "Css_types.MozBorderTopColors"

let property__moz_context_properties : property__moz_context_properties Rule.rule = [%spec "'none' | [ 'fill' | 'fill-opacity' | 'stroke' | 'stroke-opacity' ]#"]
let property__moz_context_properties_runtime_module_path = Some "Css_types.MozContextProperties"

let property__moz_control_character_visibility : property__moz_control_character_visibility Rule.rule = [%spec "'visible' | 'hidden'"]
let property__moz_control_character_visibility_runtime_module_path = Some "Css_types.MozControlCharacterVisibility"

let property__moz_float_edge : property__moz_float_edge Rule.rule = [%spec "'border-box' | 'content-box' | 'margin-box' | 'padding-box'"]
let property__moz_float_edge_runtime_module_path = Some "Css_types.MozFloatEdge"

let property__moz_force_broken_image_icon : property__moz_force_broken_image_icon Rule.rule = [%spec "<integer>"]
let property__moz_force_broken_image_icon_runtime_module_path = Some "Css_types.MozForceBrokenImageIcon"

let property__moz_image_region : property__moz_image_region Rule.rule = [%spec "<shape> | 'auto'"]
let property__moz_image_region_runtime_module_path = Some "Css_types.MozImageRegion"

let property__moz_orient : property__moz_orient Rule.rule = [%spec "'inline' | 'block' | 'horizontal' | 'vertical'"]
let property__moz_orient_runtime_module_path = Some "Css_types.MozOrient"

let property__moz_osx_font_smoothing : property__moz_osx_font_smoothing Rule.rule = [%spec "'auto' | 'grayscale'"]
let property__moz_osx_font_smoothing_runtime_module_path = Some "Css_types.MozOsxFontSmoothing"

let property__moz_outline_radius : property__moz_outline_radius Rule.rule = [%spec "[ <outline-radius> ]{1,4} [ '/' [ <outline-radius> ]{1,4} ]?"]
let property__moz_outline_radius_runtime_module_path = Some "Css_types.MozOutlineRadius"

let property__moz_outline_radius_bottomleft : property__moz_outline_radius_bottomleft Rule.rule = [%spec "<outline-radius>"]
let property__moz_outline_radius_bottomleft_runtime_module_path = Some "Css_types.MozOutlineRadiusBottomleft"

let property__moz_outline_radius_bottomright : property__moz_outline_radius_bottomright Rule.rule = [%spec "<outline-radius>"]
let property__moz_outline_radius_bottomright_runtime_module_path = Some "Css_types.MozOutlineRadiusBottomright"

let property__moz_outline_radius_topleft : property__moz_outline_radius_topleft Rule.rule = [%spec "<outline-radius>"]
let property__moz_outline_radius_topleft_runtime_module_path = Some "Css_types.MozOutlineRadiusTopleft"

let property__moz_outline_radius_topright : property__moz_outline_radius_topright Rule.rule = [%spec "<outline-radius>"]
let property__moz_outline_radius_topright_runtime_module_path = Some "Css_types.MozOutlineRadiusTopright"

let property__moz_stack_sizing : property__moz_stack_sizing Rule.rule = [%spec "'ignore' | 'stretch-to-fit'"]
let property__moz_stack_sizing_runtime_module_path = Some "Css_types.MozStackSizing"

let property__moz_text_blink : property__moz_text_blink Rule.rule = [%spec "'none' | 'blink'"]
let property__moz_text_blink_runtime_module_path = Some "Css_types.MozTextBlink"

let property__moz_user_focus : property__moz_user_focus Rule.rule = [%spec "'ignore' | 'normal' | 'select-after' | 'select-before' | 'select-menu' | \
   'select-same' | 'select-all' | 'none'"]
let property__moz_user_focus_runtime_module_path = Some "Css_types.MozUserFocus"

let property__moz_user_input : property__moz_user_input Rule.rule = [%spec "'auto' | 'none' | 'enabled' | 'disabled'"]
let property__moz_user_input_runtime_module_path = Some "Css_types.MozUserInput"

let property__moz_user_modify : property__moz_user_modify Rule.rule = [%spec "'read-only' | 'read-write' | 'write-only'"]
let property__moz_user_modify_runtime_module_path = Some "Css_types.MozUserModify"

let property__moz_user_select : property__moz_user_select Rule.rule = [%spec "'none' | 'text' | 'all' | '-moz-none'"]
let property__moz_user_select_runtime_module_path = Some "Css_types.MozUserSelect"

let property__moz_window_dragging : property__moz_window_dragging Rule.rule = [%spec "'drag' | 'no-drag'"]
let property__moz_window_dragging_runtime_module_path = Some "Css_types.MozWindowDragging"

let property__moz_window_shadow : property__moz_window_shadow Rule.rule = [%spec "'default' | 'menu' | 'tooltip' | 'sheet' | 'none'"]
let property__moz_window_shadow_runtime_module_path = Some "Css_types.MozWindowShadow"

let property__webkit_appearance : property__webkit_appearance Rule.rule = [%spec "'none' | 'button' | 'button-bevel' | 'caps-lock-indicator' | 'caret' | \
   'checkbox' | 'default-button' | 'listbox' | 'listitem' | \
   'media-fullscreen-button' | 'media-mute-button' | 'media-play-button' | \
   'media-seek-back-button' | 'media-seek-forward-button' | 'media-slider' | \
   'media-sliderthumb' | 'menulist' | 'menulist-button' | 'menulist-text' | \
   'menulist-textfield' | 'push-button' | 'radio' | 'scrollbarbutton-down' | \
   'scrollbarbutton-left' | 'scrollbarbutton-right' | 'scrollbarbutton-up' | \
   'scrollbargripper-horizontal' | 'scrollbargripper-vertical' | \
   'scrollbarthumb-horizontal' | 'scrollbarthumb-vertical' | \
   'scrollbartrack-horizontal' | 'scrollbartrack-vertical' | 'searchfield' | \
   'searchfield-cancel-button' | 'searchfield-decoration' | \
   'searchfield-results-button' | 'searchfield-results-decoration' | \
   'slider-horizontal' | 'slider-vertical' | 'sliderthumb-horizontal' | \
   'sliderthumb-vertical' | 'square-button' | 'textarea' | 'textfield'"]
let property__webkit_appearance_runtime_module_path = Some "Css_types.WebkitAppearance"

let property__webkit_background_clip : property__webkit_background_clip Rule.rule = [%spec "[ <box> | 'border' | 'padding' | 'content' | 'text' ]#"]
let property__webkit_background_clip_runtime_module_path = Some "Css_types.WebkitBackgroundClip"

let property__webkit_border_before : property__webkit_border_before Rule.rule = [%spec "<'border-width'> || <'border-style'> || <'color'>"]
let property__webkit_border_before_runtime_module_path = Some "Css_types.WebkitBorderBefore"

let property__webkit_border_before_color : property__webkit_border_before_color Rule.rule = [%spec "<'color'>"]
let property__webkit_border_before_color_runtime_module_path = Some "Css_types.WebkitBorderBeforeColor"

let property__webkit_border_before_style : property__webkit_border_before_style Rule.rule = [%spec "<'border-style'>"]
let property__webkit_border_before_style_runtime_module_path = Some "Css_types.WebkitBorderBeforeStyle"

let property__webkit_border_before_width : property__webkit_border_before_width Rule.rule = [%spec "<'border-width'>"]
let property__webkit_border_before_width_runtime_module_path = Some "Css_types.WebkitBorderBeforeWidth"

let property__webkit_box_reflect : property__webkit_box_reflect Rule.rule = [%spec "[ 'above' | 'below' | 'right' | 'left' ]? [ <extended-length> ]? [ <image> \
   ]?"]
let property__webkit_box_reflect_runtime_module_path = Some "Css_types.WebkitBoxReflect"

let property__webkit_column_break_after : property__webkit_column_break_after Rule.rule = [%spec "'always' | 'auto' | 'avoid'"]
let property__webkit_column_break_after_runtime_module_path = Some "Css_types.WebkitColumnBreakAfter"

let property__webkit_column_break_before : property__webkit_column_break_before Rule.rule = [%spec "'always' | 'auto' | 'avoid'"]
let property__webkit_column_break_before_runtime_module_path = Some "Css_types.WebkitColumnBreakBefore"

let property__webkit_column_break_inside : property__webkit_column_break_inside Rule.rule = [%spec "'always' | 'auto' | 'avoid'"]
let property__webkit_column_break_inside_runtime_module_path = Some "Css_types.WebkitColumnBreakInside"

let property__webkit_font_smoothing : property__webkit_font_smoothing Rule.rule = [%spec "'auto' | 'none' | 'antialiased' | 'subpixel-antialiased'"]
let property__webkit_font_smoothing_runtime_module_path = Some "Css_types.WebkitFontSmoothing"

let property__webkit_line_clamp : property__webkit_line_clamp Rule.rule = [%spec "'none' | <integer>"]
let property__webkit_line_clamp_runtime_module_path = Some "Css_types.WebkitLineClamp"

let property__webkit_mask : property__webkit_mask Rule.rule = [%spec "[ <mask-reference> || <position> [ '/' <bg-size> ]? || <repeat-style> || [ \
   <box> | 'border' | 'padding' | 'content' | 'text' ] || [ <box> | 'border' | \
   'padding' | 'content' ] ]#"]
let property__webkit_mask_runtime_module_path = Some "Css_types.WebkitMask"

let property__webkit_mask_attachment : property__webkit_mask_attachment Rule.rule = [%spec "[ <attachment> ]#"]
let property__webkit_mask_attachment_runtime_module_path = Some "Css_types.WebkitMaskAttachment"

let property__webkit_mask_box_image : property__webkit_mask_box_image Rule.rule = [%spec "[ <url> | <gradient> | 'none' ] [ [ <extended-length> | \
   <extended-percentage> ]{4} [ <webkit-mask-box-repeat> ]{2} ]?"]
let property__webkit_mask_box_image_runtime_module_path = Some "Css_types.WebkitMaskBoxImage"

let property__webkit_mask_clip : property__webkit_mask_clip Rule.rule = [%spec "[ <box> | 'border' | 'padding' | 'content' | 'text' ]#"]
let property__webkit_mask_clip_runtime_module_path = Some "Css_types.WebkitMaskClip"

let property__webkit_mask_composite : property__webkit_mask_composite Rule.rule = [%spec "[ <composite-style> ]#"]
let property__webkit_mask_composite_runtime_module_path = Some "Css_types.WebkitMaskComposite"

let property__webkit_mask_image : property__webkit_mask_image Rule.rule = [%spec "[ <mask-reference> ]#"]
let property__webkit_mask_image_runtime_module_path = Some "Css_types.WebkitMaskImage"

let property__webkit_mask_origin : property__webkit_mask_origin Rule.rule = [%spec "[ <box> | 'border' | 'padding' | 'content' ]#"]
let property__webkit_mask_origin_runtime_module_path = Some "Css_types.WebkitMaskOrigin"

let property__webkit_mask_position : property__webkit_mask_position Rule.rule = [%spec "[ <position> ]#"]
let property__webkit_mask_position_runtime_module_path = Some "Css_types.WebkitMaskPosition"

let property__webkit_mask_position_x : property__webkit_mask_position_x Rule.rule = [%spec "[ <extended-length> | <extended-percentage> | 'left' | 'center' | 'right' ]#"]
let property__webkit_mask_position_x_runtime_module_path = Some "Css_types.WebkitMaskPositionX"

let property__webkit_mask_position_y : property__webkit_mask_position_y Rule.rule = [%spec "[ <extended-length> | <extended-percentage> | 'top' | 'center' | 'bottom' ]#"]
let property__webkit_mask_position_y_runtime_module_path = Some "Css_types.WebkitMaskPositionY"

let property__webkit_mask_repeat : property__webkit_mask_repeat Rule.rule = [%spec "[ <repeat-style> ]#"]
let property__webkit_mask_repeat_runtime_module_path = Some "Css_types.WebkitMaskRepeat"

let property__webkit_mask_repeat_x : property__webkit_mask_repeat_x Rule.rule = [%spec "'repeat' | 'no-repeat' | 'space' | 'round'"]
let property__webkit_mask_repeat_x_runtime_module_path = Some "Css_types.WebkitMaskRepeatX"

let property__webkit_mask_repeat_y : property__webkit_mask_repeat_y Rule.rule = [%spec "'repeat' | 'no-repeat' | 'space' | 'round'"]
let property__webkit_mask_repeat_y_runtime_module_path = Some "Css_types.WebkitMaskRepeatY"

let property__webkit_mask_size : property__webkit_mask_size Rule.rule = [%spec "[ <bg-size> ]#"]
let property__webkit_mask_size_runtime_module_path = Some "Css_types.WebkitMaskSize"

let property__webkit_overflow_scrolling : property__webkit_overflow_scrolling Rule.rule = [%spec "'auto' | 'touch'"]
let property__webkit_overflow_scrolling_runtime_module_path = Some "Css_types.WebkitOverflowScrolling"

let property__webkit_print_color_adjust : property__webkit_print_color_adjust Rule.rule = [%spec "'economy' | 'exact'"]
let property__webkit_print_color_adjust_runtime_module_path = Some "Css_types.WebkitPrintColorAdjust"

let property__webkit_tap_highlight_color : property__webkit_tap_highlight_color Rule.rule = [%spec "<color>"]
let property__webkit_tap_highlight_color_runtime_module_path = Some "Css_types.WebkitTapHighlightColor"

let property__webkit_text_fill_color : property__webkit_text_fill_color Rule.rule = [%spec "<color>"]
let property__webkit_text_fill_color_runtime_module_path = Some "Css_types.WebkitTextFillColor"

let property__webkit_text_security : property__webkit_text_security Rule.rule = [%spec "'none' | 'circle' | 'disc' | 'square'"]
let property__webkit_text_security_runtime_module_path = Some "Css_types.WebkitTextSecurity"

let property__webkit_text_stroke : property__webkit_text_stroke Rule.rule = [%spec "<extended-length> || <color>"]
let property__webkit_text_stroke_runtime_module_path = Some "Css_types.WebkitTextStroke"

let property__webkit_text_stroke_color : property__webkit_text_stroke_color Rule.rule = [%spec "<color>"]
let property__webkit_text_stroke_color_runtime_module_path = Some "Css_types.WebkitTextStrokeColor"

let property__webkit_text_stroke_width : property__webkit_text_stroke_width Rule.rule = [%spec "<extended-length>"]
let property__webkit_text_stroke_width_runtime_module_path = Some "Css_types.WebkitTextStrokeWidth"

let property__webkit_touch_callout : property__webkit_touch_callout Rule.rule = [%spec "'default' | 'none'"]
let property__webkit_touch_callout_runtime_module_path = Some "Css_types.WebkitTouchCallout"

let property__webkit_user_drag : property__webkit_user_drag Rule.rule = [%spec "'none' | 'element' | 'auto'"]
let property__webkit_user_drag_runtime_module_path = Some "Css_types.WebkitUserDrag"

let property__webkit_user_modify : property__webkit_user_modify Rule.rule = [%spec "'read-only' | 'read-write' | 'read-write-plaintext-only'"]
let property__webkit_user_modify_runtime_module_path = Some "Css_types.WebkitUserModify"

let property__webkit_user_select : property__webkit_user_select Rule.rule = [%spec "'auto' | 'none' | 'text' | 'all'"]
let property__webkit_user_select_runtime_module_path = Some "Css_types.WebkitUserSelect"

let property_align_content : property_align_content Rule.rule = [%spec "'normal' | <baseline-position> | <content-distribution> | [ \
   <overflow-position> ]? <content-position>"]
let property_align_content_runtime_module_path = Some "Css_types.AlignContent"

let property_align_items : property_align_items Rule.rule = [%spec "'normal' | 'stretch' | <baseline-position> | [ <overflow-position> ]? \
   <self-position> | <interpolation>"]
let property_align_items_runtime_module_path = Some "Css_types.AlignItems"

let property_align_self : property_align_self Rule.rule = [%spec "'auto' | 'normal' | 'stretch' | <baseline-position> | [ <overflow-position> \
   ]? <self-position> | <interpolation>"]
let property_align_self_runtime_module_path = Some "Css_types.AlignSelf"

let property_alignment_baseline : property_alignment_baseline Rule.rule = [%spec "'auto' | 'baseline' | 'before-edge' | 'text-before-edge' | 'middle' | \
   'central' | 'after-edge' | 'text-after-edge' | 'ideographic' | 'alphabetic' \
   | 'hanging' | 'mathematical'"]
let property_alignment_baseline_runtime_module_path = Some "Css_types.AlignmentBaseline"

let property_all : property_all Rule.rule = [%spec "'initial' | 'inherit' | 'unset' | 'revert'"]
let property_all_runtime_module_path = Some "Css_types.All"

let property_animation : property_animation Rule.rule = [%spec "[ <single-animation> | <single-animation-no-interp> ]#"]
let property_animation_runtime_module_path = Some "Css_types.Animation"

let property_animation_delay : property_animation_delay Rule.rule = [%spec "[ <extended-time> ]#"]
let property_animation_delay_runtime_module_path = Some "Css_types.AnimationDelay"

let property_animation_direction : property_animation_direction Rule.rule = [%spec "[ <single-animation-direction> ]#"]
let property_animation_direction_runtime_module_path = Some "Css_types.AnimationDirection"

let property_animation_duration : property_animation_duration Rule.rule = [%spec "[ <extended-time> ]#"]
let property_animation_duration_runtime_module_path = Some "Css_types.AnimationDuration"

let property_animation_fill_mode : property_animation_fill_mode Rule.rule = [%spec "[ <single-animation-fill-mode> ]#"]
let property_animation_fill_mode_runtime_module_path = Some "Css_types.AnimationFillMode"

let property_animation_iteration_count : property_animation_iteration_count Rule.rule = [%spec "[ <single-animation-iteration-count> ]#"]
let property_animation_iteration_count_runtime_module_path = Some "Css_types.AnimationIterationCount"

let property_animation_name : property_animation_name Rule.rule = [%spec "[ <keyframes-name> | 'none' | <interpolation> ]#"]

let property_animation_play_state : property_animation_play_state Rule.rule = [%spec "[ <single-animation-play-state> ]#"]
let property_animation_play_state_runtime_module_path = Some "Css_types.AnimationPlayState"

let property_animation_timing_function : property_animation_timing_function Rule.rule = [%spec "[ <timing-function> ]#"]
let property_animation_timing_function_runtime_module_path = Some "Css_types.AnimationTimingFunction"

let property_appearance : property_appearance Rule.rule = [%spec "'none' | 'auto' | 'button' | 'textfield' | 'menulist-button' | <compat-auto>"]
let property_appearance_runtime_module_path = Some "Css_types.Appearance"

let property_aspect_ratio : property_aspect_ratio Rule.rule = [%spec "'auto' | <ratio>"]
let property_aspect_ratio_runtime_module_path = Some "Css_types.AspectRatio"

let property_azimuth : property_azimuth Rule.rule = [%spec "<extended-angle> | [ 'left-side' | 'far-left' | 'left' | 'center-left' | \
   'center' | 'center-right' | 'right' | 'far-right' | 'right-side' ] || \
   'behind' | 'leftwards' | 'rightwards'"]
let property_azimuth_runtime_module_path = Some "Css_types.Azimuth"

let property_backdrop_filter : property_backdrop_filter Rule.rule = [%spec "'none' | <interpolation> | <filter-function-list>"]

let property_backface_visibility : property_backface_visibility Rule.rule = [%spec "'visible' | 'hidden'"]
let property_backface_visibility_runtime_module_path = Some "Css_types.BackfaceVisibility"

let property_background : property_background Rule.rule = [%spec "[ <bg-layer> ',' ]* <final-bg-layer>"]
let property_background_runtime_module_path = Some "Css_types.Background"

let property_background_attachment : property_background_attachment Rule.rule = [%spec "[ <attachment> ]#"]
let property_background_attachment_runtime_module_path = Some "Css_types.BackgroundAttachment"

let property_background_blend_mode : property_background_blend_mode Rule.rule = [%spec "[ <blend-mode> ]#"]
let property_background_blend_mode_runtime_module_path = Some "Css_types.BackgroundBlendMode"

let property_background_clip : property_background_clip Rule.rule = [%spec "[ <box> | 'text' | 'border-area' ]#"]
let property_background_clip_runtime_module_path = Some "Css_types.BackgroundClip"

let property_background_color : property_background_color Rule.rule = [%spec "<color>"]

let property_background_image : property_background_image Rule.rule = [%spec "[ <bg-image> ]#"]
let property_background_image_runtime_module_path = Some "Css_types.BackgroundImage"

let property_background_origin : property_background_origin Rule.rule = [%spec "[ <box> ]#"]
let property_background_origin_runtime_module_path = Some "Css_types.BackgroundOrigin"

let property_background_position : property_background_position Rule.rule = [%spec "[ <bg-position> ]#"]
let property_background_position_runtime_module_path = Some "Css_types.BackgroundPosition"

let property_background_position_x : property_background_position_x Rule.rule = [%spec "[ 'center' | [ 'left' | 'right' | 'x-start' | 'x-end' ]? [ \
   <extended-length> | <extended-percentage> ]? ]#"]
let property_background_position_x_runtime_module_path = Some "Css_types.BackgroundPositionX"

let property_background_position_y : property_background_position_y Rule.rule = [%spec "[ 'center' | [ 'top' | 'bottom' | 'y-start' | 'y-end' ]? [ \
   <extended-length> | <extended-percentage> ]? ]#"]
let property_background_position_y_runtime_module_path = Some "Css_types.BackgroundPositionY"

let property_background_repeat : property_background_repeat Rule.rule = [%spec "[ <repeat-style> ]#"]
let property_background_repeat_runtime_module_path = Some "Css_types.BackgroundRepeat"

let property_background_size : property_background_size Rule.rule = [%spec "[ <bg-size> ]#"]
let property_background_size_runtime_module_path = Some "Css_types.BackgroundSize"

let property_baseline_shift : property_baseline_shift Rule.rule = [%spec "'baseline' | 'sub' | 'super' | <svg-length>"]
let property_baseline_shift_runtime_module_path = Some "Css_types.BaselineShift"

let property_behavior : property_behavior Rule.rule = [%spec "[ <url> ]+"]
let property_behavior_runtime_module_path = Some "Css_types.Behavior"

let property_block_overflow : property_block_overflow Rule.rule = [%spec "'clip' | 'ellipsis' | <string>"]
let property_block_overflow_runtime_module_path = Some "Css_types.BlockOverflow"

let property_block_size : property_block_size Rule.rule = [%spec "<'width'>"]

let property_border : property_border Rule.rule = [%spec "'none' | [ <line-width> | <interpolation> ] | [ <line-width> | \
   <interpolation> ] [ <line-style> | <interpolation> ] | [ <line-width> | \
   <interpolation> ] [ <line-style> | <interpolation> ] [ <color> | \
   <interpolation> ]"]

let property_border_block : property_border_block Rule.rule = [%spec "<'border'>"]
let property_border_block_runtime_module_path = Some "Css_types.BorderBlock"

let property_border_block_color : property_border_block_color Rule.rule = [%spec "[ <'border-top-color'> ]{1,2}"]
let property_border_block_color_runtime_module_path = Some "Css_types.BorderBlockColor"

let property_border_block_end : property_border_block_end Rule.rule = [%spec "<'border'>"]
let property_border_block_end_runtime_module_path = Some "Css_types.BorderBlockEnd"

let property_border_block_end_color : property_border_block_end_color Rule.rule = [%spec "<'border-top-color'>"]
let property_border_block_end_color_runtime_module_path = Some "Css_types.BorderBlockEndColor"

let property_border_block_end_style : property_border_block_end_style Rule.rule = [%spec "<'border-top-style'>"]
let property_border_block_end_style_runtime_module_path = Some "Css_types.BorderBlockEndStyle"

let property_border_block_end_width : property_border_block_end_width Rule.rule = [%spec "<'border-top-width'>"]
let property_border_block_end_width_runtime_module_path = Some "Css_types.BorderBlockEndWidth"

let property_border_block_start : property_border_block_start Rule.rule = [%spec "<'border'>"]
let property_border_block_start_runtime_module_path = Some "Css_types.BorderBlockStart"

let property_border_block_start_color : property_border_block_start_color Rule.rule = [%spec "<'border-top-color'>"]
let property_border_block_start_color_runtime_module_path = Some "Css_types.BorderBlockStartColor"

let property_border_block_start_style : property_border_block_start_style Rule.rule = [%spec "<'border-top-style'>"]
let property_border_block_start_style_runtime_module_path = Some "Css_types.BorderBlockStartStyle"

let property_border_block_start_width : property_border_block_start_width Rule.rule = [%spec "<'border-top-width'>"]
let property_border_block_start_width_runtime_module_path = Some "Css_types.BorderBlockStartWidth"

let property_border_block_style : property_border_block_style Rule.rule = [%spec "<'border-top-style'>"]
let property_border_block_style_runtime_module_path = Some "Css_types.BorderBlockStyle"

let property_border_block_width : property_border_block_width Rule.rule = [%spec "<'border-top-width'>"]
let property_border_block_width_runtime_module_path = Some "Css_types.BorderBlockWidth"

let property_border_bottom : property_border_bottom Rule.rule = [%spec "<'border'>"]
let property_border_bottom_runtime_module_path = Some "Css_types.BorderBottom"

let property_border_bottom_color : property_border_bottom_color Rule.rule = [%spec "<'border-top-color'>"]

let property_border_bottom_left_radius : property_border_bottom_left_radius Rule.rule = [%spec "[ <extended-length> | <extended-percentage> ]{1,2}"]

let property_border_bottom_right_radius : property_border_bottom_right_radius Rule.rule = [%spec "[ <extended-length> | <extended-percentage> ]{1,2}"]

let property_border_bottom_style : property_border_bottom_style Rule.rule = [%spec "<line-style>"]

let property_border_bottom_width : property_border_bottom_width Rule.rule = [%spec "<line-width>"]

let property_border_collapse : property_border_collapse Rule.rule = [%spec "'collapse' | 'separate'"]
let property_border_collapse_runtime_module_path = Some "Css_types.BorderCollapse"

let property_border_color : property_border_color Rule.rule = [%spec "[ <color> ]{1,4}"]

let property_border_end_end_radius : property_border_end_end_radius Rule.rule = [%spec "[ <extended-length> | <extended-percentage> ]{1,2}"]

let property_border_end_start_radius : property_border_end_start_radius Rule.rule = [%spec "[ <extended-length> | <extended-percentage> ]{1,2}"]

let property_border_image : property_border_image Rule.rule = [%spec "<'border-image-source'> || <'border-image-slice'> [ '/' \
   <'border-image-width'> | '/' [ <'border-image-width'> ]? '/' \
   <'border-image-outset'> ]? || <'border-image-repeat'>"]
let property_border_image_runtime_module_path = Some "Css_types.BorderImage"

let property_border_image_outset : property_border_image_outset Rule.rule = [%spec "[ <extended-length> | <number> ]{1,4}"]
let property_border_image_outset_runtime_module_path = Some "Css_types.BorderImageOutset"

let property_border_image_repeat : property_border_image_repeat Rule.rule = [%spec "[ 'stretch' | 'repeat' | 'round' | 'space' ]{1,2}"]
let property_border_image_repeat_runtime_module_path = Some "Css_types.BorderImageRepeat"

let property_border_image_slice : property_border_image_slice Rule.rule = [%spec "[ <number-percentage> ]{1,4} && [ 'fill' ]?"]
let property_border_image_slice_runtime_module_path = Some "Css_types.BorderImageSlice"

let property_border_image_source : property_border_image_source Rule.rule = [%spec "'none' | <image>"]
let property_border_image_source_runtime_module_path = Some "Css_types.BorderImageSource"

let property_border_image_width : property_border_image_width Rule.rule = [%spec "[ <extended-length> | <extended-percentage> | <number> | 'auto' ]{1,4}"]
let property_border_image_width_runtime_module_path = Some "Css_types.BorderImageWidth"

let property_border_inline : property_border_inline Rule.rule = [%spec "<'border'>"]
let property_border_inline_runtime_module_path = Some "Css_types.BorderInline"

let property_border_inline_color : property_border_inline_color Rule.rule = [%spec "[ <'border-top-color'> ]{1,2}"]
let property_border_inline_color_runtime_module_path = Some "Css_types.BorderInlineColor"

let property_border_inline_end : property_border_inline_end Rule.rule = [%spec "<'border'>"]
let property_border_inline_end_runtime_module_path = Some "Css_types.BorderInlineEnd"

let property_border_inline_end_color : property_border_inline_end_color Rule.rule = [%spec "<'border-top-color'>"]
let property_border_inline_end_color_runtime_module_path = Some "Css_types.BorderInlineEndColor"

let property_border_inline_end_style : property_border_inline_end_style Rule.rule = [%spec "<'border-top-style'>"]
let property_border_inline_end_style_runtime_module_path = Some "Css_types.BorderInlineEndStyle"

let property_border_inline_end_width : property_border_inline_end_width Rule.rule = [%spec "<'border-top-width'>"]
let property_border_inline_end_width_runtime_module_path = Some "Css_types.BorderInlineEndWidth"

let property_border_inline_start : property_border_inline_start Rule.rule = [%spec "<'border'>"]
let property_border_inline_start_runtime_module_path = Some "Css_types.BorderInlineStart"

let property_border_inline_start_color : property_border_inline_start_color Rule.rule = [%spec "<'border-top-color'>"]
let property_border_inline_start_color_runtime_module_path = Some "Css_types.BorderInlineStartColor"

let property_border_inline_start_style : property_border_inline_start_style Rule.rule = [%spec "<'border-top-style'>"]
let property_border_inline_start_style_runtime_module_path = Some "Css_types.BorderInlineStartStyle"

let property_border_inline_start_width : property_border_inline_start_width Rule.rule = [%spec "<'border-top-width'>"]
let property_border_inline_start_width_runtime_module_path = Some "Css_types.BorderInlineStartWidth"

let property_border_inline_style : property_border_inline_style Rule.rule = [%spec "<'border-top-style'>"]
let property_border_inline_style_runtime_module_path = Some "Css_types.BorderInlineStyle"

let property_border_inline_width : property_border_inline_width Rule.rule = [%spec "<'border-top-width'>"]
let property_border_inline_width_runtime_module_path = Some "Css_types.BorderInlineWidth"

let property_border_left : property_border_left Rule.rule = [%spec "<'border'>"]
let property_border_left_runtime_module_path = Some "Css_types.BorderLeft"

let property_border_left_color : property_border_left_color Rule.rule = [%spec "<color>"]

let property_border_left_style : property_border_left_style Rule.rule = [%spec "<line-style>"]

let property_border_left_width : property_border_left_width Rule.rule = [%spec "<line-width>"]

(* border-radius supports 1-4 values with optional "/" for horizontal/vertical radii *)
let property_border_radius : property_border_radius Rule.rule = [%spec "[ <extended-length> | <extended-percentage> ]{1,4} [ '/' [ \
   <extended-length> | <extended-percentage> ]{1,4} ]?"]
let property_border_radius_runtime_module_path = Some "Css_types.BorderRadius"

let property_border_right : property_border_right Rule.rule = [%spec "<'border'>"]
let property_border_right_runtime_module_path = Some "Css_types.BorderRight"

let property_border_right_color : property_border_right_color Rule.rule = [%spec "<color>"]

let property_border_right_style : property_border_right_style Rule.rule = [%spec "<line-style>"]

let property_border_right_width : property_border_right_width Rule.rule = [%spec "<line-width>"]

let property_border_spacing : property_border_spacing Rule.rule = [%spec "<extended-length> [ <extended-length> ]?"]
let property_border_spacing_runtime_module_path = Some "Css_types.BorderSpacing"

let property_border_start_end_radius : property_border_start_end_radius Rule.rule = [%spec "[ <extended-length> | <extended-percentage> ]{1,2}"]

let property_border_start_start_radius : property_border_start_start_radius Rule.rule = [%spec "[ <extended-length> | <extended-percentage> ]{1,2}"]

(* bs-css doesn't support list of styles, the original spec is: `[ <line-style> ]{1,4}` *)
let property_border_style : property_border_style Rule.rule = [%spec "<line-style>"]
let property_border_style_runtime_module_path = Some "Css_types.BorderStyle"

let property_border_top : property_border_top Rule.rule = [%spec "<'border'>"]
let property_border_top_runtime_module_path = Some "Css_types.BorderTop"

let property_border_top_color : property_border_top_color Rule.rule = [%spec "<color>"]

let property_border_top_left_radius : property_border_top_left_radius Rule.rule = [%spec "[ <extended-length> | <extended-percentage> ]{1,2}"]

let property_border_top_right_radius : property_border_top_right_radius Rule.rule = [%spec "[ <extended-length> | <extended-percentage> ]{1,2}"]

let property_border_top_style : property_border_top_style Rule.rule = [%spec "<line-style>"]

let property_border_top_width : property_border_top_width Rule.rule = [%spec "<line-width>"]

let property_border_width : property_border_width Rule.rule = [%spec "[ <line-width> ]{1,4}"]

let property_bottom : property_bottom Rule.rule = [%spec "<extended-length> | <extended-percentage> | 'auto'"]
let property_bottom_runtime_module_path = Some "Css_types.Bottom"

let property_box_align : property_box_align Rule.rule = [%spec "'start' | 'center' | 'end' | 'baseline' | 'stretch'"]
let property_box_align_runtime_module_path = Some "Css_types.BoxAlign"

let property_box_decoration_break : property_box_decoration_break Rule.rule = [%spec "'slice' | 'clone'"]
let property_box_decoration_break_runtime_module_path = Some "Css_types.BoxDecorationBreak"

let property_box_direction : property_box_direction Rule.rule = [%spec "'normal' | 'reverse' | 'inherit'"]
let property_box_direction_runtime_module_path = Some "Css_types.BoxDirection"

let property_box_flex : property_box_flex Rule.rule = [%spec "<number>"]
let property_box_flex_runtime_module_path = Some "Css_types.BoxFlex"

let property_box_flex_group : property_box_flex_group Rule.rule = [%spec "<integer>"]
let property_box_flex_group_runtime_module_path = Some "Css_types.BoxFlexGroup"

let property_box_lines : property_box_lines Rule.rule = [%spec "'single' | 'multiple'"]
let property_box_lines_runtime_module_path = Some "Css_types.BoxLines"

let property_box_ordinal_group : property_box_ordinal_group Rule.rule = [%spec "<integer>"]
let property_box_ordinal_group_runtime_module_path = Some "Css_types.BoxOrdinalGroup"

let property_box_orient : property_box_orient Rule.rule = [%spec "'horizontal' | 'vertical' | 'inline-axis' | 'block-axis' | 'inherit'"]
let property_box_orient_runtime_module_path = Some "Css_types.BoxOrient"

let property_box_pack : property_box_pack Rule.rule = [%spec "'start' | 'center' | 'end' | 'justify'"]
let property_box_pack_runtime_module_path = Some "Css_types.BoxPack"

let property_box_shadow : property_box_shadow Rule.rule = [%spec "'none' | <interpolation> | [ <shadow> ]#"]
let property_box_shadow_runtime_module_path = Some "Css_types.BoxShadow"

let property_box_sizing : property_box_sizing Rule.rule = [%spec "'content-box' | 'border-box'"]
let property_box_sizing_runtime_module_path = Some "Css_types.BoxSizing"

let property_break_after : property_break_after Rule.rule = [%spec "'auto' | 'avoid' | 'always' | 'all' | 'avoid-page' | 'page' | 'left' | \
   'right' | 'recto' | 'verso' | 'avoid-column' | 'column' | 'avoid-region' | \
   'region'"]
let property_break_after_runtime_module_path = Some "Css_types.BreakAfter"

let property_break_before : property_break_before Rule.rule = [%spec "'auto' | 'avoid' | 'always' | 'all' | 'avoid-page' | 'page' | 'left' | \
   'right' | 'recto' | 'verso' | 'avoid-column' | 'column' | 'avoid-region' | \
   'region'"]
let property_break_before_runtime_module_path = Some "Css_types.BreakBefore"

let property_break_inside : property_break_inside Rule.rule = [%spec "'auto' | 'avoid' | 'avoid-page' | 'avoid-column' | 'avoid-region'"]
let property_break_inside_runtime_module_path = Some "Css_types.BreakInside"

let property_caption_side : property_caption_side Rule.rule = [%spec "'top' | 'bottom' | 'block-start' | 'block-end' | 'inline-start' | \
   'inline-end'"]
let property_caption_side_runtime_module_path = Some "Css_types.CaptionSide"

let property_caret_color : property_caret_color Rule.rule = [%spec "'auto' | <color>"]
let property_caret_color_runtime_module_path = Some "Css_types.CaretColor"

let property_clear : property_clear Rule.rule = [%spec "'none' | 'left' | 'right' | 'both' | 'inline-start' | 'inline-end'"]
let property_clear_runtime_module_path = Some "Css_types.Clear"

let property_clip : property_clip Rule.rule = [%spec "<shape> | 'auto'"]
let property_clip_runtime_module_path = Some "Css_types.Clip"

let property_clip_path : property_clip_path Rule.rule = [%spec "<clip-source> | <basic-shape> || <geometry-box> | 'none'"]
let property_clip_path_runtime_module_path = Some "Css_types.ClipPath"

let property_clip_rule : property_clip_rule Rule.rule = [%spec "'nonzero' | 'evenodd'"]
let property_clip_rule_runtime_module_path = Some "Css_types.ClipRule"

let property_color : property_color Rule.rule = [%spec "<color>"]
let property_color_runtime_module_path = Some "Css_types.Color"

let property_color_interpolation_filters : property_color_interpolation_filters Rule.rule = [%spec "'auto' | 'sRGB' | 'linearRGB'"]
let property_color_interpolation_filters_runtime_module_path = Some "Css_types.ColorInterpolationFilters"

let property_color_interpolation : property_color_interpolation Rule.rule = [%spec "'auto' | 'sRGB' | 'linearRGB'"]
let property_color_interpolation_runtime_module_path = Some "Css_types.ColorInterpolation"

let property_color_adjust : property_color_adjust Rule.rule = [%spec "'economy' | 'exact'"]
let property_color_adjust_runtime_module_path = Some "Css_types.ColorAdjust"

let property_column_count : property_column_count Rule.rule = [%spec "<integer> | 'auto'"]
let property_column_count_runtime_module_path = Some "Css_types.ColumnCount"

let property_column_fill : property_column_fill Rule.rule = [%spec "'auto' | 'balance' | 'balance-all'"]
let property_column_fill_runtime_module_path = Some "Css_types.ColumnFill"

let property_column_gap : property_column_gap Rule.rule = [%spec "'normal' | <extended-length> | <extended-percentage>"]

let property_column_rule : property_column_rule Rule.rule = [%spec "<'column-rule-width'> || <'column-rule-style'> || <'column-rule-color'>"]
let property_column_rule_runtime_module_path = Some "Css_types.ColumnRule"

let property_column_rule_color : property_column_rule_color Rule.rule = [%spec "<color>"]
let property_column_rule_color_runtime_module_path = Some "Css_types.ColumnRuleColor"

let property_column_rule_style : property_column_rule_style Rule.rule = [%spec "<'border-style'>"]
let property_column_rule_style_runtime_module_path = Some "Css_types.ColumnRuleStyle"

let property_column_rule_width : property_column_rule_width Rule.rule = [%spec "<'border-width'>"]
let property_column_rule_width_runtime_module_path = Some "Css_types.ColumnRuleWidth"

let property_column_span : property_column_span Rule.rule = [%spec "'none' | 'all'"]
let property_column_span_runtime_module_path = Some "Css_types.ColumnSpan"

let property_column_width : property_column_width Rule.rule = [%spec "<extended-length> | 'auto'"]
let property_column_width_runtime_module_path = Some "Css_types.ColumnWidth"

let property_columns : property_columns Rule.rule = [%spec "<'column-width'> || <'column-count'>"]
let property_columns_runtime_module_path = Some "Css_types.Columns"

let property_contain : property_contain Rule.rule = [%spec "'none' | 'strict' | 'content' | 'size' || 'layout' || 'style' || 'paint'"]
let property_contain_runtime_module_path = Some "Css_types.Contain"

let property_content : property_content Rule.rule = [%spec "'normal' | 'none' | <string> | <interpolation> | [ <content-replacement> | \
   <content-list> ] [ '/' <string> ]?"]
let property_content_runtime_module_path = Some "Css_types.Content"

let property_content_visibility : property_content_visibility Rule.rule = [%spec "'visible' | 'hidden' | 'auto'"]
let property_content_visibility_runtime_module_path = Some "Css_types.ContentVisibility"

let property_counter_increment : property_counter_increment Rule.rule = [%spec "[ <custom-ident> [ <integer> ]? ]+ | 'none'"]
let property_counter_increment_runtime_module_path = Some "Css_types.CounterIncrement"

let property_counter_reset : property_counter_reset Rule.rule = [%spec "[ <custom-ident> [ <integer> ]? ]+ | 'none'"]
let property_counter_reset_runtime_module_path = Some "Css_types.CounterReset"

let property_counter_set : property_counter_set Rule.rule = [%spec "[ <custom-ident> [ <integer> ]? ]+ | 'none'"]
let property_counter_set_runtime_module_path = Some "Css_types.CounterSet"

let property_cue : property_cue Rule.rule = [%spec "<'cue-before'> [ <'cue-after'> ]?"]
let property_cue_runtime_module_path = Some "Css_types.Cue"

let property_cue_after : property_cue_after Rule.rule = [%spec "<url> [ <decibel> ]? | 'none'"]
let property_cue_after_runtime_module_path = Some "Css_types.CueAfter"

let property_cue_before : property_cue_before Rule.rule = [%spec "<url> [ <decibel> ]? | 'none'"]
let property_cue_before_runtime_module_path = Some "Css_types.CueBefore"

(* type property_cursor = [%spec_t "[ <url> [ <x> <y> ]? ',' ]* [ 'auto' | 'default' | 'none' | 'context-menu' | 'help' | 'pointer' | 'progress' | 'wait' | 'cell' | 'crosshair' | 'text' | 'vertical-text' | 'alias' | 'copy' | 'move' | 'no-drop' | 'not-allowed' | 'e-resize' | 'n-resize' | 'ne-resize' | 'nw-resize' | 's-resize' | 'se-resize' | 'sw-resize' | 'w-resize' | 'ew-resize' | 'ns-resize' | 'nesw-resize' | 'nwse-resize' | 'col-resize' | 'row-resize' | 'all-scroll' | 'zoom-in' | 'zoom-out' | 'grab' | 'grabbing' | 'hand' | '-webkit-grab' | '-webkit-grabbing' | '-webkit-zoom-in' | '-webkit-zoom-out' | '-moz-grab' | '-moz-grabbing' | '-moz-zoom-in' | '-moz-zoom-out' ] | <interpolation>"]
let property_cursor : property_cursor Rule.rule = [%spec "[ <url> [ <x> <y> ]? ',' ]* [ 'auto' | 'default' | 'none' | 'context-menu' | 'help' | 'pointer' | 'progress' | 'wait' | 'cell' | 'crosshair' | 'text' | 'vertical-text' | 'alias' | 'copy' | 'move' | 'no-drop' | 'not-allowed' | 'e-resize' | 'n-resize' | 'ne-resize' | 'nw-resize' | 's-resize' | 'se-resize' | 'sw-resize' | 'w-resize' | 'ew-resize' | 'ns-resize' | 'nesw-resize' | 'nwse-resize' | 'col-resize' | 'row-resize' | 'all-scroll' | 'zoom-in' | 'zoom-out' | 'grab' | 'grabbing' | 'hand' | '-webkit-grab' | '-webkit-grabbing' | '-webkit-zoom-in' | '-webkit-zoom-out' | '-moz-grab' | '-moz-grabbing' | '-moz-zoom-in' | '-moz-zoom-out' ] | <interpolation>"]
let property_cursor_runtime_module_path = Some "Css_types.Cursor" *)
(* Removed [ <url> [ <x> <y> ]? ',' ]* *)
let property_cursor : property_cursor Rule.rule = [%spec "'auto' | 'default' | 'none' | 'context-menu' | 'help' | 'pointer' | \
   'progress' | 'wait' | 'cell' | 'crosshair' | 'text' | 'vertical-text' | \
   'alias' | 'copy' | 'move' | 'no-drop' | 'not-allowed' | 'e-resize' | \
   'n-resize' | 'ne-resize' | 'nw-resize' | 's-resize' | 'se-resize' | \
   'sw-resize' | 'w-resize' | 'ew-resize' | 'ns-resize' | 'nesw-resize' | \
   'nwse-resize' | 'col-resize' | 'row-resize' | 'all-scroll' | 'zoom-in' | \
   'zoom-out' | 'grab' | 'grabbing' | 'hand' | '-webkit-grab' | \
   '-webkit-grabbing' | '-webkit-zoom-in' | '-webkit-zoom-out' | '-moz-grab' | \
   '-moz-grabbing' | '-moz-zoom-in' | '-moz-zoom-out' | <interpolation>"]
let property_cursor_runtime_module_path = Some "Css_types.Cursor"

let property_direction : property_direction Rule.rule = [%spec "'ltr' | 'rtl'"]
let property_direction_runtime_module_path = Some "Css_types.Direction"

let property_display : property_display Rule.rule = [%spec "'block' | 'contents' | 'flex' | 'flow' | 'flow-root' | 'grid' | 'inline' | \
   'inline-block' | 'inline-flex' | 'inline-grid' | 'inline-list-item' | \
   'inline-table' | 'list-item' | 'none' | 'ruby' | 'ruby-base' | \
   'ruby-base-container' | 'ruby-text' | 'ruby-text-container' | 'run-in' | \
   'table' | 'table-caption' | 'table-cell' | 'table-column' | \
   'table-column-group' | 'table-footer-group' | 'table-header-group' | \
   'table-row' | 'table-row-group' | '-webkit-flex' | '-webkit-inline-flex' | \
   '-webkit-box' | '-webkit-inline-box' | '-moz-inline-stack' | '-moz-box' | \
   '-moz-inline-box'"]
let property_display_runtime_module_path = Some "Css_types.Display"

let property_dominant_baseline : property_dominant_baseline Rule.rule = [%spec "'auto' | 'use-script' | 'no-change' | 'reset-size' | 'ideographic' | \
   'alphabetic' | 'hanging' | 'mathematical' | 'central' | 'middle' | \
   'text-after-edge' | 'text-before-edge'"]
let property_dominant_baseline_runtime_module_path = Some "Css_types.DominantBaseline"

let property_empty_cells : property_empty_cells Rule.rule = [%spec "'show' | 'hide'"]
let property_empty_cells_runtime_module_path = Some "Css_types.EmptyCells"

let property_fill : property_fill Rule.rule = [%spec "<paint>"]
let property_fill_runtime_module_path = Some "Css_types.Paint"

let property_fill_opacity : property_fill_opacity Rule.rule = [%spec "<alpha-value>"]
let property_fill_opacity_runtime_module_path = Some "Css_types.FillOpacity"

let property_fill_rule : property_fill_rule Rule.rule = [%spec "'nonzero' | 'evenodd'"]
let property_fill_rule_runtime_module_path = Some "Css_types.FillRule"

let property_filter : property_filter Rule.rule = [%spec "'none' | <interpolation> | <filter-function-list>"]
let property_filter_runtime_module_path = Some "Css_types.Filter"

let property_flex : property_flex Rule.rule = [%spec "'none' | [<'flex-grow'> [ <'flex-shrink'> ]? || <'flex-basis'>] | \
   <interpolation>"]
let property_flex_runtime_module_path = Some "Css_types.Flex"

let property_flex_basis : property_flex_basis Rule.rule = [%spec "'content' | <'width'> | <interpolation>"]
let property_flex_basis_runtime_module_path = Some "Css_types.FlexBasis"

let property_flex_direction : property_flex_direction Rule.rule = [%spec "'row' | 'row-reverse' | 'column' | 'column-reverse'"]
let property_flex_direction_runtime_module_path = Some "Css_types.FlexDirection"

let property_flex_flow : property_flex_flow Rule.rule = [%spec "<'flex-direction'> || <'flex-wrap'>"]
let property_flex_flow_runtime_module_path = Some "Css_types.FlexFlow"

let property_flex_grow : property_flex_grow Rule.rule = [%spec "<number> | <interpolation>"]
let property_flex_grow_runtime_module_path = Some "Css_types.FlexGrow"

let property_flex_shrink : property_flex_shrink Rule.rule = [%spec "<number> | <interpolation>"]
let property_flex_shrink_runtime_module_path = Some "Css_types.FlexShrink"

let property_flex_wrap : property_flex_wrap Rule.rule = [%spec "'nowrap' | 'wrap' | 'wrap-reverse'"]
let property_flex_wrap_runtime_module_path = Some "Css_types.FlexWrap"

let property_float : property_float Rule.rule = [%spec "'left' | 'right' | 'none' | 'inline-start' | 'inline-end'"]
let property_float_runtime_module_path = Some "Css_types.Float"

let property_font : property_font Rule.rule = [%spec "[ <'font-style'> || <font-variant-css21> || <'font-weight'> || \
   <'font-stretch'> ]? <'font-size'> [ '/' <'line-height'> ]? <'font-family'> \
   | 'caption' | 'icon' | 'menu' | 'message-box' | 'small-caption' | \
   'status-bar'"]
let property_font_runtime_module_path = Some "Css_types.Font"

let font_families : font_families Rule.rule = [%spec "[ <family-name> | <generic-family> | <interpolation> ]#"]
let font_families_runtime_module_path = Some "Css_types.FontFamilies"

let property_font_family : property_font_family Rule.rule = [%spec "<font_families> | <interpolation>"]
let property_font_family_runtime_module_path = Some "Css_types.FontFamily"

let property_font_feature_settings : property_font_feature_settings Rule.rule = [%spec "'normal' | [ <feature-tag-value> ]#"]
let property_font_feature_settings_runtime_module_path = Some "Css_types.FontFeatureSettings"

let property_font_display : property_font_display Rule.rule = [%spec "'auto' | 'block' | 'swap' | 'fallback' | 'optional'"]
let property_font_display_runtime_module_path = Some "Css_types.FontDisplay"

let property_font_kerning : property_font_kerning Rule.rule = [%spec "'auto' | 'normal' | 'none'"]
let property_font_kerning_runtime_module_path = Some "Css_types.FontKerning"

let property_font_language_override : property_font_language_override Rule.rule = [%spec "'normal' | <string>"]
let property_font_language_override_runtime_module_path = Some "Css_types.FontLanguageOverride"

let property_font_optical_sizing : property_font_optical_sizing Rule.rule = [%spec "'auto' | 'none'"]
let property_font_optical_sizing_runtime_module_path = Some "Css_types.FontOpticalSizing"

let property_font_palette : property_font_palette Rule.rule = [%spec "'normal' | 'light' | 'dark'"]
let property_font_palette_runtime_module_path = Some "Css_types.FontPalette"

let property_font_size : property_font_size Rule.rule = [%spec "<absolute-size> | <relative-size> | <extended-length> | \
   <extended-percentage>"]
let property_font_size_runtime_module_path = Some "Css_types.FontSize"

let property_font_size_adjust : property_font_size_adjust Rule.rule = [%spec "'none' | <number>"]
let property_font_size_adjust_runtime_module_path = Some "Css_types.FontSizeAdjust"

let property_font_smooth : property_font_smooth Rule.rule = [%spec "'auto' | 'never' | 'always' | <absolute-size> | <extended-length>"]
let property_font_smooth_runtime_module_path = Some "Css_types.FontSmooth"

let property_font_stretch : property_font_stretch Rule.rule = [%spec "<font-stretch-absolute>"]
let property_font_stretch_runtime_module_path = Some "Css_types.FontStretch"

let property_font_style : property_font_style Rule.rule = [%spec "'normal' | 'italic' | 'oblique' | <interpolation> | [ 'oblique' \
   <extended-angle> ]?"]
let property_font_style_runtime_module_path = Some "Css_types.FontStyle"

let property_font_synthesis : property_font_synthesis Rule.rule = [%spec "'none' | [ 'weight' || 'style' || 'small-caps' || 'position' ]"]
let property_font_synthesis_runtime_module_path = Some "Css_types.FontSynthesis"

let property_font_synthesis_weight : property_font_synthesis_weight Rule.rule = [%spec "'auto' | 'none'"]
let property_font_synthesis_weight_runtime_module_path = Some "Css_types.FontSynthesisWeight"

let property_font_synthesis_style : property_font_synthesis_style Rule.rule = [%spec "'auto' | 'none'"]
let property_font_synthesis_style_runtime_module_path = Some "Css_types.FontSynthesisStyle"

let property_font_synthesis_small_caps : property_font_synthesis_small_caps Rule.rule = [%spec "'auto' | 'none'"]
let property_font_synthesis_small_caps_runtime_module_path = Some "Css_types.FontSynthesisSmallCaps"

let property_font_synthesis_position : property_font_synthesis_position Rule.rule = [%spec "'auto' | 'none'"]
let property_font_synthesis_position_runtime_module_path = Some "Css_types.FontSynthesisPosition"

let property_font_variant : property_font_variant Rule.rule = [%spec "'normal' | 'none' | 'small-caps' | <common-lig-values> || \
   <discretionary-lig-values> || <historical-lig-values> || \
   <contextual-alt-values> || stylistic( <feature-value-name> ) || \
   'historical-forms' || styleset( [ <feature-value-name> ]# ) || \
   character-variant( [ <feature-value-name> ]# ) || swash( \
   <feature-value-name> ) || ornaments( <feature-value-name> ) || annotation( \
   <feature-value-name> ) || [ 'small-caps' | 'all-small-caps' | 'petite-caps' \
   | 'all-petite-caps' | 'unicase' | 'titling-caps' ] || \
   <numeric-figure-values> || <numeric-spacing-values> || \
   <numeric-fraction-values> || 'ordinal' || 'slashed-zero' || \
   <east-asian-variant-values> || <east-asian-width-values> || 'ruby' || 'sub' \
   || 'super' || 'text' || 'emoji' || 'unicode'"]
let property_font_variant_runtime_module_path = Some "Css_types.FontVariant"

let property_font_variant_alternates : property_font_variant_alternates Rule.rule = [%spec "'normal' | stylistic( <feature-value-name> ) || 'historical-forms' || \
   styleset( [ <feature-value-name> ]# ) || character-variant( [ \
   <feature-value-name> ]# ) || swash( <feature-value-name> ) || ornaments( \
   <feature-value-name> ) || annotation( <feature-value-name> )"]
let property_font_variant_alternates_runtime_module_path = Some "Css_types.FontVariantAlternates"

let property_font_variant_caps : property_font_variant_caps Rule.rule = [%spec "'normal' | 'small-caps' | 'all-small-caps' | 'petite-caps' | \
   'all-petite-caps' | 'unicase' | 'titling-caps'"]
let property_font_variant_caps_runtime_module_path = Some "Css_types.FontVariantCaps"

let property_font_variant_east_asian : property_font_variant_east_asian Rule.rule = [%spec "'normal' | <east-asian-variant-values> || <east-asian-width-values> || \
   'ruby'"]
let property_font_variant_east_asian_runtime_module_path = Some "Css_types.FontVariantEastAsian"

let property_font_variant_ligatures : property_font_variant_ligatures Rule.rule = [%spec "'normal' | 'none' | <common-lig-values> || <discretionary-lig-values> || \
   <historical-lig-values> || <contextual-alt-values>"]
let property_font_variant_ligatures_runtime_module_path = Some "Css_types.FontVariantLigatures"

let property_font_variant_numeric : property_font_variant_numeric Rule.rule = [%spec "'normal' | <numeric-figure-values> || <numeric-spacing-values> || \
   <numeric-fraction-values> || 'ordinal' || 'slashed-zero'"]
let property_font_variant_numeric_runtime_module_path = Some "Css_types.FontVariantNumeric"

let property_font_variant_position : property_font_variant_position Rule.rule = [%spec "'normal' | 'sub' | 'super'"]
let property_font_variant_position_runtime_module_path = Some "Css_types.FontVariantPosition"

let property_font_variation_settings : property_font_variation_settings Rule.rule = [%spec "'normal' | [ <string> <number> ]#"]
let property_font_variation_settings_runtime_module_path = Some "Css_types.FontVariationSettings"

let property_font_variant_emoji : property_font_variant_emoji Rule.rule = [%spec "'normal' | 'text' | 'emoji' | 'unicode'"]
let property_font_variant_emoji_runtime_module_path = Some "Css_types.FontVariantEmoji"

let property_font_weight : property_font_weight Rule.rule = [%spec "<font-weight-absolute> | 'bolder' | 'lighter' | <interpolation>"]
let property_font_weight_runtime_module_path = Some "Css_types.FontWeight"

let property_gap : property_gap Rule.rule = [%spec "<'row-gap'> [ <'column-gap'> ]?"]
let property_gap_runtime_module_path = Some "Css_types.Gap"

let property_glyph_orientation_horizontal : property_glyph_orientation_horizontal Rule.rule = [%spec "<extended-angle>"]
let property_glyph_orientation_horizontal_runtime_module_path = Some "Css_types.GlyphOrientationHorizontal"

let property_glyph_orientation_vertical : property_glyph_orientation_vertical Rule.rule = [%spec "<extended-angle>"]
let property_glyph_orientation_vertical_runtime_module_path = Some "Css_types.GlyphOrientationVertical"

let property_grid : property_grid Rule.rule = [%spec "<'grid-template'> | <'grid-template-rows'> '/' [ 'auto-flow' && [ 'dense' \
   ]? ] [ <'grid-auto-columns'> ]? | [ 'auto-flow' && [ 'dense' ]? ] [ \
   <'grid-auto-rows'> ]? '/' <'grid-template-columns'>"]
let property_grid_runtime_module_path = Some "Css_types.Grid"

let property_grid_area : property_grid_area Rule.rule = [%spec "<grid-line> [ '/' <grid-line> ]{0,3}"]
let property_grid_area_runtime_module_path = Some "Css_types.GridArea"

let property_grid_auto_columns : property_grid_auto_columns Rule.rule = [%spec "[ <track-size> ]+"]
let property_grid_auto_columns_runtime_module_path = Some "Css_types.GridAutoColumns"

let property_grid_auto_flow : property_grid_auto_flow Rule.rule = [%spec "[ [ 'row' | 'column' ] || 'dense' ] | <interpolation>"]
let property_grid_auto_flow_runtime_module_path = Some "Css_types.GridAutoFlow"

let property_grid_auto_rows : property_grid_auto_rows Rule.rule = [%spec "[ <track-size> ]+"]
let property_grid_auto_rows_runtime_module_path = Some "Css_types.GridAutoRows"

let property_grid_column : property_grid_column Rule.rule = [%spec "<grid-line> [ '/' <grid-line> ]?"]
let property_grid_column_runtime_module_path = Some "Css_types.GridColumn"

let property_grid_column_end : property_grid_column_end Rule.rule = [%spec "<grid-line>"]
let property_grid_column_end_runtime_module_path = Some "Css_types.GridColumnEnd"

let property_grid_column_gap : property_grid_column_gap Rule.rule = [%spec "<extended-length> | <extended-percentage>"]

let property_grid_column_start : property_grid_column_start Rule.rule = [%spec "<grid-line>"]
let property_grid_column_start_runtime_module_path = Some "Css_types.GridColumnStart"

let property_grid_gap : property_grid_gap Rule.rule = [%spec "<'grid-row-gap'> [ <'grid-column-gap'> ]?"]

let property_grid_row : property_grid_row Rule.rule = [%spec "<grid-line> [ '/' <grid-line> ]?"]
let property_grid_row_runtime_module_path = Some "Css_types.GridRow"

let property_grid_row_end : property_grid_row_end Rule.rule = [%spec "<grid-line>"]
let property_grid_row_end_runtime_module_path = Some "Css_types.GridRowEnd"

let property_grid_row_gap : property_grid_row_gap Rule.rule = [%spec "<extended-length> | <extended-percentage>"]

let property_grid_row_start : property_grid_row_start Rule.rule = [%spec "<grid-line>"]
let property_grid_row_start_runtime_module_path = Some "Css_types.GridRowStart"

let property_grid_template : property_grid_template Rule.rule = [%spec "'none' | <'grid-template-rows'> '/' <'grid-template-columns'> | [ [ \
   <line-names> ]? <string> [ <track-size> ]? [ <line-names> ]? ]+ [ '/' \
   <explicit-track-list> ]?"]
let property_grid_template_runtime_module_path = Some "Css_types.GridTemplate"

let property_grid_template_areas : property_grid_template_areas Rule.rule = [%spec "'none' | [ <string> | <interpolation> ]+"]
let property_grid_template_areas_runtime_module_path = Some "Css_types.GridTemplateAreas"

let property_grid_template_columns : property_grid_template_columns Rule.rule = [%spec "'none' | <track-list> | <auto-track-list> | 'subgrid' [ <line-name-list> ]? \
   | 'masonry' | <interpolation>"]
let property_grid_template_columns_runtime_module_path = Some "Css_types.GridTemplateColumns"

let property_grid_template_rows : property_grid_template_rows Rule.rule = [%spec "'none' | <track-list> | <auto-track-list> | 'subgrid' [ <line-name-list> ]? \
   | 'masonry' | <interpolation>"]
let property_grid_template_rows_runtime_module_path = Some "Css_types.GridTemplateRows"

let property_hanging_punctuation : property_hanging_punctuation Rule.rule = [%spec "'none' | 'first' || [ 'force-end' | 'allow-end' ] || 'last'"]
let property_hanging_punctuation_runtime_module_path = Some "Css_types.HangingPunctuation"

let property_height : property_height Rule.rule = [%spec "'auto' | <extended-length> | <extended-percentage> | 'min-content' | \
   'max-content' | 'fit-content' | fit-content( <extended-length> | \
   <extended-percentage> )"]
let property_height_runtime_module_path = Some "Css_types.Height"

let property_hyphens : property_hyphens Rule.rule = [%spec "'none' | 'manual' | 'auto'"]
let property_hyphens_runtime_module_path = Some "Css_types.Hyphens"

let property_hyphenate_character : property_hyphenate_character Rule.rule = [%spec "'auto' | <string-token>"]
let property_hyphenate_character_runtime_module_path = Some "Css_types.HyphenateCharacter"

let property_hyphenate_limit_chars : property_hyphenate_limit_chars Rule.rule = [%spec "'auto' | <integer>"]
let property_hyphenate_limit_chars_runtime_module_path = Some "Css_types.HyphenateLimitChars"

let property_hyphenate_limit_lines : property_hyphenate_limit_lines Rule.rule = [%spec "'no-limit' | <integer>"]
let property_hyphenate_limit_lines_runtime_module_path = Some "Css_types.HyphenateLimitLines"

let property_hyphenate_limit_zone : property_hyphenate_limit_zone Rule.rule = [%spec "<extended-length> | <extended-percentage>"]
let property_hyphenate_limit_zone_runtime_module_path = Some "Css_types.HyphenateLimitZone"

let property_image_orientation : property_image_orientation Rule.rule = [%spec "'from-image' | <extended-angle> | [ <extended-angle> ]? 'flip'"]
let property_image_orientation_runtime_module_path = Some "Css_types.ImageOrientation"

let property_image_rendering : property_image_rendering Rule.rule = [%spec "'auto' |'smooth' | 'high-quality' | 'crisp-edges' | 'pixelated'"]
let property_image_rendering_runtime_module_path = Some "Css_types.ImageRendering"

let property_image_resolution : property_image_resolution Rule.rule = [%spec "[ 'from-image' || <resolution> ] && [ 'snap' ]?"]
let property_image_resolution_runtime_module_path = Some "Css_types.ImageResolution"

let property_ime_mode : property_ime_mode Rule.rule = [%spec "'auto' | 'normal' | 'active' | 'inactive' | 'disabled'"]
let property_ime_mode_runtime_module_path = Some "Css_types.ImeMode"

let property_initial_letter : property_initial_letter Rule.rule = [%spec "'normal' | <number> [ <integer> ]?"]
let property_initial_letter_runtime_module_path = Some "Css_types.InitialLetter"

let property_initial_letter_align : property_initial_letter_align Rule.rule = [%spec "'auto' | 'alphabetic' | 'hanging' | 'ideographic'"]
let property_initial_letter_align_runtime_module_path = Some "Css_types.InitialLetterAlign"

let property_inline_size : property_inline_size Rule.rule = [%spec "<'width'>"]

let property_inset : property_inset Rule.rule = [%spec "[ <'top'> ]{1,4}"]
let property_inset_runtime_module_path = Some "Css_types.Inset"

let property_inset_block : property_inset_block Rule.rule = [%spec "[ <'top'> ]{1,2}"]
let property_inset_block_runtime_module_path = Some "Css_types.InsetBlock"

let property_inset_block_end : property_inset_block_end Rule.rule = [%spec "<'top'>"]

let property_inset_block_start : property_inset_block_start Rule.rule = [%spec "<'top'>"]

let property_inset_inline : property_inset_inline Rule.rule = [%spec "[ <'top'> ]{1,2}"]
let property_inset_inline_runtime_module_path = Some "Css_types.InsetInline"

let property_inset_inline_end : property_inset_inline_end Rule.rule = [%spec "<'top'>"]

let property_inset_inline_start : property_inset_inline_start Rule.rule = [%spec "<'top'>"]

let property_isolation : property_isolation Rule.rule = [%spec "'auto' | 'isolate'"]
let property_isolation_runtime_module_path = Some "Css_types.Isolation"

let property_justify_content : property_justify_content Rule.rule = [%spec "'normal' | <content-distribution> | [ <overflow-position> ]? [ \
   <content-position> | 'left' | 'right' ]"]
let property_justify_content_runtime_module_path = Some "Css_types.JustifyContent"

let property_justify_items : property_justify_items Rule.rule = [%spec "'normal' | 'stretch' | <baseline-position> | [ <overflow-position> ]? [ \
   <self-position> | 'left' | 'right' ] | 'legacy' | 'legacy' && [ 'left' | \
   'right' | 'center' ]"]
let property_justify_items_runtime_module_path = Some "Css_types.JustifyItems"

let property_justify_self : property_justify_self Rule.rule = [%spec "'auto' | 'normal' | 'stretch' | <baseline-position> | [ <overflow-position> \
   ]? [ <self-position> | 'left' | 'right' ]"]
let property_justify_self_runtime_module_path = Some "Css_types.JustifySelf"

let property_kerning : property_kerning Rule.rule = [%spec "'auto' | <svg-length>"]
let property_kerning_runtime_module_path = Some "Css_types.Kerning"

let property_layout_grid : property_layout_grid Rule.rule = [%spec "'auto' | <custom-ident> | <integer> && [ <custom-ident> ]?"]
let property_layout_grid_runtime_module_path = Some "Css_types.LayoutGrid"

let property_layout_grid_char : property_layout_grid_char Rule.rule = [%spec "'auto' | <custom-ident> | <string>"]
let property_layout_grid_char_runtime_module_path = Some "Css_types.LayoutGridChar"

let property_layout_grid_line : property_layout_grid_line Rule.rule = [%spec "'auto' | <custom-ident> | <string>"]
let property_layout_grid_line_runtime_module_path = Some "Css_types.LayoutGridLine"

let property_layout_grid_mode : property_layout_grid_mode Rule.rule = [%spec "'auto' | <custom-ident> | <string>"]
let property_layout_grid_mode_runtime_module_path = Some "Css_types.LayoutGridMode"

let property_layout_grid_type : property_layout_grid_type Rule.rule = [%spec "'auto' | <custom-ident> | <string>"]
let property_layout_grid_type_runtime_module_path = Some "Css_types.LayoutGridType"

let property_left : property_left Rule.rule = [%spec "<extended-length> | <extended-percentage> | 'auto'"]
let property_left_runtime_module_path = Some "Css_types.Left"

let property_letter_spacing : property_letter_spacing Rule.rule = [%spec "'normal' | <extended-length> | <extended-percentage>"]
let property_letter_spacing_runtime_module_path = Some "Css_types.LetterSpacing"

let property_line_break : property_line_break Rule.rule = [%spec "'auto' | 'loose' | 'normal' | 'strict' | 'anywhere' | <interpolation>"]
let property_line_break_runtime_module_path = Some "Css_types.LineBreak"

let property_line_clamp : property_line_clamp Rule.rule = [%spec "'none' | <integer>"]
let property_line_clamp_runtime_module_path = Some "Css_types.LineClamp"

let property_line_height : property_line_height Rule.rule = [%spec "'normal' | <number> | <extended-length> | <extended-percentage>"]
let property_line_height_runtime_module_path = Some "Css_types.LineHeight"

let property_line_height_step : property_line_height_step Rule.rule = [%spec "<extended-length>"]
let property_line_height_step_runtime_module_path = Some "Css_types.LineHeightStep"

let property_list_style : property_list_style Rule.rule = [%spec "<'list-style-type'> || <'list-style-position'> || <'list-style-image'>"]
let property_list_style_runtime_module_path = Some "Css_types.ListStyle"

let property_list_style_image : property_list_style_image Rule.rule = [%spec "'none' | <image>"]
let property_list_style_image_runtime_module_path = Some "Css_types.ListStyleImage"

let property_list_style_position : property_list_style_position Rule.rule = [%spec "'inside' | 'outside'"]
let property_list_style_position_runtime_module_path = Some "Css_types.ListStylePosition"

let property_list_style_type : property_list_style_type Rule.rule = [%spec "<counter-style> | <string> | 'none'"]
let property_list_style_type_runtime_module_path = Some "Css_types.ListStyleType"

let property_margin : property_margin Rule.rule = [%spec "[ <extended-length> | <extended-percentage> | 'auto' | <interpolation> \
   ]{1,4}"]
let property_margin_runtime_module_path = Some "Css_types.Margin"

let property_margin_block : property_margin_block Rule.rule = [%spec "[ <'margin-left'> ]{1,2}"]
let property_margin_block_runtime_module_path = Some "Css_types.MarginBlock"

let property_margin_block_end : property_margin_block_end Rule.rule = [%spec "<'margin-left'>"]

let property_margin_block_start : property_margin_block_start Rule.rule = [%spec "<'margin-left'>"]

let property_margin_bottom : property_margin_bottom Rule.rule = [%spec "<extended-length> | <extended-percentage> | 'auto'"]

let property_margin_inline : property_margin_inline Rule.rule = [%spec "[ <'margin-left'> ]{1,2}"]
let property_margin_inline_runtime_module_path = Some "Css_types.MarginInline"

let property_margin_inline_end : property_margin_inline_end Rule.rule = [%spec "<'margin-left'>"]

let property_margin_inline_start : property_margin_inline_start Rule.rule = [%spec "<'margin-left'>"]

let property_margin_left : property_margin_left Rule.rule = [%spec "<extended-length> | <extended-percentage> | 'auto'"]

let property_margin_right : property_margin_right Rule.rule = [%spec "<extended-length> | <extended-percentage> | 'auto'"]

let property_margin_top : property_margin_top Rule.rule = [%spec "<extended-length> | <extended-percentage> | 'auto'"]

let property_margin_trim : property_margin_trim Rule.rule = [%spec "'none' | 'in-flow' | 'all'"]
let property_margin_trim_runtime_module_path = Some "Css_types.MarginTrim"

let property_marker : property_marker Rule.rule = [%spec "'none' | <url>"]
let property_marker_runtime_module_path = Some "Css_types.Marker"

let property_marker_end : property_marker_end Rule.rule = [%spec "'none' | <url>"]
let property_marker_end_runtime_module_path = Some "Css_types.MarkerEnd"

let property_marker_mid : property_marker_mid Rule.rule = [%spec "'none' | <url>"]
let property_marker_mid_runtime_module_path = Some "Css_types.MarkerMid"

let property_marker_start : property_marker_start Rule.rule = [%spec "'none' | <url>"]
let property_marker_start_runtime_module_path = Some "Css_types.MarkerStart"

let property_mask : property_mask Rule.rule = [%spec "[ <mask-layer> ]#"]
let property_mask_runtime_module_path = Some "Css_types.Mask"

let property_mask_border : property_mask_border Rule.rule = [%spec "<'mask-border-source'> || <'mask-border-slice'> [ '/' [ \
   <'mask-border-width'> ]? [ '/' <'mask-border-outset'> ]? ]? || \
   <'mask-border-repeat'> || <'mask-border-mode'>"]
let property_mask_border_runtime_module_path = Some "Css_types.MaskBorder"

let property_mask_border_mode : property_mask_border_mode Rule.rule = [%spec "'luminance' | 'alpha'"]
let property_mask_border_mode_runtime_module_path = Some "Css_types.MaskBorderMode"

let property_mask_border_outset : property_mask_border_outset Rule.rule = [%spec "[ <extended-length> | <number> ]{1,4}"]
let property_mask_border_outset_runtime_module_path = Some "Css_types.MaskBorderOutset"

let property_mask_border_repeat : property_mask_border_repeat Rule.rule = [%spec "[ 'stretch' | 'repeat' | 'round' | 'space' ]{1,2}"]
let property_mask_border_repeat_runtime_module_path = Some "Css_types.MaskBorderRepeat"

let property_mask_border_slice : property_mask_border_slice Rule.rule = [%spec "[ <number-percentage> ]{1,4} [ 'fill' ]?"]
let property_mask_border_slice_runtime_module_path = Some "Css_types.MaskBorderSlice"

let property_mask_border_source : property_mask_border_source Rule.rule = [%spec "'none' | <image>"]
let property_mask_border_source_runtime_module_path = Some "Css_types.MaskBorderSource"

let property_mask_border_width : property_mask_border_width Rule.rule = [%spec "[ <extended-length> | <extended-percentage> | <number> | 'auto' ]{1,4}"]
let property_mask_border_width_runtime_module_path = Some "Css_types.MaskBorderWidth"

let property_mask_clip : property_mask_clip Rule.rule = [%spec "[ <geometry-box> | 'no-clip' ]#"]
let property_mask_clip_runtime_module_path = Some "Css_types.MaskClip"

let property_mask_composite : property_mask_composite Rule.rule = [%spec "[ <compositing-operator> ]#"]
let property_mask_composite_runtime_module_path = Some "Css_types.MaskComposite"

let property_mask_image : property_mask_image Rule.rule = [%spec "[ <mask-reference> ]#"]
let property_mask_image_runtime_module_path = Some "Css_types.MaskImage"

let property_mask_mode : property_mask_mode Rule.rule = [%spec "[ <masking-mode> ]#"]
let property_mask_mode_runtime_module_path = Some "Css_types.MaskMode"

let property_mask_origin : property_mask_origin Rule.rule = [%spec "[ <geometry-box> ]#"]
let property_mask_origin_runtime_module_path = Some "Css_types.MaskOrigin"

let property_mask_position : property_mask_position Rule.rule = [%spec "[ <position> ]#"]
let property_mask_position_runtime_module_path = Some "Css_types.MaskPosition"

let property_mask_repeat : property_mask_repeat Rule.rule = [%spec "[ <repeat-style> ]#"]
let property_mask_repeat_runtime_module_path = Some "Css_types.MaskRepeat"

let property_mask_size : property_mask_size Rule.rule = [%spec "[ <bg-size> ]#"]
let property_mask_size_runtime_module_path = Some "Css_types.MaskSize"

let property_mask_type : property_mask_type Rule.rule = [%spec "'luminance' | 'alpha'"]
let property_mask_type_runtime_module_path = Some "Css_types.MaskType"

let property_masonry_auto_flow : property_masonry_auto_flow Rule.rule = [%spec "[ 'pack' | 'next' ] || [ 'definite-first' | 'ordered' ]"]
let property_masonry_auto_flow_runtime_module_path = Some "Css_types.MasonryAutoFlow"

let property_max_block_size : property_max_block_size Rule.rule = [%spec "<'max-width'>"]

let property_max_height : property_max_height Rule.rule = [%spec "'auto' | <extended-length> | <extended-percentage> | 'min-content' | \
   'max-content' | 'fit-content' | fit-content( <extended-length> | \
   <extended-percentage> )"]
let property_max_height_runtime_module_path = Some "Css_types.MaxHeight"

let property_max_inline_size : property_max_inline_size Rule.rule = [%spec "<'max-width'>"]

let property_max_lines : property_max_lines Rule.rule = [%spec "'none' | <integer>"]
let property_max_lines_runtime_module_path = Some "Css_types.MaxLines"

let property_max_width : property_max_width Rule.rule = [%spec "<extended-length> | <extended-percentage> | 'none' | 'max-content' | \
   'min-content' | 'fit-content' | fit-content( <extended-length> | \
   <extended-percentage> ) | 'fill-available' | <-non-standard-width>"]
let property_max_width_runtime_module_path = Some "Css_types.MaxWidth"

let property_min_block_size : property_min_block_size Rule.rule = [%spec "<'min-width'>"]

let property_min_height : property_min_height Rule.rule = [%spec "'auto' | <extended-length> | <extended-percentage> | 'min-content' | \
   'max-content' | 'fit-content' | fit-content( <extended-length> | \
   <extended-percentage> )"]
let property_min_height_runtime_module_path = Some "Css_types.MinHeight"

let property_min_inline_size : property_min_inline_size Rule.rule = [%spec "<'min-width'>"]

let property_min_width : property_min_width Rule.rule = [%spec "<extended-length> | <extended-percentage> | 'auto' | 'max-content' | \
   'min-content' | 'fit-content' | fit-content( <extended-length> | \
   <extended-percentage> ) | 'fill-available' | <-non-standard-width>"]
let property_min_width_runtime_module_path = Some "Css_types.MinWidth"

let property_mix_blend_mode : property_mix_blend_mode Rule.rule = [%spec "<blend-mode>"]
let property_mix_blend_mode_runtime_module_path = Some "Css_types.MixBlendMode"

let property_media_any_hover : property_media_any_hover Rule.rule = [%spec "none | hover"]
let property_media_any_hover_runtime_module_path = Some "Css_types.MediaAnyHover"

let property_media_any_pointer : property_media_any_pointer Rule.rule = [%spec "none | coarse | fine"]
let property_media_any_pointer_runtime_module_path = Some "Css_types.MediaAnyPointer"

let property_media_pointer : property_media_pointer Rule.rule = [%spec "none | coarse | fine"]
let property_media_pointer_runtime_module_path = Some "Css_types.MediaPointer"

let property_media_max_aspect_ratio : property_media_max_aspect_ratio Rule.rule = [%spec "<ratio>"]
let property_media_max_aspect_ratio_runtime_module_path = Some "Css_types.MediaMaxAspectRatio"

let property_media_min_aspect_ratio : property_media_min_aspect_ratio Rule.rule = [%spec "<ratio>"]
let property_media_min_aspect_ratio_runtime_module_path = Some "Css_types.MediaMinAspectRatio"

let property_media_min_color : property_media_min_color Rule.rule = [%spec "<integer>"]
let property_media_min_color_runtime_module_path = Some "Css_types.MediaMinColor"

let property_media_color_gamut : property_media_color_gamut Rule.rule = [%spec "'srgb' | 'p3' | 'rec2020'"]
let property_media_color_gamut_runtime_module_path = Some "Css_types.MediaColorGamut"

let property_media_color_index : property_media_color_index Rule.rule = [%spec "<integer>"]
let property_media_color_index_runtime_module_path = Some "Css_types.MediaColorIndex"

let property_media_min_color_index : property_media_min_color_index Rule.rule = [%spec "<integer>"]
let property_media_min_color_index_runtime_module_path = Some "Css_types.MediaMinColorIndex"

let property_media_display_mode : property_media_display_mode Rule.rule = [%spec "'fullscreen' | 'standalone' | 'minimal-ui' | 'browser'"]
let property_media_display_mode_runtime_module_path = Some "Css_types.MediaDisplayMode"

let property_media_forced_colors : property_media_forced_colors Rule.rule = [%spec "'none' | 'active'"]
let property_media_forced_colors_runtime_module_path = Some "Css_types.MediaForcedColors"

let property_forced_color_adjust : property_forced_color_adjust Rule.rule = [%spec "'auto' | 'none' | 'preserve-parent-color'"]
let property_forced_color_adjust_runtime_module_path = Some "Css_types.ForcedColorAdjust"

let property_media_grid : property_media_grid Rule.rule = [%spec "<integer>"]
let property_media_grid_runtime_module_path = Some "Css_types.MediaGrid"

let property_media_hover : property_media_hover Rule.rule = [%spec "'hover' | 'none'"]
let property_media_hover_runtime_module_path = Some "Css_types.MediaHover"

let property_media_inverted_colors : property_media_inverted_colors Rule.rule = [%spec "'inverted' | 'none'"]
let property_media_inverted_colors_runtime_module_path = Some "Css_types.MediaInvertedColors"

let property_media_monochrome : property_media_monochrome Rule.rule = [%spec "<integer>"]
let property_media_monochrome_runtime_module_path = Some "Css_types.MediaMonochrome"

let property_media_prefers_color_scheme : property_media_prefers_color_scheme Rule.rule = [%spec "'dark' | 'light'"]
let property_media_prefers_color_scheme_runtime_module_path = Some "Css_types.MediaPrefersColorScheme"

let property_color_scheme : property_color_scheme Rule.rule = [%spec "'normal' | [ 'dark' | 'light' | <custom-ident> ]+ && 'only'?"]
let property_color_scheme_runtime_module_path = Some "Css_types.ColorScheme"

let property_media_prefers_contrast : property_media_prefers_contrast Rule.rule = [%spec "'no-preference' | 'more' | 'less'"]
let property_media_prefers_contrast_runtime_module_path = Some "Css_types.MediaPrefersContrast"

let property_media_prefers_reduced_motion : property_media_prefers_reduced_motion Rule.rule = [%spec "'no-preference' | 'reduce'"]
let property_media_prefers_reduced_motion_runtime_module_path = Some "Css_types.MediaPrefersReducedMotion"

let property_media_resolution : property_media_resolution Rule.rule = [%spec "<resolution>"]
let property_media_resolution_runtime_module_path = Some "Css_types.MediaResolution"

let property_media_min_resolution : property_media_min_resolution Rule.rule = [%spec "<resolution>"]
let property_media_min_resolution_runtime_module_path = Some "Css_types.MediaMinResolution"

let property_media_max_resolution : property_media_max_resolution Rule.rule = [%spec "<resolution>"]
let property_media_max_resolution_runtime_module_path = Some "Css_types.MediaMaxResolution"

let property_media_scripting : property_media_scripting Rule.rule = [%spec "'none' | 'initial-only' | 'enabled'"]
let property_media_scripting_runtime_module_path = Some "Css_types.MediaScripting"

let property_media_update : property_media_update Rule.rule = [%spec "'none' | 'slow' | 'fast'"]
let property_media_update_runtime_module_path = Some "Css_types.MediaUpdate"

let property_media_orientation : property_media_orientation Rule.rule = [%spec "'portrait' | 'landscape'"]
let property_media_orientation_runtime_module_path = Some "Css_types.MediaOrientation"

let property_object_fit : property_object_fit Rule.rule = [%spec "'fill' | 'contain' | 'cover' | 'none' | 'scale-down'"]
let property_object_fit_runtime_module_path = Some "Css_types.ObjectFit"

let property_object_position : property_object_position Rule.rule = [%spec "<position> | 'inherit' | 'initial' | 'unset' | 'revert' | 'revert-layer'"]
let property_object_position_runtime_module_path = Some "Css_types.ObjectPosition"

let property_offset : property_offset Rule.rule = [%spec "[ <'offset-position'>? [ <'offset-path'> [ <'offset-distance'> || \
   <'offset-rotate'> ]? ]? ]? [ '/' <'offset-anchor'> ]?"]
let property_offset_runtime_module_path = Some "Css_types.Offset"

let property_offset_anchor : property_offset_anchor Rule.rule = [%spec "'auto' | <position>"]
let property_offset_anchor_runtime_module_path = Some "Css_types.OffsetAnchor"

let property_offset_distance : property_offset_distance Rule.rule = [%spec "<extended-length> | <extended-percentage>"]
let property_offset_distance_runtime_module_path = Some "Css_types.OffsetDistance"

let property_offset_path : property_offset_path Rule.rule = [%spec "'none' | ray( <extended-angle> && [ <ray-size> ]? && [ 'contain' ]? ) | \
   <path()> | <url> | <basic-shape> || <geometry-box>"]
let property_offset_path_runtime_module_path = Some "Css_types.OffsetPath"

let property_offset_position : property_offset_position Rule.rule = [%spec "'auto' | <position>"]
let property_offset_position_runtime_module_path = Some "Css_types.OffsetPosition"

let property_offset_rotate : property_offset_rotate Rule.rule = [%spec "[ 'auto' | 'reverse' ] || <extended-angle>"]
let property_offset_rotate_runtime_module_path = Some "Css_types.OffsetRotate"

let property_opacity : property_opacity Rule.rule = [%spec "<alpha-value>"]

let property_order : property_order Rule.rule = [%spec "<integer>"]
let property_order_runtime_module_path = Some "Css_types.Order"

let property_orphans : property_orphans Rule.rule = [%spec "<integer>"]
let property_orphans_runtime_module_path = Some "Css_types.Orphans"

let property_outline : property_outline Rule.rule = [%spec "'none' | <'outline-width'> | [ <'outline-width'> <'outline-style'> ] | [ \
   <'outline-width'> <'outline-style'> [ <color> | <interpolation> ]]"]
let property_outline_runtime_module_path = Some "Css_types.Outline"

let property_outline_color : property_outline_color Rule.rule = [%spec "<color>"]

let property_outline_offset : property_outline_offset Rule.rule = [%spec "<extended-length>"]

let property_outline_style : property_outline_style Rule.rule = [%spec "'auto' | <line-style> | <interpolation>"]
let property_outline_style_runtime_module_path = Some "Css_types.OutlineStyle"

let property_outline_width : property_outline_width Rule.rule = [%spec "<line-width> | <interpolation>"]

let property_overflow : property_overflow Rule.rule = [%spec "[ 'visible' | 'hidden' | 'clip' | 'scroll' | 'auto' ]{1,2} | \
   <-non-standard-overflow> | <interpolation>"]
let property_overflow_runtime_module_path = Some "Css_types.Overflow"

let property_overflow_anchor : property_overflow_anchor Rule.rule = [%spec "'auto' | 'none'"]
let property_overflow_anchor_runtime_module_path = Some "Css_types.OverflowAnchor"

let property_overflow_block : property_overflow_block Rule.rule = [%spec "'visible' | 'hidden' | 'clip' | 'scroll' | 'auto' | <interpolation>"]
let property_overflow_block_runtime_module_path = Some "Css_types.OverflowBlock"

let property_overflow_clip_margin : property_overflow_clip_margin Rule.rule = [%spec "<visual-box> || <extended-length>"]
let property_overflow_clip_margin_runtime_module_path = Some "Css_types.OverflowClipMargin"

let property_overflow_inline : property_overflow_inline Rule.rule = [%spec "'visible' | 'hidden' | 'clip' | 'scroll' | 'auto' | <interpolation>"]
let property_overflow_inline_runtime_module_path = Some "Css_types.OverflowInline"

let property_overflow_wrap : property_overflow_wrap Rule.rule = [%spec "'normal' | 'break-word' | 'anywhere'"]
let property_overflow_wrap_runtime_module_path = Some "Css_types.OverflowWrap"

let property_overflow_x : property_overflow_x Rule.rule = [%spec "'visible' | 'hidden' | 'clip' | 'scroll' | 'auto' | <interpolation>"]

let property_overflow_y : property_overflow_y Rule.rule = [%spec "'visible' | 'hidden' | 'clip' | 'scroll' | 'auto' | <interpolation>"]

let property_overscroll_behavior : property_overscroll_behavior Rule.rule = [%spec "[ 'contain' | 'none' | 'auto' ]{1,2}"]
let property_overscroll_behavior_runtime_module_path = Some "Css_types.OverscrollBehavior"

let property_overscroll_behavior_block : property_overscroll_behavior_block Rule.rule = [%spec "'contain' | 'none' | 'auto'"]
let property_overscroll_behavior_block_runtime_module_path = Some "Css_types.OverscrollBehaviorBlock"

let property_overscroll_behavior_inline : property_overscroll_behavior_inline Rule.rule = [%spec "'contain' | 'none' | 'auto'"]
let property_overscroll_behavior_inline_runtime_module_path = Some "Css_types.OverscrollBehaviorInline"

let property_overscroll_behavior_x : property_overscroll_behavior_x Rule.rule = [%spec "'contain' | 'none' | 'auto'"]
let property_overscroll_behavior_x_runtime_module_path = Some "Css_types.OverscrollBehaviorX"

let property_overscroll_behavior_y : property_overscroll_behavior_y Rule.rule = [%spec "'contain' | 'none' | 'auto'"]
let property_overscroll_behavior_y_runtime_module_path = Some "Css_types.OverscrollBehaviorY"

let property_padding : property_padding Rule.rule = [%spec "[ <extended-length> | <extended-percentage> | <interpolation> ]{1,4}"]
let property_padding_runtime_module_path = Some "Css_types.Padding"

let property_padding_block : property_padding_block Rule.rule = [%spec "[ <'padding-left'> ]{1,2}"]
let property_padding_block_runtime_module_path = Some "Css_types.PaddingBlock"

let property_padding_block_end : property_padding_block_end Rule.rule = [%spec "<'padding-left'>"]

let property_padding_block_start : property_padding_block_start Rule.rule = [%spec "<'padding-left'>"]

let property_padding_bottom : property_padding_bottom Rule.rule = [%spec "<extended-length> | <extended-percentage>"]

let property_padding_inline : property_padding_inline Rule.rule = [%spec "[ <'padding-left'> ]{1,2}"]
let property_padding_inline_runtime_module_path = Some "Css_types.PaddingInline"

let property_padding_inline_end : property_padding_inline_end Rule.rule = [%spec "<'padding-left'>"]

let property_padding_inline_start : property_padding_inline_start Rule.rule = [%spec "<'padding-left'>"]

let property_padding_left : property_padding_left Rule.rule = [%spec "<extended-length> | <extended-percentage>"]

let property_padding_right : property_padding_right Rule.rule = [%spec "<extended-length> | <extended-percentage>"]

let property_padding_top : property_padding_top Rule.rule = [%spec "<extended-length> | <extended-percentage>"]

let property_page_break_after : property_page_break_after Rule.rule = [%spec "'auto' | 'always' | 'avoid' | 'left' | 'right' | 'recto' | 'verso'"]
let property_page_break_after_runtime_module_path = Some "Css_types.PageBreakAfter"

let property_page_break_before : property_page_break_before Rule.rule = [%spec "'auto' | 'always' | 'avoid' | 'left' | 'right' | 'recto' | 'verso'"]
let property_page_break_before_runtime_module_path = Some "Css_types.PageBreakBefore"

let property_page_break_inside : property_page_break_inside Rule.rule = [%spec "'auto' | 'avoid'"]
let property_page_break_inside_runtime_module_path = Some "Css_types.PageBreakInside"

let property_paint_order : property_paint_order Rule.rule = [%spec "'normal' | 'fill' || 'stroke' || 'markers'"]
let property_paint_order_runtime_module_path = Some "Css_types.PaintOrder"

let property_pause : property_pause Rule.rule = [%spec "<'pause-before'> [ <'pause-after'> ]?"]
let property_pause_runtime_module_path = Some "Css_types.Pause"

let property_pause_after : property_pause_after Rule.rule = [%spec "<extended-time> | 'none' | 'x-weak' | 'weak' | 'medium' | 'strong' | \
   'x-strong'"]
let property_pause_after_runtime_module_path = Some "Css_types.PauseAfter"

let property_pause_before : property_pause_before Rule.rule = [%spec "<extended-time> | 'none' | 'x-weak' | 'weak' | 'medium' | 'strong' | \
   'x-strong'"]
let property_pause_before_runtime_module_path = Some "Css_types.PauseBefore"

let property_perspective : property_perspective Rule.rule = [%spec "'none' | <extended-length>"]
let property_perspective_runtime_module_path = Some "Css_types.Perspective"

let property_perspective_origin : property_perspective_origin Rule.rule = [%spec "<position>"]
let property_perspective_origin_runtime_module_path = Some "Css_types.PerspectiveOrigin"

let property_place_content : property_place_content Rule.rule = [%spec "<'align-content'> [ <'justify-content'> ]?"]
let property_place_content_runtime_module_path = Some "Css_types.PlaceContent"

let property_place_items : property_place_items Rule.rule = [%spec "<'align-items'> [ <'justify-items'> ]?"]
let property_place_items_runtime_module_path = Some "Css_types.PlaceItems"

let property_place_self : property_place_self Rule.rule = [%spec "<'align-self'> [ <'justify-self'> ]?"]
let property_place_self_runtime_module_path = Some "Css_types.PlaceSelf"

let property_pointer_events : property_pointer_events Rule.rule = [%spec "'auto' | 'none' | 'visiblePainted' | 'visibleFill' | 'visibleStroke' | \
   'visible' | 'painted' | 'fill' | 'stroke' | 'all' | 'inherit'"]
let property_pointer_events_runtime_module_path = Some "Css_types.PointerEvents"

let property_position : property_position Rule.rule = [%spec "'static' | 'relative' | 'absolute' | 'sticky' | 'fixed' | '-webkit-sticky'"]
let property_position_runtime_module_path = Some "Css_types.Position"

let property_quotes : property_quotes Rule.rule = [%spec "'none' | 'auto' | [ <string> <string> ]+"]
let property_quotes_runtime_module_path = Some "Css_types.Quotes"

let property_resize : property_resize Rule.rule = [%spec "'none' | 'both' | 'horizontal' | 'vertical' | 'block' | 'inline'"]
let property_resize_runtime_module_path = Some "Css_types.Resize"

let property_rest : property_rest Rule.rule = [%spec "<'rest-before'> [ <'rest-after'> ]?"]
let property_rest_runtime_module_path = Some "Css_types.Rest"

let property_rest_after : property_rest_after Rule.rule = [%spec "<extended-time> | 'none' | 'x-weak' | 'weak' | 'medium' | 'strong' | \
   'x-strong'"]
let property_rest_after_runtime_module_path = Some "Css_types.RestAfter"

let property_rest_before : property_rest_before Rule.rule = [%spec "<extended-time> | 'none' | 'x-weak' | 'weak' | 'medium' | 'strong' | \
   'x-strong'"]
let property_rest_before_runtime_module_path = Some "Css_types.RestBefore"

let property_right : property_right Rule.rule = [%spec "<extended-length> | <extended-percentage> | 'auto'"]
let property_right_runtime_module_path = Some "Css_types.Right"

let property_rotate : property_rotate Rule.rule = [%spec "'none' | <extended-angle> | [ 'x' | 'y' | 'z' | [ <number> ]{3} ] && \
   <extended-angle>"]
let property_rotate_runtime_module_path = Some "Css_types.Rotate"

let property_row_gap : property_row_gap Rule.rule = [%spec "'normal' | <extended-length> | <extended-percentage>"]

let property_ruby_align : property_ruby_align Rule.rule = [%spec "'start' | 'center' | 'space-between' | 'space-around'"]
let property_ruby_align_runtime_module_path = Some "Css_types.RubyAlign"

let property_ruby_merge : property_ruby_merge Rule.rule = [%spec "'separate' | 'collapse' | 'auto'"]
let property_ruby_merge_runtime_module_path = Some "Css_types.RubyMerge"

let property_ruby_position : property_ruby_position Rule.rule = [%spec "'over' | 'under' | 'inter-character'"]
let property_ruby_position_runtime_module_path = Some "Css_types.RubyPosition"

let property_scale : property_scale Rule.rule = [%spec "'none' | [ <number-percentage> ]{1,3}"]
let property_scale_runtime_module_path = Some "Css_types.Scale"

let property_scroll_behavior : property_scroll_behavior Rule.rule = [%spec "'auto' | 'smooth'"]
let property_scroll_behavior_runtime_module_path = Some "Css_types.ScrollBehavior"

let property_scroll_margin : property_scroll_margin Rule.rule = [%spec "[ <extended-length> ]{1,4}"]
let property_scroll_margin_runtime_module_path = Some "Css_types.ScrollMargin"

let property_scroll_margin_block : property_scroll_margin_block Rule.rule = [%spec "[ <extended-length> ]{1,2}"]

let property_scroll_margin_block_end : property_scroll_margin_block_end Rule.rule = [%spec "<extended-length>"]

let property_scroll_margin_block_start : property_scroll_margin_block_start Rule.rule = [%spec "<extended-length>"]

let property_scroll_margin_bottom : property_scroll_margin_bottom Rule.rule = [%spec "<extended-length>"]

let property_scroll_margin_inline : property_scroll_margin_inline Rule.rule = [%spec "[ <extended-length> ]{1,2}"]

let property_scroll_margin_inline_end : property_scroll_margin_inline_end Rule.rule = [%spec "<extended-length>"]

let property_scroll_margin_inline_start : property_scroll_margin_inline_start Rule.rule = [%spec "<extended-length>"]

let property_scroll_margin_left : property_scroll_margin_left Rule.rule = [%spec "<extended-length>"]

let property_scroll_margin_right : property_scroll_margin_right Rule.rule = [%spec "<extended-length>"]

let property_scroll_margin_top : property_scroll_margin_top Rule.rule = [%spec "<extended-length>"]

let property_scroll_padding : property_scroll_padding Rule.rule = [%spec "[ 'auto' | <extended-length> | <extended-percentage> ]{1,4}"]
let property_scroll_padding_runtime_module_path = Some "Css_types.ScrollPadding"

let property_scroll_padding_block : property_scroll_padding_block Rule.rule = [%spec "[ 'auto' | <extended-length> | <extended-percentage> ]{1,2}"]

let property_scroll_padding_block_end : property_scroll_padding_block_end Rule.rule = [%spec "'auto' | <extended-length> | <extended-percentage>"]

let property_scroll_padding_block_start : property_scroll_padding_block_start Rule.rule = [%spec "'auto' | <extended-length> | <extended-percentage>"]

let property_scroll_padding_bottom : property_scroll_padding_bottom Rule.rule = [%spec "'auto' | <extended-length> | <extended-percentage>"]

let property_scroll_padding_inline : property_scroll_padding_inline Rule.rule = [%spec "[ 'auto' | <extended-length> | <extended-percentage> ]{1,2}"]

let property_scroll_padding_inline_end : property_scroll_padding_inline_end Rule.rule = [%spec "'auto' | <extended-length> | <extended-percentage>"]

let property_scroll_padding_inline_start : property_scroll_padding_inline_start Rule.rule = [%spec "'auto' | <extended-length> | <extended-percentage>"]

let property_scroll_padding_left : property_scroll_padding_left Rule.rule = [%spec "'auto' | <extended-length> | <extended-percentage>"]

let property_scroll_padding_right : property_scroll_padding_right Rule.rule = [%spec "'auto' | <extended-length> | <extended-percentage>"]

let property_scroll_padding_top : property_scroll_padding_top Rule.rule = [%spec "'auto' | <extended-length> | <extended-percentage>"]

let property_scroll_snap_align : property_scroll_snap_align Rule.rule = [%spec "[ 'none' | 'start' | 'end' | 'center' ]{1,2}"]
let property_scroll_snap_align_runtime_module_path = Some "Css_types.ScrollSnapAlign"

let property_scroll_snap_coordinate : property_scroll_snap_coordinate Rule.rule = [%spec "'none' | [ <position> ]#"]
let property_scroll_snap_coordinate_runtime_module_path = Some "Css_types.ScrollSnapCoordinate"

let property_scroll_snap_destination : property_scroll_snap_destination Rule.rule = [%spec "<position>"]
let property_scroll_snap_destination_runtime_module_path = Some "Css_types.ScrollSnapDestination"

let property_scroll_snap_points_x : property_scroll_snap_points_x Rule.rule = [%spec "'none' | repeat( <extended-length> | <extended-percentage> )"]
let property_scroll_snap_points_x_runtime_module_path = Some "Css_types.ScrollSnapPointsX"

let property_scroll_snap_points_y : property_scroll_snap_points_y Rule.rule = [%spec "'none' | repeat( <extended-length> | <extended-percentage> )"]
let property_scroll_snap_points_y_runtime_module_path = Some "Css_types.ScrollSnapPointsY"

let property_scroll_snap_stop : property_scroll_snap_stop Rule.rule = [%spec "'normal' | 'always'"]
let property_scroll_snap_stop_runtime_module_path = Some "Css_types.ScrollSnapStop"

let property_scroll_snap_type : property_scroll_snap_type Rule.rule = [%spec "'none' | [ 'x' | 'y' | 'block' | 'inline' | 'both' ] [ 'mandatory' | \
   'proximity' ]?"]
let property_scroll_snap_type_runtime_module_path = Some "Css_types.ScrollSnapType"

let property_scroll_snap_type_x : property_scroll_snap_type_x Rule.rule = [%spec "'none' | 'mandatory' | 'proximity'"]

let property_scroll_snap_type_y : property_scroll_snap_type_y Rule.rule = [%spec "'none' | 'mandatory' | 'proximity'"]

let property_scrollbar_color : property_scrollbar_color Rule.rule = [%spec "'auto' | [ <color> <color> ]"]
let property_scrollbar_color_runtime_module_path = Some "Css_types.ScrollbarColor"

let property_scrollbar_width : property_scrollbar_width Rule.rule = [%spec "'auto' | 'thin' | 'none'"]
let property_scrollbar_width_runtime_module_path = Some "Css_types.ScrollbarWidth"

let property_scrollbar_gutter : property_scrollbar_gutter Rule.rule = [%spec "'auto' | 'stable' && 'both-edges'?"]
let property_scrollbar_gutter_runtime_module_path = Some "Css_types.ScrollbarGutter"

let property_scrollbar_3dlight_color : property_scrollbar_3dlight_color Rule.rule = [%spec "<color>"]
let property_scrollbar_3dlight_color_runtime_module_path = Some "Css_types.Scrollbar3dlightColor"

let property_scrollbar_arrow_color : property_scrollbar_arrow_color Rule.rule = [%spec "<color>"]
let property_scrollbar_arrow_color_runtime_module_path = Some "Css_types.ScrollbarArrowColor"

let property_scrollbar_base_color : property_scrollbar_base_color Rule.rule = [%spec "<color>"]
let property_scrollbar_base_color_runtime_module_path = Some "Css_types.ScrollbarBaseColor"

let property_scrollbar_darkshadow_color : property_scrollbar_darkshadow_color Rule.rule = [%spec "<color>"]
let property_scrollbar_darkshadow_color_runtime_module_path = Some "Css_types.ScrollbarDarkshadowColor"

let property_scrollbar_face_color : property_scrollbar_face_color Rule.rule = [%spec "<color>"]
let property_scrollbar_face_color_runtime_module_path = Some "Css_types.ScrollbarFaceColor"

let property_scrollbar_highlight_color : property_scrollbar_highlight_color Rule.rule = [%spec "<color>"]
let property_scrollbar_highlight_color_runtime_module_path = Some "Css_types.ScrollbarHighlightColor"

let property_scrollbar_shadow_color : property_scrollbar_shadow_color Rule.rule = [%spec "<color>"]
let property_scrollbar_shadow_color_runtime_module_path = Some "Css_types.ScrollbarShadowColor"

let property_scrollbar_track_color : property_scrollbar_track_color Rule.rule = [%spec "<color>"]
let property_scrollbar_track_color_runtime_module_path = Some "Css_types.ScrollbarTrackColor"

let property_shape_image_threshold : property_shape_image_threshold Rule.rule = [%spec "<alpha-value>"]
let property_shape_image_threshold_runtime_module_path = Some "Css_types.ShapeImageThreshold"

let property_shape_margin : property_shape_margin Rule.rule = [%spec "<extended-length> | <extended-percentage>"]
let property_shape_margin_runtime_module_path = Some "Css_types.ShapeMargin"

let property_shape_outside : property_shape_outside Rule.rule = [%spec "'none' | <shape-box> || <basic-shape> | <image>"]
let property_shape_outside_runtime_module_path = Some "Css_types.ShapeOutside"

let property_shape_rendering : property_shape_rendering Rule.rule = [%spec "'auto' | 'optimizeSpeed' | 'crispEdges' | 'geometricPrecision'"]
let property_shape_rendering_runtime_module_path = Some "Css_types.ShapeRendering"

let property_speak : property_speak Rule.rule = [%spec "'auto' | 'none' | 'normal'"]
let property_speak_runtime_module_path = Some "Css_types.Speak"

let property_speak_as : property_speak_as Rule.rule = [%spec "'normal' | 'spell-out' || 'digits' || [ 'literal-punctuation' | \
   'no-punctuation' ]"]
let property_speak_as_runtime_module_path = Some "Css_types.SpeakAs"

let property_src : property_src Rule.rule = [%spec "[ <url> [ format( [ <string> ]# ) ]? | local( <family-name> ) ]#"]
let property_src_runtime_module_path = Some "Css_types.Src"

let property_stroke : property_stroke Rule.rule = [%spec "<paint>"]
let property_stroke_runtime_module_path = Some "Css_types.Paint"

let property_stroke_dasharray : property_stroke_dasharray Rule.rule = [%spec "'none' | [ [ <svg-length> ]+ ]#"]

let property_stroke_dashoffset : property_stroke_dashoffset Rule.rule = [%spec "<svg-length>"]
let property_stroke_dashoffset_runtime_module_path = Some "Css_types.StrokeDashoffset"

let property_stroke_linecap : property_stroke_linecap Rule.rule = [%spec "'butt' | 'round' | 'square'"]
let property_stroke_linecap_runtime_module_path = Some "Css_types.StrokeLinecap"

let property_stroke_linejoin : property_stroke_linejoin Rule.rule = [%spec "'miter' | 'round' | 'bevel'"]
let property_stroke_linejoin_runtime_module_path = Some "Css_types.StrokeLinejoin"

let property_stroke_miterlimit : property_stroke_miterlimit Rule.rule = [%spec "<number-one-or-greater>"]
let property_stroke_miterlimit_runtime_module_path = Some "Css_types.StrokeMiterlimit"

let property_stroke_opacity : property_stroke_opacity Rule.rule = [%spec "<alpha-value>"]
let property_stroke_opacity_runtime_module_path = Some "Css_types.StrokeOpacity"

let property_stroke_width : property_stroke_width Rule.rule = [%spec "<svg-length>"]
let property_stroke_width_runtime_module_path = Some "Css_types.StrokeWidth"

let property_tab_size : property_tab_size Rule.rule = [%spec " <number> | <extended-length>"]
let property_tab_size_runtime_module_path = Some "Css_types.TabSize"

let property_table_layout : property_table_layout Rule.rule = [%spec "'auto' | 'fixed'"]
let property_table_layout_runtime_module_path = Some "Css_types.TableLayout"

let property_text_autospace : property_text_autospace Rule.rule = [%spec "'none' | 'ideograph-alpha' | 'ideograph-numeric' | 'ideograph-parenthesis' \
   | 'ideograph-space'"]
let property_text_autospace_runtime_module_path = Some "Css_types.TextAutospace"

let property_text_blink : property_text_blink Rule.rule = [%spec "'none' | 'blink' | 'blink-anywhere'"]
let property_text_blink_runtime_module_path = Some "Css_types.TextBlink"

let property_text_align : property_text_align Rule.rule = [%spec "'start' | 'end' | 'left' | 'right' | 'center' | 'justify' | 'match-parent' \
   | 'justify-all'"]
let property_text_align_runtime_module_path = Some "Css_types.TextAlign"

let property_text_align_all : property_text_align_all Rule.rule = [%spec "'start' | 'end' | 'left' | 'right' | 'center' | 'justify' | 'match-parent'"]
let property_text_align_all_runtime_module_path = Some "Css_types.TextAlignAll"

let property_text_align_last : property_text_align_last Rule.rule = [%spec "'auto' | 'start' | 'end' | 'left' | 'right' | 'center' | 'justify' | \
   'match-parent'"]
let property_text_align_last_runtime_module_path = Some "Css_types.TextAlignLast"

let property_text_anchor : property_text_anchor Rule.rule = [%spec "'start' | 'middle' | 'end'"]
let property_text_anchor_runtime_module_path = Some "Css_types.TextAnchor"

let property_text_combine_upright : property_text_combine_upright Rule.rule = [%spec "'none' | 'all' | 'digits' [ <integer> ]?"]
let property_text_combine_upright_runtime_module_path = Some "Css_types.TextCombineUpright"

let property_text_decoration : property_text_decoration Rule.rule = [%spec "<'text-decoration-color'> || <'text-decoration-style'> || \
   <'text-decoration-thickness'> || <'text-decoration-line'>"]
let property_text_decoration_runtime_module_path = Some "Css_types.TextDecoration"

let property_text_justify_trim : property_text_justify_trim Rule.rule = [%spec "'none' | 'all' | 'auto'"]
let property_text_justify_trim_runtime_module_path = Some "Css_types.TextJustifyTrim"

let property_text_kashida : property_text_kashida Rule.rule = [%spec "'none' | 'horizontal' | 'vertical' | 'both'"]
let property_text_kashida_runtime_module_path = Some "Css_types.TextKashida"

let property_text_kashida_space : property_text_kashida_space Rule.rule = [%spec "'normal' | 'pre' | 'post'"]
let property_text_kashida_space_runtime_module_path = Some "Css_types.TextKashidaSpace"

let property_text_decoration_color : property_text_decoration_color Rule.rule = [%spec "<color>"]

(* Spec doesn't contain spelling-error module grammar-error: https://developer.mozilla.org/en-US/docs/Web/CSS/text-decoration-line but this list used to have them | 'spelling-error' | 'grammar-error'. Leaving this comment here for reference *)
(* module this definition has changed from the origianl, it might be a bug on the spec or our Generator,
   but simplifying to "|" simplifies it module solves the bug *)
let property_text_decoration_line : property_text_decoration_line Rule.rule = [%spec "'none' | <interpolation> | [ 'underline' || 'overline' || 'line-through' || \
   'blink' ]"]
let property_text_decoration_line_runtime_module_path = Some "Css_types.TextDecorationLine"

let property_text_decoration_skip : property_text_decoration_skip Rule.rule = [%spec "'none' | 'objects' || [ 'spaces' | 'leading-spaces' || 'trailing-spaces' ] \
   || 'edges' || 'box-decoration'"]
let property_text_decoration_skip_runtime_module_path = Some "Css_types.TextDecorationSkip"

let property_text_decoration_skip_self : property_text_decoration_skip_self Rule.rule = [%spec "'none' | 'objects' || [ 'spaces' | 'leading-spaces' || 'trailing-spaces' ] \
   || 'edges' || 'box-decoration'"]
let property_text_decoration_skip_self_runtime_module_path = Some "Css_types.TextDecorationSkipSelf"

let property_text_decoration_skip_ink : property_text_decoration_skip_ink Rule.rule = [%spec "'auto' | 'all' | 'none'"]
let property_text_decoration_skip_ink_runtime_module_path = Some "Css_types.TextDecorationSkipInk"

let property_text_decoration_skip_box : property_text_decoration_skip_box Rule.rule = [%spec "'none' | 'all'"]
let property_text_decoration_skip_box_runtime_module_path = Some "Css_types.TextDecorationSkipBox"

let property_text_decoration_skip_spaces : property_text_decoration_skip_spaces Rule.rule = [%spec "'none' | 'objects' || [ 'spaces' | 'leading-spaces' || 'trailing-spaces' ] \
   || 'edges' || 'box-decoration'"]
let property_text_decoration_skip_spaces_runtime_module_path = Some "Css_types.TextDecorationSkipSpaces"

let property_text_decoration_skip_inset : property_text_decoration_skip_inset Rule.rule = [%spec "'none' | 'auto'"]
let property_text_decoration_skip_inset_runtime_module_path = Some "Css_types.TextDecorationSkipInset"

let property_text_decoration_style : property_text_decoration_style Rule.rule = [%spec "'solid' | 'double' | 'dotted' | 'dashed' | 'wavy'"]
let property_text_decoration_style_runtime_module_path = Some "Css_types.TextDecorationStyle"

let property_text_decoration_thickness : property_text_decoration_thickness Rule.rule = [%spec "'auto' | 'from-font' | <extended-length> | <extended-percentage>"]
let property_text_decoration_thickness_runtime_module_path = Some "Css_types.TextDecorationThickness"

let property_text_emphasis : property_text_emphasis Rule.rule = [%spec "<'text-emphasis-style'> || <'text-emphasis-color'>"]
let property_text_emphasis_runtime_module_path = Some "Css_types.TextEmphasis"

let property_text_emphasis_color : property_text_emphasis_color Rule.rule = [%spec "<color>"]

let property_text_emphasis_position : property_text_emphasis_position Rule.rule = [%spec "[ 'over' | 'under' ] && [ 'right' | 'left' ]?"]
let property_text_emphasis_position_runtime_module_path = Some "Css_types.TextEmphasisPosition"

let property_text_emphasis_style : property_text_emphasis_style Rule.rule = [%spec "'none' | [ 'filled' | 'open' ] || [ 'dot' | 'circle' | 'double-circle' | \
   'triangle' | 'sesame' ] | <string>"]
let property_text_emphasis_style_runtime_module_path = Some "Css_types.TextEmphasisStyle"

let property_text_indent : property_text_indent Rule.rule = [%spec "[<extended-length> | <extended-percentage>] && [ 'hanging' ]? && [ \
   'each-line' ]?"]
let property_text_indent_runtime_module_path = Some "Css_types.TextIndent"

let property_text_justify : property_text_justify Rule.rule = [%spec "'auto' | 'inter-character' | 'inter-word' | 'none'"]
let property_text_justify_runtime_module_path = Some "Css_types.TextJustify"

let property_text_orientation : property_text_orientation Rule.rule = [%spec "'mixed' | 'upright' | 'sideways'"]
let property_text_orientation_runtime_module_path = Some "Css_types.TextOrientation"

let property_text_overflow : property_text_overflow Rule.rule = [%spec "[ 'clip' | 'ellipsis' | <string> ]{1,2}"]
let property_text_overflow_runtime_module_path = Some "Css_types.TextOverflow"

let property_text_rendering : property_text_rendering Rule.rule = [%spec "'auto' | 'optimizeSpeed' | 'optimizeLegibility' | 'geometricPrecision'"]
let property_text_rendering_runtime_module_path = Some "Css_types.TextRendering"

let property_text_shadow : property_text_shadow Rule.rule = [%spec "'none' | <interpolation> | [ <shadow-t> ]#"]
let property_text_shadow_runtime_module_path = Some "Css_types.TextShadow"

let property_text_size_adjust : property_text_size_adjust Rule.rule = [%spec "'none' | 'auto' | <extended-percentage>"]
let property_text_size_adjust_runtime_module_path = Some "Css_types.TextSizeAdjust"

let property_text_transform : property_text_transform Rule.rule = [%spec "'none' | 'capitalize' | 'uppercase' | 'lowercase' | 'full-width' | \
   'full-size-kana'"]
let property_text_transform_runtime_module_path = Some "Css_types.TextTransform"

let property_text_underline_offset : property_text_underline_offset Rule.rule = [%spec "'auto' | <extended-length> | <extended-percentage>"]
let property_text_underline_offset_runtime_module_path = Some "Css_types.TextUnderlineOffset"

let property_text_underline_position : property_text_underline_position Rule.rule = [%spec "'auto' | 'from-font' | 'under' || [ 'left' | 'right' ]"]
let property_text_underline_position_runtime_module_path = Some "Css_types.TextUnderlinePosition"

let property_top : property_top Rule.rule = [%spec "<extended-length> | <extended-percentage> | 'auto'"]
let property_top_runtime_module_path = Some "Css_types.Top"

let property_touch_action : property_touch_action Rule.rule = [%spec "'auto' | 'none' | [ 'pan-x' | 'pan-left' | 'pan-right' ] || [ 'pan-y' | \
   'pan-up' | 'pan-down' ] || 'pinch-zoom' | 'manipulation'"]
let property_touch_action_runtime_module_path = Some "Css_types.TouchAction"

let property_transform : property_transform Rule.rule = [%spec "'none' | <transform-list>"]
let property_transform_runtime_module_path = Some "Css_types.Transform"

let property_transform_box : property_transform_box Rule.rule = [%spec "'content-box' | 'border-box' | 'fill-box' | 'stroke-box' | 'view-box'"]
let property_transform_box_runtime_module_path = Some "Css_types.TransformBox"

let property_transform_origin : property_transform_origin Rule.rule = [%spec "[ 'left' | 'center' | 'right' | 'top' | 'bottom' | <length-percentage> ] | \
   [ 'left' | 'center' | 'right' | <length-percentage> ] [ 'top' | 'center' | \
   'bottom' | <length-percentage> ] <length>? | [[ 'center' | 'left' | 'right' \
   ] && [ 'center' | 'top' | 'bottom' ]] <length>? "]
let property_transform_origin_runtime_module_path = Some "Css_types.TransformOrigin"

let property_transform_style : property_transform_style Rule.rule = [%spec "'flat' | 'preserve-3d'"]
let property_transform_style_runtime_module_path = Some "Css_types.TransformStyle"

let property_transition : property_transition Rule.rule = [%spec "[ <single-transition> | <single-transition-no-interp> ]#"]
let property_transition_runtime_module_path = Some "Css_types.Transition"

let property_transition_behavior : property_transition_behavior Rule.rule = [%spec "<transition-behavior-value>#"]
let property_transition_behavior_runtime_module_path = Some "Css_types.TransitionBehavior"

let property_transition_delay : property_transition_delay Rule.rule = [%spec "[ <extended-time> ]#"]
let property_transition_delay_runtime_module_path = Some "Css_types.TransitionDelay"

let property_transition_duration : property_transition_duration Rule.rule = [%spec "[ <extended-time> ]#"]
let property_transition_duration_runtime_module_path = Some "Css_types.TransitionDuration"

let property_transition_property : property_transition_property Rule.rule = [%spec "[ <single-transition-property> ]# | 'none'"]

let property_transition_timing_function : property_transition_timing_function Rule.rule = [%spec "[ <timing-function> ]#"]
let property_transition_timing_function_runtime_module_path = Some "Css_types.TransitionTimingFunction"

let property_translate : property_translate Rule.rule = [%spec "'none' | <length-percentage> [ <length-percentage> <length>? ]?"]
let property_translate_runtime_module_path = Some "Css_types.Translate"

let property_unicode_bidi : property_unicode_bidi Rule.rule = [%spec "'normal' | 'embed' | 'isolate' | 'bidi-override' | 'isolate-override' | \
   'plaintext' | '-moz-isolate' | '-moz-isolate-override' | '-moz-plaintext' | \
   '-webkit-isolate'"]
let property_unicode_bidi_runtime_module_path = Some "Css_types.UnicodeBidi"

let property_unicode_range : property_unicode_range Rule.rule = [%spec "[ <urange> ]#"]
let property_unicode_range_runtime_module_path = Some "Css_types.UnicodeRange"

let property_user_select : property_user_select Rule.rule = [%spec "'auto' | 'text' | 'none' | 'contain' | 'all' | <interpolation>"]
let property_user_select_runtime_module_path = Some "Css_types.UserSelect"

let property_vertical_align : property_vertical_align Rule.rule = [%spec "'baseline' | 'sub' | 'super' | 'text-top' | 'text-bottom' | 'middle' | \
   'top' | 'bottom' | <extended-percentage> | <extended-length>"]
let property_vertical_align_runtime_module_path = Some "Css_types.VerticalAlign"

let property_visibility : property_visibility Rule.rule = [%spec "'visible' | 'hidden' | 'collapse' | <interpolation>"]
let property_visibility_runtime_module_path = Some "Css_types.Visibility"

let property_voice_balance : property_voice_balance Rule.rule = [%spec "<number> | 'left' | 'center' | 'right' | 'leftwards' | 'rightwards'"]
let property_voice_balance_runtime_module_path = Some "Css_types.VoiceBalance"

let property_voice_duration : property_voice_duration Rule.rule = [%spec "'auto' | <extended-time>"]
let property_voice_duration_runtime_module_path = Some "Css_types.VoiceDuration"

let property_voice_family : property_voice_family Rule.rule = [%spec "[ [ <family-name> | <generic-voice> ] ',' ]* [ <family-name> | \
   <generic-voice> ] | 'preserve'"]
let property_voice_family_runtime_module_path = Some "Css_types.VoiceFamily"

let property_voice_pitch : property_voice_pitch Rule.rule = [%spec "<extended-frequency> && 'absolute' | [ 'x-low' | 'low' | 'medium' | 'high' \
   | 'x-high' ] || [ <extended-frequency> | <semitones> | \
   <extended-percentage> ]"]
let property_voice_pitch_runtime_module_path = Some "Css_types.VoicePitch"

let property_voice_range : property_voice_range Rule.rule = [%spec "<extended-frequency> && 'absolute' | [ 'x-low' | 'low' | 'medium' | 'high' \
   | 'x-high' ] || [ <extended-frequency> | <semitones> | \
   <extended-percentage> ]"]
let property_voice_range_runtime_module_path = Some "Css_types.VoiceRange"

let property_voice_rate : property_voice_rate Rule.rule = [%spec "[ 'normal' | 'x-slow' | 'slow' | 'medium' | 'fast' | 'x-fast' ] || \
   <extended-percentage>"]
let property_voice_rate_runtime_module_path = Some "Css_types.VoiceRate"

let property_voice_stress : property_voice_stress Rule.rule = [%spec "'normal' | 'strong' | 'moderate' | 'none' | 'reduced'"]
let property_voice_stress_runtime_module_path = Some "Css_types.VoiceStress"

let property_voice_volume : property_voice_volume Rule.rule = [%spec "'silent' | [ 'x-soft' | 'soft' | 'medium' | 'loud' | 'x-loud' ] || <decibel>"]
let property_voice_volume_runtime_module_path = Some "Css_types.VoiceVolume"

let property_white_space : property_white_space Rule.rule = [%spec "'normal' | 'pre' | 'nowrap' | 'pre-wrap' | 'pre-line' | 'break-spaces'"]
let property_white_space_runtime_module_path = Some "Css_types.WhiteSpace"

let property_widows : property_widows Rule.rule = [%spec "<integer>"]
let property_widows_runtime_module_path = Some "Css_types.Widows"

let property_width : property_width Rule.rule = [%spec "'auto' | <extended-length> | <extended-percentage> | 'min-content' | \
   'max-content' | 'fit-content' | fit-content( <extended-length> | \
   <extended-percentage> )"]
let property_width_runtime_module_path = Some "Css_types.Width"

let property_will_change : property_will_change Rule.rule = [%spec "'auto' | [ <animateable-feature> ]#"]
let property_will_change_runtime_module_path = Some "Css_types.WillChange"

let property_word_break : property_word_break Rule.rule = [%spec "'normal' | 'break-all' | 'keep-all' | 'break-word'"]
let property_word_break_runtime_module_path = Some "Css_types.WordBreak"

let property_word_spacing : property_word_spacing Rule.rule = [%spec "'normal' | <extended-length> | <extended-percentage>"]
let property_word_spacing_runtime_module_path = Some "Css_types.WordSpacing"

let property_word_wrap : property_word_wrap Rule.rule = [%spec "'normal' | 'break-word' | 'anywhere'"]
let property_word_wrap_runtime_module_path = Some "Css_types.WordWrap"

let property_writing_mode : property_writing_mode Rule.rule = [%spec "'horizontal-tb' | 'vertical-rl' | 'vertical-lr' | 'sideways-rl' | \
   'sideways-lr' | <svg-writing-mode>"]
let property_writing_mode_runtime_module_path = Some "Css_types.WritingMode"

let property_z_index : property_z_index Rule.rule = [%spec "'auto' | <integer> | <interpolation>"]
let property_z_index_runtime_module_path = Some "Css_types.ZIndex"

let property_zoom : property_zoom Rule.rule = [%spec "'normal' | 'reset' | <number> | <extended-percentage>"]
let property_zoom_runtime_module_path = Some "Css_types.Zoom"

let property_container : property_container Rule.rule = [%spec "<'container-name'> [ '/' <'container-type'> ]?"]
let property_container_runtime_module_path = Some "Css_types.Container"

let property_container_name : property_container_name Rule.rule = [%spec "<custom-ident>+ | 'none'"]
let property_container_name_runtime_module_path = Some "Css_types.ContainerName"

let property_container_type : property_container_type Rule.rule = [%spec "'normal' | 'size' | 'inline-size'"]
let property_container_type_runtime_module_path = Some "Css_types.ContainerType"

let property_nav_down : property_nav_down Rule.rule = [%spec "'auto' | <integer> | <interpolation>"]
let property_nav_down_runtime_module_path = Some "Css_types.NavDown"

let property_nav_left : property_nav_left Rule.rule = [%spec "'auto' | <integer> | <interpolation>"]
let property_nav_left_runtime_module_path = Some "Css_types.NavLeft"

let property_nav_right : property_nav_right Rule.rule = [%spec "'auto' | <integer> | <interpolation>"]
let property_nav_right_runtime_module_path = Some "Css_types.NavRight"

let property_nav_up : property_nav_up Rule.rule = [%spec "'auto' | <integer> | <interpolation>"]
let property_nav_up_runtime_module_path = Some "Css_types.NavUp"

let property_accent_color : property_accent_color Rule.rule = [%spec "'auto' | <color>"]
let property_accent_color_runtime_module_path = Some "Css_types.AccentColor"

let property_animation_composition : property_animation_composition Rule.rule = [%spec "[ 'replace' | 'add' | 'accumulate' ]#"]
let property_animation_composition_runtime_module_path = Some "Css_types.AnimationComposition"

let property_animation_range : property_animation_range Rule.rule = [%spec "[ 'normal' | <extended-length> | <extended-percentage> ]{1,2}"]
let property_animation_range_runtime_module_path = Some "Css_types.AnimationRange"

let property_animation_range_end : property_animation_range_end Rule.rule = [%spec "'normal' | <extended-length> | <extended-percentage>"]
let property_animation_range_end_runtime_module_path = Some "Css_types.AnimationRangeEnd"

let property_animation_range_start : property_animation_range_start Rule.rule = [%spec "'normal' | <extended-length> | <extended-percentage>"]
let property_animation_range_start_runtime_module_path = Some "Css_types.AnimationRangeStart"

let property_animation_timeline : property_animation_timeline Rule.rule = [%spec "[ 'none' | <custom-ident> ]#"]
let property_animation_timeline_runtime_module_path = Some "Css_types.AnimationTimeline"

let property_field_sizing : property_field_sizing Rule.rule = [%spec "'content' | 'fixed'"]
let property_field_sizing_runtime_module_path = Some "Css_types.FieldSizing"

let property_interpolate_size : property_interpolate_size Rule.rule = [%spec "'numeric-only' | 'allow-keywords'"]
let property_interpolate_size_runtime_module_path = Some "Css_types.InterpolateSize"

let property_media_type : property_media_type Rule.rule = [%spec "<ident>"]
let property_media_type_runtime_module_path = Some "Css_types.MediaType"

let property_overlay : property_overlay Rule.rule = [%spec "'none' | 'auto'"]
let property_overlay_runtime_module_path = Some "Css_types.Overlay"

let property_scroll_timeline : property_scroll_timeline Rule.rule = [%spec "[ 'none' | <custom-ident> ]# [ 'block' | 'inline' | 'x' | 'y' ]#"]
let property_scroll_timeline_runtime_module_path = Some "Css_types.ScrollTimeline"

let property_scroll_timeline_axis : property_scroll_timeline_axis Rule.rule = [%spec "[ 'block' | 'inline' | 'x' | 'y' ]#"]
let property_scroll_timeline_axis_runtime_module_path = Some "Css_types.ScrollTimelineAxis"

let property_scroll_timeline_name : property_scroll_timeline_name Rule.rule = [%spec "[ 'none' | <custom-ident> ]#"]
let property_scroll_timeline_name_runtime_module_path = Some "Css_types.ScrollTimelineName"

let property_text_wrap : property_text_wrap Rule.rule = [%spec "'wrap' | 'nowrap' | 'balance' | 'stable' | 'pretty'"]
let property_text_wrap_runtime_module_path = Some "Css_types.TextWrap"

let property_view_timeline : property_view_timeline Rule.rule = [%spec "[ 'none' | <custom-ident> ]# [ 'block' | 'inline' | 'x' | 'y' ]#"]
let property_view_timeline_runtime_module_path = Some "Css_types.ViewTimeline"

let property_view_timeline_axis : property_view_timeline_axis Rule.rule = [%spec "[ 'block' | 'inline' | 'x' | 'y' ]#"]
let property_view_timeline_axis_runtime_module_path = Some "Css_types.ViewTimelineAxis"

let property_view_timeline_inset : property_view_timeline_inset Rule.rule = [%spec "[ 'auto' | <extended-length> | <extended-percentage> ]{1,2}"]
let property_view_timeline_inset_runtime_module_path = Some "Css_types.ViewTimelineInset"

let property_view_timeline_name : property_view_timeline_name Rule.rule = [%spec "[ 'none' | <custom-ident> ]#"]
let property_view_timeline_name_runtime_module_path = Some "Css_types.ViewTimelineName"

let property_view_transition_name : property_view_transition_name Rule.rule = [%spec "'none' | <custom-ident>"]
let property_view_transition_name_runtime_module_path = Some "Css_types.ViewTransitionName"

let property_anchor_name : property_anchor_name Rule.rule = [%spec "'none' | [ <dashed-ident> ]#"]
let property_anchor_name_runtime_module_path = Some "Css_types.AnchorName"

let property_anchor_scope : property_anchor_scope Rule.rule = [%spec "'none' | 'all' | [ <dashed-ident> ]#"]
let property_anchor_scope_runtime_module_path = Some "Css_types.AnchorScope"

let property_position_anchor : property_position_anchor Rule.rule = [%spec "'auto' | <dashed-ident>"]
let property_position_anchor_runtime_module_path = Some "Css_types.PositionAnchor"

let property_position_area : property_position_area Rule.rule = [%spec "'none' | [ 'top' | 'bottom' | 'left' | 'right' | 'center' | 'self-start' | \
   'self-end' | 'start' | 'end' ]"]
let property_position_area_runtime_module_path = Some "Css_types.PositionArea"

let property_position_try : property_position_try Rule.rule = [%spec "'none' | [ <dashed-ident> | <try-tactic> ]#"]
let property_position_try_runtime_module_path = Some "Css_types.PositionTry"

let property_position_try_fallbacks : property_position_try_fallbacks Rule.rule = [%spec "'none' | [ <dashed-ident> | <try-tactic> ]#"]
let property_position_try_fallbacks_runtime_module_path = Some "Css_types.PositionTryFallbacks"

let property_position_try_options : property_position_try_options Rule.rule = [%spec "'none' | [ 'flip-block' || 'flip-inline' || 'flip-start' ]"]
let property_position_try_options_runtime_module_path = Some "Css_types.PositionTryOptions"

let property_position_visibility : property_position_visibility Rule.rule = [%spec "'always' | 'anchors-valid' | 'anchors-visible' | 'no-overflow'"]
let property_position_visibility_runtime_module_path = Some "Css_types.PositionVisibility"

let property_inset_area : property_inset_area Rule.rule = [%spec "'none' | [ 'top' | 'bottom' | 'left' | 'right' | 'center' | 'self-start' | \
   'self-end' | 'start' | 'end' ]{1,2}"]
let property_inset_area_runtime_module_path = Some "Css_types.InsetArea"

let property_scroll_start : property_scroll_start Rule.rule = [%spec "'auto' | 'start' | 'end' | 'center' | 'top' | 'bottom' | 'left' | 'right' | \
   <extended-length> | <extended-percentage>"]
let property_scroll_start_runtime_module_path = Some "Css_types.ScrollStart"

let property_scroll_start_block : property_scroll_start_block Rule.rule = [%spec "'auto' | 'start' | 'end' | 'center' | <extended-length> | \
   <extended-percentage>"]
let property_scroll_start_block_runtime_module_path = Some "Css_types.ScrollStartBlock"

let property_scroll_start_inline : property_scroll_start_inline Rule.rule = [%spec "'auto' | 'start' | 'end' | 'center' | <extended-length> | \
   <extended-percentage>"]
let property_scroll_start_inline_runtime_module_path = Some "Css_types.ScrollStartInline"

let property_scroll_start_x : property_scroll_start_x Rule.rule = [%spec "'auto' | 'start' | 'end' | 'center' | <extended-length> | \
   <extended-percentage>"]
let property_scroll_start_x_runtime_module_path = Some "Css_types.ScrollStartX"

let property_scroll_start_y : property_scroll_start_y Rule.rule = [%spec "'auto' | 'start' | 'end' | 'center' | <extended-length> | \
   <extended-percentage>"]
let property_scroll_start_y_runtime_module_path = Some "Css_types.ScrollStartY"

let property_scroll_start_target : property_scroll_start_target Rule.rule = [%spec "'none' | 'auto'"]
let property_scroll_start_target_runtime_module_path = Some "Css_types.ScrollStartTarget"

let property_scroll_start_target_block : property_scroll_start_target_block Rule.rule = [%spec "'none' | 'auto'"]
let property_scroll_start_target_block_runtime_module_path = Some "Css_types.ScrollStartTargetBlock"

let property_scroll_start_target_inline : property_scroll_start_target_inline Rule.rule = [%spec "'none' | 'auto'"]
let property_scroll_start_target_inline_runtime_module_path = Some "Css_types.ScrollStartTargetInline"

let property_scroll_start_target_x : property_scroll_start_target_x Rule.rule = [%spec "'none' | 'auto'"]
let property_scroll_start_target_x_runtime_module_path = Some "Css_types.ScrollStartTargetX"

let property_scroll_start_target_y : property_scroll_start_target_y Rule.rule = [%spec "'none' | 'auto'"]
let property_scroll_start_target_y_runtime_module_path = Some "Css_types.ScrollStartTargetY"

let property_text_spacing_trim : property_text_spacing_trim Rule.rule = [%spec "'normal' | 'space-all' | 'space-first' | 'trim-start'"]
let property_text_spacing_trim_runtime_module_path = Some "Css_types.TextSpacingTrim"

let property_word_space_transform : property_word_space_transform Rule.rule = [%spec "'none' | 'auto' | 'ideograph-alpha' | 'ideograph-numeric'"]
let property_word_space_transform_runtime_module_path = Some "Css_types.WordSpaceTransform"

let property_reading_flow : property_reading_flow Rule.rule = [%spec "'normal' | 'flex-visual' | 'flex-flow' | 'grid-rows' | 'grid-columns' | \
   'grid-order'"]
let property_reading_flow_runtime_module_path = Some "Css_types.ReadingFlow"

let property_math_depth : property_math_depth Rule.rule = [%spec "'auto-add' | 'add(' <integer> ')' | <integer>"]
let property_math_depth_runtime_module_path = Some "Css_types.MathDepth"

let property_math_shift : property_math_shift Rule.rule = [%spec "'normal' | 'compact'"]
let property_math_shift_runtime_module_path = Some "Css_types.MathShift"

let property_math_style : property_math_style Rule.rule = [%spec "'normal' | 'compact'"]
let property_math_style_runtime_module_path = Some "Css_types.MathStyle"

let property_text_wrap_mode : property_text_wrap_mode Rule.rule = [%spec "'wrap' | 'nowrap'"]
let property_text_wrap_mode_runtime_module_path = Some "Css_types.TextWrapMode"

let property_text_wrap_style : property_text_wrap_style Rule.rule = [%spec "'auto' | 'balance' | 'stable' | 'pretty'"]
let property_text_wrap_style_runtime_module_path = Some "Css_types.TextWrapStyle"

let property_white_space_collapse : property_white_space_collapse Rule.rule = [%spec "'collapse' | 'preserve' | 'preserve-breaks' | 'preserve-spaces' | \
   'break-spaces'"]
let property_white_space_collapse_runtime_module_path = Some "Css_types.WhiteSpaceCollapse"

let property_text_box_trim : property_text_box_trim Rule.rule = [%spec "'none' | 'trim-start' | 'trim-end' | 'trim-both'"]
let property_text_box_trim_runtime_module_path = Some "Css_types.TextBoxTrim"

let property_text_box_edge : property_text_box_edge Rule.rule = [%spec "'leading' | 'text' | 'cap' | 'ex' | 'alphabetic'"]
let property_text_box_edge_runtime_module_path = Some "Css_types.TextBoxEdge"

(* Print module paged media properties *)
let property_page : property_page Rule.rule = [%spec "'auto' | <custom-ident>"]
let property_page_runtime_module_path = Some "Css_types.Page"

let property_size : property_size Rule.rule = [%spec "<extended-length>{1,2} | 'auto' | [ 'A5' | 'A4' | 'A3' | 'B5' | 'B4' | \
   'JIS-B5' | 'JIS-B4' | 'letter' | 'legal' | 'ledger' ] [ 'portrait' | \
   'landscape' ]?"]
let property_size_runtime_module_path = Some "Css_types.Size"

let property_marks : property_marks Rule.rule = [%spec "'none' | 'crop' || 'cross'"]
let property_marks_runtime_module_path = Some "Css_types.Marks"

let property_bleed : property_bleed Rule.rule = [%spec "'auto' | <extended-length>"]
let property_bleed_runtime_module_path = Some "Css_types.Bleed"

(* More modern layout module effect properties *)
let property_backdrop_blur : property_backdrop_blur Rule.rule = [%spec "<extended-length>"]
let property_backdrop_blur_runtime_module_path = Some "Css_types.BackdropBlur"

let property_scrollbar_color_legacy : property_scrollbar_color_legacy Rule.rule = [%spec "<color>"]
let property_scrollbar_color_legacy_runtime_module_path = Some "Css_types.ScrollbarColorLegacy"

(* SVG paint server properties *)
let property_stop_color : property_stop_color Rule.rule = [%spec "<color>"]

let property_stop_opacity : property_stop_opacity Rule.rule = [%spec "<alpha-value>"]

let property_flood_color : property_flood_color Rule.rule = [%spec "<color>"]

let property_flood_opacity : property_flood_opacity Rule.rule = [%spec "<alpha-value>"]

let property_lighting_color : property_lighting_color Rule.rule = [%spec "<color>"]

let property_color_rendering : property_color_rendering Rule.rule = [%spec "'auto' | 'optimizeSpeed' | 'optimizeQuality'"]
let property_color_rendering_runtime_module_path = Some "Css_types.ColorRendering"

let property_vector_effect : property_vector_effect Rule.rule = [%spec "'none' | 'non-scaling-stroke'"]
let property_vector_effect_runtime_module_path = Some "Css_types.VectorEffect"

(* SVG geometry properties *)
let property_cx : property_cx Rule.rule = [%spec "<extended-length> | <extended-percentage>"]

let property_cy : property_cy Rule.rule = [%spec "<extended-length> | <extended-percentage>"]

let property_d : property_d Rule.rule = [%spec "'none' | <string>"]

let property_r : property_r Rule.rule = [%spec "<extended-length> | <extended-percentage>"]

let property_rx : property_rx Rule.rule = [%spec "'auto' | <extended-length> | <extended-percentage>"]

let property_ry : property_ry Rule.rule = [%spec "'auto' | <extended-length> | <extended-percentage>"]

let property_x : property_x Rule.rule = [%spec "<extended-length> | <extended-percentage>"]
let property_x_runtime_module_path = Some "Css_types.X"

let property_y : property_y Rule.rule = [%spec "<extended-length> | <extended-percentage>"]
let property_y_runtime_module_path = Some "Css_types.Y"

(* Contain intrinsic sizing *)
let property_contain_intrinsic_size : property_contain_intrinsic_size Rule.rule = [%spec "'none' | [ 'auto' ]? <extended-length>{1,2}"]
let property_contain_intrinsic_size_runtime_module_path = Some "Css_types.ContainIntrinsicSize"

let property_contain_intrinsic_width : property_contain_intrinsic_width Rule.rule = [%spec "'none' | 'auto' <extended-length> | <extended-length>"]
let property_contain_intrinsic_width_runtime_module_path = Some "Css_types.ContainIntrinsicWidth"

let property_contain_intrinsic_height : property_contain_intrinsic_height Rule.rule = [%spec "'none' | 'auto' <extended-length> | <extended-length>"]
let property_contain_intrinsic_height_runtime_module_path = Some "Css_types.ContainIntrinsicHeight"

let property_contain_intrinsic_block_size : property_contain_intrinsic_block_size Rule.rule = [%spec "'none' | 'auto' <extended-length> | <extended-length>"]
let property_contain_intrinsic_block_size_runtime_module_path = Some "Css_types.ContainIntrinsicBlockSize"

let property_contain_intrinsic_inline_size : property_contain_intrinsic_inline_size Rule.rule = [%spec "'none' | 'auto' <extended-length> | <extended-length>"]
let property_contain_intrinsic_inline_size_runtime_module_path = Some "Css_types.ContainIntrinsicInlineSize"

(* Print *)
let property_print_color_adjust : property_print_color_adjust Rule.rule = [%spec "'economy' | 'exact'"]
let property_print_color_adjust_runtime_module_path = Some "Css_types.PrintColorAdjust"

(* Ruby *)
let property_ruby_overhang : property_ruby_overhang Rule.rule = [%spec "'auto' | 'none'"]
let property_ruby_overhang_runtime_module_path = Some "Css_types.RubyOverhang"

(* Timeline scope *)
let property_timeline_scope : property_timeline_scope Rule.rule = [%spec "[ 'none' | <custom-ident> | <dashed-ident> ]#"]
let property_timeline_scope_runtime_module_path = Some "Css_types.TimelineScope"

(* Scroll driven animations *)
let property_animation_delay_end : property_animation_delay_end Rule.rule = [%spec "[ <extended-time> ]#"]
let property_animation_delay_end_runtime_module_path = Some "Css_types.AnimationDelayEnd"

let property_animation_delay_start : property_animation_delay_start Rule.rule = [%spec "[ <extended-time> ]#"]
let property_animation_delay_start_runtime_module_path = Some "Css_types.AnimationDelayStart"

(* Custom properties for at-rules *)
let property_syntax : property_syntax Rule.rule = [%spec "<string>"]
let property_syntax_runtime_module_path = Some "Css_types.Syntax"

let property_inherits : property_inherits Rule.rule = [%spec "'true' | 'false'"]
let property_inherits_runtime_module_path = Some "Css_types.Inherits"

let property_initial_value : property_initial_value Rule.rule = [%spec "<string>"]
let property_initial_value_runtime_module_path = Some "Css_types.InitialValue"

(* Additional modern properties *)
let property_scroll_marker_group : property_scroll_marker_group Rule.rule = [%spec "'none' | 'before' | 'after'"]
let property_scroll_marker_group_runtime_module_path = Some "Css_types.ScrollMarkerGroup"

let property_container_name_computed : property_container_name_computed Rule.rule = [%spec "'none' | [ <custom-ident> ]#"]
let property_container_name_computed_runtime_module_path = Some "Css_types.ContainerNameComputed"

let property_text_edge : property_text_edge Rule.rule = [%spec "[ 'leading' | <'text-box-edge'> ]{1,2}"]
let property_text_edge_runtime_module_path = Some "Css_types.TextEdge"

let property_hyphenate_limit_last : property_hyphenate_limit_last Rule.rule = [%spec "'none' | 'always' | 'column' | 'page' | 'spread'"]
let property_hyphenate_limit_last_runtime_module_path = Some "Css_types.HyphenateLimitLast"

let pseudo_class_selector : pseudo_class_selector Rule.rule = [%spec "':' <ident-token> | ':' <function-token> <any-value> ')'"]
let pseudo_class_selector_runtime_module_path = Some "Css_types.PseudoClassSelector"

let pseudo_element_selector : pseudo_element_selector Rule.rule = [%spec "':' <pseudo-class-selector>"]
let pseudo_element_selector_runtime_module_path = Some "Css_types.PseudoElementSelector"

let pseudo_page : pseudo_page Rule.rule = [%spec "':' [ 'left' | 'right' | 'first' | 'blank' ]"]
let pseudo_page_runtime_module_path = Some "Css_types.PseudoPage"

let quote : quote Rule.rule = [%spec "'open-quote' | 'close-quote' | 'no-open-quote' | 'no-close-quote'"]
let quote_runtime_module_path = Some "Css_types.Quote"

let ratio : ratio Rule.rule = [%spec "<integer> '/' <integer> | <number> | <interpolation>"]
let ratio_runtime_module_path = Some "Css_types.Ratio"

let relative_selector : relative_selector Rule.rule = [%spec "[ <combinator> ]? <complex-selector>"]
let relative_selector_runtime_module_path = Some "Css_types.RelativeSelector"

let relative_selector_list : relative_selector_list Rule.rule = [%spec "[ <relative-selector> ]#"]
let relative_selector_list_runtime_module_path = Some "Css_types.RelativeSelectorList"

let relative_size : relative_size Rule.rule = [%spec "'larger' | 'smaller'"]
let relative_size_runtime_module_path = Some "Css_types.RelativeSize"

let repeat_style : repeat_style Rule.rule = [%spec "'repeat-x' | 'repeat-y' | [ 'repeat' | 'space' | 'round' | 'no-repeat' ] [ \
   'repeat' | 'space' | 'round' | 'no-repeat' ]?"]
let repeat_style_runtime_module_path = Some "Css_types.RepeatStyle"

let right : right Rule.rule = [%spec "<extended-length> | 'auto'"]
let right_runtime_module_path = Some "Css_types.Right"

let self_position : self_position Rule.rule = [%spec "'center' | 'start' | 'end' | 'self-start' | 'self-end' | 'flex-start' | \
   'flex-end'"]
let self_position_runtime_module_path = Some "Css_types.SelfPosition"

let shadow : shadow Rule.rule = [%spec "[ 'inset' ]? [ <extended-length> | <interpolation> ]{2,4} [ <color> | \
   <interpolation> ]?"]

let shadow_t : shadow_t Rule.rule = [%spec "[ <extended-length> | <interpolation> ]{2,3} [ <color> | <interpolation> ]?"]
let shadow_t_runtime_module_path = Some "Css_types.TextShadow"

let shape : shape Rule.rule = [%spec "rect( <top> ',' <right> ',' <bottom> ',' <left> ) | rect( <top> <right> \
   <bottom> <left> )"]
let shape_runtime_module_path = Some "Css_types.Shape"

let shape_box : shape_box Rule.rule = [%spec "<box> | 'margin-box'"]
let shape_box_runtime_module_path = Some "Css_types.ShapeBox"

let shape_radius : shape_radius Rule.rule = [%spec "<extended-length> | <extended-percentage> | 'closest-side' | 'farthest-side'"]
let shape_radius_runtime_module_path = Some "Css_types.ShapeRadius"

let side_or_corner : side_or_corner Rule.rule = [%spec "[ 'left' | 'right' ] || [ 'top' | 'bottom' ]"]
let side_or_corner_runtime_module_path = Some "Css_types.SideOrCorner"

let single_animation : single_animation Rule.rule = [%spec "[ [ <keyframes-name> | 'none' | <interpolation> ] ] | [ [ <keyframes-name> \
   | 'none' | <interpolation> ] <extended-time> ] | [ [ <keyframes-name> | \
   'none' | <interpolation> ] <extended-time> <timing-function> ] | [ [ \
   <keyframes-name> | 'none' | <interpolation> ] <extended-time> \
   <timing-function> <extended-time> ] | [ [ <keyframes-name> | 'none' | \
   <interpolation> ] <extended-time> <timing-function> <extended-time> \
   <single-animation-iteration-count> ] | [ [ <keyframes-name> | 'none' | \
   <interpolation> ] <extended-time> <timing-function> <extended-time> \
   <single-animation-iteration-count> <single-animation-direction> ] | [ [ \
   <keyframes-name> | 'none' | <interpolation> ] <extended-time> \
   <timing-function> <extended-time> <single-animation-iteration-count> \
   <single-animation-direction> <single-animation-fill-mode> ] | [ [ \
   <keyframes-name> | 'none' | <interpolation> ] <extended-time> \
   <timing-function> <extended-time> <single-animation-iteration-count> \
   <single-animation-direction> <single-animation-fill-mode> \
   <single-animation-play-state> ]"]
let single_animation_runtime_module_path = Some "Css_types.SingleAnimation"

let single_animation_no_interp : single_animation_no_interp Rule.rule = [%spec "[ <keyframes-name> | 'none' ] || <extended-time-no-interp> || \
   <timing-function-no-interp> || <extended-time-no-interp> || \
   <single-animation-iteration-count-no-interp> || \
   <single-animation-direction-no-interp> || \
   <single-animation-fill-mode-no-interp> || \
   <single-animation-play-state-no-interp>"]
let single_animation_no_interp_runtime_module_path = Some "Css_types.SingleAnimationNoInterp"

let single_animation_direction : single_animation_direction Rule.rule = [%spec "'normal' | 'reverse' | 'alternate' | 'alternate-reverse' | <interpolation>"]
let single_animation_direction_runtime_module_path = Some "Css_types.SingleAnimationDirection"

let single_animation_direction_no_interp : single_animation_direction_no_interp Rule.rule = [%spec "'normal' | 'reverse' | 'alternate' | 'alternate-reverse'"]
let single_animation_direction_no_interp_runtime_module_path = Some "Css_types.SingleAnimationDirectionNoInterp"

let single_animation_fill_mode : single_animation_fill_mode Rule.rule = [%spec "'none' | 'forwards' | 'backwards' | 'both' | <interpolation>"]
let single_animation_fill_mode_runtime_module_path = Some "Css_types.SingleAnimationFillMode"

let single_animation_fill_mode_no_interp : single_animation_fill_mode_no_interp Rule.rule = [%spec "'none' | 'forwards' | 'backwards' | 'both'"]
let single_animation_fill_mode_no_interp_runtime_module_path = Some "Css_types.SingleAnimationFillModeNoInterp"

let single_animation_iteration_count : single_animation_iteration_count Rule.rule = [%spec "'infinite' | <number> | <interpolation>"]
let single_animation_iteration_count_runtime_module_path = Some "Css_types.SingleAnimationIterationCount"

let single_animation_iteration_count_no_interp : single_animation_iteration_count_no_interp Rule.rule = [%spec "'infinite' | <number>"]
let single_animation_iteration_count_no_interp_runtime_module_path = Some "Css_types.SingleAnimationIterationCountNoInterp"

let single_animation_play_state : single_animation_play_state Rule.rule = [%spec "'running' | 'paused' | <interpolation>"]
let single_animation_play_state_runtime_module_path = Some "Css_types.SingleAnimationPlayState"

let single_animation_play_state_no_interp : single_animation_play_state_no_interp Rule.rule = [%spec "'running' | 'paused'"]
let single_animation_play_state_no_interp_runtime_module_path = Some "Css_types.SingleAnimationPlayStateNoInterp"

let single_transition_no_interp : single_transition_no_interp Rule.rule = [%spec "[ <single-transition-property-no-interp> | 'none' ] || \
   <extended-time-no-interp> || <timing-function-no-interp> || \
   <extended-time-no-interp> || <transition-behavior-value-no-interp>"]
let single_transition_no_interp_runtime_module_path = Some "Css_types.SingleTransitionNoInterp"

let single_transition : single_transition Rule.rule = [%spec "[<single-transition-property> | 'none'] | [ [<single-transition-property> | \
   'none'] <extended-time> ] | [ [<single-transition-property> | 'none'] \
   <extended-time> <timing-function> ] | [ [<single-transition-property> | \
   'none'] <extended-time> <timing-function> <extended-time> ] | [ \
   [<single-transition-property> | 'none'] <extended-time> <timing-function> \
   <extended-time> <transition-behavior-value> ]"]
let single_transition_runtime_module_path = Some "Css_types.SingleTransition"

let single_transition_property : single_transition_property Rule.rule = [%spec "<custom-ident> | <interpolation> | 'all'"]
let single_transition_property_runtime_module_path = Some "Css_types.SingleTransitionProperty"

let single_transition_property_no_interp : single_transition_property_no_interp Rule.rule = [%spec "<custom-ident> | 'all'"]
let single_transition_property_no_interp_runtime_module_path = Some "Css_types.SingleTransitionPropertyNoInterp"

let size : size Rule.rule = [%spec "'closest-side' | 'farthest-side' | 'closest-corner' | 'farthest-corner' | \
   <extended-length> | [ <extended-length> | <extended-percentage> ]{2}"]
let size_runtime_module_path = Some "Css_types.Size"

let ray_size : ray_size Rule.rule = [%spec "'closest-side' | 'farthest-side' | 'closest-corner' | 'farthest-corner' | \
   'sides'"]
let ray_size_runtime_module_path = Some "Css_types.RaySize"

let radial_size : radial_size Rule.rule = [%spec "'closest-side' | 'farthest-side' | 'closest-corner' | 'farthest-corner' | \
   <extended-length> | [ <extended-length> | <extended-percentage> ]{2}"]
let radial_size_runtime_module_path = Some "Css_types.RadialSize"

let step_position : step_position Rule.rule = [%spec "'jump-start' | 'jump-end' | 'jump-none' | 'jump-both' | 'start' | 'end'"]
let step_position_runtime_module_path = Some "Css_types.StepPosition"

let step_timing_function : step_timing_function Rule.rule = [%spec "'step-start' | 'step-end' | steps( <integer> [ ',' <step-position> ]? )"]
let step_timing_function_runtime_module_path = Some "Css_types.StepTimingFunction"

let subclass_selector : subclass_selector Rule.rule = [%spec "<id-selector> | <class-selector> | <attribute-selector> | \
   <pseudo-class-selector>"]
let subclass_selector_runtime_module_path = Some "Css_types.SubclassSelector"

let supports_condition : supports_condition Rule.rule = [%spec "'not' <supports-in-parens> | <supports-in-parens> [ 'and' \
   <supports-in-parens> ]* | <supports-in-parens> [ 'or' <supports-in-parens> \
   ]*"]
let supports_condition_runtime_module_path = Some "Css_types.SupportsCondition"

let supports_decl : supports_decl Rule.rule = [%spec "'(' <declaration> ')'"]
let supports_decl_runtime_module_path = Some "Css_types.SupportsDecl"

let supports_feature : supports_feature Rule.rule = [%spec "<supports-decl> | <supports-selector-fn>"]
let supports_feature_runtime_module_path = Some "Css_types.SupportsFeature"

let supports_in_parens : supports_in_parens Rule.rule = [%spec "'(' <supports-condition> ')' | <supports-feature>"]
let supports_in_parens_runtime_module_path = Some "Css_types.SupportsInParens"

let supports_selector_fn : supports_selector_fn Rule.rule = [%spec "selector( <complex-selector> )"]
let supports_selector_fn_runtime_module_path = Some "Css_types.SupportsSelectorFn"

let svg_length : svg_length Rule.rule = [%spec "<extended-percentage> | <extended-length> | <number>"]
let svg_length_runtime_module_path = Some "Css_types.SvgLength"

let svg_writing_mode : svg_writing_mode Rule.rule = [%spec "'lr-tb' | 'rl-tb' | 'tb-rl' | 'lr' | 'rl' | 'tb'"]
let svg_writing_mode_runtime_module_path = Some "Css_types.SvgWritingMode"

let symbol : symbol Rule.rule = [%spec "<string> | <image> | <custom-ident>"]
let symbol_runtime_module_path = Some "Css_types.Symbol"

let symbols_type : symbols_type Rule.rule = [%spec "'cyclic' | 'numeric' | 'alphabetic' | 'symbolic' | 'fixed'"]
let symbols_type_runtime_module_path = Some "Css_types.SymbolsType"

let target : target Rule.rule = [%spec "<target-counter()> | <target-counters()> | <target-text()>"]
let target_runtime_module_path = Some "Css_types.Target"

let url : url Rule.rule = [%spec "<url-no-interp> | url( <interpolation> )"]
let url_runtime_module_path = Some "Css_types.Url"

(* https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/Values/length-percentage#use_in_calc *)
let extended_length : extended_length Rule.rule = [%spec "<length> | <calc()> | <interpolation> | <min()> | <max()>"]
let extended_length_runtime_module_path = Some "Css_types.ExtendedLength"

(* https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/Values/length-percentage#use_in_calc *)
let length_percentage : length_percentage Rule.rule = [%spec "<extended-length> | <extended-percentage>"]
let length_percentage_runtime_module_path = Some "Css_types.LengthPercentage"

let extended_frequency : extended_frequency Rule.rule = [%spec "<frequency> | <calc()> | <interpolation> | <min()> | <max()>"]
let extended_frequency_runtime_module_path = Some "Css_types.ExtendedFrequency"

let extended_angle : extended_angle Rule.rule = [%spec "<angle> | <calc()> | <interpolation> | <min()> | <max()>"]
let extended_angle_runtime_module_path = Some "Css_types.ExtendedAngle"

let extended_time : extended_time Rule.rule = [%spec "<time> | <calc()> | <interpolation> | <min()> | <max()>"]
let extended_time_runtime_module_path = Some "Css_types.ExtendedTime"

let extended_time_no_interp : extended_time_no_interp Rule.rule = [%spec "<time> | <calc()> | <min()> | <max()>"]
let extended_time_no_interp_runtime_module_path = Some "Css_types.ExtendedTimeNoInterp"

let extended_percentage : extended_percentage Rule.rule = [%spec "<percentage> | <calc()> | <interpolation> | <min()> | <max()> "]
let extended_percentage_runtime_module_path = Some "Css_types.ExtendedPercentage"

let timing_function : timing_function Rule.rule = [%spec "'linear' | <cubic-bezier-timing-function> | <step-timing-function> | \
   <interpolation>"]
let timing_function_runtime_module_path = Some "Css_types.TimingFunction"

let timing_function_no_interp : timing_function_no_interp Rule.rule = [%spec "'linear' | <cubic-bezier-timing-function> | <step-timing-function>"]
let timing_function_no_interp_runtime_module_path = Some "Css_types.TimingFunctionNoInterp"

let top : top Rule.rule = [%spec "<extended-length> | 'auto'"]
let top_runtime_module_path = Some "Css_types.Top"

let try_tactic : try_tactic Rule.rule = [%spec "'flip-block' | 'flip-inline' | 'flip-start'"]
let try_tactic_runtime_module_path = Some "Css_types.TryTactic"

let track_breadth : track_breadth Rule.rule = [%spec "<extended-length> | <extended-percentage> | <flex-value> | 'min-content' | \
   'max-content' | 'auto'"]
let track_breadth_runtime_module_path = Some "Css_types.TrackBreadth"

let track_group : track_group Rule.rule = [%spec "'(' [ [ <string> ]* <track-minmax> [ <string> ]* ]+ ')' [ '[' \
   <positive-integer> ']' ]? | <track-minmax>"]
let track_group_runtime_module_path = Some "Css_types.TrackGroup"

let track_list : track_list Rule.rule = [%spec "[ [ <line-names> ]? [ <track-size> | <track-repeat> ] ]+ [ <line-names> ]?"]
let track_list_runtime_module_path = Some "Css_types.TrackList"

let track_list_v0 : track_list_v0 Rule.rule = [%spec "[ [ <string> ]* <track-group> [ <string> ]* ]+ | 'none'"]
let track_list_v0_runtime_module_path = Some "Css_types.TrackListV0"

let track_minmax : track_minmax Rule.rule = [%spec "minmax( <track-breadth> ',' <track-breadth> ) | 'auto' | <track-breadth> | \
   fit-content( <extended-length> | <extended-percentage> )"]
let track_minmax_runtime_module_path = Some "Css_types.TrackMinmax"

let track_repeat : track_repeat Rule.rule = [%spec "repeat( <positive-integer> ',' [ [ <line-names> ]? <track-size> ]+ [ \
   <line-names> ]? )"]
let track_repeat_runtime_module_path = Some "Css_types.TrackRepeat"

let track_size : track_size Rule.rule = [%spec "<track-breadth> | minmax( <inflexible-breadth> ',' <track-breadth> ) | \
   fit-content( <extended-length> | <extended-percentage> )"]
let track_size_runtime_module_path = Some "Css_types.TrackSize"

let transform_function : transform_function Rule.rule = [%spec "<matrix()> | <translate()> | <translateX()> | <translateY()> | <scale()> | \
   <scaleX()> | <scaleY()> | <rotate()> | <skew()> | <skewX()> | <skewY()> | \
   <matrix3d()> | <translate3d()> | <translateZ()> | <scale3d()> | <scaleZ()> \
   | <rotate3d()> | <rotateX()> | <rotateY()> | <rotateZ()> | <perspective()>"]
let transform_function_runtime_module_path = Some "Css_types.TransformFunction"

let transform_list : transform_list Rule.rule = [%spec "[ <transform-function> ]+"]
let transform_list_runtime_module_path = Some "Css_types.TransformList"

let transition_behavior_value : transition_behavior_value Rule.rule = [%spec "'normal' | 'allow-discrete' | <interpolation>"]
let transition_behavior_value_runtime_module_path = Some "Css_types.TransitionBehaviorValue"

let transition_behavior_value_no_interp : transition_behavior_value_no_interp Rule.rule = [%spec "'normal' | 'allow-discrete'"]
let transition_behavior_value_no_interp_runtime_module_path = Some "Css_types.TransitionBehaviorValueNoInterp"

let type_or_unit : type_or_unit Rule.rule = [%spec "'string' | 'color' | 'url' | 'integer' | 'number' | 'length' | 'angle' | \
   'time' | 'frequency' | 'cap' | 'ch' | 'em' | 'ex' | 'ic' | 'lh' | 'rlh' | \
   'rem' | 'vb' | 'vi' | 'vw' | 'vh' | 'vmin' | 'vmax' | 'mm' | 'Q' | 'cm' | \
   'in' | 'pt' | 'pc' | 'px' | 'deg' | 'grad' | 'rad' | 'turn' | 'ms' | 's' | \
   'Hz' | 'kHz' | '%'"]
let type_or_unit_runtime_module_path = Some "Css_types.TypeOrUnit"

let type_selector : type_selector Rule.rule = [%spec "<wq-name> | [ <ns-prefix> ]? '*'"]
let type_selector_runtime_module_path = Some "Css_types.TypeSelector"

let viewport_length : viewport_length Rule.rule = [%spec "'auto' | <extended-length> | <extended-percentage>"]
let viewport_length_runtime_module_path = Some "Css_types.ViewportLength"

let visual_box : visual_box Rule.rule = [%spec "'content-box' | 'padding-box' | 'border-box'"]
let visual_box_runtime_module_path = Some "Css_types.VisualBox"

let wq_name : wq_name Rule.rule = [%spec "[ <ns-prefix> ]? <ident-token>"]
let wq_name_runtime_module_path = Some "Css_types.WqName"

let attr_name : attr_name Rule.rule = [%spec "[ <ident-token>? '|' ]? <ident-token>"]
let attr_name_runtime_module_path = Some "Css_types.AttrName"

let attr_unit : attr_unit Rule.rule = [%spec "'%' | 'em' | 'ex' | 'ch' | 'rem' | 'vw' | 'vh' | 'vmin' | 'vmax' | 'cm' | \
   'mm' | 'in' | 'px' | 'pt' | 'pc' | 'deg' | 'grad' | 'rad' | 'turn' | 'ms' | \
   's' | 'Hz' | 'kHz'"]
let attr_unit_runtime_module_path = Some "Css_types.AttrUnit"

let syntax_type_name : syntax_type_name Rule.rule = [%spec "'angle' | 'color' | 'custom-ident' | 'image' | 'integer' | 'length' | \
   'length-percentage' | 'number' | 'percentage' | 'resolution' | 'string' | \
   'time' | 'url' | 'transform-function'"]
let syntax_type_name_runtime_module_path = Some "Css_types.SyntaxTypeName"

let syntax_multiplier : syntax_multiplier Rule.rule = [%spec "'#' | '+'"]
let syntax_multiplier_runtime_module_path = Some "Css_types.SyntaxMultiplier"

let syntax_single_component : syntax_single_component Rule.rule = [%spec "'<' <syntax-type-name> '>' | <ident>"]
let syntax_single_component_runtime_module_path = Some "Css_types.SyntaxSingleComponent"

let syntax_string : syntax_string Rule.rule = [%spec "<string>"]
let syntax_string_runtime_module_path = Some "Css_types.SyntaxString"

let syntax_combinator : syntax_combinator Rule.rule = [%spec "'|'"]
let syntax_combinator_runtime_module_path = Some "Css_types.SyntaxCombinator"

let syntax_component : syntax_component Rule.rule = [%spec "<syntax-single-component> [ <syntax-multiplier> ]? | '<' 'transform-list' \
   '>'"]
let syntax_component_runtime_module_path = Some "Css_types.SyntaxComponent"

let syntax : syntax Rule.rule = [%spec "'*' | <syntax-component> [ <syntax-combinator> <syntax-component> ]* | \
   <syntax-string>"]
let syntax_runtime_module_path = Some "Css_types.Syntax"

(* (*
 We don't support type() yet, original spec is: "type( <syntax> ) | 'raw-string' | <attr-unit>" *) *)
let attr_type : attr_type Rule.rule = [%spec "'raw-string' | <attr-unit>"]
let attr_type_runtime_module_path = Some "Css_types.AttrType"

let x : x Rule.rule = [%spec "<number>"]
let x_runtime_module_path = Some "Css_types.X"
let y : y Rule.rule = [%spec "<number>"]
let y_runtime_module_path = Some "Css_types.Y"

let registry : (kind * packed_rule) list =
  [
    (* Properties *)
    Property "display", pack_rule property_display ?runtime_module_path:property_display_runtime_module_path ();
    Property "overflow", pack_rule property_overflow ?runtime_module_path:property_overflow_runtime_module_path ();
    Property "position", pack_rule property_position ?runtime_module_path:property_position_runtime_module_path ();
    Property "visibility", pack_rule property_visibility ?runtime_module_path:property_visibility_runtime_module_path ();
    Property "float", pack_rule property_float ?runtime_module_path:property_float_runtime_module_path ();
    Property "clear", pack_rule property_clear ?runtime_module_path:property_clear_runtime_module_path ();
    Property "table-layout", pack_rule property_table_layout ?runtime_module_path:property_table_layout_runtime_module_path ();
    Property "border-collapse", pack_rule property_border_collapse ?runtime_module_path:property_border_collapse_runtime_module_path ();
    Property "empty-cells", pack_rule property_empty_cells ?runtime_module_path:property_empty_cells_runtime_module_path ();
    Property "caption-side", pack_rule property_caption_side ?runtime_module_path:property_caption_side_runtime_module_path ();
    Property "direction", pack_rule property_direction ?runtime_module_path:property_direction_runtime_module_path ();
    Property "unicode-bidi", pack_rule property_unicode_bidi ?runtime_module_path:property_unicode_bidi_runtime_module_path ();
    Property "writing-mode", pack_rule property_writing_mode ?runtime_module_path:property_writing_mode_runtime_module_path ();
    Property "text-orientation", pack_rule property_text_orientation ?runtime_module_path:property_text_orientation_runtime_module_path ();
    Property "text-transform", pack_rule property_text_transform ?runtime_module_path:property_text_transform_runtime_module_path ();
    Property "white-space", pack_rule property_white_space ?runtime_module_path:property_white_space_runtime_module_path ();
    Property "word-break", pack_rule property_word_break ?runtime_module_path:property_word_break_runtime_module_path ();
    Property "overflow-wrap", pack_rule property_overflow_wrap ?runtime_module_path:property_overflow_wrap_runtime_module_path ();
    Property "text-align", pack_rule property_text_align ?runtime_module_path:property_text_align_runtime_module_path ();
    Property "text-align-last", pack_rule property_text_align_last ?runtime_module_path:property_text_align_last_runtime_module_path ();
    Property "text-justify", pack_rule property_text_justify ?runtime_module_path:property_text_justify_runtime_module_path ();
    ( Property "text-decoration-line",
      pack_rule property_text_decoration_line ?runtime_module_path:property_text_decoration_line_runtime_module_path () );
    ( Property "text-decoration-style",
      pack_rule property_text_decoration_style ?runtime_module_path:property_text_decoration_style_runtime_module_path () );
    ( Property "text-decoration-skip-ink",
      pack_rule property_text_decoration_skip_ink ?runtime_module_path:property_text_decoration_skip_ink_runtime_module_path () );
    Property "font-style", pack_rule property_font_style ?runtime_module_path:property_font_style_runtime_module_path ();
    Property "font-variant-caps", pack_rule property_font_variant_caps ?runtime_module_path:property_font_variant_caps_runtime_module_path ();
    Property "font-stretch", pack_rule property_font_stretch ?runtime_module_path:property_font_stretch_runtime_module_path ();
    Property "font-kerning", pack_rule property_font_kerning ?runtime_module_path:property_font_kerning_runtime_module_path ();
    ( Property "font-variant-position",
      pack_rule property_font_variant_position ?runtime_module_path:property_font_variant_position_runtime_module_path () );
    Property "list-style-position", pack_rule property_list_style_position ?runtime_module_path:property_list_style_position_runtime_module_path ();
    Property "list-style-type", pack_rule property_list_style_type ?runtime_module_path:property_list_style_type_runtime_module_path ();
    Property "pointer-events", pack_rule property_pointer_events ?runtime_module_path:property_pointer_events_runtime_module_path ();
    Property "user-select", pack_rule property_user_select ?runtime_module_path:property_user_select_runtime_module_path ();
    Property "resize", pack_rule property_resize ?runtime_module_path:property_resize_runtime_module_path ();
    Property "box-sizing", pack_rule property_box_sizing ?runtime_module_path:property_box_sizing_runtime_module_path ();
    Property "object-fit", pack_rule property_object_fit ?runtime_module_path:property_object_fit_runtime_module_path ();
    Property "isolation", pack_rule property_isolation ?runtime_module_path:property_isolation_runtime_module_path ();
    Property "mix-blend-mode", pack_rule property_mix_blend_mode ?runtime_module_path:property_mix_blend_mode_runtime_module_path ();
    Property "backface-visibility", pack_rule property_backface_visibility ?runtime_module_path:property_backface_visibility_runtime_module_path ();
    Property "flex-direction", pack_rule property_flex_direction ?runtime_module_path:property_flex_direction_runtime_module_path ();
    Property "flex-wrap", pack_rule property_flex_wrap ?runtime_module_path:property_flex_wrap_runtime_module_path ();
    Property "justify-content", pack_rule property_justify_content ?runtime_module_path:property_justify_content_runtime_module_path ();
    Property "align-items", pack_rule property_align_items ?runtime_module_path:property_align_items_runtime_module_path ();
    Property "align-content", pack_rule property_align_content ?runtime_module_path:property_align_content_runtime_module_path ();
    Property "align-self", pack_rule property_align_self ?runtime_module_path:property_align_self_runtime_module_path ();
    Property "justify-items", pack_rule property_justify_items ?runtime_module_path:property_justify_items_runtime_module_path ();
    Property "justify-self", pack_rule property_justify_self ?runtime_module_path:property_justify_self_runtime_module_path ();
    Property "scroll-behavior", pack_rule property_scroll_behavior ?runtime_module_path:property_scroll_behavior_runtime_module_path ();
    Property "overscroll-behavior", pack_rule property_overscroll_behavior ?runtime_module_path:property_overscroll_behavior_runtime_module_path ();
    Property "overflow-anchor", pack_rule property_overflow_anchor ?runtime_module_path:property_overflow_anchor_runtime_module_path ();
    Property "touch-action", pack_rule property_touch_action ?runtime_module_path:property_touch_action_runtime_module_path ();
    Property "caret-color", pack_rule property_caret_color ?runtime_module_path:property_caret_color_runtime_module_path ();
    Property "appearance", pack_rule property_appearance ?runtime_module_path:property_appearance_runtime_module_path ();
    Property "text-rendering", pack_rule property_text_rendering ?runtime_module_path:property_text_rendering_runtime_module_path ();
    Property "image-rendering", pack_rule property_image_rendering ?runtime_module_path:property_image_rendering_runtime_module_path ();
    Property "color-scheme", pack_rule property_color_scheme ?runtime_module_path:property_color_scheme_runtime_module_path ();
    Property "forced-color-adjust", pack_rule property_forced_color_adjust ?runtime_module_path:property_forced_color_adjust_runtime_module_path ();
    Property "print-color-adjust", pack_rule property_print_color_adjust ?runtime_module_path:property_print_color_adjust_runtime_module_path ();
    ( Property "contain-intrinsic-size",
      pack_rule property_contain_intrinsic_size ?runtime_module_path:property_contain_intrinsic_size_runtime_module_path () );
    Property "content-visibility", pack_rule property_content_visibility ?runtime_module_path:property_content_visibility_runtime_module_path ();
    Property "hyphens", pack_rule property_hyphens ?runtime_module_path:property_hyphens_runtime_module_path ();
    Property "column-fill", pack_rule property_column_fill ?runtime_module_path:property_column_fill_runtime_module_path ();
    Property "column-span", pack_rule property_column_span ?runtime_module_path:property_column_span_runtime_module_path ();
    Property "clip-rule", pack_rule property_clip_rule ?runtime_module_path:property_clip_rule_runtime_module_path ();
    Property "font-optical-sizing", pack_rule property_font_optical_sizing ?runtime_module_path:property_font_optical_sizing_runtime_module_path ();
    Property "font-palette", pack_rule property_font_palette ?runtime_module_path:property_font_palette_runtime_module_path ();
    ( Property "font-synthesis-weight",
      pack_rule property_font_synthesis_weight ?runtime_module_path:property_font_synthesis_weight_runtime_module_path () );
    ( Property "font-synthesis-style",
      pack_rule property_font_synthesis_style ?runtime_module_path:property_font_synthesis_style_runtime_module_path () );
    ( Property "font-synthesis-small-caps",
      pack_rule property_font_synthesis_small_caps ?runtime_module_path:property_font_synthesis_small_caps_runtime_module_path () );
    ( Property "font-synthesis-position",
      pack_rule property_font_synthesis_position ?runtime_module_path:property_font_synthesis_position_runtime_module_path () );
    Property "mask-border-mode", pack_rule property_mask_border_mode ?runtime_module_path:property_mask_border_mode_runtime_module_path ();
    Property "mask-type", pack_rule property_mask_type ?runtime_module_path:property_mask_type_runtime_module_path ();
    Property "ruby-merge", pack_rule property_ruby_merge ?runtime_module_path:property_ruby_merge_runtime_module_path ();
    Property "ruby-position", pack_rule property_ruby_position ?runtime_module_path:property_ruby_position_runtime_module_path ();
    Property "scroll-snap-stop", pack_rule property_scroll_snap_stop ?runtime_module_path:property_scroll_snap_stop_runtime_module_path ();
    Property "scrollbar-width", pack_rule property_scrollbar_width ?runtime_module_path:property_scrollbar_width_runtime_module_path ();
    Property "speak", pack_rule property_speak ?runtime_module_path:property_speak_runtime_module_path ();
    Property "stroke-linecap", pack_rule property_stroke_linecap ?runtime_module_path:property_stroke_linecap_runtime_module_path ();
    ( Property "box-decoration-break",
      pack_rule property_box_decoration_break ?runtime_module_path:property_box_decoration_break_runtime_module_path () );
    Property "color-adjust", pack_rule property_color_adjust ?runtime_module_path:property_color_adjust_runtime_module_path ();
    ( Property "text-decoration-thickness",
      pack_rule property_text_decoration_thickness ?runtime_module_path:property_text_decoration_thickness_runtime_module_path () );
    ( Property "text-underline-position",
      pack_rule property_text_underline_position ?runtime_module_path:property_text_underline_position_runtime_module_path () );
    Property "word-wrap", pack_rule property_word_wrap ?runtime_module_path:property_word_wrap_runtime_module_path ();
    Property "break-inside", pack_rule property_break_inside ?runtime_module_path:property_break_inside_runtime_module_path ();
    Property "break-before", pack_rule property_break_before ?runtime_module_path:property_break_before_runtime_module_path ();
    Property "break-after", pack_rule property_break_after ?runtime_module_path:property_break_after_runtime_module_path ();
    Property "page-break-after", pack_rule property_page_break_after ?runtime_module_path:property_page_break_after_runtime_module_path ();
    Property "page-break-before", pack_rule property_page_break_before ?runtime_module_path:property_page_break_before_runtime_module_path ();
    Property "page-break-inside", pack_rule property_page_break_inside ?runtime_module_path:property_page_break_inside_runtime_module_path ();
    Property "border-image-repeat", pack_rule property_border_image_repeat ?runtime_module_path:property_border_image_repeat_runtime_module_path ();
    Property "transform-style", pack_rule property_transform_style ?runtime_module_path:property_transform_style_runtime_module_path ();
    Property "transform-box", pack_rule property_transform_box ?runtime_module_path:property_transform_box_runtime_module_path ();
    Property "grid-auto-flow", pack_rule property_grid_auto_flow ?runtime_module_path:property_grid_auto_flow_runtime_module_path ();
    Property "font-display", pack_rule property_font_display ?runtime_module_path:property_font_display_runtime_module_path ();
    Property "will-change", pack_rule property_will_change ?runtime_module_path:property_will_change_runtime_module_path ();
    Property "contain", pack_rule property_contain ?runtime_module_path:property_contain_runtime_module_path ();
    Property "all", pack_rule property_all ?runtime_module_path:property_all_runtime_module_path ();
    (* Values with runtime types *)
    Value "age", pack_rule age ?runtime_module_path:age_runtime_module_path ();
    Value "attachment", pack_rule attachment ?runtime_module_path:attachment_runtime_module_path ();
    Value "box", pack_rule box ?runtime_module_path:box_runtime_module_path ();
    Value "display-box", pack_rule display_box ?runtime_module_path:display_box_runtime_module_path ();
    Value "display-outside", pack_rule display_outside ?runtime_module_path:display_outside_runtime_module_path ();
    Value "ending-shape", pack_rule ending_shape ?runtime_module_path:ending_shape_runtime_module_path ();
    Value "fill-rule", pack_rule fill_rule ?runtime_module_path:fill_rule_runtime_module_path ();
    Value "zero", pack_rule zero ();
    Value "gender", pack_rule gender ?runtime_module_path:gender_runtime_module_path ();
    Value "combinator", pack_rule combinator ?runtime_module_path:combinator_runtime_module_path ();
    Value "contextual-alt-values", pack_rule contextual_alt_values ?runtime_module_path:contextual_alt_values_runtime_module_path ();
    Value "east-asian-width-values", pack_rule east_asian_width_values ?runtime_module_path:east_asian_width_values_runtime_module_path ();
    Value "attr-modifier", pack_rule attr_modifier ?runtime_module_path:attr_modifier_runtime_module_path ();
    Value "image-tags", pack_rule image_tags ?runtime_module_path:image_tags_runtime_module_path ();
    Value "line-style", pack_rule line_style ?runtime_module_path:line_style_runtime_module_path ();
    Value "line-width", pack_rule line_width ?runtime_module_path:line_width_runtime_module_path ();
    Value "named-color", pack_rule named_color ?runtime_module_path:named_color_runtime_module_path ();
    Value "color", pack_rule color ?runtime_module_path:color_runtime_module_path ();
    Value "alpha-value", pack_rule alpha_value ?runtime_module_path:alpha_value_runtime_module_path ();
    Value "hue", pack_rule hue ?runtime_module_path:hue_runtime_module_path ();
    Value "bg-image", pack_rule bg_image ?runtime_module_path:bg_image_runtime_module_path ();
    Value "content-replacement", pack_rule content_replacement ?runtime_module_path:content_replacement_runtime_module_path ();
    Value "transform-list", pack_rule transform_list ?runtime_module_path:transform_list_runtime_module_path ();
    Value "transform-function", pack_rule transform_function ?runtime_module_path:transform_function_runtime_module_path ();
    Value "image", pack_rule image ?runtime_module_path:image_runtime_module_path ();
    Value "font_families", pack_rule font_families ?runtime_module_path:font_families_runtime_module_path ();
    ( Value "color-interpolation-method",
      pack_rule color_interpolation_method ?runtime_module_path:color_interpolation_method_runtime_module_path () );
    Property "row-gap", pack_rule property_row_gap ();
    Property "column-gap", pack_rule property_column_gap ();
    Property "outline-width", pack_rule property_outline_width ();
    Property "outline-style", pack_rule property_outline_style ?runtime_module_path:property_outline_style_runtime_module_path ();
    Property "width", pack_rule property_width ?runtime_module_path:property_width_runtime_module_path ();
    Property "border", pack_rule property_border ();
    Property "flex-grow", pack_rule property_flex_grow ?runtime_module_path:property_flex_grow_runtime_module_path ();
    Property "flex-shrink", pack_rule property_flex_shrink ?runtime_module_path:property_flex_shrink_runtime_module_path ();
    Property "flex-basis", pack_rule property_flex_basis ?runtime_module_path:property_flex_basis_runtime_module_path ();
    Value "family-name", pack_rule family_name ?runtime_module_path:family_name_runtime_module_path ();
    Value "keyframes-name", pack_rule keyframes_name ?runtime_module_path:keyframes_name_runtime_module_path ();
    Value "url", pack_rule url ?runtime_module_path:url_runtime_module_path ();
    (* Image functions *)
    Function "image()", pack_rule function_image ?runtime_module_path:function_image_runtime_module_path ();
    Function "image-set()", pack_rule function_image_set ();
    Function "element()", pack_rule function_element ();
    Function "paint()", pack_rule function_paint ?runtime_module_path:function_paint_runtime_module_path ();
    Function "cross-fade()", pack_rule function_cross_fade ();
    (* Gradient and other values *)
    Value "gradient", pack_rule gradient ?runtime_module_path:gradient_runtime_module_path ();
    Value "shadow", pack_rule shadow ();
    Value "track-list", pack_rule track_list ?runtime_module_path:track_list_runtime_module_path ();
    Value "line-names", pack_rule line_names ?runtime_module_path:line_names_runtime_module_path ();
    Value "side-or-corner", pack_rule side_or_corner ?runtime_module_path:side_or_corner_runtime_module_path ();
    Value "track-size", pack_rule track_size ?runtime_module_path:track_size_runtime_module_path ();
    Value "track-breadth", pack_rule track_breadth ?runtime_module_path:track_breadth_runtime_module_path ();
    Value "track-repeat", pack_rule track_repeat ?runtime_module_path:track_repeat_runtime_module_path ();
    Value "content-list", pack_rule content_list ?runtime_module_path:content_list_runtime_module_path ();
    Value "mask-reference", pack_rule mask_reference ?runtime_module_path:mask_reference_runtime_module_path ();
    Value "color-stop-list", pack_rule color_stop_list ?runtime_module_path:color_stop_list_runtime_module_path ();
    Value "mask-source", pack_rule mask_source ?runtime_module_path:mask_source_runtime_module_path ();
    Value "length-percentage", pack_rule length_percentage ?runtime_module_path:length_percentage_runtime_module_path ();
    Value "auto-track-list", pack_rule auto_track_list ?runtime_module_path:auto_track_list_runtime_module_path ();
    Value "counter-style", pack_rule counter_style ?runtime_module_path:counter_style_runtime_module_path ();
    Value "counter-style-name", pack_rule counter_style_name ?runtime_module_path:counter_style_name_runtime_module_path ();
    Value "fixed-size", pack_rule fixed_size ?runtime_module_path:fixed_size_runtime_module_path ();
    Value "fixed-repeat", pack_rule fixed_repeat ?runtime_module_path:fixed_repeat_runtime_module_path ();
    Value "fixed-breadth", pack_rule fixed_breadth ?runtime_module_path:fixed_breadth_runtime_module_path ();
    Value "auto-repeat", pack_rule auto_repeat ?runtime_module_path:auto_repeat_runtime_module_path ();
    Value "extended-time-no-interp", pack_rule extended_time_no_interp ?runtime_module_path:extended_time_no_interp_runtime_module_path ();
    Value "timing-function-no-interp", pack_rule timing_function_no_interp ?runtime_module_path:timing_function_no_interp_runtime_module_path ();
    ( Value "cubic-bezier-timing-function",
      pack_rule cubic_bezier_timing_function ?runtime_module_path:cubic_bezier_timing_function_runtime_module_path () );
    Value "step-timing-function", pack_rule step_timing_function ?runtime_module_path:step_timing_function_runtime_module_path ();
    Value "single-animation", pack_rule single_animation ?runtime_module_path:single_animation_runtime_module_path ();
    ( Value "single-animation-no-interp",
      pack_rule single_animation_no_interp ?runtime_module_path:single_animation_no_interp_runtime_module_path () );
    ( Value "single-animation-direction-no-interp",
      pack_rule single_animation_direction_no_interp ?runtime_module_path:single_animation_direction_no_interp_runtime_module_path () );
    ( Value "single-animation-fill-mode-no-interp",
      pack_rule single_animation_fill_mode_no_interp ?runtime_module_path:single_animation_fill_mode_no_interp_runtime_module_path () );
    ( Value "single-animation-iteration-count-no-interp",
      pack_rule single_animation_iteration_count_no_interp ?runtime_module_path:single_animation_iteration_count_no_interp_runtime_module_path () );
    ( Value "single-animation-play-state-no-interp",
      pack_rule single_animation_play_state_no_interp ?runtime_module_path:single_animation_play_state_no_interp_runtime_module_path () );
    Value "shadow-t", pack_rule shadow_t ?runtime_module_path:shadow_t_runtime_module_path ();
    Value "font-weight-absolute", pack_rule font_weight_absolute ?runtime_module_path:font_weight_absolute_runtime_module_path ();
    (* Commonly referenced values *)
    Value "position", pack_rule position ?runtime_module_path:position_runtime_module_path ();
    Value "timing-function", pack_rule timing_function ?runtime_module_path:timing_function_runtime_module_path ();
    Value "number-percentage", pack_rule number_percentage ?runtime_module_path:number_percentage_runtime_module_path ();
    Value "grid-line", pack_rule grid_line ?runtime_module_path:grid_line_runtime_module_path ();
    ( Value "single-transition-property",
      pack_rule single_transition_property ?runtime_module_path:single_transition_property_runtime_module_path () );
    Value "outline-radius", pack_rule outline_radius ?runtime_module_path:outline_radius_runtime_module_path ();
    Value "bg-size", pack_rule bg_size ?runtime_module_path:bg_size_runtime_module_path ();
    Value "bg-position", pack_rule bg_position ?runtime_module_path:bg_position_runtime_module_path ();
    Value "feature-value-name", pack_rule feature_value_name ?runtime_module_path:feature_value_name_runtime_module_path ();
    Value "svg-length", pack_rule svg_length ?runtime_module_path:svg_length_runtime_module_path ();
    ( Value "single-animation-iteration-count",
      pack_rule single_animation_iteration_count ?runtime_module_path:single_animation_iteration_count_runtime_module_path () );
    Value "basic-shape", pack_rule basic_shape ?runtime_module_path:basic_shape_runtime_module_path ();
    Value "filter-function", pack_rule filter_function ?runtime_module_path:filter_function_runtime_module_path ();
    Function "attr()", pack_rule function_attr ();
    Function "symbols()", pack_rule function_symbols ?runtime_module_path:function_symbols_runtime_module_path ();
    (* Gradient functions *)
    Function "linear-gradient()", pack_rule function_linear_gradient ();
    Function "radial-gradient()", pack_rule function_radial_gradient ();
    Function "conic-gradient()", pack_rule function_conic_gradient ();
    ( Function "repeating-linear-gradient()",
      pack_rule function_repeating_linear_gradient () );
    ( Function "repeating-radial-gradient()",
      pack_rule function_repeating_radial_gradient () );
    Function "-webkit-gradient()", pack_rule function__webkit_gradient ();
    (* Transform functions *)
    Function "matrix()", pack_rule function_matrix ();
    Function "matrix3d()", pack_rule function_matrix3d ();
    Function "translate()", pack_rule function_translate ?runtime_module_path:function_translate_runtime_module_path ();
    Function "translateX()", pack_rule function_translateX ();
    Function "translateY()", pack_rule function_translateY ();
    Function "translateZ()", pack_rule function_translateZ ();
    Function "translate3d()", pack_rule function_translate3d ();
    Function "scale()", pack_rule function_scale ?runtime_module_path:function_scale_runtime_module_path ();
    Function "scale3d()", pack_rule function_scale3d ();
    Function "scaleX()", pack_rule function_scaleX ();
    Function "scaleY()", pack_rule function_scaleY ();
    Function "scaleZ()", pack_rule function_scaleZ ();
    Function "rotate()", pack_rule function_rotate ?runtime_module_path:function_rotate_runtime_module_path ();
    Function "rotate3d()", pack_rule function_rotate3d ();
    Function "rotateX()", pack_rule function_rotateX ();
    Function "rotateY()", pack_rule function_rotateY ();
    Function "rotateZ()", pack_rule function_rotateZ ();
    Function "skew()", pack_rule function_skew ();
    Function "skewX()", pack_rule function_skewX ();
    Function "skewY()", pack_rule function_skewY ();
    Function "perspective()", pack_rule function_perspective ?runtime_module_path:function_perspective_runtime_module_path ();
    Value "overflow-position", pack_rule overflow_position ?runtime_module_path:overflow_position_runtime_module_path ();
    Value "relative-size", pack_rule relative_size ?runtime_module_path:relative_size_runtime_module_path ();
    Value "repeat-style", pack_rule repeat_style ?runtime_module_path:repeat_style_runtime_module_path ();
    Value "self-position", pack_rule self_position ?runtime_module_path:self_position_runtime_module_path ();
    ( Value "single-animation-direction",
      pack_rule single_animation_direction ?runtime_module_path:single_animation_direction_runtime_module_path () );
    ( Value "single-animation-fill-mode",
      pack_rule single_animation_fill_mode ?runtime_module_path:single_animation_fill_mode_runtime_module_path () );
    ( Value "single-animation-play-state",
      pack_rule single_animation_play_state ?runtime_module_path:single_animation_play_state_runtime_module_path () );
    Value "step-position", pack_rule step_position ?runtime_module_path:step_position_runtime_module_path ();
    Value "symbols-type", pack_rule symbols_type ?runtime_module_path:symbols_type_runtime_module_path ();
    Value "masking-mode", pack_rule masking_mode ?runtime_module_path:masking_mode_runtime_module_path ();
    Value "numeric-figure-values", pack_rule numeric_figure_values ?runtime_module_path:numeric_figure_values_runtime_module_path ();
    Value "numeric-spacing-values", pack_rule numeric_spacing_values ?runtime_module_path:numeric_spacing_values_runtime_module_path ();
    Value "absolute-size", pack_rule absolute_size ?runtime_module_path:absolute_size_runtime_module_path ();
    Value "content-position", pack_rule content_position ?runtime_module_path:content_position_runtime_module_path ();
    Value "baseline-position", pack_rule baseline_position ?runtime_module_path:baseline_position_runtime_module_path ();
    Value "blend-mode", pack_rule blend_mode ?runtime_module_path:blend_mode_runtime_module_path ();
    Value "geometry-box", pack_rule geometry_box ?runtime_module_path:geometry_box_runtime_module_path ();
    Property "-webkit-appearance", pack_rule property__webkit_appearance ?runtime_module_path:property__webkit_appearance_runtime_module_path ();
    Property "stroke-linejoin", pack_rule property_stroke_linejoin ?runtime_module_path:property_stroke_linejoin_runtime_module_path ();
    Property "perspective-origin", pack_rule property_perspective_origin ?runtime_module_path:property_perspective_origin_runtime_module_path ();
    (* CSS Math Functions *)
    Function "calc()", pack_rule function_calc ();
    Function "min()", pack_rule function_min ();
    Function "max()", pack_rule function_max ();
    (* CSS Color Functions *)
    Function "rgb()", pack_rule function_rgb ();
    Function "rgba()", pack_rule function_rgba ();
    Function "hsl()", pack_rule function_hsl ();
    Function "hsla()", pack_rule function_hsla ();
    Function "var()", pack_rule function_var ?runtime_module_path:function_var_runtime_module_path ();
    Function "color-mix()", pack_rule function_color_mix ();
    (* CSS Calc internal types *)
    Value "calc-product", pack_rule calc_product ?runtime_module_path:calc_product_runtime_module_path ();
    Value "calc-sum", pack_rule calc_sum ?runtime_module_path:calc_sum_runtime_module_path ();
    Value "calc-value", pack_rule calc_value ?runtime_module_path:calc_value_runtime_module_path ();
    (* Media query building blocks *)
    Value "mf-eq", pack_rule mf_eq ?runtime_module_path:mf_eq_runtime_module_path ();
    Value "mf-gt", pack_rule mf_gt ?runtime_module_path:mf_gt_runtime_module_path ();
    Value "mf-lt", pack_rule mf_lt ?runtime_module_path:mf_lt_runtime_module_path ();
    (* Media query types *)
    Property "media-type", pack_rule property_media_type ?runtime_module_path:property_media_type_runtime_module_path ();
    Property "container-type", pack_rule property_container_type ?runtime_module_path:property_container_type_runtime_module_path ();
    Value "dimension", pack_rule dimension ?runtime_module_path:dimension_runtime_module_path ();
    Value "ratio", pack_rule ratio ?runtime_module_path:ratio_runtime_module_path ();
    Value "mf-name", pack_rule mf_name ?runtime_module_path:mf_name_runtime_module_path ();
    Value "mf-value", pack_rule mf_value ?runtime_module_path:mf_value_runtime_module_path ();
    Value "mf-boolean", pack_rule mf_boolean ?runtime_module_path:mf_boolean_runtime_module_path ();
    Value "mf-plain", pack_rule mf_plain ?runtime_module_path:mf_plain_runtime_module_path ();
    Value "mf-comparison", pack_rule mf_comparison ?runtime_module_path:mf_comparison_runtime_module_path ();
    Value "mf-range", pack_rule mf_range ?runtime_module_path:mf_range_runtime_module_path ();
    (* Media query types *)
    Media_query "media-feature", pack_rule media_feature ?runtime_module_path:media_feature_runtime_module_path ();
    Media_query "media-in-parens", pack_rule media_in_parens ?runtime_module_path:media_in_parens_runtime_module_path ();
    Media_query "media-or", pack_rule media_or ?runtime_module_path:media_or_runtime_module_path ();
    Media_query "media-and", pack_rule media_and ?runtime_module_path:media_and_runtime_module_path ();
    Media_query "media-not", pack_rule media_not ?runtime_module_path:media_not_runtime_module_path ();
    ( Media_query "media-condition-without-or",
      pack_rule media_condition_without_or ?runtime_module_path:media_condition_without_or_runtime_module_path () );
    Media_query "media-condition", pack_rule media_condition ?runtime_module_path:media_condition_runtime_module_path ();
    Media_query "media-query", pack_rule media_query ?runtime_module_path:media_query_runtime_module_path ();
    Media_query "media-query-list", pack_rule media_query_list ?runtime_module_path:media_query_list_runtime_module_path ();
    (* Container query types *)
    Value "container-query", pack_rule container_query ?runtime_module_path:container_query_runtime_module_path ();
    Value "container-condition", pack_rule container_condition ?runtime_module_path:container_condition_runtime_module_path ();
    Value "query-in-parens", pack_rule query_in_parens ?runtime_module_path:query_in_parens_runtime_module_path ();
    Value "size-feature", pack_rule size_feature ?runtime_module_path:size_feature_runtime_module_path ();
    Value "style-query", pack_rule style_query ?runtime_module_path:style_query_runtime_module_path ();
    Value "style-feature", pack_rule style_feature ?runtime_module_path:style_feature_runtime_module_path ();
    Value "style-in-parens", pack_rule style_in_parens ?runtime_module_path:style_in_parens_runtime_module_path ();
    (* Legacy/Non-standard values - keyword only *)
    ( Value "legacy-radial-gradient-shape",
      pack_rule legacy_radial_gradient_shape ?runtime_module_path:legacy_radial_gradient_shape_runtime_module_path () );
    ( Value "legacy-radial-gradient-size",
      pack_rule legacy_radial_gradient_size ?runtime_module_path:legacy_radial_gradient_size_runtime_module_path () );
    ( Value "legacy-radial-gradient-arguments",
      pack_rule legacy_radial_gradient_arguments ?runtime_module_path:legacy_radial_gradient_arguments_runtime_module_path () );
    Value "legacy-radial-gradient", pack_rule legacy_radial_gradient ?runtime_module_path:legacy_radial_gradient_runtime_module_path ();
    ( Value "legacy-repeating-radial-gradient",
      pack_rule legacy_repeating_radial_gradient ?runtime_module_path:legacy_repeating_radial_gradient_runtime_module_path () );
    Value "legacy-linear-gradient", pack_rule legacy_linear_gradient ?runtime_module_path:legacy_linear_gradient_runtime_module_path ();
    ( Value "legacy-linear-gradient-arguments",
      pack_rule legacy_linear_gradient_arguments ?runtime_module_path:legacy_linear_gradient_arguments_runtime_module_path () );
    ( Value "legacy-repeating-linear-gradient",
      pack_rule legacy_repeating_linear_gradient ?runtime_module_path:legacy_repeating_linear_gradient_runtime_module_path () );
    Value "legacy-gradient", pack_rule legacy_gradient ?runtime_module_path:legacy_gradient_runtime_module_path ();
    Value "-non-standard-color", pack_rule non_standard_color ?runtime_module_path:non_standard_color_runtime_module_path ();
    Value "-non-standard-font", pack_rule non_standard_font ?runtime_module_path:non_standard_font_runtime_module_path ();
    ( Value "-non-standard-image-rendering",
      pack_rule non_standard_image_rendering ?runtime_module_path:non_standard_image_rendering_runtime_module_path () );
    Value "-non-standard-overflow", pack_rule non_standard_overflow ?runtime_module_path:non_standard_overflow_runtime_module_path ();
    Value "-non-standard-width", pack_rule non_standard_width ?runtime_module_path:non_standard_width_runtime_module_path ();
    Value "-webkit-gradient-type", pack_rule webkit_gradient_type ?runtime_module_path:webkit_gradient_type_runtime_module_path ();
    Value "-webkit-mask-box-repeat", pack_rule webkit_mask_box_repeat ?runtime_module_path:webkit_mask_box_repeat_runtime_module_path ();
    Value "-webkit-mask-clip-style", pack_rule webkit_mask_clip_style ?runtime_module_path:webkit_mask_clip_style_runtime_module_path ();
    (* Keyword-only CSS values *)
    Value "common-lig-values", pack_rule common_lig_values ?runtime_module_path:common_lig_values_runtime_module_path ();
    Value "compat-auto", pack_rule compat_auto ?runtime_module_path:compat_auto_runtime_module_path ();
    Value "composite-style", pack_rule composite_style ?runtime_module_path:composite_style_runtime_module_path ();
    Value "compositing-operator", pack_rule compositing_operator ?runtime_module_path:compositing_operator_runtime_module_path ();
    Value "content-distribution", pack_rule content_distribution ?runtime_module_path:content_distribution_runtime_module_path ();
    Value "deprecated-system-color", pack_rule deprecated_system_color ?runtime_module_path:deprecated_system_color_runtime_module_path ();
    Value "discretionary-lig-values", pack_rule discretionary_lig_values ?runtime_module_path:discretionary_lig_values_runtime_module_path ();
    Value "display-inside", pack_rule display_inside ?runtime_module_path:display_inside_runtime_module_path ();
    Value "display-internal", pack_rule display_internal ?runtime_module_path:display_internal_runtime_module_path ();
    Value "display-legacy", pack_rule display_legacy ?runtime_module_path:display_legacy_runtime_module_path ();
    Value "east-asian-variant-values", pack_rule east_asian_variant_values ?runtime_module_path:east_asian_variant_values_runtime_module_path ();
    Value "feature-type", pack_rule feature_type ?runtime_module_path:feature_type_runtime_module_path ();
    Value "font-variant-css21", pack_rule font_variant_css21 ?runtime_module_path:font_variant_css21_runtime_module_path ();
    Value "generic-family", pack_rule generic_family ?runtime_module_path:generic_family_runtime_module_path ();
    Value "generic-name", pack_rule generic_name ?runtime_module_path:generic_name_runtime_module_path ();
    Value "historical-lig-values", pack_rule historical_lig_values ?runtime_module_path:historical_lig_values_runtime_module_path ();
    Value "numeric-fraction-values", pack_rule numeric_fraction_values ?runtime_module_path:numeric_fraction_values_runtime_module_path ();
    (* Value "overflow-position-value", pack_rule overflow_position ?runtime_module_path:overflow_position_runtime_module_path (); *)
    Value "page-margin-box-type", pack_rule page_margin_box_type ?runtime_module_path:page_margin_box_type_runtime_module_path ();
    Value "polar-color-space", pack_rule polar_color_space ?runtime_module_path:polar_color_space_runtime_module_path ();
    Value "quote", pack_rule quote ?runtime_module_path:quote_runtime_module_path ();
    Value "rectangular-color-space", pack_rule rectangular_color_space ?runtime_module_path:rectangular_color_space_runtime_module_path ();
    Value "shape-box", pack_rule shape_box ?runtime_module_path:shape_box_runtime_module_path ();
    Value "visual-box", pack_rule visual_box ?runtime_module_path:visual_box_runtime_module_path ();
    (* ============================================= *)
    (* Missing Properties - Added via registry scan *)
    (* ============================================= *)
    Property "-moz-appearance", pack_rule property__moz_appearance ?runtime_module_path:property__moz_appearance_runtime_module_path ();
    ( Property "-moz-background-clip",
      pack_rule property__moz_background_clip ?runtime_module_path:property__moz_background_clip_runtime_module_path () );
    Property "-moz-binding", pack_rule property__moz_binding ?runtime_module_path:property__moz_binding_runtime_module_path ();
    ( Property "-moz-border-bottom-colors",
      pack_rule property__moz_border_bottom_colors ?runtime_module_path:property__moz_border_bottom_colors_runtime_module_path () );
    ( Property "-moz-border-left-colors",
      pack_rule property__moz_border_left_colors ?runtime_module_path:property__moz_border_left_colors_runtime_module_path () );
    ( Property "-moz-border-radius-bottomleft",
      pack_rule property__moz_border_radius_bottomleft ?runtime_module_path:property__moz_border_radius_bottomleft_runtime_module_path () );
    ( Property "-moz-border-radius-bottomright",
      pack_rule property__moz_border_radius_bottomright ?runtime_module_path:property__moz_border_radius_bottomright_runtime_module_path () );
    ( Property "-moz-border-radius-topleft",
      pack_rule property__moz_border_radius_topleft ?runtime_module_path:property__moz_border_radius_topleft_runtime_module_path () );
    ( Property "-moz-border-radius-topright",
      pack_rule property__moz_border_radius_topright ?runtime_module_path:property__moz_border_radius_topright_runtime_module_path () );
    ( Property "-moz-border-right-colors",
      pack_rule property__moz_border_right_colors ?runtime_module_path:property__moz_border_right_colors_runtime_module_path () );
    ( Property "-moz-border-top-colors",
      pack_rule property__moz_border_top_colors ?runtime_module_path:property__moz_border_top_colors_runtime_module_path () );
    ( Property "-moz-context-properties",
      pack_rule property__moz_context_properties ?runtime_module_path:property__moz_context_properties_runtime_module_path () );
    ( Property "-moz-control-character-visibility",
      pack_rule property__moz_control_character_visibility ?runtime_module_path:property__moz_control_character_visibility_runtime_module_path () );
    Property "-moz-float-edge", pack_rule property__moz_float_edge ?runtime_module_path:property__moz_float_edge_runtime_module_path ();
    ( Property "-moz-force-broken-image-icon",
      pack_rule property__moz_force_broken_image_icon ?runtime_module_path:property__moz_force_broken_image_icon_runtime_module_path () );
    Property "-moz-image-region", pack_rule property__moz_image_region ?runtime_module_path:property__moz_image_region_runtime_module_path ();
    Property "-moz-orient", pack_rule property__moz_orient ?runtime_module_path:property__moz_orient_runtime_module_path ();
    ( Property "-moz-osx-font-smoothing",
      pack_rule property__moz_osx_font_smoothing ?runtime_module_path:property__moz_osx_font_smoothing_runtime_module_path () );
    Property "-moz-outline-radius", pack_rule property__moz_outline_radius ?runtime_module_path:property__moz_outline_radius_runtime_module_path ();
    ( Property "-moz-outline-radius-bottomleft",
      pack_rule property__moz_outline_radius_bottomleft ?runtime_module_path:property__moz_outline_radius_bottomleft_runtime_module_path () );
    ( Property "-moz-outline-radius-bottomright",
      pack_rule property__moz_outline_radius_bottomright ?runtime_module_path:property__moz_outline_radius_bottomright_runtime_module_path () );
    ( Property "-moz-outline-radius-topleft",
      pack_rule property__moz_outline_radius_topleft ?runtime_module_path:property__moz_outline_radius_topleft_runtime_module_path () );
    ( Property "-moz-outline-radius-topright",
      pack_rule property__moz_outline_radius_topright ?runtime_module_path:property__moz_outline_radius_topright_runtime_module_path () );
    Property "-moz-stack-sizing", pack_rule property__moz_stack_sizing ?runtime_module_path:property__moz_stack_sizing_runtime_module_path ();
    Property "-moz-text-blink", pack_rule property__moz_text_blink ?runtime_module_path:property__moz_text_blink_runtime_module_path ();
    Property "-moz-user-focus", pack_rule property__moz_user_focus ?runtime_module_path:property__moz_user_focus_runtime_module_path ();
    Property "-moz-user-input", pack_rule property__moz_user_input ?runtime_module_path:property__moz_user_input_runtime_module_path ();
    Property "-moz-user-modify", pack_rule property__moz_user_modify ?runtime_module_path:property__moz_user_modify_runtime_module_path ();
    Property "-moz-user-select", pack_rule property__moz_user_select ?runtime_module_path:property__moz_user_select_runtime_module_path ();
    ( Property "-moz-window-dragging",
      pack_rule property__moz_window_dragging ?runtime_module_path:property__moz_window_dragging_runtime_module_path () );
    Property "-moz-window-shadow", pack_rule property__moz_window_shadow ?runtime_module_path:property__moz_window_shadow_runtime_module_path ();
    ( Property "-webkit-background-clip",
      pack_rule property__webkit_background_clip ?runtime_module_path:property__webkit_background_clip_runtime_module_path () );
    ( Property "-webkit-border-before",
      pack_rule property__webkit_border_before ?runtime_module_path:property__webkit_border_before_runtime_module_path () );
    ( Property "-webkit-border-before-color",
      pack_rule property__webkit_border_before_color ?runtime_module_path:property__webkit_border_before_color_runtime_module_path () );
    ( Property "-webkit-border-before-style",
      pack_rule property__webkit_border_before_style ?runtime_module_path:property__webkit_border_before_style_runtime_module_path () );
    ( Property "-webkit-border-before-width",
      pack_rule property__webkit_border_before_width ?runtime_module_path:property__webkit_border_before_width_runtime_module_path () );
    Property "-webkit-box-reflect", pack_rule property__webkit_box_reflect ?runtime_module_path:property__webkit_box_reflect_runtime_module_path ();
    ( Property "-webkit-column-break-after",
      pack_rule property__webkit_column_break_after ?runtime_module_path:property__webkit_column_break_after_runtime_module_path () );
    ( Property "-webkit-column-break-before",
      pack_rule property__webkit_column_break_before ?runtime_module_path:property__webkit_column_break_before_runtime_module_path () );
    ( Property "-webkit-column-break-inside",
      pack_rule property__webkit_column_break_inside ?runtime_module_path:property__webkit_column_break_inside_runtime_module_path () );
    ( Property "-webkit-font-smoothing",
      pack_rule property__webkit_font_smoothing ?runtime_module_path:property__webkit_font_smoothing_runtime_module_path () );
    Property "-webkit-line-clamp", pack_rule property__webkit_line_clamp ?runtime_module_path:property__webkit_line_clamp_runtime_module_path ();
    Property "-webkit-mask", pack_rule property__webkit_mask ?runtime_module_path:property__webkit_mask_runtime_module_path ();
    ( Property "-webkit-mask-attachment",
      pack_rule property__webkit_mask_attachment ?runtime_module_path:property__webkit_mask_attachment_runtime_module_path () );
    ( Property "-webkit-mask-box-image",
      pack_rule property__webkit_mask_box_image ?runtime_module_path:property__webkit_mask_box_image_runtime_module_path () );
    Property "-webkit-mask-clip", pack_rule property__webkit_mask_clip ?runtime_module_path:property__webkit_mask_clip_runtime_module_path ();
    ( Property "-webkit-mask-composite",
      pack_rule property__webkit_mask_composite ?runtime_module_path:property__webkit_mask_composite_runtime_module_path () );
    Property "-webkit-mask-image", pack_rule property__webkit_mask_image ?runtime_module_path:property__webkit_mask_image_runtime_module_path ();
    Property "-webkit-mask-origin", pack_rule property__webkit_mask_origin ?runtime_module_path:property__webkit_mask_origin_runtime_module_path ();
    ( Property "-webkit-mask-position",
      pack_rule property__webkit_mask_position ?runtime_module_path:property__webkit_mask_position_runtime_module_path () );
    ( Property "-webkit-mask-position-x",
      pack_rule property__webkit_mask_position_x ?runtime_module_path:property__webkit_mask_position_x_runtime_module_path () );
    ( Property "-webkit-mask-position-y",
      pack_rule property__webkit_mask_position_y ?runtime_module_path:property__webkit_mask_position_y_runtime_module_path () );
    Property "-webkit-mask-repeat", pack_rule property__webkit_mask_repeat ?runtime_module_path:property__webkit_mask_repeat_runtime_module_path ();
    ( Property "-webkit-mask-repeat-x",
      pack_rule property__webkit_mask_repeat_x ?runtime_module_path:property__webkit_mask_repeat_x_runtime_module_path () );
    ( Property "-webkit-mask-repeat-y",
      pack_rule property__webkit_mask_repeat_y ?runtime_module_path:property__webkit_mask_repeat_y_runtime_module_path () );
    Property "-webkit-mask-size", pack_rule property__webkit_mask_size ?runtime_module_path:property__webkit_mask_size_runtime_module_path ();
    ( Property "-webkit-overflow-scrolling",
      pack_rule property__webkit_overflow_scrolling ?runtime_module_path:property__webkit_overflow_scrolling_runtime_module_path () );
    ( Property "-webkit-print-color-adjust",
      pack_rule property__webkit_print_color_adjust ?runtime_module_path:property__webkit_print_color_adjust_runtime_module_path () );
    ( Property "-webkit-tap-highlight-color",
      pack_rule property__webkit_tap_highlight_color ?runtime_module_path:property__webkit_tap_highlight_color_runtime_module_path () );
    ( Property "-webkit-text-fill-color",
      pack_rule property__webkit_text_fill_color ?runtime_module_path:property__webkit_text_fill_color_runtime_module_path () );
    ( Property "-webkit-text-security",
      pack_rule property__webkit_text_security ?runtime_module_path:property__webkit_text_security_runtime_module_path () );
    Property "-webkit-text-stroke", pack_rule property__webkit_text_stroke ?runtime_module_path:property__webkit_text_stroke_runtime_module_path ();
    ( Property "-webkit-text-stroke-color",
      pack_rule property__webkit_text_stroke_color ?runtime_module_path:property__webkit_text_stroke_color_runtime_module_path () );
    ( Property "-webkit-text-stroke-width",
      pack_rule property__webkit_text_stroke_width ?runtime_module_path:property__webkit_text_stroke_width_runtime_module_path () );
    ( Property "-webkit-touch-callout",
      pack_rule property__webkit_touch_callout ?runtime_module_path:property__webkit_touch_callout_runtime_module_path () );
    Property "-webkit-user-drag", pack_rule property__webkit_user_drag ?runtime_module_path:property__webkit_user_drag_runtime_module_path ();
    Property "-webkit-user-modify", pack_rule property__webkit_user_modify ?runtime_module_path:property__webkit_user_modify_runtime_module_path ();
    Property "-webkit-user-select", pack_rule property__webkit_user_select ?runtime_module_path:property__webkit_user_select_runtime_module_path ();
    Property "accent-color", pack_rule property_accent_color ?runtime_module_path:property_accent_color_runtime_module_path ();
    Property "alignment-baseline", pack_rule property_alignment_baseline ?runtime_module_path:property_alignment_baseline_runtime_module_path ();
    Property "anchor-name", pack_rule property_anchor_name ?runtime_module_path:property_anchor_name_runtime_module_path ();
    Property "anchor-scope", pack_rule property_anchor_scope ?runtime_module_path:property_anchor_scope_runtime_module_path ();
    Property "animation", pack_rule property_animation ?runtime_module_path:property_animation_runtime_module_path ();
    ( Property "animation-composition",
      pack_rule property_animation_composition ?runtime_module_path:property_animation_composition_runtime_module_path () );
    Property "animation-delay", pack_rule property_animation_delay ?runtime_module_path:property_animation_delay_runtime_module_path ();
    Property "animation-delay-end", pack_rule property_animation_delay_end ?runtime_module_path:property_animation_delay_end_runtime_module_path ();
    ( Property "animation-delay-start",
      pack_rule property_animation_delay_start ?runtime_module_path:property_animation_delay_start_runtime_module_path () );
    Property "animation-direction", pack_rule property_animation_direction ?runtime_module_path:property_animation_direction_runtime_module_path ();
    Property "animation-duration", pack_rule property_animation_duration ?runtime_module_path:property_animation_duration_runtime_module_path ();
    Property "animation-fill-mode", pack_rule property_animation_fill_mode ?runtime_module_path:property_animation_fill_mode_runtime_module_path ();
    ( Property "animation-iteration-count",
      pack_rule property_animation_iteration_count ?runtime_module_path:property_animation_iteration_count_runtime_module_path () );
    Property "animation-name", pack_rule property_animation_name ();
    ( Property "animation-play-state",
      pack_rule property_animation_play_state ?runtime_module_path:property_animation_play_state_runtime_module_path () );
    Property "animation-range", pack_rule property_animation_range ?runtime_module_path:property_animation_range_runtime_module_path ();
    Property "animation-range-end", pack_rule property_animation_range_end ?runtime_module_path:property_animation_range_end_runtime_module_path ();
    ( Property "animation-range-start",
      pack_rule property_animation_range_start ?runtime_module_path:property_animation_range_start_runtime_module_path () );
    Property "animation-timeline", pack_rule property_animation_timeline ?runtime_module_path:property_animation_timeline_runtime_module_path ();
    ( Property "animation-timing-function",
      pack_rule property_animation_timing_function ?runtime_module_path:property_animation_timing_function_runtime_module_path () );
    Property "aspect-ratio", pack_rule property_aspect_ratio ?runtime_module_path:property_aspect_ratio_runtime_module_path ();
    Property "azimuth", pack_rule property_azimuth ?runtime_module_path:property_azimuth_runtime_module_path ();
    Property "backdrop-blur", pack_rule property_backdrop_blur ?runtime_module_path:property_backdrop_blur_runtime_module_path ();
    Property "backdrop-filter", pack_rule property_backdrop_filter ();
    Property "background", pack_rule property_background ?runtime_module_path:property_background_runtime_module_path ();
    ( Property "background-attachment",
      pack_rule property_background_attachment ?runtime_module_path:property_background_attachment_runtime_module_path () );
    ( Property "background-blend-mode",
      pack_rule property_background_blend_mode ?runtime_module_path:property_background_blend_mode_runtime_module_path () );
    Property "background-clip", pack_rule property_background_clip ?runtime_module_path:property_background_clip_runtime_module_path ();
    Property "background-color", pack_rule property_background_color ();
    Property "background-image", pack_rule property_background_image ?runtime_module_path:property_background_image_runtime_module_path ();
    Property "background-origin", pack_rule property_background_origin ?runtime_module_path:property_background_origin_runtime_module_path ();
    Property "background-position", pack_rule property_background_position ?runtime_module_path:property_background_position_runtime_module_path ();
    ( Property "background-position-x",
      pack_rule property_background_position_x ?runtime_module_path:property_background_position_x_runtime_module_path () );
    ( Property "background-position-y",
      pack_rule property_background_position_y ?runtime_module_path:property_background_position_y_runtime_module_path () );
    Property "background-repeat", pack_rule property_background_repeat ?runtime_module_path:property_background_repeat_runtime_module_path ();
    Property "background-size", pack_rule property_background_size ?runtime_module_path:property_background_size_runtime_module_path ();
    Property "baseline-shift", pack_rule property_baseline_shift ?runtime_module_path:property_baseline_shift_runtime_module_path ();
    Property "behavior", pack_rule property_behavior ?runtime_module_path:property_behavior_runtime_module_path ();
    Property "bleed", pack_rule property_bleed ?runtime_module_path:property_bleed_runtime_module_path ();
    Property "block-overflow", pack_rule property_block_overflow ?runtime_module_path:property_block_overflow_runtime_module_path ();
    Property "block-size", pack_rule property_block_size ();
    Property "border-block", pack_rule property_border_block ?runtime_module_path:property_border_block_runtime_module_path ();
    Property "border-block-color", pack_rule property_border_block_color ?runtime_module_path:property_border_block_color_runtime_module_path ();
    Property "border-block-end", pack_rule property_border_block_end ?runtime_module_path:property_border_block_end_runtime_module_path ();
    ( Property "border-block-end-color",
      pack_rule property_border_block_end_color ?runtime_module_path:property_border_block_end_color_runtime_module_path () );
    ( Property "border-block-end-style",
      pack_rule property_border_block_end_style ?runtime_module_path:property_border_block_end_style_runtime_module_path () );
    ( Property "border-block-end-width",
      pack_rule property_border_block_end_width ?runtime_module_path:property_border_block_end_width_runtime_module_path () );
    Property "border-block-start", pack_rule property_border_block_start ?runtime_module_path:property_border_block_start_runtime_module_path ();
    ( Property "border-block-start-color",
      pack_rule property_border_block_start_color ?runtime_module_path:property_border_block_start_color_runtime_module_path () );
    ( Property "border-block-start-style",
      pack_rule property_border_block_start_style ?runtime_module_path:property_border_block_start_style_runtime_module_path () );
    ( Property "border-block-start-width",
      pack_rule property_border_block_start_width ?runtime_module_path:property_border_block_start_width_runtime_module_path () );
    Property "border-block-style", pack_rule property_border_block_style ?runtime_module_path:property_border_block_style_runtime_module_path ();
    Property "border-block-width", pack_rule property_border_block_width ?runtime_module_path:property_border_block_width_runtime_module_path ();
    Property "border-bottom", pack_rule property_border_bottom ?runtime_module_path:property_border_bottom_runtime_module_path ();
    Property "border-bottom-color", pack_rule property_border_bottom_color ();
    ( Property "border-bottom-left-radius",
      pack_rule property_border_bottom_left_radius () );
    ( Property "border-bottom-right-radius",
      pack_rule property_border_bottom_right_radius () );
    Property "border-bottom-style", pack_rule property_border_bottom_style ();
    Property "border-bottom-width", pack_rule property_border_bottom_width ();
    Property "border-color", pack_rule property_border_color ();
    ( Property "border-end-end-radius",
      pack_rule property_border_end_end_radius () );
    ( Property "border-end-start-radius",
      pack_rule property_border_end_start_radius () );
    Property "border-image", pack_rule property_border_image ?runtime_module_path:property_border_image_runtime_module_path ();
    Property "border-image-outset", pack_rule property_border_image_outset ?runtime_module_path:property_border_image_outset_runtime_module_path ();
    Property "border-image-slice", pack_rule property_border_image_slice ?runtime_module_path:property_border_image_slice_runtime_module_path ();
    Property "border-image-source", pack_rule property_border_image_source ?runtime_module_path:property_border_image_source_runtime_module_path ();
    Property "border-image-width", pack_rule property_border_image_width ?runtime_module_path:property_border_image_width_runtime_module_path ();
    Property "border-inline", pack_rule property_border_inline ?runtime_module_path:property_border_inline_runtime_module_path ();
    Property "border-inline-color", pack_rule property_border_inline_color ?runtime_module_path:property_border_inline_color_runtime_module_path ();
    Property "border-inline-end", pack_rule property_border_inline_end ?runtime_module_path:property_border_inline_end_runtime_module_path ();
    ( Property "border-inline-end-color",
      pack_rule property_border_inline_end_color ?runtime_module_path:property_border_inline_end_color_runtime_module_path () );
    ( Property "border-inline-end-style",
      pack_rule property_border_inline_end_style ?runtime_module_path:property_border_inline_end_style_runtime_module_path () );
    ( Property "border-inline-end-width",
      pack_rule property_border_inline_end_width ?runtime_module_path:property_border_inline_end_width_runtime_module_path () );
    Property "border-inline-start", pack_rule property_border_inline_start ?runtime_module_path:property_border_inline_start_runtime_module_path ();
    ( Property "border-inline-start-color",
      pack_rule property_border_inline_start_color ?runtime_module_path:property_border_inline_start_color_runtime_module_path () );
    ( Property "border-inline-start-style",
      pack_rule property_border_inline_start_style ?runtime_module_path:property_border_inline_start_style_runtime_module_path () );
    ( Property "border-inline-start-width",
      pack_rule property_border_inline_start_width ?runtime_module_path:property_border_inline_start_width_runtime_module_path () );
    Property "border-inline-style", pack_rule property_border_inline_style ?runtime_module_path:property_border_inline_style_runtime_module_path ();
    Property "border-inline-width", pack_rule property_border_inline_width ?runtime_module_path:property_border_inline_width_runtime_module_path ();
    Property "border-left", pack_rule property_border_left ?runtime_module_path:property_border_left_runtime_module_path ();
    Property "border-left-color", pack_rule property_border_left_color ();
    Property "border-left-style", pack_rule property_border_left_style ();
    Property "border-left-width", pack_rule property_border_left_width ();
    Property "border-radius", pack_rule property_border_radius ?runtime_module_path:property_border_radius_runtime_module_path ();
    Property "border-right", pack_rule property_border_right ?runtime_module_path:property_border_right_runtime_module_path ();
    Property "border-right-color", pack_rule property_border_right_color ();
    Property "border-right-style", pack_rule property_border_right_style ();
    Property "border-right-width", pack_rule property_border_right_width ();
    Property "border-spacing", pack_rule property_border_spacing ?runtime_module_path:property_border_spacing_runtime_module_path ();
    ( Property "border-start-end-radius",
      pack_rule property_border_start_end_radius () );
    ( Property "border-start-start-radius",
      pack_rule property_border_start_start_radius () );
    Property "border-style", pack_rule property_border_style ?runtime_module_path:property_border_style_runtime_module_path ();
    Property "border-top", pack_rule property_border_top ?runtime_module_path:property_border_top_runtime_module_path ();
    Property "border-top-color", pack_rule property_border_top_color ();
    ( Property "border-top-left-radius",
      pack_rule property_border_top_left_radius () );
    ( Property "border-top-right-radius",
      pack_rule property_border_top_right_radius () );
    Property "border-top-style", pack_rule property_border_top_style ();
    Property "border-top-width", pack_rule property_border_top_width ();
    Property "border-width", pack_rule property_border_width ();
    Property "bottom", pack_rule property_bottom ?runtime_module_path:property_bottom_runtime_module_path ();
    Property "box-align", pack_rule property_box_align ?runtime_module_path:property_box_align_runtime_module_path ();
    Property "box-direction", pack_rule property_box_direction ?runtime_module_path:property_box_direction_runtime_module_path ();
    Property "box-flex", pack_rule property_box_flex ?runtime_module_path:property_box_flex_runtime_module_path ();
    Property "box-flex-group", pack_rule property_box_flex_group ?runtime_module_path:property_box_flex_group_runtime_module_path ();
    Property "box-lines", pack_rule property_box_lines ?runtime_module_path:property_box_lines_runtime_module_path ();
    Property "box-ordinal-group", pack_rule property_box_ordinal_group ?runtime_module_path:property_box_ordinal_group_runtime_module_path ();
    Property "box-orient", pack_rule property_box_orient ?runtime_module_path:property_box_orient_runtime_module_path ();
    Property "-webkit-box-orient", pack_rule property_box_orient ?runtime_module_path:property_box_orient_runtime_module_path ();
    Property "box-pack", pack_rule property_box_pack ?runtime_module_path:property_box_pack_runtime_module_path ();
    Property "box-shadow", pack_rule property_box_shadow ?runtime_module_path:property_box_shadow_runtime_module_path ();
    Property "-webkit-box-shadow", pack_rule property_box_shadow ?runtime_module_path:property_box_shadow_runtime_module_path ();
    Property "clip", pack_rule property_clip ?runtime_module_path:property_clip_runtime_module_path ();
    Property "clip-path", pack_rule property_clip_path ?runtime_module_path:property_clip_path_runtime_module_path ();
    Property "color", pack_rule property_color ?runtime_module_path:property_color_runtime_module_path ();
    Property "color-interpolation", pack_rule property_color_interpolation ?runtime_module_path:property_color_interpolation_runtime_module_path ();
    ( Property "color-interpolation-filters",
      pack_rule property_color_interpolation_filters ?runtime_module_path:property_color_interpolation_filters_runtime_module_path () );
    Property "color-rendering", pack_rule property_color_rendering ?runtime_module_path:property_color_rendering_runtime_module_path ();
    Property "column-count", pack_rule property_column_count ?runtime_module_path:property_column_count_runtime_module_path ();
    Property "column-rule", pack_rule property_column_rule ?runtime_module_path:property_column_rule_runtime_module_path ();
    Property "column-rule-color", pack_rule property_column_rule_color ?runtime_module_path:property_column_rule_color_runtime_module_path ();
    Property "column-rule-style", pack_rule property_column_rule_style ?runtime_module_path:property_column_rule_style_runtime_module_path ();
    Property "column-rule-width", pack_rule property_column_rule_width ?runtime_module_path:property_column_rule_width_runtime_module_path ();
    Property "column-width", pack_rule property_column_width ?runtime_module_path:property_column_width_runtime_module_path ();
    Property "columns", pack_rule property_columns ?runtime_module_path:property_columns_runtime_module_path ();
    ( Property "contain-intrinsic-block-size",
      pack_rule property_contain_intrinsic_block_size ?runtime_module_path:property_contain_intrinsic_block_size_runtime_module_path () );
    ( Property "contain-intrinsic-height",
      pack_rule property_contain_intrinsic_height ?runtime_module_path:property_contain_intrinsic_height_runtime_module_path () );
    ( Property "contain-intrinsic-inline-size",
      pack_rule property_contain_intrinsic_inline_size ?runtime_module_path:property_contain_intrinsic_inline_size_runtime_module_path () );
    ( Property "contain-intrinsic-width",
      pack_rule property_contain_intrinsic_width ?runtime_module_path:property_contain_intrinsic_width_runtime_module_path () );
    Property "container", pack_rule property_container ?runtime_module_path:property_container_runtime_module_path ();
    Property "container-name", pack_rule property_container_name ?runtime_module_path:property_container_name_runtime_module_path ();
    ( Property "container-name-computed",
      pack_rule property_container_name_computed ?runtime_module_path:property_container_name_computed_runtime_module_path () );
    Property "content", pack_rule property_content ?runtime_module_path:property_content_runtime_module_path ();
    Property "counter-increment", pack_rule property_counter_increment ?runtime_module_path:property_counter_increment_runtime_module_path ();
    Property "counter-reset", pack_rule property_counter_reset ?runtime_module_path:property_counter_reset_runtime_module_path ();
    Property "counter-set", pack_rule property_counter_set ?runtime_module_path:property_counter_set_runtime_module_path ();
    Property "cue", pack_rule property_cue ?runtime_module_path:property_cue_runtime_module_path ();
    Property "cue-after", pack_rule property_cue_after ?runtime_module_path:property_cue_after_runtime_module_path ();
    Property "cue-before", pack_rule property_cue_before ?runtime_module_path:property_cue_before_runtime_module_path ();
    Property "cursor", pack_rule property_cursor ?runtime_module_path:property_cursor_runtime_module_path ();
    Property "cx", pack_rule property_cx ();
    Property "cy", pack_rule property_cy ();
    Property "d", pack_rule property_d ();
    Property "dominant-baseline", pack_rule property_dominant_baseline ?runtime_module_path:property_dominant_baseline_runtime_module_path ();
    Property "field-sizing", pack_rule property_field_sizing ?runtime_module_path:property_field_sizing_runtime_module_path ();
    Property "fill", pack_rule property_fill ?runtime_module_path:property_fill_runtime_module_path ();
    Property "fill-opacity", pack_rule property_fill_opacity ?runtime_module_path:property_fill_opacity_runtime_module_path ();
    Property "fill-rule", pack_rule property_fill_rule ?runtime_module_path:property_fill_rule_runtime_module_path ();
    Property "filter", pack_rule property_filter ?runtime_module_path:property_filter_runtime_module_path ();
    Property "flex", pack_rule property_flex ?runtime_module_path:property_flex_runtime_module_path ();
    Property "flex-flow", pack_rule property_flex_flow ?runtime_module_path:property_flex_flow_runtime_module_path ();
    Property "flood-color", pack_rule property_flood_color ();
    Property "flood-opacity", pack_rule property_flood_opacity ();
    Property "font", pack_rule property_font ?runtime_module_path:property_font_runtime_module_path ();
    Property "font-family", pack_rule property_font_family ?runtime_module_path:property_font_family_runtime_module_path ();
    ( Property "font-feature-settings",
      pack_rule property_font_feature_settings ?runtime_module_path:property_font_feature_settings_runtime_module_path () );
    ( Property "font-language-override",
      pack_rule property_font_language_override ?runtime_module_path:property_font_language_override_runtime_module_path () );
    Property "font-size", pack_rule property_font_size ?runtime_module_path:property_font_size_runtime_module_path ();
    Property "font-size-adjust", pack_rule property_font_size_adjust ?runtime_module_path:property_font_size_adjust_runtime_module_path ();
    Property "font-smooth", pack_rule property_font_smooth ?runtime_module_path:property_font_smooth_runtime_module_path ();
    Property "font-synthesis", pack_rule property_font_synthesis ?runtime_module_path:property_font_synthesis_runtime_module_path ();
    Property "font-variant", pack_rule property_font_variant ?runtime_module_path:property_font_variant_runtime_module_path ();
    ( Property "font-variant-alternates",
      pack_rule property_font_variant_alternates ?runtime_module_path:property_font_variant_alternates_runtime_module_path () );
    ( Property "font-variant-east-asian",
      pack_rule property_font_variant_east_asian ?runtime_module_path:property_font_variant_east_asian_runtime_module_path () );
    Property "font-variant-emoji", pack_rule property_font_variant_emoji ?runtime_module_path:property_font_variant_emoji_runtime_module_path ();
    ( Property "font-variant-ligatures",
      pack_rule property_font_variant_ligatures ?runtime_module_path:property_font_variant_ligatures_runtime_module_path () );
    ( Property "font-variant-numeric",
      pack_rule property_font_variant_numeric ?runtime_module_path:property_font_variant_numeric_runtime_module_path () );
    ( Property "font-variation-settings",
      pack_rule property_font_variation_settings ?runtime_module_path:property_font_variation_settings_runtime_module_path () );
    Property "font-weight", pack_rule property_font_weight ?runtime_module_path:property_font_weight_runtime_module_path ();
    Property "gap", pack_rule property_gap ?runtime_module_path:property_gap_runtime_module_path ();
    ( Property "glyph-orientation-horizontal",
      pack_rule property_glyph_orientation_horizontal ?runtime_module_path:property_glyph_orientation_horizontal_runtime_module_path () );
    ( Property "glyph-orientation-vertical",
      pack_rule property_glyph_orientation_vertical ?runtime_module_path:property_glyph_orientation_vertical_runtime_module_path () );
    Property "grid", pack_rule property_grid ?runtime_module_path:property_grid_runtime_module_path ();
    Property "grid-area", pack_rule property_grid_area ?runtime_module_path:property_grid_area_runtime_module_path ();
    Property "grid-auto-columns", pack_rule property_grid_auto_columns ?runtime_module_path:property_grid_auto_columns_runtime_module_path ();
    Property "grid-auto-rows", pack_rule property_grid_auto_rows ?runtime_module_path:property_grid_auto_rows_runtime_module_path ();
    Property "grid-column", pack_rule property_grid_column ?runtime_module_path:property_grid_column_runtime_module_path ();
    Property "grid-column-end", pack_rule property_grid_column_end ?runtime_module_path:property_grid_column_end_runtime_module_path ();
    Property "grid-column-gap", pack_rule property_grid_column_gap ();
    Property "grid-column-start", pack_rule property_grid_column_start ?runtime_module_path:property_grid_column_start_runtime_module_path ();
    Property "grid-gap", pack_rule property_grid_gap ();
    Property "grid-row", pack_rule property_grid_row ?runtime_module_path:property_grid_row_runtime_module_path ();
    Property "grid-row-end", pack_rule property_grid_row_end ?runtime_module_path:property_grid_row_end_runtime_module_path ();
    Property "grid-row-gap", pack_rule property_grid_row_gap ();
    Property "grid-row-start", pack_rule property_grid_row_start ?runtime_module_path:property_grid_row_start_runtime_module_path ();
    Property "grid-template", pack_rule property_grid_template ?runtime_module_path:property_grid_template_runtime_module_path ();
    Property "grid-template-areas", pack_rule property_grid_template_areas ?runtime_module_path:property_grid_template_areas_runtime_module_path ();
    ( Property "grid-template-columns",
      pack_rule property_grid_template_columns ?runtime_module_path:property_grid_template_columns_runtime_module_path () );
    Property "grid-template-rows", pack_rule property_grid_template_rows ?runtime_module_path:property_grid_template_rows_runtime_module_path ();
    Property "hanging-punctuation", pack_rule property_hanging_punctuation ?runtime_module_path:property_hanging_punctuation_runtime_module_path ();
    Property "height", pack_rule property_height ?runtime_module_path:property_height_runtime_module_path ();
    Property "hyphenate-character", pack_rule property_hyphenate_character ?runtime_module_path:property_hyphenate_character_runtime_module_path ();
    ( Property "hyphenate-limit-chars",
      pack_rule property_hyphenate_limit_chars ?runtime_module_path:property_hyphenate_limit_chars_runtime_module_path () );
    ( Property "hyphenate-limit-last",
      pack_rule property_hyphenate_limit_last ?runtime_module_path:property_hyphenate_limit_last_runtime_module_path () );
    ( Property "hyphenate-limit-lines",
      pack_rule property_hyphenate_limit_lines ?runtime_module_path:property_hyphenate_limit_lines_runtime_module_path () );
    ( Property "hyphenate-limit-zone",
      pack_rule property_hyphenate_limit_zone ?runtime_module_path:property_hyphenate_limit_zone_runtime_module_path () );
    Property "image-orientation", pack_rule property_image_orientation ?runtime_module_path:property_image_orientation_runtime_module_path ();
    Property "image-resolution", pack_rule property_image_resolution ?runtime_module_path:property_image_resolution_runtime_module_path ();
    Property "ime-mode", pack_rule property_ime_mode ?runtime_module_path:property_ime_mode_runtime_module_path ();
    Property "inherits", pack_rule property_inherits ?runtime_module_path:property_inherits_runtime_module_path ();
    Property "initial-letter", pack_rule property_initial_letter ?runtime_module_path:property_initial_letter_runtime_module_path ();
    ( Property "initial-letter-align",
      pack_rule property_initial_letter_align ?runtime_module_path:property_initial_letter_align_runtime_module_path () );
    Property "initial-value", pack_rule property_initial_value ?runtime_module_path:property_initial_value_runtime_module_path ();
    Property "inline-size", pack_rule property_inline_size ();
    Property "inset", pack_rule property_inset ?runtime_module_path:property_inset_runtime_module_path ();
    Property "inset-area", pack_rule property_inset_area ?runtime_module_path:property_inset_area_runtime_module_path ();
    Property "inset-block", pack_rule property_inset_block ?runtime_module_path:property_inset_block_runtime_module_path ();
    Property "inset-block-end", pack_rule property_inset_block_end ();
    Property "inset-block-start", pack_rule property_inset_block_start ();
    Property "inset-inline", pack_rule property_inset_inline ?runtime_module_path:property_inset_inline_runtime_module_path ();
    Property "inset-inline-end", pack_rule property_inset_inline_end ();
    Property "inset-inline-start", pack_rule property_inset_inline_start ();
    Property "interpolate-size", pack_rule property_interpolate_size ?runtime_module_path:property_interpolate_size_runtime_module_path ();
    Property "kerning", pack_rule property_kerning ?runtime_module_path:property_kerning_runtime_module_path ();
    Property "layout-grid", pack_rule property_layout_grid ?runtime_module_path:property_layout_grid_runtime_module_path ();
    Property "layout-grid-char", pack_rule property_layout_grid_char ?runtime_module_path:property_layout_grid_char_runtime_module_path ();
    Property "layout-grid-line", pack_rule property_layout_grid_line ?runtime_module_path:property_layout_grid_line_runtime_module_path ();
    Property "layout-grid-mode", pack_rule property_layout_grid_mode ?runtime_module_path:property_layout_grid_mode_runtime_module_path ();
    Property "layout-grid-type", pack_rule property_layout_grid_type ?runtime_module_path:property_layout_grid_type_runtime_module_path ();
    Property "left", pack_rule property_left ?runtime_module_path:property_left_runtime_module_path ();
    Property "letter-spacing", pack_rule property_letter_spacing ?runtime_module_path:property_letter_spacing_runtime_module_path ();
    Property "lighting-color", pack_rule property_lighting_color ();
    Property "line-break", pack_rule property_line_break ?runtime_module_path:property_line_break_runtime_module_path ();
    Property "line-clamp", pack_rule property_line_clamp ?runtime_module_path:property_line_clamp_runtime_module_path ();
    Property "line-height", pack_rule property_line_height ?runtime_module_path:property_line_height_runtime_module_path ();
    Property "line-height-step", pack_rule property_line_height_step ?runtime_module_path:property_line_height_step_runtime_module_path ();
    Property "list-style", pack_rule property_list_style ?runtime_module_path:property_list_style_runtime_module_path ();
    Property "list-style-image", pack_rule property_list_style_image ?runtime_module_path:property_list_style_image_runtime_module_path ();
    Property "margin", pack_rule property_margin ?runtime_module_path:property_margin_runtime_module_path ();
    Property "margin-block", pack_rule property_margin_block ?runtime_module_path:property_margin_block_runtime_module_path ();
    Property "margin-block-end", pack_rule property_margin_block_end ();
    Property "margin-block-start", pack_rule property_margin_block_start ();
    Property "margin-bottom", pack_rule property_margin_bottom ();
    Property "margin-inline", pack_rule property_margin_inline ?runtime_module_path:property_margin_inline_runtime_module_path ();
    Property "margin-inline-end", pack_rule property_margin_inline_end ();
    Property "margin-inline-start", pack_rule property_margin_inline_start ();
    Property "margin-left", pack_rule property_margin_left ();
    Property "margin-right", pack_rule property_margin_right ();
    Property "margin-top", pack_rule property_margin_top ();
    Property "margin-trim", pack_rule property_margin_trim ?runtime_module_path:property_margin_trim_runtime_module_path ();
    Property "marker", pack_rule property_marker ?runtime_module_path:property_marker_runtime_module_path ();
    Property "marker-end", pack_rule property_marker_end ?runtime_module_path:property_marker_end_runtime_module_path ();
    Property "marker-mid", pack_rule property_marker_mid ?runtime_module_path:property_marker_mid_runtime_module_path ();
    Property "marker-start", pack_rule property_marker_start ?runtime_module_path:property_marker_start_runtime_module_path ();
    Property "marks", pack_rule property_marks ?runtime_module_path:property_marks_runtime_module_path ();
    Property "mask", pack_rule property_mask ?runtime_module_path:property_mask_runtime_module_path ();
    Property "mask-border", pack_rule property_mask_border ?runtime_module_path:property_mask_border_runtime_module_path ();
    Property "mask-border-outset", pack_rule property_mask_border_outset ?runtime_module_path:property_mask_border_outset_runtime_module_path ();
    Property "mask-border-repeat", pack_rule property_mask_border_repeat ?runtime_module_path:property_mask_border_repeat_runtime_module_path ();
    Property "mask-border-slice", pack_rule property_mask_border_slice ?runtime_module_path:property_mask_border_slice_runtime_module_path ();
    Property "mask-border-source", pack_rule property_mask_border_source ?runtime_module_path:property_mask_border_source_runtime_module_path ();
    Property "mask-border-width", pack_rule property_mask_border_width ?runtime_module_path:property_mask_border_width_runtime_module_path ();
    Property "mask-clip", pack_rule property_mask_clip ?runtime_module_path:property_mask_clip_runtime_module_path ();
    Property "mask-composite", pack_rule property_mask_composite ?runtime_module_path:property_mask_composite_runtime_module_path ();
    Property "mask-image", pack_rule property_mask_image ?runtime_module_path:property_mask_image_runtime_module_path ();
    Property "mask-mode", pack_rule property_mask_mode ?runtime_module_path:property_mask_mode_runtime_module_path ();
    Property "mask-origin", pack_rule property_mask_origin ?runtime_module_path:property_mask_origin_runtime_module_path ();
    Property "mask-position", pack_rule property_mask_position ?runtime_module_path:property_mask_position_runtime_module_path ();
    Property "mask-repeat", pack_rule property_mask_repeat ?runtime_module_path:property_mask_repeat_runtime_module_path ();
    Property "mask-size", pack_rule property_mask_size ?runtime_module_path:property_mask_size_runtime_module_path ();
    Property "masonry-auto-flow", pack_rule property_masonry_auto_flow ?runtime_module_path:property_masonry_auto_flow_runtime_module_path ();
    Property "math-depth", pack_rule property_math_depth ?runtime_module_path:property_math_depth_runtime_module_path ();
    Property "math-shift", pack_rule property_math_shift ?runtime_module_path:property_math_shift_runtime_module_path ();
    Property "math-style", pack_rule property_math_style ?runtime_module_path:property_math_style_runtime_module_path ();
    Property "max-block-size", pack_rule property_max_block_size ();
    Property "max-height", pack_rule property_max_height ?runtime_module_path:property_max_height_runtime_module_path ();
    Property "max-inline-size", pack_rule property_max_inline_size ();
    Property "max-lines", pack_rule property_max_lines ?runtime_module_path:property_max_lines_runtime_module_path ();
    Property "max-width", pack_rule property_max_width ?runtime_module_path:property_max_width_runtime_module_path ();
    Property "media-any-hover", pack_rule property_media_any_hover ?runtime_module_path:property_media_any_hover_runtime_module_path ();
    Property "media-any-pointer", pack_rule property_media_any_pointer ?runtime_module_path:property_media_any_pointer_runtime_module_path ();
    Property "media-color-gamut", pack_rule property_media_color_gamut ?runtime_module_path:property_media_color_gamut_runtime_module_path ();
    Property "media-color-index", pack_rule property_media_color_index ?runtime_module_path:property_media_color_index_runtime_module_path ();
    Property "media-display-mode", pack_rule property_media_display_mode ?runtime_module_path:property_media_display_mode_runtime_module_path ();
    Property "media-forced-colors", pack_rule property_media_forced_colors ?runtime_module_path:property_media_forced_colors_runtime_module_path ();
    Property "media-grid", pack_rule property_media_grid ?runtime_module_path:property_media_grid_runtime_module_path ();
    Property "media-hover", pack_rule property_media_hover ?runtime_module_path:property_media_hover_runtime_module_path ();
    ( Property "media-inverted-colors",
      pack_rule property_media_inverted_colors ?runtime_module_path:property_media_inverted_colors_runtime_module_path () );
    ( Property "media-max-aspect-ratio",
      pack_rule property_media_max_aspect_ratio ?runtime_module_path:property_media_max_aspect_ratio_runtime_module_path () );
    ( Property "media-max-resolution",
      pack_rule property_media_max_resolution ?runtime_module_path:property_media_max_resolution_runtime_module_path () );
    ( Property "media-min-aspect-ratio",
      pack_rule property_media_min_aspect_ratio ?runtime_module_path:property_media_min_aspect_ratio_runtime_module_path () );
    Property "media-min-color", pack_rule property_media_min_color ?runtime_module_path:property_media_min_color_runtime_module_path ();
    ( Property "media-min-color-index",
      pack_rule property_media_min_color_index ?runtime_module_path:property_media_min_color_index_runtime_module_path () );
    ( Property "media-min-resolution",
      pack_rule property_media_min_resolution ?runtime_module_path:property_media_min_resolution_runtime_module_path () );
    Property "media-monochrome", pack_rule property_media_monochrome ?runtime_module_path:property_media_monochrome_runtime_module_path ();
    Property "media-orientation", pack_rule property_media_orientation ?runtime_module_path:property_media_orientation_runtime_module_path ();
    Property "media-pointer", pack_rule property_media_pointer ?runtime_module_path:property_media_pointer_runtime_module_path ();
    ( Property "media-prefers-color-scheme",
      pack_rule property_media_prefers_color_scheme ?runtime_module_path:property_media_prefers_color_scheme_runtime_module_path () );
    ( Property "media-prefers-contrast",
      pack_rule property_media_prefers_contrast ?runtime_module_path:property_media_prefers_contrast_runtime_module_path () );
    ( Property "media-prefers-reduced-motion",
      pack_rule property_media_prefers_reduced_motion ?runtime_module_path:property_media_prefers_reduced_motion_runtime_module_path () );
    Property "media-resolution", pack_rule property_media_resolution ?runtime_module_path:property_media_resolution_runtime_module_path ();
    Property "media-scripting", pack_rule property_media_scripting ?runtime_module_path:property_media_scripting_runtime_module_path ();
    Property "media-update", pack_rule property_media_update ?runtime_module_path:property_media_update_runtime_module_path ();
    Property "min-block-size", pack_rule property_min_block_size ();
    Property "min-height", pack_rule property_min_height ?runtime_module_path:property_min_height_runtime_module_path ();
    Property "min-inline-size", pack_rule property_min_inline_size ();
    Property "min-width", pack_rule property_min_width ?runtime_module_path:property_min_width_runtime_module_path ();
    Property "nav-down", pack_rule property_nav_down ?runtime_module_path:property_nav_down_runtime_module_path ();
    Property "nav-left", pack_rule property_nav_left ?runtime_module_path:property_nav_left_runtime_module_path ();
    Property "nav-right", pack_rule property_nav_right ?runtime_module_path:property_nav_right_runtime_module_path ();
    Property "nav-up", pack_rule property_nav_up ?runtime_module_path:property_nav_up_runtime_module_path ();
    Property "object-position", pack_rule property_object_position ?runtime_module_path:property_object_position_runtime_module_path ();
    Property "offset", pack_rule property_offset ?runtime_module_path:property_offset_runtime_module_path ();
    Property "offset-anchor", pack_rule property_offset_anchor ?runtime_module_path:property_offset_anchor_runtime_module_path ();
    Property "offset-distance", pack_rule property_offset_distance ?runtime_module_path:property_offset_distance_runtime_module_path ();
    Property "offset-path", pack_rule property_offset_path ?runtime_module_path:property_offset_path_runtime_module_path ();
    Property "offset-position", pack_rule property_offset_position ?runtime_module_path:property_offset_position_runtime_module_path ();
    Property "offset-rotate", pack_rule property_offset_rotate ?runtime_module_path:property_offset_rotate_runtime_module_path ();
    Property "opacity", pack_rule property_opacity ();
    Property "order", pack_rule property_order ?runtime_module_path:property_order_runtime_module_path ();
    Property "orphans", pack_rule property_orphans ?runtime_module_path:property_orphans_runtime_module_path ();
    Property "outline", pack_rule property_outline ?runtime_module_path:property_outline_runtime_module_path ();
    Property "outline-color", pack_rule property_outline_color ();
    Property "outline-offset", pack_rule property_outline_offset ();
    Property "overflow-block", pack_rule property_overflow_block ?runtime_module_path:property_overflow_block_runtime_module_path ();
    ( Property "overflow-clip-margin",
      pack_rule property_overflow_clip_margin ?runtime_module_path:property_overflow_clip_margin_runtime_module_path () );
    Property "overflow-inline", pack_rule property_overflow_inline ?runtime_module_path:property_overflow_inline_runtime_module_path ();
    Property "overflow-x", pack_rule property_overflow_x ();
    Property "overflow-y", pack_rule property_overflow_y ();
    Property "overlay", pack_rule property_overlay ?runtime_module_path:property_overlay_runtime_module_path ();
    ( Property "overscroll-behavior-block",
      pack_rule property_overscroll_behavior_block ?runtime_module_path:property_overscroll_behavior_block_runtime_module_path () );
    ( Property "overscroll-behavior-inline",
      pack_rule property_overscroll_behavior_inline ?runtime_module_path:property_overscroll_behavior_inline_runtime_module_path () );
    ( Property "overscroll-behavior-x",
      pack_rule property_overscroll_behavior_x ?runtime_module_path:property_overscroll_behavior_x_runtime_module_path () );
    ( Property "overscroll-behavior-y",
      pack_rule property_overscroll_behavior_y ?runtime_module_path:property_overscroll_behavior_y_runtime_module_path () );
    Property "padding", pack_rule property_padding ?runtime_module_path:property_padding_runtime_module_path ();
    Property "padding-block", pack_rule property_padding_block ?runtime_module_path:property_padding_block_runtime_module_path ();
    Property "padding-block-end", pack_rule property_padding_block_end ();
    Property "padding-block-start", pack_rule property_padding_block_start ();
    Property "padding-bottom", pack_rule property_padding_bottom ();
    Property "padding-inline", pack_rule property_padding_inline ?runtime_module_path:property_padding_inline_runtime_module_path ();
    Property "padding-inline-end", pack_rule property_padding_inline_end ();
    ( Property "padding-inline-start",
      pack_rule property_padding_inline_start () );
    Property "padding-left", pack_rule property_padding_left ();
    Property "padding-right", pack_rule property_padding_right ();
    Property "padding-top", pack_rule property_padding_top ();
    Property "page", pack_rule property_page ?runtime_module_path:property_page_runtime_module_path ();
    Property "paint-order", pack_rule property_paint_order ?runtime_module_path:property_paint_order_runtime_module_path ();
    Property "pause", pack_rule property_pause ?runtime_module_path:property_pause_runtime_module_path ();
    Property "pause-after", pack_rule property_pause_after ?runtime_module_path:property_pause_after_runtime_module_path ();
    Property "pause-before", pack_rule property_pause_before ?runtime_module_path:property_pause_before_runtime_module_path ();
    Property "perspective", pack_rule property_perspective ?runtime_module_path:property_perspective_runtime_module_path ();
    Property "place-content", pack_rule property_place_content ?runtime_module_path:property_place_content_runtime_module_path ();
    Property "place-items", pack_rule property_place_items ?runtime_module_path:property_place_items_runtime_module_path ();
    Property "place-self", pack_rule property_place_self ?runtime_module_path:property_place_self_runtime_module_path ();
    Property "position-anchor", pack_rule property_position_anchor ?runtime_module_path:property_position_anchor_runtime_module_path ();
    Property "position-area", pack_rule property_position_area ?runtime_module_path:property_position_area_runtime_module_path ();
    Property "position-try", pack_rule property_position_try ?runtime_module_path:property_position_try_runtime_module_path ();
    ( Property "position-try-fallbacks",
      pack_rule property_position_try_fallbacks ?runtime_module_path:property_position_try_fallbacks_runtime_module_path () );
    ( Property "position-try-options",
      pack_rule property_position_try_options ?runtime_module_path:property_position_try_options_runtime_module_path () );
    Property "position-visibility", pack_rule property_position_visibility ?runtime_module_path:property_position_visibility_runtime_module_path ();
    Property "quotes", pack_rule property_quotes ?runtime_module_path:property_quotes_runtime_module_path ();
    Property "r", pack_rule property_r ();
    Property "reading-flow", pack_rule property_reading_flow ?runtime_module_path:property_reading_flow_runtime_module_path ();
    Property "rest", pack_rule property_rest ?runtime_module_path:property_rest_runtime_module_path ();
    Property "rest-after", pack_rule property_rest_after ?runtime_module_path:property_rest_after_runtime_module_path ();
    Property "rest-before", pack_rule property_rest_before ?runtime_module_path:property_rest_before_runtime_module_path ();
    Property "right", pack_rule property_right ?runtime_module_path:property_right_runtime_module_path ();
    Property "rotate", pack_rule property_rotate ?runtime_module_path:property_rotate_runtime_module_path ();
    Property "ruby-align", pack_rule property_ruby_align ?runtime_module_path:property_ruby_align_runtime_module_path ();
    Property "ruby-overhang", pack_rule property_ruby_overhang ?runtime_module_path:property_ruby_overhang_runtime_module_path ();
    Property "rx", pack_rule property_rx ();
    Property "ry", pack_rule property_ry ();
    Property "scale", pack_rule property_scale ?runtime_module_path:property_scale_runtime_module_path ();
    Property "scroll-margin", pack_rule property_scroll_margin ?runtime_module_path:property_scroll_margin_runtime_module_path ();
    Property "scroll-margin-block", pack_rule property_scroll_margin_block ();
    ( Property "scroll-margin-block-end",
      pack_rule property_scroll_margin_block_end () );
    ( Property "scroll-margin-block-start",
      pack_rule property_scroll_margin_block_start () );
    ( Property "scroll-margin-bottom",
      pack_rule property_scroll_margin_bottom () );
    ( Property "scroll-margin-inline",
      pack_rule property_scroll_margin_inline () );
    ( Property "scroll-margin-inline-end",
      pack_rule property_scroll_margin_inline_end () );
    ( Property "scroll-margin-inline-start",
      pack_rule property_scroll_margin_inline_start () );
    Property "scroll-margin-left", pack_rule property_scroll_margin_left ();
    Property "scroll-margin-right", pack_rule property_scroll_margin_right ();
    Property "scroll-margin-top", pack_rule property_scroll_margin_top ();
    Property "scroll-marker-group", pack_rule property_scroll_marker_group ?runtime_module_path:property_scroll_marker_group_runtime_module_path ();
    Property "scroll-padding", pack_rule property_scroll_padding ?runtime_module_path:property_scroll_padding_runtime_module_path ();
    ( Property "scroll-padding-block",
      pack_rule property_scroll_padding_block () );
    ( Property "scroll-padding-block-end",
      pack_rule property_scroll_padding_block_end () );
    ( Property "scroll-padding-block-start",
      pack_rule property_scroll_padding_block_start () );
    ( Property "scroll-padding-bottom",
      pack_rule property_scroll_padding_bottom () );
    ( Property "scroll-padding-inline",
      pack_rule property_scroll_padding_inline () );
    ( Property "scroll-padding-inline-end",
      pack_rule property_scroll_padding_inline_end () );
    ( Property "scroll-padding-inline-start",
      pack_rule property_scroll_padding_inline_start () );
    Property "scroll-padding-left", pack_rule property_scroll_padding_left ();
    ( Property "scroll-padding-right",
      pack_rule property_scroll_padding_right () );
    Property "scroll-padding-top", pack_rule property_scroll_padding_top ();
    Property "scroll-snap-align", pack_rule property_scroll_snap_align ?runtime_module_path:property_scroll_snap_align_runtime_module_path ();
    ( Property "scroll-snap-coordinate",
      pack_rule property_scroll_snap_coordinate ?runtime_module_path:property_scroll_snap_coordinate_runtime_module_path () );
    ( Property "scroll-snap-destination",
      pack_rule property_scroll_snap_destination ?runtime_module_path:property_scroll_snap_destination_runtime_module_path () );
    ( Property "scroll-snap-points-x",
      pack_rule property_scroll_snap_points_x ?runtime_module_path:property_scroll_snap_points_x_runtime_module_path () );
    ( Property "scroll-snap-points-y",
      pack_rule property_scroll_snap_points_y ?runtime_module_path:property_scroll_snap_points_y_runtime_module_path () );
    Property "scroll-snap-type", pack_rule property_scroll_snap_type ?runtime_module_path:property_scroll_snap_type_runtime_module_path ();
    Property "scroll-snap-type-x", pack_rule property_scroll_snap_type_x ();
    Property "scroll-snap-type-y", pack_rule property_scroll_snap_type_y ();
    Property "scroll-start", pack_rule property_scroll_start ?runtime_module_path:property_scroll_start_runtime_module_path ();
    Property "scroll-start-block", pack_rule property_scroll_start_block ?runtime_module_path:property_scroll_start_block_runtime_module_path ();
    Property "scroll-start-inline", pack_rule property_scroll_start_inline ?runtime_module_path:property_scroll_start_inline_runtime_module_path ();
    Property "scroll-start-target", pack_rule property_scroll_start_target ?runtime_module_path:property_scroll_start_target_runtime_module_path ();
    ( Property "scroll-start-target-block",
      pack_rule property_scroll_start_target_block ?runtime_module_path:property_scroll_start_target_block_runtime_module_path () );
    ( Property "scroll-start-target-inline",
      pack_rule property_scroll_start_target_inline ?runtime_module_path:property_scroll_start_target_inline_runtime_module_path () );
    ( Property "scroll-start-target-x",
      pack_rule property_scroll_start_target_x ?runtime_module_path:property_scroll_start_target_x_runtime_module_path () );
    ( Property "scroll-start-target-y",
      pack_rule property_scroll_start_target_y ?runtime_module_path:property_scroll_start_target_y_runtime_module_path () );
    Property "scroll-start-x", pack_rule property_scroll_start_x ?runtime_module_path:property_scroll_start_x_runtime_module_path ();
    Property "scroll-start-y", pack_rule property_scroll_start_y ?runtime_module_path:property_scroll_start_y_runtime_module_path ();
    Property "scroll-timeline", pack_rule property_scroll_timeline ?runtime_module_path:property_scroll_timeline_runtime_module_path ();
    ( Property "scroll-timeline-axis",
      pack_rule property_scroll_timeline_axis ?runtime_module_path:property_scroll_timeline_axis_runtime_module_path () );
    ( Property "scroll-timeline-name",
      pack_rule property_scroll_timeline_name ?runtime_module_path:property_scroll_timeline_name_runtime_module_path () );
    ( Property "scrollbar-3dlight-color",
      pack_rule property_scrollbar_3dlight_color ?runtime_module_path:property_scrollbar_3dlight_color_runtime_module_path () );
    ( Property "scrollbar-arrow-color",
      pack_rule property_scrollbar_arrow_color ?runtime_module_path:property_scrollbar_arrow_color_runtime_module_path () );
    ( Property "scrollbar-base-color",
      pack_rule property_scrollbar_base_color ?runtime_module_path:property_scrollbar_base_color_runtime_module_path () );
    Property "scrollbar-color", pack_rule property_scrollbar_color ?runtime_module_path:property_scrollbar_color_runtime_module_path ();
    ( Property "scrollbar-color-legacy",
      pack_rule property_scrollbar_color_legacy ?runtime_module_path:property_scrollbar_color_legacy_runtime_module_path () );
    ( Property "scrollbar-darkshadow-color",
      pack_rule property_scrollbar_darkshadow_color ?runtime_module_path:property_scrollbar_darkshadow_color_runtime_module_path () );
    ( Property "scrollbar-face-color",
      pack_rule property_scrollbar_face_color ?runtime_module_path:property_scrollbar_face_color_runtime_module_path () );
    Property "scrollbar-gutter", pack_rule property_scrollbar_gutter ?runtime_module_path:property_scrollbar_gutter_runtime_module_path ();
    ( Property "scrollbar-highlight-color",
      pack_rule property_scrollbar_highlight_color ?runtime_module_path:property_scrollbar_highlight_color_runtime_module_path () );
    ( Property "scrollbar-shadow-color",
      pack_rule property_scrollbar_shadow_color ?runtime_module_path:property_scrollbar_shadow_color_runtime_module_path () );
    ( Property "scrollbar-track-color",
      pack_rule property_scrollbar_track_color ?runtime_module_path:property_scrollbar_track_color_runtime_module_path () );
    ( Property "shape-image-threshold",
      pack_rule property_shape_image_threshold ?runtime_module_path:property_shape_image_threshold_runtime_module_path () );
    Property "shape-margin", pack_rule property_shape_margin ?runtime_module_path:property_shape_margin_runtime_module_path ();
    Property "shape-outside", pack_rule property_shape_outside ?runtime_module_path:property_shape_outside_runtime_module_path ();
    Property "shape-rendering", pack_rule property_shape_rendering ?runtime_module_path:property_shape_rendering_runtime_module_path ();
    Property "size", pack_rule property_size ?runtime_module_path:property_size_runtime_module_path ();
    Property "speak-as", pack_rule property_speak_as ?runtime_module_path:property_speak_as_runtime_module_path ();
    Property "src", pack_rule property_src ?runtime_module_path:property_src_runtime_module_path ();
    Property "stop-color", pack_rule property_stop_color ();
    Property "stop-opacity", pack_rule property_stop_opacity ();
    Property "stroke", pack_rule property_stroke ?runtime_module_path:property_stroke_runtime_module_path ();
    Property "stroke-dasharray", pack_rule property_stroke_dasharray ();
    Property "stroke-dashoffset", pack_rule property_stroke_dashoffset ?runtime_module_path:property_stroke_dashoffset_runtime_module_path ();
    Property "stroke-miterlimit", pack_rule property_stroke_miterlimit ?runtime_module_path:property_stroke_miterlimit_runtime_module_path ();
    Property "stroke-opacity", pack_rule property_stroke_opacity ?runtime_module_path:property_stroke_opacity_runtime_module_path ();
    Property "stroke-width", pack_rule property_stroke_width ?runtime_module_path:property_stroke_width_runtime_module_path ();
    Property "syntax", pack_rule property_syntax ?runtime_module_path:property_syntax_runtime_module_path ();
    Property "tab-size", pack_rule property_tab_size ?runtime_module_path:property_tab_size_runtime_module_path ();
    Property "text-align-all", pack_rule property_text_align_all ?runtime_module_path:property_text_align_all_runtime_module_path ();
    Property "text-anchor", pack_rule property_text_anchor ?runtime_module_path:property_text_anchor_runtime_module_path ();
    Property "text-autospace", pack_rule property_text_autospace ?runtime_module_path:property_text_autospace_runtime_module_path ();
    Property "text-blink", pack_rule property_text_blink ?runtime_module_path:property_text_blink_runtime_module_path ();
    Property "text-box-edge", pack_rule property_text_box_edge ?runtime_module_path:property_text_box_edge_runtime_module_path ();
    Property "text-box-trim", pack_rule property_text_box_trim ?runtime_module_path:property_text_box_trim_runtime_module_path ();
    ( Property "text-combine-upright",
      pack_rule property_text_combine_upright ?runtime_module_path:property_text_combine_upright_runtime_module_path () );
    Property "text-decoration", pack_rule property_text_decoration ?runtime_module_path:property_text_decoration_runtime_module_path ();
    ( Property "text-decoration-color",
      pack_rule property_text_decoration_color () );
    ( Property "text-decoration-skip",
      pack_rule property_text_decoration_skip ?runtime_module_path:property_text_decoration_skip_runtime_module_path () );
    ( Property "text-decoration-skip-box",
      pack_rule property_text_decoration_skip_box ?runtime_module_path:property_text_decoration_skip_box_runtime_module_path () );
    ( Property "text-decoration-skip-inset",
      pack_rule property_text_decoration_skip_inset ?runtime_module_path:property_text_decoration_skip_inset_runtime_module_path () );
    ( Property "text-decoration-skip-self",
      pack_rule property_text_decoration_skip_self ?runtime_module_path:property_text_decoration_skip_self_runtime_module_path () );
    ( Property "text-decoration-skip-spaces",
      pack_rule property_text_decoration_skip_spaces ?runtime_module_path:property_text_decoration_skip_spaces_runtime_module_path () );
    Property "text-edge", pack_rule property_text_edge ?runtime_module_path:property_text_edge_runtime_module_path ();
    Property "text-emphasis", pack_rule property_text_emphasis ?runtime_module_path:property_text_emphasis_runtime_module_path ();
    Property "text-emphasis-color", pack_rule property_text_emphasis_color ();
    ( Property "text-emphasis-position",
      pack_rule property_text_emphasis_position ?runtime_module_path:property_text_emphasis_position_runtime_module_path () );
    Property "text-emphasis-style", pack_rule property_text_emphasis_style ?runtime_module_path:property_text_emphasis_style_runtime_module_path ();
    Property "text-indent", pack_rule property_text_indent ?runtime_module_path:property_text_indent_runtime_module_path ();
    Property "text-justify-trim", pack_rule property_text_justify_trim ?runtime_module_path:property_text_justify_trim_runtime_module_path ();
    Property "text-kashida", pack_rule property_text_kashida ?runtime_module_path:property_text_kashida_runtime_module_path ();
    Property "text-kashida-space", pack_rule property_text_kashida_space ?runtime_module_path:property_text_kashida_space_runtime_module_path ();
    Property "text-overflow", pack_rule property_text_overflow ?runtime_module_path:property_text_overflow_runtime_module_path ();
    Property "text-shadow", pack_rule property_text_shadow ?runtime_module_path:property_text_shadow_runtime_module_path ();
    Property "text-size-adjust", pack_rule property_text_size_adjust ?runtime_module_path:property_text_size_adjust_runtime_module_path ();
    Property "text-spacing-trim", pack_rule property_text_spacing_trim ?runtime_module_path:property_text_spacing_trim_runtime_module_path ();
    ( Property "text-underline-offset",
      pack_rule property_text_underline_offset ?runtime_module_path:property_text_underline_offset_runtime_module_path () );
    Property "text-wrap", pack_rule property_text_wrap ?runtime_module_path:property_text_wrap_runtime_module_path ();
    Property "text-wrap-mode", pack_rule property_text_wrap_mode ?runtime_module_path:property_text_wrap_mode_runtime_module_path ();
    Property "text-wrap-style", pack_rule property_text_wrap_style ?runtime_module_path:property_text_wrap_style_runtime_module_path ();
    Property "timeline-scope", pack_rule property_timeline_scope ?runtime_module_path:property_timeline_scope_runtime_module_path ();
    Property "top", pack_rule property_top ?runtime_module_path:property_top_runtime_module_path ();
    Property "transform", pack_rule property_transform ?runtime_module_path:property_transform_runtime_module_path ();
    Property "transform-origin", pack_rule property_transform_origin ?runtime_module_path:property_transform_origin_runtime_module_path ();
    Property "transition", pack_rule property_transition ?runtime_module_path:property_transition_runtime_module_path ();
    Property "transition-behavior", pack_rule property_transition_behavior ?runtime_module_path:property_transition_behavior_runtime_module_path ();
    Property "transition-delay", pack_rule property_transition_delay ?runtime_module_path:property_transition_delay_runtime_module_path ();
    Property "transition-duration", pack_rule property_transition_duration ?runtime_module_path:property_transition_duration_runtime_module_path ();
    Property "transition-property", pack_rule property_transition_property ();
    ( Property "transition-timing-function",
      pack_rule property_transition_timing_function ?runtime_module_path:property_transition_timing_function_runtime_module_path () );
    Property "translate", pack_rule property_translate ?runtime_module_path:property_translate_runtime_module_path ();
    Property "unicode-range", pack_rule property_unicode_range ?runtime_module_path:property_unicode_range_runtime_module_path ();
    Property "vector-effect", pack_rule property_vector_effect ?runtime_module_path:property_vector_effect_runtime_module_path ();
    Property "vertical-align", pack_rule property_vertical_align ?runtime_module_path:property_vertical_align_runtime_module_path ();
    Property "view-timeline", pack_rule property_view_timeline ?runtime_module_path:property_view_timeline_runtime_module_path ();
    Property "view-timeline-axis", pack_rule property_view_timeline_axis ?runtime_module_path:property_view_timeline_axis_runtime_module_path ();
    Property "view-timeline-inset", pack_rule property_view_timeline_inset ?runtime_module_path:property_view_timeline_inset_runtime_module_path ();
    Property "view-timeline-name", pack_rule property_view_timeline_name ?runtime_module_path:property_view_timeline_name_runtime_module_path ();
    ( Property "view-transition-name",
      pack_rule property_view_transition_name ?runtime_module_path:property_view_transition_name_runtime_module_path () );
    Property "voice-balance", pack_rule property_voice_balance ?runtime_module_path:property_voice_balance_runtime_module_path ();
    Property "voice-duration", pack_rule property_voice_duration ?runtime_module_path:property_voice_duration_runtime_module_path ();
    Property "voice-family", pack_rule property_voice_family ?runtime_module_path:property_voice_family_runtime_module_path ();
    Property "voice-pitch", pack_rule property_voice_pitch ?runtime_module_path:property_voice_pitch_runtime_module_path ();
    Property "voice-range", pack_rule property_voice_range ?runtime_module_path:property_voice_range_runtime_module_path ();
    Property "voice-rate", pack_rule property_voice_rate ?runtime_module_path:property_voice_rate_runtime_module_path ();
    Property "voice-stress", pack_rule property_voice_stress ?runtime_module_path:property_voice_stress_runtime_module_path ();
    Property "voice-volume", pack_rule property_voice_volume ?runtime_module_path:property_voice_volume_runtime_module_path ();
    ( Property "white-space-collapse",
      pack_rule property_white_space_collapse ?runtime_module_path:property_white_space_collapse_runtime_module_path () );
    Property "widows", pack_rule property_widows ?runtime_module_path:property_widows_runtime_module_path ();
    ( Property "word-space-transform",
      pack_rule property_word_space_transform ?runtime_module_path:property_word_space_transform_runtime_module_path () );
    Property "word-spacing", pack_rule property_word_spacing ?runtime_module_path:property_word_spacing_runtime_module_path ();
    Property "x", pack_rule property_x ?runtime_module_path:property_x_runtime_module_path ();
    Property "y", pack_rule property_y ?runtime_module_path:property_y_runtime_module_path ();
    Property "z-index", pack_rule property_z_index ?runtime_module_path:property_z_index_runtime_module_path ();
    Property "zoom", pack_rule property_zoom ?runtime_module_path:property_zoom_runtime_module_path ();
    (* ============================================= *)
    (* Missing Functions - Added via registry scan *)
    (* ============================================= *)
    Function "blur()", pack_rule function_blur ();
    Function "brightness()", pack_rule function_brightness ();
    Function "circle()", pack_rule function_circle ();
    Function "clamp()", pack_rule function_clamp ();
    Function "contrast()", pack_rule function_contrast ();
    Function "counter()", pack_rule function_counter ?runtime_module_path:function_counter_runtime_module_path ();
    Function "counters()", pack_rule function_counters ?runtime_module_path:function_counters_runtime_module_path ();
    Function "drop-shadow()", pack_rule function_drop_shadow ();
    Function "ellipse()", pack_rule function_ellipse ();
    Function "env()", pack_rule function_env ();
    Function "fit-content()", pack_rule function_fit_content ();
    Function "grayscale()", pack_rule function_grayscale ();
    Function "hue-rotate()", pack_rule function_hue_rotate ();
    Function "inset()", pack_rule function_inset ?runtime_module_path:function_inset_runtime_module_path ();
    Function "invert()", pack_rule function_invert ();
    Function "leader()", pack_rule function_leader ();
    Function "minmax()", pack_rule function_minmax ();
    Function "opacity()", pack_rule function_opacity ();
    Function "path()", pack_rule function_path ();
    Function "polygon()", pack_rule function_polygon ();
    Function "saturate()", pack_rule function_saturate ();
    Function "sepia()", pack_rule function_sepia ();
    Function "target-counter()", pack_rule function_target_counter ();
    Function "target-counters()", pack_rule function_target_counters ();
    Function "target-text()", pack_rule function_target_text ();
    (* ============================================= *)
    (* Missing Values - Added via registry scan *)
    (* ============================================= *)
    Value "angular-color-hint", pack_rule angular_color_hint ?runtime_module_path:angular_color_hint_runtime_module_path ();
    Value "angular-color-stop", pack_rule angular_color_stop ?runtime_module_path:angular_color_stop_runtime_module_path ();
    Value "angular-color-stop-list", pack_rule angular_color_stop_list ?runtime_module_path:angular_color_stop_list_runtime_module_path ();
    Value "animateable-feature", pack_rule animateable_feature ?runtime_module_path:animateable_feature_runtime_module_path ();
    Value "attr-fallback", pack_rule attr_fallback ?runtime_module_path:attr_fallback_runtime_module_path ();
    Value "attr-matcher", pack_rule attr_matcher ?runtime_module_path:attr_matcher_runtime_module_path ();
    Value "attr-name", pack_rule attr_name ?runtime_module_path:attr_name_runtime_module_path ();
    Value "attr-type", pack_rule attr_type ?runtime_module_path:attr_type_runtime_module_path ();
    Value "attr-unit", pack_rule attr_unit ?runtime_module_path:attr_unit_runtime_module_path ();
    Value "attribute-selector", pack_rule attribute_selector ?runtime_module_path:attribute_selector_runtime_module_path ();
    Value "bg-layer", pack_rule bg_layer ?runtime_module_path:bg_layer_runtime_module_path ();
    Value "border-radius", pack_rule border_radius ?runtime_module_path:border_radius_runtime_module_path ();
    Value "bottom", pack_rule bottom ?runtime_module_path:bottom_runtime_module_path ();
    Value "cf-final-image", pack_rule cf_final_image ?runtime_module_path:cf_final_image_runtime_module_path ();
    Value "cf-mixing-image", pack_rule cf_mixing_image ?runtime_module_path:cf_mixing_image_runtime_module_path ();
    Value "class-selector", pack_rule class_selector ?runtime_module_path:class_selector_runtime_module_path ();
    Value "clip-source", pack_rule clip_source ?runtime_module_path:clip_source_runtime_module_path ();
    Value "color-stop", pack_rule color_stop ?runtime_module_path:color_stop_runtime_module_path ();
    Value "color-stop-angle", pack_rule color_stop_angle ?runtime_module_path:color_stop_angle_runtime_module_path ();
    Value "color-stop-length", pack_rule color_stop_length ?runtime_module_path:color_stop_length_runtime_module_path ();
    Value "complex-selector", pack_rule complex_selector ?runtime_module_path:complex_selector_runtime_module_path ();
    Value "complex-selector-list", pack_rule complex_selector_list ?runtime_module_path:complex_selector_list_runtime_module_path ();
    Value "compound-selector", pack_rule compound_selector ?runtime_module_path:compound_selector_runtime_module_path ();
    Value "compound-selector-list", pack_rule compound_selector_list ?runtime_module_path:compound_selector_list_runtime_module_path ();
    Value "container-condition-list", pack_rule container_condition_list ?runtime_module_path:container_condition_list_runtime_module_path ();
    Value "counter-name", pack_rule counter_name ?runtime_module_path:counter_name_runtime_module_path ();
    Value "declaration", pack_rule declaration ?runtime_module_path:declaration_runtime_module_path ();
    Value "declaration-list", pack_rule declaration_list ?runtime_module_path:declaration_list_runtime_module_path ();
    Value "display-listitem", pack_rule display_listitem ?runtime_module_path:display_listitem_runtime_module_path ();
    Value "explicit-track-list", pack_rule explicit_track_list ?runtime_module_path:explicit_track_list_runtime_module_path ();
    Value "extended-angle", pack_rule extended_angle ?runtime_module_path:extended_angle_runtime_module_path ();
    Value "extended-frequency", pack_rule extended_frequency ?runtime_module_path:extended_frequency_runtime_module_path ();
    Value "extended-length", pack_rule extended_length ?runtime_module_path:extended_length_runtime_module_path ();
    Value "extended-percentage", pack_rule extended_percentage ?runtime_module_path:extended_percentage_runtime_module_path ();
    Value "extended-time", pack_rule extended_time ?runtime_module_path:extended_time_runtime_module_path ();
    Value "feature-tag-value", pack_rule feature_tag_value ?runtime_module_path:feature_tag_value_runtime_module_path ();
    Value "feature-value-block", pack_rule feature_value_block ?runtime_module_path:feature_value_block_runtime_module_path ();
    Value "feature-value-block-list", pack_rule feature_value_block_list ?runtime_module_path:feature_value_block_list_runtime_module_path ();
    Value "feature-value-declaration", pack_rule feature_value_declaration ?runtime_module_path:feature_value_declaration_runtime_module_path ();
    ( Value "feature-value-declaration-list",
      pack_rule feature_value_declaration_list ?runtime_module_path:feature_value_declaration_list_runtime_module_path () );
    Value "filter-function-list", pack_rule filter_function_list ?runtime_module_path:filter_function_list_runtime_module_path ();
    Value "final-bg-layer", pack_rule final_bg_layer ?runtime_module_path:final_bg_layer_runtime_module_path ();
    Value "font-stretch-absolute", pack_rule font_stretch_absolute ?runtime_module_path:font_stretch_absolute_runtime_module_path ();
    Value "general-enclosed", pack_rule general_enclosed ?runtime_module_path:general_enclosed_runtime_module_path ();
    Value "generic-voice", pack_rule generic_voice ?runtime_module_path:generic_voice_runtime_module_path ();
    Value "hue-interpolation-method", pack_rule hue_interpolation_method ?runtime_module_path:hue_interpolation_method_runtime_module_path ();
    Value "id-selector", pack_rule id_selector ?runtime_module_path:id_selector_runtime_module_path ();
    Value "image-set-option", pack_rule image_set_option ?runtime_module_path:image_set_option_runtime_module_path ();
    Value "image-src", pack_rule image_src ?runtime_module_path:image_src_runtime_module_path ();
    Value "inflexible-breadth", pack_rule inflexible_breadth ?runtime_module_path:inflexible_breadth_runtime_module_path ();
    Value "keyframe-block", pack_rule keyframe_block ?runtime_module_path:keyframe_block_runtime_module_path ();
    Value "keyframe-block-list", pack_rule keyframe_block_list ?runtime_module_path:keyframe_block_list_runtime_module_path ();
    Value "keyframe-selector", pack_rule keyframe_selector ?runtime_module_path:keyframe_selector_runtime_module_path ();
    Value "leader-type", pack_rule leader_type ?runtime_module_path:leader_type_runtime_module_path ();
    Value "left", pack_rule left ?runtime_module_path:left_runtime_module_path ();
    Value "line-name-list", pack_rule line_name_list ?runtime_module_path:line_name_list_runtime_module_path ();
    Value "linear-color-hint", pack_rule linear_color_hint ?runtime_module_path:linear_color_hint_runtime_module_path ();
    Value "linear-color-stop", pack_rule linear_color_stop ?runtime_module_path:linear_color_stop_runtime_module_path ();
    Value "mask-image", pack_rule mask_image ?runtime_module_path:mask_image_runtime_module_path ();
    Value "mask-layer", pack_rule mask_layer ?runtime_module_path:mask_layer_runtime_module_path ();
    Value "mask-position", pack_rule mask_position ?runtime_module_path:mask_position_runtime_module_path ();
    Value "name-repeat", pack_rule name_repeat ?runtime_module_path:name_repeat_runtime_module_path ();
    Value "namespace-prefix", pack_rule namespace_prefix ?runtime_module_path:namespace_prefix_runtime_module_path ();
    Value "ns-prefix", pack_rule ns_prefix ?runtime_module_path:ns_prefix_runtime_module_path ();
    Value "nth", pack_rule nth ?runtime_module_path:nth_runtime_module_path ();
    Value "number-one-or-greater", pack_rule number_one_or_greater ?runtime_module_path:number_one_or_greater_runtime_module_path ();
    Value "number-zero-one", pack_rule number_zero_one ?runtime_module_path:number_zero_one_runtime_module_path ();
    Value "one-bg-size", pack_rule one_bg_size ?runtime_module_path:one_bg_size_runtime_module_path ();
    Value "page-body", pack_rule page_body ?runtime_module_path:page_body_runtime_module_path ();
    Value "page-margin-box", pack_rule page_margin_box ?runtime_module_path:page_margin_box_runtime_module_path ();
    Value "page-selector", pack_rule page_selector ?runtime_module_path:page_selector_runtime_module_path ();
    Value "page-selector-list", pack_rule page_selector_list ?runtime_module_path:page_selector_list_runtime_module_path ();
    Value "paint", pack_rule paint ?runtime_module_path:paint_runtime_module_path ();
    Value "positive-integer", pack_rule positive_integer ?runtime_module_path:positive_integer_runtime_module_path ();
    Value "pseudo-class-selector", pack_rule pseudo_class_selector ?runtime_module_path:pseudo_class_selector_runtime_module_path ();
    Value "pseudo-element-selector", pack_rule pseudo_element_selector ?runtime_module_path:pseudo_element_selector_runtime_module_path ();
    Value "pseudo-page", pack_rule pseudo_page ?runtime_module_path:pseudo_page_runtime_module_path ();
    Value "radial-size", pack_rule radial_size ?runtime_module_path:radial_size_runtime_module_path ();
    Value "ray-size", pack_rule ray_size ?runtime_module_path:ray_size_runtime_module_path ();
    Value "relative-selector", pack_rule relative_selector ?runtime_module_path:relative_selector_runtime_module_path ();
    Value "relative-selector-list", pack_rule relative_selector_list ?runtime_module_path:relative_selector_list_runtime_module_path ();
    Value "right", pack_rule right ?runtime_module_path:right_runtime_module_path ();
    Value "shape", pack_rule shape ?runtime_module_path:shape_runtime_module_path ();
    Value "shape-radius", pack_rule shape_radius ?runtime_module_path:shape_radius_runtime_module_path ();
    Value "single-transition", pack_rule single_transition ?runtime_module_path:single_transition_runtime_module_path ();
    ( Value "single-transition-no-interp",
      pack_rule single_transition_no_interp ?runtime_module_path:single_transition_no_interp_runtime_module_path () );
    ( Value "single-transition-property-no-interp",
      pack_rule single_transition_property_no_interp ?runtime_module_path:single_transition_property_no_interp_runtime_module_path () );
    Value "size", pack_rule size ?runtime_module_path:size_runtime_module_path ();
    Value "subclass-selector", pack_rule subclass_selector ?runtime_module_path:subclass_selector_runtime_module_path ();
    Value "supports-condition", pack_rule supports_condition ?runtime_module_path:supports_condition_runtime_module_path ();
    Value "supports-decl", pack_rule supports_decl ?runtime_module_path:supports_decl_runtime_module_path ();
    Value "supports-feature", pack_rule supports_feature ?runtime_module_path:supports_feature_runtime_module_path ();
    Value "supports-in-parens", pack_rule supports_in_parens ?runtime_module_path:supports_in_parens_runtime_module_path ();
    Value "supports-selector-fn", pack_rule supports_selector_fn ?runtime_module_path:supports_selector_fn_runtime_module_path ();
    Value "svg-writing-mode", pack_rule svg_writing_mode ?runtime_module_path:svg_writing_mode_runtime_module_path ();
    Value "symbol", pack_rule symbol ?runtime_module_path:symbol_runtime_module_path ();
    Value "syntax", pack_rule syntax ?runtime_module_path:syntax_runtime_module_path ();
    Value "syntax-combinator", pack_rule syntax_combinator ?runtime_module_path:syntax_combinator_runtime_module_path ();
    Value "syntax-component", pack_rule syntax_component ?runtime_module_path:syntax_component_runtime_module_path ();
    Value "syntax-multiplier", pack_rule syntax_multiplier ?runtime_module_path:syntax_multiplier_runtime_module_path ();
    Value "syntax-single-component", pack_rule syntax_single_component ?runtime_module_path:syntax_single_component_runtime_module_path ();
    Value "syntax-string", pack_rule syntax_string ?runtime_module_path:syntax_string_runtime_module_path ();
    Value "syntax-type-name", pack_rule syntax_type_name ?runtime_module_path:syntax_type_name_runtime_module_path ();
    Value "target", pack_rule target ?runtime_module_path:target_runtime_module_path ();
    Value "top", pack_rule top ?runtime_module_path:top_runtime_module_path ();
    Value "track-group", pack_rule track_group ?runtime_module_path:track_group_runtime_module_path ();
    Value "track-list-v0", pack_rule track_list_v0 ?runtime_module_path:track_list_v0_runtime_module_path ();
    Value "track-minmax", pack_rule track_minmax ?runtime_module_path:track_minmax_runtime_module_path ();
    Value "transition-behavior-value", pack_rule transition_behavior_value ?runtime_module_path:transition_behavior_value_runtime_module_path ();
    ( Value "transition-behavior-value-no-interp",
      pack_rule transition_behavior_value_no_interp ?runtime_module_path:transition_behavior_value_no_interp_runtime_module_path () );
    Value "try-tactic", pack_rule try_tactic ?runtime_module_path:try_tactic_runtime_module_path ();
    Value "type-or-unit", pack_rule type_or_unit ?runtime_module_path:type_or_unit_runtime_module_path ();
    Value "type-selector", pack_rule type_selector ?runtime_module_path:type_selector_runtime_module_path ();
    Value "viewport-length", pack_rule viewport_length ?runtime_module_path:viewport_length_runtime_module_path ();
    ( Value "webkit-gradient-color-stop",
      pack_rule webkit_gradient_color_stop ?runtime_module_path:webkit_gradient_color_stop_runtime_module_path () );
    Value "webkit-gradient-point", pack_rule webkit_gradient_point ?runtime_module_path:webkit_gradient_point_runtime_module_path ();
    Value "webkit-gradient-radius", pack_rule webkit_gradient_radius ?runtime_module_path:webkit_gradient_radius_runtime_module_path ();
    Value "wq-name", pack_rule wq_name ?runtime_module_path:wq_name_runtime_module_path ();
    Value "x", pack_rule x ?runtime_module_path:x_runtime_module_path ();
    Value "y", pack_rule y ?runtime_module_path:y_runtime_module_path ();
  ]

(* Registry population.
   Properties use prefixed keys to avoid collisions with values.
   Alias properties (like -webkit-box-orient -> Property_box_orient) may not have
   dedicated witnesses; they store None and use Obj.magic directly in lookup. *)
let () =
  List.iter
    (fun (kind, rule) ->
      (* Get the CSS name from the kind *)
      let css_name =
        match kind with
        | Property name -> name
        | Value name -> name
        | Function name -> name
        | Media_query name -> name
      in
      (* Generate the registry key - properties are prefixed to avoid collisions with values *)
      let key =
        match kind with
        | Property _ -> "property_" ^ css_name
        | Value _ | Function _ | Media_query _ -> css_name
      in
      Hashtbl.replace registry_tbl key (kind, rule))
    registry

let is_property_kind = function Property _ -> true | _ -> false
let is_value_kind = function Value _ -> true | _ -> false
let is_function_kind = function Function _ -> true | _ -> false
let is_media_query_kind = function Media_query _ -> true | _ -> false

let find_by_key (key : string) : packed_rule option =
  match Hashtbl.find_opt registry_tbl key with
  | Some (_, rule) -> Some rule
  | None -> None

(* Additional lookup for alias properties: tries unprefixed CSS name if prefixed fails *)
let find_property_with_fallback (name : string) : packed_rule option =
  let key = "property_" ^ name in
  match Hashtbl.find_opt registry_tbl key with
  | Some (_, rule) -> Some rule
  | None -> None

(* Properties use prefixed keys in the registry *)
let find_property (name : string) : packed_rule option =
  find_by_key ("property_" ^ name)

let find_value (name : string) : packed_rule option = find_by_key name
let find_function (name : string) : packed_rule option = find_by_key name
let find_media_query (name : string) : packed_rule option = find_by_key name

let value_names () : string list =
  Hashtbl.fold
    (fun _key (kind, _rule) acc ->
      match kind with Value name -> name :: acc | _ -> acc)
    registry_tbl []

let function_names () : string list =
  Hashtbl.fold
    (fun _key (kind, _rule) acc ->
      match kind with Function name -> name :: acc | _ -> acc)
    registry_tbl []

module Css_tokens = Styled_ppx_css_parser.Tokens
module Css_parser = Styled_ppx_css_parser.Parser
module Css_lexer = Styled_ppx_css_parser.Lexer

let apply_parser (parser, tokens_with_loc) =
  let ( let+ ) = Result.bind in
  let tokens =
    tokens_with_loc
    |> List.map (fun ({ txt; _ } : Css_lexer.token_with_location) ->
      match txt with Ok token -> token | Error (token, _) -> token)
  in

  let tokens_without_ws = tokens |> List.filter (( != ) Css_parser.WS) in

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
    | [] | [ Css_parser.EOF ] -> Ok ()
    | tokens ->
      let tokens =
        tokens |> List.map Css_tokens.show_token |> String.concat ", "
      in
      Error ("tokens remaining: " ^ tokens)
  in
  Ok output

let parse (rule_parser : 'a Rule.rule) input =
  let tokens_with_loc = Styled_ppx_css_parser.Lexer.from_string input in
  apply_parser (rule_parser, tokens_with_loc)

let find_rule (property : string) = find_property property

let check_property ~loc ~name value :
  ( unit,
    Styled_ppx_css_parser.Ast.loc
    * [> `Invalid_value of string | `Property_not_found ] )
  result =
  match find_rule name with
  | Some (PackRule { rule; _ }) ->
    (* First try parsing with the property's specific rule to get accurate error messages *)
    (match parse (Obj.magic rule) value with
    | Ok _ -> Ok ()
    | Error property_error ->
      (* If property rule fails, try universal CSS values:
         - interpolation: $(variable)
         - css-wide keywords: inherit, initial, unset, revert, revert-layer
         - var() function: var(--custom-property)
         Map all to unit since we only care about success/failure here *)
      let universal_rule =
        Combinators.xor
          [
            Rule.Match.map Standard.interpolation (fun _ -> ());
            Rule.Match.map Standard.css_wide_keywords (fun _ -> ());
            Rule.Match.map function_var (fun _ -> ());
          ]
      in
      (match parse universal_rule value with
      | Ok _ -> Ok ()
      (* If universal values also fail, return the property-specific error
         which gives more helpful feedback to the user *)
      | Error _ -> Error (loc, `Invalid_value property_error)))
  | None -> Error (loc, `Property_not_found)

(* Extract interpolation types from a property value.
   Returns a list of (variable_name, type_path) pairs.
   The type_path is the Css_types module path for the interpolation position. *)
let get_interpolation_types ~name value : (string * string) list =
  match find_rule name with
  | Some (PackRule { rule; runtime_module_path; _ }) ->
    (* Wrap with universal support like check_property. When a complete
       interpolation is provided, return its info with the property's runtime path.
       css-wide keywords and var() don't contribute interpolations. *)
    let rule_with_universal =
      Combinators.xor
        [
          Rule.Match.map Standard.interpolation (fun data ->
            `Interpolation data);
          Rule.Match.map Standard.css_wide_keywords (fun data ->
            `CssWideKeyword data);
          Rule.Match.map function_var (fun data -> `Var data);
          Rule.Match.map (Obj.magic rule) (fun _ -> `Value);
        ]
    in
    (match parse rule_with_universal value with
    | Ok (`Interpolation parts) ->
      (* Complete interpolation - use the property's runtime module path *)
      let type_path = Option.value ~default:"" runtime_module_path in
      [ String.concat "." parts, type_path ]
    | Ok (`CssWideKeyword _) ->
      (* CSS-wide keywords don't contribute interpolations *)
      []
    | Ok (`Var _) ->
      (* var() doesn't contribute interpolations *)
      []
    | Ok `Value ->
      (* Regular value - partial interpolations not yet supported with packed_rule *)
      []
    | Error _ -> [])
  | None -> []
