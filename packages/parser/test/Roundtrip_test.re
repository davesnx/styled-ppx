/* Round-trip regression: parse -> render -> parse -> render should be a
   fixpoint at the render layer, and the two parses should agree on AST
   shape (modulo source locations). Closes the gap flagged in
   .workplace/docs/parser-audit-quality.md Finding 4 ("no round-trip
   test") -- nothing else in this package or in css-grammar/test exercises
   parse/render stability directly.

   Comments are skipped by the lexer and never reach the AST, and
   whitespace/quote/number formatting is not preserved verbatim (CSS
   allows many spellings of the same value). So a case is never compared
   against its own source text -- only the first render/parse is compared
   against the second. */

open Alcotest;

module Ast = Styled_ppx_css_parser.Ast;
module Driver = Styled_ppx_css_parser.Driver;
module Render = Styled_ppx_css_parser.Render;
module Parser_location = Styled_ppx_css_parser.Parser_location;

/* Parsed as a standalone file, so location offsets never leak into the
   fixture text below; every comparison is between two parses, never
   against a fixed offset. */
let source_position_start = Parser_location.file_start();

let parse_exn = css =>
  switch (Driver.parse_declaration_list(~source_position_start, css)) {
  | Ok(value) => value
  | Error((_, msg)) =>
    fail("expected declaration list parse success for " ++ css ++ ": " ++ msg)
  };

let render = (rules: Ast.rule_list) => Render.rule_list(rules);

/* Ast's [@deriving show] prints every location with the fixed
   "start ... end ..." shape defined by Ast.location. Blank it out so two
   ASTs parsed from differently-sized strings can be compared by shape
   alone. */
let loc_pattern =
  Str.regexp(
    "start [0-9]+ [0-9]+ [0-9]+ (L:[0-9]+ c:[0-9]+)"
    ++ " end [0-9]+ [0-9]+ [0-9]+ (L:[0-9]+ c:[0-9]+)",
  );
/* `Variable`/`ClassVariable` (interpolation references, e.g. `$(x)` or
   `&.$(x)`) carry a bare `Ppxlib.Location.t`, not a `with_loc`, so it has
   no `[@printer location]` attribute (see Ast.re's `component_value` and
   `simple_selector`/`subclass_selector`) and prints via the default
   derived record printer instead of the compact form above. Blank out
   each of its leaf fields individually rather than the whole record, so
   this doesn't depend on matching newlines or nested braces. */
let loc_field_patterns = [
  (Str.regexp("pos_fname = \"[^\"]*\""), "pos_fname = <f>"),
  (Str.regexp("pos_lnum = [0-9]+"), "pos_lnum = <n>"),
  (Str.regexp("pos_bol = [0-9]+"), "pos_bol = <n>"),
  (Str.regexp("pos_cnum = [0-9]+"), "pos_cnum = <n>"),
  (Str.regexp("loc_ghost = \\(true\\|false\\)"), "loc_ghost = <b>"),
];
/* [@deriving show]'s Format-based pretty-printer wraps a record onto
   multiple lines once it no longer fits the page width, and that
   decision depends on how many columns the surrounding text already
   used -- which shifts by a character or two once the numeric offsets
   above vary in digit count between ast1 and ast2. None of that line
   layout is semantic, so collapse all whitespace before comparing;
   what's left is just the sequence of constructors and values. */
let whitespace_pattern = Str.regexp("[ \t\n]+");
/* Collapsing to a single space (above) still leaves a real difference
   between "no line break here" (zero characters) and "line break here"
   (now one space) at a box edge right next to punctuation, where the
   punctuation alone already marks the boundary unambiguously. Delete
   whitespace touching brackets/parens/braces/comma/semicolon; leave the
   single space between two bare words (e.g. "SimpleSelector Universal")
   alone, since that space is the only thing separating those two
   tokens. */
let space_before_close = Str.regexp(" \\([]}),;]\\)");
let space_after_open = Str.regexp("\\([[{(]\\) ");
let shape_of = rules => {
  let raw = Ast.show_rule_list(rules);
  let raw = Str.global_replace(loc_pattern, "<loc>", raw);
  let raw =
    List.fold_left(
      (s, (pattern, template)) => Str.global_replace(pattern, template, s),
      raw,
      loc_field_patterns,
    );
  let raw = Str.global_replace(whitespace_pattern, " ", raw);
  let raw = Str.global_replace(space_before_close, "\\1", raw);
  Str.global_replace(space_after_open, "\\1", raw);
};

/* Mirrors the canonicalization Render.re itself applies (Render.re:1-16,
   62-72): a freshly parsed AST keeps incidental leading/trailing
   Whitespace tokens in declaration values and at-rule preludes, and keeps
   style rules with an empty block; the renderer strips both away. Without
   this, comparing a fresh parse to a parse-after-one-render would flag
   that intentional, already-documented canonicalization as a spurious
   "divergence" on almost every declaration (anywhere source has the
   ordinary "prop: value" space). Applied to both sides of the AST
   comparison below, so it's a no-op on an already-canonical AST. */
let strip_trailing_whitespace = (value: Ast.component_value_list) =>
  value |> List.rev |> Render.strip_leading_whitespace |> List.rev;

let rec normalize_rule_list = ((rules, loc): Ast.rule_list): Ast.rule_list => (
  rules
  |> List.filter(
       fun
       | Ast.Style_rule({ block: ([], _), _ }) => false
       | _ => true,
     )
  |> List.map(normalize_rule),
  loc,
)
and normalize_rule = (rule: Ast.rule): Ast.rule =>
  switch (rule) {
  | Ast.Declaration(d) =>
    Ast.Declaration({
      ...d,
      value: normalize_value(d.value),
    })
  | Ast.Style_rule(sr) =>
    Ast.Style_rule({
      ...sr,
      block: normalize_rule_list(sr.block),
    })
  | Ast.At_rule(ar) =>
    Ast.At_rule({
      ...ar,
      prelude: (
        Render.strip_leading_whitespace(fst(ar.prelude)),
        snd(ar.prelude),
      ),
      block: normalize_brace_block(ar.block),
    })
  }
and normalize_value = (value: Ast.with_loc(Ast.component_value_list)) => (
  value |> fst |> Render.strip_leading_whitespace |> strip_trailing_whitespace,
  snd(value),
)
and normalize_brace_block = (block: Ast.brace_block): Ast.brace_block =>
  switch (block) {
  | Ast.Empty => Ast.Empty
  | Ast.Rule_list(rl) => Ast.Rule_list(normalize_rule_list(rl))
  | Ast.Stylesheet((rules, loc)) =>
    Ast.Stylesheet((List.map(normalize_rule, rules), loc))
  };

/* CSS bodies copied from packages/ppx/test/css-support cram fixtures
   (read once by hand, not loaded from disk here) plus hand-picked edge
   cases for grammar the fixtures don't happen to cover. Each entry is
   (label, css). */
let corpus = [
  /* backgrounds-and-borders-module.t */
  ("background-repeat list", "background-repeat: space"),
  ("background-repeat comma list", "background-repeat: repeat-x, repeat-y"),
  ("background-size two values", "background-size: 50em 50%"),
  ("background shorthand with slash", "background: top left / 50% 60%"),
  /* monorepo-patterns.t */
  ("transition 4-part shorthand", "transition: all 200ms ease 0ms"),
  (
    "box-shadow with interpolation",
    "box-shadow: inset 0 -1px 0 0 $(Color.Border.lineAlpha)",
  ),
  (
    "box-shadow comma list with interpolation",
    "box-shadow: 0 0 0 1px $(Color.Shadow.elevation1), 0 1px 0 0 $(Color.Shadow.elevation1Bottom)",
  ),
  (
    "border shorthand with interpolation",
    "border: 1px solid $(Color.Border.line)",
  ),
  (
    "animation shorthand",
    "animation: helpMenuFadeIn 0.18s ease-in-out forwards",
  ),
  (
    "transition with cubic-bezier",
    "transition: height 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94), opacity 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94)",
  ),
  (
    "box-shadow with important",
    "box-shadow: inset 1px 0 0 0 transparent !important",
  ),
  ("transition with important", "transition: transform 0.3s !important"),
  /* monorepo-cx-patterns.t */
  (
    "space before colon, two declarations",
    "width: 30px;\ncolor : $(Color.Text.tertiary);",
  ),
  (
    "nested hover with multi-value important box-shadow",
    "box-shadow: inset 0 0 0 0 transparent;\n\n  &:hover {\n    box-shadow:\n      1px 0 0 0 $(Color.Border.line),\n      inset 0 -1px 0 0 $(Color.Border.line) !important\n  }\n",
  ),
  (
    "nested class-interpolation selector",
    "flex-grow: 1;\nz-index: 1;\ntransition: all 200ms ease 0ms;\n\n&.$(_sidebarClosed) {\n  min-width: 0;\n  max-width: 0;\n  opacity: 0;\n  overflow: hidden;\n}\n",
  ),
  /* declaration-trailing-space.t */
  ("declaration with explicit semicolon and spaces", " display: flex; "),
  ("declaration without semicolon and trailing space", " display: flex "),
  ("nested block with explicit semicolon", " & > * { min-height: 0; } "),
  ("nested block without semicolon", " & > * { min-height: 0 } "),
  (
    "media block with explicit semicolon",
    " @media (min-width: 100px) { display: flex; } ",
  ),
  (
    "media block without semicolon",
    " @media (min-width: 100px) { display: flex } ",
  ),
  /* missing-semicolon-before-nested-block.t (ASI disambiguation) */
  (
    "ASI: value then nested pseudo-class selector",
    "background-color: red\n\n  &:nth-child(2n) {\n    background-color: blue;\n  }\n",
  ),
  (
    "ASI: value then child combinator on same line",
    "transition: max-height 400ms ease-in-out 0ms & > * {\n    opacity: 0;\n    transition-duration: 400ms;\n  }\n",
  ),
  (
    "ASI: value then media block on same line",
    "margin-bottom: 24px @media (min-width: 1024px) {\n    width: 50%;\n  }\n",
  ),
  (
    "ASI: value, comment, then class selector",
    "transition: transform 200ms ease-in-out 0ms /* Need to use selectSelf. */\n    &.contentAfterOpen {\n    transform: translateY(16px);\n  }\n",
  ),
  (
    "ASI: value then class selector on next line",
    "color: red\n  .child {\n    color: blue;\n  }\n",
  ),
  (
    "ASI: value then type selector on next line",
    "color: red\n  svg path {\n    fill: blue;\n  }\n",
  ),
  (
    "ASI: value then bare descendant combinator",
    "height: 100% & h4 {\n    padding: 0;\n  }\n",
  ),
  /* selector-class-interpolation.t */
  ("class-interpolation selector alone", "&.$(foo) { color: blue; }"),
  (
    "not() wrapping class-interpolation",
    "background-color: blue;\n\n  &:disabled:not(&.$(buttonLoadingAnimation)) {\n    background-color: gray;\n  }\n",
  ),
  /* animations.t */
  (
    "cubic-bezier with leading-dot fractions",
    "animation-timing-function: cubic-bezier(.5, .5, .5, .5)",
  ),
  (
    "cubic-bezier with signed leading-dot fractions",
    "animation-timing-function: cubic-bezier(.5, 1.5, .5, -2.5)",
  ),
  ("iteration count decimal", "animation-iteration-count: 4.35"),
  ("direction keyword", "animation-direction: alternate-reverse"),
  /* Edge cases not present in the css-support fixtures. */
  ("supports block", "@supports (display: grid) { display: grid; }"),
  ("container block", "@container (min-width: 400px) { width: 50%; }"),
  ("calc expression", "width: calc(100% - 10px)"),
  ("var with fallback", "color: var(--x, blue)"),
  (":is() selector", "&:is(.a, .b) { color: red; }"),
  (":where() selector", "&:where(.a, .b) { color: red; }"),
  (":not() selector", "&:not(.a) { color: red; }"),
  (":has() selector", "&:has(> span) { color: red; }"),
  ("attribute selector with matcher", "a[href^=\"https\"] { color: red; }"),
  ("pseudo-element", "&::before { content: \"x\"; }"),
  (
    "unsigned and signed leading-dot numbers",
    "opacity: .5;\nmargin: -.5px;\nline-height: 1e3;",
  ),
  ("string with escaped quote and backslash", "content: \"a\\\"b\\\\c\""),
  (
    "comment between declarations is dropped",
    "color: red; /* comment */ background: blue;",
  ),
  (
    "comment right before terminator is dropped",
    "content: 'x' /* trailing */;",
  ),
];

/* Unquoted CSS `url(foo.png)` parses to the dedicated `Ast.Uri` variant,
   but `Render.serialize_uri` always re-emits url() with a quoted string
   argument, and a quoted `url("foo.png")` parses as a generic
   `Ast.Function` (name "url") over a `String` body, not as `Ast.Uri`.
   Render text is stable (both forms print identically), but `Ast.Uri` is
   structurally unreachable after a single render pass -- anything
   downstream that pattern-matches on `Ast.Uri` only sees it for
   never-rendered, freshly-parsed source. Kept for render-stability only;
   excluded from the AST-shape check below, and pinned as a known
   divergence underneath instead. */
let render_only_corpus = [
  ("background url list", "background: url(foo.png), url(bar.svg)"),
  ("url function", "background: url(foo.png)"),
];

/* Cases with a known, currently-real round-trip divergence. Each stays a
   green test that pins the actual (imperfect) behavior, per the task: a
   legitimate failure is a finding to keep visible, not a fixture to
   delete or silently skip. */
let known_divergences = [
  (
    "unquoted url() becomes a generic Function after one render",
    "Ast.Uri is not reconstructed from Render's always-quoted url() output; see render_only_corpus above",
    () => {
      let ast1 = parse_exn("background:url(foo.png)");
      switch (ast1) {
      | (
          [Ast.Declaration({ value: ([(Ast.Uri("foo.png"), _)], _), _ })],
          _,
        ) =>
        ()
      | _ =>
        fail("expected unquoted url() to parse as Ast.Uri before any render")
      };
      let ast2 = ast1 |> render |> parse_exn;
      switch (ast2) {
      | (
          [
            Ast.Declaration({
              value:
                (
                  [
                    (
                      Ast.Function({
                        name: ("url", _),
                        body: ([(Ast.String("foo.png"), _)], _),
                        _,
                      }),
                      _,
                    ),
                  ],
                  _,
                ),
              _,
            }),
          ],
          _,
        ) =>
        ()
      | _ =>
        fail(
          "expected the second parse to see a generic Function instead of Ast.Uri -- "
          ++ "if this now fails because Ast.Uri round-trips, delete this pinned test "
          ++ "and move the case back into the main corpus",
        )
      };
    },
  ),
];

let render_stable_tests =
  corpus
  @ render_only_corpus
  |> List.map(((label, css)) => {
       let assertion = () => {
         let render1 = css |> parse_exn |> render;
         let render2 = render1 |> parse_exn |> render;
         check(
           string,
           "render(parse(css)) is a render fixpoint",
           render1,
           render2,
         );
       };
       test_case(label, `Quick, assertion);
     });

let ast_stable_tests =
  corpus
  |> List.map(((label, css)) => {
       let assertion = () => {
         let ast1 = parse_exn(css);
         let render1 = render(ast1);
         let ast2 = parse_exn(render1);
         check(
           string,
           "parse(render(parse(css))) matches parse(css) modulo locations and whitespace canonicalization",
           shape_of(normalize_rule_list(ast1)),
           shape_of(normalize_rule_list(ast2)),
         );
       };
       test_case(label, `Quick, assertion);
     });

let known_divergence_tests =
  known_divergences
  |> List.map(((label, reason, assertion)) =>
       test_case(
         label ++ " (known divergence: " ++ reason ++ ")",
         `Quick,
         assertion,
       )
     );

let tests =
  List.concat([
    render_stable_tests,
    ast_stable_tests,
    known_divergence_tests,
  ]);
