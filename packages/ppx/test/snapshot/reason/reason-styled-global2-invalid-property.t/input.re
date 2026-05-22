/* Invalid property names inside [%styled.global2] should fail before
   extraction, matching the [%css] validation path. */

module Global = [%styled.global2 {|
  body {
    colour: red;
  }
|}];
