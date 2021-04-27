# melange

A simple project template using [Melange](https://github.com/melange-re/melange).

## Getting started

You will need [esy](https://esy.sh) package manager to obtain OCaml and Melange sources. See `esy` installation instructions [here](https://esy.sh/docs/en/getting-started.html#install-esy).

Once `esy` is available, run

```bash
esy
```

to install all dependencies.

Then:

```bash
esy build
```

to build the project. Now you should see a `_build` folder with all generated files, you can run

```bash
esy x node _build/default/src/Main.bs.js
```

To see the result of the script running.