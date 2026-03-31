open Types
open Support

module Property_display =
  [%spec_module
  "'block' | 'contents' | 'flex' | 'flow' | 'flow-root' | 'grid' | 'inline' | \
   'inline-block' | 'inline-flex' | 'inline-grid' | 'inline-list-item' | \
   'inline-table' | 'list-item' | 'none' | 'ruby' | 'ruby-base' | \
   'ruby-base-container' | 'ruby-text' | 'ruby-text-container' | 'run-in' | \
   'table' | 'table-caption' | 'table-cell' | 'table-column' | \
   'table-column-group' | 'table-footer-group' | 'table-header-group' | \
   'table-row' | 'table-row-group' | '-webkit-flex' | '-webkit-inline-flex' | \
   '-webkit-box' | '-webkit-inline-box' | '-moz-inline-stack' | '-moz-box' | \
   '-moz-inline-box'",
  (module Css_types.Display)]

let property_display : property_display Rule.rule = Property_display.rule

let entries : (kind * packed_rule) list =
  [
    Property "display", pack_module (module Property_display);
  ]
