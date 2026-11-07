An unresolved sentinel inside an atom fails and points at the original source.

  $ cat > a.ml <<EOT
  > let x = 1
  > EOT

  $ cat > b.ml <<EOT
  > [@@@css.atoms [("_c0aswitch", [".\000A.x\000>*{color:red}"], 0, 0, 1, [])]]
  > [@@@css.refs [("A.x", "b.re", 3, 4, 9)]]
  > EOT

  $ styled-ppx.generate a.ml b.ml
  styled-ppx: File "b.re", line 3, characters 4-9:
  Error: cross-module [%css] selector reference `A.x` does not resolve.
  The target binding is missing from module `A`, or the binding is not
  a [%css] expression. Define `A.x` with [%css "..."], or remove the
  reference.
  [1]
