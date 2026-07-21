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
    ".css-1qr1l22-_amp_pseudo_with_class_descendant:hover .child{color:red}"
  ];
  [@css ".css-gy2lqg-_amp_pseudo_with_type_descendant:hover span{color:blue}"];
  [@css
    ".css-d17ypc-_amp_pseudo_with_explicit_ampersand_descendant:hover .child{color:green}"
  ];
  [@css
    ".css-1v07is5-_amp_pseudo_with_compound_inner:hover:focus{color:yellow}"
  ];
  [@css
    ".css-1diylnq-_amp_pseudo_with_pseudo_element_inner:hover::after{color:orange}"
  ];
  [@css
    ".css-1drwsij-_amp_pseudo_three_levels:hover .child .grandchild{color:purple}"
  ];
  [@css ".css-1k6xpsz-_amp_pseudo_five_levels:hover .a .b .c .d{color:pink}"];
  [@css ".css-pjzhar-_amp_pseudo_mixed_inner:hover .a:focus .b{color:brown}"];
  [@css.bindings
    [
      (
        "Input._amp_pseudo_with_class_descendant",
        "css-1qr1l22-_amp_pseudo_with_class_descendant",
      ),
      (
        "Input._amp_pseudo_with_type_descendant",
        "css-gy2lqg-_amp_pseudo_with_type_descendant",
      ),
      (
        "Input._amp_pseudo_with_explicit_ampersand_descendant",
        "css-d17ypc-_amp_pseudo_with_explicit_ampersand_descendant",
      ),
      (
        "Input._amp_pseudo_with_compound_inner",
        "css-1v07is5-_amp_pseudo_with_compound_inner",
      ),
      (
        "Input._amp_pseudo_with_pseudo_element_inner",
        "css-1diylnq-_amp_pseudo_with_pseudo_element_inner",
      ),
      (
        "Input._amp_pseudo_three_levels",
        "css-1drwsij-_amp_pseudo_three_levels",
      ),
      ("Input._amp_pseudo_five_levels", "css-1k6xpsz-_amp_pseudo_five_levels"),
      ("Input._amp_pseudo_mixed_inner", "css-pjzhar-_amp_pseudo_mixed_inner"),
    ]
  ];
  
  let _amp_pseudo_with_class_descendant =
    CSS.make("css-1qr1l22-_amp_pseudo_with_class_descendant", []);
  
  let _amp_pseudo_with_type_descendant =
    CSS.make("css-gy2lqg-_amp_pseudo_with_type_descendant", []);
  
  let _amp_pseudo_with_explicit_ampersand_descendant =
    CSS.make("css-d17ypc-_amp_pseudo_with_explicit_ampersand_descendant", []);
  
  let _amp_pseudo_with_compound_inner =
    CSS.make("css-1v07is5-_amp_pseudo_with_compound_inner", []);
  
  let _amp_pseudo_with_pseudo_element_inner =
    CSS.make("css-1diylnq-_amp_pseudo_with_pseudo_element_inner", []);
  
  let _amp_pseudo_three_levels =
    CSS.make("css-1drwsij-_amp_pseudo_three_levels", []);
  
  let _amp_pseudo_five_levels =
    CSS.make("css-1k6xpsz-_amp_pseudo_five_levels", []);
  
  let _amp_pseudo_mixed_inner =
    CSS.make("css-pjzhar-_amp_pseudo_mixed_inner", []);
