/** Per-compilation-unit buffer of [%css] binding exports.

    Every named [%css] binding records a [(longident, class_string, binding_id)] entry
    here. The longident is the fully-qualified path users would write to
    reference the binding from another module (e.g. ["M.Css.marker"]); the
    class string is the space-separated list of atomized class names the
    PPX minted for it.

    The impl transformer drains this buffer at end-of-CU and emits one
    [\[\@\@\@css.bindings ...\]] attribute carrying every entry. The
    aggregator ([styled-ppx.generate]) collects those attributes into its
    global index — no AST traversal of [CSS.make] calls is required because
    the PPX has already done the work of mapping bindings to class strings.

    Anonymous bindings ([let _ = ...]) are not recorded — they cannot be
    referenced cross-module so they have no useful index entry. */;

type entry = {
  longident: string,
  class_string: string,
  binding_id: string,
};

/** Mint the id token of a binding site. [occurrence] is the index among the
    bindings of this unit that share [scope] and [name], so a shadowed name
    gets a distinct id. The counter restarts on [drain]. */
let mint_id:
  (~main_module: string, ~scope: list(string), ~name: string) => string;

/** The [(token, hash source)] pair of every id minted since the last [drain],
    in minting order. Call before [drain], which clears them. */
let drain_ids: unit => list((string, string));

/** Record a [%css] binding's resolved class string under its
    fully-qualified longident. [binding_id = ""] means the binding has no id.
    No-op if [longident] is empty (anonymous binding). Last-write-wins for
    duplicate longidents within a CU. */
let record:
  (~longident: string, ~class_string: string, ~binding_id: string) => unit;

/** Drain and clear all recorded entries, in insertion order. */
let drain: unit => list(entry);
