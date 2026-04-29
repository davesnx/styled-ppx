(** styled-ppx aggregator: walk every post-PPX [.ml] file in a dune library,
    collect [\[\@\@\@css ...\]] CSS rules and any cross-module references
    embedded as NUL-delimited sentinels, resolve those sentinels against
    a global index of [%cx2] bindings, and emit the final stylesheet.

    The aggregator runs once per `dune build` invocation, after the PPX
    has produced the post-PPX [.ml] files for every module in the library.

    Two-pass design:

    Pass 1 — Collect every [\[\@\@\@css.bindings ...\]] attribute payload
    into a global index mapping [longident -> class_string]. The PPX itself
    populates these payloads with the fully-qualified longident
    ([\["M.Css.marker"\]]) and the space-separated class names it minted,
    so the aggregator only has to read them — it does not re-derive module
    names from filenames or pattern-match [CSS.make] calls.

    Pass 2 — For each rule string in [\[\@\@\@css ...\]], scan for
    NUL-delimited sentinels [\x00LONGIDENT\x00]. Look the longident up
    in the index and substitute its class chain (multi-class bindings
    produce a dot-chain like [cssA.cssB], a valid CSS compound selector).
    Resolution failures emit a hard error pointing at the original
    [.re]/[.ml] source via the location descriptors in
    [\[\@\@\@css.refs ...\]] attributes.

    See [documents/cross-module-selector-interpolation.md]. *)

(** [\x00] is the only byte we use as a sentinel delimiter. It cannot
    appear in valid CSS, in user [%cx2] source, or in OCaml string
    literals as plain text, so collisions are impossible by construction. *)
let sentinel_byte = '\x00'

(** Decode an OCaml expression that's a string literal back to its value.
    Used to read string fields out of the various [\[\@\@\@css.* ...\]]
    attribute payloads. *)
let string_of_const_expr (e : Ppxlib.expression) : string option =
  match e.pexp_desc with
  | Pexp_constant (Pconst_string (s, _, _)) -> Some s
  | _ -> None

(** Decode an OCaml expression that's an int literal back to its value.
    Used to read line/column fields out of [\[\@\@\@css.refs ...\]]
    payloads. *)
let int_of_const_expr (e : Ppxlib.expression) : int option =
  match e.pexp_desc with
  | Pexp_constant (Pconst_integer (s, _)) -> Some (int_of_string s)
  | _ -> None

(** Walk a list expression like [\[a; b; c\]] and decode each element
    via [decode]. Decoded entries are returned in source order; elements
    that fail to decode are silently skipped (they shouldn't exist in
    well-formed PPX output). *)
let decode_list ~decode (e : Ppxlib.expression) =
  let rec loop (e : Ppxlib.expression) acc =
    match e.pexp_desc with
    | Pexp_construct ({ txt = Lident "[]"; _ }, None) -> List.rev acc
    | Pexp_construct
        ( { txt = Lident "::"; _ },
          Some { pexp_desc = Pexp_tuple [ hd; tl ]; _ } ) ->
      (match decode hd with
      | Some v -> loop tl (v :: acc)
      | None -> loop tl acc)
    | _ -> List.rev acc
  in
  loop e []

(** Root module segment of a dotted longident.
    [["M.Css.marker"]] -> [["M"]]; [["foo"]] -> [["foo"]]. *)
let longident_head longident =
  match String.split_on_char '.' longident with
  | head :: _ -> head
  | [] -> longident

(** Global index of [%cx2] bindings, populated from [\[\@\@\@css.bindings ...\]]
    attribute payloads. Keyed by the dotted longident exactly as users
    write it in their [%cx2] selector refs (e.g. [["M.Css.marker"]]) so
    resolution is a direct [Hashtbl.find_opt]. *)
module Index = struct
  type t = (string, string) Hashtbl.t

  let create () : t = Hashtbl.create 64

  (** Decode a single [(longident, class_string)] tuple. *)
  let decode_binding (e : Ppxlib.expression) : (string * string) option =
    match e.pexp_desc with
    | Pexp_tuple [ longident_e; class_e ] ->
      (match string_of_const_expr longident_e, string_of_const_expr class_e with
      | Some longident, Some class_string -> Some (longident, class_string)
      | _ -> None)
    | _ -> None

  let add_from_payload (idx : t) payload =
    decode_list ~decode:decode_binding payload
    |> List.iter (fun (longident, class_string) ->
        Hashtbl.replace idx longident class_string)
end

(** Every [\[\@\@\@css.refs \[(longident, file, start_line, start_col, end_col); ...\]\]]
    attribute decoded into a list of records. The aggregator uses these
    locations when reporting unresolvable refs. *)
module Refs = struct
  type ref_loc = {
    longident : string;
    file : string;
    start_line : int;
    start_col : int;
    end_col : int;
  }

  (** Decode a single tuple expression like
      [("M.Css.marker", "n.re", 5, 6, 18)] into a [ref_loc]. *)
  let decode_ref (e : Ppxlib.expression) : ref_loc option =
    match e.pexp_desc with
    | Pexp_tuple [ longident_e; file_e; sl_e; sc_e; ec_e ] ->
      (match
         ( string_of_const_expr longident_e,
           string_of_const_expr file_e,
           int_of_const_expr sl_e,
           int_of_const_expr sc_e,
           int_of_const_expr ec_e )
       with
      | Some longident, Some file, Some sl, Some sc, Some ec ->
        Some { longident; file; start_line = sl; start_col = sc; end_col = ec }
      | _ -> None)
    | _ -> None

  let of_list_expr = decode_list ~decode:decode_ref
end

(** Per-file harvest: rules with potential sentinels, plus all
    cross-module ref descriptors seen in this file. The bindings attribute
    is consumed directly into the global [Index] during the same walk. *)
type harvest = {
  filename : string;
  rules : string list;
  refs : Refs.ref_loc list;
}

let harvest_structure ~filename ~idx structure : harvest =
  let rules = ref [] in
  let refs = ref [] in
  List.iter
    (fun item ->
      match item with
      | [%stri [@@@css [%e? value]]] ->
        (match string_of_const_expr value with
        | Some v -> rules := v :: !rules
        | None -> ())
      | [%stri [@@@css.refs [%e? value]]] ->
        refs := Refs.of_list_expr value @ !refs
      | [%stri [@@@css.bindings [%e? value]]] ->
        Index.add_from_payload idx value
      | _ -> ())
    structure;
  { filename; rules = List.rev !rules; refs = List.rev !refs }

(** Read a post-PPX [.ml] file or its serialized [.pp.ml] AST into a ppxlib
    structure. File-read and parse errors are surfaced unconditionally
    (not gated on [~verbose]) so a mistyped path produces a clear
    aggregator-level diagnostic instead of silent empty output. *)
let read_structure filename : Ppxlib.structure option =
  try
    if String.ends_with filename ~suffix:".pp.ml" then
      match Ppxlib.Ast_io.read_binary filename with
      | Error msg ->
        Printf.eprintf "styled-ppx aggregator: cannot read %s: %s\n"
          filename msg;
        None
      | Ok t ->
        (match Ppxlib.Ast_io.get_ast t with
        | Impl s -> Some s
        | Intf _ -> None)
    else if String.ends_with filename ~suffix:".ml" then
      let ic = open_in filename in
      let len = in_channel_length ic in
      let content = really_input_string ic len in
      close_in ic;
      let lexbuf = Lexing.from_string content in
      lexbuf.lex_curr_p <- { lexbuf.lex_curr_p with pos_fname = filename };
      Some (Ppxlib.Parse.implementation lexbuf)
    else
      failwith ("Expected .ml or .pp.ml file, got: " ^ filename)
  with
  | Sys_error msg ->
    Printf.eprintf "styled-ppx aggregator: cannot read %s: %s\n"
      filename msg;
    None
  | exn ->
    Printf.eprintf "styled-ppx aggregator: cannot parse %s: %s\n"
      filename (Printexc.to_string exn);
    None

(** Resolve every [\x00LONGIDENT\x00] sentinel in [rule] against [idx].
    Multi-class bindings yield space-separated class strings — we convert
    those to dot-chains, since sentinels appear inside CSS selectors where
    the chain form is required.

    On unresolved longident, calls [on_error] with the offending longident.
    [on_error] decides whether to raise or accumulate; we use a callback
    so the caller can collect all errors before bailing. *)
let resolve_sentinels ~idx ~on_error (rule : string) : string =
  let buf = Buffer.create (String.length rule) in
  let len = String.length rule in
  let i = ref 0 in
  while !i < len do
    let c = rule.[!i] in
    if c = sentinel_byte then begin
      (* Find the closing sentinel byte. *)
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
        (* Unterminated sentinel — preserve as-is. Should never happen
           for well-formed PPX output. *)
        Buffer.add_char buf c;
        incr i
      | Some j ->
        let longident = String.sub rule start (j - start) in
        (match Hashtbl.find_opt idx longident with
        | Some class_string ->
          (* "css-A css-B" → "css-A.css-B" so it slots into selector chains. *)
          let chain =
            String.split_on_char ' ' class_string
            |> List.filter (fun s -> s <> "")
            |> String.concat "."
          in
          Buffer.add_string buf chain
        | None ->
          on_error longident;
          (* Preserve the sentinel literally so the final CSS is
             obviously broken if errors are non-fatal. *)
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

(** Format an aggregator error in the OCaml [File "..."] convention so editors
    pick it up the same way they pick up compiler errors. *)
let format_location (r : Refs.ref_loc) : string =
  Printf.sprintf "File %S, line %d, characters %d-%d:" r.file r.start_line
    r.start_col r.end_col

(** Detect cross-library references: a longident whose root module isn't
    the prefix of any [%cx2] binding the aggregator indexed. The aggregator
    only sees files from the current library invocation, so any longident
    whose root segment doesn't appear in the index must point outside it. *)
let is_cross_library ~idx longident =
  match String.split_on_char '.' longident with
  | [] | [ _ ] -> false (* No dot — single-segment, can't be cross-anything. *)
  | _ ->
    let head = longident_head longident in
    not
      (Hashtbl.fold
         (fun key _ acc -> acc || longident_head key = head)
         idx false)

let cross_library_message ~longident ~head ~ref_loc =
  Printf.sprintf
    "%s\n\
     Error: cross-library [%%cx2] selector references are not supported.\n\
     The reference `%s` resolves to module `%s` which is not part of the\n\
     current library. Move the [%%cx2] binding into the current library, or\n\
     inline the class chain literally."
    (format_location ref_loc) longident head

let unresolved_message ~longident ~ref_loc ~idx =
  let head = longident_head longident in
  if is_cross_library ~idx longident then
    cross_library_message ~longident ~head ~ref_loc
  else
    Printf.sprintf
      "%s\n\
       Error: cross-module [%%cx2] selector reference `%s` does not resolve.\n\
       The target binding is missing from module `%s`, or the binding is not\n\
       a [%%cx2] expression. Define `%s` with [%%cx2 \"...\"], or remove the\n\
       reference."
      (format_location ref_loc) longident head longident

(** Collect, index, resolve, dedup, output. *)
let run ~verbose ~minify ~output_file input_files =
  if verbose then Printf.eprintf "Input files: %d\n" (List.length input_files);
  let idx = Index.create () in
  let harvests =
    List.filter_map
      (fun filename ->
        if String.ends_with filename ~suffix:".css" then
          failwith "Extracting from .css files is not supported yet";
        match read_structure filename with
        | None -> None
        | Some structure -> Some (harvest_structure ~filename ~idx structure))
      input_files
  in

  (* Resolve all rules across all harvests, collecting errors with locations. *)
  let errors = ref [] in
  let resolved_rules = ref [] in
  List.iter
    (fun harvest ->
      List.iter
        (fun rule ->
          let on_error longident =
            let ref_loc =
              match
                List.find_opt
                  (fun (r : Refs.ref_loc) -> r.longident = longident)
                  harvest.refs
              with
              | Some r -> r
              | None ->
                {
                  Refs.longident;
                  file = harvest.filename;
                  start_line = 1;
                  start_col = 0;
                  end_col = 0;
                }
            in
            let msg = unresolved_message ~longident ~ref_loc ~idx in
            errors := msg :: !errors
          in
          let resolved = resolve_sentinels ~idx ~on_error rule in
          resolved_rules := resolved :: !resolved_rules)
        harvest.rules)
    harvests;

  (match !errors with
  | [] -> ()
  | _ ->
    List.iter prerr_endline (List.rev !errors);
    exit 1);

  (* Dedup the resolved CSS rules. *)
  let module Rule_set = Set.Make (String) in
  let rule_set =
    List.fold_left (fun s r -> Rule_set.add r s) Rule_set.empty !resolved_rules
  in

  let out_channel =
    match output_file with Some file -> open_out file | None -> Stdlib.stdout
  in
  let separator = if minify then "" else "\n" in
  output_string out_channel
    "/* This file is generated by styled-ppx, do not edit manually */\n";
  Rule_set.iter
    (fun rule ->
      output_string out_channel rule;
      output_string out_channel separator)
    rule_set;
  match output_file with Some _ -> close_out out_channel | None -> ()

let parse_args args =
  let rec parse acc ~output_file ~verbose ~minify = function
    | "-o" :: file :: rest
    | "-output" :: file :: rest
    | "--output" :: file :: rest ->
      parse acc ~output_file:(Some file) ~verbose ~minify rest
    | "-v" :: rest | "-verbose" :: rest | "--verbose" :: rest ->
      parse acc ~output_file ~verbose:true ~minify rest
    | "--minify" :: rest -> parse acc ~output_file ~verbose ~minify:true rest
    | arg :: rest -> parse (arg :: acc) ~output_file ~verbose ~minify rest
    | [] -> List.rev acc, output_file, verbose, minify
  in
  let tail = match Array.to_list args with [] -> [] | _ :: t -> t in
  parse [] ~output_file:None ~verbose:false ~minify:false tail

let () =
  let input_files, output_file, verbose, minify = parse_args Sys.argv in
  run ~verbose ~minify ~output_file input_files
