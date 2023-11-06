let to_base36 (n : int32) : string =
  let rec go n acc =
    if Int32.equal n 0l then acc
    else (
      let base36_digit =
        if Int32.compare n 0l < 0 then 36 - (Int32.to_int (Int32.neg n) mod 36)
        else Int32.to_int n mod 36
      in
      let new_acc =
        Char.chr
          (if base36_digit < 10 then 48 + base36_digit else 87 + base36_digit)
        :: acc
      in
      go (Int32.div n 36l) new_acc)
  in
  match Int32.compare n 0l with
  | 0 -> "0"
  | _ ->
    let chars = go (Int32.abs n) [] in
    let word = List.map (String.make 1) chars in
    String.concat "" word

(* This hash algorithm is based on caml_hash from `Hashtbl.hash`
   which uses murmur3 and condicentally it's the same algorithm used in emotion,
   Even thought emotion has changed slightly the implementation.

   We adapted caml_hash to use Int32
*)

let rotl32 (x : int32) (r : int) =
  Int32.logor (Int32.shift_left x r) (Int32.shift_right_logical x (32 - r))

let mix_int (h : int32 ref) (d : int32) =
  let d = Int32.mul d 0xcc9e2d51l in
  let d = rotl32 d 15 in
  let d = Int32.mul d 0x1b873593l in
  let h = Int32.logxor !h d in
  let h = rotl32 h 13 in
  Int32.add h (Int32.add (Int32.shift_left h 2) 0xe6546b64l)

let final_mix (h : int32) =
  let h = Int32.logxor h (Int32.shift_right h 16) in
  let h = Int32.mul h 0x85ebca6bl in
  let h = Int32.logxor h (Int32.shift_right h 13) in
  let h = Int32.mul h 0xc2b2ae35l in
  Int32.logxor h (Int32.shift_right h 16)

let hash s =
  let len = String.length s in
  let block = (len / 4) - 1 in
  let hash = ref 0l in
  for i = 0 to block do
    let j = 4 * i in
    let w =
      Int32.logor
        (Int32.logor
           (Int32.logor
              (Int32.of_int (Char.code s.[j]))
              (Int32.shift_left (Int32.of_int (Char.code s.[j + 1])) 8))
           (Int32.shift_left (Int32.of_int (Char.code s.[j + 2])) 16))
        (Int32.shift_left (Int32.of_int (Char.code s.[j + 3])) 24)
    in
    hash := mix_int hash w
  done;
  let modulo = len land 0b11 in
  if modulo <> 0 then (
    let w =
      if modulo = 3 then
        Int32.logor
          (Int32.logor
             (Int32.shift_left (Int32.of_int (Char.code s.[len - 1])) 16)
             (Int32.shift_left (Int32.of_int (Char.code s.[len - 2])) 8))
          (Int32.of_int (Char.code s.[len - 3]))
      else if modulo = 2 then
        Int32.logor
          (Int32.shift_left (Int32.of_int (Char.code s.[len - 1])) 8)
          (Int32.of_int (Char.code s.[len - 2]))
      else Int32.of_int (Char.code s.[len - 1])
    in
    hash := mix_int hash w);
  hash := Int32.logxor !hash (Int32.of_int len);
  final_mix !hash

let default (str : string) = str |> hash |> to_base36
