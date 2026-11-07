cx2 expansions inside nested expressions don't leak local binding names
into the cross-module bindings index. Only the top-level `let` whose rhs
contains the cx2 gets registered — local `let inner = ... in` bindings,
function args, and other inner expressions stay private.

  $ ../../../standalone.exe --impl input.ml -o output.ml
  $ cat output.ml
  [@@@css "@property --active-dmugh9{syntax:\"*\";inherits:false;}"]
  [@@@css.atoms
    [("_a7fadbhEW", ["._a7fadbhEW{color:red;}"], 1, 0, 1,
       [("value", "adbhEW", "val\\07f\\0& | \\0color:red")]);
    ("_a7fHyXuSS", ["._a7fHyXuSS{color:var(--active-dmugh9);}"], 1, 0, 1,
      [("value", "HyXuSS", "val\\07f\\0& | \\0color:$(active)")]);
    ("_iiMKmrLeZ", [], 1, 0, 0,
      [("id", "_iiMKmrLeZ", "bind\\0\\0Input\\0\\0outer\\00")]);
    ("_i69QGZ7-t", [], 1, 0, 0,
      [("id", "_i69QGZ7-t", "bind\\0\\0Input\\0\\0make_button\\00")])]]
  [@@@css.bindings
    [("Input.outer", "_iiMKmrLeZ _a7fadbhEW", "_iiMKmrLeZ");
    ("Input.make_button", "_i69QGZ7-t _a7fHyXuSS", "_i69QGZ7-t")]]
  let outer = let inner = CSS.make "_iiMKmrLeZ _a7fadbhEW" [] in inner
  let make_button active =
    CSS.make "_i69QGZ7-t _a7fHyXuSS"
      [("--active-dmugh9", (CSS.Types.Color.toString active))]
