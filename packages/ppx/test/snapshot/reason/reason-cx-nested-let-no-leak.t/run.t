cx2 expansions inside nested expressions don't leak local binding names
into the cross-module bindings index. Only the top-level `let` whose rhs
contains the cx2 gets registered — local `let inner = ... in` bindings,
function args, and other inner expressions stay private.

  $ standalone --impl input.ml -o output.ml
  $ cat output.ml
  [@@@css ".css-tokvmb-inner{color:red;}"]
  [@@@css ".css-ythpkc-make_button{color:var(--var-19vt2u9);}"]
  [@@@css.bindings
    [("Input.outer", "css-tokvmb-inner");
    ("Input.make_button", "css-ythpkc-make_button")]]
  let outer = let inner = CSS.make "css-tokvmb-inner" [] in inner
  let make_button active =
    CSS.make "css-ythpkc-make_button"
      [("--var-19vt2u9", (CSS.Types.Color.toString active))]
