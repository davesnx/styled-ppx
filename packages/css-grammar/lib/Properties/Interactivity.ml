open Types
open Support

module Property_interactivity =
  [%spec_module
  "'auto' | 'inert'", (module Css_types.Cascading)]

let property_interactivity = Property_interactivity.rule

module Property__ms_accelerator =
  [%spec_module
  "'false' | 'true'", (module Css_types.Cascading)]

let property__ms_accelerator = Property__ms_accelerator.rule

let entries : (kind * packed_rule) list =
  [
    Property "-ms-accelerator", pack_module (module Property__ms_accelerator);
    Property "interactivity", pack_module (module Property_interactivity);
  ]
