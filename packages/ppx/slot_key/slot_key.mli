(** What CSS property/context an atomized styled-ppx rule occupies, so a future
    property-aware [CSS.merge] can decide "does [latter] override [former]?"
    without depending on stylesheet position.

    See .workplace/docs/merge-order-flip-under-dedup.md for the bug this exists
    to fix, and .workplace/plans/atom-slot-keys_PLAN.md for the design
    decisions. Not wired into class names, [CSS.make], the runtime, or
    [generate] yet - this module only computes the key and the override
    relation; nothing calls it yet. *)

(** One atom's position: the at-rule chain it sits under (outer to inner, e.g.
    [[("media", "(max-width:600px)")]] for [@media (max-width:600px)]), and its
    selector suffix relative to [&] rendered by
    {!Styled_ppx_css_parser.Render.selector} ([""] at the top level - a bare
    declaration and a [&]-only group are the same context). Two atoms only ever
    compete for the same context if this is exactly equal; a base declaration
    and its [:hover]/[@media] siblings never interact. *)
type context = {
  at_rules : (string * string) list;
  selector : string;
}

(** The property an atom's declaration names, normalized
    ({!normalize_property}). [All] is CSS's [all] property, which cannot be
    enumerated as a finite leaf list (see {!excluded_from_all}). *)
type property =
  | Named of string
  | All

(** What a [{context; property}] pair actually sets, in terms of leaf
    (non-shorthand) properties. [Leaves] is a property's own name for a plain
    property, or its fully-expanded longhand set for a shorthand (never includes
    the shorthand's own name - CSS gives a shorthand no computed value distinct
    from its longhands). [Everything] is [all]'s non-enumerable "every property
    except {!excluded_from_all}". *)
type covered =
  | Leaves of string list
  | Everything

type t = {
  context : context;
  property : property;
  covered : covered;
  important : bool;
}

(** Lowercase, except a custom property ([--*]), which is case-sensitive.
    Mirrors [Css_file.re]'s [declaration_group_key] - duplicated rather than
    shared because [slot_key] must not depend on the [ppx] library (it is meant
    to be a dependency of it once wired in). *)
val normalize_property : string -> string

(** [direct_children] shorthand table: a shorthand's own immediate components
    only (which may themselves be shorthands, e.g. [border] ->
    [border-width; border-style; border-color] -> [border-top-width; ...]).
    Adding a new shorthand means adding one entry here; {!leaves_of} computes
    the transitive leaf set, so nested shorthands (border -> border-top ->
    border-top-width) stay correct automatically without a hand-flattened list
    to keep in sync. Sourced from the CSS specs cited next to each group in
    slot_key.ml. *)
val direct_children : (string, string list) Hashtbl.t

(** The fully-expanded, deduplicated leaf (non-shorthand) property set for
    [property] - [[property]] itself if it names no shorthand. *)
val leaves_of : string -> string list

(** Properties CSS's [all] does not reset: [direction], [unicode-bidi], and
    every custom property. Per the CSS Cascade spec, [all] resets every other
    property to its initial or inherited value. *)
val excluded_from_all : string -> bool

(** Build the slot key for one atomized rule, exactly as [Css_file.re]'s
    [atomize_rules] produces it: a bare [Declaration], a same-property
    [Declaration] group wrapped in a [&]-only [Style_rule], an atom wrapped in a
    resolved parent selector, any of those under one or more [At_rule] wrappers,
    or [!important] on some or all of a group's declarations (the group's own
    [important] is true if any member is). Returns [None] only for a rule shape
    [atomize_rules] never actually produces (an at-rule with no declaration or
    more than one inner rule reaching the leaf) - defensive, not expected to
    fire on real ppx output. *)
val of_atom : Styled_ppx_css_parser.Ast.rule -> t option

(** [removes ~former ~latter] : true when, in a [CSS.merge] whose right
    argument is meant to override its left, [latter] should cause
    [former]'s class to be dropped from the left side.

    Defined as: the contexts match exactly, [former]'s covered leaf set is
    a subset of [latter]'s, and [former] does not carry [!important] while
    [latter] does not. That one subset rule is intentionally the entire
    override policy - it is what makes shorthand-vs-longhand correctly
    asymmetric with no extra cases:
    - [former = margin-top], [latter = margin]: {[margin-top]} subset of
      the margin's 4-side set -> [true], drop the longhand. A later
      shorthand fully re-specifies every leg it covers, so this reproduces
      what stylesheet order already gives when the shorthand comes later.
    - [former = margin], [latter = margin-top]: the margin's 4-side set is
      NOT a subset of {[margin-top]} -> [false], keep both. Dropping the
      shorthand here would also discard its other three, unrelated legs -
      collateral damage this module refuses to cause. This direction is
      NOT resolved by dropping; it still needs stylesheet position (as
      today) or compile-time shorthand expansion (out of scope here) to be
      correct in every build. See atom-slot-keys_PLAN.md, "Shorthand
      asymmetry".
    - Different contexts (e.g. [former] in [@media], [latter] at the top
      level) never remove each other, regardless of property - a media
      override does not clear an unrelated base declaration, nor the
      reverse. *)
val removes : former:t -> latter:t -> bool

(** Short, deterministic slot-key hash for [t.context, t.property] alone (not
    its covered set) - the encoding a future wiring step could attach next to an
    atom's class name. [t.important] is not part of the hash: two atoms in the
    same slot with different [!important] are still the same slot; {!removes}
    accounts for [!important] separately. *)
val key : t -> string

(** Per-leaf slot-key hashes for [t]'s covered set - [None] for [All]
    ([Everything] is not enumerable). For inspection/debugging only; {!removes}
    does not use this, it compares the structural {!covered} values directly so
    its correctness does not depend on the hash. *)
val covered_keys : t -> string list option
