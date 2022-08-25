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
cosas
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
