open Jest;
open Expect;
open ReactTestingLibrary;

module Opacity = [%styled "opacity: 0.9"];

/* module Overflow = [%styled
  {|
  overflow-y: visible;
  overflow-x: visible;
  overflow: hidden;
|}
];

module Visibility = [%styled "visibility: visible"];
module Hyphens = [%styled "hyphens: manual"];
module Stroke = [%styled "stroke: none"];
module Order = [%styled "order: 0"];
module Direction = [%styled "direction: ltr"];
module Content = [%styled "content: normal"];
module Clear = [%styled "clear: none"];
module Box = [%styled "box-shadow: none"];
module Box = [%styled "box-sizing: content-box"];
module Border = [%styled "border-collapse: separate"];
 */

/*
module Transition = [%styled "transition-property: all"];
 | "animation" => render_animation()
 | "box-shadow" => render_box_shadow()
 | "text-shadow" => render_text_shadow()
 | "transform" => render_transform()
 | "transition" => render_transition()
 | "font-family" => render_font_family()
 */

let componentsList = [
  ("Opacity", <Opacity />),
  /* ("Overflow", Overflow),
  ("Visibility", Visibility),
  ("Hypens", Hypens),
  ("Stroke", Stroke),
  ("Order", Order),
  ("Direction", Direction),
  ("Content", Content),
  ("Clear", Clear),
  ("Box", Box),
  ("Box", Box),
  ("Border", Border), */
];

Belt.List.forEach(componentsList, (((name, component)) => {
  test("Component " ++ name ++ " renders ", () => {
    component
    |> render
    |> container
    |> expect
    |> toMatchSnapshot
  });
}));

