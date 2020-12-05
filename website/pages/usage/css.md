### Inline css function
```reason
ReactDOMRe.renderToElementWithId(
  <span className=[%css "font-size: 32px"]> {React.string("Hello!")} </span>,
  "app",
);
```

For further detail, take a look in [here](./docs/apis.md).
