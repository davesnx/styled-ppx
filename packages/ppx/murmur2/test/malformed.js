const murmur2 = require('./murmur2.js');

const buffer_2_bytes = Buffer.from([0xC0]);
const malformed_2_byte_utf8_string = buffer_2_bytes.toString('utf8'); 
const buffer_3_bytes = Buffer.from([0xE0, 0x80]);
const malformed_3_byte_utf8_string = buffer_3_bytes.toString('utf8'); 
const buffer_4_bytes = Buffer.from([0xF0, 0x80]);
const malformed_4_byte_utf8_string = buffer_4_bytes.toString('utf8'); 

process.stdout.write(murmur2(malformed_2_byte_utf8_string) + " (2 bytes) - ");
process.stdout.write(murmur2(malformed_3_byte_utf8_string) + " (3 bytes) - ");
process.stdout.write(murmur2(malformed_4_byte_utf8_string) + " (4 bytes)");