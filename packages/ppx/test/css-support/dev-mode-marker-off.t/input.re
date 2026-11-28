/* Without the --dev flag, [%css] output has no `cx-<name>` marker
   class, only the block's class. The class does not depend on the
   flag, so the post-marker substring of dev-on output equals the
   no-marker dev-off output. */

let layout = [%css {| display: flex; padding: 12px; |}];

let button = [%css {| color: red; |}];

let _ = (layout, button);
