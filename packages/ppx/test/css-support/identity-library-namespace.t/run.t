`--namespace` defaults to the dune `library-name` cookie (see
`Settings.Get.namespace`), replacing the empty default this file used to
pin. Two dune libraries with different library names now mint DIFFERENT
`_id_...` identities AND `_a_...` atom classes for the same module and
binding name, with no `--namespace` flag at all.

  $ refmt --parse re --print ml input.re > input.ml

  $ ../../standalone.exe -cookie 'library-name="ui"' --impl input.ml -o ui.ml
  $ cat ui.ml
  [@@@css.config [("library-name", "ui")]]
  [@@@css "._a_4eogw8{color:red;}"]
  [@@@css.bindings [("Input.marker", "_id_1lismv4", "_a_4eogw8")]]
  let marker = CSS.make "label:marker _id_1lismv4 _a_4eogw8" []
  let _ = marker

  $ ../../standalone.exe -cookie 'library-name="admin"' --impl input.ml -o admin.ml
  $ cat admin.ml
  [@@@css.config [("library-name", "admin")]]
  [@@@css "._a_4elw89{color:red;}"]
  [@@@css.bindings [("Input.marker", "_id_1v8uaax", "_a_4elw89")]]
  let marker = CSS.make "label:marker _id_1v8uaax _a_4elw89" []
  let _ = marker

  $ diff ui.ml admin.ml
  1,4c1,4
  < [@@@css.config [("library-name", "ui")]]
  < [@@@css "._a_4eogw8{color:red;}"]
  < [@@@css.bindings [("Input.marker", "_id_1lismv4", "_a_4eogw8")]]
  < let marker = CSS.make "label:marker _id_1lismv4 _a_4eogw8" []
  ---
  > [@@@css.config [("library-name", "admin")]]
  > [@@@css "._a_4elw89{color:red;}"]
  > [@@@css.bindings [("Input.marker", "_id_1v8uaax", "_a_4elw89")]]
  > let marker = CSS.make "label:marker _id_1v8uaax _a_4elw89" []
  [1]

Without a cookie at all (an executable stanza), the namespace falls back
to the empty default - unrelated to either library name above:

  $ ../../standalone.exe --impl input.ml -o none.ml
  $ cat none.ml
  [@@@css "._a_4ekvmb{color:red;}"]
  [@@@css.bindings [("Input.marker", "_id_1rctcrz", "_a_4ekvmb")]]
  let marker = CSS.make "label:marker _id_1rctcrz _a_4ekvmb" []
  let _ = marker

`--namespace` still overrides the cookie, same as before the cookie was
ever a default: pass each library a different explicit value and they
mint distinct identities and atom classes; pass both the SAME explicit
value and they mint identical ones regardless of their differing
library-name cookies (the native/melange twin case -
`atom-namespace-twin.t` covers this in full).

  $ ../../standalone.exe -cookie 'library-name="ui"' --namespace ui --impl input.ml -o ui-ns.ml
  $ ../../standalone.exe -cookie 'library-name="admin"' --namespace admin --impl input.ml -o admin-ns.ml
  $ diff ui-ns.ml admin-ns.ml
  1,4c1,4
  < [@@@css.config [("library-name", "ui")]]
  < [@@@css "._a_4eogw8{color:red;}"]
  < [@@@css.bindings [("Input.marker", "_id_1lismv4", "_a_4eogw8")]]
  < let marker = CSS.make "label:marker _id_1lismv4 _a_4eogw8" []
  ---
  > [@@@css.config [("library-name", "admin")]]
  > [@@@css "._a_4elw89{color:red;}"]
  > [@@@css.bindings [("Input.marker", "_id_1v8uaax", "_a_4elw89")]]
  > let marker = CSS.make "label:marker _id_1v8uaax _a_4elw89" []
  [1]

  $ ../../standalone.exe -cookie 'library-name="ui"' --namespace shared --impl input.ml -o ui-shared.ml
  $ ../../standalone.exe -cookie 'library-name="admin"' --namespace shared --impl input.ml -o admin-shared.ml
  $ diff ui-shared.ml admin-shared.ml
  1c1
  < [@@@css.config [("library-name", "ui")]]
  ---
  > [@@@css.config [("library-name", "admin")]]
  [1]
