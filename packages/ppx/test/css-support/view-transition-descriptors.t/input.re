/* css-view-transitions-2 @view-transition descriptors (issue #583):
   navigation and types validate at compile time inside [%styled.global]. */

module ViewTransitions = [%styled.global
  {|
  @view-transition {
    navigation: auto;
    types: slide forwards;
  }
|}
];

let _ = ViewTransitions.make;
