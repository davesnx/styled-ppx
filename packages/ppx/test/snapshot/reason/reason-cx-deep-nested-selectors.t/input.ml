(* Repro for cx2 deep-nested selector atomization bug.
   See styled-ppx-bug-report-4.md.

   Single-level nesting works (control case). Depth >= 2 currently drops
   every parent prelude during static extraction, so only the innermost
   selector survives in the emitted CSS. *)

(* Control: single-level nesting -- works correctly *)
let single = [%css {|
  color: red;
  &:hover {
    color: blue;
  }
|}]

(* Bug 1: pseudo-element nested under pseudo-class *)
let twoLevel =
  [%css
    {|
  color: red;
  &:focus-visible {
    &::after {
      content: "";
    }
  }
|}]

(* Bug 2: pseudo-class nested under pseudo-class *)
let twoLevelPseudoClass =
  [%css
    {|
  color: red;
  &:hover {
    &:focus {
      color: green;
    }
  }
|}]

(* Bug 3: three levels deep mixing combinators *)
let threeLevel =
  [%css
    {|
  color: red;
  &:hover {
    & .child {
      &:focus {
        color: green;
      }
    }
  }
|}]

(* Bug 4: descendant selector under pseudo-class *)
let descendantUnderPseudo =
  [%css
    {|
  color: red;
  &:hover {
    .child {
      color: blue;
    }
  }
|}]
