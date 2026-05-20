/* Invalid property values inside [%styled.global2] should fail before
   extraction, matching the [%cx2] validation path. */

module Global = [%styled.global2 {|
  body {
    display: blocki;
  }
|}];
