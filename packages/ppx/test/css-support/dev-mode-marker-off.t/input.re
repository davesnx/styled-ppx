/* Without the --dev flag, [%css] output is identical to before:
   no `cx-<name>` marker class, only the atomized hashes. The atom
   hashes themselves are dev-mode-invariant, so the post-marker
   substring of dev-on output equals the no-marker dev-off output. */

let layout = [%css {| display: flex; padding: 12px; |}];

let button = [%css {| color: red; |}];

let _ = (layout, button);
