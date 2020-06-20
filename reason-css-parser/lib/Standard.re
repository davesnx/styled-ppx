open Tokens;
open Combinator;
open Rule.Let;
open Rule.Pattern;
open Rule.Match;

let keyword = string => expect(STRING(string));
let function_call = (name, rule) => {
  let.bind_match () = keyword(name);
  let.bind_match () = expect(LEFT_PARENS);
  let.bind_match value = rule;
  let.bind_match () = expect(RIGHT_PARENS);
  return_match(value);
};

let integer =
  token(
    fun
    | INT(int) => Ok(int)
    | _ => Error("expected an integer"),
  );

let number =
  token(
    fun
    | INT(int) => Ok(int |> float_of_int)
    | _ => Error("expected a number"),
  );

let length = {
  let.bind_match number = number;
  combine_xor([
    // relative
    keyword("em") |> value(`Em(number)),
    keyword("ex") |> value(`Ex(number)),
    keyword("cap") |> value(`Cap(number)),
    keyword("ch") |> value(`Ch(number)),
    keyword("ic") |> value(`Ic(number)),
    keyword("rem") |> value(`Rem(number)),
    keyword("lh") |> value(`Lh(number)),
    keyword("rlh") |> value(`Rlh(number)),
    keyword("vw") |> value(`Vw(number)),
    keyword("vh") |> value(`Vh(number)),
    keyword("vi") |> value(`Vi(number)),
    keyword("vb") |> value(`Vb(number)),
    keyword("vmin") |> value(`Vmin(number)),
    keyword("vmax") |> value(`Vmax(number)),
    // absolute
    keyword("cm") |> value(`Cm(number)),
    keyword("mm") |> value(`Mm(number)),
    keyword("Q") |> value(`Q(number)),
    keyword("in") |> value(`In(number)),
    keyword("pt") |> value(`Pt(number)),
    keyword("pc") |> value(`Pc(number)),
    keyword("px") |> value(`Px(number)),
    identity |> value(`Zero),
  ]);
};

// TODO: positive numbers like <number [0,infinity]>
let percentage = {
  let.bind_match number = number;
  let.bind_match () = expect(PERCENT);
  return_match(number);
};

let length_percentage =
  combine_xor([
    map(length, v => `Length(v)),
    map(percentage, v => `Percentage(v)),
  ]);

let css_wide_keywords =
  combine_xor([
    value(`Initial, keyword("initial")),
    value(`Inherit, keyword("inherit")),
    value(`Unset, keyword("unset")),
  ]);
