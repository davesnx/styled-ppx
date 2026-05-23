/* Invalid property values inside [%styled.global] should fail before
   extraction, matching the [%css] validation path. */

module Global = [%styled.global {|
  body {
    display: blocki;
  }
|}];
