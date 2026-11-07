open Types
open Support

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

let entries : (kind * packed_rule) list =
  [
    Property "layout-grid", pack_module (module Property_layout_grid);
    Property "layout-grid-char", pack_module (module Property_layout_grid_char);
    Property "layout-grid-line", pack_module (module Property_layout_grid_line);
    Property "layout-grid-mode", pack_module (module Property_layout_grid_mode);
    Property "layout-grid-type", pack_module (module Property_layout_grid_type);
  ]
