open Standard;
open Combinator;
open Modifier;
open Rule.Match;
open Parser_helper;
let rec property_test = tokens =>
  combine_xor(
    [
      map(keyword("static"), _v => `Static),
      map(keyword("absolute"), _v => `Absolute),
      map(text, v => `Text(v)),
    ],
    tokens,
  )
and text = tokens =>
  combine_xor(
    [
      map(string, v => `String(v)),
      map(property_test, v => `Property_test(v)),
    ],
    tokens,
  );
module Types = {
  type property_test = [ | `Static | `Absolute | `Text(text)]
  and text = [ | `String(string) | `Property_test(property_test)]
  and integer
  and number
  and length
  and angle
  and time
  and frequency
  and resolution
  and percentage
  and ident
  and custom_ident
  and any_value
  and url
  and hex_color
  and interpolation
  and flex_value
  and hash_token
  and dimension
  and an_plus_b;
};
