let () = assert (Css_grammar.registry <> [])

let () =
  Hashtbl.fold
    (fun _ kind acc ->
      match fst kind with Css_grammar.Property name -> name :: acc | _ -> acc)
    Css_grammar.registry_tbl []
  |> List.sort_uniq String.compare
  |> List.iter print_endline
