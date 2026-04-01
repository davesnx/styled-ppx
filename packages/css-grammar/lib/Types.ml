module type RULE = sig
  type t

  val rule : t Rule.rule

  val type_check :
    Styled_ppx_css_parser.Ast.component_value_list -> (t, string) result

  val runtime_module_path : string option
  val infer_interpolation_types : t -> (string * string) list

  val infer_interpolation_types_with_context :
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
      validate :
        Styled_ppx_css_parser.Ast.component_value_list -> (unit, string) result;
      runtime_module_path : string option;
      infer_interpolation_types :
        Styled_ppx_css_parser.Ast.component_value_list -> (string * string) list;
      infer_interpolation_types_from_ast :
        string -> Obj.t -> (string * string) list;
    }
      -> packed_rule

type packed_property = {
  validate :
    Styled_ppx_css_parser.Ast.component_value_list -> (unit, string) result;
  infer_interpolation_types :
    Styled_ppx_css_parser.Ast.component_value_list -> (string * string) list;
  runtime_module_path : string option;
}
