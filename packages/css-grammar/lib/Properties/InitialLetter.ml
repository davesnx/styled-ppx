open Types
open Support

module Property_initial_letter =
  [%spec_module
  "'normal' | <number> [ <integer> ]?", (module Css_types.InitialLetter)]

let property_initial_letter : property_initial_letter Rule.rule =
  Property_initial_letter.rule

(* CSS Inline Layout L3: https://drafts.csswg.org/css-inline-3/#propdef-initial-letter-wrap *)
module Property_initial_letter_wrap =
  [%spec_module
  "'none' | 'first' | 'all' | 'grid' | <extended-length> | \
   <extended-percentage>",
  (module Css_types.InitialLetterWrap)]

let property_initial_letter_wrap : property_initial_letter_wrap Rule.rule =
  Property_initial_letter_wrap.rule

let entries : (kind * packed_rule) list =
  [
    Property "initial-letter", pack_module (module Property_initial_letter);
    ( Property "initial-letter-wrap",
      pack_module (module Property_initial_letter_wrap) );
  ]
