/* \xe9 inserts one invalid UTF-8 byte into the CSS payload. */

let broken = [%css "content: \"caf\xe9\""];
