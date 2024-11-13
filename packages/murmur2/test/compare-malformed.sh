#!/bin/sh
native_hashes=$(./malformed.exe)
js_hashes=$(node './malformed.js')

if [ "$native_hashes" = "$js_hashes" ]; then
  echo "Hashes match: ${native_hashes}"
  exit 0
else
  echo "Hashes do not match"
  echo "native: ${native_hashes}"
  echo "JavaScript: ${js_hashes}"
  exit 1
fi
