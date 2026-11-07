open Ppxlib
module Builder = Ppxlib.Ast_builder.Default

type binding = {
  longident : string;
  class_string : string;
  binding_id : string;
}

type hash_source = {
  kind : string;
  token : string;
  source : string;
}

type atom = {
  cls : string;
  rules : string list;
  tier : int;
  conds : int;
  cover : int;
  hashes : hash_source list;
}

type ref_loc = {
  longident : string;
  file : string;
  start_line : int;
  start_col : int;
  end_col : int;
}

let css_attribute_name = "css"
let bindings_attribute_name = "css.bindings"
let refs_attribute_name = "css.refs"
let atoms_attribute_name = "css.atoms"
let config_attribute_name = "css.config"
let config_env_key = "env"
let config_env_production = "production"
let sentinel_byte = '\x00'

let sentinel longident =
  String.make 1 sentinel_byte ^ longident ^ String.make 1 sentinel_byte

let class_chain_of_class_string class_string =
  String.split_on_char ' ' class_string
  |> List.filter (fun s -> s <> "")
  |> String.concat "."

let binding_with_id ~longident ~class_string ~binding_id =
  { longident; class_string; binding_id }

let binding ~longident ~class_string =
  binding_with_id ~longident ~class_string ~binding_id:""

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
      ([
         Builder.estring ~loc entry.longident;
         Builder.estring ~loc entry.class_string;
       ]
      @
      if entry.binding_id = "" then []
      else [ Builder.estring ~loc entry.binding_id ])
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

let atoms_attribute entries =
  let loc = Ppxlib.Location.none in
  let hash_to_expr (h : hash_source) =
    Builder.pexp_tuple ~loc
      [
        Builder.estring ~loc h.kind;
        Builder.estring ~loc h.token;
        Builder.estring ~loc h.source;
      ]
  in
  let entry_to_expr (entry : atom) =
    Builder.pexp_tuple ~loc
      [
        Builder.estring ~loc entry.cls;
        Builder.elist ~loc (List.map (Builder.estring ~loc) entry.rules);
        Builder.eint ~loc entry.tier;
        Builder.eint ~loc entry.conds;
        Builder.eint ~loc entry.cover;
        Builder.elist ~loc (List.map hash_to_expr entry.hashes);
      ]
  in
  make_list_attribute ~name:atoms_attribute_name
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
    | Some longident, Some class_string ->
      Ok { longident; class_string; binding_id = "" }
    | _ -> Error "expected (longident, class_string) string tuple")
  | Pexp_tuple [ longident_e; class_e; id_e ] ->
    (match
       ( string_of_const_expr longident_e,
         string_of_const_expr class_e,
         string_of_const_expr id_e )
     with
    | Some longident, Some class_string, Some binding_id ->
      Ok { longident; class_string; binding_id }
    | _ -> Error "expected (longident, class_string, binding_id) string tuple")
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

let decode_hash (e : Ppxlib.expression) =
  match e.pexp_desc with
  | Pexp_tuple [ kind_e; token_e; source_e ] ->
    (match
       ( string_of_const_expr kind_e,
         string_of_const_expr token_e,
         string_of_const_expr source_e )
     with
    | Some kind, Some token, Some source -> Ok { kind; token; source }
    | _ -> Error "expected (kind, token, source) string tuple")
  | _ -> Error "expected (kind, token, source) tuple"

let decode_atom (e : Ppxlib.expression) =
  let shape = "expected (cls, rules, tier, conds, cover, hashes) tuple" in
  match e.pexp_desc with
  | Pexp_tuple [ cls_e; rules_e; tier_e; conds_e; cover_e; hashes_e ] ->
    (match
       ( string_of_const_expr cls_e,
         int_of_const_expr tier_e,
         int_of_const_expr conds_e,
         int_of_const_expr cover_e )
     with
    | Some cls, Some tier, Some conds, Some cover ->
      let rules =
        decode_list ~attribute:"rules"
          ~decode:(fun r ->
            match string_of_const_expr r with
            | Some rule -> Ok rule
            | None -> Error "expected a string literal")
          rules_e
      in
      (match
         rules, decode_list ~attribute:"hashes" ~decode:decode_hash hashes_e
       with
      | Ok rules, Ok hashes -> Ok { cls; rules; tier; conds; cover; hashes }
      | Error msg, _ | _, Error msg -> Error msg)
    | _ -> Error shape)
  | _ -> Error shape

let decode_config_entry (e : Ppxlib.expression) =
  match e.pexp_desc with
  | Pexp_tuple [ key_e; value_e ] ->
    (match string_of_const_expr key_e, string_of_const_expr value_e with
    | Some key, Some value -> Ok (key, value)
    | _ -> Error "expected (key, value) string tuple")
  | _ -> Error "expected (key, value) tuple"

let decode_bindings_payload =
  decode_list ~attribute:bindings_attribute_name ~decode:decode_binding

let decode_config_payload =
  decode_list ~attribute:config_attribute_name ~decode:decode_config_entry

let decode_atoms_payload =
  decode_list ~attribute:atoms_attribute_name ~decode:decode_atom

let decode_refs_payload =
  decode_list ~attribute:refs_attribute_name ~decode:decode_ref

let resolve_sentinels ~lookup ~on_unresolved ~on_malformed (rule : string) :
  string =
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
        | Some class_string ->
          Buffer.add_string buf (class_chain_of_class_string class_string)
        | None ->
          on_unresolved longident;
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
