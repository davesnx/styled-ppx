let to_base36 (num : Int32.t) =
  let rec to_base36' (num : Int32.t) =
    if num = 0l then []
    else (
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
      :: to_base36' quotient)
  in
  num |> to_base36' |> List.rev |> String.concat ""

let rotl32 x n = (x lsl n) lor (x lsr (32 - n))
let ( .![] ) s index = int_of_char s.[index]

let caml_hash_mix_int h d =
  let d = ref d in
  d.contents <- d.contents * 0xcc9e2d51;
  d.contents <- rotl32 d.contents 15;
  d.contents <- d.contents * 0x1b873593;
  let h = ref (h lxor d.contents) in
  h.contents <- rotl32 h.contents 13;
  h.contents + (h.contents lsl 2) + 0xe6546b64

let caml_hash_final_mix h =
  let h = ref (h lxor (h lsr 16)) in
  h.contents <- h.contents * 0x85ebca6b;
  h.contents <- h.contents lxor (h.contents lsr 13);
  h.contents <- h.contents * 0xc2b2ae35;
  h.contents lxor (h.contents lsr 16)

let caml_hash s =
  let len = String.length s in
  let block = (len / 4) - 1 in
  let hash = ref 0 in
  for i = 0 to block do
    let j = 4 * i in
    let w =
      s.![j]
      lor (s.![j + 1] lsl 8)
      lor (s.![j + 2] lsl 16)
      lor (s.![j + 3] lsl 24)
    in
    hash.contents <- caml_hash_mix_int hash.contents w
  done;
  let modulo = len land 0b11 in
  if modulo <> 0 then (
    let w =
      if modulo = 3 then
        (s.![len - 1] lsl 16) lor (s.![len - 2] lsl 8) lor s.![len - 3]
      else if modulo = 2 then (s.![len - 1] lsl 8) lor s.![len - 2]
      else s.![len - 1]
    in
    hash.contents <- caml_hash_mix_int hash.contents w);
  hash.contents <- hash.contents lxor len;
  hash.contents

let hash str = caml_hash_final_mix (caml_hash str)
let default (str : string) = str |> hash |> Int32.of_int |> to_base36
