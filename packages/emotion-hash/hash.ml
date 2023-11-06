let to_base36_string n =
  let open Int32 in
  let base36_chars = "0123456789abcdefghijklmnopqrstuvwxyz" in
  let rec convert_to_base36 acc n =
    if n = 0l then acc
    else (
      let quotient = unsigned_div n 36l in
      let remainder = unsigned_rem n 36l in
      let char_at_remainder =
        String.make 1 (String.get base36_chars (to_int remainder))
      in
      convert_to_base36 (char_at_remainder :: acc) quotient)
  in
  if n = 0l then "0" else String.concat "" (convert_to_base36 [] n)

let default str =
  let open Int32 in
  let ( lor ) = logor in
  let ( land ) = logand in
  let ( lsl ) = shift_left in
  let ( lsr ) = shift_right_logical in
  let ( lxor ) = logxor in
  (* 'm' and 'r' are mixing constants generated offline.
     They're not really 'magic', they just happen to work well. *)
  let m = 0x5bd1e995l in
  let r = 24 in

  (* Initialize the hash *)
  let h = ref 0l in

  (* Mix 4 bytes at a time into the hash *)
  let i = ref 0 in
  let len = ref (String.length str) in
  let of_char c = of_int (int_of_char c) in
  while !len >= 4 do
    let k =
      of_char str.[!i]
      land 0xffl
      lor ((of_char str.[!i + 1] land 0xffl) lsl 8)
      lor ((of_char str.[!i + 2] land 0xffl) lsl 16)
      lor ((of_char str.[!i + 3] land 0xffl) lsl 24)
    in

    let k = add (mul (k land 0xffffl) m) (mul (k lsr 16) 0xe995l lsl 16) in
    print_endline (Printf.sprintf "K INIT: %lx" k);
    let k = k lxor (k lsr r) in

    print_endline (Printf.sprintf "K FINAL: %lx" k);
    h :=
      add (mul (k land 0xffffl) m) (mul (k lsr 16) 0xe995l lsl 16)
      lxor add (mul (!h land 0xffffl) m) (mul (!h lsr 16) 0xe995l lsl 16);

    i := !i + 4;
    len := !len - 4
    (* print_endline (Printf.sprintf "loop %d" !i);
       print_endline (Printf.sprintf "len %d" !len);
       print_endline (Printf.sprintf "H is: %lx" !h) *)
  done;

  (* print_endline (Printf.sprintf "len: %d" !len);
     print_endline (Printf.sprintf "i: %d" !i);
     print_endline (Printf.sprintf "H is: %lx" !h); *)

  (* Handle the last few bytes of the input array *)
  let () =
    if !len = 3 then h := !h lxor ((of_char str.[!i + 2] land 0xffl) lsl 16);
    if !len >= 2 then begin
      (* print_endline "here";
         print_endline str;
         print_endline (Printf.sprintf "INDXE %d" (!i + 1));
         print_endline
           (Printf.sprintf "ofchar %ld" (!h lxor ((0x20l land 0xffl) lsl 8))); *)
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
  let () = print_endline (Printf.sprintf "ONE %ld" (mul (!h land 0xffffl) m)) in
  let () =
    print_endline (Printf.sprintf "TWO %ld" (mul (!h lsr 16) 0xe995l lsl 16))
  in
  h :=
      add
        (mul (!h land 0xffffl) (m))
        (mul (!h lsr 16) 0xe995l lsl 16);
  let () = print_endline (Printf.sprintf "H prealmostfinal is: %lx" !h) in
  let () = print_endline (Printf.sprintf "H shifted is: %lx" (!h lsr 15)) in
  let () =
    print_endline
      (Printf.sprintf "H test is: %s" (to_base36_string 0xf77f8879l))
  in

  print_endline (Printf.sprintf "H FINAL is: %lx" !h);
  print_endline
    (Printf.sprintf "FINAL %s"
       (to_base36_string (!h lxor (!h lsr 15) land 0xffffffffl)));
  to_base36_string (!h lxor (!h lsr 15) land 0xffffffffl)
