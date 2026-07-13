Cross-library [%css] selector references are not supported. The aggregator
sees only files from the current library invocation; if the referenced
module's file isn't in that set, the reference is by definition cross-library.

  $ refmt --parse re --print ml n.re > n.ml
  $ standalone --impl n.ml -o n.ml

  $ styled-ppx.generate n.ml
  styled-ppx: File "n.ml", line 2, characters 6-21:
  Error: cross-library [%css] selector references are not supported.
  The reference `OtherLib.marker` resolves to module `OtherLib` which is not part of the
  current library. Move the [%css] binding into the current library, or
  inline the class chain literally.
  [1]
