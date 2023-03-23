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

/* let getJSXVersion = () => {
     switch (getBsConfigFile()) {
     | Some(bsConfigFile) =>
       try(bsConfigFile |> Json.Read.from_file |> parseConfig) {
       | Config_error(_) as e => raise(e)
       | _ => ()
       }
     | None => ()
     };
   };
    */
