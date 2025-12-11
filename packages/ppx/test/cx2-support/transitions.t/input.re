/* CSS Transitions */
[%cx2 {|transition-property: none|}];
[%cx2 {|transition-property: all|}];
[%cx2 {|transition-property: width|}];
[%cx2 {|transition-property: width, height|}];
[%cx2 {|transition-duration: 0s|}];
[%cx2 {|transition-duration: 1s|}];
[%cx2 {|transition-duration: 100ms|}];
[%cx2 {|transition-duration: 10s, 30s, 230ms|}];
[%cx2 {|transition-timing-function: ease|}];
[%cx2 {|transition-timing-function: linear|}];
[%cx2 {|transition-timing-function: ease-in|}];
[%cx2 {|transition-timing-function: ease-out|}];
[%cx2 {|transition-timing-function: ease-in-out|}];
[%cx2 {|transition-timing-function: cubic-bezier(.5, .5, .5, .5)|}];
[%cx2 {|transition-timing-function: cubic-bezier(.5, 1.5, .5, -2.5)|}];
[%cx2 {|transition-timing-function: step-start|}];
[%cx2 {|transition-timing-function: step-end|}];
[%cx2 {|transition-timing-function: steps(3, start)|}];
[%cx2 {|transition-timing-function: steps(5, end)|}];
[%cx2
  {|transition-timing-function: ease, step-start, cubic-bezier(0.1, 0.7, 1, 0.1)|}
];
[%cx2 {|transition-delay: 1s|}];
[%cx2 {|transition-delay: -1s|}];
[%cx2 {|transition-delay: 2s, 4ms|}];
[%cx2 {|transition-behavior: normal|}];
[%cx2 {|transition-behavior: allow-discrete|}];
[%cx2 {|transition-behavior: allow-discrete, normal|}];
[%cx2 {|transition: margin-right 2s, opacity 0.5s|}];
[%cx2 {|transition: 1s 2s width linear|}];
[%cx2 {|transition: none|}];
[%cx2 {|transition: margin-right|}];
[%cx2 {|transition: margin-right ease-in|}];
[%cx2 {|transition: .5s|}];
[%cx2 {|transition: 200ms .5s|}];
[%cx2 {|transition: linear|}];
[%cx2 {|transition: 1s .5s linear margin-right|}];
[%cx2 {|transition: display 4s allow-discrete|}];
[%cx2 {|transition: all 0.5s ease-out allow-discrete|}];

// Interpolation
let property = CSS.Types.TransitionProperty.make("margin-right");
let property2 = CSS.Types.TransitionProperty.all;
let timingFunction = `easeOut;
let duration = `ms(200);
let delay = `s(3);
let property3 = CSS.Types.TransitionProperty.make("opacity");
let behavior = `allowDiscrete;

[%cx2 {|transition: $(property)|}];
[%cx2 {|transition: $(property2)|}];
// This is the order of interpolation, from left to right.
[%cx2 {|transition: $(property) $(duration) $(timingFunction) $(delay) $(behavior)|}];
[%css
  {|transition: $(property) $(duration) $(timingFunction) $(delay), $(property3) 0s|}
];
[%cx2 {|transition: $(property) 0.2s ease-out 3s|}];
[%cx2 {|transition: $(property) 0.2s $(timingFunction) 3s|}];
[%cx2 {|transition: $(property) $(duration) $(timingFunction) 3s|}];
[%cx2 {|transition: margin-right $(duration) ease-out $(delay)|}];
[%cx2 {|transition: $(property) $(duration) ease-out $(delay)|}];
[%cx2 {|transition: margin-right 0.2s $(timingFunction) 3s|}];
[%cx2 {|transition: margin-right 0.2s ease-out $(delay)|}];
[%cx2 {|transition: $(property) 0.2s ease-in|}];
[%cx2 {|transition: $(property) 0.2s $(timingFunction)|}];
[%cx2 {|transition: margin-right $(duration) ease-in|}];
[%cx2 {|transition: $(property) $(duration) ease-in|}];
[%cx2 {|transition: margin-right 0.2s $(timingFunction)|}];
[%cx2 {|transition: $(property) 0.2s ease-in|}];
[%cx2 {|transition: margin-right $(duration) ease-in|}];
[%cx2 {|transition: margin-right 0.2s $(timingFunction)|}];
[%cx2 {|transition: $(property) 0.2s|}];
[%cx2 {|transition: margin-right $(duration)|}];
