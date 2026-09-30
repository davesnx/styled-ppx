A native library and its Melange twin - the same source, compiled twice under
two different dune library names (`copy_files` into a Melange build dir is
the common case) - must keep minting the SAME atom AND identity classes, so
server HTML and client hydration agree. Since `--namespace` now defaults to
the `library-name` cookie, two dune libraries with different names salt
their atoms differently BY DEFAULT; a twin pair must override the default by
passing one shared `--namespace` to both stanzas (the same fix the identity
class already needed - see `identity-library-namespace.t`'s last section).

  $ mkdir -p native js
  $ cp Marker.re native/Marker.re
  $ cp Marker.re js/Marker.re
  $ refmt --parse re --print ml native/Marker.re > native/Marker.ml
  $ refmt --parse re --print ml js/Marker.re > js/Marker.ml

Without a shared `--namespace`, two libraries named differently mint
DIFFERENT atom and identity classes for the exact same source - the failure
mode a twin pair must avoid:

  $ ../../standalone.exe -cookie 'library-name="lib_native"' --impl native/Marker.ml -o native/default.ml
  $ ../../standalone.exe -cookie 'library-name="lib_js"' --impl js/Marker.ml -o js/default.ml
  $ diff native/default.ml js/default.ml
  1,4c1,4
  < [@@@css.config [("library-name", "lib_native")]]
  < [@@@css "._a_7pkwep{margin:10px;}"]
  < [@@@css.bindings [("Marker.marker", "_id_1gfp5g8", "_a_7pkwep")]]
  < let marker = CSS.make "label:marker _id_1gfp5g8 _a_7pkwep" []
  ---
  > [@@@css.config [("library-name", "lib_js")]]
  > [@@@css "._a_7pwt2x{margin:10px;}"]
  > [@@@css.bindings [("Marker.marker", "_id_jr5pjc", "_a_7pwt2x")]]
  > let marker = CSS.make "label:marker _id_jr5pjc _a_7pwt2x" []
  [1]

Passing the SAME explicit `--namespace` to both stanzas overrides their
differing cookies, so both mint identical atom and identity classes again:

  $ ../../standalone.exe -cookie 'library-name="lib_native"' --namespace lib --impl native/Marker.ml -o native/twin.ml
  $ ../../standalone.exe -cookie 'library-name="lib_js"' --namespace lib --impl js/Marker.ml -o js/twin.ml
  $ cat native/twin.ml
  [@@@css.config [("library-name", "lib_native")]]
  [@@@css "._a_7pjvti{margin:10px;}"]
  [@@@css.bindings [("Marker.marker", "_id_ikmmxf", "_a_7pjvti")]]
  let marker = CSS.make "label:marker _id_ikmmxf _a_7pjvti" []
  let _ = marker
  $ diff native/twin.ml js/twin.ml
  1c1
  < [@@@css.config [("library-name", "lib_native")]]
  ---
  > [@@@css.config [("library-name", "lib_js")]]
  [1]
