let m = 0xc6a4a7935bd1e995L
let r = 47

let hash s =
  let len = String.length s in
  let ( *% ) = Int64.mul in
  let ( ^% ) = Int64.logxor in
  let shr = Int64.shift_right_logical in
  let h = ref (Int64.of_int len *% m) in
  for i = 0 to (len / 8) - 1 do
    let k = String.get_int64_le s (i * 8) in
    let k = k *% m in
    let k = k ^% shr k r in
    let k = k *% m in
    h := (!h ^% k) *% m
  done;
  let tail = len land 7 in
  if tail > 0 then begin
    for j = tail - 1 downto 0 do
      let byte = Int64.of_int (Char.code s.[len - tail + j]) in
      h := !h ^% Int64.shift_left byte (8 * j)
    done;
    h := !h *% m
  end;
  let h = !h ^% shr !h r in
  let h = h *% m in
  h ^% shr h r

let chars h n =
  if n < 1 || n > 10 then invalid_arg "Hash64.chars";
  String.init n (fun i ->
    let bits = Int64.shift_right_logical h (6 * (n - 1 - i)) in
    Property_class_core.Css_class_format.alphabet.[Int64.to_int
                                                     (Int64.logand bits 63L)])
