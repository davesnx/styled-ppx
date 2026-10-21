(* Declarations whose longhands overlap, within one block, group into
   a single atom so the winner is decided by intra-atom source order
   (emotion parity), not by stylesheet position of independently-hashed
   atoms. Most examples below repeat one property; `shorthandReset` mixes
   a shorthand with its own longhand instead - see
   `reason-family-atoms.t` for grouping across properties as the main
   subject. *)

(* Last occurrence wins: blue (used to split into two atoms where
   stylesheet position - first-mint-wins dedup - picked the winner). *)
let dup = [%css "color: blue; color: red; color: blue"]

(* Progressive-enhancement fallback pair: both declarations must ship
   together, in order, inside one rule. *)
let fallback = [%css "display: -webkit-box; display: flex"]

(* Grouping reaches across other properties: the color group anchors at
   the LAST color's position; margin stays its own atom. *)
let interleaved = [%css "color: blue; margin: 0; color: red"]

(* Last-occurrence anchoring: an equal-specificity rule written BETWEEN
   the duplicates must stay before the group, or it would beat the final
   duplicate. Authored cascade when the media matches: blue, green, red
   -> red wins. (First-occurrence anchoring hoisted {blue;red} above the
   media rule, letting green win.) *)
let mediaInterleaved =
  [%css "color: blue; @media (min-width: 600px) { color: green; } color: red"]

(* margin and margin-top overlap on margin-top, so all three
   declarations - shorthand, longhand, shorthand again - group into ONE
   atom, in author order. The final `margin: 10px` resets `margin-top`
   because it is the last declaration in that one rule, the same way any
   repeated property resolves - not because of where two separate atoms
   happen to land in the stylesheet. *)
let shorthandReset = [%css "margin: 0; margin-top: 5px; margin: 10px"]

(* Groups under a nested selector keep the parent chain. *)
let nested = [%css "&:hover { color: blue; color: red; }"]

(* Identical duplicated atoms produce a single class token (used to
   yield "css-A css-A"). *)
let twice = [%css "&:hover { color: red; } &:hover { color: red; }"]

(* Custom properties are case-sensitive: --Foo and --foo don't group. *)
let custom = [%css "--Foo: 1px; --foo: 2px"]

(* Cross-binding: sharing the single-declaration atom (a-tokvmb, for
   color:red) can no longer flip the winner - B's duplicate pair is a
   self-contained group with its own hash. *)
module A = struct
  let x = [%css "color: red"]
end

module B = struct
  let x = [%css "color: blue; color: red"]
end

(* Interpolations group too; the var survives per declaration. *)
let c = "10px"
let vars = [%css "margin: 0; margin: $(c)"]
