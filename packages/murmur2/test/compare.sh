#!/bin/sh

set -e

input=$1

native_hash=$(./cli_murmur2.exe "${input}")
js_hash=$(node './emotion-hash' "${input}")

if [ "$native_hash" = "$js_hash" ]; then
  echo "Hashes match: ${native_hash}"
  exit 0
else
  echo "Hashes do not match"
  echo "native: ${native_hash}"
  echo "JavaScript: ${js_hash}"
  exit 1
fi
