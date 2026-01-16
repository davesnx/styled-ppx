(lang dune 3.16)
(cram enable)

(using menhir 2.0)
(using melange 0.1)

(name styled-ppx)

(generate_opam_files true)

(implicit_transitive_deps false)

(source (github davesnx/styled-ppx))
(homepage "https://styled-ppx.vercel.app")
(bug_reports "https://github.com/davesnx/styled-ppx/issues")

(license "BSD-2-Clause")

(authors "David Sancho <dsnxmoreno@gmail.com>")

(maintainers "David Sancho <dsnxmoreno@gmail.com>")

(package
 (name styled-ppx)
 (synopsis "Type-safe styled components for ReScript and Melange")
 (description
  "styled-ppx is a ppx and a library that brings styled components to ReScript, Melange and OCaml. Create React Components or simply `className` with type-safe style definitions with only CSS.")
  (depends
   (ocaml (>= 4.14))
   (reason (>= 3.11.0))
   (menhir (>= 20220210))
   (ppx_deriving (>= 5.0))
   (ppx_deriving_yojson (>= 3.7.0))
   (ppxlib (>= 0.36.0))
   (sedlex (>= 3.5))
   (melange (>= 3.0.0))
   (server-reason-react (>= 0.4.1))
   (reason-react (>= 0.14.0))
   (alcotest :with-test)
   (conf-npm :with-test)
   (reason-react-ppx :with-dev-setup)
   (ocaml-lsp-server :with-dev-setup)
   (ocamlformat :with-dev-setup)))
