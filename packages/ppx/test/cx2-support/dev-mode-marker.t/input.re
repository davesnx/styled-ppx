/* When the PPX is invoked with --dev, every named [%cx2] binding gets a
   leading `cx-<name>` marker class baked into its className string. The
   marker has no associated CSS rule and never appears in the extracted
   CSS — only as the first token of the className passed to CSS.make. */

let layout = [%cx2 {| display: flex; padding: 12px; |}];

let button = [%cx2 {| color: red; |}];

let _ = (layout, button);
