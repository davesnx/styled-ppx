type context = {
  scope : string;
  conditions : string list;
  important : bool;
}

let is_space c =
  c = ' ' || c = '\t' || c = '\n' || c = '\r' || c = '\011' || c = '\012'

let is_name_char c =
  (c >= 'a' && c <= 'z')
  || (c >= 'A' && c <= 'Z')
  || (c >= '0' && c <= '9')
  || c = '-'
  || c = '_'

let skip_quoted text i =
  let len = String.length text in
  let q = text.[i] in
  let rec go j =
    if j >= len then len
    else if text.[j] = '\\' then go (j + 2)
    else if text.[j] = q then j + 1
    else go (j + 1)
  in
  go (i + 1)

let lowercase_range text start stop =
  String.sub text start (stop - start) |> String.lowercase_ascii

let lowercase_features condition =
  let len = String.length condition in
  let buf = Buffer.create len in
  let rec go i =
    if i < len then (
      match condition.[i] with
      | '"' | '\'' ->
        let stop = min len (skip_quoted condition i) in
        Buffer.add_string buf (String.sub condition i (stop - i));
        go stop
      | '(' when i = 0 || not (is_name_char condition.[i - 1]) ->
        let rec space j =
          if j < len && is_space condition.[j] then space (j + 1) else j
        in
        let start = space (i + 1) in
        let rec name j =
          if j < len && is_name_char condition.[j] then name (j + 1) else j
        in
        let stop = name start in
        let next = space stop in
        let feature =
          stop > start
          && (not (stop - start >= 2 && String.sub condition start 2 = "--"))
          && next < len
          && String.contains ":)<>=" condition.[next]
        in
        Buffer.add_string buf (String.sub condition i (start - i));
        Buffer.add_string buf
          (if feature then lowercase_range condition start stop
           else String.sub condition start (stop - start));
        go stop
      | c ->
        Buffer.add_char buf c;
        go (i + 1))
  in
  go 0;
  Buffer.contents buf

let canonical_spaces condition =
  let len = String.length condition in
  let buf = Buffer.create len in
  let rec go i pending =
    if i < len then
      if is_space condition.[i] then go (i + 1) true
      else begin
        let c = condition.[i] in
        let last =
          if Buffer.length buf = 0 then '('
          else Buffer.nth buf (Buffer.length buf - 1)
        in
        if
          pending
          && (not (String.contains "(:," last))
          && not (String.contains "):," c)
        then Buffer.add_char buf ' ';
        let stop =
          if c = '"' || c = '\'' then min len (skip_quoted condition i)
          else i + 1
        in
        Buffer.add_string buf (String.sub condition i (stop - i));
        go stop false
      end
  in
  go 0 false;
  Buffer.contents buf

let canonical_condition condition =
  canonical_spaces (lowercase_features condition)

let is_pseudo_char c = (c >= 'a' && c <= 'z') || c = '-'
let legacy_pseudo_elements = [ "after"; "before"; "first-letter"; "first-line" ]

let word_end selector i =
  let len = String.length selector in
  let rec word j =
    if j < len && is_pseudo_char selector.[j] then word (j + 1) else j
  in
  word i

let is_legacy_pseudo_element selector i =
  selector.[i] = ':'
  && (i = 0 || selector.[i - 1] <> ':')
  && List.mem
       (String.sub selector (i + 1) (word_end selector (i + 1) - i - 1))
       legacy_pseudo_elements

let pseudo_suffix_from selector start =
  let len = String.length selector in
  let rec pseudo i =
    i < len
    && selector.[i] = ':'
    && i + 1 < len
    && is_pseudo_char selector.[i + 1]
    && (not (is_legacy_pseudo_element selector i))
    &&
    let stop = word_end selector (i + 1) in
    stop = len || pseudo stop
  in
  pseudo start

let lowercase_pseudo_names selector =
  let len = String.length selector in
  let buf = Buffer.create len in
  let rec go i depth =
    if i < len then (
      match selector.[i] with
      | '\\' ->
        let stop = min len (i + 2) in
        Buffer.add_string buf (String.sub selector i (stop - i));
        go stop depth
      | '"' | '\'' ->
        let stop = min len (skip_quoted selector i) in
        Buffer.add_string buf (String.sub selector i (stop - i));
        go stop depth
      | '[' ->
        Buffer.add_char buf '[';
        go (i + 1) (depth + 1)
      | ']' ->
        Buffer.add_char buf ']';
        go (i + 1) (depth - 1)
      | ':' when depth = 0 ->
        let start =
          if i + 1 < len && selector.[i + 1] = ':' then i + 2 else i + 1
        in
        let rec name j =
          if j < len && is_name_char selector.[j] then name (j + 1) else j
        in
        let stop = name start in
        Buffer.add_string buf (String.sub selector i (start - i));
        Buffer.add_string buf (lowercase_range selector start stop);
        go stop depth
      | c ->
        Buffer.add_char buf c;
        go (i + 1) depth)
  in
  go 0 0;
  Buffer.contents buf

let normalize_selector selector =
  let selector = lowercase_pseudo_names selector in
  let len = String.length selector in
  let rec first i =
    if i >= len || is_legacy_pseudo_element selector i then None
    else if pseudo_suffix_from selector i then Some i
    else first (i + 1)
  in
  match first 0 with
  | Some i when i = 0 || selector.[i - 1] <> ':' ->
    let pseudos =
      String.sub selector i (len - i)
      |> String.split_on_char ':'
      |> List.filter (fun p -> p <> "")
      |> List.sort String.compare
    in
    String.sub selector 0 i
    ^ String.concat "" (List.map (fun p -> ":" ^ p) pseudos)
  | _ -> selector

let normalize_scope scope =
  match String.index_opt scope '\000' with
  | None -> normalize_selector scope
  | Some i ->
    normalize_selector (String.sub scope 0 i)
    ^ String.sub scope i (String.length scope - i)

let key { scope; conditions; important } =
  String.concat " | "
    (normalize_scope scope
     :: List.sort String.compare (List.map canonical_condition conditions)
    @ [ (if important then "!important" else "") ])
