open Types
open Support

module Property_table_layout =
  [%spec_module
  "'auto' | 'fixed'", (module Css_types.TableLayout)]

let property_table_layout : property_table_layout Rule.rule =
  Property_table_layout.rule

let entries : (kind * packed_rule) list =
  [
    Property "table-layout", pack_module (module Property_table_layout);
  ]
