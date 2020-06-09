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

[@deriving show({with_path: false})]
type terminal =
  | Keyword(string) /* auto */
  | Data_type(string) /* <color > */
  | Property_type(string) /* <'color'> */
  | Function(string) /* <color()> */;

[@deriving show({with_path: false})]
type combinator =
  | Static /* a b */
  | And /* a && b */
  | Or /* a || b */
  | Xor /* a | b */;

// TODO: non-terminals https://drafts.csswg.org/css-values-3/#component-types item 4
[@deriving show({with_path: false})]
type value =
  | Terminal(terminal, multiplier)
  | Combinator(combinator, list(value))
  | Group(value, multiplier) /* [ A ] */
  | Function_call(string, value) /* F( A ) */;
// TODO: does Function_call accepts multiplier?

// the only case where At_least_one makes sense, is with static
// A? || B? = A? && B?
// [ A? || B? ]! = [ A? && B? ]! = A || B
// A? | B? ... what would that mean? true | true ?
// [ A? | B? ]! = A | B
// [ A? B? ]! != A B

// [ A? B? ]! != [ A B ]
// [ A? && B? ]! == A || B
// [ A? || B? ]! == A || B
// [ A? | B? ]! == A | B
