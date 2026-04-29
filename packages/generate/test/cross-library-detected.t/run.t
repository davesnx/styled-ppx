A reference whose root module isn't in any indexed `[@@@css.bindings ...]`
attribute is by definition cross-library: dune invokes the aggregator
with one library's files at a time. We can't resolve the reference and
we don't want to silently succeed, so we emit a dedicated cross-library
error message.

  $ cat > a.ml <<EOF
  > [@@@css.bindings [("A.local", "css-local")]]
  > let local = CSS.make "css-local" []
  > EOF

  $ cat > b.ml <<EOF
  > [@@@css ".target.\000Foreign.lib.thing\000{}"]
  > [@@@css.refs [("Foreign.lib.thing", "src/b.re", 3, 4, 21)]]
  > let _ = Foreign.lib.thing
  > EOF

  $ styled-ppx.generate a.ml b.ml
  File "src/b.re", line 3, characters 4-21:
  Error: cross-library [%cx2] selector references are not supported.
  The reference `Foreign.lib.thing` resolves to module `Foreign` which is not part of the
  current library. Move the [%cx2] binding into the current library, or
  inline the class chain literally.
  [1]
