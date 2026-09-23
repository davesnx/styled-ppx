/* This test ensures that defining a dynamic component without props
   is rejected as a hard error (not just a warning). The legacy API
   accepted this shape silently; styled-ppx now rejects it because a
   no-prop dynamic component carries no information beyond a static
   one and almost always indicates user confusion about the API. */
module T = [%styled.span () => [|[%css "font-size: 16px"]|]];
