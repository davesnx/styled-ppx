cx2 expansions inside nested expressions don't leak local binding names
into the cross-module bindings index. Only the top-level `let` whose rhs
contains the cx2 gets registered — local `let inner = ... in` bindings,
function args, and other inner expressions stay private.

  $ ../../../standalone.exe --impl input.ml -o output.ml
  $ cat output.ml
  [@@@css "@property --active-f7rv17{syntax:\"*\";inherits:false;}"]
  [@@@css "._a_4ekvmb{color:red;}"]
  [@@@css "._a_4ehpkc{color:var(--active-f7rv17);}"]
  [@@@css.bindings
    [("Input.outer", "_id_hu39a8", "_a_4ekvmb");
    ("Input.make_button", "_id_1nqluy1", "_a_4ehpkc")]]
  [@@@css.blocks [(10, "_id_hu39a8 _a_4ekvmb"); (15, "_id_1nqluy1 _a_4ehpkc")]]
  let outer =
    let inner = CSS.make "label:inner _id_hu39a8 _a_4ekvmb" [] in inner
  let make_button active =
    CSS.make "label:make_button _id_1nqluy1 _a_4ehpkc"
      [("--active-f7rv17", (CSS.Types.Color.toString active))]
