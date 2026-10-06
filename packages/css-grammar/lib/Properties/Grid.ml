open Types
open Support

(* CSS Grid Layout L3 (grid lanes containers): https://drafts.csswg.org/css-grid-3/#propdef-flow-tolerance *)
module Property_flow_tolerance =
  [%spec_module
  "'normal' | <extended-length> | <extended-percentage> | 'infinite'",
  (module Css_types.FlowTolerance)]

let property_flow_tolerance : property_flow_tolerance Rule.rule =
  Property_flow_tolerance.rule

module Property_grid =
  [%spec_module
  "<'grid-template'> | <'grid-template-rows'> '/' [ 'auto-flow' && [ 'dense' \
   ]? ] [ <'grid-auto-columns'> ]? | [ 'auto-flow' && [ 'dense' ]? ] [ \
   <'grid-auto-rows'> ]? '/' <'grid-template-columns'>",
  (module Css_types.Grid)]

let property_grid : property_grid Rule.rule = Property_grid.rule

module Property_grid_area =
  [%spec_module
  "<grid-line> [ '/' <grid-line> ]{0,3}", (module Css_types.GridArea)]

let property_grid_area : property_grid_area Rule.rule = Property_grid_area.rule

module Property_grid_auto_columns =
  [%spec_module
  "[ <track-size> ]+", (module Css_types.GridAutoColumns)]

let property_grid_auto_columns : property_grid_auto_columns Rule.rule =
  Property_grid_auto_columns.rule

module Property_grid_auto_flow =
  [%spec_module
  "[ [ 'row' | 'column' ] || 'dense' ] | <interpolation>",
  (module Css_types.GridAutoFlow)]

let property_grid_auto_flow : property_grid_auto_flow Rule.rule =
  Property_grid_auto_flow.rule

module Property__ms_grid_columns =
  [%spec_module
  "'none' | <track-list> | <auto-track-list> | 'subgrid' [ <line-name-list> ]? \
   | 'masonry' | <interpolation>",
  (module Css_types.GridTemplateColumns)]

let property__ms_grid_columns = Property__ms_grid_columns.rule

module Property__ms_grid_rows =
  [%spec_module
  "'none' | <track-list> | <auto-track-list> | 'subgrid' [ <line-name-list> ]? \
   | 'masonry' | <interpolation>",
  (module Css_types.GridTemplateRows)]

let property__ms_grid_rows = Property__ms_grid_rows.rule

module Property_grid_auto_rows =
  [%spec_module
  "[ <track-size> ]+", (module Css_types.GridAutoRows)]

let property_grid_auto_rows : property_grid_auto_rows Rule.rule =
  Property_grid_auto_rows.rule

module Property_grid_column =
  [%spec_module
  "<grid-line> [ '/' <grid-line> ]?", (module Css_types.GridColumn)]

let property_grid_column : property_grid_column Rule.rule =
  Property_grid_column.rule

module Property_grid_column_end =
  [%spec_module
  "<grid-line>", (module Css_types.GridColumnEnd)]

let property_grid_column_end : property_grid_column_end Rule.rule =
  Property_grid_column_end.rule

module Property_grid_column_gap =
  [%spec_module
  "<extended-length> | <extended-percentage>", (module Css_types.Gap)]

let property_grid_column_gap : property_grid_column_gap Rule.rule =
  Property_grid_column_gap.rule

module Property_grid_column_start =
  [%spec_module
  "<grid-line>", (module Css_types.GridColumnStart)]

let property_grid_column_start : property_grid_column_start Rule.rule =
  Property_grid_column_start.rule

module Property_grid_gap =
  [%spec_module
  "<'grid-row-gap'> [ <'grid-column-gap'> ]?", (module Css_types.Gap)]

let property_grid_gap : property_grid_gap Rule.rule = Property_grid_gap.rule

module Property_grid_row =
  [%spec_module
  "<grid-line> [ '/' <grid-line> ]?", (module Css_types.GridRow)]

let property_grid_row : property_grid_row Rule.rule = Property_grid_row.rule

module Property_grid_row_end =
  [%spec_module
  "<grid-line>", (module Css_types.GridRowEnd)]

let property_grid_row_end : property_grid_row_end Rule.rule =
  Property_grid_row_end.rule

module Property_grid_row_gap =
  [%spec_module
  "<extended-length> | <extended-percentage>", (module Css_types.Gap)]

let property_grid_row_gap : property_grid_row_gap Rule.rule =
  Property_grid_row_gap.rule

module Property_grid_row_start =
  [%spec_module
  "<grid-line>", (module Css_types.GridRowStart)]

let property_grid_row_start : property_grid_row_start Rule.rule =
  Property_grid_row_start.rule

module Property_grid_template =
  [%spec_module
  "'none' | <'grid-template-rows'> '/' <'grid-template-columns'> | [ [ \
   <line-names> ]? <string> [ <track-size> ]? [ <line-names> ]? ]+ [ '/' \
   <explicit-track-list> ]?",
  (module Css_types.GridTemplate)]

let property_grid_template : property_grid_template Rule.rule =
  Property_grid_template.rule

module Property_grid_template_areas =
  [%spec_module
  "'none' | [ <string> | <interpolation> ]+",
  (module Css_types.GridTemplateAreas)]

let property_grid_template_areas : property_grid_template_areas Rule.rule =
  Property_grid_template_areas.rule

module Property_grid_template_columns =
  [%spec_module
  "'none' | <track-list> | <auto-track-list> | 'subgrid' [ <line-name-list> ]? \
   | 'masonry' | <interpolation>",
  (module Css_types.GridTemplateColumns)]

let property_grid_template_columns : property_grid_template_columns Rule.rule =
  Property_grid_template_columns.rule

module Property_grid_template_rows =
  [%spec_module
  "'none' | <track-list> | <auto-track-list> | 'subgrid' [ <line-name-list> ]? \
   | 'masonry' | <interpolation>",
  (module Css_types.GridTemplateRows)]

let property_grid_template_rows : property_grid_template_rows Rule.rule =
  Property_grid_template_rows.rule

let entries : (kind * packed_rule) list =
  [
    Property "-ms-grid-columns", pack_module (module Property__ms_grid_columns);
    Property "-ms-grid-rows", pack_module (module Property__ms_grid_rows);
    Property "flow-tolerance", pack_module (module Property_flow_tolerance);
    Property "grid-auto-flow", pack_module (module Property_grid_auto_flow);
    (* Grid Layout L2: https://www.w3.org/TR/css-grid-2/#propdef-grid-template, #propdef-grid, #propdef-grid-area *)
    ( Shorthand
        ( "grid",
          [
            "grid-template";
            "grid-auto-rows";
            "grid-auto-columns";
            "grid-auto-flow";
          ] ),
      pack_module (module Property_grid) );
    (* Grid Layout L2: https://www.w3.org/TR/css-grid-2/#propdef-grid-template, #propdef-grid, #propdef-grid-area *)
    ( Shorthand ("grid-area", [ "grid-row"; "grid-column" ]),
      pack_module (module Property_grid_area) );
    ( Property "grid-auto-columns",
      pack_module (module Property_grid_auto_columns) );
    Property "grid-auto-rows", pack_module (module Property_grid_auto_rows);
    (* Grid Layout L2: https://www.w3.org/TR/css-grid-2/#propdef-grid-template, #propdef-grid, #propdef-grid-area *)
    ( Shorthand ("grid-column", [ "grid-column-start"; "grid-column-end" ]),
      pack_module (module Property_grid_column) );
    Property "grid-column-end", pack_module (module Property_grid_column_end);
    (* CSS Box Alignment L3 - https://www.w3.org/TR/css-align-3/#gap-legacy :
       legacy alias for "column-gap", mapped value-for-value. *)
    ( Alias ("grid-column-gap", "column-gap"),
      pack_module (module Property_grid_column_gap) );
    ( Property "grid-column-start",
      pack_module (module Property_grid_column_start) );
    (* CSS Box Alignment L3 - https://www.w3.org/TR/css-align-3/#gap-legacy :
       legacy alias for "gap", mapped value-for-value. *)
    Alias ("grid-gap", "gap"), pack_module (module Property_grid_gap);
    (* Grid Layout L2: https://www.w3.org/TR/css-grid-2/#propdef-grid-template, #propdef-grid, #propdef-grid-area *)
    ( Shorthand ("grid-row", [ "grid-row-start"; "grid-row-end" ]),
      pack_module (module Property_grid_row) );
    Property "grid-row-end", pack_module (module Property_grid_row_end);
    (* CSS Box Alignment L3 - https://www.w3.org/TR/css-align-3/#gap-legacy :
       legacy alias for "row-gap", mapped value-for-value. *)
    ( Alias ("grid-row-gap", "row-gap"),
      pack_module (module Property_grid_row_gap) );
    Property "grid-row-start", pack_module (module Property_grid_row_start);
    (* Grid Layout L2: https://www.w3.org/TR/css-grid-2/#propdef-grid-template, #propdef-grid, #propdef-grid-area *)
    ( Shorthand
        ( "grid-template",
          [
            "grid-template-rows"; "grid-template-columns"; "grid-template-areas";
          ] ),
      pack_module (module Property_grid_template) );
    ( Property "grid-template-areas",
      pack_module (module Property_grid_template_areas) );
    ( Property "grid-template-columns",
      pack_module (module Property_grid_template_columns) );
    ( Property "grid-template-rows",
      pack_module (module Property_grid_template_rows) );
  ]
