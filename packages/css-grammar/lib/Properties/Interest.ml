open Types
open Support

module Property_interest_delay =
  [%spec_module
  "[ 'normal' | <extended-time> ]{1,2}", (module Css_types.Cascading)]

module Property_interest_delay_end =
  [%spec_module
  "'normal' | <extended-time>", (module Css_types.Cascading)]

module Property_interest_delay_start =
  [%spec_module
  "'normal' | <extended-time>", (module Css_types.Cascading)]

let entries : (kind * packed_rule) list =
  [
    Property "interest-delay", pack_module (module Property_interest_delay);
    ( Property "interest-delay-end",
      pack_module (module Property_interest_delay_end) );
    ( Property "interest-delay-start",
      pack_module (module Property_interest_delay_start) );
  ]
