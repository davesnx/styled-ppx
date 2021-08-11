# Interpolation

```reason
module Component = [%styled.div "
  border: 1px solid $(Theme.black);
"];
```

Interpolation here means using any identifier as a value inside a CSS definition. Useful for reusing variables, handling themes or change CSS during run-time.

This interpolation only works inside values, which is slightly different from other JavaScript-based solutions (such as styled-components or emotion), where their interpolation is much more dynamic, you might find styled-ppx more strict, here's an example:

`margin-${whatever}: 10px` is valid in JavaScript, while isn't valid in styled-ppx.

As a solution, you can implement similar behaviour with more explicitness, using the `css` extension which is described below.

```reason
let margin = direction => {
   switch (direction) {
      | `Left => [%css "margin-left: 10px;"]
      | `Right => [%css "margin-right: 10px;"]
      | `Top => [%css "margin-top: 10px;"]
      | `Bottom => [%css "margin-bottom: 10px;"]
   }
};
```

Interpolation is treated as unsafe, disables the type-checker which can lead to run-time issues.
This is the current implementation and the reason for that is because is very hard to implement type-safety with [shorthand properties](https://developer.mozilla.org/en-US/docs/Web/CSS/Shorthand_properties) and the polymorphism of CSS.

## Polymorphism of CSS

There are plenty of properties on CSS that accept different types of values, the ones encountered more challenging are `animation`, `box-shadow`, `background`, `transition` and `transform`, to name a few.

```reason
background: #fff; /* The background is white */
background: url(img.png); /* The background is an image */
background: #fff url(img.png); /* The background is white with an image */
background: url(img.png) no-repeat; /* The background is a non-repeating image */
```

In this case, `background: $(variable)`. The type-checker doesn't know the type of `$(variable)`, and if will be valid at run-time. That's the reason to treat everything as strings. This might change on the future, but it's a known limitation.

