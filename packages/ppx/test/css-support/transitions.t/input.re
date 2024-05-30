/* CSS Transitions */
[%css {|transition-property: none|}];
[%css {|transition-property: all|}];
[%css {|transition-property: width|}];
[%css {|transition-property: width, height|}];
[%css {|transition-duration: 0s|}];
[%css {|transition-duration: 1s|}];
[%css {|transition-duration: 100ms|}];
[%css {|transition-timing-function: ease|}];
[%css {|transition-timing-function: linear|}];
[%css {|transition-timing-function: ease-in|}];
[%css {|transition-timing-function: ease-out|}];
[%css {|transition-timing-function: ease-in-out|}];
[%css {|transition-timing-function: cubic-bezier(.5, .5, .5, .5)|}];
[%css {|transition-timing-function: cubic-bezier(.5, 1.5, .5, -2.5)|}];
[%css {|transition-timing-function: step-start|}];
[%css {|transition-timing-function: step-end|}];
[%css {|transition-timing-function: steps(3, start)|}];
[%css {|transition-timing-function: steps(5, end)|}];
[%css {|transition-delay: 1s|}];
[%css {|transition-delay: -1s|}];
[%css {|transition: margin-right 2s, opacity 0.5s|}];
[%css {|transition: 1s 2s width linear|}];
[%css {|transition: none|}];
[%css {|transition: margin-right|}];
[%css {|transition: margin-right ease-in|}];
[%css {|transition: .5s|}];
[%css {|transition: 200ms .5s|}];
[%css {|transition: linear|}];
[%css {|transition: 1s .5s linear margin-right|}];

// Interpolation
let transitions = [|
  CssJs.Transition.shorthand("margin-left"),
  CssJs.Transition.shorthand(~duration=`s(2), "opacity"),
|];
let property = "margin-right";
let timingFunction = `easeOut;
let duration = `ms(200);
let delay = `s(3);
let property2 = "opacity";

[%css {|transition: $(transitions)|}];
// This is the order of interpolation, from left to right.
[%css {|transition: $(timingFunction) $(property) $(duration) $(delay)|}];
[%css
  {|transition: $(timingFunction) $(property) $(duration) $(delay), ease $(property2)|}
];
[%css {|transition: margin-right $(timingFunction)|}];
[%css {|transition: 2s $(timingFunction)|}];
[%css {|transition: ease $(property)|}];
[%css {|transition: all ease $(duration)|}];
[%css {|transition: all ease $(duration) 3s|}];
[%css {|transition: all ease 0s $(delay)|}];

/* This is invalid since the first INTERPOLATION is parsed as timingFunction, and we add it again (with linear)
 * [%css {|transition: $(duration) 2s width linear|}];
 */
