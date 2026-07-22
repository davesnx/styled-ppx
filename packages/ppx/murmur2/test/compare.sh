#!/bin/sh

set -e

input=$1

native_hashes=$(./cli_murmur2.exe "${input}")
js_hashes=$(node './cli_murmur2.js' "${input}")

if [ "$native_hashes" = "$js_hashes" ]; then
  echo "Hashes match: ${native_hashes}"
  exit 0
else
  echo "Hashes do not match"
  echo "native: ${native_hashes}"
  echo "JavaScript: ${js_hashes}"
  exit 1
fi
