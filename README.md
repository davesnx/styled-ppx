![styled-ppx-header-light](./.github/header-light.png#gh-dark-mode-only)![styled-ppx-header-dark](./.github/header-dark.png#gh-light-mode-only)

![demo](./.github/demo-dark.png#gh-dark-mode-only)![styled-ppx-demo-dark](./.github/demo-light.png#gh-light-mode-only)

### Typed styled components for ReScript

**styled-ppx** is a [ppx](https://tarides.com/blog/2019-05-09-an-introduction-to-ocaml-ppx-ecosystem) that brings styled components to ReScript. Built on top of [emotion](https://emotion.sh), it allows you to style apps safely, quickly, and with zero runtime overhead - just as you have always done it. styled-ppx allows you to create **React Components** with type-safe style definitions that don't rely on a different language ([DSL](https://en.wikipedia.org/wiki/Domain-specific_language)) except CSS.

## Usage

```bash
npm install @davesnx/styled-ppx
```

### Update `bsconfig.json`

Add `"@davesnx/styled-ppx/ppx"` under bsconfig `"ppx-flags"`:

```diff
{
  "bs-dependencies": [
    "@rescript/react",
+   "@davesnx/styled-ppx/css",
+   "@davesnx/styled-ppx/emotion"
  ],
+ "ppx-flags": ["@davesnx/styled-ppx/ppx"]
}
```

Read more about [getting started](https://styled-ppx.vercel.app/getting-started).

## [Documentation](https://styled-ppx.vercel.app)

For the entire documentation, visit [styled-ppx.vercel.app](https://styled-ppx.vercel.app).

### Editor Support

We provide an editor extension that brings syntax highlighting. (In the future it may include IntelliSense or other [CSS-related](https://code.visualstudio.com/docs/languages/css) features.)

#### VSCode Extension

Install the **[VSCode Extension](https://marketplace.visualstudio.com/items?itemName=davesnx.vscode-styled-ppx)**.

#### vim plugin

Install the **[vim plugin](https://github.com/ahrefs/vim-styled-ppx/blob/main/README.md#installation)**.

> If you are interested on another editor, please [file an issue](https://github.com/davesnx/styled-ppx/issues/new).

## Contributing

We would love your help improving **styled-ppx**! Please see our contributing and community guidelines; they'll help you get set up locally and explain the whole process: [CONTRIBUTING.md](./CONTRIBUTING.md).

## License

This project is licensed under the [Simplified BSD License (BSD 2-Clause License)](./LICENSE).

## CI

<a href="https://github.com/davesnx/styled-ppx/actions"><img alt="CI" src="https://github.com/davesnx/styled-ppx/workflows/CI/badge.svg"></a> <a href="https://badge.fury.io/js/%40davesnx%2Fstyled-ppx"><img src="https://badge.fury.io/js/%40davesnx%2Fstyled-ppx.svg" alt="npm version"></a>
