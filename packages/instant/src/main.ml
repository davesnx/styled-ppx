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
(* TODO: Create alcotest Testable *)
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

type tag = [ `Ok | `Fail | `Skip | `Todo | `Assert ]

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

let pp_tag ~wrapped ppf typ =
  let colour = colour_of_tag typ in
  let tag = string_of_tag typ in
  let tag = if wrapped then "[" ^ tag ^ "]" else tag in
  Fmt.(styled colour string) ppf tag

let tag = pp_tag ~wrapped:false

let pp_location =
  let pp =
    Fmt.styled `Bold (fun ppf (f, l, c) ->
        Fmt.pf ppf "File \"%s\", line %d, character %d:@," f l c)
  in
  fun ?here ?pos ppf ->
    match (here, pos) with
    | Some (here : Source_code_position.here), _ ->
        pp ppf (here.pos_fname, here.pos_lnum, here.pos_cnum - here.pos_bol)
    | _, Some (fname, lnum, cnum, _) -> pp ppf (fname, lnum, cnum)
    | None, None -> ()

exception Check_error of unit Fmt.t

let check_err fmt = raise (Check_error fmt)

let custom_check (type a) ?here ?pos (t : a testable) msg (expected : a)
    (actual : a) =
  if not (equal t expected actual) then
    let open Fmt in
    let s = const string in
    let pp_error =
      match msg with "" -> nop | _ -> const tag `Fail ++ s (" " ^ msg) ++ cut
    and pp_expected ppf () =
      Fmt.pf ppf "   Expected: `%a'" (styled `Green (pp t)) expected;
      Format.pp_print_if_newline ppf ();
      Fmt.cut ppf ();
      ()
    and pp_actual ppf () =
      Fmt.pf ppf "   Received: `%a'" (styled `Red (pp t)) actual
    in
    let open Fmt in
    raise
    @@ check_err
         (vbox
            ((fun ppf () -> pp_location ?here ?pos ppf)
            ++ pp_error ++ cut ++ pp_expected ++ cut ++ pp_actual)
         ++ cut)

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
      Lwt.return (check string title left right)
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
      Alcotest_lwt.test_case "one" `Quick (fun switch () ->
          transform_snap_to_alco case switch))
    mock

let () =
  Lwt_main.run @@ Alcotest_lwt.run "Snapshot_tests" [ ("Mock_tests", cases) ]
