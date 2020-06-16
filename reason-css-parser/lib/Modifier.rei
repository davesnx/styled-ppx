type modifier('a, 'b) = Rule.rule('a) => Rule.rule('b);

type range = (int, option(int));

let one: modifier('a, 'a);
let optional: modifier('a, option('a));
let zero_or_more: modifier('a, list('a));
let one_or_more: modifier('a, list('a));
let repeat: range => modifier('a, list('a));
let repeat_by_comma: range => modifier('a, list('a));
let at_least_one: modifier(list(option('a)), list(option('a)));
