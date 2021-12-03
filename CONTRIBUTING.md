# Contributing to `styled-ppx`

We aim to keep all technical discussions inside GitHub issues, and all other discussions in the [Reason Discord](https://discord.gg/T6YxT5JCWX). This is to make sure valuable discussions are public and discoverable via search engines.

If you have questions about a specific PR, want to discuss a new API idea or a bug, GitHub issues are the right place. If you have questions about how to use it, or how the project is running - the [Reason Discord](https://discord.gg/T6YxT5JCWX) is the place to go.

The roadmap lives under the [Projects](https://github.com/davesnx/styled-ppx/projects) in GitHub.

## What about if you have problems that cannot be discussed in a public?

[David Sancho](https://github.com/davesnx) have a contact email on the GitHub profile, and happy to talk about any problems via those, via Discord or [Twitter DMs](https://twitter.com/davesnx).

## Code contributions

Here is a quick guide to doing code contributions to the repository.

<!-- 1. Find some issue you're interested in, or a feature that you'd like to tackle.
   Also make sure that no one else is already working on it. We don't want you to be
   disappointed.

2. Fork, then clone: `git clone https://github.com/YOUR_USERNAME/styled-components.git`

3. Create a branch with a meaningful name for the issue: `git checkout -b fix-something`

4. Install packages by running `yarn` in the root of the project.

5. Make your changes and commit: `git add` and `git commit`

6. Make sure that the tests still pass: `yarn test` and `yarn lint` (for the type checks)

7. Push your branch: `git push -u origin your-branch-name`

8. Submit a pull request to the upstream styled-components repository.

9. Choose a descriptive title and describe your changes briefly.

10. Wait for a maintainer to review your PR, make changes if it's being recommended, and get it merged.

11. Perform a celebratory dance! :dancer: -->

## Set up the project

- Make sure you have installed esy and yarn.
- Run [`esy`](https://esy.sh) and edit code in the `packages/*` folder.

### Editor setup

Now you can run your editor within the environment if you use vim like so: `esy $EDITOR`.

If you use VSCode, make sure you have installed OCaml Platform via [esy](https://esy.sh), and just open the editor on the root of the project.

## Workflow

After you make some changes to source code, you can re-run project's build again with the same simple `esy build` command.

If you want a faster feedback look, use `esy dev` where runs the build automatically every file changes.

This project uses dune as a build system, if you add a dependency in the package.json, don't forget to add it to dune as well.

### How do I verify and test my changes?

<!-- Explain this better -->
<!-- Test are a good way to keep a common knowledge of the supported features, avoid regressions and allows to create a failing test case and practice TDD -->

You can test any changes from the ppx generation with different test suites. Such as:

- Native tests running esy test_native
- Snapshot tests running esy test_snapshot
- BuckleScript tests (see below). This tests are more like an end to end tests, where we run the typechecker aganinst bs-css-emotion.
- also there's tests related with internal libraries such as CSS Parser, CSS Lexer and CSS Spec Parser, and all of those run with a single command: esy test.

- If you want to run Bucklescript's integration test instead, you can do:

```bash
esy
cd packages/ppx/test/bucklescript
yarn install
yarn build
yarn test
```

<!-- To make development process easier we provide a Sandbox React application in this repo which automatically uses your local version of the `styled-components` library. That means when you make any changes in the `packages/styled-components/src/` folder they'll show up automatically there!

To use the sandbox, follow these steps:

1. Go to sandbox folder: `cd packages/sandbox`

2. Install all the dependencies: `yarn install`. Since this repository uses `yarn` workspaces, avoid using `npm` where you can.

3. Run `yarn start` to start sandbox server

Now you should have the sandbox running on `localhost:3000`. The Sandbox supports client-side and server-side rendering.

You can use an interactive editor, powered by [`react-live`](https://react-live.philpl.com/), to test your changes. But if you want more control, you can edit the sandbox itself too:

- Root `<App>` component is located at `packages/sandbox/src/App.js` file

- Client-side entry point is at `packages/sandbox/src/browser.js`

- Server-side entry point is at `packages/sandbox/src/server.js`

In the sandbox source, `styled-components` is an alias to `packages/styled-components/src` folder, so you can edit the source directly and dev-server will handle rebuilding the source and livereloading your sandbox after the build is done.

When you commit our pre-commit hook will run, which executes `lint-staged`. It will run the linter automatically and warn you if the code you've written doesn't comply with our code style guidelines. -->

## Release process

TBD

<!-- [Core team members](./CORE_TEAM.md) have the responsibility of pushing new releases to npm. The release process is as follows:

1. Make sure you have the latest changes and are on the main branch: `git checkout main && git pull origin main`
2. Install all the dependencies by running `yarn` in the root folder. This will also install `lerna`.
3. Create a new branch based on the version number, for example `git checkout -b 3.4.1`
4. Update the [CHANGELOG.md](./CHANGELOG.md) with the new version number, add a new Unreleased section at the top and edit the links at the bottom so everything is linked correctly
5. Commit the Changelog changes with `git commit -m 'Update CHANGELOG'`
6. Push the branch to the repo with `git push -u origin <branchname>`
7. Run `yarn run publish`. (Not `yarn publish`) This will run `test` cases, check for `flow` and `lint` errors and then start the `lerna publish` process. You will prompted to choose the next versions for all the packages including `styled-components`. (Note: Packages which are marked as `private` will not be published to `npm`, choose any version for them).
8. Congratulations, you just published a new release of `styled-components`! :tada: Let everybody know on Twitter, in our community and all the other places -->

## Credits

These contribution guidelines are based on [styled-components's guideline](https://github.com/styled-components/styled-components).
