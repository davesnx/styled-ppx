cx2 expansions inside nested expressions don't leak local binding names
into the cross-module bindings index. Only the top-level `let` whose rhs
contains the cx2 gets registered — local `let inner = ... in` bindings,
function args, and other inner expressions stay private.

  $ ../../../standalone.exe --impl input.ml -o output.ml
  $ cat output.ml
  [@@@css "@property --ivpc29y{syntax:\"*\";inherits:false;}"]
  [@@@css ".css-ivpcvso{color:red;}"]
  [@@@css ".css-ivpcs77{color:var(--ivpc29y);}"]
  [@@@css.classes
    [("css-ivpcvso", 1, "Input.outer.inner", "input.ml", 10, 23, 10, 35);
    ("css-ivpcs77", 2, "Input.make_button", "input.ml", 15, 34, 15, 52)]]
  [@@@css.bindings [("Input.outer", "css-ivpcvso"); ("Input.make_button", "")]]
  let outer = let inner = CSS.make "css-ivpcvso" [] in inner
  let make_button active =
    CSS.make "css-ivpcs77" [("--ivpc29y", (CSS.Types.Color.toString active))]
