type extension =
  | Reason
  | OCaml;

let detectFileSuffix = (path): result(extension, string) => {
  switch (Filename.extension(path)) {
  | ".re" => Ok(Reason)
  | ".res" => Error("ReScript source files are no longer supported")
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

/* Whether the file set by [set] was parsed by Reason's lexer rather than
   OCaml's: they disagree on where a string literal's location starts (see
   [Parser_location.source_position_start]'s [~loc_includes_delimiters]).
   Unset or unrecognized defaults to Reason, matching [detectFileSuffix]. */
let currentIsReason = () =>
  switch (current^) {
  | Some(OCaml) => false
  | Some(Reason)
  | None => true
  };
