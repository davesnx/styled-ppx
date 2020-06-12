type combinator('a, 'b, 'c) =
  (Rule.rule('a), Rule.rule('b)) => Rule.rule('c);

// TODO: docs for infix operators
let combine_static: combinator('a, 'b, ('a, 'b));
let (+): combinator('a, 'b, ('a, 'b));

let combine_xor: combinator('a, 'a, 'a);
let (lxor): combinator('a, 'a, 'a);

let combine_and: combinator('a, 'b, ('a, 'b));
let (land): combinator('a, 'b, ('a, 'b));

let combine_or: combinator('a, 'b, (option('a), option('b)));
let (lor): combinator('a, 'b, (option('a), option('b)));
