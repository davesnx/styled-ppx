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
  doc: "Emit dev-mode marker classes (e.g. cx-layout) on [%css] output to make atomized class lists greppable in DOM inspectors. No effect on extracted CSS or atom hashes.",
  value: None,
  defaultValue: false,
};

let env = {
  flag: "--env",
  doc: " Preset over the individual flags: \"development\" enables --dev marker classes and keeps the readable -<label> suffix on class names; \"production\" enables --minify (drops label suffixes and minifies CSS) and disables dev markers.",
  value: None,
  defaultValue: "development",
};

type settings = {
  native: flag(bool),
  debug: flag(bool),
  minify: flag(bool),
  dev: flag(bool),
};

let currentSettings =
  ref({
    native,
    debug,
    minify,
    dev,
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
  let minify = value =>
    updateSettings({
      ...currentSettings.contents,
      minify: {
        ...currentSettings.contents.minify,
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

  let env =
    fun
    | `Development => {
        dev(true);
        minify(false);
      }
    | `Production => {
        dev(false);
        minify(true);
      };
};

let find = (key, args) => {
  args |> Array.to_list |> List.find_opt(a => a == key) |> Option.is_some;
};
