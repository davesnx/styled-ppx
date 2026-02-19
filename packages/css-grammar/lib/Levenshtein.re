/* Levenshtein distance algorithm */

let distance = (s1, s2) => {
  let len1 = String.length(s1);
  let len2 = String.length(s2);

  let matrix = Array.make_matrix(len1 + 1, len2 + 1, 0);

  for (i in 0 to len1) {
    matrix[i][0] = i;
  };
  for (j in 0 to len2) {
    matrix[0][j] = j;
  };

  for (i in 1 to len1) {
    for (j in 1 to len2) {
      let cost =
        if (s1.[i - 1] == s2.[j - 1]) {
          0;
        } else {
          1;
        };
      matrix[i][j] =
        min(
          min(
            matrix[i - 1][j] + 1, /* deletion */
            matrix[i][j - 1] + 1 /* insertion */
          ),
          matrix[i - 1][j - 1] + cost /* substitution */
        );
    };
  };

  matrix[len1][len2];
};

let find_closest_match = (target, candidates) => {
  let target_lower = String.lowercase_ascii(target);
  let scored_candidates =
    candidates
    |> List.map(candidate => {
         let candidate_lower = String.lowercase_ascii(candidate);
         let distance = distance(target_lower, candidate_lower);
         /* lower distance is better */
         let max_len = max(String.length(target), String.length(candidate));
         let similarity_ratio =
           if (max_len == 0) {
             1.0;
           } else {
             1.0 -. float_of_int(distance) /. float_of_int(max_len);
           };
         (candidate, distance, similarity_ratio);
       })
    |> List.sort(((_, d1, _), (_, d2, _)) => Int.compare(d1, d2));

  switch (scored_candidates) {
  | [] => None
  | [(best_match, distance, ratio), ..._rest] =>
    let is_good_match =
      distance <= 2 || ratio >= 0.6 && String.length(target) > 3;

    if (is_good_match) {
      Some(best_match);
    } else {
      None;
    };
  };
};
