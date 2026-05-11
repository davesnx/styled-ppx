/* CSS Generated Content Module Level 3 */
[%cx2 {|quotes: auto|}];
/* [%cx2 {|content: url(./img/star.png) / "New!"|}]; */
[%cx2 {|content: "\25BA" / ""|}];

[%cx2 {|content: "";|}];
/* counter() — single-argument form (Gap 4) */
[%cx2 {|content: counter(ol);|}];
[%cx2 {|content: counter(count, decimal);|}];
[%cx2 {|content: counter(count, decimal) ") ";|}];
[%cx2 {|content: unset;|}];

/* Keywords that cannot be combined with other values */
[%cx2 {|content: normal;|}];
[%cx2 {|content: none;|}];

/* <content-replacement>: <image> values */
[%cx2 {|content: url("http://www.example.com/test.png");|}];
[%cx2 {|content: linear-gradient(#e66465, #9198e5);|}];
[%cx2 {|content: image-set("image1x.png" 1x, "image2x.png" 2x);|}];

/* speech output: alternative text after a "/"  */
[%cx2 {|content: url("../img/test.png") / "This is the alt text";|}];

/* <string> value */
[%cx2 {|content: "unparsed text";|}];

/* <counter> values, with and without a <counter-style> (Gap 4) */
[%cx2 {|content: counter(chapter_counter);|}];
[%cx2 {|content: counter(chapter_counter, upper-roman);|}];
/* <counters()> values, with and without a <counter-style> (Gap 3) */
[%cx2 {|content: counters(section_counter, ".");|}];
[%cx2 {|content: counters(section_counter, ".", decimal-leading-zero);|}];

/* attr() value linked to the HTML attribute value */
[%cx2 {|content: attr(href);|}];
[%cx2 {|content: attr(data-width px);|}];
/* inherit is a declaration value, and current spec parser does not support it */
/* [%cx2 {|content: attr(data-width px, inherit);|}]; */

/* <quote> values */
[%cx2 {|content: open-quote;|}];
[%cx2 {|content: close-quote;|}];
[%cx2 {|content: no-open-quote;|}];
[%cx2 {|content: no-close-quote;|}];

/* <content-list>: a list of content values.
   Several values can be used simultaneously */
[%cx2 {|content: "prefix" url(http://www.example.com/test.png);|}];
[%cx2 {|content: "prefix" url("/img/test.png") "suffix" / "Alt text";|}];
/* Mixing quotes and counters in a content-list (Gap 3 + Gap 4) */
[%cx2 {|content: open-quote counter(chapter_counter);|}];

/* Global values */
[%cx2 {|content: inherit;|}];
[%cx2 {|content: initial;|}];
[%cx2 {|content: revert;|}];
[%cx2 {|content: revert-layer;|}];
[%cx2 {|content: unset;|}];

[%cx2 "content: '点';"];
[%cx2 {|content: '点';|}];
[%cx2 {|content: "点";|}];
[%cx2 {|content: "lola";|}];
[%cx2 {|content: 'lola';|}];
[%cx2 {|content: "";|}];
[%cx2 {|content: " ";|}];
[%cx2 {|content: ' ';|}];
[%cx2 {|content: '';|}];
[%cx2 {|content: "'";|}];
[%cx2 {|content: '"';|}];

/* Test attr() with attr-type */
[%cx2 {|content: attr(href);|}];
[%cx2 {|content: attr(data-value);|}];
/* [%cx2 {|content: attr(data-value type(string));|}]; */
/* [%cx2 {|content: attr(data-value type(color));|}]; */
/* [%cx2 {|content: attr(data-value type(url));|}]; */
/* [%cx2 {|content: attr(data-value type(integer));|}]; */
/* [%cx2 {|content: attr(data-value type(number));|}]; */
/* [%cx2 {|content: attr(data-value type(length));|}]; */
/* [%cx2 {|content: attr(data-value type(angle));|}]; */
/* [%cx2 {|content: attr(data-value type(time));|}]; */
/* [%cx2 {|content: attr(data-value type(percentage));|}]; */
[%cx2 {|content: attr(data-value raw-string);|}];
[%cx2 {|content: attr(data-value em);|}];
[%cx2 {|content: attr(data-value px);|}];
/* [%cx2 {|content: attr(data-value type(string), "fallback");|}]; */
/* [%cx2 {|content: attr(data-value type(color), red);|}]; */
/* [%cx2 {|content: attr(href type(url), "#");|}]; */

/* Unicode escape sequences in content property */
[%cx2 {|content: "\2192";|}]; /* Right arrow → */
[%cx2 {|content: "\2190";|}]; /* Left arrow ← */
[%cx2 {|content: "\2191";|}]; /* Up arrow ↑ */
[%cx2 {|content: "\2193";|}]; /* Down arrow ↓ */

/* Quotation marks */
[%cx2 {|content: "\201C";|}]; /* Left double quotation mark " */
[%cx2 {|content: "\201D";|}]; /* Right double quotation mark " */

[%cx2 {|content: "\2018";|}]; /* Left single quotation mark ' */
[%cx2 {|content: "\2019";|}]; /* Right single quotation mark ' */

/* Special symbols */
[%cx2 {|content: "\2022";|}]; /* Bullet • */
[%cx2 {|content: "\2014";|}]; /* Em dash — */
[%cx2 {|content: "\2026";|}]; /* Horizontal ellipsis … */
[%cx2 {|content: "\2665";|}]; /* Black heart suit ♥ */
[%cx2 {|content: "\2713";|}]; /* Check mark ✓ */
[%cx2 {|content: "\2717";|}]; /* Ballot X ✗ */
[%cx2 {|content: "\2726";|}]; /* Black four pointed star ✦ */

/* Multiple Unicode escapes combined */
[%cx2 {|content: "" attr(data-title) "\201D";|}];
[%cx2 {|content: "\2192" " Click here";|}];
[%cx2 {|content: "Step " counter(step, decimal) ": ";|}];

/* Emoji with Unicode escapes (using surrogate pairs where needed) */
[%cx2 {|content: "\1F4A1";|}]; /* Light bulb emoji 💡 */
[%cx2 {|content: "\1F44D";|}]; /* Thumbs up emoji 👍 */

/* Combined with pseudo-elements (these would typically be in selectors) */
[%cx2 {|content: "\00BB";|}]; /* Right-pointing double angle quotation mark » */
[%cx2 {|content: "\00A7";|}]; /* Section sign § */

/* Testing different formats of Unicode escapes */
[%cx2 {|content: "\002192";|}]; /* 6-digit format for arrow */
[%cx2 {|content: "\000020";|}]; /* Space character */

/* Testing with actual Unicode characters directly */
[%cx2 {|content: "→";|}]; /* Direct arrow character */
[%cx2 {|content: "•";|}]; /* Direct bullet */
[%cx2 {|content: "—";|}]; /* Direct em dash */
[%cx2 {|content: "…";|}]; /* Direct ellipsis */
[%cx2 {|content: '"';|}]; /* Direct left double quote */
[%cx2 {|content: '"';|}]; /* Direct right double quote */
[%cx2 {|content: "✓";|}]; /* Direct check mark */
[%cx2 {|content: "♥";|}]; /* Direct heart */
[%cx2 {|content: "→ " attr(href);|}]; /* Combining direct character with attr */
[%cx2 {|content: "• " counter(item, decimal) " ";|}]; /* Direct bullet with counter */
