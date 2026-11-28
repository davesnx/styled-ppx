(* Module order from compiled imports.

   Each [.cmt] names its module ([cmt_modname], mangled for wrapped
   libraries), the source file it was compiled from ([cmt_sourcefile], a
   path from the directory the compiler ran in; for dune the build context
   root) and the compilation units it imports ([cmt_imports]). Only these
   three fields are read: they exist with the same meaning on OCaml 4.14 to
   5.x ([cmt_loadpath] changed type in 5.2, so it is not touched).

   Two steps: [pair] gives each input its [.cmt]s, and [order] sorts the
   inputs by the imports of their [.cmt]s. *)

type cmt = {
  path : string;
  modname : string;
  sourcefile : string;
  imports : string list;
}

(* Wrapped libraries compile an alias module from a generated [.ml-gen]
   file; it holds no CSS and is never an input. *)
let is_alias_module cmt = Filename.check_suffix cmt.sourcefile ".ml-gen"

let read_cmt path =
  match Cmt_format.read_cmt path with
  | { Cmt_format.cmt_modname; cmt_sourcefile = Some sourcefile; cmt_imports; _ }
    ->
    Ok
      (Some
         {
           path;
           modname = cmt_modname;
           sourcefile;
           imports = List.map fst cmt_imports;
         })
  | _ -> Ok None
  | exception _ -> Error path

(** The [.cmt]s at [paths] that come from a source file, or [Error path] for the
    first one that cannot be read. *)
let read_cmts paths =
  let rec read_all acc = function
    | [] -> Ok (List.rev acc)
    | path :: rest ->
      (match read_cmt path with
      | Ok (Some cmt) when not (is_alias_module cmt) ->
        read_all (cmt :: acc) rest
      | Ok _ -> read_all acc rest
      | Error _ as error -> error)
  in
  read_all [] paths

(* The components of a path, last first, so a suffix of a path is a prefix of
   its components. *)
let components path =
  let parts =
    String.split_on_char '/' path |> List.concat_map (String.split_on_char '\\')
  in
  List.fold_left
    (fun acc part ->
      match part, acc with
      | ("" | "."), _ -> acc
      | "..", _ :: rest -> rest
      | _ -> part :: acc)
    [] parts

let rec is_prefix prefix list =
  match prefix, list with
  | [], _ -> true
  | x :: prefix, y :: list -> x = y && is_prefix prefix list
  | _ :: _, [] -> false

let absolute path =
  if Filename.is_relative path then Filename.concat (Sys.getcwd ()) path
  else path

type pairing = {
  inputs : string list;
  paired : (string * cmt) list;  (** input, one of its [.cmt]s *)
}

(** A [.cmt] that is the best match of several inputs: it is ignored. *)
type ambiguous = {
  cmt : cmt;
  candidates : string list;
}

(* A [.cmt] belongs to an input when its source file is a component suffix
   of the input's absolute path. Each input takes the [.cmt]s with the
   longest such source file (several when one source file was compiled
   twice, for two modes); a [.cmt] that is the best match of two inputs
   belongs to neither. Every other [.cmt] is ignored. *)
let pair ~inputs cmts =
  let inputs = List.sort_uniq compare inputs in
  let sources = List.map (fun cmt -> cmt, components cmt.sourcefile) cmts in
  let best_of input =
    let parts = components (absolute input) in
    let matching =
      List.filter
        (fun (_, source) -> source <> [] && is_prefix source parts)
        sources
    in
    let longest =
      List.fold_left
        (fun longest (_, source) -> max longest (List.length source))
        0 matching
    in
    List.filter_map
      (fun (cmt, source) ->
        if List.length source = longest then Some cmt else None)
      matching
  in
  let choices =
    List.concat_map
      (fun input -> List.map (fun cmt -> input, cmt) (best_of input))
      inputs
  in
  let candidates_of cmt =
    List.filter_map
      (fun (input, (other : cmt)) ->
        if other.path = cmt.path then Some input else None)
      choices
  in
  let paired, ambiguous =
    List.partition (fun (_, cmt) -> List.length (candidates_of cmt) = 1) choices
  in
  let ambiguous =
    List.sort_uniq compare
      (List.map
         (fun (_, cmt) -> { cmt; candidates = candidates_of cmt })
         ambiguous)
  in
  { inputs; paired }, ambiguous

let cmts_of pairing input =
  List.filter_map
    (fun (owner, cmt) -> if owner = input then Some cmt else None)
    pairing.paired

(* The inputs that [input] imports: each import names the paired [.cmt]s
   with that module name, preferring those in the importer's own object
   directory (a [copy_files] twin compiled next to it), else all of them. A
   [.cmt] lists its own unit among its imports; that is not an edge. *)
let dependencies pairing =
  let by_modname = Hashtbl.create 64 in
  List.iter
    (fun ((_, (cmt : cmt)) as owned) ->
      Hashtbl.add by_modname cmt.modname owned)
    pairing.paired;
  fun input ->
    cmts_of pairing input
    |> List.concat_map (fun (importer : cmt) ->
      List.concat_map
        (fun name ->
          let candidates =
            List.filter
              (fun (owner, _) -> owner <> input)
              (Hashtbl.find_all by_modname name)
          in
          let local =
            List.filter
              (fun (_, (cmt : cmt)) ->
                Filename.dirname cmt.path = Filename.dirname importer.path)
              candidates
          in
          List.map fst (if local = [] then candidates else local))
        (List.filter (fun name -> name <> importer.modname) importer.imports))

(* Kahn's algorithm: each path after the paths it depends on. Among the
   ready paths the smallest comes first, so the result depends neither on
   the order of [paths] nor on that of the dependencies. Dependencies outside
   [paths], and on itself, are ignored. On a cycle, [Error cycle] lists its
   paths in path order, without the paths that only depend on it. *)
module Paths = Set.Make (String)

let toposort ~dependencies paths =
  let paths = List.sort_uniq compare paths in
  let known = Paths.of_list paths in
  let waiting = Hashtbl.create 64 in
  let dependents = Hashtbl.create 64 in
  List.iter
    (fun path ->
      let ds =
        dependencies path
        |> List.filter (fun d -> d <> path && Paths.mem d known)
        |> List.sort_uniq compare
      in
      Hashtbl.replace waiting path (List.length ds);
      List.iter (fun d -> Hashtbl.add dependents d path) ds)
    paths;
  let ready =
    List.filter (fun path -> Hashtbl.find waiting path = 0) paths
    |> Paths.of_list
  in
  let rec kahn acc ready =
    match Paths.min_elt_opt ready with
    | Some path ->
      Hashtbl.remove waiting path;
      let ready =
        List.fold_left
          (fun ready dependent ->
            let n = Hashtbl.find waiting dependent - 1 in
            Hashtbl.replace waiting dependent n;
            if n = 0 then Paths.add dependent ready else ready)
          (Paths.remove path ready)
          (Hashtbl.find_all dependents path)
      in
      kahn (path :: acc) ready
    | None when Hashtbl.length waiting = 0 -> Ok (List.rev acc)
    | None ->
      (* What is left is a cycle and the paths after it; drop the paths that
         nothing left depends on until only the cycle remains. *)
      let rec peel left =
        let kept =
          List.filter
            (fun path ->
              List.exists
                (fun dependent -> List.mem dependent left)
                (Hashtbl.find_all dependents path))
            left
        in
        if List.length kept = List.length left then left else peel kept
      in
      Error
        (Hashtbl.fold (fun path _ acc -> path :: acc) waiting []
        |> List.sort compare
        |> peel)
  in
  kahn [] ready

(** The inputs in dependency order, ties by path, or [Error cycle] with the
    module name and path of each input of the cycle. *)
let order pairing =
  toposort ~dependencies:(dependencies pairing) pairing.inputs
  |> Result.map_error
       (List.map (fun input ->
          let modname =
            match cmts_of pairing input with
            | cmt :: _ -> cmt.modname
            | [] -> input
          in
          modname, input))
