let kebab_case_to_snake_case = name =>
  name |> String.split_on_char('-') |> String.concat("_");

let first_uppercase = name =>
  (String.sub(name, 0, 1) |> String.uppercase_ascii)
  ++ String.sub(name, 1, String.length(name) - 1);

let is_function = str => {
  let length = String.length(str);
  length >= 2 && String.sub(str, length - 2, 2) == "()";
};

let function_value_name = function_name => "function-" ++ function_name;

let property_value_name = property_name =>
  is_function(property_name)
    ? function_value_name(property_name) : "property-" ++ property_name;

let value_of_delimiter =
  fun
  | "+" => "cross"
  | "-" => "dash"
  | "*" => "asterisk"
  | "/" => "bar"
  | "@" => "at"
  | "," => "comma"
  | ";" => ""
  | ":" => "doubledot"
  | "." => "dot"
  | "(" => "openparen"
  | ")" => "closeparen"
  | "[" => "openbracket"
  | "]" => "closebracket"
  | "{" => "opencurly"
  | "}" => "closecurly"
  | "^" => "caret"
  | "<" => "lessthan"
  | "=" => "equal"
  | ">" => "biggerthan"
  | "|" => "vbar"
  | "~" => "tilde"
  | "$" => "dollar"
  | _ => "unknown";

let value_name_of_css = str => {
  let length = String.length(str);
  let str =
    if (is_function(str)) {
      let str = String.sub(str, 0, length - 2);
      function_value_name(str);
    } else {
      str;
    };
  kebab_case_to_snake_case(str);
};

let keyword_to_css = str => {
  switch (str) {
  | "%" => "percent"
  | _ => kebab_case_to_snake_case(str)
  };
};
