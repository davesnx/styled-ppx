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
