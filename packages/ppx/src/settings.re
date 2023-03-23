type flag('a) = {
  flag: string,
  doc: string,
  value: option('a),
  defaultValue: 'a,
};

let compatibleWithBsEmotionPpx = {
  flag: "--compat-with-bs-emotion-ppx",
  doc: "Changes the extension name from `css` to `css_` to avoid the conflict with bs-emotion-ppx",
  value: None,
  defaultValue: false,
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
  defaultValue: 4,
};

let jsxMode = {
  flag: "--jsx-mode",
  doc: "When --jsx-version is set to 4, this option can be used to specify the JSX mode (classic or automatic)",
  value: None,
  defaultValue: "classic",
};

type settings = {
  jsxMode: flag(string),
  jsxVersion: flag(int),
  compatibleWithBsEmotionPpx: flag(bool),
  production: flag(bool),
};
let settings = {jsxMode, jsxVersion, compatibleWithBsEmotionPpx, production};

let currentSettings = ref(settings);

module Get = {
  let jsxMode = () =>
    currentSettings.contents.jsxMode.value
    |> Option.value(~default=currentSettings.contents.jsxMode.defaultValue);

  let jsxVersion = () =>
    currentSettings.contents.jsxVersion.value
    |> Option.value(~default=currentSettings.contents.jsxVersion.defaultValue);

  let compatibleWithBsEmotionPpx = () =>
    currentSettings.contents.compatibleWithBsEmotionPpx.value
    |> Option.value(
         ~default=
           currentSettings.contents.compatibleWithBsEmotionPpx.defaultValue,
       );
  let production = () =>
    currentSettings.contents.production.value
    |> Option.value(~default=currentSettings.contents.production.defaultValue);
};

module Update = {
  let set = newSettings => currentSettings := newSettings;
  let jsxMode = value =>
    set({
      ...currentSettings.contents,
      jsxMode: {
        ...currentSettings.contents.jsxMode,
        value: Some(value),
      },
    });
  let jsxVersion = value =>
    set({
      ...currentSettings.contents,
      jsxVersion: {
        ...currentSettings.contents.jsxVersion,
        value: Some(value),
      },
    });
  let compatibleWithBsEmotionPpx = value =>
    set({
      ...currentSettings.contents,
      compatibleWithBsEmotionPpx: {
        ...currentSettings.contents.compatibleWithBsEmotionPpx,
        value: Some(value),
      },
    });
  let production = value =>
    set({
      ...currentSettings.contents,
      production: {
        ...currentSettings.contents.production,
        value: Some(value),
      },
    });
};
