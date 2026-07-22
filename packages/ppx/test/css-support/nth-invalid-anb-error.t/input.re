/* Invalid an+b payloads in :nth-child() must produce a located parse
   error pointing at the payload, not crash the compiler (int_of_string
   used to escape as an unlocated Failure). */
let _x = [%css ":nth-child(3n-abc) { color: red; }"];
