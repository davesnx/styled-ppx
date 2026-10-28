An explicit --dev always keeps the `label:<name>` marker on, whatever
position it takes next to --minify or --env production. Without an
explicit --dev, --minify and --env production still turn the marker off,
same as before.

  $ refmt --parse re --print ml input.re > input.ml

--dev --minify keeps the marker:

  $ ../../standalone.exe --dev --minify --impl input.ml -o dev-minify.ml
  $ cat dev-minify.ml
  [@@@css.config [("env", "production")]]
  [@@@css
    ("._a_5r08qs{display:flex;}", "_a_5r08qs", "0,1,0 own", "207", 1, false)]
  [@@@css
    ("._a_94zrbw{padding:12px;}", "_a_94zrbw", "0,1,0 own", "328", 15, false)]
  [@@@css
    ("._a_4ekvmb{color:red;}", "_a_4ekvmb", "0,1,0 own", "158", 1, false)]
  [@@@css.bindings
    [("Input.layout", "_id_1xb8ads", "_a_5r08qs _a_94zrbw");
    ("Input.button", "_id_1enkfbb", "_a_4ekvmb")]]
  [@@@css.blocks [(1, "_id_1xb8ads", [0; 1]); (2, "_id_1enkfbb", [2])]]
  let layout = CSS.make "label:layout _id_1xb8ads _a_5r08qs _a_94zrbw" []
  let button = CSS.make "label:button _id_1enkfbb _a_4ekvmb" []
  let _ = (layout, button)

--minify --dev (the other order) keeps the marker too:

  $ ../../standalone.exe --minify --dev --impl input.ml -o minify-dev.ml
  $ cat minify-dev.ml
  [@@@css.config [("env", "production")]]
  [@@@css
    ("._a_5r08qs{display:flex;}", "_a_5r08qs", "0,1,0 own", "207", 1, false)]
  [@@@css
    ("._a_94zrbw{padding:12px;}", "_a_94zrbw", "0,1,0 own", "328", 15, false)]
  [@@@css
    ("._a_4ekvmb{color:red;}", "_a_4ekvmb", "0,1,0 own", "158", 1, false)]
  [@@@css.bindings
    [("Input.layout", "_id_1xb8ads", "_a_5r08qs _a_94zrbw");
    ("Input.button", "_id_1enkfbb", "_a_4ekvmb")]]
  [@@@css.blocks [(1, "_id_1xb8ads", [0; 1]); (2, "_id_1enkfbb", [2])]]
  let layout = CSS.make "label:layout _id_1xb8ads _a_5r08qs _a_94zrbw" []
  let button = CSS.make "label:button _id_1enkfbb _a_4ekvmb" []
  let _ = (layout, button)

--dev --env production keeps the marker:

  $ ../../standalone.exe --dev --env production --impl input.ml -o dev-prod.ml
  $ cat dev-prod.ml
  [@@@css.config [("env", "production")]]
  [@@@css
    ("._a_5r08qs{display:flex;}", "_a_5r08qs", "0,1,0 own", "207", 1, false)]
  [@@@css
    ("._a_94zrbw{padding:12px;}", "_a_94zrbw", "0,1,0 own", "328", 15, false)]
  [@@@css
    ("._a_4ekvmb{color:red;}", "_a_4ekvmb", "0,1,0 own", "158", 1, false)]
  [@@@css.bindings
    [("Input.layout", "_id_1xb8ads", "_a_5r08qs _a_94zrbw");
    ("Input.button", "_id_1enkfbb", "_a_4ekvmb")]]
  [@@@css.blocks [(1, "_id_1xb8ads", [0; 1]); (2, "_id_1enkfbb", [2])]]
  let layout = CSS.make "label:layout _id_1xb8ads _a_5r08qs _a_94zrbw" []
  let button = CSS.make "label:button _id_1enkfbb _a_4ekvmb" []
  let _ = (layout, button)

--env production --dev (the other order) keeps the marker too:

  $ ../../standalone.exe --env production --dev --impl input.ml -o prod-dev.ml
  $ cat prod-dev.ml
  [@@@css.config [("env", "production")]]
  [@@@css
    ("._a_5r08qs{display:flex;}", "_a_5r08qs", "0,1,0 own", "207", 1, false)]
  [@@@css
    ("._a_94zrbw{padding:12px;}", "_a_94zrbw", "0,1,0 own", "328", 15, false)]
  [@@@css
    ("._a_4ekvmb{color:red;}", "_a_4ekvmb", "0,1,0 own", "158", 1, false)]
  [@@@css.bindings
    [("Input.layout", "_id_1xb8ads", "_a_5r08qs _a_94zrbw");
    ("Input.button", "_id_1enkfbb", "_a_4ekvmb")]]
  [@@@css.blocks [(1, "_id_1xb8ads", [0; 1]); (2, "_id_1enkfbb", [2])]]
  let layout = CSS.make "label:layout _id_1xb8ads _a_5r08qs _a_94zrbw" []
  let button = CSS.make "label:button _id_1enkfbb _a_4ekvmb" []
  let _ = (layout, button)

Without --dev, --minify alone still turns the marker off:

  $ ../../standalone.exe --minify --impl input.ml -o minify-only.ml
  $ cat minify-only.ml
  [@@@css.config [("env", "production")]]
  [@@@css
    ("._a_5r08qs{display:flex;}", "_a_5r08qs", "0,1,0 own", "207", 1, false)]
  [@@@css
    ("._a_94zrbw{padding:12px;}", "_a_94zrbw", "0,1,0 own", "328", 15, false)]
  [@@@css
    ("._a_4ekvmb{color:red;}", "_a_4ekvmb", "0,1,0 own", "158", 1, false)]
  [@@@css.bindings
    [("Input.layout", "_id_1xb8ads", "_a_5r08qs _a_94zrbw");
    ("Input.button", "_id_1enkfbb", "_a_4ekvmb")]]
  [@@@css.blocks [(1, "_id_1xb8ads", [0; 1]); (2, "_id_1enkfbb", [2])]]
  let layout = CSS.make "_id_1xb8ads _a_5r08qs _a_94zrbw" []
  let button = CSS.make "_id_1enkfbb _a_4ekvmb" []
  let _ = (layout, button)

Without --dev, --env production alone still turns the marker off:

  $ ../../standalone.exe --env production --impl input.ml -o prod-only.ml
  $ cat prod-only.ml
  [@@@css.config [("env", "production")]]
  [@@@css
    ("._a_5r08qs{display:flex;}", "_a_5r08qs", "0,1,0 own", "207", 1, false)]
  [@@@css
    ("._a_94zrbw{padding:12px;}", "_a_94zrbw", "0,1,0 own", "328", 15, false)]
  [@@@css
    ("._a_4ekvmb{color:red;}", "_a_4ekvmb", "0,1,0 own", "158", 1, false)]
  [@@@css.bindings
    [("Input.layout", "_id_1xb8ads", "_a_5r08qs _a_94zrbw");
    ("Input.button", "_id_1enkfbb", "_a_4ekvmb")]]
  [@@@css.blocks [(1, "_id_1xb8ads", [0; 1]); (2, "_id_1enkfbb", [2])]]
  let layout = CSS.make "_id_1xb8ads _a_5r08qs _a_94zrbw" []
  let button = CSS.make "_id_1enkfbb _a_4ekvmb" []
  let _ = (layout, button)
