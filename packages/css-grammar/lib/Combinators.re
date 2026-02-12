open Rule.Let;

type combinator('a, 'b) = list(Rule.rule('a)) => Rule.rule('b);
type expected_rule('a) = (option(string), Rule.rule('a));

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
  if (!String.contains(error_msg, '\'')) {
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

let contains_substring = (text, pattern) => {
  let text_len = String.length(text);
  let pattern_len = String.length(pattern);
  let rec loop = idx =>
    if (idx + pattern_len > text_len) {
      false;
    } else if (String.sub(text, idx, pattern_len) == pattern) {
      true;
    } else {
      loop(idx + 1);
    };
  loop(0);
};

let extract_all_quoted_values = error_msg => {
  let rec loop = (start, acc) =>
    try({
      let open_idx = String.index_from(error_msg, start, '\'');
      let close_idx = String.index_from(error_msg, open_idx + 1, '\'');
      let value =
        String.sub(error_msg, open_idx + 1, close_idx - open_idx - 1);
      loop(close_idx + 1, [value, ...acc]);
    }) {
    | _ => List.rev(acc)
    };
  loop(0, []);
};

let extract_expected_values = error_msg =>
  if (!String.contains(error_msg, '\'')) {
    [];
  } else {
    let has_got =
      contains_substring(error_msg, "got")
      || contains_substring(error_msg, "Got");
    has_got
      ? switch (extract_expected_value(error_msg)) {
        | Some(value) => [value]
        | None => []
        }
      : extract_all_quoted_values(error_msg);
  };

let extract_got_value = error_msg =>
  /* Extract what we got from error message */
  if (!String.contains(error_msg, '\'')) {
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

let max_expected_values = 8;

let split_at = (count, values) => {
  let rec loop = (count, values, acc) =>
    if (count <= 0) {
      (List.rev(acc), values);
    } else {
      switch (values) {
      | [] => (List.rev(acc), [])
      | [value, ...rest] => loop(count - 1, rest, [value, ...acc])
      };
    };
  loop(count, values, []);
};

let format_expected_values = values => {
  switch (values) {
  | [] => ""
  | values =>
    let (shown, rest) = split_at(max_expected_values, values);
    let shown = shown |> List.map(value => "'" ++ value ++ "'");
    switch (rest) {
    | [] =>
      switch (shown) {
      | [] => ""
      | [single] => single
      | [first, second] => first ++ " or " ++ second
      | _ =>
        let rec format_list = lst =>
          switch (lst) {
          | [] => ""
          | [last] => "or " ++ last
          | [item, ...items] => item ++ ", " ++ format_list(items)
          };
        format_list(shown);
      }
    | _ => String.concat(", ", shown) ++ ", etc."
    };
  };
};

let create_error_message = (got, expected_values) => {
  switch (expected_values) {
  | [] =>
    /* No valid expected values to show */
    ["Expected a valid value."]
  | values =>
    let expected_str = format_expected_values(values);
    let base =
      expected_str == ""
        ? "Expected a valid value." : "Expected " ++ expected_str ++ ".";
    let message =
      switch (Levenshtein.find_closest_match(got, values)) {
      | Some(suggestion) => base ++ " Did you mean '" ++ suggestion ++ "'?"
      | None => base
      };
    [message];
  };
};

let dedupe_preserve_order = values => {
  let rec loop = (seen, acc, values) =>
    switch (values) {
    | [] => List.rev(acc)
    | [value, ...rest] =>
      if (List.mem(value, seen)) {
        loop(seen, acc, rest);
      } else {
        loop([value, ...seen], [value, ...acc], rest);
      }
    };
  loop([], [], values);
};

let process_error_messages = (~expected_from_rules=[], errors) =>
  switch (errors) {
  | [] => ["No alternatives matched"]
  | errors =>
    /* Extract expected values from all error messages */
    let expected_values =
      errors
      |> List.map(error_list =>
           error_list |> List.map(extract_expected_values) |> List.concat
         )
      |> List.concat
      /* Filter out '$' token which comes from the interpolation xor, and we don't want to render it as a valid value suggestion. A bit of a hack. */
      |> List.filter(value => value != "$")
      |> dedupe_preserve_order;

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

let xor_with_expected = rules_with_expected =>
  switch (rules_with_expected) {
  | [] => (
      tokens => Rule.Data.return(Error(["No alternatives matched"]), tokens)
    )
  | all_rules_with_expected => (
      tokens => {
        let expected_from_rules =
          all_rules_with_expected
          |> List.filter_map(((expected, _rule)) => expected);

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
          /* All rules failed - collect errors for diagnostics */
          let errors =
            results
            |> List.filter_map(
                 fun
                 | (Error(err), _) => Some(err)
                 | (Ok(_), _) => None,
               );
          let combined_error =
            process_error_messages(~expected_from_rules, errors);
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
