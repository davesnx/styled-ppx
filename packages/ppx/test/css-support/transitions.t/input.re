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
[%css {|transition: $(property) $(duration) $(timingFunction) $(delay)|}];
[%css
  {|transition: $(property) $(duration) $(timingFunction) $(delay), $(property2) 0s|}
];
[%css {|transition: margin-right 0s $(timingFunction) 0s|}];
[%css {|transition: all 2s $(timingFunction) 0s|}];
[%css {|transition: $(property) 0s|}];
[%css {|transition: all $(duration)|}];
[%css {|transition: all $(duration) ease 3s|}];
[%css {|transition: all 0s ease $(delay)|}];