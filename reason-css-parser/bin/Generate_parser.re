let to_property = name => "property_" ++ name;

module Json = {
  module Yojson = Yojson.Safe;
  exception Invalid_json_syntax;
  let syntax_of_yojson = (json: Yojson.t) =>
    switch (json) {
    | `Assoc(map) =>
      let syntax =
        map
        |> List.find_map(
             fun
             | ("syntax", `String(syntax)) => Some(syntax)
             | _ => None,
           );
      switch (syntax) {
      | None => raise(Invalid_json_syntax)
      | Some(syntax) => syntax
      };
    | _ => raise(Invalid_json_syntax)
    };
  let pairs_of_yojson = (json: Yojson.t) =>
    switch (json) {
    | `Assoc(pairs) =>
      pairs |> List.map(((key, value)) => (key, syntax_of_yojson(value)))
    | _ => raise(Invalid_json_syntax)
    };
};

module Patch = {
  open Reason_css_vds;
  module StringMap = Map.Make(String);

  exception Missing_value_;
  // TODO: probably should be separated in two functions
  let rec patch_dependencies = (value_map, value) =>
    switch (value) {
    | Terminal(terminal, multiplier) =>
      let (missing, terminal) =
        switch (terminal) {
        | Keyword(_) => ([], terminal)
        | Data_type(data) =>
          switch (
            value_map |> StringMap.find_opt(data),
            value_map |> StringMap.find_opt(to_property(data)),
          ) {
          | (Some(_), _) => ([], Data_type(data))
          | (None, Some(_)) => ([], Data_type(to_property(data)))
          | (None, None) => ([data], Data_type(data))
          }
        | Property_type(property) =>
          let missing =
            switch (value_map |> StringMap.find_opt(property)) {
            | Some(_) => []
            | None => [property]
            };
          (missing, Property_type(property));
        };
      (missing, Terminal(terminal, multiplier));
    | Combinator(_, []) => failwith("Invalid combinator, empty")
    | Combinator(kind, [value, ...values]) =>
      let (missing, value) = patch_dependencies(value_map, value);
      let (missing, values) =
        values
        |> List.fold_left(
             ((all_missing, values), value) => {
               let (missing, value) = patch_dependencies(value_map, value);
               (List.append(missing, all_missing), [value, ...values]);
             },
             (missing, [value]),
           );
      let values = values |> List.rev;
      (missing, Combinator(kind, values));
    | Group(value, multiplier) =>
      let (missing, value) = patch_dependencies(value_map, value);
      (missing, Group(value, multiplier));
    | Function_call(name, value) =>
      let (missing, value) = patch_dependencies(value_map, value);
      (missing, Function_call(name, value));
    };

  let patch_values = values => {
    let values =
      values
      |> List.map(((name, value)) => {
           let value =
             switch (Reason_css_vds.value_of_string(value)) {
             | None => failwith(name)
             | Some(value) => value
             | exception _ => failwith(name)
             };
           (name, value);
         });
    let value_map = values |> List.to_seq |> StringMap.of_seq;
    let (values, missing) =
      value_map
      |> StringMap.map(patch_dependencies(value_map))
      |> StringMap.bindings
      |> List.map(((key, (missing, value))) => ((key, value), missing))
      |> List.split;
    let missing = List.concat(missing);
    let values =
      values
      |> List.map(((name, value)) =>
           (name, Reason_css_vds.value_to_string(value))
         );
    (missing, values);
  };
};

module Emit = {
  open Reason_css_parser_ppx;
  module Ast_builder =
    Ppxlib.Ast_builder.Make({
      let loc = Location.none;
    });
  module Emit = Emit.Make(Ast_builder);
  open Ast_builder;

  let value_name = key => {
    open String;
    let len = length(key);
    sub(key, len - 2, 2) == "()" ? "function_" ++ sub(key, 0, len - 2) : key;
  };

  let emit_values = values =>
    values
    |> List.map(((name, value)) => {
         let name = Escape.name(name);
         let expr = {
           let payload = Parsetree.PStr([pstr_eval(estring(value), [])]);
           pexp_extension((Located.mk("value.rec"), payload));
         };
         value_binding(~pat=pvar(name), ~expr);
       })
    |> pstr_value(Asttypes.Recursive);
  let emit_check_map = values => {
    let key_to_value_list =
      values
      |> List.map(((name, _)) =>
           pexp_tuple([
             estring(name),
             eapply(evar("check"), [Escape.name(name) |> evar]),
           ])
         )
      |> elist;
    let key_to_value_seq = eapply(evar("List.to_seq"), [key_to_value_list]);
    let key_to_value_map =
      eapply(evar("StringMap.of_seq"), [key_to_value_seq]);
    let binding =
      value_binding(~pat=pvar("check_map"), ~expr=key_to_value_map);
    pstr_value(Asttypes.Nonrecursive, [binding]);
  };
  let emit_code = (~values, ~properties) => {
    let properties =
      properties |> List.map(((key, value)) => ("property-" ++ key, value));
    let values =
      values |> List.map(((key, value)) => (value_name(key), value));
    let (_missing, values) =
      List.append(values, properties) |> Patch.patch_values;
    [emit_values(values), emit_check_map(values)];
  };
};

let read_file = file => {
  let fd = open_in(file);
  really_input_string(fd, in_channel_length(fd));
};

open Json;
open Emit;

// get from mdn-data at npm
let values =
  read_file("./bin/syntaxes.json") |> Yojson.from_string |> pairs_of_yojson;
let properties =
  read_file("./bin/properties.json") |> Yojson.from_string |> pairs_of_yojson;

emit_code(~values, ~properties)
|> Pprintast.string_of_structure
|> print_endline;
