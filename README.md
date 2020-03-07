# re-styled-ppx

**styled** is the ppx that enables *CSS-in-Reason*.

Allows you to create React Components with style definitions with CSS that doesn't rely on a specific DSL and keeps type-safety with great error messages.Build on top of [bs-emotion](https://github.com/ahrefs/bs-emotion), it allows you to style apps quickly, performant and as you always done it.

> ⚠️ **Early stage** This ppx is in a early stage. Meaning that it doesn't support full functionality as [emotion](https://emotion.sh) or [styled-components](https://styled-components.com/).

> But you can safely use it, as it woudn't break any existing code.
> In case you want to know more, take a look at the [ROADMAP](./ROADMAP.md), or feel free to chat on Discord: @davesnx#5641

## Motivation
I love CSS and comming from the JavaScript world, writing React code with styled-components. I found it, one of the best combos to write scalable frontend applications and wasn't a reality in ReasonML/OCaml.

Saw a few people asking for it as well (on [Discord](https://discordapp.com/channels/235176658175262720/235176658175262720), [reasonml.chat](https://reasonml.chat) or twitter) So I took the time to create it with help from [@jchavarri](https://github.com/jchavarri).

## Usage
`re-styled-ppx` implements a ppx that transforms `[%styled]` extensions into [bs-emotion](https://github.com/ahrefs/bs-emotion) APIs.

How you write the components:
```re
module Component = [%styled "display: flex"];

module ComponentWithMultiline = [%styled {|
  display: flex;
  justify-content: center;
  align-items: center;
|}];

ReactDOMRe.renderToElementWithId(
  <ComponentWithMultiline>
    {React.string("- Middle -")}
  </ComponentWithMultiline>,
  "app"
);
```

After running the ppx:
```re
module Component = {
  let styled = Emotion.(css([display(`flex)]));
  [@react.component]
  let make = (~children) => {
    <div className=styled> children </div>
  }
};

module ComponentWithMultiline = {
  let styled = Emotion.(css([display(`flex), justifyContent(`center), alignItems(`center)]));
  [@react.component]
  let make = (~children) => {
    <div className=styled> children </div>
  }
};
```

It works in OCaml as well:
```ocaml
module Component = [%styled ("display: flex")]

module ComponentMultiline = [%styled
  {|
    color: #333;
    background-color: #333;
    margin: auto 0 10px 1em;
    border-bottom: thin dashed #eee;
    border-right-color: rgb(1, 0, 1);
    width: 70%;
    background: url(http://example.com/test.jpg);
  |}
]
```

## Installation

### With `esy` on native projects

```bash
esy add davesnx/re-styled-ppx
```

### With `npm` or `yarn` on BuckleScript projects

```bash
yarn global add @davesnx/re-styled-ppx
# Or
npm -g install @davesnx/re-styled-ppx
```

And add the PPX in your `bsconfig.json` file:

```json
{
  "ppx-flags": ["@davesnx/re-styled-ppx"]
}
```

However, if you want to use `esy` in BuckleScript:
Create an `esy.json` file with the content:

```json
{
  "name": "test_bs",
  "version": "0.0.0",
  "dependencies": {
    "re-styled-ppx": "*",
    "ocaml": "~4.6.1000"
  },
  "resolutions": {
    "re-styled-ppx": "davesnx/re-styled-ppx"
  }
}
```

And add the PPX in your `bsconfig.json` file:

```json
{
  "ppx-flags": ["esy x re-styled-ppx.exe"]
}
```

## Thanks to
Thanks to [Javier Chávarri](https://github.com/jchavarri), for helping me understand all the world of OCaml and his knowledge about ppx's. It has been a great experience.
Inspired by [@astrada](https://github.com/astrada/) `bs-css-ppx` and their CSS Parser.
Thanks to [ahrefs/bs-emotion](https://github.com/ahrefs/bs-emotion) and [emotion](https://github.com/emotion-js/emotion).

## Contributing
We would love your help improving re-styled-ppx, there's still a lot to do.
The ROADMAP is full and well organized, take a look in [here](./ROADMAP.md).

### Developing
You need `esy`, you can install the latest version from [npm](https://npmjs.com):

```bash
yarn global add esy@latest
# Or
npm install -g esy@latest
```

> NOTE: Make sure `esy --version` returns at least `0.5.8` for this project to build.

Then run the `esy` command from this project root to install and build depenencies.

```bash
esy
```

Now you can run your editor within the environment (which also includes merlin):

```bash
esy $EDITOR
esy vim
```

After you make some changes to source code, you can re-run project's build
again with the same simple `esy` command and run the native tests with

```bash
esy test
```

This project uses [Dune](https://dune.build/) as a build system, if you add a dependency in your `package.json` file, don't forget to add it to your `dune` and `dune-project` files too.

### Running Tests

You can test compiled executable (runs `scripts.tests` specified in `package.json`):

This will run the native unit test.
```bash
esy test
```

If you want to run Bucklescript's integration test instead, you can do:
```bash
cd test_bs
esy
yarn install
yarn test
```

---

Happy reasoning!

<!-- ### Creating release builds

To release prebuilt binaries to all platforms, we use Github Actions to build each binary individually.

The binaries are then uploaded to a Github Release and NPM automatically.

To trigger the Release workflow, you need to push a git tag to the repository.
We provide a script that will bump the version of the project, tag the commit and push it to Github:

```bash
./scripts/release.sh
```

The script uses `npm version` to bump the project, so you can use the same argument.
For instance, to release a new patch version, you can run:

```bash
./scripts/release.sh patch
```
 -->
