Resolution errors carry the original `[%css]` source location through
the `[@@@css.refs ...]` attribute, surfaced in the OCaml `File "..."`
diagnostic format with a `styled-ppx:` prefix.

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
  styled-ppx: File "src/n.re", line 7, characters 12-25:
  Error: cross-module [%css] selector reference `A.missing` does not resolve.
  The target binding is missing from module `A`, or the binding is not
  a [%css] expression. Define `A.missing` with [%css "..."], or remove the
  reference.
  [1]
