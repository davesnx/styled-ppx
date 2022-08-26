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
      map(color, v => `Color(v)),
    ],
    tokens,
  );
module Types = {
  type property_test = [ | `Static | `Absolute | `Color(color)];
};
