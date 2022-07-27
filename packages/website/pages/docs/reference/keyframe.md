# Keyframes

**Generates keyframes**, method to create animations with CSS

```rescript
let fadeIn = %keyframe(`
  0% {
    opacity: 0;
  }

  100% {
    opacity: 1;
  }
`)

module Component = %styled.div(`
  animation-name: $(fadeIn);
  width: 100px;
  height: 100px;
`)
```
