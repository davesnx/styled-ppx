This test ensures the ppx generates the correct output against styled-ppx.css_native
If this test fail means that Css_Js_Core or CssJs_Legacy_Core (from styled-ppx.css or styled-ppx.css_native) are not in sync with the ppx

This test only runs against Css_Js_Core from styled-ppx.css_native

  $ cat >dune-project <<EOF
  > (lang dune 3.10)
  > EOF

  $ cat >dune <<EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.emotion_native styled-ppx.css_native)
  >  (preprocess (pps styled-ppx.lib)))
  > EOF

  $ dune describe pp input.re
  /* CSS Basic User Interface Module Level 3 (CSS3 UI) */
  [%css {|box-sizing: border-box|}];
  [%css {|box-sizing: content-box|}];
  [%css {|outline-style: auto|}];
  [%css {|outline-style: none|}];
  [%css {|outline-style: dotted|}];
  [%css {|outline-style: dashed|}];
  [%css {|outline-style: solid|}];
  [%css {|outline-style: double|}];
  [%css {|outline-style: groove|}];
  [%css {|outline-style: ridge|}];
  [%css {|outline-style: inset|}];
  [%css {|outline-style: outset|}];
  [%css {|outline-offset: -5px|}];
  [%css {|outline-offset: 0|}];
  [%css {|outline-offset: 5px|}];
  [%css {|resize: none|}];
  [%css {|resize: both|}];
  [%css {|resize: horizontal|}];
  [%css {|resize: vertical|}];
  [%css {|text-overflow: clip|}];
  [%css {|text-overflow: ellipsis|}];
  /* [%css {|cursor: url(foo.png) 2 2, auto|}]; */
  [%css {|cursor: default|}];
  [%css {|cursor: none|}];
  [%css {|cursor: context-menu|}];
  [%css {|cursor: cell|}];
  [%css {|cursor: vertical-text|}];
  [%css {|cursor: alias|}];
  [%css {|cursor: copy|}];
  [%css {|cursor: no-drop|}];
  [%css {|cursor: not-allowed|}];
  [%css {|cursor: grab|}];
  [%css {|cursor: grabbing|}];
  [%css {|cursor: ew-resize|}];
  [%css {|cursor: ns-resize|}];
  [%css {|cursor: nesw-resize|}];
  [%css {|cursor: nwse-resize|}];
  [%css {|cursor: col-resize|}];
  [%css {|cursor: row-resize|}];
  [%css {|cursor: all-scroll|}];
  [%css {|cursor: zoom-in|}];
  [%css {|cursor: zoom-out|}];
  [%css {|caret-color: auto|}];
  [%css {|caret-color: green|}];
  
  /* CSS Basic User Interface Module Level 4 */
  [%css {|appearance: auto|}];
  [%css {|appearance: none|}];
  /* [%css {|caret: auto|}]; */
  /* [%css {|caret: green|}]; */
  /* [%css {|caret: bar|}]; */
  /* [%css {|caret: green bar|}]; */
  /* [%css {|caret-shape: auto|}]; */
  /* [%css {|caret-shape: bar|}]; */
  /* [%css {|caret-shape: block|}]; */
  /* [%css {|caret-shape: underscore|}]; */
  [%css {|text-overflow: clip|}];
  [%css {|text-overflow: ellipsis|}];
  /* [%css {|text-overflow: fade|}]; */
  /* [%css {|text-overflow: fade(10px)|}]; */
  /* [%css {|text-overflow: fade(10%)|}]; */
  [%css {|text-overflow: 'foo'|}];
  [%css {|text-overflow: clip clip|}];
  [%css {|text-overflow: ellipsis clip|}];
  /* [%css {|text-overflow: fade clip|}]; */
  /* [%css {|text-overflow: fade(10px) clip|}]; */
  /* [%css {|text-overflow: fade(10%) clip|}]; */
  [%css {|text-overflow: 'foo' clip|}];
  [%css {|text-overflow: clip ellipsis|}];
  [%css {|text-overflow: ellipsis ellipsis|}];
  /* [%css {|text-overflow: fade ellipsis|}]; */
  /* [%css {|text-overflow: fade(10px) ellipsis|}]; */
  /* [%css {|text-overflow: fade(10%) ellipsis|}]; */
  [%css {|text-overflow: 'foo' ellipsis|}];
  /* [%css {|text-overflow: clip fade|}]; */
  /* [%css {|text-overflow: ellipsis fade|}]; */
  /* [%css {|text-overflow: fade fade|}]; */
  /* [%css {|text-overflow: fade(10px) fade|}]; */
  /* [%css {|text-overflow: fade(10%) fade|}]; */
  /* [%css {|text-overflow: 'foo' fade|}]; */
  /* [%css {|text-overflow: clip fade(10px)|}]; */
  /* [%css {|text-overflow: ellipsis fade(10px)|}]; */
  /* [%css {|text-overflow: fade fade(10px)|}]; */
  /* [%css {|text-overflow: fade(10px) fade(10px)|}]; */
  /* [%css {|text-overflow: fade(10%) fade(10px)|}]; */
  /* [%css {|text-overflow: 'foo' fade(10px)|}]; */
  /* [%css {|text-overflow: clip fade(10%)|}]; */
  /* [%css {|text-overflow: ellipsis fade(10%)|}]; */
  /* [%css {|text-overflow: fade fade(10%)|}]; */
  /* [%css {|text-overflow: fade(10px) fade(10%)|}]; */
  /* [%css {|text-overflow: fade(10%) fade(10%)|}]; */
  /* [%css {|text-overflow: 'foo' fade(10%)|}]; */
  [%css {|text-overflow: clip 'foo'|}];
  [%css {|text-overflow: ellipsis 'foo'|}];
  /* [%css {|text-overflow: fade 'foo'|}]; */
  /* [%css {|text-overflow: fade(10px) 'foo'|}]; */
  /* [%css {|text-overflow: fade(10%) 'foo'|}]; */
  [%css {|text-overflow: 'foo' 'foo'|}];
  [%css {|user-select: auto|}];
  [%css {|user-select: text|}];
  [%css {|user-select: none|}];
  [%css {|user-select: contain|}];
  [%css {|user-select: all|}];
  /* [%css {|nav-up: auto|}]; */
  /* [%css {|nav-up: #foo|}]; */
  /* [%css {|nav-up: #foo current|}]; */
  /* [%css {|nav-up: #foo root|}]; */
  /* [%css {|nav-right: auto|}]; */
  /* [%css {|nav-right: #foo|}]; */
  /* [%css {|nav-right: #foo current|}]; */
  /* [%css {|nav-right: #foo root|}]; */
  /* [%css {|nav-down: auto|}]; */
  /* [%css {|nav-down: #foo|}]; */
  /* [%css {|nav-down: #foo current|}]; */
  /* [%css {|nav-down: #foo root|}]; */
  /* [%css {|nav-left: auto|}]; */
  /* [%css {|nav-left: #foo|}]; */
  /* [%css {|nav-left: #foo current|}]; */
  /* [%css {|nav-left: #foo root|}]; */

  $ dune build
