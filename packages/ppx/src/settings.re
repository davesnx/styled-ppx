type flag('a) = {
  flag: string,
  doc: string,
  value: option('a),
  defaultValue: 'a,
};

let production = {
  flag: "--production",
  doc: "*doesn't do anything*",
  value: None,
  defaultValue: false,
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

type settings = {
  jsxVersion: flag(int),
  jsxMode: flag(string),
  production: flag(bool),
  native: flag(bool),
};

let settings = {
  jsxVersion,
  jsxMode,
  production,
  native,
};

let currentSettings = ref(settings);
let updateSettings = newSettings => currentSettings := newSettings;

module Get = {
  let jsxVersion = () =>
    currentSettings.contents.jsxVersion.value
    |> Option.value(~default=currentSettings.contents.jsxVersion.defaultValue);
  let jsxMode = () =>
    currentSettings.contents.jsxMode.value
    |> Option.value(~default=currentSettings.contents.jsxMode.defaultValue);
  let production = () =>
    currentSettings.contents.production.value
    |> Option.value(~default=currentSettings.contents.production.defaultValue);
  let native = () =>
    currentSettings.contents.native.value
    |> Option.value(~default=currentSettings.contents.native.defaultValue);
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
  let production = value =>
    updateSettings({
      ...currentSettings.contents,
      production: {
        ...currentSettings.contents.production,
        value: Some(value),
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
};

let find = (key, args) => {
  args |> Array.to_list |> List.find_opt(a => a == key) |> Option.is_some;
};
