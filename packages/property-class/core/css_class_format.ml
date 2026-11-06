type prop = Css_class_decode.prop =
  | Id of string
  | Name of string

type decoded = Css_class_decode.decoded =
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

let max_bundle_cells = 4095
let plain_ctx = Css_class_decode.plain_ctx
let decode = Css_class_decode.decode
let tokens = Css_class_decode.tokens
let symbols_at = Css_class_decode.symbols_at
let id_at = Css_class_decode.id_at
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
