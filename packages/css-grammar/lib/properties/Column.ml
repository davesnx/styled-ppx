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

module Property_column_rule =
  [%spec_module
  "<'column-rule-width'> || <'column-rule-style'> || <'column-rule-color'>",
  (module Css_types.ColumnRule)]

let property_column_rule : property_column_rule Rule.rule =
  Property_column_rule.rule

module Property_column_rule_color =
  [%spec_module
  "<color>", (module Css_types.Color)]

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
    Property "column-rule", pack_module (module Property_column_rule);
    ( Property "column-rule-color",
      pack_module (module Property_column_rule_color) );
    ( Property "column-rule-style",
      pack_module (module Property_column_rule_style) );
    ( Property "column-rule-width",
      pack_module (module Property_column_rule_width) );
    Property "column-width", pack_module (module Property_column_width);
  ]
