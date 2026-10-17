(* [Merge_key] against [Reference_merge_key], the module as it was before it
   was rewritten to compare fields in place (kept here as the oracle). Both
   must return the same string for every input, so the rewrite is a pure
   speed-up. Inputs are random and seeded, so a failure replays. *)

let alphabet = "0123456789abcdefghijklmnopqrstuvwxyz"
let pick st arr = arr.(Random.State.int st (Array.length arr))
let chars st n = String.init n (fun _ -> alphabet.[Random.State.int st 36])

(* -- synthetic tokens: every field shape, the sentinel families, stray
   classes and characters outside base36 ------------------------------- *)

let families =
  [| "zz"; "zy"; "5q"; "dp"; "ab"; "ac"; "ba"; "0a"; "A1"; "01"; "a1"; "a-" |]

let contexts =
  [| "0aaaa"; "0aaab"; "0bbbb"; "1aaaa"; "1aaab"; "2cccc"; "3dddd" |]

let masks =
  Array.map
    (fun digits ->
      String.make (Class_format.mask_width - String.length digits) '0' ^ digits)
    [| "1"; "2"; "3"; "4"; "6"; "z"; "zz"; "0" |]

let extendeds = [| "eeeeee"; "eeeeef"; "ffffff" |]
let prefixes = [| "_a_"; "_a_"; "_a_"; "_t1_"; "_t2_" |]

let strays =
  [|
    "";
    "_id_1abc23";
    "label:box";
    "_a_zzz";
    "_t3_abcdef";
    "_t0_abcdef";
    "_t1_";
    "_a_";
    "a-header";
    "_a_header";
    "_t2_x";
  |]

let synthetic_token st =
  if Random.State.int st 8 = 0 then pick st strays
  else (
    let context = if Random.State.bool st then "" else pick st contexts in
    let extended =
      if Random.State.int st 4 = 0 then pick st extendeds else ""
    in
    let mask = if Random.State.int st 3 = 0 then pick st masks else "" in
    (* the extended and mask fields never appear together *)
    let mask = if extended <> "" then "" else mask in
    let value = if Random.State.int st 3 = 0 then "vvvv" else chars st 4 in
    let body = context ^ pick st families ^ extended ^ mask ^ value in
    let body =
      (* now and then a wrong length, which must stay opaque *)
      if Random.State.int st 40 = 0 then body ^ "x" else body
    in
    pick st prefixes ^ body)

let separators = [| " "; " "; " "; "  "; "\t"; "\n"; " \r\n " |]

let join st tokens =
  let buf = Buffer.create 64 in
  if Random.State.int st 10 = 0 then Buffer.add_string buf (pick st separators);
  List.iteri
    (fun i token ->
      if i > 0 then Buffer.add_string buf (pick st separators);
      Buffer.add_string buf token)
    tokens;
  if Random.State.int st 10 = 0 then Buffer.add_string buf (pick st separators);
  Buffer.contents buf

(* -- monorepo-shaped tokens: real atoms from the ppx-side encoder, in the
   contexts the monorepo uses, with the usual identity prefix ------------ *)

let declarations =
  [|
    "color: red;";
    "color: blue;";
    "background-color: #333;";
    "margin: 10px;";
    "margin-top: 0;";
    "margin-left: 2px;";
    "padding: 1px;";
    "padding-top: 1px;";
    "padding-left: 2px;";
    "padding-inline: 4px;";
    "height: 0;";
    "width: 100%;";
    "display: flex;";
    "gap: 8px;";
    "column-gap: 24px;";
    "border: 1px solid red;";
    "border-top-width: 2px;";
    "font-size: 12px;";
    "opacity: 0.5;";
    "overflow: hidden;";
    "all: unset;";
    "direction: rtl;";
    "unicode-bidi: embed;";
    "--brand: red;";
  |]

let wrappers =
  [|
    (fun d -> d);
    (fun d -> d);
    (fun d -> d);
    (fun d -> "@media (max-width:600px){" ^ d ^ "}");
    (fun d -> "@media (max-width:1200px){" ^ d ^ "}");
    (fun d -> "@container (min-width:1px){" ^ d ^ "}");
    (fun d -> "&:hover{" ^ d ^ "}");
    (fun d -> "&:focus{" ^ d ^ "}");
    (fun d -> "@media (max-width:600px){&:hover{" ^ d ^ "}}");
    (fun d -> String.sub d 0 (String.length d - 1) ^ " !important;");
  |]

let real_atoms =
  lazy
    (Array.init 400 (fun i ->
       let st = Random.State.make [| i |] in
       Test_merge_key.class_of (pick st wrappers (pick st declarations)))
    |> Array.to_list
    |> List.sort_uniq compare
    |> Array.of_list)

let monorepo_token st =
  match Random.State.int st 12 with
  | 0 -> "label:box"
  | 1 -> "_id_1abc23"
  | _ ->
    let atoms = Lazy.force real_atoms in
    let atom = pick st atoms in
    (* a twin form of the same atom, as a previous merge would leave *)
    if Random.State.int st 6 = 0 then
      Printf.sprintf "_t%d_%s"
        (1 + Random.State.int st 2)
        (String.sub atom 3 (String.length atom - 3))
    else atom

let list_of st max gen =
  List.init (Random.State.int st (max + 1)) (fun _ -> gen st)

(* -- the comparison --------------------------------------------------- *)

let iterations = 20_000

let check_equal what input expected actual =
  if not (String.equal expected actual) then
    Alcotest.failf "%s differs on %s@.reference: %S@.actual:    %S" what input
      expected actual

let merge_matches gen max () =
  let st = Random.State.make [| 7 |] in
  for _ = 1 to iterations do
    let a = join st (list_of st max gen) in
    let b = join st (list_of st max gen) in
    check_equal "merge"
      (Printf.sprintf "%S %S" a b)
      (Reference_merge_key.merge_class_names a b)
      (Merge_key.merge_class_names a b)
  done

let chain_matches gen max () =
  let st = Random.State.make [| 11 |] in
  for _ = 1 to iterations / 2 do
    let a = join st (list_of st max gen) in
    let b = join st (list_of st max gen) in
    let c = join st (list_of st max gen) in
    check_equal "chained merge"
      (Printf.sprintf "%S %S %S" a b c)
      (Reference_merge_key.merge_class_names
         (Reference_merge_key.merge_class_names a b)
         c)
      (Merge_key.merge_class_names (Merge_key.merge_class_names a b) c)
  done

let block_matches gen max () =
  let st = Random.State.make [| 13 |] in
  for _ = 1 to iterations do
    let tokens = list_of st max gen in
    check_equal "twin_block"
      (Printf.sprintf "%S" (String.concat " " tokens))
      (String.concat " " (Reference_merge_key.twin_block tokens))
      (String.concat " " (Merge_key.twin_block tokens))
  done

let tests =
  [
    Alcotest_extra.test "merge equals the reference on random tokens"
      (merge_matches synthetic_token 12);
    Alcotest_extra.test "merge equals the reference on large random lists"
      (merge_matches synthetic_token 60);
    Alcotest_extra.test "merge equals the reference on monorepo-shaped atoms"
      (merge_matches monorepo_token 15);
    Alcotest_extra.test "chained merge equals the reference on random tokens"
      (chain_matches synthetic_token 10);
    Alcotest_extra.test "chained merge equals the reference on monorepo atoms"
      (chain_matches monorepo_token 10);
    Alcotest_extra.test "twin_block equals the reference on random tokens"
      (block_matches synthetic_token 12);
    Alcotest_extra.test "twin_block equals the reference on monorepo atoms"
      (block_matches monorepo_token 15);
  ]
