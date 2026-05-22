(* Golden hashes: a fixed stylesheet of representative shapes pinned to
   their expected class names. Refactors to `Render`, `Murmur2`, or the
   atomization pipeline that change rendered rule text will cascade into
   every emitted className. Without a pin, a no-op-intended refactor
   silently busts every cached className downstream — invalidating
   browser caches, CDN caches, and any persisted DOM identifiers.

   When this test fails, the diff IS the cache-busting blast radius.
   Update it deliberately and document the reason. *)

(* Single declaration. *)
let solid = [%css {| color: red; |}]

(* Multiple declarations on one binding. *)
let multi = [%css {|
  margin: 10px;
  padding: 20px;
  color: blue;
|}]

(* Pseudo-class joining onto the binding class. *)
let hovered = [%css {|
  color: black;
  &:hover {
    color: white;
  }
|}]

(* Multi-selector parent fanning out to one atom per selector. *)
let multiSel = [%css {|
  .a, .b {
    color: green;
  }
|}]

(* @media nested under a selector — at-rule wraps the per-binding chain. *)
let withMedia =
  [%css
    {|
  .a {
    @media (min-width: 768px) {
      color: red;
    }
  }
|}]

(* Numeric value with units that exercise float formatting. *)
let units = [%css {|
  width: 1.5rem;
  opacity: 0.5;
|}]

(* var() with fallback exercises the declaration-value capture path. *)
let withFallback = [%css {|
  color: var(--theme, blue);
|}]
