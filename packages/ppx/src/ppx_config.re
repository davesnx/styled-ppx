type t = {
  compatibleModeWithBsEmotionPpx: bool,
  production: bool,
};

let default = {
  compatibleModeWithBsEmotionPpx: false,
  production: false
};

let value = ref(None);
let set = config => value := Some(config);
let setDefault = () => set(default);

let get = () => value^

let update = fn => value := value^ |> Option.map(fn);

let updateCompatibleModeWithBsEmotionPpx = compatible => {
  value^
    |> Option.map(config => set({ ...config, compatibleModeWithBsEmotionPpx: compatible }))
    |> Option.value(~default=())
};

let compatibleModeWithBsEmotionPpx = () => {
  value^
    |> Option.map(c => c.compatibleModeWithBsEmotionPpx)
    |> Option.value(~default=default.compatibleModeWithBsEmotionPpx)
};

let find = (key, args) => {
  args
  |> Array.to_list
  |> List.find_opt(a => a == key)
  |> Option.is_some;
};

let compatibleModeWithBsEmotionPpxKey = "--compat-with-bs-emotion-ppx";
