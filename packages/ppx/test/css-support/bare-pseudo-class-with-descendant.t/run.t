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
  [@css ".a-d3qow4emold:hover .child{color:red;}"];
  [@css ".a-dwogj4e74wv:hover span{color:blue;}"];
  [@css ".a-d3qow4edg3s:hover .child{color:green;}"];
  [@css ".a-rv9hg4ej0cc:hover:focus{color:yellow;}"];
  [@css ".a-4ii3y4ehiyt:hover::after{color:orange;}"];
  [@css ".a-yj7sa4e1xle:hover .child .grandchild{color:purple;}"];
  [@css ".a-h0ece4e19o0:hover .a .b .c .d{color:pink;}"];
  [@css ".a-t7s414escwj:hover .a:focus .b{color:brown;}"];
  [@css.bindings
    [
      ("Input._amp_pseudo_with_class_descendant", "id-1mtruzt", "a-d3qow4emold"),
      ("Input._amp_pseudo_with_type_descendant", "id-1l96rxg", "a-dwogj4e74wv"),
      (
        "Input._amp_pseudo_with_explicit_ampersand_descendant",
        "id-saeaxt",
        "a-d3qow4edg3s",
      ),
      ("Input._amp_pseudo_with_compound_inner", "id-1gv0q8s", "a-rv9hg4ej0cc"),
      (
        "Input._amp_pseudo_with_pseudo_element_inner",
        "id-1ogtbuw",
        "a-4ii3y4ehiyt",
      ),
      ("Input._amp_pseudo_three_levels", "id-wnmhdk", "a-yj7sa4e1xle"),
      ("Input._amp_pseudo_five_levels", "id-lhbok8", "a-h0ece4e19o0"),
      ("Input._amp_pseudo_mixed_inner", "id-1tn24tq", "a-t7s414escwj"),
    ]
  ];
  
  let _amp_pseudo_with_class_descendant =
    CSS.make(
      "label:_amp_pseudo_with_class_descendant id-1mtruzt a-d3qow4emold",
      [],
    );
  
  let _amp_pseudo_with_type_descendant =
    CSS.make(
      "label:_amp_pseudo_with_type_descendant id-1l96rxg a-dwogj4e74wv",
      [],
    );
  
  let _amp_pseudo_with_explicit_ampersand_descendant =
    CSS.make(
      "label:_amp_pseudo_with_explicit_ampersand_descendant id-saeaxt a-d3qow4edg3s",
      [],
    );
  
  let _amp_pseudo_with_compound_inner =
    CSS.make(
      "label:_amp_pseudo_with_compound_inner id-1gv0q8s a-rv9hg4ej0cc",
      [],
    );
  
  let _amp_pseudo_with_pseudo_element_inner =
    CSS.make(
      "label:_amp_pseudo_with_pseudo_element_inner id-1ogtbuw a-4ii3y4ehiyt",
      [],
    );
  
  let _amp_pseudo_three_levels =
    CSS.make("label:_amp_pseudo_three_levels id-wnmhdk a-yj7sa4e1xle", []);
  
  let _amp_pseudo_five_levels =
    CSS.make("label:_amp_pseudo_five_levels id-lhbok8 a-h0ece4e19o0", []);
  
  let _amp_pseudo_mixed_inner =
    CSS.make("label:_amp_pseudo_mixed_inner id-1tn24tq a-t7s414escwj", []);
