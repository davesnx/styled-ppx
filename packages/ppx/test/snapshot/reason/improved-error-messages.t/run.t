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
  File "input.re", line 3, characters 24-27:
  3 | let invalid_css = [%css 123];
                              ^^^
  Error: [%css] expects a string of CSS with a single rule (a property-value
         pair).
         
         Example:
           [%css "color: red"]
           [%css "display: block"]
         
         More info: https://styled-ppx.vercel.app/reference/css
  [1]
