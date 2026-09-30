type flag('a) = {
  flag: string,
  doc: string,
  value: option('a),
  defaultValue: 'a,
};

let native = {
  flag: "--native",
  doc: "Generate code for server-reason-react",
  value: None,
  defaultValue: false,
};

let debug = {
  flag: "--debug",
  doc: "Enable debug logging",
  value: None,
  defaultValue: false,
};

let minify = {
  flag: "--minify",
  doc: "Minify generated CSS by removing unnecessary whitespace",
  value: None,
  defaultValue: false,
};

let dev = {
  flag: "--dev",
  doc: "Emit dev-mode marker classes (e.g. label:layout) on [%css] output to make atomized class lists greppable in DOM inspectors. No effect on extracted CSS or atom hashes. On by default; --minify and --env production turn it off, --dev forces it back on.",
  value: None,
  defaultValue: true,
};

let env = {
  flag: "--env",
  doc: " Preset over the individual flags: \"development\" enables --dev marker classes; \"production\" enables --minify (CSS whitespace only) and disables dev markers.",
  value: None,
  defaultValue: "development",
};

let namespace = {
  flag: "--namespace",
  doc: "Mixed into every atom (`_a_`), bundle (`_in_`) and identity (`_id_`) class hash, so the same declaration in two libraries mints two different classes and never collides on a page that links both. Defaults to the dune `library-name` cookie (empty when neither the cookie nor this flag is present, e.g. the standalone driver with no `-cookie`). Pass an explicit value to override the cookie: give a native library and its melange twin the SAME value in both stanzas so they keep minting identical classes, or give two libraries with no dune cookie distinct values so their classes differ.",
  value: None,
  defaultValue: "",
};

type settings = {
  native: flag(bool),
  debug: flag(bool),
  minify: flag(bool),
  dev: flag(bool),
  namespace: flag(string),
  /* Not a CLI flag: set from the dune `library-name` cookie
     (see Ppxlib.Driver.Cookies in ppx.re). */
  library: option(string),
};

let currentSettings =
  ref({
    native,
    debug,
    minify,
    dev,
    namespace,
    library: None,
  });

let updateSettings = newSettings => currentSettings := newSettings;

/* Set only by the literal --dev flag (Update.devFlag), never by --env
   development. Once set, --minify and --env production stop turning dev
   off, whatever their position relative to --dev on the command line. */
let devExplicit = ref(false);

module Get = {
  let native = () =>
    currentSettings.contents.native.value
    |> Option.value(~default=currentSettings.contents.native.defaultValue);
  let debug = () =>
    currentSettings.contents.debug.value
    |> Option.value(~default=currentSettings.contents.debug.defaultValue);
  let minify = () =>
    currentSettings.contents.minify.value
    |> Option.value(~default=currentSettings.contents.minify.defaultValue);
  let dev = () =>
    currentSettings.contents.dev.value
    |> Option.value(~default=currentSettings.contents.dev.defaultValue);
  let library = () => currentSettings.contents.library;
  /* An explicit `--namespace` always wins; absent that, default to the dune
     `library-name` cookie (so each library salts its own classes without a
     flag); absent both, the empty default (e.g. the standalone driver run
     with no `-cookie`, as every css-support cram test does). */
  let namespace = () =>
    switch (currentSettings.contents.namespace.value) {
    | Some(value) => value
    | None =>
      switch (currentSettings.contents.library) {
      | Some(name) => name
      | None => currentSettings.contents.namespace.defaultValue
      }
    };
};

module Update = {
  let native = value =>
    updateSettings({
      ...currentSettings.contents,
      native: {
        ...currentSettings.contents.native,
        value: Some(value),
      },
    });
  let debug = value =>
    updateSettings({
      ...currentSettings.contents,
      debug: {
        ...currentSettings.contents.debug,
        value: Some(value),
      },
    });
  let dev = value =>
    updateSettings({
      ...currentSettings.contents,
      dev: {
        ...currentSettings.contents.dev,
        value: Some(value),
      },
    });
  /* Turning minify on also turns dev off (matches `--env production`),
     unless an explicit --dev was given: that wins regardless of where
     --dev sits relative to --minify / --env production on the command
     line (see devFlag below). */
  let minify = value => {
    updateSettings({
      ...currentSettings.contents,
      minify: {
        ...currentSettings.contents.minify,
        value: Some(value),
      },
    });
    if (value && ! devExplicit^) {
      dev(false);
    };
  };

  /* The literal --dev flag: like `dev(true)`, but also remembers that
     --dev was explicitly requested, so no --minify / --env production on
     either side of it on the command line can turn it back off. --env
     development calls `dev` directly instead of this, so it doesn't get
     this precedence. */
  let devFlag = () => {
    devExplicit := true;
    dev(true);
  };

  let namespace = value =>
    updateSettings({
      ...currentSettings.contents,
      namespace: {
        ...currentSettings.contents.namespace,
        value: Some(value),
      },
    });

  let library = value =>
    updateSettings({
      ...currentSettings.contents,
      library: Some(value),
    });

  let env =
    fun
    | `Development => {
        dev(true);
        minify(false);
      }
    | `Production => minify(true);
};

let find = (key, args) => {
  args |> Array.to_list |> List.find_opt(a => a == key) |> Option.is_some;
};
