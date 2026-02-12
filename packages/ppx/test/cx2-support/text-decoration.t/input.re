/* CSS Text Decoration Module Level 3 */
/* [%cx2 {|text-decoration: underline dotted green|}]; */
[%cx2 {|text-decoration-line: none|}];
[%cx2 {|text-decoration-line: underline|}];
[%cx2 {|text-decoration-line: overline|}];
[%cx2 {|text-decoration-line: line-through|}];
[%cx2 {|text-decoration-line: underline overline|}];
[%cx2 {|text-decoration-color: white|}];
[%cx2 {|text-decoration-style: solid|}];
[%cx2 {|text-decoration-style: double|}];
[%cx2 {|text-decoration-style: dotted|}];
[%cx2 {|text-decoration-style: dashed|}];
[%cx2 {|text-decoration-style: wavy|}];
[%cx2 {|text-underline-position: auto|}];
[%cx2 {|text-underline-position: under|}];
[%cx2 {|text-underline-position: left|}];
[%cx2 {|text-underline-position: right|}];
[%cx2 {|text-underline-position: under left|}];
[%cx2 {|text-underline-position: under right|}];
[%cx2 {|text-emphasis-style: none|}];
[%cx2 {|text-emphasis-style: filled|}];
[%cx2 {|text-emphasis-style: open|}];
[%cx2 {|text-emphasis-style: dot|}];
[%cx2 {|text-emphasis-style: circle|}];
[%cx2 {|text-emphasis-style: double-circle|}];
[%cx2 {|text-emphasis-style: triangle|}];
[%cx2 {|text-emphasis-style: sesame|}];
[%cx2 {|text-emphasis-style: open dot|}];
[%cx2 {|text-emphasis-style: 'foo'|}];
[%cx2 {|text-emphasis-color: green|}];
[%cx2 {|text-emphasis: open dot green|}];
/* [%cx2 {|text-emphasis-position: left|}]; */
[%cx2 {|text-emphasis-position: over|}];
[%cx2 {|text-emphasis-position: under|}];
[%cx2 {|text-emphasis-position: over left|}];
[%cx2 {|text-emphasis-position: over right|}];
[%cx2 {|text-emphasis-position: under left|}];
[%cx2 {|text-emphasis-position: left under|}];
[%cx2 {|text-emphasis-position: under right|}];
/* text-shadow: none | <length>{2,3} && <color>?
   Combinatorial coverage: 4 combinations */
[%cx2 {|text-shadow: none|}];
/* x y (no blur, no color) */
[%cx2 {|text-shadow: 1px 1px|}];
/* x y color (no blur) */
[%cx2 {|text-shadow: 0 0 black|}];
/* x y blur (no color) */
[%cx2 {|text-shadow: 1px 2px 3px|}];
/* x y blur color (all parts) */
[%cx2 {|text-shadow: 1px 2px 3px black|}];
/* Multiple shadows */
[%cx2 {|text-shadow: 1px 1px, 2px 2px red|}];
[%cx2 {|text-shadow: 1px 2px 3px black, 0 0 5px white|}];

/* CSS Text Decoration Module Level 4 */
/* [%cx2 {|text-decoration: underline solid blue 1px|}]; */
[%cx2 {|text-decoration-skip: none|}];
[%cx2 {|text-decoration-skip: objects|}];
[%cx2 {|text-decoration-skip: objects spaces|}];
[%cx2 {|text-decoration-skip: objects leading-spaces|}];
[%cx2 {|text-decoration-skip: objects trailing-spaces|}];
[%cx2 {|text-decoration-skip: objects leading-spaces trailing-spaces|}];
[%cx2 {|text-decoration-skip: objects leading-spaces trailing-spaces edges|}];
[%cx2
  {|text-decoration-skip: objects leading-spaces trailing-spaces edges box-decoration|}
];
[%cx2 {|text-decoration-skip: objects edges|}];
[%cx2 {|text-decoration-skip: objects box-decoration|}];
[%cx2 {|text-decoration-skip: spaces|}];
[%cx2 {|text-decoration-skip: spaces edges|}];
[%cx2 {|text-decoration-skip: spaces edges box-decoration|}];
[%cx2 {|text-decoration-skip: spaces box-decoration|}];
[%cx2 {|text-decoration-skip: leading-spaces|}];
[%cx2 {|text-decoration-skip: leading-spaces trailing-spaces edges|}];
[%css
  {|text-decoration-skip: leading-spaces trailing-spaces edges box-decoration|}
];
[%cx2 {|text-decoration-skip: edges|}];
[%cx2 {|text-decoration-skip: edges box-decoration|}];
[%cx2 {|text-decoration-skip: box-decoration|}];
[%cx2 {|text-decoration-skip-ink: none|}];
[%cx2 {|text-decoration-skip-ink: auto|}];
[%cx2 {|text-decoration-skip-ink: all|}];
[%cx2 {|text-decoration-skip-box: none|}];
[%cx2 {|text-decoration-skip-box: all|}];
[%cx2 {|text-decoration-skip-inset: none|}];
[%cx2 {|text-decoration-skip-inset: auto|}];
[%cx2 {|text-underline-offset: auto|}];
[%cx2 {|text-underline-offset: 3px|}];
[%cx2 {|text-underline-offset: 10%|}];
[%cx2 {|text-decoration-thickness: auto|}];
[%cx2 {|text-decoration-thickness: from-font|}];
[%cx2 {|text-decoration-thickness: 3px|}];
[%cx2 {|text-decoration-thickness: 10%|}];
