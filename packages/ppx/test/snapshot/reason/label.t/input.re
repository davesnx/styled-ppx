let%label css_apply = css([CssJs.block(`blue)]);
let%label css_apply_with_empty = css([]);
let%label css_apply_multiple = css([prop("1"), prop("2")]);
let%label should_complain = [prop("1"), prop("2")];
let%label should_complain_custom_error = cxx([prop("1"), prop("2")]);
let should_not_touch_this = css([prop("1"), prop("2")]);
