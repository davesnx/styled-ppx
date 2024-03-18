open Ppxlib

let get_preprocessed_ast path =
  match Ppxlib.Ast_io.read_binary path with
  | exception Sys_error s -> Error s
  | Ok s -> Ok s
  | Error e -> Error e

let get_reparsed_code_from_pp_file ~path =
  match get_preprocessed_ast path with
  | Error e -> Error e
  | Ok source ->
    (match Ppxlib.Ast_io.get_ast source with
    | Impl structure ->
      let _structure =
        Ppxlib_ast.Selected_ast.To_ocaml.copy_structure structure
      in
      let output = Stdlib.Format.asprintf "%a" Pprintast.structure structure in
      Ok output
    | Intf _signature ->
      (* let signature =
           Ppxlib_ast.Selected_ast.To_ocaml.copy_signature signature
         in
         let output =
           Stdlib.Format.asprintf "%a" Pprintast.signature signature
         in
         output *)
      Error "Interface files are not supported")

let get_safe arr index =
  if index < Stdlib.Array.length arr then Some (Stdlib.Array.get arr index)
  else None

let () =
  let path = get_safe Sys.argv 1 in
  match path with
  | None -> print_endline "Please provide a file path"
  | Some path ->
    (match get_reparsed_code_from_pp_file ~path with
    | Ok s -> print_endline s
    | Error e -> print_endline e)
