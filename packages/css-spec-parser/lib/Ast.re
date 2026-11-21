[@deriving show({ with_path: false })]
type range_bound =
  | Int_bound(int)
  | Infinity
  | Neg_infinity;

[@deriving show({ with_path: false })]
type range = (range_bound, range_bound);

[@deriving show({ with_path: false })]
type multiplier =
  | One
  | Zero_or_more
  | One_or_more
  | Optional
  | Repeat(int, option(int))
  | Repeat_by_comma(int, option(int))
  | At_least_one;

[@deriving show({ with_path: false })]
type terminal =
  | Delim(string)
  | Keyword(string)
  | Data_type(string, option(range))
  | Property_type(string);

[@deriving show({ with_path: false })]
type combinator =
  | Static
  | And
  | Or
  | Xor;

[@deriving show({ with_path: false })]
type value =
  | Terminal(terminal, multiplier)
  | Combinator(combinator, list(value))
  | Group(value, multiplier)
  | Function_call(string, value);
