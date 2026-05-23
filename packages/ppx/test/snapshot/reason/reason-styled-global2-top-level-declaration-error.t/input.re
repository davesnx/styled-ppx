/* Top-level Declaration in styled.global - not allowed.

   Globals must consist of selectors / at-rules. A bare declaration
   like `margin: 0;` at the top level has no scope. The PPX produces
   a Pmod_extension with the universal-selector hint pointing the
   user at `* { margin: 0; }`. */

module Reset = [%styled.global "margin: 0;"];
