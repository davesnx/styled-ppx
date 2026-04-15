open Rule.Let;

type combinator('a, 'b) = list(Rule.rule('a)) => Rule.rule('b);
type expected_rule('a) = (option(string), Rule.rule('a));

let rec match_longest = ((left_key, left_rule), rules) =>
  switch (rules) {
  | [] =>
    let.bind_match value = left_rule;
    Rule.Match.return((left_key, value));
  | [new_left, ...rules] =>
    let.bind_longest_match value = (
      left_rule,
      match_longest(new_left, rules),
    );
    switch (value) {
    | `Left(value) => Rule.Match.return((left_key, value))
    | `Right(value) => Rule.Match.return(value)
    };
  };

let static = rules => {
  let rec match_everything = (values, rules) =>
    switch (rules) {
    | [] => return_match(values |> List.rev)
    | [left, ...rules] =>
      let.bind_match value = left;
      match_everything([value, ...values], rules);
    };
  match_everything([], rules);
};

/* Merge structured errors from failed alternatives into a single error_info.
   Collects all expected values and picks the first 'got' value. */
let merge_errors = (errors: list(Rule.error)): Rule.error => {
  let all_infos = errors |> List.concat;
  let all_expected =
    all_infos
    |> List.concat_map((info: Rule.error_info) => info.expected)
    |> List.filter(
         fun
         /* Filter out '$' from interpolation xor — not a user-facing suggestion */
         | Rule.Keyword("$") => false
         | _ => true,
       )
    |> List.sort_uniq((a, b) =>
         String.compare(
           Rule.expected_to_string(a),
           Rule.expected_to_string(b),
         )
       );
  let got = all_infos |> List.find_map((info: Rule.error_info) => info.got);
  [{expected: all_expected, got}];
};

let xor_with_expected = rules_with_expected =>
  switch (rules_with_expected) {
  | [] => (
      tokens =>
        Rule.Data.return(
          Error([{Rule.expected: [], got: None}]),
          tokens,
        )
    )
  | all_rules_with_expected => (
      tokens => {
        let all_rules =
          all_rules_with_expected |> List.map(((_, rule)) => rule);

        /* Evaluate each rule exactly once, collecting both successes and errors */
        let results =
          all_rules
          |> List.map(rule => {
               let (data, remaining) = rule(tokens);
               (data, remaining);
             });

        /* Separate successes from failures */
        let successes =
          results
          |> List.filter_map(
               fun
               | (Ok(value), remaining) => Some((value, remaining))
               | (Error(_), _) => None,
             );

        switch (successes) {
        | [] =>
          /* All rules failed - merge structured errors */
          let errors =
            results
            |> List.filter_map(
                 fun
                 | (Error(err), _) => Some(err)
                 | (Ok(_), _) => None,
               );
          let combined_error = merge_errors(errors);
          Rule.Data.return(Error(combined_error), tokens);
        | [single] =>
          /* Exactly one match - use it directly */
          let (value, remaining) = single;
          Rule.Data.return(Ok(value), remaining);
        | [first, ...rest] =>
          /* Multiple matches - pick the longest (fewest remaining tokens) */
          let best =
            List.fold_left(
              (acc, current) => {
                let (_, acc_remaining) = acc;
                let (_, curr_remaining) = current;
                /* Use <= to prefer later alternatives on tie, matching the
                   original match_longest right-biased tie-breaking behavior */
                if (Rule.remaining_length(curr_remaining)
                    <= Rule.remaining_length(acc_remaining)) {
                  current;
                } else {
                  acc;
                };
              },
              first,
              rest,
            );
          let (value, remaining) = best;
          Rule.Data.return(Ok(value), remaining);
        };
      }
    )
  };

let xor = rules =>
  switch (rules) {
  | [] => failwith("xor doesn't makes sense without a single value")
  | all_rules => (
      tokens => {
        /* Evaluate each rule exactly once, collecting both successes and errors */
        let results =
          all_rules
          |> List.map(rule => {
               let (data, remaining) = rule(tokens);
               (data, remaining);
             });

        /* Separate successes from failures */
        let successes =
          results
          |> List.filter_map(
               fun
               | (Ok(value), remaining) => Some((value, remaining))
               | (Error(_), _) => None,
             );

        switch (successes) {
        | [] =>
          /* All rules failed - merge structured errors */
          let errors =
            results
            |> List.filter_map(
                 fun
                 | (Error(err), _) => Some(err)
                 | (Ok(_), _) => None,
               );
          let combined_error = merge_errors(errors);
          Rule.Data.return(Error(combined_error), tokens);
        | [single] =>
          /* Exactly one match - use it directly */
          let (value, remaining) = single;
          Rule.Data.return(Ok(value), remaining);
        | [first, ...rest] =>
          /* Multiple matches - pick the longest (fewest remaining tokens) */
          let best =
            List.fold_left(
              (acc, current) => {
                let (_, acc_remaining) = acc;
                let (_, curr_remaining) = current;
                /* Use <= to prefer later alternatives on tie, matching the
                   original match_longest right-biased tie-breaking behavior */
                if (Rule.remaining_length(curr_remaining)
                    <= Rule.remaining_length(acc_remaining)) {
                  current;
                } else {
                  acc;
                };
              },
              first,
              rest,
            );
          let (value, remaining) = best;
          Rule.Data.return(Ok(value), remaining);
        };
      }
    )
  };

let and_ = rules => {
  // TODO: an array is a better choice
  let rec match_everything = (values, rules) =>
    switch (rules) {
    | [] => return_match(values |> List.rev)
    | [left, ...new_rules] =>
      let.bind_match (key, value) = match_longest(left, new_rules);
      let rules = List.remove_assoc(key, rules);
      match_everything([(key, value), ...values], rules);
    };

  let rules = rules |> List.mapi((i, rule) => (i, rule));
  let.map_match values = match_everything([], rules);
  values
  |> List.sort(((a, _), (b, _)) => Int.compare(a, b))
  |> List.map(((_, v)) => v);
};

// [ A || B ] = [ A? && B? ]!
let or_ = rules =>
  rules |> List.map(Modifier.optional) |> and_ |> Modifier.at_least_one;
