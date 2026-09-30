open Types
open Support

(* CSS Generated Content L3: https://drafts.csswg.org/css-content-3/#propdef-bookmark-label
   Reuses Css_types.Content (the runtime `content` property's own witness) -
   its `t = [ one | `multi of one array ]` already models exactly one or
   more <content-list> tokens, the whole of this property's grammar. *)
module Property_bookmark_label =
  [%spec_module
  "<content-list>", (module Css_types.Content)]

let property_bookmark_label : property_bookmark_label Rule.rule =
  Property_bookmark_label.rule

(* CSS Generated Content L3: https://drafts.csswg.org/css-content-3/#propdef-bookmark-level *)
module Property_bookmark_level =
  [%spec_module
  "'none' | <positive-integer>", (module Css_types.BookmarkLevel)]

let property_bookmark_level : property_bookmark_level Rule.rule =
  Property_bookmark_level.rule

(* CSS Generated Content L3: https://drafts.csswg.org/css-content-3/#propdef-bookmark-state *)
module Property_bookmark_state =
  [%spec_module
  "'open' | 'closed'", (module Css_types.BookmarkState)]

let property_bookmark_state : property_bookmark_state Rule.rule =
  Property_bookmark_state.rule

(* CSS Generated Content L3: https://drafts.csswg.org/css-content-3/#propdef-string-set
   (css-gcpm also defines string-set, with <content-list> instead of <string>+
   in its second group member - content-3 is the actively-maintained Level 3
   module and is used here as the current definition). *)
module Property_string_set =
  [%spec_module
  "'none' | [ <custom-ident> <string>+ ]#", (module Css_types.StringSet)]

let property_string_set : property_string_set Rule.rule =
  Property_string_set.rule

(* CSS Generated Content for Paged Media: https://drafts.csswg.org/css-gcpm/#propdef-running
   Marks the element as the current value of a named running element, later
   referenced via content: running(<custom-ident>) inside a page margin box. *)
module Property_running =
  [%spec_module
  "<custom-ident>", (module Css_types.Running)]

let property_running : property_running Rule.rule = Property_running.rule

(* CSS Generated Content for Paged Media: https://drafts.csswg.org/css-gcpm/#propdef-footnote-display *)
module Property_footnote_display =
  [%spec_module
  "'block' | 'inline' | 'compact'", (module Css_types.FootnoteDisplay)]

let property_footnote_display : property_footnote_display Rule.rule =
  Property_footnote_display.rule

(* CSS Generated Content for Paged Media: https://drafts.csswg.org/css-gcpm/#propdef-footnote-policy *)
module Property_footnote_policy =
  [%spec_module
  "'auto' | 'line' | 'block'", (module Css_types.FootnotePolicy)]

let property_footnote_policy : property_footnote_policy Rule.rule =
  Property_footnote_policy.rule

let entries : (kind * packed_rule) list =
  [
    Property "bookmark-label", pack_module (module Property_bookmark_label);
    Property "bookmark-level", pack_module (module Property_bookmark_level);
    Property "bookmark-state", pack_module (module Property_bookmark_state);
    Property "string-set", pack_module (module Property_string_set);
    Property "running", pack_module (module Property_running);
    Property "footnote-display", pack_module (module Property_footnote_display);
    Property "footnote-policy", pack_module (module Property_footnote_policy);
  ]
