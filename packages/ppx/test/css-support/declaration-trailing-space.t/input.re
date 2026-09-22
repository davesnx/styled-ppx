/* Declaration value terminated by an explicit `;` in source (no source
   space before the terminator). */
[%css {| display: flex; |}];

/* Same declaration, terminated by end-of-input with a source space before
   the terminator. Must render and hash identically to the one above. */
[%css {| display: flex |}];

/* Nested block: declaration terminated by explicit `;` vs. by the closing
   `}` with a source space before it. */
[%css {| & > * { min-height: 0; } |}];
[%css {| & > * { min-height: 0 } |}];

/* At-rule body: same contrast inside a block. */
[%css {| @media (min-width: 100px) { display: flex; } |}];
[%css {| @media (min-width: 100px) { display: flex } |}];

/* Autoprefixed value: the autoprefixer matches the value by string, so both
   must share one class AND one body, with `-webkit-grab` present in each. */
[%css {| cursor: grab; |}];
[%css {| cursor: grab |}];
