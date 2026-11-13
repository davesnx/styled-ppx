open Ppxlib
module Builder = Ppxlib.Ast_builder.Default

type binding = {
  longident : string;
  class_string : string;
}

type ref_loc = {
  longident : string;
  file : string;
  start_line : int;
  start_col : int;
  end_col : int;
}

type class_entry = {
  class_name : string;
  rule_index : int;
  binding : string;
  file : string;
  start_line : int;
  start_col : int;
  end_line : int;
  end_col : int;
}

let css_attribute_name = "css"
let bindings_attribute_name = "css.bindings"
let refs_attribute_name = "css.refs"
let config_attribute_name = "css.config"
let classes_attribute_name = "css.classes"
let config_env_key = "env"
let config_env_production = "production"
let sentinel_byte = '\x00'

let sentinel longident =
  String.make 1 sentinel_byte ^ longident ^ String.make 1 sentinel_byte

let binding ~longident ~class_string = { longident; class_string }

let ref_loc ~longident ~file ~start_line ~start_col ~end_col =
  { longident; file; start_line; start_col; end_col }

let ref_loc_of_location ~longident (loc : Ppxlib.Location.t) =
  let pos_start = loc.loc_start in
  let pos_end = loc.loc_end in
  {
    longident;
    file = pos_start.pos_fname;
    start_line = pos_start.pos_lnum;
    start_col = pos_start.pos_cnum - pos_start.pos_bol;
    end_col = pos_end.pos_cnum - pos_end.pos_bol;
  }

let class_entry ~class_name ~rule_index ~binding (loc : Ppxlib.Location.t) =
  let pos_start = loc.loc_start in
  let pos_end = loc.loc_end in
  {
    class_name;
    rule_index;
    binding;
    file = pos_start.pos_fname;
    start_line = pos_start.pos_lnum;
    start_col = pos_start.pos_cnum - pos_start.pos_bol;
    end_line = pos_end.pos_lnum;
    end_col = pos_end.pos_cnum - pos_end.pos_bol;
  }

let make_list_attribute ~name expr =
  let loc = Ppxlib.Location.none in
  let payload = Ppxlib.PStr [ Builder.pstr_eval ~loc expr [] ] in
  let attr =
    Builder.attribute ~loc ~name:{ Ppxlib.Location.txt = name; loc } ~payload
  in
  Builder.pstr_attribute ~loc attr

let css_attribute rule =
  let loc = Ppxlib.Location.none in
  make_list_attribute ~name:css_attribute_name (Builder.estring ~loc rule)

let bindings_attribute entries =
  let loc = Ppxlib.Location.none in
  let entry_to_expr (entry : binding) =
    Builder.pexp_tuple ~loc
      [
        Builder.estring ~loc entry.longident;
        Builder.estring ~loc entry.class_string;
      ]
  in
  make_list_attribute ~name:bindings_attribute_name
    (Builder.elist ~loc (List.map entry_to_expr entries))

let config_attribute entries =
  let loc = Ppxlib.Location.none in
  let entry_to_expr (key, value) =
    Builder.pexp_tuple ~loc
      [ Builder.estring ~loc key; Builder.estring ~loc value ]
  in
  make_list_attribute ~name:config_attribute_name
    (Builder.elist ~loc (List.map entry_to_expr entries))

let classes_attribute entries =
  let loc = Ppxlib.Location.none in
  let entry_to_expr (entry : class_entry) =
    Builder.pexp_tuple ~loc
      [
        Builder.estring ~loc entry.class_name;
        Builder.eint ~loc entry.rule_index;
        Builder.estring ~loc entry.binding;
        Builder.estring ~loc entry.file;
        Builder.eint ~loc entry.start_line;
        Builder.eint ~loc entry.start_col;
        Builder.eint ~loc entry.end_line;
        Builder.eint ~loc entry.end_col;
      ]
  in
  make_list_attribute ~name:classes_attribute_name
    (Builder.elist ~loc (List.map entry_to_expr entries))

let refs_attribute entries =
  let loc = Ppxlib.Location.none in
  let entry_to_expr (entry : ref_loc) =
    Builder.pexp_tuple ~loc
      [
        Builder.estring ~loc entry.longident;
        Builder.estring ~loc entry.file;
        Builder.eint ~loc entry.start_line;
        Builder.eint ~loc entry.start_col;
        Builder.eint ~loc entry.end_col;
      ]
  in
  make_list_attribute ~name:refs_attribute_name
    (Builder.elist ~loc (List.map entry_to_expr entries))

let string_of_const_expr (e : Ppxlib.expression) : string option =
  match e.pexp_desc with
  | Pexp_constant (Pconst_string (s, _, _)) -> Some s
  | _ -> None

let int_of_const_expr (e : Ppxlib.expression) : int option =
  match e.pexp_desc with
  | Pexp_constant (Pconst_integer (s, _)) ->
    (try Some (int_of_string s) with Failure _ -> None)
  | _ -> None

let decode_css_payload value =
  match string_of_const_expr value with
  | Some rule -> Ok rule
  | None -> Error "expected [@@@css] payload to be a string literal"

let decode_list ~attribute ~decode (e : Ppxlib.expression) =
  let rec loop index (e : Ppxlib.expression) acc =
    match e.pexp_desc with
    | Pexp_construct ({ txt = Lident "[]"; _ }, None) -> Ok (List.rev acc)
    | Pexp_construct
        ({ txt = Lident "::"; _ }, Some { pexp_desc = Pexp_tuple [ hd; tl ]; _ })
      ->
      (match decode hd with
      | Ok v -> loop (index + 1) tl (v :: acc)
      | Error msg ->
        Error
          (Printf.sprintf "malformed %s payload at entry %d: %s" attribute index
             msg))
    | _ -> Error (Printf.sprintf "expected %s payload to be a list" attribute)
  in
  loop 0 e []

let decode_binding (e : Ppxlib.expression) =
  match e.pexp_desc with
  | Pexp_tuple [ longident_e; class_e ] ->
    (match string_of_const_expr longident_e, string_of_const_expr class_e with
    | Some longident, Some class_string -> Ok { longident; class_string }
    | _ -> Error "expected (longident, class_string) string tuple")
  | _ -> Error "expected (longident, class_string) tuple"

let decode_ref (e : Ppxlib.expression) =
  match e.pexp_desc with
  | Pexp_tuple [ longident_e; file_e; sl_e; sc_e; ec_e ] ->
    (match
       ( string_of_const_expr longident_e,
         string_of_const_expr file_e,
         int_of_const_expr sl_e,
         int_of_const_expr sc_e,
         int_of_const_expr ec_e )
     with
    | Some longident, Some file, Some start_line, Some start_col, Some end_col
      ->
      Ok { longident; file; start_line; start_col; end_col }
    | _ ->
      Error "expected (longident, file, start_line, start_col, end_col) tuple")
  | _ ->
    Error "expected (longident, file, start_line, start_col, end_col) tuple"

let decode_config_entry (e : Ppxlib.expression) =
  match e.pexp_desc with
  | Pexp_tuple [ key_e; value_e ] ->
    (match string_of_const_expr key_e, string_of_const_expr value_e with
    | Some key, Some value -> Ok (key, value)
    | _ -> Error "expected (key, value) string tuple")
  | _ -> Error "expected (key, value) tuple"

let decode_class_entry (e : Ppxlib.expression) =
  let shape =
    "expected (class, rule_index, binding, file, start_line, start_col, \
     end_line, end_col) tuple"
  in
  match e.pexp_desc with
  | Pexp_tuple [ class_e; index_e; binding_e; file_e; sl_e; sc_e; el_e; ec_e ]
    ->
    (match
       ( string_of_const_expr class_e,
         int_of_const_expr index_e,
         string_of_const_expr binding_e,
         string_of_const_expr file_e,
         List.map int_of_const_expr [ sl_e; sc_e; el_e; ec_e ] )
     with
    | Some _, Some index, Some _, Some _, _ when index < 0 ->
      Error (Printf.sprintf "expected a rule index of 0 or more, got %d" index)
    | ( Some class_name,
        Some rule_index,
        Some binding,
        Some file,
        [ Some start_line; Some start_col; Some end_line; Some end_col ] ) ->
      Ok
        {
          class_name;
          rule_index;
          binding;
          file;
          start_line;
          start_col;
          end_line;
          end_col;
        }
    | _ -> Error shape)
  | _ -> Error shape

let decode_classes_payload =
  decode_list ~attribute:classes_attribute_name ~decode:decode_class_entry

let decode_bindings_payload =
  decode_list ~attribute:bindings_attribute_name ~decode:decode_binding

let decode_config_payload =
  decode_list ~attribute:config_attribute_name ~decode:decode_config_entry

let decode_refs_payload =
  decode_list ~attribute:refs_attribute_name ~decode:decode_ref

type lookup_error =
  | Unresolved
  | Several_blocks of int
  | Not_one_block

let resolve_sentinels ~lookup ~on_error ~on_malformed (rule : string) : string =
  let buf = Buffer.create (String.length rule) in
  let len = String.length rule in
  let i = ref 0 in
  while !i < len do
    let c = rule.[!i] in
    if c = sentinel_byte then begin
      let start = !i + 1 in
      let stop =
        let rec find j =
          if j >= len then None
          else if rule.[j] = sentinel_byte then Some j
          else find (j + 1)
        in
        find start
      in
      match stop with
      | None ->
        on_malformed "unterminated cross-module selector sentinel";
        Buffer.add_char buf c;
        incr i
      | Some j ->
        let longident = String.sub rule start (j - start) in
        (match lookup longident with
        | Ok class_name -> Buffer.add_string buf class_name
        | Error error ->
          on_error longident error;
          Buffer.add_char buf c;
          Buffer.add_string buf longident;
          Buffer.add_char buf c);
        i := j + 1
    end
    else begin
      Buffer.add_char buf c;
      incr i
    end
  done;
  Buffer.contents buf
