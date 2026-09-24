`styles=` on an element that already carries an optional `?className` or
`?style` type-checks and merges: the `[%css]` class comes first, the
element's own class after it, and an absent `?style` still yields the
`[%css]` inline style (empty here). Needs server-reason-react at 82c52e8a or
later (ml-in-barcelona/server-reason-react#402).

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries
  >   server-reason-react.js
  >   server-reason-react.belt
  >   server-reason-react.react
  >   server-reason-react.reactDom
  >   styled-ppx.native)
  >  (preprocess
  >   (pps styled-ppx server-reason-react.ppx server-reason-react.melange_ppx -- --env production)))
  > EOF

  $ dune build

  $ ./_build/default/input.exe
  <div class="cid-1hdqfg1 css-k008qs" style="">ok</div>
  <div class="cid-1hdqfg1 css-k008qs base" style="">ok</div>

server-reason-react's expansion binds the incoming bundle to a reserved
`__incoming` temporary before styled-ppx lowers the `[%css]` inside it. The
inline css still belongs to the enclosing `make` binding: the identity above
is `make`'s, and in development mode the marker reads `label:make`, not
`label:__incoming`.

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries
  >   server-reason-react.js
  >   server-reason-react.belt
  >   server-reason-react.react
  >   server-reason-react.reactDom
  >   styled-ppx.native)
  >  (preprocess
  >   (pps styled-ppx server-reason-react.ppx server-reason-react.melange_ppx)))
  > EOF

  $ dune build

  $ ./_build/default/input.exe
  <div class="label:make cid-1hdqfg1 css-k008qs" style="">ok</div>
  <div class="label:make cid-1hdqfg1 css-k008qs base" style="">ok</div>
