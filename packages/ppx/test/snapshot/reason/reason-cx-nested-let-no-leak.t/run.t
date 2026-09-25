cx2 expansions inside nested expressions don't leak local binding names
into the cross-module bindings index. Only the top-level `let` whose rhs
contains the cx2 gets registered — local `let inner = ... in` bindings,
function args, and other inner expressions stay private.

  $ ../../../standalone.exe --impl input.ml -o output.ml
  $ cat output.ml
  [@@@css "@property --active-f7rv17{syntax:\"*\";inherits:false;}"]
  [@@@css ".a-4ekvmb{color:red;}"]
  [@@@css ".in-ythpkc{color:var(--active-f7rv17);}"]
  [@@@css.bindings
    [("Input.outer", "id-1din52f", "a-4ekvmb");
    ("Input.make_button", "id-1ue7vq2", "in-ythpkc")]]
  let outer =
    let inner = CSS.make "label:inner id-1din52f a-4ekvmb" [] in inner
  let make_button active =
    CSS.make "label:make_button id-1ue7vq2 in-ythpkc"
      [("--active-f7rv17", (CSS.Types.Color.toString active))]
