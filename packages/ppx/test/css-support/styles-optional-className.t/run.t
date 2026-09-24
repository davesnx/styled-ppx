`styles=` on an element that already carries an optional `?className` or
`?style` type-checks and merges: the `[%css]` class comes first, the
element's own class after it, and an absent `?style` still yields the
`[%css]` inline style (empty here). Production mode keeps the class names
free of development labels. Needs server-reason-react at 82c52e8a or later
(ml-in-barcelona/server-reason-react#402).

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
  <div class="css-k008qs" style="">ok</div>
  <div class="css-k008qs base" style="">ok</div>
