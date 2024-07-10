type combinator('a, 'b) = list(Rule.rule('a)) => Rule.rule('b);

// TODO: docs for infix operators
let static: combinator('a, list('a));

let xor: combinator('a, 'a);

let and_: combinator('a, list('a));

let or_: combinator('a, list(option('a)));
