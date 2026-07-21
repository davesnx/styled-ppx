The css-view-transitions-2 @view-transition descriptors (navigation, types)
are validated at compile time inside [%styled.global] (issue #583).
navigation accepts 'auto' | 'none'; types accepts 'none' or one or more
custom idents.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

A valid @view-transition block using both descriptors compiles and ships
through the extraction channel verbatim:

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (modules input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build 2>&1 | head -4

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css "@view-transition{navigation:auto;types:slide forwards}"];
  
  module ViewTransitions = {
    let to_string = () => "";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => Js.Obj.empty();
    let make = _props => CSS.global_style_tag(to_string());
  };
  
  let _ = ViewTransitions.make;

An invalid value (a keyword outside 'auto' | 'none') fails with an error
naming the descriptor:

  $ cat > dune << EOF
  > (executable
  >  (name invalid)
  >  (modules invalid)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build 2>&1 | head -6
  File "invalid.re", line 7, characters 15-24:
  7 |     navigation: sideways;
                     ^^^^^^^^^
  Error: Property 'navigation' has an invalid value: 'sideways',
         Expected 'auto' or 'none'.
