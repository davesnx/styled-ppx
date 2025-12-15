This test ensures the ppx generates the correct output against styled-ppx.native
If this test fail means that the module is not in sync with the ppx

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF


  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css
    ".css-9clcc1 { align-content: flex-start; }\n.css-luqlve { align-content: flex-end; }\n.css-17956mw { align-content: space-between; }\n.css-1is2unp { align-content: space-around; }\n.css-17syz37 { align-items: flex-start; }\n.css-ltrldv { align-items: flex-end; }\n.css-1g5frg { align-self: flex-start; }\n.css-n87n32 { align-self: flex-end; }\n.css-17vxl0k { display: flex; }\n.css-16jka92 { display: inline-flex; }\n.css-1vlfmts { flex: none; }\n.css-cdz979 { flex: 5 7 10%; }\n.css-naggdn { flex: 2; }\n.css-1l636xm { flex: 10em; }\n.css-1ckya70 { flex: 30%; }\n.css-ja6bgv { flex: min-content; }\n.css-jz3hqm { flex: 1 30px; }\n.css-8j9o4z { flex: 2 2; }\n.css-1j7ej5v { flex: 2 2 10%; }\n.css-1q5it5d { flex: var(--var-hvez6j); }\n.css-fpeblm { flex: var(--var-volh69) var(--var-volh69); }\n.css-1spvg28 { flex: var(--var-volh69) var(--var-volh69) var(--var-1u1axvx); }\n.css-1osz5qs { flex-basis: auto; }\n.css-169l2ov { flex-basis: content; }\n.css-1jo1rq9 { flex-basis: 1px; }\n.css-sw3yj { flex-direction: row; }\n.css-15kamqm { flex-direction: row-reverse; }\n.css-1s0kfvh { flex-direction: column; }\n.css-5pulkd { flex-direction: column-reverse; }\n.css-spx0zg { flex-flow: row; }\n.css-vyst1l { flex-flow: row-reverse; }\n.css-1estk77 { flex-flow: column; }\n.css-flvwdz { flex-flow: column-reverse; }\n.css-15bjnsc { flex-flow: wrap; }\n.css-11hso83 { flex-flow: wrap-reverse; }\n.css-1wv2e0y { flex-flow: row wrap; }\n.css-1gktcrt { flex-flow: row-reverse nowrap; }\n.css-10w3efu { flex-flow: column wrap; }\n.css-dimcxx { flex-flow: column-reverse wrap-reverse; }\n.css-1p17p1d { flex-grow: 0; }\n.css-1wmpz19 { flex-grow: 5; }\n.css-1t1j3t { flex-shrink: 1; }\n.css-13zl5dy { flex-shrink: 10; }\n.css-1pd1f9w { flex-wrap: nowrap; }\n.css-1gwrhd7 { flex-wrap: wrap; }\n.css-123jw3g { flex-wrap: wrap-reverse; }\n.css-16fy3cs { justify-content: flex-start; }\n.css-1wmq422 { justify-content: flex-end; }\n.css-x61i8g { justify-content: space-between; }\n.css-1nz7ffr { justify-content: space-around; }\n.css-1dzewri { min-height: auto; }\n.css-1f4odbo { min-width: auto; }\n.css-pus3te { order: 0; }\n.css-s6x697 { order: 1; }\n"
  ];
  module X = {
    let value = 1.;
    let flex1 = `num(1.);
    let min = `px(500);
  };
  
  CSS.make("css-9clcc1", []);
  CSS.make("css-luqlve", []);
  CSS.make("css-17956mw", []);
  CSS.make("css-1is2unp", []);
  CSS.make("css-17syz37", []);
  CSS.make("css-ltrldv", []);
  CSS.make("css-1g5frg", []);
  CSS.make("css-n87n32", []);
  CSS.make("css-17vxl0k", []);
  CSS.make("css-16jka92", []);
  CSS.make("css-1vlfmts", []);
  CSS.make("css-cdz979", []);
  CSS.make("css-naggdn", []);
  CSS.make("css-1l636xm", []);
  CSS.make("css-1ckya70", []);
  CSS.make("css-ja6bgv", []);
  CSS.make("css-jz3hqm", []);
  CSS.make("css-8j9o4z", []);
  CSS.make("css-1j7ej5v", []);
  CSS.make("css-1q5it5d", [("--var-hvez6j", CSS.Types.Flex.toString(X.flex1))]);
  CSS.make("css-fpeblm", [("--var-volh69", CSS.Types.Flex.toString(X.value))]);
  CSS.make(
    "css-1spvg28",
    [("--var-volh69", CSS.Types.Flex.toString(X.value)), ("--var-1u1axvx", CSS.Types.Flex.toString(X.min))],
  );
  CSS.make("css-1osz5qs", []);
  CSS.make("css-169l2ov", []);
  CSS.make("css-1jo1rq9", []);
  CSS.make("css-sw3yj", []);
  CSS.make("css-15kamqm", []);
  CSS.make("css-1s0kfvh", []);
  CSS.make("css-5pulkd", []);
  CSS.make("css-spx0zg", []);
  CSS.make("css-vyst1l", []);
  CSS.make("css-1estk77", []);
  CSS.make("css-flvwdz", []);
  CSS.make("css-15bjnsc", []);
  CSS.make("css-11hso83", []);
  CSS.make("css-1wv2e0y", []);
  CSS.make("css-1gktcrt", []);
  CSS.make("css-10w3efu", []);
  CSS.make("css-dimcxx", []);
  CSS.make("css-1p17p1d", []);
  CSS.make("css-1wmpz19", []);
  CSS.make("css-1t1j3t", []);
  CSS.make("css-13zl5dy", []);
  CSS.make("css-1pd1f9w", []);
  CSS.make("css-1gwrhd7", []);
  CSS.make("css-123jw3g", []);
  CSS.make("css-16fy3cs", []);
  CSS.make("css-1wmq422", []);
  CSS.make("css-x61i8g", []);
  CSS.make("css-1nz7ffr", []);
  CSS.make("css-1dzewri", []);
  CSS.make("css-1f4odbo", []);
  CSS.make("css-pus3te", []);
  CSS.make("css-s6x697", []);
