`--namespace <string>` is mixed into every binding's identity hash, so two
libraries that would otherwise mint the same `cid-...` (same module
basename, same binding name, no other distinguishing input) can be told
apart. No `--namespace` is equivalent to `--namespace ""`; passing the
same non-empty value twice mints the same identity both times - it is a
deterministic input, not a nonce.

  $ refmt --parse re --print ml input.re > input.ml

  $ ../../standalone.exe --impl input.ml -o none.ml
  $ grep "css.bindings" none.ml
  [@@@css.bindings [("Input.marker", "cid-1rctcrz", "css-tokvmb-marker")]]

  $ ../../standalone.exe --namespace a --impl input.ml -o a1.ml
  $ grep "css.bindings" a1.ml
  [@@@css.bindings [("Input.marker", "cid-12d5hxh", "css-tokvmb-marker")]]

  $ ../../standalone.exe --namespace a --impl input.ml -o a2.ml
  $ grep "css.bindings" a2.ml
  [@@@css.bindings [("Input.marker", "cid-12d5hxh", "css-tokvmb-marker")]]
