(* Dumps every key of the css-grammar rule registry, one per line.

   Generated parsers resolve <data-type> and <'property'> references at parse
   time through this registry (see Support.lookup). This dump is the ground
   truth when debugging "Rule not found in registry" crashes; the companion
   registry_closure_check executable asserts every reference resolves. *)

(* Referencing [Css_grammar.registry] (re-exported from Registry) forces
   linkage of the Registry module, whose top-level initializers populate
   [registry_tbl]. *)
let () = assert (Css_grammar.registry <> [])

let () =
  Hashtbl.fold (fun key _ acc -> key :: acc) Css_grammar.registry_tbl []
  |> List.sort String.compare
  |> List.iter print_endline
