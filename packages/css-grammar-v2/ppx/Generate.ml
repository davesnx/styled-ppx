open Ppxlib
module Spec_parser = Css_spec_parser

let loc = Location.none
let txt x = { Location.loc; txt = x }

let kebab_to_snake name =
  let name =
    if String.length name > 0 && name.[0] = '-' then
      String.sub name 1 (String.length name - 1)
    else name
  in
  name |> String.split_on_char '-' |> String.concat "_"

let first_upper name =
  if String.length name = 0 then ""
  else
    String.uppercase_ascii (String.sub name 0 1)
    ^ String.sub name 1 (String.length name - 1)

let kebab_to_pascal name =
  name
  |> String.split_on_char '-'
  |> List.filter (fun s -> String.length s > 0)
  |> List.map first_upper
  |> String.concat ""

let is_function str =
  let len = String.length str in
  len >= 2 && String.sub str (len - 2) 2 = "()"

let value_name_of_css str =
  let str =
    if is_function str then
      "function_" ^ String.sub str 0 (String.length str - 2)
    else str
  in
  kebab_to_snake str

(** Convert CSS keyword to OCaml identifier, handling special characters.
    "font-size" → "font_size" "@media" → "at_media" "+" → "cross" *)
let keyword_to_ocaml str =
  let str =
    if String.length str > 0 && str.[0] = '@' then
      "at_" ^ String.sub str 1 (String.length str - 1)
    else str
  in
  match str with
  | "%" -> "percent"
  | ">" -> "biggerthan"
  | ">=" -> "biggerthan_equal"
  | "<" -> "lessthan"
  | "<=" -> "lessthan_equal"
  | "+" -> "cross"
  | "~" -> "tilde"
  | "||" -> "doublevbar"
  | "|" -> "vbar"
  | "=" -> "equal"
  | "#" -> "hash"
  | "!" -> "bang"
  | _ -> kebab_to_snake str

(** Convert delimiter character to readable name for variant generation. *)
let value_of_delimiter = function
  | "+" -> "cross"
  | "-" -> "dash"
  | "*" -> "asterisk"
  | "/" -> "bar"
  | "@" -> "at"
  | "," -> "comma"
  | ";" -> ""
  | ":" -> "doubledot"
  | "." -> "dot"
  | "(" -> "openparen"
  | ")" -> "closeparen"
  | "[" -> "openbracket"
  | "]" -> "closebracket"
  | "{" -> "opencurly"
  | "}" -> "closecurly"
  | "^" -> "caret"
  | "<" -> "lessthan"
  | "=" -> "equal"
  | ">" -> "biggerthan"
  | "|" -> "vbar"
  | "||" -> "doublevbar"
  | "~" -> "tilde"
  | "$" -> "dollar"
  | _ -> "unknown"

(** Derive a variant name from a spec node. Used for xor branches: <length> |
    'auto' → `Length | `Auto *)
let rec variant_name = function
  | Spec_parser.Terminal (Delim name, _) -> value_of_delimiter name
  | Terminal (Keyword name, _) -> keyword_to_ocaml name
  | Terminal (Data_type name, _) -> value_name_of_css name
  | Terminal (Property_type name, _) -> "property_" ^ value_name_of_css name
  | Group (value, _) -> variant_name value
  | Combinator (Static, _) -> "static"
  | Combinator (And, _) -> "and"
  | Combinator (Or, _) -> "or"
  | Combinator (Xor, _) -> "xor"
  | Function_call (name, _) -> value_name_of_css name

let variant_name_upper v = first_upper (variant_name v)

(** Generate unique variant names for a list of values. If duplicates exist,
    append indices: Length, Length_0, Length_1 *)
let variant_names values =
  let names = List.map variant_name_upper values in
  let occurrences name = List.length (List.filter (( = ) name) names) in
  let _, result =
    List.fold_left
      (fun (seen, acc) name ->
        let total = occurrences name in
        let count_in_seen = List.length (List.filter (( = ) name) seen) in
        let final_name =
          if total = 1 then name else name ^ "_" ^ string_of_int count_in_seen
        in
        name :: seen, final_name :: acc)
      ([], []) names
  in
  List.rev result

type type_info = {
  has_interpolation_variant : bool;
    (** Whether this type can contain `Interpolation variant *)
  is_primitive : bool;  (** Whether this is a primitive type like string *)
}

(** Registry of standard CSS types known to the PPX. These map to Standard.*
    rules in the runtime. *)
let standard_types =
  [
    "length", { has_interpolation_variant = true; is_primitive = false };
    "angle", { has_interpolation_variant = true; is_primitive = false };
    "time", { has_interpolation_variant = true; is_primitive = false };
    "frequency", { has_interpolation_variant = true; is_primitive = false };
    "resolution", { has_interpolation_variant = true; is_primitive = false };
    "percentage", { has_interpolation_variant = true; is_primitive = false };
    "number", { has_interpolation_variant = true; is_primitive = false };
    "integer", { has_interpolation_variant = true; is_primitive = false };
    "flex-value", { has_interpolation_variant = true; is_primitive = false };
    ( "length-percentage",
      { has_interpolation_variant = true; is_primitive = false } );
    ( "css-wide-keywords",
      { has_interpolation_variant = false; is_primitive = false } );
    "ident", { has_interpolation_variant = false; is_primitive = true };
    "custom-ident", { has_interpolation_variant = false; is_primitive = true };
    "dashed-ident", { has_interpolation_variant = false; is_primitive = true };
    "string", { has_interpolation_variant = false; is_primitive = true };
    "string-token", { has_interpolation_variant = false; is_primitive = true };
    "hex-color", { has_interpolation_variant = false; is_primitive = true };
    "url", { has_interpolation_variant = false; is_primitive = true };
  ]

let is_standard_type name = List.mem_assoc name standard_types

let type_has_interpolation_variant name =
  match List.assoc_opt name standard_types with
  | Some info -> info.has_interpolation_variant
  | None -> false

(** Map CSS type name to runtime module name in Css_types. *)
let css_type_to_module_name name =
  match name with
  | "length" -> Some "Length"
  | "angle" -> Some "Angle"
  | "time" -> Some "Time"
  | "frequency" -> Some "Frequency"
  | "resolution" -> Some "Resolution"
  | "percentage" -> Some "Percentage"
  | "number" -> Some "Number"
  | "integer" -> Some "Integer"
  | "flex-value" -> Some "FlexValue"
  | "length-percentage" -> Some "LengthPercentage"
  | "hex-color" -> Some "Color"
  | "css-wide-keywords" -> Some "Cascading"
  | _ -> None

let runtime_module_path_for_type name =
  match css_type_to_module_name name with
  | Some mod_name -> Some ("Css_types." ^ mod_name)
  | None -> None

module Make (Builder : Ast_builder.S) = struct
  open Builder

  let evar name = pexp_ident (Located.lident name)
  let pvar name = ppat_var (Located.mk name)

  let make_module_path_expr (css_type_name : string) : expression =
    match css_type_to_module_name css_type_name with
    | Some mod_name ->
      let lid = Longident.Ldot (Longident.Lident "Css_types", mod_name) in
      let construct_expr = pexp_construct (Located.mk lid) None in
      pexp_extension
        (Located.mk "module_path", PStr [ pstr_eval construct_expr [] ])
    | None -> estring ""

  let make_type_path_expr (path : string) : expression =
    if String.length path > 10 && String.sub path 0 10 = "Css_types." then (
      let mod_name = String.sub path 10 (String.length path - 10) in
      let lid = Longident.Ldot (Longident.Lident "Css_types", mod_name) in
      let construct_expr = pexp_construct (Located.mk lid) None in
      pexp_extension
        (Located.mk "module_path", PStr [ pstr_eval construct_expr [] ]))
    else estring path

  (** Apply repetition/optionality modifiers to a rule expression.

      Transforms: rule + Optional → Modifier.optional rule rule + Zero_or_more →
      Modifier.zero_or_more rule rule + Repeat(2,4) → Modifier.repeat (2, Some
      4) rule *)
  let apply_modifier modifier rule_expr =
    match modifier with
    | Spec_parser.One -> rule_expr
    | Optional -> [%expr Modifier.optional [%e rule_expr]]
    | Zero_or_more -> [%expr Modifier.zero_or_more [%e rule_expr]]
    | One_or_more -> [%expr Modifier.one_or_more [%e rule_expr]]
    | At_least_one -> [%expr Modifier.at_least_one [%e rule_expr]]
    | Repeat (min, max) ->
      let max_expr =
        match max with
        | Some m -> [%expr Some [%e eint m]]
        | None -> [%expr None]
      in
      [%expr Modifier.repeat ([%e eint min], [%e max_expr]) [%e rule_expr]]
    | Repeat_by_comma (min, max) ->
      let max_expr =
        match max with
        | Some m -> [%expr Some [%e eint m]]
        | None -> [%expr None]
      in
      [%expr
        Modifier.repeat_by_comma ([%e eint min], [%e max_expr]) [%e rule_expr]]

  (** Generate a sequential (positional) combinator rule from multiple values.

      Used for both Static (space-separated) and Or (||) combinators. We treat
      || as positional because we need fixed positions for interpolation type
      inference.

      Input: [<length>, <percentage>] Output: Rule.Match.bind Standard.length
      (fun v0 -> Rule.Match.bind Standard.percentage (fun v1 ->
      Rule.Match.return (v0, v1))) *)
  let generate_sequential_rule generate_rule values =
    let n = List.length values in
    if n = 0 then [%expr Rule.Match.return ()]
    else if n = 1 then generate_rule (List.hd values)
    else (
      let rules_with_idx = List.mapi (fun i v -> i, generate_rule v) values in
      let var_name i = "v" ^ string_of_int i in
      let final_tuple =
        pexp_tuple (List.mapi (fun i _ -> evar (var_name i)) values)
      in
      List.fold_right
        (fun (i, rule_expr) acc ->
          [%expr
            Rule.Match.bind [%e rule_expr] (fun [%p pvar (var_name i)] ->
              [%e acc])])
        rules_with_idx
        [%expr Rule.Match.return [%e final_tuple]])

  (** Main rule generation entry point. Transforms spec AST nodes into Rule.rule
      expressions. *)
  let rec generate_rule (spec : Spec_parser.value) : expression =
    match spec with
    | Terminal (kind, modifier) -> generate_terminal kind modifier
    | Combinator (kind, values) -> generate_combinator kind values
    | Function_call (name, inner) -> generate_function_call name inner
    | Group (value, modifier) ->
      let inner_rule = generate_rule value in
      apply_modifier modifier inner_rule

  (** Generate rule for terminal tokens (keywords, delimiters, data types).

      'auto' → Rule.Pattern.value () (Standard.keyword "auto") <length> →
      Standard.length <my-type> → my_type.Spec.rule (for non-standard types) *)
  and generate_terminal kind modifier =
    let rule_expr =
      match kind with
      | Keyword kw ->
        [%expr Rule.Pattern.value () (Standard.keyword [%e estring kw])]
      | Delim d -> [%expr Rule.Pattern.value () (Standard.delim [%e estring d])]
      | Data_type name ->
        let snake_name = value_name_of_css name in
        if is_standard_type name then
          pexp_ident (Located.lident ("Standard." ^ snake_name))
        else
          (* Non-standard types reference user-defined Spec.t values *)
          [%expr [%e pexp_ident (Located.lident snake_name)].Spec.rule]
      | Property_type name ->
        let snake_name = "property_" ^ value_name_of_css name in
        [%expr [%e pexp_ident (Located.lident snake_name)].rule]
    in
    apply_modifier modifier rule_expr

  (** Generate rule for combinator nodes (|, ||, &&, space-separated).

      Xor (|): Mutually exclusive alternatives <length> | 'auto' →
      Combinators.xor
      [ Rule.Match.map length (fun v -> `Length v); Rule.Match.map (keyword
       "auto") (fun () -> `Auto) ]

      Static (space): Sequential parsing into tuple <length> <percentage> → bind
      length (fun v0 -> bind percentage (fun v1 -> return (v0, v1)))

      Or (||): Treated same as Static for type inference CSS says "any order"
      but we need positions for interpolation types *)
  and generate_combinator kind values =
    match kind with
    | Xor ->
      let names = variant_names values in
      let pairs = List.combine names values in
      let branches =
        List.map
          (fun (name, value) ->
            let inner_rule = generate_rule value in
            match value with
            | Terminal (Keyword _, _) | Terminal (Delim _, _) ->
              (* Keywords produce unit, wrap in variant with no payload *)
              [%expr
                Rule.Match.map [%e inner_rule] (fun () ->
                  [%e pexp_variant name None])]
            | _ ->
              (* Data types produce values, wrap in variant with payload *)
              [%expr
                Rule.Match.map [%e inner_rule] (fun v ->
                  [%e pexp_variant name (Some (evar "v"))])])
          pairs
      in
      [%expr Combinators.xor [%e elist branches]]
    | Static ->
      (* Space-separated sequence: <a> <b> <c> → tuple (a, b, c) *)
      generate_sequential_rule generate_rule values
    | And ->
      (* && combinator: all must match in any order *)
      let rules = List.map generate_rule values in
      [%expr Combinators.and_ [%e elist rules]]
    | Or ->
      (* || combinator: treated as positional for interpolation type inference.
         CSS spec says || means "any order, each at most once", but we can't
         infer types for $(var) without fixed positions. *)
      generate_sequential_rule generate_rule values

  (** Generate rule for CSS function calls.

      rgb(<args>) → Standard.function_call "rgb" <inner_rule> *)
  and generate_function_call name inner =
    let inner_rule = generate_rule inner in
    [%expr Standard.function_call [%e estring name] [%e inner_rule]]

  (** Check if a spec can contain interpolation values. Used to determine
      whether to generate extraction code. *)
  let rec spec_contains_interpolation (spec : Spec_parser.value) =
    match spec with
    | Terminal (Data_type name, _) -> type_has_interpolation_variant name
    | Terminal _ -> false
    | Group (inner, _) -> spec_contains_interpolation inner
    | Combinator (_, values) -> List.exists spec_contains_interpolation values
    | Function_call (_, inner) -> spec_contains_interpolation inner

  (** Get runtime type path from a spec node for interpolation tagging. *)
  let get_type_name_from_spec (spec : Spec_parser.value) =
    match spec with
    | Terminal (Data_type name, _) when is_standard_type name ->
      runtime_module_path_for_type name
    | _ -> None

  (** Generate extraction logic for sequential/positional combinators.

      Used for both Static, And, and Or (||) combinators.

      Input tuple: (length_val, percentage_val)
      Output: extract from each position, concatenate results

      let (v0, _) = value in  (* only bind positions with interpolation *)
      extract_from_v0 @ []
  *)
  let gen_extract_from_positional gen_extract spec_contains_interpolation
    get_type_name_from_spec make_type_path_expr type_context values var_expr =
    let n = List.length values in
    if n = 0 then [%expr []]
    else if n = 1 then (
      let inner_spec = List.hd values in
      if spec_contains_interpolation inner_spec then (
        let pos_type =
          match get_type_name_from_spec inner_spec with
          | Some t -> make_type_path_expr t
          | None -> type_context
        in
        gen_extract inner_spec var_expr pos_type)
      else [%expr []])
    else (
      (* Multiple values: destructure tuple and extract from each *)
      let extractions =
        List.mapi
          (fun i inner_spec ->
            if spec_contains_interpolation inner_spec then (
              let var_name = "v" ^ string_of_int i in
              let pos_type =
                match get_type_name_from_spec inner_spec with
                | Some t -> make_type_path_expr t
                | None -> type_context
              in
              gen_extract inner_spec (evar var_name) pos_type)
            else [%expr []])
          values
      in
      let combined =
        List.fold_right
          (fun extract acc -> [%expr [%e extract] @ [%e acc]])
          extractions [%expr []]
      in
      (* Pattern: only bind variables for positions that have interpolation *)
      let tuple_pat =
        ppat_tuple
          (List.mapi
             (fun i inner_spec ->
               if spec_contains_interpolation inner_spec then
                 pvar ("v" ^ string_of_int i)
               else ppat_any)
             values)
      in
      pexp_let Nonrecursive
        [ value_binding ~pat:tuple_pat ~expr:var_expr ]
        combined)

  (** Generate the extract_interpolations function for a spec.

      This function traverses parsed values and collects (variable_name,
      type_path) pairs for all interpolations.

      Interpolation is handled within standard types (e.g. Standard.length
      includes an `Interpolation variant), so specs don't need explicit
      <interpolation>. *)
  let generate_extract_interpolations (spec : Spec_parser.value)
    ~(runtime_module_path : string option) : expression =
    let default_type_path =
      match runtime_module_path with
      | Some p -> make_type_path_expr p
      | None -> estring ""
    in

    let rec gen_extract (spec : Spec_parser.value) (var_expr : expression)
      (type_context : expression) : expression =
      match spec with
      (* Standard types with interpolation variant *)
      | Terminal (Data_type name, modifier) when is_standard_type name ->
        if type_has_interpolation_variant name then (
          let type_path =
            match runtime_module_path_for_type name with
            | Some p -> make_type_path_expr p
            | None -> type_context
          in
          match modifier with
          | One ->
            [%expr
              match [%e var_expr] with
              | `Interpolation parts ->
                [ String.concat "." parts, [%e type_path] ]
              | _ -> []]
          | Optional ->
            [%expr
              match [%e var_expr] with
              | None -> []
              | Some (`Interpolation parts) ->
                [ String.concat "." parts, [%e type_path] ]
              | Some _ -> []]
          | _ ->
            [%expr
              List.concat_map
                (function
                  | `Interpolation parts ->
                    [ String.concat "." parts, [%e type_path] ]
                  | _ -> [])
                [%e var_expr]])
        else [%expr []]
      (* Non-interpolation terminals *)
      | Terminal _ -> [%expr []]
      (* Groups: unwrap according to modifier *)
      | Group (inner, modifier) ->
        (match modifier with
        | One -> gen_extract inner var_expr type_context
        | Optional ->
          [%expr
            match [%e var_expr] with
            | None -> []
            | Some v -> [%e gen_extract inner (evar "v") type_context]]
        | _ ->
          [%expr
            List.concat
              (List.map
                 (fun v -> [%e gen_extract inner (evar "v") type_context])
                 [%e var_expr])])
      (* Xor: match on variant and extract from the matched branch *)
      | Combinator (Xor, values) ->
        let names = variant_names values in
        let pairs = List.combine names values in
        (* Find type context from sibling branches *)
        let sibling_type = List.find_map get_type_name_from_spec values in
        let effective_context =
          match sibling_type with
          | Some t -> make_type_path_expr t
          | None -> type_context
        in
        let cases =
          List.map
            (fun (name, inner_spec) ->
              let has_content =
                match inner_spec with
                | Spec_parser.Terminal (Keyword _, _)
                | Spec_parser.Terminal (Delim _, _) ->
                  false
                | _ -> true
              in
              if has_content && spec_contains_interpolation inner_spec then
                case
                  ~lhs:(ppat_variant name (Some (pvar "inner")))
                  ~guard:None
                  ~rhs:(gen_extract inner_spec (evar "inner") effective_context)
              else
                case
                  ~lhs:
                    (ppat_variant name
                       (if has_content then Some ppat_any else None))
                  ~guard:None ~rhs:[%expr []])
            pairs
        in
        pexp_match var_expr cases
      (* Static and And: extract from tuple positions *)
      | Combinator ((Static | And), values) ->
        gen_extract_from_positional gen_extract spec_contains_interpolation
          get_type_name_from_spec make_type_path_expr type_context values
          var_expr
      (* Or (||): treated same as Static for extraction *)
      | Combinator (Or, values) ->
        gen_extract_from_positional gen_extract spec_contains_interpolation
          get_type_name_from_spec make_type_path_expr type_context values
          var_expr
      (* Function calls: extract from inner content *)
      | Function_call (_, inner) -> gen_extract inner var_expr type_context
    in

    let has_interpolation = spec_contains_interpolation spec in
    let body =
      if has_interpolation then
        gen_extract spec (evar "value") default_type_path
      else [%expr []]
    in
    (* Use _ parameter if no interpolation to avoid unused variable warning *)
    let param_pat = if has_interpolation then pvar "value" else ppat_any in
    pexp_fun Nolabel None param_pat body

  (** Generate the complete Spec.t record expression.

      { Spec.rule = <rule>;
        extract_interpolations = <extraction_fn>;
        runtime_module_path = <path_option>;
      }
  *)
  let generate_spec_record ~(spec : Spec_parser.value)
    ~(runtime_module_path : string option) : expression =
    let rule_expr = generate_rule spec in
    let extract_expr =
      generate_extract_interpolations spec ~runtime_module_path
    in
    let runtime_path_expr =
      match runtime_module_path with
      | Some p -> [%expr Some [%e make_type_path_expr p]]
      | None -> [%expr None]
    in
    [%expr
      {
        Spec.rule = [%e rule_expr];
        extract_interpolations = [%e extract_expr];
        runtime_module_path = [%e runtime_path_expr];
      }]

  (** Map CSS type name to OCaml type path for type generation. "length" →
      "Standard.length" *)
  let css_type_to_ocaml_type name =
    match name with
    | "length" -> Some "Standard.length"
    | "angle" -> Some "Standard.angle"
    | "time" -> Some "Standard.time"
    | "frequency" -> Some "Standard.frequency"
    | "resolution" -> Some "Standard.resolution"
    | "percentage" -> Some "Standard.percentage"
    | "number" -> Some "Standard.number"
    | "integer" -> Some "Standard.integer"
    | "flex-value" -> Some "Standard.flex_value"
    | "length-percentage" -> Some "Standard.length_percentage"
    | "css-wide-keywords" -> Some "Standard.css_wide_keywords"
    | "ident" | "custom-ident" | "dashed-ident" | "string" | "string-token" ->
      Some "string"
    | "hex-color" -> Some "string"
    | "url" -> Some "string"
    | _ -> None

  (** Convert dotted path string to Longident: "A.B.C" → Ldot(Ldot(A, B), C) *)
  let make_type_lid path =
    let parts = String.split_on_char '.' path in
    match parts with
    | [] -> failwith "empty type path"
    | [ single ] -> Longident.Lident single
    | first :: rest ->
      List.fold_left
        (fun acc part -> Longident.Ldot (acc, part))
        (Longident.Lident first) rest

  (** Generate OCaml type from spec AST.

      Main entry point for [%spec_t] extension. *)
  let rec generate_type (spec : Spec_parser.value) : core_type =
    match spec with
    | Terminal (Data_type name, modifier) ->
      generate_data_type_type name modifier
    | Terminal (Keyword _, modifier) -> generate_keyword_type modifier
    | Terminal (Delim _, modifier) -> generate_keyword_type modifier
    | Terminal (Property_type _, _) -> ptyp_any
    | Group (inner, modifier) ->
      apply_type_modifier modifier (generate_type inner)
    | Combinator (Xor, values) -> generate_xor_type values
    | Combinator (Static, values) -> generate_tuple_type values
    | Combinator (And, values) -> generate_tuple_type values
    | Combinator (Or, values) -> generate_tuple_type values (* Same as Static *)
    | Function_call (_, inner) -> generate_type inner

  (** Generate type for data type reference: <length> → Standard.length *)
  and generate_data_type_type name modifier =
    let base_type =
      match css_type_to_ocaml_type name with
      | Some path ->
        let lid = make_type_lid path in
        ptyp_constr (Located.mk lid) []
      | None ->
        (* Non-standard type: reference by snake_case name *)
        let lid = make_type_lid (value_name_of_css name) in
        ptyp_constr (Located.mk lid) []
    in
    apply_type_modifier modifier base_type

  (** Generate type for keywords/delimiters: 'auto' → unit *)
  and generate_keyword_type modifier =
    apply_type_modifier modifier (ptyp_constr (Located.lident "unit") [])

  (** Apply type modifier: ? → option, * + # → list *)
  and apply_type_modifier modifier base_type =
    match modifier with
    | Spec_parser.One -> base_type
    | Optional -> ptyp_constr (Located.lident "option") [ base_type ]
    | Zero_or_more | One_or_more | Repeat _ | Repeat_by_comma _ ->
      ptyp_constr (Located.lident "list") [ base_type ]
    | At_least_one -> base_type

  (** Generate polymorphic variant type for xor. <length> | 'auto' →
      [ `Length of Standard.length | `Auto ] *)
  and generate_xor_type values =
    let names = variant_names values in
    let pairs = List.combine names values in
    let row_fields =
      List.map
        (fun (name, value) ->
          match value with
          | Spec_parser.Terminal (Keyword _, _)
          | Spec_parser.Terminal (Delim _, _) ->
            (* Keywords have no payload *)
            {
              prf_desc = Rtag (Located.mk name, true, []);
              prf_loc = loc;
              prf_attributes = [];
            }
          | _ ->
            (* Data types have payload *)
            let inner_type = generate_inner_type value in
            {
              prf_desc = Rtag (Located.mk name, false, [ inner_type ]);
              prf_loc = loc;
              prf_attributes = [];
            })
        pairs
    in
    ptyp_variant row_fields Closed None

  (** Generate inner type for xor branches (handles groups specially). *)
  and generate_inner_type (spec : Spec_parser.value) : core_type =
    match spec with
    | Terminal (Data_type name, modifier) ->
      let base =
        match css_type_to_ocaml_type name with
        | Some path ->
          let lid = make_type_lid path in
          ptyp_constr (Located.mk lid) []
        | None ->
          let lid = make_type_lid (value_name_of_css name) in
          ptyp_constr (Located.mk lid) []
      in
      apply_type_modifier modifier base
    | Group (inner, modifier) ->
      apply_type_modifier modifier (generate_type inner)
    | _ -> generate_type spec

  (** Generate tuple type for sequential combinators. <length> <percentage> →
      Standard.length * Standard.percentage *)
  and generate_tuple_type values =
    match values with
    | [] -> ptyp_constr (Located.lident "unit") []
    | [ single ] -> generate_type single
    | _ ->
      let types = List.map generate_type values in
      ptyp_tuple types
end
