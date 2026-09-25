module Ast = Styled_ppx_css_parser.Ast
module Render = Styled_ppx_css_parser.Render

type context = {
  at_rules : (string * string) list;
  selector : string;
  important : bool;
    (** [!important] is folded into the context, as if it were one more wrapper
        around the declaration, like an [at_rules] entry (2026-09-25 user
        decision, replacing an earlier separate importance guard on [removes]) -
        a declaration and its [!important] twin are therefore never in the same
        context, so [removes] never removes either one in favor of the other;
        the browser's own cascade already decides between them, and [CSS.merge]
        does not need a second opinion. See {!context_key}. *)
}

let is_custom_property name =
  String.length name >= 2 && name.[0] = '-' && name.[1] = '-'

let normalize_property name =
  if is_custom_property name then name else String.lowercase_ascii name

(* Direct shorthand -> immediate-children edges only, sourced live from
   css-grammar's own registrations (packages/css-grammar/lib/Properties/
   *.ml, one [Shorthand (name, longhands)] tag per shorthand, spec-cited
   right there next to each registration - see Css_grammar.Types.kind's
   doc). A child that is itself a shorthand (e.g. "border" -> "border-width")
   is expanded by {!leaves_of} and {!Family}, not flattened here - that is
   what keeps nested shorthands (border -> border-top -> border-top-width)
   correct without a hand-maintained flat list.

   How this stays current: css-grammar is the single source of truth now -
   a newly-added CSS shorthand needs one [Shorthand] tag at its own
   registration site (see any existing one for the shape), nothing in this
   module changes. A shorthand css-grammar does not yet tag this way falls
   through {!leaves_of} as a plain leaf (itself), which is always safe
   (never wrongly claims to cover properties it does not) even if it's
   under-informative (never lets it remove or be removed by its own real
   longhands) until someone tags it. *)
let direct_children : (string, string list) Hashtbl.t =
  let table = Hashtbl.create 128 in
  Css_grammar.shorthands ()
  |> List.iter (fun (shorthand, children) ->
    Hashtbl.replace table shorthand children);
  table

(* Deliberately NOT unified: CSS Logical Properties and Values L1 makes a
   logical property's physical target depend on the element's
   writing-mode/direction at run time (margin-inline-start is margin-left
   in LTR, margin-right in RTL). This module has no access to that at
   compile time, so treating margin-inline-start and margin-left as the
   same leaf would be wrong on every RTL page, not just incomplete. Logical
   properties only expand into their own logical siblings above
   (margin-inline -> margin-inline-start/-end), never into a physical
   property. *)

let rec expand seen property =
  if List.mem property seen then [ property ]
  else (
    match Hashtbl.find_opt direct_children property with
    | None -> [ property ]
    | Some children ->
      children
      |> List.concat_map (expand (property :: seen))
      |> List.sort_uniq String.compare)

let leaves_of property = expand [] property

let excluded_from_all name =
  name = "direction" || name = "unicode-bidi" || is_custom_property name

(* --- Context --------------------------------------------------------- *)

let context_key { at_rules; selector; important } =
  (* [important] is prepended as a synthetic leading "at-rule" entry, not a
     separate field in the key - the whole point is that it composes with
     the real [at_rules]/[selector] exactly like another wrapper would,
     using the same [at_rules_part] machinery, rather than needing its own
     parallel encoding. *)
  let at_rules =
    if important then ("!important", "") :: at_rules else at_rules
  in
  let at_rules_part =
    at_rules
    |> List.map (fun (name, prelude) -> Printf.sprintf "@%s\x00%s" name prelude)
    |> String.concat "\x00"
  in
  if at_rules_part = "" && selector = "" then ""
  else at_rules_part ^ "\x00" ^ selector

(* --- Families: union-find over [direct_children] ---------------------- *)

module Family = struct
  (* Two properties are in the same family iff some [direct_children] entry's
     fully-expanded leaf set ({!leaves_of}) contains both - e.g.
     margin-top/margin-left are unioned via the "margin" entry;
     border-top-width/border-color are unioned transitively (border-top ->
     {border-top-width,...}, border -> border-color -> {...}, both within
     the same 12-leaf closure). A shorthand's own name is unioned with its
     leaves too, so "border" itself lands in the family, not just its
     children. Deterministic: the smaller string always becomes the root,
     independent of Hashtbl.iter's unspecified order. *)
  let parent : (string, string) Hashtbl.t = Hashtbl.create 128

  let rec find x =
    match Hashtbl.find_opt parent x with
    | None ->
      Hashtbl.add parent x x;
      x
    | Some p when p = x -> x
    | Some p ->
      let root = find p in
      Hashtbl.replace parent x root;
      root

  let union a b =
    let ra = find a in
    let rb = find b in
    if ra <> rb then (
      let winner, loser = if compare ra rb <= 0 then ra, rb else rb, ra in
      Hashtbl.replace parent loser winner)

  let () =
    Hashtbl.iter
      (fun shorthand _ ->
        List.iter (fun leaf -> union shorthand leaf) (leaves_of shorthand))
      direct_children

  let members_by_root : (string, string list) Hashtbl.t = Hashtbl.create 64

  let () =
    Hashtbl.iter
      (fun prop _root ->
        let root = find prop in
        let current =
          Option.value (Hashtbl.find_opt members_by_root root) ~default:[]
        in
        if not (List.mem prop current) then
          Hashtbl.replace members_by_root root (prop :: current))
      parent

  (* Every property (shorthand, intermediate, or leaf) that participates in
     [prop]'s family, including [prop] itself whether or not it was ever a
     [direct_children] key. Singleton (never in [parent]) for a property
     with no shorthand relationship at all. *)
  let all_members_of prop =
    match Hashtbl.find_opt parent prop with
    | None -> [ prop ]
    | Some root ->
      Hashtbl.find_opt members_by_root root |> Option.value ~default:[ prop ]

  let leaf_members_of prop =
    all_members_of prop
    |> List.filter (fun m -> not (Hashtbl.mem direct_children m))
    |> List.sort_uniq String.compare

  (* The shortest member that is itself a shorthand (a [direct_children]
     key), ties broken alphabetically - picks "border" over "border-top"
     or "border-width" as the family's canonical name. A family with no
     shorthand member at all (every real property that names no
     shorthand and isn't anyone's child) uses [prop] itself. *)
  let family_key_of prop =
    let shorthand_members =
      all_members_of prop |> List.filter (Hashtbl.mem direct_children)
    in
    match shorthand_members with
    | [] -> prop
    | _ :: _ ->
      shorthand_members
      |> List.sort (fun a b ->
        match compare (String.length a) (String.length b) with
        | 0 -> compare a b
        | c -> c)
      |> List.hd

  let bit_position_of leaf leaves =
    let rec index i = function
      | [] -> invalid_arg ("Slot_key.Family: " ^ leaf ^ " not in its own family")
      | x :: _ when x = leaf -> i
      | _ :: rest -> index (i + 1) rest
    in
    index 0 leaves

  let mask_of prop =
    let leaves = leaf_members_of prop in
    leaves_of prop
    |> List.fold_left
         (fun mask leaf ->
           match List.find_opt (( = ) leaf) leaves with
           | Some _ -> mask lor (1 lsl bit_position_of leaf leaves)
           | None -> mask
           (* defensive: shouldn't happen, leaves_of prop
                              subset of prop's own family by construction *))
         0

  let full_mask_of prop =
    let n = List.length (leaf_members_of prop) in
    if n = 0 then 0 else (1 lsl n) - 1
end

(* --- Registry: fixed, append-only property/family id table ----------- *)

(* Every id this table hands out - a shorthand family's canonical name (see
   {!Family.family_key_of}) or a standalone (family-less) property's own
   name - in one fixed, literal, append-only array. Position in this array
   IS the id (see {!Registry.table} below, which uses this array's order
   verbatim - no sorting, no filtering, ever, at build time). Seeded
   2026-09-25 from every property packages/css-grammar/lib/Properties/*.ml
   registers (757, via [Css_grammar.property_names ()], the 25 internal
   `@media`-feature-grammar entries in Properties/Media.ml excluded - they
   are not CSS properties, see Css_grammar.Registry's module doc; also
   excludes "backdrop-blur" and "container-name-computed", removed
   2026-09-25 - see the plan's Decisions), reduced through {!resolve_alias}
   and {!Family.family_key_of} to the 526 distinct ids actually needed (44
   shorthand-family canonical keys + 482 standalone properties) - a leaf
   covered by some family (e.g. "margin-top") needs no entry of its own,
   and neither does a true alias (e.g. "font-width", "word-
   wrap"), {!family_id_of} redirects both kinds to their canonical key.

   ORDER RULE: append a newly-needed id at the END, never insert
   alphabetically, never reorder, never remove. Moving an existing entry's
   position changes every atom's class name built before the move - this
   array's whole purpose is to make that impossible by construction. A
   property not (yet) listed here still gets a correct, stable id via
   {!family_id_of}'s hash fallback below, just not as short a class name
   until it's added here. This alphabetical order is simply how the 2026-
   09-25 seed happened to be authored, not an ongoing invariant. *)
let seed : string array =
  [|
    "--*";
    "-moz-appearance";
    "-moz-background-clip";
    "-moz-binding";
    "-moz-border-bottom-colors";
    "-moz-border-left-colors";
    "-moz-border-radius-bottomleft";
    "-moz-border-radius-bottomright";
    "-moz-border-radius-topleft";
    "-moz-border-radius-topright";
    "-moz-border-right-colors";
    "-moz-border-top-colors";
    "-moz-context-properties";
    "-moz-control-character-visibility";
    "-moz-float-edge";
    "-moz-force-broken-image-icon";
    "-moz-image-region";
    "-moz-orient";
    "-moz-osx-font-smoothing";
    "-moz-outline-radius";
    "-moz-stack-sizing";
    "-moz-text-blink";
    "-moz-user-focus";
    "-moz-user-input";
    "-moz-user-modify";
    "-moz-user-select";
    "-moz-window-dragging";
    "-moz-window-shadow";
    "-ms-accelerator";
    "-ms-block-progression";
    "-ms-content-zoom-chaining";
    "-ms-content-zoom-limit";
    "-ms-content-zoom-limit-max";
    "-ms-content-zoom-limit-min";
    "-ms-content-zoom-snap";
    "-ms-content-zoom-snap-points";
    "-ms-content-zoom-snap-type";
    "-ms-content-zooming";
    "-ms-filter";
    "-ms-flow-from";
    "-ms-flow-into";
    "-ms-grid-columns";
    "-ms-grid-rows";
    "-ms-high-contrast-adjust";
    "-ms-hyphenate-limit-chars";
    "-ms-hyphenate-limit-lines";
    "-ms-hyphenate-limit-zone";
    "-ms-ime-align";
    "-ms-overflow-style";
    "-ms-scroll-chaining";
    "-ms-scroll-limit";
    "-ms-scroll-limit-x-max";
    "-ms-scroll-limit-x-min";
    "-ms-scroll-limit-y-max";
    "-ms-scroll-limit-y-min";
    "-ms-scroll-rails";
    "-ms-scroll-snap-points-x";
    "-ms-scroll-snap-points-y";
    "-ms-scroll-snap-type";
    "-ms-scroll-snap-x";
    "-ms-scroll-snap-y";
    "-ms-scroll-translation";
    "-ms-scrollbar-3dlight-color";
    "-ms-scrollbar-arrow-color";
    "-ms-scrollbar-base-color";
    "-ms-scrollbar-darkshadow-color";
    "-ms-scrollbar-face-color";
    "-ms-scrollbar-highlight-color";
    "-ms-scrollbar-shadow-color";
    "-ms-scrollbar-track-color";
    "-ms-text-autospace";
    "-ms-touch-select";
    "-ms-user-select";
    "-ms-wrap-flow";
    "-ms-wrap-margin";
    "-ms-wrap-through";
    "-webkit-appearance";
    "-webkit-background-clip";
    "-webkit-border-before";
    "-webkit-box-orient";
    "-webkit-box-reflect";
    "-webkit-box-shadow";
    "-webkit-column-break-after";
    "-webkit-column-break-before";
    "-webkit-column-break-inside";
    "-webkit-font-smoothing";
    "-webkit-line-clamp";
    "-webkit-mask";
    "-webkit-mask-box-image";
    "-webkit-overflow-scrolling";
    "-webkit-print-color-adjust";
    "-webkit-tap-highlight-color";
    "-webkit-text-fill-color";
    "-webkit-text-security";
    "-webkit-text-stroke";
    "-webkit-text-stroke-color";
    "-webkit-text-stroke-width";
    "-webkit-touch-callout";
    "-webkit-user-drag";
    "-webkit-user-modify";
    "-webkit-user-select";
    "accent-color";
    "align-tracks";
    "alignment-baseline";
    "all";
    "anchor-name";
    "anchor-scope";
    "animation";
    "animation-delay-end";
    "animation-delay-start";
    "animation-trigger";
    "appearance";
    "ascent-override";
    "aspect-ratio";
    "azimuth";
    "backdrop-filter";
    "backface-visibility";
    "background";
    "background-blend-mode";
    "baseline-shift";
    "baseline-source";
    "behavior";
    "bleed";
    "block-overflow";
    "block-size";
    "border";
    "border-block";
    "border-collapse";
    "border-end-end-radius";
    "border-end-start-radius";
    "border-inline";
    "border-radius";
    "border-spacing";
    "border-start-end-radius";
    "border-start-start-radius";
    "box-align";
    "box-decoration-break";
    "box-direction";
    "box-flex";
    "box-flex-group";
    "box-lines";
    "box-ordinal-group";
    "box-orient";
    "box-pack";
    "box-shadow";
    "box-sizing";
    "break-after";
    "break-before";
    "break-inside";
    "caption-side";
    "caret";
    "caret-animation";
    "caret-color";
    "caret-shape";
    "clear";
    "clip";
    "clip-path";
    "clip-rule";
    "color";
    "color-adjust";
    "color-interpolation";
    "color-interpolation-filters";
    "color-rendering";
    "color-scheme";
    "column-fill";
    "column-rule";
    "column-span";
    "column-wrap";
    "columns";
    "contain";
    "contain-intrinsic-block-size";
    "contain-intrinsic-height";
    "contain-intrinsic-inline-size";
    "contain-intrinsic-size";
    "contain-intrinsic-width";
    "container";
    "content";
    "content-visibility";
    "corner-block-end-shape";
    "corner-block-start-shape";
    "corner-bottom-left-shape";
    "corner-bottom-right-shape";
    "corner-bottom-shape";
    "corner-end-end-shape";
    "corner-end-start-shape";
    "corner-inline-end-shape";
    "corner-inline-start-shape";
    "corner-left-shape";
    "corner-right-shape";
    "corner-shape";
    "corner-start-end-shape";
    "corner-start-start-shape";
    "corner-top-left-shape";
    "corner-top-right-shape";
    "corner-top-shape";
    "counter-increment";
    "counter-reset";
    "counter-set";
    "cue";
    "cue-after";
    "cue-before";
    "cursor";
    "cx";
    "cy";
    "d";
    "descent-override";
    "direction";
    "display";
    "dominant-baseline";
    "dynamic-range-limit";
    "empty-cells";
    "field-sizing";
    "fill";
    "fill-opacity";
    "fill-rule";
    "filter";
    "flex";
    "flex-flow";
    "float";
    "flood-color";
    "flood-opacity";
    "font";
    "font-display";
    "font-palette";
    "font-smooth";
    "font-synthesis";
    "font-synthesis-position";
    "font-synthesis-small-caps";
    "font-synthesis-style";
    "font-synthesis-weight";
    "forced-color-adjust";
    "gap";
    "glyph-orientation-horizontal";
    "glyph-orientation-vertical";
    "grid";
    "grid-row";
    "hanging-punctuation";
    "height";
    "hyphenate-character";
    "hyphenate-limit-chars";
    "hyphenate-limit-last";
    "hyphenate-limit-lines";
    "hyphenate-limit-zone";
    "hyphens";
    "image-orientation";
    "image-rendering";
    "image-resolution";
    "ime-mode";
    "inherits";
    "initial-letter";
    "initial-letter-align";
    "initial-value";
    "inline-size";
    "inset";
    "inset-area";
    "inset-block";
    "inset-inline";
    "interactivity";
    "interest-delay";
    "interest-delay-end";
    "interest-delay-start";
    "interpolate-size";
    "isolation";
    "justify-tracks";
    "kerning";
    "layout-grid";
    "layout-grid-char";
    "layout-grid-line";
    "layout-grid-mode";
    "layout-grid-type";
    "letter-spacing";
    "lighting-color";
    "line-break";
    "line-clamp";
    "line-gap-override";
    "line-height-step";
    "list-style";
    "margin";
    "margin-block";
    "margin-inline";
    "margin-trim";
    "marker";
    "marker-end";
    "marker-mid";
    "marker-start";
    "marks";
    "mask";
    "mask-type";
    "masonry-auto-flow";
    "math-depth";
    "math-shift";
    "math-style";
    "max-block-size";
    "max-height";
    "max-inline-size";
    "max-lines";
    "max-width";
    "min-block-size";
    "min-height";
    "min-inline-size";
    "min-width";
    "mix-blend-mode";
    "nav-down";
    "nav-left";
    "nav-right";
    "nav-up";
    "object-fit";
    "object-position";
    "object-view-box";
    "offset";
    "opacity";
    "order";
    "orphans";
    "outline";
    "outline-offset";
    "overflow";
    "overflow-anchor";
    "overflow-block";
    "overflow-clip-box";
    "overflow-clip-margin";
    "overflow-inline";
    "overflow-wrap";
    "overlay";
    "overscroll-behavior";
    "overscroll-behavior-block";
    "overscroll-behavior-inline";
    "overscroll-behavior-x";
    "overscroll-behavior-y";
    "padding";
    "padding-block";
    "padding-inline";
    "page";
    "page-break-after";
    "page-break-before";
    "page-break-inside";
    "paint-order";
    "pause";
    "pause-after";
    "pause-before";
    "perspective";
    "perspective-origin";
    "place-content";
    "place-items";
    "place-self";
    "pointer-events";
    "position";
    "position-anchor";
    "position-area";
    "position-try";
    "position-try-fallbacks";
    "position-try-options";
    "position-try-order";
    "position-visibility";
    "print-color-adjust";
    "quotes";
    "r";
    "reading-flow";
    "reading-order";
    "resize";
    "rest";
    "rest-after";
    "rest-before";
    "rotate";
    "ruby-align";
    "ruby-merge";
    "ruby-overhang";
    "ruby-position";
    "rx";
    "ry";
    "scale";
    "scroll-behavior";
    "scroll-initial-target";
    "scroll-margin";
    "scroll-margin-block";
    "scroll-margin-inline";
    "scroll-marker-group";
    "scroll-padding";
    "scroll-padding-block";
    "scroll-padding-inline";
    "scroll-snap-align";
    "scroll-snap-coordinate";
    "scroll-snap-destination";
    "scroll-snap-points-x";
    "scroll-snap-points-y";
    "scroll-snap-stop";
    "scroll-snap-type";
    "scroll-snap-type-x";
    "scroll-snap-type-y";
    "scroll-start";
    "scroll-start-block";
    "scroll-start-inline";
    "scroll-start-target";
    "scroll-start-target-block";
    "scroll-start-target-inline";
    "scroll-start-target-x";
    "scroll-start-target-y";
    "scroll-start-x";
    "scroll-start-y";
    "scroll-target-group";
    "scroll-timeline";
    "scroll-timeline-axis";
    "scroll-timeline-name";
    "scrollbar-3dlight-color";
    "scrollbar-arrow-color";
    "scrollbar-base-color";
    "scrollbar-color";
    "scrollbar-color-legacy";
    "scrollbar-darkshadow-color";
    "scrollbar-face-color";
    "scrollbar-gutter";
    "scrollbar-highlight-color";
    "scrollbar-shadow-color";
    "scrollbar-track-color";
    "scrollbar-width";
    "shape-image-threshold";
    "shape-margin";
    "shape-outside";
    "shape-rendering";
    "size";
    "size-adjust";
    "speak";
    "speak-as";
    "src";
    "stop-color";
    "stop-opacity";
    "stroke";
    "stroke-color";
    "stroke-dasharray";
    "stroke-dashoffset";
    "stroke-linecap";
    "stroke-linejoin";
    "stroke-miterlimit";
    "stroke-opacity";
    "stroke-width";
    "syntax";
    "tab-size";
    "table-layout";
    "text-align";
    "text-align-all";
    "text-align-last";
    "text-anchor";
    "text-autospace";
    "text-blink";
    "text-box";
    "text-box-edge";
    "text-box-trim";
    "text-combine-upright";
    "text-decoration";
    "text-decoration-inset";
    "text-decoration-skip";
    "text-decoration-skip-box";
    "text-decoration-skip-ink";
    "text-decoration-skip-inset";
    "text-decoration-skip-self";
    "text-decoration-skip-spaces";
    "text-edge";
    "text-emphasis";
    "text-emphasis-position";
    "text-indent";
    "text-justify";
    "text-justify-trim";
    "text-kashida";
    "text-kashida-space";
    "text-orientation";
    "text-overflow";
    "text-rendering";
    "text-shadow";
    "text-size-adjust";
    "text-spacing-trim";
    "text-transform";
    "text-underline-offset";
    "text-underline-position";
    "text-wrap";
    "text-wrap-mode";
    "text-wrap-style";
    "timeline-scope";
    "timeline-trigger";
    "timeline-trigger-activation-range";
    "timeline-trigger-activation-range-end";
    "timeline-trigger-activation-range-start";
    "timeline-trigger-active-range";
    "timeline-trigger-active-range-end";
    "timeline-trigger-active-range-start";
    "timeline-trigger-name";
    "timeline-trigger-source";
    "touch-action";
    "transform";
    "transform-box";
    "transform-origin";
    "transform-style";
    "transition";
    "translate";
    "trigger-scope";
    "unicode-bidi";
    "unicode-range";
    "user-select";
    "vector-effect";
    "vertical-align";
    "view-timeline";
    "view-timeline-axis";
    "view-timeline-inset";
    "view-timeline-name";
    "view-transition-class";
    "view-transition-name";
    "visibility";
    "voice-balance";
    "voice-duration";
    "voice-family";
    "voice-pitch";
    "voice-range";
    "voice-rate";
    "voice-stress";
    "voice-volume";
    "white-space";
    "white-space-collapse";
    "widows";
    "width";
    "will-change";
    "word-break";
    "word-space-transform";
    "word-spacing";
    "writing-mode";
    "x";
    "y";
    "z-index";
    "zoom";
  |]

(* Width, in base36 chars, of the extended-hash field [Class_format] emits
   right after the family field when it holds one of the two unregistered
   markers below (a property outside the seed table, or a custom property -
   neither has a table slot, so its real identity has to live somewhere).
   Owned here, not in [Class_format], so both the encoder and this module's
   own [Registry.hash_into] stay in sync by construction - Class_format
   already depends on Slot_key, never the reverse. *)
let extended_hash_width = 6

let extended_hash_range =
  let rec pow36 n acc = if n = 0 then acc else pow36 (n - 1) (acc * 36) in
  pow36 extended_hash_width 1

module Registry = struct
  (* The family field is 2 base36 chars (see Class_format) - 1,296 values.
     [0, registered_max] is the table's own range. The checkpoint tweak
     (2026-09-25, team-lead/user) replaced the old scheme's two reserved
     numeric SUB-RANGES for unknown/custom properties (which, at 3 chars,
     could afford to give each its own thousands-wide range) with two
     single reserved MARKER values instead, so the common (registered)
     case keeps almost the whole 1,296-value space to grow into. A
     property whose family field is one of those two markers carries its
     real identity in a separate, wider hash field instead (see
     {!family_id}, [Class_format]'s [extended_width]) - the marker only
     says "look there", it is never itself hashed. [all_sentinel] is a
     third, single reserved value, for the same reason [all] always was
     one - not a real property, never worth a table slot. *)
  let registered_max = 1292
  let unregistered_ordinary_marker = 1293
  let unregistered_custom_marker = 1294
  let all_sentinel = 1295

  (* [seed] verbatim - see its own ORDER RULE comment. No [List.sort_uniq]
     or other re-derivation here: that would silently break append-only the
     moment a new entry sorted earlier than an existing one, shifting every
     later id (the bug this replaces - see the 2026-09-25 property-table
     session report for how it was found). *)
  let table : string array = seed
  let by_name : (string, int) Hashtbl.t = Hashtbl.create (2 * Array.length table)

  let () =
    Array.iteri
      (fun i name ->
        if i > registered_max then
          invalid_arg "Slot_key.Registry: seed exceeds the registered range"
        else Hashtbl.replace by_name name i)
      table

  let index_of name = Hashtbl.find_opt by_name name

  (* Reuses Murmur2 (the same algorithm Hash_class hashes class-name content
     with) rather than a new hash function, so this stays stable across
     builds the same way class-name hashing already is. *)
  let hash_into name = Murmur2.default_int name mod extended_hash_range
end

(* [Unregistered]'s payload is the property's own extended-hash value (see
   [extended_hash_width]/[Class_format]) - unlike the old range-based
   scheme, the family-field integer itself no longer carries the identity,
   only the marker does (see {!family_marker}), so a custom property and an
   ordinary unregistered one need distinct constructors, not distinct
   sub-ranges of one payload, to stay tellable apart from the [family_id]
   value alone. *)
type family_id =
  | Registered of int
  | Unregistered of int
  | UnregisteredCustom of int
  | All

(* The family FIELD's own value - what [Class_format] actually writes into
   the 2-char family slot. [Unregistered]/[UnregisteredCustom]'s payload
   (the real extended hash) is a separate field entirely; see
   {!extended_hash}. *)
let family_marker = function
  | Registered n -> n
  | Unregistered _ -> Registry.unregistered_ordinary_marker
  | UnregisteredCustom _ -> Registry.unregistered_custom_marker
  | All -> Registry.all_sentinel

let extended_hash = function
  | Unregistered n | UnregisteredCustom n -> Some n
  | Registered _ | All -> None

(* A true spec-level alias (e.g. "font-width" for "font-stretch",
   "word-wrap" for "overflow-wrap" - see Css_grammar.Types.kind's [Alias]
   doc) is resolved to its canonical name before any family/registry lookup,
   so setting either name is recognized as covering the other. Unlike
   {!Family.family_key_of}, this is a plain 1:1 rename, not a shorthand
   reduction - it happens first, then family_key_of runs on the result (an
   alias's canonical name may itself have a family, e.g. "font-stretch" is
   one of "font"'s own longhands). *)
let resolve_alias property =
  match Css_grammar.canonical_name_of property with
  | Some canonical -> canonical
  | None -> property

let family_id_of property =
  if property = "all" then All
  else (
    let key = Family.family_key_of (resolve_alias property) in
    match Registry.index_of key with
    | Some i -> Registered i
    | None ->
      if is_custom_property property then
        UnregisteredCustom (Registry.hash_into property)
      else Unregistered (Registry.hash_into key))

type t = {
  context : context;
  family : family_id;
  mask : int option;
  bundle : bool;
    (** True when any declaration in this atom carries a [$(...)] value
        interpolation - [Css_file.re]'s [transform_rule_list] bundles such
        declarations under one shared class today (see slot_key.ml's
        [declaration_has_value_interpolation], duplicated from there for the
        same reason {!normalize_property} duplicates [declaration_group_key] -
        this module cannot depend on the [ppx] library). [removes] never drops a
        bundle atom and never lets one drop another atom - a bundle's class
        legitimately shares its class with unrelated declarations from the same
        binding (a real, pre-existing mechanism, not a merge decision this
        module can safely reason about) - see the checkpoint's [csv-] prefix. *)
}

(* Duplicated from [Css_file.re]'s [Css_transform.component_value_has_
   interpolation]/[declaration_has_value_interpolation] (this module
   cannot depend on [ppx] - see {!normalize_property}'s own note on the
   same constraint). A declaration's VALUE carrying a [$(...)] is what
   makes [Css_file.re] bundle it with its siblings under one shared class
   today; selector-position interpolations are resolved statically and
   never bundled, so they are irrelevant here, same as there. *)
let rec component_value_has_interpolation (cv : Ast.component_value) =
  match cv with
  | Ast.Variable (_, _) -> true
  | Ast.Paren_block values | Ast.Bracket_block values ->
    component_value_list_has_interpolation values
  | Ast.Function { body = values, _; _ } ->
    component_value_list_has_interpolation values
  | _ -> false

and component_value_list_has_interpolation values =
  List.exists (fun (cv, _loc) -> component_value_has_interpolation cv) values

let declaration_has_value_interpolation (decl : Ast.declaration) =
  component_value_list_has_interpolation (fst decl.value)

(* Walks one atomized rule (Css_file.re's [atomize_rules] output shape),
   collecting the at-rule chain outer to inner, the innermost selector
   text, and the declaration(s) at the leaf. [Render.selector]/
   [Render.component_value_list] are the same renderers [Hash_class] hashes
   for the class name, so this gets the same whitespace/ordering
   canonicalization for free. *)
let rec collect_context (rule : Ast.rule) :
  (string * string) list * string option * Ast.declaration list =
  match rule with
  | Ast.Declaration d -> [], None, [ d ]
  | Ast.Style_rule { prelude = sels, _; block = rules, _; _ } ->
    let sel_text =
      sels |> List.map (fun (s, _) -> Render.selector s) |> String.concat ", "
    in
    let selector = if sel_text = "&" then None else Some sel_text in
    let decls =
      List.filter_map (function Ast.Declaration d -> Some d | _ -> None) rules
    in
    [], selector, decls
  | Ast.At_rule { name = name, _; prelude = pre, _; block; _ } ->
    let prelude_text =
      Render.component_value_list (Render.strip_leading_whitespace pre)
    in
    let inner_rules =
      match block with
      | Ast.Rule_list (rules, _) | Ast.Stylesheet (rules, _) -> rules
      | Ast.Empty -> []
    in
    let at_rules, selector, decls =
      match inner_rules with
      | [ inner ] -> collect_context inner
      | _ -> [], None, []
    in
    (String.lowercase_ascii name, prelude_text) :: at_rules, selector, decls

let of_atom (rule : Ast.rule) : t option =
  let at_rules, selector, decls = collect_context rule in
  match decls with
  | [] -> None
  | _ :: _ ->
    let important =
      List.exists (fun (d : Ast.declaration) -> fst d.important) decls
    in
    let context =
      { at_rules; selector = Option.value selector ~default:""; important }
    in
    (* A multi-declaration group (same-property today; a mixed shorthand +
       longhand "family atom" from phase 3) combines every declaration's
       own family/mask - they are always the same family by construction
       (that's what makes them one group), so the combined mask is the OR
       of each one's own mask, using [None] ("full") as absorbing: any
       [None] in the group makes the whole group's mask [None]. *)
    let properties =
      List.map
        (fun (d : Ast.declaration) -> normalize_property (fst d.name))
        decls
    in
    let family = family_id_of (List.hd properties) in
    let mask =
      List.fold_left
        (fun acc property ->
          match acc with
          | None -> None
          | Some acc_mask ->
            let full = Family.full_mask_of property in
            let own = Family.mask_of property in
            if own = full then None else Some (acc_mask lor own))
        (Some 0) properties
    in
    let bundle = List.exists declaration_has_value_interpolation decls in
    Some { context; family; mask; bundle }

let context_equal a b =
  a.at_rules = b.at_rules
  && a.selector = b.selector
  && a.important = b.important

let mask_subset a b =
  match a, b with
  | None, None -> true
  | None, Some _ -> false
  | Some _, None -> true
  | Some ma, Some mb -> ma land mb = ma

let is_excluded_from_all = function
  | Registered i ->
    (* the only two registered properties [all] does not reset *)
    Registry.index_of "direction" = Some i
    || Registry.index_of "unicode-bidi" = Some i
  | UnregisteredCustom _ -> true
  | Unregistered _ | All -> false

let removes ~former ~latter =
  (not former.bundle)
  && (not latter.bundle)
  && context_equal former.context latter.context
  &&
  match latter.family with
  | All -> not (is_excluded_from_all former.family)
  | _ -> former.family = latter.family && mask_subset former.mask latter.mask
