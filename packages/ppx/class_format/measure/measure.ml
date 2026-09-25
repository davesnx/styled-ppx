(* Phase 2 checkpoint measurement: for each real CSS rule line in a corpus
   file, compute what the new atom-class format's LENGTH would be (using
   the real Slot_key/Class_format code, not reimplemented constants) versus
   the length of the class token already in that line (today's format).
   Emits: a length-distribution summary on stdout, and a rewritten copy of
   the corpus with each old class token replaced by a same-length-as-new
   placeholder, so the caller can gzip both files for a real compressed-size
   comparison (this tool does not gzip itself - no zlib binding is wired
   into this small executable, and the shell already has gzip). *)

let is_class_char c =
  (c >= 'a' && c <= 'z') || (c >= '0' && c <= '9') || c = '-'

let find_class_token line =
  (* First ".css-..."/".csi-..."/".csv-..." token in the line (there is at
     most one real atom class per corpus line - see merge-order-flip-
     under-dedup.md's "one line per rule" observation about this exact
     corpus). A [csv-] token (a bundle atom, already wired for real - see
     Hash_class.bundle_class_and_namespace) is measured as-is, not
     re-estimated: it needs no css-/csi- field arithmetic at all. *)
  let n = String.length line in
  let has_prefix i p =
    let m = String.length p in
    i + m <= n && String.sub line i m = p
  in
  let rec scan i =
    if i >= n then None
    else if
      line.[i] = '.'
      && (has_prefix (i + 1) "css-"
         || has_prefix (i + 1) "csi-"
         || has_prefix (i + 1) "csv-")
    then (
      let start = i + 1 in
      let is_bundle = has_prefix start "csv-" in
      let j = ref (start + 4) in
      while !j < n && is_class_char line.[!j] do
        incr j
      done;
      Some (start, !j - start, is_bundle))
    else scan (i + 1)
  in
  scan 0

(* Declared property names inside the {...} body - same approach as the
   phase-1 evaluation's Python `derive_slots`: text before each top-level
   ':', which is a reasonable proxy for this corpus's mostly-flat
   declarations without pulling in a full CSS parser for a measurement
   script. *)
let properties_in_body body =
  let is_prop_char c =
    (c >= 'a' && c <= 'z')
    || (c >= 'A' && c <= 'Z')
    || (c >= '0' && c <= '9')
    || c = '-'
  in
  let n = String.length body in
  let rec loop i acc =
    if i >= n then List.rev acc
    else if body.[i] = ':' then (
      let j = ref (i - 1) in
      while
        !j >= 0
        && (is_prop_char body.[!j]
           || (body.[!j] = '-' && !j > 0 && body.[!j - 1] = '-'))
      do
        decr j
      done;
      let start = !j + 1 in
      if start < i then (
        let prop = String.sub body start (i - start) in
        loop (i + 1) (prop :: acc))
      else loop (i + 1) acc)
    else loop (i + 1) acc
  in
  loop 0 []

let has_context line class_end =
  (* Anything other than "{" immediately after the class token means a
     pseudo-class/element or a combinator suffix; an at-rule wrapper
     (checked separately by the caller) is the other source of context. *)
  class_end < String.length line && line.[class_end] <> '{'

let new_length ~has_context ~mask_needed ~extended_needed =
  Class_format.value_width
  + Class_format.family_width
  + (if has_context then Class_format.context_width else 0)
  + (if mask_needed then Class_format.mask_width else 0)
  + (if extended_needed then Class_format.extended_width else 0)
  + 4 (* "css-"/"csi-" *)

type row = {
  old_length : int;
  new_length : int;
  context : bool;
  mask : bool;
  extended : bool;
  bundle : bool;
}

(* Whether this multi-declaration group's combined mask is a proper subset
   of its family's full mask - mirrors [Slot_key.of_atom]'s own fold
   (None/"full" absorbs). *)
let group_needs_mask properties =
  match properties with
  | [] -> false
  | first :: _ ->
    let full = Slot_key.Family.full_mask_of first in
    let combined =
      List.fold_left
        (fun acc p ->
          match acc with
          | None -> None
          | Some m ->
            if Slot_key.Family.mask_of p = Slot_key.Family.full_mask_of p then
              None
            else Some (m lor Slot_key.Family.mask_of p))
        (Some 0) properties
    in
    (match combined with None -> false | Some m -> m <> full)

(* [Slot_key.family_id_of] IS the real logic (not a re-implementation) for
   "does this property need the extended-hash field" - [Registered]/[All]
   don't, [Unregistered]/[UnregisteredCustom] do. *)
let needs_extended property =
  match Slot_key.family_id_of property with
  | Slot_key.Registered _ | Slot_key.All -> false
  | Slot_key.Unregistered _ | Slot_key.UnregisteredCustom _ -> true

let row_of ~context ~old_len ~properties =
  match properties with
  | [] -> None
  | first :: _ ->
    let mask_needed = group_needs_mask properties in
    let extended_needed = needs_extended first in
    Some
      {
        old_length = old_len;
        new_length =
          new_length ~has_context:context ~mask_needed ~extended_needed;
        context;
        mask = mask_needed;
        extended = extended_needed;
        bundle = false;
      }

let body_between line class_end =
  let body_start =
    try 1 + String.index_from line class_end '{' with Not_found -> class_end
  in
  let body_end =
    try String.rindex line '}' with Not_found -> String.length line
  in
  String.sub line body_start (max 0 (body_end - body_start))

let analyze_line line : row option =
  if String.length line = 0 then None
  else (
    match find_class_token line with
    | Some (_, len, true) ->
      (* A bundle atom is already real (see Hash_class.
         bundle_class_and_namespace) - measure it as-is, no delta. *)
      Some
        {
          old_length = len;
          new_length = len;
          context = false;
          mask = false;
          extended = false;
          bundle = true;
        }
    | Some (start, len, false) ->
      if
        line.[0] = '@'
        && not (String.length line >= 10 && String.sub line 0 10 = "@property ")
      then (
        (* A single-line at-rule wrapper (this corpus's shape, e.g.
           "@media (...){height: auto;}") - context is always present. *)
        let properties =
          body_between line (start + len)
          |> properties_in_body
          |> List.map Slot_key.normalize_property
        in
        row_of ~context:true ~old_len:len ~properties)
      else (
        let class_end = start + len in
        let ctx = has_context line class_end in
        let properties =
          body_between line class_end
          |> properties_in_body
          |> List.map Slot_key.normalize_property
        in
        row_of ~context:ctx ~old_len:len ~properties)
    | None -> None)

let read_lines path =
  let ic = open_in path in
  let rec loop acc =
    match input_line ic with
    | line -> loop (line :: acc)
    | exception End_of_file ->
      close_in ic;
      List.rev acc
  in
  loop []

let () =
  match Sys.argv with
  | [| _; corpus_path; rewritten_out_path |] ->
    let lines = read_lines corpus_path in
    let rows = List.filter_map analyze_line lines in
    let n = List.length rows in
    let sum f = List.fold_left (fun acc r -> acc + f r) 0 rows in
    let old_total = sum (fun r -> r.old_length) in
    let new_total = sum (fun r -> r.new_length) in
    let non_bundle = List.filter (fun r -> not r.bundle) rows in
    let n_nb = List.length non_bundle in
    (* [pct_of] denominator is the group the count is a fraction OF - the
       four css-/csi- breakdowns below are fractions of [n_nb] (the non-
       bundle atoms), not of [n] (all atoms including bundles), which was a
       real bug caught while writing up the checkpoint numbers: it silently
       made every one of those four percentages read low, since [n] > [n_nb]
       whenever any bundle atoms exist at all. *)
    let pct_of denom k = 100. *. float_of_int k /. float_of_int denom in
    let pct = pct_of n in
    let pct_nb = pct_of n_nb in
    let base_count =
      List.length
        (List.filter
           (fun r -> (not r.context) && (not r.mask) && not r.extended)
           non_bundle)
    in
    let context_count =
      List.length (List.filter (fun r -> r.context) non_bundle)
    in
    let mask_count = List.length (List.filter (fun r -> r.mask) non_bundle) in
    let extended_count =
      List.length (List.filter (fun r -> r.extended) non_bundle)
    in
    let bundle_count = List.length (List.filter (fun r -> r.bundle) rows) in
    Printf.printf
      "atoms analyzed: %d (%d css-/csi-, %d already-real csv- bundles)\n" n n_nb
      bundle_count;
    Printf.printf "old total class-name chars: %d (avg %.2f)\n" old_total
      (float_of_int old_total /. float_of_int n);
    Printf.printf "new total class-name chars: %d (avg %.2f)\n" new_total
      (float_of_int new_total /. float_of_int n);
    Printf.printf "delta: %+d chars (%+.2f avg/atom)\n" (new_total - old_total)
      (float_of_int (new_total - old_total) /. float_of_int n);
    Printf.printf "of the %d css-/csi- (non-bundle) atoms:\n" n_nb;
    Printf.printf "  base (no context, no mask, no extended): %d (%.1f%%)\n"
      base_count (pct_nb base_count);
    Printf.printf "  non-base context: %d (%.1f%%)\n" context_count
      (pct_nb context_count);
    Printf.printf "  needs a mask token: %d (%.1f%%)\n" mask_count
      (pct_nb mask_count);
    Printf.printf
      "  needs the extended-hash field (unregistered/custom): %d (%.1f%%)\n"
      extended_count (pct_nb extended_count);
    Printf.printf
      "bundle (csv-, already real, measured as-is, no delta): %d (%.1f%%)\n"
      bundle_count (pct bundle_count);
    (* Rewrite the corpus with each old class token replaced by a
       placeholder of the NEW computed length, same prefix ("css-"/"csi-"
       preserved), so the caller can gzip old vs new. Each field is hashed
       SEPARATELY at its own real width (context<=4, family/mask<=3,
       value<=5), mirroring how [Class_format.slot_class] actually builds a
       class name field by field, rather than one combined hash: a single
       hash over a >12-char width overflows OCaml's native int well before
       reaching it (36^15 is far past the 63-bit range), and produces a
       biased, leading-zero-heavy result that would make the placeholders
       LESS realistic (more repetition, so gzip would again understate the
       real cost) than genuinely independent per-field hashes are. *)
    let oc = open_out rewritten_out_path in
    List.iter
      (fun line ->
        match find_class_token line, analyze_line line with
        | Some (_, _, _), Some row when row.bundle ->
          (* Already real - copy through unchanged. *)
          output_string oc line;
          output_char oc '\n'
        | Some (start, len, false), Some row ->
          let prefix = String.sub line start 4 in
          let field ~width tag =
            Class_format.hashed_field ~width (line ^ tag)
          in
          let placeholder =
            prefix
            ^ (if row.context then field ~width:Class_format.context_width "ctx"
               else "")
            ^ field ~width:Class_format.family_width "fam"
            ^ (if row.extended then
                 field ~width:Class_format.extended_width "ext"
               else "")
            ^ (if row.mask then field ~width:Class_format.mask_width "mask"
               else "")
            ^ field ~width:Class_format.value_width "val"
          in
          assert (String.length placeholder = row.new_length);
          output_string oc (String.sub line 0 start);
          output_string oc placeholder;
          output_string oc
            (String.sub line (start + len) (String.length line - start - len));
          output_char oc '\n'
        | _ ->
          output_string oc line;
          output_char oc '\n')
      lines;
    close_out oc
  | _ ->
    prerr_endline "usage: measure.exe <corpus-file> <rewritten-output-file>";
    exit 1
