exception ConfigNotFound;

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

let getUnsafe = () => {
  switch (value^) {
    | Some(v) => v
    | None => raise(ConfigNotFound)
  }
};

let update = fn => value := value^ |> Option.map(fn);

let updateCompatibleModeWithBsEmotionPpx = bool => {
  let config = getUnsafe();
  set({ ...config, compatibleModeWithBsEmotionPpx: bool })
};

let compatibleModeWithBsEmotionPpx = () =>
  getUnsafe().compatibleModeWithBsEmotionPpx;

let find = (name, args) => args |> Array.to_list |> List.find_opt(a => a == name);
let getArgsBeforeConfigLoaded = () => {
  Sys.argv |> find("--compat-with-bs-emotion-ppx") |> Option.is_some;
};
