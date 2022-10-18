open Alcotest

(*
  ├── __tests__
  │   ├── command
  │   ├── input (or whatever you want)
  │   └── expected

  Given the following file structure.
  This program will run the command with the optional stdin and compare the result with the expected file.
  If this succeeds or fail, the test is reported by alcotest.

  Running the dummy script: `esy dune exec packages/instant/src/main.exe`
*)

type case = { title : string; command : string; expected : string }

type completed = {
  stdout : string;
  stderr : string;
  status : Unix.process_status;
}

let write_to_stdin process stdin =
  match stdin with
  | Some stdin ->
      let%lwt () = Lwt_io.write process#stdin stdin in
      let%lwt () = Lwt_io.close process#stdin in
      Lwt.return_unit
  | None -> Lwt.return ()

let spawn ?stdin exec =
  let callback process =
    let%lwt _ = write_to_stdin process stdin in
    let%lwt status, (stdout, stderr) =
      Lwt.both process#status
        (Lwt.both (Lwt_io.read process#stdout) (Lwt_io.read process#stderr))
    in
    Lwt.return { stdout; stderr; status }
  in
  Lwt_process.with_process_full (Lwt_process.shell exec) callback

type tag = Ok | Fail | Skip | Todo | Assert

let colour_of_tag = function
  | Ok -> `Green
  | Fail -> `Red
  | Skip | Todo | Assert -> `Yellow

let string_of_tag = function
  | Ok -> "OK"
  | Fail -> "FAIL"
  | Skip -> "SKIP"
  | Todo -> "TODO"
  | Assert -> "ASSERT"

let tag ppf typ =
  let colour = colour_of_tag typ in
  let tag = string_of_tag typ in
  Fmt.(styled colour string) ppf tag

exception Check_error of unit Fmt.t

let () =
  let print_error =
    (* We instantiate the error print buffer lazily, so as to be sensitive to
       [Fmt_tty.setup_std_outputs]. *)
    lazy
      (fun error ->
        let buf = Buffer.create 0 in
        let ppf = Format.formatter_of_buffer buf in
        Fmt.set_style_renderer ppf Fmt.(style_renderer stderr);
        Fmt.pf ppf "@.%a@." error ();
        let contents = Buffer.contents buf in
        Buffer.clear buf;
        contents)
  in
  Printexc.register_printer (function
    | Check_error err -> Some (Lazy.force print_error err)
    | _exn -> None)

let equal left right = equal string left right
let not_equal l r = not (equal l r)

module Rule = Patdiff_kernel.Format.Rule
module Rules = Patdiff_kernel.Format.Rules
module Style = Patdiff_kernel.Format.Style
module Color = Patdiff_kernel.Format.Color

let output_rules : Rules.t =
  let red =
    let color = Color.Red in
    let background = Color.RGB6 (Color.RGB6.create_exn ~r:2 ~g:0 ~b:0) in
    let style = Style.[ Fg color; Background background; Bold ] in
    Rule.create style
  in

  let green =
    let color = Color.Green in
    let background = Color.RGB6 (Color.RGB6.create_exn ~r:0 ~g:2 ~b:0) in
    let style = Style.[ Fg color; Background background; Bold ] in
    Rule.create style
  in

  {
    line_prev = red;
    line_next = green;
    word_prev = red;
    word_next = green;
    line_same = Rule.blank;
    line_unified = Rule.blank;
    word_same_prev = Rule.blank;
    word_same_next = Rule.blank;
    word_same_unified = Rule.blank;
    hunk = Rule.blank;
    header_prev = Rule.blank;
    header_next = Rule.blank;
  }

let diff left right =
  match
    Patdiff.Patdiff_core.Without_unix.patdiff ~location_style:None
      ~rules:output_rules
        (* without color, cannot produce the "!|" lines that mix add/keep/remove *)
      ~produce_unified_lines:false
        (* line splitting produces confusing output in ASCII format *)
      ~split_long_lines:false ~keep_ws:true
      ~prev:{ name = "expected"; text = left }
      ~next:{ name = "actual"; text = right }
      ()
  with
  | "" -> None
  | otherwise -> Some otherwise

(* Custom alcotest's check function. To override output with diffing. *)
let check (expected : string) (actual : string) =
  (* unit makes the test pass, have a small variable to express it better *)
  let pass = () in
  if not_equal expected actual then
    match diff expected actual with
    | Some diff ->
        let msg =
          Fmt.vbox (fun ppf () ->
              Fmt.pf ppf "%s" diff;
              Fmt.cut ppf ())
        in
        raise (Check_error msg)
    | None -> pass
  else pass

let code_of_status = function Unix.WEXITED c | WSIGNALED c | WSTOPPED c -> c

let transform_to_alco switch ({ command; expected; _ } : case) =
  try%lwt
    Lwt_switch.add_hook (Some switch) (fun () -> Lwt.return ());
    match%lwt spawn command with
    | { stderr; stdout; status = WEXITED 0 } ->
        let%lwt output =
          match (stderr, stdout) with
          | "", output -> Lwt.return output
          | output, "" -> Lwt.return output
          | err, out ->
              Alcotest.failf "stderr: %s" err |> ignore;
              Lwt.return out
        in
        Lwt.return (check expected output)
    | { stdout = ""; stderr = ""; status } ->
        Alcotest.failf
          "Status code: %i. No output (stderr empty and stdout empty)"
          (code_of_status status)
    | { stdout = ""; stderr; status } ->
        let msg =
          Printf.sprintf "Status code: %i. stderr %s" (code_of_status status)
            stderr
        in
        Lwt.fail_with msg
    | _ -> Lwt.fail_with "Unknown error - this should not happen"
  with exn -> Alcotest.failf "%s" (Printexc.to_string exn)

(** [dir_is_empty dir] is true, if [dir] contains no files except
 * "." and ".."
 *)
let dir_is_empty dir = Array.length (Sys.readdir dir) = 0

(** [dir_contents] returns the paths of all regular files that are
 * contained in [dir]. Each file is a path starting with [dir].
  *)
let dir_contents_deep dir =
  let rec loop result = function
    | f :: fs when Sys.is_directory f ->
        Sys.readdir f |> Array.to_list
        |> List.map (Filename.concat f)
        |> List.append fs |> loop result
    | f :: fs -> loop (f :: result) fs
    | [] -> result
  in
  loop [] [ dir ]

let dir_contents dir = dir |> Sys.readdir |> Array.to_list

let obtain_title_cases folder =
  let cwd = Path.drive (Sys.getcwd ()) in
  let current_folder = Path.join cwd folder in
  let stringPath = Path.toString current_folder in
  dir_contents stringPath

let read_text path =
  match Fs.readText path with
  | Ok c -> c
  | Error _e ->
      fail
        (Printf.sprintf "can't read command file from %s" (Path.toString path))

let is_empty str = String.equal "" (String.trim str)

let read_text_optional path =
  match Fs.readText path with
  | Ok c when is_empty c -> None
  | Error _ -> None
  | Ok c -> Some c

let make_case folder title =
  try
    let folder_path = Path.join folder (title |> Path.drive) in
    let command_path = Path.drive "command" in
    let command = read_text (Path.join folder_path command_path) in
    let expected_path = Path.drive "expected" in
    let expected = read_text (Path.join folder_path expected_path) in
    { title; command; expected }
  with e -> Alcotest.fail (Printf.sprintf "Error: %s" (Printexc.to_string e))

let main =
  let folder = "packages/ppx/test/instant/" in
  let folder_path = Path.drive folder in
  let title_cases = obtain_title_cases folder_path in
  let cases = List.map (make_case folder_path) title_cases in
  Alcotest_lwt.run "Snapshot_tests"
    (List.map
       (fun case ->
         ( case.title,
           [
             Alcotest_lwt.test_case "" `Quick (fun switch () ->
                 transform_to_alco switch case);
           ] ))
       cases)

let () = Lwt_main.run @@ main
