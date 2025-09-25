/* CSS Generated Content Module Level 3 */
[%css {|quotes: auto|}];
/* [%css {|content: url(./img/star.png) / "New!"|}]; */
[%css {|content: "\25BA" / ""|}];

[%css {|content: "";|}];
/* [%css {|content: counter(ol);|}]; */
[%css {|content: counter(count, decimal);|}];
[%css {|content: counter(count, decimal) ") ";|}];
[%css {|content: unset;|}];

/* Keywords that cannot be combined with other values */
[%css {|content: normal;|}];
[%css {|content: none;|}];

/* <content-replacement>: <image> values */
[%css {|content: url("http://www.example.com/test.png");|}];
[%css {|content: linear-gradient(#e66465, #9198e5);|}];
[%css {|content: image-set("image1x.png" 1x, "image2x.png" 2x);|}];

/* speech output: alternative text after a "/"  */
[%css {|content: url("../img/test.png") / "This is the alt text";|}];

/* <string> value */
[%css {|content: "unparsed text";|}];

/* <counter> values, optionally with <list-style-type> */
/* [%css {|content: counter(chapter_counter);|}]; */
/* [%css {|content: counter(chapter_counter, upper-roman);|}]; */
/* [%css {|content: counters(section_counter, ".");|}]; */
/* [%css {|content: counters(section_counter, ".", decimal-leading-zero);|}]; */

/* attr() value linked to the HTML attribute value */
[%css {|content: attr(href);|}];
[%css {|content: attr(data-width px);|}];
/* inherit is a declaration value, and current spec parser does not support it */
/* [%css {|content: attr(data-width px, inherit);|}]; */

/* <quote> values */
[%css {|content: open-quote;|}];
[%css {|content: close-quote;|}];
[%css {|content: no-open-quote;|}];
[%css {|content: no-close-quote;|}];

/* <content-list>: a list of content values.
   Several values can be used simultaneously */
[%css {|content: "prefix" url(http://www.example.com/test.png);|}];
[%css {|content: "prefix" url("/img/test.png") "suffix" / "Alt text";|}];
/* [%css {|content: open-quote counter(chapter_counter);|}]; */

/* Global values */
[%css {|content: inherit;|}];
[%css {|content: initial;|}];
[%css {|content: revert;|}];
[%css {|content: revert-layer;|}];
[%css {|content: unset;|}];

[%css "content: '点';"];
[%css {|content: '点';|}];
[%css {|content: "点";|}];
[%css {|content: "lola";|}];
[%css {|content: 'lola';|}];
[%css {|content: "";|}];
[%css {|content: " ";|}];
[%css {|content: ' ';|}];
[%css {|content: '';|}];
[%css {|content: "'";|}];
[%css {|content: '"';|}];

/* Test attr() with attr-type */
[%css {|content: attr(href);|}];
[%css {|content: attr(data-value);|}];
/* [%css {|content: attr(data-value type(string));|}]; */
/* [%css {|content: attr(data-value type(color));|}]; */
/* [%css {|content: attr(data-value type(url));|}]; */
/* [%css {|content: attr(data-value type(integer));|}]; */
/* [%css {|content: attr(data-value type(number));|}]; */
/* [%css {|content: attr(data-value type(length));|}]; */
/* [%css {|content: attr(data-value type(angle));|}]; */
/* [%css {|content: attr(data-value type(time));|}]; */
/* [%css {|content: attr(data-value type(percentage));|}]; */
[%css {|content: attr(data-value raw-string);|}];
[%css {|content: attr(data-value em);|}];
[%css {|content: attr(data-value px);|}];
/* [%css {|content: attr(data-value type(string), "fallback");|}]; */
/* [%css {|content: attr(data-value type(color), red);|}]; */
/* [%css {|content: attr(href type(url), "#");|}]; */

/* Unicode escape sequences in content property */
[%css {|content: "\2192";|}]; /* Right arrow → */
[%css {|content: "\2190";|}]; /* Left arrow ← */
[%css {|content: "\2191";|}]; /* Up arrow ↑ */
[%css {|content: "\2193";|}]; /* Down arrow ↓ */

/* Quotation marks */
[%css {|content: "\201C";|}]; /* Left double quotation mark " */
[%css {|content: "\201D";|}]; /* Right double quotation mark " */

[%css {|content: "\2018";|}]; /* Left single quotation mark ' */
[%css {|content: "\2019";|}]; /* Right single quotation mark ' */

/* Special symbols */
[%css {|content: "\2022";|}]; /* Bullet • */
[%css {|content: "\2014";|}]; /* Em dash — */
[%css {|content: "\2026";|}]; /* Horizontal ellipsis … */
[%css {|content: "\2665";|}]; /* Black heart suit ♥ */
[%css {|content: "\2713";|}]; /* Check mark ✓ */
[%css {|content: "\2717";|}]; /* Ballot X ✗ */
[%css {|content: "\2726";|}]; /* Black four pointed star ✦ */

/* Multiple Unicode escapes combined */
[%css {|content: "" attr(data-title) "\201D";|}];
[%css {|content: "\2192" " Click here";|}];
[%css {|content: "Step " counter(step, decimal) ": ";|}];

/* Emoji with Unicode escapes (using surrogate pairs where needed) */
[%css {|content: "\1F4A1";|}]; /* Light bulb emoji 💡 */
[%css {|content: "\1F44D";|}]; /* Thumbs up emoji 👍 */

/* Combined with pseudo-elements (these would typically be in selectors) */
[%css {|content: "\00BB";|}]; /* Right-pointing double angle quotation mark » */
[%css {|content: "\00A7";|}]; /* Section sign § */

/* Testing different formats of Unicode escapes */
[%css {|content: "\002192";|}]; /* 6-digit format for arrow */
[%css {|content: "\000020";|}]; /* Space character */

/* Testing with actual Unicode characters directly */
[%css {|content: "→";|}]; /* Direct arrow character */
[%css {|content: "•";|}]; /* Direct bullet */
[%css {|content: "—";|}]; /* Direct em dash */
[%css {|content: "…";|}]; /* Direct ellipsis */
[%css {|content: '"';|}]; /* Direct left double quote */
[%css {|content: '"';|}]; /* Direct right double quote */
[%css {|content: "✓";|}]; /* Direct check mark */
[%css {|content: "♥";|}]; /* Direct heart */
[%css {|content: "→ " attr(href);|}]; /* Combining direct character with attr */
[%css {|content: "• " counter(item, decimal) " ";|}]; /* Direct bullet with counter */
