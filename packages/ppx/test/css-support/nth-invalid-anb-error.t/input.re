/* Malformed An+B payloads should report a located parse error. */
let _x = [%css ":nth-child(3n-abc) { color: red; }"];
