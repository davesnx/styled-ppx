let ( << ) = Int32.shift_left
let ( & ) = Int32.logand
let ( ||| ) = Int32.logor
let ( * ) = Int32.mul
let ( >>> ) = Int32.shift_right
let ( ++ ) = Int32.add
let ( ^ ) = Int32.logxor

let to_base36 (num : Int32.t) =
  let rec to_base36' (num : Int32.t) =
    if num = 0l then []
    else
      let quotient = Int32.div num 36l in
      let remainder = Int32.rem num 36l in
      (match remainder with
      | 10l -> "a"
      | 11l -> "b"
      | 12l -> "c"
      | 13l -> "d"
      | 14l -> "e"
      | 15l -> "f"
      | 16l -> "g"
      | 17l -> "h"
      | 18l -> "i"
      | 19l -> "j"
      | 20l -> "k"
      | 21l -> "l"
      | 22l -> "m"
      | 23l -> "n"
      | 24l -> "o"
      | 25l -> "p"
      | 26l -> "q"
      | 27l -> "r"
      | 28l -> "s"
      | 29l -> "t"
      | 30l -> "u"
      | 31l -> "v"
      | 32l -> "w"
      | 33l -> "x"
      | 34l -> "y"
      | 35l -> "z"
      | _ -> string_of_int (Int32.to_int remainder))
      :: to_base36' quotient
  in
  num |> to_base36' |> List.rev |> String.concat ""

let to_css (number : Int32.t) = number |> to_base36

(*
    The murmur2 hashing is based on @emotion/hash, which is based on
    https://github.com/garycourt/murmurhash-js and ported from
    https://github.com/aappleby/smhasher/blob/61a0530f28277f2e850bfc39600ce61d02b518de/src/MurmurHash2.cpp#L37-L86.
    Reference: https://github.com/emotion-js/emotion/blob/main/packages/hash/src/index.js

    It's an ongoing effort to have a hashing function, currently okish. *)
let murmur2 (str : string) =
  let length = String.length str in
  (* var h = 0 *)
  let hash = ref 0l in
  (* var k *)
  let k = ref 0l in
  (* len = str.length *)
  let len = ref length in
  (* i = 0, *)
  let index = ref 0 in
  while !index + 4 <= length do
    let char_code_1 = Int32.of_int (Char.code str.[!index]) in
    let char_code_2 = Int32.of_int (Char.code str.[!index + 1]) in
    let char_code_3 = Int32.of_int (Char.code str.[!index + 2]) in
    let char_code_4 = Int32.of_int (Char.code str.[!index + 3]) in
    (* k =
       (str.charCodeAt(i) & 0xff) |
       ((str.charCodeAt(++i) & 0xff) << 8) |
       ((str.charCodeAt(++i) & 0xff) << 16) |
       ((str.charCodeAt(++i) & 0xff) << 24) *)
    k :=
      char_code_1 ||| (char_code_2 << 8) ||| (char_code_3 << 16)
      ||| (char_code_4 << 24);
    (* k =
       (k & 0xffff) * 0x5bd1e995 + (((k >>> 16) * 0xe995) << 16) *)
    k :=
      ((!k & 0xffffl) * 0x5bd1e995l) ++ (((!k >>> 16) * 0x5bd1e995l) & 0xffffl)
      << 16;
    (* k ^=  k >>> 24 *)
    k := !k ^ (!k >>> 24);
    k :=
      ((!k & 0xffffl) * 0x5bd1e995l) ++ (((!k >>> 16) * 0x5bd1e995l) & 0xffffl)
      << 16;
    (* h =
       ((k & 0xffff) * 0x5bd1e995 + (((k >>> 16) * 0xe995) << 16)) ^
       ((h & 0xffff) * 0x5bd1e995 + (((h >>> 16) * 0xe995) << 16)) *)
    hash :=
      (((!hash & 0xffffl) * 0x5bd1e995l)
       ++ (((!hash >>> 16) * 0x5bd1e995l) & 0xffffl)
      << 16)
      ^ !k;
    index := !index + 1;
    len := !len - 4
  done;

  (* Handle the last few bytes of the input array *)
  (match !len with
  | 3 ->
      (* h ^= (str.charCodeAt(i + 2) & 0xff) << 16 *)
      hash := !hash ^ (Int32.of_int (Char.code str.[!index + 2]) << 16)
  | 2 ->
      (* h ^= (str.charCodeAt(i + 1) & 0xff) << 8 *)
      hash := !hash ^ (Int32.of_int (Char.code str.[!index + 1]) << 8)
  | 1 ->
      (* h ^= str.charCodeAt(i) & 0xff *)
      hash := !hash ^ Int32.of_int (Char.code str.[!index]);
      (* h =
         (h & 0xffff) * 0x5bd1e995 + (((h >>> 16) * 0xe995) << 16) *)
      hash :=
        ((!hash & 0xffffl) * 0x5bd1e995l)
        ++ (((!hash >>> 16) * 0x5bd1e995l) & 0xffffl)
        << 16
  | _ -> ());

  (* Do a few final mixes of the hash to ensure the last few bytes are well-incorporated. *)

  (* h ^= h >>> 13 *)
  hash := !hash ^ (!hash >>> 13);
  (* h =
     (h & 0xffff) * 0x5bd1e995 + (((h >>> 16) * 0xe995) << 16) *)
  hash :=
    ((!hash & 0xffffl) * 0x5bd1e995l) ++ ((!hash >>> 16) * 0x5bd1e995l << 16);
  (* (h ^ (h >>> 15)) >>> 0 *)
  !hash ^ (!hash >>> 15) >>> 0

let make (str : string) = str |> murmur2 |> to_css

(* Re-export as default since we want to compile it with Melange and match
   the same interface as @emotion/hash *)
let default = make
