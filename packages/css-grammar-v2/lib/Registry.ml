type entry = { name : string; spec : Spec.packed }

let entries : entry list ref = ref []

let register ~name spec =
  entries := { name; spec = Spec.pack spec } :: !entries

let find name =
  List.find_opt (fun e -> e.name = name) !entries |> Option.map (fun e -> e.spec)

let find_all () = !entries

let () =
  register ~name:"margin" Properties.margin;
  register ~name:"padding" Properties.padding;
  register ~name:"position" Properties.position;
  register ~name:"line-height" Properties.line_height;
  register ~name:"color" Properties.color;
  register ~name:"background-color" Properties.background_color
