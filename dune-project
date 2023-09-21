(lang dune 3.8)
(cram enable)

(using menhir 2.0)
(using melange 0.1)

(name styled-ppx)

(generate_opam_files true)

(implicit_transitive_deps false)

(source (github davesnx/styled-ppx))
(homepage "https://styled-ppx.vercel.app")
(documentation "https://styled-ppx.vercel.app")
(bug_reports "https://github.com/davesnx/styled-ppx/issues")

(license MIT)

(authors "David Sancho <dsnxmoreno@gmail.com>")

(maintainers "David Sancho <dsnxmoreno@gmail.com>")

(package
 (name styled-ppx)
 (synopsis "Type-safe styled components for ReScript and Melange")
 (description
  "styled-ppx is the ppx that brings styled components to ReScript and Melange, allowing you to create React Components with type-safe style definitions using CSS.")
  (depends
   (ocaml (>= 5.1.0))
   (menhir (>= 20220210))
   (ppx_deriving (>= 5.0))
   (ppx_deriving_yojson (>= 3.7.0))
   (ppxlib (>= 0.27.0))
   (sedlex (>= 2.0))
   (melange (>= 2.0.0))
   (reason :with-dev-setup)
   (alcotest :with-test)
   (ocaml-lsp-server :with-dev-setup)
   (ocamlformat :with-dev-setup)
   (utop :with-dev-setup)))
