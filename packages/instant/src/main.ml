open Alcotest

(*
  ├── __tests__
  │   ├── command
  │   ├── stdin
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

let create_from_process_and_consumers ~consume_stdout ~consume_stderr process =
  let open Lwt.Infix in
  Lwt.both process#status
    (Lwt.both (consume_stdout process#stdout) (consume_stderr process#stderr))
  >>= fun (status, (stdout, stderr)) -> Lwt.return { stdout; stderr; status }

let spawn ?(consume_stdout = Lwt_io.read) ?(consume_stderr = Lwt_io.read)
    ?(arguments = []) exec =
  let lwt_command = (exec, Array.of_list (exec :: arguments)) in
  Lwt_process.with_process_full lwt_command
    (create_from_process_and_consumers ~consume_stdout ~consume_stderr)

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
    | _ -> None)

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

let print_list f lst =
  let rec print_elements = function
    | [] -> ()
    | h :: t ->
        f h;
        print_string ";";
        print_elements t
  in
  print_string "[";
  print_elements lst;
  print_string "]"

(* Custom alcotest's check function. To override output with diffing. *)
let check (expected : string) (actual : string) =
  if not_equal expected actual then
    match diff actual expected with
    | Some diff ->
        let pp_diff ppf () =
          Fmt.pf ppf "%s" diff;
          Fmt.cut ppf ();
          ()
        in
        let msg = Fmt.vbox pp_diff in
        raise_notrace (Check_error msg)
    | None -> ()

let transform_to_alco ({ command; expected; _ } : case) switch =
  Lwt_switch.add_hook (Some switch) (fun () -> Lwt.return ());
  let exec = List.hd (String.split_on_char ' ' command) in
  let arguments = List.tl (String.split_on_char ' ' command) in
  match%lwt spawn ~arguments exec with
  | { stderr; stdout; status = WEXITED 0 } ->
      let output =
        match (stderr, stdout) with
        | "", output -> output
        | output, "" -> output
        | _, _ -> fail "command got stderr and stdout"
      in
      let left = expected in
      let right = output in
      Lwt.return (check left right)
  | {
   stdout = "";
   stderr = "";
   status = WEXITED status_code | WSIGNALED status_code | WSTOPPED status_code;
  } ->
      let msg =
        Format.sprintf
          "No output (stderr empty and stdout empty) Status code: %i"
          status_code
      in
      fail msg
  | _ -> fail "Unknown error - this should not happen"

let mock =
  [
    { title = "first-case"; command = "echo cosis"; expected = "cosis\n" };
    {
      title = "one line command";
      command = "pwd";
      expected = "/Users/davesnx/Code/github/davesnx/styled-ppx";
    };
    {
      title = "multi line command";
      command = "ls";
      expected =
        {|CONTRIBUTING.md
LICENSE
README.md
_build
_esy
bin
dune-project
dune-workspace
esy.lock
node_modules
package.json
packages
scripts
styled-ppx.install
styled-ppx.opam
|};
    };
  ]

let run_cases data =
  List.map
    (fun case ->
      ( case.title,
        [
          Alcotest_lwt.test_case "" `Quick (fun switch () ->
              transform_to_alco case switch);
        ] ))
    data

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

let make_case folder title =
  let folder_path = Path.join folder (title |> Path.drive) in
  let command_path = Path.drive "command" in
  let command = Fs.readTextExn (Path.join folder_path command_path) in
  let expected_path = Path.drive "expected" in
  let expected = Fs.readTextExn (Path.join folder_path expected_path) in
  { title; command; expected }

let main =
  let folder = "packages/instant/_tests/" in
  let folder_path = Path.drive folder in
  let title_cases = obtain_title_cases folder_path in
  let cases = List.map (make_case folder_path) title_cases in
  Alcotest_lwt.run "Snapshot_tests" (run_cases cases)

let () = Lwt_main.run @@ main
