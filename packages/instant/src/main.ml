open Alcotest

(*
  ├── __tests__
  │   ├── command
  │   ├── stdin
  │   └── expected

  Given the following file structure.
  This program will run the command with the optional stdin and compare the result with the expected file.
  If this succeeds or fail, the test is reported by alcotest.
*)

(* TODO: Read folder content *)
(* TODO: Create testing API (Snapshot folder options) *)
(* TODO: Create mode to update snapshot files *)
(* TODO: Read folder nested commands *)

type case = {
  title : string;
  command : string;
  flags : string list;
  expected : string;
}

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

type tag = Ok | Fail | Skip | Todo | Assert

let colour_of_tag = function
  | `Ok -> `Green
  | `Fail -> `Red
  | `Skip | `Todo | `Assert -> `Yellow

let string_of_tag = function
  | `Ok -> "OK"
  | `Fail -> "FAIL"
  | `Skip -> "SKIP"
  | `Todo -> "TODO"
  | `Assert -> "ASSERT"

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
      (let buf = Buffer.create 0 in
       let ppf = Format.formatter_of_buffer buf in
       Fmt.set_style_renderer ppf Fmt.(style_renderer stderr);
       fun error ->
         Fmt.pf ppf "Alcotest assertion failure@.%a@." error ();
         let contents = Buffer.contents buf in
         Buffer.clear buf;
         contents)
  in
  Printexc.register_printer (function
    | Check_error err -> Some (Lazy.force print_error err)
    | _ -> None)

let pp_none ppf x = Fmt.pf ppf " %s" x
let pp_green = Fmt.styled `Green (fun ppf v -> Fmt.pf ppf "+%s" v)
let pp_red = Fmt.styled `Red (fun ppf v -> Fmt.pf ppf "-%s" v)

let fmt_diff ppf v =
  match v with
  | Diff.Deleted items -> Fmt.array pp_green ppf items
  | Added items -> Fmt.array pp_red ppf items
  | Equal items -> Fmt.array pp_none ppf items

let pp_diff_list = Fmt.vbox (Fmt.list fmt_diff)

(* Custom alcotest's check function. To override printing behaviour. *)
let check_diff msg (expected : string) (actual : string) =
  let ( ++ ) = Fmt.( ++ ) in
  if not (equal string expected actual) then
    let difference = Diff.get expected actual in
    let pp_error =
      match msg with
      | "" -> Fmt.nop
      | _ -> Fmt.const tag `Fail ++ Fmt.const Fmt.string (" " ^ msg) ++ Fmt.cut
    and pp_diff ppf () =
      Fmt.pf ppf "  %a" pp_diff_list difference;
      Fmt.cut ppf ();
      ()
    in
    let msg = Fmt.vbox pp_error ++ Fmt.cut ++ pp_diff ++ Fmt.cut in
    raise_notrace (Check_error msg)

let transform_snap_to_alco ({ command; flags; expected; title } : case) switch =
  Lwt_switch.add_hook (Some switch) (fun () -> Lwt.return ());
  match%lwt spawn ~arguments:flags command with
  | { stderr; stdout; status = WEXITED 0 } ->
      let output =
        match (stderr, stdout) with
        | "", output -> output
        | output, "" -> output
        | _, _ -> fail "command got stderr and stdout"
      in
      let left = expected |> String.trim in
      let right = output |> String.trim in
      Lwt.return (check_diff title left right)
  | {
   stdout = "";
   stderr = "";
   status = WEXITED status_code | WSIGNALED status_code | WSTOPPED status_code;
  } ->
      let msg =
        "No output (stderr empty and stdout empty) Status code: "
        ^ string_of_int status_code
      in
      fail msg
  | _ -> fail "Unknown error - this should not happen"

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

let cases =
  List.map
    (fun case ->
      Alcotest_lwt.test_case case.title `Quick (fun switch () ->
          transform_snap_to_alco case switch))
    mock

let () = Lwt_main.run @@ Alcotest_lwt.run "Mock" [ ("Snapshot_tests", cases) ]
