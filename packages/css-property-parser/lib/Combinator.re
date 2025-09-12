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
  if (List.is_empty(errors)) {
    ["No alternatives matched"];
  } else {
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
  | all_rules =>
    let try_rules_with_best_match = rules => {
      switch (rules) {
      | [] => failwith("xor doesn't makes sense without a single value")
      | [left, ...rest] =>
        let rules_with_unit = List.map(rule => ((), rule), rest);
        let.map_match ((), value) =
          match_longest(((), left), rules_with_unit);
        value;
      };
    };

    let try_all_and_collect_errors = (rules, tokens) => {
      let rec collect_errors = (remaining_rules, acc_errors) => {
        switch (remaining_rules) {
        | [] =>
          let combined_error = process_error_messages(acc_errors);
          Rule.Data.return(Error(combined_error), tokens);
        | [rule, ...rest] =>
          let (data, remaining) = rule(tokens);
          switch (data) {
          | Ok(value) => Rule.Data.return(Ok(value), remaining)
          | Error(err) => collect_errors(rest, acc_errors @ [err])
          };
        };
      };
      collect_errors(rules, []);
    };

    (
      tokens => {
        let successful_rules =
          all_rules
          |> List.filter_map(rule => {
               let (data, remaining) = rule(tokens);
               switch (data) {
               | Ok(_) => Some((rule, remaining))
               | Error(_) => None
               };
             });

        switch (successful_rules) {
        | [] => try_all_and_collect_errors(all_rules, tokens)
        | _ => try_rules_with_best_match(all_rules, tokens)
        };
      }
    );
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
let or_ = rules => rules |> List.map(Modifier.optional) |> and_;
