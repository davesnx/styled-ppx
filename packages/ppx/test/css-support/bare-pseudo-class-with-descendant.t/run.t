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
  [@css ".css-1og7fxs:hover .child{color:red;}"];
  [@css ".css-u4npw1:hover span{color:blue;}"];
  [@css ".css-5cfure:hover .child{color:green;}"];
  [@css ".css-k34zdr:hover:focus{color:yellow;}"];
  [@css ".css-11zzjks:hover::after{color:orange;}"];
  [@css ".css-1cgp68t:hover .child .grandchild{color:purple;}"];
  [@css ".css-1lrguki:hover .a .b .c .d{color:pink;}"];
  [@css ".css-19kdzew:hover .a:focus .b{color:brown;}"];
  [@css.classes
    [
      (
        "css-1og7fxs",
        0,
        "Input._amp_pseudo_with_class_descendant",
        "input.re",
        15,
        2,
        18,
        0,
      ),
      (
        "css-u4npw1",
        1,
        "Input._amp_pseudo_with_type_descendant",
        "input.re",
        23,
        2,
        26,
        0,
      ),
      (
        "css-5cfure",
        2,
        "Input._amp_pseudo_with_explicit_ampersand_descendant",
        "input.re",
        31,
        2,
        34,
        0,
      ),
      (
        "css-k34zdr",
        3,
        "Input._amp_pseudo_with_compound_inner",
        "input.re",
        39,
        2,
        42,
        0,
      ),
      (
        "css-11zzjks",
        4,
        "Input._amp_pseudo_with_pseudo_element_inner",
        "input.re",
        47,
        2,
        50,
        0,
      ),
      (
        "css-1cgp68t",
        5,
        "Input._amp_pseudo_three_levels",
        "input.re",
        60,
        2,
        65,
        0,
      ),
      (
        "css-1lrguki",
        6,
        "Input._amp_pseudo_five_levels",
        "input.re",
        70,
        2,
        79,
        0,
      ),
      (
        "css-19kdzew",
        7,
        "Input._amp_pseudo_mixed_inner",
        "input.re",
        85,
        2,
        92,
        0,
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input._amp_pseudo_with_class_descendant", "css-1og7fxs"),
      ("Input._amp_pseudo_with_type_descendant", "css-u4npw1"),
      ("Input._amp_pseudo_with_explicit_ampersand_descendant", "css-5cfure"),
      ("Input._amp_pseudo_with_compound_inner", "css-k34zdr"),
      ("Input._amp_pseudo_with_pseudo_element_inner", "css-11zzjks"),
      ("Input._amp_pseudo_three_levels", "css-1cgp68t"),
      ("Input._amp_pseudo_five_levels", "css-1lrguki"),
      ("Input._amp_pseudo_mixed_inner", "css-19kdzew"),
    ]
  ];
  
  let _amp_pseudo_with_class_descendant = CSS.make("css-1og7fxs", []);
  
  let _amp_pseudo_with_type_descendant = CSS.make("css-u4npw1", []);
  
  let _amp_pseudo_with_explicit_ampersand_descendant =
    CSS.make("css-5cfure", []);
  
  let _amp_pseudo_with_compound_inner = CSS.make("css-k34zdr", []);
  
  let _amp_pseudo_with_pseudo_element_inner = CSS.make("css-11zzjks", []);
  
  let _amp_pseudo_three_levels = CSS.make("css-1cgp68t", []);
  
  let _amp_pseudo_five_levels = CSS.make("css-1lrguki", []);
  
  let _amp_pseudo_mixed_inner = CSS.make("css-19kdzew", []);
