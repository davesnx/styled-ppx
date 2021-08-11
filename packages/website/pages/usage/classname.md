# className: `cx` extension

Sometimes is hard to give the right name for a styled component or sometimes those styles are only used once, that's why `cx` exists.

```reason
<span className=[%cx "font-size: 32px"]> {React.string("Hello!")} </span>,
```

Aside from the styled extension, styled-ppx provides a `%cx` extension. Generates a className given one or more CSS rules. Very useful to attach directly to React's className prop.

```reason
let className: string = [%cx "display: block; color: blue;"];

<div className />
```

