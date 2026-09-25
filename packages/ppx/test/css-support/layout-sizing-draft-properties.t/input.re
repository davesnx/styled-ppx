/* css-grammar-draft-properties (task 2): the layout/sizing slice of the 140
   standards-track/preview properties, across 7 small specs. */

/* CSS Box Sizing L4 */
[%css {|max-size: 100px|}];
[%css {|max-size: 100px 50px|}];
[%css {|min-size: auto|}];
[%css {|min-size: 10px 20px|}];
[%css {|min-intrinsic-sizing: legacy|}];
[%css {|min-intrinsic-sizing: zero-if-scroll|}];
[%css {|min-intrinsic-sizing: zero-if-scroll zero-if-extrinsic|}];

/* CSS Exclusions L1 */
[%css {|wrap-flow: minimum|}];
[%css {|wrap-through: none|}];

/* CSS Fragmentation L4 */
[%css {|margin-break: keep|}];

/* CSS Rhythmic Sizing L1 */
[%css {|block-step-size: none|}];
[%css {|block-step-insert: content-box|}];
[%css {|block-step-align: center|}];
[%css {|block-step-round: nearest|}];
[%css {|block-step: 10px content-box center up|}];

/* CSS Inline Layout L3 */
[%css {|initial-letter-wrap: grid|}];
[%css {|inline-sizing: stretch|}];
[%css {|line-fit-edge: cap|}];

/* CSS Line Grid L1 */
[%css {|line-grid: create|}];
[%css {|line-snap: contain|}];
[%css {|box-snap: last-baseline|}];

/* CSS Round Display L1 */
[%css {|border-boundary: parent|}];
[%css {|shape-inside: circle() border-box|}];
