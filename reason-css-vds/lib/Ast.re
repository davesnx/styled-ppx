// TODO: terminology
// TODO: add css-wide keywords?

// TODO: maybe polymorphic variant?
// TODO: best naming to no multiplier
[@deriving show]
type multiplier =
  | One /* */
  | Zero_or_more /* * */
  | One_or_more /* + */
  | Optional /* ? */
  | Repeat(int, option(int)) /* {A} {A,B} {A,} */
  | Repeat_by_comma(int, option(int)) /* # #{A, B} */
  | At_least_one /* ! */;

let multiplier = value =>
  switch (value) {
  | None => One
  | Some(value) => value
  };
// TODO: non-terminals https://drafts.csswg.org/css-values-3/#component-types item 4
[@deriving show]
type value =
  | Keyword(string, multiplier) /* auto */
  | Data_type(string, multiplier) /* <color > */
  | Property_type(string, multiplier) /* <'color'> */
  // combinators
  | Static((value, value), multiplier) /* a b */
  | And((value, value), multiplier) /* && */
  | Or((value, value), multiplier) /* || */
  | Xor((value, value), multiplier) /* | */;

let rec multiplier_to_string =
  fun
  | One => ""
  | Zero_or_more => "*"
  | One_or_more => "+"
  | Optional => "?"
  | Repeat(min, Some(max)) when min == max =>
    "{" ++ string_of_int(min) ++ "}"
  | Repeat(min, Some(max)) =>
    "{" ++ string_of_int(min) ++ "," ++ string_of_int(max) ++ "}"
  | Repeat(min, None) => "{" ++ string_of_int(min) ++ ",}"
  | Repeat_by_comma(1, None) => "#"
  | Repeat_by_comma(min, max) =>
    "#" ++ multiplier_to_string(Repeat(min, max))
  | At_least_one => "!";
