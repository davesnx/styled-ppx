/* Without the --dev flag, [%cx2] output is identical to before:
   no `cx-<name>` marker class, only the atomized hashes. The atom
   hashes themselves are dev-mode-invariant, so the post-marker
   substring of dev-on output equals the no-marker dev-off output. */

let layout = [%cx2 {| display: flex; padding: 12px; |}];

let button = [%cx2 {| color: red; |}];

let _ = (layout, button);
