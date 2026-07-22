/* Invalid UTF-8 in a CSS payload must produce a located error, not a
   compiler crash. The \xe9 escape puts a raw non-UTF-8 byte in the payload
   while this file itself stays valid ASCII. */

let broken = [%css "content: \"caf\xe9\""];
