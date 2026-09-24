/** Dev-mode marker class support for [%css].

    Every [%css] binding gets a leading marker class derived from its
    enclosing [let] binding name (e.g. [let layout = [%css ...]] yields
    [class="label:layout c-..."]). The marker has no associated CSS rule; it
    exists purely as a grep-target in DOM inspectors.

    Dev mode is on by default. [--minify] and [--env production] turn it
    off; an explicit [--dev] forces it back on (see settings.re).

    The marker is filtered out for anonymous bindings ([None]) and for
    bindings explicitly named [_], matching the behavior of
    {!Local_selector_environment.register}. This keeps the two debug
    affordances (DOM marker and selector interpolation [$(name)]) in
    sync. */;

/** Compute the marker class for a binding.

    Returns [Some "label:<name>"] when dev mode is enabled and [name] is a
    real binding (not [None], not ["_"]). Returns [None] otherwise. The
    caller passes the result to {!Css_to_runtime.render_make_call} as
    [~marker]. */
let marker: option(string) => option(string);
