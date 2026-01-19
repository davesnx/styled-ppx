type entry = { name : string; spec : Spec.packed }

let entries : entry list ref = ref []

let register_module ~name (module M : Spec.RULE) =
  entries := { name; spec = Spec.Pack (module M) } :: !entries

let find name =
  List.find_opt (fun e -> e.name = name) !entries |> Option.map (fun e -> e.spec)

let find_all () = !entries

let () =
  register_module ~name:"margin" (module Properties.Margin);
  register_module ~name:"padding" (module Properties.Padding);
  register_module ~name:"position" (module Properties.Position);
  register_module ~name:"line-height" (module Properties.Line_height);
  register_module ~name:"color" (module Properties.Color);
  register_module ~name:"background-color" (module Properties.Background_color)
