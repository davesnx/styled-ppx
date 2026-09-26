The identity namespace does not depend on the dune `library-name` cookie.
Two dune libraries with different library names mint the SAME `id-...`
for the same module and binding name when neither passes `--namespace`
(RED before the fix: see the report for the pre-fix diff).

  $ refmt --parse re --print ml input.re > input.ml

  $ ../../standalone.exe -cookie 'library-name="ui"' --impl input.ml -o ui.ml
  $ cat ui.ml
  [@@@css.config [("library-name", "ui")]]
  [@@@css "._a_4ekvmb{color:red;}"]
  [@@@css.bindings [("Input.marker", "_id_1rctcrz", "_a_4ekvmb")]]
  let marker = CSS.make "label:marker _id_1rctcrz _a_4ekvmb" []
  let _ = marker

  $ ../../standalone.exe -cookie 'library-name="admin"' --impl input.ml -o admin.ml
  $ cat admin.ml
  [@@@css.config [("library-name", "admin")]]
  [@@@css "._a_4ekvmb{color:red;}"]
  [@@@css.bindings [("Input.marker", "_id_1rctcrz", "_a_4ekvmb")]]
  let marker = CSS.make "label:marker _id_1rctcrz _a_4ekvmb" []
  let _ = marker

  $ diff ui.ml admin.ml
  1c1
  < [@@@css.config [("library-name", "ui")]]
  ---
  > [@@@css.config [("library-name", "admin")]]
  [1]

Without a cookie at all (an executable stanza) the identity is the same
too: the cookie was never part of the hash once `--namespace` is absent.

  $ ../../standalone.exe --impl input.ml -o none.ml
  $ diff ui.ml none.ml
  1d0
  < [@@@css.config [("library-name", "ui")]]
  [1]

`--namespace` still lets two libraries that share a module basename and
binding name mint distinct identities, the way it did before the library
name was ever a default: pass each one a different value.

  $ ../../standalone.exe -cookie 'library-name="ui"' --namespace ui --impl input.ml -o ui-ns.ml
  $ ../../standalone.exe -cookie 'library-name="admin"' --namespace admin --impl input.ml -o admin-ns.ml
  $ diff ui-ns.ml admin-ns.ml
  1c1
  < [@@@css.config [("library-name", "ui")]]
  ---
  > [@@@css.config [("library-name", "admin")]]
  3,4c3,4
  < [@@@css.bindings [("Input.marker", "_id_1lismv4", "_a_4ekvmb")]]
  < let marker = CSS.make "label:marker _id_1lismv4 _a_4ekvmb" []
  ---
  > [@@@css.bindings [("Input.marker", "_id_1v8uaax", "_a_4ekvmb")]]
  > let marker = CSS.make "label:marker _id_1v8uaax _a_4ekvmb" []
  [1]

A native library and its melange twin, built from the same sources under
different library names, still keep minting the same identity by passing
one shared `--namespace` on both stanzas - unchanged from before.

  $ ../../standalone.exe -cookie 'library-name="lib_native"' --namespace lib --impl input.ml -o native.ml
  $ ../../standalone.exe -cookie 'library-name="lib_js"' --namespace lib --impl input.ml -o js.ml
  $ diff native.ml js.ml
  1c1
  < [@@@css.config [("library-name", "lib_native")]]
  ---
  > [@@@css.config [("library-name", "lib_js")]]
  [1]
