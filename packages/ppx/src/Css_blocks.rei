/** Per-compilation-unit buffer of block class lists, for the
    [\[\@\@\@css.blocks ...\]] attribute (see [Css_extraction.block]).

    [Css_to_runtime.render_make_call] records every block it renders - every
    [%css] and [%styled.<tag>] expansion, named or anonymous - so this is the
    one place a block's class list is captured. The impl transformer drains
    the buffer at end-of-CU. */;

let record: (~loc: Ppxlib.Location.t, ~classNames: list(string)) => unit;

/** Drain and clear all recorded blocks, in source order, without duplicates. */
let drain: unit => list(Css_extraction.block);
