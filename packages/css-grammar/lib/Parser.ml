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
  val extract_interpolations : t -> string list
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

type angle =
  [ `Deg of float
  | `Grad of float
  | `Rad of float
  | `Turn of float
  ]

type time =
  [ `S of float
  | `Ms of float
  ]

type frequency =
  [ `Hz of float
  | `KHz of float
  ]

type resolution =
  [ `Dpi of float
  | `Dppx of float
  | `Dpcm of float
  ]

type flex_value = [ `Fr of float ]

type css_wide_keywords =
  [ `Initial
  | `Inherit
  | `Unset
  | `Revert
  | `RevertLayer
  ]

(* Mutually recursive calc-related types.
   These form a cycle: calc_value -> extended_* -> calc_sum -> calc_product -> calc_value
   We define them together using 'and' to break the compile-time circular dependency. *)
type calc_value =
  [ `Number of float
  | `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  | `Extended_angle of extended_angle
  | `Extended_time of extended_time
  | `Static of unit * calc_sum * unit
  ]

and calc_product =
  calc_value
  * [ `Static_0 of unit * calc_value | `Static_1 of unit * float ] list

and calc_sum =
  calc_product * ([ `Cross of unit | `Dash of unit ] * calc_product) list

and extended_length =
  [ `Length of length
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

and extended_percentage =
  [ `Percentage of float
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

and extended_frequency =
  [ `Frequency of frequency
  | `Function_calc of calc_sum
  | `Interpolation of string list
  | `Function_min of calc_sum list
  | `Function_max of calc_sum list
  ]

(* No-interpolation variants *)
type extended_time_no_interp =
  [ `Time of time
  | `Function_calc of calc_sum
  | `Function_min of calc_sum list
  | `Function_max of calc_sum list
  ]

(* Other types that reference the calc types *)
type one_bg_size =
  [ `Extended_length of extended_length
  | `Extended_percentage of extended_percentage
  | `Auto
  ]
  * [ `Extended_length of extended_length
    | `Extended_percentage of extended_percentage
    | `Auto
    ]
    option

type ratio =
  [ `Static of int * unit * int
  | `Number of float
  | `Interpolation of string list
  ]

type kind =
  | Property of string
  | Value of string
  | Function of string
  | Media_query of string

let registry_ref : (kind * (module RULE)) list ref = ref []

let lookup_property_rule (name : string) : 'a Rule.rule =
  (* For function lookups, try both "name" and "name()" since functions are registered with "()" *)
  let function_name = name ^ "()" in
  let rec find_rule = function
    | [] -> failwith ("Rule not found: " ^ name)
    | (k, (module M : RULE)) :: rest ->
      let n =
        match k with Property n | Value n | Function n | Media_query n -> n
      in
      (* Match exact name, or function name with "()" appended *)
      if n = name || n = function_name then Obj.magic M.rule else find_rule rest
  in
  find_rule !registry_ref

(* Lazy version of lookup - defers the lookup until the rule is actually run *)
let lazy_lookup_property_rule (name : string) : 'a Rule.rule =
 fun tokens ->
  let rule = lookup_property_rule name in
  rule tokens

module Legacy_linear_gradient_arguments =
  [%spec_module
  "legacy_linear_gradient_arguments",
  "[ <extended-angle> | <side-or-corner> ]? ',' <color-stop-list>"]

module Legacy_radial_gradient_shape =
  [%spec_module
  "legacy_radial_gradient_shape", "'circle' | 'ellipse'"]

module Legacy_radial_gradient_size =
  [%spec_module
  "legacy_radial_gradient_size",
  "'closest-side' | 'closest-corner' | 'farthest-side' | 'farthest-corner' | \
   'contain' | 'cover'"]

module Legacy_radial_gradient_arguments =
  [%spec_module
  "legacy_radial_gradient_arguments",
  "[ <position> ',' ]? [ [ <legacy-radial-gradient-shape> || \
   <legacy-radial-gradient-size> | [ <extended-length> | <extended-percentage> \
   ]{2} ] ',' ]? <color-stop-list>"]

module Legacy_linear_gradient =
  [%spec_module
  "legacy_linear_gradient",
  "-moz-linear-gradient( <legacy-linear-gradient-arguments> ) | \
   -webkit-linear-gradient( <legacy-linear-gradient-arguments> ) | \
   -o-linear-gradient( <legacy-linear-gradient-arguments> )"]

module Legacy_radial_gradient =
  [%spec_module
  "legacy_radial_gradient",
  "-moz-radial-gradient( <legacy-radial-gradient-arguments> ) | \
   -webkit-radial-gradient( <legacy-radial-gradient-arguments> ) | \
   -o-radial-gradient( <legacy-radial-gradient-arguments> )"]

module Legacy_repeating_linear_gradient =
  [%spec_module
  "legacy_repeating_linear_gradient",
  "-moz-repeating-linear-gradient( <legacy-linear-gradient-arguments> ) | \
   -webkit-repeating-linear-gradient( <legacy-linear-gradient-arguments> ) | \
   -o-repeating-linear-gradient( <legacy-linear-gradient-arguments> )"]

module Legacy_repeating_radial_gradient =
  [%spec_module
  "legacy_repeating_radial_gradient",
  "-moz-repeating-radial-gradient( <legacy-radial-gradient-arguments> ) | \
   -webkit-repeating-radial-gradient( <legacy-radial-gradient-arguments> ) | \
   -o-repeating-radial-gradient( <legacy-radial-gradient-arguments> )"]

(* Legacy_gradient depends on all the above, so it must come last *)
module Legacy_gradient =
  [%spec_module
  "legacy_gradient",
  "<-webkit-gradient()> | <legacy-linear-gradient> | \
   <legacy-repeating-linear-gradient> | <legacy-radial-gradient> | \
   <legacy-repeating-radial-gradient>"]

module Non_standard_color =
  [%spec_module
  "non_standard_color",
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
   '-webkit-text'"]

module Non_standard_font =
  [%spec_module
  "non_standard_font",
  "'-apple-system-body' | '-apple-system-headline' | \
   '-apple-system-subheadline' | '-apple-system-caption1' | \
   '-apple-system-caption2' | '-apple-system-footnote' | \
   '-apple-system-short-body' | '-apple-system-short-headline' | \
   '-apple-system-short-subheadline' | '-apple-system-short-caption1' | \
   '-apple-system-short-footnote' | '-apple-system-tall-body'"]

module Non_standard_image_rendering =
  [%spec_module
  "non_standard_image_rendering",
  "'optimize-contrast' | '-moz-crisp-edges' | '-o-crisp-edges' | \
   '-webkit-optimize-contrast'"]

module Non_standard_overflow =
  [%spec_module
  "non_standard_overflow",
  "'-moz-scrollbars-none' | '-moz-scrollbars-horizontal' | \
   '-moz-scrollbars-vertical' | '-moz-hidden-unscrollable'"]

module Non_standard_width =
  [%spec_module
  "non_standard_width",
  "'min-intrinsic' | 'intrinsic' | '-moz-min-content' | '-moz-max-content' | \
   '-webkit-min-content' | '-webkit-max-content'"]

module Webkit_gradient_color_stop =
  [%spec_module
  "webkit_gradient_color_stop",
  "from( <color> ) | color-stop( [ <alpha-value> | <extended-percentage> ] ',' \
   <color> ) | to( <color> )"]

module Webkit_gradient_point =
  [%spec_module
  "webkit_gradient_point",
  "[ 'left' | 'center' | 'right' | <extended-length> | <extended-percentage> ] \
   [ 'top' | 'center' | 'bottom' | <extended-length> | <extended-percentage> ]"]

module Webkit_gradient_radius =
  [%spec_module
  "webkit_gradient_radius", "<extended-length> | <extended-percentage>"]

module Webkit_gradient_type =
  [%spec_module
  "webkit_gradient_type", "'linear' | 'radial'"]

module Webkit_mask_box_repeat =
  [%spec_module
  "webkit_mask_box_repeat", "'repeat' | 'stretch' | 'round'"]

module Webkit_mask_clip_style =
  [%spec_module
  "webkit_mask_clip_style",
  "'border' | 'border-box' | 'padding' | 'padding-box' | 'content' | \
   'content-box' | 'text'"]

module Absolute_size =
  [%spec_module
  "absolute_size",
  "'xx-small' | 'x-small' | 'small' | 'medium' | 'large' | 'x-large' | \
   'xx-large' | 'xxx-large'"]

module Age = [%spec_module "age", "'child' | 'young' | 'old'"]

module Alpha_value =
  [%spec_module
  "alpha_value", "<number> | <extended-percentage>"]

module Angular_color_hint =
  [%spec_module
  "angular_color_hint", "<extended-angle> | <extended-percentage>"]

module Angular_color_stop =
  [%spec_module
  "angular_color_stop", "<color> && [ <color-stop-angle> ]?"]

module Angular_color_stop_list =
  [%spec_module
  "angular_color_stop_list",
  "[ <angular-color-stop> [ ',' <angular-color-hint> ]? ]# ',' \
   <angular-color-stop>"]

module Animateable_feature =
  [%spec_module
  "animateable_feature", "'scroll-position' | 'contents' | <custom-ident>"]

module Attachment = [%spec_module "attachment", "'scroll' | 'fixed' | 'local'"]
module Attr_fallback = [%spec_module "attr_fallback", "<any-value>"]

module Attr_matcher =
  [%spec_module
  "attr_matcher", "[ '~' | '|' | '^' | '$' | '*' ]? '='"]

module Attr_modifier = [%spec_module "attr_modifier", "'i' | 's'"]

module Attribute_selector =
  [%spec_module
  "attribute_selector",
  "'[' <wq-name> ']' | '[' <wq-name> <attr-matcher> [ <string-token> | \
   <ident-token> ] [ <attr-modifier> ]? ']'"]

module Auto_repeat =
  [%spec_module
  "auto_repeat",
  "repeat( [ 'auto-fill' | 'auto-fit' ] ',' [ [ <line-names> ]? <fixed-size> \
   ]+ [ <line-names> ]? )"]

module Auto_track_list =
  [%spec_module
  "auto_track_list",
  "[ [ <line-names> ]? [ <fixed-size> | <fixed-repeat> ] ]* [ <line-names> ]? \
   <auto-repeat> [ [ <line-names> ]? [ <fixed-size> | <fixed-repeat> ] ]* [ \
   <line-names> ]?"]

module Baseline_position =
  [%spec_module
  "baseline_position", "[ 'first' | 'last' ]? 'baseline'"]

module Basic_shape =
  [%spec_module
  "basic_shape", "<inset()> | <circle()> | <ellipse()> | <polygon()> | <path()>"]

module Bg_image = [%spec_module "bg_image", "'none' | <image>"]

module Bg_layer =
  [%spec_module
  "bg_layer",
  "<bg-image> || <bg-position> [ '/' <bg-size> ]? || <repeat-style> || \
   <attachment> || <box> || <box>"]

module Bg_position =
  [%spec_module
  "bg_position",
  "[ 'left' | 'center' | 'right' | 'top' | 'bottom' | <length-percentage> ] | \
   [ 'left' | 'center' | 'right' | <length-percentage> ] [ 'top' | 'center' | \
   'bottom' | <length-percentage> ] | [ 'center' | [ 'left' | 'right' ] \
   <length-percentage>? ] && [ 'center' | [ 'top' | 'bottom' ] \
   <length-percentage>? ]"]

(* one_bg_size isn't part of the spec, helps us with Type generation *)
module One_bg_size =
  [%spec_module
  "one_bg_size",
  "[ <extended-length> | <extended-percentage> | 'auto' ] [ <extended-length> \
   | <extended-percentage> | 'auto' ]?"]

module Bg_size = [%spec_module "bg_size", "<one-bg-size> | 'cover' | 'contain'"]

module Blend_mode =
  [%spec_module
  "blend_mode",
  "'normal' | 'multiply' | 'screen' | 'overlay' | 'darken' | 'lighten' | \
   'color-dodge' | 'color-burn' | 'hard-light' | 'soft-light' | 'difference' | \
   'exclusion' | 'hue' | 'saturation' | 'color' | 'luminosity'"]

(* module border_radius = [%spec_module "border_radius",
  "[ <extended-length> | <extended-percentage> ]{1,2}"] *)
module Border_radius =
  [%spec_module
  "border_radius", "<extended-length> | <extended-percentage>"]

module Bottom = [%spec_module "bottom", "<extended-length> | 'auto'"]

module Box =
  [%spec_module
  "box", "'border-box' | 'padding-box' | 'content-box'"]

module Calc_product =
  [%spec_module
  "calc_product", "<calc-value> [ '*' <calc-value> | '/' <number> ]*"]

module Dimension =
  [%spec_module
  "dimension",
  "<extended-length> | <extended-time> | <extended-frequency> | <resolution>"]

module Calc_sum =
  [%spec_module
  "calc_sum", "<calc-product> [ [ '+' | '-' ] <calc-product> ]*"]

(* module calc_value = [%spec_module "calc_value",
  "<number> | <dimension> | <extended-percentage> | <calc>"] *)
module Calc_value =
  [%spec_module
  "calc_value",
  "<number> | <extended-length> | <extended-percentage> | <extended-angle> | \
   <extended-time> | '(' <calc-sum> ')'"]

module Cf_final_image = [%spec_module "cf_final_image", "<image> | <color>"]

module Cf_mixing_image =
  [%spec_module
  "cf_mixing_image", "[ <extended-percentage> ]? && <image>"]

module Class_selector = [%spec_module "class_selector", "'.' <ident-token>"]
module Clip_source = [%spec_module "clip_source", "<url>"]

module Color =
  [%spec_module
  "color",
  "<rgb()> | <rgba()> | <hsl()> | <hsla()> | <hex-color> | <named-color> | \
   'currentColor' | <deprecated-system-color> | <interpolation> | <var()> | \
   <color-mix()>"]

module Color_stop =
  [%spec_module
  "color_stop", "<color-stop-length> | <color-stop-angle>"]

module Color_stop_angle =
  [%spec_module
  "color_stop_angle", "[ <extended-angle> ]{1,2}"]

(* module color_stop_length = [%spec_module "color_stop_length",
  "[ <extended-length> | <extended-percentage> ]{1,2}"] *)
module Color_stop_length =
  [%spec_module
  "color_stop_length", "<extended-length> | <extended-percentage>"]

(* color_stop_list is modified from the original spec, here is a simplified version where it tries to be fully compatible but easier for code-gen:

   The current impl allows values that aren't really supported such as: `linear-gradient(0deg, 10%, blue)` which is invalid, but we allow it for now to make it easier to generate the types. The correct value would require always a color to be in the first position `linear-gradient(0deg, red, 10%, blue);`

   The original spec is `color_stop_list = [%spec_module "[ <linear-color-stop> [ ',' <linear-color-hint> ]? ]# ',' <linear-color-stop>"]`
   *)
module Color_stop_list =
  [%spec_module
  "color_stop_list",
  "[ [<color>? <length-percentage>] | [<color> <length-percentage>?] ]#"]

module Hue_interpolation_method =
  [%spec_module
  "hue_interpolation_method",
  " [ 'shorter' | 'longer' | 'increasing' | 'decreasing' ] && 'hue' "]

module Polar_color_space =
  [%spec_module
  "polar_color_space", " 'hsl' | 'hwb' | 'lch' | 'oklch' "]

module Rectangular_color_space =
  [%spec_module
  "rectangular_color_space",
  " 'srgb' | 'srgb-linear' | 'display-p3' | 'a98-rgb' | 'prophoto-rgb' | \
   'rec2020' | 'lab' | 'oklab' | 'xyz' | 'xyz-d50' | 'xyz-d65' "]

module Color_interpolation_method =
  [%spec_module
  "color_interpolation_method",
  " 'in' && [<rectangular-color-space> | <polar-color-space> \
   <hue-interpolation-method>?] "]

module Function_color_mix =
  [%spec_module
  "function_color_mix",
  (* TODO: Use <extended-percentage> *)
  "color-mix(<color-interpolation-method> ',' [ <color> && <percentage>? ] ',' \
   [ <color> && <percentage>? ])"]

module Combinator = [%spec_module "combinator", "'>' | '+' | '~' | '||'"]

module Common_lig_values =
  [%spec_module
  "common_lig_values", "'common-ligatures' | 'no-common-ligatures'"]

module Compat_auto =
  [%spec_module
  "compat_auto",
  "'searchfield' | 'textarea' | 'push-button' | 'slider-horizontal' | \
   'checkbox' | 'radio' | 'square-button' | 'menulist' | 'listbox' | 'meter' | \
   'progress-bar'"]

module Complex_selector =
  [%spec_module
  "complex_selector",
  "<compound-selector> [ [ <combinator> ]? <compound-selector> ]*"]

module Complex_selector_list =
  [%spec_module
  "complex_selector_list", "[ <complex-selector> ]#"]

module Composite_style =
  [%spec_module
  "composite_style",
  "'clear' | 'copy' | 'source-over' | 'source-in' | 'source-out' | \
   'source-atop' | 'destination-over' | 'destination-in' | 'destination-out' | \
   'destination-atop' | 'xor'"]

module Compositing_operator =
  [%spec_module
  "compositing_operator", "'add' | 'subtract' | 'intersect' | 'exclude'"]

module Compound_selector =
  [%spec_module
  "compound_selector",
  "[ <type-selector> ]? [ <subclass-selector> ]* [ <pseudo-element-selector> [ \
   <pseudo-class-selector> ]* ]*"]

module Compound_selector_list =
  [%spec_module
  "compound_selector_list", "[ <compound-selector> ]#"]

module Content_distribution =
  [%spec_module
  "content_distribution",
  "'space-between' | 'space-around' | 'space-evenly' | 'stretch'"]

module Content_list =
  [%spec_module
  "content_list",
  "[ <string> | 'contents' | <url> | <quote> | <attr()> | counter( <ident> ',' \
   [ <'list-style-type'> ]? ) ]+"]

module Content_position =
  [%spec_module
  "content_position", "'center' | 'start' | 'end' | 'flex-start' | 'flex-end'"]

module Content_replacement = [%spec_module "content_replacement", "<image>"]

module Contextual_alt_values =
  [%spec_module
  "contextual_alt_values", "'contextual' | 'no-contextual'"]

module Counter_style =
  [%spec_module
  "counter_style", "<counter-style-name> | <symbols()>"]

module Counter_style_name =
  [%spec_module
  "counter_style_name", "<custom-ident>"]

module Counter_name = [%spec_module "counter_name", "<custom-ident>"]

module Cubic_bezier_timing_function =
  [%spec_module
  "cubic_bezier_timing_function",
  "'ease' | 'ease-in' | 'ease-out' | 'ease-in-out' | cubic-bezier( <number> \
   ',' <number> ',' <number> ',' <number> )"]

module Declaration =
  [%spec_module
  "declaration",
  "<ident-token> ':' [ <declaration-value> ]? [ '!' 'important' ]?"]

module Declaration_list =
  [%spec_module
  "declaration_list", "[ [ <declaration> ]? ';' ]* [ <declaration> ]?"]

module Deprecated_system_color =
  [%spec_module
  "deprecated_system_color",
  "'ActiveBorder' | 'ActiveCaption' | 'AppWorkspace' | 'Background' | \
   'ButtonFace' | 'ButtonHighlight' | 'ButtonShadow' | 'ButtonText' | \
   'CaptionText' | 'GrayText' | 'Highlight' | 'HighlightText' | \
   'InactiveBorder' | 'InactiveCaption' | 'InactiveCaptionText' | \
   'InfoBackground' | 'InfoText' | 'Menu' | 'MenuText' | 'Scrollbar' | \
   'ThreeDDarkShadow' | 'ThreeDFace' | 'ThreeDHighlight' | 'ThreeDLightShadow' \
   | 'ThreeDShadow' | 'Window' | 'WindowFrame' | 'WindowText'"]

module Discretionary_lig_values =
  [%spec_module
  "discretionary_lig_values",
  "'discretionary-ligatures' | 'no-discretionary-ligatures'"]

module Display_box = [%spec_module "display_box", "'contents' | 'none'"]

module Display_inside =
  [%spec_module
  "display_inside", "'flow' | 'flow-root' | 'table' | 'flex' | 'grid' | 'ruby'"]

module Display_internal =
  [%spec_module
  "display_internal",
  "'table-row-group' | 'table-header-group' | 'table-footer-group' | \
   'table-row' | 'table-cell' | 'table-column-group' | 'table-column' | \
   'table-caption' | 'ruby-base' | 'ruby-text' | 'ruby-base-container' | \
   'ruby-text-container'"]

module Display_legacy =
  [%spec_module
  "display_legacy",
  "'inline-block' | 'inline-list-item' | 'inline-table' | 'inline-flex' | \
   'inline-grid'"]

module Display_listitem =
  [%spec_module
  "display_listitem",
  "[ <display-outside> ]? && [ 'flow' | 'flow-root' ]? && 'list-item'"]

module Display_outside =
  [%spec_module
  "display_outside", "'block' | 'inline' | 'run-in'"]

module East_asian_variant_values =
  [%spec_module
  "east_asian_variant_values",
  "'jis78' | 'jis83' | 'jis90' | 'jis04' | 'simplified' | 'traditional'"]

module East_asian_width_values =
  [%spec_module
  "east_asian_width_values", "'full-width' | 'proportional-width'"]

module Ending_shape = [%spec_module "ending_shape", "'circle' | 'ellipse'"]

module Explicit_track_list =
  [%spec_module
  "explicit_track_list", "[ [ <line-names> ]? <track-size> ]+ [ <line-names> ]?"]

module Family_name = [%spec_module "family_name", "<string> | <custom-ident>"]

module Feature_tag_value =
  [%spec_module
  "feature_tag_value", "<string> [ <integer> | 'on' | 'off' ]?"]

module Feature_type =
  [%spec_module
  "feature_type",
  "'@stylistic' | '@historical-forms' | '@styleset' | '@character-variant' | \
   '@swash' | '@ornaments' | '@annotation'"]

module Feature_value_block =
  [%spec_module
  "feature_value_block",
  "<feature-type> '{' <feature-value-declaration-list> '}'"]

module Feature_value_block_list =
  [%spec_module
  "feature_value_block_list", "[ <feature-value-block> ]+"]

module Feature_value_declaration =
  [%spec_module
  "feature_value_declaration", "<custom-ident> ':' [ <integer> ]+ ';'"]

module Feature_value_declaration_list =
  [%spec_module
  "feature_value_declaration_list", "<feature-value-declaration>"]

module Feature_value_name =
  [%spec_module
  "feature_value_name", "<custom-ident>"]

(* <zero> represents the literal value 0, used in contexts like rotate(0) *)
module Zero = [%spec_module "zero", "'0'"]

module Fill_rule = [%spec_module "fill_rule", "'nonzero' | 'evenodd'"]

module Filter_function =
  [%spec_module
  "filter_function",
  "<blur()> | <brightness()> | <contrast()> | <drop-shadow()> | <grayscale()> \
   | <hue-rotate()> | <invert()> | <opacity()> | <saturate()> | <sepia()>"]

module Filter_function_list =
  [%spec_module
  "filter_function_list", "[ <filter-function> | <url> ]+"]

module Final_bg_layer =
  [%spec_module
  "final_bg_layer",
  "<'background-color'> || <bg-image> || <bg-position> [ '/' <bg-size> ]? || \
   <repeat-style> || <attachment> || <box> || <box>"]

module Line_names = [%spec_module "line_names", "'[' <custom-ident>* ']'"]

module Fixed_breadth =
  [%spec_module
  "fixed_breadth", "<extended-length> | <extended-percentage>"]

module Fixed_repeat =
  [%spec_module
  "fixed_repeat",
  "repeat( <positive-integer> ',' [ [ <line-names> ]? <fixed-size> ]+ [ \
   <line-names> ]? )"]

module Fixed_size =
  [%spec_module
  "fixed_size",
  "<fixed-breadth> | minmax( <fixed-breadth> ',' <track-breadth> ) | minmax( \
   <inflexible-breadth> ',' <fixed-breadth> )"]

module Font_stretch_absolute =
  [%spec_module
  "font_stretch_absolute",
  "'normal' | 'ultra-condensed' | 'extra-condensed' | 'condensed' | \
   'semi-condensed' | 'semi-expanded' | 'expanded' | 'extra-expanded' | \
   'ultra-expanded' | <extended-percentage>"]

module Font_variant_css21 =
  [%spec_module
  "font_variant_css21", "'normal' | 'small-caps'"]

module Font_weight_absolute =
  [%spec_module
  "font_weight_absolute", "'normal' | 'bold' | <integer>"]

module Function__webkit_gradient =
  [%spec_module
  "function__webkit_gradient",
  "-webkit-gradient( <webkit-gradient-type> ',' <webkit-gradient-point> [ ',' \
   <webkit-gradient-point> | ',' <webkit-gradient-radius> ',' \
   <webkit-gradient-point> ] [ ',' <webkit-gradient-radius> ]? [ ',' \
   <webkit-gradient-color-stop> ]* )"]

(* We don't support attr() with fallback value (since it's a declaration value) yet, original spec is: "attr(<attr-name> <attr-type>? , <declaration-value>?)" *)
module Function_attr =
  [%spec_module
  "function_attr", "attr(<attr-name> <attr-type>?)"]

(* module function_attr = [%spec_module
     "function_attr",
  "attr(<attr-name> <attr-type>? , <declaration-value>?)"
   ] *)
module Function_blur =
  [%spec_module
  "function_blur", "blur( <extended-length> )"]

module Function_brightness =
  [%spec_module
  "function_brightness", "brightness( <number-percentage> )"]

module Function_calc = [%spec_module "function_calc", "calc( <calc-sum> )"]

module Function_circle =
  [%spec_module
  "function_circle", "circle( [ <shape-radius> ]? [ 'at' <position> ]? )"]

module Function_clamp =
  [%spec_module
  "function_clamp", "clamp( [ <calc-sum> ]#{3} )"]

module Function_conic_gradient =
  [%spec_module
  "function_conic_gradient",
  "conic-gradient( [ 'from' <extended-angle> ]? [ 'at' <position> ]? ',' \
   <angular-color-stop-list> )"]

module Function_contrast =
  [%spec_module
  "function_contrast", "contrast( <number-percentage> )"]

module Function_counter =
  [%spec_module
  "function_counter", "counter( <counter-name> , <counter-style>? )"]

module Function_counters =
  [%spec_module
  "function_counters",
  "counters( <custom-ident> ',' <string> ',' [ <counter-style> ]? )"]

module Function_cross_fade =
  [%spec_module
  "function_cross_fade",
  "cross-fade( <cf-mixing-image> ',' [ <cf-final-image> ]? )"]

(* drop-shadow can have 2 length module order doesn't matter, we changed to be more restrict module always expect 3 *)
module Function_drop_shadow =
  [%spec_module
  "function_drop_shadow",
  "drop-shadow(<extended-length> <extended-length> <extended-length> [ <color> \
   ]?)"]

module Function_element =
  [%spec_module
  "function_element", "element( <id-selector> )"]

module Function_ellipse =
  [%spec_module
  "function_ellipse",
  "ellipse( [ [ <shape-radius> ]{2} ]? [ 'at' <position> ]? )"]

module Function_env =
  [%spec_module
  "function_env", "env( <custom-ident> ',' [ <declaration-value> ]? )"]

module Function_fit_content =
  [%spec_module
  "function_fit_content",
  "fit-content( <extended-length> | <extended-percentage> )"]

module Function_grayscale =
  [%spec_module
  "function_grayscale", "grayscale( <number-percentage> )"]

module Function_hsl =
  [%spec_module
  "function_hsl",
  " hsl( <hue> <extended-percentage> <extended-percentage> [ '/' <alpha-value> \
   ]? ) | hsl( <hue> ',' <extended-percentage> ',' <extended-percentage> [ ',' \
   <alpha-value> ]? )"]

module Function_hsla =
  [%spec_module
  "function_hsla",
  " hsla( <hue> <extended-percentage> <extended-percentage> [ '/' \
   <alpha-value> ]? ) | hsla( <hue> ',' <extended-percentage> ',' \
   <extended-percentage> ',' [ <alpha-value> ]? )"]

module Function_hue_rotate =
  [%spec_module
  "function_hue_rotate", "hue-rotate( <extended-angle> )"]

module Function_image =
  [%spec_module
  "function_image",
  "image( [ <image-tags> ]? [ <image-src> ]? ',' [ <color> ]? )"]

module Function_image_set =
  [%spec_module
  "function_image_set", "image-set( [ <image-set-option> ]# )"]

module Function_inset =
  [%spec_module
  "function_inset",
  "inset( [ <extended-length> | <extended-percentage> ]{1,4} [ 'round' \
   <'border-radius'> ]? )"]

module Function_invert =
  [%spec_module
  "function_invert", "invert( <number-percentage> )"]

module Function_leader =
  [%spec_module
  "function_leader", "leader( <leader-type> )"]

module Function_linear_gradient =
  [%spec_module
  "function_linear_gradient",
  "linear-gradient( [ [<extended-angle> ','] | ['to' <side-or-corner> ','] ]? \
   <color-stop-list> )"]

(* module function_linear_gradient = [%spec_module "function_linear_gradient",
  "linear-gradient( [ <extended-angle> | 'to' <side-or-corner> ]? ',' <color-stop-list> )"] *)
module Function_matrix =
  [%spec_module
  "function_matrix", "matrix( [ <number> ]#{6} )"]

module Function_matrix3d =
  [%spec_module
  "function_matrix3d", "matrix3d( [ <number> ]#{16} )"]

module Function_max = [%spec_module "function_max", "max( [ <calc-sum> ]# )"]
module Function_min = [%spec_module "function_min", "min( [ <calc-sum> ]# )"]

module Function_minmax =
  [%spec_module
  "function_minmax",
  "minmax( [ <extended-length> | <extended-percentage> | 'min-content' | \
   'max-content' | 'auto' ] ',' [ <extended-length> | <extended-percentage> | \
   <flex-value> | 'min-content' | 'max-content' | 'auto' ] )"]

module Function_opacity =
  [%spec_module
  "function_opacity", "opacity( <number-percentage> )"]

module Function_paint =
  [%spec_module
  "function_paint", "paint( <ident> ',' [ <declaration-value> ]? )"]

module Function_path = [%spec_module "function_path", "path( <string> )"]

module Function_perspective =
  [%spec_module
  "function_perspective", "perspective( <property-perspective> )"]

module Function_polygon =
  [%spec_module
  "function_polygon",
  "polygon( [ <fill-rule> ',' ]? [ <length-percentage> <length-percentage> ]# )"]

module Function_radial_gradient =
  [%spec_module
  "function_radial_gradient",
  "radial-gradient( <ending-shape>? <radial-size>? ['at' <position> ]? ','? \
   <color-stop-list> )"]

module Function_repeating_linear_gradient =
  [%spec_module
  "function_repeating_linear_gradient",
  "repeating-linear-gradient( [ <extended-angle> | 'to' <side-or-corner> ]? \
   ',' <color-stop-list> )"]

module Function_repeating_radial_gradient =
  [%spec_module
  "function_repeating_radial_gradient",
  "repeating-radial-gradient( [ <ending-shape> || <size> ]? [ 'at' <position> \
   ]? ',' <color-stop-list> )"]

module Function_rgb =
  [%spec_module
  "function_rgb",
  "rgb( [ <extended-percentage> ]{3} [ '/' <alpha-value> ]? ) | rgb( [ \
   <number> ]{3} [ '/' <alpha-value> ]? ) | rgb( [ <extended-percentage> ]#{3} \
   [ ',' <alpha-value> ]? ) | rgb( [ <number> ]#{3} [ ',' <alpha-value> ]? )"]

module Function_rgba =
  [%spec_module
  "function_rgba",
  "rgba( [ <extended-percentage> ]{3} [ '/' <alpha-value> ]? ) | rgba( [ \
   <number> ]{3} [ '/' <alpha-value> ]? ) | rgba( [ <extended-percentage> \
   ]#{3} [ ',' <alpha-value> ]? ) | rgba( [ <number> ]#{3} [ ',' <alpha-value> \
   ]? )"]

module Function_rotate =
  [%spec_module
  "function_rotate", "rotate( <extended-angle> | <zero> )"]

module Function_rotate3d =
  [%spec_module
  "function_rotate3d",
  "rotate3d( <number> ',' <number> ',' <number> ',' [ <extended-angle> | \
   <zero> ] )"]

module Function_rotateX =
  [%spec_module
  "function_rotateX", "rotateX( <extended-angle> | <zero> )"]

module Function_rotateY =
  [%spec_module
  "function_rotateY", "rotateY( <extended-angle> | <zero> )"]

module Function_rotateZ =
  [%spec_module
  "function_rotateZ", "rotateZ( <extended-angle> | <zero> )"]

module Function_saturate =
  [%spec_module
  "function_saturate", "saturate( <number-percentage> )"]

module Function_scale =
  [%spec_module
  "function_scale", "scale( <number> [',' [ <number> ]]? )"]

module Function_scale3d =
  [%spec_module
  "function_scale3d", "scale3d( <number> ',' <number> ',' <number> )"]

module Function_scaleX = [%spec_module "function_scaleX", "scaleX( <number> )"]
module Function_scaleY = [%spec_module "function_scaleY", "scaleY( <number> )"]
module Function_scaleZ = [%spec_module "function_scaleZ", "scaleZ( <number> )"]

module Function_sepia =
  [%spec_module
  "function_sepia", "sepia( <number-percentage> )"]

module Function_skew =
  [%spec_module
  "function_skew",
  "skew( [ <extended-angle> | <zero> ] [',' [ <extended-angle> | <zero> ]]? )"]

module Function_skewX =
  [%spec_module
  "function_skewX", "skewX( <extended-angle> | <zero> )"]

module Function_skewY =
  [%spec_module
  "function_skewY", "skewY( <extended-angle> | <zero> )"]

module Function_symbols =
  [%spec_module
  "function_symbols", "symbols( [ <symbols-type> ]? [ <string> | <image> ]+ )"]

module Function_target_counter =
  [%spec_module
  "function_target_counter",
  "target-counter( [ <string> | <url> ] ',' <custom-ident> ',' [ \
   <counter-style> ]? )"]

module Function_target_counters =
  [%spec_module
  "function_target_counters",
  "target-counters( [ <string> | <url> ] ',' <custom-ident> ',' <string> ',' [ \
   <counter-style> ]? )"]

module Function_target_text =
  [%spec_module
  "function_target_text",
  "target-text( [ <string> | <url> ] ',' [ 'content' | 'before' | 'after' | \
   'first-letter' ]? )"]

module Function_translate =
  [%spec_module
  "function_translate",
  "translate( [<extended-length> | <extended-percentage>] [',' [ \
   <extended-length> | <extended-percentage> ]]? )"]

module Function_translate3d =
  [%spec_module
  "function_translate3d",
  "translate3d( [<extended-length> | <extended-percentage>] ',' \
   [<extended-length> | <extended-percentage>] ',' <extended-length> )"]

module Function_translateX =
  [%spec_module
  "function_translateX",
  "translateX( [<extended-length> | <extended-percentage>] )"]

module Function_translateY =
  [%spec_module
  "function_translateY",
  "translateY( [<extended-length> | <extended-percentage>] )"]

module Function_translateZ =
  [%spec_module
  "function_translateZ", "translateZ( <extended-length> )"]

(* module function_var = [%spec_module "function_var",
  "var( <ident> ',' [ <declaration-value> ]? )"] *)
module Function_var = [%spec_module "function_var", "var( <ident> )"]
module Gender = [%spec_module "gender", "'male' | 'female' | 'neutral'"]

module General_enclosed =
  [%spec_module
  "general_enclosed",
  "<function-token> <any-value> ')' | '(' <ident> <any-value> ')'"]

module Generic_family =
  [%spec_module
  "generic_family",
  "'serif' | 'sans-serif' | 'cursive' | 'fantasy' | 'monospace' | \
   '-apple-system'"]

module Generic_name =
  [%spec_module
  "generic_name", "'serif' | 'sans-serif' | 'cursive' | 'fantasy' | 'monospace'"]

module Generic_voice =
  [%spec_module
  "generic_voice", "[ <age> ]? <gender> [ <integer> ]?"]

module Geometry_box =
  [%spec_module
  "geometry_box", "<shape-box> | 'fill-box' | 'stroke-box' | 'view-box'"]

module Gradient =
  [%spec_module
  "gradient",
  "<linear-gradient()> | <repeating-linear-gradient()> | <radial-gradient()> | \
   <repeating-radial-gradient()> | <conic-gradient()> | <legacy-gradient>"]

module Grid_line =
  [%spec_module
  "grid_line",
  "<custom-ident-without-span-or-auto> | <integer> && [ \
   <custom-ident-without-span-or-auto> ]? | 'span' && [ <integer> || \
   <custom-ident-without-span-or-auto> ] | 'auto' | <interpolation>"]

module Historical_lig_values =
  [%spec_module
  "historical_lig_values", "'historical-ligatures' | 'no-historical-ligatures'"]

module Hue = [%spec_module "hue", "<number> | <extended-angle>"]
module Id_selector = [%spec_module "id_selector", "<hash-token>"]

module Image =
  [%spec_module
  "image",
  "<url> | <image()> | <image-set()> | <element()> | <paint()> | \
   <cross-fade()> | <gradient> | <interpolation>"]

module Image_set_option =
  [%spec_module
  "image_set_option", "[ <image> | <string> ] <resolution>"]

module Image_src = [%spec_module "image_src", "<url> | <string>"]
module Image_tags = [%spec_module "image_tags", "'ltr' | 'rtl'"]

module Inflexible_breadth =
  [%spec_module
  "inflexible_breadth",
  "<extended-length> | <extended-percentage> | 'min-content' | 'max-content' | \
   'auto'"]

module Keyframe_block =
  [%spec_module
  "keyframe_block", "[ <keyframe-selector> ]# '{' <declaration-list> '}'"]

module Keyframe_block_list =
  [%spec_module
  "keyframe_block_list", "[ <keyframe-block> ]+"]

module Keyframe_selector =
  [%spec_module
  "keyframe_selector", "'from' | 'to' | <extended-percentage>"]

module Keyframes_name =
  [%spec_module
  "keyframes_name", "<custom-ident> | <string>"]

module Leader_type =
  [%spec_module
  "leader_type", "'dotted' | 'solid' | 'space' | <string>"]

module Left = [%spec_module "left", "<extended-length> | 'auto'"]

module Line_name_list =
  [%spec_module
  "line_name_list", "[ <line-names> | <name-repeat> ]+"]

module Line_style =
  [%spec_module
  "line_style",
  "'none' | 'hidden' | 'dotted' | 'dashed' | 'solid' | 'double' | 'groove' | \
   'ridge' | 'inset' | 'outset'"]

module Line_width =
  [%spec_module
  "line_width", "<extended-length> | 'thin' | 'medium' | 'thick'"]

module Linear_color_hint =
  [%spec_module
  "linear_color_hint", "<extended-length> | <extended-percentage>"]

module Linear_color_stop =
  [%spec_module
  "linear_color_stop", "<color> <length-percentage>?"]

module Mask_image = [%spec_module "mask_image", "[ <mask-reference> ]#"]

module Mask_layer =
  [%spec_module
  "mask_layer",
  "<mask-reference> || <position> [ '/' <bg-size> ]? || <repeat-style> || \
   <geometry-box> || [ <geometry-box> | 'no-clip' ] || <compositing-operator> \
   || <masking-mode>"]

module Mask_position =
  [%spec_module
  "mask_position",
  "[ <extended-length> | <extended-percentage> | 'left' | 'center' | 'right' ] \
   [ <extended-length> | <extended-percentage> | 'top' | 'center' | 'bottom' \
   ]?"]

module Mask_reference =
  [%spec_module
  "mask_reference", "'none' | <image> | <mask-source>"]

module Mask_source = [%spec_module "mask_source", "<url>"]

module Masking_mode =
  [%spec_module
  "masking_mode", "'alpha' | 'luminance' | 'match-source'"]

module Mf_comparison =
  [%spec_module
  "mf_comparison", "<mf-lt> | <mf-gt> | <mf-eq>"]

module Mf_eq = [%spec_module "mf_eq", "'='"]
module Mf_gt = [%spec_module "mf_gt", "'>=' | '>'"]
module Mf_lt = [%spec_module "mf_lt", "'<=' | '<'"]

module Mf_value =
  [%spec_module
  "mf_value",
  "<number> | <dimension> | <ident> | <ratio> | <interpolation> | <calc()>"]

module Mf_name = [%spec_module "mf_name", "<ident>"]

module Mf_range =
  [%spec_module
  "mf_range",
  "<mf-name> <mf-comparison> <mf-value> | <mf-value> <mf-comparison> <mf-name> \
   | <mf-value> <mf-lt> <mf-name> <mf-lt> <mf-value> | <mf-value> <mf-gt> \
   <mf-name> <mf-gt> <mf-value>"]

module Mf_boolean = [%spec_module "mf_boolean", "<mf-name>"]
module Mf_plain = [%spec_module "mf_plain", "<mf-name> ':' <mf-value>"]

module Media_feature =
  [%spec_module
  "media_feature", "'(' [ <mf-plain> | <mf-boolean> | <mf-range> ] ')'"]

module Media_in_parens =
  [%spec_module
  "media_in_parens",
  "'(' <media-condition> ')' | <media-feature> | <interpolation>"]

module Media_and = [%spec_module "media_and", "'and' <media-in-parens>"]
module Media_or = [%spec_module "media_or", "'or' <media-in-parens>"]
module Media_not = [%spec_module "media_not", "'not' <media-in-parens>"]

module Media_condition_without_or =
  [%spec_module
  "media_condition_without_or", "<media-not> | <media-in-parens> <media-and>*"]

module Media_condition =
  [%spec_module
  "media_condition",
  "<media-not> | <media-in-parens> [ <media-and>* | <media-or>* ]"]

module Media_query =
  [%spec_module
  "media_query",
  "<media-condition> | [ 'not' | 'only' ]? <media-type> [ 'and' \
   <media-condition-without-or> ]?"]

module Media_query_list =
  [%spec_module
  "media_query_list", "[ <media-query> ]# | <interpolation>"]

module Container_condition_list =
  [%spec_module
  "container_condition_list", "<container-condition>#"]

module Container_condition =
  [%spec_module
  "container_condition", "[ <container-name> ]? <container-query>"]

module Container_query =
  [%spec_module
  "container_query",
  "'not' <query-in-parens> | <query-in-parens> [ [ 'and' <query-in-parens> ]* \
   | [ 'or' <query-in-parens> ]* ]"]

module Query_in_parens =
  [%spec_module
  "query_in_parens",
  "'(' <container-query> ')' | '(' <size-feature> ')' | style( <style-query> )"]

module Size_feature =
  [%spec_module
  "size_feature", "<mf-plain> | <mf-boolean> | <mf-range>"]

module Style_query =
  [%spec_module
  "style_query",
  "'not' <style-in-parens> | <style-in-parens> [ [ module <style-in-parens> ]* \
   | [ or <style-in-parens> ]* ] | <style-feature>"]

module Style_feature =
  [%spec_module
  "style_feature", "<dashed_ident> ':' <mf-value>"]

module Style_in_parens =
  [%spec_module
  "style_in_parens", "'(' <style-query> ')' | '(' <style-feature> ')'"]

module Name_repeat =
  [%spec_module
  "name_repeat",
  "repeat( [ <positive-integer> | 'auto-fill' ] ',' [ <line-names> ]+ )"]

module Named_color =
  [%spec_module
  "named_color",
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
   'whitesmoke' | 'yellow' | 'yellowgreen' | <-non-standard-color>"]

module Namespace_prefix = [%spec_module "namespace_prefix", "<ident>"]
module Ns_prefix = [%spec_module "ns_prefix", "[ <ident-token> | '*' ]? '|'"]
module Nth = [%spec_module "nth", "<an-plus-b> | 'even' | 'odd'"]

module Number_one_or_greater =
  [%spec_module
  "number_one_or_greater", "<number>"]

module Number_percentage =
  [%spec_module
  "number_percentage", "<number> | <extended-percentage>"]

module Number_zero_one = [%spec_module "number_zero_one", "<number>"]

module Numeric_figure_values =
  [%spec_module
  "numeric_figure_values", "'lining-nums' | 'oldstyle-nums'"]

module Numeric_fraction_values =
  [%spec_module
  "numeric_fraction_values", "'diagonal-fractions' | 'stacked-fractions'"]

module Numeric_spacing_values =
  [%spec_module
  "numeric_spacing_values", "'proportional-nums' | 'tabular-nums'"]

module Outline_radius =
  [%spec_module
  "outline_radius", "<extended-length> | <extended-percentage>"]

module Overflow_position =
  [%spec_module
  "overflow_position", "'unsafe' | 'safe'"]

module Page_body =
  [%spec_module
  "page_body",
  "[ <declaration> ]? [ ';' <page-body> ]? | <page-margin-box> <page-body>"]

module Page_margin_box =
  [%spec_module
  "page_margin_box", "<page-margin-box-type> '{' <declaration-list> '}'"]

module Page_margin_box_type =
  [%spec_module
  "page_margin_box_type",
  "'@top-left-corner' | '@top-left' | '@top-center' | '@top-right' | \
   '@top-right-corner' | '@bottom-left-corner' | '@bottom-left' | \
   '@bottom-center' | '@bottom-right' | '@bottom-right-corner' | '@left-top' | \
   '@left-middle' | '@left-bottom' | '@right-top' | '@right-middle' | \
   '@right-bottom'"]

module Page_selector =
  [%spec_module
  "page_selector", "[ <pseudo-page> ]+ | <ident> [ <pseudo-page> ]*"]

module Page_selector_list =
  [%spec_module
  "page_selector_list", "[ [ <page-selector> ]# ]?"]

module Paint =
  [%spec_module
  "paint",
  "'none' | <color> | <url> [ 'none' | <color> ]? | 'context-fill' | \
   'context-stroke' | <interpolation>"]

module Position =
  [%spec_module
  "position",
  "[ 'left' | 'center' | 'right' | 'top' | 'bottom' | <length-percentage> ] | \
   [ 'left' | 'center' | 'right' ] && [ 'top' | 'center' | 'bottom' ] | [ \
   'left' | 'center' | 'right' | <length-percentage> ] [ 'top' | 'center' | \
   'bottom' | <length-percentage> ] | [ [ 'left' | 'right' ] \
   <length-percentage> ] && [ [ 'top' | 'bottom' ] <length-percentage> ]"]

module Positive_integer = [%spec_module "positive_integer", "<integer>"]

module Property__moz_appearance =
  [%spec_module
  "property__moz_appearance",
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
   '-moz-window-titlebar-maximized'"]

module Property__moz_background_clip =
  [%spec_module
  "property__moz_background_clip", "'padding' | 'border'"]

module Property__moz_binding =
  [%spec_module
  "property__moz_binding", "<url> | 'none'"]

module Property__moz_border_bottom_colors =
  [%spec_module
  "property__moz_border_bottom_colors", "[ <color> ]+ | 'none'"]

module Property__moz_border_left_colors =
  [%spec_module
  "property__moz_border_left_colors", "[ <color> ]+ | 'none'"]

module Property__moz_border_radius_bottomleft =
  [%spec_module
  "property__moz_border_radius_bottomleft", "<'border-bottom-left-radius'>"]

module Property__moz_border_radius_bottomright =
  [%spec_module
  "property__moz_border_radius_bottomright", "<'border-bottom-right-radius'>"]

module Property__moz_border_radius_topleft =
  [%spec_module
  "property__moz_border_radius_topleft", "<'border-top-left-radius'>"]

module Property__moz_border_radius_topright =
  [%spec_module
  "property__moz_border_radius_topright", "<'border-bottom-right-radius'>"]

(* TODO: Remove interpolation without <> *)
module Property__moz_border_right_colors =
  [%spec_module
  "property__moz_border_right_colors", "[ <color> ]+ | 'none' | interpolation"]

(* TODO: Remove interpolation without <> *)
module Property__moz_border_top_colors =
  [%spec_module
  "property__moz_border_top_colors", "[ <color> ]+ | 'none' | interpolation"]

module Property__moz_context_properties =
  [%spec_module
  "property__moz_context_properties",
  "'none' | [ 'fill' | 'fill-opacity' | 'stroke' | 'stroke-opacity' ]#"]

module Property__moz_control_character_visibility =
  [%spec_module
  "property__moz_control_character_visibility", "'visible' | 'hidden'"]

module Property__moz_float_edge =
  [%spec_module
  "property__moz_float_edge",
  "'border-box' | 'content-box' | 'margin-box' | 'padding-box'"]

module Property__moz_force_broken_image_icon =
  [%spec_module
  "property__moz_force_broken_image_icon", "<integer>"]

module Property__moz_image_region =
  [%spec_module
  "property__moz_image_region", "<shape> | 'auto'"]

module Property__moz_orient =
  [%spec_module
  "property__moz_orient", "'inline' | 'block' | 'horizontal' | 'vertical'"]

module Property__moz_osx_font_smoothing =
  [%spec_module
  "property__moz_osx_font_smoothing", "'auto' | 'grayscale'"]

module Property__moz_outline_radius =
  [%spec_module
  "property__moz_outline_radius",
  "[ <outline-radius> ]{1,4} [ '/' [ <outline-radius> ]{1,4} ]?"]

module Property__moz_outline_radius_bottomleft =
  [%spec_module
  "property__moz_outline_radius_bottomleft", "<outline-radius>"]

module Property__moz_outline_radius_bottomright =
  [%spec_module
  "property__moz_outline_radius_bottomright", "<outline-radius>"]

module Property__moz_outline_radius_topleft =
  [%spec_module
  "property__moz_outline_radius_topleft", "<outline-radius>"]

module Property__moz_outline_radius_topright =
  [%spec_module
  "property__moz_outline_radius_topright", "<outline-radius>"]

module Property__moz_stack_sizing =
  [%spec_module
  "property__moz_stack_sizing", "'ignore' | 'stretch-to-fit'"]

module Property__moz_text_blink =
  [%spec_module
  "property__moz_text_blink", "'none' | 'blink'"]

module Property__moz_user_focus =
  [%spec_module
  "property__moz_user_focus",
  "'ignore' | 'normal' | 'select-after' | 'select-before' | 'select-menu' | \
   'select-same' | 'select-all' | 'none'"]

module Property__moz_user_input =
  [%spec_module
  "property__moz_user_input", "'auto' | 'none' | 'enabled' | 'disabled'"]

module Property__moz_user_modify =
  [%spec_module
  "property__moz_user_modify", "'read-only' | 'read-write' | 'write-only'"]

module Property__moz_user_select =
  [%spec_module
  "property__moz_user_select", "'none' | 'text' | 'all' | '-moz-none'"]

module Property__moz_window_dragging =
  [%spec_module
  "property__moz_window_dragging", "'drag' | 'no-drag'"]

module Property__moz_window_shadow =
  [%spec_module
  "property__moz_window_shadow",
  "'default' | 'menu' | 'tooltip' | 'sheet' | 'none'"]

module Property__webkit_appearance =
  [%spec_module
  "property__webkit_appearance",
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
   'sliderthumb-vertical' | 'square-button' | 'textarea' | 'textfield'"]

module Property__webkit_background_clip =
  [%spec_module
  "property__webkit_background_clip",
  "[ <box> | 'border' | 'padding' | 'content' | 'text' ]#"]

module Property__webkit_border_before =
  [%spec_module
  "property__webkit_border_before",
  "<'border-width'> || <'border-style'> || <'color'>"]

module Property__webkit_border_before_color =
  [%spec_module
  "property__webkit_border_before_color", "<'color'>"]

module Property__webkit_border_before_style =
  [%spec_module
  "property__webkit_border_before_style", "<'border-style'>"]

module Property__webkit_border_before_width =
  [%spec_module
  "property__webkit_border_before_width", "<'border-width'>"]

module Property__webkit_box_reflect =
  [%spec_module
  "property__webkit_box_reflect",
  "[ 'above' | 'below' | 'right' | 'left' ]? [ <extended-length> ]? [ <image> \
   ]?"]

module Property__webkit_column_break_after =
  [%spec_module
  "property__webkit_column_break_after", "'always' | 'auto' | 'avoid'"]

module Property__webkit_column_break_before =
  [%spec_module
  "property__webkit_column_break_before", "'always' | 'auto' | 'avoid'"]

module Property__webkit_column_break_inside =
  [%spec_module
  "property__webkit_column_break_inside", "'always' | 'auto' | 'avoid'"]

module Property__webkit_font_smoothing =
  [%spec_module
  "property__webkit_font_smoothing",
  "'auto' | 'none' | 'antialiased' | 'subpixel-antialiased'"]

module Property__webkit_line_clamp =
  [%spec_module
  "property__webkit_line_clamp", "'none' | <integer>"]

module Property__webkit_mask =
  [%spec_module
  "property__webkit_mask",
  "[ <mask-reference> || <position> [ '/' <bg-size> ]? || <repeat-style> || [ \
   <box> | 'border' | 'padding' | 'content' | 'text' ] || [ <box> | 'border' | \
   'padding' | 'content' ] ]#"]

module Property__webkit_mask_attachment =
  [%spec_module
  "property__webkit_mask_attachment", "[ <attachment> ]#"]

module Property__webkit_mask_box_image =
  [%spec_module
  "property__webkit_mask_box_image",
  "[ <url> | <gradient> | 'none' ] [ [ <extended-length> | \
   <extended-percentage> ]{4} [ <webkit-mask-box-repeat> ]{2} ]?"]

module Property__webkit_mask_clip =
  [%spec_module
  "property__webkit_mask_clip",
  "[ <box> | 'border' | 'padding' | 'content' | 'text' ]#"]

module Property__webkit_mask_composite =
  [%spec_module
  "property__webkit_mask_composite", "[ <composite-style> ]#"]

module Property__webkit_mask_image =
  [%spec_module
  "property__webkit_mask_image", "[ <mask-reference> ]#"]

module Property__webkit_mask_origin =
  [%spec_module
  "property__webkit_mask_origin",
  "[ <box> | 'border' | 'padding' | 'content' ]#"]

module Property__webkit_mask_position =
  [%spec_module
  "property__webkit_mask_position", "[ <position> ]#"]

module Property__webkit_mask_position_x =
  [%spec_module
  "property__webkit_mask_position_x",
  "[ <extended-length> | <extended-percentage> | 'left' | 'center' | 'right' ]#"]

module Property__webkit_mask_position_y =
  [%spec_module
  "property__webkit_mask_position_y",
  "[ <extended-length> | <extended-percentage> | 'top' | 'center' | 'bottom' ]#"]

module Property__webkit_mask_repeat =
  [%spec_module
  "property__webkit_mask_repeat", "[ <repeat-style> ]#"]

module Property__webkit_mask_repeat_x =
  [%spec_module
  "property__webkit_mask_repeat_x", "'repeat' | 'no-repeat' | 'space' | 'round'"]

module Property__webkit_mask_repeat_y =
  [%spec_module
  "property__webkit_mask_repeat_y", "'repeat' | 'no-repeat' | 'space' | 'round'"]

module Property__webkit_mask_size =
  [%spec_module
  "property__webkit_mask_size", "[ <bg-size> ]#"]

module Property__webkit_overflow_scrolling =
  [%spec_module
  "property__webkit_overflow_scrolling", "'auto' | 'touch'"]

module Property__webkit_print_color_adjust =
  [%spec_module
  "property__webkit_print_color_adjust", "'economy' | 'exact'"]

module Property__webkit_tap_highlight_color =
  [%spec_module
  "property__webkit_tap_highlight_color", "<color>"]

module Property__webkit_text_fill_color =
  [%spec_module
  "property__webkit_text_fill_color", "<color>"]

module Property__webkit_text_security =
  [%spec_module
  "property__webkit_text_security", "'none' | 'circle' | 'disc' | 'square'"]

module Property__webkit_text_stroke =
  [%spec_module
  "property__webkit_text_stroke", "<extended-length> || <color>"]

module Property__webkit_text_stroke_color =
  [%spec_module
  "property__webkit_text_stroke_color", "<color>"]

module Property__webkit_text_stroke_width =
  [%spec_module
  "property__webkit_text_stroke_width", "<extended-length>"]

module Property__webkit_touch_callout =
  [%spec_module
  "property__webkit_touch_callout", "'default' | 'none'"]

module Property__webkit_user_drag =
  [%spec_module
  "property__webkit_user_drag", "'none' | 'element' | 'auto'"]

module Property__webkit_user_modify =
  [%spec_module
  "property__webkit_user_modify",
  "'read-only' | 'read-write' | 'read-write-plaintext-only'"]

module Property__webkit_user_select =
  [%spec_module
  "property__webkit_user_select", "'auto' | 'none' | 'text' | 'all'"]

module Property_align_content =
  [%spec_module
  "property_align_content",
  "'normal' | <baseline-position> | <content-distribution> | [ \
   <overflow-position> ]? <content-position>"]

module Property_align_items =
  [%spec_module
  "property_align_items",
  "'normal' | 'stretch' | <baseline-position> | [ <overflow-position> ]? \
   <self-position> | <interpolation>"]

module Property_align_self =
  [%spec_module
  "property_align_self",
  "'auto' | 'normal' | 'stretch' | <baseline-position> | [ <overflow-position> \
   ]? <self-position> | <interpolation>"]

module Property_alignment_baseline =
  [%spec_module
  "property_alignment_baseline",
  "'auto' | 'baseline' | 'before-edge' | 'text-before-edge' | 'middle' | \
   'central' | 'after-edge' | 'text-after-edge' | 'ideographic' | 'alphabetic' \
   | 'hanging' | 'mathematical'"]

module Property_all =
  [%spec_module
  "property_all", "'initial' | 'inherit' | 'unset' | 'revert'"]

module Property_animation =
  [%spec_module
  "property_animation", "[ <single-animation> | <single-animation-no-interp> ]#"]

module Property_animation_delay =
  [%spec_module
  "property_animation_delay", "[ <extended-time> ]#"]

module Property_animation_direction =
  [%spec_module
  "property_animation_direction", "[ <single-animation-direction> ]#"]

module Property_animation_duration =
  [%spec_module
  "property_animation_duration", "[ <extended-time> ]#"]

module Property_animation_fill_mode =
  [%spec_module
  "property_animation_fill_mode", "[ <single-animation-fill-mode> ]#"]

module Property_animation_iteration_count =
  [%spec_module
  "property_animation_iteration_count",
  "[ <single-animation-iteration-count> ]#"]

module Property_animation_name =
  [%spec_module
  "property_animation_name", "[ <keyframes-name> | 'none' | <interpolation> ]#"]

module Property_animation_play_state =
  [%spec_module
  "property_animation_play_state", "[ <single-animation-play-state> ]#"]

module Property_animation_timing_function =
  [%spec_module
  "property_animation_timing_function", "[ <timing-function> ]#"]

module Property_appearance =
  [%spec_module
  "property_appearance",
  "'none' | 'auto' | 'button' | 'textfield' | 'menulist-button' | <compat-auto>"]

module Property_aspect_ratio =
  [%spec_module
  "property_aspect_ratio", "'auto' | <ratio>"]

module Property_azimuth =
  [%spec_module
  "property_azimuth",
  "<extended-angle> | [ 'left-side' | 'far-left' | 'left' | 'center-left' | \
   'center' | 'center-right' | 'right' | 'far-right' | 'right-side' ] || \
   'behind' | 'leftwards' | 'rightwards'"]

module Property_backdrop_filter =
  [%spec_module
  "property_backdrop_filter",
  "'none' | <interpolation> | <filter-function-list>"]

module Property_backface_visibility =
  [%spec_module
  "property_backface_visibility", "'visible' | 'hidden'"]

module Property_background =
  [%spec_module
  "property_background", "[ <bg-layer> ',' ]* <final-bg-layer>"]

module Property_background_attachment =
  [%spec_module
  "property_background_attachment", "[ <attachment> ]#"]

module Property_background_blend_mode =
  [%spec_module
  "property_background_blend_mode", "[ <blend-mode> ]#"]

module Property_background_clip =
  [%spec_module
  "property_background_clip", "[ <box> | 'text' | 'border-area' ]#"]

module Property_background_color =
  [%spec_module
  "property_background_color", "<color>"]

module Property_background_image =
  [%spec_module
  "property_background_image", "[ <bg-image> ]#"]

module Property_background_origin =
  [%spec_module
  "property_background_origin", "[ <box> ]#"]

module Property_background_position =
  [%spec_module
  "property_background_position", "[ <bg-position> ]#"]

module Property_background_position_x =
  [%spec_module
  "property_background_position_x",
  "[ 'center' | [ 'left' | 'right' | 'x-start' | 'x-end' ]? [ \
   <extended-length> | <extended-percentage> ]? ]#"]

module Property_background_position_y =
  [%spec_module
  "property_background_position_y",
  "[ 'center' | [ 'top' | 'bottom' | 'y-start' | 'y-end' ]? [ \
   <extended-length> | <extended-percentage> ]? ]#"]

module Property_background_repeat =
  [%spec_module
  "property_background_repeat", "[ <repeat-style> ]#"]

module Property_background_size =
  [%spec_module
  "property_background_size", "[ <bg-size> ]#"]

module Property_baseline_shift =
  [%spec_module
  "property_baseline_shift", "'baseline' | 'sub' | 'super' | <svg-length>"]

module Property_behavior = [%spec_module "property_behavior", "[ <url> ]+"]

module Property_block_overflow =
  [%spec_module
  "property_block_overflow", "'clip' | 'ellipsis' | <string>"]

module Property_block_size = [%spec_module "property_block_size", "<'width'>"]

module Property_border =
  [%spec_module
  "property_border",
  "'none' | [ <line-width> | <interpolation> ] | [ <line-width> | \
   <interpolation> ] [ <line-style> | <interpolation> ] | [ <line-width> | \
   <interpolation> ] [ <line-style> | <interpolation> ] [ <color> | \
   <interpolation> ]"]

module Property_border_block =
  [%spec_module
  "property_border_block", "<'border'>"]

module Property_border_block_color =
  [%spec_module
  "property_border_block_color", "[ <'border-top-color'> ]{1,2}"]

module Property_border_block_end =
  [%spec_module
  "property_border_block_end", "<'border'>"]

module Property_border_block_end_color =
  [%spec_module
  "property_border_block_end_color", "<'border-top-color'>"]

module Property_border_block_end_style =
  [%spec_module
  "property_border_block_end_style", "<'border-top-style'>"]

module Property_border_block_end_width =
  [%spec_module
  "property_border_block_end_width", "<'border-top-width'>"]

module Property_border_block_start =
  [%spec_module
  "property_border_block_start", "<'border'>"]

module Property_border_block_start_color =
  [%spec_module
  "property_border_block_start_color", "<'border-top-color'>"]

module Property_border_block_start_style =
  [%spec_module
  "property_border_block_start_style", "<'border-top-style'>"]

module Property_border_block_start_width =
  [%spec_module
  "property_border_block_start_width", "<'border-top-width'>"]

module Property_border_block_style =
  [%spec_module
  "property_border_block_style", "<'border-top-style'>"]

module Property_border_block_width =
  [%spec_module
  "property_border_block_width", "<'border-top-width'>"]

module Property_border_bottom =
  [%spec_module
  "property_border_bottom", "<'border'>"]

module Property_border_bottom_color =
  [%spec_module
  "property_border_bottom_color", "<'border-top-color'>"]

module Property_border_bottom_left_radius =
  [%spec_module
  "property_border_bottom_left_radius",
  "[ <extended-length> | <extended-percentage> ]{1,2}"]

module Property_border_bottom_right_radius =
  [%spec_module
  "property_border_bottom_right_radius",
  "[ <extended-length> | <extended-percentage> ]{1,2}"]

module Property_border_bottom_style =
  [%spec_module
  "property_border_bottom_style", "<line-style>"]

module Property_border_bottom_width =
  [%spec_module
  "property_border_bottom_width", "<line-width>"]

module Property_border_collapse =
  [%spec_module
  "property_border_collapse", "'collapse' | 'separate'"]

module Property_border_color =
  [%spec_module
  "property_border_color", "[ <color> ]{1,4}"]

module Property_border_end_end_radius =
  [%spec_module
  "property_border_end_end_radius",
  "[ <extended-length> | <extended-percentage> ]{1,2}"]

module Property_border_end_start_radius =
  [%spec_module
  "property_border_end_start_radius",
  "[ <extended-length> | <extended-percentage> ]{1,2}"]

module Property_border_image =
  [%spec_module
  "property_border_image",
  "<'border-image-source'> || <'border-image-slice'> [ '/' \
   <'border-image-width'> | '/' [ <'border-image-width'> ]? '/' \
   <'border-image-outset'> ]? || <'border-image-repeat'>"]

module Property_border_image_outset =
  [%spec_module
  "property_border_image_outset", "[ <extended-length> | <number> ]{1,4}"]

module Property_border_image_repeat =
  [%spec_module
  "property_border_image_repeat",
  "[ 'stretch' | 'repeat' | 'round' | 'space' ]{1,2}"]

module Property_border_image_slice =
  [%spec_module
  "property_border_image_slice", "[ <number-percentage> ]{1,4} && [ 'fill' ]?"]

module Property_border_image_source =
  [%spec_module
  "property_border_image_source", "'none' | <image>"]

module Property_border_image_width =
  [%spec_module
  "property_border_image_width",
  "[ <extended-length> | <extended-percentage> | <number> | 'auto' ]{1,4}"]

module Property_border_inline =
  [%spec_module
  "property_border_inline", "<'border'>"]

module Property_border_inline_color =
  [%spec_module
  "property_border_inline_color", "[ <'border-top-color'> ]{1,2}"]

module Property_border_inline_end =
  [%spec_module
  "property_border_inline_end", "<'border'>"]

module Property_border_inline_end_color =
  [%spec_module
  "property_border_inline_end_color", "<'border-top-color'>"]

module Property_border_inline_end_style =
  [%spec_module
  "property_border_inline_end_style", "<'border-top-style'>"]

module Property_border_inline_end_width =
  [%spec_module
  "property_border_inline_end_width", "<'border-top-width'>"]

module Property_border_inline_start =
  [%spec_module
  "property_border_inline_start", "<'border'>"]

module Property_border_inline_start_color =
  [%spec_module
  "property_border_inline_start_color", "<'border-top-color'>"]

module Property_border_inline_start_style =
  [%spec_module
  "property_border_inline_start_style", "<'border-top-style'>"]

module Property_border_inline_start_width =
  [%spec_module
  "property_border_inline_start_width", "<'border-top-width'>"]

module Property_border_inline_style =
  [%spec_module
  "property_border_inline_style", "<'border-top-style'>"]

module Property_border_inline_width =
  [%spec_module
  "property_border_inline_width", "<'border-top-width'>"]

module Property_border_left =
  [%spec_module
  "property_border_left", "<'border'>"]

module Property_border_left_color =
  [%spec_module
  "property_border_left_color", "<color>"]

module Property_border_left_style =
  [%spec_module
  "property_border_left_style", "<line-style>"]

module Property_border_left_width =
  [%spec_module
  "property_border_left_width", "<line-width>"]

(* border-radius isn't supported with the entire spec in bs-css: `"[ <extended-length> | <extended-percentage> ]{1,4} [ '/' [ <extended-length> | <extended-percentage> ]{1,4} ]?"` *)
module Property_border_radius =
  [%spec_module
  "property_border_radius", "<extended-length> | <extended-percentage>"]

module Property_border_right =
  [%spec_module
  "property_border_right", "<'border'>"]

module Property_border_right_color =
  [%spec_module
  "property_border_right_color", "<color>"]

module Property_border_right_style =
  [%spec_module
  "property_border_right_style", "<line-style>"]

module Property_border_right_width =
  [%spec_module
  "property_border_right_width", "<line-width>"]

module Property_border_spacing =
  [%spec_module
  "property_border_spacing", "<extended-length> [ <extended-length> ]?"]

module Property_border_start_end_radius =
  [%spec_module
  "property_border_start_end_radius",
  "[ <extended-length> | <extended-percentage> ]{1,2}"]

module Property_border_start_start_radius =
  [%spec_module
  "property_border_start_start_radius",
  "[ <extended-length> | <extended-percentage> ]{1,2}"]

(* bs-css doesn't support list of styles, the original spec is: `[ <line-style> ]{1,4}` *)
module Property_border_style =
  [%spec_module
  "property_border_style", "<line-style>"]

module Property_border_top = [%spec_module "property_border_top", "<'border'>"]

module Property_border_top_color =
  [%spec_module
  "property_border_top_color", "<color>"]

module Property_border_top_left_radius =
  [%spec_module
  "property_border_top_left_radius",
  "[ <extended-length> | <extended-percentage> ]{1,2}"]

module Property_border_top_right_radius =
  [%spec_module
  "property_border_top_right_radius",
  "[ <extended-length> | <extended-percentage> ]{1,2}"]

module Property_border_top_style =
  [%spec_module
  "property_border_top_style", "<line-style>"]

module Property_border_top_width =
  [%spec_module
  "property_border_top_width", "<line-width>"]

module Property_border_width =
  [%spec_module
  "property_border_width", "[ <line-width> ]{1,4}"]

module Property_bottom =
  [%spec_module
  "property_bottom", "<extended-length> | <extended-percentage> | 'auto'"]

module Property_box_align =
  [%spec_module
  "property_box_align", "'start' | 'center' | 'end' | 'baseline' | 'stretch'"]

module Property_box_decoration_break =
  [%spec_module
  "property_box_decoration_break", "'slice' | 'clone'"]

module Property_box_direction =
  [%spec_module
  "property_box_direction", "'normal' | 'reverse' | 'inherit'"]

module Property_box_flex = [%spec_module "property_box_flex", "<number>"]

module Property_box_flex_group =
  [%spec_module
  "property_box_flex_group", "<integer>"]

module Property_box_lines =
  [%spec_module
  "property_box_lines", "'single' | 'multiple'"]

module Property_box_ordinal_group =
  [%spec_module
  "property_box_ordinal_group", "<integer>"]

module Property_box_orient =
  [%spec_module
  "property_box_orient",
  "'horizontal' | 'vertical' | 'inline-axis' | 'block-axis' | 'inherit'"]

module Property_box_pack =
  [%spec_module
  "property_box_pack", "'start' | 'center' | 'end' | 'justify'"]

module Property_box_shadow =
  [%spec_module
  "property_box_shadow", "'none' | <interpolation> | [ <shadow> ]#"]

module Property_box_sizing =
  [%spec_module
  "property_box_sizing", "'content-box' | 'border-box'"]

module Property_break_after =
  [%spec_module
  "property_break_after",
  "'auto' | 'avoid' | 'always' | 'all' | 'avoid-page' | 'page' | 'left' | \
   'right' | 'recto' | 'verso' | 'avoid-column' | 'column' | 'avoid-region' | \
   'region'"]

module Property_break_before =
  [%spec_module
  "property_break_before",
  "'auto' | 'avoid' | 'always' | 'all' | 'avoid-page' | 'page' | 'left' | \
   'right' | 'recto' | 'verso' | 'avoid-column' | 'column' | 'avoid-region' | \
   'region'"]

module Property_break_inside =
  [%spec_module
  "property_break_inside",
  "'auto' | 'avoid' | 'avoid-page' | 'avoid-column' | 'avoid-region'"]

module Property_caption_side =
  [%spec_module
  "property_caption_side",
  "'top' | 'bottom' | 'block-start' | 'block-end' | 'inline-start' | \
   'inline-end'"]

module Property_caret_color =
  [%spec_module
  "property_caret_color", "'auto' | <color>"]

module Property_clear =
  [%spec_module
  "property_clear",
  "'none' | 'left' | 'right' | 'both' | 'inline-start' | 'inline-end'"]

module Property_clip = [%spec_module "property_clip", "<shape> | 'auto'"]

module Property_clip_path =
  [%spec_module
  "property_clip_path",
  "<clip-source> | <basic-shape> || <geometry-box> | 'none'"]

module Property_clip_rule =
  [%spec_module
  "property_clip_rule", "'nonzero' | 'evenodd'"]

module Property_color = [%spec_module "property_color", "<color>"]

module Property_color_interpolation_filters =
  [%spec_module
  "property_color_interpolation_filters", "'auto' | 'sRGB' | 'linearRGB'"]

module Property_color_interpolation =
  [%spec_module
  "property_color_interpolation", "'auto' | 'sRGB' | 'linearRGB'"]

module Property_color_adjust =
  [%spec_module
  "property_color_adjust", "'economy' | 'exact'"]

module Property_column_count =
  [%spec_module
  "property_column_count", "<integer> | 'auto'"]

module Property_column_fill =
  [%spec_module
  "property_column_fill", "'auto' | 'balance' | 'balance-all'"]

module Property_column_gap =
  [%spec_module
  "property_column_gap", "'normal' | <extended-length> | <extended-percentage>"]

module Property_column_rule =
  [%spec_module
  "property_column_rule",
  "<'column-rule-width'> || <'column-rule-style'> || <'column-rule-color'>"]

module Property_column_rule_color =
  [%spec_module
  "property_column_rule_color", "<color>"]

module Property_column_rule_style =
  [%spec_module
  "property_column_rule_style", "<'border-style'>"]

module Property_column_rule_width =
  [%spec_module
  "property_column_rule_width", "<'border-width'>"]

module Property_column_span =
  [%spec_module
  "property_column_span", "'none' | 'all'"]

module Property_column_width =
  [%spec_module
  "property_column_width", "<extended-length> | 'auto'"]

module Property_columns =
  [%spec_module
  "property_columns", "<'column-width'> || <'column-count'>"]

module Property_contain =
  [%spec_module
  "property_contain",
  "'none' | 'strict' | 'content' | 'size' || 'layout' || 'style' || 'paint'"]

module Property_content =
  [%spec_module
  "property_content",
  "'normal' | 'none' | <string> | <interpolation> | [ <content-replacement> | \
   <content-list> ] [ '/' <string> ]?"]

module Property_content_visibility =
  [%spec_module
  "property_content_visibility", "'visible' | 'hidden' | 'auto'"]

module Property_counter_increment =
  [%spec_module
  "property_counter_increment", "[ <custom-ident> [ <integer> ]? ]+ | 'none'"]

module Property_counter_reset =
  [%spec_module
  "property_counter_reset", "[ <custom-ident> [ <integer> ]? ]+ | 'none'"]

module Property_counter_set =
  [%spec_module
  "property_counter_set", "[ <custom-ident> [ <integer> ]? ]+ | 'none'"]

module Property_cue =
  [%spec_module
  "property_cue", "<'cue-before'> [ <'cue-after'> ]?"]

module Property_cue_after =
  [%spec_module
  "property_cue_after", "<url> [ <decibel> ]? | 'none'"]

module Property_cue_before =
  [%spec_module
  "property_cue_before", "<url> [ <decibel> ]? | 'none'"]

(* module property_cursor = [%spec_module
     "property_cursor",
  "[ <url> [ <x> <y> ]? ',' ]* [ 'auto' | 'default' | 'none' | 'context-menu' | 'help' | 'pointer' | 'progress' | 'wait' | 'cell' | 'crosshair' | 'text' | 'vertical-text' | 'alias' | 'copy' | 'move' | 'no-drop' | 'not-allowed' | 'e-resize' | 'n-resize' | 'ne-resize' | 'nw-resize' | 's-resize' | 'se-resize' | 'sw-resize' | 'w-resize' | 'ew-resize' | 'ns-resize' | 'nesw-resize' | 'nwse-resize' | 'col-resize' | 'row-resize' | 'all-scroll' | 'zoom-in' | 'zoom-out' | 'grab' | 'grabbing' | 'hand' | '-webkit-grab' | '-webkit-grabbing' | '-webkit-zoom-in' | '-webkit-zoom-out' | '-moz-grab' | '-moz-grabbing' | '-moz-zoom-in' | '-moz-zoom-out' ] | <interpolation>"
   ] *)
(* Removed [ <url> [ <x> <y> ]? ',' ]* *)
module Property_cursor =
  [%spec_module
  "property_cursor",
  "'auto' | 'default' | 'none' | 'context-menu' | 'help' | 'pointer' | \
   'progress' | 'wait' | 'cell' | 'crosshair' | 'text' | 'vertical-text' | \
   'alias' | 'copy' | 'move' | 'no-drop' | 'not-allowed' | 'e-resize' | \
   'n-resize' | 'ne-resize' | 'nw-resize' | 's-resize' | 'se-resize' | \
   'sw-resize' | 'w-resize' | 'ew-resize' | 'ns-resize' | 'nesw-resize' | \
   'nwse-resize' | 'col-resize' | 'row-resize' | 'all-scroll' | 'zoom-in' | \
   'zoom-out' | 'grab' | 'grabbing' | 'hand' | '-webkit-grab' | \
   '-webkit-grabbing' | '-webkit-zoom-in' | '-webkit-zoom-out' | '-moz-grab' | \
   '-moz-grabbing' | '-moz-zoom-in' | '-moz-zoom-out' | <interpolation>"]

module Property_direction = [%spec_module "property_direction", "'ltr' | 'rtl'"]

module Property_display =
  [%spec_module
  "property_display",
  "'block' | 'contents' | 'flex' | 'flow' | 'flow-root' | 'grid' | 'inline' | \
   'inline-block' | 'inline-flex' | 'inline-grid' | 'inline-list-item' | \
   'inline-table' | 'list-item' | 'none' | 'ruby' | 'ruby-base' | \
   'ruby-base-container' | 'ruby-text' | 'ruby-text-container' | 'run-in' | \
   'table' | 'table-caption' | 'table-cell' | 'table-column' | \
   'table-column-group' | 'table-footer-group' | 'table-header-group' | \
   'table-row' | 'table-row-group' | '-webkit-flex' | '-webkit-inline-flex' | \
   '-webkit-box' | '-webkit-inline-box' | '-moz-inline-stack' | '-moz-box' | \
   '-moz-inline-box'"]

module Property_dominant_baseline =
  [%spec_module
  "property_dominant_baseline",
  "'auto' | 'use-script' | 'no-change' | 'reset-size' | 'ideographic' | \
   'alphabetic' | 'hanging' | 'mathematical' | 'central' | 'middle' | \
   'text-after-edge' | 'text-before-edge'"]

module Property_empty_cells =
  [%spec_module
  "property_empty_cells", "'show' | 'hide'"]

module Property_fill = [%spec_module "property_fill", "<paint>"]

module Property_fill_opacity =
  [%spec_module
  "property_fill_opacity", "<alpha-value>"]

module Property_fill_rule =
  [%spec_module
  "property_fill_rule", "'nonzero' | 'evenodd'"]

module Property_filter =
  [%spec_module
  "property_filter", "'none' | <interpolation> | <filter-function-list>"]

module Property_flex =
  [%spec_module
  "property_flex",
  "'none' | [<'flex-grow'> [ <'flex-shrink'> ]? || <'flex-basis'>] | \
   <interpolation>"]

module Property_flex_basis =
  [%spec_module
  "property_flex_basis", "'content' | <'width'> | <interpolation>"]

module Property_flex_direction =
  [%spec_module
  "property_flex_direction",
  "'row' | 'row-reverse' | 'column' | 'column-reverse'"]

module Property_flex_flow =
  [%spec_module
  "property_flex_flow", "<'flex-direction'> || <'flex-wrap'>"]

module Property_flex_grow =
  [%spec_module
  "property_flex_grow", "<number> | <interpolation>"]

module Property_flex_shrink =
  [%spec_module
  "property_flex_shrink", "<number> | <interpolation>"]

module Property_flex_wrap =
  [%spec_module
  "property_flex_wrap", "'nowrap' | 'wrap' | 'wrap-reverse'"]

module Property_float =
  [%spec_module
  "property_float", "'left' | 'right' | 'none' | 'inline-start' | 'inline-end'"]

module Property_font =
  [%spec_module
  "property_font",
  "[ <'font-style'> || <font-variant-css21> || <'font-weight'> || \
   <'font-stretch'> ]? <'font-size'> [ '/' <'line-height'> ]? <'font-family'> \
   | 'caption' | 'icon' | 'menu' | 'message-box' | 'small-caption' | \
   'status-bar'"]

module Font_families =
  [%spec_module
  "font_families", "[ <family-name> | <generic-family> | <interpolation> ]#"]

module Property_font_family =
  [%spec_module
  "property_font_family", "<font_families> | <interpolation>"]

module Property_font_feature_settings =
  [%spec_module
  "property_font_feature_settings", "'normal' | [ <feature-tag-value> ]#"]

module Property_font_display =
  [%spec_module
  "property_font_display", "'auto' | 'block' | 'swap' | 'fallback' | 'optional'"]

module Property_font_kerning =
  [%spec_module
  "property_font_kerning", "'auto' | 'normal' | 'none'"]

module Property_font_language_override =
  [%spec_module
  "property_font_language_override", "'normal' | <string>"]

module Property_font_optical_sizing =
  [%spec_module
  "property_font_optical_sizing", "'auto' | 'none'"]

module Property_font_palette =
  [%spec_module
  "property_font_palette", "'normal' | 'light' | 'dark'"]

module Property_font_size =
  [%spec_module
  "property_font_size",
  "<absolute-size> | <relative-size> | <extended-length> | \
   <extended-percentage>"]

module Property_font_size_adjust =
  [%spec_module
  "property_font_size_adjust", "'none' | <number>"]

module Property_font_smooth =
  [%spec_module
  "property_font_smooth",
  "'auto' | 'never' | 'always' | <absolute-size> | <extended-length>"]

module Property_font_stretch =
  [%spec_module
  "property_font_stretch", "<font-stretch-absolute>"]

module Property_font_style =
  [%spec_module
  "property_font_style",
  "'normal' | 'italic' | 'oblique' | <interpolation> | [ 'oblique' \
   <extended-angle> ]?"]

module Property_font_synthesis =
  [%spec_module
  "property_font_synthesis",
  "'none' | [ 'weight' || 'style' || 'small-caps' || 'position' ]"]

module Property_font_synthesis_weight =
  [%spec_module
  "property_font_synthesis_weight", "'auto' | 'none'"]

module Property_font_synthesis_style =
  [%spec_module
  "property_font_synthesis_style", "'auto' | 'none'"]

module Property_font_synthesis_small_caps =
  [%spec_module
  "property_font_synthesis_small_caps", "'auto' | 'none'"]

module Property_font_synthesis_position =
  [%spec_module
  "property_font_synthesis_position", "'auto' | 'none'"]

module Property_font_variant =
  [%spec_module
  "property_font_variant",
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
   || 'super' || 'text' || 'emoji' || 'unicode'"]

module Property_font_variant_alternates =
  [%spec_module
  "property_font_variant_alternates",
  "'normal' | stylistic( <feature-value-name> ) || 'historical-forms' || \
   styleset( [ <feature-value-name> ]# ) || character-variant( [ \
   <feature-value-name> ]# ) || swash( <feature-value-name> ) || ornaments( \
   <feature-value-name> ) || annotation( <feature-value-name> )"]

module Property_font_variant_caps =
  [%spec_module
  "property_font_variant_caps",
  "'normal' | 'small-caps' | 'all-small-caps' | 'petite-caps' | \
   'all-petite-caps' | 'unicase' | 'titling-caps'"]

module Property_font_variant_east_asian =
  [%spec_module
  "property_font_variant_east_asian",
  "'normal' | <east-asian-variant-values> || <east-asian-width-values> || \
   'ruby'"]

module Property_font_variant_ligatures =
  [%spec_module
  "property_font_variant_ligatures",
  "'normal' | 'none' | <common-lig-values> || <discretionary-lig-values> || \
   <historical-lig-values> || <contextual-alt-values>"]

module Property_font_variant_numeric =
  [%spec_module
  "property_font_variant_numeric",
  "'normal' | <numeric-figure-values> || <numeric-spacing-values> || \
   <numeric-fraction-values> || 'ordinal' || 'slashed-zero'"]

module Property_font_variant_position =
  [%spec_module
  "property_font_variant_position", "'normal' | 'sub' | 'super'"]

module Property_font_variation_settings =
  [%spec_module
  "property_font_variation_settings", "'normal' | [ <string> <number> ]#"]

module Property_font_variant_emoji =
  [%spec_module
  "property_font_variant_emoji", "'normal' | 'text' | 'emoji' | 'unicode'"]

module Property_font_weight =
  [%spec_module
  "property_font_weight",
  "<font-weight-absolute> | 'bolder' | 'lighter' | <interpolation>"]

module Property_gap =
  [%spec_module
  "property_gap", "<'row-gap'> [ <'column-gap'> ]?"]

module Property_glyph_orientation_horizontal =
  [%spec_module
  "property_glyph_orientation_horizontal", "<extended-angle>"]

module Property_glyph_orientation_vertical =
  [%spec_module
  "property_glyph_orientation_vertical", "<extended-angle>"]

module Property_grid =
  [%spec_module
  "property_grid",
  "<'grid-template'> | <'grid-template-rows'> '/' [ 'auto-flow' && [ 'dense' \
   ]? ] [ <'grid-auto-columns'> ]? | [ 'auto-flow' && [ 'dense' ]? ] [ \
   <'grid-auto-rows'> ]? '/' <'grid-template-columns'>"]

module Property_grid_area =
  [%spec_module
  "property_grid_area", "<grid-line> [ '/' <grid-line> ]{0,3}"]

module Property_grid_auto_columns =
  [%spec_module
  "property_grid_auto_columns", "[ <track-size> ]+"]

module Property_grid_auto_flow =
  [%spec_module
  "property_grid_auto_flow",
  "[ [ 'row' | 'column' ] || 'dense' ] | <interpolation>"]

module Property_grid_auto_rows =
  [%spec_module
  "property_grid_auto_rows", "[ <track-size> ]+"]

module Property_grid_column =
  [%spec_module
  "property_grid_column", "<grid-line> [ '/' <grid-line> ]?"]

module Property_grid_column_end =
  [%spec_module
  "property_grid_column_end", "<grid-line>"]

module Property_grid_column_gap =
  [%spec_module
  "property_grid_column_gap", "<extended-length> | <extended-percentage>"]

module Property_grid_column_start =
  [%spec_module
  "property_grid_column_start", "<grid-line>"]

module Property_grid_gap =
  [%spec_module
  "property_grid_gap", "<'grid-row-gap'> [ <'grid-column-gap'> ]?"]

module Property_grid_row =
  [%spec_module
  "property_grid_row", "<grid-line> [ '/' <grid-line> ]?"]

module Property_grid_row_end =
  [%spec_module
  "property_grid_row_end", "<grid-line>"]

module Property_grid_row_gap =
  [%spec_module
  "property_grid_row_gap", "<extended-length> | <extended-percentage>"]

module Property_grid_row_start =
  [%spec_module
  "property_grid_row_start", "<grid-line>"]

module Property_grid_template =
  [%spec_module
  "property_grid_template",
  "'none' | <'grid-template-rows'> '/' <'grid-template-columns'> | [ [ \
   <line-names> ]? <string> [ <track-size> ]? [ <line-names> ]? ]+ [ '/' \
   <explicit-track-list> ]?"]

module Property_grid_template_areas =
  [%spec_module
  "property_grid_template_areas", "'none' | [ <string> | <interpolation> ]+"]

module Property_grid_template_columns =
  [%spec_module
  "property_grid_template_columns",
  "'none' | <track-list> | <auto-track-list> | 'subgrid' [ <line-name-list> ]? \
   | 'masonry' | <interpolation>"]

module Property_grid_template_rows =
  [%spec_module
  "property_grid_template_rows",
  "'none' | <track-list> | <auto-track-list> | 'subgrid' [ <line-name-list> ]? \
   | 'masonry' | <interpolation>"]

module Property_hanging_punctuation =
  [%spec_module
  "property_hanging_punctuation",
  "'none' | 'first' || [ 'force-end' | 'allow-end' ] || 'last'"]

module Property_height =
  [%spec_module
  "property_height",
  "'auto' | <extended-length> | <extended-percentage> | 'min-content' | \
   'max-content' | 'fit-content' | fit-content( <extended-length> | \
   <extended-percentage> )"]

module Property_hyphens =
  [%spec_module
  "property_hyphens", "'none' | 'manual' | 'auto'"]

module Property_hyphenate_character =
  [%spec_module
  "property_hyphenate_character", "'auto' | <string-token>"]

module Property_hyphenate_limit_chars =
  [%spec_module
  "property_hyphenate_limit_chars", "'auto' | <integer>"]

module Property_hyphenate_limit_lines =
  [%spec_module
  "property_hyphenate_limit_lines", "'no-limit' | <integer>"]

module Property_hyphenate_limit_zone =
  [%spec_module
  "property_hyphenate_limit_zone", "<extended-length> | <extended-percentage>"]

module Property_image_orientation =
  [%spec_module
  "property_image_orientation",
  "'from-image' | <extended-angle> | [ <extended-angle> ]? 'flip'"]

module Property_image_rendering =
  [%spec_module
  "property_image_rendering",
  "'auto' |'smooth' | 'high-quality' | 'crisp-edges' | 'pixelated'"]

module Property_image_resolution =
  [%spec_module
  "property_image_resolution", "[ 'from-image' || <resolution> ] && [ 'snap' ]?"]

module Property_ime_mode =
  [%spec_module
  "property_ime_mode", "'auto' | 'normal' | 'active' | 'inactive' | 'disabled'"]

module Property_initial_letter =
  [%spec_module
  "property_initial_letter", "'normal' | <number> [ <integer> ]?"]

module Property_initial_letter_align =
  [%spec_module
  "property_initial_letter_align",
  "'auto' | 'alphabetic' | 'hanging' | 'ideographic'"]

module Property_inline_size = [%spec_module "property_inline_size", "<'width'>"]
module Property_inset = [%spec_module "property_inset", "[ <'top'> ]{1,4}"]

module Property_inset_block =
  [%spec_module
  "property_inset_block", "[ <'top'> ]{1,2}"]

module Property_inset_block_end =
  [%spec_module
  "property_inset_block_end", "<'top'>"]

module Property_inset_block_start =
  [%spec_module
  "property_inset_block_start", "<'top'>"]

module Property_inset_inline =
  [%spec_module
  "property_inset_inline", "[ <'top'> ]{1,2}"]

module Property_inset_inline_end =
  [%spec_module
  "property_inset_inline_end", "<'top'>"]

module Property_inset_inline_start =
  [%spec_module
  "property_inset_inline_start", "<'top'>"]

module Property_isolation =
  [%spec_module
  "property_isolation", "'auto' | 'isolate'"]

module Property_justify_content =
  [%spec_module
  "property_justify_content",
  "'normal' | <content-distribution> | [ <overflow-position> ]? [ \
   <content-position> | 'left' | 'right' ]"]

module Property_justify_items =
  [%spec_module
  "property_justify_items",
  "'normal' | 'stretch' | <baseline-position> | [ <overflow-position> ]? [ \
   <self-position> | 'left' | 'right' ] | 'legacy' | 'legacy' && [ 'left' | \
   'right' | 'center' ]"]

module Property_justify_self =
  [%spec_module
  "property_justify_self",
  "'auto' | 'normal' | 'stretch' | <baseline-position> | [ <overflow-position> \
   ]? [ <self-position> | 'left' | 'right' ]"]

module Property_kerning =
  [%spec_module
  "property_kerning", "'auto' | <svg-length>"]

module Property_layout_grid =
  [%spec_module
  "property_layout_grid",
  "'auto' | <custom-ident> | <integer> && [ <custom-ident> ]?"]

module Property_layout_grid_char =
  [%spec_module
  "property_layout_grid_char", "'auto' | <custom-ident> | <string>"]

module Property_layout_grid_line =
  [%spec_module
  "property_layout_grid_line", "'auto' | <custom-ident> | <string>"]

module Property_layout_grid_mode =
  [%spec_module
  "property_layout_grid_mode", "'auto' | <custom-ident> | <string>"]

module Property_layout_grid_type =
  [%spec_module
  "property_layout_grid_type", "'auto' | <custom-ident> | <string>"]

module Property_left =
  [%spec_module
  "property_left", "<extended-length> | <extended-percentage> | 'auto'"]

module Property_letter_spacing =
  [%spec_module
  "property_letter_spacing",
  "'normal' | <extended-length> | <extended-percentage>"]

module Property_line_break =
  [%spec_module
  "property_line_break",
  "'auto' | 'loose' | 'normal' | 'strict' | 'anywhere' | <interpolation>"]

module Property_line_clamp =
  [%spec_module
  "property_line_clamp", "'none' | <integer>"]

module Property_line_height =
  [%spec_module
  "property_line_height",
  "'normal' | <number> | <extended-length> | <extended-percentage>"]

module Property_line_height_step =
  [%spec_module
  "property_line_height_step", "<extended-length>"]

module Property_list_style =
  [%spec_module
  "property_list_style",
  "<'list-style-type'> || <'list-style-position'> || <'list-style-image'>"]

module Property_list_style_image =
  [%spec_module
  "property_list_style_image", "'none' | <image>"]

module Property_list_style_position =
  [%spec_module
  "property_list_style_position", "'inside' | 'outside'"]

module Property_list_style_type =
  [%spec_module
  "property_list_style_type", "<counter-style> | <string> | 'none'"]

module Property_margin =
  [%spec_module
  "property_margin",
  "[ <extended-length> | <extended-percentage> | 'auto' | <interpolation> \
   ]{1,4}"]

module Property_margin_block =
  [%spec_module
  "property_margin_block", "[ <'margin-left'> ]{1,2}"]

module Property_margin_block_end =
  [%spec_module
  "property_margin_block_end", "<'margin-left'>"]

module Property_margin_block_start =
  [%spec_module
  "property_margin_block_start", "<'margin-left'>"]

module Property_margin_bottom =
  [%spec_module
  "property_margin_bottom", "<extended-length> | <extended-percentage> | 'auto'"]

module Property_margin_inline =
  [%spec_module
  "property_margin_inline", "[ <'margin-left'> ]{1,2}"]

module Property_margin_inline_end =
  [%spec_module
  "property_margin_inline_end", "<'margin-left'>"]

module Property_margin_inline_start =
  [%spec_module
  "property_margin_inline_start", "<'margin-left'>"]

module Property_margin_left =
  [%spec_module
  "property_margin_left", "<extended-length> | <extended-percentage> | 'auto'"]

module Property_margin_right =
  [%spec_module
  "property_margin_right", "<extended-length> | <extended-percentage> | 'auto'"]

module Property_margin_top =
  [%spec_module
  "property_margin_top", "<extended-length> | <extended-percentage> | 'auto'"]

module Property_margin_trim =
  [%spec_module
  "property_margin_trim", "'none' | 'in-flow' | 'all'"]

module Property_marker = [%spec_module "property_marker", "'none' | <url>"]

module Property_marker_end =
  [%spec_module
  "property_marker_end", "'none' | <url>"]

module Property_marker_mid =
  [%spec_module
  "property_marker_mid", "'none' | <url>"]

module Property_marker_start =
  [%spec_module
  "property_marker_start", "'none' | <url>"]

module Property_mask = [%spec_module "property_mask", "[ <mask-layer> ]#"]

module Property_mask_border =
  [%spec_module
  "property_mask_border",
  "<'mask-border-source'> || <'mask-border-slice'> [ '/' [ \
   <'mask-border-width'> ]? [ '/' <'mask-border-outset'> ]? ]? || \
   <'mask-border-repeat'> || <'mask-border-mode'>"]

module Property_mask_border_mode =
  [%spec_module
  "property_mask_border_mode", "'luminance' | 'alpha'"]

module Property_mask_border_outset =
  [%spec_module
  "property_mask_border_outset", "[ <extended-length> | <number> ]{1,4}"]

module Property_mask_border_repeat =
  [%spec_module
  "property_mask_border_repeat",
  "[ 'stretch' | 'repeat' | 'round' | 'space' ]{1,2}"]

module Property_mask_border_slice =
  [%spec_module
  "property_mask_border_slice", "[ <number-percentage> ]{1,4} [ 'fill' ]?"]

module Property_mask_border_source =
  [%spec_module
  "property_mask_border_source", "'none' | <image>"]

module Property_mask_border_width =
  [%spec_module
  "property_mask_border_width",
  "[ <extended-length> | <extended-percentage> | <number> | 'auto' ]{1,4}"]

module Property_mask_clip =
  [%spec_module
  "property_mask_clip", "[ <geometry-box> | 'no-clip' ]#"]

module Property_mask_composite =
  [%spec_module
  "property_mask_composite", "[ <compositing-operator> ]#"]

module Property_mask_image =
  [%spec_module
  "property_mask_image", "[ <mask-reference> ]#"]

module Property_mask_mode =
  [%spec_module
  "property_mask_mode", "[ <masking-mode> ]#"]

module Property_mask_origin =
  [%spec_module
  "property_mask_origin", "[ <geometry-box> ]#"]

module Property_mask_position =
  [%spec_module
  "property_mask_position", "[ <position> ]#"]

module Property_mask_repeat =
  [%spec_module
  "property_mask_repeat", "[ <repeat-style> ]#"]

module Property_mask_size =
  [%spec_module
  "property_mask_size", "[ <bg-size> ]#"]

module Property_mask_type =
  [%spec_module
  "property_mask_type", "'luminance' | 'alpha'"]

module Property_masonry_auto_flow =
  [%spec_module
  "property_masonry_auto_flow",
  "[ 'pack' | 'next' ] || [ 'definite-first' | 'ordered' ]"]

module Property_max_block_size =
  [%spec_module
  "property_max_block_size", "<'max-width'>"]

module Property_max_height =
  [%spec_module
  "property_max_height",
  "'auto' | <extended-length> | <extended-percentage> | 'min-content' | \
   'max-content' | 'fit-content' | fit-content( <extended-length> | \
   <extended-percentage> )"]

module Property_max_inline_size =
  [%spec_module
  "property_max_inline_size", "<'max-width'>"]

module Property_max_lines =
  [%spec_module
  "property_max_lines", "'none' | <integer>"]

module Property_max_width =
  [%spec_module
  "property_max_width",
  "<extended-length> | <extended-percentage> | 'none' | 'max-content' | \
   'min-content' | 'fit-content' | fit-content( <extended-length> | \
   <extended-percentage> ) | 'fill-available' | <-non-standard-width>"]

module Property_min_block_size =
  [%spec_module
  "property_min_block_size", "<'min-width'>"]

module Property_min_height =
  [%spec_module
  "property_min_height",
  "'auto' | <extended-length> | <extended-percentage> | 'min-content' | \
   'max-content' | 'fit-content' | fit-content( <extended-length> | \
   <extended-percentage> )"]

module Property_min_inline_size =
  [%spec_module
  "property_min_inline_size", "<'min-width'>"]

module Property_min_width =
  [%spec_module
  "property_min_width",
  "<extended-length> | <extended-percentage> | 'auto' | 'max-content' | \
   'min-content' | 'fit-content' | fit-content( <extended-length> | \
   <extended-percentage> ) | 'fill-available' | <-non-standard-width>"]

module Property_mix_blend_mode =
  [%spec_module
  "property_mix_blend_mode", "<blend-mode>"]

module Property_media_any_hover =
  [%spec_module
  "property_media_any_hover", "none | hover"]

module Property_media_any_pointer =
  [%spec_module
  "property_media_any_pointer", "none | coarse | fine"]

module Property_media_pointer =
  [%spec_module
  "property_media_pointer", "none | coarse | fine"]

module Property_media_max_aspect_ratio =
  [%spec_module
  "property_media_max_aspect_ratio", "<ratio>"]

module Property_media_min_aspect_ratio =
  [%spec_module
  "property_media_min_aspect_ratio", "<ratio>"]

module Property_media_min_color =
  [%spec_module
  "property_media_min_color", "<integer>"]

module Property_media_color_gamut =
  [%spec_module
  "property_media_color_gamut", "'srgb' | 'p3' | 'rec2020'"]

module Property_media_color_index =
  [%spec_module
  "property_media_color_index", "<integer>"]

module Property_media_min_color_index =
  [%spec_module
  "property_media_min_color_index", "<integer>"]

module Property_media_display_mode =
  [%spec_module
  "property_media_display_mode",
  "'fullscreen' | 'standalone' | 'minimal-ui' | 'browser'"]

module Property_media_forced_colors =
  [%spec_module
  "property_media_forced_colors", "'none' | 'active'"]

module Property_forced_color_adjust =
  [%spec_module
  "property_forced_color_adjust", "'auto' | 'none' | 'preserve-parent-color'"]

module Property_media_grid = [%spec_module "property_media_grid", "<integer>"]

module Property_media_hover =
  [%spec_module
  "property_media_hover", "'hover' | 'none'"]

module Property_media_inverted_colors =
  [%spec_module
  "property_media_inverted_colors", "'inverted' | 'none'"]

module Property_media_monochrome =
  [%spec_module
  "property_media_monochrome", "<integer>"]

module Property_media_prefers_color_scheme =
  [%spec_module
  "property_media_prefers_color_scheme", "'dark' | 'light'"]

module Property_color_scheme =
  [%spec_module
  "property_color_scheme",
  "'normal' | [ 'dark' | 'light' | <custom-ident> ]+ && 'only'?"]

module Property_media_prefers_contrast =
  [%spec_module
  "property_media_prefers_contrast", "'no-preference' | 'more' | 'less'"]

module Property_media_prefers_reduced_motion =
  [%spec_module
  "property_media_prefers_reduced_motion", "'no-preference' | 'reduce'"]

module Property_media_resolution =
  [%spec_module
  "property_media_resolution", "<resolution>"]

module Property_media_min_resolution =
  [%spec_module
  "property_media_min_resolution", "<resolution>"]

module Property_media_max_resolution =
  [%spec_module
  "property_media_max_resolution", "<resolution>"]

module Property_media_scripting =
  [%spec_module
  "property_media_scripting", "'none' | 'initial-only' | 'enabled'"]

module Property_media_update =
  [%spec_module
  "property_media_update", "'none' | 'slow' | 'fast'"]

module Property_media_orientation =
  [%spec_module
  "property_media_orientation", "'portrait' | 'landscape'"]

module Property_object_fit =
  [%spec_module
  "property_object_fit", "'fill' | 'contain' | 'cover' | 'none' | 'scale-down'"]

module Property_object_position =
  [%spec_module
  "property_object_position", "<position>"]

module Property_offset =
  [%spec_module
  "property_offset",
  "[ [ <'offset-position'> ]? <'offset-path'> [ <'offset-distance'> || \
   <'offset-rotate'> ]? ]? [ '/' <'offset-anchor'> ]?"]

module Property_offset_anchor =
  [%spec_module
  "property_offset_anchor", "'auto' | <position>"]

module Property_offset_distance =
  [%spec_module
  "property_offset_distance", "<extended-length> | <extended-percentage>"]

module Property_offset_path =
  [%spec_module
  "property_offset_path",
  "'none' | ray( <extended-angle> && [ <ray_size> ]? && [ 'contain' ]? ) | \
   <path()> | <url> | <basic-shape> || <geometry-box>"]

module Property_offset_position =
  [%spec_module
  "property_offset_position", "'auto' | <position>"]

module Property_offset_rotate =
  [%spec_module
  "property_offset_rotate", "[ 'auto' | 'reverse' ] || <extended-angle>"]

module Property_opacity = [%spec_module "property_opacity", "<alpha-value>"]
module Property_order = [%spec_module "property_order", "<integer>"]
module Property_orphans = [%spec_module "property_orphans", "<integer>"]

module Property_outline =
  [%spec_module
  "property_outline",
  "'none' | <'outline-width'> | [ <'outline-width'> <'outline-style'> ] | [ \
   <'outline-width'> <'outline-style'> [ <color> | <interpolation> ]]"]

module Property_outline_color =
  [%spec_module
  "property_outline_color", "<color>"]

module Property_outline_offset =
  [%spec_module
  "property_outline_offset", "<extended-length>"]

module Property_outline_style =
  [%spec_module
  "property_outline_style", "'auto' | <line-style> | <interpolation>"]

module Property_outline_width =
  [%spec_module
  "property_outline_width", "<line-width> | <interpolation>"]

module Property_overflow =
  [%spec_module
  "property_overflow",
  "[ 'visible' | 'hidden' | 'clip' | 'scroll' | 'auto' ]{1,2} | \
   <-non-standard-overflow> | <interpolation>"]

module Property_overflow_anchor =
  [%spec_module
  "property_overflow_anchor", "'auto' | 'none'"]

module Property_overflow_block =
  [%spec_module
  "property_overflow_block",
  "'visible' | 'hidden' | 'clip' | 'scroll' | 'auto' | <interpolation>"]

module Property_overflow_clip_margin =
  [%spec_module
  "property_overflow_clip_margin", "<visual-box> || <extended-length>"]

module Property_overflow_inline =
  [%spec_module
  "property_overflow_inline",
  "'visible' | 'hidden' | 'clip' | 'scroll' | 'auto' | <interpolation>"]

module Property_overflow_wrap =
  [%spec_module
  "property_overflow_wrap", "'normal' | 'break-word' | 'anywhere'"]

module Property_overflow_x =
  [%spec_module
  "property_overflow_x",
  "'visible' | 'hidden' | 'clip' | 'scroll' | 'auto' | <interpolation>"]

module Property_overflow_y =
  [%spec_module
  "property_overflow_y",
  "'visible' | 'hidden' | 'clip' | 'scroll' | 'auto' | <interpolation>"]

module Property_overscroll_behavior =
  [%spec_module
  "property_overscroll_behavior", "[ 'contain' | 'none' | 'auto' ]{1,2}"]

module Property_overscroll_behavior_block =
  [%spec_module
  "property_overscroll_behavior_block", "'contain' | 'none' | 'auto'"]

module Property_overscroll_behavior_inline =
  [%spec_module
  "property_overscroll_behavior_inline", "'contain' | 'none' | 'auto'"]

module Property_overscroll_behavior_x =
  [%spec_module
  "property_overscroll_behavior_x", "'contain' | 'none' | 'auto'"]

module Property_overscroll_behavior_y =
  [%spec_module
  "property_overscroll_behavior_y", "'contain' | 'none' | 'auto'"]

module Property_padding =
  [%spec_module
  "property_padding",
  "[ <extended-length> | <extended-percentage> | <interpolation> ]{1,4}"]

module Property_padding_block =
  [%spec_module
  "property_padding_block", "[ <'padding-left'> ]{1,2}"]

module Property_padding_block_end =
  [%spec_module
  "property_padding_block_end", "<'padding-left'>"]

module Property_padding_block_start =
  [%spec_module
  "property_padding_block_start", "<'padding-left'>"]

module Property_padding_bottom =
  [%spec_module
  "property_padding_bottom", "<extended-length> | <extended-percentage>"]

module Property_padding_inline =
  [%spec_module
  "property_padding_inline", "[ <'padding-left'> ]{1,2}"]

module Property_padding_inline_end =
  [%spec_module
  "property_padding_inline_end", "<'padding-left'>"]

module Property_padding_inline_start =
  [%spec_module
  "property_padding_inline_start", "<'padding-left'>"]

module Property_padding_left =
  [%spec_module
  "property_padding_left", "<extended-length> | <extended-percentage>"]

module Property_padding_right =
  [%spec_module
  "property_padding_right", "<extended-length> | <extended-percentage>"]

module Property_padding_top =
  [%spec_module
  "property_padding_top", "<extended-length> | <extended-percentage>"]

module Property_page_break_after =
  [%spec_module
  "property_page_break_after",
  "'auto' | 'always' | 'avoid' | 'left' | 'right' | 'recto' | 'verso'"]

module Property_page_break_before =
  [%spec_module
  "property_page_break_before",
  "'auto' | 'always' | 'avoid' | 'left' | 'right' | 'recto' | 'verso'"]

module Property_page_break_inside =
  [%spec_module
  "property_page_break_inside", "'auto' | 'avoid'"]

module Property_paint_order =
  [%spec_module
  "property_paint_order", "'normal' | 'fill' || 'stroke' || 'markers'"]

module Property_pause =
  [%spec_module
  "property_pause", "<'pause-before'> [ <'pause-after'> ]?"]

module Property_pause_after =
  [%spec_module
  "property_pause_after",
  "<extended-time> | 'none' | 'x-weak' | 'weak' | 'medium' | 'strong' | \
   'x-strong'"]

module Property_pause_before =
  [%spec_module
  "property_pause_before",
  "<extended-time> | 'none' | 'x-weak' | 'weak' | 'medium' | 'strong' | \
   'x-strong'"]

module Property_perspective =
  [%spec_module
  "property_perspective", "'none' | <extended-length>"]

module Property_perspective_origin =
  [%spec_module
  "property_perspective_origin", "<position>"]

module Property_place_content =
  [%spec_module
  "property_place_content", "<'align-content'> [ <'justify-content'> ]?"]

module Property_place_items =
  [%spec_module
  "property_place_items", "<'align-items'> [ <'justify-items'> ]?"]

module Property_place_self =
  [%spec_module
  "property_place_self", "<'align-self'> [ <'justify-self'> ]?"]

module Property_pointer_events =
  [%spec_module
  "property_pointer_events",
  "'auto' | 'none' | 'visiblePainted' | 'visibleFill' | 'visibleStroke' | \
   'visible' | 'painted' | 'fill' | 'stroke' | 'all' | 'inherit'"]

module Property_position =
  [%spec_module
  "property_position",
  "'static' | 'relative' | 'absolute' | 'sticky' | 'fixed' | '-webkit-sticky'"]

module Property_quotes =
  [%spec_module
  "property_quotes", "'none' | 'auto' | [ <string> <string> ]+"]

module Property_resize =
  [%spec_module
  "property_resize",
  "'none' | 'both' | 'horizontal' | 'vertical' | 'block' | 'inline'"]

module Property_rest =
  [%spec_module
  "property_rest", "<'rest-before'> [ <'rest-after'> ]?"]

module Property_rest_after =
  [%spec_module
  "property_rest_after",
  "<extended-time> | 'none' | 'x-weak' | 'weak' | 'medium' | 'strong' | \
   'x-strong'"]

module Property_rest_before =
  [%spec_module
  "property_rest_before",
  "<extended-time> | 'none' | 'x-weak' | 'weak' | 'medium' | 'strong' | \
   'x-strong'"]

module Property_right =
  [%spec_module
  "property_right", "<extended-length> | <extended-percentage> | 'auto'"]

module Property_rotate =
  [%spec_module
  "property_rotate",
  "'none' | <extended-angle> | [ 'x' | 'y' | 'z' | [ <number> ]{3} ] && \
   <extended-angle>"]

module Property_row_gap =
  [%spec_module
  "property_row_gap", "'normal' | <extended-length> | <extended-percentage>"]

module Property_ruby_align =
  [%spec_module
  "property_ruby_align", "'start' | 'center' | 'space-between' | 'space-around'"]

module Property_ruby_merge =
  [%spec_module
  "property_ruby_merge", "'separate' | 'collapse' | 'auto'"]

module Property_ruby_position =
  [%spec_module
  "property_ruby_position", "'over' | 'under' | 'inter-character'"]

module Property_scale =
  [%spec_module
  "property_scale", "'none' | [ <number-percentage> ]{1,3}"]

module Property_scroll_behavior =
  [%spec_module
  "property_scroll_behavior", "'auto' | 'smooth'"]

module Property_scroll_margin =
  [%spec_module
  "property_scroll_margin", "[ <extended-length> ]{1,4}"]

module Property_scroll_margin_block =
  [%spec_module
  "property_scroll_margin_block", "[ <extended-length> ]{1,2}"]

module Property_scroll_margin_block_end =
  [%spec_module
  "property_scroll_margin_block_end", "<extended-length>"]

module Property_scroll_margin_block_start =
  [%spec_module
  "property_scroll_margin_block_start", "<extended-length>"]

module Property_scroll_margin_bottom =
  [%spec_module
  "property_scroll_margin_bottom", "<extended-length>"]

module Property_scroll_margin_inline =
  [%spec_module
  "property_scroll_margin_inline", "[ <extended-length> ]{1,2}"]

module Property_scroll_margin_inline_end =
  [%spec_module
  "property_scroll_margin_inline_end", "<extended-length>"]

module Property_scroll_margin_inline_start =
  [%spec_module
  "property_scroll_margin_inline_start", "<extended-length>"]

module Property_scroll_margin_left =
  [%spec_module
  "property_scroll_margin_left", "<extended-length>"]

module Property_scroll_margin_right =
  [%spec_module
  "property_scroll_margin_right", "<extended-length>"]

module Property_scroll_margin_top =
  [%spec_module
  "property_scroll_margin_top", "<extended-length>"]

module Property_scroll_padding =
  [%spec_module
  "property_scroll_padding",
  "[ 'auto' | <extended-length> | <extended-percentage> ]{1,4}"]

module Property_scroll_padding_block =
  [%spec_module
  "property_scroll_padding_block",
  "[ 'auto' | <extended-length> | <extended-percentage> ]{1,2}"]

module Property_scroll_padding_block_end =
  [%spec_module
  "property_scroll_padding_block_end",
  "'auto' | <extended-length> | <extended-percentage>"]

module Property_scroll_padding_block_start =
  [%spec_module
  "property_scroll_padding_block_start",
  "'auto' | <extended-length> | <extended-percentage>"]

module Property_scroll_padding_bottom =
  [%spec_module
  "property_scroll_padding_bottom",
  "'auto' | <extended-length> | <extended-percentage>"]

module Property_scroll_padding_inline =
  [%spec_module
  "property_scroll_padding_inline",
  "[ 'auto' | <extended-length> | <extended-percentage> ]{1,2}"]

module Property_scroll_padding_inline_end =
  [%spec_module
  "property_scroll_padding_inline_end",
  "'auto' | <extended-length> | <extended-percentage>"]

module Property_scroll_padding_inline_start =
  [%spec_module
  "property_scroll_padding_inline_start",
  "'auto' | <extended-length> | <extended-percentage>"]

module Property_scroll_padding_left =
  [%spec_module
  "property_scroll_padding_left",
  "'auto' | <extended-length> | <extended-percentage>"]

module Property_scroll_padding_right =
  [%spec_module
  "property_scroll_padding_right",
  "'auto' | <extended-length> | <extended-percentage>"]

module Property_scroll_padding_top =
  [%spec_module
  "property_scroll_padding_top",
  "'auto' | <extended-length> | <extended-percentage>"]

module Property_scroll_snap_align =
  [%spec_module
  "property_scroll_snap_align", "[ 'none' | 'start' | 'end' | 'center' ]{1,2}"]

module Property_scroll_snap_coordinate =
  [%spec_module
  "property_scroll_snap_coordinate", "'none' | [ <position> ]#"]

module Property_scroll_snap_destination =
  [%spec_module
  "property_scroll_snap_destination", "<position>"]

module Property_scroll_snap_points_x =
  [%spec_module
  "property_scroll_snap_points_x",
  "'none' | repeat( <extended-length> | <extended-percentage> )"]

module Property_scroll_snap_points_y =
  [%spec_module
  "property_scroll_snap_points_y",
  "'none' | repeat( <extended-length> | <extended-percentage> )"]

module Property_scroll_snap_stop =
  [%spec_module
  "property_scroll_snap_stop", "'normal' | 'always'"]

module Property_scroll_snap_type =
  [%spec_module
  "property_scroll_snap_type",
  "'none' | [ 'x' | 'y' | 'block' | 'inline' | 'both' ] [ 'mandatory' | \
   'proximity' ]?"]

module Property_scroll_snap_type_x =
  [%spec_module
  "property_scroll_snap_type_x", "'none' | 'mandatory' | 'proximity'"]

module Property_scroll_snap_type_y =
  [%spec_module
  "property_scroll_snap_type_y", "'none' | 'mandatory' | 'proximity'"]

module Property_scrollbar_color =
  [%spec_module
  "property_scrollbar_color", "'auto' | [ <color> <color> ]"]

module Property_scrollbar_width =
  [%spec_module
  "property_scrollbar_width", "'auto' | 'thin' | 'none'"]

module Property_scrollbar_gutter =
  [%spec_module
  "property_scrollbar_gutter", "'auto' | 'stable' && 'both-edges'?"]

module Property_scrollbar_3dlight_color =
  [%spec_module
  "property_scrollbar_3dlight_color", "<color>"]

module Property_scrollbar_arrow_color =
  [%spec_module
  "property_scrollbar_arrow_color", "<color>"]

module Property_scrollbar_base_color =
  [%spec_module
  "property_scrollbar_base_color", "<color>"]

module Property_scrollbar_darkshadow_color =
  [%spec_module
  "property_scrollbar_darkshadow_color", "<color>"]

module Property_scrollbar_face_color =
  [%spec_module
  "property_scrollbar_face_color", "<color>"]

module Property_scrollbar_highlight_color =
  [%spec_module
  "property_scrollbar_highlight_color", "<color>"]

module Property_scrollbar_shadow_color =
  [%spec_module
  "property_scrollbar_shadow_color", "<color>"]

module Property_scrollbar_track_color =
  [%spec_module
  "property_scrollbar_track_color", "<color>"]

module Property_shape_image_threshold =
  [%spec_module
  "property_shape_image_threshold", "<alpha-value>"]

module Property_shape_margin =
  [%spec_module
  "property_shape_margin", "<extended-length> | <extended-percentage>"]

module Property_shape_outside =
  [%spec_module
  "property_shape_outside", "'none' | <shape-box> || <basic-shape> | <image>"]

module Property_shape_rendering =
  [%spec_module
  "property_shape_rendering",
  "'auto' | 'optimizeSpeed' | 'crispEdges' | 'geometricPrecision'"]

module Property_speak =
  [%spec_module
  "property_speak", "'auto' | 'none' | 'normal'"]

module Property_speak_as =
  [%spec_module
  "property_speak_as",
  "'normal' | 'spell-out' || 'digits' || [ 'literal-punctuation' | \
   'no-punctuation' ]"]

module Property_src =
  [%spec_module
  "property_src",
  "[ <url> [ format( [ <string> ]# ) ]? | local( <family-name> ) ]#"]

module Property_stroke = [%spec_module "property_stroke", "<paint>"]

module Property_stroke_dasharray =
  [%spec_module
  "property_stroke_dasharray", "'none' | [ [ <svg-length> ]+ ]#"]

module Property_stroke_dashoffset =
  [%spec_module
  "property_stroke_dashoffset", "<svg-length>"]

module Property_stroke_linecap =
  [%spec_module
  "property_stroke_linecap", "'butt' | 'round' | 'square'"]

module Property_stroke_linejoin =
  [%spec_module
  "property_stroke_linejoin", "'miter' | 'round' | 'bevel'"]

module Property_stroke_miterlimit =
  [%spec_module
  "property_stroke_miterlimit", "<number-one-or-greater>"]

module Property_stroke_opacity =
  [%spec_module
  "property_stroke_opacity", "<alpha-value>"]

module Property_stroke_width =
  [%spec_module
  "property_stroke_width", "<svg-length>"]

module Property_tab_size =
  [%spec_module
  "property_tab_size", " <number> | <extended-length>"]

module Property_table_layout =
  [%spec_module
  "property_table_layout", "'auto' | 'fixed'"]

module Property_text_autospace =
  [%spec_module
  "property_text_autospace",
  "'none' | 'ideograph-alpha' | 'ideograph-numeric' | 'ideograph-parenthesis' \
   | 'ideograph-space'"]

module Property_text_blink =
  [%spec_module
  "property_text_blink", "'none' | 'blink' | 'blink-anywhere'"]

module Property_text_align =
  [%spec_module
  "property_text_align",
  "'start' | 'end' | 'left' | 'right' | 'center' | 'justify' | 'match-parent' \
   | 'justify-all'"]

module Property_text_align_all =
  [%spec_module
  "property_text_align_all",
  "'start' | 'end' | 'left' | 'right' | 'center' | 'justify' | 'match-parent'"]

module Property_text_align_last =
  [%spec_module
  "property_text_align_last",
  "'auto' | 'start' | 'end' | 'left' | 'right' | 'center' | 'justify' | \
   'match-parent'"]

module Property_text_anchor =
  [%spec_module
  "property_text_anchor", "'start' | 'middle' | 'end'"]

module Property_text_combine_upright =
  [%spec_module
  "property_text_combine_upright", "'none' | 'all' | 'digits' [ <integer> ]?"]

module Property_text_decoration =
  [%spec_module
  "property_text_decoration",
  "<'text-decoration-color'> || <'text-decoration-style'> || \
   <'text-decoration-thickness'> || <'text-decoration-line'>"]

module Property_text_justify_trim =
  [%spec_module
  "property_text_justify_trim", "'none' | 'all' | 'auto'"]

module Property_text_kashida =
  [%spec_module
  "property_text_kashida", "'none' | 'horizontal' | 'vertical' | 'both'"]

module Property_text_kashida_space =
  [%spec_module
  "property_text_kashida_space", "'normal' | 'pre' | 'post'"]

module Property_text_decoration_color =
  [%spec_module
  "property_text_decoration_color", "<color>"]

(* Spec doesn't contain spelling-error module grammar-error: https://developer.mozilla.org/en-US/docs/Web/CSS/text-decoration-line but this list used to have them | 'spelling-error' | 'grammar-error'. Leaving this comment here for reference *)
(* module this definition has changed from the origianl, it might be a bug on the spec or our Generator,
   but simplifying to "|" simplifies it module solves the bug *)
module Property_text_decoration_line =
  [%spec_module
  "property_text_decoration_line",
  "'none' | <interpolation> | [ 'underline' || 'overline' || 'line-through' || \
   'blink' ]"]

module Property_text_decoration_skip =
  [%spec_module
  "property_text_decoration_skip",
  "'none' | 'objects' || [ 'spaces' | 'leading-spaces' || 'trailing-spaces' ] \
   || 'edges' || 'box-decoration'"]

module Property_text_decoration_skip_self =
  [%spec_module
  "property_text_decoration_skip_self",
  "'none' | 'objects' || [ 'spaces' | 'leading-spaces' || 'trailing-spaces' ] \
   || 'edges' || 'box-decoration'"]

module Property_text_decoration_skip_ink =
  [%spec_module
  "property_text_decoration_skip_ink", "'auto' | 'all' | 'none'"]

module Property_text_decoration_skip_box =
  [%spec_module
  "property_text_decoration_skip_box", "'none' | 'all'"]

module Property_text_decoration_skip_spaces =
  [%spec_module
  "property_text_decoration_skip_spaces",
  "'none' | 'objects' || [ 'spaces' | 'leading-spaces' || 'trailing-spaces' ] \
   || 'edges' || 'box-decoration'"]

module Property_text_decoration_skip_inset =
  [%spec_module
  "property_text_decoration_skip_inset", "'none' | 'auto'"]

module Property_text_decoration_style =
  [%spec_module
  "property_text_decoration_style",
  "'solid' | 'double' | 'dotted' | 'dashed' | 'wavy'"]

module Property_text_decoration_thickness =
  [%spec_module
  "property_text_decoration_thickness",
  "'auto' | 'from-font' | <extended-length> | <extended-percentage>"]

module Property_text_emphasis =
  [%spec_module
  "property_text_emphasis", "<'text-emphasis-style'> || <'text-emphasis-color'>"]

module Property_text_emphasis_color =
  [%spec_module
  "property_text_emphasis_color", "<color>"]

module Property_text_emphasis_position =
  [%spec_module
  "property_text_emphasis_position",
  "[ 'over' | 'under' ] && [ 'right' | 'left' ]?"]

module Property_text_emphasis_style =
  [%spec_module
  "property_text_emphasis_style",
  "'none' | [ 'filled' | 'open' ] || [ 'dot' | 'circle' | 'double-circle' | \
   'triangle' | 'sesame' ] | <string>"]

module Property_text_indent =
  [%spec_module
  "property_text_indent",
  "[<extended-length> | <extended-percentage>] && [ 'hanging' ]? && [ \
   'each-line' ]?"]

module Property_text_justify =
  [%spec_module
  "property_text_justify", "'auto' | 'inter-character' | 'inter-word' | 'none'"]

module Property_text_orientation =
  [%spec_module
  "property_text_orientation", "'mixed' | 'upright' | 'sideways'"]

module Property_text_overflow =
  [%spec_module
  "property_text_overflow", "[ 'clip' | 'ellipsis' | <string> ]{1,2}"]

module Property_text_rendering =
  [%spec_module
  "property_text_rendering",
  "'auto' | 'optimizeSpeed' | 'optimizeLegibility' | 'geometricPrecision'"]

module Property_text_shadow =
  [%spec_module
  "property_text_shadow", "'none' | <interpolation> | [ <shadow-t> ]#"]

module Property_text_size_adjust =
  [%spec_module
  "property_text_size_adjust", "'none' | 'auto' | <extended-percentage>"]

module Property_text_transform =
  [%spec_module
  "property_text_transform",
  "'none' | 'capitalize' | 'uppercase' | 'lowercase' | 'full-width' | \
   'full-size-kana'"]

module Property_text_underline_offset =
  [%spec_module
  "property_text_underline_offset",
  "'auto' | <extended-length> | <extended-percentage>"]

module Property_text_underline_position =
  [%spec_module
  "property_text_underline_position",
  "'auto' | 'from-font' | 'under' || [ 'left' | 'right' ]"]

module Property_top =
  [%spec_module
  "property_top", "<extended-length> | <extended-percentage> | 'auto'"]

module Property_touch_action =
  [%spec_module
  "property_touch_action",
  "'auto' | 'none' | [ 'pan-x' | 'pan-left' | 'pan-right' ] || [ 'pan-y' | \
   'pan-up' | 'pan-down' ] || 'pinch-zoom' | 'manipulation'"]

module Property_transform =
  [%spec_module
  "property_transform", "'none' | <transform-list>"]

module Property_transform_box =
  [%spec_module
  "property_transform_box",
  "'content-box' | 'border-box' | 'fill-box' | 'stroke-box' | 'view-box'"]

module Property_transform_origin =
  [%spec_module
  "property_transform_origin",
  "[ 'left' | 'center' | 'right' | 'top' | 'bottom' | <length-percentage> ] | \
   [ 'left' | 'center' | 'right' | <length-percentage> ] [ 'top' | 'center' | \
   'bottom' | <length-percentage> ] <length>? | [[ 'center' | 'left' | 'right' \
   ] && [ 'center' | 'top' | 'bottom' ]] <length>? "]

module Property_transform_style =
  [%spec_module
  "property_transform_style", "'flat' | 'preserve-3d'"]

module Property_transition =
  [%spec_module
  "property_transition",
  "[ <single-transition> | <single-transition-no-interp> ]#"]

module Property_transition_behavior =
  [%spec_module
  "property_transition_behavior", "<transition-behavior-value>#"]

module Property_transition_delay =
  [%spec_module
  "property_transition_delay", "[ <extended-time> ]#"]

module Property_transition_duration =
  [%spec_module
  "property_transition_duration", "[ <extended-time> ]#"]

module Property_transition_property =
  [%spec_module
  "property_transition_property", "[ <single-transition-property> ]# | 'none'"]

module Property_transition_timing_function =
  [%spec_module
  "property_transition_timing_function", "[ <timing-function> ]#"]

module Property_translate =
  [%spec_module
  "property_translate",
  "'none' | <length-percentage> [ <length-percentage> <length>? ]?"]

module Property_unicode_bidi =
  [%spec_module
  "property_unicode_bidi",
  "'normal' | 'embed' | 'isolate' | 'bidi-override' | 'isolate-override' | \
   'plaintext' | '-moz-isolate' | '-moz-isolate-override' | '-moz-plaintext' | \
   '-webkit-isolate'"]

module Property_unicode_range =
  [%spec_module
  "property_unicode_range", "[ <urange> ]#"]

module Property_user_select =
  [%spec_module
  "property_user_select",
  "'auto' | 'text' | 'none' | 'contain' | 'all' | <interpolation>"]

module Property_vertical_align =
  [%spec_module
  "property_vertical_align",
  "'baseline' | 'sub' | 'super' | 'text-top' | 'text-bottom' | 'middle' | \
   'top' | 'bottom' | <extended-percentage> | <extended-length>"]

module Property_visibility =
  [%spec_module
  "property_visibility", "'visible' | 'hidden' | 'collapse' | <interpolation>"]

module Property_voice_balance =
  [%spec_module
  "property_voice_balance",
  "<number> | 'left' | 'center' | 'right' | 'leftwards' | 'rightwards'"]

module Property_voice_duration =
  [%spec_module
  "property_voice_duration", "'auto' | <extended-time>"]

module Property_voice_family =
  [%spec_module
  "property_voice_family",
  "[ [ <family-name> | <generic-voice> ] ',' ]* [ <family-name> | \
   <generic-voice> ] | 'preserve'"]

module Property_voice_pitch =
  [%spec_module
  "property_voice_pitch",
  "<extended-frequency> && 'absolute' | [ 'x-low' | 'low' | 'medium' | 'high' \
   | 'x-high' ] || [ <extended-frequency> | <semitones> | \
   <extended-percentage> ]"]

module Property_voice_range =
  [%spec_module
  "property_voice_range",
  "<extended-frequency> && 'absolute' | [ 'x-low' | 'low' | 'medium' | 'high' \
   | 'x-high' ] || [ <extended-frequency> | <semitones> | \
   <extended-percentage> ]"]

module Property_voice_rate =
  [%spec_module
  "property_voice_rate",
  "[ 'normal' | 'x-slow' | 'slow' | 'medium' | 'fast' | 'x-fast' ] || \
   <extended-percentage>"]

module Property_voice_stress =
  [%spec_module
  "property_voice_stress",
  "'normal' | 'strong' | 'moderate' | 'none' | 'reduced'"]

module Property_voice_volume =
  [%spec_module
  "property_voice_volume",
  "'silent' | [ 'x-soft' | 'soft' | 'medium' | 'loud' | 'x-loud' ] || <decibel>"]

module Property_white_space =
  [%spec_module
  "property_white_space",
  "'normal' | 'pre' | 'nowrap' | 'pre-wrap' | 'pre-line' | 'break-spaces'"]

module Property_widows = [%spec_module "property_widows", "<integer>"]

module Property_width =
  [%spec_module
  "property_width",
  "'auto' | <extended-length> | <extended-percentage> | 'min-content' | \
   'max-content' | 'fit-content' | fit-content( <extended-length> | \
   <extended-percentage> )"]

module Property_will_change =
  [%spec_module
  "property_will_change", "'auto' | [ <animateable-feature> ]#"]

module Property_word_break =
  [%spec_module
  "property_word_break", "'normal' | 'break-all' | 'keep-all' | 'break-word'"]

module Property_word_spacing =
  [%spec_module
  "property_word_spacing",
  "'normal' | <extended-length> | <extended-percentage>"]

module Property_word_wrap =
  [%spec_module
  "property_word_wrap", "'normal' | 'break-word' | 'anywhere'"]

module Property_writing_mode =
  [%spec_module
  "property_writing_mode",
  "'horizontal-tb' | 'vertical-rl' | 'vertical-lr' | 'sideways-rl' | \
   'sideways-lr' | <svg-writing-mode>"]

module Property_z_index =
  [%spec_module
  "property_z_index", "'auto' | <integer> | <interpolation>"]

module Property_zoom =
  [%spec_module
  "property_zoom", "'normal' | 'reset' | <number> | <extended-percentage>"]

module Property_container =
  [%spec_module
  "property_container", "<'container-name'> [ '/' <'container-type'> ]?"]

module Property_container_name =
  [%spec_module
  "property_container_name", "<custom-ident>+ | 'none'"]

module Property_container_type =
  [%spec_module
  "property_container_type", "'normal' | 'size' | 'inline-size'"]

module Property_nav_down =
  [%spec_module
  "property_nav_down", "'auto' | <integer> | <interpolation>"]

module Property_nav_left =
  [%spec_module
  "property_nav_left", "'auto' | <integer> | <interpolation>"]

module Property_nav_right =
  [%spec_module
  "property_nav_right", "'auto' | <integer> | <interpolation>"]

module Property_nav_up =
  [%spec_module
  "property_nav_up", "'auto' | <integer> | <interpolation>"]

module Property_accent_color =
  [%spec_module
  "property_accent_color", "'auto' | <color>"]

module Property_animation_composition =
  [%spec_module
  "property_animation_composition", "[ 'replace' | 'add' | 'accumulate' ]#"]

module Property_animation_range =
  [%spec_module
  "property_animation_range",
  "[ 'normal' | <extended-length> | <extended-percentage> ]{1,2}"]

module Property_animation_range_end =
  [%spec_module
  "property_animation_range_end",
  "'normal' | <extended-length> | <extended-percentage>"]

module Property_animation_range_start =
  [%spec_module
  "property_animation_range_start",
  "'normal' | <extended-length> | <extended-percentage>"]

module Property_animation_timeline =
  [%spec_module
  "property_animation_timeline", "[ 'none' | <custom-ident> ]#"]

module Property_field_sizing =
  [%spec_module
  "property_field_sizing", "'content' | 'fixed'"]

module Property_interpolate_size =
  [%spec_module
  "property_interpolate_size", "'numeric-only' | 'allow-keywords'"]

module Property_media_type = [%spec_module "property_media_type", "<ident>"]
module Property_overlay = [%spec_module "property_overlay", "'none' | 'auto'"]

module Property_scroll_timeline =
  [%spec_module
  "property_scroll_timeline",
  "[ 'none' | <custom-ident> ]# [ 'block' | 'inline' | 'x' | 'y' ]#"]

module Property_scroll_timeline_axis =
  [%spec_module
  "property_scroll_timeline_axis", "[ 'block' | 'inline' | 'x' | 'y' ]#"]

module Property_scroll_timeline_name =
  [%spec_module
  "property_scroll_timeline_name", "[ 'none' | <custom-ident> ]#"]

module Property_text_wrap =
  [%spec_module
  "property_text_wrap", "'wrap' | 'nowrap' | 'balance' | 'stable' | 'pretty'"]

module Property_view_timeline =
  [%spec_module
  "property_view_timeline",
  "[ 'none' | <custom-ident> ]# [ 'block' | 'inline' | 'x' | 'y' ]#"]

module Property_view_timeline_axis =
  [%spec_module
  "property_view_timeline_axis", "[ 'block' | 'inline' | 'x' | 'y' ]#"]

module Property_view_timeline_inset =
  [%spec_module
  "property_view_timeline_inset",
  "[ 'auto' | <extended-length> | <extended-percentage> ]{1,2}"]

module Property_view_timeline_name =
  [%spec_module
  "property_view_timeline_name", "[ 'none' | <custom-ident> ]#"]

module Property_view_transition_name =
  [%spec_module
  "property_view_transition_name", "'none' | <custom-ident>"]

module Property_anchor_name =
  [%spec_module
  "property_anchor_name", "'none' | [ <dashed-ident> ]#"]

module Property_anchor_scope =
  [%spec_module
  "property_anchor_scope", "'none' | 'all' | [ <dashed-ident> ]#"]

module Property_position_anchor =
  [%spec_module
  "property_position_anchor", "'auto' | <dashed-ident>"]

module Property_position_area =
  [%spec_module
  "property_position_area",
  "'none' | [ 'top' | 'bottom' | 'left' | 'right' | 'center' | 'self-start' | \
   'self-end' | 'start' | 'end' ]"]

module Property_position_try =
  [%spec_module
  "property_position_try", "'none' | [ <dashed-ident> | <try-tactic> ]#"]

module Property_position_try_fallbacks =
  [%spec_module
  "property_position_try_fallbacks",
  "'none' | [ <dashed-ident> | <try-tactic> ]#"]

module Property_position_try_options =
  [%spec_module
  "property_position_try_options",
  "'none' | [ 'flip-block' || 'flip-inline' || 'flip-start' ]"]

module Property_position_visibility =
  [%spec_module
  "property_position_visibility",
  "'always' | 'anchors-valid' | 'anchors-visible' | 'no-overflow'"]

module Property_inset_area =
  [%spec_module
  "property_inset_area",
  "'none' | [ 'top' | 'bottom' | 'left' | 'right' | 'center' | 'self-start' | \
   'self-end' | 'start' | 'end' ]{1,2}"]

module Property_scroll_start =
  [%spec_module
  "property_scroll_start",
  "'auto' | 'start' | 'end' | 'center' | 'top' | 'bottom' | 'left' | 'right' | \
   <extended-length> | <extended-percentage>"]

module Property_scroll_start_block =
  [%spec_module
  "property_scroll_start_block",
  "'auto' | 'start' | 'end' | 'center' | <extended-length> | \
   <extended-percentage>"]

module Property_scroll_start_inline =
  [%spec_module
  "property_scroll_start_inline",
  "'auto' | 'start' | 'end' | 'center' | <extended-length> | \
   <extended-percentage>"]

module Property_scroll_start_x =
  [%spec_module
  "property_scroll_start_x",
  "'auto' | 'start' | 'end' | 'center' | <extended-length> | \
   <extended-percentage>"]

module Property_scroll_start_y =
  [%spec_module
  "property_scroll_start_y",
  "'auto' | 'start' | 'end' | 'center' | <extended-length> | \
   <extended-percentage>"]

module Property_scroll_start_target =
  [%spec_module
  "property_scroll_start_target", "'none' | 'auto'"]

module Property_scroll_start_target_block =
  [%spec_module
  "property_scroll_start_target_block", "'none' | 'auto'"]

module Property_scroll_start_target_inline =
  [%spec_module
  "property_scroll_start_target_inline", "'none' | 'auto'"]

module Property_scroll_start_target_x =
  [%spec_module
  "property_scroll_start_target_x", "'none' | 'auto'"]

module Property_scroll_start_target_y =
  [%spec_module
  "property_scroll_start_target_y", "'none' | 'auto'"]

module Property_text_spacing_trim =
  [%spec_module
  "property_text_spacing_trim",
  "'normal' | 'space-all' | 'space-first' | 'trim-start'"]

module Property_word_space_transform =
  [%spec_module
  "property_word_space_transform",
  "'none' | 'auto' | 'ideograph-alpha' | 'ideograph-numeric'"]

module Property_reading_flow =
  [%spec_module
  "property_reading_flow",
  "'normal' | 'flex-visual' | 'flex-flow' | 'grid-rows' | 'grid-columns' | \
   'grid-order'"]

module Property_math_depth =
  [%spec_module
  "property_math_depth", "'auto-add' | 'add(' <integer> ')' | <integer>"]

module Property_math_shift =
  [%spec_module
  "property_math_shift", "'normal' | 'compact'"]

module Property_math_style =
  [%spec_module
  "property_math_style", "'normal' | 'compact'"]

module Property_text_wrap_mode =
  [%spec_module
  "property_text_wrap_mode", "'wrap' | 'nowrap'"]

module Property_text_wrap_style =
  [%spec_module
  "property_text_wrap_style", "'auto' | 'balance' | 'stable' | 'pretty'"]

module Property_white_space_collapse =
  [%spec_module
  "property_white_space_collapse",
  "'collapse' | 'preserve' | 'preserve-breaks' | 'preserve-spaces' | \
   'break-spaces'"]

module Property_text_box_trim =
  [%spec_module
  "property_text_box_trim", "'none' | 'trim-start' | 'trim-end' | 'trim-both'"]

module Property_text_box_edge =
  [%spec_module
  "property_text_box_edge", "'leading' | 'text' | 'cap' | 'ex' | 'alphabetic'"]

(* Print module paged media properties *)
module Property_page = [%spec_module "property_page", "'auto' | <custom-ident>"]

module Property_size =
  [%spec_module
  "property_size",
  "<extended-length>{1,2} | 'auto' | [ 'A5' | 'A4' | 'A3' | 'B5' | 'B4' | \
   'JIS-B5' | 'JIS-B4' | 'letter' | 'legal' | 'ledger' ] [ 'portrait' | \
   'landscape' ]?"]

module Property_marks =
  [%spec_module
  "property_marks", "'none' | 'crop' || 'cross'"]

module Property_bleed =
  [%spec_module
  "property_bleed", "'auto' | <extended-length>"]

(* More modern layout module effect properties *)
module Property_backdrop_blur =
  [%spec_module
  "property_backdrop_blur", "<extended-length>"]

module Property_scrollbar_color_legacy =
  [%spec_module
  "property_scrollbar_color_legacy", "<color>"]

(* SVG paint server properties *)
module Property_stop_color = [%spec_module "property_stop_color", "<color>"]

module Property_stop_opacity =
  [%spec_module
  "property_stop_opacity", "<alpha-value>"]

module Property_flood_color = [%spec_module "property_flood_color", "<color>"]

module Property_flood_opacity =
  [%spec_module
  "property_flood_opacity", "<alpha-value>"]

module Property_lighting_color =
  [%spec_module
  "property_lighting_color", "<color>"]

module Property_color_rendering =
  [%spec_module
  "property_color_rendering", "'auto' | 'optimizeSpeed' | 'optimizeQuality'"]

module Property_vector_effect =
  [%spec_module
  "property_vector_effect", "'none' | 'non-scaling-stroke'"]

(* SVG geometry properties *)
module Property_cx =
  [%spec_module
  "property_cx", "<extended-length> | <extended-percentage>"]

module Property_cy =
  [%spec_module
  "property_cy", "<extended-length> | <extended-percentage>"]

module Property_d = [%spec_module "property_d", "'none' | <string>"]

module Property_r =
  [%spec_module
  "property_r", "<extended-length> | <extended-percentage>"]

module Property_rx =
  [%spec_module
  "property_rx", "'auto' | <extended-length> | <extended-percentage>"]

module Property_ry =
  [%spec_module
  "property_ry", "'auto' | <extended-length> | <extended-percentage>"]

module Property_x =
  [%spec_module
  "property_x", "<extended-length> | <extended-percentage>"]

module Property_y =
  [%spec_module
  "property_y", "<extended-length> | <extended-percentage>"]

(* Contain intrinsic sizing *)
module Property_contain_intrinsic_size =
  [%spec_module
  "property_contain_intrinsic_size",
  "'none' | [ 'auto' ]? <extended-length>{1,2}"]

module Property_contain_intrinsic_width =
  [%spec_module
  "property_contain_intrinsic_width",
  "'none' | 'auto' <extended-length> | <extended-length>"]

module Property_contain_intrinsic_height =
  [%spec_module
  "property_contain_intrinsic_height",
  "'none' | 'auto' <extended-length> | <extended-length>"]

module Property_contain_intrinsic_block_size =
  [%spec_module
  "property_contain_intrinsic_block_size",
  "'none' | 'auto' <extended-length> | <extended-length>"]

module Property_contain_intrinsic_inline_size =
  [%spec_module
  "property_contain_intrinsic_inline_size",
  "'none' | 'auto' <extended-length> | <extended-length>"]

(* Print *)
module Property_print_color_adjust =
  [%spec_module
  "property_print_color_adjust", "'economy' | 'exact'"]

(* Ruby *)
module Property_ruby_overhang =
  [%spec_module
  "property_ruby_overhang", "'auto' | 'none'"]

(* Timeline scope *)
module Property_timeline_scope =
  [%spec_module
  "property_timeline_scope", "[ 'none' | <custom-ident> | <dashed-ident> ]#"]

(* Scroll driven animations *)
module Property_animation_delay_end =
  [%spec_module
  "property_animation_delay_end", "[ <extended-time> ]#"]

module Property_animation_delay_start =
  [%spec_module
  "property_animation_delay_start", "[ <extended-time> ]#"]

(* Custom properties for at-rules *)
module Property_syntax = [%spec_module "property_syntax", "<string>"]

module Property_inherits =
  [%spec_module
  "property_inherits", "'true' | 'false'"]

module Property_initial_value =
  [%spec_module
  "property_initial_value", "<string>"]

(* Additional modern properties *)
module Property_scroll_marker_group =
  [%spec_module
  "property_scroll_marker_group", "'none' | 'before' | 'after'"]

module Property_container_name_computed =
  [%spec_module
  "property_container_name_computed", "'none' | [ <custom-ident> ]#"]

module Property_text_edge =
  [%spec_module
  "property_text_edge", "[ 'leading' | <'text-box-edge'> ]{1,2}"]

module Property_hyphenate_limit_last =
  [%spec_module
  "property_hyphenate_limit_last",
  "'none' | 'always' | 'column' | 'page' | 'spread'"]

module Pseudo_class_selector =
  [%spec_module
  "pseudo_class_selector",
  "':' <ident-token> | ':' <function-token> <any-value> ')'"]

module Pseudo_element_selector =
  [%spec_module
  "pseudo_element_selector", "':' <pseudo-class-selector>"]

module Pseudo_page =
  [%spec_module
  "pseudo_page", "':' [ 'left' | 'right' | 'first' | 'blank' ]"]

module Quote =
  [%spec_module
  "quote", "'open-quote' | 'close-quote' | 'no-open-quote' | 'no-close-quote'"]

module Ratio =
  [%spec_module
  "ratio", "<integer> '/' <integer> | <number> | <interpolation>"]

module Relative_selector =
  [%spec_module
  "relative_selector", "[ <combinator> ]? <complex-selector>"]

module Relative_selector_list =
  [%spec_module
  "relative_selector_list", "[ <relative-selector> ]#"]

module Relative_size = [%spec_module "relative_size", "'larger' | 'smaller'"]

module Repeat_style =
  [%spec_module
  "repeat_style",
  "'repeat-x' | 'repeat-y' | [ 'repeat' | 'space' | 'round' | 'no-repeat' ] [ \
   'repeat' | 'space' | 'round' | 'no-repeat' ]?"]

module Right = [%spec_module "right", "<extended-length> | 'auto'"]

module Self_position =
  [%spec_module
  "self_position",
  "'center' | 'start' | 'end' | 'self-start' | 'self-end' | 'flex-start' | \
   'flex-end'"]

module Shadow =
  [%spec_module
  "shadow",
  "[ 'inset' ]? [ <extended-length> | <interpolation> ]{4} [ <color> | \
   <interpolation> ]?"]

module Shadow_t =
  [%spec_module
  "shadow_t",
  "[ <extended-length> | <interpolation> ]{3} [ <color> | <interpolation> ]?"]

module Shape =
  [%spec_module
  "shape",
  "rect( <top> ',' <right> ',' <bottom> ',' <left> ) | rect( <top> <right> \
   <bottom> <left> )"]

module Shape_box = [%spec_module "shape_box", "<box> | 'margin-box'"]

module Shape_radius =
  [%spec_module
  "shape_radius",
  "<extended-length> | <extended-percentage> | 'closest-side' | 'farthest-side'"]

module Side_or_corner =
  [%spec_module
  "side_or_corner", "[ 'left' | 'right' ] || [ 'top' | 'bottom' ]"]

module Single_animation =
  [%spec_module
  "single_animation",
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
   <single-animation-play-state> ]"]

module Single_animation_no_interp =
  [%spec_module
  "single_animation_no_interp",
  "[ <keyframes-name> | 'none' ] || <extended-time-no-interp> || \
   <timing-function-no-interp> || <extended-time-no-interp> || \
   <single-animation-iteration-count-no-interp> || \
   <single-animation-direction-no-interp> || \
   <single-animation-fill-mode-no-interp> || \
   <single-animation-play-state-no-interp>"]

module Single_animation_direction =
  [%spec_module
  "single_animation_direction",
  "'normal' | 'reverse' | 'alternate' | 'alternate-reverse' | <interpolation>"]

module Single_animation_direction_no_interp =
  [%spec_module
  "single_animation_direction_no_interp",
  "'normal' | 'reverse' | 'alternate' | 'alternate-reverse'"]

module Single_animation_fill_mode =
  [%spec_module
  "single_animation_fill_mode",
  "'none' | 'forwards' | 'backwards' | 'both' | <interpolation>"]

module Single_animation_fill_mode_no_interp =
  [%spec_module
  "single_animation_fill_mode_no_interp",
  "'none' | 'forwards' | 'backwards' | 'both'"]

module Single_animation_iteration_count =
  [%spec_module
  "single_animation_iteration_count", "'infinite' | <number> | <interpolation>"]

module Single_animation_iteration_count_no_interp =
  [%spec_module
  "single_animation_iteration_count_no_interp", "'infinite' | <number>"]

module Single_animation_play_state =
  [%spec_module
  "single_animation_play_state", "'running' | 'paused' | <interpolation>"]

module Single_animation_play_state_no_interp =
  [%spec_module
  "single_animation_play_state_no_interp", "'running' | 'paused'"]

module Single_transition_no_interp =
  [%spec_module
  "single_transition_no_interp",
  "[ <single-transition-property-no-interp> | 'none' ] || \
   <extended-time-no-interp> || <timing-function-no-interp> || \
   <extended-time-no-interp> || <transition-behavior-value-no-interp>"]

module Single_transition =
  [%spec_module
  "single_transition",
  "[<single-transition-property> | 'none'] | [ [<single-transition-property> | \
   'none'] <extended-time> ] | [ [<single-transition-property> | 'none'] \
   <extended-time> <timing-function> ] | [ [<single-transition-property> | \
   'none'] <extended-time> <timing-function> <extended-time> ] | [ \
   [<single-transition-property> | 'none'] <extended-time> <timing-function> \
   <extended-time> <transition-behavior-value> ]"]

module Single_transition_property =
  [%spec_module
  "single_transition_property", "<custom-ident> | <interpolation> | 'all'"]

module Single_transition_property_no_interp =
  [%spec_module
  "single_transition_property_no_interp", "<custom-ident> | 'all'"]

module Size =
  [%spec_module
  "size",
  "'closest-side' | 'farthest-side' | 'closest-corner' | 'farthest-corner' | \
   <extended-length> | [ <extended-length> | <extended-percentage> ]{2}"]

module Ray_size =
  [%spec_module
  "ray_size",
  "'closest-side' | 'farthest-side' | 'closest-corner' | 'farthest-corner' | \
   'sides'"]

module Radial_size =
  [%spec_module
  "radial_size",
  "'closest-side' | 'farthest-side' | 'closest-corner' | 'farthest-corner' | \
   <extended-length> | [ <extended-length> | <extended-percentage> ]{2}"]

module Step_position =
  [%spec_module
  "step_position",
  "'jump-start' | 'jump-end' | 'jump-none' | 'jump-both' | 'start' | 'end'"]

module Step_timing_function =
  [%spec_module
  "step_timing_function",
  "'step-start' | 'step-end' | steps( <integer> [ ',' <step-position> ]? )"]

module Subclass_selector =
  [%spec_module
  "subclass_selector",
  "<id-selector> | <class-selector> | <attribute-selector> | \
   <pseudo-class-selector>"]

module Supports_condition =
  [%spec_module
  "supports_condition",
  "'not' <supports-in-parens> | <supports-in-parens> [ 'and' \
   <supports-in-parens> ]* | <supports-in-parens> [ 'or' <supports-in-parens> \
   ]*"]

module Supports_decl = [%spec_module "supports_decl", "'(' <declaration> ')'"]

module Supports_feature =
  [%spec_module
  "supports_feature", "<supports-decl> | <supports-selector-fn>"]

module Supports_in_parens =
  [%spec_module
  "supports_in_parens", "'(' <supports-condition> ')' | <supports-feature>"]

module Supports_selector_fn =
  [%spec_module
  "supports_selector_fn", "selector( <complex-selector> )"]

module Svg_length =
  [%spec_module
  "svg_length", "<extended-percentage> | <extended-length> | <number>"]

module Svg_writing_mode =
  [%spec_module
  "svg_writing_mode", "'lr-tb' | 'rl-tb' | 'tb-rl' | 'lr' | 'rl' | 'tb'"]

module Symbol = [%spec_module "symbol", "<string> | <image> | <custom-ident>"]

module Symbols_type =
  [%spec_module
  "symbols_type", "'cyclic' | 'numeric' | 'alphabetic' | 'symbolic' | 'fixed'"]

module Target =
  [%spec_module
  "target", "<target-counter()> | <target-counters()> | <target-text()>"]

module Url = [%spec_module "url", "<url-no-interp> | url( <interpolation> )"]

(* https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/Values/length-percentage#use_in_calc *)
module Extended_length =
  [%spec_module
  "extended_length", "<length> | <calc()> | <interpolation> | <min()> | <max()>"]

(* https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/Values/length-percentage#use_in_calc *)
module Length_percentage =
  [%spec_module
  "length_percentage", "<extended-length> | <extended-percentage>"]

module Extended_frequency =
  [%spec_module
  "extended_frequency",
  "<frequency> | <calc()> | <interpolation> | <min()> | <max()>"]

module Extended_angle =
  [%spec_module
  "extended_angle", "<angle> | <calc()> | <interpolation> | <min()> | <max()>"]

module Extended_time =
  [%spec_module
  "extended_time", "<time> | <calc()> | <interpolation> | <min()> | <max()>"]

module Extended_time_no_interp =
  [%spec_module
  "extended_time_no_interp", "<time> | <calc()> | <min()> | <max()>"]

module Extended_percentage =
  [%spec_module
  "extended_percentage",
  "<percentage> | <calc()> | <interpolation> | <min()> | <max()> "]

module Timing_function =
  [%spec_module
  "timing_function",
  "'linear' | <cubic-bezier-timing-function> | <step-timing-function> | \
   <interpolation>"]

module Timing_function_no_interp =
  [%spec_module
  "timing_function_no_interp",
  "'linear' | <cubic-bezier-timing-function> | <step-timing-function>"]

module Top = [%spec_module "top", "<extended-length> | 'auto'"]

module Try_tactic =
  [%spec_module
  "try_tactic", "'flip-block' | 'flip-inline' | 'flip-start'"]

module Track_breadth =
  [%spec_module
  "track_breadth",
  "<extended-length> | <extended-percentage> | <flex-value> | 'min-content' | \
   'max-content' | 'auto'"]

module Track_group =
  [%spec_module
  "track_group",
  "'(' [ [ <string> ]* <track-minmax> [ <string> ]* ]+ ')' [ '[' \
   <positive-integer> ']' ]? | <track-minmax>"]

module Track_list =
  [%spec_module
  "track_list",
  "[ [ <line-names> ]? [ <track-size> | <track-repeat> ] ]+ [ <line-names> ]?"]

module Track_list_v0 =
  [%spec_module
  "track_list_v0", "[ [ <string> ]* <track-group> [ <string> ]* ]+ | 'none'"]

module Track_minmax =
  [%spec_module
  "track_minmax",
  "minmax( <track-breadth> ',' <track-breadth> ) | 'auto' | <track-breadth> | \
   fit-content( <extended-length> | <extended-percentage> )"]

module Track_repeat =
  [%spec_module
  "track_repeat",
  "repeat( <positive-integer> ',' [ [ <line-names> ]? <track-size> ]+ [ \
   <line-names> ]? )"]

module Track_size =
  [%spec_module
  "track_size",
  "<track-breadth> | minmax( <inflexible-breadth> ',' <track-breadth> ) | \
   fit-content( <extended-length> | <extended-percentage> )"]

module Transform_function =
  [%spec_module
  "transform_function",
  "<matrix()> | <translate()> | <translateX()> | <translateY()> | <scale()> | \
   <scaleX()> | <scaleY()> | <rotate()> | <skew()> | <skewX()> | <skewY()> | \
   <matrix3d()> | <translate3d()> | <translateZ()> | <scale3d()> | <scaleZ()> \
   | <rotate3d()> | <rotateX()> | <rotateY()> | <rotateZ()> | <perspective()>"]

module Transform_list =
  [%spec_module
  "transform_list", "[ <transform-function> ]+"]

module Transition_behavior_value =
  [%spec_module
  "transition_behavior_value", "'normal' | 'allow-discrete' | <interpolation>"]

module Transition_behavior_value_no_interp =
  [%spec_module
  "transition_behavior_value_no_interp", "'normal' | 'allow-discrete'"]

module Type_or_unit =
  [%spec_module
  "type_or_unit",
  "'string' | 'color' | 'url' | 'integer' | 'number' | 'length' | 'angle' | \
   'time' | 'frequency' | 'cap' | 'ch' | 'em' | 'ex' | 'ic' | 'lh' | 'rlh' | \
   'rem' | 'vb' | 'vi' | 'vw' | 'vh' | 'vmin' | 'vmax' | 'mm' | 'Q' | 'cm' | \
   'in' | 'pt' | 'pc' | 'px' | 'deg' | 'grad' | 'rad' | 'turn' | 'ms' | 's' | \
   'Hz' | 'kHz' | '%'"]

module Type_selector =
  [%spec_module
  "type_selector", "<wq-name> | [ <ns-prefix> ]? '*'"]

module Viewport_length =
  [%spec_module
  "viewport_length", "'auto' | <extended-length> | <extended-percentage>"]

module Visual_box =
  [%spec_module
  "visual_box", "'content-box' | 'padding-box' | 'border-box'"]

module Wq_name = [%spec_module "wq_name", "[ <ns-prefix> ]? <ident-token>"]

module Attr_name =
  [%spec_module
  "attr_name", "[ <ident-token>? '|' ]? <ident-token>"]

module Attr_unit =
  [%spec_module
  "attr_unit",
  "'%' | 'em' | 'ex' | 'ch' | 'rem' | 'vw' | 'vh' | 'vmin' | 'vmax' | 'cm' | \
   'mm' | 'in' | 'px' | 'pt' | 'pc' | 'deg' | 'grad' | 'rad' | 'turn' | 'ms' | \
   's' | 'Hz' | 'kHz'"]

module Syntax_type_name =
  [%spec_module
  "syntax_type_name",
  "'angle' | 'color' | 'custom-ident' | 'image' | 'integer' | 'length' | \
   'length-percentage' | 'number' | 'percentage' | 'resolution' | 'string' | \
   'time' | 'url' | 'transform-function'"]

module Syntax_multiplier = [%spec_module "syntax_multiplier", "'#' | '+'"]

module Syntax_single_component =
  [%spec_module
  "syntax_single_component", "'<' <syntax-type-name> '>' | <ident>"]

module Syntax_string = [%spec_module "syntax_string", "<string>"]
module Syntax_combinator = [%spec_module "syntax_combinator", "'|'"]

module Syntax_component =
  [%spec_module
  "syntax_component",
  "<syntax-single-component> [ <syntax-multiplier> ]? | '<' 'transform-list' \
   '>'"]

module Syntax =
  [%spec_module
  "syntax",
  "'*' | <syntax-component> [ <syntax-combinator> <syntax-component> ]* | \
   <syntax-string>"]

(* (*
 We don't support type() yet, original spec is: "type( <syntax> ) | 'raw-string' | <attr-unit>" *) *)
module Attr_type = [%spec_module "attr_type", "'raw-string' | <attr-unit>"]
module X = [%spec_module "x", "<number>"]
module Y = [%spec_module "y", "<number>"]

let registry : (kind * (module RULE)) list =
  [
    (* Properties *)
    Property "display", (module Property_display : RULE);
    Property "overflow", (module Property_overflow : RULE);
    Property "position", (module Property_position : RULE);
    Property "visibility", (module Property_visibility : RULE);
    Property "float", (module Property_float : RULE);
    Property "clear", (module Property_clear : RULE);
    Property "table-layout", (module Property_table_layout : RULE);
    Property "border-collapse", (module Property_border_collapse : RULE);
    Property "empty-cells", (module Property_empty_cells : RULE);
    Property "caption-side", (module Property_caption_side : RULE);
    Property "direction", (module Property_direction : RULE);
    Property "unicode-bidi", (module Property_unicode_bidi : RULE);
    Property "writing-mode", (module Property_writing_mode : RULE);
    Property "text-orientation", (module Property_text_orientation : RULE);
    Property "text-transform", (module Property_text_transform : RULE);
    Property "white-space", (module Property_white_space : RULE);
    Property "word-break", (module Property_word_break : RULE);
    Property "overflow-wrap", (module Property_overflow_wrap : RULE);
    Property "text-align", (module Property_text_align : RULE);
    Property "text-align-last", (module Property_text_align_last : RULE);
    Property "text-justify", (module Property_text_justify : RULE);
    ( Property "text-decoration-line",
      (module Property_text_decoration_line : RULE) );
    ( Property "text-decoration-style",
      (module Property_text_decoration_style : RULE) );
    ( Property "text-decoration-skip-ink",
      (module Property_text_decoration_skip_ink : RULE) );
    Property "font-style", (module Property_font_style : RULE);
    Property "font-variant-caps", (module Property_font_variant_caps : RULE);
    Property "font-stretch", (module Property_font_stretch : RULE);
    Property "font-kerning", (module Property_font_kerning : RULE);
    ( Property "font-variant-position",
      (module Property_font_variant_position : RULE) );
    Property "list-style-position", (module Property_list_style_position : RULE);
    Property "list-style-type", (module Property_list_style_type : RULE);
    Property "pointer-events", (module Property_pointer_events : RULE);
    Property "user-select", (module Property_user_select : RULE);
    Property "resize", (module Property_resize : RULE);
    Property "box-sizing", (module Property_box_sizing : RULE);
    Property "object-fit", (module Property_object_fit : RULE);
    Property "isolation", (module Property_isolation : RULE);
    Property "mix-blend-mode", (module Property_mix_blend_mode : RULE);
    Property "backface-visibility", (module Property_backface_visibility : RULE);
    Property "flex-direction", (module Property_flex_direction : RULE);
    Property "flex-wrap", (module Property_flex_wrap : RULE);
    Property "justify-content", (module Property_justify_content : RULE);
    Property "align-items", (module Property_align_items : RULE);
    Property "align-content", (module Property_align_content : RULE);
    Property "align-self", (module Property_align_self : RULE);
    Property "justify-items", (module Property_justify_items : RULE);
    Property "justify-self", (module Property_justify_self : RULE);
    Property "scroll-behavior", (module Property_scroll_behavior : RULE);
    Property "overscroll-behavior", (module Property_overscroll_behavior : RULE);
    Property "overflow-anchor", (module Property_overflow_anchor : RULE);
    Property "touch-action", (module Property_touch_action : RULE);
    Property "caret-color", (module Property_caret_color : RULE);
    Property "appearance", (module Property_appearance : RULE);
    Property "text-rendering", (module Property_text_rendering : RULE);
    Property "image-rendering", (module Property_image_rendering : RULE);
    Property "color-scheme", (module Property_color_scheme : RULE);
    Property "forced-color-adjust", (module Property_forced_color_adjust : RULE);
    Property "print-color-adjust", (module Property_print_color_adjust : RULE);
    ( Property "contain-intrinsic-size",
      (module Property_contain_intrinsic_size : RULE) );
    Property "content-visibility", (module Property_content_visibility : RULE);
    Property "hyphens", (module Property_hyphens : RULE);
    Property "column-fill", (module Property_column_fill : RULE);
    Property "column-span", (module Property_column_span : RULE);
    Property "clip-rule", (module Property_clip_rule : RULE);
    Property "font-optical-sizing", (module Property_font_optical_sizing : RULE);
    Property "font-palette", (module Property_font_palette : RULE);
    ( Property "font-synthesis-weight",
      (module Property_font_synthesis_weight : RULE) );
    ( Property "font-synthesis-style",
      (module Property_font_synthesis_style : RULE) );
    ( Property "font-synthesis-small-caps",
      (module Property_font_synthesis_small_caps : RULE) );
    ( Property "font-synthesis-position",
      (module Property_font_synthesis_position : RULE) );
    Property "mask-border-mode", (module Property_mask_border_mode : RULE);
    Property "mask-type", (module Property_mask_type : RULE);
    Property "ruby-merge", (module Property_ruby_merge : RULE);
    Property "ruby-position", (module Property_ruby_position : RULE);
    Property "scroll-snap-stop", (module Property_scroll_snap_stop : RULE);
    Property "scrollbar-width", (module Property_scrollbar_width : RULE);
    Property "speak", (module Property_speak : RULE);
    Property "stroke-linecap", (module Property_stroke_linecap : RULE);
    ( Property "box-decoration-break",
      (module Property_box_decoration_break : RULE) );
    Property "color-adjust", (module Property_color_adjust : RULE);
    ( Property "text-decoration-thickness",
      (module Property_text_decoration_thickness : RULE) );
    ( Property "text-underline-position",
      (module Property_text_underline_position : RULE) );
    Property "word-wrap", (module Property_word_wrap : RULE);
    Property "break-inside", (module Property_break_inside : RULE);
    Property "break-before", (module Property_break_before : RULE);
    Property "break-after", (module Property_break_after : RULE);
    Property "page-break-after", (module Property_page_break_after : RULE);
    Property "page-break-before", (module Property_page_break_before : RULE);
    Property "page-break-inside", (module Property_page_break_inside : RULE);
    Property "border-image-repeat", (module Property_border_image_repeat : RULE);
    Property "transform-style", (module Property_transform_style : RULE);
    Property "transform-box", (module Property_transform_box : RULE);
    Property "grid-auto-flow", (module Property_grid_auto_flow : RULE);
    Property "font-display", (module Property_font_display : RULE);
    Property "will-change", (module Property_will_change : RULE);
    Property "contain", (module Property_contain : RULE);
    Property "all", (module Property_all : RULE);
    (* Values with runtime types *)
    Value "age", (module Age : RULE);
    Value "attachment", (module Attachment : RULE);
    Value "box", (module Box : RULE);
    Value "display-box", (module Display_box : RULE);
    Value "display-outside", (module Display_outside : RULE);
    Value "ending-shape", (module Ending_shape : RULE);
    Value "fill-rule", (module Fill_rule : RULE);
    Value "zero", (module Zero : RULE);
    Value "gender", (module Gender : RULE);
    Value "combinator", (module Combinator : RULE);
    Value "contextual-alt-values", (module Contextual_alt_values : RULE);
    Value "east-asian-width-values", (module East_asian_width_values : RULE);
    Value "attr-modifier", (module Attr_modifier : RULE);
    Value "image-tags", (module Image_tags : RULE);
    Value "line-style", (module Line_style : RULE);
    Value "line-width", (module Line_width : RULE);
    Value "named-color", (module Named_color : RULE);
    Value "color", (module Color : RULE);
    Value "alpha-value", (module Alpha_value : RULE);
    Value "hue", (module Hue : RULE);
    Value "bg-image", (module Bg_image : RULE);
    Value "content-replacement", (module Content_replacement : RULE);
    Value "transform-list", (module Transform_list : RULE);
    Value "transform-function", (module Transform_function : RULE);
    Value "image", (module Image : RULE);
    Value "font_families", (module Font_families : RULE);
    ( Value "color-interpolation-method",
      (module Color_interpolation_method : RULE) );
    Property "row-gap", (module Property_row_gap : RULE);
    Property "column-gap", (module Property_column_gap : RULE);
    Property "outline-width", (module Property_outline_width : RULE);
    Property "outline-style", (module Property_outline_style : RULE);
    Property "width", (module Property_width : RULE);
    Property "border", (module Property_border : RULE);
    Property "flex-grow", (module Property_flex_grow : RULE);
    Property "flex-shrink", (module Property_flex_shrink : RULE);
    Property "flex-basis", (module Property_flex_basis : RULE);
    Value "family-name", (module Family_name : RULE);
    Value "keyframes-name", (module Keyframes_name : RULE);
    Value "url", (module Url : RULE);
    (* Image functions *)
    Function "image()", (module Function_image : RULE);
    Function "image-set()", (module Function_image_set : RULE);
    Function "element()", (module Function_element : RULE);
    Function "paint()", (module Function_paint : RULE);
    Function "cross-fade()", (module Function_cross_fade : RULE);
    (* Gradient and other values *)
    Value "gradient", (module Gradient : RULE);
    Value "shadow", (module Shadow : RULE);
    Value "track-list", (module Track_list : RULE);
    Value "line-names", (module Line_names : RULE);
    Value "side-or-corner", (module Side_or_corner : RULE);
    Value "track-size", (module Track_size : RULE);
    Value "track-breadth", (module Track_breadth : RULE);
    Value "track-repeat", (module Track_repeat : RULE);
    Value "content-list", (module Content_list : RULE);
    Value "mask-reference", (module Mask_reference : RULE);
    Value "color-stop-list", (module Color_stop_list : RULE);
    Value "mask-source", (module Mask_source : RULE);
    Value "length-percentage", (module Length_percentage : RULE);
    Value "auto-track-list", (module Auto_track_list : RULE);
    Value "counter-style", (module Counter_style : RULE);
    Value "counter-style-name", (module Counter_style_name : RULE);
    Value "fixed-size", (module Fixed_size : RULE);
    Value "fixed-repeat", (module Fixed_repeat : RULE);
    Value "fixed-breadth", (module Fixed_breadth : RULE);
    Value "auto-repeat", (module Auto_repeat : RULE);
    Value "extended-time-no-interp", (module Extended_time_no_interp : RULE);
    Value "timing-function-no-interp", (module Timing_function_no_interp : RULE);
    ( Value "cubic-bezier-timing-function",
      (module Cubic_bezier_timing_function : RULE) );
    Value "step-timing-function", (module Step_timing_function : RULE);
    Value "single-animation", (module Single_animation : RULE);
    ( Value "single-animation-no-interp",
      (module Single_animation_no_interp : RULE) );
    ( Value "single-animation-direction-no-interp",
      (module Single_animation_direction_no_interp : RULE) );
    ( Value "single-animation-fill-mode-no-interp",
      (module Single_animation_fill_mode_no_interp : RULE) );
    ( Value "single-animation-iteration-count-no-interp",
      (module Single_animation_iteration_count_no_interp : RULE) );
    ( Value "single-animation-play-state-no-interp",
      (module Single_animation_play_state_no_interp : RULE) );
    Value "shadow-t", (module Shadow_t : RULE);
    Value "font-weight-absolute", (module Font_weight_absolute : RULE);
    (* Commonly referenced values *)
    Value "position", (module Position : RULE);
    Value "timing-function", (module Timing_function : RULE);
    Value "number-percentage", (module Number_percentage : RULE);
    Value "grid-line", (module Grid_line : RULE);
    ( Value "single-transition-property",
      (module Single_transition_property : RULE) );
    Value "outline-radius", (module Outline_radius : RULE);
    Value "bg-size", (module Bg_size : RULE);
    Value "bg-position", (module Bg_position : RULE);
    Value "feature-value-name", (module Feature_value_name : RULE);
    Value "svg-length", (module Svg_length : RULE);
    ( Value "single-animation-iteration-count",
      (module Single_animation_iteration_count : RULE) );
    Value "basic-shape", (module Basic_shape : RULE);
    Value "filter-function", (module Filter_function : RULE);
    Function "attr()", (module Function_attr : RULE);
    Function "symbols()", (module Function_symbols : RULE);
    (* Gradient functions *)
    Function "linear-gradient()", (module Function_linear_gradient : RULE);
    Function "radial-gradient()", (module Function_radial_gradient : RULE);
    Function "conic-gradient()", (module Function_conic_gradient : RULE);
    ( Function "repeating-linear-gradient()",
      (module Function_repeating_linear_gradient : RULE) );
    ( Function "repeating-radial-gradient()",
      (module Function_repeating_radial_gradient : RULE) );
    Function "-webkit-gradient()", (module Function__webkit_gradient : RULE);
    (* Transform functions *)
    Function "matrix()", (module Function_matrix : RULE);
    Function "matrix3d()", (module Function_matrix3d : RULE);
    Function "translate()", (module Function_translate : RULE);
    Function "translateX()", (module Function_translateX : RULE);
    Function "translateY()", (module Function_translateY : RULE);
    Function "translateZ()", (module Function_translateZ : RULE);
    Function "translate3d()", (module Function_translate3d : RULE);
    Function "scale()", (module Function_scale : RULE);
    Function "scale3d()", (module Function_scale3d : RULE);
    Function "scaleX()", (module Function_scaleX : RULE);
    Function "scaleY()", (module Function_scaleY : RULE);
    Function "scaleZ()", (module Function_scaleZ : RULE);
    Function "rotate()", (module Function_rotate : RULE);
    Function "rotate3d()", (module Function_rotate3d : RULE);
    Function "rotateX()", (module Function_rotateX : RULE);
    Function "rotateY()", (module Function_rotateY : RULE);
    Function "rotateZ()", (module Function_rotateZ : RULE);
    Function "skew()", (module Function_skew : RULE);
    Function "skewX()", (module Function_skewX : RULE);
    Function "skewY()", (module Function_skewY : RULE);
    Function "perspective()", (module Function_perspective : RULE);
    Value "overflow-position", (module Overflow_position : RULE);
    Value "relative-size", (module Relative_size : RULE);
    Value "repeat-style", (module Repeat_style : RULE);
    Value "self-position", (module Self_position : RULE);
    ( Value "single-animation-direction",
      (module Single_animation_direction : RULE) );
    ( Value "single-animation-fill-mode",
      (module Single_animation_fill_mode : RULE) );
    ( Value "single-animation-play-state",
      (module Single_animation_play_state : RULE) );
    Value "step-position", (module Step_position : RULE);
    Value "symbols-type", (module Symbols_type : RULE);
    Value "masking-mode", (module Masking_mode : RULE);
    Value "numeric-figure-values", (module Numeric_figure_values : RULE);
    Value "numeric-spacing-values", (module Numeric_spacing_values : RULE);
    Value "absolute-size", (module Absolute_size : RULE);
    Value "content-position", (module Content_position : RULE);
    Value "baseline-position", (module Baseline_position : RULE);
    Value "blend-mode", (module Blend_mode : RULE);
    Value "geometry-box", (module Geometry_box : RULE);
    Property "-webkit-appearance", (module Property__webkit_appearance : RULE);
    Property "stroke-linejoin", (module Property_stroke_linejoin : RULE);
    Property "perspective-origin", (module Property_perspective_origin : RULE);
    (* CSS Math Functions *)
    Function "calc()", (module Function_calc : RULE);
    Function "min()", (module Function_min : RULE);
    Function "max()", (module Function_max : RULE);
    (* CSS Color Functions *)
    Function "rgb()", (module Function_rgb : RULE);
    Function "rgba()", (module Function_rgba : RULE);
    Function "hsl()", (module Function_hsl : RULE);
    Function "hsla()", (module Function_hsla : RULE);
    Function "var()", (module Function_var : RULE);
    Function "color-mix()", (module Function_color_mix : RULE);
    (* CSS Calc internal types *)
    Value "calc-product", (module Calc_product : RULE);
    Value "calc-sum", (module Calc_sum : RULE);
    Value "calc-value", (module Calc_value : RULE);
    (* Media query building blocks *)
    Value "mf-eq", (module Mf_eq : RULE);
    Value "mf-gt", (module Mf_gt : RULE);
    Value "mf-lt", (module Mf_lt : RULE);
    (* Media query types *)
    Property "media-type", (module Property_media_type : RULE);
    Property "container-type", (module Property_container_type : RULE);
    Value "dimension", (module Dimension : RULE);
    Value "ratio", (module Ratio : RULE);
    Value "mf-name", (module Mf_name : RULE);
    Value "mf-value", (module Mf_value : RULE);
    Value "mf-boolean", (module Mf_boolean : RULE);
    Value "mf-plain", (module Mf_plain : RULE);
    Value "mf-comparison", (module Mf_comparison : RULE);
    Value "mf-range", (module Mf_range : RULE);
    (* Media query types *)
    Media_query "media-feature", (module Media_feature : RULE);
    Media_query "media-in-parens", (module Media_in_parens : RULE);
    Media_query "media-or", (module Media_or : RULE);
    Media_query "media-and", (module Media_and : RULE);
    Media_query "media-not", (module Media_not : RULE);
    ( Media_query "media-condition-without-or",
      (module Media_condition_without_or : RULE) );
    Media_query "media-condition", (module Media_condition : RULE);
    Media_query "media-query", (module Media_query : RULE);
    Media_query "media-query-list", (module Media_query_list : RULE);
    (* Container query types *)
    Value "container-query", (module Container_query : RULE);
    Value "container-condition", (module Container_condition : RULE);
    Value "query-in-parens", (module Query_in_parens : RULE);
    Value "size-feature", (module Size_feature : RULE);
    Value "style-query", (module Style_query : RULE);
    Value "style-feature", (module Style_feature : RULE);
    Value "style-in-parens", (module Style_in_parens : RULE);
    (* Legacy/Non-standard values - keyword only *)
    ( Value "legacy-radial-gradient-shape",
      (module Legacy_radial_gradient_shape : RULE) );
    ( Value "legacy-radial-gradient-size",
      (module Legacy_radial_gradient_size : RULE) );
    ( Value "legacy-radial-gradient-arguments",
      (module Legacy_radial_gradient_arguments : RULE) );
    Value "legacy-radial-gradient", (module Legacy_radial_gradient : RULE);
    ( Value "legacy-repeating-radial-gradient",
      (module Legacy_repeating_radial_gradient : RULE) );
    Value "legacy-linear-gradient", (module Legacy_linear_gradient : RULE);
    ( Value "legacy-linear-gradient-arguments",
      (module Legacy_linear_gradient_arguments : RULE) );
    ( Value "legacy-repeating-linear-gradient",
      (module Legacy_repeating_linear_gradient : RULE) );
    Value "legacy-gradient", (module Legacy_gradient : RULE);
    Value "-non-standard-color", (module Non_standard_color : RULE);
    Value "-non-standard-font", (module Non_standard_font : RULE);
    ( Value "-non-standard-image-rendering",
      (module Non_standard_image_rendering : RULE) );
    Value "-non-standard-overflow", (module Non_standard_overflow : RULE);
    Value "-non-standard-width", (module Non_standard_width : RULE);
    Value "-webkit-gradient-type", (module Webkit_gradient_type : RULE);
    Value "-webkit-mask-box-repeat", (module Webkit_mask_box_repeat : RULE);
    Value "-webkit-mask-clip-style", (module Webkit_mask_clip_style : RULE);
    (* Keyword-only CSS values *)
    Value "common-lig-values", (module Common_lig_values : RULE);
    Value "compat-auto", (module Compat_auto : RULE);
    Value "composite-style", (module Composite_style : RULE);
    Value "compositing-operator", (module Compositing_operator : RULE);
    Value "content-distribution", (module Content_distribution : RULE);
    Value "deprecated-system-color", (module Deprecated_system_color : RULE);
    Value "discretionary-lig-values", (module Discretionary_lig_values : RULE);
    Value "display-inside", (module Display_inside : RULE);
    Value "display-internal", (module Display_internal : RULE);
    Value "display-legacy", (module Display_legacy : RULE);
    Value "east-asian-variant-values", (module East_asian_variant_values : RULE);
    Value "feature-type", (module Feature_type : RULE);
    Value "font-variant-css21", (module Font_variant_css21 : RULE);
    Value "generic-family", (module Generic_family : RULE);
    Value "generic-name", (module Generic_name : RULE);
    Value "historical-lig-values", (module Historical_lig_values : RULE);
    Value "numeric-fraction-values", (module Numeric_fraction_values : RULE);
    (* Value "overflow-position-value", (module Overflow_position : RULE); *)
    Value "page-margin-box-type", (module Page_margin_box_type : RULE);
    Value "polar-color-space", (module Polar_color_space : RULE);
    Value "quote", (module Quote : RULE);
    Value "rectangular-color-space", (module Rectangular_color_space : RULE);
    Value "shape-box", (module Shape_box : RULE);
    Value "visual-box", (module Visual_box : RULE);
    (* ============================================= *)
    (* Missing Properties - Added via registry scan *)
    (* ============================================= *)
    Property "-moz-appearance", (module Property__moz_appearance : RULE);
    ( Property "-moz-background-clip",
      (module Property__moz_background_clip : RULE) );
    Property "-moz-binding", (module Property__moz_binding : RULE);
    ( Property "-moz-border-bottom-colors",
      (module Property__moz_border_bottom_colors : RULE) );
    ( Property "-moz-border-left-colors",
      (module Property__moz_border_left_colors : RULE) );
    ( Property "-moz-border-radius-bottomleft",
      (module Property__moz_border_radius_bottomleft : RULE) );
    ( Property "-moz-border-radius-bottomright",
      (module Property__moz_border_radius_bottomright : RULE) );
    ( Property "-moz-border-radius-topleft",
      (module Property__moz_border_radius_topleft : RULE) );
    ( Property "-moz-border-radius-topright",
      (module Property__moz_border_radius_topright : RULE) );
    ( Property "-moz-border-right-colors",
      (module Property__moz_border_right_colors : RULE) );
    ( Property "-moz-border-top-colors",
      (module Property__moz_border_top_colors : RULE) );
    ( Property "-moz-context-properties",
      (module Property__moz_context_properties : RULE) );
    ( Property "-moz-control-character-visibility",
      (module Property__moz_control_character_visibility : RULE) );
    Property "-moz-float-edge", (module Property__moz_float_edge : RULE);
    ( Property "-moz-force-broken-image-icon",
      (module Property__moz_force_broken_image_icon : RULE) );
    Property "-moz-image-region", (module Property__moz_image_region : RULE);
    Property "-moz-orient", (module Property__moz_orient : RULE);
    ( Property "-moz-osx-font-smoothing",
      (module Property__moz_osx_font_smoothing : RULE) );
    Property "-moz-outline-radius", (module Property__moz_outline_radius : RULE);
    ( Property "-moz-outline-radius-bottomleft",
      (module Property__moz_outline_radius_bottomleft : RULE) );
    ( Property "-moz-outline-radius-bottomright",
      (module Property__moz_outline_radius_bottomright : RULE) );
    ( Property "-moz-outline-radius-topleft",
      (module Property__moz_outline_radius_topleft : RULE) );
    ( Property "-moz-outline-radius-topright",
      (module Property__moz_outline_radius_topright : RULE) );
    Property "-moz-stack-sizing", (module Property__moz_stack_sizing : RULE);
    Property "-moz-text-blink", (module Property__moz_text_blink : RULE);
    Property "-moz-user-focus", (module Property__moz_user_focus : RULE);
    Property "-moz-user-input", (module Property__moz_user_input : RULE);
    Property "-moz-user-modify", (module Property__moz_user_modify : RULE);
    Property "-moz-user-select", (module Property__moz_user_select : RULE);
    ( Property "-moz-window-dragging",
      (module Property__moz_window_dragging : RULE) );
    Property "-moz-window-shadow", (module Property__moz_window_shadow : RULE);
    ( Property "-webkit-background-clip",
      (module Property__webkit_background_clip : RULE) );
    ( Property "-webkit-border-before",
      (module Property__webkit_border_before : RULE) );
    ( Property "-webkit-border-before-color",
      (module Property__webkit_border_before_color : RULE) );
    ( Property "-webkit-border-before-style",
      (module Property__webkit_border_before_style : RULE) );
    ( Property "-webkit-border-before-width",
      (module Property__webkit_border_before_width : RULE) );
    Property "-webkit-box-reflect", (module Property__webkit_box_reflect : RULE);
    ( Property "-webkit-column-break-after",
      (module Property__webkit_column_break_after : RULE) );
    ( Property "-webkit-column-break-before",
      (module Property__webkit_column_break_before : RULE) );
    ( Property "-webkit-column-break-inside",
      (module Property__webkit_column_break_inside : RULE) );
    ( Property "-webkit-font-smoothing",
      (module Property__webkit_font_smoothing : RULE) );
    Property "-webkit-line-clamp", (module Property__webkit_line_clamp : RULE);
    Property "-webkit-mask", (module Property__webkit_mask : RULE);
    ( Property "-webkit-mask-attachment",
      (module Property__webkit_mask_attachment : RULE) );
    ( Property "-webkit-mask-box-image",
      (module Property__webkit_mask_box_image : RULE) );
    Property "-webkit-mask-clip", (module Property__webkit_mask_clip : RULE);
    ( Property "-webkit-mask-composite",
      (module Property__webkit_mask_composite : RULE) );
    Property "-webkit-mask-image", (module Property__webkit_mask_image : RULE);
    Property "-webkit-mask-origin", (module Property__webkit_mask_origin : RULE);
    ( Property "-webkit-mask-position",
      (module Property__webkit_mask_position : RULE) );
    ( Property "-webkit-mask-position-x",
      (module Property__webkit_mask_position_x : RULE) );
    ( Property "-webkit-mask-position-y",
      (module Property__webkit_mask_position_y : RULE) );
    Property "-webkit-mask-repeat", (module Property__webkit_mask_repeat : RULE);
    ( Property "-webkit-mask-repeat-x",
      (module Property__webkit_mask_repeat_x : RULE) );
    ( Property "-webkit-mask-repeat-y",
      (module Property__webkit_mask_repeat_y : RULE) );
    Property "-webkit-mask-size", (module Property__webkit_mask_size : RULE);
    ( Property "-webkit-overflow-scrolling",
      (module Property__webkit_overflow_scrolling : RULE) );
    ( Property "-webkit-print-color-adjust",
      (module Property__webkit_print_color_adjust : RULE) );
    ( Property "-webkit-tap-highlight-color",
      (module Property__webkit_tap_highlight_color : RULE) );
    ( Property "-webkit-text-fill-color",
      (module Property__webkit_text_fill_color : RULE) );
    ( Property "-webkit-text-security",
      (module Property__webkit_text_security : RULE) );
    Property "-webkit-text-stroke", (module Property__webkit_text_stroke : RULE);
    ( Property "-webkit-text-stroke-color",
      (module Property__webkit_text_stroke_color : RULE) );
    ( Property "-webkit-text-stroke-width",
      (module Property__webkit_text_stroke_width : RULE) );
    ( Property "-webkit-touch-callout",
      (module Property__webkit_touch_callout : RULE) );
    Property "-webkit-user-drag", (module Property__webkit_user_drag : RULE);
    Property "-webkit-user-modify", (module Property__webkit_user_modify : RULE);
    Property "-webkit-user-select", (module Property__webkit_user_select : RULE);
    Property "accent-color", (module Property_accent_color : RULE);
    Property "alignment-baseline", (module Property_alignment_baseline : RULE);
    Property "anchor-name", (module Property_anchor_name : RULE);
    Property "anchor-scope", (module Property_anchor_scope : RULE);
    Property "animation", (module Property_animation : RULE);
    ( Property "animation-composition",
      (module Property_animation_composition : RULE) );
    Property "animation-delay", (module Property_animation_delay : RULE);
    Property "animation-delay-end", (module Property_animation_delay_end : RULE);
    ( Property "animation-delay-start",
      (module Property_animation_delay_start : RULE) );
    Property "animation-direction", (module Property_animation_direction : RULE);
    Property "animation-duration", (module Property_animation_duration : RULE);
    Property "animation-fill-mode", (module Property_animation_fill_mode : RULE);
    ( Property "animation-iteration-count",
      (module Property_animation_iteration_count : RULE) );
    Property "animation-name", (module Property_animation_name : RULE);
    ( Property "animation-play-state",
      (module Property_animation_play_state : RULE) );
    Property "animation-range", (module Property_animation_range : RULE);
    Property "animation-range-end", (module Property_animation_range_end : RULE);
    ( Property "animation-range-start",
      (module Property_animation_range_start : RULE) );
    Property "animation-timeline", (module Property_animation_timeline : RULE);
    ( Property "animation-timing-function",
      (module Property_animation_timing_function : RULE) );
    Property "aspect-ratio", (module Property_aspect_ratio : RULE);
    Property "azimuth", (module Property_azimuth : RULE);
    Property "backdrop-blur", (module Property_backdrop_blur : RULE);
    Property "backdrop-filter", (module Property_backdrop_filter : RULE);
    Property "background", (module Property_background : RULE);
    ( Property "background-attachment",
      (module Property_background_attachment : RULE) );
    ( Property "background-blend-mode",
      (module Property_background_blend_mode : RULE) );
    Property "background-clip", (module Property_background_clip : RULE);
    Property "background-color", (module Property_background_color : RULE);
    Property "background-image", (module Property_background_image : RULE);
    Property "background-origin", (module Property_background_origin : RULE);
    Property "background-position", (module Property_background_position : RULE);
    ( Property "background-position-x",
      (module Property_background_position_x : RULE) );
    ( Property "background-position-y",
      (module Property_background_position_y : RULE) );
    Property "background-repeat", (module Property_background_repeat : RULE);
    Property "background-size", (module Property_background_size : RULE);
    Property "baseline-shift", (module Property_baseline_shift : RULE);
    Property "behavior", (module Property_behavior : RULE);
    Property "bleed", (module Property_bleed : RULE);
    Property "block-overflow", (module Property_block_overflow : RULE);
    Property "block-size", (module Property_block_size : RULE);
    Property "border-block", (module Property_border_block : RULE);
    Property "border-block-color", (module Property_border_block_color : RULE);
    Property "border-block-end", (module Property_border_block_end : RULE);
    ( Property "border-block-end-color",
      (module Property_border_block_end_color : RULE) );
    ( Property "border-block-end-style",
      (module Property_border_block_end_style : RULE) );
    ( Property "border-block-end-width",
      (module Property_border_block_end_width : RULE) );
    Property "border-block-start", (module Property_border_block_start : RULE);
    ( Property "border-block-start-color",
      (module Property_border_block_start_color : RULE) );
    ( Property "border-block-start-style",
      (module Property_border_block_start_style : RULE) );
    ( Property "border-block-start-width",
      (module Property_border_block_start_width : RULE) );
    Property "border-block-style", (module Property_border_block_style : RULE);
    Property "border-block-width", (module Property_border_block_width : RULE);
    Property "border-bottom", (module Property_border_bottom : RULE);
    Property "border-bottom-color", (module Property_border_bottom_color : RULE);
    ( Property "border-bottom-left-radius",
      (module Property_border_bottom_left_radius : RULE) );
    ( Property "border-bottom-right-radius",
      (module Property_border_bottom_right_radius : RULE) );
    Property "border-bottom-style", (module Property_border_bottom_style : RULE);
    Property "border-bottom-width", (module Property_border_bottom_width : RULE);
    Property "border-color", (module Property_border_color : RULE);
    ( Property "border-end-end-radius",
      (module Property_border_end_end_radius : RULE) );
    ( Property "border-end-start-radius",
      (module Property_border_end_start_radius : RULE) );
    Property "border-image", (module Property_border_image : RULE);
    Property "border-image-outset", (module Property_border_image_outset : RULE);
    Property "border-image-slice", (module Property_border_image_slice : RULE);
    Property "border-image-source", (module Property_border_image_source : RULE);
    Property "border-image-width", (module Property_border_image_width : RULE);
    Property "border-inline", (module Property_border_inline : RULE);
    Property "border-inline-color", (module Property_border_inline_color : RULE);
    Property "border-inline-end", (module Property_border_inline_end : RULE);
    ( Property "border-inline-end-color",
      (module Property_border_inline_end_color : RULE) );
    ( Property "border-inline-end-style",
      (module Property_border_inline_end_style : RULE) );
    ( Property "border-inline-end-width",
      (module Property_border_inline_end_width : RULE) );
    Property "border-inline-start", (module Property_border_inline_start : RULE);
    ( Property "border-inline-start-color",
      (module Property_border_inline_start_color : RULE) );
    ( Property "border-inline-start-style",
      (module Property_border_inline_start_style : RULE) );
    ( Property "border-inline-start-width",
      (module Property_border_inline_start_width : RULE) );
    Property "border-inline-style", (module Property_border_inline_style : RULE);
    Property "border-inline-width", (module Property_border_inline_width : RULE);
    Property "border-left", (module Property_border_left : RULE);
    Property "border-left-color", (module Property_border_left_color : RULE);
    Property "border-left-style", (module Property_border_left_style : RULE);
    Property "border-left-width", (module Property_border_left_width : RULE);
    Property "border-radius", (module Property_border_radius : RULE);
    Property "border-right", (module Property_border_right : RULE);
    Property "border-right-color", (module Property_border_right_color : RULE);
    Property "border-right-style", (module Property_border_right_style : RULE);
    Property "border-right-width", (module Property_border_right_width : RULE);
    Property "border-spacing", (module Property_border_spacing : RULE);
    ( Property "border-start-end-radius",
      (module Property_border_start_end_radius : RULE) );
    ( Property "border-start-start-radius",
      (module Property_border_start_start_radius : RULE) );
    Property "border-style", (module Property_border_style : RULE);
    Property "border-top", (module Property_border_top : RULE);
    Property "border-top-color", (module Property_border_top_color : RULE);
    ( Property "border-top-left-radius",
      (module Property_border_top_left_radius : RULE) );
    ( Property "border-top-right-radius",
      (module Property_border_top_right_radius : RULE) );
    Property "border-top-style", (module Property_border_top_style : RULE);
    Property "border-top-width", (module Property_border_top_width : RULE);
    Property "border-width", (module Property_border_width : RULE);
    Property "bottom", (module Property_bottom : RULE);
    Property "box-align", (module Property_box_align : RULE);
    Property "box-direction", (module Property_box_direction : RULE);
    Property "box-flex", (module Property_box_flex : RULE);
    Property "box-flex-group", (module Property_box_flex_group : RULE);
    Property "box-lines", (module Property_box_lines : RULE);
    Property "box-ordinal-group", (module Property_box_ordinal_group : RULE);
    Property "box-orient", (module Property_box_orient : RULE);
    Property "-webkit-box-orient", (module Property_box_orient : RULE);
    Property "box-pack", (module Property_box_pack : RULE);
    Property "box-shadow", (module Property_box_shadow : RULE);
    Property "clip", (module Property_clip : RULE);
    Property "clip-path", (module Property_clip_path : RULE);
    Property "color", (module Property_color : RULE);
    Property "color-interpolation", (module Property_color_interpolation : RULE);
    ( Property "color-interpolation-filters",
      (module Property_color_interpolation_filters : RULE) );
    Property "color-rendering", (module Property_color_rendering : RULE);
    Property "column-count", (module Property_column_count : RULE);
    Property "column-rule", (module Property_column_rule : RULE);
    Property "column-rule-color", (module Property_column_rule_color : RULE);
    Property "column-rule-style", (module Property_column_rule_style : RULE);
    Property "column-rule-width", (module Property_column_rule_width : RULE);
    Property "column-width", (module Property_column_width : RULE);
    Property "columns", (module Property_columns : RULE);
    ( Property "contain-intrinsic-block-size",
      (module Property_contain_intrinsic_block_size : RULE) );
    ( Property "contain-intrinsic-height",
      (module Property_contain_intrinsic_height : RULE) );
    ( Property "contain-intrinsic-inline-size",
      (module Property_contain_intrinsic_inline_size : RULE) );
    ( Property "contain-intrinsic-width",
      (module Property_contain_intrinsic_width : RULE) );
    Property "container", (module Property_container : RULE);
    Property "container-name", (module Property_container_name : RULE);
    ( Property "container-name-computed",
      (module Property_container_name_computed : RULE) );
    Property "content", (module Property_content : RULE);
    Property "counter-increment", (module Property_counter_increment : RULE);
    Property "counter-reset", (module Property_counter_reset : RULE);
    Property "counter-set", (module Property_counter_set : RULE);
    Property "cue", (module Property_cue : RULE);
    Property "cue-after", (module Property_cue_after : RULE);
    Property "cue-before", (module Property_cue_before : RULE);
    Property "cursor", (module Property_cursor : RULE);
    Property "cx", (module Property_cx : RULE);
    Property "cy", (module Property_cy : RULE);
    Property "d", (module Property_d : RULE);
    Property "dominant-baseline", (module Property_dominant_baseline : RULE);
    Property "field-sizing", (module Property_field_sizing : RULE);
    Property "fill", (module Property_fill : RULE);
    Property "fill-opacity", (module Property_fill_opacity : RULE);
    Property "fill-rule", (module Property_fill_rule : RULE);
    Property "filter", (module Property_filter : RULE);
    Property "flex", (module Property_flex : RULE);
    Property "flex-flow", (module Property_flex_flow : RULE);
    Property "flood-color", (module Property_flood_color : RULE);
    Property "flood-opacity", (module Property_flood_opacity : RULE);
    Property "font", (module Property_font : RULE);
    Property "font-family", (module Property_font_family : RULE);
    ( Property "font-feature-settings",
      (module Property_font_feature_settings : RULE) );
    ( Property "font-language-override",
      (module Property_font_language_override : RULE) );
    Property "font-size", (module Property_font_size : RULE);
    Property "font-size-adjust", (module Property_font_size_adjust : RULE);
    Property "font-smooth", (module Property_font_smooth : RULE);
    Property "font-synthesis", (module Property_font_synthesis : RULE);
    Property "font-variant", (module Property_font_variant : RULE);
    ( Property "font-variant-alternates",
      (module Property_font_variant_alternates : RULE) );
    ( Property "font-variant-east-asian",
      (module Property_font_variant_east_asian : RULE) );
    Property "font-variant-emoji", (module Property_font_variant_emoji : RULE);
    ( Property "font-variant-ligatures",
      (module Property_font_variant_ligatures : RULE) );
    ( Property "font-variant-numeric",
      (module Property_font_variant_numeric : RULE) );
    ( Property "font-variation-settings",
      (module Property_font_variation_settings : RULE) );
    Property "font-weight", (module Property_font_weight : RULE);
    Property "gap", (module Property_gap : RULE);
    ( Property "glyph-orientation-horizontal",
      (module Property_glyph_orientation_horizontal : RULE) );
    ( Property "glyph-orientation-vertical",
      (module Property_glyph_orientation_vertical : RULE) );
    Property "grid", (module Property_grid : RULE);
    Property "grid-area", (module Property_grid_area : RULE);
    Property "grid-auto-columns", (module Property_grid_auto_columns : RULE);
    Property "grid-auto-rows", (module Property_grid_auto_rows : RULE);
    Property "grid-column", (module Property_grid_column : RULE);
    Property "grid-column-end", (module Property_grid_column_end : RULE);
    Property "grid-column-gap", (module Property_grid_column_gap : RULE);
    Property "grid-column-start", (module Property_grid_column_start : RULE);
    Property "grid-gap", (module Property_grid_gap : RULE);
    Property "grid-row", (module Property_grid_row : RULE);
    Property "grid-row-end", (module Property_grid_row_end : RULE);
    Property "grid-row-gap", (module Property_grid_row_gap : RULE);
    Property "grid-row-start", (module Property_grid_row_start : RULE);
    Property "grid-template", (module Property_grid_template : RULE);
    Property "grid-template-areas", (module Property_grid_template_areas : RULE);
    ( Property "grid-template-columns",
      (module Property_grid_template_columns : RULE) );
    Property "grid-template-rows", (module Property_grid_template_rows : RULE);
    Property "hanging-punctuation", (module Property_hanging_punctuation : RULE);
    Property "height", (module Property_height : RULE);
    Property "hyphenate-character", (module Property_hyphenate_character : RULE);
    ( Property "hyphenate-limit-chars",
      (module Property_hyphenate_limit_chars : RULE) );
    ( Property "hyphenate-limit-last",
      (module Property_hyphenate_limit_last : RULE) );
    ( Property "hyphenate-limit-lines",
      (module Property_hyphenate_limit_lines : RULE) );
    ( Property "hyphenate-limit-zone",
      (module Property_hyphenate_limit_zone : RULE) );
    Property "image-orientation", (module Property_image_orientation : RULE);
    Property "image-resolution", (module Property_image_resolution : RULE);
    Property "ime-mode", (module Property_ime_mode : RULE);
    Property "inherits", (module Property_inherits : RULE);
    Property "initial-letter", (module Property_initial_letter : RULE);
    ( Property "initial-letter-align",
      (module Property_initial_letter_align : RULE) );
    Property "initial-value", (module Property_initial_value : RULE);
    Property "inline-size", (module Property_inline_size : RULE);
    Property "inset", (module Property_inset : RULE);
    Property "inset-area", (module Property_inset_area : RULE);
    Property "inset-block", (module Property_inset_block : RULE);
    Property "inset-block-end", (module Property_inset_block_end : RULE);
    Property "inset-block-start", (module Property_inset_block_start : RULE);
    Property "inset-inline", (module Property_inset_inline : RULE);
    Property "inset-inline-end", (module Property_inset_inline_end : RULE);
    Property "inset-inline-start", (module Property_inset_inline_start : RULE);
    Property "interpolate-size", (module Property_interpolate_size : RULE);
    Property "kerning", (module Property_kerning : RULE);
    Property "layout-grid", (module Property_layout_grid : RULE);
    Property "layout-grid-char", (module Property_layout_grid_char : RULE);
    Property "layout-grid-line", (module Property_layout_grid_line : RULE);
    Property "layout-grid-mode", (module Property_layout_grid_mode : RULE);
    Property "layout-grid-type", (module Property_layout_grid_type : RULE);
    Property "left", (module Property_left : RULE);
    Property "letter-spacing", (module Property_letter_spacing : RULE);
    Property "lighting-color", (module Property_lighting_color : RULE);
    Property "line-break", (module Property_line_break : RULE);
    Property "line-clamp", (module Property_line_clamp : RULE);
    Property "line-height", (module Property_line_height : RULE);
    Property "line-height-step", (module Property_line_height_step : RULE);
    Property "list-style", (module Property_list_style : RULE);
    Property "list-style-image", (module Property_list_style_image : RULE);
    Property "margin", (module Property_margin : RULE);
    Property "margin-block", (module Property_margin_block : RULE);
    Property "margin-block-end", (module Property_margin_block_end : RULE);
    Property "margin-block-start", (module Property_margin_block_start : RULE);
    Property "margin-bottom", (module Property_margin_bottom : RULE);
    Property "margin-inline", (module Property_margin_inline : RULE);
    Property "margin-inline-end", (module Property_margin_inline_end : RULE);
    Property "margin-inline-start", (module Property_margin_inline_start : RULE);
    Property "margin-left", (module Property_margin_left : RULE);
    Property "margin-right", (module Property_margin_right : RULE);
    Property "margin-top", (module Property_margin_top : RULE);
    Property "margin-trim", (module Property_margin_trim : RULE);
    Property "marker", (module Property_marker : RULE);
    Property "marker-end", (module Property_marker_end : RULE);
    Property "marker-mid", (module Property_marker_mid : RULE);
    Property "marker-start", (module Property_marker_start : RULE);
    Property "marks", (module Property_marks : RULE);
    Property "mask", (module Property_mask : RULE);
    Property "mask-border", (module Property_mask_border : RULE);
    Property "mask-border-outset", (module Property_mask_border_outset : RULE);
    Property "mask-border-repeat", (module Property_mask_border_repeat : RULE);
    Property "mask-border-slice", (module Property_mask_border_slice : RULE);
    Property "mask-border-source", (module Property_mask_border_source : RULE);
    Property "mask-border-width", (module Property_mask_border_width : RULE);
    Property "mask-clip", (module Property_mask_clip : RULE);
    Property "mask-composite", (module Property_mask_composite : RULE);
    Property "mask-image", (module Property_mask_image : RULE);
    Property "mask-mode", (module Property_mask_mode : RULE);
    Property "mask-origin", (module Property_mask_origin : RULE);
    Property "mask-position", (module Property_mask_position : RULE);
    Property "mask-repeat", (module Property_mask_repeat : RULE);
    Property "mask-size", (module Property_mask_size : RULE);
    Property "masonry-auto-flow", (module Property_masonry_auto_flow : RULE);
    Property "math-depth", (module Property_math_depth : RULE);
    Property "math-shift", (module Property_math_shift : RULE);
    Property "math-style", (module Property_math_style : RULE);
    Property "max-block-size", (module Property_max_block_size : RULE);
    Property "max-height", (module Property_max_height : RULE);
    Property "max-inline-size", (module Property_max_inline_size : RULE);
    Property "max-lines", (module Property_max_lines : RULE);
    Property "max-width", (module Property_max_width : RULE);
    Property "media-any-hover", (module Property_media_any_hover : RULE);
    Property "media-any-pointer", (module Property_media_any_pointer : RULE);
    Property "media-color-gamut", (module Property_media_color_gamut : RULE);
    Property "media-color-index", (module Property_media_color_index : RULE);
    Property "media-display-mode", (module Property_media_display_mode : RULE);
    Property "media-forced-colors", (module Property_media_forced_colors : RULE);
    Property "media-grid", (module Property_media_grid : RULE);
    Property "media-hover", (module Property_media_hover : RULE);
    ( Property "media-inverted-colors",
      (module Property_media_inverted_colors : RULE) );
    ( Property "media-max-aspect-ratio",
      (module Property_media_max_aspect_ratio : RULE) );
    ( Property "media-max-resolution",
      (module Property_media_max_resolution : RULE) );
    ( Property "media-min-aspect-ratio",
      (module Property_media_min_aspect_ratio : RULE) );
    Property "media-min-color", (module Property_media_min_color : RULE);
    ( Property "media-min-color-index",
      (module Property_media_min_color_index : RULE) );
    ( Property "media-min-resolution",
      (module Property_media_min_resolution : RULE) );
    Property "media-monochrome", (module Property_media_monochrome : RULE);
    Property "media-orientation", (module Property_media_orientation : RULE);
    Property "media-pointer", (module Property_media_pointer : RULE);
    ( Property "media-prefers-color-scheme",
      (module Property_media_prefers_color_scheme : RULE) );
    ( Property "media-prefers-contrast",
      (module Property_media_prefers_contrast : RULE) );
    ( Property "media-prefers-reduced-motion",
      (module Property_media_prefers_reduced_motion : RULE) );
    Property "media-resolution", (module Property_media_resolution : RULE);
    Property "media-scripting", (module Property_media_scripting : RULE);
    Property "media-update", (module Property_media_update : RULE);
    Property "min-block-size", (module Property_min_block_size : RULE);
    Property "min-height", (module Property_min_height : RULE);
    Property "min-inline-size", (module Property_min_inline_size : RULE);
    Property "min-width", (module Property_min_width : RULE);
    Property "nav-down", (module Property_nav_down : RULE);
    Property "nav-left", (module Property_nav_left : RULE);
    Property "nav-right", (module Property_nav_right : RULE);
    Property "nav-up", (module Property_nav_up : RULE);
    Property "object-position", (module Property_object_position : RULE);
    Property "offset", (module Property_offset : RULE);
    Property "offset-anchor", (module Property_offset_anchor : RULE);
    Property "offset-distance", (module Property_offset_distance : RULE);
    Property "offset-path", (module Property_offset_path : RULE);
    Property "offset-position", (module Property_offset_position : RULE);
    Property "offset-rotate", (module Property_offset_rotate : RULE);
    Property "opacity", (module Property_opacity : RULE);
    Property "order", (module Property_order : RULE);
    Property "orphans", (module Property_orphans : RULE);
    Property "outline", (module Property_outline : RULE);
    Property "outline-color", (module Property_outline_color : RULE);
    Property "outline-offset", (module Property_outline_offset : RULE);
    Property "overflow-block", (module Property_overflow_block : RULE);
    ( Property "overflow-clip-margin",
      (module Property_overflow_clip_margin : RULE) );
    Property "overflow-inline", (module Property_overflow_inline : RULE);
    Property "overflow-x", (module Property_overflow_x : RULE);
    Property "overflow-y", (module Property_overflow_y : RULE);
    Property "overlay", (module Property_overlay : RULE);
    ( Property "overscroll-behavior-block",
      (module Property_overscroll_behavior_block : RULE) );
    ( Property "overscroll-behavior-inline",
      (module Property_overscroll_behavior_inline : RULE) );
    ( Property "overscroll-behavior-x",
      (module Property_overscroll_behavior_x : RULE) );
    ( Property "overscroll-behavior-y",
      (module Property_overscroll_behavior_y : RULE) );
    Property "padding", (module Property_padding : RULE);
    Property "padding-block", (module Property_padding_block : RULE);
    Property "padding-block-end", (module Property_padding_block_end : RULE);
    Property "padding-block-start", (module Property_padding_block_start : RULE);
    Property "padding-bottom", (module Property_padding_bottom : RULE);
    Property "padding-inline", (module Property_padding_inline : RULE);
    Property "padding-inline-end", (module Property_padding_inline_end : RULE);
    ( Property "padding-inline-start",
      (module Property_padding_inline_start : RULE) );
    Property "padding-left", (module Property_padding_left : RULE);
    Property "padding-right", (module Property_padding_right : RULE);
    Property "padding-top", (module Property_padding_top : RULE);
    Property "page", (module Property_page : RULE);
    Property "paint-order", (module Property_paint_order : RULE);
    Property "pause", (module Property_pause : RULE);
    Property "pause-after", (module Property_pause_after : RULE);
    Property "pause-before", (module Property_pause_before : RULE);
    Property "perspective", (module Property_perspective : RULE);
    Property "place-content", (module Property_place_content : RULE);
    Property "place-items", (module Property_place_items : RULE);
    Property "place-self", (module Property_place_self : RULE);
    Property "position-anchor", (module Property_position_anchor : RULE);
    Property "position-area", (module Property_position_area : RULE);
    Property "position-try", (module Property_position_try : RULE);
    ( Property "position-try-fallbacks",
      (module Property_position_try_fallbacks : RULE) );
    ( Property "position-try-options",
      (module Property_position_try_options : RULE) );
    Property "position-visibility", (module Property_position_visibility : RULE);
    Property "quotes", (module Property_quotes : RULE);
    Property "r", (module Property_r : RULE);
    Property "reading-flow", (module Property_reading_flow : RULE);
    Property "rest", (module Property_rest : RULE);
    Property "rest-after", (module Property_rest_after : RULE);
    Property "rest-before", (module Property_rest_before : RULE);
    Property "right", (module Property_right : RULE);
    Property "rotate", (module Property_rotate : RULE);
    Property "ruby-align", (module Property_ruby_align : RULE);
    Property "ruby-overhang", (module Property_ruby_overhang : RULE);
    Property "rx", (module Property_rx : RULE);
    Property "ry", (module Property_ry : RULE);
    Property "scale", (module Property_scale : RULE);
    Property "scroll-margin", (module Property_scroll_margin : RULE);
    Property "scroll-margin-block", (module Property_scroll_margin_block : RULE);
    ( Property "scroll-margin-block-end",
      (module Property_scroll_margin_block_end : RULE) );
    ( Property "scroll-margin-block-start",
      (module Property_scroll_margin_block_start : RULE) );
    ( Property "scroll-margin-bottom",
      (module Property_scroll_margin_bottom : RULE) );
    ( Property "scroll-margin-inline",
      (module Property_scroll_margin_inline : RULE) );
    ( Property "scroll-margin-inline-end",
      (module Property_scroll_margin_inline_end : RULE) );
    ( Property "scroll-margin-inline-start",
      (module Property_scroll_margin_inline_start : RULE) );
    Property "scroll-margin-left", (module Property_scroll_margin_left : RULE);
    Property "scroll-margin-right", (module Property_scroll_margin_right : RULE);
    Property "scroll-margin-top", (module Property_scroll_margin_top : RULE);
    Property "scroll-marker-group", (module Property_scroll_marker_group : RULE);
    Property "scroll-padding", (module Property_scroll_padding : RULE);
    ( Property "scroll-padding-block",
      (module Property_scroll_padding_block : RULE) );
    ( Property "scroll-padding-block-end",
      (module Property_scroll_padding_block_end : RULE) );
    ( Property "scroll-padding-block-start",
      (module Property_scroll_padding_block_start : RULE) );
    ( Property "scroll-padding-bottom",
      (module Property_scroll_padding_bottom : RULE) );
    ( Property "scroll-padding-inline",
      (module Property_scroll_padding_inline : RULE) );
    ( Property "scroll-padding-inline-end",
      (module Property_scroll_padding_inline_end : RULE) );
    ( Property "scroll-padding-inline-start",
      (module Property_scroll_padding_inline_start : RULE) );
    Property "scroll-padding-left", (module Property_scroll_padding_left : RULE);
    ( Property "scroll-padding-right",
      (module Property_scroll_padding_right : RULE) );
    Property "scroll-padding-top", (module Property_scroll_padding_top : RULE);
    Property "scroll-snap-align", (module Property_scroll_snap_align : RULE);
    ( Property "scroll-snap-coordinate",
      (module Property_scroll_snap_coordinate : RULE) );
    ( Property "scroll-snap-destination",
      (module Property_scroll_snap_destination : RULE) );
    ( Property "scroll-snap-points-x",
      (module Property_scroll_snap_points_x : RULE) );
    ( Property "scroll-snap-points-y",
      (module Property_scroll_snap_points_y : RULE) );
    Property "scroll-snap-type", (module Property_scroll_snap_type : RULE);
    Property "scroll-snap-type-x", (module Property_scroll_snap_type_x : RULE);
    Property "scroll-snap-type-y", (module Property_scroll_snap_type_y : RULE);
    Property "scroll-start", (module Property_scroll_start : RULE);
    Property "scroll-start-block", (module Property_scroll_start_block : RULE);
    Property "scroll-start-inline", (module Property_scroll_start_inline : RULE);
    Property "scroll-start-target", (module Property_scroll_start_target : RULE);
    ( Property "scroll-start-target-block",
      (module Property_scroll_start_target_block : RULE) );
    ( Property "scroll-start-target-inline",
      (module Property_scroll_start_target_inline : RULE) );
    ( Property "scroll-start-target-x",
      (module Property_scroll_start_target_x : RULE) );
    ( Property "scroll-start-target-y",
      (module Property_scroll_start_target_y : RULE) );
    Property "scroll-start-x", (module Property_scroll_start_x : RULE);
    Property "scroll-start-y", (module Property_scroll_start_y : RULE);
    Property "scroll-timeline", (module Property_scroll_timeline : RULE);
    ( Property "scroll-timeline-axis",
      (module Property_scroll_timeline_axis : RULE) );
    ( Property "scroll-timeline-name",
      (module Property_scroll_timeline_name : RULE) );
    ( Property "scrollbar-3dlight-color",
      (module Property_scrollbar_3dlight_color : RULE) );
    ( Property "scrollbar-arrow-color",
      (module Property_scrollbar_arrow_color : RULE) );
    ( Property "scrollbar-base-color",
      (module Property_scrollbar_base_color : RULE) );
    Property "scrollbar-color", (module Property_scrollbar_color : RULE);
    ( Property "scrollbar-color-legacy",
      (module Property_scrollbar_color_legacy : RULE) );
    ( Property "scrollbar-darkshadow-color",
      (module Property_scrollbar_darkshadow_color : RULE) );
    ( Property "scrollbar-face-color",
      (module Property_scrollbar_face_color : RULE) );
    Property "scrollbar-gutter", (module Property_scrollbar_gutter : RULE);
    ( Property "scrollbar-highlight-color",
      (module Property_scrollbar_highlight_color : RULE) );
    ( Property "scrollbar-shadow-color",
      (module Property_scrollbar_shadow_color : RULE) );
    ( Property "scrollbar-track-color",
      (module Property_scrollbar_track_color : RULE) );
    ( Property "shape-image-threshold",
      (module Property_shape_image_threshold : RULE) );
    Property "shape-margin", (module Property_shape_margin : RULE);
    Property "shape-outside", (module Property_shape_outside : RULE);
    Property "shape-rendering", (module Property_shape_rendering : RULE);
    Property "size", (module Property_size : RULE);
    Property "speak-as", (module Property_speak_as : RULE);
    Property "src", (module Property_src : RULE);
    Property "stop-color", (module Property_stop_color : RULE);
    Property "stop-opacity", (module Property_stop_opacity : RULE);
    Property "stroke", (module Property_stroke : RULE);
    Property "stroke-dasharray", (module Property_stroke_dasharray : RULE);
    Property "stroke-dashoffset", (module Property_stroke_dashoffset : RULE);
    Property "stroke-miterlimit", (module Property_stroke_miterlimit : RULE);
    Property "stroke-opacity", (module Property_stroke_opacity : RULE);
    Property "stroke-width", (module Property_stroke_width : RULE);
    Property "syntax", (module Property_syntax : RULE);
    Property "tab-size", (module Property_tab_size : RULE);
    Property "text-align-all", (module Property_text_align_all : RULE);
    Property "text-anchor", (module Property_text_anchor : RULE);
    Property "text-autospace", (module Property_text_autospace : RULE);
    Property "text-blink", (module Property_text_blink : RULE);
    Property "text-box-edge", (module Property_text_box_edge : RULE);
    Property "text-box-trim", (module Property_text_box_trim : RULE);
    ( Property "text-combine-upright",
      (module Property_text_combine_upright : RULE) );
    Property "text-decoration", (module Property_text_decoration : RULE);
    ( Property "text-decoration-color",
      (module Property_text_decoration_color : RULE) );
    ( Property "text-decoration-skip",
      (module Property_text_decoration_skip : RULE) );
    ( Property "text-decoration-skip-box",
      (module Property_text_decoration_skip_box : RULE) );
    ( Property "text-decoration-skip-inset",
      (module Property_text_decoration_skip_inset : RULE) );
    ( Property "text-decoration-skip-self",
      (module Property_text_decoration_skip_self : RULE) );
    ( Property "text-decoration-skip-spaces",
      (module Property_text_decoration_skip_spaces : RULE) );
    Property "text-edge", (module Property_text_edge : RULE);
    Property "text-emphasis", (module Property_text_emphasis : RULE);
    Property "text-emphasis-color", (module Property_text_emphasis_color : RULE);
    ( Property "text-emphasis-position",
      (module Property_text_emphasis_position : RULE) );
    Property "text-emphasis-style", (module Property_text_emphasis_style : RULE);
    Property "text-indent", (module Property_text_indent : RULE);
    Property "text-justify-trim", (module Property_text_justify_trim : RULE);
    Property "text-kashida", (module Property_text_kashida : RULE);
    Property "text-kashida-space", (module Property_text_kashida_space : RULE);
    Property "text-overflow", (module Property_text_overflow : RULE);
    Property "text-shadow", (module Property_text_shadow : RULE);
    Property "text-size-adjust", (module Property_text_size_adjust : RULE);
    Property "text-spacing-trim", (module Property_text_spacing_trim : RULE);
    ( Property "text-underline-offset",
      (module Property_text_underline_offset : RULE) );
    Property "text-wrap", (module Property_text_wrap : RULE);
    Property "text-wrap-mode", (module Property_text_wrap_mode : RULE);
    Property "text-wrap-style", (module Property_text_wrap_style : RULE);
    Property "timeline-scope", (module Property_timeline_scope : RULE);
    Property "top", (module Property_top : RULE);
    Property "transform", (module Property_transform : RULE);
    Property "transform-origin", (module Property_transform_origin : RULE);
    Property "transition", (module Property_transition : RULE);
    Property "transition-behavior", (module Property_transition_behavior : RULE);
    Property "transition-delay", (module Property_transition_delay : RULE);
    Property "transition-duration", (module Property_transition_duration : RULE);
    Property "transition-property", (module Property_transition_property : RULE);
    ( Property "transition-timing-function",
      (module Property_transition_timing_function : RULE) );
    Property "translate", (module Property_translate : RULE);
    Property "unicode-range", (module Property_unicode_range : RULE);
    Property "vector-effect", (module Property_vector_effect : RULE);
    Property "vertical-align", (module Property_vertical_align : RULE);
    Property "view-timeline", (module Property_view_timeline : RULE);
    Property "view-timeline-axis", (module Property_view_timeline_axis : RULE);
    Property "view-timeline-inset", (module Property_view_timeline_inset : RULE);
    Property "view-timeline-name", (module Property_view_timeline_name : RULE);
    ( Property "view-transition-name",
      (module Property_view_transition_name : RULE) );
    Property "voice-balance", (module Property_voice_balance : RULE);
    Property "voice-duration", (module Property_voice_duration : RULE);
    Property "voice-family", (module Property_voice_family : RULE);
    Property "voice-pitch", (module Property_voice_pitch : RULE);
    Property "voice-range", (module Property_voice_range : RULE);
    Property "voice-rate", (module Property_voice_rate : RULE);
    Property "voice-stress", (module Property_voice_stress : RULE);
    Property "voice-volume", (module Property_voice_volume : RULE);
    ( Property "white-space-collapse",
      (module Property_white_space_collapse : RULE) );
    Property "widows", (module Property_widows : RULE);
    ( Property "word-space-transform",
      (module Property_word_space_transform : RULE) );
    Property "word-spacing", (module Property_word_spacing : RULE);
    Property "x", (module Property_x : RULE);
    Property "y", (module Property_y : RULE);
    Property "z-index", (module Property_z_index : RULE);
    Property "zoom", (module Property_zoom : RULE);
    (* ============================================= *)
    (* Missing Functions - Added via registry scan *)
    (* ============================================= *)
    Function "blur()", (module Function_blur : RULE);
    Function "brightness()", (module Function_brightness : RULE);
    Function "circle()", (module Function_circle : RULE);
    Function "clamp()", (module Function_clamp : RULE);
    Function "contrast()", (module Function_contrast : RULE);
    Function "counter()", (module Function_counter : RULE);
    Function "counters()", (module Function_counters : RULE);
    Function "drop-shadow()", (module Function_drop_shadow : RULE);
    Function "ellipse()", (module Function_ellipse : RULE);
    Function "env()", (module Function_env : RULE);
    Function "fit-content()", (module Function_fit_content : RULE);
    Function "grayscale()", (module Function_grayscale : RULE);
    Function "hue-rotate()", (module Function_hue_rotate : RULE);
    Function "inset()", (module Function_inset : RULE);
    Function "invert()", (module Function_invert : RULE);
    Function "leader()", (module Function_leader : RULE);
    Function "minmax()", (module Function_minmax : RULE);
    Function "opacity()", (module Function_opacity : RULE);
    Function "path()", (module Function_path : RULE);
    Function "polygon()", (module Function_polygon : RULE);
    Function "saturate()", (module Function_saturate : RULE);
    Function "sepia()", (module Function_sepia : RULE);
    Function "target-counter()", (module Function_target_counter : RULE);
    Function "target-counters()", (module Function_target_counters : RULE);
    Function "target-text()", (module Function_target_text : RULE);
    (* ============================================= *)
    (* Missing Values - Added via registry scan *)
    (* ============================================= *)
    Value "angular-color-hint", (module Angular_color_hint : RULE);
    Value "angular-color-stop", (module Angular_color_stop : RULE);
    Value "angular-color-stop-list", (module Angular_color_stop_list : RULE);
    Value "animateable-feature", (module Animateable_feature : RULE);
    Value "attr-fallback", (module Attr_fallback : RULE);
    Value "attr-matcher", (module Attr_matcher : RULE);
    Value "attr-name", (module Attr_name : RULE);
    Value "attr-type", (module Attr_type : RULE);
    Value "attr-unit", (module Attr_unit : RULE);
    Value "attribute-selector", (module Attribute_selector : RULE);
    Value "bg-layer", (module Bg_layer : RULE);
    Value "border-radius", (module Border_radius : RULE);
    Value "bottom", (module Bottom : RULE);
    Value "cf-final-image", (module Cf_final_image : RULE);
    Value "cf-mixing-image", (module Cf_mixing_image : RULE);
    Value "class-selector", (module Class_selector : RULE);
    Value "clip-source", (module Clip_source : RULE);
    Value "color-stop", (module Color_stop : RULE);
    Value "color-stop-angle", (module Color_stop_angle : RULE);
    Value "color-stop-length", (module Color_stop_length : RULE);
    Value "complex-selector", (module Complex_selector : RULE);
    Value "complex-selector-list", (module Complex_selector_list : RULE);
    Value "compound-selector", (module Compound_selector : RULE);
    Value "compound-selector-list", (module Compound_selector_list : RULE);
    Value "container-condition-list", (module Container_condition_list : RULE);
    Value "counter-name", (module Counter_name : RULE);
    Value "declaration", (module Declaration : RULE);
    Value "declaration-list", (module Declaration_list : RULE);
    Value "display-listitem", (module Display_listitem : RULE);
    Value "explicit-track-list", (module Explicit_track_list : RULE);
    Value "extended-angle", (module Extended_angle : RULE);
    Value "extended-frequency", (module Extended_frequency : RULE);
    Value "extended-length", (module Extended_length : RULE);
    Value "extended-percentage", (module Extended_percentage : RULE);
    Value "extended-time", (module Extended_time : RULE);
    Value "feature-tag-value", (module Feature_tag_value : RULE);
    Value "feature-value-block", (module Feature_value_block : RULE);
    Value "feature-value-block-list", (module Feature_value_block_list : RULE);
    Value "feature-value-declaration", (module Feature_value_declaration : RULE);
    ( Value "feature-value-declaration-list",
      (module Feature_value_declaration_list : RULE) );
    Value "filter-function-list", (module Filter_function_list : RULE);
    Value "final-bg-layer", (module Final_bg_layer : RULE);
    Value "font-stretch-absolute", (module Font_stretch_absolute : RULE);
    Value "general-enclosed", (module General_enclosed : RULE);
    Value "generic-voice", (module Generic_voice : RULE);
    Value "hue-interpolation-method", (module Hue_interpolation_method : RULE);
    Value "id-selector", (module Id_selector : RULE);
    Value "image-set-option", (module Image_set_option : RULE);
    Value "image-src", (module Image_src : RULE);
    Value "inflexible-breadth", (module Inflexible_breadth : RULE);
    Value "keyframe-block", (module Keyframe_block : RULE);
    Value "keyframe-block-list", (module Keyframe_block_list : RULE);
    Value "keyframe-selector", (module Keyframe_selector : RULE);
    Value "leader-type", (module Leader_type : RULE);
    Value "left", (module Left : RULE);
    Value "line-name-list", (module Line_name_list : RULE);
    Value "linear-color-hint", (module Linear_color_hint : RULE);
    Value "linear-color-stop", (module Linear_color_stop : RULE);
    Value "mask-image", (module Mask_image : RULE);
    Value "mask-layer", (module Mask_layer : RULE);
    Value "mask-position", (module Mask_position : RULE);
    Value "name-repeat", (module Name_repeat : RULE);
    Value "namespace-prefix", (module Namespace_prefix : RULE);
    Value "ns-prefix", (module Ns_prefix : RULE);
    Value "nth", (module Nth : RULE);
    Value "number-one-or-greater", (module Number_one_or_greater : RULE);
    Value "number-zero-one", (module Number_zero_one : RULE);
    Value "one-bg-size", (module One_bg_size : RULE);
    Value "page-body", (module Page_body : RULE);
    Value "page-margin-box", (module Page_margin_box : RULE);
    Value "page-selector", (module Page_selector : RULE);
    Value "page-selector-list", (module Page_selector_list : RULE);
    Value "paint", (module Paint : RULE);
    Value "positive-integer", (module Positive_integer : RULE);
    Value "pseudo-class-selector", (module Pseudo_class_selector : RULE);
    Value "pseudo-element-selector", (module Pseudo_element_selector : RULE);
    Value "pseudo-page", (module Pseudo_page : RULE);
    Value "radial-size", (module Radial_size : RULE);
    Value "ray-size", (module Ray_size : RULE);
    Value "relative-selector", (module Relative_selector : RULE);
    Value "relative-selector-list", (module Relative_selector_list : RULE);
    Value "right", (module Right : RULE);
    Value "shape", (module Shape : RULE);
    Value "shape-radius", (module Shape_radius : RULE);
    Value "single-transition", (module Single_transition : RULE);
    ( Value "single-transition-no-interp",
      (module Single_transition_no_interp : RULE) );
    ( Value "single-transition-property-no-interp",
      (module Single_transition_property_no_interp : RULE) );
    Value "size", (module Size : RULE);
    Value "subclass-selector", (module Subclass_selector : RULE);
    Value "supports-condition", (module Supports_condition : RULE);
    Value "supports-decl", (module Supports_decl : RULE);
    Value "supports-feature", (module Supports_feature : RULE);
    Value "supports-in-parens", (module Supports_in_parens : RULE);
    Value "supports-selector-fn", (module Supports_selector_fn : RULE);
    Value "svg-writing-mode", (module Svg_writing_mode : RULE);
    Value "symbol", (module Symbol : RULE);
    Value "syntax", (module Syntax : RULE);
    Value "syntax-combinator", (module Syntax_combinator : RULE);
    Value "syntax-component", (module Syntax_component : RULE);
    Value "syntax-multiplier", (module Syntax_multiplier : RULE);
    Value "syntax-single-component", (module Syntax_single_component : RULE);
    Value "syntax-string", (module Syntax_string : RULE);
    Value "syntax-type-name", (module Syntax_type_name : RULE);
    Value "target", (module Target : RULE);
    Value "top", (module Top : RULE);
    Value "track-group", (module Track_group : RULE);
    Value "track-list-v0", (module Track_list_v0 : RULE);
    Value "track-minmax", (module Track_minmax : RULE);
    Value "transition-behavior-value", (module Transition_behavior_value : RULE);
    ( Value "transition-behavior-value-no-interp",
      (module Transition_behavior_value_no_interp : RULE) );
    Value "try-tactic", (module Try_tactic : RULE);
    Value "type-or-unit", (module Type_or_unit : RULE);
    Value "type-selector", (module Type_selector : RULE);
    Value "viewport-length", (module Viewport_length : RULE);
    ( Value "webkit-gradient-color-stop",
      (module Webkit_gradient_color_stop : RULE) );
    Value "webkit-gradient-point", (module Webkit_gradient_point : RULE);
    Value "webkit-gradient-radius", (module Webkit_gradient_radius : RULE);
    Value "wq-name", (module Wq_name : RULE);
    Value "x", (module X : RULE);
    Value "y", (module Y : RULE);
  ]

let () = registry_ref := registry

let find_property (name : string) : (module RULE) option =
  List.find_opt (fun (k, _) -> k = Property name) registry |> Option.map snd

let find_value (name : string) : (module RULE) option =
  List.find_opt (fun (k, _) -> k = Value name) registry |> Option.map snd

let find_function (name : string) : (module RULE) option =
  List.find_opt (fun (k, _) -> k = Function name) registry |> Option.map snd

let find_media_query (name : string) : (module RULE) option =
  List.find_opt (fun (k, _) -> k = Media_query name) registry |> Option.map snd

let value_names () : string list =
  registry
  |> List.filter_map (fun (k, _) ->
       match k with Value name -> Some name | _ -> None)

let function_names () : string list =
  registry
  |> List.filter_map (fun (k, _) ->
       match k with Function name -> Some name | _ -> None)

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
  | Some rule ->
    let module R = (val rule : RULE) in
    (match parse R.rule value with
    | Ok _ -> Ok ()
    | Error message -> Error (loc, `Invalid_value message))
  | None -> Error (loc, `Property_not_found)
