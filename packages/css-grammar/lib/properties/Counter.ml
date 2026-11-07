open Types
open Support

module Property_counter_increment =
  [%spec_module
  "[ <custom-ident> [ <integer> ]? ]+ | 'none'",
  (module Css_types.CounterIncrement)]

let property_counter_increment : property_counter_increment Rule.rule =
  Property_counter_increment.rule

module Property_counter_reset =
  [%spec_module
  "[ <custom-ident> [ <integer> ]? ]+ | 'none'", (module Css_types.CounterReset)]

let property_counter_reset : property_counter_reset Rule.rule =
  Property_counter_reset.rule

module Property_counter_set =
  [%spec_module
  "[ <custom-ident> [ <integer> ]? ]+ | 'none'", (module Css_types.CounterSet)]

let property_counter_set : property_counter_set Rule.rule =
  Property_counter_set.rule

let entries : (kind * packed_rule) list =
  [
    ( Property "counter-increment",
      pack_module (module Property_counter_increment) );
    Property "counter-reset", pack_module (module Property_counter_reset);
    Property "counter-set", pack_module (module Property_counter_set);
  ]
