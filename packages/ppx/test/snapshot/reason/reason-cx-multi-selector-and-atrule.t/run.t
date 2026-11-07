Coverage for cx2 atomization edge cases.

Multi-selector preludes expand with CSS-nesting Cartesian semantics at every
depth; overlapping declarations in the expanded selectors form one bundle atom.
Nested at-rules must carry the parent
selector chain into the at-rule's contents instead of dropping it.

  $ ../../../standalone.exe --impl input.ml -o output.ml
  $ cat output.ml
  [@@@css.atoms
    [("_bAC7f5JrtD67ffiDtDHpi0BaP",
       ["._bAC7f5JrtD67ffiDtDHpi0BaP .a{color:red;}";
       "._bAC7f5JrtD67ffiDtDHpi0BaP .b{color:red;}"], 0, 1, 2,
       [("ctx", "5JrtD6", "ctx\\0& .a | ");
       ("ctx", "fiDtDH", "ctx\\0& .b | ");
       ("value", "pi0BaP",
         "bval\\0& .a | \\07f\\0color:red\\0& .b | \\07f\\0color:red")]);
    ("_bAC7fAUeLuW7fEPcp_Bcl1hyC",
      ["._bAC7fAUeLuW7fEPcp_Bcl1hyC .parent .a{color:blue;}";
      "._bAC7fAUeLuW7fEPcp_Bcl1hyC .parent .b{color:blue;}"], 0, 1, 2,
      [("ctx", "AUeLuW", "ctx\\0& .parent .a | ");
      ("ctx", "EPcp_B", "ctx\\0& .parent .b | ");
      ("value", "cl1hyC",
        "bval\\0& .parent .a | \\07f\\0color:blue\\0& .parent .b | \\07f\\0color:blue")]);
    ("_bAE7fd5_A1-7fLmQB5b7fGzl8e97fWp7iwEHgBEQB",
      ["._bAE7fd5_A1-7fLmQB5b7fGzl8e97fWp7iwEHgBEQB .a .c{color:green;}";
      "._bAE7fd5_A1-7fLmQB5b7fGzl8e97fWp7iwEHgBEQB .a .d{color:green;}";
      "._bAE7fd5_A1-7fLmQB5b7fGzl8e97fWp7iwEHgBEQB .b .c{color:green;}";
      "._bAE7fd5_A1-7fLmQB5b7fGzl8e97fWp7iwEHgBEQB .b .d{color:green;}"], 0, 1,
      4,
      [("ctx", "d5_A1-", "ctx\\0& .a .c | ");
      ("ctx", "LmQB5b", "ctx\\0& .a .d | ");
      ("ctx", "Gzl8e9", "ctx\\0& .b .c | ");
      ("ctx", "Wp7iwE", "ctx\\0& .b .d | ");
      ("value", "HgBEQB",
        "bval\\0& .a .c | \\07f\\0color:green\\0& .a .d | \\07f\\0color:green\\0& .b .c | \\07f\\0color:green\\0& .b .d | \\07f\\0color:green")]);
    ("_bAE7f5JrtD67ffiDtDH7fDwyoqa7fsvRT0l0HNRUi",
      ["._bAE7f5JrtD67ffiDtDH7fDwyoqa7fsvRT0l0HNRUi .a{color:red;}";
      "._bAE7f5JrtD67ffiDtDH7fDwyoqa7fsvRT0l0HNRUi .b{color:red;}";
      "._bAE7f5JrtD67ffiDtDH7fDwyoqa7fsvRT0l0HNRUi .a:hover{color:blue;}";
      "._bAE7f5JrtD67ffiDtDH7fDwyoqa7fsvRT0l0HNRUi .b:hover{color:blue;}"], 0,
      1, 4,
      [("ctx", "5JrtD6", "ctx\\0& .a | ");
      ("ctx", "fiDtDH", "ctx\\0& .b | ");
      ("ctx", "Dwyoqa", "ctx\\0& .a:hover | ");
      ("ctx", "svRT0l", "ctx\\0& .b:hover | ");
      ("value", "0HNRUi",
        "bval\\0& .a | \\07f\\0color:red\\0& .b | \\07f\\0color:red\\0& .a:hover | \\07f\\0color:blue\\0& .b:hover | \\07f\\0color:blue")]);
    ("_c7fP3RA54yz8J2j",
      ["@media (min-width:768px){._c7fP3RA54yz8J2j .a{color:red;}}"], 0, 2, 1,
      [("ctx", "P3RA54", "ctx\\0& .a | @media (min-width:768px) | ");
      ("value", "yz8J2j",
        "val\\07f\\0& .a | @media (min-width:768px) | \\0color:red")]);
    ("_c7fvCEQWdJB1TY2",
      ["@media (max-width:600px){._c7fvCEQWdJB1TY2 .a .b{color:red;}}"], 0, 2,
      1,
      [("ctx", "vCEQWd", "ctx\\0& .a .b | @media (max-width:600px) | ");
      ("value", "JB1TY2",
        "val\\07f\\0& .a .b | @media (max-width:600px) | \\0color:red")]);
    ("_c7f5JrtD6N_h5Bz", ["._c7f5JrtD6N_h5Bz .a{color:black;}"], 0, 1, 1,
      [("ctx", "5JrtD6", "ctx\\0& .a | ");
      ("value", "N_h5Bz", "val\\07f\\0& .a | \\0color:black")]);
    ("_bAC7fytOc2z7fK6Mo6aGxRoun",
      ["@media (max-width:600px){._bAC7fytOc2z7fK6Mo6aGxRoun .a{color:red;}}";
      "@media (max-width:600px){._bAC7fytOc2z7fK6Mo6aGxRoun .a:hover{color:blue;}}"],
      0, 2, 2,
      [("ctx", "ytOc2z", "ctx\\0& .a | @media (max-width:600px) | ");
      ("ctx", "K6Mo6a", "ctx\\0& .a:hover | @media (max-width:600px) | ");
      ("value", "GxRoun",
        "bval\\0& .a | @media (max-width:600px) | \\07f\\0color:red\\0& .a:hover | @media (max-width:600px) | \\07f\\0color:blue")]);
    ("_iw3F77wcE", [], 1, 0, 0,
      [("id", "_iw3F77wcE", "bind\\0\\0Input\\0\\0multiTop\\00")]);
    ("_iTZc0ckOP", [], 1, 0, 0,
      [("id", "_iTZc0ckOP", "bind\\0\\0Input\\0\\0multiNested\\00")]);
    ("_iFWUDyyrN", [], 1, 0, 0,
      [("id", "_iFWUDyyrN", "bind\\0\\0Input\\0\\0cartesian\\00")]);
    ("_idsNbl91u", [], 1, 0, 0,
      [("id", "_idsNbl91u", "bind\\0\\0Input\\0\\0multiMixed\\00")]);
    ("_iHmydnKPe", [], 1, 0, 0,
      [("id", "_iHmydnKPe", "bind\\0\\0Input\\0\\0mediaUnderSelector\\00")]);
    ("_ibPnwlRae", [], 1, 0, 0,
      [("id", "_ibPnwlRae", "bind\\0\\0Input\\0\\0mediaDeep\\00")]);
    ("_iU0CdlKe9", [], 1, 0, 0,
      [("id", "_iU0CdlKe9", "bind\\0\\0Input\\0\\0mediaWithNested\\00")])]]
  [@@@css.bindings
    [("Input.multiTop", "_iw3F77wcE _bAC7f5JrtD67ffiDtDHpi0BaP", "_iw3F77wcE");
    ("Input.multiNested", "_iTZc0ckOP _bAC7fAUeLuW7fEPcp_Bcl1hyC",
      "_iTZc0ckOP");
    ("Input.cartesian",
      "_iFWUDyyrN _bAE7fd5_A1-7fLmQB5b7fGzl8e97fWp7iwEHgBEQB", "_iFWUDyyrN");
    ("Input.multiMixed",
      "_idsNbl91u _bAE7f5JrtD67ffiDtDH7fDwyoqa7fsvRT0l0HNRUi", "_idsNbl91u");
    ("Input.mediaUnderSelector", "_iHmydnKPe _c7fP3RA54yz8J2j", "_iHmydnKPe");
    ("Input.mediaDeep", "_ibPnwlRae _c7fvCEQWdJB1TY2", "_ibPnwlRae");
    ("Input.mediaWithNested",
      "_iU0CdlKe9 _c7f5JrtD6N_h5Bz _bAC7fytOc2z7fK6Mo6aGxRoun", "_iU0CdlKe9")]]
  let multiTop = CSS.make "_iw3F77wcE _bAC7f5JrtD67ffiDtDHpi0BaP" []
  let multiNested = CSS.make "_iTZc0ckOP _bAC7fAUeLuW7fEPcp_Bcl1hyC" []
  let cartesian =
    CSS.make "_iFWUDyyrN _bAE7fd5_A1-7fLmQB5b7fGzl8e97fWp7iwEHgBEQB" []
  let multiMixed =
    CSS.make "_idsNbl91u _bAE7f5JrtD67ffiDtDH7fDwyoqa7fsvRT0l0HNRUi" []
  let mediaUnderSelector = CSS.make "_iHmydnKPe _c7fP3RA54yz8J2j" []
  let mediaDeep = CSS.make "_ibPnwlRae _c7fvCEQWdJB1TY2" []
  let mediaWithNested =
    CSS.make "_iU0CdlKe9 _c7f5JrtD6N_h5Bz _bAC7fytOc2z7fK6Mo6aGxRoun" []
