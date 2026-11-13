cx2 expansions inside nested expressions don't leak local binding names
into the cross-module bindings index. Only the top-level `let` whose rhs
contains the cx2 gets registered — local `let inner = ... in` bindings,
function args, and other inner expressions stay private.

  $ ../../../standalone.exe --impl input.ml -o output.ml
  $ cat output.ml
  [@@@css "@property --11j2eur-0{syntax:\"*\";inherits:false;}"]
  [@@@css ".css-1ytlvso{color:red;}"]
  [@@@css ".css-11j2eur{color:var(--11j2eur-0);}"]
  [@@@css.classes
    [("css-1ytlvso", 1, "Input.outer.inner", "input.ml", 10, 23, 10, 35);
    ("css-11j2eur", 2, "Input.make_button", "input.ml", 15, 34, 15, 52)]]
  [@@@css.bindings [("Input.outer", "css-1ytlvso"); ("Input.make_button", "")]]
  let outer = let inner = CSS.make "css-1ytlvso" [] in inner
  let make_button active =
    CSS.make "css-11j2eur" [("--11j2eur-0", (CSS.Types.Color.toString active))]
