Family atoms: two declarations in one context share an atom only when
their covered leaf properties overlap (taken transitively), declarations
in author order. Sharing a family is not enough on its own -
`padding-left`/`padding-right` share the "padding" family but cover
disjoint leaves, so they still get separate atoms.

  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css ".a-1frow79{margin:10px;margin-top:0;}"];
  [@css ".a-1o78lih{margin-top:0;margin:10px;}"];
  [@css ".a-1q6p6yp{margin:10px;margin-top:0;margin-left:5px;}"];
  [@css ".a-tokvmb{color:red;}"];
  [@css ".a-8kn4zf{margin-top:0;}"];
  [@css ".a-1dacand{padding-top:0;}"];
  [@css ".a-gdo9vs:hover{margin:10px;margin-top:0;}"];
  [@css ".a-131yq1t{padding-left:0;}"];
  [@css ".a-9t8fgp{padding-right:0;}"];
  [@css ".a-iqmzmu{border-top:1px solid red;}"];
  [@css ".a-1w0py0o{border-left-width:2px;}"];
  [@css ".a-25u7ex{border:1px solid blue;border-left-width:2px;}"];
  [@css
    ".a-13gtdra{border-top:1px solid red;border:2px dashed blue;border-left-width:3px;}"
  ];
  [@css.bindings
    [
      ("Output.shorthandThenLonghand", "id-1b2y2pm", "a-1frow79"),
      ("Output.longhandThenShorthand", "id-9pf9ej", "a-1o78lih"),
      ("Output.threeMembers", "id-5viu7a", "a-1q6p6yp"),
      ("Output.unrelatedProperties", "id-1eulq6f", "a-tokvmb a-8kn4zf"),
      ("Output.crossFamilyIndependence", "id-mz6ujm", "a-8kn4zf a-1dacand"),
      ("Output.underSelector", "id-vkdvp6", "a-gdo9vs"),
      ("Output.sameFamilyDisjointLeaves", "id-ds74ar", "a-131yq1t a-9t8fgp"),
      ("Output.sameFamilyNoOverlap", "id-18fztpi", "a-iqmzmu a-1w0py0o"),
      ("Output.sameFamilyOverlapViaShorthand", "id-jjk2yk", "a-25u7ex"),
      ("Output.transitiveBridge", "id-1r4280b", "a-13gtdra"),
    ]
  ];
  let shorthandThenLonghand =
    CSS.make("label:shorthandThenLonghand id-1b2y2pm a-1frow79", []);
  let longhandThenShorthand =
    CSS.make("label:longhandThenShorthand id-9pf9ej a-1o78lih", []);
  let threeMembers = CSS.make("label:threeMembers id-5viu7a a-1q6p6yp", []);
  let unrelatedProperties =
    CSS.make("label:unrelatedProperties id-1eulq6f a-tokvmb a-8kn4zf", []);
  let crossFamilyIndependence =
    CSS.make("label:crossFamilyIndependence id-mz6ujm a-8kn4zf a-1dacand", []);
  let underSelector = CSS.make("label:underSelector id-vkdvp6 a-gdo9vs", []);
  let sameFamilyDisjointLeaves =
    CSS.make("label:sameFamilyDisjointLeaves id-ds74ar a-131yq1t a-9t8fgp", []);
  let sameFamilyNoOverlap =
    CSS.make("label:sameFamilyNoOverlap id-18fztpi a-iqmzmu a-1w0py0o", []);
  let sameFamilyOverlapViaShorthand =
    CSS.make("label:sameFamilyOverlapViaShorthand id-jjk2yk a-25u7ex", []);
  let transitiveBridge =
    CSS.make("label:transitiveBridge id-1r4280b a-13gtdra", []);
