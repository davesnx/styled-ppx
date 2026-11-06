type context = {
  scope : string;
  conditions : string list;
  important : bool;
}

let is_space c =
  c = ' ' || c = '\t' || c = '\n' || c = '\r' || c = '\011' || c = '\012'

let is_punctuation c = c = '(' || c = ')' || c = ',' || c = ':'

let normalize_condition condition =
  let buf = Buffer.create (String.length condition) in
  let len = String.length condition in
  let i = ref 0 in
  while !i < len do
    if is_space condition.[!i] then begin
      while !i < len && is_space condition.[!i] do
        incr i
      done;
      let after_punctuation =
        Buffer.length buf > 0
        && is_punctuation (Buffer.nth buf (Buffer.length buf - 1))
      in
      let before_punctuation = !i < len && is_punctuation condition.[!i] in
      if not (after_punctuation || before_punctuation) then
        Buffer.add_char buf ' '
    end
    else begin
      Buffer.add_char buf condition.[!i];
      incr i
    end
  done;
  String.trim (Buffer.contents buf)

let is_pseudo_char c = (c >= 'a' && c <= 'z') || c = '-'

let pseudo_suffix_from selector start =
  let len = String.length selector in
  let rec pseudo i =
    i < len
    && selector.[i] = ':'
    && i + 1 < len
    && is_pseudo_char selector.[i + 1]
    &&
    let rec word j =
      if j < len && is_pseudo_char selector.[j] then word (j + 1) else j
    in
    let stop = word (i + 1) in
    stop = len || pseudo stop
  in
  pseudo start

let normalize_selector selector =
  let len = String.length selector in
  let rec first i =
    if i >= len then None
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
     :: List.sort String.compare (List.map normalize_condition conditions)
    @ [ (if important then "!important" else "") ])
