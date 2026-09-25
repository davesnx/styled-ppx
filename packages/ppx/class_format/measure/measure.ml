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
  (* First ".css-..." or ".csi-..." token in the line (there is at most one
     real atom class per corpus line - see merge-order-flip-under-dedup.md's
     "one line per rule" observation about this exact corpus). *)
  let n = String.length line in
  let has_prefix i p =
    let m = String.length p in
    i + m <= n && String.sub line i m = p
  in
  let rec scan i =
    if i >= n then None
    else if
      line.[i] = '.' && (has_prefix (i + 1) "css-" || has_prefix (i + 1) "csi-")
    then (
      let start = i + 1 in
      let j = ref (start + 4) in
      while !j < n && is_class_char line.[!j] do
        incr j
      done;
      Some (start, !j - start))
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

let new_length ~has_context ~mask_needed =
  Class_format.value_width
  + Class_format.family_width
  + (if has_context then Class_format.context_width else 0)
  + (if mask_needed then Class_format.mask_width else 0)
  + 4 (* "css-"/"csi-" *)

type row = {
  old_length : int;
  new_length : int;
  context : bool;
  mask : bool;
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

let row_of ~context ~old_len ~properties =
  match properties with
  | [] -> None
  | _ :: _ ->
    let mask_needed = group_needs_mask properties in
    Some
      {
        old_length = old_len;
        new_length = new_length ~has_context:context ~mask_needed;
        context;
        mask = mask_needed;
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
  else if
    line.[0] = '@'
    && not (String.length line >= 10 && String.sub line 0 10 = "@property ")
  then (
    (* A single-line at-rule wrapper (this corpus's shape, e.g.
       "@media (...){height: auto;}") - context is always present. *)
    match find_class_token line with
    | None -> None
    | Some (start, len) ->
      let properties =
        body_between line (start + len)
        |> properties_in_body
        |> List.map Slot_key.normalize_property
      in
      row_of ~context:true ~old_len:len ~properties)
  else (
    match find_class_token line with
    | None -> None
    | Some (start, len) ->
      let class_end = start + len in
      let ctx = has_context line class_end in
      let properties =
        body_between line class_end
        |> properties_in_body
        |> List.map Slot_key.normalize_property
      in
      row_of ~context:ctx ~old_len:len ~properties)

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
    let base_count =
      List.length (List.filter (fun r -> (not r.context) && not r.mask) rows)
    in
    let context_count = List.length (List.filter (fun r -> r.context) rows) in
    let mask_count = List.length (List.filter (fun r -> r.mask) rows) in
    Printf.printf "atoms analyzed: %d\n" n;
    Printf.printf "old total class-name chars: %d (avg %.2f)\n" old_total
      (float_of_int old_total /. float_of_int n);
    Printf.printf "new total class-name chars: %d (avg %.2f)\n" new_total
      (float_of_int new_total /. float_of_int n);
    Printf.printf "delta: %+d chars (%+.2f avg/atom)\n" (new_total - old_total)
      (float_of_int (new_total - old_total) /. float_of_int n);
    Printf.printf "base (no context, no mask): %d (%.1f%%)\n" base_count
      (100. *. float_of_int base_count /. float_of_int n);
    Printf.printf "non-base context: %d (%.1f%%)\n" context_count
      (100. *. float_of_int context_count /. float_of_int n);
    Printf.printf "needs a mask token: %d (%.1f%%)\n" mask_count
      (100. *. float_of_int mask_count /. float_of_int n);
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
        | Some (start, len), Some row ->
          let prefix = String.sub line start 4 in
          let field ~width tag =
            Class_format.hashed_field ~width (line ^ tag)
          in
          let placeholder =
            prefix
            ^ (if row.context then field ~width:Class_format.context_width "ctx"
               else "")
            ^ field ~width:Class_format.family_width "fam"
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
