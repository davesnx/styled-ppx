# Array API

Aside from the string API mentioned before, an alternative API use an array instead.

## css extension

Generates a `Css.Rule` given a single CSS rule, generates the [bs-css](https://github.com/giraud/bs-css) rule.

```reason
let rule: Css.Rule.t = [%css "display: block; "];
```

## Compose extensions and styles

Both `cx` and `styled` extension support the following:

```reason
module Component = [%styled.section [|
  [%css "display: flex;"],
  [%css "justify-content: center;"]
|]];

let className = [%cx [|
  [%css "display: flex;"]
|]];
```

Any expression that is a `Css.Rule.t` is valid inside the array.

Allowing composability and re-usability of CSS. Useful to reference other variables or an inline pattern match. Solves the migration from other systems (such as `bs-css`) and bypass `styled-ppx` parser that might not support a property.

Here are some illustrative examples:

```reason
module Button = [%styled.button [|
  buttonStyles, // a variable reference
  anyRandomFunction(123), // a function call
  boolean ? [%css "width: 100%;"] : [%css "width: auto"], // conditional
|];
```

```reason
module Align = [%styled.div (~distribute=`Center, ~align=`Center) => [|
    [%css "display: flex"],
    [%css "height: 100%"],
    [%css "width: 100%;"],
    switch (distribute) {
    | `Start => [%css "justify-content: flex-start"]
    | `Center => [%css "justify-content: center"]
    | `End => [%css "justify-content: flex-end"]
    },
    switch (align) {
    | `Start => [%css "align-items: flex-start"]
    | `Center => [%css "align-items: center"]
    | `End => [%css "align-items: flex-end"]
    },
  |]
];

<Align distribute=`Start align=`Start />
```

### Usage with Dynamic components

There's a nice trick where dynamic components with the Array API provides: running any code before the styles and treat the module as an inlined function. It will be called each time the component renders. Such as:

```reason
module Button = [%styled.button (~variant) => {
  let color = Theme.button(~variant);

  [|
    [%css "color: $(color)"],
    [%css "width: 100%;"],
    [%css "display: inline-flex"],
  |];
}];
```

This is just an example of runtime for styles where the theme calculates the right color for the button.
