(* `let inner = [%css ...] in inner` is a local binding inside a function
   body — it must not leak `inner` into the cross-module bindings index.

   The CSS for the inner cx2 still gets emitted (so the runtime works),
   but `Module.inner` is not registered. The runtime expansion at the
   top-level `let outer = ...` site is what consumers see, and that's
   what gets recorded in the bindings index. *)

let outer =
  let inner = [%css {| color: red; |}] in
  inner

(* The cx2 lives inside a function body, not directly the rhs of a
   top-level let. The function's binding is what gets registered. *)
let make_button active = [%css {| color: $(active); |}]
