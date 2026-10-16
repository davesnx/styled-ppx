Two dune libraries that both declare the SAME base atom (`margin: 10px`) must
never mint the SAME atom class for it: content-hash dedup would otherwise let
one library's copy of that atom - wherever it lands in a page that links both
sheets - decide a tie against the OTHER library's own `@media` override of it.
`--namespace` (defaulting to the dune `library-name` cookie) salts the atom
hash so this never happens: the two libraries' atoms differ even though the
declaration is byte-identical.

  $ refmt --parse re --print ml input.re > input.ml

Library "ui":

  $ ../../standalone.exe -cookie 'library-name="ui"' --impl input.ml -o ui.ml
  $ cat ui.ml
  [@@@css.config [("library-name", "ui")]]
  [@@@css "._a_7px4i4{margin:10px;}"]
  [@@@css "@media (min-width: 768px) {._a_06loh7p008834g{margin-top:20px;}}"]
  [@@@css "@media (min-width: 768px) {._a_06loh7p004w4be{margin-right:20px;}}"]
  [@@@css
    "@media (min-width: 768px) {._a_06loh7p001jjc1{margin-bottom:20px;}}"]
  [@@@css "@media (min-width: 768px) {._a_06loh7p002zp38{margin-left:20px;}}"]
  [@@@css.bindings
    [("Input.base", "_id_msle0w", "_a_7px4i4");
    ("Input.withMedia", "_id_1o6qo3l",
      "_a_7px4i4 _a_06loh7p008834g _a_06loh7p004w4be _a_06loh7p001jjc1 _a_06loh7p002zp38")]]
  let base = CSS.make "label:base _id_msle0w _a_7px4i4" []
  let withMedia =
    CSS.make
      "label:withMedia _id_1o6qo3l _a_7px4i4 _a_06loh7p008834g _a_06loh7p004w4be _a_06loh7p001jjc1 _a_06loh7p002zp38"
      []
  let _ = (base, withMedia)

Library "admin", same source, same base declaration, also carries a
`@media` override of it:

  $ ../../standalone.exe -cookie 'library-name="admin"' --impl input.ml -o admin.ml
  $ cat admin.ml
  [@@@css.config [("library-name", "admin")]]
  [@@@css "._a_7phzb9{margin:10px;}"]
  [@@@css "@media (min-width: 768px) {._a_06loh7p00800f7{margin-top:20px;}}"]
  [@@@css "@media (min-width: 768px) {._a_06loh7p0046w8d{margin-right:20px;}}"]
  [@@@css
    "@media (min-width: 768px) {._a_06loh7p001we4g{margin-bottom:20px;}}"]
  [@@@css "@media (min-width: 768px) {._a_06loh7p002c66l{margin-left:20px;}}"]
  [@@@css.bindings
    [("Input.base", "_id_sheykm", "_a_7phzb9");
    ("Input.withMedia", "_id_16foyc5",
      "_a_7phzb9 _a_06loh7p00800f7 _a_06loh7p0046w8d _a_06loh7p001we4g _a_06loh7p002c66l")]]
  let base = CSS.make "label:base _id_sheykm _a_7phzb9" []
  let withMedia =
    CSS.make
      "label:withMedia _id_16foyc5 _a_7phzb9 _a_06loh7p00800f7 _a_06loh7p0046w8d _a_06loh7p001we4g _a_06loh7p002c66l"
      []
  let _ = (base, withMedia)

The shared base atom's class (and its identity) differ between the two
libraries - nothing else does:

  $ diff ui.ml admin.ml
  1,4c1,4
  < [@@@css.config [("library-name", "ui")]]
  < [@@@css "._a_7px4i4{margin:10px;}"]
  < [@@@css "@media (min-width: 768px) {._a_06loh7p008834g{margin-top:20px;}}"]
  < [@@@css "@media (min-width: 768px) {._a_06loh7p004w4be{margin-right:20px;}}"]
  ---
  > [@@@css.config [("library-name", "admin")]]
  > [@@@css "._a_7phzb9{margin:10px;}"]
  > [@@@css "@media (min-width: 768px) {._a_06loh7p00800f7{margin-top:20px;}}"]
  > [@@@css "@media (min-width: 768px) {._a_06loh7p0046w8d{margin-right:20px;}}"]
  6,7c6,7
  <   "@media (min-width: 768px) {._a_06loh7p001jjc1{margin-bottom:20px;}}"]
  < [@@@css "@media (min-width: 768px) {._a_06loh7p002zp38{margin-left:20px;}}"]
  ---
  >   "@media (min-width: 768px) {._a_06loh7p001we4g{margin-bottom:20px;}}"]
  > [@@@css "@media (min-width: 768px) {._a_06loh7p002c66l{margin-left:20px;}}"]
  9,12c9,12
  <   [("Input.base", "_id_msle0w", "_a_7px4i4");
  <   ("Input.withMedia", "_id_1o6qo3l",
  <     "_a_7px4i4 _a_06loh7p008834g _a_06loh7p004w4be _a_06loh7p001jjc1 _a_06loh7p002zp38")]]
  < let base = CSS.make "label:base _id_msle0w _a_7px4i4" []
  ---
  >   [("Input.base", "_id_sheykm", "_a_7phzb9");
  >   ("Input.withMedia", "_id_16foyc5",
  >     "_a_7phzb9 _a_06loh7p00800f7 _a_06loh7p0046w8d _a_06loh7p001we4g _a_06loh7p002c66l")]]
  > let base = CSS.make "label:base _id_sheykm _a_7phzb9" []
  15c15
  <     "label:withMedia _id_1o6qo3l _a_7px4i4 _a_06loh7p008834g _a_06loh7p004w4be _a_06loh7p001jjc1 _a_06loh7p002zp38"
  ---
  >     "label:withMedia _id_16foyc5 _a_7phzb9 _a_06loh7p00800f7 _a_06loh7p0046w8d _a_06loh7p001we4g _a_06loh7p002c66l"
  [1]
