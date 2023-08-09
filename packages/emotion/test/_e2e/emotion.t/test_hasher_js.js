#!/usr/bin/env node

const hash = require("@emotion/hash").default;

const s = process.argv[2];
console.log(hash(s))
