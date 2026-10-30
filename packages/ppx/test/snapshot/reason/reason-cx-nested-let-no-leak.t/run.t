cx2 expansions inside nested expressions don't leak local binding names
into the cross-module bindings index. Only a top-level `let` whose rhs
contains the cx2 outside any local `let` gets registered — local
`let inner = ... in` bindings, the top-level `let` that holds them,
function args, and other inner expressions stay private.

  $ ../../../standalone.exe --impl input.ml -o output.ml
  $ cat output.ml
  [@@@css "@property --active-f7rv17{syntax:\"*\";inherits:false;}"]
  [@@@css
    ("._a_4ekvmb{color:red;}", "_a_4ekvmb", "0,1,0 own", "158", 1, false)]
  [@@@css
    ("._a_4ehpkc{color:var(--active-f7rv17);}", "_a_4ehpkc", "0,1,0 own",
      "158", 1, false)]
  [@@@css.bindings [("Input.make_button", "_id_1nqluy1", "_a_4ehpkc")]]
  [@@@css.blocks [(9, "_id_hu39a8", [1]); (14, "_id_1nqluy1", [2])]]
  let outer =
    let inner = CSS.make "label:inner _id_hu39a8 _a_4ekvmb" [] in inner
  let make_button active =
    CSS.make "label:make_button _id_1nqluy1 _a_4ehpkc"
      [("--active-f7rv17", (CSS.Types.Color.toString active))]
