open Yojson.Safe.Util

let rec element bindings el =
  let lookup name =
    match List.assoc_opt name bindings with
    | Some styles -> styles
    | None -> failwith ("unknown binding " ^ name)
  in
  let carrier =
    match el |> member "merge" |> to_list |> List.map to_string with
    | [] -> None
    | first :: rest ->
      Some
        (List.fold_left
           (fun acc name -> CSS.merge acc (lookup name))
           (lookup first) rest)
  in
  let children =
    match member "children" el with `Null -> [] | list -> to_list list
  in
  ReactDOM.createDOMElementVariadic
    (el |> member "tag" |> to_string_option |> Option.value ~default:"div")
    ~props:
      (ReactDOM.domProps
         ~id:(el |> member "id" |> to_string)
         ?dir:(el |> member "dir" |> to_string_option)
         ?className:(Option.map CSS.className carrier)
         ?style:(Option.map CSS.styles carrier)
         ())
    (Array.of_list (List.map (element bindings) children))

let respond request =
  let key = request |> member "case" |> to_string in
  match List.assoc_opt key Registry.cases with
  | None -> `Assoc [ "error", `String ("case not linked: " ^ key) ]
  | Some bindings ->
    let bindings = Array.to_list bindings in
    let tree = request |> member "tree" |> to_list in
    let html =
      ReactDOM.renderToStaticMarkup
        (React.list (List.map (element bindings) tree))
    in
    `Assoc [ "html", `String html ]

let () =
  try
    while true do
      let line = input_line stdin in
      let response =
        try respond (Yojson.Safe.from_string line)
        with e -> `Assoc [ "error", `String (Printexc.to_string e) ]
      in
      print_endline (Yojson.Safe.to_string response)
    done
  with End_of_file -> ()
