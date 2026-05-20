/* Malformed CSS payload - unbalanced braces.

   The driver's parse_declaration_list returns an Error with the loc
   and message; the PPX wraps that into a Pmod_extension carrying the
   parser's diagnostic so the location surfaces at the right column. */

module BadCss = [%styled.global2 {|
  body {
    color: red;
|}];
