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
  [@css ".css-1i2mold:hover .child{color:red;}"];
  [@css ".css-1pw74wv:hover span{color:blue;}"];
  [@css ".css-5tdg3s:hover .child{color:green;}"];
  [@css ".css-1pzj0cc:hover:focus{color:yellow;}"];
  [@css ".css-1cghiyt:hover::after{color:orange;}"];
  [@css ".css-15g1xle:hover .child .grandchild{color:purple;}"];
  [@css ".css-v719o0:hover .a .b .c .d{color:pink;}"];
  [@css ".css-1d0scwj:hover .a:focus .b{color:brown;}"];
  [@css.bindings
    [
      ("Input._amp_pseudo_with_class_descendant", "cid-1mtruzt", "css-1i2mold"),
      ("Input._amp_pseudo_with_type_descendant", "cid-1l96rxg", "css-1pw74wv"),
      (
        "Input._amp_pseudo_with_explicit_ampersand_descendant",
        "cid-saeaxt",
        "css-5tdg3s",
      ),
      ("Input._amp_pseudo_with_compound_inner", "cid-1gv0q8s", "css-1pzj0cc"),
      (
        "Input._amp_pseudo_with_pseudo_element_inner",
        "cid-1ogtbuw",
        "css-1cghiyt",
      ),
      ("Input._amp_pseudo_three_levels", "cid-wnmhdk", "css-15g1xle"),
      ("Input._amp_pseudo_five_levels", "cid-lhbok8", "css-v719o0"),
      ("Input._amp_pseudo_mixed_inner", "cid-1tn24tq", "css-1d0scwj"),
    ]
  ];
  
  let _amp_pseudo_with_class_descendant =
    CSS.make(
      "cx-_amp_pseudo_with_class_descendant cid-1mtruzt css-1i2mold",
      [],
    );
  
  let _amp_pseudo_with_type_descendant =
    CSS.make("cx-_amp_pseudo_with_type_descendant cid-1l96rxg css-1pw74wv", []);
  
  let _amp_pseudo_with_explicit_ampersand_descendant =
    CSS.make(
      "cx-_amp_pseudo_with_explicit_ampersand_descendant cid-saeaxt css-5tdg3s",
      [],
    );
  
  let _amp_pseudo_with_compound_inner =
    CSS.make("cx-_amp_pseudo_with_compound_inner cid-1gv0q8s css-1pzj0cc", []);
  
  let _amp_pseudo_with_pseudo_element_inner =
    CSS.make(
      "cx-_amp_pseudo_with_pseudo_element_inner cid-1ogtbuw css-1cghiyt",
      [],
    );
  
  let _amp_pseudo_three_levels =
    CSS.make("cx-_amp_pseudo_three_levels cid-wnmhdk css-15g1xle", []);
  
  let _amp_pseudo_five_levels =
    CSS.make("cx-_amp_pseudo_five_levels cid-lhbok8 css-v719o0", []);
  
  let _amp_pseudo_mixed_inner =
    CSS.make("cx-_amp_pseudo_mixed_inner cid-1tn24tq css-1d0scwj", []);
