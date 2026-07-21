(* Dumps every name known to the css-grammar layer, one `kind\tname` line
   per entry. Consumed by scripts/css-oracle/report.mjs to diff styled-ppx's
   grammar coverage against the @webref/css spec inventory. *)

(* Force [Registry] initialization before reading the registry. *)
let () = assert (Css_grammar.registry <> [])

let () =
  Css_grammar.registry
  |> List.iter (fun ((kind : Css_grammar.kind), _) ->
    match kind with
    | Property name -> Printf.printf "property\t%s\n" name
    | Value name -> Printf.printf "value\t%s\n" name
    | Function name -> Printf.printf "function\t%s\n" name
    | Media_query name -> Printf.printf "media-query\t%s\n" name);
  Css_grammar.media_feature_inventory
  |> List.iter (Printf.printf "media-feature\t%s\n");
  Css_grammar.container_feature_inventory
  |> List.iter (Printf.printf "container-feature\t%s\n");
  (* At-rule classification: `at-rule\t@<name>\t<class>` lines. The names
     match the @webref/css `atrules` keys so report.mjs can join directly. *)
  Css_grammar.At_rules.inventory
  |> List.iter (fun (name, classification) ->
    let class_tag =
      match (classification : Css_grammar.At_rules.classification) with
      | Atomized -> "atomized"
      | Keyframe_extension -> "keyframe-extension"
      | Descriptor_passthrough -> "descriptor-passthrough"
      | Global_passthrough -> "global-passthrough"
    in
    Printf.printf "at-rule\t@%s\t%s\n" name class_tag)
