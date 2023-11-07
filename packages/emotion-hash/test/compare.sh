#!/bin/bash

set -e

input=$1

native_hash=$(dune exec styled-ppx.native_hash "${input}")
js_hash=$(node './emotion-hash' "${input}")

if [ "$native_hash" == "$js_hash" ]; then
  echo "Hashes match: ${native_hash}"
  exit 0
else
  echo "Hashes do not match"
  echo "styled-ppx.hash: ${native_hash}"
  echo "@emotion/hash: ${js_hash}"
  exit 1
fi
