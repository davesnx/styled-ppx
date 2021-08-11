### keyframe
**Generates keyframes**, method to create animations with CSS

```reason
/* Since animationName is a string under the hood, casting it to string
to match it as a string.

This is clearly a work-around, should be part of the bs-css binding */
external toString: CssJs.animationName => string = "%identity";

let fadeIn = [%keyframe {|
  0% {
    opacity: 0;
  }

  100% {
    opacity: 1;
  }
|}] |> toString;

module Component = [%styled.div {|
  animation-name: $(fadeIn);
  width: 100px;
  height: 100px;
|}];
```
