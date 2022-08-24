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
(* TODO: Add option to ignore ws *)

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

let diff left right =
  Patdiff.Patdiff_core.Without_unix.patdiff
    ~location_style:None
      (* without color, cannot produce the "!|" lines that mix add/keep/remove *)
    ~produce_unified_lines:false
      (* line splitting produces confusing output in ASCII format *)
    ~split_long_lines:false ~keep_ws:false
    ~prev:{ name = "expected"; text = left }
    ~next:{ name = "actual"; text = right }
    ()

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

(* let pp_none ppf = Fmt.pf ppf " %s"

   let pp_green =
     (fun ppf -> Fmt.pf ppf "+%s") |> Fmt.styled `Bold |> Fmt.styled (`Fg `Green)

   let pp_red =
     (fun ppf -> Fmt.pf ppf "-%s") |> Fmt.styled `Bold |> Fmt.styled (`Fg `Red)

   let iter ?sep:(pp_sep = Fmt.cut) iter pp_elt ppf v =
     let pp_elt v =
       pp_sep ppf ();
       pp_elt ppf v
     in
     iter pp_elt v

   let array pp_elt = iter ~sep:(Fmt.const Fmt.string "\n") Array.iter pp_elt
   let list pp_elt = iter ~sep:Fmt.nop List.iter pp_elt *)

let equal left right = equal string left right
let not_equal l r = not (equal l r)

(* Custom alcotest's check function. To override output with diffing. *)
let check (expected : string) (actual : string) =
  let ( ++ ) = Fmt.( ++ ) in
  if not_equal expected actual then
    let difference = diff expected actual in
    let pp_diff ppf () =
      Fmt.pf ppf "%s" difference;
      Fmt.cut ppf ();
      ()
    in
    let msg = Fmt.vbox (pp_diff ++ Fmt.cut) in
    raise_notrace (Check_error msg)

let transform_snap_to_alco ({ command; flags; expected; _ } : case) switch =
  Lwt_switch.add_hook (Some switch) (fun () -> Lwt.return ());
  match%lwt spawn ~arguments:flags command with
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
      expected = "cosis\n";
    };
    {
      title = "one line command";
      command = "pwd";
      flags = [];
      expected = "/Users/davesnx/Code/github/davesnx/styled-ppx\n";
    };
    {
      title = "multiple lines command";
      command = "echo";
      flags = [ "cosis\nasd\nasdfadsf" ];
      expected = "cosis\nasd\nasdfadsf\n";
    };
    {
      title = "multi line command";
      command = "ls";
      flags = [];
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
       packages
       scripts
       styled-ppx.install
       styled-ppx.opam
       |};
    };
  ]

let cases =
  List.map
    (fun case ->
      ( case.title,
        [
          Alcotest_lwt.test_case "" `Quick (fun switch () ->
              transform_snap_to_alco case switch);
        ] ))
    mock

let () = Lwt_main.run @@ Alcotest_lwt.run "Snapshot_tests" cases
