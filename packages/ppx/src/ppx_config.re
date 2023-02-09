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

let updateCompatibleModeWithBsEmotionPpx = value => {
  Printf.printf("updateCompatibleModeWithBsEmotionPpx: %b\n", value);
  get()
    |> Option.map(config => set({ ...config, compatibleModeWithBsEmotionPpx: value }))
    |> Option.value(~default=())
};

let compatibleModeWithBsEmotionPpx = () => {
  let value = get()
    |> Option.map(c => c.compatibleModeWithBsEmotionPpx)
    |> Option.value(~default=default.compatibleModeWithBsEmotionPpx)
  Printf.printf("compatibleModeWithBsEmotionPpx: %b\n", value);
  value;
};
