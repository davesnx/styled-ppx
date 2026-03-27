module type RULE = sig
  type t

  val rule : t Rule.rule
  val parse : string -> (t, string) result
  val to_string : t -> string
  val runtime_module_path : string option
  val extract_interpolations : t -> (string * string) list

  val extract_interpolations_with_context :
    string -> t -> (string * string) list
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
  | `Function_hwb of function_hwb
  | `Function_lab of function_lab
  | `Function_lch of function_lch
  | `Function_oklab of function_oklab
  | `Function_oklch of function_oklch
  | `Function_color of function_color
  | `Function_light_dark of function_light_dark
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

and function_hwb =
  hue * extended_percentage * extended_percentage * (unit * alpha_value) option

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

and function_lab =
  extended_percentage * float * float * (unit * alpha_value) option

and function_lch =
  extended_percentage * float * hue * (unit * alpha_value) option

and function_light_dark = color * unit * color

and predefined_color_space =
  [ `Srgb
  | `Srgb_linear
  | `Display_p3
  | `A98_rgb
  | `Prophoto_rgb
  | `Rec2020
  | `Xyz
  | `Xyz_d50
  | `Xyz_d65
  ]

and function_color =
  predefined_color_space
  * number_percentage
  * number_percentage
  * number_percentage
  * (unit * alpha_value) option

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

and function_oklab =
  extended_percentage * float * float * (unit * alpha_value) option

and function_oklch =
  extended_percentage * float * hue * (unit * alpha_value) option

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

and property__ms_overflow_style =
  [ `Auto
  | `None
  | `Scrollbar
  | `Ms_autohiding_scrollbar
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

and property_object_position = position

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

and shadow = unit option * extended_length list * color option
and shadow_t = extended_length list * color option

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

type packed_rule =
  | Pack_rule : {
      rule : 'a Rule.rule;
      validate : string -> (unit, string) result;
      runtime_module_path : string option;
      extract_interpolations : string -> (string * string) list;
      extract_interpolations_from_ast :
        string -> Obj.t -> (string * string) list;
    }
      -> packed_rule

let registry_tbl : (string, kind * packed_rule) Hashtbl.t = Hashtbl.create 1000

let lookup (name : string) : _ Rule.rule =
 fun tokens ->
  match Hashtbl.find_opt registry_tbl name with
  | Some (_, Pack_rule { rule; _ }) -> (Obj.magic rule : _ Rule.rule) tokens
  | None -> failwith ("Rule not found in registry: " ^ name)

let detect_whole_value_interpolation ~runtime_module_path input =
  let interp_rule =
    Rule.Match.map Css_value_types.interpolation (fun data -> data)
  in
  match Rule.parse_string interp_rule input with
  | Ok parts ->
    let type_path = Option.value ~default:"" runtime_module_path in
    [ String.concat "." parts, type_path ]
  | Error _ -> []

let extract_from_registry_ast (type_name : string) (type_context : string)
  (ast_obj : Obj.t) : (string * string) list =
  match Hashtbl.find_opt registry_tbl type_name with
  | Some (_, Pack_rule { extract_interpolations_from_ast; _ }) ->
    extract_interpolations_from_ast type_context ast_obj
  | None -> []

let runtime_module_path_of_registry_key (key : string) : string option =
  match Hashtbl.find_opt registry_tbl key with
  | Some (_, Pack_rule { runtime_module_path; _ }) -> runtime_module_path
  | None -> None

let resolve_runtime_module_path (key : string) ~(fallback : string) : string =
  Option.value ~default:fallback (runtime_module_path_of_registry_key key)

let pack_rule (type a) (rule : a Rule.rule)
  ?(runtime_module_path : string option) () : packed_rule =
  let validate input =
    match Rule.parse_string rule input with
    | Ok _ -> Ok ()
    | Error msg -> Error msg
  in
  let extract_interpolations =
    detect_whole_value_interpolation ~runtime_module_path
  in
  let extract_interpolations_from_ast (_type_context : string) (_obj : Obj.t) :
    (string * string) list =
    []
  in
  Pack_rule
    {
      rule;
      validate;
      runtime_module_path;
      extract_interpolations;
      extract_interpolations_from_ast;
    }

let pack_module (module M : RULE) : packed_rule =
  let validate input =
    match M.parse input with Ok _ -> Ok () | Error msg -> Error msg
  in
  let extract_interpolations input =
    (* First: check for whole-value interpolation (e.g., "$(myWidth)").
       Use the property/module's runtime_module_path for the type.
       This ensures full-value interpolation returns the property type
       (e.g., Css_types.Width) rather than a sub-type (e.g., Css_types.Percentage). *)
    let whole =
      detect_whole_value_interpolation
        ~runtime_module_path:M.runtime_module_path input
    in
    if whole <> [] then whole
    else (
      (* Not a whole-value interpolation - parse and extract.
         Delegation to sub-types via registry handles partial interpolation. *)
      match M.parse input with
      | Ok ast ->
        let result = M.extract_interpolations ast in
        if result <> [] then result else []
      | Error _ -> [])
  in
  let extract_interpolations_from_ast (type_context : string) (obj : Obj.t) :
    (string * string) list =
    M.extract_interpolations_with_context type_context (Obj.obj obj : M.t)
  in
  Pack_rule
    {
      rule = M.rule;
      validate;
      runtime_module_path = M.runtime_module_path;
      extract_interpolations;
      extract_interpolations_from_ast;
    }

module Legacy_linear_gradient_arguments =
  [%spec_module
  "[ <extended-angle> | <side-or-corner> ]? ',' <color-stop-list>"]

let legacy_linear_gradient_arguments :
  legacy_linear_gradient_arguments Rule.rule =
  Legacy_linear_gradient_arguments.rule

module Legacy_radial_gradient_shape =
  [%spec_module
  "'circle' | 'ellipse'", (module Css_types.LegacyRadialGradientShape)]

let legacy_radial_gradient_shape : legacy_radial_gradient_shape Rule.rule =
  Legacy_radial_gradient_shape.rule

module Legacy_radial_gradient_size =
  [%spec_module
  "'closest-side' | 'closest-corner' | 'farthest-side' | 'farthest-corner' | \
   'contain' | 'cover'",
  (module Css_types.LegacyRadialGradientSize)]

let legacy_radial_gradient_size : legacy_radial_gradient_size Rule.rule =
  Legacy_radial_gradient_size.rule

module Legacy_radial_gradient_arguments =
  [%spec_module
  "[ <position> ',' ]? [ [ <legacy-radial-gradient-shape> || \
   <legacy-radial-gradient-size> | [ <extended-length> | <extended-percentage> \
   ]{2} ] ',' ]? <color-stop-list>"]

let legacy_radial_gradient_arguments :
  legacy_radial_gradient_arguments Rule.rule =
  Legacy_radial_gradient_arguments.rule

module Legacy_linear_gradient =
  [%spec_module
  "-moz-linear-gradient( <legacy-linear-gradient-arguments> ) | \
   -webkit-linear-gradient( <legacy-linear-gradient-arguments> ) | \
   -o-linear-gradient( <legacy-linear-gradient-arguments> )",
  (module Css_types.LegacyLinearGradient)]

let legacy_linear_gradient : legacy_linear_gradient Rule.rule =
  Legacy_linear_gradient.rule

module Legacy_radial_gradient =
  [%spec_module
  "-moz-radial-gradient( <legacy-radial-gradient-arguments> ) | \
   -webkit-radial-gradient( <legacy-radial-gradient-arguments> ) | \
   -o-radial-gradient( <legacy-radial-gradient-arguments> )",
  (module Css_types.LegacyRadialGradient)]

let legacy_radial_gradient : legacy_radial_gradient Rule.rule =
  Legacy_radial_gradient.rule

module Legacy_repeating_linear_gradient =
  [%spec_module
  "-moz-repeating-linear-gradient( <legacy-linear-gradient-arguments> ) | \
   -webkit-repeating-linear-gradient( <legacy-linear-gradient-arguments> ) | \
   -o-repeating-linear-gradient( <legacy-linear-gradient-arguments> )"]

let legacy_repeating_linear_gradient :
  legacy_repeating_linear_gradient Rule.rule =
  Legacy_repeating_linear_gradient.rule

module Legacy_repeating_radial_gradient =
  [%spec_module
  "-moz-repeating-radial-gradient( <legacy-radial-gradient-arguments> ) | \
   -webkit-repeating-radial-gradient( <legacy-radial-gradient-arguments> ) | \
   -o-repeating-radial-gradient( <legacy-radial-gradient-arguments> )"]

let legacy_repeating_radial_gradient :
  legacy_repeating_radial_gradient Rule.rule =
  Legacy_repeating_radial_gradient.rule

(* Legacy_gradient depends on all the above, so it must come last *)
module Legacy_gradient =
  [%spec_module
  "<-webkit-gradient()> | <legacy-linear-gradient> | \
   <legacy-repeating-linear-gradient> | <legacy-radial-gradient> | \
   <legacy-repeating-radial-gradient>",
  (module Css_types.LegacyGradient)]

let legacy_gradient : legacy_gradient Rule.rule = Legacy_gradient.rule

module Non_standard_color =
  [%spec_module
  "'-moz-ButtonDefault' | '-moz-ButtonHoverFace' | '-moz-ButtonHoverText' | \
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
   '-webkit-text'",
  (module Css_types.NonStandardColor)]

let non_standard_color : non_standard_color Rule.rule = Non_standard_color.rule

module Non_standard_font =
  [%spec_module
  "'-apple-system-body' | '-apple-system-headline' | \
   '-apple-system-subheadline' | '-apple-system-caption1' | \
   '-apple-system-caption2' | '-apple-system-footnote' | \
   '-apple-system-short-body' | '-apple-system-short-headline' | \
   '-apple-system-short-subheadline' | '-apple-system-short-caption1' | \
   '-apple-system-short-footnote' | '-apple-system-tall-body'",
  (module Css_types.NonStandardFont)]

let non_standard_font : non_standard_font Rule.rule = Non_standard_font.rule

module Non_standard_image_rendering =
  [%spec_module
  "'optimize-contrast' | '-moz-crisp-edges' | '-o-crisp-edges' | \
   '-webkit-optimize-contrast'",
  (module Css_types.NonStandardImageRendering)]

let non_standard_image_rendering : non_standard_image_rendering Rule.rule =
  Non_standard_image_rendering.rule

module Non_standard_overflow =
  [%spec_module
  "'-moz-scrollbars-none' | '-moz-scrollbars-horizontal' | \
   '-moz-scrollbars-vertical' | '-moz-hidden-unscrollable'",
  (module Css_types.NonStandardOverflow)]

let non_standard_overflow : non_standard_overflow Rule.rule =
  Non_standard_overflow.rule

module Non_standard_width =
  [%spec_module
  "'min-intrinsic' | 'intrinsic' | '-moz-min-content' | '-moz-max-content' | \
   '-webkit-min-content' | '-webkit-max-content'",
  (module Css_types.NonStandardWidth)]

let non_standard_width : non_standard_width Rule.rule = Non_standard_width.rule

module Webkit_gradient_color_stop =
  [%spec_module
  "from( <color> ) | color-stop( [ <alpha-value> | <extended-percentage> ] ',' \
   <color> ) | to( <color> )",
  (module Css_types.WebkitGradientColorStop)]

let webkit_gradient_color_stop : webkit_gradient_color_stop Rule.rule =
  Webkit_gradient_color_stop.rule

module Webkit_gradient_point =
  [%spec_module
  "[ 'left' | 'center' | 'right' | <extended-length> | <extended-percentage> ] \
   [ 'top' | 'center' | 'bottom' | <extended-length> | <extended-percentage> ]",
  (module Css_types.WebkitGradientPoint)]

let webkit_gradient_point : webkit_gradient_point Rule.rule =
  Webkit_gradient_point.rule

module Webkit_gradient_radius =
  [%spec_module
  "<extended-length> | <extended-percentage>",
  (module Css_types.WebkitGradientRadius)]

let webkit_gradient_radius : webkit_gradient_radius Rule.rule =
  Webkit_gradient_radius.rule

module Webkit_gradient_type =
  [%spec_module
  "'linear' | 'radial'", (module Css_types.WebkitGradientType)]

let webkit_gradient_type : webkit_gradient_type Rule.rule =
  Webkit_gradient_type.rule

module Webkit_mask_box_repeat =
  [%spec_module
  "'repeat' | 'stretch' | 'round'", (module Css_types.WebkitMaskBoxRepeat)]

let webkit_mask_box_repeat : webkit_mask_box_repeat Rule.rule =
  Webkit_mask_box_repeat.rule

module Webkit_mask_clip_style =
  [%spec_module
  "'border' | 'border-box' | 'padding' | 'padding-box' | 'content' | \
   'content-box' | 'text'",
  (module Css_types.WebkitMaskClipStyle)]

let webkit_mask_clip_style : webkit_mask_clip_style Rule.rule =
  Webkit_mask_clip_style.rule

module Absolute_size =
  [%spec_module
  "'xx-small' | 'x-small' | 'small' | 'medium' | 'large' | 'x-large' | \
   'xx-large' | 'xxx-large'",
  (module Css_types.AbsoluteSize)]

let absolute_size : absolute_size Rule.rule = Absolute_size.rule

module Age = [%spec_module "'child' | 'young' | 'old'", (module Css_types.Age)]

let age : age Rule.rule = Age.rule

module Alpha_value =
  [%spec_module
  "<number> | <extended-percentage>", (module Css_types.AlphaValue)]

let alpha_value : alpha_value Rule.rule = Alpha_value.rule

module Angular_color_hint =
  [%spec_module
  "<extended-angle> | <extended-percentage>",
  (module Css_types.AngularColorHint)]

let angular_color_hint : angular_color_hint Rule.rule = Angular_color_hint.rule

module Angular_color_stop =
  [%spec_module
  "<color> && [ <color-stop-angle> ]?", (module Css_types.AngularColorStop)]

let angular_color_stop : angular_color_stop Rule.rule = Angular_color_stop.rule

module Angular_color_stop_list =
  [%spec_module
  "[ <angular-color-stop> [ ',' <angular-color-hint> ]? ]# ',' \
   <angular-color-stop>",
  (module Css_types.AngularColorStopList)]

let angular_color_stop_list : angular_color_stop_list Rule.rule =
  Angular_color_stop_list.rule

module Animateable_feature =
  [%spec_module
  "'scroll-position' | 'contents' | <custom-ident>",
  (module Css_types.AnimateableFeature)]

let animateable_feature : animateable_feature Rule.rule =
  Animateable_feature.rule

module Attachment =
  [%spec_module
  "'scroll' | 'fixed' | 'local'", (module Css_types.Attachment)]

let attachment : attachment Rule.rule = Attachment.rule

module Attr_fallback =
  [%spec_module
  "<any-value>", (module Css_types.AttrFallback)]

let attr_fallback : attr_fallback Rule.rule = Attr_fallback.rule

module Attr_matcher =
  [%spec_module
  "[ '~' | '|' | '^' | '$' | '*' ]? '='", (module Css_types.AttrMatcher)]

let attr_matcher : attr_matcher Rule.rule = Attr_matcher.rule

module Attr_modifier =
  [%spec_module
  "'i' | 's'", (module Css_types.AttrModifier)]

let attr_modifier : attr_modifier Rule.rule = Attr_modifier.rule

module Attribute_selector =
  [%spec_module
  "'[' <wq-name> ']' | '[' <wq-name> <attr-matcher> [ <string-token> | \
   <ident-token> ] [ <attr-modifier> ]? ']'",
  (module Css_types.AttributeSelector)]

let attribute_selector : attribute_selector Rule.rule = Attribute_selector.rule

module Auto_repeat =
  [%spec_module
  "repeat( [ 'auto-fill' | 'auto-fit' ] ',' [ [ <line-names> ]? <fixed-size> \
   ]+ [ <line-names> ]? )",
  (module Css_types.AutoRepeat)]

let auto_repeat : auto_repeat Rule.rule = Auto_repeat.rule

module Auto_track_list =
  [%spec_module
  "[ [ <line-names> ]? [ <fixed-size> | <fixed-repeat> ] ]* [ <line-names> ]? \
   <auto-repeat> [ [ <line-names> ]? [ <fixed-size> | <fixed-repeat> ] ]* [ \
   <line-names> ]?",
  (module Css_types.AutoTrackList)]

let auto_track_list : auto_track_list Rule.rule = Auto_track_list.rule

module Baseline_position =
  [%spec_module
  "[ 'first' | 'last' ]? 'baseline'", (module Css_types.BaselinePosition)]

let baseline_position : baseline_position Rule.rule = Baseline_position.rule

module Basic_shape =
  [%spec_module
  "<inset()> | <circle()> | <ellipse()> | <polygon()> | <path()>",
  (module Css_types.BasicShape)]

let basic_shape : basic_shape Rule.rule = Basic_shape.rule

module Bg_image = [%spec_module "'none' | <image>", (module Css_types.BgImage)]

let bg_image : bg_image Rule.rule = Bg_image.rule

module Bg_layer =
  [%spec_module
  "<bg-image> || <bg-position> [ '/' <bg-size> ]? || <repeat-style> || \
   <attachment> || <box> || <box>",
  (module Css_types.BgLayer)]

let bg_layer : bg_layer Rule.rule = Bg_layer.rule

module Bg_position =
  [%spec_module
  "[ 'left' | 'center' | 'right' | 'top' | 'bottom' | <length-percentage> ] | \
   [ 'left' | 'center' | 'right' | <length-percentage> ] [ 'top' | 'center' | \
   'bottom' | <length-percentage> ] | [ 'center' | [ 'left' | 'right' ] \
   <length-percentage>? ] && [ 'center' | [ 'top' | 'bottom' ] \
   <length-percentage>? ]",
  (module Css_types.BgPosition)]

let bg_position : bg_position Rule.rule = Bg_position.rule

(* one_bg_size isn't part of the spec, helps us with Type generation *)
module One_bg_size =
  [%spec_module
  "[ <extended-length> | <extended-percentage> | 'auto' ] [ <extended-length> \
   | <extended-percentage> | 'auto' ]?",
  (module Css_types.OneBgSize)]

let one_bg_size : one_bg_size Rule.rule = One_bg_size.rule

module Bg_size =
  [%spec_module
  "<one-bg-size> | 'cover' | 'contain'", (module Css_types.BgSize)]

let bg_size : bg_size Rule.rule = Bg_size.rule

module Blend_mode =
  [%spec_module
  "'normal' | 'multiply' | 'screen' | 'overlay' | 'darken' | 'lighten' | \
   'color-dodge' | 'color-burn' | 'hard-light' | 'soft-light' | 'difference' | \
   'exclusion' | 'hue' | 'saturation' | 'color' | 'luminosity'",
  (module Css_types.BlendMode)]

let blend_mode : blend_mode Rule.rule = Blend_mode.rule

(* border_radius value supports 1-4 values with optional "/" for horizontal/vertical *)
module Border_radius =
  [%spec_module
  "[ <extended-length> | <extended-percentage> ]{1,4} [ '/' [ \
   <extended-length> | <extended-percentage> ]{1,4} ]?",
  (module Css_types.BorderRadius)]

let border_radius : border_radius Rule.rule = Border_radius.rule

module Bottom =
  [%spec_module
  "<extended-length> | 'auto'", (module Css_types.Bottom)]

let bottom : bottom Rule.rule = Bottom.rule

module Box =
  [%spec_module
  "'border-box' | 'padding-box' | 'content-box'", (module Css_types.Box)]

let box : box Rule.rule = Box.rule

module Calc_product =
  [%spec_module
  "<calc-value> [ '*' <calc-value> | '/' <number> ]*",
  (module Css_types.CalcProduct)]

let calc_product : calc_product Rule.rule = Calc_product.rule

module Dimension =
  [%spec_module
  "<extended-length> | <extended-time> | <extended-frequency> | <resolution>",
  (module Css_types.Dimension)]

let dimension : dimension Rule.rule = Dimension.rule

module Calc_sum =
  [%spec_module
  "<calc-product> [ [ '+' | '-' ] <calc-product> ]*", (module Css_types.CalcSum)]

let calc_sum : calc_sum Rule.rule = Calc_sum.rule

module Calc_value =
  [%spec_module
  "<number> | <extended-length> | <extended-percentage> | <extended-angle> | \
   <extended-time> | '(' <calc-sum> ')'",
  (module Css_types.CalcValue)]

let calc_value : calc_value Rule.rule = Calc_value.rule

module Cf_final_image =
  [%spec_module
  "<image> | <color>", (module Css_types.CfFinalImage)]

let cf_final_image : cf_final_image Rule.rule = Cf_final_image.rule

module Cf_mixing_image =
  [%spec_module
  "[ <extended-percentage> ]? && <image>", (module Css_types.CfMixingImage)]

let cf_mixing_image : cf_mixing_image Rule.rule = Cf_mixing_image.rule

module Class_selector =
  [%spec_module
  "'.' <ident-token>", (module Css_types.ClassSelector)]

let class_selector : class_selector Rule.rule = Class_selector.rule

module Clip_source = [%spec_module "<url>", (module Css_types.ClipSource)]

let clip_source : clip_source Rule.rule = Clip_source.rule

module Color =
  [%spec_module
  "<rgb()> | <rgba()> | <hsl()> | <hsla()> | <hwb()> | <lab()> | <lch()> | \
   <oklab()> | <oklch()> | <color()> | <light-dark()> | <hex-color> | \
   <named-color> | 'currentColor' | <deprecated-system-color> | \
   <interpolation> | <var()> | <color-mix()>",
  (module Css_types.Color)]

let color : color Rule.rule = Color.rule

module Color_stop =
  [%spec_module
  "<color-stop-length> | <color-stop-angle>", (module Css_types.ColorStop)]

let color_stop : color_stop Rule.rule = Color_stop.rule

module Color_stop_angle =
  [%spec_module
  "[ <extended-angle> ]{1,2}", (module Css_types.ColorStopAngle)]

let color_stop_angle : color_stop_angle Rule.rule = Color_stop_angle.rule

module Color_stop_length =
  [%spec_module
  "<extended-length> | <extended-percentage>",
  (module Css_types.ColorStopLength)]

let color_stop_length : color_stop_length Rule.rule = Color_stop_length.rule

(* color_stop_list is modified from the original spec, here is a simplified version where it tries to be fully compatible but easier for code-gen:

   The current impl allows values that aren't really supported such as: `linear-gradient(0deg, 10%, blue)` which is invalid, but we allow it for now to make it easier to generate the types. The correct value would require always a color to be in the first position `linear-gradient(0deg, red, 10%, blue);`

   The original spec is `color_stop_list = [%spec_module "[ <linear-color-stop> [ ',' <linear-color-hint> ]? ]# ',' <linear-color-stop>"]`
   *)
module Color_stop_list =
  [%spec_module
  "[ [<color>? <length-percentage>] | [<color> <length-percentage>?] ]#",
  (module Css_types.ColorStopList)]

let color_stop_list : color_stop_list Rule.rule = Color_stop_list.rule

module Hue_interpolation_method =
  [%spec_module
  " [ 'shorter' | 'longer' | 'increasing' | 'decreasing' ] && 'hue' ",
  (module Css_types.HueInterpolationMethod)]

let hue_interpolation_method : hue_interpolation_method Rule.rule =
  Hue_interpolation_method.rule

module Polar_color_space =
  [%spec_module
  " 'hsl' | 'hwb' | 'lch' | 'oklch' ", (module Css_types.PolarColorSpace)]

let polar_color_space : polar_color_space Rule.rule = Polar_color_space.rule

module Rectangular_color_space =
  [%spec_module
  " 'srgb' | 'srgb-linear' | 'display-p3' | 'a98-rgb' | 'prophoto-rgb' | \
   'rec2020' | 'lab' | 'oklab' | 'xyz' | 'xyz-d50' | 'xyz-d65' ",
  (module Css_types.RectangularColorSpace)]

let rectangular_color_space : rectangular_color_space Rule.rule =
  Rectangular_color_space.rule

module Color_interpolation_method =
  [%spec_module
  " 'in' && [<rectangular-color-space> | <polar-color-space> \
   <hue-interpolation-method>?] ",
  (module Css_types.ColorInterpolationMethod)]

let color_interpolation_method : color_interpolation_method Rule.rule =
  Color_interpolation_method.rule

(* TODO: Use <extended-percentage> *)
module Function_color_mix =
  [%spec_module
  "color-mix(<color-interpolation-method> ',' [ <color> && <percentage>? ] ',' \
   [ <color> && <percentage>? ])"]

let function_color_mix : function_color_mix Rule.rule = Function_color_mix.rule

module Combinator =
  [%spec_module
  "'>' | '+' | '~' | '||'", (module Css_types.Combinator)]

let combinator : combinator Rule.rule = Combinator.rule

module Common_lig_values =
  [%spec_module
  "'common-ligatures' | 'no-common-ligatures'",
  (module Css_types.CommonLigValues)]

let common_lig_values : common_lig_values Rule.rule = Common_lig_values.rule

module Compat_auto =
  [%spec_module
  "'searchfield' | 'textarea' | 'push-button' | 'slider-horizontal' | \
   'checkbox' | 'radio' | 'square-button' | 'menulist' | 'listbox' | 'meter' | \
   'progress-bar'",
  (module Css_types.CompatAuto)]

let compat_auto : compat_auto Rule.rule = Compat_auto.rule

module Complex_selector =
  [%spec_module
  "<compound-selector> [ [ <combinator> ]? <compound-selector> ]*",
  (module Css_types.ComplexSelector)]

let complex_selector : complex_selector Rule.rule = Complex_selector.rule

module Complex_selector_list =
  [%spec_module
  "[ <complex-selector> ]#", (module Css_types.ComplexSelectorList)]

let complex_selector_list : complex_selector_list Rule.rule =
  Complex_selector_list.rule

module Composite_style =
  [%spec_module
  "'clear' | 'copy' | 'source-over' | 'source-in' | 'source-out' | \
   'source-atop' | 'destination-over' | 'destination-in' | 'destination-out' | \
   'destination-atop' | 'xor'",
  (module Css_types.CompositeStyle)]

let composite_style : composite_style Rule.rule = Composite_style.rule

module Compositing_operator =
  [%spec_module
  "'add' | 'subtract' | 'intersect' | 'exclude'",
  (module Css_types.CompositingOperator)]

let compositing_operator : compositing_operator Rule.rule =
  Compositing_operator.rule

module Compound_selector =
  [%spec_module
  "[ <type-selector> ]? [ <subclass-selector> ]* [ <pseudo-element-selector> [ \
   <pseudo-class-selector> ]* ]*",
  (module Css_types.CompoundSelector)]

let compound_selector : compound_selector Rule.rule = Compound_selector.rule

module Compound_selector_list =
  [%spec_module
  "[ <compound-selector> ]#", (module Css_types.CompoundSelectorList)]

let compound_selector_list : compound_selector_list Rule.rule =
  Compound_selector_list.rule

module Content_distribution =
  [%spec_module
  "'space-between' | 'space-around' | 'space-evenly' | 'stretch'",
  (module Css_types.ContentDistribution)]

let content_distribution : content_distribution Rule.rule =
  Content_distribution.rule

module Content_list =
  [%spec_module
  "[ <string> | 'contents' | <url> | <quote> | <attr()> | counter( <ident> ',' \
   [ <'list-style-type'> ]? ) ]+",
  (module Css_types.ContentList)]

let content_list : content_list Rule.rule = Content_list.rule

module Content_position =
  [%spec_module
  "'center' | 'start' | 'end' | 'flex-start' | 'flex-end'",
  (module Css_types.ContentPosition)]

let content_position : content_position Rule.rule = Content_position.rule

module Content_replacement =
  [%spec_module
  "<image>", (module Css_types.ContentReplacement)]

let content_replacement : content_replacement Rule.rule =
  Content_replacement.rule

module Contextual_alt_values =
  [%spec_module
  "'contextual' | 'no-contextual'", (module Css_types.ContextualAltValues)]

let contextual_alt_values : contextual_alt_values Rule.rule =
  Contextual_alt_values.rule

module Counter_style =
  [%spec_module
  "<counter-style-name> | <symbols()>", (module Css_types.CounterStyle)]

let counter_style : counter_style Rule.rule = Counter_style.rule

module Counter_style_name =
  [%spec_module
  "<custom-ident>", (module Css_types.CounterStyleName)]

let counter_style_name : counter_style_name Rule.rule = Counter_style_name.rule

module Counter_name =
  [%spec_module
  "<custom-ident>", (module Css_types.CounterName)]

let counter_name : counter_name Rule.rule = Counter_name.rule

module Cubic_bezier_timing_function =
  [%spec_module
  "'ease' | 'ease-in' | 'ease-out' | 'ease-in-out' | cubic-bezier( <number> \
   ',' <number> ',' <number> ',' <number> )",
  (module Css_types.CubicBezierTimingFunction)]

let cubic_bezier_timing_function : cubic_bezier_timing_function Rule.rule =
  Cubic_bezier_timing_function.rule

module Declaration =
  [%spec_module
  "<ident-token> ':' [ <declaration-value> ]? [ '!' 'important' ]?",
  (module Css_types.Declaration)]

let declaration : declaration Rule.rule = Declaration.rule

module Declaration_list =
  [%spec_module
  "[ [ <declaration> ]? ';' ]* [ <declaration> ]?",
  (module Css_types.DeclarationList)]

let declaration_list : declaration_list Rule.rule = Declaration_list.rule

module Deprecated_system_color =
  [%spec_module
  "'ActiveBorder' | 'ActiveCaption' | 'AppWorkspace' | 'Background' | \
   'ButtonFace' | 'ButtonHighlight' | 'ButtonShadow' | 'ButtonText' | \
   'CaptionText' | 'GrayText' | 'Highlight' | 'HighlightText' | \
   'InactiveBorder' | 'InactiveCaption' | 'InactiveCaptionText' | \
   'InfoBackground' | 'InfoText' | 'Menu' | 'MenuText' | 'Scrollbar' | \
   'ThreeDDarkShadow' | 'ThreeDFace' | 'ThreeDHighlight' | 'ThreeDLightShadow' \
   | 'ThreeDShadow' | 'Window' | 'WindowFrame' | 'WindowText'",
  (module Css_types.DeprecatedSystemColor)]

let deprecated_system_color : deprecated_system_color Rule.rule =
  Deprecated_system_color.rule

module Discretionary_lig_values =
  [%spec_module
  "'discretionary-ligatures' | 'no-discretionary-ligatures'",
  (module Css_types.DiscretionaryLigValues)]

let discretionary_lig_values : discretionary_lig_values Rule.rule =
  Discretionary_lig_values.rule

module Display_box =
  [%spec_module
  "'contents' | 'none'", (module Css_types.DisplayBox)]

let display_box : display_box Rule.rule = Display_box.rule

module Display_inside =
  [%spec_module
  "'flow' | 'flow-root' | 'table' | 'flex' | 'grid' | 'ruby'",
  (module Css_types.DisplayInside)]

let display_inside : display_inside Rule.rule = Display_inside.rule

module Display_internal =
  [%spec_module
  "'table-row-group' | 'table-header-group' | 'table-footer-group' | \
   'table-row' | 'table-cell' | 'table-column-group' | 'table-column' | \
   'table-caption' | 'ruby-base' | 'ruby-text' | 'ruby-base-container' | \
   'ruby-text-container'",
  (module Css_types.DisplayInternal)]

let display_internal : display_internal Rule.rule = Display_internal.rule

module Display_legacy =
  [%spec_module
  "'inline-block' | 'inline-list-item' | 'inline-table' | 'inline-flex' | \
   'inline-grid'",
  (module Css_types.DisplayLegacy)]

let display_legacy : display_legacy Rule.rule = Display_legacy.rule

module Display_listitem =
  [%spec_module
  "[ <display-outside> ]? && [ 'flow' | 'flow-root' ]? && 'list-item'",
  (module Css_types.DisplayListitem)]

let display_listitem : display_listitem Rule.rule = Display_listitem.rule

module Display_outside =
  [%spec_module
  "'block' | 'inline' | 'run-in'", (module Css_types.DisplayOutside)]

let display_outside : display_outside Rule.rule = Display_outside.rule

module East_asian_variant_values =
  [%spec_module
  "'jis78' | 'jis83' | 'jis90' | 'jis04' | 'simplified' | 'traditional'",
  (module Css_types.EastAsianVariantValues)]

let east_asian_variant_values : east_asian_variant_values Rule.rule =
  East_asian_variant_values.rule

module East_asian_width_values =
  [%spec_module
  "'full-width' | 'proportional-width'", (module Css_types.EastAsianWidthValues)]

let east_asian_width_values : east_asian_width_values Rule.rule =
  East_asian_width_values.rule

module Ending_shape =
  [%spec_module
  "'circle' | 'ellipse'", (module Css_types.EndingShape)]

let ending_shape : ending_shape Rule.rule = Ending_shape.rule

module Explicit_track_list =
  [%spec_module
  "[ [ <line-names> ]? <track-size> ]+ [ <line-names> ]?",
  (module Css_types.ExplicitTrackList)]

let explicit_track_list : explicit_track_list Rule.rule =
  Explicit_track_list.rule

module Family_name =
  [%spec_module
  "<string> | <custom-ident>", (module Css_types.FamilyName)]

let family_name : family_name Rule.rule = Family_name.rule

module Feature_tag_value =
  [%spec_module
  "<string> [ <integer> | 'on' | 'off' ]?", (module Css_types.FeatureTagValue)]

let feature_tag_value : feature_tag_value Rule.rule = Feature_tag_value.rule

module Feature_type =
  [%spec_module
  "'@stylistic' | '@historical-forms' | '@styleset' | '@character-variant' | \
   '@swash' | '@ornaments' | '@annotation'",
  (module Css_types.FeatureType)]

let feature_type : feature_type Rule.rule = Feature_type.rule

module Feature_value_block =
  [%spec_module
  "<feature-type> '{' <feature-value-declaration-list> '}'",
  (module Css_types.FeatureValueBlock)]

let feature_value_block : feature_value_block Rule.rule =
  Feature_value_block.rule

module Feature_value_block_list =
  [%spec_module
  "[ <feature-value-block> ]+", (module Css_types.FeatureValueBlockList)]

let feature_value_block_list : feature_value_block_list Rule.rule =
  Feature_value_block_list.rule

module Feature_value_declaration =
  [%spec_module
  "<custom-ident> ':' [ <integer> ]+ ';'",
  (module Css_types.FeatureValueDeclaration)]

let feature_value_declaration : feature_value_declaration Rule.rule =
  Feature_value_declaration.rule

module Feature_value_declaration_list =
  [%spec_module
  "<feature-value-declaration>"]

let feature_value_declaration_list : feature_value_declaration_list Rule.rule =
  Feature_value_declaration_list.rule

module Feature_value_name =
  [%spec_module
  "<custom-ident>", (module Css_types.FeatureValueName)]

let feature_value_name : feature_value_name Rule.rule = Feature_value_name.rule

(* <zero> represents the literal value 0, used in contexts like rotate(0) *)
module Zero = [%spec_module "'0'"]

let zero : zero Rule.rule = Zero.rule

module Fill_rule =
  [%spec_module
  "'nonzero' | 'evenodd'", (module Css_types.FillRule)]

let fill_rule : fill_rule Rule.rule = Fill_rule.rule

module Filter_function =
  [%spec_module
  "<blur()> | <brightness()> | <contrast()> | <drop-shadow()> | <grayscale()> \
   | <hue-rotate()> | <invert()> | <opacity()> | <saturate()> | <sepia()>",
  (module Css_types.FilterFunction)]

let filter_function : filter_function Rule.rule = Filter_function.rule

module Filter_function_list =
  [%spec_module
  "[ <filter-function> | <url> ]+", (module Css_types.FilterFunctionList)]

let filter_function_list : filter_function_list Rule.rule =
  Filter_function_list.rule

module Final_bg_layer =
  [%spec_module
  "<'background-color'> || <bg-image> || <bg-position> [ '/' <bg-size> ]? || \
   <repeat-style> || <attachment> || <box> || <box>",
  (module Css_types.FinalBgLayer)]

let final_bg_layer : final_bg_layer Rule.rule = Final_bg_layer.rule

module Line_names =
  [%spec_module
  "'[' <custom-ident>* ']'", (module Css_types.LineNames)]

let line_names : line_names Rule.rule = Line_names.rule

module Fixed_breadth =
  [%spec_module
  "<extended-length> | <extended-percentage>", (module Css_types.FixedBreadth)]

let fixed_breadth : fixed_breadth Rule.rule = Fixed_breadth.rule

module Fixed_repeat =
  [%spec_module
  "repeat( <positive-integer> ',' [ [ <line-names> ]? <fixed-size> ]+ [ \
   <line-names> ]? )",
  (module Css_types.FixedRepeat)]

let fixed_repeat : fixed_repeat Rule.rule = Fixed_repeat.rule

module Fixed_size =
  [%spec_module
  "<fixed-breadth> | minmax( <fixed-breadth> ',' <track-breadth> ) | minmax( \
   <inflexible-breadth> ',' <fixed-breadth> )",
  (module Css_types.FixedSize)]

let fixed_size : fixed_size Rule.rule = Fixed_size.rule

module Font_stretch_absolute =
  [%spec_module
  "'normal' | 'ultra-condensed' | 'extra-condensed' | 'condensed' | \
   'semi-condensed' | 'semi-expanded' | 'expanded' | 'extra-expanded' | \
   'ultra-expanded' | <extended-percentage>",
  (module Css_types.FontStretchAbsolute)]

let font_stretch_absolute : font_stretch_absolute Rule.rule =
  Font_stretch_absolute.rule

module Font_variant_css21 =
  [%spec_module
  "'normal' | 'small-caps'", (module Css_types.FontVariantCss21)]

let font_variant_css21 : font_variant_css21 Rule.rule = Font_variant_css21.rule

module Font_weight_absolute =
  [%spec_module
  "'normal' | 'bold' | <integer>", (module Css_types.FontWeightAbsolute)]

let font_weight_absolute : font_weight_absolute Rule.rule =
  Font_weight_absolute.rule

module Function__webkit_gradient =
  [%spec_module
  "-webkit-gradient( <webkit-gradient-type> ',' <webkit-gradient-point> [ ',' \
   <webkit-gradient-point> | ',' <webkit-gradient-radius> ',' \
   <webkit-gradient-point> ] [ ',' <webkit-gradient-radius> ]? [ ',' \
   <webkit-gradient-color-stop> ]* )"]

let function__webkit_gradient : function__webkit_gradient Rule.rule =
  Function__webkit_gradient.rule

(* We don't support attr() with fallback value (since it's a declaration value) yet, original spec is: "attr(<attr-name> <attr-type>? , <declaration-value>?)" *)
module Function_attr = [%spec_module "attr(<attr-name> <attr-type>?)"]

let function_attr : function_attr Rule.rule = Function_attr.rule

module Function_blur = [%spec_module "blur( <extended-length> )"]

let function_blur : function_blur Rule.rule = Function_blur.rule

module Function_brightness = [%spec_module "brightness( <number-percentage> )"]

let function_brightness : function_brightness Rule.rule =
  Function_brightness.rule

module Function_calc = [%spec_module "calc( <calc-sum> )"]

let function_calc : function_calc Rule.rule = Function_calc.rule

module Function_circle =
  [%spec_module
  "circle( [ <shape-radius> ]? [ 'at' <position> ]? )"]

let function_circle : function_circle Rule.rule = Function_circle.rule

module Function_clamp = [%spec_module "clamp( [ <calc-sum> ]#{3} )"]

let function_clamp : function_clamp Rule.rule = Function_clamp.rule

module Function_conic_gradient =
  [%spec_module
  "conic-gradient( [ 'from' <extended-angle> ]? [ 'at' <position> ]? ',' \
   <angular-color-stop-list> )"]

let function_conic_gradient : function_conic_gradient Rule.rule =
  Function_conic_gradient.rule

module Function_contrast = [%spec_module "contrast( <number-percentage> )"]

let function_contrast : function_contrast Rule.rule = Function_contrast.rule

module Function_counter =
  [%spec_module
  "counter( <counter-name> , <counter-style>? )", (module Css_types.Counter)]

let function_counter : function_counter Rule.rule = Function_counter.rule

module Function_counters =
  [%spec_module
  "counters( <custom-ident> ',' <string> ',' [ <counter-style> ]? )",
  (module Css_types.Counters)]

let function_counters : function_counters Rule.rule = Function_counters.rule

module Function_cross_fade =
  [%spec_module
  "cross-fade( <cf-mixing-image> ',' [ <cf-final-image> ]? )"]

let function_cross_fade : function_cross_fade Rule.rule =
  Function_cross_fade.rule

(* drop-shadow can have 2 length module order doesn't matter, we changed to be more restrict module always expect 3 *)
module Function_drop_shadow =
  [%spec_module
  "drop-shadow(<extended-length> <extended-length> <extended-length> [ <color> \
   ]?)"]

let function_drop_shadow : function_drop_shadow Rule.rule =
  Function_drop_shadow.rule

module Function_element = [%spec_module "element( <id-selector> )"]

let function_element : function_element Rule.rule = Function_element.rule

module Function_ellipse =
  [%spec_module
  "ellipse( [ [ <shape-radius> ]{2} ]? [ 'at' <position> ]? )"]

let function_ellipse : function_ellipse Rule.rule = Function_ellipse.rule

module Function_env =
  [%spec_module
  "env( <custom-ident> ',' [ <declaration-value> ]? )"]

let function_env : function_env Rule.rule = Function_env.rule

module Function_fit_content =
  [%spec_module
  "fit-content( <extended-length> | <extended-percentage> )"]

let function_fit_content : function_fit_content Rule.rule =
  Function_fit_content.rule

module Function_grayscale = [%spec_module "grayscale( <number-percentage> )"]

let function_grayscale : function_grayscale Rule.rule = Function_grayscale.rule

module Function_hsl =
  [%spec_module
  " hsl( <hue> <extended-percentage> <extended-percentage> [ '/' <alpha-value> \
   ]? ) | hsl( <hue> ',' <extended-percentage> ',' <extended-percentage> [ ',' \
   <alpha-value> ]? )"]

let function_hsl : function_hsl Rule.rule = Function_hsl.rule

module Function_hsla =
  [%spec_module
  " hsla( <hue> <extended-percentage> <extended-percentage> [ '/' \
   <alpha-value> ]? ) | hsla( <hue> ',' <extended-percentage> ',' \
   <extended-percentage> ',' [ <alpha-value> ]? )"]

let function_hsla : function_hsla Rule.rule = Function_hsla.rule

module Function_hwb =
  [%spec_module
  "hwb( <hue> <extended-percentage> <extended-percentage> [ '/' <alpha-value> \
   ]? )"]

let function_hwb : function_hwb Rule.rule = Function_hwb.rule

module Function_hue_rotate = [%spec_module "hue-rotate( <extended-angle> )"]

let function_hue_rotate : function_hue_rotate Rule.rule =
  Function_hue_rotate.rule

module Function_image =
  [%spec_module
  "image( [ <image-tags> ]? [ <image-src> ]? ',' [ <color> ]? )",
  (module Css_types.Image)]

let function_image : function_image Rule.rule = Function_image.rule

module Function_image_set =
  [%spec_module
  "image-set( [ <image-set-option> ]# )"]

let function_image_set : function_image_set Rule.rule = Function_image_set.rule

module Function_inset =
  [%spec_module
  "inset( [ <extended-length> | <extended-percentage> ]{1,4} [ 'round' \
   <'border-radius'> ]? )",
  (module Css_types.Inset)]

let function_inset : function_inset Rule.rule = Function_inset.rule

module Function_invert = [%spec_module "invert( <number-percentage> )"]

let function_invert : function_invert Rule.rule = Function_invert.rule

module Function_leader = [%spec_module "leader( <leader-type> )"]

let function_leader : function_leader Rule.rule = Function_leader.rule

module Function_lab =
  [%spec_module
  "lab( <extended-percentage> <number> <number> [ '/' <alpha-value> ]? )"]

let function_lab : function_lab Rule.rule = Function_lab.rule

module Function_lch =
  [%spec_module
  "lch( <extended-percentage> <number> <hue> [ '/' <alpha-value> ]? )"]

let function_lch : function_lch Rule.rule = Function_lch.rule

module Function_light_dark = [%spec_module "light-dark( <color> ',' <color> )"]

let function_light_dark : function_light_dark Rule.rule =
  Function_light_dark.rule

module Predefined_color_space =
  [%spec_module
  " 'srgb' | 'srgb-linear' | 'display-p3' | 'a98-rgb' | 'prophoto-rgb' | \
   'rec2020' | 'xyz' | 'xyz-d50' | 'xyz-d65' "]

let predefined_color_space : predefined_color_space Rule.rule =
  Predefined_color_space.rule

module Function_color =
  [%spec_module
  "color( <predefined-color-space> <number-percentage> <number-percentage> \
   <number-percentage> [ '/' <alpha-value> ]? )"]

let function_color : function_color Rule.rule = Function_color.rule

module Function_linear_gradient =
  [%spec_module
  "linear-gradient( [ [<extended-angle> ','] | ['to' <side-or-corner> ','] ]? \
   <color-stop-list> )"]

let function_linear_gradient : function_linear_gradient Rule.rule =
  Function_linear_gradient.rule

module Function_matrix = [%spec_module "matrix( [ <number> ]#{6} )"]

let function_matrix : function_matrix Rule.rule = Function_matrix.rule

module Function_matrix3d = [%spec_module "matrix3d( [ <number> ]#{16} )"]

let function_matrix3d : function_matrix3d Rule.rule = Function_matrix3d.rule

module Function_max = [%spec_module "max( [ <calc-sum> ]# )"]

let function_max : function_max Rule.rule = Function_max.rule

module Function_min = [%spec_module "min( [ <calc-sum> ]# )"]

let function_min : function_min Rule.rule = Function_min.rule

module Function_minmax =
  [%spec_module
  "minmax( [ <extended-length> | <extended-percentage> | 'min-content' | \
   'max-content' | 'auto' ] ',' [ <extended-length> | <extended-percentage> | \
   <flex-value> | 'min-content' | 'max-content' | 'auto' ] )"]

let function_minmax : function_minmax Rule.rule = Function_minmax.rule

module Function_oklab =
  [%spec_module
  "oklab( <extended-percentage> <number> <number> [ '/' <alpha-value> ]? )"]

let function_oklab : function_oklab Rule.rule = Function_oklab.rule

module Function_oklch =
  [%spec_module
  "oklch( <extended-percentage> <number> <hue> [ '/' <alpha-value> ]? )"]

let function_oklch : function_oklch Rule.rule = Function_oklch.rule

module Function_opacity = [%spec_module "opacity( <number-percentage> )"]

let function_opacity : function_opacity Rule.rule = Function_opacity.rule

module Function_paint =
  [%spec_module
  "paint( <ident> ',' [ <declaration-value> ]? )", (module Css_types.Paint)]

let function_paint : function_paint Rule.rule = Function_paint.rule

module Function_path = [%spec_module "path( <string> )"]

let function_path : function_path Rule.rule = Function_path.rule

module Function_perspective =
  [%spec_module
  "perspective( <'perspective'> )", (module Css_types.Perspective)]

let function_perspective : function_perspective Rule.rule =
  Function_perspective.rule

module Function_polygon =
  [%spec_module
  "polygon( [ <fill-rule> ',' ]? [ <length-percentage> <length-percentage> ]# )"]

let function_polygon : function_polygon Rule.rule = Function_polygon.rule

module Function_radial_gradient =
  [%spec_module
  "radial-gradient( <ending-shape>? <radial-size>? ['at' <position> ]? ','? \
   <color-stop-list> )"]

let function_radial_gradient : function_radial_gradient Rule.rule =
  Function_radial_gradient.rule

module Function_repeating_linear_gradient =
  [%spec_module
  "repeating-linear-gradient( [ <extended-angle> | 'to' <side-or-corner> ]? \
   ',' <color-stop-list> )"]

let function_repeating_linear_gradient :
  function_repeating_linear_gradient Rule.rule =
  Function_repeating_linear_gradient.rule

module Function_repeating_radial_gradient =
  [%spec_module
  "repeating-radial-gradient( [ <ending-shape> || <size> ]? [ 'at' <position> \
   ]? ',' <color-stop-list> )"]

let function_repeating_radial_gradient :
  function_repeating_radial_gradient Rule.rule =
  Function_repeating_radial_gradient.rule

module Function_rgb =
  [%spec_module
  "rgb( [ <extended-percentage> ]{3} [ '/' <alpha-value> ]? ) | rgb( [ \
   <number> ]{3} [ '/' <alpha-value> ]? ) | rgb( [ <extended-percentage> ]#{3} \
   [ ',' <alpha-value> ]? ) | rgb( [ <number> ]#{3} [ ',' <alpha-value> ]? )"]

let function_rgb : function_rgb Rule.rule = Function_rgb.rule

module Function_rgba =
  [%spec_module
  "rgba( [ <extended-percentage> ]{3} [ '/' <alpha-value> ]? ) | rgba( [ \
   <number> ]{3} [ '/' <alpha-value> ]? ) | rgba( [ <extended-percentage> \
   ]#{3} [ ',' <alpha-value> ]? ) | rgba( [ <number> ]#{3} [ ',' <alpha-value> \
   ]? )"]

let function_rgba : function_rgba Rule.rule = Function_rgba.rule

module Function_rotate =
  [%spec_module
  "rotate( <extended-angle> | <zero> )", (module Css_types.Rotate)]

let function_rotate : function_rotate Rule.rule = Function_rotate.rule

module Function_rotate3d =
  [%spec_module
  "rotate3d( <number> ',' <number> ',' <number> ',' [ <extended-angle> | \
   <zero> ] )"]

let function_rotate3d : function_rotate3d Rule.rule = Function_rotate3d.rule

module Function_rotateX = [%spec_module "rotateX( <extended-angle> | <zero> )"]

let function_rotateX : function_rotateX Rule.rule = Function_rotateX.rule

module Function_rotateY = [%spec_module "rotateY( <extended-angle> | <zero> )"]

let function_rotateY : function_rotateY Rule.rule = Function_rotateY.rule

module Function_rotateZ = [%spec_module "rotateZ( <extended-angle> | <zero> )"]

let function_rotateZ : function_rotateZ Rule.rule = Function_rotateZ.rule

module Function_saturate = [%spec_module "saturate( <number-percentage> )"]

let function_saturate : function_saturate Rule.rule = Function_saturate.rule

module Function_scale =
  [%spec_module
  "scale( <number> [',' [ <number> ]]? )", (module Css_types.Scale)]

let function_scale : function_scale Rule.rule = Function_scale.rule

module Function_scale3d =
  [%spec_module
  "scale3d( <number> ',' <number> ',' <number> )"]

let function_scale3d : function_scale3d Rule.rule = Function_scale3d.rule

module Function_scaleX = [%spec_module "scaleX( <number> )"]

let function_scaleX : function_scaleX Rule.rule = Function_scaleX.rule

module Function_scaleY = [%spec_module "scaleY( <number> )"]

let function_scaleY : function_scaleY Rule.rule = Function_scaleY.rule

module Function_scaleZ = [%spec_module "scaleZ( <number> )"]

let function_scaleZ : function_scaleZ Rule.rule = Function_scaleZ.rule

module Function_sepia = [%spec_module "sepia( <number-percentage> )"]

let function_sepia : function_sepia Rule.rule = Function_sepia.rule

module Function_skew =
  [%spec_module
  "skew( [ <extended-angle> | <zero> ] [',' [ <extended-angle> | <zero> ]]? )"]

let function_skew : function_skew Rule.rule = Function_skew.rule

module Function_skewX = [%spec_module "skewX( <extended-angle> | <zero> )"]

let function_skewX : function_skewX Rule.rule = Function_skewX.rule

module Function_skewY = [%spec_module "skewY( <extended-angle> | <zero> )"]

let function_skewY : function_skewY Rule.rule = Function_skewY.rule

module Function_symbols =
  [%spec_module
  "symbols( [ <symbols-type> ]? [ <string> | <image> ]+ )",
  (module Css_types.Symbols)]

let function_symbols : function_symbols Rule.rule = Function_symbols.rule

module Function_target_counter =
  [%spec_module
  "target-counter( [ <string> | <url> ] ',' <custom-ident> ',' [ \
   <counter-style> ]? )"]

let function_target_counter : function_target_counter Rule.rule =
  Function_target_counter.rule

module Function_target_counters =
  [%spec_module
  "target-counters( [ <string> | <url> ] ',' <custom-ident> ',' <string> ',' [ \
   <counter-style> ]? )"]

let function_target_counters : function_target_counters Rule.rule =
  Function_target_counters.rule

module Function_target_text =
  [%spec_module
  "target-text( [ <string> | <url> ] ',' [ 'content' | 'before' | 'after' | \
   'first-letter' ]? )"]

let function_target_text : function_target_text Rule.rule =
  Function_target_text.rule

module Function_translate =
  [%spec_module
  "translate( [<extended-length> | <extended-percentage>] [',' [ \
   <extended-length> | <extended-percentage> ]]? )",
  (module Css_types.Translate)]

let function_translate : function_translate Rule.rule = Function_translate.rule

module Function_translate3d =
  [%spec_module
  "translate3d( [<extended-length> | <extended-percentage>] ',' \
   [<extended-length> | <extended-percentage>] ',' <extended-length> )"]

let function_translate3d : function_translate3d Rule.rule =
  Function_translate3d.rule

module Function_translateX =
  [%spec_module
  "translateX( [<extended-length> | <extended-percentage>] )"]

let function_translateX : function_translateX Rule.rule =
  Function_translateX.rule

module Function_translateY =
  [%spec_module
  "translateY( [<extended-length> | <extended-percentage>] )"]

let function_translateY : function_translateY Rule.rule =
  Function_translateY.rule

module Function_translateZ = [%spec_module "translateZ( <extended-length> )"]

let function_translateZ : function_translateZ Rule.rule =
  Function_translateZ.rule

module Function_var = [%spec_module "var( <ident> )", (module Css_types.Var)]

let function_var : function_var Rule.rule = Function_var.rule

module Gender =
  [%spec_module
  "'male' | 'female' | 'neutral'", (module Css_types.Gender)]

let gender : gender Rule.rule = Gender.rule

module General_enclosed =
  [%spec_module
  "<function-token> <any-value> ')' | '(' <ident> <any-value> ')'",
  (module Css_types.GeneralEnclosed)]

let general_enclosed : general_enclosed Rule.rule = General_enclosed.rule

module Generic_family =
  [%spec_module
  "'serif' | 'sans-serif' | 'cursive' | 'fantasy' | 'monospace' | \
   '-apple-system'",
  (module Css_types.GenericFamily)]

let generic_family : generic_family Rule.rule = Generic_family.rule

module Generic_name =
  [%spec_module
  "'serif' | 'sans-serif' | 'cursive' | 'fantasy' | 'monospace'",
  (module Css_types.GenericName)]

let generic_name : generic_name Rule.rule = Generic_name.rule

module Generic_voice =
  [%spec_module
  "[ <age> ]? <gender> [ <integer> ]?", (module Css_types.GenericVoice)]

let generic_voice : generic_voice Rule.rule = Generic_voice.rule

module Geometry_box =
  [%spec_module
  "<shape-box> | 'fill-box' | 'stroke-box' | 'view-box'",
  (module Css_types.GeometryBox)]

let geometry_box : geometry_box Rule.rule = Geometry_box.rule

module Gradient =
  [%spec_module
  "<linear-gradient()> | <repeating-linear-gradient()> | <radial-gradient()> | \
   <repeating-radial-gradient()> | <conic-gradient()> | <legacy-gradient>",
  (module Css_types.Gradient)]

let gradient : gradient Rule.rule = Gradient.rule

module Grid_line =
  [%spec_module
  "<custom-ident-without-span-or-auto> | <integer> && [ \
   <custom-ident-without-span-or-auto> ]? | 'span' && [ <integer> || \
   <custom-ident-without-span-or-auto> ] | 'auto' | <interpolation>",
  (module Css_types.GridLine)]

let grid_line : grid_line Rule.rule = Grid_line.rule

module Historical_lig_values =
  [%spec_module
  "'historical-ligatures' | 'no-historical-ligatures'",
  (module Css_types.HistoricalLigValues)]

let historical_lig_values : historical_lig_values Rule.rule =
  Historical_lig_values.rule

module Hue =
  [%spec_module
  "<number> | <extended-angle>", (module Css_types.Hue)]

let hue : hue Rule.rule = Hue.rule

module Id_selector =
  [%spec_module
  "<hash-token>", (module Css_types.IdSelector)]

let id_selector : id_selector Rule.rule = Id_selector.rule

module Image =
  [%spec_module
  "<url> | <image()> | <image-set()> | <element()> | <paint()> | \
   <cross-fade()> | <gradient> | <interpolation>",
  (module Css_types.Image)]

let image : image Rule.rule = Image.rule

module Image_set_option =
  [%spec_module
  "[ <image> | <string> ] <resolution>", (module Css_types.ImageSetOption)]

let image_set_option : image_set_option Rule.rule = Image_set_option.rule

module Image_src =
  [%spec_module
  "<url> | <string>", (module Css_types.ImageSrc)]

let image_src : image_src Rule.rule = Image_src.rule

module Image_tags = [%spec_module "'ltr' | 'rtl'", (module Css_types.ImageTags)]

let image_tags : image_tags Rule.rule = Image_tags.rule

module Inflexible_breadth =
  [%spec_module
  "<extended-length> | <extended-percentage> | 'min-content' | 'max-content' | \
   'auto'",
  (module Css_types.InflexibleBreadth)]

let inflexible_breadth : inflexible_breadth Rule.rule = Inflexible_breadth.rule

module Keyframe_block =
  [%spec_module
  "[ <keyframe-selector> ]# '{' <declaration-list> '}'",
  (module Css_types.KeyframeBlock)]

let keyframe_block : keyframe_block Rule.rule = Keyframe_block.rule

module Keyframe_block_list =
  [%spec_module
  "[ <keyframe-block> ]+", (module Css_types.KeyframeBlockList)]

let keyframe_block_list : keyframe_block_list Rule.rule =
  Keyframe_block_list.rule

module Keyframe_selector =
  [%spec_module
  "'from' | 'to' | <extended-percentage>", (module Css_types.KeyframeSelector)]

let keyframe_selector : keyframe_selector Rule.rule = Keyframe_selector.rule

module Keyframes_name =
  [%spec_module
  "<custom-ident> | <string>", (module Css_types.KeyframesName)]

let keyframes_name : keyframes_name Rule.rule = Keyframes_name.rule

module Leader_type =
  [%spec_module
  "'dotted' | 'solid' | 'space' | <string>", (module Css_types.LeaderType)]

let leader_type : leader_type Rule.rule = Leader_type.rule

module Left =
  [%spec_module
  "<extended-length> | 'auto'", (module Css_types.Left)]

let left : left Rule.rule = Left.rule

module Line_name_list =
  [%spec_module
  "[ <line-names> | <name-repeat> ]+", (module Css_types.LineNameList)]

let line_name_list : line_name_list Rule.rule = Line_name_list.rule

module Line_style =
  [%spec_module
  "'none' | 'hidden' | 'dotted' | 'dashed' | 'solid' | 'double' | 'groove' | \
   'ridge' | 'inset' | 'outset'",
  (module Css_types.LineStyle)]

let line_style : line_style Rule.rule = Line_style.rule

module Line_width =
  [%spec_module
  "<extended-length> | 'thin' | 'medium' | 'thick'",
  (module Css_types.LineWidth)]

let line_width : line_width Rule.rule = Line_width.rule

module Linear_color_hint =
  [%spec_module
  "<extended-length> | <extended-percentage>",
  (module Css_types.LinearColorHint)]

let linear_color_hint : linear_color_hint Rule.rule = Linear_color_hint.rule

module Linear_color_stop =
  [%spec_module
  "<color> <length-percentage>?", (module Css_types.LinearColorStop)]

let linear_color_stop : linear_color_stop Rule.rule = Linear_color_stop.rule

module Mask_image =
  [%spec_module
  "[ <mask-reference> ]#", (module Css_types.MaskImage)]

let mask_image : mask_image Rule.rule = Mask_image.rule

module Mask_layer =
  [%spec_module
  "<mask-reference> || <position> [ '/' <bg-size> ]? || <repeat-style> || \
   <geometry-box> || [ <geometry-box> | 'no-clip' ] || <compositing-operator> \
   || <masking-mode>",
  (module Css_types.MaskLayer)]

let mask_layer : mask_layer Rule.rule = Mask_layer.rule

module Mask_position =
  [%spec_module
  "[ <extended-length> | <extended-percentage> | 'left' | 'center' | 'right' ] \
   [ <extended-length> | <extended-percentage> | 'top' | 'center' | 'bottom' \
   ]?",
  (module Css_types.MaskPosition)]

let mask_position : mask_position Rule.rule = Mask_position.rule

module Mask_reference =
  [%spec_module
  "'none' | <image> | <mask-source>", (module Css_types.MaskReference)]

let mask_reference : mask_reference Rule.rule = Mask_reference.rule

module Mask_source = [%spec_module "<url>", (module Css_types.MaskSource)]

let mask_source : mask_source Rule.rule = Mask_source.rule

module Masking_mode =
  [%spec_module
  "'alpha' | 'luminance' | 'match-source'", (module Css_types.MaskingMode)]

let masking_mode : masking_mode Rule.rule = Masking_mode.rule

module Mf_comparison =
  [%spec_module
  "<mf-lt> | <mf-gt> | <mf-eq>", (module Css_types.MfComparison)]

let mf_comparison : mf_comparison Rule.rule = Mf_comparison.rule

module Mf_eq = [%spec_module "'='", (module Css_types.MfEq)]

let mf_eq : mf_eq Rule.rule = Mf_eq.rule

module Mf_gt = [%spec_module "'>=' | '>'", (module Css_types.MfGt)]

let mf_gt : mf_gt Rule.rule = Mf_gt.rule

module Mf_lt = [%spec_module "'<=' | '<'", (module Css_types.MfLt)]

let mf_lt : mf_lt Rule.rule = Mf_lt.rule

module Mf_value =
  [%spec_module
  "<number> | <dimension> | <ident> | <ratio> | <interpolation> | <calc()>",
  (module Css_types.MfValue)]

let mf_value : mf_value Rule.rule = Mf_value.rule

module Mf_name = [%spec_module "<ident>", (module Css_types.MfName)]

let mf_name : mf_name Rule.rule = Mf_name.rule

module Mf_range =
  [%spec_module
  "<mf-name> <mf-comparison> <mf-value> | <mf-value> <mf-comparison> <mf-name> \
   | <mf-value> <mf-lt> <mf-name> <mf-lt> <mf-value> | <mf-value> <mf-gt> \
   <mf-name> <mf-gt> <mf-value>",
  (module Css_types.MfRange)]

let mf_range : mf_range Rule.rule = Mf_range.rule

module Mf_boolean = [%spec_module "<mf-name>", (module Css_types.MfBoolean)]

let mf_boolean : mf_boolean Rule.rule = Mf_boolean.rule

module Mf_plain =
  [%spec_module
  "<mf-name> ':' <mf-value>", (module Css_types.MfPlain)]

let mf_plain : mf_plain Rule.rule = Mf_plain.rule

module Media_feature =
  [%spec_module
  "'(' [ <mf-plain> | <mf-boolean> | <mf-range> ] ')'",
  (module Css_types.MediaFeature)]

let media_feature : media_feature Rule.rule = Media_feature.rule

module Media_in_parens =
  [%spec_module
  "<media-feature> | '(' <media-condition> ')' | <interpolation>",
  (module Css_types.MediaInParens)]

let media_in_parens : media_in_parens Rule.rule = Media_in_parens.rule

module Media_and =
  [%spec_module
  "'and' <media-in-parens>", (module Css_types.MediaAnd)]

let media_and : media_and Rule.rule = Media_and.rule

module Media_or =
  [%spec_module
  "'or' <media-in-parens>", (module Css_types.MediaOr)]

let media_or : media_or Rule.rule = Media_or.rule

module Media_not =
  [%spec_module
  "'not' <media-in-parens>", (module Css_types.MediaNot)]

let media_not : media_not Rule.rule = Media_not.rule

module Media_condition_without_or =
  [%spec_module
  "<media-not> | <media-in-parens> <media-and>*",
  (module Css_types.MediaConditionWithoutOr)]

let media_condition_without_or : media_condition_without_or Rule.rule =
  Media_condition_without_or.rule

module Media_condition =
  [%spec_module
  "<media-not> | <media-in-parens> [ <media-and>* | <media-or>* ]",
  (module Css_types.MediaCondition)]

let media_condition : media_condition Rule.rule = Media_condition.rule

module Media_query =
  [%spec_module
  "<media-condition> | [ 'not' | 'only' ]? <media-type> [ 'and' \
   <media-condition-without-or> ]?",
  (module Css_types.MediaQuery)]

let media_query : media_query Rule.rule = Media_query.rule

module Media_query_list =
  [%spec_module
  "[ <media-query> ]# | <interpolation>", (module Css_types.MediaQueryList)]

let media_query_list : media_query_list Rule.rule = Media_query_list.rule

module Container_condition_list =
  [%spec_module
  "<container-condition>#", (module Css_types.ContainerConditionList)]

let container_condition_list : container_condition_list Rule.rule =
  Container_condition_list.rule

module Container_condition =
  [%spec_module
  "[ <container-name> ]? <container-query>",
  (module Css_types.ContainerCondition)]

let container_condition : container_condition Rule.rule =
  Container_condition.rule

module Container_query =
  [%spec_module
  "'not' <query-in-parens> | <query-in-parens> [ [ 'and' <query-in-parens> ]* \
   | [ 'or' <query-in-parens> ]* ]",
  (module Css_types.ContainerQuery)]

let container_query : container_query Rule.rule = Container_query.rule

module Query_in_parens =
  [%spec_module
  "'(' <container-query> ')' | '(' <size-feature> ')' | style( <style-query> )",
  (module Css_types.QueryInParens)]

let query_in_parens : query_in_parens Rule.rule = Query_in_parens.rule

module Size_feature =
  [%spec_module
  "<mf-plain> | <mf-boolean> | <mf-range>", (module Css_types.SizeFeature)]

let size_feature : size_feature Rule.rule = Size_feature.rule

module Style_query =
  [%spec_module
  "'not' <style-in-parens> | <style-in-parens> [ [ module <style-in-parens> ]* \
   | [ or <style-in-parens> ]* ] | <style-feature>",
  (module Css_types.StyleQuery)]

let style_query : style_query Rule.rule = Style_query.rule

module Style_feature =
  [%spec_module
  "<dashed_ident> ':' <mf-value>", (module Css_types.StyleFeature)]

let style_feature : style_feature Rule.rule = Style_feature.rule

module Style_in_parens =
  [%spec_module
  "'(' <style-query> ')' | '(' <style-feature> ')'",
  (module Css_types.StyleInParens)]

let style_in_parens : style_in_parens Rule.rule = Style_in_parens.rule

module Name_repeat =
  [%spec_module
  "repeat( [ <positive-integer> | 'auto-fill' ] ',' [ <line-names> ]+ )",
  (module Css_types.NameRepeat)]

let name_repeat : name_repeat Rule.rule = Name_repeat.rule

module Named_color =
  [%spec_module
  "'transparent' | 'aliceblue' | 'antiquewhite' | 'aqua' | 'aquamarine' | \
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
   'whitesmoke' | 'yellow' | 'yellowgreen' | <-non-standard-color>",
  (module Css_types.NamedColor)]

let named_color : named_color Rule.rule = Named_color.rule

module Namespace_prefix =
  [%spec_module
  "<ident>", (module Css_types.NamespacePrefix)]

let namespace_prefix : namespace_prefix Rule.rule = Namespace_prefix.rule

module Ns_prefix =
  [%spec_module
  "[ <ident-token> | '*' ]? '|'", (module Css_types.NsPrefix)]

let ns_prefix : ns_prefix Rule.rule = Ns_prefix.rule

module Nth =
  [%spec_module
  "<an-plus-b> | 'even' | 'odd'", (module Css_types.Nth)]

let nth : nth Rule.rule = Nth.rule

module Number_one_or_greater =
  [%spec_module
  "<number>", (module Css_types.NumberOneOrGreater)]

let number_one_or_greater : number_one_or_greater Rule.rule =
  Number_one_or_greater.rule

module Number_percentage =
  [%spec_module
  "<number> | <extended-percentage>", (module Css_types.NumberPercentage)]

let number_percentage : number_percentage Rule.rule = Number_percentage.rule

module Number_zero_one =
  [%spec_module
  "<number>", (module Css_types.NumberZeroOne)]

let number_zero_one : number_zero_one Rule.rule = Number_zero_one.rule

module Numeric_figure_values =
  [%spec_module
  "'lining-nums' | 'oldstyle-nums'", (module Css_types.NumericFigureValues)]

let numeric_figure_values : numeric_figure_values Rule.rule =
  Numeric_figure_values.rule

module Numeric_fraction_values =
  [%spec_module
  "'diagonal-fractions' | 'stacked-fractions'",
  (module Css_types.NumericFractionValues)]

let numeric_fraction_values : numeric_fraction_values Rule.rule =
  Numeric_fraction_values.rule

module Numeric_spacing_values =
  [%spec_module
  "'proportional-nums' | 'tabular-nums'",
  (module Css_types.NumericSpacingValues)]

let numeric_spacing_values : numeric_spacing_values Rule.rule =
  Numeric_spacing_values.rule

module Outline_radius =
  [%spec_module
  "<extended-length> | <extended-percentage>", (module Css_types.OutlineRadius)]

let outline_radius : outline_radius Rule.rule = Outline_radius.rule

module Overflow_position =
  [%spec_module
  "'unsafe' | 'safe'", (module Css_types.OverflowPosition)]

let overflow_position : overflow_position Rule.rule = Overflow_position.rule

module Page_body =
  [%spec_module
  "[ <declaration> ]? [ ';' <page-body> ]? | <page-margin-box> <page-body>",
  (module Css_types.PageBody)]

let page_body : page_body Rule.rule = Page_body.rule

module Page_margin_box =
  [%spec_module
  "<page-margin-box-type> '{' <declaration-list> '}'",
  (module Css_types.PageMarginBox)]

let page_margin_box : page_margin_box Rule.rule = Page_margin_box.rule

module Page_margin_box_type =
  [%spec_module
  "'@top-left-corner' | '@top-left' | '@top-center' | '@top-right' | \
   '@top-right-corner' | '@bottom-left-corner' | '@bottom-left' | \
   '@bottom-center' | '@bottom-right' | '@bottom-right-corner' | '@left-top' | \
   '@left-middle' | '@left-bottom' | '@right-top' | '@right-middle' | \
   '@right-bottom'",
  (module Css_types.PageMarginBoxType)]

let page_margin_box_type : page_margin_box_type Rule.rule =
  Page_margin_box_type.rule

module Page_selector =
  [%spec_module
  "[ <pseudo-page> ]+ | <ident> [ <pseudo-page> ]*",
  (module Css_types.PageSelector)]

let page_selector : page_selector Rule.rule = Page_selector.rule

module Page_selector_list =
  [%spec_module
  "[ [ <page-selector> ]# ]?", (module Css_types.PageSelectorList)]

let page_selector_list : page_selector_list Rule.rule = Page_selector_list.rule

module Paint =
  [%spec_module
  "'none' | <color> | <url> [ 'none' | <color> ]? | 'context-fill' | \
   'context-stroke' | <interpolation>",
  (module Css_types.Paint)]

let paint : paint Rule.rule = Paint.rule

module Position =
  [%spec_module
  "[ 'left' | 'center' | 'right' | 'top' | 'bottom' | <length-percentage> ] | \
   [ 'left' | 'center' | 'right' ] && [ 'top' | 'center' | 'bottom' ] | [ \
   'left' | 'center' | 'right' | <length-percentage> ] [ 'top' | 'center' | \
   'bottom' | <length-percentage> ] | [ [ 'left' | 'right' ] \
   <length-percentage> ] && [ [ 'top' | 'bottom' ] <length-percentage> ]",
  (module Css_types.Position)]

let position : position Rule.rule = Position.rule

module Positive_integer =
  [%spec_module
  "<integer>", (module Css_types.PositiveInteger)]

let positive_integer : positive_integer Rule.rule = Positive_integer.rule

module Property__moz_appearance =
  [%spec_module
  "'none' | 'button' | 'button-arrow-down' | 'button-arrow-next' | \
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
   '-moz-window-titlebar-maximized'",
  (module Css_types.MozAppearance)]

let property__moz_appearance : property__moz_appearance Rule.rule =
  Property__moz_appearance.rule

module Property__moz_background_clip =
  [%spec_module
  "'padding' | 'border'", (module Css_types.MozBackgroundClip)]

let property__moz_background_clip : property__moz_background_clip Rule.rule =
  Property__moz_background_clip.rule

module Property__moz_binding =
  [%spec_module
  "<url> | 'none'", (module Css_types.MozBinding)]

let property__moz_binding : property__moz_binding Rule.rule =
  Property__moz_binding.rule

module Property__moz_border_bottom_colors =
  [%spec_module
  "[ <color> ]+ | 'none'", (module Css_types.MozBorderBottomColors)]

let property__moz_border_bottom_colors :
  property__moz_border_bottom_colors Rule.rule =
  Property__moz_border_bottom_colors.rule

module Property__moz_border_left_colors =
  [%spec_module
  "[ <color> ]+ | 'none'", (module Css_types.MozBorderLeftColors)]

let property__moz_border_left_colors :
  property__moz_border_left_colors Rule.rule =
  Property__moz_border_left_colors.rule

module Property__moz_border_radius_bottomleft =
  [%spec_module
  "<'border-bottom-left-radius'>", (module Css_types.MozBorderRadiusBottomleft)]

let property__moz_border_radius_bottomleft :
  property__moz_border_radius_bottomleft Rule.rule =
  Property__moz_border_radius_bottomleft.rule

module Property__moz_border_radius_bottomright =
  [%spec_module
  "<'border-bottom-right-radius'>",
  (module Css_types.MozBorderRadiusBottomright)]

let property__moz_border_radius_bottomright :
  property__moz_border_radius_bottomright Rule.rule =
  Property__moz_border_radius_bottomright.rule

module Property__moz_border_radius_topleft =
  [%spec_module
  "<'border-top-left-radius'>", (module Css_types.MozBorderRadiusTopleft)]

let property__moz_border_radius_topleft :
  property__moz_border_radius_topleft Rule.rule =
  Property__moz_border_radius_topleft.rule

module Property__moz_border_radius_topright =
  [%spec_module
  "<'border-bottom-right-radius'>", (module Css_types.MozBorderRadiusTopright)]

let property__moz_border_radius_topright :
  property__moz_border_radius_topright Rule.rule =
  Property__moz_border_radius_topright.rule

module Property__moz_border_right_colors =
  [%spec_module
  "[ <color> ]+ | 'none'", (module Css_types.MozBorderRightColors)]

let property__moz_border_right_colors :
  property__moz_border_right_colors Rule.rule =
  Property__moz_border_right_colors.rule

module Property__moz_border_top_colors =
  [%spec_module
  "[ <color> ]+ | 'none'", (module Css_types.MozBorderTopColors)]

let property__moz_border_top_colors : property__moz_border_top_colors Rule.rule
    =
  Property__moz_border_top_colors.rule

module Property__moz_context_properties =
  [%spec_module
  "'none' | [ 'fill' | 'fill-opacity' | 'stroke' | 'stroke-opacity' ]#",
  (module Css_types.MozContextProperties)]

let property__moz_context_properties :
  property__moz_context_properties Rule.rule =
  Property__moz_context_properties.rule

module Property__moz_control_character_visibility =
  [%spec_module
  "'visible' | 'hidden'", (module Css_types.Cascading)]

let property__moz_control_character_visibility :
  property__moz_control_character_visibility Rule.rule =
  Property__moz_control_character_visibility.rule

module Property__moz_float_edge =
  [%spec_module
  "'border-box' | 'content-box' | 'margin-box' | 'padding-box'",
  (module Css_types.MozFloatEdge)]

let property__moz_float_edge : property__moz_float_edge Rule.rule =
  Property__moz_float_edge.rule

module Property__moz_force_broken_image_icon =
  [%spec_module
  "<integer>", (module Css_types.MozForceBrokenImageIcon)]

let property__moz_force_broken_image_icon :
  property__moz_force_broken_image_icon Rule.rule =
  Property__moz_force_broken_image_icon.rule

module Property__moz_image_region =
  [%spec_module
  "<shape> | 'auto'", (module Css_types.MozImageRegion)]

let property__moz_image_region : property__moz_image_region Rule.rule =
  Property__moz_image_region.rule

module Property__moz_orient =
  [%spec_module
  "'inline' | 'block' | 'horizontal' | 'vertical'", (module Css_types.MozOrient)]

let property__moz_orient : property__moz_orient Rule.rule =
  Property__moz_orient.rule

module Property__moz_osx_font_smoothing =
  [%spec_module
  "'auto' | 'grayscale'", (module Css_types.MozOsxFontSmoothing)]

let property__moz_osx_font_smoothing :
  property__moz_osx_font_smoothing Rule.rule =
  Property__moz_osx_font_smoothing.rule

module Property__moz_outline_radius =
  [%spec_module
  "[ <outline-radius> ]{1,4} [ '/' [ <outline-radius> ]{1,4} ]?",
  (module Css_types.MozOutlineRadius)]

let property__moz_outline_radius : property__moz_outline_radius Rule.rule =
  Property__moz_outline_radius.rule

module Property__moz_outline_radius_bottomleft =
  [%spec_module
  "<outline-radius>", (module Css_types.MozOutlineRadiusBottomleft)]

let property__moz_outline_radius_bottomleft :
  property__moz_outline_radius_bottomleft Rule.rule =
  Property__moz_outline_radius_bottomleft.rule

module Property__moz_outline_radius_bottomright =
  [%spec_module
  "<outline-radius>", (module Css_types.LengthPercentage)]

let property__moz_outline_radius_bottomright :
  property__moz_outline_radius_bottomright Rule.rule =
  Property__moz_outline_radius_bottomright.rule

module Property__moz_outline_radius_topleft =
  [%spec_module
  "<outline-radius>", (module Css_types.MozOutlineRadiusTopleft)]

let property__moz_outline_radius_topleft :
  property__moz_outline_radius_topleft Rule.rule =
  Property__moz_outline_radius_topleft.rule

module Property__moz_outline_radius_topright =
  [%spec_module
  "<outline-radius>", (module Css_types.MozOutlineRadiusTopright)]

let property__moz_outline_radius_topright :
  property__moz_outline_radius_topright Rule.rule =
  Property__moz_outline_radius_topright.rule

module Property__moz_stack_sizing =
  [%spec_module
  "'ignore' | 'stretch-to-fit'", (module Css_types.MozStackSizing)]

let property__moz_stack_sizing : property__moz_stack_sizing Rule.rule =
  Property__moz_stack_sizing.rule

module Property__moz_text_blink =
  [%spec_module
  "'none' | 'blink'", (module Css_types.MozTextBlink)]

let property__moz_text_blink : property__moz_text_blink Rule.rule =
  Property__moz_text_blink.rule

module Property__moz_user_focus =
  [%spec_module
  "'ignore' | 'normal' | 'select-after' | 'select-before' | 'select-menu' | \
   'select-same' | 'select-all' | 'none'",
  (module Css_types.MozUserFocus)]

let property__moz_user_focus : property__moz_user_focus Rule.rule =
  Property__moz_user_focus.rule

module Property__moz_user_input =
  [%spec_module
  "'auto' | 'none' | 'enabled' | 'disabled'", (module Css_types.MozUserInput)]

let property__moz_user_input : property__moz_user_input Rule.rule =
  Property__moz_user_input.rule

module Property__moz_user_modify =
  [%spec_module
  "'read-only' | 'read-write' | 'write-only'", (module Css_types.MozUserModify)]

let property__moz_user_modify : property__moz_user_modify Rule.rule =
  Property__moz_user_modify.rule

module Property__moz_user_select =
  [%spec_module
  "'none' | 'text' | 'all' | '-moz-none'", (module Css_types.MozUserSelect)]

let property__moz_user_select : property__moz_user_select Rule.rule =
  Property__moz_user_select.rule

module Property__moz_window_dragging =
  [%spec_module
  "'drag' | 'no-drag'", (module Css_types.MozWindowDragging)]

let property__moz_window_dragging : property__moz_window_dragging Rule.rule =
  Property__moz_window_dragging.rule

module Property__moz_window_shadow =
  [%spec_module
  "'default' | 'menu' | 'tooltip' | 'sheet' | 'none'",
  (module Css_types.MozWindowShadow)]

let property__moz_window_shadow : property__moz_window_shadow Rule.rule =
  Property__moz_window_shadow.rule

module Property__webkit_appearance =
  [%spec_module
  "'none' | 'button' | 'button-bevel' | 'caps-lock-indicator' | 'caret' | \
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
   'sliderthumb-vertical' | 'square-button' | 'textarea' | 'textfield'",
  (module Css_types.WebkitAppearance)]

let property__webkit_appearance : property__webkit_appearance Rule.rule =
  Property__webkit_appearance.rule

module Property__webkit_background_clip =
  [%spec_module
  "[ <box> | 'border' | 'padding' | 'content' | 'text' ]#",
  (module Css_types.WebkitBackgroundClip)]

let property__webkit_background_clip :
  property__webkit_background_clip Rule.rule =
  Property__webkit_background_clip.rule

module Property__webkit_border_before =
  [%spec_module
  "<'border-width'> || <'border-style'> || <'color'>",
  (module Css_types.WebkitBorderBefore)]

let property__webkit_border_before : property__webkit_border_before Rule.rule =
  Property__webkit_border_before.rule

module Property__webkit_border_before_color =
  [%spec_module
  "<'color'>", (module Css_types.WebkitBorderBeforeColor)]

let property__webkit_border_before_color :
  property__webkit_border_before_color Rule.rule =
  Property__webkit_border_before_color.rule

module Property__webkit_border_before_style =
  [%spec_module
  "<'border-style'>", (module Css_types.WebkitBorderBeforeStyle)]

let property__webkit_border_before_style :
  property__webkit_border_before_style Rule.rule =
  Property__webkit_border_before_style.rule

module Property__webkit_border_before_width =
  [%spec_module
  "<'border-width'>", (module Css_types.WebkitBorderBeforeWidth)]

let property__webkit_border_before_width :
  property__webkit_border_before_width Rule.rule =
  Property__webkit_border_before_width.rule

module Property__webkit_box_reflect =
  [%spec_module
  "[ 'above' | 'below' | 'right' | 'left' ]? [ <extended-length> ]? [ <image> \
   ]?",
  (module Css_types.WebkitBoxReflect)]

let property__webkit_box_reflect : property__webkit_box_reflect Rule.rule =
  Property__webkit_box_reflect.rule

module Property__webkit_column_break_after =
  [%spec_module
  "'always' | 'auto' | 'avoid'", (module Css_types.WebkitColumnBreakAfter)]

let property__webkit_column_break_after :
  property__webkit_column_break_after Rule.rule =
  Property__webkit_column_break_after.rule

module Property__webkit_column_break_before =
  [%spec_module
  "'always' | 'auto' | 'avoid'", (module Css_types.WebkitColumnBreakBefore)]

let property__webkit_column_break_before :
  property__webkit_column_break_before Rule.rule =
  Property__webkit_column_break_before.rule

module Property__webkit_column_break_inside =
  [%spec_module
  "'always' | 'auto' | 'avoid'", (module Css_types.WebkitColumnBreakInside)]

let property__webkit_column_break_inside :
  property__webkit_column_break_inside Rule.rule =
  Property__webkit_column_break_inside.rule

module Property__webkit_font_smoothing =
  [%spec_module
  "'auto' | 'none' | 'antialiased' | 'subpixel-antialiased'",
  (module Css_types.WebkitFontSmoothing)]

let property__webkit_font_smoothing : property__webkit_font_smoothing Rule.rule
    =
  Property__webkit_font_smoothing.rule

module Property__webkit_line_clamp =
  [%spec_module
  "'none' | <integer>", (module Css_types.WebkitLineClamp)]

let property__webkit_line_clamp : property__webkit_line_clamp Rule.rule =
  Property__webkit_line_clamp.rule

module Property__webkit_mask =
  [%spec_module
  "[ <mask-reference> || <position> [ '/' <bg-size> ]? || <repeat-style> || [ \
   <box> | 'border' | 'padding' | 'content' | 'text' ] || [ <box> | 'border' | \
   'padding' | 'content' ] ]#",
  (module Css_types.WebkitMask)]

let property__webkit_mask : property__webkit_mask Rule.rule =
  Property__webkit_mask.rule

module Property__webkit_mask_attachment =
  [%spec_module
  "[ <attachment> ]#", (module Css_types.WebkitMaskAttachment)]

let property__webkit_mask_attachment :
  property__webkit_mask_attachment Rule.rule =
  Property__webkit_mask_attachment.rule

module Property__webkit_mask_box_image =
  [%spec_module
  "[ <url> | <gradient> | 'none' ] [ [ <extended-length> | \
   <extended-percentage> ]{4} [ <webkit-mask-box-repeat> ]{2} ]?",
  (module Css_types.WebkitMaskBoxImage)]

let property__webkit_mask_box_image : property__webkit_mask_box_image Rule.rule
    =
  Property__webkit_mask_box_image.rule

module Property__webkit_mask_clip =
  [%spec_module
  "[ <box> | 'border' | 'padding' | 'content' | 'text' ]#",
  (module Css_types.WebkitMaskClip)]

let property__webkit_mask_clip : property__webkit_mask_clip Rule.rule =
  Property__webkit_mask_clip.rule

module Property__webkit_mask_composite =
  [%spec_module
  "[ <composite-style> ]#", (module Css_types.WebkitMaskComposite)]

let property__webkit_mask_composite : property__webkit_mask_composite Rule.rule
    =
  Property__webkit_mask_composite.rule

module Property__webkit_mask_image =
  [%spec_module
  "[ <mask-reference> ]#", (module Css_types.WebkitMaskImage)]

let property__webkit_mask_image : property__webkit_mask_image Rule.rule =
  Property__webkit_mask_image.rule

module Property__webkit_mask_origin =
  [%spec_module
  "[ <box> | 'border' | 'padding' | 'content' ]#",
  (module Css_types.WebkitMaskOrigin)]

let property__webkit_mask_origin : property__webkit_mask_origin Rule.rule =
  Property__webkit_mask_origin.rule

module Property__webkit_mask_position =
  [%spec_module
  "[ <position> ]#", (module Css_types.WebkitMaskPosition)]

let property__webkit_mask_position : property__webkit_mask_position Rule.rule =
  Property__webkit_mask_position.rule

module Property__webkit_mask_position_x =
  [%spec_module
  "[ <extended-length> | <extended-percentage> | 'left' | 'center' | 'right' ]#",
  (module Css_types.WebkitMaskPositionX)]

let property__webkit_mask_position_x :
  property__webkit_mask_position_x Rule.rule =
  Property__webkit_mask_position_x.rule

module Property__webkit_mask_position_y =
  [%spec_module
  "[ <extended-length> | <extended-percentage> | 'top' | 'center' | 'bottom' ]#",
  (module Css_types.WebkitMaskPositionY)]

let property__webkit_mask_position_y :
  property__webkit_mask_position_y Rule.rule =
  Property__webkit_mask_position_y.rule

module Property__webkit_mask_repeat =
  [%spec_module
  "[ <repeat-style> ]#", (module Css_types.WebkitMaskRepeat)]

let property__webkit_mask_repeat : property__webkit_mask_repeat Rule.rule =
  Property__webkit_mask_repeat.rule

module Property__webkit_mask_repeat_x =
  [%spec_module
  "'repeat' | 'no-repeat' | 'space' | 'round'",
  (module Css_types.WebkitMaskRepeatX)]

let property__webkit_mask_repeat_x : property__webkit_mask_repeat_x Rule.rule =
  Property__webkit_mask_repeat_x.rule

module Property__webkit_mask_repeat_y =
  [%spec_module
  "'repeat' | 'no-repeat' | 'space' | 'round'",
  (module Css_types.WebkitMaskRepeatY)]

let property__webkit_mask_repeat_y : property__webkit_mask_repeat_y Rule.rule =
  Property__webkit_mask_repeat_y.rule

module Property__webkit_mask_size =
  [%spec_module
  "[ <bg-size> ]#", (module Css_types.WebkitMaskSize)]

let property__webkit_mask_size : property__webkit_mask_size Rule.rule =
  Property__webkit_mask_size.rule

module Property__webkit_overflow_scrolling =
  [%spec_module
  "'auto' | 'touch'", (module Css_types.WebkitOverflowScrolling)]

let property__webkit_overflow_scrolling :
  property__webkit_overflow_scrolling Rule.rule =
  Property__webkit_overflow_scrolling.rule

module Property__webkit_print_color_adjust =
  [%spec_module
  "'economy' | 'exact'", (module Css_types.WebkitPrintColorAdjust)]

let property__webkit_print_color_adjust :
  property__webkit_print_color_adjust Rule.rule =
  Property__webkit_print_color_adjust.rule

module Property__webkit_tap_highlight_color =
  [%spec_module
  "<color>", (module Css_types.WebkitTapHighlightColor)]

let property__webkit_tap_highlight_color :
  property__webkit_tap_highlight_color Rule.rule =
  Property__webkit_tap_highlight_color.rule

module Property__webkit_text_fill_color =
  [%spec_module
  "<color>", (module Css_types.WebkitTextFillColor)]

let property__webkit_text_fill_color :
  property__webkit_text_fill_color Rule.rule =
  Property__webkit_text_fill_color.rule

module Property__webkit_text_security =
  [%spec_module
  "'none' | 'circle' | 'disc' | 'square'", (module Css_types.WebkitTextSecurity)]

let property__webkit_text_security : property__webkit_text_security Rule.rule =
  Property__webkit_text_security.rule

module Property__webkit_text_stroke =
  [%spec_module
  "<extended-length> || <color>", (module Css_types.WebkitTextStroke)]

let property__webkit_text_stroke : property__webkit_text_stroke Rule.rule =
  Property__webkit_text_stroke.rule

module Property__webkit_text_stroke_color =
  [%spec_module
  "<color>", (module Css_types.WebkitTextStrokeColor)]

let property__webkit_text_stroke_color :
  property__webkit_text_stroke_color Rule.rule =
  Property__webkit_text_stroke_color.rule

module Property__webkit_text_stroke_width =
  [%spec_module
  "<extended-length>", (module Css_types.WebkitTextStrokeWidth)]

let property__webkit_text_stroke_width :
  property__webkit_text_stroke_width Rule.rule =
  Property__webkit_text_stroke_width.rule

module Property__webkit_touch_callout =
  [%spec_module
  "'default' | 'none'", (module Css_types.WebkitTouchCallout)]

let property__webkit_touch_callout : property__webkit_touch_callout Rule.rule =
  Property__webkit_touch_callout.rule

module Property__webkit_user_drag =
  [%spec_module
  "'none' | 'element' | 'auto'", (module Css_types.WebkitUserDrag)]

let property__webkit_user_drag : property__webkit_user_drag Rule.rule =
  Property__webkit_user_drag.rule

module Property__webkit_user_modify =
  [%spec_module
  "'read-only' | 'read-write' | 'read-write-plaintext-only'",
  (module Css_types.WebkitUserModify)]

let property__webkit_user_modify : property__webkit_user_modify Rule.rule =
  Property__webkit_user_modify.rule

module Property__webkit_user_select =
  [%spec_module
  "'auto' | 'none' | 'text' | 'all'", (module Css_types.WebkitUserSelect)]

let property__webkit_user_select : property__webkit_user_select Rule.rule =
  Property__webkit_user_select.rule

module Property__ms_overflow_style =
  [%spec_module
  "'auto' | 'none' | 'scrollbar' | '-ms-autohiding-scrollbar'",
  (module Css_types.MsOverflowStyle)]

let property__ms_overflow_style : property__ms_overflow_style Rule.rule =
  Property__ms_overflow_style.rule

module Property_align_content =
  [%spec_module
  "'normal' | <baseline-position> | <content-distribution> | [ \
   <overflow-position> ]? <content-position>",
  (module Css_types.AlignContent)]

let property_align_content : property_align_content Rule.rule =
  Property_align_content.rule

module Property_align_items =
  [%spec_module
  "'normal' | 'stretch' | <baseline-position> | [ <overflow-position> ]? \
   <self-position> | <interpolation>",
  (module Css_types.AlignItems)]

let property_align_items : property_align_items Rule.rule =
  Property_align_items.rule

module Property_align_self =
  [%spec_module
  "'auto' | 'normal' | 'stretch' | <baseline-position> | [ <overflow-position> \
   ]? <self-position> | <interpolation>",
  (module Css_types.AlignSelf)]

let property_align_self : property_align_self Rule.rule =
  Property_align_self.rule

module Property_alignment_baseline =
  [%spec_module
  "'auto' | 'baseline' | 'before-edge' | 'text-before-edge' | 'middle' | \
   'central' | 'after-edge' | 'text-after-edge' | 'ideographic' | 'alphabetic' \
   | 'hanging' | 'mathematical'",
  (module Css_types.AlignmentBaseline)]

let property_alignment_baseline : property_alignment_baseline Rule.rule =
  Property_alignment_baseline.rule

module Property_all =
  [%spec_module
  "'initial' | 'inherit' | 'unset' | 'revert'", (module Css_types.All)]

let property_all : property_all Rule.rule = Property_all.rule

module Property_animation =
  [%spec_module
  "[ <single-animation> | <single-animation-no-interp> ]#",
  (module Css_types.Animation)]

let property_animation : property_animation Rule.rule = Property_animation.rule

module Property_animation_delay =
  [%spec_module
  "[ <extended-time> ]#", (module Css_types.AnimationDelay)]

let property_animation_delay : property_animation_delay Rule.rule =
  Property_animation_delay.rule

module Property_animation_direction =
  [%spec_module
  "[ <single-animation-direction> ]#", (module Css_types.AnimationDirection)]

let property_animation_direction : property_animation_direction Rule.rule =
  Property_animation_direction.rule

module Property_animation_duration =
  [%spec_module
  "[ <extended-time> ]#", (module Css_types.AnimationDuration)]

let property_animation_duration : property_animation_duration Rule.rule =
  Property_animation_duration.rule

module Property_animation_fill_mode =
  [%spec_module
  "[ <single-animation-fill-mode> ]#", (module Css_types.AnimationFillMode)]

let property_animation_fill_mode : property_animation_fill_mode Rule.rule =
  Property_animation_fill_mode.rule

module Property_animation_iteration_count =
  [%spec_module
  "[ <single-animation-iteration-count> ]#",
  (module Css_types.AnimationIterationCount)]

let property_animation_iteration_count :
  property_animation_iteration_count Rule.rule =
  Property_animation_iteration_count.rule

module Property_animation_name =
  [%spec_module
  "[ <keyframes-name> | 'none' | <interpolation> ]#",
  (module Css_types.AnimationName)]

let property_animation_name : property_animation_name Rule.rule =
  Property_animation_name.rule

module Property_animation_play_state =
  [%spec_module
  "[ <single-animation-play-state> ]#", (module Css_types.AnimationPlayState)]

let property_animation_play_state : property_animation_play_state Rule.rule =
  Property_animation_play_state.rule

module Property_animation_timing_function =
  [%spec_module
  "[ <timing-function> ]#", (module Css_types.AnimationTimingFunction)]

let property_animation_timing_function :
  property_animation_timing_function Rule.rule =
  Property_animation_timing_function.rule

module Property_appearance =
  [%spec_module
  "'none' | 'auto' | 'button' | 'textfield' | 'menulist-button' | <compat-auto>",
  (module Css_types.Appearance)]

let property_appearance : property_appearance Rule.rule =
  Property_appearance.rule

module Property_aspect_ratio =
  [%spec_module
  "'auto' | <ratio>", (module Css_types.AspectRatio)]

let property_aspect_ratio : property_aspect_ratio Rule.rule =
  Property_aspect_ratio.rule

module Property_azimuth =
  [%spec_module
  "<extended-angle> | [ 'left-side' | 'far-left' | 'left' | 'center-left' | \
   'center' | 'center-right' | 'right' | 'far-right' | 'right-side' ] || \
   'behind' | 'leftwards' | 'rightwards'",
  (module Css_types.Azimuth)]

let property_azimuth : property_azimuth Rule.rule = Property_azimuth.rule

module Property_backdrop_filter =
  [%spec_module
  "'none' | <interpolation> | <filter-function-list>", (module Css_types.Filter)]

let property_backdrop_filter : property_backdrop_filter Rule.rule =
  Property_backdrop_filter.rule

module Property_backface_visibility =
  [%spec_module
  "'visible' | 'hidden'", (module Css_types.BackfaceVisibility)]

let property_backface_visibility : property_backface_visibility Rule.rule =
  Property_backface_visibility.rule

module Property_background =
  [%spec_module
  "[ <bg-layer> ',' ]* <final-bg-layer>", (module Css_types.Background)]

let property_background : property_background Rule.rule =
  Property_background.rule

module Property_background_attachment =
  [%spec_module
  "[ <attachment> ]#", (module Css_types.BackgroundAttachment)]

let property_background_attachment : property_background_attachment Rule.rule =
  Property_background_attachment.rule

module Property_background_blend_mode =
  [%spec_module
  "[ <blend-mode> ]#", (module Css_types.BackgroundBlendMode)]

let property_background_blend_mode : property_background_blend_mode Rule.rule =
  Property_background_blend_mode.rule

module Property_background_clip =
  [%spec_module
  "[ <box> | 'text' | 'border-area' ]#", (module Css_types.BackgroundClip)]

let property_background_clip : property_background_clip Rule.rule =
  Property_background_clip.rule

module Property_background_color =
  [%spec_module
  "<color>", (module Css_types.Color)]

let property_background_color : property_background_color Rule.rule =
  Property_background_color.rule

module Property_background_image =
  [%spec_module
  "[ <bg-image> ]#", (module Css_types.BackgroundImage)]

let property_background_image : property_background_image Rule.rule =
  Property_background_image.rule

module Property_background_origin =
  [%spec_module
  "[ <box> ]#", (module Css_types.BackgroundOrigin)]

let property_background_origin : property_background_origin Rule.rule =
  Property_background_origin.rule

module Property_background_position =
  [%spec_module
  "[ <bg-position> ]#", (module Css_types.BackgroundPosition)]

let property_background_position : property_background_position Rule.rule =
  Property_background_position.rule

module Property_background_position_x =
  [%spec_module
  "[ 'center' | [ 'left' | 'right' | 'x-start' | 'x-end' ]? [ \
   <extended-length> | <extended-percentage> ]? ]#",
  (module Css_types.BackgroundPositionX)]

let property_background_position_x : property_background_position_x Rule.rule =
  Property_background_position_x.rule

module Property_background_position_y =
  [%spec_module
  "[ 'center' | [ 'top' | 'bottom' | 'y-start' | 'y-end' ]? [ \
   <extended-length> | <extended-percentage> ]? ]#",
  (module Css_types.BackgroundPositionY)]

let property_background_position_y : property_background_position_y Rule.rule =
  Property_background_position_y.rule

module Property_background_repeat =
  [%spec_module
  "[ <repeat-style> ]#", (module Css_types.BackgroundRepeat)]

let property_background_repeat : property_background_repeat Rule.rule =
  Property_background_repeat.rule

module Property_background_size =
  [%spec_module
  "[ <bg-size> ]#", (module Css_types.BackgroundSize)]

let property_background_size : property_background_size Rule.rule =
  Property_background_size.rule

module Property_baseline_shift =
  [%spec_module
  "'baseline' | 'sub' | 'super' | <svg-length>",
  (module Css_types.BaselineShift)]

let property_baseline_shift : property_baseline_shift Rule.rule =
  Property_baseline_shift.rule

module Property_behavior =
  [%spec_module
  "[ <url> ]+", (module Css_types.Behavior)]

let property_behavior : property_behavior Rule.rule = Property_behavior.rule

module Property_block_overflow =
  [%spec_module
  "'clip' | 'ellipsis' | <string>", (module Css_types.BlockOverflow)]

let property_block_overflow : property_block_overflow Rule.rule =
  Property_block_overflow.rule

module Property_block_size =
  [%spec_module
  "<'width'>", (module Css_types.Length)]

let property_block_size : property_block_size Rule.rule =
  Property_block_size.rule

module Property_border =
  [%spec_module
  "'none' | [ <line-width> | <interpolation> ] | [ <line-width> | \
   <interpolation> ] [ <line-style> | <interpolation> ] | [ <line-width> | \
   <interpolation> ] [ <line-style> | <interpolation> ] [ <color> | \
   <interpolation> ]",
  (module Css_types.Border)]

let property_border : property_border Rule.rule = Property_border.rule

module Property_border_block =
  [%spec_module
  "<'border'>", (module Css_types.BorderBlock)]

let property_border_block : property_border_block Rule.rule =
  Property_border_block.rule

module Property_border_block_color =
  [%spec_module
  "[ <'border-top-color'> ]{1,2}", (module Css_types.BorderBlockColor)]

let property_border_block_color : property_border_block_color Rule.rule =
  Property_border_block_color.rule

module Property_border_block_end =
  [%spec_module
  "<'border'>", (module Css_types.BorderBlockEnd)]

let property_border_block_end : property_border_block_end Rule.rule =
  Property_border_block_end.rule

module Property_border_block_end_color =
  [%spec_module
  "<'border-top-color'>", (module Css_types.BorderBlockEndColor)]

let property_border_block_end_color : property_border_block_end_color Rule.rule
    =
  Property_border_block_end_color.rule

module Property_border_block_end_style =
  [%spec_module
  "<'border-top-style'>", (module Css_types.BorderBlockEndStyle)]

let property_border_block_end_style : property_border_block_end_style Rule.rule
    =
  Property_border_block_end_style.rule

module Property_border_block_end_width =
  [%spec_module
  "<'border-top-width'>", (module Css_types.BorderBlockEndWidth)]

let property_border_block_end_width : property_border_block_end_width Rule.rule
    =
  Property_border_block_end_width.rule

module Property_border_block_start =
  [%spec_module
  "<'border'>", (module Css_types.BorderBlockStart)]

let property_border_block_start : property_border_block_start Rule.rule =
  Property_border_block_start.rule

module Property_border_block_start_color =
  [%spec_module
  "<'border-top-color'>", (module Css_types.BorderBlockStartColor)]

let property_border_block_start_color :
  property_border_block_start_color Rule.rule =
  Property_border_block_start_color.rule

module Property_border_block_start_style =
  [%spec_module
  "<'border-top-style'>", (module Css_types.BorderBlockStartStyle)]

let property_border_block_start_style :
  property_border_block_start_style Rule.rule =
  Property_border_block_start_style.rule

module Property_border_block_start_width =
  [%spec_module
  "<'border-top-width'>", (module Css_types.BorderBlockStartWidth)]

let property_border_block_start_width :
  property_border_block_start_width Rule.rule =
  Property_border_block_start_width.rule

module Property_border_block_style =
  [%spec_module
  "<'border-top-style'>", (module Css_types.BorderBlockStyle)]

let property_border_block_style : property_border_block_style Rule.rule =
  Property_border_block_style.rule

module Property_border_block_width =
  [%spec_module
  "<'border-top-width'>", (module Css_types.BorderBlockWidth)]

let property_border_block_width : property_border_block_width Rule.rule =
  Property_border_block_width.rule

module Property_border_bottom =
  [%spec_module
  "<'border'>", (module Css_types.Border)]

let property_border_bottom : property_border_bottom Rule.rule =
  Property_border_bottom.rule

module Property_border_bottom_color =
  [%spec_module
  "<'border-top-color'>", (module Css_types.Color)]

let property_border_bottom_color : property_border_bottom_color Rule.rule =
  Property_border_bottom_color.rule

module Property_border_bottom_left_radius =
  [%spec_module
  "[ <extended-length> | <extended-percentage> ]{1,2}",
  (module Css_types.LengthPercentage)]

let property_border_bottom_left_radius :
  property_border_bottom_left_radius Rule.rule =
  Property_border_bottom_left_radius.rule

module Property_border_bottom_right_radius =
  [%spec_module
  "[ <extended-length> | <extended-percentage> ]{1,2}",
  (module Css_types.LengthPercentage)]

let property_border_bottom_right_radius :
  property_border_bottom_right_radius Rule.rule =
  Property_border_bottom_right_radius.rule

module Property_border_bottom_style =
  [%spec_module
  "<line-style>", (module Css_types.BorderStyle)]

let property_border_bottom_style : property_border_bottom_style Rule.rule =
  Property_border_bottom_style.rule

module Property_border_bottom_width =
  [%spec_module
  "<line-width>", (module Css_types.LineWidth)]

let property_border_bottom_width : property_border_bottom_width Rule.rule =
  Property_border_bottom_width.rule

module Property_border_collapse =
  [%spec_module
  "'collapse' | 'separate'", (module Css_types.BorderCollapse)]

let property_border_collapse : property_border_collapse Rule.rule =
  Property_border_collapse.rule

module Property_border_color =
  [%spec_module
  "[ <color> ]{1,4}", (module Css_types.Color)]

let property_border_color : property_border_color Rule.rule =
  Property_border_color.rule

module Property_border_end_end_radius =
  [%spec_module
  "[ <extended-length> | <extended-percentage> ]{1,2}",
  (module Css_types.LengthPercentage)]

let property_border_end_end_radius : property_border_end_end_radius Rule.rule =
  Property_border_end_end_radius.rule

module Property_border_end_start_radius =
  [%spec_module
  "[ <extended-length> | <extended-percentage> ]{1,2}",
  (module Css_types.LengthPercentage)]

let property_border_end_start_radius :
  property_border_end_start_radius Rule.rule =
  Property_border_end_start_radius.rule

module Property_border_image =
  [%spec_module
  "<'border-image-source'> || <'border-image-slice'> [ '/' \
   <'border-image-width'> | '/' [ <'border-image-width'> ]? '/' \
   <'border-image-outset'> ]? || <'border-image-repeat'>",
  (module Css_types.BorderImage)]

let property_border_image : property_border_image Rule.rule =
  Property_border_image.rule

module Property_border_image_outset =
  [%spec_module
  "[ <extended-length> | <number> ]{1,4}", (module Css_types.BorderImageOutset)]

let property_border_image_outset : property_border_image_outset Rule.rule =
  Property_border_image_outset.rule

module Property_border_image_repeat =
  [%spec_module
  "[ 'stretch' | 'repeat' | 'round' | 'space' ]{1,2}",
  (module Css_types.BorderImageRepeat)]

let property_border_image_repeat : property_border_image_repeat Rule.rule =
  Property_border_image_repeat.rule

module Property_border_image_slice =
  [%spec_module
  "[ <number-percentage> ]{1,4} && [ 'fill' ]?",
  (module Css_types.BorderImageSlice)]

let property_border_image_slice : property_border_image_slice Rule.rule =
  Property_border_image_slice.rule

module Property_border_image_source =
  [%spec_module
  "'none' | <image>", (module Css_types.BorderImageSource)]

let property_border_image_source : property_border_image_source Rule.rule =
  Property_border_image_source.rule

module Property_border_image_width =
  [%spec_module
  "[ <extended-length> | <extended-percentage> | <number> | 'auto' ]{1,4}",
  (module Css_types.BorderImageWidth)]

let property_border_image_width : property_border_image_width Rule.rule =
  Property_border_image_width.rule

module Property_border_inline =
  [%spec_module
  "<'border'>", (module Css_types.BorderInline)]

let property_border_inline : property_border_inline Rule.rule =
  Property_border_inline.rule

module Property_border_inline_color =
  [%spec_module
  "[ <'border-top-color'> ]{1,2}", (module Css_types.BorderInlineColor)]

let property_border_inline_color : property_border_inline_color Rule.rule =
  Property_border_inline_color.rule

module Property_border_inline_end =
  [%spec_module
  "<'border'>", (module Css_types.BorderInlineEnd)]

let property_border_inline_end : property_border_inline_end Rule.rule =
  Property_border_inline_end.rule

module Property_border_inline_end_color =
  [%spec_module
  "<'border-top-color'>", (module Css_types.BorderInlineEndColor)]

let property_border_inline_end_color :
  property_border_inline_end_color Rule.rule =
  Property_border_inline_end_color.rule

module Property_border_inline_end_style =
  [%spec_module
  "<'border-top-style'>", (module Css_types.BorderInlineEndStyle)]

let property_border_inline_end_style :
  property_border_inline_end_style Rule.rule =
  Property_border_inline_end_style.rule

module Property_border_inline_end_width =
  [%spec_module
  "<'border-top-width'>", (module Css_types.BorderInlineEndWidth)]

let property_border_inline_end_width :
  property_border_inline_end_width Rule.rule =
  Property_border_inline_end_width.rule

module Property_border_inline_start =
  [%spec_module
  "<'border'>", (module Css_types.BorderInlineStart)]

let property_border_inline_start : property_border_inline_start Rule.rule =
  Property_border_inline_start.rule

module Property_border_inline_start_color =
  [%spec_module
  "<'border-top-color'>", (module Css_types.BorderInlineStartColor)]

let property_border_inline_start_color :
  property_border_inline_start_color Rule.rule =
  Property_border_inline_start_color.rule

module Property_border_inline_start_style =
  [%spec_module
  "<'border-top-style'>", (module Css_types.BorderInlineStartStyle)]

let property_border_inline_start_style :
  property_border_inline_start_style Rule.rule =
  Property_border_inline_start_style.rule

module Property_border_inline_start_width =
  [%spec_module
  "<'border-top-width'>", (module Css_types.BorderInlineStartWidth)]

let property_border_inline_start_width :
  property_border_inline_start_width Rule.rule =
  Property_border_inline_start_width.rule

module Property_border_inline_style =
  [%spec_module
  "<'border-top-style'>", (module Css_types.BorderInlineStyle)]

let property_border_inline_style : property_border_inline_style Rule.rule =
  Property_border_inline_style.rule

module Property_border_inline_width =
  [%spec_module
  "<'border-top-width'>", (module Css_types.BorderInlineWidth)]

let property_border_inline_width : property_border_inline_width Rule.rule =
  Property_border_inline_width.rule

module Property_border_left =
  [%spec_module
  "<'border'>", (module Css_types.Border)]

let property_border_left : property_border_left Rule.rule =
  Property_border_left.rule

module Property_border_left_color =
  [%spec_module
  "<color>", (module Css_types.Color)]

let property_border_left_color : property_border_left_color Rule.rule =
  Property_border_left_color.rule

module Property_border_left_style =
  [%spec_module
  "<line-style>", (module Css_types.BorderStyle)]

let property_border_left_style : property_border_left_style Rule.rule =
  Property_border_left_style.rule

module Property_border_left_width =
  [%spec_module
  "<line-width>", (module Css_types.LineWidth)]

let property_border_left_width : property_border_left_width Rule.rule =
  Property_border_left_width.rule

(* border-radius supports 1-4 values with optional "/" for horizontal/vertical radii *)
module Property_border_radius =
  [%spec_module
  "<extended-length> | <extended-percentage>", (module Css_types.BorderRadius)]

let property_border_radius : property_border_radius Rule.rule =
  Property_border_radius.rule

module Property_border_right =
  [%spec_module
  "<'border'>", (module Css_types.Border)]

let property_border_right : property_border_right Rule.rule =
  Property_border_right.rule

module Property_border_right_color =
  [%spec_module
  "<color>", (module Css_types.Color)]

let property_border_right_color : property_border_right_color Rule.rule =
  Property_border_right_color.rule

module Property_border_right_style =
  [%spec_module
  "<line-style>", (module Css_types.BorderStyle)]

let property_border_right_style : property_border_right_style Rule.rule =
  Property_border_right_style.rule

module Property_border_right_width =
  [%spec_module
  "<line-width>", (module Css_types.LineWidth)]

let property_border_right_width : property_border_right_width Rule.rule =
  Property_border_right_width.rule

module Property_border_spacing =
  [%spec_module
  "<extended-length> [ <extended-length> ]?", (module Css_types.BorderSpacing)]

let property_border_spacing : property_border_spacing Rule.rule =
  Property_border_spacing.rule

module Property_border_start_end_radius =
  [%spec_module
  "[ <extended-length> | <extended-percentage> ]{1,2}",
  (module Css_types.LengthPercentage)]

let property_border_start_end_radius :
  property_border_start_end_radius Rule.rule =
  Property_border_start_end_radius.rule

module Property_border_start_start_radius =
  [%spec_module
  "[ <extended-length> | <extended-percentage> ]{1,2}",
  (module Css_types.LengthPercentage)]

let property_border_start_start_radius :
  property_border_start_start_radius Rule.rule =
  Property_border_start_start_radius.rule

(* bs-css doesn't support list of styles, the original spec is: `[ <line-style> ]{1,4}` *)
module Property_border_style =
  [%spec_module
  "<line-style>", (module Css_types.BorderStyle)]

let property_border_style : property_border_style Rule.rule =
  Property_border_style.rule

module Property_border_top =
  [%spec_module
  "<'border'>", (module Css_types.Border)]

let property_border_top : property_border_top Rule.rule =
  Property_border_top.rule

module Property_border_top_color =
  [%spec_module
  "<color>", (module Css_types.Color)]

let property_border_top_color : property_border_top_color Rule.rule =
  Property_border_top_color.rule

module Property_border_top_left_radius =
  [%spec_module
  "[ <extended-length> | <extended-percentage> ]{1,2}",
  (module Css_types.LengthPercentage)]

let property_border_top_left_radius : property_border_top_left_radius Rule.rule
    =
  Property_border_top_left_radius.rule

module Property_border_top_right_radius =
  [%spec_module
  "[ <extended-length> | <extended-percentage> ]{1,2}",
  (module Css_types.LengthPercentage)]

let property_border_top_right_radius :
  property_border_top_right_radius Rule.rule =
  Property_border_top_right_radius.rule

module Property_border_top_style =
  [%spec_module
  "<line-style>", (module Css_types.BorderStyle)]

let property_border_top_style : property_border_top_style Rule.rule =
  Property_border_top_style.rule

module Property_border_top_width =
  [%spec_module
  "<line-width>", (module Css_types.LineWidth)]

let property_border_top_width : property_border_top_width Rule.rule =
  Property_border_top_width.rule

module Property_border_width =
  [%spec_module
  "[ <line-width> ]{1,4}", (module Css_types.LineWidth)]

let property_border_width : property_border_width Rule.rule =
  Property_border_width.rule

module Property_bottom =
  [%spec_module
  "<extended-length> | <extended-percentage> | 'auto'",
  (module Css_types.Bottom)]

let property_bottom : property_bottom Rule.rule = Property_bottom.rule

module Property_box_align =
  [%spec_module
  "'start' | 'center' | 'end' | 'baseline' | 'stretch'",
  (module Css_types.BoxAlign)]

let property_box_align : property_box_align Rule.rule = Property_box_align.rule

module Property_box_decoration_break =
  [%spec_module
  "'slice' | 'clone'", (module Css_types.BoxDecorationBreak)]

let property_box_decoration_break : property_box_decoration_break Rule.rule =
  Property_box_decoration_break.rule

module Property_box_direction =
  [%spec_module
  "'normal' | 'reverse' | 'inherit'", (module Css_types.BoxDirection)]

let property_box_direction : property_box_direction Rule.rule =
  Property_box_direction.rule

module Property_box_flex = [%spec_module "<number>", (module Css_types.BoxFlex)]

let property_box_flex : property_box_flex Rule.rule = Property_box_flex.rule

module Property_box_flex_group =
  [%spec_module
  "<integer>", (module Css_types.BoxFlexGroup)]

let property_box_flex_group : property_box_flex_group Rule.rule =
  Property_box_flex_group.rule

module Property_box_lines =
  [%spec_module
  "'single' | 'multiple'", (module Css_types.BoxLines)]

let property_box_lines : property_box_lines Rule.rule = Property_box_lines.rule

module Property_box_ordinal_group =
  [%spec_module
  "<integer>", (module Css_types.BoxOrdinalGroup)]

let property_box_ordinal_group : property_box_ordinal_group Rule.rule =
  Property_box_ordinal_group.rule

module Property_box_orient =
  [%spec_module
  "'horizontal' | 'vertical' | 'inline-axis' | 'block-axis' | 'inherit'",
  (module Css_types.BoxOrient)]

let property_box_orient : property_box_orient Rule.rule =
  Property_box_orient.rule

module Property_box_pack =
  [%spec_module
  "'start' | 'center' | 'end' | 'justify'", (module Css_types.BoxPack)]

let property_box_pack : property_box_pack Rule.rule = Property_box_pack.rule

module Property_box_shadow =
  [%spec_module
  "'none' | <interpolation> | [ <shadow> ]#", (module Css_types.BoxShadows)]

let property_box_shadow : property_box_shadow Rule.rule =
  Property_box_shadow.rule

module Property_box_sizing =
  [%spec_module
  "'content-box' | 'border-box'", (module Css_types.BoxSizing)]

let property_box_sizing : property_box_sizing Rule.rule =
  Property_box_sizing.rule

module Property_break_after =
  [%spec_module
  "'auto' | 'avoid' | 'always' | 'all' | 'avoid-page' | 'page' | 'left' | \
   'right' | 'recto' | 'verso' | 'avoid-column' | 'column' | 'avoid-region' | \
   'region'",
  (module Css_types.BreakAfter)]

let property_break_after : property_break_after Rule.rule =
  Property_break_after.rule

module Property_break_before =
  [%spec_module
  "'auto' | 'avoid' | 'always' | 'all' | 'avoid-page' | 'page' | 'left' | \
   'right' | 'recto' | 'verso' | 'avoid-column' | 'column' | 'avoid-region' | \
   'region'",
  (module Css_types.BreakBefore)]

let property_break_before : property_break_before Rule.rule =
  Property_break_before.rule

module Property_break_inside =
  [%spec_module
  "'auto' | 'avoid' | 'avoid-page' | 'avoid-column' | 'avoid-region'",
  (module Css_types.BreakInside)]

let property_break_inside : property_break_inside Rule.rule =
  Property_break_inside.rule

module Property_caption_side =
  [%spec_module
  "'top' | 'bottom' | 'block-start' | 'block-end' | 'inline-start' | \
   'inline-end'",
  (module Css_types.CaptionSide)]

let property_caption_side : property_caption_side Rule.rule =
  Property_caption_side.rule

module Property_caret_color =
  [%spec_module
  "'auto' | <color>", (module Css_types.CaretColor)]

let property_caret_color : property_caret_color Rule.rule =
  Property_caret_color.rule

module Property_clear =
  [%spec_module
  "'none' | 'left' | 'right' | 'both' | 'inline-start' | 'inline-end'",
  (module Css_types.Clear)]

let property_clear : property_clear Rule.rule = Property_clear.rule

module Property_clip =
  [%spec_module
  "<shape> | 'auto'", (module Css_types.Clip)]

let property_clip : property_clip Rule.rule = Property_clip.rule

module Property_clip_path =
  [%spec_module
  "<clip-source> | <basic-shape> || <geometry-box> | 'none'",
  (module Css_types.ClipPath)]

let property_clip_path : property_clip_path Rule.rule = Property_clip_path.rule

module Property_clip_rule =
  [%spec_module
  "'nonzero' | 'evenodd'", (module Css_types.ClipRule)]

let property_clip_rule : property_clip_rule Rule.rule = Property_clip_rule.rule

module Property_color = [%spec_module "<color>", (module Css_types.Color)]

let property_color : property_color Rule.rule = Property_color.rule

module Property_color_interpolation_filters =
  [%spec_module
  "'auto' | 'sRGB' | 'linearRGB'", (module Css_types.ColorInterpolationFilters)]

let property_color_interpolation_filters :
  property_color_interpolation_filters Rule.rule =
  Property_color_interpolation_filters.rule

module Property_color_interpolation =
  [%spec_module
  "'auto' | 'sRGB' | 'linearRGB'", (module Css_types.ColorInterpolation)]

let property_color_interpolation : property_color_interpolation Rule.rule =
  Property_color_interpolation.rule

module Property_color_adjust =
  [%spec_module
  "'economy' | 'exact'", (module Css_types.ColorAdjust)]

let property_color_adjust : property_color_adjust Rule.rule =
  Property_color_adjust.rule

module Property_column_count =
  [%spec_module
  "<integer> | 'auto'", (module Css_types.ColumnCount)]

let property_column_count : property_column_count Rule.rule =
  Property_column_count.rule

module Property_column_fill =
  [%spec_module
  "'auto' | 'balance' | 'balance-all'", (module Css_types.ColumnFill)]

let property_column_fill : property_column_fill Rule.rule =
  Property_column_fill.rule

module Property_column_gap =
  [%spec_module
  "'normal' | <extended-length> | <extended-percentage>", (module Css_types.Gap)]

let property_column_gap : property_column_gap Rule.rule =
  Property_column_gap.rule

module Property_column_rule =
  [%spec_module
  "<'column-rule-width'> || <'column-rule-style'> || <'column-rule-color'>",
  (module Css_types.ColumnRule)]

let property_column_rule : property_column_rule Rule.rule =
  Property_column_rule.rule

module Property_column_rule_color =
  [%spec_module
  "<color>", (module Css_types.ColumnRuleColor)]

let property_column_rule_color : property_column_rule_color Rule.rule =
  Property_column_rule_color.rule

module Property_column_rule_style =
  [%spec_module
  "<'border-style'>", (module Css_types.ColumnRuleStyle)]

let property_column_rule_style : property_column_rule_style Rule.rule =
  Property_column_rule_style.rule

module Property_column_rule_width =
  [%spec_module
  "<'border-width'>", (module Css_types.ColumnRuleWidth)]

let property_column_rule_width : property_column_rule_width Rule.rule =
  Property_column_rule_width.rule

module Property_column_span =
  [%spec_module
  "'none' | 'all'", (module Css_types.ColumnSpan)]

let property_column_span : property_column_span Rule.rule =
  Property_column_span.rule

module Property_column_width =
  [%spec_module
  "<extended-length> | 'auto'", (module Css_types.ColumnWidth)]

let property_column_width : property_column_width Rule.rule =
  Property_column_width.rule

module Property_columns =
  [%spec_module
  "<'column-width'> || <'column-count'>", (module Css_types.Columns)]

let property_columns : property_columns Rule.rule = Property_columns.rule

module Property_contain =
  [%spec_module
  "'none' | 'strict' | 'content' | 'size' || 'layout' || 'style' || 'paint'",
  (module Css_types.Contain)]

let property_contain : property_contain Rule.rule = Property_contain.rule

module Property_content =
  [%spec_module
  "'normal' | 'none' | <string> | <interpolation> | [ <content-replacement> | \
   <content-list> ] [ '/' <string> ]?",
  (module Css_types.Content)]

let property_content : property_content Rule.rule = Property_content.rule

module Property_content_visibility =
  [%spec_module
  "'visible' | 'hidden' | 'auto'", (module Css_types.ContentVisibility)]

let property_content_visibility : property_content_visibility Rule.rule =
  Property_content_visibility.rule

module Property_counter_increment =
  [%spec_module
  "[ <custom-ident> [ <integer> ]? ]+ | 'none'",
  (module Css_types.CounterIncrement)]

let property_counter_increment : property_counter_increment Rule.rule =
  Property_counter_increment.rule

module Property_counter_reset =
  [%spec_module
  "[ <custom-ident> [ <integer> ]? ]+ | 'none'", (module Css_types.CounterReset)]

let property_counter_reset : property_counter_reset Rule.rule =
  Property_counter_reset.rule

module Property_counter_set =
  [%spec_module
  "[ <custom-ident> [ <integer> ]? ]+ | 'none'", (module Css_types.CounterSet)]

let property_counter_set : property_counter_set Rule.rule =
  Property_counter_set.rule

module Property_cue =
  [%spec_module
  "<'cue-before'> [ <'cue-after'> ]?", (module Css_types.Cue)]

let property_cue : property_cue Rule.rule = Property_cue.rule

module Property_cue_after =
  [%spec_module
  "<url> [ <decibel> ]? | 'none'", (module Css_types.CueAfter)]

let property_cue_after : property_cue_after Rule.rule = Property_cue_after.rule

module Property_cue_before =
  [%spec_module
  "<url> [ <decibel> ]? | 'none'", (module Css_types.CueBefore)]

let property_cue_before : property_cue_before Rule.rule =
  Property_cue_before.rule

(* Removed [ <url> [ <x> <y> ]? ',' ]* from the original spec *)
module Property_cursor =
  [%spec_module
  "'auto' | 'default' | 'none' | 'context-menu' | 'help' | 'pointer' | \
   'progress' | 'wait' | 'cell' | 'crosshair' | 'text' | 'vertical-text' | \
   'alias' | 'copy' | 'move' | 'no-drop' | 'not-allowed' | 'e-resize' | \
   'n-resize' | 'ne-resize' | 'nw-resize' | 's-resize' | 'se-resize' | \
   'sw-resize' | 'w-resize' | 'ew-resize' | 'ns-resize' | 'nesw-resize' | \
   'nwse-resize' | 'col-resize' | 'row-resize' | 'all-scroll' | 'zoom-in' | \
   'zoom-out' | 'grab' | 'grabbing' | 'hand' | '-webkit-grab' | \
   '-webkit-grabbing' | '-webkit-zoom-in' | '-webkit-zoom-out' | '-moz-grab' | \
   '-moz-grabbing' | '-moz-zoom-in' | '-moz-zoom-out' | <interpolation>",
  (module Css_types.Cursor)]

let property_cursor : property_cursor Rule.rule = Property_cursor.rule

module Property_direction =
  [%spec_module
  "'ltr' | 'rtl'", (module Css_types.Direction)]

let property_direction : property_direction Rule.rule = Property_direction.rule

module Property_display =
  [%spec_module
  "'block' | 'contents' | 'flex' | 'flow' | 'flow-root' | 'grid' | 'inline' | \
   'inline-block' | 'inline-flex' | 'inline-grid' | 'inline-list-item' | \
   'inline-table' | 'list-item' | 'none' | 'ruby' | 'ruby-base' | \
   'ruby-base-container' | 'ruby-text' | 'ruby-text-container' | 'run-in' | \
   'table' | 'table-caption' | 'table-cell' | 'table-column' | \
   'table-column-group' | 'table-footer-group' | 'table-header-group' | \
   'table-row' | 'table-row-group' | '-webkit-flex' | '-webkit-inline-flex' | \
   '-webkit-box' | '-webkit-inline-box' | '-moz-inline-stack' | '-moz-box' | \
   '-moz-inline-box'",
  (module Css_types.Display)]

let property_display : property_display Rule.rule = Property_display.rule

module Property_dominant_baseline =
  [%spec_module
  "'auto' | 'use-script' | 'no-change' | 'reset-size' | 'ideographic' | \
   'alphabetic' | 'hanging' | 'mathematical' | 'central' | 'middle' | \
   'text-after-edge' | 'text-before-edge'",
  (module Css_types.DominantBaseline)]

let property_dominant_baseline : property_dominant_baseline Rule.rule =
  Property_dominant_baseline.rule

module Property_empty_cells =
  [%spec_module
  "'show' | 'hide'", (module Css_types.EmptyCells)]

let property_empty_cells : property_empty_cells Rule.rule =
  Property_empty_cells.rule

module Property_fill = [%spec_module "<paint>", (module Css_types.Paint)]

let property_fill : property_fill Rule.rule = Property_fill.rule

module Property_fill_opacity =
  [%spec_module
  "<alpha-value>", (module Css_types.FillOpacity)]

let property_fill_opacity : property_fill_opacity Rule.rule =
  Property_fill_opacity.rule

module Property_fill_rule =
  [%spec_module
  "'nonzero' | 'evenodd'", (module Css_types.FillRule)]

let property_fill_rule : property_fill_rule Rule.rule = Property_fill_rule.rule

module Property_filter =
  [%spec_module
  "'none' | <interpolation> | <filter-function-list>", (module Css_types.Filter)]

let property_filter : property_filter Rule.rule = Property_filter.rule

module Property_flex =
  [%spec_module
  "'none' | [<'flex-grow'> [ <'flex-shrink'> ]? || <'flex-basis'>] | \
   <interpolation>",
  (module Css_types.Flex)]

let property_flex : property_flex Rule.rule = Property_flex.rule

module Property_flex_basis =
  [%spec_module
  "'content' | <'width'> | <interpolation>", (module Css_types.FlexBasis)]

let property_flex_basis : property_flex_basis Rule.rule =
  Property_flex_basis.rule

module Property_flex_direction =
  [%spec_module
  "'row' | 'row-reverse' | 'column' | 'column-reverse'",
  (module Css_types.FlexDirection)]

let property_flex_direction : property_flex_direction Rule.rule =
  Property_flex_direction.rule

module Property_flex_flow =
  [%spec_module
  "<'flex-direction'> || <'flex-wrap'>", (module Css_types.FlexFlow)]

let property_flex_flow : property_flex_flow Rule.rule = Property_flex_flow.rule

module Property_flex_grow =
  [%spec_module
  "<number> | <interpolation>", (module Css_types.FlexGrow)]

let property_flex_grow : property_flex_grow Rule.rule = Property_flex_grow.rule

module Property_flex_shrink =
  [%spec_module
  "<number> | <interpolation>", (module Css_types.FlexShrink)]

let property_flex_shrink : property_flex_shrink Rule.rule =
  Property_flex_shrink.rule

module Property_flex_wrap =
  [%spec_module
  "'nowrap' | 'wrap' | 'wrap-reverse'", (module Css_types.FlexWrap)]

let property_flex_wrap : property_flex_wrap Rule.rule = Property_flex_wrap.rule

module Property_float =
  [%spec_module
  "'left' | 'right' | 'none' | 'inline-start' | 'inline-end'",
  (module Css_types.Float)]

let property_float : property_float Rule.rule = Property_float.rule

module Property_font =
  [%spec_module
  "[ <'font-style'> || <font-variant-css21> || <'font-weight'> || \
   <'font-stretch'> ]? <'font-size'> [ '/' <'line-height'> ]? <'font-family'> \
   | 'caption' | 'icon' | 'menu' | 'message-box' | 'small-caption' | \
   'status-bar'",
  (module Css_types.Font)]

let property_font : property_font Rule.rule = Property_font.rule

module Font_families =
  [%spec_module
  "[ <family-name> | <generic-family> | <interpolation> ]#",
  (module Css_types.FontFamily)]

let font_families : font_families Rule.rule = Font_families.rule

module Property_font_family =
  [%spec_module
  "<font_families> | <interpolation>", (module Css_types.FontFamily)]

let property_font_family : property_font_family Rule.rule =
  Property_font_family.rule

module Property_font_feature_settings =
  [%spec_module
  "'normal' | [ <feature-tag-value> ]#", (module Css_types.FontFeatureSettings)]

let property_font_feature_settings : property_font_feature_settings Rule.rule =
  Property_font_feature_settings.rule

module Property_font_display =
  [%spec_module
  "'auto' | 'block' | 'swap' | 'fallback' | 'optional'",
  (module Css_types.FontDisplay)]

let property_font_display : property_font_display Rule.rule =
  Property_font_display.rule

module Property_font_kerning =
  [%spec_module
  "'auto' | 'normal' | 'none'", (module Css_types.FontKerning)]

let property_font_kerning : property_font_kerning Rule.rule =
  Property_font_kerning.rule

module Property_font_language_override =
  [%spec_module
  "'normal' | <string>", (module Css_types.FontLanguageOverride)]

let property_font_language_override : property_font_language_override Rule.rule
    =
  Property_font_language_override.rule

module Property_font_optical_sizing =
  [%spec_module
  "'auto' | 'none'", (module Css_types.FontOpticalSizing)]

let property_font_optical_sizing : property_font_optical_sizing Rule.rule =
  Property_font_optical_sizing.rule

module Property_font_palette =
  [%spec_module
  "'normal' | 'light' | 'dark'", (module Css_types.FontPalette)]

let property_font_palette : property_font_palette Rule.rule =
  Property_font_palette.rule

module Property_font_size =
  [%spec_module
  "<absolute-size> | <relative-size> | <extended-length> | \
   <extended-percentage>",
  (module Css_types.FontSize)]

let property_font_size : property_font_size Rule.rule = Property_font_size.rule

module Property_font_size_adjust =
  [%spec_module
  "'none' | <number>", (module Css_types.FontSizeAdjust)]

let property_font_size_adjust : property_font_size_adjust Rule.rule =
  Property_font_size_adjust.rule

module Property_font_smooth =
  [%spec_module
  "'auto' | 'never' | 'always' | <absolute-size> | <extended-length>",
  (module Css_types.FontSmooth)]

let property_font_smooth : property_font_smooth Rule.rule =
  Property_font_smooth.rule

module Property_font_stretch =
  [%spec_module
  "<font-stretch-absolute>", (module Css_types.FontStretch)]

let property_font_stretch : property_font_stretch Rule.rule =
  Property_font_stretch.rule

module Property_font_style =
  [%spec_module
  "'normal' | 'italic' | 'oblique' | <interpolation> | [ 'oblique' \
   <extended-angle> ]?",
  (module Css_types.FontStyle)]

let property_font_style : property_font_style Rule.rule =
  Property_font_style.rule

module Property_font_synthesis =
  [%spec_module
  "'none' | [ 'weight' || 'style' || 'small-caps' || 'position' ]",
  (module Css_types.FontSynthesis)]

let property_font_synthesis : property_font_synthesis Rule.rule =
  Property_font_synthesis.rule

module Property_font_synthesis_weight =
  [%spec_module
  "'auto' | 'none'", (module Css_types.FontSynthesisWeight)]

let property_font_synthesis_weight : property_font_synthesis_weight Rule.rule =
  Property_font_synthesis_weight.rule

module Property_font_synthesis_style =
  [%spec_module
  "'auto' | 'none'", (module Css_types.FontSynthesisStyle)]

let property_font_synthesis_style : property_font_synthesis_style Rule.rule =
  Property_font_synthesis_style.rule

module Property_font_synthesis_small_caps =
  [%spec_module
  "'auto' | 'none'", (module Css_types.FontSynthesisSmallCaps)]

let property_font_synthesis_small_caps :
  property_font_synthesis_small_caps Rule.rule =
  Property_font_synthesis_small_caps.rule

module Property_font_synthesis_position =
  [%spec_module
  "'auto' | 'none'", (module Css_types.FontSynthesisPosition)]

let property_font_synthesis_position :
  property_font_synthesis_position Rule.rule =
  Property_font_synthesis_position.rule

module Property_font_variant =
  [%spec_module
  "'normal' | 'none' | 'small-caps' | <common-lig-values> || \
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
   || 'super' || 'text' || 'emoji' || 'unicode'",
  (module Css_types.FontVariant)]

let property_font_variant : property_font_variant Rule.rule =
  Property_font_variant.rule

module Property_font_variant_alternates =
  [%spec_module
  "'normal' | stylistic( <feature-value-name> ) || 'historical-forms' || \
   styleset( [ <feature-value-name> ]# ) || character-variant( [ \
   <feature-value-name> ]# ) || swash( <feature-value-name> ) || ornaments( \
   <feature-value-name> ) || annotation( <feature-value-name> )",
  (module Css_types.FontVariantAlternates)]

let property_font_variant_alternates :
  property_font_variant_alternates Rule.rule =
  Property_font_variant_alternates.rule

module Property_font_variant_caps =
  [%spec_module
  "'normal' | 'small-caps' | 'all-small-caps' | 'petite-caps' | \
   'all-petite-caps' | 'unicase' | 'titling-caps'",
  (module Css_types.FontVariantCaps)]

let property_font_variant_caps : property_font_variant_caps Rule.rule =
  Property_font_variant_caps.rule

module Property_font_variant_east_asian =
  [%spec_module
  "'normal' | <east-asian-variant-values> || <east-asian-width-values> || \
   'ruby'",
  (module Css_types.FontVariantEastAsian)]

let property_font_variant_east_asian :
  property_font_variant_east_asian Rule.rule =
  Property_font_variant_east_asian.rule

module Property_font_variant_ligatures =
  [%spec_module
  "'normal' | 'none' | <common-lig-values> || <discretionary-lig-values> || \
   <historical-lig-values> || <contextual-alt-values>",
  (module Css_types.FontVariantLigatures)]

let property_font_variant_ligatures : property_font_variant_ligatures Rule.rule
    =
  Property_font_variant_ligatures.rule

module Property_font_variant_numeric =
  [%spec_module
  "'normal' | <numeric-figure-values> || <numeric-spacing-values> || \
   <numeric-fraction-values> || 'ordinal' || 'slashed-zero'",
  (module Css_types.FontVariantNumeric)]

let property_font_variant_numeric : property_font_variant_numeric Rule.rule =
  Property_font_variant_numeric.rule

module Property_font_variant_position =
  [%spec_module
  "'normal' | 'sub' | 'super'", (module Css_types.FontVariantPosition)]

let property_font_variant_position : property_font_variant_position Rule.rule =
  Property_font_variant_position.rule

module Property_font_variation_settings =
  [%spec_module
  "'normal' | [ <string> <number> ]#", (module Css_types.FontVariationSettings)]

let property_font_variation_settings :
  property_font_variation_settings Rule.rule =
  Property_font_variation_settings.rule

module Property_font_variant_emoji =
  [%spec_module
  "'normal' | 'text' | 'emoji' | 'unicode'", (module Css_types.FontVariantEmoji)]

let property_font_variant_emoji : property_font_variant_emoji Rule.rule =
  Property_font_variant_emoji.rule

module Property_font_weight =
  [%spec_module
  "<font-weight-absolute> | 'bolder' | 'lighter' | <interpolation>",
  (module Css_types.FontWeight)]

let property_font_weight : property_font_weight Rule.rule =
  Property_font_weight.rule

module Property_gap =
  [%spec_module
  "<'row-gap'> [ <'column-gap'> ]?", (module Css_types.Gap)]

let property_gap : property_gap Rule.rule = Property_gap.rule

module Property_glyph_orientation_horizontal =
  [%spec_module
  "<extended-angle>", (module Css_types.GlyphOrientationHorizontal)]

let property_glyph_orientation_horizontal :
  property_glyph_orientation_horizontal Rule.rule =
  Property_glyph_orientation_horizontal.rule

module Property_glyph_orientation_vertical =
  [%spec_module
  "<extended-angle>", (module Css_types.GlyphOrientationVertical)]

let property_glyph_orientation_vertical :
  property_glyph_orientation_vertical Rule.rule =
  Property_glyph_orientation_vertical.rule

module Property_grid =
  [%spec_module
  "<'grid-template'> | <'grid-template-rows'> '/' [ 'auto-flow' && [ 'dense' \
   ]? ] [ <'grid-auto-columns'> ]? | [ 'auto-flow' && [ 'dense' ]? ] [ \
   <'grid-auto-rows'> ]? '/' <'grid-template-columns'>",
  (module Css_types.Grid)]

let property_grid : property_grid Rule.rule = Property_grid.rule

module Property_grid_area =
  [%spec_module
  "<grid-line> [ '/' <grid-line> ]{0,3}", (module Css_types.GridArea)]

let property_grid_area : property_grid_area Rule.rule = Property_grid_area.rule

module Property_grid_auto_columns =
  [%spec_module
  "[ <track-size> ]+", (module Css_types.GridAutoColumns)]

let property_grid_auto_columns : property_grid_auto_columns Rule.rule =
  Property_grid_auto_columns.rule

module Property_grid_auto_flow =
  [%spec_module
  "[ [ 'row' | 'column' ] || 'dense' ] | <interpolation>",
  (module Css_types.GridAutoFlow)]

let property_grid_auto_flow : property_grid_auto_flow Rule.rule =
  Property_grid_auto_flow.rule

module Property_grid_auto_rows =
  [%spec_module
  "[ <track-size> ]+", (module Css_types.GridAutoRows)]

let property_grid_auto_rows : property_grid_auto_rows Rule.rule =
  Property_grid_auto_rows.rule

module Property_grid_column =
  [%spec_module
  "<grid-line> [ '/' <grid-line> ]?", (module Css_types.GridColumn)]

let property_grid_column : property_grid_column Rule.rule =
  Property_grid_column.rule

module Property_grid_column_end =
  [%spec_module
  "<grid-line>", (module Css_types.GridColumnEnd)]

let property_grid_column_end : property_grid_column_end Rule.rule =
  Property_grid_column_end.rule

module Property_grid_column_gap =
  [%spec_module
  "<extended-length> | <extended-percentage>", (module Css_types.Gap)]

let property_grid_column_gap : property_grid_column_gap Rule.rule =
  Property_grid_column_gap.rule

module Property_grid_column_start =
  [%spec_module
  "<grid-line>", (module Css_types.GridColumnStart)]

let property_grid_column_start : property_grid_column_start Rule.rule =
  Property_grid_column_start.rule

module Property_grid_gap =
  [%spec_module
  "<'grid-row-gap'> [ <'grid-column-gap'> ]?", (module Css_types.Gap)]

let property_grid_gap : property_grid_gap Rule.rule = Property_grid_gap.rule

module Property_grid_row =
  [%spec_module
  "<grid-line> [ '/' <grid-line> ]?", (module Css_types.GridRow)]

let property_grid_row : property_grid_row Rule.rule = Property_grid_row.rule

module Property_grid_row_end =
  [%spec_module
  "<grid-line>", (module Css_types.GridRowEnd)]

let property_grid_row_end : property_grid_row_end Rule.rule =
  Property_grid_row_end.rule

module Property_grid_row_gap =
  [%spec_module
  "<extended-length> | <extended-percentage>", (module Css_types.Gap)]

let property_grid_row_gap : property_grid_row_gap Rule.rule =
  Property_grid_row_gap.rule

module Property_grid_row_start =
  [%spec_module
  "<grid-line>", (module Css_types.GridRowStart)]

let property_grid_row_start : property_grid_row_start Rule.rule =
  Property_grid_row_start.rule

module Property_grid_template =
  [%spec_module
  "'none' | <'grid-template-rows'> '/' <'grid-template-columns'> | [ [ \
   <line-names> ]? <string> [ <track-size> ]? [ <line-names> ]? ]+ [ '/' \
   <explicit-track-list> ]?",
  (module Css_types.GridTemplate)]

let property_grid_template : property_grid_template Rule.rule =
  Property_grid_template.rule

module Property_grid_template_areas =
  [%spec_module
  "'none' | [ <string> | <interpolation> ]+",
  (module Css_types.GridTemplateAreas)]

let property_grid_template_areas : property_grid_template_areas Rule.rule =
  Property_grid_template_areas.rule

module Property_grid_template_columns =
  [%spec_module
  "'none' | <track-list> | <auto-track-list> | 'subgrid' [ <line-name-list> ]? \
   | 'masonry' | <interpolation>",
  (module Css_types.GridTemplateColumns)]

let property_grid_template_columns : property_grid_template_columns Rule.rule =
  Property_grid_template_columns.rule

module Property_grid_template_rows =
  [%spec_module
  "'none' | <track-list> | <auto-track-list> | 'subgrid' [ <line-name-list> ]? \
   | 'masonry' | <interpolation>",
  (module Css_types.GridTemplateRows)]

let property_grid_template_rows : property_grid_template_rows Rule.rule =
  Property_grid_template_rows.rule

module Property_hanging_punctuation =
  [%spec_module
  "'none' | 'first' || [ 'force-end' | 'allow-end' ] || 'last'",
  (module Css_types.HangingPunctuation)]

let property_hanging_punctuation : property_hanging_punctuation Rule.rule =
  Property_hanging_punctuation.rule

module Property_height =
  [%spec_module
  "'auto' | <extended-length> | <extended-percentage> | 'min-content' | \
   'max-content' | 'fit-content' | fit-content( <extended-length> | \
   <extended-percentage> )",
  (module Css_types.Height)]

let property_height : property_height Rule.rule = Property_height.rule

module Property_hyphens =
  [%spec_module
  "'none' | 'manual' | 'auto'", (module Css_types.Hyphens)]

let property_hyphens : property_hyphens Rule.rule = Property_hyphens.rule

module Property_hyphenate_character =
  [%spec_module
  "'auto' | <string-token>", (module Css_types.HyphenateCharacter)]

let property_hyphenate_character : property_hyphenate_character Rule.rule =
  Property_hyphenate_character.rule

module Property_hyphenate_limit_chars =
  [%spec_module
  "'auto' | <integer>", (module Css_types.HyphenateLimitChars)]

let property_hyphenate_limit_chars : property_hyphenate_limit_chars Rule.rule =
  Property_hyphenate_limit_chars.rule

module Property_hyphenate_limit_lines =
  [%spec_module
  "'no-limit' | <integer>", (module Css_types.HyphenateLimitLines)]

let property_hyphenate_limit_lines : property_hyphenate_limit_lines Rule.rule =
  Property_hyphenate_limit_lines.rule

module Property_hyphenate_limit_zone =
  [%spec_module
  "<extended-length> | <extended-percentage>",
  (module Css_types.HyphenateLimitZone)]

let property_hyphenate_limit_zone : property_hyphenate_limit_zone Rule.rule =
  Property_hyphenate_limit_zone.rule

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

module Property_ime_mode =
  [%spec_module
  "'auto' | 'normal' | 'active' | 'inactive' | 'disabled'",
  (module Css_types.ImeMode)]

let property_ime_mode : property_ime_mode Rule.rule = Property_ime_mode.rule

module Property_initial_letter =
  [%spec_module
  "'normal' | <number> [ <integer> ]?", (module Css_types.InitialLetter)]

let property_initial_letter : property_initial_letter Rule.rule =
  Property_initial_letter.rule

module Property_initial_letter_align =
  [%spec_module
  "'auto' | 'alphabetic' | 'hanging' | 'ideographic'",
  (module Css_types.InitialLetterAlign)]

let property_initial_letter_align : property_initial_letter_align Rule.rule =
  Property_initial_letter_align.rule

module Property_inline_size =
  [%spec_module
  "<'width'>", (module Css_types.Length)]

let property_inline_size : property_inline_size Rule.rule =
  Property_inline_size.rule

module Property_inset =
  [%spec_module
  "[ <'top'> ]{1,4}", (module Css_types.Inset)]

let property_inset : property_inset Rule.rule = Property_inset.rule

module Property_inset_block =
  [%spec_module
  "[ <'top'> ]{1,2}", (module Css_types.InsetBlock)]

let property_inset_block : property_inset_block Rule.rule =
  Property_inset_block.rule

module Property_inset_block_end =
  [%spec_module
  "<'top'>", (module Css_types.Length)]

let property_inset_block_end : property_inset_block_end Rule.rule =
  Property_inset_block_end.rule

module Property_inset_block_start =
  [%spec_module
  "<'top'>", (module Css_types.Length)]

let property_inset_block_start : property_inset_block_start Rule.rule =
  Property_inset_block_start.rule

module Property_inset_inline =
  [%spec_module
  "[ <'top'> ]{1,2}", (module Css_types.InsetInline)]

let property_inset_inline : property_inset_inline Rule.rule =
  Property_inset_inline.rule

module Property_inset_inline_end =
  [%spec_module
  "<'top'>", (module Css_types.Length)]

let property_inset_inline_end : property_inset_inline_end Rule.rule =
  Property_inset_inline_end.rule

module Property_inset_inline_start =
  [%spec_module
  "<'top'>", (module Css_types.Length)]

let property_inset_inline_start : property_inset_inline_start Rule.rule =
  Property_inset_inline_start.rule

module Property_isolation =
  [%spec_module
  "'auto' | 'isolate'", (module Css_types.Isolation)]

let property_isolation : property_isolation Rule.rule = Property_isolation.rule

module Property_justify_content =
  [%spec_module
  "'normal' | <content-distribution> | [ <overflow-position> ]? [ \
   <content-position> | 'left' | 'right' ]",
  (module Css_types.JustifyContent)]

let property_justify_content : property_justify_content Rule.rule =
  Property_justify_content.rule

module Property_justify_items =
  [%spec_module
  "'normal' | 'stretch' | <baseline-position> | [ <overflow-position> ]? [ \
   <self-position> | 'left' | 'right' ] | 'legacy' | 'legacy' && [ 'left' | \
   'right' | 'center' ]",
  (module Css_types.JustifyItems)]

let property_justify_items : property_justify_items Rule.rule =
  Property_justify_items.rule

module Property_justify_self =
  [%spec_module
  "'auto' | 'normal' | 'stretch' | <baseline-position> | [ <overflow-position> \
   ]? [ <self-position> | 'left' | 'right' ]",
  (module Css_types.JustifySelf)]

let property_justify_self : property_justify_self Rule.rule =
  Property_justify_self.rule

module Property_kerning =
  [%spec_module
  "'auto' | <svg-length>", (module Css_types.Kerning)]

let property_kerning : property_kerning Rule.rule = Property_kerning.rule

module Property_layout_grid =
  [%spec_module
  "'auto' | <custom-ident> | <integer> && [ <custom-ident> ]?",
  (module Css_types.LayoutGrid)]

let property_layout_grid : property_layout_grid Rule.rule =
  Property_layout_grid.rule

module Property_layout_grid_char =
  [%spec_module
  "'auto' | <custom-ident> | <string>", (module Css_types.LayoutGridChar)]

let property_layout_grid_char : property_layout_grid_char Rule.rule =
  Property_layout_grid_char.rule

module Property_layout_grid_line =
  [%spec_module
  "'auto' | <custom-ident> | <string>", (module Css_types.LayoutGridLine)]

let property_layout_grid_line : property_layout_grid_line Rule.rule =
  Property_layout_grid_line.rule

module Property_layout_grid_mode =
  [%spec_module
  "'auto' | <custom-ident> | <string>", (module Css_types.LayoutGridMode)]

let property_layout_grid_mode : property_layout_grid_mode Rule.rule =
  Property_layout_grid_mode.rule

module Property_layout_grid_type =
  [%spec_module
  "'auto' | <custom-ident> | <string>", (module Css_types.LayoutGridType)]

let property_layout_grid_type : property_layout_grid_type Rule.rule =
  Property_layout_grid_type.rule

module Property_left =
  [%spec_module
  "<extended-length> | <extended-percentage> | 'auto'", (module Css_types.Left)]

let property_left : property_left Rule.rule = Property_left.rule

module Property_letter_spacing =
  [%spec_module
  "'normal' | <extended-length> | <extended-percentage>",
  (module Css_types.LetterSpacing)]

let property_letter_spacing : property_letter_spacing Rule.rule =
  Property_letter_spacing.rule

module Property_line_break =
  [%spec_module
  "'auto' | 'loose' | 'normal' | 'strict' | 'anywhere' | <interpolation>",
  (module Css_types.LineBreak)]

let property_line_break : property_line_break Rule.rule =
  Property_line_break.rule

module Property_line_clamp =
  [%spec_module
  "'none' | <integer>", (module Css_types.LineClamp)]

let property_line_clamp : property_line_clamp Rule.rule =
  Property_line_clamp.rule

module Property_line_height =
  [%spec_module
  "'normal' | <number> | <extended-length> | <extended-percentage>",
  (module Css_types.LineHeight)]

let property_line_height : property_line_height Rule.rule =
  Property_line_height.rule

module Property_line_height_step =
  [%spec_module
  "<extended-length>", (module Css_types.LineHeightStep)]

let property_line_height_step : property_line_height_step Rule.rule =
  Property_line_height_step.rule

module Property_list_style =
  [%spec_module
  "<'list-style-type'> || <'list-style-position'> || <'list-style-image'>",
  (module Css_types.ListStyle)]

let property_list_style : property_list_style Rule.rule =
  Property_list_style.rule

module Property_list_style_image =
  [%spec_module
  "'none' | <image>", (module Css_types.ListStyleImage)]

let property_list_style_image : property_list_style_image Rule.rule =
  Property_list_style_image.rule

module Property_list_style_position =
  [%spec_module
  "'inside' | 'outside'", (module Css_types.ListStylePosition)]

let property_list_style_position : property_list_style_position Rule.rule =
  Property_list_style_position.rule

module Property_list_style_type =
  [%spec_module
  "<counter-style> | <string> | 'none'", (module Css_types.ListStyleType)]

let property_list_style_type : property_list_style_type Rule.rule =
  Property_list_style_type.rule

module Property_margin =
  [%spec_module
  "[ <extended-length> | <extended-percentage> | 'auto' | <interpolation> \
   ]{1,4}",
  (module Css_types.Margin)]

let property_margin : property_margin Rule.rule = Property_margin.rule

module Property_margin_block =
  [%spec_module
  "[ <'margin-left'> ]{1,2}", (module Css_types.MarginBlock)]

let property_margin_block : property_margin_block Rule.rule =
  Property_margin_block.rule

module Property_margin_block_end =
  [%spec_module
  "<'margin-left'>", (module Css_types.Margin)]

let property_margin_block_end : property_margin_block_end Rule.rule =
  Property_margin_block_end.rule

module Property_margin_block_start =
  [%spec_module
  "<'margin-left'>", (module Css_types.Margin)]

let property_margin_block_start : property_margin_block_start Rule.rule =
  Property_margin_block_start.rule

module Property_margin_bottom =
  [%spec_module
  "<extended-length> | <extended-percentage> | 'auto'",
  (module Css_types.Margin)]

let property_margin_bottom : property_margin_bottom Rule.rule =
  Property_margin_bottom.rule

module Property_margin_inline =
  [%spec_module
  "[ <'margin-left'> ]{1,2}", (module Css_types.MarginInline)]

let property_margin_inline : property_margin_inline Rule.rule =
  Property_margin_inline.rule

module Property_margin_inline_end =
  [%spec_module
  "<'margin-left'>", (module Css_types.Margin)]

let property_margin_inline_end : property_margin_inline_end Rule.rule =
  Property_margin_inline_end.rule

module Property_margin_inline_start =
  [%spec_module
  "<'margin-left'>", (module Css_types.Margin)]

let property_margin_inline_start : property_margin_inline_start Rule.rule =
  Property_margin_inline_start.rule

module Property_margin_left =
  [%spec_module
  "<extended-length> | <extended-percentage> | 'auto'",
  (module Css_types.Margin)]

let property_margin_left : property_margin_left Rule.rule =
  Property_margin_left.rule

module Property_margin_right =
  [%spec_module
  "<extended-length> | <extended-percentage> | 'auto'",
  (module Css_types.Margin)]

let property_margin_right : property_margin_right Rule.rule =
  Property_margin_right.rule

module Property_margin_top =
  [%spec_module
  "<extended-length> | <extended-percentage> | 'auto'",
  (module Css_types.Margin)]

let property_margin_top : property_margin_top Rule.rule =
  Property_margin_top.rule

module Property_margin_trim =
  [%spec_module
  "'none' | 'in-flow' | 'all'", (module Css_types.MarginTrim)]

let property_margin_trim : property_margin_trim Rule.rule =
  Property_margin_trim.rule

module Property_marker =
  [%spec_module
  "'none' | <url>", (module Css_types.Marker)]

let property_marker : property_marker Rule.rule = Property_marker.rule

module Property_marker_end =
  [%spec_module
  "'none' | <url>", (module Css_types.MarkerEnd)]

let property_marker_end : property_marker_end Rule.rule =
  Property_marker_end.rule

module Property_marker_mid =
  [%spec_module
  "'none' | <url>", (module Css_types.MarkerMid)]

let property_marker_mid : property_marker_mid Rule.rule =
  Property_marker_mid.rule

module Property_marker_start =
  [%spec_module
  "'none' | <url>", (module Css_types.MarkerStart)]

let property_marker_start : property_marker_start Rule.rule =
  Property_marker_start.rule

module Property_mask =
  [%spec_module
  "[ <mask-layer> ]#", (module Css_types.Mask)]

let property_mask : property_mask Rule.rule = Property_mask.rule

module Property_mask_border =
  [%spec_module
  "<'mask-border-source'> || <'mask-border-slice'> [ '/' [ \
   <'mask-border-width'> ]? [ '/' <'mask-border-outset'> ]? ]? || \
   <'mask-border-repeat'> || <'mask-border-mode'>",
  (module Css_types.MaskBorder)]

let property_mask_border : property_mask_border Rule.rule =
  Property_mask_border.rule

module Property_mask_border_mode =
  [%spec_module
  "'luminance' | 'alpha'", (module Css_types.MaskBorderMode)]

let property_mask_border_mode : property_mask_border_mode Rule.rule =
  Property_mask_border_mode.rule

module Property_mask_border_outset =
  [%spec_module
  "[ <extended-length> | <number> ]{1,4}", (module Css_types.MaskBorderOutset)]

let property_mask_border_outset : property_mask_border_outset Rule.rule =
  Property_mask_border_outset.rule

module Property_mask_border_repeat =
  [%spec_module
  "[ 'stretch' | 'repeat' | 'round' | 'space' ]{1,2}",
  (module Css_types.MaskBorderRepeat)]

let property_mask_border_repeat : property_mask_border_repeat Rule.rule =
  Property_mask_border_repeat.rule

module Property_mask_border_slice =
  [%spec_module
  "[ <number-percentage> ]{1,4} [ 'fill' ]?", (module Css_types.MaskBorderSlice)]

let property_mask_border_slice : property_mask_border_slice Rule.rule =
  Property_mask_border_slice.rule

module Property_mask_border_source =
  [%spec_module
  "'none' | <image>", (module Css_types.MaskBorderSource)]

let property_mask_border_source : property_mask_border_source Rule.rule =
  Property_mask_border_source.rule

module Property_mask_border_width =
  [%spec_module
  "[ <extended-length> | <extended-percentage> | <number> | 'auto' ]{1,4}",
  (module Css_types.MaskBorderWidth)]

let property_mask_border_width : property_mask_border_width Rule.rule =
  Property_mask_border_width.rule

module Property_mask_clip =
  [%spec_module
  "[ <geometry-box> | 'no-clip' ]#", (module Css_types.MaskClip)]

let property_mask_clip : property_mask_clip Rule.rule = Property_mask_clip.rule

module Property_mask_composite =
  [%spec_module
  "[ <compositing-operator> ]#", (module Css_types.MaskComposite)]

let property_mask_composite : property_mask_composite Rule.rule =
  Property_mask_composite.rule

module Property_mask_image =
  [%spec_module
  "[ <mask-reference> ]#", (module Css_types.MaskImage)]

let property_mask_image : property_mask_image Rule.rule =
  Property_mask_image.rule

module Property_mask_mode =
  [%spec_module
  "[ <masking-mode> ]#", (module Css_types.MaskMode)]

let property_mask_mode : property_mask_mode Rule.rule = Property_mask_mode.rule

module Property_mask_origin =
  [%spec_module
  "[ <geometry-box> ]#", (module Css_types.MaskOrigin)]

let property_mask_origin : property_mask_origin Rule.rule =
  Property_mask_origin.rule

module Property_mask_position =
  [%spec_module
  "[ <position> ]#", (module Css_types.MaskPosition)]

let property_mask_position : property_mask_position Rule.rule =
  Property_mask_position.rule

module Property_mask_repeat =
  [%spec_module
  "[ <repeat-style> ]#", (module Css_types.MaskRepeat)]

let property_mask_repeat : property_mask_repeat Rule.rule =
  Property_mask_repeat.rule

module Property_mask_size =
  [%spec_module
  "[ <bg-size> ]#", (module Css_types.MaskSize)]

let property_mask_size : property_mask_size Rule.rule = Property_mask_size.rule

module Property_mask_type =
  [%spec_module
  "'luminance' | 'alpha'", (module Css_types.MaskType)]

let property_mask_type : property_mask_type Rule.rule = Property_mask_type.rule

module Property_masonry_auto_flow =
  [%spec_module
  "[ 'pack' | 'next' ] || [ 'definite-first' | 'ordered' ]",
  (module Css_types.MasonryAutoFlow)]

let property_masonry_auto_flow : property_masonry_auto_flow Rule.rule =
  Property_masonry_auto_flow.rule

module Property_max_block_size =
  [%spec_module
  "<'max-width'>", (module Css_types.Length)]

let property_max_block_size : property_max_block_size Rule.rule =
  Property_max_block_size.rule

module Property_max_height =
  [%spec_module
  "'auto' | <extended-length> | <extended-percentage> | 'min-content' | \
   'max-content' | 'fit-content' | fit-content( <extended-length> | \
   <extended-percentage> )",
  (module Css_types.MaxHeight)]

let property_max_height : property_max_height Rule.rule =
  Property_max_height.rule

module Property_max_inline_size =
  [%spec_module
  "<'max-width'>", (module Css_types.Length)]

let property_max_inline_size : property_max_inline_size Rule.rule =
  Property_max_inline_size.rule

module Property_max_lines =
  [%spec_module
  "'none' | <integer>", (module Css_types.MaxLines)]

let property_max_lines : property_max_lines Rule.rule = Property_max_lines.rule

module Property_max_width =
  [%spec_module
  "<extended-length> | <extended-percentage> | 'none' | 'max-content' | \
   'min-content' | 'fit-content' | fit-content( <extended-length> | \
   <extended-percentage> ) | 'fill-available' | <-non-standard-width>",
  (module Css_types.MaxWidth)]

let property_max_width : property_max_width Rule.rule = Property_max_width.rule

module Property_min_block_size =
  [%spec_module
  "<'min-width'>", (module Css_types.Length)]

let property_min_block_size : property_min_block_size Rule.rule =
  Property_min_block_size.rule

module Property_min_height =
  [%spec_module
  "'auto' | <extended-length> | <extended-percentage> | 'min-content' | \
   'max-content' | 'fit-content' | fit-content( <extended-length> | \
   <extended-percentage> )",
  (module Css_types.MinHeight)]

let property_min_height : property_min_height Rule.rule =
  Property_min_height.rule

module Property_min_inline_size =
  [%spec_module
  "<'min-width'>", (module Css_types.Length)]

let property_min_inline_size : property_min_inline_size Rule.rule =
  Property_min_inline_size.rule

module Property_min_width =
  [%spec_module
  "<extended-length> | <extended-percentage> | 'auto' | 'max-content' | \
   'min-content' | 'fit-content' | fit-content( <extended-length> | \
   <extended-percentage> ) | 'fill-available' | <-non-standard-width>",
  (module Css_types.MinWidth)]

let property_min_width : property_min_width Rule.rule = Property_min_width.rule

module Property_mix_blend_mode =
  [%spec_module
  "<blend-mode>", (module Css_types.MixBlendMode)]

let property_mix_blend_mode : property_mix_blend_mode Rule.rule =
  Property_mix_blend_mode.rule

module Property_media_any_hover =
  [%spec_module
  "none | hover", (module Css_types.MediaAnyHover)]

let property_media_any_hover : property_media_any_hover Rule.rule =
  Property_media_any_hover.rule

module Property_media_any_pointer =
  [%spec_module
  "none | coarse | fine", (module Css_types.MediaAnyPointer)]

let property_media_any_pointer : property_media_any_pointer Rule.rule =
  Property_media_any_pointer.rule

module Property_media_pointer =
  [%spec_module
  "none | coarse | fine", (module Css_types.MediaPointer)]

let property_media_pointer : property_media_pointer Rule.rule =
  Property_media_pointer.rule

module Property_media_max_aspect_ratio =
  [%spec_module
  "<ratio>", (module Css_types.MediaMaxAspectRatio)]

let property_media_max_aspect_ratio : property_media_max_aspect_ratio Rule.rule
    =
  Property_media_max_aspect_ratio.rule

module Property_media_min_aspect_ratio =
  [%spec_module
  "<ratio>", (module Css_types.MediaMinAspectRatio)]

let property_media_min_aspect_ratio : property_media_min_aspect_ratio Rule.rule
    =
  Property_media_min_aspect_ratio.rule

module Property_media_min_color =
  [%spec_module
  "<integer>", (module Css_types.MediaMinColor)]

let property_media_min_color : property_media_min_color Rule.rule =
  Property_media_min_color.rule

module Property_media_color_gamut =
  [%spec_module
  "'srgb' | 'p3' | 'rec2020'", (module Css_types.MediaColorGamut)]

let property_media_color_gamut : property_media_color_gamut Rule.rule =
  Property_media_color_gamut.rule

module Property_media_color_index =
  [%spec_module
  "<integer>", (module Css_types.MediaColorIndex)]

let property_media_color_index : property_media_color_index Rule.rule =
  Property_media_color_index.rule

module Property_media_min_color_index =
  [%spec_module
  "<integer>", (module Css_types.MediaMinColorIndex)]

let property_media_min_color_index : property_media_min_color_index Rule.rule =
  Property_media_min_color_index.rule

module Property_media_display_mode =
  [%spec_module
  "'fullscreen' | 'standalone' | 'minimal-ui' | 'browser'",
  (module Css_types.MediaDisplayMode)]

let property_media_display_mode : property_media_display_mode Rule.rule =
  Property_media_display_mode.rule

module Property_media_forced_colors =
  [%spec_module
  "'none' | 'active'", (module Css_types.MediaForcedColors)]

let property_media_forced_colors : property_media_forced_colors Rule.rule =
  Property_media_forced_colors.rule

module Property_forced_color_adjust =
  [%spec_module
  "'auto' | 'none' | 'preserve-parent-color'",
  (module Css_types.ForcedColorAdjust)]

let property_forced_color_adjust : property_forced_color_adjust Rule.rule =
  Property_forced_color_adjust.rule

module Property_media_grid =
  [%spec_module
  "<integer>", (module Css_types.MediaGrid)]

let property_media_grid : property_media_grid Rule.rule =
  Property_media_grid.rule

module Property_media_hover =
  [%spec_module
  "'hover' | 'none'", (module Css_types.MediaHover)]

let property_media_hover : property_media_hover Rule.rule =
  Property_media_hover.rule

module Property_media_inverted_colors =
  [%spec_module
  "'inverted' | 'none'", (module Css_types.MediaInvertedColors)]

let property_media_inverted_colors : property_media_inverted_colors Rule.rule =
  Property_media_inverted_colors.rule

module Property_media_monochrome =
  [%spec_module
  "<integer>", (module Css_types.MediaMonochrome)]

let property_media_monochrome : property_media_monochrome Rule.rule =
  Property_media_monochrome.rule

module Property_media_prefers_color_scheme =
  [%spec_module
  "'dark' | 'light'", (module Css_types.MediaPrefersColorScheme)]

let property_media_prefers_color_scheme :
  property_media_prefers_color_scheme Rule.rule =
  Property_media_prefers_color_scheme.rule

module Property_color_scheme =
  [%spec_module
  "'normal' | [ 'dark' | 'light' | <custom-ident> ]+ && 'only'?",
  (module Css_types.ColorScheme)]

let property_color_scheme : property_color_scheme Rule.rule =
  Property_color_scheme.rule

module Property_media_prefers_contrast =
  [%spec_module
  "'no-preference' | 'more' | 'less'", (module Css_types.MediaPrefersContrast)]

let property_media_prefers_contrast : property_media_prefers_contrast Rule.rule
    =
  Property_media_prefers_contrast.rule

module Property_media_prefers_reduced_motion =
  [%spec_module
  "'no-preference' | 'reduce'", (module Css_types.MediaPrefersReducedMotion)]

let property_media_prefers_reduced_motion :
  property_media_prefers_reduced_motion Rule.rule =
  Property_media_prefers_reduced_motion.rule

module Property_media_resolution =
  [%spec_module
  "<resolution>", (module Css_types.MediaResolution)]

let property_media_resolution : property_media_resolution Rule.rule =
  Property_media_resolution.rule

module Property_media_min_resolution =
  [%spec_module
  "<resolution>", (module Css_types.MediaMinResolution)]

let property_media_min_resolution : property_media_min_resolution Rule.rule =
  Property_media_min_resolution.rule

module Property_media_max_resolution =
  [%spec_module
  "<resolution>", (module Css_types.MediaMaxResolution)]

let property_media_max_resolution : property_media_max_resolution Rule.rule =
  Property_media_max_resolution.rule

module Property_media_scripting =
  [%spec_module
  "'none' | 'initial-only' | 'enabled'", (module Css_types.MediaScripting)]

let property_media_scripting : property_media_scripting Rule.rule =
  Property_media_scripting.rule

module Property_media_update =
  [%spec_module
  "'none' | 'slow' | 'fast'", (module Css_types.MediaUpdate)]

let property_media_update : property_media_update Rule.rule =
  Property_media_update.rule

module Property_media_orientation =
  [%spec_module
  "'portrait' | 'landscape'", (module Css_types.MediaOrientation)]

let property_media_orientation : property_media_orientation Rule.rule =
  Property_media_orientation.rule

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

module Property_offset =
  [%spec_module
  "[ <'offset-position'>? [ <'offset-path'> [ <'offset-distance'> || \
   <'offset-rotate'> ]? ]? ]? [ '/' <'offset-anchor'> ]?",
  (module Css_types.Offset)]

let property_offset : property_offset Rule.rule = Property_offset.rule

module Property_offset_anchor =
  [%spec_module
  "'auto' | <position>", (module Css_types.OffsetAnchor)]

let property_offset_anchor : property_offset_anchor Rule.rule =
  Property_offset_anchor.rule

module Property_offset_distance =
  [%spec_module
  "<extended-length> | <extended-percentage>", (module Css_types.OffsetDistance)]

let property_offset_distance : property_offset_distance Rule.rule =
  Property_offset_distance.rule

module Property_offset_path =
  [%spec_module
  "'none' | ray( <extended-angle> && [ <ray-size> ]? && [ 'contain' ]? ) | \
   <path()> | <url> | <basic-shape> || <geometry-box>",
  (module Css_types.OffsetPath)]

let property_offset_path : property_offset_path Rule.rule =
  Property_offset_path.rule

module Property_offset_position =
  [%spec_module
  "'auto' | <position>", (module Css_types.OffsetPosition)]

let property_offset_position : property_offset_position Rule.rule =
  Property_offset_position.rule

module Property_offset_rotate =
  [%spec_module
  "[ 'auto' | 'reverse' ] || <extended-angle>", (module Css_types.OffsetRotate)]

let property_offset_rotate : property_offset_rotate Rule.rule =
  Property_offset_rotate.rule

module Property_opacity =
  [%spec_module
  "<alpha-value>", (module Css_types.Opacity)]

let property_opacity : property_opacity Rule.rule = Property_opacity.rule

module Property_order = [%spec_module "<integer>", (module Css_types.Order)]

let property_order : property_order Rule.rule = Property_order.rule

module Property_orphans = [%spec_module "<integer>", (module Css_types.Orphans)]

let property_orphans : property_orphans Rule.rule = Property_orphans.rule

module Property_outline =
  [%spec_module
  "'none' | <'outline-width'> | [ <'outline-width'> <'outline-style'> ] | [ \
   <'outline-width'> <'outline-style'> [ <color> | <interpolation> ]]",
  (module Css_types.Outline)]

let property_outline : property_outline Rule.rule = Property_outline.rule

module Property_outline_color =
  [%spec_module
  "<color>", (module Css_types.Color)]

let property_outline_color : property_outline_color Rule.rule =
  Property_outline_color.rule

module Property_outline_offset =
  [%spec_module
  "<extended-length>", (module Css_types.Length)]

let property_outline_offset : property_outline_offset Rule.rule =
  Property_outline_offset.rule

module Property_outline_style =
  [%spec_module
  "'auto' | <line-style> | <interpolation>", (module Css_types.OutlineStyle)]

let property_outline_style : property_outline_style Rule.rule =
  Property_outline_style.rule

module Property_outline_width =
  [%spec_module
  "<line-width> | <interpolation>", (module Css_types.LineWidth)]

let property_outline_width : property_outline_width Rule.rule =
  Property_outline_width.rule

module Property_overflow =
  [%spec_module
  "[ 'visible' | 'hidden' | 'clip' | 'scroll' | 'auto' ]{1,2} | \
   <-non-standard-overflow> | <interpolation>",
  (module Css_types.Overflow)]

let property_overflow : property_overflow Rule.rule = Property_overflow.rule

module Property_overflow_anchor =
  [%spec_module
  "'auto' | 'none'", (module Css_types.OverflowAnchor)]

let property_overflow_anchor : property_overflow_anchor Rule.rule =
  Property_overflow_anchor.rule

module Property_overflow_block =
  [%spec_module
  "'visible' | 'hidden' | 'clip' | 'scroll' | 'auto' | <interpolation>",
  (module Css_types.OverflowBlock)]

let property_overflow_block : property_overflow_block Rule.rule =
  Property_overflow_block.rule

module Property_overflow_clip_margin =
  [%spec_module
  "<visual-box> || <extended-length>", (module Css_types.OverflowClipMargin)]

let property_overflow_clip_margin : property_overflow_clip_margin Rule.rule =
  Property_overflow_clip_margin.rule

module Property_overflow_inline =
  [%spec_module
  "'visible' | 'hidden' | 'clip' | 'scroll' | 'auto' | <interpolation>",
  (module Css_types.OverflowInline)]

let property_overflow_inline : property_overflow_inline Rule.rule =
  Property_overflow_inline.rule

module Property_overflow_wrap =
  [%spec_module
  "'normal' | 'break-word' | 'anywhere'", (module Css_types.OverflowWrap)]

let property_overflow_wrap : property_overflow_wrap Rule.rule =
  Property_overflow_wrap.rule

module Property_overflow_x =
  [%spec_module
  "'visible' | 'hidden' | 'clip' | 'scroll' | 'auto' | <interpolation>",
  (module Css_types.OverflowX)]

let property_overflow_x : property_overflow_x Rule.rule =
  Property_overflow_x.rule

module Property_overflow_y =
  [%spec_module
  "'visible' | 'hidden' | 'clip' | 'scroll' | 'auto' | <interpolation>",
  (module Css_types.OverflowY)]

let property_overflow_y : property_overflow_y Rule.rule =
  Property_overflow_y.rule

module Property_overscroll_behavior =
  [%spec_module
  "[ 'contain' | 'none' | 'auto' ]{1,2}", (module Css_types.OverscrollBehavior)]

let property_overscroll_behavior : property_overscroll_behavior Rule.rule =
  Property_overscroll_behavior.rule

module Property_overscroll_behavior_block =
  [%spec_module
  "'contain' | 'none' | 'auto'", (module Css_types.OverscrollBehaviorBlock)]

let property_overscroll_behavior_block :
  property_overscroll_behavior_block Rule.rule =
  Property_overscroll_behavior_block.rule

module Property_overscroll_behavior_inline =
  [%spec_module
  "'contain' | 'none' | 'auto'", (module Css_types.OverscrollBehaviorInline)]

let property_overscroll_behavior_inline :
  property_overscroll_behavior_inline Rule.rule =
  Property_overscroll_behavior_inline.rule

module Property_overscroll_behavior_x =
  [%spec_module
  "'contain' | 'none' | 'auto'", (module Css_types.OverscrollBehaviorX)]

let property_overscroll_behavior_x : property_overscroll_behavior_x Rule.rule =
  Property_overscroll_behavior_x.rule

module Property_overscroll_behavior_y =
  [%spec_module
  "'contain' | 'none' | 'auto'", (module Css_types.OverscrollBehaviorY)]

let property_overscroll_behavior_y : property_overscroll_behavior_y Rule.rule =
  Property_overscroll_behavior_y.rule

module Property_padding =
  [%spec_module
  "[ <extended-length> | <extended-percentage> | <interpolation> ]{1,4}",
  (module Css_types.Padding)]

let property_padding : property_padding Rule.rule = Property_padding.rule

module Property_padding_block =
  [%spec_module
  "[ <'padding-left'> ]{1,2}", (module Css_types.PaddingBlock)]

let property_padding_block : property_padding_block Rule.rule =
  Property_padding_block.rule

module Property_padding_block_end =
  [%spec_module
  "<'padding-left'>", (module Css_types.Length)]

let property_padding_block_end : property_padding_block_end Rule.rule =
  Property_padding_block_end.rule

module Property_padding_block_start =
  [%spec_module
  "<'padding-left'>", (module Css_types.Length)]

let property_padding_block_start : property_padding_block_start Rule.rule =
  Property_padding_block_start.rule

module Property_padding_bottom =
  [%spec_module
  "<extended-length> | <extended-percentage>", (module Css_types.Length)]

let property_padding_bottom : property_padding_bottom Rule.rule =
  Property_padding_bottom.rule

module Property_padding_inline =
  [%spec_module
  "[ <'padding-left'> ]{1,2}", (module Css_types.PaddingInline)]

let property_padding_inline : property_padding_inline Rule.rule =
  Property_padding_inline.rule

module Property_padding_inline_end =
  [%spec_module
  "<'padding-left'>", (module Css_types.Length)]

let property_padding_inline_end : property_padding_inline_end Rule.rule =
  Property_padding_inline_end.rule

module Property_padding_inline_start =
  [%spec_module
  "<'padding-left'>", (module Css_types.Length)]

let property_padding_inline_start : property_padding_inline_start Rule.rule =
  Property_padding_inline_start.rule

module Property_padding_left =
  [%spec_module
  "<extended-length> | <extended-percentage>", (module Css_types.Length)]

let property_padding_left : property_padding_left Rule.rule =
  Property_padding_left.rule

module Property_padding_right =
  [%spec_module
  "<extended-length> | <extended-percentage>", (module Css_types.Length)]

let property_padding_right : property_padding_right Rule.rule =
  Property_padding_right.rule

module Property_padding_top =
  [%spec_module
  "<extended-length> | <extended-percentage>", (module Css_types.Length)]

let property_padding_top : property_padding_top Rule.rule =
  Property_padding_top.rule

module Property_page_break_after =
  [%spec_module
  "'auto' | 'always' | 'avoid' | 'left' | 'right' | 'recto' | 'verso'",
  (module Css_types.PageBreakAfter)]

let property_page_break_after : property_page_break_after Rule.rule =
  Property_page_break_after.rule

module Property_page_break_before =
  [%spec_module
  "'auto' | 'always' | 'avoid' | 'left' | 'right' | 'recto' | 'verso'",
  (module Css_types.PageBreakBefore)]

let property_page_break_before : property_page_break_before Rule.rule =
  Property_page_break_before.rule

module Property_page_break_inside =
  [%spec_module
  "'auto' | 'avoid'", (module Css_types.PageBreakInside)]

let property_page_break_inside : property_page_break_inside Rule.rule =
  Property_page_break_inside.rule

module Property_paint_order =
  [%spec_module
  "'normal' | 'fill' || 'stroke' || 'markers'", (module Css_types.PaintOrder)]

let property_paint_order : property_paint_order Rule.rule =
  Property_paint_order.rule

module Property_pause =
  [%spec_module
  "<'pause-before'> [ <'pause-after'> ]?", (module Css_types.Pause)]

let property_pause : property_pause Rule.rule = Property_pause.rule

module Property_pause_after =
  [%spec_module
  "<extended-time> | 'none' | 'x-weak' | 'weak' | 'medium' | 'strong' | \
   'x-strong'",
  (module Css_types.PauseAfter)]

let property_pause_after : property_pause_after Rule.rule =
  Property_pause_after.rule

module Property_pause_before =
  [%spec_module
  "<extended-time> | 'none' | 'x-weak' | 'weak' | 'medium' | 'strong' | \
   'x-strong'",
  (module Css_types.PauseBefore)]

let property_pause_before : property_pause_before Rule.rule =
  Property_pause_before.rule

module Property_perspective =
  [%spec_module
  "'none' | <extended-length>", (module Css_types.Perspective)]

let property_perspective : property_perspective Rule.rule =
  Property_perspective.rule

module Property_perspective_origin =
  [%spec_module
  "<position>", (module Css_types.PerspectiveOrigin)]

let property_perspective_origin : property_perspective_origin Rule.rule =
  Property_perspective_origin.rule

module Property_place_content =
  [%spec_module
  "<'align-content'> [ <'justify-content'> ]?", (module Css_types.PlaceContent)]

let property_place_content : property_place_content Rule.rule =
  Property_place_content.rule

module Property_place_items =
  [%spec_module
  "<'align-items'> [ <'justify-items'> ]?", (module Css_types.PlaceItems)]

let property_place_items : property_place_items Rule.rule =
  Property_place_items.rule

module Property_place_self =
  [%spec_module
  "<'align-self'> [ <'justify-self'> ]?", (module Css_types.PlaceSelf)]

let property_place_self : property_place_self Rule.rule =
  Property_place_self.rule

module Property_pointer_events =
  [%spec_module
  "'auto' | 'none' | 'visiblePainted' | 'visibleFill' | 'visibleStroke' | \
   'visible' | 'painted' | 'fill' | 'stroke' | 'all' | 'inherit'",
  (module Css_types.PointerEvents)]

let property_pointer_events : property_pointer_events Rule.rule =
  Property_pointer_events.rule

module Property_position =
  [%spec_module
  "'static' | 'relative' | 'absolute' | 'sticky' | 'fixed' | '-webkit-sticky'",
  (module Css_types.Position)]

let property_position : property_position Rule.rule = Property_position.rule

module Property_quotes =
  [%spec_module
  "'none' | 'auto' | [ <string> <string> ]+", (module Css_types.Quotes)]

let property_quotes : property_quotes Rule.rule = Property_quotes.rule

module Property_resize =
  [%spec_module
  "'none' | 'both' | 'horizontal' | 'vertical' | 'block' | 'inline'",
  (module Css_types.Resize)]

let property_resize : property_resize Rule.rule = Property_resize.rule

module Property_rest =
  [%spec_module
  "<'rest-before'> [ <'rest-after'> ]?", (module Css_types.Rest)]

let property_rest : property_rest Rule.rule = Property_rest.rule

module Property_rest_after =
  [%spec_module
  "<extended-time> | 'none' | 'x-weak' | 'weak' | 'medium' | 'strong' | \
   'x-strong'",
  (module Css_types.RestAfter)]

let property_rest_after : property_rest_after Rule.rule =
  Property_rest_after.rule

module Property_rest_before =
  [%spec_module
  "<extended-time> | 'none' | 'x-weak' | 'weak' | 'medium' | 'strong' | \
   'x-strong'",
  (module Css_types.RestBefore)]

let property_rest_before : property_rest_before Rule.rule =
  Property_rest_before.rule

module Property_right =
  [%spec_module
  "<extended-length> | <extended-percentage> | 'auto'", (module Css_types.Right)]

let property_right : property_right Rule.rule = Property_right.rule

module Property_rotate =
  [%spec_module
  "'none' | <extended-angle> | [ 'x' | 'y' | 'z' | [ <number> ]{3} ] && \
   <extended-angle>",
  (module Css_types.Rotate)]

let property_rotate : property_rotate Rule.rule = Property_rotate.rule

module Property_row_gap =
  [%spec_module
  "'normal' | <extended-length> | <extended-percentage>", (module Css_types.Gap)]

let property_row_gap : property_row_gap Rule.rule = Property_row_gap.rule

module Property_ruby_align =
  [%spec_module
  "'start' | 'center' | 'space-between' | 'space-around'",
  (module Css_types.RubyAlign)]

let property_ruby_align : property_ruby_align Rule.rule =
  Property_ruby_align.rule

module Property_ruby_merge =
  [%spec_module
  "'separate' | 'collapse' | 'auto'", (module Css_types.RubyMerge)]

let property_ruby_merge : property_ruby_merge Rule.rule =
  Property_ruby_merge.rule

module Property_ruby_position =
  [%spec_module
  "'over' | 'under' | 'inter-character'", (module Css_types.RubyPosition)]

let property_ruby_position : property_ruby_position Rule.rule =
  Property_ruby_position.rule

module Property_scale =
  [%spec_module
  "'none' | [ <number-percentage> ]{1,3}", (module Css_types.Scale)]

let property_scale : property_scale Rule.rule = Property_scale.rule

module Property_scroll_behavior =
  [%spec_module
  "'auto' | 'smooth'", (module Css_types.ScrollBehavior)]

let property_scroll_behavior : property_scroll_behavior Rule.rule =
  Property_scroll_behavior.rule

module Property_scroll_margin =
  [%spec_module
  "[ <extended-length> ]{1,4}", (module Css_types.ScrollMargin)]

let property_scroll_margin : property_scroll_margin Rule.rule =
  Property_scroll_margin.rule

module Property_scroll_margin_block =
  [%spec_module
  "[ <extended-length> ]{1,2}", (module Css_types.Length)]

let property_scroll_margin_block : property_scroll_margin_block Rule.rule =
  Property_scroll_margin_block.rule

module Property_scroll_margin_block_end =
  [%spec_module
  "<extended-length>", (module Css_types.Length)]

let property_scroll_margin_block_end :
  property_scroll_margin_block_end Rule.rule =
  Property_scroll_margin_block_end.rule

module Property_scroll_margin_block_start =
  [%spec_module
  "<extended-length>", (module Css_types.Length)]

let property_scroll_margin_block_start :
  property_scroll_margin_block_start Rule.rule =
  Property_scroll_margin_block_start.rule

module Property_scroll_margin_bottom =
  [%spec_module
  "<extended-length>", (module Css_types.Length)]

let property_scroll_margin_bottom : property_scroll_margin_bottom Rule.rule =
  Property_scroll_margin_bottom.rule

module Property_scroll_margin_inline =
  [%spec_module
  "[ <extended-length> ]{1,2}", (module Css_types.Length)]

let property_scroll_margin_inline : property_scroll_margin_inline Rule.rule =
  Property_scroll_margin_inline.rule

module Property_scroll_margin_inline_end =
  [%spec_module
  "<extended-length>", (module Css_types.Length)]

let property_scroll_margin_inline_end :
  property_scroll_margin_inline_end Rule.rule =
  Property_scroll_margin_inline_end.rule

module Property_scroll_margin_inline_start =
  [%spec_module
  "<extended-length>", (module Css_types.Length)]

let property_scroll_margin_inline_start :
  property_scroll_margin_inline_start Rule.rule =
  Property_scroll_margin_inline_start.rule

module Property_scroll_margin_left =
  [%spec_module
  "<extended-length>", (module Css_types.Length)]

let property_scroll_margin_left : property_scroll_margin_left Rule.rule =
  Property_scroll_margin_left.rule

module Property_scroll_margin_right =
  [%spec_module
  "<extended-length>", (module Css_types.Length)]

let property_scroll_margin_right : property_scroll_margin_right Rule.rule =
  Property_scroll_margin_right.rule

module Property_scroll_margin_top =
  [%spec_module
  "<extended-length>", (module Css_types.Length)]

let property_scroll_margin_top : property_scroll_margin_top Rule.rule =
  Property_scroll_margin_top.rule

module Property_scroll_padding =
  [%spec_module
  "[ 'auto' | <extended-length> | <extended-percentage> ]{1,4}",
  (module Css_types.ScrollPadding)]

let property_scroll_padding : property_scroll_padding Rule.rule =
  Property_scroll_padding.rule

module Property_scroll_padding_block =
  [%spec_module
  "[ 'auto' | <extended-length> | <extended-percentage> ]{1,2}",
  (module Css_types.Length)]

let property_scroll_padding_block : property_scroll_padding_block Rule.rule =
  Property_scroll_padding_block.rule

module Property_scroll_padding_block_end =
  [%spec_module
  "'auto' | <extended-length> | <extended-percentage>",
  (module Css_types.Length)]

let property_scroll_padding_block_end :
  property_scroll_padding_block_end Rule.rule =
  Property_scroll_padding_block_end.rule

module Property_scroll_padding_block_start =
  [%spec_module
  "'auto' | <extended-length> | <extended-percentage>",
  (module Css_types.Length)]

let property_scroll_padding_block_start :
  property_scroll_padding_block_start Rule.rule =
  Property_scroll_padding_block_start.rule

module Property_scroll_padding_bottom =
  [%spec_module
  "'auto' | <extended-length> | <extended-percentage>",
  (module Css_types.Length)]

let property_scroll_padding_bottom : property_scroll_padding_bottom Rule.rule =
  Property_scroll_padding_bottom.rule

module Property_scroll_padding_inline =
  [%spec_module
  "[ 'auto' | <extended-length> | <extended-percentage> ]{1,2}",
  (module Css_types.Length)]

let property_scroll_padding_inline : property_scroll_padding_inline Rule.rule =
  Property_scroll_padding_inline.rule

module Property_scroll_padding_inline_end =
  [%spec_module
  "'auto' | <extended-length> | <extended-percentage>",
  (module Css_types.Length)]

let property_scroll_padding_inline_end :
  property_scroll_padding_inline_end Rule.rule =
  Property_scroll_padding_inline_end.rule

module Property_scroll_padding_inline_start =
  [%spec_module
  "'auto' | <extended-length> | <extended-percentage>",
  (module Css_types.Length)]

let property_scroll_padding_inline_start :
  property_scroll_padding_inline_start Rule.rule =
  Property_scroll_padding_inline_start.rule

module Property_scroll_padding_left =
  [%spec_module
  "'auto' | <extended-length> | <extended-percentage>",
  (module Css_types.Length)]

let property_scroll_padding_left : property_scroll_padding_left Rule.rule =
  Property_scroll_padding_left.rule

module Property_scroll_padding_right =
  [%spec_module
  "'auto' | <extended-length> | <extended-percentage>",
  (module Css_types.Length)]

let property_scroll_padding_right : property_scroll_padding_right Rule.rule =
  Property_scroll_padding_right.rule

module Property_scroll_padding_top =
  [%spec_module
  "'auto' | <extended-length> | <extended-percentage>",
  (module Css_types.Length)]

let property_scroll_padding_top : property_scroll_padding_top Rule.rule =
  Property_scroll_padding_top.rule

module Property_scroll_snap_align =
  [%spec_module
  "[ 'none' | 'start' | 'end' | 'center' ]{1,2}",
  (module Css_types.ScrollSnapAlign)]

let property_scroll_snap_align : property_scroll_snap_align Rule.rule =
  Property_scroll_snap_align.rule

module Property_scroll_snap_coordinate =
  [%spec_module
  "'none' | [ <position> ]#", (module Css_types.ScrollSnapCoordinate)]

let property_scroll_snap_coordinate : property_scroll_snap_coordinate Rule.rule
    =
  Property_scroll_snap_coordinate.rule

module Property_scroll_snap_destination =
  [%spec_module
  "<position>", (module Css_types.ScrollSnapDestination)]

let property_scroll_snap_destination :
  property_scroll_snap_destination Rule.rule =
  Property_scroll_snap_destination.rule

module Property_scroll_snap_points_x =
  [%spec_module
  "'none' | repeat( <extended-length> | <extended-percentage> )",
  (module Css_types.ScrollSnapPointsX)]

let property_scroll_snap_points_x : property_scroll_snap_points_x Rule.rule =
  Property_scroll_snap_points_x.rule

module Property_scroll_snap_points_y =
  [%spec_module
  "'none' | repeat( <extended-length> | <extended-percentage> )",
  (module Css_types.ScrollSnapPointsY)]

let property_scroll_snap_points_y : property_scroll_snap_points_y Rule.rule =
  Property_scroll_snap_points_y.rule

module Property_scroll_snap_stop =
  [%spec_module
  "'normal' | 'always'", (module Css_types.ScrollSnapStop)]

let property_scroll_snap_stop : property_scroll_snap_stop Rule.rule =
  Property_scroll_snap_stop.rule

module Property_scroll_snap_type =
  [%spec_module
  "'none' | [ 'x' | 'y' | 'block' | 'inline' | 'both' ] [ 'mandatory' | \
   'proximity' ]?",
  (module Css_types.ScrollSnapType)]

let property_scroll_snap_type : property_scroll_snap_type Rule.rule =
  Property_scroll_snap_type.rule

module Property_scroll_snap_type_x =
  [%spec_module
  "'none' | 'mandatory' | 'proximity'", (module Css_types.Cascading)]

let property_scroll_snap_type_x : property_scroll_snap_type_x Rule.rule =
  Property_scroll_snap_type_x.rule

module Property_scroll_snap_type_y =
  [%spec_module
  "'none' | 'mandatory' | 'proximity'", (module Css_types.Cascading)]

let property_scroll_snap_type_y : property_scroll_snap_type_y Rule.rule =
  Property_scroll_snap_type_y.rule

module Property_scrollbar_color =
  [%spec_module
  "'auto' | [ <color> <color> ]", (module Css_types.ScrollbarColor)]

let property_scrollbar_color : property_scrollbar_color Rule.rule =
  Property_scrollbar_color.rule

module Property_scrollbar_width =
  [%spec_module
  "'auto' | 'thin' | 'none'", (module Css_types.ScrollbarWidth)]

let property_scrollbar_width : property_scrollbar_width Rule.rule =
  Property_scrollbar_width.rule

module Property_scrollbar_gutter =
  [%spec_module
  "'auto' | 'stable' && 'both-edges'?", (module Css_types.ScrollbarGutter)]

let property_scrollbar_gutter : property_scrollbar_gutter Rule.rule =
  Property_scrollbar_gutter.rule

module Property_scrollbar_3dlight_color =
  [%spec_module
  "<color>", (module Css_types.Scrollbar3dlightColor)]

let property_scrollbar_3dlight_color :
  property_scrollbar_3dlight_color Rule.rule =
  Property_scrollbar_3dlight_color.rule

module Property_scrollbar_arrow_color =
  [%spec_module
  "<color>", (module Css_types.ScrollbarArrowColor)]

let property_scrollbar_arrow_color : property_scrollbar_arrow_color Rule.rule =
  Property_scrollbar_arrow_color.rule

module Property_scrollbar_base_color =
  [%spec_module
  "<color>", (module Css_types.ScrollbarBaseColor)]

let property_scrollbar_base_color : property_scrollbar_base_color Rule.rule =
  Property_scrollbar_base_color.rule

module Property_scrollbar_darkshadow_color =
  [%spec_module
  "<color>", (module Css_types.ScrollbarDarkshadowColor)]

let property_scrollbar_darkshadow_color :
  property_scrollbar_darkshadow_color Rule.rule =
  Property_scrollbar_darkshadow_color.rule

module Property_scrollbar_face_color =
  [%spec_module
  "<color>", (module Css_types.ScrollbarFaceColor)]

let property_scrollbar_face_color : property_scrollbar_face_color Rule.rule =
  Property_scrollbar_face_color.rule

module Property_scrollbar_highlight_color =
  [%spec_module
  "<color>", (module Css_types.ScrollbarHighlightColor)]

let property_scrollbar_highlight_color :
  property_scrollbar_highlight_color Rule.rule =
  Property_scrollbar_highlight_color.rule

module Property_scrollbar_shadow_color =
  [%spec_module
  "<color>", (module Css_types.ScrollbarShadowColor)]

let property_scrollbar_shadow_color : property_scrollbar_shadow_color Rule.rule
    =
  Property_scrollbar_shadow_color.rule

module Property_scrollbar_track_color =
  [%spec_module
  "<color>", (module Css_types.ScrollbarTrackColor)]

let property_scrollbar_track_color : property_scrollbar_track_color Rule.rule =
  Property_scrollbar_track_color.rule

module Property_shape_image_threshold =
  [%spec_module
  "<alpha-value>", (module Css_types.ShapeImageThreshold)]

let property_shape_image_threshold : property_shape_image_threshold Rule.rule =
  Property_shape_image_threshold.rule

module Property_shape_margin =
  [%spec_module
  "<extended-length> | <extended-percentage>", (module Css_types.ShapeMargin)]

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

module Property_speak =
  [%spec_module
  "'auto' | 'none' | 'normal'", (module Css_types.Speak)]

let property_speak : property_speak Rule.rule = Property_speak.rule

module Property_speak_as =
  [%spec_module
  "'normal' | 'spell-out' || 'digits' || [ 'literal-punctuation' | \
   'no-punctuation' ]",
  (module Css_types.SpeakAs)]

let property_speak_as : property_speak_as Rule.rule = Property_speak_as.rule

module Property_src =
  [%spec_module
  "[ <url> [ format( [ <string> ]# ) ]? | local( <family-name> ) ]#",
  (module Css_types.Src)]

let property_src : property_src Rule.rule = Property_src.rule

module Property_stroke = [%spec_module "<paint>", (module Css_types.Paint)]

let property_stroke : property_stroke Rule.rule = Property_stroke.rule

module Property_stroke_dasharray =
  [%spec_module
  "'none' | [ [ <svg-length> ]+ ]#", (module Css_types.StrokeDashArray)]

let property_stroke_dasharray : property_stroke_dasharray Rule.rule =
  Property_stroke_dasharray.rule

module Property_stroke_dashoffset =
  [%spec_module
  "<svg-length>", (module Css_types.StrokeDashoffset)]

let property_stroke_dashoffset : property_stroke_dashoffset Rule.rule =
  Property_stroke_dashoffset.rule

module Property_stroke_linecap =
  [%spec_module
  "'butt' | 'round' | 'square'", (module Css_types.StrokeLinecap)]

let property_stroke_linecap : property_stroke_linecap Rule.rule =
  Property_stroke_linecap.rule

module Property_stroke_linejoin =
  [%spec_module
  "'miter' | 'round' | 'bevel'", (module Css_types.StrokeLinejoin)]

let property_stroke_linejoin : property_stroke_linejoin Rule.rule =
  Property_stroke_linejoin.rule

module Property_stroke_miterlimit =
  [%spec_module
  "<number-one-or-greater>", (module Css_types.StrokeMiterlimit)]

let property_stroke_miterlimit : property_stroke_miterlimit Rule.rule =
  Property_stroke_miterlimit.rule

module Property_stroke_opacity =
  [%spec_module
  "<alpha-value>", (module Css_types.StrokeOpacity)]

let property_stroke_opacity : property_stroke_opacity Rule.rule =
  Property_stroke_opacity.rule

module Property_stroke_width =
  [%spec_module
  "<svg-length>", (module Css_types.StrokeWidth)]

let property_stroke_width : property_stroke_width Rule.rule =
  Property_stroke_width.rule

module Property_tab_size =
  [%spec_module
  " <number> | <extended-length>", (module Css_types.TabSize)]

let property_tab_size : property_tab_size Rule.rule = Property_tab_size.rule

module Property_table_layout =
  [%spec_module
  "'auto' | 'fixed'", (module Css_types.TableLayout)]

let property_table_layout : property_table_layout Rule.rule =
  Property_table_layout.rule

module Property_text_autospace =
  [%spec_module
  "'none' | 'ideograph-alpha' | 'ideograph-numeric' | 'ideograph-parenthesis' \
   | 'ideograph-space'",
  (module Css_types.TextAutospace)]

let property_text_autospace : property_text_autospace Rule.rule =
  Property_text_autospace.rule

module Property_text_blink =
  [%spec_module
  "'none' | 'blink' | 'blink-anywhere'", (module Css_types.TextBlink)]

let property_text_blink : property_text_blink Rule.rule =
  Property_text_blink.rule

module Property_text_align =
  [%spec_module
  "'start' | 'end' | 'left' | 'right' | 'center' | 'justify' | 'match-parent' \
   | 'justify-all'",
  (module Css_types.TextAlign)]

let property_text_align : property_text_align Rule.rule =
  Property_text_align.rule

module Property_text_align_all =
  [%spec_module
  "'start' | 'end' | 'left' | 'right' | 'center' | 'justify' | 'match-parent'",
  (module Css_types.TextAlignAll)]

let property_text_align_all : property_text_align_all Rule.rule =
  Property_text_align_all.rule

module Property_text_align_last =
  [%spec_module
  "'auto' | 'start' | 'end' | 'left' | 'right' | 'center' | 'justify' | \
   'match-parent'",
  (module Css_types.TextAlignLast)]

let property_text_align_last : property_text_align_last Rule.rule =
  Property_text_align_last.rule

module Property_text_anchor =
  [%spec_module
  "'start' | 'middle' | 'end'", (module Css_types.TextAnchor)]

let property_text_anchor : property_text_anchor Rule.rule =
  Property_text_anchor.rule

module Property_text_combine_upright =
  [%spec_module
  "'none' | 'all' | 'digits' [ <integer> ]?",
  (module Css_types.TextCombineUpright)]

let property_text_combine_upright : property_text_combine_upright Rule.rule =
  Property_text_combine_upright.rule

module Property_text_decoration =
  [%spec_module
  "<'text-decoration-color'> || <'text-decoration-style'> || \
   <'text-decoration-thickness'> || <'text-decoration-line'>",
  (module Css_types.TextDecoration)]

let property_text_decoration : property_text_decoration Rule.rule =
  Property_text_decoration.rule

module Property_text_justify_trim =
  [%spec_module
  "'none' | 'all' | 'auto'", (module Css_types.TextJustifyTrim)]

let property_text_justify_trim : property_text_justify_trim Rule.rule =
  Property_text_justify_trim.rule

module Property_text_kashida =
  [%spec_module
  "'none' | 'horizontal' | 'vertical' | 'both'", (module Css_types.TextKashida)]

let property_text_kashida : property_text_kashida Rule.rule =
  Property_text_kashida.rule

module Property_text_kashida_space =
  [%spec_module
  "'normal' | 'pre' | 'post'", (module Css_types.TextKashidaSpace)]

let property_text_kashida_space : property_text_kashida_space Rule.rule =
  Property_text_kashida_space.rule

module Property_text_decoration_color =
  [%spec_module
  "<color>", (module Css_types.Color)]

let property_text_decoration_color : property_text_decoration_color Rule.rule =
  Property_text_decoration_color.rule

(* Spec doesn't contain spelling-error module grammar-error: https://developer.mozilla.org/en-US/docs/Web/CSS/text-decoration-line but this list used to have them | 'spelling-error' | 'grammar-error'. Leaving this comment here for reference *)
(* module this definition has changed from the origianl, it might be a bug on the spec or our Generator,
   but simplifying to "|" simplifies it module solves the bug *)
module Property_text_decoration_line =
  [%spec_module
  "'none' | <interpolation> | [ 'underline' || 'overline' || 'line-through' || \
   'blink' ]",
  (module Css_types.TextDecorationLine)]

let property_text_decoration_line : property_text_decoration_line Rule.rule =
  Property_text_decoration_line.rule

module Property_text_decoration_skip =
  [%spec_module
  "'none' | 'objects' || [ 'spaces' | 'leading-spaces' || 'trailing-spaces' ] \
   || 'edges' || 'box-decoration'",
  (module Css_types.TextDecorationSkip)]

let property_text_decoration_skip : property_text_decoration_skip Rule.rule =
  Property_text_decoration_skip.rule

module Property_text_decoration_skip_self =
  [%spec_module
  "'none' | 'objects' || [ 'spaces' | 'leading-spaces' || 'trailing-spaces' ] \
   || 'edges' || 'box-decoration'",
  (module Css_types.TextDecorationSkipSelf)]

let property_text_decoration_skip_self :
  property_text_decoration_skip_self Rule.rule =
  Property_text_decoration_skip_self.rule

module Property_text_decoration_skip_ink =
  [%spec_module
  "'auto' | 'all' | 'none'", (module Css_types.TextDecorationSkipInk)]

let property_text_decoration_skip_ink :
  property_text_decoration_skip_ink Rule.rule =
  Property_text_decoration_skip_ink.rule

module Property_text_decoration_skip_box =
  [%spec_module
  "'none' | 'all'", (module Css_types.TextDecorationSkipBox)]

let property_text_decoration_skip_box :
  property_text_decoration_skip_box Rule.rule =
  Property_text_decoration_skip_box.rule

module Property_text_decoration_skip_spaces =
  [%spec_module
  "'none' | 'objects' || [ 'spaces' | 'leading-spaces' || 'trailing-spaces' ] \
   || 'edges' || 'box-decoration'",
  (module Css_types.TextDecorationSkipSpaces)]

let property_text_decoration_skip_spaces :
  property_text_decoration_skip_spaces Rule.rule =
  Property_text_decoration_skip_spaces.rule

module Property_text_decoration_skip_inset =
  [%spec_module
  "'none' | 'auto'", (module Css_types.TextDecorationSkipInset)]

let property_text_decoration_skip_inset :
  property_text_decoration_skip_inset Rule.rule =
  Property_text_decoration_skip_inset.rule

module Property_text_decoration_style =
  [%spec_module
  "'solid' | 'double' | 'dotted' | 'dashed' | 'wavy'",
  (module Css_types.TextDecorationStyle)]

let property_text_decoration_style : property_text_decoration_style Rule.rule =
  Property_text_decoration_style.rule

module Property_text_decoration_thickness =
  [%spec_module
  "'auto' | 'from-font' | <extended-length> | <extended-percentage>",
  (module Css_types.TextDecorationThickness)]

let property_text_decoration_thickness :
  property_text_decoration_thickness Rule.rule =
  Property_text_decoration_thickness.rule

module Property_text_emphasis =
  [%spec_module
  "<'text-emphasis-style'> || <'text-emphasis-color'>",
  (module Css_types.TextEmphasis)]

let property_text_emphasis : property_text_emphasis Rule.rule =
  Property_text_emphasis.rule

module Property_text_emphasis_color =
  [%spec_module
  "<color>", (module Css_types.Color)]

let property_text_emphasis_color : property_text_emphasis_color Rule.rule =
  Property_text_emphasis_color.rule

module Property_text_emphasis_position =
  [%spec_module
  "[ 'over' | 'under' ] && [ 'right' | 'left' ]?",
  (module Css_types.TextEmphasisPosition)]

let property_text_emphasis_position : property_text_emphasis_position Rule.rule
    =
  Property_text_emphasis_position.rule

module Property_text_emphasis_style =
  [%spec_module
  "'none' | [ 'filled' | 'open' ] || [ 'dot' | 'circle' | 'double-circle' | \
   'triangle' | 'sesame' ] | <string>",
  (module Css_types.TextEmphasisStyle)]

let property_text_emphasis_style : property_text_emphasis_style Rule.rule =
  Property_text_emphasis_style.rule

module Property_text_indent =
  [%spec_module
  "[<extended-length> | <extended-percentage>] && [ 'hanging' ]? && [ \
   'each-line' ]?",
  (module Css_types.TextIndent)]

let property_text_indent : property_text_indent Rule.rule =
  Property_text_indent.rule

module Property_text_justify =
  [%spec_module
  "'auto' | 'inter-character' | 'inter-word' | 'none'",
  (module Css_types.TextJustify)]

let property_text_justify : property_text_justify Rule.rule =
  Property_text_justify.rule

module Property_text_orientation =
  [%spec_module
  "'mixed' | 'upright' | 'sideways'", (module Css_types.TextOrientation)]

let property_text_orientation : property_text_orientation Rule.rule =
  Property_text_orientation.rule

module Property_text_overflow =
  [%spec_module
  "[ 'clip' | 'ellipsis' | <string> ]{1,2}", (module Css_types.TextOverflow)]

let property_text_overflow : property_text_overflow Rule.rule =
  Property_text_overflow.rule

module Property_text_rendering =
  [%spec_module
  "'auto' | 'optimizeSpeed' | 'optimizeLegibility' | 'geometricPrecision'",
  (module Css_types.TextRendering)]

let property_text_rendering : property_text_rendering Rule.rule =
  Property_text_rendering.rule

module Property_text_shadow =
  [%spec_module
  "'none' | <interpolation> | [ <shadow-t> ]#", (module Css_types.TextShadows)]

let property_text_shadow : property_text_shadow Rule.rule =
  Property_text_shadow.rule

module Property_text_size_adjust =
  [%spec_module
  "'none' | 'auto' | <extended-percentage>", (module Css_types.TextSizeAdjust)]

let property_text_size_adjust : property_text_size_adjust Rule.rule =
  Property_text_size_adjust.rule

module Property_text_transform =
  [%spec_module
  "'none' | 'capitalize' | 'uppercase' | 'lowercase' | 'full-width' | \
   'full-size-kana'",
  (module Css_types.TextTransform)]

let property_text_transform : property_text_transform Rule.rule =
  Property_text_transform.rule

module Property_text_underline_offset =
  [%spec_module
  "'auto' | <extended-length> | <extended-percentage>",
  (module Css_types.TextUnderlineOffset)]

let property_text_underline_offset : property_text_underline_offset Rule.rule =
  Property_text_underline_offset.rule

module Property_text_underline_position =
  [%spec_module
  "'auto' | 'from-font' | 'under' || [ 'left' | 'right' ]",
  (module Css_types.TextUnderlinePosition)]

let property_text_underline_position :
  property_text_underline_position Rule.rule =
  Property_text_underline_position.rule

module Property_top =
  [%spec_module
  "<extended-length> | <extended-percentage> | 'auto'", (module Css_types.Top)]

let property_top : property_top Rule.rule = Property_top.rule

module Property_touch_action =
  [%spec_module
  "'auto' | 'none' | [ 'pan-x' | 'pan-left' | 'pan-right' ] || [ 'pan-y' | \
   'pan-up' | 'pan-down' ] || 'pinch-zoom' | 'manipulation'",
  (module Css_types.TouchAction)]

let property_touch_action : property_touch_action Rule.rule =
  Property_touch_action.rule

module Property_transform =
  [%spec_module
  "'none' | <transform-list>", (module Css_types.Transform)]

let property_transform : property_transform Rule.rule = Property_transform.rule

module Property_transform_box =
  [%spec_module
  "'content-box' | 'border-box' | 'fill-box' | 'stroke-box' | 'view-box'",
  (module Css_types.TransformBox)]

let property_transform_box : property_transform_box Rule.rule =
  Property_transform_box.rule

module Property_transform_origin =
  [%spec_module
  "[ 'left' | 'center' | 'right' | 'top' | 'bottom' | <length-percentage> ] | \
   [ 'left' | 'center' | 'right' | <length-percentage> ] [ 'top' | 'center' | \
   'bottom' | <length-percentage> ] <length>? | [[ 'center' | 'left' | 'right' \
   ] && [ 'center' | 'top' | 'bottom' ]] <length>? ",
  (module Css_types.TransformOrigin)]

let property_transform_origin : property_transform_origin Rule.rule =
  Property_transform_origin.rule

module Property_transform_style =
  [%spec_module
  "'flat' | 'preserve-3d'", (module Css_types.TransformStyle)]

let property_transform_style : property_transform_style Rule.rule =
  Property_transform_style.rule

module Property_transition =
  [%spec_module
  "[ <single-transition> | <single-transition-no-interp> ]#",
  (module Css_types.Transition)]

let property_transition : property_transition Rule.rule =
  Property_transition.rule

module Property_transition_behavior =
  [%spec_module
  "<transition-behavior-value>#", (module Css_types.TransitionBehavior)]

let property_transition_behavior : property_transition_behavior Rule.rule =
  Property_transition_behavior.rule

module Property_transition_delay =
  [%spec_module
  "[ <extended-time> ]#", (module Css_types.TransitionDelay)]

let property_transition_delay : property_transition_delay Rule.rule =
  Property_transition_delay.rule

module Property_transition_duration =
  [%spec_module
  "[ <extended-time> ]#", (module Css_types.TransitionDuration)]

let property_transition_duration : property_transition_duration Rule.rule =
  Property_transition_duration.rule

module Property_transition_property =
  [%spec_module
  "[ <single-transition-property> ]# | 'none'",
  (module Css_types.TransitionProperty)]

let property_transition_property : property_transition_property Rule.rule =
  Property_transition_property.rule

module Property_transition_timing_function =
  [%spec_module
  "[ <timing-function> ]#", (module Css_types.TransitionTimingFunction)]

let property_transition_timing_function :
  property_transition_timing_function Rule.rule =
  Property_transition_timing_function.rule

module Property_translate =
  [%spec_module
  "'none' | <length-percentage> [ <length-percentage> <length>? ]?",
  (module Css_types.Translate)]

let property_translate : property_translate Rule.rule = Property_translate.rule

module Property_unicode_bidi =
  [%spec_module
  "'normal' | 'embed' | 'isolate' | 'bidi-override' | 'isolate-override' | \
   'plaintext' | '-moz-isolate' | '-moz-isolate-override' | '-moz-plaintext' | \
   '-webkit-isolate'",
  (module Css_types.UnicodeBidi)]

let property_unicode_bidi : property_unicode_bidi Rule.rule =
  Property_unicode_bidi.rule

module Property_unicode_range =
  [%spec_module
  "[ <urange> ]#", (module Css_types.UnicodeRange)]

let property_unicode_range : property_unicode_range Rule.rule =
  Property_unicode_range.rule

module Property_user_select =
  [%spec_module
  "'auto' | 'text' | 'none' | 'contain' | 'all' | <interpolation>",
  (module Css_types.UserSelect)]

let property_user_select : property_user_select Rule.rule =
  Property_user_select.rule

module Property_vertical_align =
  [%spec_module
  "'baseline' | 'sub' | 'super' | 'text-top' | 'text-bottom' | 'middle' | \
   'top' | 'bottom' | <extended-percentage> | <extended-length>",
  (module Css_types.VerticalAlign)]

let property_vertical_align : property_vertical_align Rule.rule =
  Property_vertical_align.rule

module Property_visibility =
  [%spec_module
  "'visible' | 'hidden' | 'collapse' | <interpolation>",
  (module Css_types.Visibility)]

let property_visibility : property_visibility Rule.rule =
  Property_visibility.rule

module Property_voice_balance =
  [%spec_module
  "<number> | 'left' | 'center' | 'right' | 'leftwards' | 'rightwards'",
  (module Css_types.VoiceBalance)]

let property_voice_balance : property_voice_balance Rule.rule =
  Property_voice_balance.rule

module Property_voice_duration =
  [%spec_module
  "'auto' | <extended-time>", (module Css_types.VoiceDuration)]

let property_voice_duration : property_voice_duration Rule.rule =
  Property_voice_duration.rule

module Property_voice_family =
  [%spec_module
  "[ [ <family-name> | <generic-voice> ] ',' ]* [ <family-name> | \
   <generic-voice> ] | 'preserve'",
  (module Css_types.VoiceFamily)]

let property_voice_family : property_voice_family Rule.rule =
  Property_voice_family.rule

module Property_voice_pitch =
  [%spec_module
  "<extended-frequency> && 'absolute' | [ 'x-low' | 'low' | 'medium' | 'high' \
   | 'x-high' ] || [ <extended-frequency> | <semitones> | \
   <extended-percentage> ]",
  (module Css_types.VoicePitch)]

let property_voice_pitch : property_voice_pitch Rule.rule =
  Property_voice_pitch.rule

module Property_voice_range =
  [%spec_module
  "<extended-frequency> && 'absolute' | [ 'x-low' | 'low' | 'medium' | 'high' \
   | 'x-high' ] || [ <extended-frequency> | <semitones> | \
   <extended-percentage> ]",
  (module Css_types.VoiceRange)]

let property_voice_range : property_voice_range Rule.rule =
  Property_voice_range.rule

module Property_voice_rate =
  [%spec_module
  "[ 'normal' | 'x-slow' | 'slow' | 'medium' | 'fast' | 'x-fast' ] || \
   <extended-percentage>",
  (module Css_types.VoiceRate)]

let property_voice_rate : property_voice_rate Rule.rule =
  Property_voice_rate.rule

module Property_voice_stress =
  [%spec_module
  "'normal' | 'strong' | 'moderate' | 'none' | 'reduced'",
  (module Css_types.VoiceStress)]

let property_voice_stress : property_voice_stress Rule.rule =
  Property_voice_stress.rule

module Property_voice_volume =
  [%spec_module
  "'silent' | [ 'x-soft' | 'soft' | 'medium' | 'loud' | 'x-loud' ] || <decibel>",
  (module Css_types.VoiceVolume)]

let property_voice_volume : property_voice_volume Rule.rule =
  Property_voice_volume.rule

module Property_white_space =
  [%spec_module
  "'normal' | 'pre' | 'nowrap' | 'pre-wrap' | 'pre-line' | 'break-spaces'",
  (module Css_types.WhiteSpace)]

let property_white_space : property_white_space Rule.rule =
  Property_white_space.rule

module Property_widows = [%spec_module "<integer>", (module Css_types.Widows)]

let property_widows : property_widows Rule.rule = Property_widows.rule

module Property_width =
  [%spec_module
  "'auto' | <extended-length> | <extended-percentage> | 'min-content' | \
   'max-content' | 'fit-content' | fit-content( <extended-length> | \
   <extended-percentage> )",
  (module Css_types.Width)]

let property_width : property_width Rule.rule = Property_width.rule

module Property_will_change =
  [%spec_module
  "'auto' | [ <animateable-feature> ]#", (module Css_types.WillChange)]

let property_will_change : property_will_change Rule.rule =
  Property_will_change.rule

module Property_word_break =
  [%spec_module
  "'normal' | 'break-all' | 'keep-all' | 'break-word'",
  (module Css_types.WordBreak)]

let property_word_break : property_word_break Rule.rule =
  Property_word_break.rule

module Property_word_spacing =
  [%spec_module
  "'normal' | <extended-length> | <extended-percentage>",
  (module Css_types.WordSpacing)]

let property_word_spacing : property_word_spacing Rule.rule =
  Property_word_spacing.rule

module Property_word_wrap =
  [%spec_module
  "'normal' | 'break-word' | 'anywhere'", (module Css_types.WordWrap)]

let property_word_wrap : property_word_wrap Rule.rule = Property_word_wrap.rule

module Property_writing_mode =
  [%spec_module
  "'horizontal-tb' | 'vertical-rl' | 'vertical-lr' | 'sideways-rl' | \
   'sideways-lr' | <svg-writing-mode>",
  (module Css_types.WritingMode)]

let property_writing_mode : property_writing_mode Rule.rule =
  Property_writing_mode.rule

module Property_z_index =
  [%spec_module
  "'auto' | <integer> | <interpolation>", (module Css_types.ZIndex)]

let property_z_index : property_z_index Rule.rule = Property_z_index.rule

module Property_zoom =
  [%spec_module
  "'normal' | 'reset' | <number> | <extended-percentage>",
  (module Css_types.Zoom)]

let property_zoom : property_zoom Rule.rule = Property_zoom.rule

module Property_container =
  [%spec_module
  "<'container-name'> [ '/' <'container-type'> ]?", (module Css_types.Container)]

let property_container : property_container Rule.rule = Property_container.rule

module Property_container_name =
  [%spec_module
  "<custom-ident>+ | 'none'", (module Css_types.ContainerName)]

let property_container_name : property_container_name Rule.rule =
  Property_container_name.rule

module Property_container_type =
  [%spec_module
  "'normal' | 'size' | 'inline-size'", (module Css_types.ContainerType)]

let property_container_type : property_container_type Rule.rule =
  Property_container_type.rule

module Property_nav_down =
  [%spec_module
  "'auto' | <integer> | <interpolation>", (module Css_types.NavDown)]

let property_nav_down : property_nav_down Rule.rule = Property_nav_down.rule

module Property_nav_left =
  [%spec_module
  "'auto' | <integer> | <interpolation>", (module Css_types.NavLeft)]

let property_nav_left : property_nav_left Rule.rule = Property_nav_left.rule

module Property_nav_right =
  [%spec_module
  "'auto' | <integer> | <interpolation>", (module Css_types.NavRight)]

let property_nav_right : property_nav_right Rule.rule = Property_nav_right.rule

module Property_nav_up =
  [%spec_module
  "'auto' | <integer> | <interpolation>", (module Css_types.NavUp)]

let property_nav_up : property_nav_up Rule.rule = Property_nav_up.rule

module Property_accent_color =
  [%spec_module
  "'auto' | <color>", (module Css_types.AccentColor)]

let property_accent_color : property_accent_color Rule.rule =
  Property_accent_color.rule

module Property_animation_composition =
  [%spec_module
  "[ 'replace' | 'add' | 'accumulate' ]#",
  (module Css_types.AnimationComposition)]

let property_animation_composition : property_animation_composition Rule.rule =
  Property_animation_composition.rule

module Property_animation_range =
  [%spec_module
  "[ 'normal' | <extended-length> | <extended-percentage> ]{1,2}",
  (module Css_types.AnimationRange)]

let property_animation_range : property_animation_range Rule.rule =
  Property_animation_range.rule

module Property_animation_range_end =
  [%spec_module
  "'normal' | <extended-length> | <extended-percentage>",
  (module Css_types.AnimationRangeEnd)]

let property_animation_range_end : property_animation_range_end Rule.rule =
  Property_animation_range_end.rule

module Property_animation_range_start =
  [%spec_module
  "'normal' | <extended-length> | <extended-percentage>",
  (module Css_types.AnimationRangeStart)]

let property_animation_range_start : property_animation_range_start Rule.rule =
  Property_animation_range_start.rule

module Property_animation_timeline =
  [%spec_module
  "[ 'none' | <custom-ident> ]#", (module Css_types.AnimationTimeline)]

let property_animation_timeline : property_animation_timeline Rule.rule =
  Property_animation_timeline.rule

module Property_field_sizing =
  [%spec_module
  "'content' | 'fixed'", (module Css_types.FieldSizing)]

let property_field_sizing : property_field_sizing Rule.rule =
  Property_field_sizing.rule

module Property_interpolate_size =
  [%spec_module
  "'numeric-only' | 'allow-keywords'", (module Css_types.InterpolateSize)]

let property_interpolate_size : property_interpolate_size Rule.rule =
  Property_interpolate_size.rule

module Property_media_type =
  [%spec_module
  "<ident>", (module Css_types.MediaType)]

let property_media_type : property_media_type Rule.rule =
  Property_media_type.rule

module Property_overlay =
  [%spec_module
  "'none' | 'auto'", (module Css_types.Overlay)]

let property_overlay : property_overlay Rule.rule = Property_overlay.rule

module Property_scroll_timeline =
  [%spec_module
  "[ 'none' | <custom-ident> ]# [ 'block' | 'inline' | 'x' | 'y' ]#",
  (module Css_types.ScrollTimeline)]

let property_scroll_timeline : property_scroll_timeline Rule.rule =
  Property_scroll_timeline.rule

module Property_scroll_timeline_axis =
  [%spec_module
  "[ 'block' | 'inline' | 'x' | 'y' ]#", (module Css_types.ScrollTimelineAxis)]

let property_scroll_timeline_axis : property_scroll_timeline_axis Rule.rule =
  Property_scroll_timeline_axis.rule

module Property_scroll_timeline_name =
  [%spec_module
  "[ 'none' | <custom-ident> ]#", (module Css_types.ScrollTimelineName)]

let property_scroll_timeline_name : property_scroll_timeline_name Rule.rule =
  Property_scroll_timeline_name.rule

module Property_text_wrap =
  [%spec_module
  "'wrap' | 'nowrap' | 'balance' | 'stable' | 'pretty'",
  (module Css_types.TextWrap)]

let property_text_wrap : property_text_wrap Rule.rule = Property_text_wrap.rule

module Property_view_timeline =
  [%spec_module
  "[ 'none' | <custom-ident> ]# [ 'block' | 'inline' | 'x' | 'y' ]#",
  (module Css_types.ViewTimeline)]

let property_view_timeline : property_view_timeline Rule.rule =
  Property_view_timeline.rule

module Property_view_timeline_axis =
  [%spec_module
  "[ 'block' | 'inline' | 'x' | 'y' ]#", (module Css_types.ViewTimelineAxis)]

let property_view_timeline_axis : property_view_timeline_axis Rule.rule =
  Property_view_timeline_axis.rule

module Property_view_timeline_inset =
  [%spec_module
  "[ 'auto' | <extended-length> | <extended-percentage> ]{1,2}",
  (module Css_types.ViewTimelineInset)]

let property_view_timeline_inset : property_view_timeline_inset Rule.rule =
  Property_view_timeline_inset.rule

module Property_view_timeline_name =
  [%spec_module
  "[ 'none' | <custom-ident> ]#", (module Css_types.ViewTimelineName)]

let property_view_timeline_name : property_view_timeline_name Rule.rule =
  Property_view_timeline_name.rule

module Property_view_transition_name =
  [%spec_module
  "'none' | <custom-ident>", (module Css_types.ViewTransitionName)]

let property_view_transition_name : property_view_transition_name Rule.rule =
  Property_view_transition_name.rule

module Property_anchor_name =
  [%spec_module
  "'none' | [ <dashed-ident> ]#", (module Css_types.AnchorName)]

let property_anchor_name : property_anchor_name Rule.rule =
  Property_anchor_name.rule

module Property_anchor_scope =
  [%spec_module
  "'none' | 'all' | [ <dashed-ident> ]#", (module Css_types.AnchorScope)]

let property_anchor_scope : property_anchor_scope Rule.rule =
  Property_anchor_scope.rule

module Property_position_anchor =
  [%spec_module
  "'auto' | <dashed-ident>", (module Css_types.PositionAnchor)]

let property_position_anchor : property_position_anchor Rule.rule =
  Property_position_anchor.rule

module Property_position_area =
  [%spec_module
  "'none' | [ 'top' | 'bottom' | 'left' | 'right' | 'center' | 'self-start' | \
   'self-end' | 'start' | 'end' ]",
  (module Css_types.PositionArea)]

let property_position_area : property_position_area Rule.rule =
  Property_position_area.rule

module Property_position_try =
  [%spec_module
  "'none' | [ <dashed-ident> | <try-tactic> ]#", (module Css_types.PositionTry)]

let property_position_try : property_position_try Rule.rule =
  Property_position_try.rule

module Property_position_try_fallbacks =
  [%spec_module
  "'none' | [ <dashed-ident> | <try-tactic> ]#",
  (module Css_types.PositionTryFallbacks)]

let property_position_try_fallbacks : property_position_try_fallbacks Rule.rule
    =
  Property_position_try_fallbacks.rule

module Property_position_try_options =
  [%spec_module
  "'none' | [ 'flip-block' || 'flip-inline' || 'flip-start' ]",
  (module Css_types.PositionTryOptions)]

let property_position_try_options : property_position_try_options Rule.rule =
  Property_position_try_options.rule

module Property_position_visibility =
  [%spec_module
  "'always' | 'anchors-valid' | 'anchors-visible' | 'no-overflow'",
  (module Css_types.PositionVisibility)]

let property_position_visibility : property_position_visibility Rule.rule =
  Property_position_visibility.rule

module Property_inset_area =
  [%spec_module
  "'none' | [ 'top' | 'bottom' | 'left' | 'right' | 'center' | 'self-start' | \
   'self-end' | 'start' | 'end' ]{1,2}",
  (module Css_types.InsetArea)]

let property_inset_area : property_inset_area Rule.rule =
  Property_inset_area.rule

module Property_scroll_start =
  [%spec_module
  "'auto' | 'start' | 'end' | 'center' | 'top' | 'bottom' | 'left' | 'right' | \
   <extended-length> | <extended-percentage>",
  (module Css_types.ScrollStart)]

let property_scroll_start : property_scroll_start Rule.rule =
  Property_scroll_start.rule

module Property_scroll_start_block =
  [%spec_module
  "'auto' | 'start' | 'end' | 'center' | <extended-length> | \
   <extended-percentage>",
  (module Css_types.ScrollStartBlock)]

let property_scroll_start_block : property_scroll_start_block Rule.rule =
  Property_scroll_start_block.rule

module Property_scroll_start_inline =
  [%spec_module
  "'auto' | 'start' | 'end' | 'center' | <extended-length> | \
   <extended-percentage>",
  (module Css_types.ScrollStartInline)]

let property_scroll_start_inline : property_scroll_start_inline Rule.rule =
  Property_scroll_start_inline.rule

module Property_scroll_start_x =
  [%spec_module
  "'auto' | 'start' | 'end' | 'center' | <extended-length> | \
   <extended-percentage>",
  (module Css_types.ScrollStartX)]

let property_scroll_start_x : property_scroll_start_x Rule.rule =
  Property_scroll_start_x.rule

module Property_scroll_start_y =
  [%spec_module
  "'auto' | 'start' | 'end' | 'center' | <extended-length> | \
   <extended-percentage>",
  (module Css_types.ScrollStartY)]

let property_scroll_start_y : property_scroll_start_y Rule.rule =
  Property_scroll_start_y.rule

module Property_scroll_start_target =
  [%spec_module
  "'none' | 'auto'", (module Css_types.ScrollStartTarget)]

let property_scroll_start_target : property_scroll_start_target Rule.rule =
  Property_scroll_start_target.rule

module Property_scroll_start_target_block =
  [%spec_module
  "'none' | 'auto'", (module Css_types.ScrollStartTargetBlock)]

let property_scroll_start_target_block :
  property_scroll_start_target_block Rule.rule =
  Property_scroll_start_target_block.rule

module Property_scroll_start_target_inline =
  [%spec_module
  "'none' | 'auto'", (module Css_types.ScrollStartTargetInline)]

let property_scroll_start_target_inline :
  property_scroll_start_target_inline Rule.rule =
  Property_scroll_start_target_inline.rule

module Property_scroll_start_target_x =
  [%spec_module
  "'none' | 'auto'", (module Css_types.ScrollStartTargetX)]

let property_scroll_start_target_x : property_scroll_start_target_x Rule.rule =
  Property_scroll_start_target_x.rule

module Property_scroll_start_target_y =
  [%spec_module
  "'none' | 'auto'", (module Css_types.ScrollStartTargetY)]

let property_scroll_start_target_y : property_scroll_start_target_y Rule.rule =
  Property_scroll_start_target_y.rule

module Property_text_spacing_trim =
  [%spec_module
  "'normal' | 'space-all' | 'space-first' | 'trim-start'",
  (module Css_types.TextSpacingTrim)]

let property_text_spacing_trim : property_text_spacing_trim Rule.rule =
  Property_text_spacing_trim.rule

module Property_word_space_transform =
  [%spec_module
  "'none' | 'auto' | 'ideograph-alpha' | 'ideograph-numeric'",
  (module Css_types.WordSpaceTransform)]

let property_word_space_transform : property_word_space_transform Rule.rule =
  Property_word_space_transform.rule

module Property_reading_flow =
  [%spec_module
  "'normal' | 'flex-visual' | 'flex-flow' | 'grid-rows' | 'grid-columns' | \
   'grid-order'",
  (module Css_types.ReadingFlow)]

let property_reading_flow : property_reading_flow Rule.rule =
  Property_reading_flow.rule

module Property_math_depth =
  [%spec_module
  "'auto-add' | 'add(' <integer> ')' | <integer>", (module Css_types.MathDepth)]

let property_math_depth : property_math_depth Rule.rule =
  Property_math_depth.rule

module Property_math_shift =
  [%spec_module
  "'normal' | 'compact'", (module Css_types.MathShift)]

let property_math_shift : property_math_shift Rule.rule =
  Property_math_shift.rule

module Property_math_style =
  [%spec_module
  "'normal' | 'compact'", (module Css_types.MathStyle)]

let property_math_style : property_math_style Rule.rule =
  Property_math_style.rule

module Property_text_wrap_mode =
  [%spec_module
  "'wrap' | 'nowrap'", (module Css_types.TextWrapMode)]

let property_text_wrap_mode : property_text_wrap_mode Rule.rule =
  Property_text_wrap_mode.rule

module Property_text_wrap_style =
  [%spec_module
  "'auto' | 'balance' | 'stable' | 'pretty'", (module Css_types.TextWrapStyle)]

let property_text_wrap_style : property_text_wrap_style Rule.rule =
  Property_text_wrap_style.rule

module Property_white_space_collapse =
  [%spec_module
  "'collapse' | 'preserve' | 'preserve-breaks' | 'preserve-spaces' | \
   'break-spaces'",
  (module Css_types.WhiteSpaceCollapse)]

let property_white_space_collapse : property_white_space_collapse Rule.rule =
  Property_white_space_collapse.rule

module Property_text_box_trim =
  [%spec_module
  "'none' | 'trim-start' | 'trim-end' | 'trim-both'",
  (module Css_types.TextBoxTrim)]

let property_text_box_trim : property_text_box_trim Rule.rule =
  Property_text_box_trim.rule

module Property_text_box_edge =
  [%spec_module
  "'leading' | 'text' | 'cap' | 'ex' | 'alphabetic'",
  (module Css_types.TextBoxEdge)]

let property_text_box_edge : property_text_box_edge Rule.rule =
  Property_text_box_edge.rule

(* Print module paged media properties *)
module Property_page =
  [%spec_module
  "'auto' | <custom-ident>", (module Css_types.Page)]

let property_page : property_page Rule.rule = Property_page.rule

module Property_size =
  [%spec_module
  "<extended-length>{1,2} | 'auto' | [ 'A5' | 'A4' | 'A3' | 'B5' | 'B4' | \
   'JIS-B5' | 'JIS-B4' | 'letter' | 'legal' | 'ledger' ] [ 'portrait' | \
   'landscape' ]?",
  (module Css_types.Size)]

let property_size : property_size Rule.rule = Property_size.rule

module Property_marks =
  [%spec_module
  "'none' | 'crop' || 'cross'", (module Css_types.Marks)]

let property_marks : property_marks Rule.rule = Property_marks.rule

module Property_bleed =
  [%spec_module
  "'auto' | <extended-length>", (module Css_types.Bleed)]

let property_bleed : property_bleed Rule.rule = Property_bleed.rule

(* More modern layout module effect properties *)
module Property_backdrop_blur =
  [%spec_module
  "<extended-length>", (module Css_types.BackdropBlur)]

let property_backdrop_blur : property_backdrop_blur Rule.rule =
  Property_backdrop_blur.rule

module Property_scrollbar_color_legacy =
  [%spec_module
  "<color>", (module Css_types.ScrollbarColorLegacy)]

let property_scrollbar_color_legacy : property_scrollbar_color_legacy Rule.rule
    =
  Property_scrollbar_color_legacy.rule

(* SVG paint server properties *)
module Property_stop_color = [%spec_module "<color>", (module Css_types.Color)]

let property_stop_color : property_stop_color Rule.rule =
  Property_stop_color.rule

module Property_stop_opacity =
  [%spec_module
  "<alpha-value>", (module Css_types.Opacity)]

let property_stop_opacity : property_stop_opacity Rule.rule =
  Property_stop_opacity.rule

module Property_flood_color = [%spec_module "<color>", (module Css_types.Color)]

let property_flood_color : property_flood_color Rule.rule =
  Property_flood_color.rule

module Property_flood_opacity =
  [%spec_module
  "<alpha-value>", (module Css_types.Opacity)]

let property_flood_opacity : property_flood_opacity Rule.rule =
  Property_flood_opacity.rule

module Property_lighting_color =
  [%spec_module
  "<color>", (module Css_types.Color)]

let property_lighting_color : property_lighting_color Rule.rule =
  Property_lighting_color.rule

module Property_color_rendering =
  [%spec_module
  "'auto' | 'optimizeSpeed' | 'optimizeQuality'",
  (module Css_types.ColorRendering)]

let property_color_rendering : property_color_rendering Rule.rule =
  Property_color_rendering.rule

module Property_vector_effect =
  [%spec_module
  "'none' | 'non-scaling-stroke'", (module Css_types.VectorEffect)]

let property_vector_effect : property_vector_effect Rule.rule =
  Property_vector_effect.rule

(* SVG geometry properties *)
module Property_cx =
  [%spec_module
  "<extended-length> | <extended-percentage>",
  (module Css_types.LengthPercentage)]

let property_cx : property_cx Rule.rule = Property_cx.rule

module Property_cy =
  [%spec_module
  "<extended-length> | <extended-percentage>",
  (module Css_types.LengthPercentage)]

let property_cy : property_cy Rule.rule = Property_cy.rule

module Property_d =
  [%spec_module
  "'none' | <string>", (module Css_types.Cascading)]

let property_d : property_d Rule.rule = Property_d.rule

module Property_r =
  [%spec_module
  "<extended-length> | <extended-percentage>",
  (module Css_types.LengthPercentage)]

let property_r : property_r Rule.rule = Property_r.rule

module Property_rx =
  [%spec_module
  "'auto' | <extended-length> | <extended-percentage>",
  (module Css_types.LengthPercentage)]

let property_rx : property_rx Rule.rule = Property_rx.rule

module Property_ry =
  [%spec_module
  "'auto' | <extended-length> | <extended-percentage>",
  (module Css_types.LengthPercentage)]

let property_ry : property_ry Rule.rule = Property_ry.rule

module Property_x =
  [%spec_module
  "<extended-length> | <extended-percentage>", (module Css_types.X)]

let property_x : property_x Rule.rule = Property_x.rule

module Property_y =
  [%spec_module
  "<extended-length> | <extended-percentage>", (module Css_types.Y)]

let property_y : property_y Rule.rule = Property_y.rule

(* Contain intrinsic sizing *)
module Property_contain_intrinsic_size =
  [%spec_module
  "'none' | [ 'auto' ]? <extended-length>{1,2}",
  (module Css_types.ContainIntrinsicSize)]

let property_contain_intrinsic_size : property_contain_intrinsic_size Rule.rule
    =
  Property_contain_intrinsic_size.rule

module Property_contain_intrinsic_width =
  [%spec_module
  "'none' | 'auto' <extended-length> | <extended-length>",
  (module Css_types.ContainIntrinsicWidth)]

let property_contain_intrinsic_width :
  property_contain_intrinsic_width Rule.rule =
  Property_contain_intrinsic_width.rule

module Property_contain_intrinsic_height =
  [%spec_module
  "'none' | 'auto' <extended-length> | <extended-length>",
  (module Css_types.ContainIntrinsicHeight)]

let property_contain_intrinsic_height :
  property_contain_intrinsic_height Rule.rule =
  Property_contain_intrinsic_height.rule

module Property_contain_intrinsic_block_size =
  [%spec_module
  "'none' | 'auto' <extended-length> | <extended-length>",
  (module Css_types.ContainIntrinsicBlockSize)]

let property_contain_intrinsic_block_size :
  property_contain_intrinsic_block_size Rule.rule =
  Property_contain_intrinsic_block_size.rule

module Property_contain_intrinsic_inline_size =
  [%spec_module
  "'none' | 'auto' <extended-length> | <extended-length>",
  (module Css_types.ContainIntrinsicInlineSize)]

let property_contain_intrinsic_inline_size :
  property_contain_intrinsic_inline_size Rule.rule =
  Property_contain_intrinsic_inline_size.rule

(* Print *)
module Property_print_color_adjust =
  [%spec_module
  "'economy' | 'exact'", (module Css_types.PrintColorAdjust)]

let property_print_color_adjust : property_print_color_adjust Rule.rule =
  Property_print_color_adjust.rule

(* Ruby *)
module Property_ruby_overhang =
  [%spec_module
  "'auto' | 'none'", (module Css_types.RubyOverhang)]

let property_ruby_overhang : property_ruby_overhang Rule.rule =
  Property_ruby_overhang.rule

(* Timeline scope *)
module Property_timeline_scope =
  [%spec_module
  "[ 'none' | <custom-ident> | <dashed-ident> ]#",
  (module Css_types.TimelineScope)]

let property_timeline_scope : property_timeline_scope Rule.rule =
  Property_timeline_scope.rule

(* Scroll driven animations *)
module Property_animation_delay_end =
  [%spec_module
  "[ <extended-time> ]#", (module Css_types.AnimationDelayEnd)]

let property_animation_delay_end : property_animation_delay_end Rule.rule =
  Property_animation_delay_end.rule

module Property_animation_delay_start =
  [%spec_module
  "[ <extended-time> ]#", (module Css_types.AnimationDelayStart)]

let property_animation_delay_start : property_animation_delay_start Rule.rule =
  Property_animation_delay_start.rule

(* Custom properties for at-rules *)
module Property_syntax = [%spec_module "<string>", (module Css_types.Syntax)]

let property_syntax : property_syntax Rule.rule = Property_syntax.rule

module Property_inherits =
  [%spec_module
  "'true' | 'false'", (module Css_types.Inherits)]

let property_inherits : property_inherits Rule.rule = Property_inherits.rule

module Property_initial_value =
  [%spec_module
  "<string>", (module Css_types.InitialValue)]

let property_initial_value : property_initial_value Rule.rule =
  Property_initial_value.rule

(* Additional modern properties *)
module Property_scroll_marker_group =
  [%spec_module
  "'none' | 'before' | 'after'", (module Css_types.ScrollMarkerGroup)]

let property_scroll_marker_group : property_scroll_marker_group Rule.rule =
  Property_scroll_marker_group.rule

module Property_container_name_computed =
  [%spec_module
  "'none' | [ <custom-ident> ]#", (module Css_types.ContainerNameComputed)]

let property_container_name_computed :
  property_container_name_computed Rule.rule =
  Property_container_name_computed.rule

module Property_text_edge =
  [%spec_module
  "[ 'leading' | <'text-box-edge'> ]{1,2}", (module Css_types.TextEdge)]

let property_text_edge : property_text_edge Rule.rule = Property_text_edge.rule

module Property_hyphenate_limit_last =
  [%spec_module
  "'none' | 'always' | 'column' | 'page' | 'spread'",
  (module Css_types.HyphenateLimitLast)]

let property_hyphenate_limit_last : property_hyphenate_limit_last Rule.rule =
  Property_hyphenate_limit_last.rule

module Pseudo_class_selector =
  [%spec_module
  "':' <ident-token> | ':' <function-token> <any-value> ')'",
  (module Css_types.PseudoClassSelector)]

let pseudo_class_selector : pseudo_class_selector Rule.rule =
  Pseudo_class_selector.rule

module Pseudo_element_selector =
  [%spec_module
  "':' <pseudo-class-selector>", (module Css_types.PseudoElementSelector)]

let pseudo_element_selector : pseudo_element_selector Rule.rule =
  Pseudo_element_selector.rule

module Pseudo_page =
  [%spec_module
  "':' [ 'left' | 'right' | 'first' | 'blank' ]", (module Css_types.PseudoPage)]

let pseudo_page : pseudo_page Rule.rule = Pseudo_page.rule

module Quote =
  [%spec_module
  "'open-quote' | 'close-quote' | 'no-open-quote' | 'no-close-quote'",
  (module Css_types.Quote)]

let quote : quote Rule.rule = Quote.rule

module Ratio =
  [%spec_module
  "<integer> '/' <integer> | <number> | <interpolation>",
  (module Css_types.Ratio)]

let ratio : ratio Rule.rule = Ratio.rule

module Relative_selector =
  [%spec_module
  "[ <combinator> ]? <complex-selector>", (module Css_types.RelativeSelector)]

let relative_selector : relative_selector Rule.rule = Relative_selector.rule

module Relative_selector_list =
  [%spec_module
  "[ <relative-selector> ]#", (module Css_types.RelativeSelectorList)]

let relative_selector_list : relative_selector_list Rule.rule =
  Relative_selector_list.rule

module Relative_size =
  [%spec_module
  "'larger' | 'smaller'", (module Css_types.RelativeSize)]

let relative_size : relative_size Rule.rule = Relative_size.rule

module Repeat_style =
  [%spec_module
  "'repeat-x' | 'repeat-y' | [ 'repeat' | 'space' | 'round' | 'no-repeat' ] [ \
   'repeat' | 'space' | 'round' | 'no-repeat' ]?",
  (module Css_types.RepeatStyle)]

let repeat_style : repeat_style Rule.rule = Repeat_style.rule

module Right =
  [%spec_module
  "<extended-length> | 'auto'", (module Css_types.Right)]

let right : right Rule.rule = Right.rule

module Self_position =
  [%spec_module
  "'center' | 'start' | 'end' | 'self-start' | 'self-end' | 'flex-start' | \
   'flex-end'",
  (module Css_types.SelfPosition)]

let self_position : self_position Rule.rule = Self_position.rule

module Shadow =
  [%spec_module
  "[ 'inset' ]? [ <extended-length> ]{2,4} [ <color> ]?"]

let shadow : shadow Rule.rule = Shadow.rule

module Shadow_t =
  [%spec_module
  "[ <extended-length> ]{2,3} [ <color> ]?", (module Css_types.TextShadow)]

let shadow_t : shadow_t Rule.rule = Shadow_t.rule

module Shape =
  [%spec_module
  "rect( <top> ',' <right> ',' <bottom> ',' <left> ) | rect( <top> <right> \
   <bottom> <left> )",
  (module Css_types.Shape)]

let shape : shape Rule.rule = Shape.rule

module Shape_box =
  [%spec_module
  "<box> | 'margin-box'", (module Css_types.ShapeBox)]

let shape_box : shape_box Rule.rule = Shape_box.rule

module Shape_radius =
  [%spec_module
  "<extended-length> | <extended-percentage> | 'closest-side' | 'farthest-side'",
  (module Css_types.ShapeRadius)]

let shape_radius : shape_radius Rule.rule = Shape_radius.rule

module Side_or_corner =
  [%spec_module
  "[ 'left' | 'right' ] || [ 'top' | 'bottom' ]",
  (module Css_types.SideOrCorner)]

let side_or_corner : side_or_corner Rule.rule = Side_or_corner.rule

module Single_animation =
  [%spec_module
  "[ [ <keyframes-name> | 'none' | <interpolation> ] ] | [ [ <keyframes-name> \
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
   <single-animation-play-state> ]",
  (module Css_types.SingleAnimation)]

let single_animation : single_animation Rule.rule = Single_animation.rule

(* Uses || (any order) per CSS spec. The or_ combinator's match_longest
   tie-breaking assigns the FIRST input <time> to position 3 (last matching
   rule) and the SECOND input <time> to position 1 (first matching rule).
   This means: tuple position 1 = delay, tuple position 3 = duration.
   See render_single_animation_no_interp in Property_to_runtime.re. *)
module Single_animation_no_interp =
  [%spec_module
  "[ <keyframes-name> | 'none' ] || <extended-time-no-interp> || \
   <timing-function-no-interp> || <extended-time-no-interp> || \
   <single-animation-iteration-count-no-interp> || \
   <single-animation-direction-no-interp> || \
   <single-animation-fill-mode-no-interp> || \
   <single-animation-play-state-no-interp>",
  (module Css_types.SingleAnimationNoInterp)]

let single_animation_no_interp : single_animation_no_interp Rule.rule =
  Single_animation_no_interp.rule

module Single_animation_direction =
  [%spec_module
  "'normal' | 'reverse' | 'alternate' | 'alternate-reverse' | <interpolation>",
  (module Css_types.SingleAnimationDirection)]

let single_animation_direction : single_animation_direction Rule.rule =
  Single_animation_direction.rule

module Single_animation_direction_no_interp =
  [%spec_module
  "'normal' | 'reverse' | 'alternate' | 'alternate-reverse'"]

let single_animation_direction_no_interp :
  single_animation_direction_no_interp Rule.rule =
  Single_animation_direction_no_interp.rule

module Single_animation_fill_mode =
  [%spec_module
  "'none' | 'forwards' | 'backwards' | 'both' | <interpolation>",
  (module Css_types.SingleAnimationFillMode)]

let single_animation_fill_mode : single_animation_fill_mode Rule.rule =
  Single_animation_fill_mode.rule

module Single_animation_fill_mode_no_interp =
  [%spec_module
  "'none' | 'forwards' | 'backwards' | 'both'"]

let single_animation_fill_mode_no_interp :
  single_animation_fill_mode_no_interp Rule.rule =
  Single_animation_fill_mode_no_interp.rule

module Single_animation_iteration_count =
  [%spec_module
  "'infinite' | <number> | <interpolation>"]

let single_animation_iteration_count :
  single_animation_iteration_count Rule.rule =
  Single_animation_iteration_count.rule

module Single_animation_iteration_count_no_interp =
  [%spec_module
  "'infinite' | <number>"]

let single_animation_iteration_count_no_interp :
  single_animation_iteration_count_no_interp Rule.rule =
  Single_animation_iteration_count_no_interp.rule

module Single_animation_play_state =
  [%spec_module
  "'running' | 'paused' | <interpolation>",
  (module Css_types.SingleAnimationPlayState)]

let single_animation_play_state : single_animation_play_state Rule.rule =
  Single_animation_play_state.rule

module Single_animation_play_state_no_interp =
  [%spec_module
  "'running' | 'paused'"]

let single_animation_play_state_no_interp :
  single_animation_play_state_no_interp Rule.rule =
  Single_animation_play_state_no_interp.rule

module Single_transition_no_interp =
  [%spec_module
  "[ <single-transition-property-no-interp> | 'none' ] || \
   <extended-time-no-interp> || <timing-function-no-interp> || \
   <extended-time-no-interp> || <transition-behavior-value-no-interp>",
  (module Css_types.SingleTransitionNoInterp)]

let single_transition_no_interp : single_transition_no_interp Rule.rule =
  Single_transition_no_interp.rule

module Single_transition =
  [%spec_module
  "[<single-transition-property> | 'none'] | [ [<single-transition-property> | \
   'none'] <extended-time> ] | [ [<single-transition-property> | 'none'] \
   <extended-time> <timing-function> ] | [ [<single-transition-property> | \
   'none'] <extended-time> <timing-function> <extended-time> ] | [ \
   [<single-transition-property> | 'none'] <extended-time> <timing-function> \
   <extended-time> <transition-behavior-value> ]",
  (module Css_types.SingleTransition)]

let single_transition : single_transition Rule.rule = Single_transition.rule

module Single_transition_property =
  [%spec_module
  "<custom-ident> | <interpolation> | 'all'",
  (module Css_types.TransitionProperty)]

let single_transition_property : single_transition_property Rule.rule =
  Single_transition_property.rule

module Single_transition_property_no_interp =
  [%spec_module
  "<custom-ident> | 'all'"]

let single_transition_property_no_interp :
  single_transition_property_no_interp Rule.rule =
  Single_transition_property_no_interp.rule

module Size =
  [%spec_module
  "'closest-side' | 'farthest-side' | 'closest-corner' | 'farthest-corner' | \
   <extended-length> | [ <extended-length> | <extended-percentage> ]{2}",
  (module Css_types.Size)]

let size : size Rule.rule = Size.rule

module Ray_size =
  [%spec_module
  "'closest-side' | 'farthest-side' | 'closest-corner' | 'farthest-corner' | \
   'sides'",
  (module Css_types.RaySize)]

let ray_size : ray_size Rule.rule = Ray_size.rule

module Radial_size =
  [%spec_module
  "'closest-side' | 'farthest-side' | 'closest-corner' | 'farthest-corner' | \
   <extended-length> | [ <extended-length> | <extended-percentage> ]{2}",
  (module Css_types.RadialSize)]

let radial_size : radial_size Rule.rule = Radial_size.rule

module Step_position =
  [%spec_module
  "'jump-start' | 'jump-end' | 'jump-none' | 'jump-both' | 'start' | 'end'",
  (module Css_types.StepPosition)]

let step_position : step_position Rule.rule = Step_position.rule

module Step_timing_function =
  [%spec_module
  "'step-start' | 'step-end' | steps( <integer> [ ',' <step-position> ]? )",
  (module Css_types.StepTimingFunction)]

let step_timing_function : step_timing_function Rule.rule =
  Step_timing_function.rule

module Subclass_selector =
  [%spec_module
  "<id-selector> | <class-selector> | <attribute-selector> | \
   <pseudo-class-selector>",
  (module Css_types.SubclassSelector)]

let subclass_selector : subclass_selector Rule.rule = Subclass_selector.rule

module Supports_condition =
  [%spec_module
  "'not' <supports-in-parens> | <supports-in-parens> [ 'and' \
   <supports-in-parens> ]* | <supports-in-parens> [ 'or' <supports-in-parens> \
   ]*",
  (module Css_types.SupportsCondition)]

let supports_condition : supports_condition Rule.rule = Supports_condition.rule

module Supports_decl =
  [%spec_module
  "'(' <declaration> ')'", (module Css_types.SupportsDecl)]

let supports_decl : supports_decl Rule.rule = Supports_decl.rule

module Supports_feature =
  [%spec_module
  "<supports-decl> | <supports-selector-fn>", (module Css_types.SupportsFeature)]

let supports_feature : supports_feature Rule.rule = Supports_feature.rule

module Supports_in_parens =
  [%spec_module
  "'(' <supports-condition> ')' | <supports-feature>",
  (module Css_types.SupportsInParens)]

let supports_in_parens : supports_in_parens Rule.rule = Supports_in_parens.rule

module Supports_selector_fn =
  [%spec_module
  "selector( <complex-selector> )", (module Css_types.SupportsSelectorFn)]

let supports_selector_fn : supports_selector_fn Rule.rule =
  Supports_selector_fn.rule

module Svg_length =
  [%spec_module
  "<extended-percentage> | <extended-length> | <number>",
  (module Css_types.SvgLength)]

let svg_length : svg_length Rule.rule = Svg_length.rule

module Svg_writing_mode =
  [%spec_module
  "'lr-tb' | 'rl-tb' | 'tb-rl' | 'lr' | 'rl' | 'tb'",
  (module Css_types.SvgWritingMode)]

let svg_writing_mode : svg_writing_mode Rule.rule = Svg_writing_mode.rule

module Symbol =
  [%spec_module
  "<string> | <image> | <custom-ident>", (module Css_types.Symbol)]

let symbol : symbol Rule.rule = Symbol.rule

module Symbols_type =
  [%spec_module
  "'cyclic' | 'numeric' | 'alphabetic' | 'symbolic' | 'fixed'",
  (module Css_types.SymbolsType)]

let symbols_type : symbols_type Rule.rule = Symbols_type.rule

module Target =
  [%spec_module
  "<target-counter()> | <target-counters()> | <target-text()>",
  (module Css_types.Target)]

let target : target Rule.rule = Target.rule

module Url =
  [%spec_module
  "<url-no-interp> | url( <interpolation> )", (module Css_types.Url)]

let url : url Rule.rule = Url.rule

(* https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/Values/length-percentage#use_in_calc *)
module Extended_length =
  [%spec_module
  "<length> | <calc()> | <interpolation> | <min()> | <max()>",
  (module Css_types.Length)]

let extended_length : extended_length Rule.rule = Extended_length.rule

(* https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/Values/length-percentage#use_in_calc *)
module Length_percentage =
  [%spec_module
  "<extended-length> | <extended-percentage>",
  (module Css_types.LengthPercentage)]

let length_percentage : length_percentage Rule.rule = Length_percentage.rule

module Extended_frequency =
  [%spec_module
  "<frequency> | <calc()> | <interpolation> | <min()> | <max()>",
  (module Css_types.Frequency)]

let extended_frequency : extended_frequency Rule.rule = Extended_frequency.rule

module Extended_angle =
  [%spec_module
  "<angle> | <calc()> | <interpolation> | <min()> | <max()>",
  (module Css_types.Angle)]

let extended_angle : extended_angle Rule.rule = Extended_angle.rule

module Extended_time =
  [%spec_module
  "<time> | <calc()> | <interpolation> | <min()> | <max()>",
  (module Css_types.Time)]

let extended_time : extended_time Rule.rule = Extended_time.rule

module Extended_time_no_interp =
  [%spec_module
  "<time> | <calc()> | <min()> | <max()>", (module Css_types.Time)]

let extended_time_no_interp : extended_time_no_interp Rule.rule =
  Extended_time_no_interp.rule

module Extended_percentage =
  [%spec_module
  "<percentage> | <calc()> | <interpolation> | <min()> | <max()> ",
  (module Css_types.Percentage)]

let extended_percentage : extended_percentage Rule.rule =
  Extended_percentage.rule

module Timing_function =
  [%spec_module
  "'linear' | <cubic-bezier-timing-function> | <step-timing-function> | \
   <interpolation>",
  (module Css_types.TransitionTimingFunction)]

let timing_function : timing_function Rule.rule = Timing_function.rule

module Timing_function_no_interp =
  [%spec_module
  "'linear' | <cubic-bezier-timing-function> | <step-timing-function>",
  (module Css_types.TimingFunctionNoInterp)]

let timing_function_no_interp : timing_function_no_interp Rule.rule =
  Timing_function_no_interp.rule

module Top = [%spec_module "<extended-length> | 'auto'", (module Css_types.Top)]

let top : top Rule.rule = Top.rule

module Try_tactic =
  [%spec_module
  "'flip-block' | 'flip-inline' | 'flip-start'", (module Css_types.TryTactic)]

let try_tactic : try_tactic Rule.rule = Try_tactic.rule

module Track_breadth =
  [%spec_module
  "<extended-length> | <extended-percentage> | <flex-value> | 'min-content' | \
   'max-content' | 'auto'",
  (module Css_types.TrackBreadth)]

let track_breadth : track_breadth Rule.rule = Track_breadth.rule

module Track_group =
  [%spec_module
  "'(' [ [ <string> ]* <track-minmax> [ <string> ]* ]+ ')' [ '[' \
   <positive-integer> ']' ]? | <track-minmax>",
  (module Css_types.TrackGroup)]

let track_group : track_group Rule.rule = Track_group.rule

module Track_list =
  [%spec_module
  "[ [ <line-names> ]? [ <track-size> | <track-repeat> ] ]+ [ <line-names> ]?",
  (module Css_types.TrackList)]

let track_list : track_list Rule.rule = Track_list.rule

module Track_list_v0 =
  [%spec_module
  "[ [ <string> ]* <track-group> [ <string> ]* ]+ | 'none'",
  (module Css_types.TrackListV0)]

let track_list_v0 : track_list_v0 Rule.rule = Track_list_v0.rule

module Track_minmax =
  [%spec_module
  "minmax( <track-breadth> ',' <track-breadth> ) | 'auto' | <track-breadth> | \
   fit-content( <extended-length> | <extended-percentage> )",
  (module Css_types.TrackMinmax)]

let track_minmax : track_minmax Rule.rule = Track_minmax.rule

module Track_repeat =
  [%spec_module
  "repeat( <positive-integer> ',' [ [ <line-names> ]? <track-size> ]+ [ \
   <line-names> ]? )",
  (module Css_types.TrackRepeat)]

let track_repeat : track_repeat Rule.rule = Track_repeat.rule

module Track_size =
  [%spec_module
  "<track-breadth> | minmax( <inflexible-breadth> ',' <track-breadth> ) | \
   fit-content( <extended-length> | <extended-percentage> )",
  (module Css_types.TrackSize)]

let track_size : track_size Rule.rule = Track_size.rule

module Transform_function =
  [%spec_module
  "<matrix()> | <translate()> | <translateX()> | <translateY()> | <scale()> | \
   <scaleX()> | <scaleY()> | <rotate()> | <skew()> | <skewX()> | <skewY()> | \
   <matrix3d()> | <translate3d()> | <translateZ()> | <scale3d()> | <scaleZ()> \
   | <rotate3d()> | <rotateX()> | <rotateY()> | <rotateZ()> | <perspective()>",
  (module Css_types.TransformFunction)]

let transform_function : transform_function Rule.rule = Transform_function.rule

module Transform_list =
  [%spec_module
  "[ <transform-function> ]+", (module Css_types.TransformList)]

let transform_list : transform_list Rule.rule = Transform_list.rule

module Transition_behavior_value =
  [%spec_module
  "'normal' | 'allow-discrete' | <interpolation>",
  (module Css_types.TransitionBehavior)]

let transition_behavior_value : transition_behavior_value Rule.rule =
  Transition_behavior_value.rule

module Transition_behavior_value_no_interp =
  [%spec_module
  "'normal' | 'allow-discrete'"]

let transition_behavior_value_no_interp :
  transition_behavior_value_no_interp Rule.rule =
  Transition_behavior_value_no_interp.rule

module Type_or_unit =
  [%spec_module
  "'string' | 'color' | 'url' | 'integer' | 'number' | 'length' | 'angle' | \
   'time' | 'frequency' | 'cap' | 'ch' | 'em' | 'ex' | 'ic' | 'lh' | 'rlh' | \
   'rem' | 'vb' | 'vi' | 'vw' | 'vh' | 'vmin' | 'vmax' | 'mm' | 'Q' | 'cm' | \
   'in' | 'pt' | 'pc' | 'px' | 'deg' | 'grad' | 'rad' | 'turn' | 'ms' | 's' | \
   'Hz' | 'kHz' | '%'",
  (module Css_types.TypeOrUnit)]

let type_or_unit : type_or_unit Rule.rule = Type_or_unit.rule

module Type_selector =
  [%spec_module
  "<wq-name> | [ <ns-prefix> ]? '*'", (module Css_types.TypeSelector)]

let type_selector : type_selector Rule.rule = Type_selector.rule

module Viewport_length =
  [%spec_module
  "'auto' | <extended-length> | <extended-percentage>",
  (module Css_types.ViewportLength)]

let viewport_length : viewport_length Rule.rule = Viewport_length.rule

module Visual_box =
  [%spec_module
  "'content-box' | 'padding-box' | 'border-box'", (module Css_types.VisualBox)]

let visual_box : visual_box Rule.rule = Visual_box.rule

module Wq_name =
  [%spec_module
  "[ <ns-prefix> ]? <ident-token>", (module Css_types.WqName)]

let wq_name : wq_name Rule.rule = Wq_name.rule

module Attr_name =
  [%spec_module
  "[ <ident-token>? '|' ]? <ident-token>", (module Css_types.AttrName)]

let attr_name : attr_name Rule.rule = Attr_name.rule

module Attr_unit =
  [%spec_module
  "'%' | 'em' | 'ex' | 'ch' | 'rem' | 'vw' | 'vh' | 'vmin' | 'vmax' | 'cm' | \
   'mm' | 'in' | 'px' | 'pt' | 'pc' | 'deg' | 'grad' | 'rad' | 'turn' | 'ms' | \
   's' | 'Hz' | 'kHz'",
  (module Css_types.AttrUnit)]

let attr_unit : attr_unit Rule.rule = Attr_unit.rule

module Syntax_type_name =
  [%spec_module
  "'angle' | 'color' | 'custom-ident' | 'image' | 'integer' | 'length' | \
   'length-percentage' | 'number' | 'percentage' | 'resolution' | 'string' | \
   'time' | 'url' | 'transform-function'",
  (module Css_types.SyntaxTypeName)]

let syntax_type_name : syntax_type_name Rule.rule = Syntax_type_name.rule

module Syntax_multiplier =
  [%spec_module
  "'#' | '+'", (module Css_types.SyntaxMultiplier)]

let syntax_multiplier : syntax_multiplier Rule.rule = Syntax_multiplier.rule

module Syntax_single_component =
  [%spec_module
  "'<' <syntax-type-name> '>' | <ident>",
  (module Css_types.SyntaxSingleComponent)]

let syntax_single_component : syntax_single_component Rule.rule =
  Syntax_single_component.rule

module Syntax_string =
  [%spec_module
  "<string>", (module Css_types.SyntaxString)]

let syntax_string : syntax_string Rule.rule = Syntax_string.rule

module Syntax_combinator =
  [%spec_module
  "'|'", (module Css_types.SyntaxCombinator)]

let syntax_combinator : syntax_combinator Rule.rule = Syntax_combinator.rule

module Syntax_component =
  [%spec_module
  "<syntax-single-component> [ <syntax-multiplier> ]? | '<' 'transform-list' \
   '>'",
  (module Css_types.SyntaxComponent)]

let syntax_component : syntax_component Rule.rule = Syntax_component.rule

module Syntax =
  [%spec_module
  "'*' | <syntax-component> [ <syntax-combinator> <syntax-component> ]* | \
   <syntax-string>",
  (module Css_types.Syntax)]

let syntax : syntax Rule.rule = Syntax.rule

(* (*
 We don't support type() yet, original spec is: "type( <syntax> ) | 'raw-string' | <attr-unit>" *) *)
module Attr_type =
  [%spec_module
  "'raw-string' | <attr-unit>", (module Css_types.AttrType)]

let attr_type : attr_type Rule.rule = Attr_type.rule

module X = [%spec_module "<number>", (module Css_types.X)]

let x : x Rule.rule = X.rule

module Y = [%spec_module "<number>", (module Css_types.Y)]

let y : y Rule.rule = Y.rule

(* Test fixtures for [%spec_module] verification *)
module Test_simple =
  [%spec_module
  "'auto' | <extended-length> | <extended-percentage>"]

module Test_with_path = [%spec_module "<color>", (module Css_types.Color)]

let _test_simple_compat : property_margin_top Rule.rule = Test_simple.rule
let _test_color_compat : color Rule.rule = Test_with_path.rule

let _test_extract : Test_with_path.t -> (string * string) list =
  Test_with_path.extract_interpolations

let _test_rmp_none : string option = Test_simple.runtime_module_path
let _test_rmp_some : string option = Test_with_path.runtime_module_path

module Test_with_interp =
  [%spec_module
  "'normal' | <extended-length> | <extended-percentage> | <interpolation>",
  (module Css_types.Length)]

let registry : (kind * packed_rule) list =
  [
    (* Properties *)
    Property "display", pack_module (module Property_display);
    Property "overflow", pack_module (module Property_overflow);
    Property "position", pack_module (module Property_position);
    Property "visibility", pack_module (module Property_visibility);
    Property "float", pack_module (module Property_float);
    Property "clear", pack_module (module Property_clear);
    Property "table-layout", pack_module (module Property_table_layout);
    Property "border-collapse", pack_module (module Property_border_collapse);
    Property "empty-cells", pack_module (module Property_empty_cells);
    Property "caption-side", pack_module (module Property_caption_side);
    Property "direction", pack_module (module Property_direction);
    Property "unicode-bidi", pack_module (module Property_unicode_bidi);
    Property "writing-mode", pack_module (module Property_writing_mode);
    Property "text-orientation", pack_module (module Property_text_orientation);
    Property "text-transform", pack_module (module Property_text_transform);
    Property "white-space", pack_module (module Property_white_space);
    Property "word-break", pack_module (module Property_word_break);
    Property "overflow-wrap", pack_module (module Property_overflow_wrap);
    Property "text-align", pack_module (module Property_text_align);
    Property "text-align-last", pack_module (module Property_text_align_last);
    Property "text-justify", pack_module (module Property_text_justify);
    ( Property "text-decoration-line",
      pack_module (module Property_text_decoration_line) );
    ( Property "text-decoration-style",
      pack_module (module Property_text_decoration_style) );
    ( Property "text-decoration-skip-ink",
      pack_module (module Property_text_decoration_skip_ink) );
    Property "font-style", pack_module (module Property_font_style);
    ( Property "font-variant-caps",
      pack_module (module Property_font_variant_caps) );
    Property "font-stretch", pack_module (module Property_font_stretch);
    Property "font-kerning", pack_module (module Property_font_kerning);
    ( Property "font-variant-position",
      pack_module (module Property_font_variant_position) );
    ( Property "list-style-position",
      pack_module (module Property_list_style_position) );
    Property "list-style-type", pack_module (module Property_list_style_type);
    Property "pointer-events", pack_module (module Property_pointer_events);
    Property "user-select", pack_module (module Property_user_select);
    Property "resize", pack_module (module Property_resize);
    Property "box-sizing", pack_module (module Property_box_sizing);
    Property "object-fit", pack_module (module Property_object_fit);
    Property "isolation", pack_module (module Property_isolation);
    Property "mix-blend-mode", pack_module (module Property_mix_blend_mode);
    ( Property "backface-visibility",
      pack_module (module Property_backface_visibility) );
    Property "flex-direction", pack_module (module Property_flex_direction);
    Property "flex-wrap", pack_module (module Property_flex_wrap);
    Property "justify-content", pack_module (module Property_justify_content);
    Property "align-items", pack_module (module Property_align_items);
    Property "align-content", pack_module (module Property_align_content);
    Property "align-self", pack_module (module Property_align_self);
    Property "justify-items", pack_module (module Property_justify_items);
    Property "justify-self", pack_module (module Property_justify_self);
    Property "scroll-behavior", pack_module (module Property_scroll_behavior);
    ( Property "overscroll-behavior",
      pack_module (module Property_overscroll_behavior) );
    Property "overflow-anchor", pack_module (module Property_overflow_anchor);
    Property "touch-action", pack_module (module Property_touch_action);
    Property "caret-color", pack_module (module Property_caret_color);
    Property "appearance", pack_module (module Property_appearance);
    Property "text-rendering", pack_module (module Property_text_rendering);
    Property "image-rendering", pack_module (module Property_image_rendering);
    Property "color-scheme", pack_module (module Property_color_scheme);
    ( Property "forced-color-adjust",
      pack_module (module Property_forced_color_adjust) );
    ( Property "print-color-adjust",
      pack_module (module Property_print_color_adjust) );
    ( Property "contain-intrinsic-size",
      pack_module (module Property_contain_intrinsic_size) );
    ( Property "content-visibility",
      pack_module (module Property_content_visibility) );
    Property "hyphens", pack_module (module Property_hyphens);
    Property "column-fill", pack_module (module Property_column_fill);
    Property "column-span", pack_module (module Property_column_span);
    Property "clip-rule", pack_module (module Property_clip_rule);
    ( Property "font-optical-sizing",
      pack_module (module Property_font_optical_sizing) );
    Property "font-palette", pack_module (module Property_font_palette);
    ( Property "font-synthesis-weight",
      pack_module (module Property_font_synthesis_weight) );
    ( Property "font-synthesis-style",
      pack_module (module Property_font_synthesis_style) );
    ( Property "font-synthesis-small-caps",
      pack_module (module Property_font_synthesis_small_caps) );
    ( Property "font-synthesis-position",
      pack_module (module Property_font_synthesis_position) );
    Property "mask-border-mode", pack_module (module Property_mask_border_mode);
    Property "mask-type", pack_module (module Property_mask_type);
    Property "ruby-merge", pack_module (module Property_ruby_merge);
    Property "ruby-position", pack_module (module Property_ruby_position);
    Property "scroll-snap-stop", pack_module (module Property_scroll_snap_stop);
    Property "scrollbar-width", pack_module (module Property_scrollbar_width);
    Property "speak", pack_module (module Property_speak);
    Property "stroke-linecap", pack_module (module Property_stroke_linecap);
    ( Property "box-decoration-break",
      pack_module (module Property_box_decoration_break) );
    Property "color-adjust", pack_module (module Property_color_adjust);
    ( Property "text-decoration-thickness",
      pack_module (module Property_text_decoration_thickness) );
    ( Property "text-underline-position",
      pack_module (module Property_text_underline_position) );
    Property "word-wrap", pack_module (module Property_word_wrap);
    Property "break-inside", pack_module (module Property_break_inside);
    Property "break-before", pack_module (module Property_break_before);
    Property "break-after", pack_module (module Property_break_after);
    Property "page-break-after", pack_module (module Property_page_break_after);
    ( Property "page-break-before",
      pack_module (module Property_page_break_before) );
    ( Property "page-break-inside",
      pack_module (module Property_page_break_inside) );
    ( Property "border-image-repeat",
      pack_module (module Property_border_image_repeat) );
    Property "transform-style", pack_module (module Property_transform_style);
    Property "transform-box", pack_module (module Property_transform_box);
    Property "grid-auto-flow", pack_module (module Property_grid_auto_flow);
    Property "font-display", pack_module (module Property_font_display);
    Property "will-change", pack_module (module Property_will_change);
    Property "contain", pack_module (module Property_contain);
    Property "all", pack_module (module Property_all);
    (* Values with runtime types *)
    Value "age", pack_module (module Age);
    Value "attachment", pack_module (module Attachment);
    Value "box", pack_module (module Box);
    Value "display-box", pack_module (module Display_box);
    Value "display-outside", pack_module (module Display_outside);
    Value "ending-shape", pack_module (module Ending_shape);
    Value "fill-rule", pack_module (module Fill_rule);
    Value "zero", pack_module (module Zero);
    Value "gender", pack_module (module Gender);
    Value "combinator", pack_module (module Combinator);
    Value "contextual-alt-values", pack_module (module Contextual_alt_values);
    ( Value "east-asian-width-values",
      pack_module (module East_asian_width_values) );
    Value "attr-modifier", pack_module (module Attr_modifier);
    Value "image-tags", pack_module (module Image_tags);
    Value "line-style", pack_module (module Line_style);
    Value "line-width", pack_module (module Line_width);
    Value "named-color", pack_module (module Named_color);
    Value "color", pack_module (module Color);
    Value "alpha-value", pack_module (module Alpha_value);
    Value "hue", pack_module (module Hue);
    Value "bg-image", pack_module (module Bg_image);
    Value "content-replacement", pack_module (module Content_replacement);
    Value "transform-list", pack_module (module Transform_list);
    Value "transform-function", pack_module (module Transform_function);
    Value "image", pack_module (module Image);
    Value "font_families", pack_module (module Font_families);
    ( Value "color-interpolation-method",
      pack_module (module Color_interpolation_method) );
    Property "row-gap", pack_module (module Property_row_gap);
    Property "column-gap", pack_module (module Property_column_gap);
    Property "outline-width", pack_module (module Property_outline_width);
    Property "outline-style", pack_module (module Property_outline_style);
    Property "width", pack_module (module Property_width);
    Property "border", pack_module (module Property_border);
    Property "flex-grow", pack_module (module Property_flex_grow);
    Property "flex-shrink", pack_module (module Property_flex_shrink);
    Property "flex-basis", pack_module (module Property_flex_basis);
    Value "family-name", pack_module (module Family_name);
    Value "keyframes-name", pack_module (module Keyframes_name);
    Value "url", pack_module (module Url);
    (* Image functions *)
    Function "image()", pack_module (module Function_image);
    Function "image-set()", pack_module (module Function_image_set);
    Function "element()", pack_module (module Function_element);
    Function "paint()", pack_module (module Function_paint);
    Function "cross-fade()", pack_module (module Function_cross_fade);
    (* Gradient and other values *)
    Value "gradient", pack_module (module Gradient);
    Value "shadow", pack_module (module Shadow);
    Value "track-list", pack_module (module Track_list);
    Value "line-names", pack_module (module Line_names);
    Value "side-or-corner", pack_module (module Side_or_corner);
    Value "track-size", pack_module (module Track_size);
    Value "track-breadth", pack_module (module Track_breadth);
    Value "track-repeat", pack_module (module Track_repeat);
    Value "content-list", pack_module (module Content_list);
    Value "mask-reference", pack_module (module Mask_reference);
    Value "color-stop-list", pack_module (module Color_stop_list);
    Value "mask-source", pack_module (module Mask_source);
    Value "length-percentage", pack_module (module Length_percentage);
    Value "auto-track-list", pack_module (module Auto_track_list);
    Value "counter-style", pack_module (module Counter_style);
    Value "counter-style-name", pack_module (module Counter_style_name);
    Value "fixed-size", pack_module (module Fixed_size);
    Value "fixed-repeat", pack_module (module Fixed_repeat);
    Value "fixed-breadth", pack_module (module Fixed_breadth);
    Value "auto-repeat", pack_module (module Auto_repeat);
    ( Value "extended-time-no-interp",
      pack_module (module Extended_time_no_interp) );
    ( Value "timing-function-no-interp",
      pack_module (module Timing_function_no_interp) );
    ( Value "cubic-bezier-timing-function",
      pack_module (module Cubic_bezier_timing_function) );
    Value "step-timing-function", pack_module (module Step_timing_function);
    Value "single-animation", pack_module (module Single_animation);
    ( Value "single-animation-no-interp",
      pack_module (module Single_animation_no_interp) );
    ( Value "single-animation-direction-no-interp",
      pack_module (module Single_animation_direction_no_interp) );
    ( Value "single-animation-fill-mode-no-interp",
      pack_module (module Single_animation_fill_mode_no_interp) );
    ( Value "single-animation-iteration-count-no-interp",
      pack_module (module Single_animation_iteration_count_no_interp) );
    ( Value "single-animation-play-state-no-interp",
      pack_module (module Single_animation_play_state_no_interp) );
    Value "shadow-t", pack_module (module Shadow_t);
    Value "font-weight-absolute", pack_module (module Font_weight_absolute);
    (* Commonly referenced values *)
    Value "position", pack_module (module Position);
    Value "timing-function", pack_module (module Timing_function);
    Value "number-percentage", pack_module (module Number_percentage);
    Value "grid-line", pack_module (module Grid_line);
    ( Value "single-transition-property",
      pack_module (module Single_transition_property) );
    Value "outline-radius", pack_module (module Outline_radius);
    Value "bg-size", pack_module (module Bg_size);
    Value "bg-position", pack_module (module Bg_position);
    Value "feature-value-name", pack_module (module Feature_value_name);
    Value "svg-length", pack_module (module Svg_length);
    ( Value "single-animation-iteration-count",
      pack_module (module Single_animation_iteration_count) );
    Value "basic-shape", pack_module (module Basic_shape);
    Value "filter-function", pack_module (module Filter_function);
    Function "attr()", pack_module (module Function_attr);
    Function "symbols()", pack_module (module Function_symbols);
    (* Gradient functions *)
    Function "linear-gradient()", pack_module (module Function_linear_gradient);
    Function "radial-gradient()", pack_module (module Function_radial_gradient);
    Function "conic-gradient()", pack_module (module Function_conic_gradient);
    ( Function "repeating-linear-gradient()",
      pack_module (module Function_repeating_linear_gradient) );
    ( Function "repeating-radial-gradient()",
      pack_module (module Function_repeating_radial_gradient) );
    ( Function "-webkit-gradient()",
      pack_module (module Function__webkit_gradient) );
    (* Transform functions *)
    Function "matrix()", pack_module (module Function_matrix);
    Function "matrix3d()", pack_module (module Function_matrix3d);
    Function "translate()", pack_module (module Function_translate);
    Function "translateX()", pack_module (module Function_translateX);
    Function "translateY()", pack_module (module Function_translateY);
    Function "translateZ()", pack_module (module Function_translateZ);
    Function "translate3d()", pack_module (module Function_translate3d);
    Function "scale()", pack_module (module Function_scale);
    Function "scale3d()", pack_module (module Function_scale3d);
    Function "scaleX()", pack_module (module Function_scaleX);
    Function "scaleY()", pack_module (module Function_scaleY);
    Function "scaleZ()", pack_module (module Function_scaleZ);
    Function "rotate()", pack_module (module Function_rotate);
    Function "rotate3d()", pack_module (module Function_rotate3d);
    Function "rotateX()", pack_module (module Function_rotateX);
    Function "rotateY()", pack_module (module Function_rotateY);
    Function "rotateZ()", pack_module (module Function_rotateZ);
    Function "skew()", pack_module (module Function_skew);
    Function "skewX()", pack_module (module Function_skewX);
    Function "skewY()", pack_module (module Function_skewY);
    Function "perspective()", pack_module (module Function_perspective);
    Value "overflow-position", pack_module (module Overflow_position);
    Value "relative-size", pack_module (module Relative_size);
    Value "repeat-style", pack_module (module Repeat_style);
    Value "self-position", pack_module (module Self_position);
    ( Value "single-animation-direction",
      pack_module (module Single_animation_direction) );
    ( Value "single-animation-fill-mode",
      pack_module (module Single_animation_fill_mode) );
    ( Value "single-animation-play-state",
      pack_module (module Single_animation_play_state) );
    Value "step-position", pack_module (module Step_position);
    Value "symbols-type", pack_module (module Symbols_type);
    Value "masking-mode", pack_module (module Masking_mode);
    Value "numeric-figure-values", pack_module (module Numeric_figure_values);
    Value "numeric-spacing-values", pack_module (module Numeric_spacing_values);
    Value "absolute-size", pack_module (module Absolute_size);
    Value "content-position", pack_module (module Content_position);
    Value "baseline-position", pack_module (module Baseline_position);
    Value "blend-mode", pack_module (module Blend_mode);
    Value "geometry-box", pack_module (module Geometry_box);
    ( Property "-webkit-appearance",
      pack_module (module Property__webkit_appearance) );
    Property "stroke-linejoin", pack_module (module Property_stroke_linejoin);
    ( Property "perspective-origin",
      pack_module (module Property_perspective_origin) );
    (* CSS Math Functions *)
    Function "calc()", pack_module (module Function_calc);
    Function "min()", pack_module (module Function_min);
    Function "max()", pack_module (module Function_max);
    (* CSS Color Functions *)
    Function "rgb()", pack_module (module Function_rgb);
    Function "rgba()", pack_module (module Function_rgba);
    Function "hsl()", pack_module (module Function_hsl);
    Function "hsla()", pack_module (module Function_hsla);
    Function "var()", pack_module (module Function_var);
    Function "hwb()", pack_module (module Function_hwb);
    Function "lab()", pack_module (module Function_lab);
    Function "lch()", pack_module (module Function_lch);
    Function "oklab()", pack_module (module Function_oklab);
    Function "oklch()", pack_module (module Function_oklch);
    Function "color()", pack_module (module Function_color);
    Function "light-dark()", pack_module (module Function_light_dark);
    Function "color-mix()", pack_module (module Function_color_mix);
    (* CSS Calc internal types *)
    Value "calc-product", pack_module (module Calc_product);
    Value "calc-sum", pack_module (module Calc_sum);
    Value "calc-value", pack_module (module Calc_value);
    (* Media query building blocks *)
    Value "mf-eq", pack_module (module Mf_eq);
    Value "mf-gt", pack_module (module Mf_gt);
    Value "mf-lt", pack_module (module Mf_lt);
    (* Media query types *)
    Property "media-type", pack_module (module Property_media_type);
    Property "container-type", pack_module (module Property_container_type);
    Value "dimension", pack_module (module Dimension);
    Value "ratio", pack_module (module Ratio);
    Value "mf-name", pack_module (module Mf_name);
    Value "mf-value", pack_module (module Mf_value);
    Value "mf-boolean", pack_module (module Mf_boolean);
    Value "mf-plain", pack_module (module Mf_plain);
    Value "mf-comparison", pack_module (module Mf_comparison);
    Value "mf-range", pack_module (module Mf_range);
    (* Media query types *)
    Media_query "media-feature", pack_module (module Media_feature);
    Media_query "media-in-parens", pack_module (module Media_in_parens);
    Media_query "media-or", pack_module (module Media_or);
    Media_query "media-and", pack_module (module Media_and);
    Media_query "media-not", pack_module (module Media_not);
    ( Media_query "media-condition-without-or",
      pack_module (module Media_condition_without_or) );
    Media_query "media-condition", pack_module (module Media_condition);
    Media_query "media-query", pack_module (module Media_query);
    Media_query "media-query-list", pack_module (module Media_query_list);
    (* Container query types *)
    Value "container-query", pack_module (module Container_query);
    Value "container-condition", pack_module (module Container_condition);
    Value "query-in-parens", pack_module (module Query_in_parens);
    Value "size-feature", pack_module (module Size_feature);
    Value "style-query", pack_module (module Style_query);
    Value "style-feature", pack_module (module Style_feature);
    Value "style-in-parens", pack_module (module Style_in_parens);
    (* Legacy/Non-standard values - keyword only *)
    ( Value "legacy-radial-gradient-shape",
      pack_module (module Legacy_radial_gradient_shape) );
    ( Value "legacy-radial-gradient-size",
      pack_module (module Legacy_radial_gradient_size) );
    ( Value "legacy-radial-gradient-arguments",
      pack_module (module Legacy_radial_gradient_arguments) );
    Value "legacy-radial-gradient", pack_module (module Legacy_radial_gradient);
    ( Value "legacy-repeating-radial-gradient",
      pack_module (module Legacy_repeating_radial_gradient) );
    Value "legacy-linear-gradient", pack_module (module Legacy_linear_gradient);
    ( Value "legacy-linear-gradient-arguments",
      pack_module (module Legacy_linear_gradient_arguments) );
    ( Value "legacy-repeating-linear-gradient",
      pack_module (module Legacy_repeating_linear_gradient) );
    Value "legacy-gradient", pack_module (module Legacy_gradient);
    Value "-non-standard-color", pack_module (module Non_standard_color);
    Value "-non-standard-font", pack_module (module Non_standard_font);
    ( Value "-non-standard-image-rendering",
      pack_module (module Non_standard_image_rendering) );
    Value "-non-standard-overflow", pack_module (module Non_standard_overflow);
    Value "-non-standard-width", pack_module (module Non_standard_width);
    Value "-webkit-gradient-type", pack_module (module Webkit_gradient_type);
    Value "-webkit-mask-box-repeat", pack_module (module Webkit_mask_box_repeat);
    Value "-webkit-mask-clip-style", pack_module (module Webkit_mask_clip_style);
    (* Keyword-only CSS values *)
    Value "common-lig-values", pack_module (module Common_lig_values);
    Value "compat-auto", pack_module (module Compat_auto);
    Value "composite-style", pack_module (module Composite_style);
    Value "compositing-operator", pack_module (module Compositing_operator);
    Value "content-distribution", pack_module (module Content_distribution);
    ( Value "deprecated-system-color",
      pack_module (module Deprecated_system_color) );
    ( Value "discretionary-lig-values",
      pack_module (module Discretionary_lig_values) );
    Value "display-inside", pack_module (module Display_inside);
    Value "display-internal", pack_module (module Display_internal);
    Value "display-legacy", pack_module (module Display_legacy);
    ( Value "east-asian-variant-values",
      pack_module (module East_asian_variant_values) );
    Value "feature-type", pack_module (module Feature_type);
    Value "font-variant-css21", pack_module (module Font_variant_css21);
    Value "generic-family", pack_module (module Generic_family);
    Value "generic-name", pack_module (module Generic_name);
    Value "historical-lig-values", pack_module (module Historical_lig_values);
    ( Value "numeric-fraction-values",
      pack_module (module Numeric_fraction_values) );
    (* Value "overflow-position-value", pack_module (module Overflow_position); *)
    Value "page-margin-box-type", pack_module (module Page_margin_box_type);
    Value "polar-color-space", pack_module (module Polar_color_space);
    Value "predefined-color-space", pack_module (module Predefined_color_space);
    Value "quote", pack_module (module Quote);
    ( Value "rectangular-color-space",
      pack_module (module Rectangular_color_space) );
    Value "shape-box", pack_module (module Shape_box);
    Value "visual-box", pack_module (module Visual_box);
    (* ============================================= *)
    (* Missing Properties - Added via registry scan *)
    (* ============================================= *)
    Property "-moz-appearance", pack_module (module Property__moz_appearance);
    ( Property "-moz-background-clip",
      pack_module (module Property__moz_background_clip) );
    Property "-moz-binding", pack_module (module Property__moz_binding);
    ( Property "-moz-border-bottom-colors",
      pack_module (module Property__moz_border_bottom_colors) );
    ( Property "-moz-border-left-colors",
      pack_module (module Property__moz_border_left_colors) );
    ( Property "-moz-border-radius-bottomleft",
      pack_module (module Property__moz_border_radius_bottomleft) );
    ( Property "-moz-border-radius-bottomright",
      pack_module (module Property__moz_border_radius_bottomright) );
    ( Property "-moz-border-radius-topleft",
      pack_module (module Property__moz_border_radius_topleft) );
    ( Property "-moz-border-radius-topright",
      pack_module (module Property__moz_border_radius_topright) );
    ( Property "-moz-border-right-colors",
      pack_module (module Property__moz_border_right_colors) );
    ( Property "-moz-border-top-colors",
      pack_module (module Property__moz_border_top_colors) );
    ( Property "-moz-context-properties",
      pack_module (module Property__moz_context_properties) );
    ( Property "-moz-control-character-visibility",
      pack_module (module Property__moz_control_character_visibility) );
    Property "-moz-float-edge", pack_module (module Property__moz_float_edge);
    ( Property "-moz-force-broken-image-icon",
      pack_module (module Property__moz_force_broken_image_icon) );
    ( Property "-moz-image-region",
      pack_module (module Property__moz_image_region) );
    Property "-moz-orient", pack_module (module Property__moz_orient);
    ( Property "-moz-osx-font-smoothing",
      pack_module (module Property__moz_osx_font_smoothing) );
    ( Property "-moz-outline-radius",
      pack_module (module Property__moz_outline_radius) );
    ( Property "-moz-outline-radius-bottomleft",
      pack_module (module Property__moz_outline_radius_bottomleft) );
    ( Property "-moz-outline-radius-bottomright",
      pack_module (module Property__moz_outline_radius_bottomright) );
    ( Property "-moz-outline-radius-topleft",
      pack_module (module Property__moz_outline_radius_topleft) );
    ( Property "-moz-outline-radius-topright",
      pack_module (module Property__moz_outline_radius_topright) );
    ( Property "-moz-stack-sizing",
      pack_module (module Property__moz_stack_sizing) );
    Property "-moz-text-blink", pack_module (module Property__moz_text_blink);
    Property "-moz-user-focus", pack_module (module Property__moz_user_focus);
    Property "-moz-user-input", pack_module (module Property__moz_user_input);
    Property "-moz-user-modify", pack_module (module Property__moz_user_modify);
    Property "-moz-user-select", pack_module (module Property__moz_user_select);
    ( Property "-moz-window-dragging",
      pack_module (module Property__moz_window_dragging) );
    ( Property "-moz-window-shadow",
      pack_module (module Property__moz_window_shadow) );
    ( Property "-webkit-background-clip",
      pack_module (module Property__webkit_background_clip) );
    ( Property "-webkit-border-before",
      pack_module (module Property__webkit_border_before) );
    ( Property "-webkit-border-before-color",
      pack_module (module Property__webkit_border_before_color) );
    ( Property "-webkit-border-before-style",
      pack_module (module Property__webkit_border_before_style) );
    ( Property "-webkit-border-before-width",
      pack_module (module Property__webkit_border_before_width) );
    ( Property "-webkit-box-reflect",
      pack_module (module Property__webkit_box_reflect) );
    ( Property "-webkit-column-break-after",
      pack_module (module Property__webkit_column_break_after) );
    ( Property "-webkit-column-break-before",
      pack_module (module Property__webkit_column_break_before) );
    ( Property "-webkit-column-break-inside",
      pack_module (module Property__webkit_column_break_inside) );
    ( Property "-webkit-font-smoothing",
      pack_module (module Property__webkit_font_smoothing) );
    ( Property "-webkit-line-clamp",
      pack_module (module Property__webkit_line_clamp) );
    Property "-webkit-mask", pack_module (module Property__webkit_mask);
    ( Property "-webkit-mask-attachment",
      pack_module (module Property__webkit_mask_attachment) );
    ( Property "-webkit-mask-box-image",
      pack_module (module Property__webkit_mask_box_image) );
    ( Property "-webkit-mask-clip",
      pack_module (module Property__webkit_mask_clip) );
    ( Property "-webkit-mask-composite",
      pack_module (module Property__webkit_mask_composite) );
    ( Property "-webkit-mask-image",
      pack_module (module Property__webkit_mask_image) );
    ( Property "-webkit-mask-origin",
      pack_module (module Property__webkit_mask_origin) );
    ( Property "-webkit-mask-position",
      pack_module (module Property__webkit_mask_position) );
    ( Property "-webkit-mask-position-x",
      pack_module (module Property__webkit_mask_position_x) );
    ( Property "-webkit-mask-position-y",
      pack_module (module Property__webkit_mask_position_y) );
    ( Property "-webkit-mask-repeat",
      pack_module (module Property__webkit_mask_repeat) );
    ( Property "-webkit-mask-repeat-x",
      pack_module (module Property__webkit_mask_repeat_x) );
    ( Property "-webkit-mask-repeat-y",
      pack_module (module Property__webkit_mask_repeat_y) );
    ( Property "-webkit-mask-size",
      pack_module (module Property__webkit_mask_size) );
    ( Property "-webkit-overflow-scrolling",
      pack_module (module Property__webkit_overflow_scrolling) );
    ( Property "-webkit-print-color-adjust",
      pack_module (module Property__webkit_print_color_adjust) );
    ( Property "-webkit-tap-highlight-color",
      pack_module (module Property__webkit_tap_highlight_color) );
    ( Property "-webkit-text-fill-color",
      pack_module (module Property__webkit_text_fill_color) );
    ( Property "-webkit-text-security",
      pack_module (module Property__webkit_text_security) );
    ( Property "-webkit-text-stroke",
      pack_module (module Property__webkit_text_stroke) );
    ( Property "-webkit-text-stroke-color",
      pack_module (module Property__webkit_text_stroke_color) );
    ( Property "-webkit-text-stroke-width",
      pack_module (module Property__webkit_text_stroke_width) );
    ( Property "-webkit-touch-callout",
      pack_module (module Property__webkit_touch_callout) );
    ( Property "-webkit-user-drag",
      pack_module (module Property__webkit_user_drag) );
    ( Property "-webkit-user-modify",
      pack_module (module Property__webkit_user_modify) );
    ( Property "-webkit-user-select",
      pack_module (module Property__webkit_user_select) );
    (* Vendor-prefixed properties - Microsoft *)
    ( Property "-ms-overflow-style",
      pack_module (module Property__ms_overflow_style) );
    Property "accent-color", pack_module (module Property_accent_color);
    ( Property "alignment-baseline",
      pack_module (module Property_alignment_baseline) );
    Property "anchor-name", pack_module (module Property_anchor_name);
    Property "anchor-scope", pack_module (module Property_anchor_scope);
    Property "animation", pack_module (module Property_animation);
    ( Property "animation-composition",
      pack_module (module Property_animation_composition) );
    Property "animation-delay", pack_module (module Property_animation_delay);
    ( Property "animation-delay-end",
      pack_module (module Property_animation_delay_end) );
    ( Property "animation-delay-start",
      pack_module (module Property_animation_delay_start) );
    ( Property "animation-direction",
      pack_module (module Property_animation_direction) );
    ( Property "animation-duration",
      pack_module (module Property_animation_duration) );
    ( Property "animation-fill-mode",
      pack_module (module Property_animation_fill_mode) );
    ( Property "animation-iteration-count",
      pack_module (module Property_animation_iteration_count) );
    Property "animation-name", pack_module (module Property_animation_name);
    ( Property "animation-play-state",
      pack_module (module Property_animation_play_state) );
    Property "animation-range", pack_module (module Property_animation_range);
    ( Property "animation-range-end",
      pack_module (module Property_animation_range_end) );
    ( Property "animation-range-start",
      pack_module (module Property_animation_range_start) );
    ( Property "animation-timeline",
      pack_module (module Property_animation_timeline) );
    ( Property "animation-timing-function",
      pack_module (module Property_animation_timing_function) );
    Property "aspect-ratio", pack_module (module Property_aspect_ratio);
    Property "azimuth", pack_module (module Property_azimuth);
    Property "backdrop-blur", pack_module (module Property_backdrop_blur);
    Property "backdrop-filter", pack_module (module Property_backdrop_filter);
    Property "background", pack_module (module Property_background);
    ( Property "background-attachment",
      pack_module (module Property_background_attachment) );
    ( Property "background-blend-mode",
      pack_module (module Property_background_blend_mode) );
    Property "background-clip", pack_module (module Property_background_clip);
    Property "background-color", pack_module (module Property_background_color);
    Property "background-image", pack_module (module Property_background_image);
    ( Property "background-origin",
      pack_module (module Property_background_origin) );
    ( Property "background-position",
      pack_module (module Property_background_position) );
    ( Property "background-position-x",
      pack_module (module Property_background_position_x) );
    ( Property "background-position-y",
      pack_module (module Property_background_position_y) );
    ( Property "background-repeat",
      pack_module (module Property_background_repeat) );
    Property "background-size", pack_module (module Property_background_size);
    Property "baseline-shift", pack_module (module Property_baseline_shift);
    Property "behavior", pack_module (module Property_behavior);
    Property "bleed", pack_module (module Property_bleed);
    Property "block-overflow", pack_module (module Property_block_overflow);
    Property "block-size", pack_module (module Property_block_size);
    Property "border-block", pack_module (module Property_border_block);
    ( Property "border-block-color",
      pack_module (module Property_border_block_color) );
    Property "border-block-end", pack_module (module Property_border_block_end);
    ( Property "border-block-end-color",
      pack_module (module Property_border_block_end_color) );
    ( Property "border-block-end-style",
      pack_module (module Property_border_block_end_style) );
    ( Property "border-block-end-width",
      pack_module (module Property_border_block_end_width) );
    ( Property "border-block-start",
      pack_module (module Property_border_block_start) );
    ( Property "border-block-start-color",
      pack_module (module Property_border_block_start_color) );
    ( Property "border-block-start-style",
      pack_module (module Property_border_block_start_style) );
    ( Property "border-block-start-width",
      pack_module (module Property_border_block_start_width) );
    ( Property "border-block-style",
      pack_module (module Property_border_block_style) );
    ( Property "border-block-width",
      pack_module (module Property_border_block_width) );
    Property "border-bottom", pack_module (module Property_border_bottom);
    ( Property "border-bottom-color",
      pack_module (module Property_border_bottom_color) );
    ( Property "border-bottom-left-radius",
      pack_module (module Property_border_bottom_left_radius) );
    ( Property "border-bottom-right-radius",
      pack_module (module Property_border_bottom_right_radius) );
    ( Property "border-bottom-style",
      pack_module (module Property_border_bottom_style) );
    ( Property "border-bottom-width",
      pack_module (module Property_border_bottom_width) );
    Property "border-color", pack_module (module Property_border_color);
    ( Property "border-end-end-radius",
      pack_module (module Property_border_end_end_radius) );
    ( Property "border-end-start-radius",
      pack_module (module Property_border_end_start_radius) );
    Property "border-image", pack_module (module Property_border_image);
    ( Property "border-image-outset",
      pack_module (module Property_border_image_outset) );
    ( Property "border-image-slice",
      pack_module (module Property_border_image_slice) );
    ( Property "border-image-source",
      pack_module (module Property_border_image_source) );
    ( Property "border-image-width",
      pack_module (module Property_border_image_width) );
    Property "border-inline", pack_module (module Property_border_inline);
    ( Property "border-inline-color",
      pack_module (module Property_border_inline_color) );
    ( Property "border-inline-end",
      pack_module (module Property_border_inline_end) );
    ( Property "border-inline-end-color",
      pack_module (module Property_border_inline_end_color) );
    ( Property "border-inline-end-style",
      pack_module (module Property_border_inline_end_style) );
    ( Property "border-inline-end-width",
      pack_module (module Property_border_inline_end_width) );
    ( Property "border-inline-start",
      pack_module (module Property_border_inline_start) );
    ( Property "border-inline-start-color",
      pack_module (module Property_border_inline_start_color) );
    ( Property "border-inline-start-style",
      pack_module (module Property_border_inline_start_style) );
    ( Property "border-inline-start-width",
      pack_module (module Property_border_inline_start_width) );
    ( Property "border-inline-style",
      pack_module (module Property_border_inline_style) );
    ( Property "border-inline-width",
      pack_module (module Property_border_inline_width) );
    Property "border-left", pack_module (module Property_border_left);
    ( Property "border-left-color",
      pack_module (module Property_border_left_color) );
    ( Property "border-left-style",
      pack_module (module Property_border_left_style) );
    ( Property "border-left-width",
      pack_module (module Property_border_left_width) );
    Property "border-radius", pack_module (module Property_border_radius);
    Property "border-right", pack_module (module Property_border_right);
    ( Property "border-right-color",
      pack_module (module Property_border_right_color) );
    ( Property "border-right-style",
      pack_module (module Property_border_right_style) );
    ( Property "border-right-width",
      pack_module (module Property_border_right_width) );
    Property "border-spacing", pack_module (module Property_border_spacing);
    ( Property "border-start-end-radius",
      pack_module (module Property_border_start_end_radius) );
    ( Property "border-start-start-radius",
      pack_module (module Property_border_start_start_radius) );
    Property "border-style", pack_module (module Property_border_style);
    Property "border-top", pack_module (module Property_border_top);
    Property "border-top-color", pack_module (module Property_border_top_color);
    ( Property "border-top-left-radius",
      pack_module (module Property_border_top_left_radius) );
    ( Property "border-top-right-radius",
      pack_module (module Property_border_top_right_radius) );
    Property "border-top-style", pack_module (module Property_border_top_style);
    Property "border-top-width", pack_module (module Property_border_top_width);
    Property "border-width", pack_module (module Property_border_width);
    Property "bottom", pack_module (module Property_bottom);
    Property "box-align", pack_module (module Property_box_align);
    Property "box-direction", pack_module (module Property_box_direction);
    Property "box-flex", pack_module (module Property_box_flex);
    Property "box-flex-group", pack_module (module Property_box_flex_group);
    Property "box-lines", pack_module (module Property_box_lines);
    ( Property "box-ordinal-group",
      pack_module (module Property_box_ordinal_group) );
    Property "box-orient", pack_module (module Property_box_orient);
    Property "-webkit-box-orient", pack_module (module Property_box_orient);
    Property "box-pack", pack_module (module Property_box_pack);
    Property "box-shadow", pack_module (module Property_box_shadow);
    Property "-webkit-box-shadow", pack_module (module Property_box_shadow);
    Property "clip", pack_module (module Property_clip);
    Property "clip-path", pack_module (module Property_clip_path);
    Property "color", pack_module (module Property_color);
    ( Property "color-interpolation",
      pack_module (module Property_color_interpolation) );
    ( Property "color-interpolation-filters",
      pack_module (module Property_color_interpolation_filters) );
    Property "color-rendering", pack_module (module Property_color_rendering);
    Property "column-count", pack_module (module Property_column_count);
    Property "column-rule", pack_module (module Property_column_rule);
    ( Property "column-rule-color",
      pack_module (module Property_column_rule_color) );
    ( Property "column-rule-style",
      pack_module (module Property_column_rule_style) );
    ( Property "column-rule-width",
      pack_module (module Property_column_rule_width) );
    Property "column-width", pack_module (module Property_column_width);
    Property "columns", pack_module (module Property_columns);
    ( Property "contain-intrinsic-block-size",
      pack_module (module Property_contain_intrinsic_block_size) );
    ( Property "contain-intrinsic-height",
      pack_module (module Property_contain_intrinsic_height) );
    ( Property "contain-intrinsic-inline-size",
      pack_module (module Property_contain_intrinsic_inline_size) );
    ( Property "contain-intrinsic-width",
      pack_module (module Property_contain_intrinsic_width) );
    Property "container", pack_module (module Property_container);
    Property "container-name", pack_module (module Property_container_name);
    ( Property "container-name-computed",
      pack_module (module Property_container_name_computed) );
    Property "content", pack_module (module Property_content);
    ( Property "counter-increment",
      pack_module (module Property_counter_increment) );
    Property "counter-reset", pack_module (module Property_counter_reset);
    Property "counter-set", pack_module (module Property_counter_set);
    Property "cue", pack_module (module Property_cue);
    Property "cue-after", pack_module (module Property_cue_after);
    Property "cue-before", pack_module (module Property_cue_before);
    Property "cursor", pack_module (module Property_cursor);
    Property "cx", pack_module (module Property_cx);
    Property "cy", pack_module (module Property_cy);
    Property "d", pack_module (module Property_d);
    ( Property "dominant-baseline",
      pack_module (module Property_dominant_baseline) );
    Property "field-sizing", pack_module (module Property_field_sizing);
    Property "fill", pack_module (module Property_fill);
    Property "fill-opacity", pack_module (module Property_fill_opacity);
    Property "fill-rule", pack_module (module Property_fill_rule);
    Property "filter", pack_module (module Property_filter);
    Property "flex", pack_module (module Property_flex);
    Property "flex-flow", pack_module (module Property_flex_flow);
    Property "flood-color", pack_module (module Property_flood_color);
    Property "flood-opacity", pack_module (module Property_flood_opacity);
    Property "font", pack_module (module Property_font);
    Property "font-family", pack_module (module Property_font_family);
    ( Property "font-feature-settings",
      pack_module (module Property_font_feature_settings) );
    ( Property "font-language-override",
      pack_module (module Property_font_language_override) );
    Property "font-size", pack_module (module Property_font_size);
    Property "font-size-adjust", pack_module (module Property_font_size_adjust);
    Property "font-smooth", pack_module (module Property_font_smooth);
    Property "font-synthesis", pack_module (module Property_font_synthesis);
    Property "font-variant", pack_module (module Property_font_variant);
    ( Property "font-variant-alternates",
      pack_module (module Property_font_variant_alternates) );
    ( Property "font-variant-east-asian",
      pack_module (module Property_font_variant_east_asian) );
    ( Property "font-variant-emoji",
      pack_module (module Property_font_variant_emoji) );
    ( Property "font-variant-ligatures",
      pack_module (module Property_font_variant_ligatures) );
    ( Property "font-variant-numeric",
      pack_module (module Property_font_variant_numeric) );
    ( Property "font-variation-settings",
      pack_module (module Property_font_variation_settings) );
    Property "font-weight", pack_module (module Property_font_weight);
    Property "gap", pack_module (module Property_gap);
    ( Property "glyph-orientation-horizontal",
      pack_module (module Property_glyph_orientation_horizontal) );
    ( Property "glyph-orientation-vertical",
      pack_module (module Property_glyph_orientation_vertical) );
    Property "grid", pack_module (module Property_grid);
    Property "grid-area", pack_module (module Property_grid_area);
    ( Property "grid-auto-columns",
      pack_module (module Property_grid_auto_columns) );
    Property "grid-auto-rows", pack_module (module Property_grid_auto_rows);
    Property "grid-column", pack_module (module Property_grid_column);
    Property "grid-column-end", pack_module (module Property_grid_column_end);
    Property "grid-column-gap", pack_module (module Property_grid_column_gap);
    ( Property "grid-column-start",
      pack_module (module Property_grid_column_start) );
    Property "grid-gap", pack_module (module Property_grid_gap);
    Property "grid-row", pack_module (module Property_grid_row);
    Property "grid-row-end", pack_module (module Property_grid_row_end);
    Property "grid-row-gap", pack_module (module Property_grid_row_gap);
    Property "grid-row-start", pack_module (module Property_grid_row_start);
    Property "grid-template", pack_module (module Property_grid_template);
    ( Property "grid-template-areas",
      pack_module (module Property_grid_template_areas) );
    ( Property "grid-template-columns",
      pack_module (module Property_grid_template_columns) );
    ( Property "grid-template-rows",
      pack_module (module Property_grid_template_rows) );
    ( Property "hanging-punctuation",
      pack_module (module Property_hanging_punctuation) );
    Property "height", pack_module (module Property_height);
    ( Property "hyphenate-character",
      pack_module (module Property_hyphenate_character) );
    ( Property "hyphenate-limit-chars",
      pack_module (module Property_hyphenate_limit_chars) );
    ( Property "hyphenate-limit-last",
      pack_module (module Property_hyphenate_limit_last) );
    ( Property "hyphenate-limit-lines",
      pack_module (module Property_hyphenate_limit_lines) );
    ( Property "hyphenate-limit-zone",
      pack_module (module Property_hyphenate_limit_zone) );
    ( Property "image-orientation",
      pack_module (module Property_image_orientation) );
    Property "image-resolution", pack_module (module Property_image_resolution);
    Property "ime-mode", pack_module (module Property_ime_mode);
    Property "inherits", pack_module (module Property_inherits);
    Property "initial-letter", pack_module (module Property_initial_letter);
    ( Property "initial-letter-align",
      pack_module (module Property_initial_letter_align) );
    Property "initial-value", pack_module (module Property_initial_value);
    Property "inline-size", pack_module (module Property_inline_size);
    Property "inset", pack_module (module Property_inset);
    Property "inset-area", pack_module (module Property_inset_area);
    Property "inset-block", pack_module (module Property_inset_block);
    Property "inset-block-end", pack_module (module Property_inset_block_end);
    ( Property "inset-block-start",
      pack_module (module Property_inset_block_start) );
    Property "inset-inline", pack_module (module Property_inset_inline);
    Property "inset-inline-end", pack_module (module Property_inset_inline_end);
    ( Property "inset-inline-start",
      pack_module (module Property_inset_inline_start) );
    Property "interpolate-size", pack_module (module Property_interpolate_size);
    Property "kerning", pack_module (module Property_kerning);
    Property "layout-grid", pack_module (module Property_layout_grid);
    Property "layout-grid-char", pack_module (module Property_layout_grid_char);
    Property "layout-grid-line", pack_module (module Property_layout_grid_line);
    Property "layout-grid-mode", pack_module (module Property_layout_grid_mode);
    Property "layout-grid-type", pack_module (module Property_layout_grid_type);
    Property "left", pack_module (module Property_left);
    Property "letter-spacing", pack_module (module Property_letter_spacing);
    Property "lighting-color", pack_module (module Property_lighting_color);
    Property "line-break", pack_module (module Property_line_break);
    Property "line-clamp", pack_module (module Property_line_clamp);
    Property "line-height", pack_module (module Property_line_height);
    Property "line-height-step", pack_module (module Property_line_height_step);
    Property "list-style", pack_module (module Property_list_style);
    Property "list-style-image", pack_module (module Property_list_style_image);
    Property "margin", pack_module (module Property_margin);
    Property "margin-block", pack_module (module Property_margin_block);
    Property "margin-block-end", pack_module (module Property_margin_block_end);
    ( Property "margin-block-start",
      pack_module (module Property_margin_block_start) );
    Property "margin-bottom", pack_module (module Property_margin_bottom);
    Property "margin-inline", pack_module (module Property_margin_inline);
    ( Property "margin-inline-end",
      pack_module (module Property_margin_inline_end) );
    ( Property "margin-inline-start",
      pack_module (module Property_margin_inline_start) );
    Property "margin-left", pack_module (module Property_margin_left);
    Property "margin-right", pack_module (module Property_margin_right);
    Property "margin-top", pack_module (module Property_margin_top);
    Property "margin-trim", pack_module (module Property_margin_trim);
    Property "marker", pack_module (module Property_marker);
    Property "marker-end", pack_module (module Property_marker_end);
    Property "marker-mid", pack_module (module Property_marker_mid);
    Property "marker-start", pack_module (module Property_marker_start);
    Property "marks", pack_module (module Property_marks);
    Property "mask", pack_module (module Property_mask);
    Property "mask-border", pack_module (module Property_mask_border);
    ( Property "mask-border-outset",
      pack_module (module Property_mask_border_outset) );
    ( Property "mask-border-repeat",
      pack_module (module Property_mask_border_repeat) );
    ( Property "mask-border-slice",
      pack_module (module Property_mask_border_slice) );
    ( Property "mask-border-source",
      pack_module (module Property_mask_border_source) );
    ( Property "mask-border-width",
      pack_module (module Property_mask_border_width) );
    Property "mask-clip", pack_module (module Property_mask_clip);
    Property "mask-composite", pack_module (module Property_mask_composite);
    Property "mask-image", pack_module (module Property_mask_image);
    Property "mask-mode", pack_module (module Property_mask_mode);
    Property "mask-origin", pack_module (module Property_mask_origin);
    Property "mask-position", pack_module (module Property_mask_position);
    Property "mask-repeat", pack_module (module Property_mask_repeat);
    Property "mask-size", pack_module (module Property_mask_size);
    ( Property "masonry-auto-flow",
      pack_module (module Property_masonry_auto_flow) );
    Property "math-depth", pack_module (module Property_math_depth);
    Property "math-shift", pack_module (module Property_math_shift);
    Property "math-style", pack_module (module Property_math_style);
    Property "max-block-size", pack_module (module Property_max_block_size);
    Property "max-height", pack_module (module Property_max_height);
    Property "max-inline-size", pack_module (module Property_max_inline_size);
    Property "max-lines", pack_module (module Property_max_lines);
    Property "max-width", pack_module (module Property_max_width);
    Property "media-any-hover", pack_module (module Property_media_any_hover);
    ( Property "media-any-pointer",
      pack_module (module Property_media_any_pointer) );
    ( Property "media-color-gamut",
      pack_module (module Property_media_color_gamut) );
    ( Property "media-color-index",
      pack_module (module Property_media_color_index) );
    ( Property "media-display-mode",
      pack_module (module Property_media_display_mode) );
    ( Property "media-forced-colors",
      pack_module (module Property_media_forced_colors) );
    Property "media-grid", pack_module (module Property_media_grid);
    Property "media-hover", pack_module (module Property_media_hover);
    ( Property "media-inverted-colors",
      pack_module (module Property_media_inverted_colors) );
    ( Property "media-max-aspect-ratio",
      pack_module (module Property_media_max_aspect_ratio) );
    ( Property "media-max-resolution",
      pack_module (module Property_media_max_resolution) );
    ( Property "media-min-aspect-ratio",
      pack_module (module Property_media_min_aspect_ratio) );
    Property "media-min-color", pack_module (module Property_media_min_color);
    ( Property "media-min-color-index",
      pack_module (module Property_media_min_color_index) );
    ( Property "media-min-resolution",
      pack_module (module Property_media_min_resolution) );
    Property "media-monochrome", pack_module (module Property_media_monochrome);
    ( Property "media-orientation",
      pack_module (module Property_media_orientation) );
    Property "media-pointer", pack_module (module Property_media_pointer);
    ( Property "media-prefers-color-scheme",
      pack_module (module Property_media_prefers_color_scheme) );
    ( Property "media-prefers-contrast",
      pack_module (module Property_media_prefers_contrast) );
    ( Property "media-prefers-reduced-motion",
      pack_module (module Property_media_prefers_reduced_motion) );
    Property "media-resolution", pack_module (module Property_media_resolution);
    Property "media-scripting", pack_module (module Property_media_scripting);
    Property "media-update", pack_module (module Property_media_update);
    Property "min-block-size", pack_module (module Property_min_block_size);
    Property "min-height", pack_module (module Property_min_height);
    Property "min-inline-size", pack_module (module Property_min_inline_size);
    Property "min-width", pack_module (module Property_min_width);
    Property "nav-down", pack_module (module Property_nav_down);
    Property "nav-left", pack_module (module Property_nav_left);
    Property "nav-right", pack_module (module Property_nav_right);
    Property "nav-up", pack_module (module Property_nav_up);
    Property "object-position", pack_module (module Property_object_position);
    Property "offset", pack_module (module Property_offset);
    Property "offset-anchor", pack_module (module Property_offset_anchor);
    Property "offset-distance", pack_module (module Property_offset_distance);
    Property "offset-path", pack_module (module Property_offset_path);
    Property "offset-position", pack_module (module Property_offset_position);
    Property "offset-rotate", pack_module (module Property_offset_rotate);
    Property "opacity", pack_module (module Property_opacity);
    Property "order", pack_module (module Property_order);
    Property "orphans", pack_module (module Property_orphans);
    Property "outline", pack_module (module Property_outline);
    Property "outline-color", pack_module (module Property_outline_color);
    Property "outline-offset", pack_module (module Property_outline_offset);
    Property "overflow-block", pack_module (module Property_overflow_block);
    ( Property "overflow-clip-margin",
      pack_module (module Property_overflow_clip_margin) );
    Property "overflow-inline", pack_module (module Property_overflow_inline);
    Property "overflow-x", pack_module (module Property_overflow_x);
    Property "overflow-y", pack_module (module Property_overflow_y);
    Property "overlay", pack_module (module Property_overlay);
    ( Property "overscroll-behavior-block",
      pack_module (module Property_overscroll_behavior_block) );
    ( Property "overscroll-behavior-inline",
      pack_module (module Property_overscroll_behavior_inline) );
    ( Property "overscroll-behavior-x",
      pack_module (module Property_overscroll_behavior_x) );
    ( Property "overscroll-behavior-y",
      pack_module (module Property_overscroll_behavior_y) );
    Property "padding", pack_module (module Property_padding);
    Property "padding-block", pack_module (module Property_padding_block);
    ( Property "padding-block-end",
      pack_module (module Property_padding_block_end) );
    ( Property "padding-block-start",
      pack_module (module Property_padding_block_start) );
    Property "padding-bottom", pack_module (module Property_padding_bottom);
    Property "padding-inline", pack_module (module Property_padding_inline);
    ( Property "padding-inline-end",
      pack_module (module Property_padding_inline_end) );
    ( Property "padding-inline-start",
      pack_module (module Property_padding_inline_start) );
    Property "padding-left", pack_module (module Property_padding_left);
    Property "padding-right", pack_module (module Property_padding_right);
    Property "padding-top", pack_module (module Property_padding_top);
    Property "page", pack_module (module Property_page);
    Property "paint-order", pack_module (module Property_paint_order);
    Property "pause", pack_module (module Property_pause);
    Property "pause-after", pack_module (module Property_pause_after);
    Property "pause-before", pack_module (module Property_pause_before);
    Property "perspective", pack_module (module Property_perspective);
    Property "place-content", pack_module (module Property_place_content);
    Property "place-items", pack_module (module Property_place_items);
    Property "place-self", pack_module (module Property_place_self);
    Property "position-anchor", pack_module (module Property_position_anchor);
    Property "position-area", pack_module (module Property_position_area);
    Property "position-try", pack_module (module Property_position_try);
    ( Property "position-try-fallbacks",
      pack_module (module Property_position_try_fallbacks) );
    ( Property "position-try-options",
      pack_module (module Property_position_try_options) );
    ( Property "position-visibility",
      pack_module (module Property_position_visibility) );
    Property "quotes", pack_module (module Property_quotes);
    Property "r", pack_module (module Property_r);
    Property "reading-flow", pack_module (module Property_reading_flow);
    Property "rest", pack_module (module Property_rest);
    Property "rest-after", pack_module (module Property_rest_after);
    Property "rest-before", pack_module (module Property_rest_before);
    Property "right", pack_module (module Property_right);
    Property "rotate", pack_module (module Property_rotate);
    Property "ruby-align", pack_module (module Property_ruby_align);
    Property "ruby-overhang", pack_module (module Property_ruby_overhang);
    Property "rx", pack_module (module Property_rx);
    Property "ry", pack_module (module Property_ry);
    Property "scale", pack_module (module Property_scale);
    Property "scroll-margin", pack_module (module Property_scroll_margin);
    ( Property "scroll-margin-block",
      pack_module (module Property_scroll_margin_block) );
    ( Property "scroll-margin-block-end",
      pack_module (module Property_scroll_margin_block_end) );
    ( Property "scroll-margin-block-start",
      pack_module (module Property_scroll_margin_block_start) );
    ( Property "scroll-margin-bottom",
      pack_module (module Property_scroll_margin_bottom) );
    ( Property "scroll-margin-inline",
      pack_module (module Property_scroll_margin_inline) );
    ( Property "scroll-margin-inline-end",
      pack_module (module Property_scroll_margin_inline_end) );
    ( Property "scroll-margin-inline-start",
      pack_module (module Property_scroll_margin_inline_start) );
    ( Property "scroll-margin-left",
      pack_module (module Property_scroll_margin_left) );
    ( Property "scroll-margin-right",
      pack_module (module Property_scroll_margin_right) );
    ( Property "scroll-margin-top",
      pack_module (module Property_scroll_margin_top) );
    ( Property "scroll-marker-group",
      pack_module (module Property_scroll_marker_group) );
    Property "scroll-padding", pack_module (module Property_scroll_padding);
    ( Property "scroll-padding-block",
      pack_module (module Property_scroll_padding_block) );
    ( Property "scroll-padding-block-end",
      pack_module (module Property_scroll_padding_block_end) );
    ( Property "scroll-padding-block-start",
      pack_module (module Property_scroll_padding_block_start) );
    ( Property "scroll-padding-bottom",
      pack_module (module Property_scroll_padding_bottom) );
    ( Property "scroll-padding-inline",
      pack_module (module Property_scroll_padding_inline) );
    ( Property "scroll-padding-inline-end",
      pack_module (module Property_scroll_padding_inline_end) );
    ( Property "scroll-padding-inline-start",
      pack_module (module Property_scroll_padding_inline_start) );
    ( Property "scroll-padding-left",
      pack_module (module Property_scroll_padding_left) );
    ( Property "scroll-padding-right",
      pack_module (module Property_scroll_padding_right) );
    ( Property "scroll-padding-top",
      pack_module (module Property_scroll_padding_top) );
    ( Property "scroll-snap-align",
      pack_module (module Property_scroll_snap_align) );
    ( Property "scroll-snap-coordinate",
      pack_module (module Property_scroll_snap_coordinate) );
    ( Property "scroll-snap-destination",
      pack_module (module Property_scroll_snap_destination) );
    ( Property "scroll-snap-points-x",
      pack_module (module Property_scroll_snap_points_x) );
    ( Property "scroll-snap-points-y",
      pack_module (module Property_scroll_snap_points_y) );
    Property "scroll-snap-type", pack_module (module Property_scroll_snap_type);
    ( Property "scroll-snap-type-x",
      pack_module (module Property_scroll_snap_type_x) );
    ( Property "scroll-snap-type-y",
      pack_module (module Property_scroll_snap_type_y) );
    Property "scroll-start", pack_module (module Property_scroll_start);
    ( Property "scroll-start-block",
      pack_module (module Property_scroll_start_block) );
    ( Property "scroll-start-inline",
      pack_module (module Property_scroll_start_inline) );
    ( Property "scroll-start-target",
      pack_module (module Property_scroll_start_target) );
    ( Property "scroll-start-target-block",
      pack_module (module Property_scroll_start_target_block) );
    ( Property "scroll-start-target-inline",
      pack_module (module Property_scroll_start_target_inline) );
    ( Property "scroll-start-target-x",
      pack_module (module Property_scroll_start_target_x) );
    ( Property "scroll-start-target-y",
      pack_module (module Property_scroll_start_target_y) );
    Property "scroll-start-x", pack_module (module Property_scroll_start_x);
    Property "scroll-start-y", pack_module (module Property_scroll_start_y);
    Property "scroll-timeline", pack_module (module Property_scroll_timeline);
    ( Property "scroll-timeline-axis",
      pack_module (module Property_scroll_timeline_axis) );
    ( Property "scroll-timeline-name",
      pack_module (module Property_scroll_timeline_name) );
    ( Property "scrollbar-3dlight-color",
      pack_module (module Property_scrollbar_3dlight_color) );
    ( Property "scrollbar-arrow-color",
      pack_module (module Property_scrollbar_arrow_color) );
    ( Property "scrollbar-base-color",
      pack_module (module Property_scrollbar_base_color) );
    Property "scrollbar-color", pack_module (module Property_scrollbar_color);
    ( Property "scrollbar-color-legacy",
      pack_module (module Property_scrollbar_color_legacy) );
    ( Property "scrollbar-darkshadow-color",
      pack_module (module Property_scrollbar_darkshadow_color) );
    ( Property "scrollbar-face-color",
      pack_module (module Property_scrollbar_face_color) );
    Property "scrollbar-gutter", pack_module (module Property_scrollbar_gutter);
    ( Property "scrollbar-highlight-color",
      pack_module (module Property_scrollbar_highlight_color) );
    ( Property "scrollbar-shadow-color",
      pack_module (module Property_scrollbar_shadow_color) );
    ( Property "scrollbar-track-color",
      pack_module (module Property_scrollbar_track_color) );
    ( Property "shape-image-threshold",
      pack_module (module Property_shape_image_threshold) );
    Property "shape-margin", pack_module (module Property_shape_margin);
    Property "shape-outside", pack_module (module Property_shape_outside);
    Property "shape-rendering", pack_module (module Property_shape_rendering);
    Property "size", pack_module (module Property_size);
    Property "speak-as", pack_module (module Property_speak_as);
    Property "src", pack_module (module Property_src);
    Property "stop-color", pack_module (module Property_stop_color);
    Property "stop-opacity", pack_module (module Property_stop_opacity);
    Property "stroke", pack_module (module Property_stroke);
    Property "stroke-dasharray", pack_module (module Property_stroke_dasharray);
    ( Property "stroke-dashoffset",
      pack_module (module Property_stroke_dashoffset) );
    ( Property "stroke-miterlimit",
      pack_module (module Property_stroke_miterlimit) );
    Property "stroke-opacity", pack_module (module Property_stroke_opacity);
    Property "stroke-width", pack_module (module Property_stroke_width);
    Property "syntax", pack_module (module Property_syntax);
    Property "tab-size", pack_module (module Property_tab_size);
    Property "text-align-all", pack_module (module Property_text_align_all);
    Property "text-anchor", pack_module (module Property_text_anchor);
    Property "text-autospace", pack_module (module Property_text_autospace);
    Property "text-blink", pack_module (module Property_text_blink);
    Property "text-box-edge", pack_module (module Property_text_box_edge);
    Property "text-box-trim", pack_module (module Property_text_box_trim);
    ( Property "text-combine-upright",
      pack_module (module Property_text_combine_upright) );
    Property "text-decoration", pack_module (module Property_text_decoration);
    ( Property "text-decoration-color",
      pack_module (module Property_text_decoration_color) );
    ( Property "text-decoration-skip",
      pack_module (module Property_text_decoration_skip) );
    ( Property "text-decoration-skip-box",
      pack_module (module Property_text_decoration_skip_box) );
    ( Property "text-decoration-skip-inset",
      pack_module (module Property_text_decoration_skip_inset) );
    ( Property "text-decoration-skip-self",
      pack_module (module Property_text_decoration_skip_self) );
    ( Property "text-decoration-skip-spaces",
      pack_module (module Property_text_decoration_skip_spaces) );
    Property "text-edge", pack_module (module Property_text_edge);
    Property "text-emphasis", pack_module (module Property_text_emphasis);
    ( Property "text-emphasis-color",
      pack_module (module Property_text_emphasis_color) );
    ( Property "text-emphasis-position",
      pack_module (module Property_text_emphasis_position) );
    ( Property "text-emphasis-style",
      pack_module (module Property_text_emphasis_style) );
    Property "text-indent", pack_module (module Property_text_indent);
    ( Property "text-justify-trim",
      pack_module (module Property_text_justify_trim) );
    Property "text-kashida", pack_module (module Property_text_kashida);
    ( Property "text-kashida-space",
      pack_module (module Property_text_kashida_space) );
    Property "text-overflow", pack_module (module Property_text_overflow);
    Property "text-shadow", pack_module (module Property_text_shadow);
    Property "text-size-adjust", pack_module (module Property_text_size_adjust);
    ( Property "text-spacing-trim",
      pack_module (module Property_text_spacing_trim) );
    ( Property "text-underline-offset",
      pack_module (module Property_text_underline_offset) );
    Property "text-wrap", pack_module (module Property_text_wrap);
    Property "text-wrap-mode", pack_module (module Property_text_wrap_mode);
    Property "text-wrap-style", pack_module (module Property_text_wrap_style);
    Property "timeline-scope", pack_module (module Property_timeline_scope);
    Property "top", pack_module (module Property_top);
    Property "transform", pack_module (module Property_transform);
    Property "transform-origin", pack_module (module Property_transform_origin);
    Property "transition", pack_module (module Property_transition);
    ( Property "transition-behavior",
      pack_module (module Property_transition_behavior) );
    Property "transition-delay", pack_module (module Property_transition_delay);
    ( Property "transition-duration",
      pack_module (module Property_transition_duration) );
    ( Property "transition-property",
      pack_module (module Property_transition_property) );
    ( Property "transition-timing-function",
      pack_module (module Property_transition_timing_function) );
    Property "translate", pack_module (module Property_translate);
    Property "unicode-range", pack_module (module Property_unicode_range);
    Property "vector-effect", pack_module (module Property_vector_effect);
    Property "vertical-align", pack_module (module Property_vertical_align);
    Property "view-timeline", pack_module (module Property_view_timeline);
    ( Property "view-timeline-axis",
      pack_module (module Property_view_timeline_axis) );
    ( Property "view-timeline-inset",
      pack_module (module Property_view_timeline_inset) );
    ( Property "view-timeline-name",
      pack_module (module Property_view_timeline_name) );
    ( Property "view-transition-name",
      pack_module (module Property_view_transition_name) );
    Property "voice-balance", pack_module (module Property_voice_balance);
    Property "voice-duration", pack_module (module Property_voice_duration);
    Property "voice-family", pack_module (module Property_voice_family);
    Property "voice-pitch", pack_module (module Property_voice_pitch);
    Property "voice-range", pack_module (module Property_voice_range);
    Property "voice-rate", pack_module (module Property_voice_rate);
    Property "voice-stress", pack_module (module Property_voice_stress);
    Property "voice-volume", pack_module (module Property_voice_volume);
    ( Property "white-space-collapse",
      pack_module (module Property_white_space_collapse) );
    Property "widows", pack_module (module Property_widows);
    ( Property "word-space-transform",
      pack_module (module Property_word_space_transform) );
    Property "word-spacing", pack_module (module Property_word_spacing);
    Property "x", pack_module (module Property_x);
    Property "y", pack_module (module Property_y);
    Property "z-index", pack_module (module Property_z_index);
    Property "zoom", pack_module (module Property_zoom);
    Function "blur()", pack_module (module Function_blur);
    Function "brightness()", pack_module (module Function_brightness);
    Function "circle()", pack_module (module Function_circle);
    Function "clamp()", pack_module (module Function_clamp);
    Function "contrast()", pack_module (module Function_contrast);
    Function "counter()", pack_module (module Function_counter);
    Function "counters()", pack_module (module Function_counters);
    Function "drop-shadow()", pack_module (module Function_drop_shadow);
    Function "ellipse()", pack_module (module Function_ellipse);
    Function "env()", pack_module (module Function_env);
    Function "fit-content()", pack_module (module Function_fit_content);
    Function "grayscale()", pack_module (module Function_grayscale);
    Function "hue-rotate()", pack_module (module Function_hue_rotate);
    Function "inset()", pack_module (module Function_inset);
    Function "invert()", pack_module (module Function_invert);
    Function "leader()", pack_module (module Function_leader);
    Function "minmax()", pack_module (module Function_minmax);
    Function "opacity()", pack_module (module Function_opacity);
    Function "path()", pack_module (module Function_path);
    Function "polygon()", pack_module (module Function_polygon);
    Function "saturate()", pack_module (module Function_saturate);
    Function "sepia()", pack_module (module Function_sepia);
    Function "target-counter()", pack_module (module Function_target_counter);
    Function "target-counters()", pack_module (module Function_target_counters);
    Function "target-text()", pack_module (module Function_target_text);
    Value "angular-color-hint", pack_module (module Angular_color_hint);
    Value "angular-color-stop", pack_module (module Angular_color_stop);
    ( Value "angular-color-stop-list",
      pack_module (module Angular_color_stop_list) );
    Value "animateable-feature", pack_module (module Animateable_feature);
    Value "attr-fallback", pack_module (module Attr_fallback);
    Value "attr-matcher", pack_module (module Attr_matcher);
    Value "attr-name", pack_module (module Attr_name);
    Value "attr-type", pack_module (module Attr_type);
    Value "attr-unit", pack_module (module Attr_unit);
    Value "attribute-selector", pack_module (module Attribute_selector);
    Value "bg-layer", pack_module (module Bg_layer);
    Value "border-radius", pack_module (module Border_radius);
    Value "bottom", pack_module (module Bottom);
    Value "cf-final-image", pack_module (module Cf_final_image);
    Value "cf-mixing-image", pack_module (module Cf_mixing_image);
    Value "class-selector", pack_module (module Class_selector);
    Value "clip-source", pack_module (module Clip_source);
    Value "color-stop", pack_module (module Color_stop);
    Value "color-stop-angle", pack_module (module Color_stop_angle);
    Value "color-stop-length", pack_module (module Color_stop_length);
    Value "complex-selector", pack_module (module Complex_selector);
    Value "complex-selector-list", pack_module (module Complex_selector_list);
    Value "compound-selector", pack_module (module Compound_selector);
    Value "compound-selector-list", pack_module (module Compound_selector_list);
    ( Value "container-condition-list",
      pack_module (module Container_condition_list) );
    Value "counter-name", pack_module (module Counter_name);
    Value "declaration", pack_module (module Declaration);
    Value "declaration-list", pack_module (module Declaration_list);
    Value "display-listitem", pack_module (module Display_listitem);
    Value "explicit-track-list", pack_module (module Explicit_track_list);
    Value "extended-angle", pack_module (module Extended_angle);
    Value "extended-frequency", pack_module (module Extended_frequency);
    Value "extended-length", pack_module (module Extended_length);
    Value "extended-percentage", pack_module (module Extended_percentage);
    Value "extended-time", pack_module (module Extended_time);
    Value "feature-tag-value", pack_module (module Feature_tag_value);
    Value "feature-value-block", pack_module (module Feature_value_block);
    ( Value "feature-value-block-list",
      pack_module (module Feature_value_block_list) );
    ( Value "feature-value-declaration",
      pack_module (module Feature_value_declaration) );
    ( Value "feature-value-declaration-list",
      pack_module (module Feature_value_declaration_list) );
    Value "filter-function-list", pack_module (module Filter_function_list);
    Value "final-bg-layer", pack_module (module Final_bg_layer);
    Value "font-stretch-absolute", pack_module (module Font_stretch_absolute);
    Value "general-enclosed", pack_module (module General_enclosed);
    Value "generic-voice", pack_module (module Generic_voice);
    ( Value "hue-interpolation-method",
      pack_module (module Hue_interpolation_method) );
    Value "id-selector", pack_module (module Id_selector);
    Value "image-set-option", pack_module (module Image_set_option);
    Value "image-src", pack_module (module Image_src);
    Value "inflexible-breadth", pack_module (module Inflexible_breadth);
    Value "keyframe-block", pack_module (module Keyframe_block);
    Value "keyframe-block-list", pack_module (module Keyframe_block_list);
    Value "keyframe-selector", pack_module (module Keyframe_selector);
    Value "leader-type", pack_module (module Leader_type);
    Value "left", pack_module (module Left);
    Value "line-name-list", pack_module (module Line_name_list);
    Value "linear-color-hint", pack_module (module Linear_color_hint);
    Value "linear-color-stop", pack_module (module Linear_color_stop);
    Value "mask-image", pack_module (module Mask_image);
    Value "mask-layer", pack_module (module Mask_layer);
    Value "mask-position", pack_module (module Mask_position);
    Value "name-repeat", pack_module (module Name_repeat);
    Value "namespace-prefix", pack_module (module Namespace_prefix);
    Value "ns-prefix", pack_module (module Ns_prefix);
    Value "nth", pack_module (module Nth);
    Value "number-one-or-greater", pack_module (module Number_one_or_greater);
    Value "number-zero-one", pack_module (module Number_zero_one);
    Value "one-bg-size", pack_module (module One_bg_size);
    Value "page-body", pack_module (module Page_body);
    Value "page-margin-box", pack_module (module Page_margin_box);
    Value "page-selector", pack_module (module Page_selector);
    Value "page-selector-list", pack_module (module Page_selector_list);
    Value "paint", pack_module (module Paint);
    Value "positive-integer", pack_module (module Positive_integer);
    Value "pseudo-class-selector", pack_module (module Pseudo_class_selector);
    ( Value "pseudo-element-selector",
      pack_module (module Pseudo_element_selector) );
    Value "pseudo-page", pack_module (module Pseudo_page);
    Value "radial-size", pack_module (module Radial_size);
    Value "ray-size", pack_module (module Ray_size);
    Value "relative-selector", pack_module (module Relative_selector);
    Value "relative-selector-list", pack_module (module Relative_selector_list);
    Value "right", pack_module (module Right);
    Value "shape", pack_module (module Shape);
    Value "shape-radius", pack_module (module Shape_radius);
    Value "single-transition", pack_module (module Single_transition);
    ( Value "single-transition-no-interp",
      pack_module (module Single_transition_no_interp) );
    ( Value "single-transition-property-no-interp",
      pack_module (module Single_transition_property_no_interp) );
    Value "size", pack_module (module Size);
    Value "subclass-selector", pack_module (module Subclass_selector);
    Value "supports-condition", pack_module (module Supports_condition);
    Value "supports-decl", pack_module (module Supports_decl);
    Value "supports-feature", pack_module (module Supports_feature);
    Value "supports-in-parens", pack_module (module Supports_in_parens);
    Value "supports-selector-fn", pack_module (module Supports_selector_fn);
    Value "svg-writing-mode", pack_module (module Svg_writing_mode);
    Value "symbol", pack_module (module Symbol);
    Value "syntax", pack_module (module Syntax);
    Value "syntax-combinator", pack_module (module Syntax_combinator);
    Value "syntax-component", pack_module (module Syntax_component);
    Value "syntax-multiplier", pack_module (module Syntax_multiplier);
    ( Value "syntax-single-component",
      pack_module (module Syntax_single_component) );
    Value "syntax-string", pack_module (module Syntax_string);
    Value "syntax-type-name", pack_module (module Syntax_type_name);
    Value "target", pack_module (module Target);
    Value "top", pack_module (module Top);
    Value "track-group", pack_module (module Track_group);
    Value "track-list-v0", pack_module (module Track_list_v0);
    Value "track-minmax", pack_module (module Track_minmax);
    ( Value "transition-behavior-value",
      pack_module (module Transition_behavior_value) );
    ( Value "transition-behavior-value-no-interp",
      pack_module (module Transition_behavior_value_no_interp) );
    Value "try-tactic", pack_module (module Try_tactic);
    Value "type-or-unit", pack_module (module Type_or_unit);
    Value "type-selector", pack_module (module Type_selector);
    Value "viewport-length", pack_module (module Viewport_length);
    ( Value "webkit-gradient-color-stop",
      pack_module (module Webkit_gradient_color_stop) );
    Value "webkit-gradient-point", pack_module (module Webkit_gradient_point);
    Value "webkit-gradient-radius", pack_module (module Webkit_gradient_radius);
    Value "wq-name", pack_module (module Wq_name);
    Value "x", pack_module (module X);
    Value "y", pack_module (module Y);
  ]

let () =
  List.iter
    (fun (kind, rule) ->
      let css_name =
        match kind with
        | Property name -> name
        | Value name -> name
        | Function name -> name
        | Media_query name -> name
      in
      let key =
        match kind with
        (* Properties use prefixed keys to avoid collisions with values. *)
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

let find_property_with_fallback (name : string) : packed_rule option =
  let key = "property_" ^ name in
  match Hashtbl.find_opt registry_tbl key with
  | Some (_, rule) -> Some rule
  | None -> None

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

type packed_property = {
  validate : string -> (unit, string) result;
  extract_interpolations : string -> (string * string) list;
  runtime_module_path : string option;
}

let pack_property (packed : packed_rule) : packed_property =
  match packed with
  | Pack_rule { validate; runtime_module_path; extract_interpolations; _ } ->
    { validate; extract_interpolations; runtime_module_path }

let property_registry : (string, packed_property) Hashtbl.t = Hashtbl.create 500

let () =
  List.iter
    (fun (kind, rule) ->
      match kind with
      | Property name ->
        Hashtbl.replace property_registry name (pack_property rule)
      | _ -> ())
    registry

let property_names () : string list =
  Hashtbl.fold (fun name _ acc -> name :: acc) property_registry []

let suggest_property_name (name : string) : string option =
  property_names () |> Levenshtein.find_closest_match name

let check_property ~loc ~name value :
  ( unit,
    Styled_ppx_css_parser.Ast.loc
    * [> `Invalid_value of string | `Property_not_found ] )
  result =
  match Hashtbl.find_opt property_registry name with
  | Some prop ->
    (match prop.validate value with
    | Ok () -> Ok ()
    | Error property_error ->
      let universal_rule =
        Combinators.xor
          [
            Rule.Match.map Css_value_types.interpolation (fun _ -> ());
            Rule.Match.map Css_value_types.css_wide_keywords (fun _ -> ());
            Rule.Match.map function_var (fun _ -> ());
          ]
      in
      (match Rule.parse_string universal_rule value with
      | Ok _ -> Ok ()
      | Error _ ->
        let prefix =
          Format.sprintf "Property '%s' has an invalid value: '%s'" name value
        in
        let error_message =
          match property_error with
          | "" -> prefix
          | detail -> Printf.sprintf "%s, %s" prefix detail
        in
        Error (loc, `Invalid_value error_message)))
  | None -> Error (loc, `Property_not_found)

let get_interpolation_types ~name value : (string * string) list =
  match Hashtbl.find_opt property_registry name with
  | Some prop -> prop.extract_interpolations value
  | None -> []

let parse (rule_parser : 'a Rule.rule) input =
  Rule.parse_string rule_parser input

let find_property_packed (name : string) : packed_property option =
  Hashtbl.find_opt property_registry name

let parse_at_rule_prelude (rule_parser : 'a Rule.rule) input =
  let tokens_with_loc =
    Styled_ppx_css_parser.Lexer.from_string
      ~initial_mode:Styled_ppx_css_parser.Lexer_context.At_rule_prelude input
  in
  let tokens =
    tokens_with_loc
    |> List.filter_map
         (fun ({ txt; _ } : Styled_ppx_css_parser.Lexer.token_with_location) ->
         match txt with Ok token -> Some token | Error _ -> None)
    |> List.rev
  in
  let tokens_without_ws =
    tokens |> List.filter (fun t -> t <> Styled_ppx_css_parser.Tokens.WS)
  in
  let output, remaining_tokens = rule_parser tokens_without_ws in
  match output with
  | Ok data ->
    let remaining =
      remaining_tokens
      |> List.filter (fun t -> t <> Styled_ppx_css_parser.Tokens.WS)
    in
    (match remaining with
    | [] | [ Styled_ppx_css_parser.Tokens.EOF ] -> Ok data
    | tokens ->
      let humanized =
        tokens
        |> List.filter (fun t -> t <> Styled_ppx_css_parser.Tokens.EOF)
        |> List.map Styled_ppx_css_parser.Tokens.humanize
        |> String.concat " "
      in
      Error ("Unexpected trailing input '" ^ humanized ^ "'."))
  | Error (message :: _) -> Error message
  | Error [] -> Error "Expected a valid value."
