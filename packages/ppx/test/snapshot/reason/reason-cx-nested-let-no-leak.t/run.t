cx2 expansions inside nested expressions don't leak local binding names
into the cross-module bindings index. Only the top-level `let` whose rhs
contains the cx2 gets registered — local `let inner = ... in` bindings,
function args, and other inner expressions stay private.

  $ ../../../standalone.exe --impl input.ml -o output.ml
  $ cat output.ml
  [@@@css "@property --active-f7rv17{syntax:\"*\";inherits:false;}"]
  [@@@css ".css-tokvmb-inner{color:red;}"]
  [@@@css ".css-ythpkc-make_button{color:var(--active-f7rv17);}"]
  [@@@css.bindings
    [("Input.outer", "css-tokvmb-inner");
    ("Input.make_button", "css-ythpkc-make_button")]]
  let outer =
    let inner = CSS.make_labeled "inner" "css-tokvmb-inner" [] in inner
  let make_button active =
    CSS.make_labeled "make_button" "css-ythpkc-make_button"
      [("--active-f7rv17", (CSS.Types.Color.toString active))]
