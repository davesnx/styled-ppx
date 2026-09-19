/** Per-compilation-unit buffer of [%css] binding exports.

    Every named [%css] binding records a [(longident, identity,
    class_string)] entry here. The longident is the fully-qualified path
    users would write to reference the binding from another module (e.g.
    ["M.Css.marker"]); the identity is the binding's build-independent
    `cid-` class (see [Hash_class.identity_class]) — `$(binding)` selector
    references resolve to this, verbatim; the class string is the
    space-separated list of atomized class names the PPX minted for it,
    kept as a content fingerprint so the aggregator can tell a legitimate
    duplicate build from a real identity collision (see
    [Generate.Index]).

    The impl transformer drains this buffer at end-of-CU and emits one
    [\[\@\@\@css.bindings ...\]] attribute carrying every entry. The
    aggregator ([styled-ppx.generate]) collects those attributes into its
    global index — no AST traversal of [CSS.make] calls is required because
    the PPX has already done the work of mapping bindings to their identity.

    Anonymous bindings ([let _ = ...]) are not recorded — they cannot be
    referenced cross-module so they have no useful index entry. */;

type entry = {
  longident: string,
  identity: string,
  class_string: string,
};

/** Record a [%css] binding's identity and atomized class string under its
    fully-qualified longident. No-op if [longident] is empty (anonymous
    binding). Last-write-wins for duplicate longidents within a CU. */
let record:
  (~longident: string, ~identity: string, ~class_string: string) => unit;

/** Drain and clear all recorded entries, in insertion order. */
let drain: unit => list(entry);
