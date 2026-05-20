/* Multiple interpolations of different var_types in a single
   styled.global2 block.

   Each $(...) must lower to the right CSS.Types.<Mod>.toString call:
   - color  -> CSS.Types.Color.toString
   - width  -> CSS.Types.Width.toString (Length-typed)
   - opacity -> CSS.Types.Opacity.toString (Number-typed)
   - z-index -> CSS.Types.ZIndex.toString (Integer-typed)

   Each interpolation also gets its own var(--var-<hash>) on the
   static side; the dynamic :root block declares one custom property
   per interpolation. */

let textColor = CSS.red;
let bodyWidth = CSS.px(960);
let mainOpacity = 0.95;
let layerIndex = 10;

module ThemeStyles = [%styled.global2 {|
  body {
    color: $(textColor);
    width: $(bodyWidth);
    opacity: $(mainOpacity);
    z-index: $(layerIndex);
  }
|}];
