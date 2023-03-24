let bsconfig = "bsconfig.json";
let projectRoot = ref(None);

module Result = {
  include Result;

  let flatMap = (f, r) => {
    Result.map(f, r) |> Result.join;
  };
};

[@deriving yojson({strict: false})]
type jsx = {
  version: int,
  mode: option(string),
};
[@deriving yojson({strict: false})]
type bsconfig = {jsx: option(jsx)};

let findProjectRoot = dir => {
  let rec traverseProject = dir =>
    if (Sys.file_exists(Filename.concat(dir, bsconfig))) {
      dir;
    } else {
      let parent = dir |> Filename.dirname;
      if (parent == dir) {
        dir;
      } else {
        traverseProject(parent);
      };
    };

  traverseProject(dir);
};

let setProjectRoot = () => {
  projectRoot := Some(findProjectRoot(Sys.getcwd()));
};

let getBsConfigFile = () => {
  switch (projectRoot^) {
  | Some(projectRoot) =>
    let bsconfig = Filename.concat(projectRoot, bsconfig);
    bsconfig |> Sys.file_exists ? Some(bsconfig) : None;
  | None => failwith("Project root not set.")
  };
};

let _ = setProjectRoot();

let getJSX = () => {
  switch (getBsConfigFile()) {
  | Some(bsConfigFile) =>
    switch (bsConfigFile |> Yojson.Safe.from_file |> bsconfig_of_yojson) {
    | Error(_e) => (None, None)
    | Ok(bsconfig) =>
      switch (bsconfig.jsx) {
      | Some({version, mode: _}) when version === 3 => (Some(version), None)
      | Some({version, mode: Some("classic") as mode}) when version === 4 => (
          Some(version),
          mode,
        )
      | Some({version, mode: Some("automatic") as mode}) when version === 4 => (
          Some(version),
          mode,
        )
      | _ => (None, None)
      }
    }
  | None => (None, None)
  };
};
