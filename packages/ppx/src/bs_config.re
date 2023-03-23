let bsconfig = "bsconfig.json";
let bsbProjectRoot = ref("");
let projectRoot = ref("");

let rec findProjectRoot = dir =>
  if (Sys.file_exists(Filename.concat(dir, bsconfig))) {
    dir;
  } else {
    let parent = dir |> Filename.dirname;
    if (parent == dir) {
      dir;
    } else {
      findProjectRoot(parent);
    };
  };

let setProjectRoot = () => {
  projectRoot := findProjectRoot(Sys.getcwd());
  bsbProjectRoot :=
    (
      switch (Sys.getenv_opt("BSB_PROJECT_ROOT")) {
      | None => projectRoot^
      | Some(s) => s
      }
    );
};

let getBsConfigFile = () => {
  let bsconfig = Filename.concat(projectRoot^, bsconfig);
  bsconfig |> Sys.file_exists ? Some(bsconfig) : None;
};

/* switch(Paths.getBsConfigFile()) with
   | Some bsConfigFile => (
     try bsConfigFile |> Json.Read.from_file |> parseConfig with
     | Config_error _ as e => raise e
     | _ => ())
   | None => () */

/* let read_config () =
   Ppx_config.set_config defaultConfig;
   Paths.setProjectRoot ();
   let open Json.Util in
   let parseConfig (json : Json.t) =
     let ppxConfig = json |> member "graphql" in
     let handleVerboseLogging verbose_logging =
       Ppx_config.update_config  */

module Json = Yojson.Safe;

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
        | Ok(mode) when mode == "automatic" => (Some(4), Some(mode))
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
