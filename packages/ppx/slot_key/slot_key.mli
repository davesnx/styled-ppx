(** What CSS property/context an atomized styled-ppx rule occupies, so
    [CSS.merge] can decide "does [latter] override [former]?" by parsing class
    names alone, with no shorthand table at runtime.

    See .workplace/docs/merge-order-flip-under-dedup.md for the bug this exists
    to fix, and .workplace/plans/atom-slot-keys_PLAN.md ("Direction agreed with
    the user", "Wiring phases") for the design this module implements. This is
    phase 1: the algorithm and its primitives. Phase 2 wires the class-name
    string format on top of it in [Hash_class]; phases 3+ wire it into
    atomization, the runtime, and generate. *)

(** One atom's position: the at-rule chain it sits under (outer to inner), and
    its selector suffix relative to [&] rendered by
    {!Styled_ppx_css_parser.Render.selector} ([""] at the top level - a bare
    declaration and a [&]-only group are the same context). Two atoms only ever
    compete for the same context if this is exactly equal. *)
type context = {
  at_rules : (string * string) list;
  selector : string;
}

(** The canonical string {!Hash_class} hashes to get a class name's (optional)
    context token. Empty for the base context, which is why a base atom's class
    name carries no context part at all. *)
val context_key : context -> string

(** Lowercase, except a custom property ([--*]), which is case-sensitive.
    Mirrors [Css_file.re]'s [declaration_group_key] - duplicated rather than
    shared because [slot_key] must not depend on the [ppx] library (it is a
    dependency of it, not the reverse). *)
val normalize_property : string -> string

val is_custom_property : string -> bool

(** [direct_children] shorthand table: a shorthand's own immediate components
    only (which may themselves be shorthands, e.g. [border] ->
    [border-width; border-style; border-color] -> [border-top-width; ...]).
    Built live from {!Css_grammar}'s own [Shorthand] registrations (see
    Css_grammar.Types.kind's doc) - a new shorthand needs one [Shorthand] tag at
    its own registration site in css-grammar, not an edit here; families and
    their leaf bit assignments (below) are derived from this table
    automatically, so nested shorthands stay correct without a hand-flattened
    leaf list. *)
val direct_children : (string, string list) Hashtbl.t

(** The fixed, append-only array {!Registry} assigns family/property ids from -
    position in this array is the id. See its own ORDER RULE comment in
    slot_key.ml: append a newly-needed id at the end, never reorder, never
    re-sort. Exposed so a test can pin its count and its two ends without
    reaching into {!Registry} (not itself exposed - it's Registry's own internal
    id-assignment concern, this array is the append-only *contract* Registry is
    built from). *)
val seed : string array

(** The fully-expanded, deduplicated leaf (non-shorthand) property set for
    [property] - [[property]] itself if it names no shorthand. *)
val leaves_of : string -> string list

(** Properties CSS's [all] does not reset: [direction], [unicode-bidi], and
    every custom property. Per the CSS Cascade spec, [all] resets every other
    property to its initial or inherited value. *)
val excluded_from_all : string -> bool

(** A family groups every property that is transitively related through
    {!direct_children} (e.g. [margin], [margin-top], ..., [margin-left] are one
    family; [border]'s width/style/color and top/right/bottom/left
    decompositions are one 12-leaf family; [border-radius] is a *different*
    family - it shares no leaf with [border]). A property that names no
    shorthand and is not itself a shorthand's child is its own one-member
    family. *)
module Family : sig
  (** The family's fully sorted, deduplicated leaf (non-shorthand) property list
      \- the fixed ordering that assigns each leaf its bit position. *)
  val leaf_members_of : string -> string list

  (** A canonical, deterministic name for [property]'s family: the shortest
      member that is itself a registered shorthand (so
      [family_key_of "border-top-color" = "border"]), or [property] itself when
      no member is a shorthand (a plain property's family key is itself). Two
      properties in the same family always compute the same key. *)
  val family_key_of : string -> string

  (** The bitmask, over {!leaf_members_of}'s fixed ordering, of the leaves
      [property] covers. A plain leaf sets one bit; a shorthand sets the OR of
      every leaf it covers (see {!leaves_of}). *)
  val mask_of : string -> int

  (** [mask_of property] with every bit set - what a family's own root shorthand
      (or a plain, family-less property) covers. *)
  val full_mask_of : string -> int
end

(** A property/family's identity in the fixed, append-only table (see
    slot_key.ml's [Registry]), or a hash-derived id when the table doesn't (yet)
    know it, or the sentinel for CSS's [all]. [Registered]/ [Unregistered] carry
    disjoint integer ranges (enforced in slot_key.ml) so a table hit and a hash
    miss can never coincide; [Unregistered] further partitions custom ([--*])
    properties into their own sub-range, which is what lets {!removes} recognize
    "[former] is a custom property" from the integer alone, with no string
    carried at runtime. *)
type family_id =
  | Registered of int
  | Unregistered of int
  | All

(** [family_id]'s underlying integer - what a class name's family token actually
    encodes. [All] is a single reserved sentinel value distinct from every real
    family. *)
val family_id_to_int : family_id -> int

(** The property/family identity for one (already-normalized) property name:
    {!Family.family_key_of} looked up in the registry if the property
    participates in a shorthand relationship, otherwise the property's own name
    looked up directly. Always succeeds - an unknown property gets a stable
    [Unregistered] id, never an error. *)
val family_id_of : string -> family_id

type t = {
  context : context;
  family : family_id;
  mask : int option;
    (** [None] = the family's full mask (a plain shorthand, or any non-family
        property). [Some m] = a proper subset (a lone longhand, or a "family
        atom" mixing some-but-not-all members - see slot_key.ml's [of_atom]). *)
  important : bool;
}

(** Build the slot key for one atomized rule, exactly as [Css_file.re]'s
    [atomize_rules] produces it today: a bare [Declaration], a same-property
    [Declaration] group wrapped in a [&]-only [Style_rule], an atom wrapped in a
    resolved parent selector, any of those under one or more [At_rule] wrappers,
    or [!important] on some or all of a group's declarations (the group's own
    [important] is true if any member is). Phase 3 additionally teaches
    [Css_file.re] to emit *family atoms* - one atom for a binding that mixes a
    shorthand with its own longhands in one context - which this function
    already handles correctly today via the same multi-declaration-group path
    used for same-property groups: their combined mask is the OR of every
    declaration's own mask. Returns [None] only for a rule shape [atomize_rules]
    never actually produces. *)
val of_atom : Styled_ppx_css_parser.Ast.rule -> t option

(** [removes ~former ~latter] : true when, in a [CSS.merge] whose right argument
    is meant to override its left, [latter] should cause [former]'s class to be
    dropped from the left side.

    Same contexts, then: if [latter.family = All], [former] is removed unless
    its own (single, non-family) property is excluded from [all] (see
    {!excluded_from_all} - carried here via [family_id]'s [Unregistered]
    custom-property sub-range and two fixed [direction]/ [unicode-bidi] registry
    entries, never a string). Otherwise, same [family], and [former.mask] is a
    subset of [latter.mask] under the convention that [None] means "full":
    [None]/[None] are equal (removed - the base case, two values of the same
    plain property or the same bare shorthand); [Some _]/[None] is always a
    subset (a later shorthand or family atom safely absorbs an earlier lone
    longhand it covers); [None]/[Some _] is never a subset (a lone longhand
    cannot remove a shorthand - it would silently drop the shorthand's other
    legs; this direction stays stylesheet-order-dependent, see the plan's
    "accepted limit"); [Some ma]/[Some mb] is a plain bitwise subset check.
    Finally, [former] carrying [!important] blocks removal unless [latter] is
    also [!important]. *)
val removes : former:t -> latter:t -> bool
