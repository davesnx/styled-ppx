Example to show errors in right locations (without styled-ppx pp)

  $ cat > dune-project <<EOF
  > (lang dune 3.7)
  > EOF

  $ cat > dune <<EOF
  > (executable
  >  (name main))
  > EOF

  $ cat > main.ml <<EOF
  > let foo != syntax_error
  > EOF

  $ dune build main.exe
  File "main.ml", line 1, characters 8-10:
  1 | let foo != syntax_error
              ^^
  Error: Syntax error
  [1]

Same example but with styled-ppx pp (error location should be at the same place)

  $ cat > dune <<EOF
  > (executable
  >  (name main)
  >  (preprocess
  >   (pps styled-ppx.lib)))
  > EOF

Preprocessing with styled-ppx.lib should not lose the error location

  $ dune build main.exe
  File "main.ml", line 1, characters 8-10:
  1 | let foo != syntax_error
              ^^
  Error: Syntax error
  [1]
