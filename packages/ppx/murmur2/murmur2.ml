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

(* Based on @emotion/hash https://github.com/emotion-js/emotion/blob/main/packages/hash/src/index.js
   which reads the low byte of each UTF-16 code unit; this reads UTF-8 bytes, so they agree on ASCII only. *)
let murmur2 str =
  (* 'm' and 'r' are mixing constants generated offline.
     They're not really 'magic', they just happen to work well. *)
  let m = 0x5bd1e995 in
  let r = 24 in

  let mix_int k = Int32.to_int (Int32.mul (Int32.of_int k) (Int32.of_int m)) in

  (* Initialize the hash *)
  let h = ref 0 in
  let i = ref 0 in

  let len = ref (String.length str) in
  let str_char_code_at i = Char.code str.[i] in

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
