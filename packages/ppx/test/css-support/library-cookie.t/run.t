dune passes `--cookie library-name="<name>"` to every ppx run inside a
`(library ...)` stanza. The PPX reads it through `Ppxlib.Driver.Cookies`
and records it in the `[@@@css.config ...]` wire-protocol attribute, next
to `env`, so the aggregator can later group rules by owning library.

  $ refmt --parse re --print ml input.re > input.ml

With the cookie set, a dev build now emits a config attribute carrying
just the library key (previously no config attribute was ever emitted
outside of --minify).

  $ ../../standalone.exe -cookie 'library-name="foo"' --impl input.ml -o dev.ml
  $ grep "css.config" dev.ml
  [@@@css.config [("library", "foo")]]

With --minify, the env key comes first, then library.

  $ ../../standalone.exe -cookie 'library-name="foo"' --minify --impl input.ml -o prod.ml
  $ grep "css.config" prod.ml
  [@@@css.config [("env", "production"); ("library", "foo")]]

Without the cookie, a dev build still emits no config attribute at all:
unchanged behaviour, absence still means development.

  $ ../../standalone.exe --impl input.ml -o nocookie.ml
  $ grep "css.config" nocookie.ml
  [1]
