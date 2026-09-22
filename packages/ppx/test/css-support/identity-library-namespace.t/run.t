The identity namespace defaults to the dune library name, which dune passes
as the `library-name` cookie to every ppx run inside a `(library ...)`
stanza. Two dune libraries never share a name, so `Button.root` in library
`ui` and `Button.root` in library `admin` mint distinct `cid-...` classes
with no configuration.

  $ refmt --parse re --print ml input.re > input.ml

  $ ../../standalone.exe -cookie 'library-name="ui"' --impl input.ml -o ui.ml
  $ grep "css.bindings" ui.ml
  [@@@css.bindings [("Input.marker", "cid-1lismv4", "css-tokvmb-marker")]]

  $ ../../standalone.exe -cookie 'library-name="admin"' --impl input.ml -o admin.ml
  $ grep "css.bindings" admin.ml
  [@@@css.bindings [("Input.marker", "cid-1v8uaax", "css-tokvmb-marker")]]

The same library name mints the same identity, build after build.

  $ ../../standalone.exe -cookie 'library-name="ui"' --impl input.ml -o ui2.ml
  $ grep "css.bindings" ui2.ml
  [@@@css.bindings [("Input.marker", "cid-1lismv4", "css-tokvmb-marker")]]

`--namespace` overrides the default. A native library and its melange twin
built from the same sources have different library names, so they pass one
shared `--namespace` and keep minting the same identity.

  $ ../../standalone.exe -cookie 'library-name="lib_native"' --namespace lib --impl input.ml -o native.ml
  $ grep "css.bindings" native.ml
  [@@@css.bindings [("Input.marker", "cid-1j0hi0j", "css-tokvmb-marker")]]

  $ ../../standalone.exe -cookie 'library-name="lib_js"' --namespace lib --impl input.ml -o js.ml
  $ grep "css.bindings" js.ml
  [@@@css.bindings [("Input.marker", "cid-1j0hi0j", "css-tokvmb-marker")]]

Without a cookie (an executable stanza) the namespace is empty, unchanged
from before the default existed; see identity-namespace.t.

  $ ../../standalone.exe --impl input.ml -o none.ml
  $ grep "css.bindings" none.ml
  [@@@css.bindings [("Input.marker", "cid-1rctcrz", "css-tokvmb-marker")]]
