type extension =
  | Reason
  | OCaml
  | ReScript;

let extension_to_string =
  fun
  | Reason => "Reason"
  | OCaml => "OCaml"
  | ReScript => "ReScript";

let detectFileSuffix = (path): result(extension, string) => {
  switch (Filename.extension(path)) {
  | ".re" => Ok(Reason)
  | ".res" => Ok(ReScript)
  | ".ml" => Ok(OCaml)
  | _ => Ok(Reason)
  };
};

let detectExtension = path => {
  switch (detectFileSuffix(path)) {
  | Ok(extension) => extension
  | Error(e) => failwith(e)
  };
};

let current = ref(None);

let set = path => {
  current := Some(detectExtension(path));
};

let get = () => current^;
