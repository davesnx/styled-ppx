let char_map_36 = "0123456789abcdefghijklmnopqrstuvwxyz"

let to_base36 n =
  let rec convert_to_base36 acc n =
    if n = 0l then acc
    else (
      let quotient = Int32.unsigned_div n 36l in
      let remainder = Int32.unsigned_rem n 36l in
      let char_at_remainder =
        String.make 1 (String.get char_map_36 (Int32.to_int remainder))
      in
      convert_to_base36 (char_at_remainder :: acc) quotient)
  in
  if n = 0l then "0" else String.concat "" (convert_to_base36 [] n)

let of_char c = Int32.of_int (int_of_char c)
let ( lor ) = Int32.logor
let ( land ) = Int32.logand
let ( lsl ) = Int32.shift_left
let ( lsr ) = Int32.shift_right_logical
let ( lxor ) = Int32.logxor

(* The murmur2 hashing algorithm is based on @emotion/hash https://github.com/emotion-js/emotion/blob/main/packages/hash/src/index.js *)
let murmur2 str =
  let open Int32 in
  (* 'm' and 'r' are mixing constants generated offline.
     They're not really 'magic', they just happen to work well. *)
  let m = 0x5bd1e995l in
  let r = 24 in

  (* Initialize the hash *)
  let h = ref 0l in

  (* Mix 4 bytes at a time into the hash *)
  let i = ref 0 in
  let len = ref (String.length str) in
  while !len >= 4 do
    let k =
      of_char str.[!i]
      land 0xffl
      lor ((of_char str.[!i + 1] land 0xffl) lsl 8)
      lor ((of_char str.[!i + 2] land 0xffl) lsl 16)
      lor ((of_char str.[!i + 3] land 0xffl) lsl 24)
    in

    let k = add (mul (k land 0xffffl) m) (mul (k lsr 16) 0xe995l lsl 16) in
    let k = k lxor (k lsr r) in

    h :=
      add (mul (k land 0xffffl) m) (mul (k lsr 16) 0xe995l lsl 16)
      lxor add (mul (!h land 0xffffl) m) (mul (!h lsr 16) 0xe995l lsl 16);

    i := !i + 4;
    len := !len - 4
  done;

  (* Handle the last few bytes of the input array *)
  let () =
    if !len = 3 then h := !h lxor ((of_char str.[!i + 2] land 0xffl) lsl 16);
    if !len >= 2 then begin
      h := !h lxor ((of_char str.[!i + 1] land 0xffl) lsl 8)
    end;
    if !len >= 1 then begin
      h := !h lxor (of_char str.[!i] land 0xffl);
      h := add (mul (!h land 0xffffl) m) (mul (!h lsr 16) 0xe995l lsl 16)
    end
  in

  (* Do a few final mixes of the hash to ensure the last few
     bytes are well-incorporated. *)
  h := !h lxor (!h lsr 13);

  h := add (mul (!h land 0xffffl) m) (mul (!h lsr 16) 0xe995l lsl 16);
  !h lxor (!h lsr 15) land 0xffffffffl

let default str = str |> murmur2 |> to_base36
