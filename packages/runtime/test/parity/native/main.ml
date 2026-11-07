let dump_style style =
  String.concat ";" (List.map (fun (_, key, value) -> key ^ ":" ^ value) style)

let () =
  Vectors.run ~make:CSS.make ~merge:CSS.merge ~class_name:CSS.className
    ~dump_style:(fun r -> dump_style (CSS.styles r))
