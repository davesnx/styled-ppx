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
[%css {|transition-timing-function: ease, step-start, cubic-bezier(0.1, 0.7, 1, 0.1)|}];
[%css {|transition-delay: 1s|}];
[%css {|transition-delay: -1s|}];
[%css {|transition-behavior: normal|}];
[%css {|transition-behavior: allow-discrete|}];
[%css {|transition-behavior: allow-discrete, normal|}];
[%css {|transition: margin-right 2s, opacity 0.5s|}];
[%css {|transition: 1s 2s width linear|}];
[%css {|transition: none|}];
[%css {|transition: margin-right|}];
[%css {|transition: margin-right ease-in|}];
[%css {|transition: .5s|}];
[%css {|transition: 200ms .5s|}];
[%css {|transition: linear|}];
[%css {|transition: 1s .5s linear margin-right|}];
[%css {|transition: display 4s allow-discrete|}];
[%css {|transition: all 0.5s ease-out allow-discrete|}];

// Interpolation
let property = CSS.Types.TransitionProperty.make("margin-right");
let property2 = CSS.Types.TransitionProperty.all;
let timingFunction = `easeOut;
let duration = `ms(200);
let delay = `s(3);
let property3 = CSS.Types.TransitionProperty.make("opacity");
let behavior = `allowDiscrete;

[%css {|transition: $(property)|}];
[%css {|transition: $(property2)|}];
// This is the order of interpolation, from left to right.
[%css {|transition: $(property) $(duration) $(timingFunction) $(delay) $(behavior)|}];
[%css
  {|transition: $(property) $(duration) $(timingFunction) $(delay), $(property3) 0s|}
];
[%css {|transition: $(property) 0.2s ease-out 3s|}];
[%css {|transition: $(property) 0.2s $(timingFunction) 3s|}];
[%css {|transition: $(property) $(duration) $(timingFunction) 3s|}];
[%css {|transition: margin-right $(duration) ease-out $(delay)|}];
[%css {|transition: $(property) $(duration) ease-out $(delay)|}];
[%css {|transition: margin-right 0.2s $(timingFunction) 3s|}];
[%css {|transition: margin-right 0.2s ease-out $(delay)|}];
[%css {|transition: $(property) 0.2s ease-in|}];
[%css {|transition: $(property) 0.2s $(timingFunction)|}];
[%css {|transition: margin-right $(duration) ease-in|}];
[%css {|transition: $(property) $(duration) ease-in|}];
[%css {|transition: margin-right 0.2s $(timingFunction)|}];
[%css {|transition: $(property) 0.2s ease-in|}];
[%css {|transition: margin-right $(duration) ease-in|}];
[%css {|transition: margin-right 0.2s $(timingFunction)|}];
[%css {|transition: $(property) 0.2s|}];
[%css {|transition: margin-right $(duration)|}];
