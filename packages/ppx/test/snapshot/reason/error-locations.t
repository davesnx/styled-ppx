  $ cat > main.ml <<EOF
  > type config = {
  >   leading: bool [@bs.optional];
  >   trailing: bool [@bs.optional];
  > } [@@deriving abstract]
  > EOF

  $ cat > dune-project <<EOF
  > (lang dune 3.8)
  > (using melange 0.1)
  > EOF

  $ cat > dune <<EOF
  > (melange.emit
  >  (target melange)
  >  (alias mel)
  >  (modules main)
  >  (preprocess
  >   (pps melange.ppx))
  >  (module_systems commonjs))
  > EOF

Preprocessing with melange.ppx shows the error on the right location

  $ dune build @mel
  File "main.ml", line 3, characters 12-16:
  3 |   trailing: bool [@bs.optional];
                  ^^^^
  Error: [@bs.optional] must appear on a type explicitly annotated with `option'
  [1]

  $ cat > dune <<EOF
  > (melange.emit
  >  (target melange)
  >  (alias mel)
  >  (modules main)
  >  (preprocess
  >   (pps melange.ppx styled-ppx.lib))
  >  (module_systems commonjs))
  > EOF

Preprocessing with melange.ppx and styled-ppx.lib loses the error location information

  $ dune build @mel
  File "_none_", line 1:
  Error: Unexpected error [@bs.optional] must appear on a type explicitly annotated with `option'
  [1]

  $ cat > main.ml <<EOF
  > let foo != syntax_error
  > EOF

Any syntax error is missing locations

  $ cat > dune <<EOF
  > (melange.emit
  >  (target melange)
  >  (alias mel)
  >  (modules main)
  >  (preprocess
  >   (pps styled-ppx.lib))
  >  (module_systems commonjs))
  > EOF

  $ dune build @mel
  File "_none_", line 1:
  Error: Unexpected error Unexpected error Syntaxerr.Error(_)
  [1]

