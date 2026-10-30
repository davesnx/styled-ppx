open Types
open Support

module Property_src =
  [%spec_module
  "[ <url> [ format( [ <string> ]# ) ]? | local( <family-name> ) ]#",
  (module Css_types.Src)]

let property_src : property_src Rule.rule = Property_src.rule

module Property_unicode_range =
  [%spec_module
  "[ <urange> ]#", (module Css_types.UnicodeRange)]

let property_unicode_range : property_unicode_range Rule.rule =
  Property_unicode_range.rule

module Property_marks =
  [%spec_module
  "'none' | 'crop' || 'cross'", (module Css_types.Marks)]

let property_marks : property_marks Rule.rule = Property_marks.rule

module Property_bleed =
  [%spec_module
  "'auto' | <extended-length>", (module Css_types.Bleed)]

let property_bleed : property_bleed Rule.rule = Property_bleed.rule

module Property_inherits =
  [%spec_module
  "'true' | 'false'", (module Css_types.Inherits)]

let property_inherits : property_inherits Rule.rule = Property_inherits.rule

module Property_initial_value =
  [%spec_module
  "<string>", (module Css_types.InitialValue)]

let property_initial_value : property_initial_value Rule.rule =
  Property_initial_value.rule

module Property_page =
  [%spec_module
  "'auto' | <custom-ident>", (module Css_types.Page)]

let property_page : property_page Rule.rule = Property_page.rule

module Property_ascent_override =
  [%spec_module
  "'normal' | <percentage>", (module Css_types.Cascading)]

let property_ascent_override = Property_ascent_override.rule

module Property_descent_override =
  [%spec_module
  "'normal' | <percentage>", (module Css_types.Cascading)]

let property_descent_override = Property_descent_override.rule

module Property_line_gap_override =
  [%spec_module
  "'normal' | <percentage>", (module Css_types.Cascading)]

let property_line_gap_override = Property_line_gap_override.rule

module Property_size_adjust =
  [%spec_module
  "<percentage>", (module Css_types.Cascading)]

let property_size_adjust = Property_size_adjust.rule

(* @view-transition (css-view-transitions-2), @font-palette-values
   (css-fonts-4) and @counter-style (css-counter-styles-3) descriptors. Like
   the @font-face metric overrides above they are not runtime values, so they
   reuse the Cascading placeholder witness. Css_validation scopes each name to
   its at-rule. *)

module Property_navigation =
  [%spec_module
  "'auto' | 'none'", (module Css_types.Cascading)]

let property_navigation = Property_navigation.rule

module Property_types =
  [%spec_module
  "'none' | [ <custom-ident> ]+", (module Css_types.Cascading)]

let property_types = Property_types.rule

module Property_base_palette =
  [%spec_module
  "'light' | 'dark' | <integer>", (module Css_types.Cascading)]

let property_base_palette = Property_base_palette.rule

module Property_override_colors =
  [%spec_module
  "[ <integer> <color> ]#", (module Css_types.Cascading)]

let property_override_colors = Property_override_colors.rule

module Property_system =
  [%spec_module
  "'cyclic' | 'numeric' | 'alphabetic' | 'symbolic' | 'additive' | [ 'fixed' \
   <integer>? ] | [ 'extends' <counter-style-name> ]",
  (module Css_types.Cascading)]

let property_system = Property_system.rule

module Property_symbols =
  [%spec_module
  "[ <symbol> ]+", (module Css_types.Cascading)]

let property_symbols = Property_symbols.rule

module Property_negative =
  [%spec_module
  "<symbol> <symbol>?", (module Css_types.Cascading)]

let property_negative = Property_negative.rule

module Property_range =
  [%spec_module
  "[ [ <integer> | 'infinite' ]{2} ]# | 'auto'", (module Css_types.Cascading)]

let property_range = Property_range.rule

module Property_pad =
  [%spec_module
  "<integer> && <symbol>", (module Css_types.Cascading)]

let property_pad = Property_pad.rule

module Property_fallback =
  [%spec_module
  "<counter-style-name>", (module Css_types.Cascading)]

let property_fallback = Property_fallback.rule

module Property_prefix = [%spec_module "<symbol>", (module Css_types.Cascading)]

let property_prefix = Property_prefix.rule

module Property_suffix = [%spec_module "<symbol>", (module Css_types.Cascading)]

let property_suffix = Property_suffix.rule

module Property_additive_symbols =
  [%spec_module
  "[ <integer> && <symbol> ]#", (module Css_types.Cascading)]

let property_additive_symbols = Property_additive_symbols.rule

(* Additional modern properties *)

let entries : (kind * packed_rule) list =
  [
    Property "inherits", pack_module (module Property_inherits);
    Property "initial-value", pack_module (module Property_initial_value);
    Property "page", pack_module (module Property_page);
    Property "src", pack_module (module Property_src);
    Property "unicode-range", pack_module (module Property_unicode_range);
    Property "bleed", pack_module (module Property_bleed);
    Property "marks", pack_module (module Property_marks);
    Property "ascent-override", pack_module (module Property_ascent_override);
    Property "descent-override", pack_module (module Property_descent_override);
    ( Property "line-gap-override",
      pack_module (module Property_line_gap_override) );
    Property "size-adjust", pack_module (module Property_size_adjust);
    Property "navigation", pack_module (module Property_navigation);
    Property "types", pack_module (module Property_types);
    Property "base-palette", pack_module (module Property_base_palette);
    Property "override-colors", pack_module (module Property_override_colors);
    Property "system", pack_module (module Property_system);
    Property "symbols", pack_module (module Property_symbols);
    Property "negative", pack_module (module Property_negative);
    Property "range", pack_module (module Property_range);
    Property "pad", pack_module (module Property_pad);
    Property "fallback", pack_module (module Property_fallback);
    Property "prefix", pack_module (module Property_prefix);
    Property "suffix", pack_module (module Property_suffix);
    Property "additive-symbols", pack_module (module Property_additive_symbols);
  ]
