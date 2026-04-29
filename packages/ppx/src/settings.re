type flag('a) = {
  flag: string,
  doc: string,
  value: option('a),
  defaultValue: 'a,
};

let jsxVersion = {
  flag: "--jsx-version",
  doc: "Configure the version of JSX to use (3 or 4)",
  value: None,
  defaultValue: 3,
};

let jsxMode = {
  flag: "--jsx-mode",
  doc: "When --jsx-version is set to 4, this option can be used to specify the JSX mode (classic or automatic)",
  value: None,
  defaultValue: "classic",
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
  doc: "Emit dev-mode marker classes (e.g. cx-layout) on [%cx2] output to make atomized class lists greppable in DOM inspectors. No effect on extracted CSS or atom hashes.",
  value: None,
  defaultValue: false,
};

type settings = {
  jsxVersion: flag(int),
  jsxMode: flag(string),
  native: flag(bool),
  debug: flag(bool),
  minify: flag(bool),
  dev: flag(bool),
};

let currentSettings =
  ref({
    jsxVersion,
    jsxMode,
    native,
    debug,
    minify,
    dev,
  });

let updateSettings = newSettings => currentSettings := newSettings;

module Get = {
  let jsxVersion = () =>
    currentSettings.contents.jsxVersion.value
    |> Option.value(~default=currentSettings.contents.jsxVersion.defaultValue);
  let jsxMode = () =>
    currentSettings.contents.jsxMode.value
    |> Option.value(~default=currentSettings.contents.jsxMode.defaultValue);
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
  let jsxVersion = value =>
    updateSettings({
      ...currentSettings.contents,
      jsxVersion: {
        ...currentSettings.contents.jsxVersion,
        value: Some(value),
      },
    });
  let jsxMode = value =>
    updateSettings({
      ...currentSettings.contents,
      jsxMode: {
        ...currentSettings.contents.jsxMode,
        value,
      },
    });
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
};

let find = (key, args) => {
  args |> Array.to_list |> List.find_opt(a => a == key) |> Option.is_some;
};
