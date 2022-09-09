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
  and integer = int
  and number = float
  and length = [
    | `Length(
        [
          | `Em(number)
          | `Ex(number)
          | `Cap(number)
          | `Ch(number)
          | `Ic(number)
          | `Rem(number)
          | `Lh(number)
          | `Rlh(number)
          | `Vw(number)
          | `Vh(number)
          | `Vi(number)
          | `Vb(number)
          | `Vmin(number)
          | `Vmax(number)
          | `Cm(number)
          | `Mm(number)
          | `Q(number)
          | `In(number)
          | `Pt(number)
          | `Pc(number)
          | `Px(number)
          | `Zero
        ],
      )
  ]
  and angle = [
    | `Deg(number)
    | `Grad(number)
    | `Rad(number)
    | `Turn(number)
  ]
  and time = [ | `Ms(float) | `S(float)]
  and frequency = [ | `Hz(float) | `KHz(float)]
  and resolution = [ | `Dpi(float) | `Dpcm(float) | `Dppx(float)]
  and percentage = float
  and ident = string
  and custom_ident = string
  and any_value = unit
  and url = string
  and hex_color = string
  and interpolation = list(string)
  and flex_value = [ | `Fr(float)]
  and hash_token
  and dimension
  and an_plus_b;
};
