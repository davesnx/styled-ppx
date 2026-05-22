/* Invalid property values inside [%styled.global2] should fail before
   extraction, matching the [%css] validation path. */

module Global = [%styled.global2 {|
  body {
    display: blocki;
  }
|}];
