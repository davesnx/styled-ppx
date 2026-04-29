Resolution errors carry the original `[%cx2]` source location through
the `[@@@css.refs ...]` attribute, so editors and CI surface them in the
familiar `File "..."` OCaml diagnostic format.

  $ cat > a.ml <<EOF
  > [@@@css.bindings [("A.exists", "klass-existing")]]
  > let exists = CSS.make "klass-existing" []
  > EOF

  $ cat > b.ml <<EOF
  > [@@@css ".target.\000A.missing\000{}"]
  > [@@@css.refs [("A.missing", "src/n.re", 7, 12, 25)]]
  > let _ = A.missing
  > EOF

  $ styled-ppx.generate a.ml b.ml
  File "src/n.re", line 7, characters 12-25:
  Error: cross-module [%cx2] selector reference `A.missing` does not resolve.
  The target binding is missing from module `A`, or the binding is not
  a [%cx2] expression. Define `A.missing` with [%cx2 "..."], or remove the
  reference.
  [1]
