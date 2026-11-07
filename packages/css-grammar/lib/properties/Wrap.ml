open Types
open Support

module Property__ms_wrap_flow =
  [%spec_module
  "'auto' | 'both' | 'start' | 'end' | 'maximum' | 'clear'",
  (module Css_types.Cascading)]

let property__ms_wrap_flow = Property__ms_wrap_flow.rule

module Property__ms_wrap_margin =
  [%spec_module
  "<extended-length>", (module Css_types.ShapeMargin)]

let property__ms_wrap_margin = Property__ms_wrap_margin.rule

module Property__ms_wrap_through =
  [%spec_module
  "'wrap' | 'none'", (module Css_types.Cascading)]

let property__ms_wrap_through = Property__ms_wrap_through.rule

let entries : (kind * packed_rule) list =
  [
    Property "-ms-wrap-flow", pack_module (module Property__ms_wrap_flow);
    Property "-ms-wrap-margin", pack_module (module Property__ms_wrap_margin);
    Property "-ms-wrap-through", pack_module (module Property__ms_wrap_through);
  ]
