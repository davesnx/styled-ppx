let distance s1 s2 =
  let len1 = String.length s1 in
  let len2 = String.length s2 in
  let matrix = Array.make_matrix (len1 + 1) (len2 + 1) 0 in
  for i = 0 to len1 do
    matrix.(i).(0) <- i
  done;
  for j = 0 to len2 do
    matrix.(0).(j) <- j
  done;
  for i = 1 to len1 do
    for j = 1 to len2 do
      let cost = if s1.[i - 1] = s2.[j - 1] then 0 else 1 in
      matrix.(i).(j) <-
        min
          (min (matrix.(i - 1).(j) + 1) (matrix.(i).(j - 1) + 1))
          (matrix.(i - 1).(j - 1) + cost)
    done
  done;
  matrix.(len1).(len2)

let find_closest_match target candidates =
  let target_lower = String.lowercase_ascii target in
  let scored_candidates =
    candidates
    |> List.map (fun candidate ->
           let candidate_lower = String.lowercase_ascii candidate in
           let dist = distance target_lower candidate_lower in
           let max_len = max (String.length target) (String.length candidate) in
           let similarity_ratio =
             if max_len = 0 then 1.0
             else 1.0 -. (float_of_int dist /. float_of_int max_len)
           in
           (candidate, dist, similarity_ratio))
    |> List.sort (fun (_, d1, _) (_, d2, _) -> Int.compare d1 d2)
  in
  match scored_candidates with
  | [] -> None
  | (best_match, dist, ratio) :: _ ->
      let is_good_match =
        dist <= 2 || (ratio >= 0.6 && String.length target > 3)
      in
      if is_good_match then Some best_match else None
