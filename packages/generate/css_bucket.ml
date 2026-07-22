(** Deterministic bucket ordering for extracted atomic CSS.

    Every atomized rule carries a single class selector, so equal-specificity
    conflicts are resolved purely by stylesheet position. Without sorting,
    that position is "first occurrence across the whole build" — a function
    of file order and compilation accidents, not of the rule itself. This
    module assigns every rendered rule a sort key derived from the rule
    alone, so the emitted stylesheet order is stable under refactors and
    encodes the precedence users actually expect (pseudo-classes override
    base, `@media` overrides unconditional styles, wider `min-width` wins).

    Design: documents/atomic-css-ordering.md. Bucket taxonomy:

    {v
    0  @property registrations          (order-independent)
    1  @keyframes                       (referenced by name)
    2  globals                          (non-atomic rules; author-ordered)
    3  atomic base                      (no pseudo)
    4  atomic structural pseudos        (:nth-child, :first-child, ...)
    5  :link          |
    6  :visited       |
    7  :focus-within  |
    8  :hover         |  LVFHA-extended
    9  :focus         |
    10 :focus-visible |
    11 :active        |
    12 pseudo-elements (::before, ...)
    13 @supports { atomic }
    14 @media    { atomic }             (sorted by breakpoint)
    15 @container{ atomic }             (sorted by breakpoint)
    16 @starting-style { atomic }
    v}

    Within a bucket the sort is *stable*: rules with equal keys keep their
    first-occurrence order, preserving the documented "define base styles
    before overrides" convention (see the runtime docs, "Merging"). The
    hash tiebreak arrives with phase 2, together with property-keyed
    [CSS.merge].

    Classification is syntactic, over the rendered rule string. Atomic rules
    are recognized by their [".css-"] selector prefix; everything else
    (including [%styled.global] output, even when it targets a [".css-"]
    class through selector interpolation deeper in the selector) stays in
    the globals bucket in author order. If string classification ever proves
    too coarse, the plan is to carry an explicit bucket tag in the
    [[\@\@\@css ...]] wire protocol instead (computed from the AST in
    [Css_file], where classification is exact). *)

type sort_mode =
  | Source  (** Legacy first-occurrence order. One-release escape hatch. *)
  | Buckets  (** Deterministic bucket order. Default. *)

let sort_mode_of_string = function
  | "source" -> Some Source
  | "buckets" -> Some Buckets
  | _ -> None

(** Sort key, compared lexicographically. [limit]/[magnitude] are only
    populated for `@media`/`@container` buckets: [limit] is 0 for
    [min-width]-style lower bounds (sorted ascending — mobile-first, wider
    wins), 1 for [max-width]-style upper bounds (sorted descending via
    negated magnitude — desktop-first, narrower wins), 2 for conditions we
    don't parse (kept in first-occurrence order after the parsed ones).
    [pseudo] orders atoms inside one conditional bucket by the same
    pseudo-class ranking as buckets 3-12, so `@media { &:hover }` still
    beats `@media { & }` at the same breakpoint. *)
type key = {
  bucket : int;
  limit : int;
  magnitude : float;
  pseudo : int;
}

let compare_key a b =
  match compare a.bucket b.bucket with
  | 0 ->
    (match compare a.limit b.limit with
    | 0 ->
      (match compare a.magnitude b.magnitude with
      | 0 -> compare a.pseudo b.pseudo
      | c -> c)
    | c -> c)
  | c -> c

let registrations_bucket = 0
let keyframes_bucket = 1
let globals_bucket = 2
let atomic_base_bucket = 3
let supports_bucket = 13
let media_bucket = 14
let container_bucket = 15
let starting_style_bucket = 16

let plain_key bucket = { bucket; limit = 0; magnitude = 0.; pseudo = 0 }

(* -- Selector analysis ---------------------------------------------------- *)

let is_ident_char = function
  | 'a' .. 'z' | 'A' .. 'Z' | '0' .. '9' | '-' | '_' -> true
  | _ -> false

(* Pseudo ranks, offsets from [atomic_base_bucket]. *)
let rank_base = 0
let rank_structural = 1
let rank_pseudo_element = 9

let rank_of_pseudo_class = function
  | "link" -> 2
  | "visited" -> 3
  | "focus-within" -> 4
  | "hover" -> 5
  | "focus" -> 6
  | "focus-visible" -> 7
  | "active" -> 8
  (* CSS2 pseudo-elements are valid with a single colon. *)
  | "before" | "after" | "first-line" | "first-letter" -> rank_pseudo_element
  | _ -> rank_structural

(** Highest pseudo rank found anywhere in [selector]. Scans left to right,
    skipping attribute-selector bodies and quoted strings; contents of
    functional pseudo-classes are scanned too, so [:not(:hover)] ranks as
    hover (it flips on the same user interaction). *)
let pseudo_rank selector =
  let n = String.length selector in
  let rank = ref rank_base in
  let i = ref 0 in
  let bracket_depth = ref 0 in
  let skip_string quote =
    incr i;
    while !i < n && selector.[!i] <> quote do incr i done;
    if !i < n then incr i
  in
  while !i < n do
    match selector.[!i] with
    | '[' ->
      incr bracket_depth;
      incr i
    | ']' ->
      if !bracket_depth > 0 then decr bracket_depth;
      incr i
    | ('"' | '\'') as quote -> skip_string quote
    | _ when !bracket_depth > 0 -> incr i
    | ':' ->
      if !i + 1 < n && selector.[!i + 1] = ':' then begin
        rank := max !rank rank_pseudo_element;
        i := !i + 2
      end
      else begin
        let start = !i + 1 in
        let j = ref start in
        while !j < n && is_ident_char selector.[!j] do incr j done;
        let name =
          String.lowercase_ascii (String.sub selector start (!j - start))
        in
        if name <> "" then rank := max !rank (rank_of_pseudo_class name);
        i := max !j (start + 1)
      end
    | _ -> incr i
  done;
  !rank

(** Atomic rules target a class the PPX minted: the selector starts with
    [".css-"] (optionally suffixed with a dev label and followed by
    combinators/pseudos). Author-written selectors — [%styled.global] output —
    keep their source order in the globals bucket instead. *)
let is_atomic_selector selector =
  String.starts_with ~prefix:".css-" (String.trim selector)

(* -- Rule-string structure ------------------------------------------------ *)

(** [@media (...) { ... ]  ->  ["media"], and the prelude between the
    at-keyword and the opening brace. *)
let at_keyword_and_prelude rule =
  let n = String.length rule in
  let j = ref 1 in
  while !j < n && is_ident_char rule.[!j] do incr j done;
  let keyword = String.lowercase_ascii (String.sub rule 1 (!j - 1)) in
  match String.index_from_opt rule !j '{' with
  | None -> keyword, ""
  | Some brace -> keyword, String.sub rule !j (brace - !j)

(** Innermost selector of a (possibly nested) at-rule-wrapped rule:
    ["@supports (...) {@media (...) {.css-x{...}}}"] -> [".css-x"]. *)
let rec innermost_selector rule =
  let rule = String.trim rule in
  if rule = "" then ""
  else if rule.[0] = '@' then (
    match String.index_opt rule '{' with
    | None -> ""
    | Some brace ->
      innermost_selector
        (String.sub rule (brace + 1) (String.length rule - brace - 1)))
  else (
    match String.index_opt rule '{' with
    | None -> rule
    | Some brace -> String.trim (String.sub rule 0 brace))

(* -- Breakpoint parsing --------------------------------------------------- *)

let find_substring haystack needle =
  let h = String.length haystack and n = String.length needle in
  let rec go i =
    if i + n > h then None
    else if String.sub haystack i n = needle then Some i
    else go (i + 1)
  in
  go 0

(** Parse ["400px"], ["40em"], ["40rem"] (or a bare number) starting at the
    first digit at/after [i]; returns the value in px. [em]/[rem] convert at
    the 16px default root font size — only relative order matters. Unknown
    units are unparseable (breakpoint comparisons across e.g. [vw] and [px]
    are not meaningful). *)
let parse_px source i =
  let n = String.length source in
  let i = ref i in
  while
    !i < n && not (match source.[!i] with '0' .. '9' -> true | _ -> false)
  do
    incr i
  done;
  if !i >= n then None
  else begin
    let start = !i in
    while
      !i < n
      && (match source.[!i] with '0' .. '9' | '.' -> true | _ -> false)
    do
      incr i
    done;
    let value = float_of_string_opt (String.sub source start (!i - start)) in
    let unit_start = !i in
    while !i < n && is_ident_char source.[!i] do incr i done;
    let unit =
      String.lowercase_ascii (String.sub source unit_start (!i - unit_start))
    in
    match value, unit with
    | Some v, ("px" | "") -> Some v
    | Some v, ("em" | "rem") -> Some (v *. 16.)
    | _ -> None
  end

(** Breakpoint key of a `@media`/`@container` prelude. Handles the common
    single-bound forms: [(min-width: N)], [(max-width: N)] and range syntax
    with `width` on the left ([(width >= N)], [(width > N)], [(width <= N)],
    [(width < N)]). Combined ranges classify by their lower bound
    (mobile-first). Anything else — [print], [orientation], reversed range
    syntax, non-length units — is (2, 0.): after the parsed breakpoints, in
    first-occurrence order. *)
let breakpoint_key prelude =
  let parse_after anchor =
    Option.bind (find_substring prelude anchor) (fun i ->
      parse_px prelude (i + String.length anchor))
  in
  let range_bound () =
    Option.bind (find_substring prelude "width") (fun i ->
      (* Reject min-width/max-width matching the bare "width" probe. *)
      if i > 0 && prelude.[i - 1] = '-' then None
      else begin
        let n = String.length prelude in
        let j = ref (i + String.length "width") in
        while !j < n && prelude.[!j] = ' ' do incr j done;
        if !j >= n then None
        else (
          match prelude.[!j] with
          | '>' -> Option.map (fun v -> 0, v) (parse_px prelude (!j + 1))
          | '<' -> Option.map (fun v -> 1, -.v) (parse_px prelude (!j + 1))
          | _ -> None)
      end)
  in
  match parse_after "min-width" with
  | Some v -> 0, v
  | None ->
    (match parse_after "max-width" with
    | Some v -> 1, -.v
    | None -> (match range_bound () with Some k -> k | None -> 2, 0.))

(* -- Classification ------------------------------------------------------- *)

let key_of_rule rule =
  let rule = String.trim rule in
  if rule = "" then plain_key globals_bucket
  else if rule.[0] = '@' then begin
    let keyword, prelude = at_keyword_and_prelude rule in
    match keyword with
    | "property" -> plain_key registrations_bucket
    | "keyframes" -> plain_key keyframes_bucket
    | "media" | "supports" | "container" | "starting-style" ->
      let selector = innermost_selector rule in
      if is_atomic_selector selector then begin
        let bucket =
          match keyword with
          | "supports" -> supports_bucket
          | "media" -> media_bucket
          | "container" -> container_bucket
          | _ -> starting_style_bucket
        in
        let limit, magnitude =
          if bucket = media_bucket || bucket = container_bucket then
            breakpoint_key prelude
          else 0, 0.
        in
        { bucket; limit; magnitude; pseudo = pseudo_rank selector }
      end
      else plain_key globals_bucket
    | _ ->
      (* @font-face and anything else the PPX lets through: global,
         author-ordered, order-independent in practice. *)
      plain_key globals_bucket
  end
  else begin
    let selector =
      match String.index_opt rule '{' with
      | None -> rule
      | Some brace -> String.sub rule 0 brace
    in
    if is_atomic_selector selector then
      plain_key (atomic_base_bucket + pseudo_rank selector)
    else plain_key globals_bucket
  end

(** Stable bucket sort: equal keys keep first-occurrence order. *)
let sort rules =
  rules
  |> List.map (fun rule -> key_of_rule rule, rule)
  |> List.stable_sort (fun (a, _) (b, _) -> compare_key a b)
  |> List.map snd
