type entry = { name : string; spec : Spec.packed }

let entries : entry list ref = ref []

let register_module ~name (module M : Spec.RULE) =
  entries := { name; spec = Spec.Pack (module M) } :: !entries

let find name =
  List.find_opt (fun e -> e.name = name) !entries |> Option.map (fun e -> e.spec)

let find_all () = !entries

let () =
  (* Box Model *)
  register_module ~name:"margin" (module Properties.Margin);
  register_module ~name:"margin-top" (module Properties.Margin_top);
  register_module ~name:"margin-right" (module Properties.Margin_right);
  register_module ~name:"margin-bottom" (module Properties.Margin_bottom);
  register_module ~name:"margin-left" (module Properties.Margin_left);
  register_module ~name:"padding" (module Properties.Padding);
  register_module ~name:"padding-top" (module Properties.Padding_top);
  register_module ~name:"padding-right" (module Properties.Padding_right);
  register_module ~name:"padding-bottom" (module Properties.Padding_bottom);
  register_module ~name:"padding-left" (module Properties.Padding_left);
  register_module ~name:"width" (module Properties.Width);
  register_module ~name:"height" (module Properties.Height);
  register_module ~name:"min-width" (module Properties.Min_width);
  register_module ~name:"min-height" (module Properties.Min_height);
  register_module ~name:"max-width" (module Properties.Max_width);
  register_module ~name:"max-height" (module Properties.Max_height);
  (* Positioning *)
  register_module ~name:"position" (module Properties.Position);
  register_module ~name:"top" (module Properties.Top);
  register_module ~name:"right" (module Properties.Right);
  register_module ~name:"bottom" (module Properties.Bottom);
  register_module ~name:"left" (module Properties.Left);
  register_module ~name:"z-index" (module Properties.Z_index);
  (* Display *)
  register_module ~name:"display" (module Properties.Display);
  register_module ~name:"visibility" (module Properties.Visibility);
  register_module ~name:"opacity" (module Properties.Opacity);
  register_module ~name:"overflow" (module Properties.Overflow);
  (* Flexbox *)
  register_module ~name:"flex-direction" (module Properties.Flex_direction);
  register_module ~name:"flex-wrap" (module Properties.Flex_wrap);
  register_module ~name:"justify-content" (module Properties.Justify_content);
  register_module ~name:"align-items" (module Properties.Align_items);
  register_module ~name:"align-self" (module Properties.Align_self);
  register_module ~name:"flex-grow" (module Properties.Flex_grow);
  register_module ~name:"flex-shrink" (module Properties.Flex_shrink);
  register_module ~name:"flex-basis" (module Properties.Flex_basis);
  register_module ~name:"order" (module Properties.Order);
  register_module ~name:"gap" (module Properties.Gap);
  (* Typography *)
  register_module ~name:"font-size" (module Properties.Font_size);
  register_module ~name:"font-weight" (module Properties.Font_weight);
  register_module ~name:"font-style" (module Properties.Font_style);
  register_module ~name:"line-height" (module Properties.Line_height);
  register_module ~name:"letter-spacing" (module Properties.Letter_spacing);
  register_module ~name:"text-align" (module Properties.Text_align);
  register_module ~name:"text-decoration" (module Properties.Text_decoration);
  register_module ~name:"text-transform" (module Properties.Text_transform);
  register_module ~name:"white-space" (module Properties.White_space);
  (* Colors *)
  register_module ~name:"color" (module Properties.Color);
  register_module ~name:"background-color" (module Properties.Background_color);
  (* Borders *)
  register_module ~name:"border-width" (module Properties.Border_width);
  register_module ~name:"border-style" (module Properties.Border_style);
  register_module ~name:"border-color" (module Properties.Border_color);
  register_module ~name:"border-radius" (module Properties.Border_radius);
  (* Background *)
  register_module ~name:"background-image" (module Properties.Background_image);
  register_module ~name:"background-size" (module Properties.Background_size);
  register_module ~name:"background-repeat" (module Properties.Background_repeat);
  (* Cursor *)
  register_module ~name:"cursor" (module Properties.Cursor);
  register_module ~name:"pointer-events" (module Properties.Pointer_events);
  register_module ~name:"user-select" (module Properties.User_select);
  (* Box Sizing *)
  register_module ~name:"box-sizing" (module Properties.Box_sizing);
  register_module ~name:"object-fit" (module Properties.Object_fit);
  (* Float and Clear *)
  register_module ~name:"float" (module Properties.Float);
  register_module ~name:"clear" (module Properties.Clear);
  (* Table *)
  register_module ~name:"table-layout" (module Properties.Table_layout);
  register_module ~name:"border-collapse" (module Properties.Border_collapse);
  (* Transitions *)
  register_module ~name:"transition-duration" (module Properties.Transition_duration);
  register_module ~name:"transition-delay" (module Properties.Transition_delay);
  (* Others *)
  register_module ~name:"content" (module Properties.Content);
  register_module ~name:"resize" (module Properties.Resize)
