// String escape round-trip tests for cx2 extraction.
// Covers the cases from documents/string-escape-bug.md: any
// character that requires backslash escaping inside a CSS
// string-token must round-trip correctly through the renderer.
//
// CSS Syntax 4.3.5 says U+0022 double-quote, U+005C backslash, and
// the C0 line terminators (U+000A, U+000D, U+000C) must be encoded
// as backslash escapes when the token is serialized.

// Embedded double-quote: input decodes to a single byte `"`,
// which must be re-emitted as backslash-double-quote.
[%cx2 {| content: "\""; |}];

// Embedded backslash: input decodes to a single byte `\`,
// which must be re-emitted as backslash-backslash.
[%cx2 {| content: "\\"; |}];

// Single quote inside double-quoted string: no escape required.
[%cx2 {| content: "'"; |}];

// Mixed quotes and characters: input contains both `a` and `b` and a quote.
[%cx2 {| content: "a\"b"; |}];

// Multiple backslashes interleaved with literal characters.
[%cx2 {| content: "before\\after"; |}];

// CSS hex escape \A decodes to U+000A (LF). The renderer must
// re-encode the LF byte as backslash-A-space so the output is a
// single-line CSS string.
[%cx2 {| content: "line\A one"; |}];

// CSS hex escape \2014 decodes to U+2014 (em dash). UTF-8 bytes
// pass through verbatim -- no re-encoding is required.
[%cx2 {| content: "\2014"; |}];

// Single-quoted source with embedded single quote. The renderer
// always emits double-quoted strings, so the single quote does not
// need to be escaped in the output.
[%cx2 {| content: '\''; |}];

// Attribute selector with embedded double-quote in the matcher.
// The selector serializer must escape the double quote.
[%cx2 {| & [data-name="O\"Brien"] { color: red; } |}];

// URL with embedded double-quote. url("...") shares the same
// serialization rules as a string token.
[%cx2 {| background-image: url("path/with\"quote.png"); |}];

// URL with embedded backslash.
[%cx2 {| background-image: url("path\\to\\file.png"); |}];

// CSS hex escape \9 decodes to U+0009 (TAB). The renderer must
// re-encode the TAB byte as a hex escape so the output is a
// well-formed <string-token>.
[%cx2 {| content: "\9"; |}];

// CSS hex escape \7F decodes to U+007F (DEL). DEL must be hex-escaped
// in the output per CSS Syntax serialization rules.
[%cx2 {| content: "\7F"; |}];
