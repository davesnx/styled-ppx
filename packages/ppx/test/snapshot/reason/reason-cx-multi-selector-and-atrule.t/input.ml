(* Coverage for cx2 atomization edge cases that were previously broken:

   - Multi-selector preludes (a, b { ... }) must produce one atom per
     selector, not collapse to the first. CSS-nesting semantics for
     `a, b { c: d }` are equivalent to `a { c: d } b { c: d }`.
   - Nested multi-selector preludes must Cartesian-product correctly
     (`a, b { c, d { ... } }` -> `a c, a d, b c, b d`).
   - `@media`/at-rules nested under Style_rule(s) must carry the parent
     selector chain into the at-rule's contents, not drop it. *)

(* Multi-selector at top: produces two atoms (one per selector). *)
let multiTop = [%css {|
  .a, .b {
    color: red;
  }
|}]

(* Multi-selector in nested position. *)
let multiNested =
  [%css {|
  .parent {
    .a, .b {
      color: blue;
    }
  }
|}]

(* Cartesian product of nested multi-selector preludes:
   `.a, .b` x `.c, .d` -> 4 atoms covering `.a .c`, `.a .d`, `.b .c`, `.b .d`. *)
let cartesian =
  [%css {|
  .a, .b {
    .c, .d {
      color: green;
    }
  }
|}]

(* Multi-selector with mixed declaration + nested rule.
   Decls fan out per selector; nested rule fans out per (parent, child) pair. *)
let multiMixed =
  [%css
    {|
  .a, .b {
    color: red;
    &:hover {
      color: blue;
    }
  }
|}]

(* @media nested under a single Style_rule: the parent prelude must
   appear inside the @media block, not be dropped. *)
let mediaUnderSelector =
  [%css
    {|
  .a {
    @media (min-width: 768px) {
      color: red;
    }
  }
|}]

(* @media nested under deeper Style_rule chain: full chain must survive. *)
let mediaDeep =
  [%css
    {|
  .a {
    .b {
      @media (max-width: 600px) {
        color: red;
      }
    }
  }
|}]

(* @media nested under a Style_rule containing a mix of declarations and
   nested rules: declarations inside the @media still get the parent. *)
let mediaWithNested =
  [%css
    {|
  .a {
    color: black;
    @media (max-width: 600px) {
      color: red;
      &:hover {
        color: blue;
      }
    }
  }
|}]
