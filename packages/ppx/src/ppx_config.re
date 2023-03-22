/* TODO: Turn this type in a Map of option
     type t = options Map
     type option('a) = { flag: string, value: 'a, defaultValue: 'a }

     let get = (key, options) => {
       options |> Map.find_opt(key) |> Option.map(o => o.value) |> Option.value(~default=o.defaultValue)
     }
     let update = (key, fn, options) => {
       options |> Map.find_opt(key) |> Option.map(o => o.value) |> Option.value(~default=o.defaultValue)
     }

     and package it in a module like: `Settings` and have all utiltiies in here:
      - isCompatbileWithBsEmotionPpx()
      - generateAllMakeProps()
   */
type t = {
  compatibleModeWithBsEmotionPpx: bool,
  production: bool,
};

let compatibleModeWithBsEmotionPpxKey = "--compat-with-bs-emotion-ppx";

let default = {compatibleModeWithBsEmotionPpx: false, production: false};

let currentConfig = ref(Some(default));
let set = config => currentConfig := Some(config);
let setDefault = () => set(default);

let get = () => currentConfig.contents;

let update = fn => {
  get() |> Option.map(fn) |> Option.iter(set);
};

let updateCompatibleModeWithBsEmotionPpx = compatible => {
  update(config => {...config, compatibleModeWithBsEmotionPpx: compatible});
};

let compatibleModeWithBsEmotionPpx = () => {
  get()
  |> Option.map(c => c.compatibleModeWithBsEmotionPpx)
  |> Option.value(~default=default.compatibleModeWithBsEmotionPpx);
};

let find = (key, args) => {
  args |> Array.to_list |> List.find_opt(a => a == key) |> Option.is_some;
};
