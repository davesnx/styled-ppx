open Types
open Support

module Property_cursor =
  [%spec_module
  "'auto' | 'default' | 'none' | 'context-menu' | 'help' | 'pointer' | \
   'progress' | 'wait' | 'cell' | 'crosshair' | 'text' | 'vertical-text' | \
   'alias' | 'copy' | 'move' | 'no-drop' | 'not-allowed' | 'e-resize' | \
   'n-resize' | 'ne-resize' | 'nw-resize' | 's-resize' | 'se-resize' | \
   'sw-resize' | 'w-resize' | 'ew-resize' | 'ns-resize' | 'nesw-resize' | \
   'nwse-resize' | 'col-resize' | 'row-resize' | 'all-scroll' | 'zoom-in' | \
   'zoom-out' | 'grab' | 'grabbing' | 'hand' | '-webkit-grab' | \
   '-webkit-grabbing' | '-webkit-zoom-in' | '-webkit-zoom-out' | '-moz-grab' | \
   '-moz-grabbing' | '-moz-zoom-in' | '-moz-zoom-out' | <interpolation>",
  (module Css_types.Cursor)]

let property_cursor : property_cursor Rule.rule = Property_cursor.rule

let entries : (kind * packed_rule) list =
  [
    Property "cursor", pack_module (module Property_cursor);
  ]
