Family atoms: two declarations in one context share an atom only when
their covered leaf properties overlap (taken transitively), declarations
in author order. Sharing a family is not enough on its own -
`padding-left`/`padding-right` share the "padding" family but cover
disjoint leaves, so they still get separate atoms.

  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "._a_7pow79{margin:10px;margin-top:0;}"];
  [@css "._a_7p8lih{margin-top:0;margin:10px;}"];
  [@css "._a_7pp6yp{margin:10px;margin-top:0;margin-left:5px;}"];
  [@css "._a_4ekvmb{color:red;}"];
  [@css "._a_7p008n4zf{margin-top:0;}"];
  [@css "._a_94008cand{padding-top:0;}"];
  [@css "._a_qyw7u7po9vs:hover{margin:10px;margin-top:0;}"];
  [@css "._a_94002yq1t{padding-left:0;}"];
  [@css "._a_940048fgp{padding-right:0;}"];
  [@css "._a_3hghsmzmu{border-top:1px solid red;}"];
  [@css "._a_3h0sgpy0o{border-left-width:2px;}"];
  [@css "._a_3hu7ex{border:1px solid blue;border-left-width:2px;}"];
  [@css
    "._a_3htdra{border-top:1px solid red;border:2px dashed blue;border-left-width:3px;}"
  ];
  [@css.bindings
    [
      ("Output.shorthandThenLonghand", "_id_1b2y2pm", "_a_7pow79"),
      ("Output.longhandThenShorthand", "_id_9pf9ej", "_a_7p8lih"),
      ("Output.threeMembers", "_id_5viu7a", "_a_7pp6yp"),
      ("Output.unrelatedProperties", "_id_1eulq6f", "_a_4ekvmb _a_7p008n4zf"),
      (
        "Output.crossFamilyIndependence",
        "_id_mz6ujm",
        "_a_7p008n4zf _a_94008cand",
      ),
      ("Output.underSelector", "_id_vkdvp6", "_a_qyw7u7po9vs"),
      (
        "Output.sameFamilyDisjointLeaves",
        "_id_ds74ar",
        "_a_94002yq1t _a_940048fgp",
      ),
      (
        "Output.sameFamilyNoOverlap",
        "_id_18fztpi",
        "_a_3hghsmzmu _a_3h0sgpy0o",
      ),
      ("Output.sameFamilyOverlapViaShorthand", "_id_jjk2yk", "_a_3hu7ex"),
      ("Output.transitiveBridge", "_id_1r4280b", "_a_3htdra"),
    ]
  ];
  let shorthandThenLonghand =
    CSS.make("label:shorthandThenLonghand _id_1b2y2pm _a_7pow79", []);
  let longhandThenShorthand =
    CSS.make("label:longhandThenShorthand _id_9pf9ej _a_7p8lih", []);
  let threeMembers = CSS.make("label:threeMembers _id_5viu7a _a_7pp6yp", []);
  let unrelatedProperties =
    CSS.make(
      "label:unrelatedProperties _id_1eulq6f _a_4ekvmb _a_7p008n4zf",
      [],
    );
  let crossFamilyIndependence =
    CSS.make(
      "label:crossFamilyIndependence _id_mz6ujm _a_7p008n4zf _a_94008cand",
      [],
    );
  let underSelector =
    CSS.make("label:underSelector _id_vkdvp6 _a_qyw7u7po9vs", []);
  let sameFamilyDisjointLeaves =
    CSS.make(
      "label:sameFamilyDisjointLeaves _id_ds74ar _a_94002yq1t _a_940048fgp",
      [],
    );
  let sameFamilyNoOverlap =
    CSS.make(
      "label:sameFamilyNoOverlap _id_18fztpi _a_3hghsmzmu _a_3h0sgpy0o",
      [],
    );
  let sameFamilyOverlapViaShorthand =
    CSS.make("label:sameFamilyOverlapViaShorthand _id_jjk2yk _a_3hu7ex", []);
  let transitiveBridge =
    CSS.make("label:transitiveBridge _id_1r4280b _a_3htdra", []);
