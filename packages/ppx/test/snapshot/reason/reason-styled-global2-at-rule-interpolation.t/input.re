/* Interpolation inside an @media block within styled.global2.

   transform_rule walks recursively into at-rule bodies, so $(...)
   inside a nested style rule should be substituted with var(...) on
   the static side and produce a CSS.Types.<Mod>.toString call on the
   dynamic side. The rendered to_string keeps the @media prelude
   intact. */

let mobileColor = CSS.red;
let desktopColor = CSS.blue;

module ResponsiveStyles = [%styled.global2 {|
  body {
    color: $(mobileColor);
  }
  @media (min-width: 768px) {
    body {
      color: $(desktopColor);
    }
  }
|}];
