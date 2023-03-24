module Json = Yojson.Safe;

let bsconfig = "bsconfig.json";
let projectRoot = ref(None);

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

let memeber_safe = (key, json, msg) =>
  try(Ok(Json.Util.member(key, json))) {
  | exn => Error(Printf.sprintf("%s %s", msg, Printexc.to_string(exn)))
  };

let parseJsxConfig = json =>
  memeber_safe(
    "jsx",
    json,
    "Error parsing bsconfig.json. Can't find `jsx` field.",
  );

let readJsxVersion = json =>
  memeber_safe(
    "version",
    json,
    "Error parsing bsconfig.json. Can't find `version` field under `jsx`.",
  )
  |> Result.map(Json.Util.to_int);

let readJsxMode = json =>
  memeber_safe(
    "mode",
    json,
    "Error parsing bsconfig.json. Can't find `mode` field under `jsx`.",
  )
  |> Result.map(Json.Util.to_string);

let _ = setProjectRoot();

let getJSX = () => {
  switch (getBsConfigFile()) {
  | Some(bsConfigFile) =>
    switch (bsConfigFile |> Json.from_file |> parseJsxConfig) {
    | Error(e) => failwith(e)
    | Ok(field) =>
      switch (readJsxVersion(field)) {
      | Ok(version) when version === 4 =>
        switch (readJsxMode(field)) {
        | Error(_e) => (Some(4), None)
        | Ok(mode) when mode == "classic" => (Some(4), Some(mode))
        /* | Ok(mode) when mode == "automatic" => (Some(4), Some(mode)) */
        | Ok(mode) =>
          failwith(
            "Error parsing bsconfig.json. Invalid `mode` field under `jsx`. Expected `classic` or `automatic` but got `"
            ++ mode
            ++ "`.",
          )
        }
      | Ok(version) when version === 3 => (Some(3), None)
      | Error(_e) => (None, None)
      | _ => (None, None)
      }
    }
  | None => (None, None)
  };
};
