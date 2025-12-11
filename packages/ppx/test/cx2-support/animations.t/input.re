let foo = [%keyframe2 {|0% { opacity: 0.0 } 100% { opacity: 1.0 }|}];
let bar = [%keyframe2 {|0% { opacity: 0.0 } 100% { opacity: 1.0 }|}];

/* CSS Animations Level 1 */
[%cx2 {|animation-name: random|}];
[%cx2 {|animation-name: foo, bar|}];
// Note: [%keyframe2] produces `KeyframesName which is not compatible with
// animation-name interpolation that expects AnimationName.t
// [%cx2 {|animation-name: $(foo)|}];
// [%cx2 {|animation-name: $(foo), $(bar)|}];
[%cx2 {|animation-duration: 0s|}];
[%cx2 {|animation-duration: 1s|}];
[%cx2 {|animation-duration: 100ms|}];
[%cx2 {|animation-duration: 1.64s, 15.22s|}];
[%cx2 {|animation-duration: 10s, 35s, 230ms|}];
[%cx2 {|animation-timing-function: ease|}];
[%cx2 {|animation-timing-function: linear|}];
[%cx2 {|animation-timing-function: ease-in|}];
[%cx2 {|animation-timing-function: ease-out|}];
[%cx2 {|animation-timing-function: ease-in-out|}];
[%cx2 {|animation-timing-function: cubic-bezier(.5, .5, .5, .5)|}];
[%cx2 {|animation-timing-function: cubic-bezier(.5, 1.5, .5, -2.5)|}];
[%cx2 {|animation-timing-function: step-start|}];
[%cx2 {|animation-timing-function: step-end|}];
[%cx2 {|animation-timing-function: steps(3, start)|}];
[%cx2 {|animation-timing-function: steps(5, end)|}];
[%css
  {|animation-timing-function: ease, step-start, cubic-bezier(0.1, 0.7, 1, 0.1)|}
];
[%cx2 {|animation-iteration-count: infinite|}];
[%cx2 {|animation-iteration-count: 8|}];
[%cx2 {|animation-iteration-count: 4.35|}];
[%cx2 {|animation-iteration-count: 2, 0, infinite|}];
[%cx2 {|animation-direction: normal|}];
[%cx2 {|animation-direction: alternate|}];
[%cx2 {|animation-direction: reverse|}];
[%cx2 {|animation-direction: alternate-reverse|}];
[%cx2 {|animation-direction: normal, reverse|}];
[%cx2 {|animation-direction: alternate, reverse, normal|}];
[%cx2 {|animation-play-state: running|}];
[%cx2 {|animation-play-state: paused|}];
[%cx2 {|animation-play-state: paused, running, running|}];
[%cx2 {|animation-delay: 1s|}];
[%cx2 {|animation-delay: -1s|}];
[%cx2 {|animation-delay: 2.1s, 480ms|}];
[%cx2 {|animation-fill-mode: none|}];
[%cx2 {|animation-fill-mode: forwards|}];
[%cx2 {|animation-fill-mode: backwards|}];
[%cx2 {|animation-fill-mode: both|}];
[%cx2 {|animation-fill-mode: both, forwards, none|}];
[%cx2 {|animation: foo 1s 2s infinite linear alternate both|}];
[%cx2 "animation: 4s ease-in 1s infinite reverse both paused"];
[%cx2 "animation: a 300ms linear 400ms infinite reverse forwards running"];
