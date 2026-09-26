open Types
open Support

(* CSS Gaps L1: https://drafts.csswg.org/css-gaps-1/
   row-rule and its family mirror column-rule exactly (same typedefs, own
   longhands, no css-multicol-1 predecessor to supersede - row-rule is new). *)

module Property_row_rule =
  [%spec_module
  "<gap-rule-list> | <gap-auto-rule-list>", (module Css_types.GapRuleList)]

let property_row_rule : property_row_rule Rule.rule = Property_row_rule.rule

module Property_row_rule_color =
  [%spec_module
  "<line-color-list> | <auto-line-color-list>", (module Css_types.Color)]

let property_row_rule_color : property_row_rule_color Rule.rule =
  Property_row_rule_color.rule

module Property_row_rule_style =
  [%spec_module
  "<line-style-list> | <auto-line-style-list>",
  (module Css_types.ColumnRuleStyle)]

let property_row_rule_style : property_row_rule_style Rule.rule =
  Property_row_rule_style.rule

module Property_row_rule_width =
  [%spec_module
  "<line-width-list> | <auto-line-width-list>",
  (module Css_types.ColumnRuleWidth)]

let property_row_rule_width : property_row_rule_width Rule.rule =
  Property_row_rule_width.rule

module Property_row_rule_break =
  [%spec_module
  "'none' | 'normal' | 'intersection'", (module Css_types.ColumnRuleBreak)]

let property_row_rule_break : property_row_rule_break Rule.rule =
  Property_row_rule_break.rule

module Property_row_rule_inset_cap_start =
  [%spec_module
  "<inset-value>", (module Css_types.InsetValue)]

let property_row_rule_inset_cap_start :
  property_row_rule_inset_cap_start Rule.rule =
  Property_row_rule_inset_cap_start.rule

module Property_row_rule_inset_cap_end =
  [%spec_module
  "<inset-value>", (module Css_types.InsetValue)]

let property_row_rule_inset_cap_end : property_row_rule_inset_cap_end Rule.rule
    =
  Property_row_rule_inset_cap_end.rule

module Property_row_rule_inset_junction_start =
  [%spec_module
  "<inset-value>", (module Css_types.InsetValue)]

let property_row_rule_inset_junction_start :
  property_row_rule_inset_junction_start Rule.rule =
  Property_row_rule_inset_junction_start.rule

module Property_row_rule_inset_junction_end =
  [%spec_module
  "<inset-value>", (module Css_types.InsetValue)]

let property_row_rule_inset_junction_end :
  property_row_rule_inset_junction_end Rule.rule =
  Property_row_rule_inset_junction_end.rule

module Property_row_rule_inset_cap =
  [%spec_module
  "<inset-value> [ <inset-value> ]?", (module Css_types.InsetValue)]

let property_row_rule_inset_cap : property_row_rule_inset_cap Rule.rule =
  Property_row_rule_inset_cap.rule

module Property_row_rule_inset_junction =
  [%spec_module
  "<inset-value> [ <inset-value> ]?", (module Css_types.InsetValue)]

let property_row_rule_inset_junction :
  property_row_rule_inset_junction Rule.rule =
  Property_row_rule_inset_junction.rule

module Property_row_rule_inset_start =
  [%spec_module
  "<inset-value>", (module Css_types.InsetValue)]

let property_row_rule_inset_start : property_row_rule_inset_start Rule.rule =
  Property_row_rule_inset_start.rule

module Property_row_rule_inset_end =
  [%spec_module
  "<inset-value>", (module Css_types.InsetValue)]

let property_row_rule_inset_end : property_row_rule_inset_end Rule.rule =
  Property_row_rule_inset_end.rule

module Property_row_rule_inset =
  [%spec_module
  "<'row-rule-inset-cap'> [ '/' <'row-rule-inset-junction'> ]?",
  (module Css_types.InsetValue)]

let property_row_rule_inset : property_row_rule_inset Rule.rule =
  Property_row_rule_inset.rule

module Property_row_rule_visibility_items =
  [%spec_module
  "'all' | 'around' | 'between' | 'normal'",
  (module Css_types.ColumnRuleVisibilityItems)]

let property_row_rule_visibility_items :
  property_row_rule_visibility_items Rule.rule =
  Property_row_rule_visibility_items.rule

let entries : (kind * packed_rule) list =
  [
    ( Shorthand
        ("row-rule", [ "row-rule-color"; "row-rule-style"; "row-rule-width" ]),
      pack_module (module Property_row_rule) );
    Property "row-rule-color", pack_module (module Property_row_rule_color);
    Property "row-rule-style", pack_module (module Property_row_rule_style);
    Property "row-rule-width", pack_module (module Property_row_rule_width);
    Property "row-rule-break", pack_module (module Property_row_rule_break);
    ( Property "row-rule-inset-cap-start",
      pack_module (module Property_row_rule_inset_cap_start) );
    ( Property "row-rule-inset-cap-end",
      pack_module (module Property_row_rule_inset_cap_end) );
    ( Property "row-rule-inset-junction-start",
      pack_module (module Property_row_rule_inset_junction_start) );
    ( Property "row-rule-inset-junction-end",
      pack_module (module Property_row_rule_inset_junction_end) );
    ( Shorthand
        ( "row-rule-inset-cap",
          [ "row-rule-inset-cap-start"; "row-rule-inset-cap-end" ] ),
      pack_module (module Property_row_rule_inset_cap) );
    ( Shorthand
        ( "row-rule-inset-junction",
          [ "row-rule-inset-junction-start"; "row-rule-inset-junction-end" ] ),
      pack_module (module Property_row_rule_inset_junction) );
    ( Shorthand
        ( "row-rule-inset-start",
          [ "row-rule-inset-cap-start"; "row-rule-inset-junction-start" ] ),
      pack_module (module Property_row_rule_inset_start) );
    ( Shorthand
        ( "row-rule-inset-end",
          [ "row-rule-inset-cap-end"; "row-rule-inset-junction-end" ] ),
      pack_module (module Property_row_rule_inset_end) );
    ( Shorthand
        ("row-rule-inset", [ "row-rule-inset-cap"; "row-rule-inset-junction" ]),
      pack_module (module Property_row_rule_inset) );
    ( Property "row-rule-visibility-items",
      pack_module (module Property_row_rule_visibility_items) );
  ]
