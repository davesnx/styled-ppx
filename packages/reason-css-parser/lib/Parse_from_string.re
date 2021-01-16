let parse_tokens = Parser_helper.parse_tokens;
let parse = Parser_helper.parse;

module StringMap = Map.Make(String);
let check_value = {
  let (let.ok) = Result.bind;
  (~name, value) => {
    let.ok check =
      Parser.check_map
      |> StringMap.find_opt(name)
      |> Option.to_result(~none=`Unknown_value);
    Ok(check(value));
  };
};
let check_property = (~name) => check_value(~name="property-" ++ name);
