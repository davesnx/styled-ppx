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

module Property_ascent_override =
  [%spec_module
  "'normal' | <extended-percentage>", (module Css_types.AscentOverride)]

let property_ascent_override : property_ascent_override Rule.rule =
  Property_ascent_override.rule

module Property_descent_override =
  [%spec_module
  "'normal' | <extended-percentage>", (module Css_types.DescentOverride)]

let property_descent_override : property_descent_override Rule.rule =
  Property_descent_override.rule

module Property_line_gap_override =
  [%spec_module
  "'normal' | <extended-percentage>", (module Css_types.LineGapOverride)]

let property_line_gap_override : property_line_gap_override Rule.rule =
  Property_line_gap_override.rule

module Property_size_adjust =
  [%spec_module
  "<extended-percentage>", (module Css_types.SizeAdjust)]

let property_size_adjust : property_size_adjust Rule.rule =
  Property_size_adjust.rule

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

(* @view-transition descriptors (css-view-transitions-2, issue #583) *)

module Property_navigation =
  [%spec_module
  "'auto' | 'none'", (module Css_types.ViewTransitionNavigation)]

let property_navigation : property_navigation Rule.rule =
  Property_navigation.rule

module Property_types =
  [%spec_module
  "'none' | [ <custom-ident> ]+", (module Css_types.ViewTransitionTypes)]

let property_types : property_types Rule.rule = Property_types.rule

(* @font-palette-values descriptors (css-fonts-4, issue #585). font-family
   inside the block is validated by the existing font-family property
   grammar (flat registry namespace). *)

module Property_base_palette =
  [%spec_module
  "'light' | 'dark' | <integer>", (module Css_types.BasePalette)]

let property_base_palette : property_base_palette Rule.rule =
  Property_base_palette.rule

module Property_override_colors =
  [%spec_module
  "[ <integer> <color> ]#", (module Css_types.OverrideColors)]

let property_override_colors : property_override_colors Rule.rule =
  Property_override_colors.rule

(* @counter-style descriptors (css-counter-styles-3, issue #584). The
   speak-as descriptor collides with the speak-as property in the flat
   registry namespace; its extra values live in Properties/SpeakAs.ml. *)

module Property_system =
  [%spec_module
  "'cyclic' | 'numeric' | 'alphabetic' | 'symbolic' | 'additive' | [ 'fixed' \
   <integer>? ] | [ 'extends' <counter-style-name> ]",
  (module Css_types.CounterStyleSystem)]

let property_system : property_system Rule.rule = Property_system.rule

module Property_symbols =
  [%spec_module
  "[ <symbol> ]+", (module Css_types.CounterStyleSymbols)]

let property_symbols : property_symbols Rule.rule = Property_symbols.rule

module Property_negative =
  [%spec_module
  "<symbol> <symbol>?", (module Css_types.CounterStyleNegative)]

let property_negative : property_negative Rule.rule = Property_negative.rule

module Property_range =
  [%spec_module
  "[ [ <integer> | 'infinite' ]{2} ]# | 'auto'",
  (module Css_types.CounterStyleRange)]

let property_range : property_range Rule.rule = Property_range.rule

module Property_pad =
  [%spec_module
  "<integer> && <symbol>", (module Css_types.CounterStylePad)]

let property_pad : property_pad Rule.rule = Property_pad.rule

module Property_fallback =
  [%spec_module
  "<counter-style-name>", (module Css_types.CounterStyleFallback)]

let property_fallback : property_fallback Rule.rule = Property_fallback.rule

module Property_prefix =
  [%spec_module
  "<symbol>", (module Css_types.CounterStylePrefix)]

let property_prefix : property_prefix Rule.rule = Property_prefix.rule

module Property_suffix =
  [%spec_module
  "<symbol>", (module Css_types.CounterStyleSuffix)]

let property_suffix : property_suffix Rule.rule = Property_suffix.rule

module Property_additive_symbols =
  [%spec_module
  "[ <integer> && <symbol> ]#", (module Css_types.CounterStyleAdditiveSymbols)]

let property_additive_symbols : property_additive_symbols Rule.rule =
  Property_additive_symbols.rule

(* Additional modern properties *)

let entries : (kind * packed_rule) list =
  [
    Property "inherits", pack_module (module Property_inherits);
    Property "initial-value", pack_module (module Property_initial_value);
    Property "page", pack_module (module Property_page);
    Property "src", pack_module (module Property_src);
    Property "unicode-range", pack_module (module Property_unicode_range);
    Property "ascent-override", pack_module (module Property_ascent_override);
    Property "descent-override", pack_module (module Property_descent_override);
    ( Property "line-gap-override",
      pack_module (module Property_line_gap_override) );
    Property "size-adjust", pack_module (module Property_size_adjust);
    Property "bleed", pack_module (module Property_bleed);
    Property "marks", pack_module (module Property_marks);
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
