Inline [%css] in a [@react.component] styles prop is expanded even after
server-reason-react rewrites the component through a generated include.

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
  >   (pps styled-ppx server-reason-react.ppx server-reason-react.melange_ppx)))
  > EOF

  $ dune build
