/* Probe: every selector form supported by the parser, in
   styled.global2 context. Used to capture current behavior. */

let accent = CSS.red;

module AllSelectors = [%styled.global2 {|
  /* Type */
  body { color: $(accent); }

  /* Universal */
  * { box-sizing: border-box; }

  /* Compound: type + class + id */
  div.container#main { padding: 0; }

  /* Multiple classes */
  .btn.primary.large { font-weight: bold; }

  /* Descendant combinator */
  nav a { text-decoration: none; }

  /* Child combinator */
  ul > li { list-style: none; }

  /* Adjacent sibling */
  h1 + p { margin-top: 0; }

  /* General sibling */
  h2 ~ p { color: gray; }

  /* Attribute selectors */
  [type="text"] { padding: 4px; }
  [data-state] { opacity: 0.5; }
  [href^="https"] { color: green; }
  a[target="_blank"]::after { content: " ↗"; }

  /* Pseudo-classes */
  a:hover { color: $(accent); }
  input:focus-visible { outline: 2px solid blue; }
  li:nth-child(2n) { background: #eee; }
  button:not(:disabled) { cursor: pointer; }

  /* Pseudo-elements */
  p::first-line { font-weight: bold; }
  q::before { content: "\""; }

  /* Functional pseudo with selector list */
  :is(h1, h2, h3) { margin: 0; }
  :where(article, section) > p { line-height: 1.6; }

  /* Comma-separated selector list */
  h1, h2, h3 { font-family: serif; }

  /* Mixed combinators with attribute and pseudo */
  form input[type="submit"]:hover { background: $(accent); }

  /* Universal + complex */
  *, *::before, *::after { box-sizing: inherit; }
|}];
