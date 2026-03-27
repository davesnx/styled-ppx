/* CSS Missing Length Units - Units in Parser.ml but missing from Css_types.ml */

/* cap - font metrics based */
[%css {|width: 1cap|}];
[%css {|width: 2.5cap|}];

/* ic - ideographic character */
[%css {|width: 1ic|}];
[%css {|width: 3.5ic|}];

/* lh - line height */
[%css {|width: 1lh|}];
[%css {|width: 2lh|}];

/* rcap - root cap */
[%css {|width: 1rcap|}];

/* rch - root ch */
[%css {|width: 1rch|}];

/* rex - root ex */
[%css {|width: 1rex|}];

/* ric - root ic */
[%css {|width: 1ric|}];

/* rlh - root line height */
[%css {|width: 1rlh|}];

/* vb - viewport block */
[%css {|width: 50vb|}];

/* vi - viewport inline */
[%css {|width: 50vi|}];

/* Q - quarter millimeter */
[%css {|width: 40Q|}];

/* Test units in other properties */
[%css {|height: 10lh|}];
[%css {|margin: 2cap|}];
[%css {|padding: 5ic|}];
[%css {|font-size: 1.5lh|}];
[%css {|line-height: 2rlh|}];
