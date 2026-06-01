Cross-module reference to a binding name that doesn't exist (the only
[%css] in M is anonymous). Behaves identically to a missing-binding
error: the aggregator's index has no entry, so resolution fails with the
same shape.

  $ refmt --parse re --print ml m.re > m.ml
  $ standalone --impl m.ml -o m.ml
  $ refmt --parse re --print ml n.re > n.ml
  $ standalone --impl n.ml -o n.ml

  $ styled-ppx.generate m.ml n.ml
  File "n.ml", line 2, characters 6-14:
  Error: cross-module [%css] selector reference `M.marker` does not resolve.
  The target binding is missing from module `M`, or the binding is not
  a [%css] expression. Define `M.marker` with [%css "..."], or remove the
  reference.
  [1]
