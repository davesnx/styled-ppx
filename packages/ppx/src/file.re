type extension = Reason | OCaml | ReScript;

let detectFileSuffix = (path): result(extension, string) => {
  switch (Filename.extension(path)) {
    | "res" => Ok(ReScript)
    | "re" => Ok(Reason)
    | "ml" => Ok(OCaml)
    | _ => Ok(Reason)
  }
};

let detectExtension = (path) => {
  switch (detectFileSuffix(path)) {
    | Ok(extension) => extension
    | Error(e) => failwith(e)
  }
};
