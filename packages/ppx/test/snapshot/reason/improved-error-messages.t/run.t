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

Testing improved error message for non-string payload with %css
  $ dune build
  File "input.re", line 3, characters 24-27:
  3 | let invalid_css = [%css 123];
                              ^^^
  Error: [%css] expects a string of CSS for static extraction.
  
  Example:
    [%css "display: block; color: red"]
  
  More info: https://styled-ppx.vercel.app/reference/cx
  [1]
