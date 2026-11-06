type prop =
  | Id of string
  | Name of string

type decoded =
  | Atom of {
      prop : prop;
      ctx : string;
      value : string;
    }
  | Bundle of {
      cells : (prop * string) list;
      value : string;
    }
  | Binding_id of string
  | Foreign

let alphabet =
  "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_-"

let plain_ctx = "000000"
let max_bundle_cells = 4095

let is_symbol c =
  (c >= 'A' && c <= 'Z')
  || (c >= 'a' && c <= 'z')
  || (c >= '0' && c <= '9')
  || c = '_'
  || c = '-'

let is_base36 c = (c >= '0' && c <= '9') || (c >= 'a' && c <= 'z')

let symbol_index c =
  if c >= 'A' && c <= 'Z' then Char.code c - 65
  else if c >= 'a' && c <= 'z' then Char.code c - 97 + 26
  else if c >= '0' && c <= '9' then Char.code c - 48 + 52
  else if c = '_' then 62
  else 63

let symbols_at s pos len =
  let stop = pos + len in
  let rec go i =
    i >= stop || (is_symbol (String.unsafe_get s i) && go (i + 1))
  in
  go pos

let id_at s pos =
  is_base36 (String.unsafe_get s pos)
  && is_base36 (String.unsafe_get s (pos + 1))
  && not (String.unsafe_get s pos = 'z' && String.unsafe_get s (pos + 1) = 'z')

let decode_bundle token width =
  let count = (symbol_index token.[2] * 64) + symbol_index token.[3] in
  let value_at = width - 6 in
  let rec cells k pos acc =
    if k = count then if pos = value_at then Some (List.rev acc) else None
    else if pos + 8 > value_at then None
    else if token.[pos] = 'z' && token.[pos + 1] = 'z' then
      if pos + 14 <= value_at && symbols_at token (pos + 2) 12 then
        cells (k + 1) (pos + 14)
          ((Name (String.sub token (pos + 2) 6), String.sub token (pos + 8) 6)
          :: acc)
      else None
    else if id_at token pos && symbols_at token (pos + 2) 6 then
      cells (k + 1) (pos + 8)
        ((Id (String.sub token pos 2), String.sub token (pos + 2) 6) :: acc)
    else None
  in
  if
    count < 1
    || (not (symbols_at token 2 2))
    || not (symbols_at token value_at 6)
  then Foreign
  else (
    match cells 0 4 [] with
    | Some cells -> Bundle { cells; value = String.sub token value_at 6 }
    | None -> Foreign)

let decode token =
  let width = String.length token in
  if width < 10 || String.unsafe_get token 0 <> '_' then Foreign
  else (
    match String.unsafe_get token 1 with
    | 'a' when width = 10 && id_at token 2 && symbols_at token 4 6 ->
      Atom
        {
          prop = Id (String.sub token 2 2);
          ctx = plain_ctx;
          value = String.sub token 4 6;
        }
    | 'c' when width = 16 && id_at token 2 && symbols_at token 4 12 ->
      Atom
        {
          prop = Id (String.sub token 2 2);
          ctx = String.sub token 4 6;
          value = String.sub token 10 6;
        }
    | 'x' when width = 20 && symbols_at token 2 18 ->
      Atom
        {
          prop = Name (String.sub token 2 6);
          ctx = String.sub token 8 6;
          value = String.sub token 14 6;
        }
    | 'i' when width = 10 && symbols_at token 2 8 ->
      Binding_id (String.sub token 2 8)
    | 'b' when width >= 18 -> decode_bundle token width
    | _ -> Foreign)

let check what ok = if not ok then invalid_arg ("Css_class_format." ^ what)

let check_symbols what s len =
  check what (String.length s = len && symbols_at s 0 len)

let check_id id = check "pid" (String.length id = 2 && id_at id 0)

let encode_atom ~prop ~ctx ~value =
  check_symbols "ctx" ctx 6;
  check_symbols "value" value 6;
  match prop with
  | Id id ->
    check_id id;
    if ctx = plain_ctx then "_a" ^ id ^ value else "_c" ^ id ^ ctx ^ value
  | Name name ->
    check_symbols "name" name 6;
    "_x" ^ name ^ ctx ^ value

let encode_bundle ~cells ~value =
  let count = List.length cells in
  check "bundle cell count" (count >= 1 && count <= max_bundle_cells);
  check_symbols "value" value 6;
  let buf = Buffer.create (10 + (8 * count)) in
  Buffer.add_string buf "_b";
  Buffer.add_char buf alphabet.[count / 64];
  Buffer.add_char buf alphabet.[count mod 64];
  List.iter
    (fun (prop, ctx) ->
      check_symbols "ctx" ctx 6;
      match prop with
      | Id id ->
        check_id id;
        Buffer.add_string buf id;
        Buffer.add_string buf ctx
      | Name name ->
        check_symbols "name" name 6;
        Buffer.add_string buf "zz";
        Buffer.add_string buf name;
        Buffer.add_string buf ctx)
    cells;
  Buffer.add_string buf value;
  Buffer.contents buf

let encode_binding_id id =
  check_symbols "binding id" id 8;
  "_i" ^ id

let tokens s = List.filter (fun t -> t <> "") (String.split_on_char ' ' s)
