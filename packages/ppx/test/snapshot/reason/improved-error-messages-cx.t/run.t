This test ensures the ppx generates improved error messages for invalid payloads

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

Testing improved error message for list syntax with %cx
  $ dune build
  File "input.re", line 3, characters 23-25:
  3 | let invalid_css = [%cx []];
                             ^^
  Error: [%cx] expects either a string of CSS or an array of CSS rules. 
  
  Example:
    [%cx "display: block"]
    [%cx [|CSS.display(`block)|]]
  
  More info: https://styled-ppx.vercel.app/reference/cx
  [1]
