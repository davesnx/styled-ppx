// from: https://github.com/emotion-js/emotion/blob/f3b268f7c52103979402da919c9c0dd3f9e0e189/packages/hash/src/index.js
// @flow
/* eslint-disable */
// Inspired by https://github.com/garycourt/murmurhash-js
// Ported from https://github.com/aappleby/smhasher/blob/61a0530f28277f2e850bfc39600ce61d02b518de/src/MurmurHash2.cpp#L37-L86

function murmur2(str) {
    // 'm' and 'r' are mixing constants generated offline.
    // They're not really 'magic', they just happen to work well.
  
    // const m = 0x5bd1e995;
    // const r = 24;
  
    // Initialize the hash
  
    var h = 0
  
    // Mix 4 bytes at a time into the hash
  
    var k,
      i = 0,
      len = str.length
    for (; len >= 4; ++i, len -= 4) {
      k =
        (str.charCodeAt(i) & 0xff) |
        ((str.charCodeAt(++i) & 0xff) << 8) |
        ((str.charCodeAt(++i) & 0xff) << 16) |
        ((str.charCodeAt(++i) & 0xff) << 24)
  
      k =
        /* Math.imul(k, m): */
        (k & 0xffff) * 0x5bd1e995 + (((k >>> 16) * 0xe995) << 16)
        console.log("K INIT", k.toString(16).substr(4, 12));
        k ^= /* k >>> r: */ k >>> 24
  
      console.log("K FINAL", (k >>> 0).toString(16));
      h =
        /* Math.imul(k, m): */
        ((k & 0xffff) * 0x5bd1e995 + (((k >>> 16) * 0xe995) << 16)) ^
        /* Math.imul(h, m): */
        ((h & 0xffff) * 0x5bd1e995 + (((h >>> 16) * 0xe995) << 16));
      // console.log("loop", i+1);
      // console.log("len", len);
      // console.log("H iS:", (h >>> 0).toString(16));
    }
  
    // Handle the last few bytes of the input array
    // console.log("len", len);
    // console.log("i", i);
    // console.log("H iS:", (h >>> 0).toString(16));
    switch (len) {
      case 3:
        h ^= (str.charCodeAt(i + 2) & 0xff) << 16
      case 2:
        // console.log("str", str);
        // console.log("index", i + 1);
        // console.log("ofchar", h ^ ((0x20 & 0xff)<< 8));
        h ^= (str.charCodeAt(i + 1) & 0xff) << 8
      case 1:
        h ^= str.charCodeAt(i) & 0xff
        h =
          /* Math.imul(h, m): */
          (h & 0xffff) * 0x5bd1e995 + (((h >>> 16) * 0xe995) << 16)
    }
    console.log("h prefinal", (h >>> 0));

    // Do a few final mixes of the hash to ensure the last few
    // bytes are well-incorporated.
  
    h ^= h >>> 13
    console.log("ONE", ((h & 0xffff) * 0x5bd1e995) >>> 0);
    console.log("TWO", (((h >>> 16) * 0xe995) << 16));
    h =
      /* Math.imul(h, m): */
      (h & 0xffff) * 0x5bd1e995 + (((h >>> 16) * 0xe995) << 16)
    console.log("h prealmostfinal", (h.toString(16)));
    console.log("h shifted is:", ((h >>> 15).toString(16)));
    console.log("H FINAL is:", ((h ^ (h >>> 15)) >>> 0).toString(16));
    return ((h ^ (h >>> 15)) >>> 0).toString(36)
  }

module.exports = murmur2
