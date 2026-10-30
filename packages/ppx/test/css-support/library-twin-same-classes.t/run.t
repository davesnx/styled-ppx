A native library and its Melange twin compile the same source under two dune
library names. Both builds must mint the same atom and identity classes, so
server markup matches the client stylesheet. The `library-name` cookie only
reaches the `[@@@css.config]` entry that `styled-ppx.generate` reads to group
modules; no class hash takes it.

  $ refmt --parse re --print ml Marker.re > Marker.ml

  $ ../../standalone.exe -cookie 'library-name="lib_native"' --impl Marker.ml -o native.ml
  $ ../../standalone.exe -cookie 'library-name="lib_js"' --impl Marker.ml -o js.ml
  $ cat native.ml
  [@@@css.config [("library-name", "lib_native")]]
  [@@@css
    ("._a_5r08qs{display:flex;}", "_a_5r08qs", "0,1,0 own", "207", 1, false)]
  [@@@css
    ("._a_7peacs{margin:10px;}", "_a_7peacs", "0,1,0 own", "277", 15, false)]
  [@@@css
    ("@media (min-width: 768px) {._a_p6loh7p8ooi{margin:20px;}}",
      "_a_p6loh7p8ooi", "0,1,0 own", "277", 15, false)]
  [@@@css
    ("._a_kwhpm60b4vk > ._id_1nxznki{-webkit-flex:0 1 100%;-ms-flex:0 1 100%;flex:0 1 100%;}",
      "_a_kwhpm60b4vk", "0,2,0 & > ._id_1nxznki", "216", 7, false)]
  [@@@css.bindings
    [("Marker.group", "_id_1nxznki", "_a_5r08qs");
    ("Marker.carousel", "_id_1xu6fo2",
      "_a_7peacs _a_p6loh7p8ooi _a_kwhpm60b4vk")]]
  [@@@css.blocks [(1, "_id_1nxznki", [0]); (4, "_id_1xu6fo2", [1; 2; 3])]]
  let group = CSS.make "label:group _id_1nxznki _a_5r08qs" []
  let carousel =
    CSS.make
      "label:carousel _id_1xu6fo2 _a_7peacs _a_p6loh7p8ooi _a_kwhpm60b4vk" []
  let _ = (group, carousel)

Only the `library-name` entry differs:

  $ diff native.ml js.ml
  1c1
  < [@@@css.config [("library-name", "lib_native")]]
  ---
  > [@@@css.config [("library-name", "lib_js")]]
  [1]

A run with no cookie (an executable stanza) mints the same classes too:

  $ ../../standalone.exe --impl Marker.ml -o none.ml
  $ diff native.ml none.ml
  1d0
  < [@@@css.config [("library-name", "lib_native")]]
  [1]

`--namespace` no longer exists:

  $ ../../standalone.exe --namespace lib --impl Marker.ml -o flag.ml 2>&1 | head -1
  ../../standalone.exe: unknown option '--namespace'.
