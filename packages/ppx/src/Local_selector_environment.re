/* Per-compilation-unit selector environment for [%cx2] and
   [%styled.global2]. It models the subset of OCaml name lookup available
   before typing: same-file modules, aliases, opens/includes, named [%cx2]
   bindings, and literal string selectors seen earlier in the file. */

let table: Hashtbl.t((string, string), list(string)) = Hashtbl.create(64);
let local_modules: Hashtbl.t((string, string), unit) = Hashtbl.create(64);
let aliases: Hashtbl.t((string, string), list(string)) =
  Hashtbl.create(32);

let join_path = (segments: list(string)): string =>
  String.concat(".", segments);

let prefixes = segments => {
  let rec loop = (current_rev, remaining, acc) =>
    switch (remaining) {
    | [] => List.rev(acc)
    | [segment, ...tail] =>
      let current = List.rev([segment, ...current_rev]);
      loop([segment, ...current_rev], tail, [current, ...acc]);
    };
  loop([], segments, []);
};

let register_module = (~file: string, ~path: list(string)) =>
  switch (path) {
  | [] => ()
  | _ => Hashtbl.replace(local_modules, (file, join_path(path)), ())
  };

let register_alias =
    (
      ~file: string,
      ~scope: list(string),
      ~name: string,
      ~target: list(string),
    ) => {
  register_module(~file, ~path=scope @ [name]);
  Hashtbl.replace(aliases, (file, join_path(scope @ [name])), target);
};

let register =
    (
      ~file: string,
      ~scope: list(string),
      ~name: string,
      ~classNames: list(string),
    ) =>
  if (name != "_") {
    List.iter(path => register_module(~file, ~path), prefixes(scope));
    Hashtbl.replace(table, (file, join_path(scope @ [name])), classNames);
  };

let lookup = (~file: string, ~path: list(string)): option(list(string)) =>
  Hashtbl.find_opt(table, (file, join_path(path)));

let module_exists = (~file: string, ~path: list(string)): bool =>
  Hashtbl.mem(local_modules, (file, join_path(path)));

let alias_target =
    (~file: string, ~path: list(string)): option(list(string)) =>
  Hashtbl.find_opt(aliases, (file, join_path(path)));

let include_module =
    (~file: string, ~scope: list(string), ~module_path: list(string)) => {
  let module_prefix = join_path(module_path);
  let module_prefix_with_dot = module_prefix ++ ".";
  let current_prefix = join_path(scope);
  let copied = ref([]);
  Hashtbl.iter(
    ((entry_file, entry_path), classNames) =>
      if (entry_file == file) {
        let suffix =
          if (entry_path == module_prefix) {
            Some("");
          } else if (String.length(entry_path)
                     > String.length(module_prefix_with_dot)
                     && String.sub(
                          entry_path,
                          0,
                          String.length(module_prefix_with_dot),
                        )
                     == module_prefix_with_dot) {
            Some(
              String.sub(
                entry_path,
                String.length(module_prefix_with_dot),
                String.length(entry_path)
                - String.length(module_prefix_with_dot),
              ),
            );
          } else {
            None;
          };
        switch (suffix) {
        | Some("") => ()
        | Some(suffix) =>
          let included_path =
            current_prefix == "" ? suffix : current_prefix ++ "." ++ suffix;
          copied := [(included_path, classNames), ...copied^];
        | None => ()
        };
      },
    table,
  );
  List.iter(
    ((included_path, classNames)) =>
      Hashtbl.replace(table, (file, included_path), classNames),
    copied^,
  );
};

let enclosing_scopes = (scope: list(string)): list(list(string)) => {
  let rec loop = (current, acc) =>
    switch (current) {
    | [] => List.rev([[], ...acc])
    | _ =>
      let parent = List.rev(List.tl(List.rev(current)));
      loop(parent, [current, ...acc]);
    };
  loop(scope, []);
};

let canonical_local_absolute_module_path = (~file, path) =>
  switch (alias_target(~file, ~path)) {
  | Some(target) when module_exists(~file, ~path=target) => Some(target)
  | Some(_) => None
  | None when module_exists(~file, ~path) => Some(path)
  | None => None
  };

let canonical_local_module_path = (~file, ~scope, path) =>
  enclosing_scopes(scope)
  |> List.find_map(base_scope =>
       canonical_local_absolute_module_path(~file, base_scope @ path)
     );

let module_alias_target = (~file, ~scope, path) =>
  switch (canonical_local_module_path(~file, ~scope, path)) {
  | Some(local_path) => local_path
  | None => path
  };

let resolve_local_module_path = canonical_local_module_path;

let path_segments = (path_str: string): list(string) =>
  String.split_on_char('.', path_str);

let module_path_of_ref = segments =>
  switch (List.rev(segments)) {
  | []
  | [_] => None
  | [_binding, ...module_rev] => Some(List.rev(module_rev))
  };

let expand_alias = (~file, ~path) =>
  switch (alias_target(~file, ~path)) {
  | Some(target) => target
  | None => path
  };

let is_self_module_ref = (~file, ~scope, ~base_scope, segments) =>
  switch (module_path_of_ref(segments)) {
  | None => false
  | Some(module_path) =>
    expand_alias(~file, ~path=base_scope @ module_path) == scope
  };

let candidate_with_alias = (~file, path) =>
  switch (module_path_of_ref(path)) {
  | None => path
  | Some(module_path) =>
    switch (List.rev(path)) {
    | [] => path
    | [binding, ..._] => expand_alias(~file, ~path=module_path) @ [binding]
    }
  };

let local_candidates = (~file, ~scope, ~opens, segments) => {
  let lexical_candidates =
    enclosing_scopes(scope)
    |> List.filter_map(base_scope =>
         is_self_module_ref(~file, ~scope, ~base_scope, segments)
           ? None : Some(candidate_with_alias(~file, base_scope @ segments))
       );
  let open_candidates =
    opens
    |> List.map(open_path =>
         candidate_with_alias(
           ~file,
           expand_alias(~file, ~path=open_path) @ segments,
         )
       );
  lexical_candidates @ open_candidates;
};

let lookup_local_class_ref = (~file, ~scope, ~opens, path_str) => {
  let segments = path_segments(path_str);
  local_candidates(~file, ~scope, ~opens, segments)
  |> List.find_map(path => lookup(~file, ~path));
};

let ref_matches_local_module = (~file, ~scope, ~opens, path_str) => {
  let segments = path_segments(path_str);
  switch (module_path_of_ref(segments)) {
  | None => false
  | Some(module_path) =>
    let lexical_paths =
      enclosing_scopes(scope)
      |> List.map(base_scope =>
           expand_alias(~file, ~path=base_scope @ module_path)
         );
    let open_paths =
      opens
      |> List.map(open_path =>
           expand_alias(
             ~file,
             ~path=expand_alias(~file, ~path=open_path) @ module_path,
           )
         );
    lexical_paths
    @ open_paths
    |> List.exists(path => path != scope && module_exists(~file, ~path));
  };
};

let resolve_selector_class_ref =
    (
      ~file: string,
      ~scope: list(string),
      ~opens: list(list(string)),
      ~loc,
      path_str: string,
    ) => {
  switch (lookup_local_class_ref(~file, ~scope, ~opens, path_str)) {
  | Some(classNames) => classNames
  | None
      when
        String.contains(path_str, '.')
        && !ref_matches_local_module(~file, ~scope, ~opens, path_str) =>
    let segments = path_segments(path_str);
    let longident =
      switch (module_path_of_ref(segments), List.rev(segments)) {
      | (Some(module_path), [binding, ..._]) =>
        String.concat(
          ".",
          expand_alias(~file, ~path=module_path) @ [binding],
        )
      | _ => path_str
      };
    Cross_module_refs.record(~file, ~longident, ~loc);
    [Cross_module_refs.sentinel(longident)];
  | None =>
    Ppxlib.Location.raise_errorf(
      ~loc,
      "Selector interpolation `$(%s)` does not refer to a [%%cx2] binding or string literal earlier in this module.\n- If `%s` is bound to a [%%cx2] or string literal later in the file, reorder the bindings.\n- If `%s` is a computed string, inline the class name literally.\n- Otherwise, use [%%cx] for runtime substitution.",
      path_str,
      path_str,
      path_str,
    )
  };
};

let clear = () => {
  Hashtbl.clear(table);
  Hashtbl.clear(local_modules);
  Hashtbl.clear(aliases);
};
