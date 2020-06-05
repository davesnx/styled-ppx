// TODO: range <length [0, infinity]
// TODO: terminology
// TODO: add css-wide keywords?

// TODO: maybe polymorphic variant?
// TODO: best naming to no multiplier
// TODO: can a value have two multipliers?
[@deriving show({with_path: false})]
type multiplier =
  | One /* */
  | Zero_or_more /* * */
  | One_or_more /* + */
  | Optional /* ? */
  | Repeat(int, option(int)) /* {A} {A,B} {A,} */
  | Repeat_by_comma(int, option(int)) /* # #{A, B} */
  | At_least_one /* ! */; // TODO: ! is only allowed for groups

// TODO: non-terminals https://drafts.csswg.org/css-values-3/#component-types item 4
[@deriving show({with_path: false})]
type value =
  | Keyword(string, multiplier) /* auto */
  | Data_type(string, multiplier) /* <color > */
  | Property_type(string, multiplier) /* <'color'> */
  // group is only useful because [ A* ]*
  | Group(value, multiplier) /* [ A ] */
  // combinators
  | Static(list(value)) /* a b */
  | And(list(value)) /* a && b */
  | Or(list(value)) /* a || b */
  | Xor(list(value)) /* a | b */;
