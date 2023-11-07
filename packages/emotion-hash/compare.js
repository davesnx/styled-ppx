const { exit } = require('process');
const emotion = require('./emotion-murmur');

const input = process.argv[2];
const js = emotion(input);
let native = require('child_process').execSync(`dune exec styled-ppx.native_hash "${input}"`).toString();
native = native.slice(0, -1); // ends with newline

if (js != native) {
    console.error(`js output differs from native, js=${js}, native=${native}`)
    exit(1)
} else {
    console.log(js);
    exit(0);
}
