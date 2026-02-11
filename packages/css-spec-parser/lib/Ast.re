[@deriving show({ with_path: false })]
type range_bound =
  | Int_bound(int)
  | Infinity
  | Neg_infinity;

[@deriving show({ with_path: false })]
type range = (range_bound, range_bound);

[@deriving show({ with_path: false })]
type multiplier =
  | One /* */
  | Zero_or_more /* * */
  | One_or_more /* + */
  | Optional /* ? */
  | Repeat(int, option(int)) /* {A} {A,B} {A,} */
  | Repeat_by_comma(int, option(int)) /* # #{A, B} */
  | At_least_one /* ! */;

[@deriving show({ with_path: false })]
type terminal =
  | Delim(string) /* ',' */
  | Keyword(string) /* auto */
  | Data_type(string, option(range)) /* <color> or <number [0, 1]> */
  | Property_type(string) /* <'color'> */;

[@deriving show({ with_path: false })]
type combinator =
  | Static /* a b */
  | And /* a && b */
  | Or /* a || b */
  | Xor; /* a | b */

[@deriving show({ with_path: false })]
type value =
  | Terminal(terminal, multiplier)
  | Combinator(combinator, list(value))
  | Group(value, multiplier) /* [ A ] */
  | Function_call(string, value) /* F( A ) */;
