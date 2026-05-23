/* Multiple rules in one styled.global block, where some are purely
   static and some contain interpolation.

   - All rules go through the static [@@@css ...] channel.
   - Only rules with $(...) contribute to to_string (they appear in
     dynamic_rules and need their values supplied at runtime).
   - The static-only rules MUST NOT appear in to_string output
     (they're already shipped via the extracted stylesheet). */

let primary = CSS.red;

module MixedStyles = [%styled.global
  {|
  html {
    box-sizing: border-box;
  }
  body {
    margin: 0;
    color: $(primary);
  }
  a {
    text-decoration: none;
  }
|}
];
