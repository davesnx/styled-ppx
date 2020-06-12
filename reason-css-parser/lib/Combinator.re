open Rule.Let;
open Modifier;

type combinator('a, 'b, 'c) =
  (Rule.rule('a), Rule.rule('b)) => Rule.rule('c);

let combine_static = (left, right) => {
  let.bind_match left_value = left;
  let.bind_match right_value = right;
  return_match((left_value, right_value));
};
let (+) = combine_static;

// TODO: test [A | [A B] ] with A B
let combine_xor = (left, right) => {
  let.bind_longest_match value = (left, right);
  let value =
    switch (value) {
    | `Left(value)
    | `Right(value) => value
    };
  return_match(value);
};
let (lxor) = combine_xor;

// TODO: [ A && [A B] ] with A B A
let combine_and = (left, right) => {
  let.bind_longest_match value = (left, right);
  switch (value) {
  | `Left(left_value) =>
    let.bind_match right_value = right;
    return_match((left_value, right_value));
  | `Right(right_value) =>
    let.bind_match left_value = left;
    return_match((left_value, right_value));
  };
};
let (land) = combine_and;

// [ A || B ] = [ A? && B? ]!
let combine_or = (left, right) => {
  let left = optional(left);
  let right = optional(right);

  combine_and(left, right) |> at_least_one;
};
let (lor) = combine_or;
