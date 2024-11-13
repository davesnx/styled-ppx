let char_map_36 = "0123456789abcdefghijklmnopqrstuvwxyz"

let to_base36 n =
  let rec convert_to_base36 acc n =
    if n = 0 then acc
    else (
      let quotient = n / 36 in
      let remainder = n mod 36 in
      let char_at_remainder =
        String.make 1 (String.get char_map_36 remainder)
      in
      convert_to_base36 (char_at_remainder :: acc) quotient)
  in
  if n = 0 then "0" else String.concat "" (convert_to_base36 [] n)

let ( lor ) = Int.logor
let ( land ) = Int.logand
let ( lsl ) = Int.shift_left
let ( lxor ) = Int.logxor
let ( lsr ) = Int.shift_right_logical

(* JavaScript uses UTF-16 not UTF-8 *)
let get_utf16_char_codes s =
  let length = String.length s in

  let rec loop i acc =
    if i >= length then List.rev acc
    else (
      let code_length =
        let code = Char.code s.[i] in
        if code land 0x80 = 0 then 1
        else if code land 0xE0 = 0xC0 then 2
        else if code land 0xF0 = 0xE0 then 3
        else if code land 0xF8 = 0xF0 then 4
        else -1
      in
      let mask_char_code c = c land 0x3F in
      match code_length with
      | 1 ->
        (* 1-byte character (ASCII) *)
        loop (i + 1) (Char.code s.[i] :: acc)
      | 2 ->
        (* 2-byte character *)
        let c1 = Char.code s.[i] land 0x07 in
        let c2 = mask_char_code (Char.code s.[i + 1]) in
        let uchar = (c1 lsl 6) lor c2 in
        loop (i + 2) (uchar :: acc)
      | 3 ->
        (* 3-byte character *)
        let c1 = Char.code s.[i] land 0x07 in
        let c2 = mask_char_code (Char.code s.[i + 1]) in
        let c3 = mask_char_code (Char.code s.[i + 2]) in
        let uchar = (c1 lsl 12) lor (c2 lsl 6) lor c3 in
        loop (i + 3) (uchar :: acc)
      | 4 ->
        (* 4-byte character (requires surrogate pair) *)
        let c1 = Char.code s.[i] land 0x07 in
        let c2 = mask_char_code (Char.code s.[i + 1]) in
        let c3 = mask_char_code (Char.code s.[i + 2]) in
        let c4 = mask_char_code (Char.code s.[i + 3]) in
        let uchar = (c1 lsl 18) lor (c2 lsl 12) lor (c3 lsl 6) lor c4 in      
        if uchar > 0xFFFF then (
          let high_surrogate = ((uchar - 0x10000) lsr 10) + 0xD800 in
          let low_surrogate = ((uchar - 0x10000) land 0x3FF) + 0xDC00 in
          loop (i + 4) (low_surrogate :: high_surrogate :: acc))
        else loop (i + 4) (uchar :: acc)
      | _ -> loop (i + code_length) (List.init code_length (fun _ -> 0xFFFD) @ acc))
  in
  try loop 0 [] with _ -> (List.init (String.length s) (fun _ -> 0xFFFD))

(* The murmur2 hashing algorithm is based on @emotion/hash https://github.com/emotion-js/emotion/blob/main/packages/hash/src/index.js *)
let murmur2 str =
  (* 'm' and 'r' are mixing constants generated offline.
     They're not really 'magic', they just happen to work well. *)
  let m = 0x5bd1e995 in
  let r = 24 in

  let mix_int k = Int32.to_int (Int32.mul (Int32.of_int k) (Int32.of_int m)) in

  (* Initialize the hash *)
  let h = ref 0 in
  let i = ref 0 in

  let utf16_values = get_utf16_char_codes str in
  let len = ref (List.length utf16_values) in
  let str_char_code_at = List.nth utf16_values in

  while !len >= 4 do
    let k =
      str_char_code_at !i
      land 0xff
      lor ((str_char_code_at (!i + 1) land 0xff) lsl 8)
      lor ((str_char_code_at (!i + 2) land 0xff) lsl 16)
      lor ((str_char_code_at (!i + 3) land 0xff) lsl 24)
    in
    let k = mix_int k in

    let k =
      Int32.logxor (k |> Int32.of_int)
        (Int32.shift_right_logical (k |> Int32.of_int) r)
      |> Int32.to_int
    in

    h := mix_int k lxor mix_int !h;

    i := !i + 4;
    len := !len - 4
  done;

  (* Handle the last few bytes of the input array *)
  let () =
    if !len = 3 then h := !h lxor ((str_char_code_at (!i + 2) land 0xff) lsl 16);
    if !len >= 2 then h := !h lxor ((str_char_code_at (!i + 1) land 0xff) lsl 8);
    if !len >= 1 then (
      h := !h lxor (str_char_code_at !i land 0xff);
      h := mix_int !h)
  in

  (h :=
     let h = !h |> Int32.of_int in
     let ( lsr ) = Int32.shift_right_logical in
     let ( lxor ) = Int32.logxor in
     h lxor (h lsr 13) |> Int32.to_int);

  h := mix_int !h;
  let h =
    let h = Int32.of_int !h in
    let ( lsr ) = Int32.shift_right_logical in
    let ( lxor ) = Int32.logxor in
    (h lxor (h lsr 15) |> Int32.to_int) land 0xFFFFFFFF
  in
  h

let default str = str |> murmur2 |> to_base36
