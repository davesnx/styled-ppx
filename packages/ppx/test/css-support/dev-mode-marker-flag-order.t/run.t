An explicit --dev always keeps the `label:<name>` marker on, whatever
position it takes next to --minify or --env production. Without an
explicit --dev, --minify and --env production still turn the marker off,
same as before.

  $ refmt --parse re --print ml input.re > input.ml

--dev --minify keeps the marker:

  $ ../../standalone.exe --dev --minify --impl input.ml -o dev-minify.ml
  $ cat dev-minify.ml
  [@@@css.config [("env", "production")]]
  [@@@css ".css-k008qs{display:flex;}"]
  [@@@css ".css-38zrbw{padding:12px;}"]
  [@@@css ".css-tokvmb{color:red;}"]
  [@@@css.bindings
    [("Input.layout", "cid-1jj5tmt", "css-k008qs css-38zrbw");
    ("Input.button", "cid-l55coe", "css-tokvmb")]]
  let layout = CSS.make "label:layout cid-1jj5tmt css-k008qs css-38zrbw" []
  let button = CSS.make "label:button cid-l55coe css-tokvmb" []
  let _ = (layout, button)

--minify --dev (the other order) keeps the marker too:

  $ ../../standalone.exe --minify --dev --impl input.ml -o minify-dev.ml
  $ cat minify-dev.ml
  [@@@css.config [("env", "production")]]
  [@@@css ".css-k008qs{display:flex;}"]
  [@@@css ".css-38zrbw{padding:12px;}"]
  [@@@css ".css-tokvmb{color:red;}"]
  [@@@css.bindings
    [("Input.layout", "cid-1jj5tmt", "css-k008qs css-38zrbw");
    ("Input.button", "cid-l55coe", "css-tokvmb")]]
  let layout = CSS.make "label:layout cid-1jj5tmt css-k008qs css-38zrbw" []
  let button = CSS.make "label:button cid-l55coe css-tokvmb" []
  let _ = (layout, button)

--dev --env production keeps the marker:

  $ ../../standalone.exe --dev --env production --impl input.ml -o dev-prod.ml
  $ cat dev-prod.ml
  [@@@css.config [("env", "production")]]
  [@@@css ".css-k008qs{display:flex;}"]
  [@@@css ".css-38zrbw{padding:12px;}"]
  [@@@css ".css-tokvmb{color:red;}"]
  [@@@css.bindings
    [("Input.layout", "cid-1jj5tmt", "css-k008qs css-38zrbw");
    ("Input.button", "cid-l55coe", "css-tokvmb")]]
  let layout = CSS.make "label:layout cid-1jj5tmt css-k008qs css-38zrbw" []
  let button = CSS.make "label:button cid-l55coe css-tokvmb" []
  let _ = (layout, button)

--env production --dev (the other order) keeps the marker too:

  $ ../../standalone.exe --env production --dev --impl input.ml -o prod-dev.ml
  $ cat prod-dev.ml
  [@@@css.config [("env", "production")]]
  [@@@css ".css-k008qs{display:flex;}"]
  [@@@css ".css-38zrbw{padding:12px;}"]
  [@@@css ".css-tokvmb{color:red;}"]
  [@@@css.bindings
    [("Input.layout", "cid-1jj5tmt", "css-k008qs css-38zrbw");
    ("Input.button", "cid-l55coe", "css-tokvmb")]]
  let layout = CSS.make "label:layout cid-1jj5tmt css-k008qs css-38zrbw" []
  let button = CSS.make "label:button cid-l55coe css-tokvmb" []
  let _ = (layout, button)

Without --dev, --minify alone still turns the marker off:

  $ ../../standalone.exe --minify --impl input.ml -o minify-only.ml
  $ cat minify-only.ml
  [@@@css.config [("env", "production")]]
  [@@@css ".css-k008qs{display:flex;}"]
  [@@@css ".css-38zrbw{padding:12px;}"]
  [@@@css ".css-tokvmb{color:red;}"]
  [@@@css.bindings
    [("Input.layout", "cid-1jj5tmt", "css-k008qs css-38zrbw");
    ("Input.button", "cid-l55coe", "css-tokvmb")]]
  let layout = CSS.make "cid-1jj5tmt css-k008qs css-38zrbw" []
  let button = CSS.make "cid-l55coe css-tokvmb" []
  let _ = (layout, button)

Without --dev, --env production alone still turns the marker off:

  $ ../../standalone.exe --env production --impl input.ml -o prod-only.ml
  $ cat prod-only.ml
  [@@@css.config [("env", "production")]]
  [@@@css ".css-k008qs{display:flex;}"]
  [@@@css ".css-38zrbw{padding:12px;}"]
  [@@@css ".css-tokvmb{color:red;}"]
  [@@@css.bindings
    [("Input.layout", "cid-1jj5tmt", "css-k008qs css-38zrbw");
    ("Input.button", "cid-l55coe", "css-tokvmb")]]
  let layout = CSS.make "cid-1jj5tmt css-k008qs css-38zrbw" []
  let button = CSS.make "cid-l55coe css-tokvmb" []
  let _ = (layout, button)
