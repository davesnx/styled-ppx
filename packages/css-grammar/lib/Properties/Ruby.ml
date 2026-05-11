open Types
open Support

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

module Property_ruby_overhang =
  [%spec_module
  "'auto' | 'none'", (module Css_types.RubyOverhang)]

let property_ruby_overhang : property_ruby_overhang Rule.rule =
  Property_ruby_overhang.rule

(* Timeline scope *)

let entries : (kind * packed_rule) list =
  [
    Property "ruby-merge", pack_module (module Property_ruby_merge);
    Property "ruby-position", pack_module (module Property_ruby_position);
    Property "ruby-align", pack_module (module Property_ruby_align);
    Property "ruby-overhang", pack_module (module Property_ruby_overhang);
  ]
