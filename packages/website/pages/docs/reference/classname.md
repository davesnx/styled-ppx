# className: `cx` extension

Aside from the styled extension, **styled-ppx** provides the `%cx` extension.

`%cx` generates a className given one or more CSS Declarations. Useful to attach to a React's component via the `className` prop. Sometimes is hard to give the right name for a styled component or maybe those styles are only used once, that's why `%cx` exists.

## Examples

```rescript
<span className=%cx("font-size: 32px")> {React.string("Hello!")} </span>
```

```rescript
let fullWidth: string = %cx(`
  position: absolute;
  width: 100%;
  height: 100%;
  top: 0;
  left: 0;
`)

<div className=fullWidth> {React.string("Hello!")} </div>
```

The value `fullWidth` is a string that contains a hash pointing to a style HTML tag in the `<head>`. If you want to concat with other styles, you can use the `+` operator and don't forget to add whitespaces between.

## Features

- Selectors, media queries and other nestign is supported in CSS declarations.
- Interpolation is allowed. `%cx(``color: $(Theme.colors.primary)``)`
- Curly braces aren't allowed. `%cx(``{ display: block; }``)` will break.
