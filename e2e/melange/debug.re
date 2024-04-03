let _ = [%cx {|
  justify-content: center;
|}];

print_endline(Ui_native.Ui.getStaticMarkup());

print_endline("");
print_endline("<style>");
print_endline(CssJs.render_style_tag());
print_endline("</style>");
