Cross-module reference whose target binding doesn't exist anywhere.
The synthetic `let _ = M.marker` line catches this at OCaml type-check
time. The aggregator catches the same condition independently and
reports the original `[%cx2]` source location, in OCaml's `File "..."`
diagnostic format.

  $ refmt --parse re --print ml m.re > m.ml
  $ standalone --impl m.ml -o m.ml
  $ refmt --parse re --print ml n.re > n.ml
  $ standalone --impl n.ml -o n.ml

  $ styled-ppx.generate m.ml n.ml
  File "n.ml", line 2, characters 6-14:
  Error: cross-module [%cx2] selector reference `M.marker` does not resolve.
  The target binding is missing from module `M`, or the binding is not
  a [%cx2] expression. Define `M.marker` with [%cx2 "..."], or remove the
  reference.
  [1]
