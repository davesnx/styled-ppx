let _ =
  match Sys.argv with
  | [| _; s |] -> print_endline (Hash.default s)
  | _ -> print_endline "Usage: hasher <string>"
