(* Prints the css-grammar registry keys, one per line. *)

(* Force [Registry] initialization before reading [registry_tbl]. *)
let () = assert (Css_grammar.registry <> [])

let () =
  Hashtbl.fold (fun key _ acc -> key :: acc) Css_grammar.registry_tbl []
  |> List.sort String.compare
  |> List.iter print_endline
