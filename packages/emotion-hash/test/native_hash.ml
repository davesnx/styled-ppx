let () =
  if Array.length Sys.argv <> 2 then (
    Printf.eprintf "Usage: %s <input_string>\n" Sys.argv.(0);
    exit 1);

  let input_string = Sys.argv.(1) in
  let result = Emotion_hash.Hash.default input_string in
  print_endline result
