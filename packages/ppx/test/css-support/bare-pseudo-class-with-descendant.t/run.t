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
    (
      "._a_d3qow4emold:hover .child{color:red;}",
      "_a_d3qow4emold",
      "0,3,0 &:hover .child",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dwogj4e74wv:hover span{color:blue;}",
      "_a_dwogj4e74wv",
      "0,2,1 &:hover span",
      "158",
      1,
      true,
    )
  ];
  [@css
    (
      "._a_d3qow4edg3s:hover .child{color:green;}",
      "_a_d3qow4edg3s",
      "0,3,0 &:hover .child",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_rv9hg4ej0cc:hover:focus{color:yellow;}",
      "_a_rv9hg4ej0cc",
      "0,3,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4ii3y4ehiyt:hover::after{color:orange;}",
      "_a_4ii3y4ehiyt",
      "0,2,1 own::after",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_yj7sa4e1xle:hover .child .grandchild{color:purple;}",
      "_a_yj7sa4e1xle",
      "0,4,0 &:hover .child .grandchild",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_h0ece4e19o0:hover .a .b .c .d{color:pink;}",
      "_a_h0ece4e19o0",
      "0,6,0 &:hover .a .b .c .d",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_t7s414escwj:hover .a:focus .b{color:brown;}",
      "_a_t7s414escwj",
      "0,5,0 &:hover .a:focus .b",
      "158",
      1,
      false,
    )
  ];
  [@css.bindings
    [
      (
        "Input._amp_pseudo_with_class_descendant",
        "_id_13yqvqg",
        "_a_d3qow4emold",
      ),
      (
        "Input._amp_pseudo_with_type_descendant",
        "_id_1abpwbm",
        "_a_dwogj4e74wv",
      ),
      (
        "Input._amp_pseudo_with_explicit_ampersand_descendant",
        "_id_1xlwa1g",
        "_a_d3qow4edg3s",
      ),
      (
        "Input._amp_pseudo_with_compound_inner",
        "_id_10mqg8n",
        "_a_rv9hg4ej0cc",
      ),
      (
        "Input._amp_pseudo_with_pseudo_element_inner",
        "_id_cg6d97",
        "_a_4ii3y4ehiyt",
      ),
      ("Input._amp_pseudo_three_levels", "_id_1j6ilit", "_a_yj7sa4e1xle"),
      ("Input._amp_pseudo_five_levels", "_id_1qajsxv", "_a_h0ece4e19o0"),
      ("Input._amp_pseudo_mixed_inner", "_id_10tx4fm", "_a_t7s414escwj"),
    ]
  ];
  [@css.blocks
    [
      (14, "_id_13yqvqg", [0]),
      (22, "_id_1abpwbm", [1]),
      (30, "_id_1xlwa1g", [2]),
      (38, "_id_10mqg8n", [3]),
      (46, "_id_cg6d97", [4]),
      (59, "_id_1j6ilit", [5]),
      (69, "_id_1qajsxv", [6]),
      (84, "_id_10tx4fm", [7]),
    ]
  ];
  
  let _amp_pseudo_with_class_descendant =
    CSS.make(
      "label:_amp_pseudo_with_class_descendant _id_13yqvqg _a_d3qow4emold",
      [],
    );
  
  let _amp_pseudo_with_type_descendant =
    CSS.make(
      "label:_amp_pseudo_with_type_descendant _id_1abpwbm _a_dwogj4e74wv",
      [],
    );
  
  let _amp_pseudo_with_explicit_ampersand_descendant =
    CSS.make(
      "label:_amp_pseudo_with_explicit_ampersand_descendant _id_1xlwa1g _a_d3qow4edg3s",
      [],
    );
  
  let _amp_pseudo_with_compound_inner =
    CSS.make(
      "label:_amp_pseudo_with_compound_inner _id_10mqg8n _a_rv9hg4ej0cc",
      [],
    );
  
  let _amp_pseudo_with_pseudo_element_inner =
    CSS.make(
      "label:_amp_pseudo_with_pseudo_element_inner _id_cg6d97 _a_4ii3y4ehiyt",
      [],
    );
  
  let _amp_pseudo_three_levels =
    CSS.make("label:_amp_pseudo_three_levels _id_1j6ilit _a_yj7sa4e1xle", []);
  
  let _amp_pseudo_five_levels =
    CSS.make("label:_amp_pseudo_five_levels _id_1qajsxv _a_h0ece4e19o0", []);
  
  let _amp_pseudo_mixed_inner =
    CSS.make("label:_amp_pseudo_mixed_inner _id_10tx4fm _a_t7s414escwj", []);
