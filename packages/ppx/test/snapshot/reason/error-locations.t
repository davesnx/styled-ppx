  $ cat > main.ml <<EOF
  > let foo != syntax_error
  > EOF

  $ cat > dune-project <<EOF
  > (lang dune 3.8)
  > EOF

  $ cat > dune <<EOF
  > (executable
  >  (name main))
  > EOF

Shows errors in right locations

  $ dune build main.exe
  File "main.ml", line 1, characters 8-10:
  1 | let foo != syntax_error
              ^^
  Error: Syntax error
  [1]

  $ cat > dune <<EOF
  > (executable
  >  (name main)
  >  (preprocess
  >   (pps styled-ppx.lib)))
  > EOF

Preprocessing with styled-ppx.lib loses the error location information

  $ dune build main.exe
  File "_none_", line 1:
  Error: Unexpected error Unexpected error Syntaxerr.Error(_)
  [1]
