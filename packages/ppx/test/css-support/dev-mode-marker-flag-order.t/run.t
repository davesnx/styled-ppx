An explicit --dev always keeps the `label:<name>` marker on, whatever
position it takes next to --minify or --env production. Without an
explicit --dev, --minify and --env production still turn the marker off,
same as before.

  $ refmt --parse re --print ml input.re > input.ml

--dev --minify keeps the marker:

  $ ../../standalone.exe --dev --minify --impl input.ml -o dev-minify.ml
  $ cat dev-minify.ml
  [@@@css.config [("env", "production")]]
  [@@@css "._a_5r08qs{display:flex;}"]
  [@@@css "._a_94zrbw{padding:12px;}"]
  [@@@css "._a_4ekvmb{color:red;}"]
  [@@@css.bindings
    [("Input.layout", "_id_1jj5tmt", "_a_5r08qs _a_94zrbw");
    ("Input.button", "_id_l55coe", "_a_4ekvmb")]]
  let layout = CSS.make "label:layout _id_1jj5tmt _a_5r08qs _a_94zrbw" []
  let button = CSS.make "label:button _id_l55coe _a_4ekvmb" []
  let _ = (layout, button)

--minify --dev (the other order) keeps the marker too:

  $ ../../standalone.exe --minify --dev --impl input.ml -o minify-dev.ml
  $ cat minify-dev.ml
  [@@@css.config [("env", "production")]]
  [@@@css "._a_5r08qs{display:flex;}"]
  [@@@css "._a_94zrbw{padding:12px;}"]
  [@@@css "._a_4ekvmb{color:red;}"]
  [@@@css.bindings
    [("Input.layout", "_id_1jj5tmt", "_a_5r08qs _a_94zrbw");
    ("Input.button", "_id_l55coe", "_a_4ekvmb")]]
  let layout = CSS.make "label:layout _id_1jj5tmt _a_5r08qs _a_94zrbw" []
  let button = CSS.make "label:button _id_l55coe _a_4ekvmb" []
  let _ = (layout, button)

--dev --env production keeps the marker:

  $ ../../standalone.exe --dev --env production --impl input.ml -o dev-prod.ml
  $ cat dev-prod.ml
  [@@@css.config [("env", "production")]]
  [@@@css "._a_5r08qs{display:flex;}"]
  [@@@css "._a_94zrbw{padding:12px;}"]
  [@@@css "._a_4ekvmb{color:red;}"]
  [@@@css.bindings
    [("Input.layout", "_id_1jj5tmt", "_a_5r08qs _a_94zrbw");
    ("Input.button", "_id_l55coe", "_a_4ekvmb")]]
  let layout = CSS.make "label:layout _id_1jj5tmt _a_5r08qs _a_94zrbw" []
  let button = CSS.make "label:button _id_l55coe _a_4ekvmb" []
  let _ = (layout, button)

--env production --dev (the other order) keeps the marker too:

  $ ../../standalone.exe --env production --dev --impl input.ml -o prod-dev.ml
  $ cat prod-dev.ml
  [@@@css.config [("env", "production")]]
  [@@@css "._a_5r08qs{display:flex;}"]
  [@@@css "._a_94zrbw{padding:12px;}"]
  [@@@css "._a_4ekvmb{color:red;}"]
  [@@@css.bindings
    [("Input.layout", "_id_1jj5tmt", "_a_5r08qs _a_94zrbw");
    ("Input.button", "_id_l55coe", "_a_4ekvmb")]]
  let layout = CSS.make "label:layout _id_1jj5tmt _a_5r08qs _a_94zrbw" []
  let button = CSS.make "label:button _id_l55coe _a_4ekvmb" []
  let _ = (layout, button)

Without --dev, --minify alone still turns the marker off:

  $ ../../standalone.exe --minify --impl input.ml -o minify-only.ml
  $ cat minify-only.ml
  [@@@css.config [("env", "production")]]
  [@@@css "._a_5r08qs{display:flex;}"]
  [@@@css "._a_94zrbw{padding:12px;}"]
  [@@@css "._a_4ekvmb{color:red;}"]
  [@@@css.bindings
    [("Input.layout", "_id_1jj5tmt", "_a_5r08qs _a_94zrbw");
    ("Input.button", "_id_l55coe", "_a_4ekvmb")]]
  let layout = CSS.make "_id_1jj5tmt _a_5r08qs _a_94zrbw" []
  let button = CSS.make "_id_l55coe _a_4ekvmb" []
  let _ = (layout, button)

Without --dev, --env production alone still turns the marker off:

  $ ../../standalone.exe --env production --impl input.ml -o prod-only.ml
  $ cat prod-only.ml
  [@@@css.config [("env", "production")]]
  [@@@css "._a_5r08qs{display:flex;}"]
  [@@@css "._a_94zrbw{padding:12px;}"]
  [@@@css "._a_4ekvmb{color:red;}"]
  [@@@css.bindings
    [("Input.layout", "_id_1jj5tmt", "_a_5r08qs _a_94zrbw");
    ("Input.button", "_id_l55coe", "_a_4ekvmb")]]
  let layout = CSS.make "_id_1jj5tmt _a_5r08qs _a_94zrbw" []
  let button = CSS.make "_id_l55coe _a_4ekvmb" []
  let _ = (layout, button)
