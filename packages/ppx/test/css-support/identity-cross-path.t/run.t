Regression guard: the SAME module compiled from two different file paths
must mint the SAME identity class for a named binding.

This is the cross-build invariant identity classes are built around (see
`Hash_class.identity_class`, and `global-var-cross-path.t` for the same
invariant on `[%styled.global]` variables). A module is routinely compiled
twice under different paths - Dune `copy_files` into a Melange build dir,
vendoring, or a native (SSR) build plus a Melange (client) build of one
file. The identity is namespaced on the compilation-unit module name
(`Marker`), never the physical path, so both builds mint the same
`id-...` and a `$(marker)` reference resolves identically on either side.

  $ mkdir -p native js
  $ cp Marker.re native/Marker.re
  $ cp Marker.re js/Marker.re
  $ refmt --parse re --print ml native/Marker.re > native/Marker.ml
  $ ../../standalone.exe --impl native/Marker.ml -o native/Marker.ml
  $ refmt --parse re --print ml js/Marker.re > js/Marker.ml
  $ ../../standalone.exe --impl js/Marker.ml -o js/Marker.ml

Both paths mint the same identity:

  $ grep "css.bindings" native/Marker.ml
  [@@@css.bindings [("Marker.marker", "id-1ja89pc", "a-tokvmb")]]
  $ grep "css.bindings" js/Marker.ml
  [@@@css.bindings [("Marker.marker", "id-1ja89pc", "a-tokvmb")]]
