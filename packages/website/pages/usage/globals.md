# Inject global styles

`%styled.global` is the method to apply general styles to your website.

```rescript
%styled.global(`
  html, body {
    margin: 0;
    padding: 0;
  }
`)
```

Recommend to not add `@font-face` defintions as globals. Consider adding the font directly to the HTML or in a `style.css` file. [More](https://andydavies.me/blog/2019/02/12/preloading-fonts-and-the-puzzle-of-priorities/).

Since [emotion](https://emotion.sh) have a small run-time for those global styles to be applied to the DOM, which in regular styles isn't an issue but adding `@fonts-face` will delay a bit their fetching and can cause a [Flash of Unestyled Text](https://css-tricks.com/fout-foit-foft/).
