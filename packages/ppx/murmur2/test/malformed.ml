let malformed_2_byte_utf8_string =
  String.concat "" [ String.make 1 (Char.chr 0xC0) ]
in
let malformed_3_byte_utf8_string =
  String.concat ""
    [ String.make 1 (Char.chr 0xE0); String.make 1 (Char.chr 0x80) ]
in
let malformed_4_byte_utf8_string =
  String.concat ""
    [ String.make 1 (Char.chr 0xF0); String.make 1 (Char.chr 0x80) ]
in
print_endline
  (Printf.sprintf "%s (2 bytes) - %s (3 bytes) - %s (4 bytes)"
     (Murmur2.default malformed_2_byte_utf8_string)
     (Murmur2.default malformed_3_byte_utf8_string)
     (Murmur2.default malformed_4_byte_utf8_string))
