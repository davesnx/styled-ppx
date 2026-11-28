A block's class can widen because of an earlier block of its module
(`b695` and `b954` of `Input` share three characters).
The ppx names every block of a module before `switch%platform`,
`browser_only` or `[@platform]` remove any of them, so the native and the
client build of one module give a block the same class.
`standalone_platform.exe` runs server-reason-react's browser_ppx (which
implements those constructs; `-js` selects the client) and styled-ppx.

  $ PPX=$(cd ../../../ppx/test && pwd)/standalone_platform.exe
  $ both() {
  >   $PPX --impl $1/input.ml -o $1/native.ml \
  >     && $PPX -js --impl $1/input.ml -o $1/js.ml \
  >     && grep -h 'CSS.make' $1/native.ml $1/js.ml
  > }

`b695` exists in the native build only:

  $ mkdir switch
  $ cat > switch/input.ml <<EOF
  > let b695 = match%platform () with Server -> [%css "color: red"] | Client -> CSS.make "" []
  > let b954 = [%css "color: red"]
  > EOF
  $ both switch
  let b695 = CSS.make "css-ivpcyt4" []
  let b954 = CSS.make "css-ivpc7yt4" []
  let b695 = CSS.make "" []
  let b954 = CSS.make "css-ivpc7yt4" []

The client branch first:

  $ mkdir client
  $ cat > client/input.ml <<EOF
  > let b695 = match%platform () with Client -> [%css "color: red"] | Server -> CSS.make "" []
  > let b954 = [%css "color: red"]
  > EOF
  $ both client
  let b695 = CSS.make "" []
  let b954 = CSS.make "css-ivpcyt4" []
  let b695 = CSS.make "css-ivpcxyt4" []
  let b954 = CSS.make "css-ivpcyt4" []

`[@@platform native]` drops the binding from the client build:

  $ mkdir attribute
  $ cat > attribute/input.ml <<EOF
  > let b695 = [%css "color: red"] [@@platform native]
  > let b954 = [%css "color: red"]
  > EOF
  $ both attribute
  let b695 = CSS.make "css-ivpcyt4" [][@@platform native]
  let b954 = CSS.make "css-ivpc7yt4" []
  let b954 = CSS.make "css-ivpc7yt4" []

`let%browser_only` drops the function's body from the native build:

  $ mkdir browser_only
  $ cat > browser_only/input.ml <<EOF
  > let%browser_only b695 () = [%css "color: red"]
  > let b954 = [%css "color: red"]
  > EOF
  $ both browser_only
  let b954 = CSS.make "css-ivpcyt4" []
  let b695 () = CSS.make "css-ivpcxyt4" []
  let b954 = CSS.make "css-ivpcyt4" []

Expansion takes every name from the naming pass, and fails when the
naming pass did not see the block. `standalone_later.exe` has a ppx that
turns `[%css_later ...]` into `[%css ...]` during expansion:

  $ mkdir later
  $ cat > later/input.ml <<EOF
  > let a = [%css "color: red"]
  > let b = [%css_later "color: blue"]
  > EOF
  $ $(cd ../../../ppx/test/later && pwd)/standalone_later.exe --impl later/input.ml -o later/out.ml
  File "later/input.ml", line 2, characters 21-32:
  2 | let b = [%css_later "color: blue"]
                           ^^^^^^^^^^^
  Error: styled-ppx: the naming pass did not see this block, so it has no class. Another ppx probably wrote or changed the block before styled-ppx expanded it. styled-ppx names blocks before any ppx runs, so write the [%css] in the source.
  [1]
