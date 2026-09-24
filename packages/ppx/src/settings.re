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
  doc: "Mixed into every binding's identity class hash. Empty by default, so a library's native and melange builds mint the same `cid-` classes. Pass distinct values to two libraries that share a module basename and binding name, so their `cid-` classes differ.",
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
  let namespace = () =>
    currentSettings.contents.namespace.value
    |> Option.value(~default=currentSettings.contents.namespace.defaultValue);
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
  /* Turning minify on also turns dev off (matches `--env production`);
     a later, explicit `--dev` still wins since flags apply in argv order. */
  let minify = value => {
    updateSettings({
      ...currentSettings.contents,
      minify: {
        ...currentSettings.contents.minify,
        value: Some(value),
      },
    });
    if (value) {
      dev(false);
    };
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
