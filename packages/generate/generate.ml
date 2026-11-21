module Logger = struct
  type level =
    | Error
    | Warning
    | Info
    | Debug

  let severity = function Error -> 0 | Warning -> 1 | Info -> 2 | Debug -> 3
  let current_level = ref Warning
  let set_level level = current_level := level

  let level_of_string = function
    | "error" -> Some Error
    | "warning" | "warn" -> Some Warning
    | "info" -> Some Info
    | "debug" -> Some Debug
    | _ -> None

  let log level fmt =
    Printf.ksprintf
      (fun message ->
        if severity level <= severity !current_level then
          Printf.eprintf "styled-ppx: %s\n%!" message)
      fmt

  let error fmt = log Error fmt
  let warning fmt = log Warning fmt
  let info fmt = log Info fmt
  let debug fmt = log Debug fmt
end

let longident_head longident =
  match String.split_on_char '.' longident with
  | head :: _ -> head
  | [] -> longident

module Index = struct
  type t = (string, string) Hashtbl.t

  let create () : t = Hashtbl.create 64

  let add_from_payload (idx : t) payload =
    match Css_extraction.decode_bindings_payload payload with
    | Error msg -> Error msg
    | Ok entries ->
      List.iter
        (fun (entry : Css_extraction.binding) ->
          Hashtbl.replace idx entry.longident entry.class_string)
        entries;
      Ok ()
end

module Refs = struct
  type ref_loc = Css_extraction.ref_loc

  let of_list_expr = Css_extraction.decode_refs_payload
end

type harvest = {
  filename : string;
  rules : string list;
  refs : Refs.ref_loc list;
  env : string option;
  protocol_errors : string list;
}

let harvest_structure ~filename ~idx structure : harvest =
  let rules = ref [] in
  let refs = ref [] in
  let env = ref None in
  let protocol_errors = ref [] in
  let add_protocol_error attribute msg =
    protocol_errors :=
      Printf.sprintf "%s: malformed [@@@%s]: %s" filename attribute msg
      :: !protocol_errors
  in
  List.iter
    (fun item ->
      match item with
      | [%stri [@@@css [%e? value]]] ->
        (match Css_extraction.decode_css_payload value with
        | Ok v -> rules := v :: !rules
        | Error msg -> add_protocol_error Css_extraction.css_attribute_name msg)
      | [%stri [@@@css.refs [%e? value]]] ->
        (match Refs.of_list_expr value with
        | Ok entries -> refs := entries @ !refs
        | Error msg -> add_protocol_error Css_extraction.refs_attribute_name msg)
      | [%stri [@@@css.bindings [%e? value]]] ->
        (match Index.add_from_payload idx value with
        | Ok () -> ()
        | Error msg ->
          add_protocol_error Css_extraction.bindings_attribute_name msg)
      | [%stri [@@@css.config [%e? value]]] ->
        (match Css_extraction.decode_config_payload value with
        | Ok entries ->
          (match List.assoc_opt Css_extraction.config_env_key entries with
          | Some _ as declared -> env := declared
          | None -> ())
        | Error msg ->
          add_protocol_error Css_extraction.config_attribute_name msg)
      | _ -> ())
    structure;
  {
    filename;
    rules = List.rev !rules;
    refs = List.rev !refs;
    env = !env;
    protocol_errors = List.rev !protocol_errors;
  }

let read_structure filename : Ppxlib.structure option =
  try
    if String.ends_with filename ~suffix:".pp.ml" then (
      match Ppxlib.Ast_io.read_binary filename with
      | Error msg ->
        Logger.error "cannot read %s: %s" filename msg;
        None
      | Ok t ->
        (match Ppxlib.Ast_io.get_ast t with Impl s -> Some s | Intf _ -> None))
    else if String.ends_with filename ~suffix:".ml" then (
      let ic = open_in filename in
      let len = in_channel_length ic in
      let content = really_input_string ic len in
      close_in ic;
      let lexbuf = Lexing.from_string content in
      lexbuf.lex_curr_p <- { lexbuf.lex_curr_p with pos_fname = filename };
      Some (Ppxlib.Parse.implementation lexbuf))
    else failwith ("Expected .ml or .pp.ml file, got: " ^ filename)
  with
  | Sys_error msg ->
    Logger.error "cannot read %s: %s" filename msg;
    None
  | exn ->
    Logger.error "cannot parse %s: %s" filename (Printexc.to_string exn);
    None

let format_location (r : Refs.ref_loc) : string =
  Printf.sprintf "File %S, line %d, characters %d-%d:" r.file r.start_line
    r.start_col r.end_col

let module_of_filename filename =
  let base = Filename.basename filename in
  let stem =
    if String.ends_with base ~suffix:".pp.ml" then
      String.sub base 0 (String.length base - String.length ".pp.ml")
    else Filename.remove_extension base
  in
  if stem = "" then stem else String.capitalize_ascii stem

let is_cross_library ~in_library_modules longident =
  match String.split_on_char '.' longident with
  | [] | [ _ ] -> false
  | _ ->
    let head = longident_head longident in
    not (List.mem head in_library_modules)

let cross_library_message ~longident ~head ~ref_loc =
  Printf.sprintf
    "%s\n\
     Error: cross-library [%%css] selector references are not supported.\n\
     The reference `%s` resolves to module `%s` which is not part of the\n\
     current library. Move the [%%css] binding into the current library, or\n\
     inline the class chain literally."
    (format_location ref_loc) longident head

let unresolved_message ~longident ~ref_loc ~in_library_modules =
  let head = longident_head longident in
  if is_cross_library ~in_library_modules longident then
    cross_library_message ~longident ~head ~ref_loc
  else
    Printf.sprintf
      "%s\n\
       Error: cross-module [%%css] selector reference `%s` does not resolve.\n\
       The target binding is missing from module `%s`, or the binding is not\n\
       a [%%css] expression. Define `%s` with [%%css \"...\"], or remove the\n\
       reference."
      (format_location ref_loc) longident head longident

let production_mode harvests =
  let contributing =
    List.filter (fun h -> h.rules <> [] || h.env <> None) harvests
  in
  let production, development =
    List.partition
      (fun h -> h.env = Some Css_extraction.config_env_production)
      contributing
  in
  match production, development with
  | [], _ -> false
  | _ :: _, [] -> true
  | prod :: _, dev :: _ ->
    Logger.warning
      "input files disagree on their [@@@%s] environment: %s was compiled for \
       production but %s was not; emitting non-minified output. Pass the same \
       environment to every (pps styled-ppx ...) stanza."
      Css_extraction.config_attribute_name prod.filename dev.filename;
    false

let run ~output_file input_files =
  Logger.info "output file: %s"
    (match output_file with Some file -> file | None -> "stdout");
  let idx = Index.create () in
  let in_library_modules = List.map module_of_filename input_files in
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

  let errors =
    ref (List.concat_map (fun harvest -> harvest.protocol_errors) harvests)
  in
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
                Css_extraction.ref_loc ~longident ~file:harvest.filename
                  ~start_line:1 ~start_col:0 ~end_col:0
            in
            let msg =
              unresolved_message ~longident ~ref_loc ~in_library_modules
            in
            errors := msg :: !errors
          in
          let on_malformed msg =
            errors :=
              Printf.sprintf "%s: malformed [@@@%s]: %s" harvest.filename
                Css_extraction.css_attribute_name msg
              :: !errors
          in
          let resolved =
            Css_extraction.resolve_sentinels ~lookup:(Hashtbl.find_opt idx)
              ~on_unresolved:on_error ~on_malformed rule
          in
          resolved_rules := resolved :: !resolved_rules)
        harvest.rules)
    harvests;

  (match !errors with
  | [] -> ()
  | _ ->
    List.iter (fun msg -> Logger.error "%s" msg) (List.rev !errors);
    exit 1);

  let ordered_rules =
    let seen = Hashtbl.create 64 in
    List.rev !resolved_rules
    |> List.filter (fun rule ->
      if Hashtbl.mem seen rule then false
      else begin
        Hashtbl.add seen rule ();
        true
      end)
  in

  let minify = production_mode harvests in
  Logger.info "environment: %s"
    (if minify then "production (from [@@@css.config])" else "development");
  let stylesheet =
    let separator = if minify then "" else "\n" in
    let buffer = Buffer.create 1024 in
    Buffer.add_string buffer
      "/* This file is generated by styled-ppx, do not edit manually */\n";
    List.iter
      (fun rule ->
        Buffer.add_string buffer rule;
        Buffer.add_string buffer separator)
      ordered_rules;
    Buffer.contents buffer
  in
  Logger.debug "stylesheet:\n%s" stylesheet;
  let out_channel =
    match output_file with Some file -> open_out file | None -> Stdlib.stdout
  in
  output_string out_channel stylesheet;
  match output_file with Some _ -> close_out out_channel | None -> ()

let parse_args args =
  let rec parse acc ~output_file ~log_level = function
    | "-o" :: file :: rest
    | "-output" :: file :: rest
    | "--output" :: file :: rest ->
      parse acc ~output_file:(Some file) ~log_level rest
    | "--log" :: level :: rest ->
      (match Logger.level_of_string level with
      | Some log_level -> parse acc ~output_file ~log_level rest
      | None ->
        Logger.error
          "invalid --log level %S (expected \"error\", \"warning\", \"info\" \
           or \"debug\")"
          level;
        exit 2)
    | "--debug" :: rest -> parse acc ~output_file ~log_level:Logger.Debug rest
    | [ (("-o" | "-output" | "--output" | "--log") as flag) ] ->
      Logger.error "missing value for flag %S" flag;
      exit 2
    | arg :: _ when String.length arg > 0 && arg.[0] = '-' ->
      Logger.error "unknown flag %S" arg;
      exit 2
    | arg :: rest -> parse (arg :: acc) ~output_file ~log_level rest
    | [] -> List.rev acc, output_file, log_level
  in
  let tail = match Array.to_list args with [] -> [] | _ :: t -> t in
  parse [] ~output_file:None ~log_level:Logger.Warning tail

let () =
  let input_files, output_file, log_level = parse_args Sys.argv in
  Logger.set_level log_level;
  run ~output_file input_files
