A `$(x)` selector reference and a `CSS.merge` argument name a `[%css]`
binding only when no local variable shadows it. Unshadowed, `$(x)`
resolves to the identity class of the top-level `x`, and `merge(x, y)` is
recorded. Inside `byParam`, `byLet` and `byCase`, `x` is a function
parameter, a local `let` and a pattern variable: none of them is the
top-level binding, so those merges record only `y`, which leaves fewer than
two arguments and no entry. In `otherParam` the parameter is `z`, so `$(x)`
and `merge(x, y)` still name the top-level `x`:

  $ refmt --parse re --print ml merges.re > merges.ml
  $ ../../standalone.exe --impl merges.ml -o merges_out.ml
  $ cat merges_out.ml
  [@@@css
    ("._a_4ekvmb{color:red;}", "_a_4ekvmb", "0,1,0 own", "158", 1, false)]
  [@@@css
    ("._a_4esm7b{color:blue;}", "_a_4esm7b", "0,1,0 own", "158", 1, false)]
  [@@@css
    ("._a_4rv1g7pyp1y ._id_1ojbei{margin:0;}", "_a_4rv1g7pyp1y",
      "0,2,0 & ._id_1ojbei", "277", 15, false)]
  [@@@css
    ("._a_4rv1g94yz5s ._id_1ojbei{padding:0;}", "_a_4rv1g94yz5s",
      "0,2,0 & ._id_1ojbei", "328", 15, false)]
  [@@@css.bindings
    [("Merges.x", "_id_1ojbei", "_a_4ekvmb");
    ("Merges.y", "_id_m6c1y4", "_a_4esm7b");
    ("Merges.card", "_id_1uw4z8l", "_a_4rv1g7pyp1y");
    ("Merges.otherParam", "_id_1bvj7", "_a_4rv1g94yz5s")]]
  [@@@css.blocks
    [(1, "_id_1ojbei", [0]);
    (2, "_id_m6c1y4", [1]);
    (3, "_id_1uw4z8l", [2]);
    (10, "_id_1bvj7", [3])]]
  [@@@css.merges [(4, [0; 1]); (10, [0; 1])]]
  let x = CSS.make "label:x _id_1ojbei _a_4ekvmb" []
  let y = CSS.make "label:y _id_m6c1y4 _a_4esm7b" []
  let card = CSS.make "label:card _id_1uw4z8l _a_4rv1g7pyp1y" []
  let _ = CSS.merge x y
  let byParam x = CSS.merge x y
  let byLet () = let x = y in CSS.merge x y
  let byCase v =
    match v with | ((Some x)[@explicit_arity ]) -> CSS.merge x y | None -> y
  let otherParam z =
    (z, (CSS.make "label:otherParam _id_1bvj7 _a_4rv1g94yz5s" []),
      (CSS.merge x y))
  let _ = (card, byParam, byLet, byCase, otherParam)

A `$(x)` whose `x` is a function parameter does not refer to the
top-level binding, so it is an error:

  $ refmt --parse re --print ml selector.re > selector.ml
  $ ../../standalone.exe --impl selector.ml -o selector_out.ml
  File "selector.ml", line 2, characters 26-27:
  2 | let row x = [%css {| & .$(x) { margin: 0; } |}]
                                ^
  Error: Selector interpolation `$(x)` names a function parameter or local variable, not a [%css] binding.
  - To reference the [%css] binding `x`, rename the local variable.
  - Otherwise, use [%cx] for runtime substitution.
  [1]

The same holds for a prop of a dynamic styled component:

  $ refmt --parse re --print ml styled.re > styled.ml
  $ ../../standalone.exe --impl styled.ml -o styled_out.ml
  File "styled.ml", line 2, characters 44-45:
  2 | module Row = [%styled.div fun ~x -> {| & .$(x) { margin: 0; } |}]
                                                  ^
  Error: Selector interpolation `$(x)` names a function parameter or local variable, not a [%css] binding.
  - To reference the [%css] binding `x`, rename the local variable.
  - Otherwise, use [%cx] for runtime substitution.
  [1]
