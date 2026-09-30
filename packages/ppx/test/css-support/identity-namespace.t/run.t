`--namespace <string>` is mixed into every binding's identity hash, so two
libraries that would otherwise mint the same `_id_...` (same module
basename, same binding name, no other distinguishing input) can be told
apart. No `--namespace` is equivalent to `--namespace ""`; passing the
same non-empty value twice mints the same identity both times - it is a
deterministic input, not a nonce.

  $ refmt --parse re --print ml input.re > input.ml

  $ ../../standalone.exe --impl input.ml -o none.ml
  $ cat none.ml
  [@@@css "._a_4ekvmb{color:red;}"]
  [@@@css.bindings [("Input.marker", "_id_1rctcrz", "_a_4ekvmb")]]
  let marker = CSS.make "label:marker _id_1rctcrz _a_4ekvmb" []
  let _ = marker

  $ ../../standalone.exe --namespace a --impl input.ml -o a1.ml
  $ cat a1.ml
  [@@@css "._a_4ect8h{color:red;}"]
  [@@@css.bindings [("Input.marker", "_id_12d5hxh", "_a_4ect8h")]]
  let marker = CSS.make "label:marker _id_12d5hxh _a_4ect8h" []
  let _ = marker

  $ ../../standalone.exe --namespace a --impl input.ml -o a2.ml
  $ cat a2.ml
  [@@@css "._a_4ect8h{color:red;}"]
  [@@@css.bindings [("Input.marker", "_id_12d5hxh", "_a_4ect8h")]]
  let marker = CSS.make "label:marker _id_12d5hxh _a_4ect8h" []
  let _ = marker
