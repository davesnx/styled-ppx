/* css-grammar-draft-properties (task 2): CSS Borders and Box Decorations L4,
   https://drafts.csswg.org/css-borders-4/ */

/* per-side radius shorthands */
[%css {|border-top-radius: 10px|}];
[%css {|border-top-radius: 10px 5px / 2px 1px|}];
[%css {|border-right-radius: 4px|}];
[%css {|border-bottom-radius: 4px|}];
[%css {|border-left-radius: 4px|}];
[%css {|border-block-start-radius: 4px|}];
[%css {|border-block-end-radius: 4px|}];
[%css {|border-inline-start-radius: 4px|}];
[%css {|border-inline-end-radius: 4px|}];

/* border-limit */
[%css {|border-limit: all|}];
[%css {|border-limit: sides 50%|}];
[%css {|border-limit: corners|}];
[%css {|border-limit: corners 10px|}];
[%css {|border-limit: left 4em|}];

/* border-clip leaves and shorthands */
[%css {|border-top-clip: 10px 1fr 10px|}];
[%css {|border-right-clip: none|}];
[%css {|border-bottom-clip: 0 10px 1fr 10px|}];
[%css {|border-left-clip: 5px|}];
[%css {|border-block-start-clip: 10px|}];
[%css {|border-block-end-clip: 10px|}];
[%css {|border-inline-start-clip: 10px|}];
[%css {|border-inline-end-clip: 10px|}];
[%css {|border-block-clip: 10px 1fr|}];
[%css {|border-inline-clip: 10px 1fr|}];
[%css {|border-clip: 0 1fr|}];

/* box-shadow-* longhands (not yet wired as box-shadow's own reset set) */
[%css {|box-shadow-color: red|}];
[%css {|box-shadow-color: red, blue|}];
[%css {|box-shadow-offset: 4px 4px|}];
[%css {|box-shadow-offset: none, 4px 4px|}];
[%css {|box-shadow-blur: 12px|}];
[%css {|box-shadow-spread: 40px|}];
[%css {|box-shadow-position: inset|}];
[%css {|box-shadow-position: outset, inset|}];
