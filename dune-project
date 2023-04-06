(lang dune 3.7)
(cram enable)

(using menhir 2.0)
(using melange 0.1)

(name styled-ppx)

(source
 (github davesnx/styled-ppx))

(license MIT)

(authors "davesnx")

(maintainers "davesnx")

(package
 (name styled-ppx)
 (synopsis "Typed styled components in Reason, OCaml and ReScript")
 (description
  "ppx that parses the CSS and turn it into ReasonReact components"))
