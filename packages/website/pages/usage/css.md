# Inline css as className

Sometimes you only want one style and not worry about the name
of that component or just one case or I particuraly don't like the components API, that's why we have
the `css` transform.

```reason
<span className=[%css "font-size: 32px"]> {React.string("Hello!")} </span>,
```