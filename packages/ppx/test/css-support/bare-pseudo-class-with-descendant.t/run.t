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
  [@css.atoms
    [
      (
        "_c7fl8GzBuC5iHEV",
        ["._c7fl8GzBuC5iHEV:hover .child{color:red;}"],
        0,
        1,
        1,
        [
          ("ctx", "l8GzBu", "ctx\\0&:hover .child | "),
          ("value", "C5iHEV", "val\\07f\\0&:hover .child | \\0color:red"),
        ],
      ),
      (
        "_c7fjDfenguUog3V",
        ["._c7fjDfenguUog3V:hover span{color:blue;}"],
        0,
        1,
        1,
        [
          ("ctx", "jDfeng", "ctx\\0&:hover span | "),
          ("value", "uUog3V", "val\\07f\\0&:hover span | \\0color:blue"),
        ],
      ),
      (
        "_c7fl8GzBuK8G2E0",
        ["._c7fl8GzBuK8G2E0:hover .child{color:green;}"],
        0,
        1,
        1,
        [
          ("ctx", "l8GzBu", "ctx\\0&:hover .child | "),
          ("value", "K8G2E0", "val\\07f\\0&:hover .child | \\0color:green"),
        ],
      ),
      (
        "_c7f-QfSkEb--_uX",
        ["._c7f-QfSkEb--_uX:hover:focus{color:yellow;}"],
        2,
        1,
        1,
        [
          ("ctx", "-QfSkE", "ctx\\0&:focus:hover | "),
          ("value", "b--_uX", "val\\07f\\0&:focus:hover | \\0color:yellow"),
        ],
      ),
      (
        "_c7fwN1JOKkLos4V",
        ["._c7fwN1JOKkLos4V:hover::after{color:orange;}"],
        2,
        1,
        1,
        [
          ("ctx", "wN1JOK", "ctx\\0&:hover::after | "),
          ("value", "kLos4V", "val\\07f\\0&:hover::after | \\0color:orange"),
        ],
      ),
      (
        "_c7fUHtsNZ9sxa2V",
        ["._c7fUHtsNZ9sxa2V:hover .child .grandchild{color:purple;}"],
        0,
        1,
        1,
        [
          ("ctx", "UHtsNZ", "ctx\\0&:hover .child .grandchild | "),
          (
            "value",
            "9sxa2V",
            "val\\07f\\0&:hover .child .grandchild | \\0color:purple",
          ),
        ],
      ),
      (
        "_c7fF1sAo2n7DPD8",
        ["._c7fF1sAo2n7DPD8:hover .a .b .c .d{color:pink;}"],
        0,
        1,
        1,
        [
          ("ctx", "F1sAo2", "ctx\\0&:hover .a .b .c .d | "),
          ("value", "n7DPD8", "val\\07f\\0&:hover .a .b .c .d | \\0color:pink"),
        ],
      ),
      (
        "_c7faNzXmkeqfWHS",
        ["._c7faNzXmkeqfWHS:hover .a:focus .b{color:brown;}"],
        0,
        1,
        1,
        [
          ("ctx", "aNzXmk", "ctx\\0&:hover .a:focus .b | "),
          (
            "value",
            "eqfWHS",
            "val\\07f\\0&:hover .a:focus .b | \\0color:brown",
          ),
        ],
      ),
      (
        "_iNqUmEGui",
        [],
        1,
        0,
        0,
        [
          (
            "id",
            "_iNqUmEGui",
            "bind\\0\\0Input\\0\\0_amp_pseudo_with_class_descendant\\00",
          ),
        ],
      ),
      (
        "_iFDFTdPEi",
        [],
        1,
        0,
        0,
        [
          (
            "id",
            "_iFDFTdPEi",
            "bind\\0\\0Input\\0\\0_amp_pseudo_with_type_descendant\\00",
          ),
        ],
      ),
      (
        "_inTM44Egk",
        [],
        1,
        0,
        0,
        [
          (
            "id",
            "_inTM44Egk",
            "bind\\0\\0Input\\0\\0_amp_pseudo_with_explicit_ampersand_descendant\\00",
          ),
        ],
      ),
      (
        "_iuHX2a1Mt",
        [],
        1,
        0,
        0,
        [
          (
            "id",
            "_iuHX2a1Mt",
            "bind\\0\\0Input\\0\\0_amp_pseudo_with_compound_inner\\00",
          ),
        ],
      ),
      (
        "_iAvDhVHKX",
        [],
        1,
        0,
        0,
        [
          (
            "id",
            "_iAvDhVHKX",
            "bind\\0\\0Input\\0\\0_amp_pseudo_with_pseudo_element_inner\\00",
          ),
        ],
      ),
      (
        "_iBFc5Gfxj",
        [],
        1,
        0,
        0,
        [
          (
            "id",
            "_iBFc5Gfxj",
            "bind\\0\\0Input\\0\\0_amp_pseudo_three_levels\\00",
          ),
        ],
      ),
      (
        "_iqDPr0Dnd",
        [],
        1,
        0,
        0,
        [
          (
            "id",
            "_iqDPr0Dnd",
            "bind\\0\\0Input\\0\\0_amp_pseudo_five_levels\\00",
          ),
        ],
      ),
      (
        "_izH0V4tt8",
        [],
        1,
        0,
        0,
        [
          (
            "id",
            "_izH0V4tt8",
            "bind\\0\\0Input\\0\\0_amp_pseudo_mixed_inner\\00",
          ),
        ],
      ),
    ]
  ];
  [@css.bindings
    [
      (
        "Input._amp_pseudo_with_class_descendant",
        "_iNqUmEGui _c7fl8GzBuC5iHEV",
        "_iNqUmEGui",
      ),
      (
        "Input._amp_pseudo_with_type_descendant",
        "_iFDFTdPEi _c7fjDfenguUog3V",
        "_iFDFTdPEi",
      ),
      (
        "Input._amp_pseudo_with_explicit_ampersand_descendant",
        "_inTM44Egk _c7fl8GzBuK8G2E0",
        "_inTM44Egk",
      ),
      (
        "Input._amp_pseudo_with_compound_inner",
        "_iuHX2a1Mt _c7f-QfSkEb--_uX",
        "_iuHX2a1Mt",
      ),
      (
        "Input._amp_pseudo_with_pseudo_element_inner",
        "_iAvDhVHKX _c7fwN1JOKkLos4V",
        "_iAvDhVHKX",
      ),
      (
        "Input._amp_pseudo_three_levels",
        "_iBFc5Gfxj _c7fUHtsNZ9sxa2V",
        "_iBFc5Gfxj",
      ),
      (
        "Input._amp_pseudo_five_levels",
        "_iqDPr0Dnd _c7fF1sAo2n7DPD8",
        "_iqDPr0Dnd",
      ),
      (
        "Input._amp_pseudo_mixed_inner",
        "_izH0V4tt8 _c7faNzXmkeqfWHS",
        "_izH0V4tt8",
      ),
    ]
  ];
  
  let _amp_pseudo_with_class_descendant =
    CSS.make("_iNqUmEGui _c7fl8GzBuC5iHEV", []);
  
  let _amp_pseudo_with_type_descendant =
    CSS.make("_iFDFTdPEi _c7fjDfenguUog3V", []);
  
  let _amp_pseudo_with_explicit_ampersand_descendant =
    CSS.make("_inTM44Egk _c7fl8GzBuK8G2E0", []);
  
  let _amp_pseudo_with_compound_inner =
    CSS.make("_iuHX2a1Mt _c7f-QfSkEb--_uX", []);
  
  let _amp_pseudo_with_pseudo_element_inner =
    CSS.make("_iAvDhVHKX _c7fwN1JOKkLos4V", []);
  
  let _amp_pseudo_three_levels = CSS.make("_iBFc5Gfxj _c7fUHtsNZ9sxa2V", []);
  
  let _amp_pseudo_five_levels = CSS.make("_iqDPr0Dnd _c7fF1sAo2n7DPD8", []);
  
  let _amp_pseudo_mixed_inner = CSS.make("_izH0V4tt8 _c7faNzXmkeqfWHS", []);
