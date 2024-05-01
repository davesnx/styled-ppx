let _ = [%cx {|
  justify-content: center;
|}];

print_endline("Rendered app:");
print_endline(Ui_native.Ui.getStaticMarkup());

print_endline("\nStyle tag:");
print_endline(ReactDOM.renderToStaticMarkup(<CssJs.style_tag />));
