/* css-grammar-gaps (2026-09-25): CSS Gaps Module Level 1, https://drafts.csswg.org/css-gaps-1/
   All 37 properties added by that pass, one browser-implemented (Chrome
   149+) family: row-rule, column-rule additions, and rule. */

/* Section 4.1-4.3: column-rule-color/-style/-width supersede the old
   css-multicol-1 single-value grammar with a comma list, plus repeat()
   and repeat(auto, ...) inside the list. row-rule and rule share the
   identical typedefs. */
[%css {|column-rule-color: red|}];
[%css {|column-rule-color: red, blue|}];
[%css {|column-rule-color: red, repeat(3, blue, green), red|}];
[%css {|column-rule-color: repeat(auto, blue, green)|}];
[%css {|column-rule-style: solid, dashed|}];
[%css {|column-rule-width: 1px, 2px|}];
[%css {|row-rule-color: red, blue|}];
[%css {|row-rule-color: repeat(auto, blue, green)|}];
[%css {|row-rule-style: solid, dashed|}];
[%css {|row-rule-width: 1px, 2px|}];
[%css {|rule-color: red, blue|}];
[%css {|rule-style: solid, dashed|}];
[%css {|rule-width: 1px, 2px|}];

/* Section 3.2: break */
[%css {|column-rule-break: intersection|}];
[%css {|row-rule-break: none|}];
[%css {|rule-break: normal|}];

/* Section 3.3: inset - leaves, -cap-/-junction- shorthands (1 or 2 values),
   -start/-end shorthands, and the universal shorthand (cap[/junction]).
   column-rule-inset-start itself is not added (not browser-implemented);
   row-rule-inset-start and rule-inset-start are. */
[%css {|column-rule-inset-cap-start: 10px|}];
[%css {|column-rule-inset-cap-end: -5px|}];
[%css {|column-rule-inset-junction-start: 50%|}];
[%css {|column-rule-inset-junction-end: overlap-join|}];
[%css {|column-rule-inset-cap: 0px|}];
[%css {|column-rule-inset-cap: 0px 5px|}];
[%css {|column-rule-inset-junction: -5px|}];
[%css {|column-rule-inset-start: 8px|}];
[%css {|column-rule-inset-end: 0px|}];
[%css {|column-rule-inset: 0px|}];
[%css {|column-rule-inset: 0px / -5px|}];
[%css {|row-rule-inset-start: 8px|}];
[%css {|row-rule-inset-end: 0px|}];
[%css {|row-rule-inset: -50%|}];
[%css {|rule-inset-cap: 0px|}];
[%css {|rule-inset-junction: -5px|}];
[%css {|rule-inset-end: 0px|}];
[%css {|rule-inset: 0px|}];
[%css {|rule-inset-start: 8px|}];

/* Section 3.4: visibility-items */
[%css {|column-rule-visibility-items: between|}];
[%css {|row-rule-visibility-items: all|}];
[%css {|rule-visibility-items: around|}];

/* Section 3.5: overlap - standalone, no column-/row- split */
[%css {|rule-overlap: row-over-column|}];
[%css {|rule-overlap: column-over-row|}];

/* Section 4.4: the shorthands themselves - <gap-rule-list> | <gap-auto-rule-list>,
   a comma list of width/style/color triples with repeat()/repeat(auto, ...) */
[%css {|column-rule: 1px solid red|}];
[%css {|column-rule: 1px solid red, 2px dashed blue|}];
[%css {|column-rule: repeat(3, 1px solid red, 2px dashed blue)|}];
[%css {|column-rule: gray, repeat(auto, red, blue), gray|}];
[%css {|row-rule: 6px solid red|}];
[%css {|rule: 1px solid red|}];
