type combinator('a, 'b) = list(Rule.rule('a)) => Rule.rule('b);

// TODO: docs for infix operators
let combine_static: combinator('a, list('a));

let combine_xor: combinator('a, 'a);

let combine_and: combinator('a, list('a));

let combine_or: combinator('a, list(option('a)));
