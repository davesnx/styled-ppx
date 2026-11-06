external entries : ReactDOM.Style.t -> (string * string) array = "entries"
[@@mel.scope "Object"]

let dump_style style =
  String.concat ";"
    (List.map
       (fun (key, value) -> key ^ ":" ^ value)
       (Array.to_list (entries style)))

let () =
  Vectors.run ~make:CSS.make ~merge:CSS.merge ~class_name:CSS.className
    ~dump_style:(fun r -> dump_style (CSS.styles r))
