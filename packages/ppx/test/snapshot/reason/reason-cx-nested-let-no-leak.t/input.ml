(* `let inner = [%css ...] in inner` is a local binding — it must not leak
   `inner` into the cross-module bindings index.

   The CSS for the inner cx2 still gets emitted (so the runtime works),
   but neither `Module.inner` nor `Module.outer` is registered: the [%css]
   belongs to the local `inner`, not to `outer`. *)

let outer =
  let inner = [%css {| color: red; |}] in
  inner

(* The cx2 lives inside a function body, not directly the rhs of a
   top-level let. The function's binding is what gets registered. *)
let make_button active = [%css {| color: $(active); |}]
