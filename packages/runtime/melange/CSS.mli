(** Public interface of the native styled-ppx runtime.

    [styles] is deliberately abstract: the carrier layout is an internal
    contract between this runtime and PPX-generated code, and is free to
    evolve (see documents/atomic-css-ordering.md, "Phase 2 direction").
    Consume values through {!className}, {!styles} and {!label}; construct
    them with the PPX ([%css ...]) or {!make}/{!make_labeled}. *)

include module type of Colors
include module type of Alias
module Types = Css_types

(** A compiled styles value: the class names a [%css ...] block minted,
    the element-scoped CSS custom properties for interpolated values, and
    a dev-only debug label. *)
type styles

(** No classes, no inline vars, no label. Useful as the neutral element of
    {!merge}: [merge styles (if cond then extra else empty)]. *)
val empty : styles

(** The inline custom-property values, for a [style] attribute. *)
val styles : styles -> ReactDOM.Style.t

(** The space-separated class names, for a [className] attribute. *)
val className : styles -> string

(** The [let] binding or module name the styles came from. Dev-only
    metadata: [None] in production builds ([--minify]/[--env production])
    and for {!make}/{!merge}-built values without labeled operands. *)
val label : styles -> string option

(** [make className vars] builds a styles value from PPX-minted class
    names and [(--custom-property, value)] pairs. Generated code calls
    this; you shouldn't need it directly. *)
val make : string -> (string * string) list -> styles

(** {!make} plus a debug label. Dev-mode generated code calls this;
    production code calls {!make} so bindings carry zero label bytes. *)
val make_labeled : string -> string -> (string * string) list -> styles

(** Concatenates class names and combines inline vars. Argument order does
    not decide which declaration wins — stylesheet order does; see the
    runtime docs, "Which declaration wins". *)
val merge : styles -> styles -> styles

(** A [<style>] element with the given CSS text, for [%styled.global]. *)
val global_style_tag : string -> React.element
