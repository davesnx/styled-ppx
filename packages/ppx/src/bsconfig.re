let bsconfig = "bsconfig.json";
let projectRoot = ref(None);

[@deriving of_yojson({ strict: false })]
type jsx = {
  version: int,
  mode: option(string),
};

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

let from_file = filename =>
  try(Ok(Yojson.Safe.from_file(filename))) {
  | exn => Error(Printexc.to_string(exn))
  };

exception Parse_config_error(string);
/* This is unlikely to happen since ReScript
   ensures each run their config is correct */
exception Malformed_jsx(string);

let parse = json => {
  module Result = Ppx_deriving_yojson_runtime.Result;

  let yojson = json |> Yojson.Safe.from_file;
  switch (yojson |> Yojson.Safe.Util.member("jsx") |> jsx_of_yojson) {
  | Result.Ok(jsx) =>
    switch (jsx) {
    | { version, mode: _ } when version === 3 => (Some(version), None)
    | { version, mode: Some("classic") as mode } when version === 4 => (
        Some(version),
        mode,
      )
    | { version, mode: Some("automatic") as mode } when version === 4 => (
        Some(version),
        mode,
      )
    | _ => raise(Malformed_jsx("Malformed jsx field"))
    }
  | Result.Error(e) =>
    raise(
      Parse_config_error(
        Printf.sprintf("There was an error parsing the config file: %s", e),
      ),
    )
  };
};

let getJSX = () => {
  switch (getBsConfigFile()) {
  | Some(bsConfigFile) =>
    try(parse(bsConfigFile)) {
    | Parse_config_error(_e) => (None, None)
    | Malformed_jsx(_e) => (None, None)
    }
  | None => (None, None)
  };
};
