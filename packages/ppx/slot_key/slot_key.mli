(** What CSS property/context an atomized styled-ppx rule occupies, so
    [CSS.merge] can decide "does [latter] override [former]?" by parsing class
    names alone, with no shorthand table at runtime.

    Content-hash deduplication picks a class's position by first stylesheet
    occurrence, not by `CSS.merge`'s own call-site argument order, so `merge(a,
    b)` can silently let `a` win when some unrelated module already emitted
    `b`'s atom earlier in the stylesheet. Encoding each atom's
    context/family/mask in its own class name lets `merge` resolve that
    correctly by parsing the two class names it is given, without a runtime
    shorthand table and without depending on stylesheet order at all.

    This module is the algorithm and its primitives, deliberately free of the
    class-name string format ([Class_format]/[Hash_class] own that) and of the
    atomization/runtime/generate wiring that will call it. *)

(** One atom's position: the at-rule chain it sits under (outer to inner), its
    selector suffix relative to [&] rendered by
    {!Styled_ppx_css_parser.Render.selector} ([""] at the top level - a bare
    declaration and a [&]-only group are the same context), and whether it
    carries [!important]. Two atoms only ever compete for the same context if
    this is exactly equal - [important] is folded in here rather than checked as
    a separate guard on {!removes}, so a declaration and its [!important] twin
    are never in the same context and never remove each other in either
    direction; the browser's own cascade already decides between them. *)
type context = {
  at_rules : (string * string) list;
  selector : string;
  important : bool;
}

(** The canonical string {!Hash_class} hashes to get a class name's (optional)
    context token. Empty for the base, non-important context, which is why a
    base atom's class name carries no context part at all - an [!important] atom
    in the base context is therefore no longer free: it is folded in as a
    synthetic leading [at_rules] entry (["!important"]), the same composition
    {!context}'s own doc describes, so it costs a real context token like any
    other wrapper would. *)
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

(** A property/family's identity: a table index, or - when the property has no
    table slot - a hash-derived id, distinguishing an ordinary property from a
    custom ([--*]) one by constructor rather than by numeric range (the family
    field is 2 base36 chars, too narrow to spare a whole reserved sub-range the
    way a wider field could), or the sentinel for CSS's [all]. See
    {!family_marker}/ {!extended_hash} for how this splits into the two
    class-name fields a non-[Registered] id actually needs. *)
type family_id =
  | Registered of int
  | Unregistered of int
  | UnregisteredCustom of int
  | All

(** The family FIELD's own value - always exactly what [Class_format] writes
    into the 2-char family slot: the table index for [Registered], or one of two
    single reserved marker values for [Unregistered]/ [UnregisteredCustom]
    (never the payload - that lives in {!extended_hash}), or the [all] sentinel.
*)
val family_marker : family_id -> int

(** [Some hash] for [Unregistered]/[UnregisteredCustom] - the real identity a
    marker in the family field says "look elsewhere for", encoded in its own
    extended-hash class-name field (present only when {!family_marker} is one of
    the two markers). [None] for [Registered]/[All], which need no second field.
*)
val extended_hash : family_id -> int option

(** Width, in base36 chars, of the extended-hash field above - owned here (not
    in [Class_format], which depends on this module) so the encoder and this
    module's own hash-reduction stay in sync by construction. *)
val extended_hash_width : int

(** The property/family identity for one (already-normalized) property name:
    {!Family.family_key_of} looked up in the registry if the property
    participates in a shorthand relationship, otherwise the property's own name
    looked up directly. Always succeeds - an unknown property gets a stable
    [Unregistered]/[UnregisteredCustom] id, never an error. *)
val family_id_of : string -> family_id

type t = {
  context : context;
  family : family_id;
  mask : int option;
    (** [None] = the family's full mask (a plain shorthand, or any non-family
        property). [Some m] = a proper subset (a lone longhand, or a "family
        atom" mixing some-but-not-all members - see slot_key.ml's [of_atom]). *)
  bundle : bool;
    (** True when [Css_file.re] is treating this atom as part of a REAL bundle:
        two or more interpolating declarations from the same block that
        interpolate the SAME source path (transitively - see [Css_file.re]'s
        [transform_rule_list]) sharing one class. A single interpolating
        declaration, or one whose path no sibling declaration shares, is NOT a
        bundle - it mints its own real, merge-participating slot-keyed class
        instead (see [Class_format.slot_class]). {!of_atom} always returns
        [false] here: bundle-hood depends on how many OTHER declarations in the
        block share this atom's path, which one atom's own AST can't say, and
        the real pipeline never needs it to say [true] either, since a genuine
        bundle's class is minted directly by [Class_format.bundle_class],
        bypassing this type entirely (see slot_key.ml's [of_atom] for the full
        reasoning). {!removes} still exempts a bundle atom in both directions
        when one is constructed with [bundle = true] by hand (a test does this
        to exercise that exemption; nothing in the real pipeline does). *)
}

(** Build the slot key for one atomized rule, exactly as [Css_file.re]'s
    [atomize_rules] produces it today: a bare [Declaration], a same-property
    [Declaration] group wrapped in a [&]-only [Style_rule], an atom wrapped in a
    resolved parent selector, any of those under one or more [At_rule] wrappers,
    or [!important] on some or all of a group's declarations (the group's own
    {!context}.[important] is true if any member is). Once [Css_file.re] is
    taught to emit *family atoms* - one atom for a binding that mixes a
    shorthand with its own longhands in one context - this function already
    handles that shape correctly today via the same multi-declaration-group path
    used for same-property groups: their combined mask is the OR of every
    declaration's own mask. Returns [None] only for a rule shape [atomize_rules]
    never actually produces. The returned {!t.bundle} is always [false] - see
    its own doc for why. *)
val of_atom : Styled_ppx_css_parser.Ast.rule -> t option

(** [removes ~former ~latter] : true when, in a [CSS.merge] whose right argument
    is meant to override its left, [latter] should cause [former]'s class to be
    dropped from the left side.

    [false] immediately if either side is a {!t.bundle} atom - bundles are
    opaque to this decision in both directions. Otherwise: same contexts, then
    if [latter.family = All], [former] is removed unless its own (single,
    non-family) property is excluded from [all] (see {!excluded_from_all} -
    carried here via [family_id]'s [UnregisteredCustom] constructor and two
    fixed [direction]/ [unicode-bidi] registry entries, never a string).
    Otherwise, same [family], and [former.mask] is a subset of [latter.mask]
    under the convention that [None] means "full": [None]/[None] are equal
    (removed - the base case, two values of the same plain property or the same
    bare shorthand); [Some _]/[None] is always a subset (a later shorthand or
    family atom safely absorbs an earlier lone longhand it covers);
    [None]/[Some _] is never a subset (a lone longhand cannot remove a shorthand
    \- it would silently drop the shorthand's other legs; `merge(wide, narrow)`
    therefore stays a known, accepted limit that still depends on stylesheet
    order); [Some ma]/[Some mb] is a plain bitwise subset check. [!important]
    carries no separate check here - it is already part of {!context}, so
    [former]'s and [latter]'s importance must already agree for "same contexts"
    to hold at all. *)
val removes : former:t -> latter:t -> bool
