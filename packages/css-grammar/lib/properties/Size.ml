open Types
open Support

module Property_size =
  [%spec_module
  "<extended-length>{1,2} | 'auto' | [ 'A5' | 'A4' | 'A3' | 'B5' | 'B4' | \
   'JIS-B5' | 'JIS-B4' | 'letter' | 'legal' | 'ledger' ] [ 'portrait' | \
   'landscape' ]?",
  (module Css_types.Size)]

let property_size : property_size Rule.rule = Property_size.rule

let entries : (kind * packed_rule) list =
  [ Property "size", pack_module (module Property_size) ]
