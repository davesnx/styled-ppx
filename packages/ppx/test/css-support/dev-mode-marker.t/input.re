/* When the PPX is invoked with --dev, every named [%css] binding gets a
   leading `cx-<name>` marker class baked into its className string. The
   marker has no associated CSS rule and never appears in the extracted
   CSS — only as the first token of the className passed to CSS.make. */

let layout = [%css {| display: flex; padding: 12px; |}];

let button = [%css {| color: red; |}];

let _ = (layout, button);
