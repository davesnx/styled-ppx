# Contributing to `styled-ppx`

We aim to keep all technical discussions inside GitHub issues, and all other discussions in the [Reason Discord](https://discord.gg/T6YxT5JCWX).

If you have questions about a specific PR, want to discuss a new API idea or a bug, GitHub issues are the right place. If you have questions about how to use it, or how the project is running - the [Reason Discord](https://discord.gg/T6YxT5JCWX) is the place to go.

## What about if you have problems that cannot be discussed in public?

You can contact via [Discord](discordapp.com/users/122441959414431745) or a DM in [Twitter](https://twitter.com/davesnx).

## Code contributions

Here is a quick guide to doing code contributions to the repository.

1. Find some issue you're interested in, or a feature that you'd like to tackle.

2. Fork, then clone: `git clone https://github.com/YOUR_USERNAME/styled-ppx.git`.

3. Create a branch with a meaningful name for the issue: `git checkout -b fix-something`.

4. Setup the project (see below).

5. Make your changes and commit: `git add` and `git commit`.

6. Make sure that the tests still pass: `make test` (if you ran `make init` a pre-push githook has been created for you to run each time you push).

7. Push your branch: `git push -u origin your-branch-name`.

8. Submit a pull request to the upstream styled-ppx repository.

9. Choose a descriptive title and describe your changes briefly.

10. Wait for a maintainer to review your PR, make changes if it's being recommended, and get it merged.

11. Perform a celebratory dance! :dancer:

## Set up the project

- Make sure you have installed opam and npm.
- Run `make init` will setup the opam switch, install dependencies and some pinned packages.
- Run `make build` will build the project or `make dev` to build and watch for changes.
- Run `make test` to run all test suites.

### Editor setup

Ensure `ocaml-lsp-server` is installed with `opam info ocaml-lsp-server` and in case not, install it with `opam install ocaml-lsp-server`.

In any other case, follow the generic installation steps from [Reason documentation](https://reasonml.github.io/docs/en/editor-plugins).

### How do I verify and test my changes?

Aside from all test suites, check the [Makefile](./Makefile) for all the available commands.

There are some end-to-end tests to ensure all the ppx generation is working as expected, under the `demo/` folder. Which contains

```bash
$ tree -L 1 demo
demo
├── melange
├── rescript-v10-JSX4
└── rescript-v9-JSX3
```

```bash
make build
make test_demo_rescript_v10
```

## Release process

- Each PR created will create a nightly release that you can install via npm.
- Each stable release will happen once the package.json's version is updated and merged in the main branch.

## Credits

These contribution guidelines are based on [styled-components's guideline](https://github.com/styled-components/styled-components).
