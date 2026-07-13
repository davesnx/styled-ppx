(* Repro for `&` compounding lost in nested selector lists under static
   extraction. See styled-ppx-extraction-nested-ampersand-bug.md.

   When a selector list using `&` (e.g. `&:first-child, &:last-child`) is
   nested two levels deep and the intermediate selector is multi-segment
   (`tr:first-child td`), extraction used to resolve `&` with a descendant
   combinator (`td :first-child`) instead of compounding (`td:first-child`). *)

(* Bug: & list nested two levels deep under a multi-segment selector *)
let table =
  [%css
    {|
  tbody {
    tr:first-child td {
      border-top: 1px solid gray;
      &:first-child, &:last-child {
        border-top: 1px solid transparent;
      }
    }
  }
|}]

(* Single & (non-list) at the same depth *)
let single =
  [%css
    {|
  tbody {
    tr:first-child td {
      &:first-child {
        color: red;
      }
    }
  }
|}]

(* & list where the parent's last segment is a compound with pseudo *)
let compoundParent =
  [%css
    {|
  ul {
    li:hover {
      &::before, &::after {
        content: "";
      }
    }
  }
|}]
