open Types
open Support

(* CSS Gaps L1 § 4.4, 3.2-3.5: https://drafts.csswg.org/css-gaps-1/
   rule and every rule-* property are bidirectional shorthands: each sets its
   column-rule-* and row-rule-* counterpart(s) to the same value. Per spec
   their own grammar is just <'column-rule*'> (a quoted-property reference -
   parses identically to that property), so direct_longhands below is what
   actually names both sides. *)

module Property_rule =
  [%spec_module
  "<'column-rule'>", (module Css_types.GapRuleList)]

let property_rule : property_rule Rule.rule = Property_rule.rule

module Property_rule_break =
  [%spec_module
  "<'column-rule-break'>", (module Css_types.ColumnRuleBreak)]

let property_rule_break : property_rule_break Rule.rule =
  Property_rule_break.rule

module Property_rule_color =
  [%spec_module
  "<'column-rule-color'>", (module Css_types.Color)]

let property_rule_color : property_rule_color Rule.rule =
  Property_rule_color.rule

module Property_rule_style =
  [%spec_module
  "<'column-rule-style'>", (module Css_types.ColumnRuleStyle)]

let property_rule_style : property_rule_style Rule.rule =
  Property_rule_style.rule

module Property_rule_width =
  [%spec_module
  "<'column-rule-width'>", (module Css_types.ColumnRuleWidth)]

let property_rule_width : property_rule_width Rule.rule =
  Property_rule_width.rule

module Property_rule_visibility_items =
  [%spec_module
  "<'column-rule-visibility-items'>",
  (module Css_types.ColumnRuleVisibilityItems)]

let property_rule_visibility_items : property_rule_visibility_items Rule.rule =
  Property_rule_visibility_items.rule

module Property_rule_inset_cap =
  [%spec_module
  "<'column-rule-inset-cap'>", (module Css_types.InsetValue)]

let property_rule_inset_cap : property_rule_inset_cap Rule.rule =
  Property_rule_inset_cap.rule

module Property_rule_inset_junction =
  [%spec_module
  "<'column-rule-inset-junction'>", (module Css_types.InsetValue)]

let property_rule_inset_junction : property_rule_inset_junction Rule.rule =
  Property_rule_inset_junction.rule

module Property_rule_inset_end =
  [%spec_module
  "<'column-rule-inset-end'>", (module Css_types.InsetValue)]

let property_rule_inset_end : property_rule_inset_end Rule.rule =
  Property_rule_inset_end.rule

module Property_rule_inset =
  [%spec_module
  "<'column-rule-inset'>", (module Css_types.InsetValue)]

let property_rule_inset : property_rule_inset Rule.rule =
  Property_rule_inset.rule

(* rule-inset-start: column-rule-inset-start itself is not registered (see
   Column.ml), so this cannot reference it via <'column-rule-inset-start'>;
   its grammar is written out directly (identical to what that reference
   would have parsed) and direct_longhands names the four real leaves
   straight through, skipping the unimplemented intermediate on the column
   side (row-rule-inset-start IS registered, so that side goes through it
   normally in the leaf sense too - both sides are named explicitly here for
   symmetry and because row-rule-inset-start is itself a Shorthand, not a
   leaf, so it cannot be a direct_longhand target here without duplicating
   its own longhand set instead of just listing it). *)
module Property_rule_inset_start =
  [%spec_module
  "<inset-value>", (module Css_types.InsetValue)]

let property_rule_inset_start : property_rule_inset_start Rule.rule =
  Property_rule_inset_start.rule

(* CSS Gaps L1 § 3.5: https://drafts.csswg.org/css-gaps-1/#propdef-rule-overlap
   Standalone - no column-/row- split, so a plain Property, not a Shorthand. *)
module Property_rule_overlap =
  [%spec_module
  "'row-over-column' | 'column-over-row'", (module Css_types.RuleOverlap)]

let property_rule_overlap : property_rule_overlap Rule.rule =
  Property_rule_overlap.rule

let entries : (kind * packed_rule) list =
  [
    ( Shorthand ("rule", [ "column-rule"; "row-rule" ]),
      pack_module (module Property_rule) );
    ( Shorthand ("rule-break", [ "column-rule-break"; "row-rule-break" ]),
      pack_module (module Property_rule_break) );
    ( Shorthand ("rule-color", [ "column-rule-color"; "row-rule-color" ]),
      pack_module (module Property_rule_color) );
    ( Shorthand ("rule-style", [ "column-rule-style"; "row-rule-style" ]),
      pack_module (module Property_rule_style) );
    ( Shorthand ("rule-width", [ "column-rule-width"; "row-rule-width" ]),
      pack_module (module Property_rule_width) );
    ( Shorthand
        ( "rule-visibility-items",
          [ "column-rule-visibility-items"; "row-rule-visibility-items" ] ),
      pack_module (module Property_rule_visibility_items) );
    ( Shorthand
        ("rule-inset-cap", [ "column-rule-inset-cap"; "row-rule-inset-cap" ]),
      pack_module (module Property_rule_inset_cap) );
    ( Shorthand
        ( "rule-inset-junction",
          [ "column-rule-inset-junction"; "row-rule-inset-junction" ] ),
      pack_module (module Property_rule_inset_junction) );
    ( Shorthand
        ("rule-inset-end", [ "column-rule-inset-end"; "row-rule-inset-end" ]),
      pack_module (module Property_rule_inset_end) );
    ( Shorthand ("rule-inset", [ "column-rule-inset"; "row-rule-inset" ]),
      pack_module (module Property_rule_inset) );
    ( Shorthand
        ( "rule-inset-start",
          [
            "column-rule-inset-cap-start";
            "column-rule-inset-junction-start";
            "row-rule-inset-cap-start";
            "row-rule-inset-junction-start";
          ] ),
      pack_module (module Property_rule_inset_start) );
    Property "rule-overlap", pack_module (module Property_rule_overlap);
  ]
