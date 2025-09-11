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
  File "input.re", line 3, characters 29-32:
  3 | let invalid_css = [%keyframe 123];
                                   ^^^
  Error: [%keyframe] expects a string of CSS with keyframe definitions.
  
  Example:
    [%keyframe "0% { opacity: 0; } 100% { opacity: 1; }"]
  
  More info: https://styled-ppx.vercel.app/reference/keyframe
  [1]
