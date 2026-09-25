/* css-grammar-draft-properties (2026-09-25): standards-track draft
   properties from CSS Backgrounds Module Level 4
   (https://drafts.csswg.org/css-backgrounds-4/) and CSS Overflow Module
   Level 4 (https://drafts.csswg.org/css-overflow-4/), none implemented in
   any browser yet (two, block-ellipsis and continue, are preview-only in
   Safari Technology Preview). */

/* Backgrounds L4: logical counterparts of background-position-x/-y and
   background-repeat-x/-y (the -x/-y forms themselves are not registered -
   implemented then removed from every browser). */
[%css {|background-position-block: center|}];
[%css {|background-position-block: start 10px|}];
[%css {|background-position-block: end 10%, center|}];
[%css {|background-position-inline: start|}];
[%css {|background-repeat-block: repeat|}];
[%css {|background-repeat-block: space, round|}];
[%css {|background-repeat-inline: no-repeat|}];

/* Overflow L4: overflow-clip-margin becomes a shorthand of its 4 physical
   per-side longhands; the 4 logical sides and the overflow-clip-margin-
   block/-inline shorthands over them are independent registrations
   (same convention as margin-top vs margin-block-start elsewhere). */
[%css {|overflow-clip-margin: 5px|}];
[%css {|overflow-clip-margin: padding-box|}];
[%css {|overflow-clip-margin: content-box 10px|}];
[%css {|overflow-clip-margin-top: 5px|}];
[%css {|overflow-clip-margin-right: border-box 2px|}];
[%css {|overflow-clip-margin-bottom: 0px|}];
[%css {|overflow-clip-margin-left: padding-box|}];
[%css {|overflow-clip-margin-block-start: 5px|}];
[%css {|overflow-clip-margin-block-end: 5px|}];
[%css {|overflow-clip-margin-inline-start: 5px|}];
[%css {|overflow-clip-margin-inline-end: 5px|}];
[%css {|overflow-clip-margin-block: 5px|}];
[%css {|overflow-clip-margin-inline: border-box|}];
[%css {|block-ellipsis: auto|}];
[%css {|block-ellipsis: no-ellipsis|}];
[%css {|block-ellipsis: "..."|}];
[%css {|continue: auto|}];
[%css {|continue: discard|}];
[%css {|continue: collapse|}];
