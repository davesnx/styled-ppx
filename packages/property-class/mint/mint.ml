module Format_ = Property_class_core.Css_class_format

type hashed = {
  kind : string;
  token : string;
  source : string;
}

let plain_key =
  Context_key.key { scope = "&"; conditions = []; important = false }

let hash_fields fields = Hash64.hash (String.concat "\000" fields)

let escape source =
  let buf = Buffer.create (String.length source) in
  String.iter
    (function
      | '\000' -> Buffer.add_string buf "\\0"
      | '\\' -> Buffer.add_string buf "\\\\"
      | c -> Buffer.add_char buf c)
    source;
  Buffer.contents buf

let hashed kind token fields =
  { kind; token; source = escape (String.concat "\000" fields) }

let context_token key =
  if key = plain_key then Format_.plain_ctx, None
  else (
    let rec attempt n =
      let fields =
        "ctx" :: key :: (if n = 0 then [] else [ string_of_int n ])
      in
      let token = Hash64.chars (hash_fields fields) 6 in
      if token = Format_.plain_ctx then attempt (n + 1) else token, fields
    in
    let token, fields = attempt 0 in
    token, Some fields)

let property_text = function Atomize.Known id | Atomize.Unknown id -> id
let name_token name = Hash64.chars (hash_fields [ "name"; name ]) 6

let prop_of = function
  | Atomize.Known id -> Format_.Id id
  | Atomize.Unknown name -> Format_.Name (name_token name)

let first = function
  | piece :: _ -> piece
  | [] -> invalid_arg "Mint: unit without pieces"

type cell = {
  property : Atomize.property;
  key : string;
}

let cells (unit_ : Atomize.unit_) =
  List.fold_left
    (fun acc (piece : Atomize.decl) ->
      let cell =
        {
          property = Atomize.property piece.prop;
          key = Context_key.key piece.context;
        }
      in
      if List.mem cell acc then acc else cell :: acc)
    [] unit_.pieces
  |> List.rev

let value_fields (unit_ : Atomize.unit_) =
  if unit_.bundle then
    "bval"
    :: List.concat_map
         (fun (piece : Atomize.decl) ->
           [
             Context_key.key piece.context;
             property_text (Atomize.property piece.prop);
             piece.text;
           ])
         unit_.pieces
  else (
    let head = first unit_.pieces in
    "val"
    :: property_text (Atomize.property head.prop)
    :: Context_key.key head.context
    :: List.map (fun (piece : Atomize.decl) -> piece.text) unit_.pieces)

let bundle_token cells value =
  Format_.encode_bundle
    ~cells:
      (List.map
         (fun cell -> prop_of cell.property, fst (context_token cell.key))
         cells)
    ~value

let token (unit_ : Atomize.unit_) =
  let head = first unit_.pieces in
  let value = Hash64.chars (hash_fields (value_fields unit_)) 6 in
  if unit_.bundle then bundle_token (cells unit_) value
  else (
    let ctx, _ = context_token (Context_key.key head.context) in
    Format_.encode_atom ~prop:(prop_of (Atomize.property head.prop)) ~ctx ~value)

let hashes (unit_ : Atomize.unit_) =
  let head = first unit_.pieces in
  let value_fields = value_fields unit_ in
  let value =
    hashed "value" (Hash64.chars (hash_fields value_fields) 6) value_fields
  in
  let cells =
    if unit_.bundle then cells unit_
    else
      [
        {
          property = Atomize.property head.prop;
          key = Context_key.key head.context;
        };
      ]
  in
  let add acc h = if List.mem h acc then acc else h :: acc in
  let contexts =
    List.fold_left
      (fun acc cell ->
        match context_token cell.key with
        | _, None -> acc
        | token, Some fields -> add acc (hashed "ctx" token fields))
      [] cells
    |> List.rev
  in
  let names =
    List.fold_left
      (fun acc cell ->
        match cell.property with
        | Atomize.Unknown name ->
          add acc (hashed "name" (name_token name) [ "name"; name ])
        | Atomize.Known _ -> acc)
      [] cells
    |> List.rev
  in
  contexts @ names @ [ value ]
