/* Invalid property names inside [%styled.global] should fail before
   extraction, matching the [%css] validation path. */

module Global = [%styled.global {|
  body {
    colour: red;
  }
|}];
