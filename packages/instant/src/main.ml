(*
  ├── __tests__
  │   ├── test_name_number_1.snap
  │   ├── test_name_number_2.snap
  │   └── test_name_number_3.snap

  Given the following file structure and a desired cli command or to transform input to input.
  This program will run the command on each file and compare the input to the input file.
  If this succeeds, the test is successful. If it fails, report the error.
*)

(* .snap file consist of
     - utf8 file
     - utf8 valid name
     - structure:
        - a command to run
        - input
        - input
*)

(* TODO: Parse .snap file *)
(* cmd: `ls`

   ```
   ```
   ---
   ```
   ```
*)

(* TODO: Run each case *)
(* TODO: Diff output and expected *)
(* TODO: Print errors nicely (alcotest uwu) *)

type case = {
  title : string;
  command : string;
  flags : string list;
  expected : string;
}

(* open Lwt.Syntax *)

let mock =
  [
    {
      title = "first-case";
      command = "echo";
      flags = [ "cosis" ];
      expected = "cosis";
    };
    {
      title = "one line command";
      command = "pwd";
      flags = [];
      expected = "/Users/davesnx/Code/github/davesnx/styled-ppx";
    };
    {
      title = "multi line command";
      command = "ls";
      flags = [];
      expected =
        {|CONTRIBUTING.md
LICENSE
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
styled-ppx.opam|};
    };
  ]

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

let spawn ?(consume_stdout = fun input_channel -> Lwt_io.read input_channel)
    ?(consume_stderr = fun input_channel -> Lwt_io.read input_channel)
    ?(arguments = []) exec =
  let lwt_command = (exec, Array.of_list (exec :: arguments)) in
  Lwt_process.with_process_full lwt_command
    (create_from_process_and_consumers ~consume_stdout ~consume_stderr)

type err =
  | Unknown of string
  | NoMatch of string
  | Invalid
  | Invalid_command
  | Invalid_input
  | Invalid_expected

let err_to_string = function
  | NoMatch msg -> msg
  | Unknown err -> "Error Unknown: " ^ err
  | Invalid -> "Error Invalid"
  | Invalid_command -> "Error Invalid_command"
  | Invalid_input -> "Error Invalid_input"
  | Invalid_expected -> "Error Invalid_expected"

type final = (unit, err) Lwt_result.t

let compare left right =
  String.equal (left |> String.trim) (right |> String.trim)

let print_diff left right =
  let left_lines = left |> String.split_on_char ' ' |> Array.of_list in
  let right_lines = right |> String.split_on_char ' ' |> Array.of_list in
  let diff = Diff.get_diff left_lines right_lines in
  Diff.print diff

let run_test { command; flags; expected; _ } =
  match%lwt spawn ~arguments:flags command with
  | { stderr; stdout; status = WEXITED 0 } ->
      let output =
        match (stderr, stdout) with
        | "", output -> output
        | output, "" -> output
        (* TODO: Handle this as an error *)
        | _, _ -> failwith "command got stderr and stdout"
      in
      if compare output expected then Lwt.return @@ Ok ()
      else Lwt.return @@ Error (NoMatch (print_diff output expected))
  | {
   stdout = "";
   stderr = "";
   status = WEXITED status_code | WSIGNALED status_code | WSTOPPED status_code;
  } ->
      let msg =
        "No output (stderr empty and stdout empty) Status code: "
        ^ string_of_int status_code
      in
      Lwt_result.error @@ Lwt.return (Unknown msg)
  | _ ->
      Lwt_result.error
      @@ Lwt.return (Unknown "Unknown error - this should not happen")

let ident num = String.make num ' '
let newline = "\n"

let format_err err =
  String.split_on_char '\n' (err_to_string err)
  |> List.map (fun line -> ident 4 ^ " " ^ line)
  |> String.concat "\n"

let run_tests suitName cases =
  Lwt_io.printl (newline ^ "Running " ^ suitName) |> ignore;
  Lwt_list.iter_p
    (fun case ->
      match%lwt run_test case with
      | Ok _ -> Lwt_io.printl (ident 2 ^ case.title ^ "  🟩")
      | Error err ->
          Lwt_io.printl
            (newline ^ ident 2 ^ case.title ^ "  🟥" ^ newline ^ format_err err))
    cases

let () = Lwt_main.run (run_tests "Mock tests" mock)
