/* The binding name travels in the styles carrier as its label and styled
   components render it as the element's `part` attribute, in every build
   mode. Anonymous and statement-position bindings have no label. */

let layout = [%css {| display: flex; padding: 12px; |}];

let _ = [%css {| color: red; |}];

[%css {| color: blue; |}];

module Button = [%styled.button {| color: white; |}];

let _ = (layout, Button.make);
