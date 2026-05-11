/** Per-compilation-unit buffer of cross-module class references encountered
    during [%cx2] expansion.

    When a [%cx2] selector contains an interpolation like [$(M.x)] whose
    target lives in another module, the PPX cannot resolve it locally —
    module M compiles separately and we have no access to its bindings.
    Rather than emit an error, we record the reference here, embed an
    uncollidable sentinel [\x00LONGIDENT\x00] into the rendered CSS, and
    let the post-build aggregator ([styled-ppx.generate]) substitute the
    real class names once every module's post-PPX [.ml] file is available.

    The buffer is populated by [Css_file.resolve_selector_class_ref]'s
    cross-module branch and drained by [ppx.re]'s impl transformer. The
    drain emits two structure items per CU with cross-module refs:

    - One [\[\@\@\@css.refs ...\]] attribute carrying every distinct
      [(longident, location)] pair seen across the CU. The aggregator uses
      the longidents to look up class names in its index and the locations
      to point at original source on resolution errors.

    - One synthetic [let _ = M.x] per distinct longident. These exist
      purely to make [ocamldep] see the cross-module dependency (so dune
      compiles M before running the aggregator over N) and to surface
      missing-binding errors at compile time rather than at aggregator
      time. */;

type entry = {
  longident: string,
  loc: Ppxlib.Location.t,
};

/** Build the sentinel string for a longident: [\x00LONGIDENT\x00].

    NUL bytes cannot appear in user CSS or in valid OCaml string literals,
    so collisions with real CSS content are impossible by construction.
    The aggregator scans rendered CSS for these sentinels and substitutes
    resolved class names. */
let sentinel: string => string;

/** Record a cross-module class reference.

    The [~file] argument gives the source file path of the enclosing
    [%cx2] block (e.g. ["packages/foo/src/n.re"]) and is used to populate
    [pos_fname] on the recorded location. The CSS parser produces
    locations relative to the [%cx2] string payload with an empty
    [pos_fname]; without this rewrite the aggregator could not point at
    the original [.re]/[.ml] file when reporting resolution errors.

    Idempotent for distinct locations: the same longident at the same
    location is recorded once. Different locations of the same longident
    are all retained so the aggregator can report every error site. */
let record:
  (~file: string, ~longident: string, ~loc: Ppxlib.Location.t) => unit;

/** Drain and clear all recorded entries. Returns:

    - [entries]: every recorded ref in insertion order, used to build the
      [\[\@\@\@css.refs ...\]] attribute payload.
    - [unique]: one [(longident, first-seen location)] per distinct
      longident, used to emit synthetic [let _ = M.x] dep-tracking lines.

    Returning both views in a single call avoids a second dedup pass at
    the call site. */
let drain:
  unit => (list(entry), list((string, Ppxlib.Location.t)));
