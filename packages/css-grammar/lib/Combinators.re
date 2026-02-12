open Rule.Let;

type combinator('a, 'b) = list(Rule.rule('a)) => Rule.rule('b);

let rec match_longest = ((left_key, left_rule), rules) =>
  switch (rules) {
  | [] =>
    let.bind_match value = left_rule;
    return_match((left_key, value));
  | [new_left, ...rules] =>
    let.bind_longest_match value = (
      left_rule,
      match_longest(new_left, rules),
    );
    switch (value) {
    | `Left(value) => return_match((left_key, value))
    | `Right(value) => return_match(value)
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

/* Helper functions for xor error handling */
let extract_expected_value = error_msg =>
  /* Extract the expected value from error message like "Expected 'X' but instead got 'Y'." */
  if (!String.contains(error_msg, 'E')) {
    None;
  } else {
    try({
      let start = String.index(error_msg, '\'') + 1;
      let end_idx = String.index_from(error_msg, start, '\'');
      Some(String.sub(error_msg, start, end_idx - start));
    }) {
    | _ => None
    };
  };

let extract_got_value = error_msg =>
  /* Extract what we got from error message */
  if (!String.contains(error_msg, 'i')) {
    "the provided value";
  } else {
    try({
      let start = String.rindex(error_msg, '\'');
      let before_quote = String.sub(error_msg, 0, start);
      let second_last = String.rindex(before_quote, '\'') + 1;
      String.sub(error_msg, second_last, start - second_last);
    }) {
    | _ => "the provided value"
    };
  };

let format_expected_values = values => {
  switch (values) {
  | [] => ""
  | [single] => "'" ++ single ++ "'"
  | _ =>
    let rec format_list = lst =>
      switch (lst) {
      | [] => ""
      | [x] => "or '" ++ x ++ "'"
      | [x, ...xs] => "'" ++ x ++ "', " ++ format_list(xs)
      };
    format_list(values);
  };
};

let create_error_message = (got, expected_values) => {
  switch (expected_values) {
  | [] =>
    /* No valid expected values to show */
    ["Got '" ++ got ++ "'"]
  | values =>
    switch (Levenshtein.find_closest_match(got, values)) {
    | Some(suggestion) =>
      /* Found a close match - suggest it */
      ["Got '" ++ got ++ "', did you mean '" ++ suggestion ++ "'?"]
    | None =>
      /* No close match - show all valid options */
      let expected_str = format_expected_values(values);
      ["Got '" ++ got ++ "', expected " ++ expected_str ++ "."];
    }
  };
};

let process_error_messages = errors =>
  switch (errors) {
  | [] => ["No alternatives matched"]
  | errors =>
    /* Extract expected values from all error messages */
    let expected_values =
      errors
      |> List.filter_map(error_list =>
           switch (error_list) {
           | [msg, ..._rest] => extract_expected_value(msg)
           | _ => None
           }
         )
      /* Filter out '$' token which comes from the interpolation xor, and we don't want to render it as a valid value suggestion. A bit of a hack. */
      |> List.filter(value => value != "$")
      |> List.sort_uniq(String.compare);

    switch (expected_values) {
    | [] => List.hd(errors)
    | values =>
      let got =
        switch (List.hd(errors)) {
        | [msg, ..._rest] => extract_got_value(msg)
        | _ => "the provided value"
        };
      create_error_message(got, values);
    };
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
          /* All rules failed - collect errors for diagnostics */
          let errors =
            results
            |> List.filter_map(
                 fun
                 | (Error(err), _) => Some(err)
                 | (Ok(_), _) => None,
               );
          let combined_error = process_error_messages(errors);
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
                if (List.length(curr_remaining) <= List.length(acc_remaining)) {
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
