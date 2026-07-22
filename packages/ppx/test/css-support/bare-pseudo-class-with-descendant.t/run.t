Coverage for the spec-correct alternatives to bare leading pseudo
selectors in `[%css]` blocks.

Bug-report-5 ("Disallow url in global" follow-up) reported an
`assert(false)` crash on `:hover { .child { ... } }`-style shapes. The
crash was a totality hole in `Selector_nesting.compute_new_prefix`'s
pseudo-compound branch. The structural fix replaces that branch with
strict CSS Nesting Level 1 §3.1 semantics (descendant-join) and rejects
bare leading pseudo selectors in `[%css]` with a precise error
(`bare-pseudo-class-error.t` covers the diagnostic).

This file covers the supported shapes — `&:hover { ... }` for compound,
deep nesting, and mixed compound/descendant inner chains.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css
    ".css-1i2mold-_amp_pseudo_with_class_descendant:hover .child{color:red;}"
  ];
  [@css ".css-1pw74wv-_amp_pseudo_with_type_descendant:hover span{color:blue;}"];
  [@css
    ".css-5tdg3s-_amp_pseudo_with_explicit_ampersand_descendant:hover .child{color:green;}"
  ];
  [@css
    ".css-1pzj0cc-_amp_pseudo_with_compound_inner:hover:focus{color:yellow;}"
  ];
  [@css
    ".css-1cghiyt-_amp_pseudo_with_pseudo_element_inner:hover::after{color:orange;}"
  ];
  [@css
    ".css-15g1xle-_amp_pseudo_three_levels:hover .child .grandchild{color:purple;}"
  ];
  [@css ".css-v719o0-_amp_pseudo_five_levels:hover .a .b .c .d{color:pink;}"];
  [@css ".css-1d0scwj-_amp_pseudo_mixed_inner:hover .a:focus .b{color:brown;}"];
  [@css.bindings
    [
      (
        "Input._amp_pseudo_with_class_descendant",
        "css-1i2mold-_amp_pseudo_with_class_descendant",
      ),
      (
        "Input._amp_pseudo_with_type_descendant",
        "css-1pw74wv-_amp_pseudo_with_type_descendant",
      ),
      (
        "Input._amp_pseudo_with_explicit_ampersand_descendant",
        "css-5tdg3s-_amp_pseudo_with_explicit_ampersand_descendant",
      ),
      (
        "Input._amp_pseudo_with_compound_inner",
        "css-1pzj0cc-_amp_pseudo_with_compound_inner",
      ),
      (
        "Input._amp_pseudo_with_pseudo_element_inner",
        "css-1cghiyt-_amp_pseudo_with_pseudo_element_inner",
      ),
      (
        "Input._amp_pseudo_three_levels",
        "css-15g1xle-_amp_pseudo_three_levels",
      ),
      ("Input._amp_pseudo_five_levels", "css-v719o0-_amp_pseudo_five_levels"),
      ("Input._amp_pseudo_mixed_inner", "css-1d0scwj-_amp_pseudo_mixed_inner"),
    ]
  ];
  
  let _amp_pseudo_with_class_descendant =
    CSS.make_labeled(
      "_amp_pseudo_with_class_descendant",
      "css-1i2mold-_amp_pseudo_with_class_descendant",
      [],
    );
  
  let _amp_pseudo_with_type_descendant =
    CSS.make_labeled(
      "_amp_pseudo_with_type_descendant",
      "css-1pw74wv-_amp_pseudo_with_type_descendant",
      [],
    );
  
  let _amp_pseudo_with_explicit_ampersand_descendant =
    CSS.make_labeled(
      "_amp_pseudo_with_explicit_ampersand_descendant",
      "css-5tdg3s-_amp_pseudo_with_explicit_ampersand_descendant",
      [],
    );
  
  let _amp_pseudo_with_compound_inner =
    CSS.make_labeled(
      "_amp_pseudo_with_compound_inner",
      "css-1pzj0cc-_amp_pseudo_with_compound_inner",
      [],
    );
  
  let _amp_pseudo_with_pseudo_element_inner =
    CSS.make_labeled(
      "_amp_pseudo_with_pseudo_element_inner",
      "css-1cghiyt-_amp_pseudo_with_pseudo_element_inner",
      [],
    );
  
  let _amp_pseudo_three_levels =
    CSS.make_labeled(
      "_amp_pseudo_three_levels",
      "css-15g1xle-_amp_pseudo_three_levels",
      [],
    );
  
  let _amp_pseudo_five_levels =
    CSS.make_labeled(
      "_amp_pseudo_five_levels",
      "css-v719o0-_amp_pseudo_five_levels",
      [],
    );
  
  let _amp_pseudo_mixed_inner =
    CSS.make_labeled(
      "_amp_pseudo_mixed_inner",
      "css-1d0scwj-_amp_pseudo_mixed_inner",
      [],
    );
