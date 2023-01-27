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

let updateCompatibleModeWithBsEmotionPpx = bool => {
  get()
    |> Option.map(config => set({ ...config, compatibleModeWithBsEmotionPpx: bool }))
    |> Option.value(~default=())
};

let compatibleModeWithBsEmotionPpx = () => {
  get()
    |> Option.map(c => c.compatibleModeWithBsEmotionPpx)
    |> Option.value(~default=default.compatibleModeWithBsEmotionPpx)
}
