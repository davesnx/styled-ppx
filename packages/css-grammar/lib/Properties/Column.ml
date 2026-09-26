open Types
open Support

module Property_column_count =
  [%spec_module
  "<integer> | 'auto'", (module Css_types.ColumnCount)]

let property_column_count : property_column_count Rule.rule =
  Property_column_count.rule

module Property_column_height =
  [%spec_module
  "'auto' | <extended-length>", (module Css_types.Cascading)]

let property_column_height = Property_column_height.rule

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

(* CSS Gaps L1 § 4.4 (supersedes css-multicol-1's plain triple):
   https://drafts.csswg.org/css-gaps-1/#propdef-column-rule *)
module Property_column_rule =
  [%spec_module
  "<gap-rule-list> | <gap-auto-rule-list>", (module Css_types.GapRuleList)]

let property_column_rule : property_column_rule Rule.rule =
  Property_column_rule.rule

(* CSS Gaps L1 § 4.1 (supersedes css-multicol-1's plain <color>):
   https://drafts.csswg.org/css-gaps-1/#propdef-column-rule-color *)
module Property_column_rule_color =
  [%spec_module
  "<line-color-list> | <auto-line-color-list>", (module Css_types.Color)]

let property_column_rule_color : property_column_rule_color Rule.rule =
  Property_column_rule_color.rule

(* CSS Gaps L1 § 4.2 (supersedes css-multicol-1's plain <'border-style'>):
   https://drafts.csswg.org/css-gaps-1/#propdef-column-rule-style *)
module Property_column_rule_style =
  [%spec_module
  "<line-style-list> | <auto-line-style-list>",
  (module Css_types.ColumnRuleStyle)]

let property_column_rule_style : property_column_rule_style Rule.rule =
  Property_column_rule_style.rule

(* CSS Gaps L1 § 4.3 (supersedes css-multicol-1's plain <'border-width'>):
   https://drafts.csswg.org/css-gaps-1/#propdef-column-rule-width *)
module Property_column_rule_width =
  [%spec_module
  "<line-width-list> | <auto-line-width-list>",
  (module Css_types.ColumnRuleWidth)]

let property_column_rule_width : property_column_rule_width Rule.rule =
  Property_column_rule_width.rule

(* CSS Gaps L1 § 3.2: https://drafts.csswg.org/css-gaps-1/#propdef-column-rule-break *)
module Property_column_rule_break =
  [%spec_module
  "'none' | 'normal' | 'intersection'", (module Css_types.ColumnRuleBreak)]

let property_column_rule_break : property_column_rule_break Rule.rule =
  Property_column_rule_break.rule

(* CSS Gaps L1 § 3.3: leaves - https://drafts.csswg.org/css-gaps-1/#propdef-column-rule-inset-cap-start *)
module Property_column_rule_inset_cap_start =
  [%spec_module
  "<inset-value>", (module Css_types.InsetValue)]

let property_column_rule_inset_cap_start :
  property_column_rule_inset_cap_start Rule.rule =
  Property_column_rule_inset_cap_start.rule

module Property_column_rule_inset_cap_end =
  [%spec_module
  "<inset-value>", (module Css_types.InsetValue)]

let property_column_rule_inset_cap_end :
  property_column_rule_inset_cap_end Rule.rule =
  Property_column_rule_inset_cap_end.rule

module Property_column_rule_inset_junction_start =
  [%spec_module
  "<inset-value>", (module Css_types.InsetValue)]

let property_column_rule_inset_junction_start :
  property_column_rule_inset_junction_start Rule.rule =
  Property_column_rule_inset_junction_start.rule

module Property_column_rule_inset_junction_end =
  [%spec_module
  "<inset-value>", (module Css_types.InsetValue)]

let property_column_rule_inset_junction_end :
  property_column_rule_inset_junction_end Rule.rule =
  Property_column_rule_inset_junction_end.rule

(* CSS Gaps L1 § 3.3.2 (-cap-/-junction- shorthands, 1 or 2 values):
   https://drafts.csswg.org/css-gaps-1/#propdef-column-rule-inset-cap *)
module Property_column_rule_inset_cap =
  [%spec_module
  "<inset-value> [ <inset-value> ]?", (module Css_types.InsetValue)]

let property_column_rule_inset_cap : property_column_rule_inset_cap Rule.rule =
  Property_column_rule_inset_cap.rule

module Property_column_rule_inset_junction =
  [%spec_module
  "<inset-value> [ <inset-value> ]?", (module Css_types.InsetValue)]

let property_column_rule_inset_junction :
  property_column_rule_inset_junction Rule.rule =
  Property_column_rule_inset_junction.rule

(* CSS Gaps L1 § 3.3.1 (-start/-end shorthands): column-rule-inset-start
   itself is not browser-implemented (no BCD entry; asymmetric with
   row-rule-inset-start, which is), so only column-rule-inset-end is added -
   https://drafts.csswg.org/css-gaps-1/#propdef-column-rule-inset-start *)
module Property_column_rule_inset_end =
  [%spec_module
  "<inset-value>", (module Css_types.InsetValue)]

let property_column_rule_inset_end : property_column_rule_inset_end Rule.rule =
  Property_column_rule_inset_end.rule

(* CSS Gaps L1 § 3.3.3 (universal shorthand):
   https://drafts.csswg.org/css-gaps-1/#propdef-column-rule-inset *)
module Property_column_rule_inset =
  [%spec_module
  "<'column-rule-inset-cap'> [ '/' <'column-rule-inset-junction'> ]?",
  (module Css_types.InsetValue)]

let property_column_rule_inset : property_column_rule_inset Rule.rule =
  Property_column_rule_inset.rule

(* CSS Gaps L1 § 3.4: https://drafts.csswg.org/css-gaps-1/#propdef-column-rule-visibility-items *)
module Property_column_rule_visibility_items =
  [%spec_module
  "'all' | 'around' | 'between' | 'normal'",
  (module Css_types.ColumnRuleVisibilityItems)]

let property_column_rule_visibility_items :
  property_column_rule_visibility_items Rule.rule =
  Property_column_rule_visibility_items.rule

module Property_column_span =
  [%spec_module
  "'none' | 'all'", (module Css_types.ColumnSpan)]

let property_column_span : property_column_span Rule.rule =
  Property_column_span.rule

module Property_column_wrap =
  [%spec_module
  "'auto' | 'nowrap' | 'wrap'", (module Css_types.Cascading)]

let property_column_wrap = Property_column_wrap.rule

module Property_column_width =
  [%spec_module
  "<extended-length> | 'auto'", (module Css_types.ColumnWidth)]

let property_column_width : property_column_width Rule.rule =
  Property_column_width.rule

let entries : (kind * packed_rule) list =
  [
    Property "column-fill", pack_module (module Property_column_fill);
    Property "column-height", pack_module (module Property_column_height);
    Property "column-span", pack_module (module Property_column_span);
    Property "column-wrap", pack_module (module Property_column_wrap);
    Property "column-gap", pack_module (module Property_column_gap);
    Property "column-count", pack_module (module Property_column_count);
    (* Multi-column Layout L2: https://www.w3.org/TR/css-multicol-2/#columns, #column-rule-style *)
    ( Shorthand
        ( "column-rule",
          [ "column-rule-color"; "column-rule-style"; "column-rule-width" ] ),
      pack_module (module Property_column_rule) );
    ( Property "column-rule-color",
      pack_module (module Property_column_rule_color) );
    ( Property "column-rule-style",
      pack_module (module Property_column_rule_style) );
    ( Property "column-rule-width",
      pack_module (module Property_column_rule_width) );
    Property "column-width", pack_module (module Property_column_width);
    (* CSS Gaps L1: https://drafts.csswg.org/css-gaps-1/ *)
    ( Property "column-rule-break",
      pack_module (module Property_column_rule_break) );
    ( Property "column-rule-inset-cap-start",
      pack_module (module Property_column_rule_inset_cap_start) );
    ( Property "column-rule-inset-cap-end",
      pack_module (module Property_column_rule_inset_cap_end) );
    ( Property "column-rule-inset-junction-start",
      pack_module (module Property_column_rule_inset_junction_start) );
    ( Property "column-rule-inset-junction-end",
      pack_module (module Property_column_rule_inset_junction_end) );
    ( Shorthand
        ( "column-rule-inset-cap",
          [ "column-rule-inset-cap-start"; "column-rule-inset-cap-end" ] ),
      pack_module (module Property_column_rule_inset_cap) );
    ( Shorthand
        ( "column-rule-inset-junction",
          [
            "column-rule-inset-junction-start"; "column-rule-inset-junction-end";
          ] ),
      pack_module (module Property_column_rule_inset_junction) );
    ( Shorthand
        ( "column-rule-inset-end",
          [ "column-rule-inset-cap-end"; "column-rule-inset-junction-end" ] ),
      pack_module (module Property_column_rule_inset_end) );
    ( Shorthand
        ( "column-rule-inset",
          [ "column-rule-inset-cap"; "column-rule-inset-junction" ] ),
      pack_module (module Property_column_rule_inset) );
    ( Property "column-rule-visibility-items",
      pack_module (module Property_column_rule_visibility_items) );
  ]
