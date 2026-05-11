/** Dev-mode marker class support for [%cx2].

    When the PPX is invoked with [--dev], every [%cx2] binding gets a
    leading marker class derived from its enclosing [let] binding name
    (e.g. [let layout = [%cx2 ...]] yields [class="cx-layout c-..."]).
    The marker has no associated CSS rule; it exists purely as a
    grep-target in DOM inspectors.

    The marker is filtered out for anonymous bindings ([None]) and for
    bindings explicitly named [_], matching the behavior of
    {!Css_file.Class_registry.register}. This keeps the two debug
    affordances (DOM marker and selector interpolation [$(name)]) in
    sync. */;

/** Compute the marker class for a binding.

    Returns [Some "cx-<name>"] when [--dev] is enabled and [name] is a
    real binding (not [None], not ["_"]). Returns [None] otherwise. The
    caller passes the result to {!Css_to_runtime.render_make_call} as
    [~marker]. */
let marker: option(string) => option(string);
