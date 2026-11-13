A block has one class, so an index entry with several classes (space-
separated in the `[@@@css.bindings ...]` payload) is a binding with several
blocks, for example two branch arms. A selector cannot name it.

  $ cat > a.ml <<EOF
  > [@@@css.bindings [("A.multi", "atom1 atom2 atom3")]]
  > let multi = CSS.make "atom1 atom2 atom3" []
  > EOF

  $ cat > b.ml <<EOF
  > [@@@css ".target.\000A.multi\000{color:red;}"]
  > [@@@css.refs [("A.multi", "b.ml", 1, 0, 7)]]
  > let _ = A.multi
  > EOF

  $ styled-ppx.generate a.ml b.ml
  styled-ppx: File "b.ml", line 1, characters 0-7:
  Error: `$(A.multi)` names a binding with 3 [%css] blocks. A selector can only reference a binding with one block; bind the block you mean to its own name, or use an empty marker binding.
  [1]

Two rules from one reference report the error once.

  $ cat > c.ml <<EOF
  > [@@@css ".target .\000A.multi\000{color:red;}.target .\000A.multi\000:hover{color:blue;}"]
  > [@@@css.refs [("A.multi", "c.re", 4, 10, 17)]]
  > let _ = A.multi
  > EOF

  $ styled-ppx.generate a.ml c.ml
  styled-ppx: File "c.re", line 4, characters 10-17:
  Error: `$(A.multi)` names a binding with 3 [%css] blocks. A selector can only reference a binding with one block; bind the block you mean to its own name, or use an empty marker binding.
  [1]
