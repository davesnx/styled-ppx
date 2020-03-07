module Component = [%styled ("display: block")]

module ComponentMultiline = [%styled
  {|
    color: #333;
    background-color: #333;
    margin: auto 0 10px 1em;
    border-bottom: thin dashed #eee;
    border-right-color: rgb(1, 0, 1);
    width: 70%;
    background: url(http://example.com/test.jpg);
  |}
]

module EmptyComponent = [%styled ()]

(* /* z-index: auto; */
  /* visibility: visible; */
  /* transition-property: all; */
  /* stroke: none; */
  /* overflow: visible; */   /* overflow-y: visible; */   /* overflow-x: visible; */
  /* order: 0; */
  /* hyphens: manual; */
  /* direction: ltr; */
  /* content: normal; */
  /* clear: none; */
  /* box-shadow: none; */
  /* box-sizing: content-box; */
  /* border-collapse: separate; */
  | "animation" => render_animation()
  | "box-shadow" => render_box_shadow()
  | "text-shadow" => render_text_shadow()
  | "transform" => render_transform()
  | "transition" => render_transition()
  | "font-family" => render_font_family() *)

(* module Props = [%styled {||}] *)

(* Not supported yet

module StyledComponentWithProps = [%styled
  (~color) => {|
    color: $color;
  |}
];

*)
