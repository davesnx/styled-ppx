### styled.global
**Inject global css**, method to apply general styles to your website.

```reason
[%styled.global {|
  html, body {
    margin: 0;
    padding: 0;
  }
|}];
```

```reason
[%styled.global {|
  html, body {
    margin: 0;
    padding: 0;
  }

  .div {
    display: flex;
  }
|}];
```

<!-- TODO: Add warning here about not adding @font-face here, a link to a way of adding fonts -->