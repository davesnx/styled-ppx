(* Simple CSS Performance Benchmark *)

let time_function name f =
  let start_time = Sys.time () in
  let result = f () in
  let end_time = Sys.time () in
  Printf.printf "%s: %.4f seconds\n" name (end_time -. start_time);
  result

let memory_stats name f =
  Gc.compact ();
  let stat_before = Gc.stat () in
  let result = f () in
  Gc.compact ();
  let stat_after = Gc.stat () in

  let allocations =
    stat_after.minor_words
    +. stat_after.major_words
    -. stat_before.minor_words
    -. stat_before.major_words
  in

  Printf.printf "%s: %.0f words allocated (%.2f MB)\n" name allocations
    (allocations *. 8.0 /. 1024.0 /. 1024.0);
  result

let generate_hashes n =
  let rec loop acc i =
    if i <= 0 then acc
    else loop (Printf.sprintf "css-hash-%d-abcdef" i :: acc) (i - 1)
  in
  loop [] n

let test_camel_strings =
  [|
    "backgroundColor";
    "borderTopLeftRadius";
    "marginBottomRight";
    "paddingTopBottomLeftRight";
    "textTransformUppercase";
    "fontWeightBoldItalic";
    "boxShadowInsetOutset";
    "transformOriginCenter";
    "animationDurationTimingFunction";
    "borderImageOutsetSliceWidthSource";
  |]

(* OLD IMPLEMENTATIONS *)
let explode s =
  let rec explode_rec acc i =
    if i < 0 then acc else explode_rec (s.[i] :: acc) (i - 1)
  in
  explode_rec [] (String.length s - 1)

let old_camelCaseToKebabCase str =
  let insert_dash acc letter =
    match letter with
    | 'A' .. 'Z' as letter ->
      ("-" ^ String.make 1 (Char.lowercase_ascii letter)) :: acc
    | _ -> String.make 1 letter :: acc
  in
  String.concat "" (List.rev (List.fold_left insert_dash [] (explode str)))

let old_get_string_style_hashes hashes =
  List.fold_left
    (fun accumulator hash ->
      String.trim @@ Printf.sprintf "%s %s" accumulator hash)
    "" hashes

(* NEW IMPLEMENTATIONS *)
let new_camelCaseToKebabCase str =
  let len = String.length str in
  let buffer = Buffer.create (len + 10) in
  for i = 0 to len - 1 do
    let c = str.[i] in
    match c with
    | 'A' .. 'Z' ->
      if i > 0 then Buffer.add_char buffer '-';
      Buffer.add_char buffer (Char.lowercase_ascii c)
    | _ -> Buffer.add_char buffer c
  done;
  Buffer.contents buffer

let new_get_string_style_hashes hashes =
  let buffer = Buffer.create 1024 in
  let first = ref true in
  List.iter
    (fun hash ->
      if not !first then Buffer.add_char buffer ' ';
      Buffer.add_string buffer (String.trim hash);
      first := false)
    hashes;
  Buffer.contents buffer

(* BENCHMARKS *)
let benchmark_camelcase n =
  Printf.printf "\n=== CamelCase Conversion (%d iterations) ===\n" n;
  let test_strings = Array.to_list (Array.make n test_camel_strings.(0)) in

  let old_result =
    memory_stats "OLD camelCase" (fun () ->
      time_function "OLD time" (fun () ->
        List.map old_camelCaseToKebabCase test_strings))
  in

  let new_result =
    memory_stats "NEW camelCase" (fun () ->
      time_function "NEW time" (fun () ->
        List.map new_camelCaseToKebabCase test_strings))
  in

  Printf.printf "Results match: %b\n"
    (List.for_all2 String.equal old_result new_result)

let benchmark_hash_concat n =
  Printf.printf "\n=== Hash Concatenation (%d hashes) ===\n" n;
  let test_hashes = generate_hashes n in

  let old_result =
    memory_stats "OLD hash concat" (fun () ->
      time_function "OLD time" (fun () ->
        old_get_string_style_hashes test_hashes))
  in

  let new_result =
    memory_stats "NEW hash concat" (fun () ->
      time_function "NEW time" (fun () ->
        new_get_string_style_hashes test_hashes))
  in

  Printf.printf "Results match: %b\n" (String.equal old_result new_result);
  Printf.printf "Result length: %d chars\n" (String.length old_result)

let stress_test () =
  Printf.printf "\n=== STRESS TEST ===\n";
  let large_hashes = generate_hashes 5000 in
  let large_camel_list =
    Array.to_list (Array.make 2000 "veryLongCamelCasePropertyName")
  in

  Printf.printf "Testing with 5000 hashes + 2000 camelCase conversions...\n";

  let _ =
    memory_stats "OLD stress test" (fun () ->
      time_function "OLD total time" (fun () ->
        let hash_result = old_get_string_style_hashes large_hashes in
        let camel_results =
          List.map old_camelCaseToKebabCase large_camel_list
        in
        hash_result, camel_results))
  in

  let _ =
    memory_stats "NEW stress test" (fun () ->
      time_function "NEW total time" (fun () ->
        let hash_result = new_get_string_style_hashes large_hashes in
        let camel_results =
          List.map new_camelCaseToKebabCase large_camel_list
        in
        hash_result, camel_results))
  in

  Printf.printf "Stress test completed\n"

let () =
  Printf.printf "=== CSS Performance Benchmark ===\n";

  benchmark_camelcase 100;
  benchmark_camelcase 1000;

  benchmark_hash_concat 100;
  benchmark_hash_concat 1000;
  benchmark_hash_concat 5000;

  stress_test ()
