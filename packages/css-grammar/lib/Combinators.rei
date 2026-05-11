type combinator('a, 'b) = list(Rule.rule('a)) => Rule.rule('b);

// TODO: docs for infix operators
let static: combinator('a, list('a));

let xor: combinator('a, 'a);

type expected_rule('a) = (option(string), Rule.rule('a));

let xor_with_expected: list(expected_rule('a)) => Rule.rule('a);

let and_: combinator('a, list('a));

let or_: combinator('a, list(option('a)));
