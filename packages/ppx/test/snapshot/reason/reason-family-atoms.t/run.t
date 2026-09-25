Family atoms: two declarations in one context share an atom only when
their covered leaf properties overlap (taken transitively), declarations
in author order. Sharing a family is not enough on its own -
`padding-left`/`padding-right` share the "padding" family but cover
disjoint leaves, so they still get separate atoms.

  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css ".a-7pow79{margin:10px;margin-top:0;}"];
  [@css ".a-7p8lih{margin-top:0;margin:10px;}"];
  [@css ".a-7pp6yp{margin:10px;margin-top:0;margin-left:5px;}"];
  [@css ".a-4ekvmb{color:red;}"];
  [@css ".a-7p008n4zf{margin-top:0;}"];
  [@css ".a-94008cand{padding-top:0;}"];
  [@css ".a-qyw7u7po9vs:hover{margin:10px;margin-top:0;}"];
  [@css ".a-94002yq1t{padding-left:0;}"];
  [@css ".a-940048fgp{padding-right:0;}"];
  [@css ".a-3hghsmzmu{border-top:1px solid red;}"];
  [@css ".a-3h0sgpy0o{border-left-width:2px;}"];
  [@css ".a-3hu7ex{border:1px solid blue;border-left-width:2px;}"];
  [@css
    ".a-3htdra{border-top:1px solid red;border:2px dashed blue;border-left-width:3px;}"
  ];
  [@css.bindings
    [
      ("Output.shorthandThenLonghand", "id-1b2y2pm", "a-7pow79"),
      ("Output.longhandThenShorthand", "id-9pf9ej", "a-7p8lih"),
      ("Output.threeMembers", "id-5viu7a", "a-7pp6yp"),
      ("Output.unrelatedProperties", "id-1eulq6f", "a-4ekvmb a-7p008n4zf"),
      (
        "Output.crossFamilyIndependence",
        "id-mz6ujm",
        "a-7p008n4zf a-94008cand",
      ),
      ("Output.underSelector", "id-vkdvp6", "a-qyw7u7po9vs"),
      (
        "Output.sameFamilyDisjointLeaves",
        "id-ds74ar",
        "a-94002yq1t a-940048fgp",
      ),
      ("Output.sameFamilyNoOverlap", "id-18fztpi", "a-3hghsmzmu a-3h0sgpy0o"),
      ("Output.sameFamilyOverlapViaShorthand", "id-jjk2yk", "a-3hu7ex"),
      ("Output.transitiveBridge", "id-1r4280b", "a-3htdra"),
    ]
  ];
  let shorthandThenLonghand =
    CSS.make("label:shorthandThenLonghand id-1b2y2pm a-7pow79", []);
  let longhandThenShorthand =
    CSS.make("label:longhandThenShorthand id-9pf9ej a-7p8lih", []);
  let threeMembers = CSS.make("label:threeMembers id-5viu7a a-7pp6yp", []);
  let unrelatedProperties =
    CSS.make("label:unrelatedProperties id-1eulq6f a-4ekvmb a-7p008n4zf", []);
  let crossFamilyIndependence =
    CSS.make(
      "label:crossFamilyIndependence id-mz6ujm a-7p008n4zf a-94008cand",
      [],
    );
  let underSelector =
    CSS.make("label:underSelector id-vkdvp6 a-qyw7u7po9vs", []);
  let sameFamilyDisjointLeaves =
    CSS.make(
      "label:sameFamilyDisjointLeaves id-ds74ar a-94002yq1t a-940048fgp",
      [],
    );
  let sameFamilyNoOverlap =
    CSS.make(
      "label:sameFamilyNoOverlap id-18fztpi a-3hghsmzmu a-3h0sgpy0o",
      [],
    );
  let sameFamilyOverlapViaShorthand =
    CSS.make("label:sameFamilyOverlapViaShorthand id-jjk2yk a-3hu7ex", []);
  let transitiveBridge =
    CSS.make("label:transitiveBridge id-1r4280b a-3htdra", []);
