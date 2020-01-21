(lang dune 1.11)
(name re-styled-ppx)
(version 0.1.0)
(source (github davesnx/re-styled-ppx))
(license MIT)
(authors "David Sancho")
(maintainers "David Sancho")

(using fmt 1.2)
(generate_opam_files true)

(package
 (name re-styled-ppx)
 (synopsis "")
 (depends
  reason
  dune
  rely
  base
  ppxlib))
