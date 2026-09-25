let base36_chars = "0123456789abcdefghijklmnopqrstuvwxyz"

let to_base36_padded ~width n =
  let buf = Bytes.make width '0' in
  let rec fill i n =
    if i >= 0 then (
      Bytes.set buf i base36_chars.[n mod 36];
      fill (i - 1) (n / 36))
  in
  fill (width - 1) n;
  Bytes.unsafe_to_string buf

let pow36 width =
  let rec go acc n = if n = 0 then acc else go (acc * 36) (n - 1) in
  go 1 width

let hashed_field ~width s =
  to_base36_padded ~width (Murmur2.default_int s mod pow36 width)

let context_width = 4
let family_width = 3
let mask_width = 3
let value_width = 5

let slot_class (slot : Slot_key.t) content =
  let prefix = if slot.important then "csi" else "css" in
  let context_part =
    let key = Slot_key.context_key slot.context in
    if key = "" then "" else hashed_field ~width:context_width key
  in
  let family_part =
    to_base36_padded ~width:family_width (Slot_key.family_id_to_int slot.family)
  in
  let mask_part =
    match slot.mask with
    | None -> ""
    | Some m -> to_base36_padded ~width:mask_width m
  in
  let value_part = hashed_field ~width:value_width content in
  Printf.sprintf "%s-%s%s%s%s" prefix context_part family_part mask_part
    value_part
